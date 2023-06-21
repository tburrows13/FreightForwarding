if not mods["bismuth"] then return end

local resource_autoplace = require "resource-autoplace.resource-autoplace"

local START_RADIUS =  175
local INNER_RADIUS =  775
local OUTER_RADIUS = 1200
local EMPTY_RADIUS = 1800

if data.raw.resource["bismuth-ore"] then
  data.raw.resource["bismuth-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "bismuth-ore",
    order = "b-z",
    base_density = 4,
    base_spots_per_km2 = 1,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1,
    starting_rq_factor_multiplier = 1,
    starting_resource_placement_ring_radius = INNER_RADIUS,
    starting_resource_placement_radius = OUTER_RADIUS,
    regular_patch_fade_in_distance_start = OUTER_RADIUS,
    regular_patch_fade_in_distance = OUTER_RADIUS,
    ideal_aux = 0.7,
    aux_range = 0.1,
  }
end

-- Stack size tweaks
local function set_stack_size(item, stack_size)
  local item = data.raw.item[item] or data.raw.tool[item]
  if not item then return end
  item.stack_size = stack_size
end

set_stack_size("bismuth-ore", 30)
