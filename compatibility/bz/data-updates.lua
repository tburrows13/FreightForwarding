if  
  not mods["bzaluminum"]  and
  not mods["bzcarbon"]    and
  not mods["bzchlorine"]  and
  not mods["bzgas"]       and
  not mods["bzgold"]      and
  not mods["bzsilicon"]   and
  not mods["bztin"]       and
  not mods["bztungsten"]  and
  not mods["bzzirconium"]
then return end

if mods["bztin"] and not (mods["bztungsten"] or mods["bzzirconium"]) then
  error("\nUsing BZ Tin without either Tungsten or Zirconium is not allowed for progression reasons")
end

local resource_autoplace = require("resource-autoplace/resource-autoplace")
local bzutil = require("__bzlead__/data-util")
local util = require "__FreightForwarding__/prototypes/data-util"

local START_RADIUS =  175
local INNER_RADIUS =  700
local OUTER_RADIUS = 1000
local EMPTY_RADIUS = 1500

--[[ Aux map
.15 iron, aluminum
.30 uranium, gold
.40 coal, graphite
.50 titanium
.60 stone, tungsten
.70 lead, zircon
.80 copper, tin, rich-coppe
.90 lava pool, salt
]]

-- Starter Island Spawn: Aluminum, Natural Gas, Graphite, Tin, (Coal, Copper, Iron, Stone)
-- + Lead (only if BZ-Tin is enabled)

if mods["bzaluminum"] then
  data.raw.resource["aluminum-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "aluminum-ore",
    order = "b-z",
    base_density = 6,
    base_spots_per_km2 = 1,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.7,
    starting_resource_placement_radius = START_RADIUS,
    ideal_aux = 0.15,
    aux_range = 0.1,
  }
  -- Integrate BZ-Aluminum changes to copper
  data.raw.resource["copper-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "copper-ore",
    order = "b",
    base_density = 6, -- decreased from 8 in vanilla
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.1,
    starting_rq_factor_multiplier = 1, -- from 1.2
    candidate_spot_count = 22,
    ideal_aux = 0.8,
    aux_range = 0.1,
  }
end

if mods["bzcarbon"] and data.raw.resource["graphite"] then
  data.raw.resource["graphite"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "graphite",
    order = "b-z",
    base_density = 6,
    base_spots_per_km2 = 1,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.4,
    starting_resource_placement_radius = START_RADIUS,
    ideal_aux = 0.4,
    aux_range = 0.1,
  }
end

if mods["bzsilicon"] then
  -- Integrate BZ-Silicon changes to stone
  data.raw.resource["stone"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "stone",
    order = "b",
    base_density = 7, -- increased from 4 in vanilla
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.0,
    starting_rq_factor_multiplier = 1.1,
    ideal_aux = 0.6,
  }
end

if mods["bztin"] then
  data.raw.resource["tin-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "tin-ore",
    order = "b-z",
    base_density = 3,
    base_spots_per_km2 = 1,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1,
    starting_rq_factor_multiplier = 1,
    starting_resource_placement_radius = START_RADIUS + 50,
    ideal_aux = 0.8,
    aux_range = 0.1,
  }
  -- Move lead to spawn (required for green chips)
  data.raw.resource["lead-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "lead-ore",
    order = "b-z",
    base_density = 6,
    base_spots_per_km2 = 1,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.7,
    starting_resource_placement_radius = START_RADIUS + 50,
    ideal_aux = 0.8,
    aux_range = 0.1,
  }
end

-- Startet Island Ring: Salt, Wolframite (AKA Tungsten), Zircon

if mods["bzchlorine"] then
  data.raw.resource["salt"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "salt",
    order = "b-z",
    base_density = 3,
    base_spots_per_km2 = 2,
    regular_rq_factor_multiplier = 2.0,
    has_starting_area_placement = true,
    starting_resource_placement_ring_radius = INNER_RADIUS,
    starting_resource_placement_radius = OUTER_RADIUS,
    regular_patch_fade_in_distance_start = OUTER_RADIUS,
    regular_patch_fade_in_distance = OUTER_RADIUS,
    ideal_aux = 0.9,
    aux_range = 0.05,
  }
end

