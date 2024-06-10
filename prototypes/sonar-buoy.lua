local hit_effects = require "__base__.prototypes.entity.hit-effects"
local sounds = require "__base__.prototypes.entity.sounds"

data.raw["fluid"]["crude-oil"].fuel_value = "300kJ"

data:extend({
  {
    type = "technology",
    name = "ff-sonar-buoy",
    icon = "__base__/graphics/technology/radar.png", --"__FreightForwarding__/graphics/sonar-buoy/technology.png",
    icon_size = 256,
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
      { "processing-unit", 5 },
      { "empty-barrel",    10 },
      { "radar",           1 },
    },
    result = "ff-sonar-buoy",
  } --[[@as data.RecipePrototype]],
  {
    type = "item",
    name = "ff-sonar-buoy",
    icon = "__base__/graphics/icons/radar.png", --"__FreightForwarding__/graphics/sonar-buoy/icon.png",
    icon_size = 64,
    subgroup = "defensive-structure",
    order = "d[radar]-b[radar]",
    place_result = "ff-sonar-buoy",
    stack_size = 50,
  } --[[@as data.ItemPrototype]],
  {
    type = "radar",
    name = "ff-sonar-buoy",
    icon = "__base__/graphics/icons/radar.png", --"__FreightForwarding__/graphics/sonar-buoy/icon.png",
    icon_size = 64,
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
    collision_mask = { "ground-tile", "object-layer", "train-layer" },
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.3, -1.3 }, { 1.3, 1.3 } },
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
        height = 1,
        base_area = 1,
        base_level = -1,
        filter = "crude-oil",
        pipe_connections = {
          {
            type = "input",
            position = { 0, 2 }
          },
          {
            type = "input",
            position = { 0, -2 }
          },
          {
            type = "input",
            position = { 2, 0 }
          },
          {
            type = "input",
            position = { -2, 0 }
          }
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

    pictures = table.deepcopy(data.raw["radar"]["radar"].pictures),
  } --[[@as data.RadarPrototype]]
})
