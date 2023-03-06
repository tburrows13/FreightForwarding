local util = require "__FreightForwarding__/prototypes/data-util"

data:extend{
  {
    type = "item",
    name = "ff-cobalt-ore",
    icon = "__FreightForwarding__/graphics/item/shale-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "a[nodule]",
    stack_size = 5,
  },
  {
    type = "item",
    name = "ff-cobalt-concentrate",
    icon = "__FreightForwarding__/graphics/item/shale-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "a[nodule]",
    stack_size = 50,
  },
  {
    type = "item",
    name = "ff-cobalt-blast-blend",
    icon = "__FreightForwarding__/graphics/item/shale-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "a[nodule]",
    stack_size = 1,
  },
  {
    type = "item",
    name = "ff-cobalt-ingot",
    icon = "__FreightForwarding__/graphics/item/shale-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "a[nodule]",
    stack_size = 200,
  },
  {
    type = "fluid",
    name = "ff-tailings-water",
    icon = "__FreightForwarding__/graphics/item/shale-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    default_temperature = 15,
    base_color = {r=0, g=0.34, b=0.6},
    flow_color = {r=0.7, g=0.7, b=0.7},
    order = "a[nodule]",
  },
  {
    type = "recipe",
    name = "ff-cobalt-concentrate",
    category = "oil-processing",
    enabled = false,
    energy_required = 2,
    main_product = "ff-cobalt-concentrate",
    ingredients = {
      {type = "item", name = "ff-cobalt-ore", amount = 5},
      {type = "fluid", name = "water", amount = 10, catalyst_amount = 10},
    },
    results = {
      {name = "ff-cobalt-concentrate", amount = 5},
      {type = "fluid", name = "ff-tailings-water", amount = 10, catalyst_amount = 10},
    },
  },
  {
    type = "recipe",
    name = "ff-cobalt-blast-blend",
    category = "crafting",
    enabled = false,
    energy_required = 2,
    main_product = "ff-cobalt-blast-blend",
    ingredients = {
      {type = "item", name = "ff-cobalt-concentrate", amount = 5},
      {type = "item", name = "explosives", amount = 1},
    },
    results = {
      {name = "ff-cobalt-blast-blend", amount = 5},
    },
  },
  {
    type = "recipe",
    name = "ff-cobalt-ingot",
    category = "smelting",
    enabled = false,
    energy_required = 3.2,
    ingredients = {{"ff-cobalt-blast-blend", 1}},
    result = "ff-cobalt-ingot"
  },
  {
    type = "recipe",
    name = "ff-tailings-filtering",
    category = "chemistry",
    enabled = false,
    energy_required = 2,
    main_product = "water",
    ingredients = {
      {type = "fluid", name = "ff-tailings-water", amount = 10, catalyst_amount = 10},
      {type = "item", name = "coal", amount = 5},
    },
    results = {
      {type = "fluid", name = "water", amount = 10, catalyst_amount = 10},
    },
  },
  {
    type = "recipe",
    name = "ff-tailings-evaporation",
    category = "chemistry",
    enabled = false,
    energy_required = 2,
    main_product = "water",
    ingredients = {
      {type = "fluid", name = "ff-tailings-water", amount = 10, catalyst_amount = 10},
    },
    results = {
      {type = "fluid", name = "water", amount = 2, catalyst_amount = 2},
      {type = "item", name = "lead-ore", amount = 5},
      {type = "item", name = "titanium-ore", amount = 5},
    },
  },
  {
    type = "technology",
    name = "ff-cobalt-crust-dredging",
    icon = "__base__/graphics/technology/oil-gathering.png",
    icon_size = 256, icon_mipmaps = 4,
    order = "a",
    prerequisites = {"production-science-pack", "ff-dredging", "explosives"},
    unit = {
      count = 150,
      ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
      },
      time = 30
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "ff-cobalt-crust"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-cobalt-crust-washing"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-cobalt-concentrate"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-cobalt-blast-blend"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-cobalt-ingot"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-tailings-filtering"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-tailings-evaporation"
      },
    }
  },
}

util.allow_productivity("ff-cobalt-concentrate")
util.allow_productivity("ff-cobalt-ingot")
util.allow_productivity("ff-tailings-filtering")
util.allow_productivity("ff-tailings-evaporation")