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
    flags = {"placeable-neutral"},
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
        filename = "__FreightForwarding__/graphics/seamount.png",
        priority = "extra-high",
        width = 200,
        height = 200,
        frame_count = 1,
        variation_count = 1,
        scale = 0.6,
        tint = {a=0.3, r=0.2,g=0.2,b=0.2},
        hr_version =
        {
          filename = "__FreightForwarding__/graphics/seamount.png",
          priority = "extra-high",
          width = 200,
          height = 200,
          frame_count = 1,
          variation_count = 1,
          tint = {a=0.3, r=0.2,g=0.2,b=0.2},
          scale = 0.6
        }
      }
    },
    map_color = {0, 0.6, 0.4},
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
