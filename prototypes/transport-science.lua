local util = require "__X-Logistics__/prototypes/data-util"

data:extend{
  {
    type = "tool",
    name = "x-transport-science-pack",
    localised_description = {"item-description.science-pack"},
    icon = "__base__/graphics/icons/logistic-science-pack.png",
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
    name = "x-transport-science-pack",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {"rail", 1},
      {"big-electric-pole", 1}
    },
    result_count = 3,
    result = "logistic-science-pack"
  },
  {
    type = "technology",
    name = "x-transport-science-pack",
    localised_name = {"technology-name.x-transport-science-pack"},
    localised_description = {"technology-description.x-transport-science-pack"},
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/logistic-science-pack.png",
    prerequisites = {"railway", "electric-energy-distribution-1"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "x-transport-science-pack"
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

util.add_prerequisite("fluid-handling", "x-transport-science-pack")
util.add_prerequisite("water_transport", "x-transport-science-pack")
util.add_prerequisite("automobilism", "x-transport-science-pack")  -- Can't easily drive to lead ore

data.raw.recipe["pipe-to-ground"].enabled = false
table.insert(data.raw.technology["fluid-handling"].effects, 1, {type = "unlock-recipe", recipe = "pipe-to-ground"})

table.insert(data.raw.lab.lab.inputs, 3, "x-transport-science-pack")