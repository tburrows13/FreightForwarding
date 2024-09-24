if not (mods["IfNickel"] or mods["BrassTacks"]) then return end

local resource_autoplace = require "resource-autoplace.resource-autoplace"

local START_RADIUS =  175 -- 175
local INNER_RADIUS =  775 -- 775
local OUTER_RADIUS = 1200 --1200
local EMPTY_RADIUS = 1800 --1800

-- Startet Island Ring: Nickel, Zinc

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

-- Outer Islands: Gold, Sulfur

if mods["ThemTharHills"] and data.raw.resource["gold-ore"] then
  data.raw.resource["gold-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "gold-ore",
    order = "a-b-e",
    base_density = 4,
    regular_rq_factor_multiplier = 1.1,
    starting_rq_factor_multiplier = 1.1,
    has_starting_area_placement = true,
    starting_resource_placement_ring_radius = INNER_RADIUS,
    starting_resource_placement_radius = OUTER_RADIUS,
    regular_patch_fade_in_distance_start = OUTER_RADIUS,
    regular_patch_fade_in_distance = OUTER_RADIUS,
    ideal_aux = 0.3,
    aux_range = 0.1,
  }
end

if mods["BrimStuff"] and data.raw.resource["sulfur-ore"] then
  data.raw.resource["sulfur-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "sulfur-ore",
    order = "a-b-e",
    base_density = 4,
    regular_rq_factor_multiplier = 1.4,
    starting_rq_factor_multiplier = 0.9,
    richness_post_multiplier = 0.75,
    has_starting_area_placement = true,
    starting_resource_placement_ring_radius = INNER_RADIUS,
    starting_resource_placement_radius = OUTER_RADIUS,
    regular_patch_fade_in_distance_start = OUTER_RADIUS,
    regular_patch_fade_in_distance = OUTER_RADIUS,
    ideal_aux = 0.9,
    aux_range = 0.1,
  }
end

-- Stack size tweaks
local restack = x_util.set_stack_sizerestack("brass-precursor", 30)
restack("nickel-ore", 30)
restack("invar-precursor", 30)
restack("motor", 50)
restack("gold-ore", 30)
restack("sulfur", 30)
restack("gold-powder", 50)
restack("drive-belt", 50)
restack("transceiver", 50)
restack("empty-amplifier-tube", 50)
restack("advanced-cable", 200)
