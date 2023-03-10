local sounds = require("__base__.prototypes.entity.sounds")

data:extend{
  {
    type = "item",
    name = "ff-seamount-dummy",  -- So that the correct words appear when hovering over the patch in map view
    localised_name = {"entity-name.ff-seamount"},
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
    name = "ff-seamount",
    icon = "__base__/graphics/icons/crude-oil-resource.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-off-grid"},
    category = "ff-seamount",
    subgroup = "raw-resource",
    order="a-b-a",
    infinite = false,
    highlight = true,
    minimum = 100,  -- Doesn't do anything?
    normal = 100,  -- Doesn't do anything?
    infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 0.7,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_time = 1,
      results =
      {
        {
          type = "item",
          name = "ff-seamount-dummy",
          amount = 1,
        }
      }
    },
    walking_sound = sounds.oil,
    --build_grid_size = 2,
    tile_height = 4, tile_width = 4,
    collision_box = {{-1.8, -1.8}, {1.8, 1.8}},
    selection_box = {{-2, -2}, {2, 2}},
    collision_mask = {"ground-tile", "resource-layer"},  -- Gets overwritten in data-final-fixes
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/crude-oil/crude-oil.png",
        priority = "extra-high",
        width = 74,
        height = 60,
        frame_count = 4,
        variation_count = 1,
        shift = util.by_pixel(0, -2),
        scale = 1.3,
        hr_version =
        {
          filename = "__base__/graphics/entity/crude-oil/hr-crude-oil.png",
          priority = "extra-high",
          width = 148,
          height = 120,
          frame_count = 4,
          variation_count = 1,
          shift = util.by_pixel(0, -2),
          scale = 0.5 * 1.3
        }
      }
    },
    map_color = {0.78, 0.2, 0.77},
    map_grid = false,
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          {
            type = "script",
            effect_id = "ff-seamount-created",
          },
        }
      }
    },
  }
}