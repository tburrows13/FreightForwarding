-- Taken from se-space-trains
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local energy_usage = "4MW"

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
    type = "assembling-machine",
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
        drain = "500W"
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

    energy_usage = energy_usage,
    crafting_categories = {"battery"},
    crafting_speed = 1,
    fixed_recipe = "ff-charge-battery",
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
    max_power_output = energy_usage,
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
    animation = space_accumulator_picture(),
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
    fuel_value = "40MJ",
    burnt_result = "battery",
    subgroup = "intermediate-product",
    order = "s-a[battery]",
    stack_size = 200  -- Will be halved in stack-sizes.lua
  },
  {
    type = "recipe",
    name = "ff-charge-battery",
    category = "battery",
    hidden = true,
    energy_required = 10,
    enabled = false,
    --icon = "__se-space-trains__/graphics/icons/battery.png",
    --icon_size = 128,
    subgroup = "intermediate-product",
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
  }
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

-- Add to accumulator tech
table.insert(data.raw.technology["electric-energy-accumulators"].effects, {type = "unlock-recipe", recipe = "ff-charging-station"})
table.insert(data.raw.technology["electric-energy-accumulators"].effects, {type = "unlock-recipe", recipe = "ff-discharging-station"})
table.insert(data.raw.technology["electric-energy-accumulators"].effects, {type = "unlock-recipe", recipe = "ff-charge-battery"})
