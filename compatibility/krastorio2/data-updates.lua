if not mods["Krastorio2"] then return end

local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require("__bzlead__/data-util")

-- Disable matter recipes that give iron-ore, copper-ore & cobalt-ore (getting them from nodules)
data.raw.recipe["matter-to-iron-ore"].hidden = true
data.raw.recipe["matter-to-copper-ore"].hidden = true
data.raw.recipe["matter-to-ff-cobalt-ore"].hidden = true

-- Remove unlock effects from kr-matter techs
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

-- Remove Transport Science pack from Singularity lab
for i, input in pairs(data.raw.lab["kr-singularity-lab"].inputs) do
  if input == "ff-transport-science-pack" then
    table.remove(data.raw.lab["kr-singularity-lab"].inputs, i)
  end
end

-- Custom stcks size (will be halved in final-fixes)
data.raw.item["wood"].stack_size = 50
data.raw.item["sand"].stack_size = 50
data.raw.item["raw-imersite"].stack_size = 30
data.raw.item["raw-rare-metals"].stack_size = 30
data.raw.item["coke"].stack_size = 50
data.raw.item["glass"].stack_size = 100
data.raw.item["fertilizer"].stack_size = 100
data.raw.item["biomass"].stack_size = 100
data.raw.item["quartz"].stack_size = 100
data.raw.item["silicon"].stack_size = 100
data.raw.item["rare-metals"].stack_size = 100
data.raw.item["imersium-plate"].stack_size = 100
data.raw.item["enriched-iron"].stack_size = 100
data.raw.item["enriched-copper"].stack_size = 100
data.raw.item["enriched-rare-metals"].stack_size = 100
data.raw.item["lithium-chloride"].stack_size = 100
data.raw.item["lithium"].stack_size = 100
data.raw.item["sulfur"].stack_size = 100
data.raw.item["lithium-sulfur-battery"].stack_size = 100
data.raw.item["explosives"].stack_size = 100
data.raw.item["imersite-powder"].stack_size = 100
data.raw.item["tritium"].stack_size = 100
data.raw.item["fuel"].stack_size = 50
data.raw.item["bio-fuel"].stack_size = 50
data.raw.item["advanced-fuel"].stack_size = 50
data.raw.item["iron-stick"].stack_size = 200
data.raw.item["iron-gear-wheel"].stack_size = 200
data.raw.item["rocket-control-unit"].stack_size = 50
data.raw.item["low-density-structure"].stack_size = 50
data.raw.item["rocket-fuel"].stack_size = 50
data.raw.item["matter-stabilizer"].stack_size = 50
data.raw.item["charged-matter-stabilizer"].stack_size = 50
data.raw.item["processing-unit"].stack_size = 200
data.raw.item["engine-unit"].stack_size = 200
data.raw.item["electric-engine-unit"].stack_size = 200
data.raw.item["flying-robot-frame"].stack_size = 200
data.raw.item["imersite-crystal"].stack_size = 200
data.raw.item["uranium-235"].stack_size = 200
data.raw.item["uranium-238"].stack_size = 200
data.raw.item["energy-control-unit"].stack_size = 200
data.raw.item["space-research-data"].stack_size = 200
data.raw.item["kr-black-reinforced-plate"].stack_size = 100
data.raw.item["kr-white-reinforced-plate"].stack_size = 100
data.raw.item["kr-steel-pipe"].stack_size = 100
data.raw.ammo["explosive-turret-rocket"].stack_size = 50
data.raw.ammo["nuclear-turret-rocket"].stack_size = 50
data.raw.ammo["antimatter-turret-rocket"].stack_size = 50
data.raw.ammo["artillery-shell"].stack_size = 50
data.raw.ammo["nuclear-artillery-shell"].stack_size = 50
data.raw.ammo["antimatter-artillery-shell"].stack_size = 50
data.raw.ammo["atomic-bomb"].stack_size = 50
data.raw.ammo["antimatter-rocket"].stack_size = 50

if mods["PlutoniumEnergy"] then
  data.raw.item["plutonium-238"].stack_size = 200
  data.raw.item["plutonium-239"].stack_size = 200
  data.raw.ammo["plutonium-atomic-bomb"].stack_size = 50
end

-- Add containers
data.raw.ammo["artillery-shell"].ic_create_container = true
data.raw.ammo["atomic-bomb"].ic_create_container = true
data.raw.ammo["antimatter-rocket"].ic_create_container = true

if mods["PlutoniumEnergy"] then 
  data.raw.ammo["plutonium-atomic-bomb"].ic_create_container = true
end

-- Revert fuels' category to adv.chemical
data.raw.item["rocket-fuel"].fuel_category = "advanced-chemical"

-- Add chemical fuel back to boat (but NOT adv. chamical)
data.raw.car["indep-boat"].burner.fuel_category = nil
data.raw.car["indep-boat"].burner.fuel_categories = { "chemical", "vehicle-fuel" }

-- Add K2's vehicle fuel to Mini Trains
data.raw.locomotive["mini-locomotive"].burner.fuel_category = nil
data.raw.locomotive["mini-locomotive"].burner.fuel_categories = { "chemical", "vehicle-fuel" }

-- Apply regular trains' fuel changes + add Vehicle fuel if needed
if not settings.startup["ff-revert-locomotive-fuel-category"].value then
  data.raw.locomotive.locomotive.burner.fuel_category = "battery"
  data.raw.locomotive.locomotive.burner.fuel_categories = nil
else
  data.raw.locomotive.locomotive.burner.fuel_category = nil
  data.raw.locomotive.locomotive.burner.fuel_categories = { "chemical", "vehicle-fuel", "battery" }
end

-- Allow Plutonium Energy fuel cells into K2's Nuclear Locomotive
if mods["PlutoniumEnergy"] then 
  local burner = data.raw.locomotive["kr-nuclear-locomotive"].burner
  burner.fuel_categories = {
    burner.fuel_category,
    data.raw.item["MOX-fuel"].fuel_category,
    data.raw.item["breeder-fuel-cell"].fuel_category
  }
  burner.fuel_category = nil
end

-- Change resources autoplace
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