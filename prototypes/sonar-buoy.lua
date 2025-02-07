local hit_effects = require "__base__.prototypes.entity.hit-effects"
local sounds = require "__base__.prototypes.entity.sounds"

data.raw["fluid"]["crude-oil"].fuel_value = "300kJ"

data:extend({
  {
    type = "technology",
    name = "ff-sonar-buoy",
    icons = {
      {
        icon = "__base__/graphics/icons/radar.png", --"__FreightForwarding__/graphics/sonar-buoy/technology.png",
        icon_size = 64,
        tint = { r = 0.0, g = 0.8, b = 0.8, a = 1.0 },
      },
    },
    order = "sonar buoy",
    prerequisites = { "laser", "advanced-electronics-2" },
    unit = {
      time = 30,
      count = 300,
      ingredients = {
        { "automation-science-pack",   1 },
        { "logistic-science-pack",     1 },
        { "chemical-science-pack",     1 },
        { "ff-transport-science-pack", 1 },
      },
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "ff-sonar-buoy",
      }
    }
  } --[[@as data.TechnologyPrototype]],
  {
    type = "recipe",
    name = "ff-sonar-buoy",
    enabled = false,
    ingredients = {
      {type="item", name="processing-unit", amount=5},
      {type="item", name="barrel", amount=10},
      {type="item", name="radar", amount=1},
    },
    results = {{type="item", name="ff-sonar-buoy", amount=1}},
  } --[[@as data.RecipePrototype]],
  {
    type = "item",
    name = "ff-sonar-buoy",
    icons = {
      {
        icon = "__base__/graphics/icons/radar.png", --"__FreightForwarding__/graphics/sonar-buoy/icon.png",
        icon_size = 64,
        tint = { r = 0.0, g = 0.8, b = 0.8, a = 1.0 },
      },
    },
    subgroup = "defensive-structure",
    order = "d[radar]-b[radar]",
    place_result = "ff-sonar-buoy",
    stack_size = 50,
  } --[[@as data.ItemPrototype]],
  {
    type = "radar",
    name = "ff-sonar-buoy",
    icons = {
      {
        icon = "__base__/graphics/icons/radar.png", --"__FreightForwarding__/graphics/sonar-buoy/icon.png",
        icon_size = 64,
        tint = { r = 0.0, g = 0.8, b = 0.8, a = 1.0 },
      },
    },
    flags = { "placeable-player", "player-creation" },
    minable = { mining_time = 0.1, result = "ff-sonar-buoy" },
    max_health = 250,
    corpse = "radar-remnants",
    dying_explosion = "radar-explosion",
    resistances = {
      {
        type = "fire",
        percent = 80,
      },
      {
        type = "impact",
        percent = 40,
      }
    },
    collision_mask = {layers = {}},
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    damaged_trigger_effect = hit_effects.entity(),

    energy_usage = "1.8MW",
    energy_per_sector = "1MJ",
    energy_per_nearby_scan = "250kJ",
    max_distance_of_sector_revealed = 1,
    max_distance_of_nearby_sector_revealed = 1,
    energy_source = {
      type = "fluid",
      burns_fluid = true,
      scale_fluid_usage = true,
      fluid_box = {
        volume = 100,
        filter = "crude-oil",
        pipe_connections = {
          { flow_direction = "input", direction = defines.direction.north, position = {0, -1} },
          { flow_direction = "input", direction = defines.direction.east, position = {0, 1} },
          { flow_direction = "input", direction = defines.direction.south, position = {-1, 0} },
          { flow_direction = "input", direction = defines.direction.west, position = {1, 0} },
        }
      }
    },

    vehicle_impact_sound = sounds.generic_impact,
    working_sound = {
      sound = {
        {
          filename = "__base__/sound/radar.ogg",
          volume = 0.8
        }
      }
    },

    pictures = {
      layers = {
        {
          filename = "__base__/graphics/entity/radar/radar.png",
          apply_projection = false,
          priority = "low",
          line_length = 8,
          width = 98,
          height = 128,
          direction_count = 64,
          shift = { 0.03125, -0.5 },
          tint = { r = 0.0, g = 0.8, b = 0.8, a = 1.0 },
          hr_version = {
            filename = "__base__/graphics/entity/radar/hr-radar.png",
            apply_projection = false,
            priority = "low",
            line_length = 8,
            width = 196,
            height = 254,
            scale = 0.5,
            direction_count = 64,
            shift = { 0.03125, -0.5 },
            tint = { r = 0.0, g = 0.8, b = 0.8, a = 1.0 },
          },
        },
        {
          filename = "__base__/graphics/entity/radar/radar-shadow.png",
          apply_projection = false,
          priority = "low",
          line_length = 8,
          width = 172,
          height = 94,
          direction_count = 64,
          draw_as_shadow = true,
          shift = { 1.21875, 0.09375 },
          hr_version = {
            filename = "__base__/graphics/entity/radar/hr-radar-shadow.png",
            apply_projection = false,
            priority = "low",
            line_length = 8,
            width = 343,
            height = 186,
            scale = 0.5,
            direction_count = 64,
            draw_as_shadow = true,
            shift = { 1.2265625, 0.09375 },
          },
        },
      },
    },
  } --[[@as data.RadarPrototype]]
})
