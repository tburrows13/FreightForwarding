if mods["Mining-Space-Industries-II"] or mods["LunarLandings"] or mods["space-exploration"] then return end

local sounds = require "__base__.prototypes.entity.sounds"

--local rocket_silo = data.raw["rocket-silo"]["rocket-silo"]
--rocket_silo.placeable_by = { item = "rocket-silo", count = 1 }  -- Allows placing rocket silo blueprints outside of holes

local rocket_silo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
local rocket_silo_item = data.raw["item"]["rocket-silo"]

local rocket_silo_dummy = table.deepcopy(rocket_silo)
rocket_silo_dummy.name = "ff-rocket-silo-dummy"
rocket_silo_dummy.localised_name = {"entity-name.rocket-silo"}
rocket_silo_dummy.localised_description = rocket_silo.localised_description or {"entity-description.rocket-silo"}
rocket_silo_dummy.type = "mining-drill"
rocket_silo_dummy.collision_mask = {}
rocket_silo_dummy.vector_to_place_result = {0, 0}
rocket_silo_dummy.mining_speed = 1
rocket_silo_dummy.resource_categories = { "ff-rocket-silo" }
rocket_silo_dummy.resource_searching_radius = 0.49
rocket_silo_dummy.animations = rocket_silo_dummy.base_day_sprite
rocket_silo_dummy.created_effect = {
  type = "direct",
  action_delivery = {
    type = "instant",
    source_effects = {
      {
        type = "script",
        effect_id = "ff-rocket-silo-created",
      },
    }
  }
}
-- TODO give dummy correct energy usage

rocket_silo_item.place_result = "ff-rocket-silo-dummy"

data:extend{
  rocket_silo_dummy,
  {
    type = "resource-category",
    name = "ff-rocket-silo",
  },
  {
    type = "item",
    name = "ff-rocket-silo-hole-dummy",  -- So that the correct words appear when hovering over the patch in map view
    localised_name = {"entity-name.ff-rocket-silo-hole"},
    --icon = "__base__/graphics/icons/assembling-machine-1.png",
    icons = {
      {
        icon = "__base__/graphics/icons/rocket-silo.png",
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
    name = "ff-rocket-silo-hole",
    icon = "__base__/graphics/icons/rocket-silo.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    category = "ff-rocket-silo",
    subgroup = "raw-resource",
    order="a-b-c",
    infinite = false,
    highlight = true,
    minimum = 100,  -- Doesn't do anything?
    normal = 100,  -- Doesn't do anything?
    infinite_depletion_amount = 10,
    resource_patch_search_radius = 12,
    tree_removal_probability = 1,
    tree_removal_max_distance = 32 * 32,
    cliff_removal_probability = 1,
    remove_decoratives = "true",  -- Doesn't work, so done in script instead
    minable =
    {
      mining_time = 1,
      results =
      {
        {
          type = "item",
          name = "ff-rocket-silo-hole-dummy",
          amount = 1,
        }
      }
    },
    --walking_sound = sounds.oil,
    --build_grid_size = 2,
    tile_height = 9, tile_width = 9,
    --collision_box = {{-3.8, -3.2}, {3.8, 3.8}},  -- TODO use smaller collision box, but only if ff-rocket-silo-dummy collides with player
    collision_box = rocket_silo.collision_box,
    selection_box = rocket_silo.selection_box,
    collision_mask = {"resource-layer", "doodad-layer", "player-layer"},
    stage_counts = {0},
    stages =
    {
      sheet =
      {
        filename = "__FreightForwarding__/graphics/rocket-silo/rocket-silo-hole.png",
        priority = "extra-high",
        width = 608,
        height = 596,
        frame_count = 1,
        variation_count = 1,
        scale = 0.5,
        --tint = {a=0.3, r=0.2,g=0.2,b=0.2},
      }
    },
    map_color = {0.1, 0.9, 0.4},
    map_grid = false,
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          {
            type = "script",
            effect_id = "ff-rocket-silo-hole-created",
          },
        }
      }
    },
  }
}
