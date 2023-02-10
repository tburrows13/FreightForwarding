local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require "__bzlead__/data-util"

data:extend{
  {
    type = "recipe-category",
    name = "ff-lava-smelting"
  },
  {
    type = "technology",
    name = "ff-titansteel-processing",
    icon_size = 256, icon_mipmaps = 4,
    --icon = "__base__/graphics/technology/steel-processing.png",
    icons = {
      {
        icon = "__base__/graphics/technology/steel-processing.png",
        tint = { b = 0.3, g = 0.3, r = 0.3 }
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
        recipe = "ff-titansteel-cooling"
      }
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
    energy_required = 2.5,
  },
  {
    type = "recipe",
    name = "ff-titansteel-cooling",
    category = "chemistry",
    main_product = "ff-titansteel-plate",
    enabled = false,
    ingredients = {
      {name = "ff-hot-titansteel-plate", amount = 1},
      {type = "fluid", name="water", amount = 20, catalyst_amount = 5},
    },
    results = {
      {name = "ff-titansteel-plate", amount = 1},
      {type = "fluid", name="steam", amount = 20, temperature = 500, catalyst_amount = 4},
    },
    energy_required = 5,
  },
  {
    type = "item",
    name = "ff-hot-titansteel-plate",
    --icon = "__base__/graphics/icons/steel-plate.png",
    icons = {
      {
        icon = "__base__/graphics/icons/steel-plate.png",
        tint = { b = 0, g = 0, r = 0.8 }
      },
    },
    icon_size = 64, icon_mipmaps = 4,
    pictures =  -- Need separate pictures for glow effect
    {
      {
        layers =
        {
          {
            filename = "__base__/graphics/icons/steel-plate.png",
            tint = { b = 0, g = 0, r = 0.8 },
            size = 64,
            scale = 0.25,
            mipmap_count = 4
          },
          {
            filename = "__base__/graphics/icons/steel-plate.png",
            blend_mode = "additive",
            draw_as_light = true,
            tint = {r = 0.8, g = 0.8, b = 0.8, a = 0.4},
            size = 64,
            scale = 0.25,
            mipmap_count = 4
          },
        }
      },
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
        tint = { b = 0.3, g = 0.3, r = 0.3 }
      },
    },
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "e[titansteel-plate]-b",
    stack_size = 50  -- Will be halved in stack-sizes.lua
  },
}

util.add_prerequisite("rocket-silo", "ff-titansteel-processing")
bzutil.replace_ingredient("rocket-silo", "steel-plate", "ff-titansteel-plate")
bzutil.add_ingredient("rocket-part", "ff-titansteel-plate", 10)
