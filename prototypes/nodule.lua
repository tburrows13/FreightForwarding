data:extend{
  {
    type = "item",
    name = "ff-ferrous-nodule",
    icon = "__FreightForwarding__/graphics/item/limestone-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "w[nodule]-a[ferrous]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ff-ferrous-nodule",
    category = "ff-dredging",
    enabled = false,
    energy_required = 50,
    ingredients = {},
    results = {
      {name = "ff-ferrous-nodule", amount_min = 100, amount_max = 200}
    },
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "recipe",
    name = "ff-ferrous-nodule-washing",
    category = "chemistry",
    enabled = false,
    energy_required = 15,
    allow_decomposition = false,
    main_product = "iron-ore",
    ingredients = {
      {type = "item", name = "ff-ferrous-nodule", amount = 18},
      {type = "fluid", name = "sulfuric-acid", amount = 15},
    },
    results = {
      {name = "iron-ore", amount_min = 40, amount_max = 50},
      {name = "copper-ore", amount_min = 0, amount_max = 8},
      {name = "stone", amount_min = 0, amount_max = 16},
      {name = "ff-ferrous-nodule", amount_min = 0, amount_max = 6},
    },
  },
  {
    type = "item",
    name = "ff-cupric-nodule",
    icon = "__FreightForwarding__/graphics/item/shale-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "w[nodule]-b[cupric]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ff-cupric-nodule",
    category = "ff-dredging",
    enabled = false,
    energy_required = 50,
    ingredients = {},
    results = {
      {name = "ff-cupric-nodule", amount_min = 100, amount_max = 200}
    },
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "recipe",
    name = "ff-cupric-nodule-washing",
    category = "chemistry",
    enabled = false,
    energy_required = 15,
    allow_decomposition = false,
    main_product = "copper-ore",
    ingredients = {
      {type = "item", name = "ff-cupric-nodule", amount = 18},
      {type = "fluid", name = "sulfuric-acid", amount = 15},
    },
    results = {
      {name = "copper-ore", amount_min = 40, amount_max = 50},
      {name = "iron-ore", amount_min = 0, amount_max = 8},
      {name = "stone", amount_min = 0, amount_max = 16},
      {name = "ff-cupric-nodule", amount_min = 0, amount_max = 6},
    },
  },
  {
    type = "item",
    name = "ff-cobalt-crust",
    icon = "__FreightForwarding__/graphics/item/cobalt-crust.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "w[nodule]-c[cobalt-crust]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ff-cobalt-crust",
    category = "ff-dredging",
    enabled = false,
    energy_required = 75,
    ingredients = {},
    results = {
      {name = "ff-cobalt-crust", amount_min = 50, amount_max = 150}
    },
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "recipe",
    name = "ff-cobalt-crust-washing",
    category = "chemistry",
    enabled = false,
    energy_required = 15,
    allow_decomposition = false,
    main_product = "ff-cobalt-ore",
    ingredients = {
      {type = "item", name = "ff-cobalt-crust", amount = 15},
      {type = "fluid", name = "sulfuric-acid", amount = 30},
    },
    results = {
      {name = "ff-cobalt-ore", amount_min = 40, amount_max = 50},
      {name = "iron-ore", amount_min = 0, amount_max = 8},
      {name = "copper-ore", amount_min = 0, amount_max = 8},
      {name = "stone", amount_min = 0, amount_max = 16},
      {name = "ff-cobalt-crust", amount_min = 0, amount_max = 10},
    },
  },
}