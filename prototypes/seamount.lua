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
    flags = {"placeable-neutral"},
    category = "ff-seamount",
    subgroup = "raw-resource",
    order="a-b-a",
    infinite = false,
    highlight = true,
    minimum = 1,
    normal = 1,
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
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    collision_mask = {"ground-tile", "resource-layer"},  -- Gets overwritten in data-final-fixes
    --[[autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "crude-oil",
      order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
      base_density = 8.2,
      base_spots_per_km2 = 1.8,
      random_probability = 1/48,
      random_spot_size_minimum = 1,
      random_spot_size_maximum = 1, -- don't randomize spot size
      additional_richness = 220000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
      has_starting_area_placement = false,
      regular_rq_factor_multiplier = 1
    },]]
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
        hr_version =
        {
          filename = "__base__/graphics/entity/crude-oil/hr-crude-oil.png",
          priority = "extra-high",
          width = 148,
          height = 120,
          frame_count = 4,
          variation_count = 1,
          shift = util.by_pixel(0, -2),
          scale = 0.5
        }
      }
    },
    map_color = {0.78, 0.2, 0.77},
    map_grid = false
  }
}