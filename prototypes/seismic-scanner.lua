local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")
local shift = {x=-0, y=-0.5}

data:extend{
  {
    type = "technology",
    name = "ff-seismic-scanner",
    icon = "__FreightForwarding__/graphics/seismic-scanner/seismic-scanner-icon.png",
    icon_size = 64,
    order = "a",
    prerequisites = {"electric-engine", "explosives"},
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
        recipe = "ff-seismic-scanner"
      }
    }
  },
  {
    type = "recipe",
    name = "ff-seismic-scanner",
    ingredients =
    {
      {"advanced-circuit", 5},
      {"electric-engine-unit", 10},
      {"lead-plate", 20},
      {"explosives", 10}
    },
    result = "ff-seismic-scanner"
  },
  {
    type = "item",
    name = "ff-seismic-scanner",
    icon = "__FreightForwarding__/graphics/seismic-scanner/seismic-scanner-icon.png",
    icon_size = 64, icon_mipmaps = 1,
    subgroup = "defensive-structure",
    order = "d[radar]-b[radar]",
    place_result = "ff-seismic-scanner",
    stack_size = 50
  },
  {
    type = "radar",
    name = "ff-seismic-scanner",
    icon = "__FreightForwarding__/graphics/seismic-scanner/seismic-scanner-icon.png",
    icon_size = 64, icon_mipmaps = 1,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "ff-seismic-scanner"},
    max_health = 250,
    corpse = "radar-remnants",
    dying_explosion = "radar-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    --energy_per_sector = "10MJ",
    energy_per_sector = "1.5MJ",
    --energy_per_sector = "10kJ",
    max_distance_of_sector_revealed = 1,
    max_distance_of_nearby_sector_revealed = 1,
    energy_per_nearby_scan = "250kJ",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 150  -- One mining drill is 10
    },
    energy_usage = "600kW",
    integration_patch =
    {
      layers =
      {
        {
          filename = "__FreightForwarding__/graphics/seismic-scanner/hr-hole.png",
          priority = "extra-high",
          width = 322,
          height = 300,
          scale = 0.5 * 3/4,
          variation_count = 1,
          shift = {0.25, -0.5},
          hr_version = {
            filename = "__FreightForwarding__/graphics/seismic-scanner/hr-hole.png",
            priority = "extra-high",
            width = 322,
            height = 300,
            scale = 0.5 * 3/4,
            variation_count = 1,
            shift = {0.25, -0.5},
          }
        },
        {
          filename = "__FreightForwarding__/graphics/seismic-scanner/hr-hole-front.png",
          priority = "extra-high",
          animation_speed = 0.5,
          width = 322,
          height = 300,
          scale = 0.5 * 3/4,
          direction_count = 1,
          shift = {0.25, -0.5},
          hr_version = {
            filename = "__FreightForwarding__/graphics/seismic-scanner/hr-hole-front.png",
            priority = "extra-high",
            animation_speed = 0.5,
            width = 322,
            height = 300,
            scale = 0.5 * 3/4,
            direction_count = 1,
            shift = {0.25, -0.5},
          }
        },
      },
    },
    
    pictures =
    {
      layers = {
        {
          filename = "__FreightForwarding__/graphics/seismic-scanner/hr-center.png",
          priority = "high",
          animation_speed = 0.5,
          line_length = 8,
          direction_count = 64,
          -- width = 70,
          -- height = 123,
          -- scale = 1.5,
          -- shift = {0 + shift.x, -1 + shift.y},
          width = 139,
          height = 246,
          scale = 0.5 * 1.5,
          shift = {-0.1 + shift.x, 0 + shift.y},
          hr_version = {
            filename = "__FreightForwarding__/graphics/seismic-scanner/hr-center.png",
            priority = "high",
            line_length = 8,
            animation_speed = 0.5,
            direction_count = 64,
            width = 139,
            height = 246,
            scale = 0.5 * 1.5,
            shift = {-0.1 + shift.x, 0 + shift.y},
          }
        },
        {
          filename = "__FreightForwarding__/graphics/seismic-scanner/hr-center-shadow.png",
          draw_as_shadow = true,
          priority = "high",
          line_length = 8,
          direction_count = 64,
          -- width = 108,
          -- height = 54,
          -- scale = 1.4,
          -- shift = {1.5 + shift.x, 0 + shift.y},
          width = 163,
          height = 123,
          scale = 0.5 * 1.4,
          shift = {1.5 + shift.x, 0 + shift.y},
          hr_version = {
            filename = "__FreightForwarding__/graphics/seismic-scanner/hr-center-shadow.png",
            draw_as_shadow = true,
            priority = "high",
            line_length = 8,
            direction_count = 64,
            width = 163,
            height = 123,
            scale = 0.5 * 1.4,
            shift = {1.5 + shift.x, 0 + shift.y},
          }
        },
      }
    },
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/radar.ogg",
          volume = 0.8
        }
      },
      max_sounds_per_type = 3,
      --audible_distance_modifier = 0.8,
      use_doppler_shift = false
    },
    radius_minimap_visualisation_color = { r = 0.059, g = 0.092, b = 0.235, a = 0.275 },
    rotation_speed = 0.01,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/radar/radar-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 32,
        shift = util.by_pixel(5, 35),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
}