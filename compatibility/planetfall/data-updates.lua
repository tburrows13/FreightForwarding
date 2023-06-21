if not (mods["IfNickel"] or mods["BrassTacks"]) then return end

local resource_autoplace = require "resource-autoplace.resource-autoplace"

local START_RADIUS =  175 -- 175
local INNER_RADIUS =  775 -- 775
local OUTER_RADIUS = 1200 --1200
local EMPTY_RADIUS = 1800 --1800

if mods["IfNickel"] and data.raw.resource["nickel-ore"] then
  data.raw.resource["nickel-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "nickel-ore",
    order = "a-b-e",
    base_density = mods["aai-industry"] and 6 or 5,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 0.7,
    starting_rq_factor_multiplier = 1.1,
    starting_resource_placement_radius = START_RADIUS,
    ideal_aux = 0.1,
    aux_range = 0.2,
  }
end

if mods["BrassTacks"] and data.raw.resource["zinc-ore"] then
  data.raw.resource["zinc-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "zinc-ore",
    order = "a-b-e",
    base_density = 4,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.1,
    starting_rq_factor_multiplier = 1.1,
    starting_resource_placement_radius = START_RADIUS,
    ideal_aux = 0.8,
    aux_range = 0.15,
  }
end

-- Stack size tweaks
local function set_stack_size(item, stack_size)
  local item = data.raw.item[item] or data.raw.tool[item]
  if not item then return end
  item.stack_size = stack_size
end

set_stack_size("brass-precursor", 30)
set_stack_size("nickel-ore", 30)
set_stack_size("invar-precursor", 30)
set_stack_size("motor", 50)
