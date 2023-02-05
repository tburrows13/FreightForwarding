require "__X-Logistics__/prototypes/inventory-sizes"
require "__X-Logistics__/prototypes/recipe-updates"

-- import custom Resource Autoplace
local resource_autoplace = require("resource-autoplace/resource-autoplace")

local empty_radius = 600

data.raw.resource["uranium-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
  name = "uranium-ore",
  order = "c",
  base_density = 0.9,
  base_spots_per_km2 = 1.25,
  has_starting_area_placement = false,
  random_spot_size_minimum = 2,
  random_spot_size_maximum = 4,
  regular_rq_factor_multiplier = 1,
  starting_resource_placement_radius = empty_radius,
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
    starting_resource_placement_ring_radius = 280,
    starting_resource_placement_radius = 400,
    regular_patch_fade_in_distance = 500,
  }
end

if mods["bztitanium"] then
  -- override BZ's autoplace, but keeping same values for richness
  data.raw.resource["titanium-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "titanium-ore",
    order = "b-z",
    base_density = 3,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 0.8,
    starting_resource_placement_radius = empty_radius,
    regular_patch_fade_in_distance = empty_radius + 100,
  }
end
