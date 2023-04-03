-- Taken from se-space-trains
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

function space_accumulator_picture(tint, repeat_count)
  return {
    layers = {
      {
        filename = "__FreightForwarding__/graphics/charging-station/space_charging_station.png",
        priority = "high",
        width = 64,
        height = 96,
        repeat_count = repeat_count,
        shift = util.by_pixel(0, -16),
        tint = tint,
        animation_speed = 0.5,
        scale = 1,
        hr_version = {
          filename = "__FreightForwarding__/graphics/charging-station/hr_space_charging_station.png",
          priority = "high",
          width = 128,
          height = 192,
          repeat_count = repeat_count,
          shift = util.by_pixel(0, -16),
          tint = tint,
          animation_speed = 0.5,
          scale = 0.5
        }
      },
      {
        filename = "__FreightForwarding__/graphics/charging-station/space_charging_station_shadow.png",
        priority = "high",
        width = 144,
        height = 45,
        repeat_count = repeat_count,
        shift = util.by_pixel(32, 11),
        draw_as_shadow = true,
        scale = 1,
        hr_version = {
          filename = "__FreightForwarding__/graphics/charging-station/hr_space_charging_station_shadow.png",
          priority = "high",
          width = 285,
          height = 91,
          repeat_count = repeat_count,
          shift = util.by_pixel(32, 11),
          draw_as_shadow = true,
          scale = 0.5
        }
      }
    }
  }
end

function space_accumulator_charge()
  return {
      layers = {space_accumulator_picture({
          r = 1,
          g = 1,
          b = 1,
          a = 1
      }, 30), {
          filename = "__FreightForwarding__/graphics/charging-station/space_charging_station_lightning.png",
          priority = "high",
          width = 64,
          height = 96,
          line_length = 6,
          frame_count = 30,
          draw_as_glow = true,
          shift = util.by_pixel(0, -16),
          scale = 1,
          animation_speed = 3,
          hr_version = {
              filename = "__FreightForwarding__/graphics/charging-station/hr_space_charging_station_lightning.png",
              priority = "high",
              width = 128,
              height = 192,
              line_length = 6,
              frame_count = 30,
              draw_as_glow = true,
              shift = util.by_pixel(0, -16),
              scale = 0.5,
              animation_speed = 3
          }
      }}
  }
end

