if not mods["Krastorio2"] then return end

-- Update kr-steel-pump
data.raw.pump["kr-steel-pump"].energy_source.drain = "1.5kW"

-- Match Steam Turbine max temp with steam
data.raw.generator["steam-turbine"].maximum_temperature = 500

-- Disable matter recipes that give iron-ore, copper-ore & cobalt-ore (getting them from nodules)
data.raw.recipe["matter-to-iron-ore"].hidden = true
data.raw.recipe["matter-to-copper-ore"].hidden = true
data.raw.recipe["matter-to-ff-cobalt-ore"].hidden = true

-- Remove unlock effects from kr-matter techs
x_util.remove_recipe_effect("kr-matter-iron-processing", "matter-to-iron-ore")
x_util.remove_recipe_effect("kr-matter-copper-processing", "matter-to-copper-ore")
x_util.remove_recipe_effect("kr-matter-cobalt-processing", "matter-to-ff-cobalt-ore")

-- -- Transport Tech Card
data.raw.tool["ff-transport-science-pack"].icon = "__FreightForwarding__/graphics/compatibility/krastorio2/transport-tech-card-item.png"
data.raw.tool["ff-transport-science-pack"].order = "b03[transport-science-pack]"
data.raw.tool["ff-transport-science-pack"].localised_name = { "item-name.ff-k2-transport-tech-card" }
data.raw.tool["ff-transport-science-pack"].pictures = {
  layers = {
    {
      size = 64,
      filename = data.raw.tool["ff-transport-science-pack"].icon,
      scale = 0.25,
      mipmap_count = 4,
    },
    {
      draw_as_light = true,
      flags = { "light" },
      size = 64,
      filename = kr_cards_icons_path .. "logistic-tech-card-light.png",
      scale = 0.25,
      mipmap_count = 4,
    },
  },
}
data.raw.technology["ff-transport-science-pack"].icon = "__FreightForwarding__/graphics/compatibility/krastorio2/transport-tech-card-technology.png"
data.raw.technology["ff-transport-science-pack"].localised_name = { "item-name.ff-k2-transport-tech-card" }
x_util.set_product_amount("ff-transport-science-pack", "ff-transport-science-pack", 5)
x_util.set_recipe_time("ff-transport-science-pack", 20)
data.raw.recipe["ff-transport-science-pack"].ingredients = {
  { type = "item", name = "big-electric-pole", amount = 1},
  { type = "item", name = "rail",              amount = 5},
  { type = "item", name = "blank-tech-card",   amount = 5}
}

-- Big-electric-pole recipe
x_util.remove_ingredient("big-electric-pole", "steel-plate")
x_util.set_ingredient("big-electric-pole", "steel-beam", 2)

-- Simplify research tree
x_util.remove_recipe_effect("kr-basic-fluid-handling", "pipe-to-ground")
x_util.remove_prerequisite("fluid-handling", "kr-basic-fluid-handling")
x_util.remove_prerequisite("fluid-handling", "engine")

-- Add logistics (will also add FF Science pack if needed in FF-final-fixes)
x_util.add_research_ingredient("fluid-handling", "logistic-science-pack")
x_util.add_research_ingredient("oil-processing", "logistic-science-pack")
x_util.add_research_ingredient("plastics", "logistic-science-pack")

-- Remove Transport Science pack from Singularity lab
for i, input in pairs(data.raw.lab["kr-singularity-lab"].inputs) do
  if input == "ff-transport-science-pack" then
    table.remove(data.raw.lab["kr-singularity-lab"].inputs, i)
  end
end

