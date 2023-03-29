local util = require "__FreightForwarding__/prototypes/data-util"

data:extend{
  {
    type = "tool",
    name = "ff-transport-science-pack",
    localised_description = {"item-description.science-pack"},
    icon = "__FreightForwarding__/graphics/transport-science-pack-item.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "science-pack",
    order = "b[logistic-science-pack]-a[transport-science-pack]",
    stack_size = 200,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  },
  {
    type = "recipe",
    name = "ff-transport-science-pack",
    enabled = false,
    energy_required = 14,
    ingredients =
    {
      {"rail", 1},
      {"big-electric-pole", 1}
    },
    result_count = 2,
    result = "ff-transport-science-pack"
  },
  {
    type = "technology",
    name = "ff-transport-science-pack",
    localised_name = {"technology-name.ff-transport-science-pack"},
    localised_description = {"technology-description.ff-transport-science-pack"},
    icon_size = 256, icon_mipmaps = 4,
    icon = "__FreightForwarding__/graphics/transport-science-pack-technology.png",
    prerequisites = {"railway", "electric-energy-distribution-1"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ff-transport-science-pack"
      }
    },
    unit =
    {
      count = 75,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 5
    },
    order = "c-a"
  },
}

-- Most tech adjustments are in data-final-fixes.lua

-- Insert FF Science Pack before these techs:
util.add_prerequisite("fluid-handling", "ff-transport-science-pack")
util.add_prerequisite("water_transport", "ff-transport-science-pack")
util.add_prerequisite("automobilism", "ff-transport-science-pack")  -- Can't easily drive to lead ore

-- Simplify tech tree dependencies already covered by FF Science Pack:
util.remove_prerequisite("fluid-handling", "engine")
util.remove_prerequisite("water_transport", "engine")
util.remove_prerequisite("water_transport", "logistics-2")
util.remove_prerequisite("automobilism", "engine")
util.remove_prerequisite("automobilism", "logistics-2")


data.raw.recipe["pipe-to-ground"].enabled = false
table.insert(data.raw.technology["fluid-handling"].effects, 1, {type = "unlock-recipe", recipe = "pipe-to-ground"})

table.insert(data.raw.lab.lab.inputs, 3, "ff-transport-science-pack")
util.allow_productivity("ff-transport-science-pack")

-- Merge deep sea oil with pumpjack tech
local deep_sea_oil = data.raw.technology["deep_sea_oil_extraction"]
local oil_processing = data.raw.technology["oil-processing"]
deep_sea_oil.hidden = true
oil_processing.icon = deep_sea_oil.icon
oil_processing.icon_size = deep_sea_oil.icon_size
oil_processing.icon_mipmaps = deep_sea_oil.icon_mipmaps

table.insert(oil_processing.effects, 2, {type = "unlock-recipe", recipe = "oil_rig"})