--[[
Vanilla collision masks:
  water-shallow =
  {
    -- Character collides only with player-layer and train-layer,
    -- this can have any tile collision masks it doesn't matter for being walkable by character but not buildable.
    -- Having water-tile prevents placing paths, ground-tile prevents placing landfill.
    -- Not sure what other side effects could different combinations of tile masks cause.
    "water-tile",
    --"ground-tile",
    "item-layer",
    "resource-layer",
    "object-layer"
    --"doodad-layer"
  },

  water =
  {
    "water-tile",
    "resource-layer",
    "item-layer",
    "player-layer",
    "doodad-layer"
  },

  landfill = {"ground-tile"},

  landfill item.place_as_tile.condition =  { "ground-tile" }

]]

local collision_mask_util = require "__core__.lualib.collision-mask-util"

local non_deep_water_mask = collision_mask_util.get_first_unused_layer()
table.insert(data.raw.tile["water-shallow"].collision_mask, non_deep_water_mask)
table.insert(data.raw.tile["water-mud"].collision_mask, non_deep_water_mask)

--local regular_water_mask = collision_mask_util.get_first_unused_layer()
table.insert(data.raw.tile["water"].collision_mask, non_deep_water_mask)
table.insert(data.raw.tile["water-green"].collision_mask, non_deep_water_mask)

deep_water_mask = collision_mask_util.get_first_unused_layer()
table.insert(data.raw.tile["deepwater"].collision_mask, deep_water_mask)
table.insert(data.raw.tile["deepwater-green"].collision_mask, deep_water_mask)

local landfill_item = data.raw.item["landfill"]
landfill_item.place_as_tile.condition_size = 1
landfill_item.place_as_tile.condition = { deep_water_mask, "ground-tile" }

local landfill_recipe = data.raw.recipe["landfill"]
landfill_recipe.ingredients = {{ "stone", 20 }, { "wood", 2 }}

data.raw.tile["landfill"].walking_speed_modifier = 1.2  -- It can't be concreted, so give it a bit of a boost anyway

-- Make landfill minable
landfill_item.minable = {
	mining_time = 0.1, result = "landfill", count = 1,
}
landfill_item.mined_sound = {
  {
    filename = "__core__/sound/landfill-small.ogg"
  },
  {
    filename = "__core__/sound/landfill-small-1.ogg"
  },
  {
    filename = "__core__/sound/landfill-small-2.ogg"
  },
  {
    filename = "__core__/sound/landfill-small-3.ogg"
  },
  {
    filename = "__core__/sound/landfill-small-4.ogg"
  },
  {
    filename = "__core__/sound/landfill-small-5.ogg"
  }
}

local waterfill_item = data.raw.item["waterfill-item"]
if waterfill_item then
  waterfill_item.order = "c[landfill]-c[waterfill]"
end

-- Add collision masks to crude oil to stop it showing on land and non-deep water in preview
local crude_oil = data.raw.resource["crude-oil"]
local collision_mask = collision_mask_util.get_mask(crude_oil)
collision_mask_util.add_layer(collision_mask, non_deep_water_mask)
collision_mask_util.add_layer(collision_mask, "ground-tile")

crude_oil.collision_mask = collision_mask