-- Custom stcks size (will be halved in final-fixes)
local restack = x_util.set_stack_size
restack("wood", 50)
restack("sand", 50)
restack("raw-imersite", 30)
restack("raw-rare-metals", 30)
restack("coke", 50)
restack("glass", 100)
restack("fertilizer", 100)
restack("biomass", 100)
restack("quartz", 100)
restack("silicon", 100)
restack("rare-metals", 100)
restack("imersium-plate", 100)
restack("enriched-iron", 100)
restack("enriched-copper", 100)
restack("enriched-rare-metals", 100)
restack("lithium-chloride", 100)
restack("lithium", 100)
restack("sulfur", 100)
restack("lithium-sulfur-battery", 100)
restack("explosives", 100)
restack("imersite-powder", 100)
restack("tritium", 100)
restack("fuel", 50)
restack("bio-fuel", 50)
restack("advanced-fuel", 50)
restack("iron-stick", 200)
restack("iron-gear-wheel", 200)
restack("rocket-control-unit", 50)
restack("low-density-structure", 50)
restack("rocket-fuel", 50)
restack("matter-stabilizer", 50)
restack("charged-matter-stabilizer", 50)
restack("processing-unit", 200)
restack("engine-unit", 200)
restack("electric-engine-unit", 200)
restack("flying-robot-frame", 200)
restack("imersite-crystal", 200)
restack("uranium-235", 200)
restack("uranium-238", 200)
restack("energy-control-unit", 200)
restack("space-research-data", 200)
restack("kr-black-reinforced-plate", 100)
restack("kr-white-reinforced-plate", 100)
restack("kr-steel-pipe", 100)
restack("blank-tech-card", 100)
restack("biters-research-data", 100)
restack("matter-research-data", 100)
restack("space-research-data", 100)
restack("basic-tech-card", 100)
restack("matter-tech-card", 100)
restack("advanced-tech-card", 100)
restack("singularity-tech-card", 100)
restack("explosive-turret-rocket", 50)
restack("nuclear-turret-rocket", 50)
restack("antimatter-turret-rocket", 50)
restack("artillery-shell", 50)
restack("nuclear-artillery-shell", 50)
restack("antimatter-artillery-shell", 50)
restack("atomic-bomb", 50)
restack("antimatter-rocket", 50)
-- "PlutoniumEnergy"
restack("plutonium-238", 200)
restack("plutonium-239", 200)
restack("plutonium-atomic-bomb", 50)

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
data.raw.locomotive.locomotive.burner.fuel_category = "battery"
data.raw.locomotive.locomotive.burner.fuel_categories = nil

-- Replace all K2 lithium-sulfur-battery instances with FF's battery-pack
data.raw.recipe["lithium-sulfur-battery"].hidden = true
data.raw.item["lithium-sulfur-battery"].hidden = true
data.raw.item["lithium-sulfur-battery"].ic_create_container = false
x_util.remove_recipe_effect("kr-lithium-sulfur-battery", "lithium-sulfur-battery")
for ___, recipe in pairs(data.raw.recipe) do
  x_util.replace_ingredient(recipe.name, "lithium-sulfur-battery", "ff-battery-pack")
  x_util.replace_product(recipe.name, "lithium-sulfur-battery", "ff-battery-pack")
end

-- Rebalance FF-battery-pack recipe to be more generous & speedy (lithium-batteries are used for science in K2)
-- (3 lithium + 3 cobalt ingot + 9 battery + 1 red chip = 3 battery packs, in the same time)
x_util.add_ingredient("ff-battery-pack", "lithium", 3)
x_util.set_ingredient("ff-battery-pack", "battery", 9)
x_util.set_ingredient("ff-battery-pack", "ff-cobalt-ingot", 3)
x_util.set_product_amount("ff-battery-pack", "ff-battery-pack", 3)
x_util.add_prerequisite("ff-battery-pack", "kr-lithium-processing")
data.raw.item["ff-battery-pack"].localised_name = "Lithium battery pack"
data.raw.item["ff-charged-battery-pack"].localised_name = "Charged lithium battery pack"

-- Lower battery requirements for Advanced Tech Cards
x_util.set_ingredient("advanced-tech-card", "ff-battery-pack", 1)

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
local resource_autoplace = require "resource-autoplace.resource-autoplace"
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
