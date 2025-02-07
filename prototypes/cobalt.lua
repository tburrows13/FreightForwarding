data:extend{
  {
    type = "item",
    name = "ff-cobalt-ore",
    icon = "__FreightForwarding__/graphics/item/cobalt-ore.png",
    icon_size = 64,
    subgroup = "raw-resource",
    order = "h[cobalt]-a[cobalt-ore]",
    stack_size = 30,
  },
  {
    type = "item",
    name = "ff-cobalt-concentrate",
    icon = "__FreightForwarding__/graphics/item/cobalt-concentrate.png",
    icon_size = 64,
    subgroup = "raw-resource",
    order = "h[cobalt]-b[cobalt-concentrate]",
    stack_size = 50,
  },
  {
    type = "item",
    name = "ff-cobalt-blast-blend",
    icons = {
      {
        icon = "__FreightForwarding__/graphics/item/cobalt-concentrate.png",
        icon_size = 64,
      },
      {
        icon = "__base__/graphics/icons/explosives.png",
        icon_size = 64,
        scale = 0.33,
      },
    },
    subgroup = "raw-resource",
    order = "h[cobalt]-c[cobalt-blast-blend]",
    stack_size = 5,
    ic_create_container = false,
  },
  {
    type = "item",
    name = "ff-cobalt-ingot",
    icon = "__FreightForwarding__/graphics/item/cobalt-ingot.png",
    icon_size = 64,
    subgroup = "raw-material",
    order = "e[cobalt-ingot]",
    stack_size = 100,
  },
  {
    type = "fluid",
    name = "ff-tailings-water",
    icon = "__FreightForwarding__/graphics/item/tailings-water.png",
    icon_size = 64,
    subgroup = "fluid",
    default_temperature = 15,
    base_color = {r=0.1, g=0.2, b=0.3},  -- TODO
    flow_color = {r=0.4, g=0.4, b=0.4},
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
      {type = "item", name = "ff-cobalt-concentrate", amount = 5},
      {type = "fluid", name = "ff-tailings-water", amount = 100, catalyst_amount = 100},
    },
    allow_productivity = true,
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
      {type = "item", name = "ff-cobalt-blast-blend", amount = 4},
    },
  },
  {
    type = "recipe",
    name = "ff-cobalt-ingot",
    category = "smelting",
    enabled = false,
    energy_required = 16,
    ingredients = {{type="item", name="ff-cobalt-blast-blend", amount=5}},
    results = {{type="item", name="ff-cobalt-ingot", amount=1}},
    allow_productivity = true,
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
      },
      {
        icon = "__FreightForwarding__/graphics/item/tailings-water.png",
        scale = 0.25,
        shift = {-8, -8},
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
    allow_productivity = true,
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
        icon = "__FreightForwarding__/graphics/item/tailings-water.png",
        scale = 0.25,
        shift = {-8, -8},
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
    icon_size = 64,
    energy_required = 36,
    ingredients = {
      {type = "fluid", name = "ff-tailings-water", amount = 100, catalyst_amount = 100},
    },
    results = {
      {type = "fluid", name = "water", amount = 20, catalyst_amount = 20},
      {type = "item", name = "lead-ore", amount_min = 0, amount_max = 8},
      {type = "item", name = "titanium-ore", amount_min = 0, amount_max = 4},
    },
    allow_productivity = true,
  },
  {
    type = "technology",
    name = "ff-cobalt-processing",
    icon = "__FreightForwarding__/graphics/cobalt-ingot-technology.png",
    icon_size = 100,
    order = "a",
    prerequisites = {"utility-science-pack", "ff-dredging", "explosives"},
    unit = {
      count = 150,
      ingredients = {
          {type="item", name="automation-science-pack", amount=1},
          {type="item", name="logistic-science-pack", amount=1},
          {type="item", name="chemical-science-pack", amount=1},
          {type="item", name="utility-science-pack", amount=1},
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