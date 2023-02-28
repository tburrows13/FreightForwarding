data:extend{
  {
    type = "item",
    name = "ff-slag",
    icon = "__FreightForwarding__/graphics/slag/hot-slag.png",
    icon_size = 64, icon_mipmaps = 4,
    pictures =
    {
      {
        layers = {
          {
            filename = "__FreightForwarding__/graphics/slag/hot-slag.png",
            mipmap_count = 4,
            scale = 0.25,
            size = 64
          },
          {
            draw_as_light = true,
            filename = "__FreightForwarding__/graphics/slag/hot-slag-light.png",
            -- blend_mode = "additive",
            flags = { "light" },
            mipmap_count = 4,
            scale = 0.25,
            size = 64
          }
        }
      },
      {
        layers = {
          {
            filename = "__FreightForwarding__/graphics/slag/hot-slag-1.png",
            mipmap_count = 4,
            scale = 0.25,
            size = 64
          },
          {
            draw_as_light = true,
            filename = "__FreightForwarding__/graphics/slag/hot-slag-1-light.png",
            -- blend_mode = "additive",
            flags = { "light" },
            mipmap_count = 4,
            scale = 0.25,
            size = 64
          }
        }
      },
      {
        layers = {
          {
            filename = "__FreightForwarding__/graphics/slag/hot-slag-2.png",
            mipmap_count = 4,
            scale = 0.25,
            size = 64
          },
          {
            draw_as_light = true,
            filename = "__FreightForwarding__/graphics/slag/hot-slag-2-light.png",
            -- blend_mode = "additive",
            flags = { "light" },
            mipmap_count = 4,
            scale = 0.25,
            size = 64
          }
        }
      },
      {
        layers = {
          {
            filename = "__FreightForwarding__/graphics/slag/hot-slag-3.png",
            mipmap_count = 4,
            scale = 0.25,
            size = 64
          },
          {
            draw_as_light = true,
            filename = "__FreightForwarding__/graphics/slag/hot-slag-3-light.png",
            -- blend_mode = "additive",
            flags = { "light" },
            mipmap_count = 4,
            scale = 0.25,
            size = 64
          }
        }
      },

    },
    subgroup = "raw-resource",
    order = "z",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "ff-slag-processing",
    category = "chemistry",
    enabled = false,
    icons =
    {
      {
        icon = "__FreightForwarding__/graphics/slag/hot-slag.png",
      },
      {
        icon = "__base__/graphics/icons/iron-ore.png",
        scale = 0.25,
        shift = {8, 8},
      },
      {
        icon = "__base__/graphics/icons/stone.png",
        scale = 0.25,
        shift = {-8, 8},
      },
    },
    icon_size = 64, icon_mipmaps = 4,
    ingredients = {
      {type = "item", name = "ff-slag", amount = 5},
      {type = "fluid", name = "sulfuric-acid", amount = 2},
    },
    results = {
      {type = "item", name = "stone", amount = 1, probability = 0.1},
      {type = "item", name = "iron-ore", amount = 1, probability = 0.1},
    },
    subgroup = "raw-material",
    order = "e[titansteel-plate]-d",
    energy_required = 5,
    crafting_machine_tint =
    {
      primary = {r = 1.000, g = 0.958, b = 0.000, a = 1.000}, -- #fff400ff
      secondary = {r = 1.000, g = 0.852, b = 0.172, a = 1.000}, -- #ffd92bff
      tertiary = {r = 0.876, g = 0.869, b = 0.597, a = 1.000}, -- #dfdd98ff
      quaternary = {r = 0.969, g = 1.000, b = 0.019, a = 1.000}, -- #f7ff04ff
    }

  },
}