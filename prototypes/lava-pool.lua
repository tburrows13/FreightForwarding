local sounds = require("__base__.prototypes.entity.sounds")

local empty_sprite = {
  filename = "__core__/graphics/empty.png",
  priority = "extra-high",
  width = 1,
  height = 1,
  frame_count = 1,
  repeat_count = 1,
  direction_count = 1,
}

data:extend{
  {
    type = "assembling-machine",
    name = "ff-lava-pool",
    --icon = "__base__/graphics/icons/assembling-machine-1.png",
    icons = {
      {
        icon = "__base__/graphics/icons/crude-oil-resource.png",
        tint = {b = 0, g = 0, r = 0.7},
      },
    },
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/crude-oil/hr-crude-oil.png",
          priority="high",
          width = 148,
          height = 120,
          frame_count = 1,
          --line_length = 8,
          --shift = util.by_pixel(0, 2),
          scale = 1.2,
          tint = {b = 0, g = 0, r = 0.7},
          hr_version =
          {
            filename = "__base__/graphics/entity/crude-oil/hr-crude-oil.png",
            priority="high",
            width = 148,
            height = 120,
            frame_count = 1.1,
            scale = 1.2,
            tint = {b = 0, g = 0, r = 0.7},
          }
        },
      }
    },
    crafting_categories = {"ff-lava-smelting"},
    fixed_recipe = "ff-titansteel-smelting",
    show_recipe_icon = false,
    crafting_speed = 1,
    energy_source = {type = "void"},
    energy_usage = "1W",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.generic_impact,
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          type = "create-entity",
          entity_name = "ff-lava-light",
        }
      }
    }
    --[[working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.5
        }
      },
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }]]
  },
  --[[{
    type = "loader-1x1",
    name = "ff-lava-pool-loader",
    icon = "__base__/graphics/icons/loader.png",
    flags = {"hidden"},
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "other",
    filter_count = 0,
    collision_mask = {"transport-belt-layer"},
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    animation_speed_coefficient = 32,
    belt_animation_set = basic_belt_animation_set,
    container_distance = 1,
    speed = 0.03125,
    allow_rail_interaction = false,
    structure_render_layer = "lower-object",
    structure =
    {
      direction_in = empty_sprite,
      direction_out = empty_sprite,
    }
  },]]
  {
    type = "lamp",
    name = "ff-lava-light",
    energy_source = {type = "void"},
    energy_usage_per_tick = "1W",
    always_on = true,
    picture_on = empty_sprite,
    picture_off = empty_sprite,
    flags = {"hidden", "not-on-map", "placeable-off-grid"},
    light =
    {
      intensity = 1,
      size = 14,
      color = {r = 255, g = 80, b = 0},
    },
  },
}