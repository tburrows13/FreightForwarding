local util = require "__FreightForwarding__/prototypes/data-util"

data:extend{
  {
    type = "item",
    name = "ff-cobalt-ore",
    icon = "__FreightForwarding__/graphics/item/cobalt-ore.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "h[cobalt]-a[cobalt-ore]",
    stack_size = 30,
  },
  {
    type = "item",
    name = "ff-cobalt-concentrate",
    icon = "__FreightForwarding__/graphics/item/cobalt-concentrate.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "h[cobalt]-b[cobalt-concentrate]",
    stack_size = 30,
  },
  {
    type = "item",
    name = "ff-cobalt-blast-blend",
    icons = {
      {
        icon = "__FreightForwarding__/graphics/item/cobalt-concentrate.png",
        icon_size = 64, icon_mipmaps = 1,
      },
      {
        icon = "__base__/graphics/icons/explosives.png",
        icon_size = 64, icon_mipmaps = 4,
        scale = 0.33,
      },
    },
    subgroup = "raw-resource",
    order = "h[cobalt]-c[cobalt-blast-blend]",
    stack_size = 5,
  },
  {
    type = "item",
    name = "ff-cobalt-ingot",
    icon = "__FreightForwarding__/graphics/item/cobalt-ingot.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-material",
    order = "e[cobalt-ingot]",
    stack_size = 200,
  },
  {
    type = "fluid",
    name = "ff-tailings-water",
    icon = "__FreightForwarding__/graphics/item/tailings.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "fluid",
    default_temperature = 15,
    base_color = {r=0, g=0.34, b=0.6},  -- TODO
    flow_color = {r=0.7, g=0.7, b=0.7},
    order = "f[tailings]",
  },
  {
    type = "recipe",
    name = "ff-cobalt-concentrate",
    category = "oil-processing",
    enabled = false,
    energy_required = 12,
    main_product = "ff-cobalt-concentrate",
    ingredients = {
      {type = "item", name = "ff-cobalt-ore", amount = 10},
      {type = "fluid", name = "water", amount = 100, catalyst_amount = 100},
    },
    results = {
      {name = "ff-cobalt-concentrate", amount = 5},
      {type = "fluid", name = "ff-tailings-water", amount = 100, catalyst_amount = 100},
    },
  },
  {
    type = "recipe",
    name = "ff-cobalt-blast-blend",
    category = "crafting",
    enabled = false,
    energy_required = 0.5,
    main_product = "ff-cobalt-blast-blend",
    ingredients = {
      {type = "item", name = "ff-cobalt-concentrate", amount = 4},
      {type = "item", name = "explosives", amount = 4},
    },
    results = {
      {name = "ff-cobalt-blast-blend", amount = 4},
    },
  },
  {
    type = "recipe",
    name = "ff-cobalt-ingot",
    category = "smelting",
    enabled = false,
    energy_required = 16,
    ingredients = {{"ff-cobalt-blast-blend", 5}},
    result = "ff-cobalt-ingot"
  },
  {
    type = "recipe",
    name = "ff-tailings-filtration",
    localised_name = {"recipe-name.ff-tailings-filtration"},
    category = "chemistry",
    subgroup = "fluid-recipes",
    order = "f[tailings]-a[filtration]",
    enabled = false,
    icons =
    {
      {
        icon = "__base__/graphics/icons/fluid/water.png",
        icon_mipmaps = 4,
      },
      {
        icon = "__FreightForwarding__/graphics/item/tailings.png",
        scale = 0.25,
        shift = {-8, -8},
        icon_mipmaps = 1,
      },
    },
    icon_size = 64,
    energy_required = 8,
    allow_decomposition = false,
    ingredients = {
      {type = "fluid", name = "ff-tailings-water", amount = 100, catalyst_amount = 100},
      {type = "item", name = "coal", amount = 2},
    },
    results = {
      {type = "fluid", name = "water", amount = 100, catalyst_amount = 100},
    },
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "recipe",
    name = "ff-tailings-evaporation",
    category = "chemistry",
    subgroup = "fluid-recipes",
    order = "f[tailings]-b[evaporation]",
    enabled = false,
    allow_decomposition = false,
    icons =
    {
      {
        icon = "__base__/graphics/icons/fluid/water.png",
      },
      {
        icon = "__FreightForwarding__/graphics/item/tailings.png",
        scale = 0.25,
        shift = {-8, -8},
        icon_mipmaps = 1,
      },
      {
        icon = "__bzlead__/graphics/icons/lead-ore.png",
        scale = 0.23,
        shift = {-8, 8},
      },
      {
        icon = "__bztitanium__/graphics/icons/titanium-ore.png",
        scale = 0.23,
        shift = {8, 8},
      },
    },
    icon_size = 64, icon_mipmaps = 4,
    energy_required = 36,
    ingredients = {
      {type = "fluid", name = "ff-tailings-water", amount = 100, catalyst_amount = 100},
    },
    results = {
      {type = "fluid", name = "water", amount = 20, catalyst_amount = 20},
      {type = "item", name = "lead-ore", amount_min = 10, amount_max = 20},
      {type = "item", name = "titanium-ore", amount_min = 10, amount_max = 20},
    },
  },
  {
    type = "technology",
    name = "ff-cobalt-processing",
    icon = "__base__/graphics/technology/oil-gathering.png",
    icon_size = 256, icon_mipmaps = 4,
    order = "a",
    prerequisites = {"utility-science-pack", "ff-dredging", "explosives"},
    unit = {
      count = 150,
      ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"utility-science-pack", 1},
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
        recipe = "ff-tailings-filtration"
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
util.allow_productivity("ff-tailings-filtration")
util.allow_productivity("ff-tailings-evaporation")