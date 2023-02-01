require "__X-Logistics__/prototypes/inventory-sizes"

-- Revert bztitanium's changes to underwater pipes
if mods["underwater-pipes"] then
  data.raw.technology["underwater-pipes"].prerequisites = { "concrete", "steel-processing" }
  data.raw.recipe["underwater-pipe"].ingredients = {
    { "pipe", 2 },
    { "steel-plate", 5 },
    { "concrete", 20 },
  }
end

-- BZ Lead compatibility - override resource autoplace
if mods["bzlead"] then
  -- import custom Resource Autoplace
  local resource_autoplace = require("resource-autoplace/resource-autoplace")

  -- override BZ's autoplace, but keeping same values for richness
  data.raw.resource["lead-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "lead-ore",
    order = "b-z",
    base_density = 6,
    base_spots_per_km2 = 1,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.7,
    starting_resource_placement_radius = 200,
    regular_patch_fade_in_distance = 200,
  }
end

-- BZ Lead compatibility - override resource autoplace
if mods["bztitanium"] then
  -- import custom Resource Autoplace
  local resource_autoplace = require("resource-autoplace/resource-autoplace")

  -- override BZ's autoplace, but keeping same values for richness
  data.raw.resource["titanium-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "titanium-ore",
    order = "b-z",
    base_density = 3,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 0.8,
    starting_resource_placement_radius = 500,
    regular_patch_fade_in_distance = 500,
  }
end
