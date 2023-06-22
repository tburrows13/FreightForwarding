local sounds = require "__base__.prototypes.entity.sounds"

local empty_sprite = {
  filename = "__core__/graphics/empty.png",
  priority = "extra-high",
  width = 1,
  height = 1,
  frame_count = 1,
  repeat_count = 1,
  direction_count = 1,
  variation_count = 1,
}

local collision_mask_util = require "__core__.lualib.collision-mask-util"

local lava_pool_layer = collision_mask_util.get_first_unused_layer()
log("FF lava_pool_layer assigned to " .. lava_pool_layer)
-- Make lava pool resource collide with trees, rocks, and cliffs
for _, type in pairs{"tree", "simple-entity", "cliff"} do
  for _, prototype in pairs(data.raw[type]) do
    local collision_mask = collision_mask_util.get_mask(prototype)
    if collision_mask_util.mask_contains_layer(collision_mask, "object-layer") then
      collision_mask_util.add_layer(collision_mask, lava_pool_layer)
      prototype.collision_mask = collision_mask
    end
  end
end

local lava_pool_water_tile_layer = collision_mask_util.get_first_unused_layer()
log("FF lava_pool_water_tile_layer assigned to " .. lava_pool_water_tile_layer)

-- Make lava pool resource collide with trees, rocks, and cliffs
for _, prototype in pairs(data.raw.tile) do
  local collision_mask = collision_mask_util.get_mask(prototype)
  if collision_mask_util.mask_contains_layer(collision_mask, "water-tile") then
    collision_mask_util.add_layer(collision_mask, lava_pool_water_tile_layer)
    prototype.collision_mask = collision_mask
  end
end


