-- Mostly copied from bzlead

data:extend({
	{
    type = "autoplace-control",
    category = "resource",
    name = "lead-ore",
    richness = true,
    order = "b-e"
	},
	{
    type = "noise-layer",
    name = "lead-ore"
	},
	{
    type = "resource",
    icon_size = 64, icon_mipmaps = 3,
    name = "lead-ore",
    icon = "__bzlead__/graphics/icons/lead-ore.png",
    flags = {"placeable-neutral"},
    order="a-b-a",
    map_color = {r=0.35, g=0.10, b=0.10},
    minable = {
      hardness = 1,
      mining_particle = "lead-ore-particle",
      mining_time = 1,
      result = "lead-ore"
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},

    autoplace = nil,  -- Set in resources.lua

    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages = {
      sheet = {
        filename = "__bzlead__/graphics/entity/ores/hr-lead-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
  },
  {
    type = "item",
    name = "lead-ore",
    icon_size = 64, icon_mipmaps = 3,
    icon = "__bzlead__/graphics/icons/lead-ore.png",
    pictures = {
      {filename="__bzlead__/graphics/icons/lead-ore.png", size=64, scale=0.25},
      {filename="__bzlead__/graphics/icons/lead-ore-1.png", size=64, scale=0.25},
      {filename="__bzlead__/graphics/icons/lead-ore-2.png", size=64, scale=0.25},
      {filename="__bzlead__/graphics/icons/lead-ore-3.png", size=64, scale=0.25},
    },
    subgroup = "raw-resource",
    order = "t-c-a",
    stack_size = 50,
  },
  {
    type = "optimized-particle",
    name = "lead-ore-particle",
    flags = {"not-on-map"},
    life_time = 180,
    pictures =
    {
      {
        filename = "__bzlead__/graphics/entity/lead-ore-particle/hr-lead-ore-particle-1.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__bzlead__/graphics/entity/lead-ore-particle/hr-lead-ore-particle-2.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__bzlead__/graphics/entity/lead-ore-particle/hr-lead-ore-particle-3.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__bzlead__/graphics/entity/lead-ore-particle/hr-lead-ore-particle-4.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      }
    },
    shadows =
    {
      {
        filename = "__bzlead__/graphics/entity/lead-ore-particle/hr-lead-ore-particle-shadow-1.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__bzlead__/graphics/entity/lead-ore-particle/hr-lead-ore-particle-shadow-2.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__bzlead__/graphics/entity/lead-ore-particle/hr-lead-ore-particle-shadow-3.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__bzlead__/graphics/entity/lead-ore-particle/hr-lead-ore-particle-shadow-4.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      }
    }
  },
  {
    type = "recipe",
    name = "lead-plate",
    category = "smelting",
    order = "d[lead-plate]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bzlead__/graphics/icons/lead-plate.png", icon_size = 64, icon_mipmaps = 3, },
          { icon = "__bzlead__/graphics/icons/lead-ore.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {-8, -8}},
        } or {
          { icon = "__bzlead__/graphics/icons/lead-plate.png", icon_size = 64, icon_mipmaps = 3, },
        }
    ),
    main_product = "lead-plate",
    enabled = true,
    energy_required = 6.4,
    ingredients = {{"lead-ore", 2}},
    results = {
      {type="item", name = "lead-plate", amount=2, probability=5/6},
      {type="item", name = "copper-ore", amount=1, probability=1/3},
    },
  },
  {
    type = "item",
    name = "lead-plate",
    icon = "__bzlead__/graphics/icons/lead-plate.png",
    icon_size = 64, icon_mipmaps = 3,
    subgroup = "raw-material",
    order = "b[lead-plate]",
    stack_size = 100
  },
}
)