if mods["bztungsten"] then
  data.raw.resource["tungsten-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "tungsten-ore",
    order = "b-z",
    base_density = 4,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1,
    has_starting_area_placement = true,
    starting_resource_placement_ring_radius = INNER_RADIUS,
    starting_resource_placement_radius = OUTER_RADIUS,
    regular_patch_fade_in_distance_start = OUTER_RADIUS,
    regular_patch_fade_in_distance = OUTER_RADIUS,
    ideal_aux = 0.6,
    aux_range = 0.05,
  }
end

if mods["bzzirconium"] then
  data.raw.resource["zircon"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "zircon",
    order = "b-z",
    base_density = 4,
    has_starting_area_placement = true,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.2,
    starting_resource_placement_ring_radius = INNER_RADIUS,  
    starting_resource_placement_radius = OUTER_RADIUS,
    regular_patch_fade_in_distance_start = OUTER_RADIUS,
    regular_patch_fade_in_distance = OUTER_RADIUS,
    ideal_aux = 0.7,
    aux_range = 0.05,
  }
end

-- Outer Islands: Gold, Titanium, Rich-copper-ore?, (Uranium)

if mods["bzgold"] then
  data.raw.resource["gold-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "gold-ore",
    order = "b-z",
    base_density = 1,
    base_spots_per_km2 = 1,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 1,
    starting_rq_factor_multiplier = 1,
    regular_patch_fade_in_distance_start = EMPTY_RADIUS,
    regular_patch_fade_in_distance = EMPTY_RADIUS + 100,
    ideal_aux = 0.3,
    aux_range = 0.1,
  }
end

if mods["bzgold"] and data.raw.resource["rich-copper-ore"] then 
  data.raw.resource["rich-copper-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "rich-copper-ore",
    autoplace_control_name = bzutil.se6() and "rich-copper-ore" or "copper-ore",
    order = "b-z",
    base_density = 4,
    base_spots_per_km2 = 1,
    has_starting_area_placement = false,
    regular_rq_factor_multiplier = 1,
    starting_rq_factor_multiplier = 1,
    regular_patch_fade_in_distance_start = EMPTY_RADIUS,
    regular_patch_fade_in_distance = EMPTY_RADIUS + 100,
    ideal_aux = 0.8,
    aux_range = 0.1,
  }
end

-- Stack size tweaks
local function set_stack_size(item, stack_size)
  local item = data.raw.item[item] or data.raw.tool[item]
  if not item then return end
  item.stack_size = stack_size
end

set_stack_size("aluminum-ore", 30)
set_stack_size("flake-graphite", 30)
set_stack_size("gold-ore", 30)
set_stack_size("rich-copper-ore", 30)
set_stack_size("salt", 30)
set_stack_size("silver-ore", 30)
set_stack_size("tin-ore", 30)
set_stack_size("tungsten-ore", 30)
set_stack_size("zircon", 30)
set_stack_size("cement", 100)
set_stack_size("crucible", 100)
set_stack_size("zirconia", 100)
set_stack_size("acsr-cable", 200)
set_stack_size("aluminum-cable", 200)


bzutil.remove_ingredient("stone-furnace", "zircon")
bzutil.set_ingredient("stone-furnace", "stone", 5)

-- Remove tungsten and zirconium from engines/trains
util.remove_prerequisite("engine", "tungsten-processing")
bzutil.remove_ingredient("engine-unit", "spark-plug")
bzutil.remove_ingredient("engine-unit", "tungsten-plate")

if mods["bztungsten"] then
  -- Adds tungsten requirement to transport science
  bzutil.add_ingredient("ff-transport-science-pack", "small-lamp", 2)
end

-- Add zircon to transport science
bzutil.add_ingredient("big-electric-pole", "zirconium-plate", 2)
bzutil.add_ingredient("po-huge-electric-pole", "zirconium-plate", 10)  -- From Power Overload
bzutil.add_ingredient("substation", "zirconium-plate", 5)

-- Remove lead from natural gas things
if not mods["bztin"] then
  bzutil.remove_ingredient("gas-extractor", "lead-plate")
  bzutil.remove_ingredient("basic-chemical-plant", "lead-plate")
end
