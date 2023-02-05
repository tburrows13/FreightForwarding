-- Code taken from IslandStart mod

local noise = require("noise")
local util = require("util")
local tne = noise.to_noise_expression

local function make_basis_noise_function(seed0,seed1,outscale0,inscale0)
  outscale0 = outscale0 or 1
  inscale0 = inscale0 or 1/outscale0
  return function(x,y,inscale,outscale)
    return tne
    {
      type = "function-application",
      function_name = "factorio-basis-noise",
      arguments =
      {
        x = tne(x),
        y = tne(y),
        seed0 = tne(seed0),
        seed1 = tne(seed1),
        input_scale = tne((inscale or 1) * inscale0),
        output_scale = tne((outscale or 1) * outscale0)
      }
    }
  end
end


local function multioctave_noise(params)
  local x = params.x or noise.var("x")
  local y = params.y or noise.var("y")
  local seed0 = params.seed0 or 1
  local seed1 = params.seed1 or 1
  local octave_count = params.octave_count or 1
  local octave0_output_scale = params.octave0_output_scale or 1
  local octave0_input_scale = params.octave0_input_scale or 1
  if params.persistence and params.octave_output_scale_multiplier then
    error("Both persistence and octave_output_scale_multiplier were provided to multioctave_noise, which makes no sense!")
  end
  local octave_output_scale_multiplier = params.octave_output_scale_multiplier or 2
  local octave_input_scale_multiplier = params.octave_input_scale_multiplier or 1/2
  local basis_noise_function = params.basis_noise_function or make_basis_noise_function(seed0, seed1)

  if params.persistence then
    octave_output_scale_multiplier = params.persistence
    -- invert everything so that we can multiply by persistence every time
    -- first octave is the largest instead of the smallest
    octave0_input_scale = octave0_input_scale * math.pow(octave_input_scale_multiplier, octave_count - 1)
    -- 'persistence' implies that the octaves would otherwise have been powers of 2, I think
    octave0_output_scale = octave0_output_scale * math.pow(2, octave_count - 1)
    octave_input_scale_multiplier = 1 / octave_input_scale_multiplier
  end


  return tne{
    type = "function-application",
    function_name = "factorio-quick-multioctave-noise",
    arguments =
    {
      x = tne(x),
      y = tne(y),
      seed0 = tne(seed0),
      seed1 = tne(seed1),
      input_scale = tne(octave0_input_scale),
      output_scale = tne(octave0_output_scale),
      octaves = tne(octave_count),
      octave_output_scale_multiplier = tne(octave_output_scale_multiplier),
      octave_input_scale_multiplier = tne(octave_input_scale_multiplier)
    }
  }
end

-- Multioctave noise that's constructed in a simple way and knows about 'persistence'.
-- It doesn't *have* to be variable,
-- but this construction allows for it.
local function simple_variable_persistence_multioctave_noise(params)
  local x = params.x or noise.var("x")
  local y = params.y or noise.var("y")
  local seed0 = params.seed0 or 1
  local seed1 = params.seed1 or 1
  local octave_count = params.octave_count or 1
  local octave0_output_scale = params.octave0_output_scale or 1
  local octave0_input_scale = params.octave0_input_scale or 1
  local persistence = params.persistence or 1/2

  local terms = {}
  -- Start at the 'large' octave (assuming powers of 2 size increases)
  -- and work inwards, doubling the frequency and mulitplying amplitude by persistence.
  -- 'octave0' is the smallest octave.
  local largest_octave_scale = (2 ^ octave_count)
  local inscale = octave0_input_scale / largest_octave_scale
  local outscale = octave0_output_scale * largest_octave_scale
  for oct=1,octave_count do
    terms[oct] = tne{
      type = "function-application",
      function_name = "factorio-basis-noise",
      arguments = {
        x = tne(x),
        y = tne(y),
        seed0 = tne(seed0),
        seed1 = tne(seed1),
        input_scale = tne(inscale),
        output_scale = tne(1), -- Since outscale is variable, need to multiply separately
      }
    } * outscale
    inscale = inscale * 2 -- double frequency
    outscale = outscale * persistence -- lower amplitude (unless persistence is >1, which would be weird but okay)
  end
  return tne{
    type = "function-application",
    function_name = "add",
    arguments = terms
  }
end


