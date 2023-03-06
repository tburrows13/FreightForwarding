data:extend{
  {
    type = "item",
    name = "ff-ferrous-nodule",
    icon = "__FreightForwarding__/graphics/item/limestone-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "w[nodule]-a[ferrous]",
    stack_size = 5
  },
  {
    type = "recipe",
    name = "ff-ferrous-nodule",
    category = "ff-dredging",
    enabled = false,
    energy_required = 2,
    ingredients = {},
    results = {
      {name = "ff-ferrous-nodule", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "ff-ferrous-nodule-washing",
    category = "chemistry",
    enabled = false,
    energy_required = 2,
    main_product = "iron-ore",
    ingredients = {
      {type = "item", name = "ff-ferrous-nodule", amount = 5},
      {type = "fluid", name = "sulfuric-acid", amount = 10},
    },
    results = {
      {name = "iron-ore", amount = 5},
      {name = "copper-ore", amount = 1, probability = 0.5},
      {name = "stone", amount = 2, probability = 0.5},
      {name = "ff-ferrous-nodule", amount = 1, probability = 0.5},
    },
  },
  {
    type = "item",
    name = "ff-cupric-nodule",
    icon = "__FreightForwarding__/graphics/item/shale-nodule.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "w[nodule]-b[cupric]",
    stack_size = 5
  },
  {
    type = "recipe",
    name = "ff-cupric-nodule",
    category = "ff-dredging",
    enabled = false,
    energy_required = 2,
    ingredients = {},
    results = {
      {name = "ff-cupric-nodule", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "ff-cupric-nodule-washing",
    category = "chemistry",
    enabled = false,
    energy_required = 2,
    main_product = "copper-ore",
    ingredients = {
      {type = "item", name = "ff-cupric-nodule", amount = 5},
      {type = "fluid", name = "sulfuric-acid", amount = 10},
    },
    results = {
      {name = "copper-ore", amount = 5},
      {name = "iron-ore", amount = 1, probability = 0.5},
      {name = "stone", amount = 2, probability = 0.5},
      {name = "ff-cupric-nodule", amount = 1, probability = 0.5},
    },
  },
  {
    type = "item",
    name = "ff-cobalt-crust",
    icon = "__FreightForwarding__/graphics/item/cobalt-crust.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "raw-resource",
    order = "w[nodule]-c[cobalt-crust]",
    stack_size = 5
  },
  {
    type = "recipe",
    name = "ff-cobalt-crust",
    category = "ff-dredging",
    enabled = false,
    energy_required = 2,
    ingredients = {},
    results = {
      {name = "ff-cobalt-crust", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "ff-cobalt-crust-washing",
    category = "chemistry",
    enabled = false,
    energy_required = 2,
    main_product = "ff-cobalt-ore",
    ingredients = {
      {type = "item", name = "ff-cobalt-crust", amount = 5},
      {type = "fluid", name = "sulfuric-acid", amount = 10},
    },
    results = {
      {name = "ff-cobalt-ore", amount = 5},
      {name = "iron-ore", amount = 1, probability = 0.5},
      {name = "copper-ore", amount = 1, probability = 0.5},
      {name = "stone", amount = 2, probability = 0.5},
      {name = "ff-cobalt-crust", amount = 1, probability = 0.5},
    },
  },
}