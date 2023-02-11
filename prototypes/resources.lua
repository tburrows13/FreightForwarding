-- import custom Resource Autoplace
local resource_autoplace = require("resource-autoplace/resource-autoplace")

-- Redefine base resources here so that they pick up modified defaults from config.lua (starting_resource_placement_radius)
data.raw.resource["iron-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
  name = "iron-ore",
  order = "b",
  base_density = 10,
  has_starting_area_placement = true,
  regular_rq_factor_multiplier = 1.10,
  starting_rq_factor_multiplier = 1.5,
  candidate_spot_count = 22, -- To match 0.17.50 placement
}
data.raw.resource["copper-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
  name = "copper-ore",
  order = "b",
  base_density = 8,
  has_starting_area_placement = true,
  regular_rq_factor_multiplier = 1.10,
  starting_rq_factor_multiplier = 1.2,
  candidate_spot_count = 22, -- To match 0.17.50 placement
}
data.raw.resource["coal"].autoplace = resource_autoplace.resource_autoplace_settings{
  name = "coal",
  order = "b",
  base_density = 8,
  has_starting_area_placement = true,
  regular_rq_factor_multiplier = 1.0,
  starting_rq_factor_multiplier = 1.1
}
data.raw.resource["stone"].autoplace = resource_autoplace.resource_autoplace_settings{
  name = "stone",
  order = "b",
  base_density = 4,
  has_starting_area_placement = true,
  regular_rq_factor_multiplier = 1.0,
  starting_rq_factor_multiplier = 1.1
}

local empty_radius = 700

data.raw.resource["uranium-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
  name = "uranium-ore",
  order = "c",
  base_density = 0.9,
  base_spots_per_km2 = 1.25,
  has_starting_area_placement = false,
  random_spot_size_minimum = 2,
  random_spot_size_maximum = 4,
  regular_rq_factor_multiplier = 1,
  regular_patch_fade_in_distance_start = empty_radius,
  regular_patch_fade_in_distance = empty_radius + 100,
}


if mods["bzlead"] then
  -- override BZ's autoplace, but keeping same values for richness
  data.raw.resource["lead-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "lead-ore",
    order = "b-z",
    base_density = 6,
    base_spots_per_km2 = 1,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.7,
    starting_resource_placement_ring_radius = 370,  -- Spawns the starting patch somewhere at distance 280 from the center
    starting_resource_placement_radius = 500,  -- Keep it reasonably above starting_resource_placement_ring_radius?
    regular_patch_fade_in_distance_start = 500,
    regular_patch_fade_in_distance = 600,
  }
end

if mods["bztitanium"] then
  -- override BZ's autoplace, but keeping same values for richness
  data.raw.resource["titanium-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "titanium-ore",
    order = "b-z",
    base_density = 3,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 0.95,
    regular_patch_fade_in_distance_start = empty_radius,
    regular_patch_fade_in_distance = empty_radius + 100,
  }
end


-- Lava pools

data:extend{
  {
    type = "autoplace-control",
    name = "ff-lava-pool",
    localised_name = {"", "[entity=ff-lava-pool] ", {"entity-name.ff-lava-pool"}},
    richness = false,
    order = "z-a",
    category = "resource"
  },
}

data.raw["assembling-machine"]["ff-lava-pool"].autoplace = resource_autoplace.resource_autoplace_settings
{
  name = "ff-lava-pool",
  order = "a", -- Other resources are "b"; lava will override if something else is already there.
  base_density = 8.2,
  base_spots_per_km2 = 2,
  random_probability = 1/128,
  random_spot_size_minimum = 0.75,
  random_spot_size_maximum = 1.25,
  size_multiplier_coefficient = 3,
  has_starting_area_placement = false,
  regular_rq_factor_multiplier = 1,
  starting_resource_placement_radius = 1000,
  regular_patch_fade_in_distance_start = 1000,
  regular_patch_fade_in_distance = 1000,
  avoid_coast = true,
}
