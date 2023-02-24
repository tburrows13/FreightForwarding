local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require "__bzlead__/data-util"

data:extend{
  {
    type = "recipe-category",
    name = "ff-lava-smelting",  -- Big lava pool
  },
  {
    type = "recipe-category",
    name = "ff-lava-heating",  -- Small lava pool
  },
  {
    type = "technology",
    name = "ff-titansteel-processing",
    icon_size = 256, icon_mipmaps = 4,
    --icon = "__base__/graphics/technology/steel-processing.png",
    icons = {
      {
        icon = "__base__/graphics/technology/steel-processing.png",
        tint = { b = 0.4, g = 0.4, r = 0.4 }
      },
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ff-titansteel-smelting"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-titansteel-heating"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-titansteel-cooling"
      },
    },
    prerequisites = {"production-science-pack", "utility-science-pack"},
    unit =
    {
      count = 1000,

      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    order = "k-a"
  },
  {
    type = "recipe",
    name = "ff-titansteel-smelting",
    category = "ff-lava-smelting",
    enabled = false,
    ingredients = {
      {name = "steel-plate", amount = 1},
      {name = "titanium-plate", amount = 1},
    },
    results = {
      {name = "ff-hot-titansteel-plate", amount = 1},
    },
    energy_required = 10,
    always_show_made_in = true,
    order = "e[titansteel-plate]-a",
  },
  {
    type = "recipe",
    name = "ff-titansteel-heating",
    category = "ff-lava-heating",
    enabled = false,
    ingredients = {
      {name = "ff-titansteel-plate", amount = 1},
    },
    results = {
      {name = "ff-hot-titansteel-plate", amount = 1, probability = 0.99},
    },
    energy_required = 2,
    always_show_made_in = true,
    show_amount_in_title = false,
    always_show_products = true,
    order = "e[titansteel-plate]-b",
  },
  {
    type = "recipe",
    name = "ff-titansteel-cooling",
    category = "chemistry",
    main_product = "ff-titansteel-plate",
    enabled = false,
    ingredients = {
      {name = "ff-hot-titansteel-plate", amount = 1},
      {type = "fluid", name="water", amount = 500},
    },
    results = {
      {name = "ff-titansteel-plate", amount = 1},
      {type = "fluid", name="steam", amount = 500, temperature = 500},
    },
    energy_required = 5,
  },
  {
    type = "item",
    name = "ff-hot-titansteel-plate",
    icon = "__FreightForwarding__/graphics/hot-titansteel.png",
    icon_size = 64, icon_mipmaps = 4,
    pictures = {
      layers = {
        {
          filename = "__FreightForwarding__/graphics/hot-titansteel.png",
          mipmap_count = 4,
          scale = 0.25,
          size = 64
        },
        {
          draw_as_light = true,
          filename = "__FreightForwarding__/graphics/hot-titansteel-light.png",
          -- blend_mode = "additive",
          flags = { "light" },
          mipmap_count = 4,
          scale = 0.25,
          size = 64
        }
      }
    },
    subgroup = "raw-material",
    order = "e[titansteel-plate]-a",
    stack_size = 1
  },
  {
    type = "item",
    name = "ff-titansteel-plate",
    --icon = "__base__/graphics/icons/steel-plate.png",
    icons = {
      {
        icon = "__base__/graphics/icons/steel-plate.png",
        tint = { b = 0.32, g = 0.32, r = 0.32 }
      },
    },
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "e[titansteel-plate]-c",
    stack_size = 50  -- Will be halved in stack-sizes.lua
  },
}

util.add_prerequisite("rocket-silo", "ff-titansteel-processing")
bzutil.replace_ingredient("rocket-silo", "steel-plate", "ff-titansteel-plate")
bzutil.add_ingredient("rocket-part", "ff-titansteel-plate", 10)
