-- Dredger includes:
-- mining-drill as place_result of item, that can only be placed on nodule deposits, and includes platform in sprite?
-- assembling-machine which is placed instead of the mining-drill by script
-- tile which is placed around the assembling-machine by script

local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")

data:extend{
  {
    type = "recipe-category",
    name = "ff-dredging",
  },
  {
    type = "resource-category",
    name = "ff-seamount",
  },
  {
    type = "technology",
    name = "ff-dredging",
    icon = "__base__/graphics/technology/oil-gathering.png",
    icon_size = 256, icon_mipmaps = 4,
    order = "a",
    prerequisites = {"chemical-science-pack", "ff-battery-charging", "concrete"},
    unit = {
      count = 150,
      ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
      },
      time = 30
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "ff-dredging-platform"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-ferrous-nodule"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-cupric-nodule"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-ferrous-nodule-washing"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-cupric-nodule-washing"
      },
    }
  },
  {
    type = "recipe",
    name = "ff-dredging-platform",
    energy_required = 5,
    ingredients =
    {
      {"pumpjack", 1},
      {"landfill", 100},
      {"refined-concrete", 200},
      {"lead-plate", 100},
    },
    result = "ff-dredging-platform",
    enabled = false
  },
  {
    type = "item",
    name = "ff-dredging-platform",
    icon = "__FreightForwarding__/graphics/dredger.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "extraction-machine",
    order = "b[fluids]-d[dredger]",
    place_result = "ff-dredging-platform",
    stack_size = 5
  },
  {
    type = "mining-drill",
    name = "ff-dredging-platform",
    icon = "__FreightForwarding__/graphics/dredger.png",
    icon_size = 64, icon_mipmaps = 1,
    flags = {"placeable-neutral", "player-creation"},
    resource_categories = {"ff-seamount"},
    max_health = 200,
    corpse = "pumpjack-remnants",
    dying_explosion = "pumpjack-explosion",
    collision_box = {{ -1.7, -1.7}, {1.7, 1.7}},
    selection_box = {{ -2, -2}, {2, 2}},
    collision_mask = {"object-layer", "train-layer"},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1.6, -2.5}, {1.5, 1.6}},  -- TODO update
    energy_source =
    {
      type = "electric",
      emissions_per_minute = 200,
      usage_priority = "secondary-input"
    },
    energy_usage = "800kW",
    mining_speed = 1,
    resource_searching_radius = 0.5,
    vector_to_place_result = {0, 0},
    module_specification =
    {
      module_slots = 2
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/pumpjack/pumpjack-radius-visualization.png",
      width = 12,
      height = 12,
      scale = 5,
    },
    monitor_visualization_tint = {r=78, g=173, b=255},
    base_render_layer = "lower-object-above-shadow",
    base_picture =
    {
      sheets =
      {
        {
          filename = "__base__/graphics/entity/pumpjack/pumpjack-base.png",
          priority = "extra-high",
          width = 131,
          height = 137,
          shift = util.by_pixel(-2.5, -4.5),
          scale = 1.3,
          hr_version =
          {
            filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-base.png",
            priority = "extra-high",
            width = 261,
            height = 273,
            shift = util.by_pixel(-2.25, -4.75),
            scale = 0.5 * 1.3
          }
        },
        {
          filename = "__base__/graphics/entity/pumpjack/pumpjack-base-shadow.png",
          priority = "extra-high",
          width = 110,
          height = 111,
          draw_as_shadow = true,
          shift = util.by_pixel(6, 0.5),
          scale = 1.3,
          hr_version =
          {
            filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-base-shadow.png",
            width = 220,
            height = 220,
            scale = 0.5 * 1.3,
            draw_as_shadow = true,
            shift = util.by_pixel(6, 0.5)
          }
        }
      }
    },
    animations =
    {
      north =
      {
        layers =
        {
          {
            priority = "high",
            filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead.png",
            line_length = 8,
            width = 104,
            height = 102,
            frame_count = 40,
            shift = util.by_pixel(-4, -24),
            animation_speed = 0.5,
            scale = 1.3,
            hr_version =
            {
              priority = "high",
              filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-horsehead.png",
              animation_speed = 0.5,
              scale = 0.5 * 1.3,
              line_length = 8,
              width = 206,
              height = 202,
              frame_count = 40,
              shift = util.by_pixel(-4, -24)
            }
          },
          {
            priority = "high",
            filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead-shadow.png",
            animation_speed = 0.5,
            draw_as_shadow = true,
            line_length = 8,
            width = 155,
            height = 41,
            frame_count = 40,
            shift = util.by_pixel(17.5, 14.5),
            scale = 1.3,
            hr_version =
            {
              priority = "high",
              filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-horsehead-shadow.png",
              animation_speed = 0.5,
              draw_as_shadow = true,
              line_length = 8,
              width = 309,
              height = 82,
              frame_count = 40,
              scale = 0.5 * 1.3,
              shift = util.by_pixel(17.75, 14.5)
            }
          }
        }
      }
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/pumpjack.ogg",
          volume = 0.7
        },
        --{
        --  filename = "__base__/sound/pumpjack-1.ogg",
        --  volume = 0.43
        --}
      },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 10
    },
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          {
            type = "script",
            effect_id = "ff-dredger-created",
          },
        }
      }
    },
  },
  {
    type = "assembling-machine",
    name = "ff-dredger",
    icon = "__FreightForwarding__/graphics/dredger.png",
    icon_size = 64, icon_mipmaps = 1,
    flags = {"placeable-neutral", "player-creation"},
    crafting_categories = {"ff-dredging"},
    max_health = 200,
    corpse = "pumpjack-remnants",
    dying_explosion = "pumpjack-explosion",
    collision_box = {{ -1.7, -1.7}, {1.7, 1.7}},
    selection_box = {{ -2, -2}, {2, 2}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1.6, -2.5}, {1.5, 1.6}},  -- TODO update
    energy_source =
    {
      type = "electric",
      emissions_per_minute = 200,
      usage_priority = "secondary-input"
    },
    energy_usage = "800kW",
    crafting_speed = 1,
    resource_searching_radius = 0.49,
    --[[module_specification =
    {
      module_slots = 2
    },]]
    base_render_layer = "lower-object-above-shadow",
    base_picture =
    {
      sheets =
      {
        {
          filename = "__base__/graphics/entity/pumpjack/pumpjack-base.png",
          priority = "extra-high",
          width = 131,
          height = 137,
          shift = util.by_pixel(-2.5, -4.5),
          scale = 1.3,
          hr_version =
          {
            filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-base.png",
            priority = "extra-high",
            width = 261,
            height = 273,
            shift = util.by_pixel(-2.25, -4.75),
            scale = 0.5 * 1.3
          }
        },
        {
          filename = "__base__/graphics/entity/pumpjack/pumpjack-base-shadow.png",
          priority = "extra-high",
          width = 110,
          height = 111,
          draw_as_shadow = true,
          shift = util.by_pixel(6, 0.5),
          scale = 1.3,
          hr_version =
          {
            filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-base-shadow.png",
            width = 220,
            height = 220,
            scale = 0.5 * 1.3,
            draw_as_shadow = true,
            shift = util.by_pixel(6, 0.5)
          }
        }
      }
    },
    animation =
    {
      north =
      {
        layers =
        {
          {
            priority = "high",
            filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead.png",
            line_length = 8,
            width = 104,
            height = 102,
            frame_count = 40,
            shift = util.by_pixel(-4, -24),
            animation_speed = 0.5,
            scale = 1.3,
            hr_version =
            {
              priority = "high",
              filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-horsehead.png",
              animation_speed = 0.5,
              scale = 0.5 * 1.3,
              line_length = 8,
              width = 206,
              height = 202,
              frame_count = 40,
              shift = util.by_pixel(-4, -24)
            }
          },
          {
            priority = "high",
            filename = "__base__/graphics/entity/pumpjack/pumpjack-horsehead-shadow.png",
            animation_speed = 0.5,
            draw_as_shadow = true,
            line_length = 8,
            width = 155,
            height = 41,
            frame_count = 40,
            shift = util.by_pixel(17.5, 14.5),
            scale = 1.3,
            hr_version =
            {
              priority = "high",
              filename = "__base__/graphics/entity/pumpjack/hr-pumpjack-horsehead-shadow.png",
              animation_speed = 0.5,
              draw_as_shadow = true,
              line_length = 8,
              width = 309,
              height = 82,
              frame_count = 40,
              scale = 0.5 * 1.3,
              shift = util.by_pixel(17.75, 14.5)
            }
          }
        }
      }
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/pumpjack.ogg",
          volume = 0.7
        },
        --{
        --  filename = "__base__/sound/pumpjack-1.ogg",
        --  volume = 0.43
        --}
      },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 10
    },
  },
  {
    type = "electric-pole",
    name = "ff-dredger-pole",
    icon = "__base__/graphics/icons/substation.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"hidden", "not-on-map", "not-blueprintable", "not-deconstructable", "placeable-off-grid"},
    --collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    --selection_box = {{-1, -1}, {1, 1}},
    maximum_wire_distance = 0,
    supply_area_distance = 14,
    pictures = util.empty_sprite(),
    --vehicle_impact_sound = sounds.generic_impact,
    --open_sound = sounds.electric_network_open,
    --close_sound = sounds.electric_network_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/substation.ogg",
        volume = 0.4
      },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.32,
      fade_in_ticks = 30,
      fade_out_ticks = 40,
      use_doppler_shift = false
    },
    connection_points =
    {
      {
        shadow =
        {
          copper = util.by_pixel(136, 8),
          green = util.by_pixel(124, 8),
          red = util.by_pixel(151, 9)
        },
        wire =
        {
          copper = util.by_pixel(0, -86),
          green = util.by_pixel(-21, -82),
          red = util.by_pixel(22, -81)
        }
      },
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      width = 12,
      height = 12,
      priority = "extra-high-no-scale"
    },
  },
}