data:extend{
  {
    type = "item",
    name = "ff-lava-pool-dummy",  -- So that the correct words appear when hovering over the patch in map view
    localised_name = {"entity-name.ff-lava-pool"},
    --icon = "__base__/graphics/icons/assembling-machine-1.png",
    icons = {
      {
        icon = "__base__/graphics/icons/crude-oil-resource.png",
        tint = {b = 0, g = 0, r = 0.7},
      },
    },
    icon_size = 64, icon_mipmaps = 4,
    flags = {"hidden"},
    --subgroup = "raw-resource",
    --order = "e[iron-ore]",
    stack_size = 50
  },
  {
    type = "resource",
    name = "ff-lava-pool-resource",
    --icon = "__base__/graphics/icons/assembling-machine-1.png",
    icons = {
      {
        icon = "__base__/graphics/icons/crude-oil-resource.png",
        tint = {b = 0, g = 0, r = 0.7},
      },
    },
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    category = "basic-fluid",
    subgroup = "raw-resource",
    order="a-b-a",
    infinite = false,
    highlight = true,
    minimum = 1,
    normal = 1,
    --[[minimum = 60000,
    normal = 300000,]]
    infinite_depletion_amount = 10,
    resource_patch_search_radius = 20,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32 * 4,
    minable =
    {
      mining_time = 1,
      result = "ff-lava-pool-dummy",
    },
    --walking_sound = sounds.oil,
    collision_mask = {lava_pool_layer, lava_pool_water_tile_layer},
    collision_box = {{-2, -2}, {2, 2}},
    --selection_box = {{-2, -2}, {2, 2}},
    stage_counts = {0},
    stages = {sheet = empty_sprite},
    map_color = {1, 0.4, 0},
    map_grid = false,
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          {
            type = "script",
            effect_id = "ff-lava-pool-resource-created",
          },
        }
      }
    },
  },
  {
    type = "assembling-machine",
    name = "ff-lava-pool",
    icon = "__FreightForwarding__/graphics/lava-pool/lava-pool-icon.png",
    icon_size = 64, icon_mipmaps = 1,
    flags = {"placeable-player"},
    collision_box = {{-1.8, -1.8}, {1.8, 1.8}},
    selection_box = {{-2, -2}, {2, 2}},
    --always_draw_idle_animation = true,
    animation =
    {
      filename = "__core__/graphics/light-medium.png",
      blend_mode = "additive",
      draw_as_light = true,
      tint = {a = 0.8, r = 255, g = 80, b = 0},
      width = 300,
      height = 300,
      --repeat_count = 48,
      shift = util.by_pixel(0, 10),
      scale = 1.1,
      hr_version =
      {
        filename = "__core__/graphics/light-medium.png",
        blend_mode = "additive",
        draw_as_light = true,
        tint = {a = 0.8, r = 255, g = 80, b = 0},
        width = 300,
        height = 300,
        --repeat_count = 48,
        shift = util.by_pixel(0, 10),
        scale = 1.1,
      }
    },
    integration_patch =  {
      filename = "__FreightForwarding__/graphics/lava-pool/lava-pool.png",
      priority = "high",
      width = 512,
      height = 512,
      --line_length = 8,
      --shift = util.by_pixel(0, 2),
      scale = 0.275,
      --draw_as_glow = true,
      hr_version =
      {
        filename = "__FreightForwarding__/graphics/lava-pool/lava-pool.png",
        priority = "high",
        width = 512,
        height = 512,
        --line_length = 8,
        --shift = util.by_pixel(0, 2),
        scale = 0.275,
      },
    },
    --always_draw_idle_animation = true,
    --[[idle_animation =
    {
      layers =
      {
        {
          filename = "__FreightForwarding__/graphics/lava-pool/lava-pool.png",
          priority = "high",
          width = 512,
          height = 512,
          frame_count = 10,
          --line_length = 8,
          --shift = util.by_pixel(0, 2),
          scale = 0.275,
          animation_speed = 0.25,
          hr_version =
          {
            filename = "__FreightForwarding__/graphics/lava-pool/lava-pool.png",
            priority = "high",
            width = 512,
            height = 512,
            frame_count = 10,
            --line_length = 8,
            --shift = util.by_pixel(0, 2),
            scale = 0.275,
            animation_speed = 0.25,
          }
        },
      }
    },]]
    --map_color = {1, 0.4, 0},
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
        source_effects = {
          {
            type = "script",
            effect_id = "ff-lava-pool-machine-created",
          },
        }
      }
    },
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
  {
    type = "animation",
    name = "ff-lava-pool-animation",
    filename = "__FreightForwarding__/graphics/lava-pool/lava-pool.png",
    priority = "high",
    width = 512,
    height = 512,
    frame_count = 10,
    --line_length = 8,
    --shift = util.by_pixel(0, 2),
    scale = 0.275,
    animation_speed = 0.2,
    draw_as_glow = true,
    hr_version =
    {
      filename = "__FreightForwarding__/graphics/lava-pool/lava-pool.png",
      priority = "high",
      width = 512,
      height = 512,
      frame_count = 10,
      --line_length = 8,
      --shift = util.by_pixel(0, 2),
      scale = 0.275,
      animation_speed = 0.2,
    },
  },
  {
    type = "assembling-machine",
    name = "ff-lava-pool-small",
    icon = "__FreightForwarding__/graphics/lava-pool/small-lava-pool-icon.png",
    icon_size = 64, icon_mipmaps = 1,
    flags = {"placeable-player"},
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    animation =
    {
      filename = "__core__/graphics/light-medium.png",
      blend_mode = "additive",
      draw_as_light = true,
      tint = {a = 0.8, r = 255, g = 80, b = 0},
      width = 300,
      height = 300,
      --repeat_count = 48,
      scale = 0.55,
      shift = util.by_pixel(0, 6),
      hr_version =
      {
        filename = "__core__/graphics/light-medium.png",
        blend_mode = "additive",
        draw_as_light = true,
        tint = {a = 0.8, r = 255, g = 80, b = 0},
        width = 300,
        height = 300,
        --repeat_count = 48,
        --shift = util.by_pixel(-1, 44),
        scale = 0.55,
        shift = util.by_pixel(0, 6),
      }
    },
    integration_patch =  {
      filename = "__FreightForwarding__/graphics/lava-pool/small-lava-pool.png",
      priority = "high",
      width = 128,
      height = 128,
        --line_length = 8,
      --shift = util.by_pixel(0, 2),
      scale = 0.6,
      --draw_as_glow = true,
      hr_version =
      {
        filename = "__FreightForwarding__/graphics/lava-pool/small-lava-pool.png",
        priority = "high",
        width = 128,
        height = 128,
            --line_length = 8,
        --shift = util.by_pixel(0, 2),
        scale = 0.6,
      },
    },
    --map_color = {1, 0.4, 0},
    crafting_categories = {"ff-lava-heating"},
    fixed_recipe = "ff-titansteel-heating",
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
        source_effects = {
          {
            type = "script",
            effect_id = "ff-lava-pool-machine-created",
          },
        }
      }
    },
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
  {
    type = "animation",
    name = "ff-lava-pool-small-animation",
    filename = "__FreightForwarding__/graphics/lava-pool/small-lava-pool.png",
    priority = "high",
    width = 128,
    height = 128,
    frame_count = 10,
    --line_length = 8,
    --shift = util.by_pixel(0, 2),
    scale = 0.6,
    animation_speed = 0.2,
    draw_as_glow = true,
    hr_version =
    {
      filename = "__FreightForwarding__/graphics/lava-pool/small-lava-pool.png",
      priority = "high",
      width = 128,
      height = 128,
      frame_count = 10,
      --line_length = 8,
      --shift = util.by_pixel(0, 2),
      scale = 0.6,
      animation_speed = 0.2,
    },
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
}