-- Accounts for multiple octaves to return an expression whose amplitude maxes out at about +-1
-- (or +-octave0_input_scale, if that's passed in).
-- Parameters are the same as for simple_variable_persistence_multioctave_noise.
local function simple_amplitude_corrected_multioctave_noise(params)
  local amplitide = params.amplitude or 1
  local persistence = params.persistence or 0.5
  local octave_count = params.octave_count or 1
  -- 0.12's ImprovedNoise would do like:
  -- output = total / ((1 - amplitude) / (1 - persistence)) -- where amplitude is persistence ^ octaves
  -- output = total * (1 - persistence) / (1 - persistence ^ octaves)
  -- So use (1 - persistence) / (1 - persistence ^ octaves) as the output multiplier
  -- but it also uses 1 as the amplitude of the largest octave, whereas
  -- simple_variable_persistence_multioctave_noise uses 2^octave_count.
  -- So divide by that, too:
  local multiplier = (1 - persistence) / (2^octave_count) / (1 - persistence ^ octave_count)

  if params.octave0_output_scale then
    error("Don't pass octave0_output_scale to simple_amplitude_corrected_multioctave_noise; pass amplitude, instead")
  end
  return simple_variable_persistence_multioctave_noise(util.merge{params, {octave0_output_scale = multiplier * amplitide}})
end

local standard_starting_lake_elevation_expression = noise.define_noise_function( function(x,y,tile,map)
  local starting_lake_distance = noise.distance_from(x, y, noise.var("starting_lake_positions"), 1024)
  local minimal_starting_lake_depth = 4
  local minimal_starting_lake_bottom =
    starting_lake_distance / 4 - minimal_starting_lake_depth +
    make_basis_noise_function(map.seed, 123, 1.5, 1/8)(x,y)

  -- Starting cone ensures a more random (but not ~too~ random, because people don't like 'swampy lakes')
  -- valley outside the starting lake:
  local starting_cone_slope = noise.fraction(1, 16)
  local starting_cone_offset = -1
  local starting_cone_noise_multiplier = noise.var("starting-lake-noise-amplitude")/16
  -- Second cone is intended to provide a more gradual slope and more noise
  -- outside of the first cone in order to prevent obvious circles of cliffs.
  -- Its bottom is clamped to a positive value so that it will only affect cliffs,
  -- not water.
  local second_cone_slope = noise.fraction(1, 16)
  local second_cone_offset = 2
  local second_cone_noise_multiplier = noise.var("starting-lake-noise-amplitude")/2

  local starting_lake_noise = multioctave_noise{
    x = x,
    y = y,
    seed0 = map.seed,
    seed1 = 14, -- CorePrototypes::elevationNoiseLayer->getID().getIndex()
    octave0_input_scale = 1/8, -- We don't want the starting lake to scale along with the rest of the map
    octave0_output_scale = 1,
    octave_count = 5,
    persistence = 0.75
  }
  return noise.ident(noise.min(
    minimal_starting_lake_bottom,
    starting_cone_offset + starting_cone_slope * starting_lake_distance + starting_cone_noise_multiplier * starting_lake_noise,
    noise.max(
      second_cone_offset,
      second_cone_offset + second_cone_slope * starting_lake_distance + second_cone_noise_multiplier * starting_lake_noise
    )
  ))
end)

local IS_wlc_mult = 1.75

local function IS_water_level_correct(to_be_corrected, map)
  return noise.ident(noise.max(
    map.wlc_elevation_minimum,
    to_be_corrected + map.wlc_elevation_offset * IS_wlc_mult
  ))
end

local function IS_finish_elevation(elevation, map)
  local elevation = IS_water_level_correct(elevation, map)
  elevation = elevation / map.segmentation_multiplier
  elevation = noise.min(elevation, standard_starting_lake_elevation_expression)
  return elevation
end

local function IS_make_lakes(x, y, tile, map, options)
  options = options or {}
  local terrain_octaves = options.terrain_octaves or 8
  local amplitude_multiplier = 1/8
  local roughness_persistence = 0.7
  local bias = options.bias or 20 -- increase average elevation level by this much
  local starting_plateau_bias = 20 --default 20.
  local starting_plateau_octaves = 6

  local blotchiness = 2

  local roughness = simple_amplitude_corrected_multioctave_noise{
    x = x,
    y = y,
    seed0 = map.seed,
    seed1 = 1,
    octave_count = terrain_octaves - 2,
    amplitude = 1/2,
    octave0_input_scale = 1/2,
    persistence = roughness_persistence
  }
  local persistence = noise.clamp(roughness + 0.3, 0.1, 0.9)
  local roughness_start = simple_amplitude_corrected_multioctave_noise{
    x = (x - 20000) / (blotchiness),
    y = y / (blotchiness),
    seed0 = map.seed,
    seed1 = 1,
    octave_count = terrain_octaves - 2,
    amplitude = 1/2,
    octave0_input_scale = 1/2,
    persistence = roughness_persistence
  }
  local persistence_start = noise.clamp(roughness_start + 0.35, 0.45, 0.7)
  local lakes = simple_variable_persistence_multioctave_noise{
    x = x,
    y = y,
    seed0 = map.seed,
    seed1 = 1,
    octave_count = terrain_octaves,
    octave0_input_scale = 1/2,
    octave0_output_scale = amplitude_multiplier,
    persistence = persistence
  }
  local starting_plateau_basis = simple_variable_persistence_multioctave_noise{
    x = (x - 20000) / (blotchiness),
    y = y / (blotchiness),
    seed0 = map.seed,
    seed1 = 2,
    octave_count = starting_plateau_octaves,
    --octave0_input_scale = 1/2 - map.segmentation_multiplier / 10,
	octave0_input_scale = 1/2,
    octave0_output_scale = 1/12,
    persistence = persistence_start
  }
  -- 10 default. 
  local island_scale = 1.1
  local starting_plateau = starting_plateau_basis + starting_plateau_bias + map.finite_water_level * IS_wlc_mult - tile.distance / (island_scale * 15)

  -- Set elevation to -4.5 in a radius around the center so that any generated continents don't merge with the starting island.
  local empty_radius = 600
  local avoid_starting_island = function(dist)
    return noise.clamp((dist - empty_radius) / (empty_radius + 600), 0, 1)
  end

  return noise.max((lakes + bias + 10) * avoid_starting_island(tile.distance) - 10, starting_plateau)
end

data:extend{
  {
    --similar to vanilla, but with a bigger minimum starting area
    type = "noise-expression",
    name = "x-continents",
    intended_property = "elevation",
    expression = noise.define_noise_function( function(x,y,tile,map)
      x = x * map.segmentation_multiplier + 20000 -- Move the point where 'fractal similarity' is obvious off into the boonies
      y = y * map.segmentation_multiplier
      options =
      {
        bias = -100,
        terrain_octaves = 10
      }
      return IS_finish_elevation(IS_make_lakes(x, y, tile, map, options), map)
    end),
  },
}