local concrete = table.deepcopy(data.raw["tile"]["concrete"])
local tile_variants = {
  main = concrete.variants.main,
  inner_corner_mask = concrete.variants.inner_corner_mask,
  outer_corner_mask = concrete.variants.outer_corner_mask,
  side_mask = concrete.variants.side_mask,
  u_transition_mask = concrete.variants.u_transition_mask,
  o_transition_mask = concrete.variants.o_transition_mask,
  material_background = {
    picture = "__FreightForwarding__/graphics/dredging-platform/concrete.png",
    count = 8,
    hr_version = {
      picture = "__FreightForwarding__/graphics/dredging-platform/hr-concrete.png",
      count = 8,
      scale = 0.5
    }
  }
}

data:extend{
  {
    type = "tile",
    name = "ff-dredging-platform",
    order = "a[artificial]-b[tier-2]-a[concrete]",
    needs_correction = false,
    collision_mask = {"ground-tile"},  -- Gets added to later
    walking_speed_modifier = 1.4,
    layer = 61,
    transition_overlay_layer_offset = 2, -- need to render border overlay on top of hazard-concrete
    decorative_removal_probability = 0.25,
    variants = tile_variants,
    transitions = concrete.transitions,
    transitions_between_transitions = concrete.transitions_between_transitions,

    walking_sound = concrete.walking_sound,
    build_sound = concrete.build_sound,
    map_color={r=63, g=61, b=59},
    scorch_mark_color = {r = 0.373, g = 0.307, b = 0.243, a = 1.000},
    pollution_absorption_per_second = 0,
    vehicle_friction_modifier = concrete.vehicle_friction_modifier,

    trigger_effect = concrete.trigger_effect,
  },
}

local radar = table.deepcopy(data.raw["radar"]["radar"])
radar.name = "ff-dredger-radar"
radar.flags = {"hidden", "not-on-map", "not-blueprintable", "not-deconstructable", "placeable-off-grid"}
radar.selectable_in_game = false
radar.allow_copy_paste = false
radar.collision_mask = {}
radar.collision_box = nil
radar.selection_box = nil
radar.fast_replaceable_group = nil
radar.next_upgrade = nil
radar.pictures = emptypic
radar.max_distance_of_sector_revealed = 0
radar.energy_source = {
  type = "void"
}
radar.energy_usage = "50kW"
radar.water_reflection = nil
radar.working_sound = nil
data:extend{radar}
