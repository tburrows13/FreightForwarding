if not mods["Krastorio2"] then return end

local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require("__bzlead__/data-util")
local TIER_1 = "ic-containerization-1"
local TIER_2 = "ic-containerization-2"
local TIER_3 = "ic-containerization-3"

-- Disable matter recipes that give iron-ore, copper-ore & cobalt-ore (getting them from nodules)
data.raw.recipe["matter-to-iron-ore"].hidden = true
data.raw.recipe["matter-to-copper-ore"].hidden = true
data.raw.recipe["matter-to-ff-cobalt-ore"].hidden = true

--Remove unlock effects from kr-matter techs
bzutil.remove_recipe_effect("kr-matter-iron-processing", "matter-to-iron-ore")
bzutil.remove_recipe_effect("kr-matter-copper-processing", "matter-to-copper-ore")
bzutil.remove_recipe_effect("kr-matter-cobalt-processing", "matter-to-ff-cobalt-ore")

-- Transport Tech Card
data.raw.tool["ff-transport-science-pack"].icon = "__FreightForwarding__/graphics/compatibility/krastorio2/transport-tech-card-item.png"
data.raw.tool["ff-transport-science-pack"].order = "b03[transport-science-pack]"
data.raw.technology["ff-transport-science-pack"].icon = "__FreightForwarding__/graphics/compatibility/krastorio2/transport-tech-card-technology.png"

-- Simplify research tree
bzutil.remove_recipe_effect("kr-basic-fluid-handling", "pipe-to-ground")
util.remove_prerequisite("fluid-handling", "kr-basic-fluid-handling")
util.remove_prerequisite("fluid-handling", "engine")

-- Add logistics (will also add FF Science pack if needed in FF-final-fixes)
util.add_research_ingredient("fluid-handling", "logistic-science-pack")
util.add_research_ingredient("oil-processing", "logistic-science-pack")
util.add_research_ingredient("plastics", "logistic-science-pack")

-- Item containers and stack sizes
local items_data = {
  ["advanced-fuel"] = { stack_size = 25 },
  ["advanced-tech-card"] = { source = "tool" },
  ["ai-core"] = { stack_size = 25 },
  ["automation-core"] = { tech = TIER_2 },
  ["basic-tech-card"] = { source = "tool", tech = TIER_2 },
  ["bio-fuel"] = { stack_size = 25 },
  ["biomass"] = { tech = TIER_1 },
  ["blank-tech-card"] = { tech = TIER_2 },
  ["biters-research-data"] = {},
  ["charged-antimatter-fuel-cell"] = {},
  ["charged-matter-stabilizer"] = {},
  ["coke"] = { stack_size = 25, tech = TIER_1 },
  ["dt-fuel"] = {},
  ["electronic-components"] = { tech = TIER_2 },
  ["empty-antimatter-fuel-cell"] = {},
  ["empty-dt-fuel"] = { tech = "kr-fusion-energy" },
  ["energy-control-unit"] = {},
  ["enriched-copper"] = {},
  ["enriched-iron"] = {},
  ["enriched-lead"] = {},
  ["enriched-rare-metals"] = {},
  ["enriched-titanium"] = {},
  ["fertilizer"] = {},
  ["fuel"] = { stack_size = 25 },
  ["glass"] = {},
  ["imersite-crystal"] = {},
  ["imersite-powder"] = { tech = "kr-quarry-minerals-extraction" },
  ["imersium-beam"] = {},
  ["imersium-gear-wheel"] = {},
  ["imersium-plate"] = {},
  ["improved-pollution-filter"] = {},
  ["inserter-parts"] = { tech = TIER_2 },
  ["iron-beam"] = { tech = TIER_2 },
  ["lithium"] = {},
  ["lithium-chloride"] = {},
  ["lithium-sulfur-battery"] = {},
  ["low-density-structure"] = { stack_size = 25 },
  ["matter-cube"] = {},
  ["matter-research-data"] = {},
  ["matter-stabilizer"] = {},
  ["matter-tech-card"] = { source = "tool" },
  ["pollution-filter"] = {},
  ["quartz"] = {},
  ["rare-metals"] = {},
  ["raw-imersite"] = { stack_size = 15, tech = "kr-quarry-minerals-extraction" },
  ["raw-rare-metals"] = { stack_size = 15, tech = TIER_1 },
  ["rocket-control-unit"] = { stack_size = 25 },
  ["rocket-fuel"] = { stack_size = 25 },
  ["sand"] = {},
  ["silicon"] = {},
  ["singularity-tech-card"] = { source = "tool" },
  ["space-research-data"] = { tech = TIER_3 },
  ["steel-beam"] = { tech = TIER_2 },
  ["steel-gear-wheel"] = { tech = TIER_2 },
  ["tritium"] = { tech = TIER_3 },
  ["used-improved-pollution-filter"] = {},
  ["used-pollution-filter"] = {},
}
--[[
for item_name, item in pairs(items_data) do
  if item.stack_size then 
    data.raw[item.source or "item"][item_name].stack_size = item.stack_size 
  else
    ff_restack(item_name)
  end

  deadlock_crating.add_crate_autotech(item_name, item.tech)
end]]

-- change resources autoplace
local resource_autoplace = require("resource-autoplace/resource-autoplace")
local empty_radius = 1500

data.raw.resource["rare-metals"].autoplace = resource_autoplace.resource_autoplace_settings({
  name = "rare-metals",
  order = "d",
  base_density = 1.0,
  base_spots_per_km2 = 0.75,
  has_starting_area_placement = false,
  random_spot_size_minimum = 0.25,
  random_spot_size_maximum = 3,
  regular_blob_amplitude_multiplier = 1,
  regular_patch_fade_in_distance_start = empty_radius,
  regular_patch_fade_in_distance = empty_radius + 100,
  regular_rq_factor_multiplier = 0.9,
  candidate_spot_count = 22,
})

data.raw.resource["imersite"].autoplace = resource_autoplace.resource_autoplace_settings({
  name = "imersite",
  order = "f",
  base_density = 1,
  richness_multiplier = 1,
  richness_multiplier_distance_bonus = 1.5,
  base_spots_per_km2 = 0.2,
  has_starting_area_placement = false,
  random_spot_size_minimum = 0.01,
  random_spot_size_maximum = 0.1,
  regular_blob_amplitude_multiplier = 1,
  regular_patch_fade_in_distance_start = empty_radius,
  regular_patch_fade_in_distance = empty_radius + 100,
  richness_post_multiplier = 1.0,
  additional_richness = 350000,
  regular_rq_factor_multiplier = 0.1,
  candidate_spot_count = 22,
})

data.raw.resource["mineral-water"].autoplace = resource_autoplace.resource_autoplace_settings({
  name = "mineral-water",
  order = "c",
  base_density = 2,
  base_spots_per_km2 = 0.5,
  random_probability = 1 / 50,
  random_spot_size_minimum = 1,
  random_spot_size_maximum = 1,
  additional_richness = 50000,
  has_starting_area_placement = false,
  regular_rq_factor_multiplier = 1,
  regular_patch_fade_in_distance_start = empty_radius,
  regular_patch_fade_in_distance = empty_radius + 100,
})