data:extend{ -- Battery charging interface
  {
    type = "furnace",
    name = "ff-charging-station",
    icon = "__FreightForwarding__/graphics/charging-station/space-train-charging-station.png",
    icon_size = 128,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {
        mining_time = 0.1,
        result = "ff-charging-station"
    },
    max_health = 150,
    resistances = {{
        type = "fire",
        percent = 70
    }},
    corpse = "accumulator-remnants",
    dying_explosion = "accumulator-explosion",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1, -1.5}, {1, 1}},
    energy_source = {
        type = "electric",
        buffer_capacity = "20MJ",
        usage_priority = "primary-input",
        input_flow_limit = "10MW",
        output_flow_limit = "0kW",
        drain = "0W"
    },
    fast_replaceable_group = "assembling-machine",
    always_draw_idle_animation = true,
    idle_animation = space_accumulator_picture(),
    working_visualisations = {{
        effect = "flicker",
        fadeout = true,
        light = {
            intensity = 0.2,
            size = 9.9,
            shift = {0.0, 0.0},
            color = {
                r = 0.25,
                g = 0.25,
                b = 0.8
            }
        }
    }, {
        effect = "flicker",
        fadeout = true,
        draw_as_light = true,
        animation = space_accumulator_charge()
    }},

    water_reflection = accumulator_reflection(),

    energy_usage = "800kW",
    crafting_categories = {"battery"},
    crafting_speed = 1,
    source_inventory_size = 1,
    result_inventory_size = 1,
    show_recipe_icon = false,

    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = {
        sound = {
            filename = "__FreightForwarding__/sound/space-charging-sound.ogg",
            volume = 0.35
        },
        idle_sound = {
            filename = "__base__/sound/accumulator-idle.ogg",
            volume = 0.3
        },
        -- persistent = true,
        max_sounds_per_type = 3,
        audible_distance_modifier = 0.5,
        fade_in_ticks = 4,
        fade_out_ticks = 20
    }
  },
  {
    type = "burner-generator",
    name = "ff-discharging-station",
    icon = "__FreightForwarding__/graphics/charging-station/space-train-charging-station.png",
    icon_size = 128,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {
        mining_time = 0.1,
        result = "ff-discharging-station"
    },
    max_health = 150,
    resistances = {{
        type = "fire",
        percent = 70
    }},
    corpse = "accumulator-remnants",
    dying_explosion = "accumulator-explosion",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1, -1.5}, {1, 1}},
    energy_source = {
      type = "electric",
      usage_priority = "secondary-output",
      drain = "0kW",
    },
    max_power_output = "4MW",
    burner = {
      emissions_per_minute = 0,
      fuel_category = "battery",
      fuel_inventory_size = 1,
      burnt_inventory_size = 1,
      type = "burner",
      light_flicker = {
          minimum_intensity = 0,
          maximum_intensity = 0,
      },
    },

    fast_replaceable_group = "assembling-machine",
    idle_animation = space_accumulator_picture(nil, 30),
    animation = space_accumulator_charge(),

    water_reflection = accumulator_reflection(),
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = {
        sound = {
            filename = "__FreightForwarding__/sound/space-charging-sound.ogg",
            volume = 0.35
        },
        idle_sound = {
            filename = "__base__/sound/accumulator-idle.ogg",
            volume = 0.3
        },
        -- persistent = true,
        max_sounds_per_type = 3,
        audible_distance_modifier = 0.5,
        fade_in_ticks = 4,
        fade_out_ticks = 20
    }
  },
  {
    type = "item",
    name = "ff-charging-station",
    icon = "__FreightForwarding__/graphics/charging-station/space-train-charging-station.png",
    icon_size = 128,
    subgroup = "production-machine",
    order = "h[train-system]",
    place_result = "ff-charging-station",
    stack_size = 10,
  },
  {
    type = "item",
    name = "ff-discharging-station",
    icon = "__FreightForwarding__/graphics/charging-station/space-train-charging-station.png",
    icon_size = 128,
    subgroup = "production-machine",
    order = "h[train-system]",
    place_result = "ff-discharging-station",
    stack_size = 10,
  },
  {
    type = "recipe",
    name = "ff-charging-station",
    energy_required = 10,
    enabled = false,
    ingredients = {{"steel-plate", 15}, {"advanced-circuit", 5}, {"copper-cable", 20}},
    result = "ff-charging-station",
  },
  {
    type = "recipe",
    name = "ff-discharging-station",
    energy_required = 10,
    enabled = false,
    ingredients = {{"steel-plate", 15}, {"advanced-circuit", 5}, {"copper-cable", 20}},
    result = "ff-discharging-station",
  },
  {
    type = "item",
    name = "ff-charged-battery",
    icons = {{icon = "__base__/graphics/icons/battery.png", tint = {r = 0.3, g = 0.5, b = 0.9, a = 0.8}}},
    icon_size = 64,
    --[[pictures = {
        layers = {{
            size = 128,
            filename = "__se-space-trains__/graphics/icons/battery.png",
            scale = 0.125
        }, {
            draw_as_light = true,
            flags = {"light"},
            size = 128,
            filename = "__se-space-trains__/graphics/icons/battery_light.png",
            scale = 0.125
        }}
    },]]
    fuel_category = "battery",
    fuel_value = "4MJ",
    burnt_result = "battery",
    subgroup = "raw-material",
    order = "h[battery]-c",
    stack_size = 200  -- Will be halved in stack-sizes.lua
  },
  {
    type = "recipe",
    name = "ff-charge-battery",
    category = "battery",
    --hide_from_player_crafting = true,
    energy_required = 5,
    enabled = false,
    --icon = "__se-space-trains__/graphics/icons/battery.png",
    --icon_size = 128,
    subgroup = "raw-material",
    allow_as_intermediate = false,
    ingredients = {{"battery", 1}},
    results = {{
      name = "ff-charged-battery",
      probability = 0.98,
      amount = 1
    }},
    always_show_made_in = true,
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "recipe",
    name = "ff-battery-pack",
    category = "chemistry",
    energy_required = 5,
    enabled = false,
    ingredients =
    {
      {"battery", 3},
      {"advanced-circuit", 1},
      {"ff-cobalt-ingot", 1},
    },
    result = "ff-battery-pack",
    crafting_machine_tint =
    {
      primary = {r = 0.965, g = 0.482, b = 0.338, a = 1.000}, -- #f67a56ff
      secondary = {r = 0.831, g = 0.560, b = 0.222, a = 1.000}, -- #d38e38ff
      tertiary = {r = 0.728, g = 0.818, b = 0.443, a = 1.000}, -- #b9d070ff
      quaternary = {r = 0.939, g = 0.763, b = 0.191, a = 1.000}, -- #efc230ff
    }
  },
  {
    type = "item",
    name = "ff-battery-pack",
    icon = "__FreightForwarding__/graphics/charging-station/battery-pack.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "h[battery]-b",
    stack_size = 200
  },
  {
    type = "item",
    name = "ff-charged-battery-pack",
    icons = {{icon = "__FreightForwarding__/graphics/charging-station/battery-pack.png", tint = {r = 0.3, g = 0.5, b = 0.9, a = 0.8}}},
    icon_size = 64,
    --[[pictures = {
        layers = {{
            size = 128,
            filename = "__se-space-trains__/graphics/icons/battery.png",
            scale = 0.125
        }, {
            draw_as_light = true,
            flags = {"light"},
            size = 128,
            filename = "__se-space-trains__/graphics/icons/battery_light.png",
            scale = 0.125
        }}
    },]]
    fuel_category = "battery",
    fuel_value = "10MJ",
    burnt_result = "ff-battery-pack",
    subgroup = "raw-material",
    order = "h[battery]-d",
    stack_size = 400  -- Will be halved in stack-sizes.lua
  },
  {
    type = "recipe",
    name = "ff-charge-battery-pack",
    category = "battery",
    --hide_from_player_crafting = true,
    energy_required = 12.5,
    enabled = false,
    --icon = "__se-space-trains__/graphics/icons/battery.png",
    --icon_size = 128,
    subgroup = "raw-material",
    allow_as_intermediate = false,
    ingredients = {{"ff-battery-pack", 1}},
    results = {{
      name = "ff-charged-battery-pack",
      probability = 0.995,
      amount = 1
    }},
    always_show_made_in = true,
    show_amount_in_title = false,
    always_show_products = true,
  },
  {
    type = "technology",
    name = "ff-battery-charging",
    icon_size = 128, icon_mipmaps = 1,
    icon = "__FreightForwarding__/graphics/charging-station/space-train-charging-station.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ff-charging-station"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-discharging-station"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-charge-battery"
      },
    },
    prerequisites = {"electric-energy-accumulators"},
    unit =
    {
      count = 150,

      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 60
    },
    order = "a"
  },
  {
    type = "technology",
    name = "ff-battery-pack",
    icon_size = 128, icon_mipmaps = 1,
    icon = "__FreightForwarding__/graphics/charging-station/battery-pack-tech.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ff-battery-pack"
      },
      {
        type = "unlock-recipe",
        recipe = "ff-charge-battery-pack"
      },
    },
    prerequisites = {"ff-battery-charging", "utility-science-pack", "ff-cobalt-processing"},
    unit =
    {
      count = 300,

      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
    order = "a"
  },
}

data:extend(
{
  {
    type = "fuel-category",
    name = "battery"
  },
  {
    type = "recipe-category",
    name = "battery"
  }
})

local util = require "__FreightForwarding__/prototypes/data-util"
util.allow_productivity("ff-battery-pack")