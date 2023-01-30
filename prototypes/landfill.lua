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

if not settings.startup["x-deep-landfill"].value then return end

local collision_mask_util = require "__core__.lualib.collision-mask-util"

local shallow_water_mask = collision_mask_util.get_first_unused_layer()
for _, tile in pairs(data.raw.tile) do
  if tile.name == "water-shallow" or tile.name == "water-mud" then
    table.insert(tile.collision_mask, shallow_water_mask)
  end
end

local water_mask = collision_mask_util.get_first_unused_layer()
for _, tile in pairs(data.raw.tile) do
  if tile.name == "water" or tile.name == "water-green" then
    table.insert(tile.collision_mask, water_mask)
  end
end

local deep_water_mask = collision_mask_util.get_first_unused_layer()
for _, tile in pairs(data.raw.tile) do
  if tile.name == "deepwater" or tile.name == "deepwater-green" then
    table.insert(tile.collision_mask, deep_water_mask)
  end
end

-- Make standard path-placeable items (brick, concrete etc) placeable on shallow water
-- This could override other mods if they change tile condition masks before us, but any that I know of (namely Space Exploration) do it in later stages so it should be fine.
for _, tileitem in pairs(data.raw.item) do
  if tileitem.place_as_tile then
    for _, mask in pairs(tileitem.place_as_tile.condition) do -- ideally you'd match only if the entire table is just a single matching entry, but that seems trickier than finding any matching element
      if mask == "water-tile" then
        tileitem.place_as_tile.condition = { water_mask, deep_water_mask }
      end
    end
  end
end

--data.raw["transport-belt"]["transport-belt"].collision_mask = { shallow_water_mask }

local landfill_item = data.raw.item["landfill"]
landfill_item.place_as_tile.condition_size = 1
landfill_item.place_as_tile.condition = { "ground-tile", deep_water_mask }

local landfill_recipe = data.raw.recipe["landfill"]
landfill_recipe.ingredients = {{ "stone", 20 }, { "wood", 2 }}

local landfill_tech = data.raw.technology["landfill"]

--data.raw["transport-belt"]["transport-belt"].collision_mask = nil

local deep_landfill_item = table.deepcopy(landfill_item)
deep_landfill_item.name = "x-deep-landfill"
deep_landfill_item.order = "c[landfill]-b[deep]"
deep_landfill_item.place_as_tile.condition = { "ground-tile" }

local deep_landfill_recipe = table.deepcopy(landfill_recipe)
deep_landfill_recipe.name = "x-deep-landfill"
deep_landfill_recipe.energy_required = 10
deep_landfill_recipe.ingredients = {{ "landfill", 15 }, { "concrete", 15 }, { "iron-stick", 15 }}
deep_landfill_recipe.result = "x-deep-landfill"
deep_landfill_recipe.enabled = false

local deep_landfill_tech = table.deepcopy(landfill_tech)
deep_landfill_tech.name = "x-deep-landfill"
deep_landfill_tech.effects = {{
  type = "unlock-recipe",
  recipe = "x-deep-landfill"
}}
deep_landfill_tech.unit = {
  count = 400,
  ingredients = {
    { "automation-science-pack", 1 },
    { "logistic-science-pack", 1 },
    { "chemical-science-pack", 1 },
  },
  time = 30
}

deep_landfill_tech.prerequisites = { "chemical-science-pack", "landfill", "concrete" }

data:extend{deep_landfill_item, deep_landfill_recipe, deep_landfill_tech}

-- Don't want deep landfill to inherit the localised names and icon
landfill_item.localised_name = { "item-name.x-landfill" }
landfill_item.localised_description = { "item-description.x-landfill" }
landfill_tech.localised_name = { "technology-name.x-landfill" }
landfill_tech.localised_description = { "technology-description.x-landfill" }

landfill_item.icon = "__X-Logistics__/graphics/shallow-landfill.png"
landfill_item.icon_size = 64
landfill_item.icon_mipmaps = 4
landfill_tech.icon = "__X-Logistics__/graphics/shallow-landfill-tech.png"
landfill_tech.icon_size = 256
landfill_tech.icon_mipmaps = 4

local waterfill_item = data.raw.item["waterfill-item"]
if waterfill_item then
  waterfill_item.order = "c[landfill]-c[waterfill]"
end
