require "__FreightForwarding__/prototypes/transport-drones"
require "__FreightForwarding__/prototypes/crating-items"
require "__FreightForwarding__/prototypes/crating-icons"
require "__FreightForwarding__/prototypes/item-subgroups"
require "__FreightForwarding__/prototypes/crating-tabs"
require "__FreightForwarding__/prototypes/stack-sizes"
local collision_mask_util = require "__core__.lualib.collision-mask-util"

data.raw["resource"]["ff-seamount"].collision_mask = {"resource-layer", non_deep_water_mask, "ground-tile"}

local platform_layer = collision_mask_util.get_first_unused_layer()
log("FF platform_layer assigned to " .. platform_layer)
table.insert(data.raw.tile["ff-dredging-platform"].collision_mask, platform_layer)
local banned_types = {"electric-pole", "underground-belt"}
for _, type in pairs(banned_types) do
  for _, prototype in pairs(data.raw[type]) do
    local mask = collision_mask_util.get_mask(prototype)
    collision_mask_util.add_layer(mask, platform_layer)
    prototype.collision_mask = mask
  end
end
table.insert(data.raw["offshore-pump"]["offshore-pump"].center_collision_mask, platform_layer)
table.insert(data.raw["offshore-pump"]["waterfill-placer"].center_collision_mask, platform_layer)


-- Science
local util = require "__FreightForwarding__/prototypes/data-util"

for _, tech in pairs(data.raw.technology) do
  local ingredients = tech.unit.ingredients
  if ingredients[3] and ingredients[3][1] == "chemical-science-pack" then
    table.insert(ingredients, 3, {"ff-transport-science-pack", 1})
  else
    -- Add to all techs descending from key techs
    if util.is_descendant_of(tech.name, "fluid-handling") or
      util.is_descendant_of(tech.name, "water_transport") or
      util.is_descendant_of(tech.name, "automobilism") then
      table.insert(ingredients, {"ff-transport-science-pack", 1})
    end
  end
end


local function multiply_ingredients(ingredients, multiplier, ingredient_name)
  local new_ingredients = {}
  for _, ingredient in pairs(ingredients) do
    if not ingredient_name or ingredient_name == ingredient[1] then
      table.insert(new_ingredients, {ingredient[1], ingredient[2] * multiplier})
    else
      table.insert(new_ingredients, {ingredient[1], ingredient[2]})
    end
  end
  return new_ingredients
end

local function multiply_recipe_ingredients(recipe, multiplier, ingredient_name)
  if recipe.normal ~= nil then
    recipe.normal.ingredients = multiply_ingredients(recipe.normal.ingredients, multiplier, ingredient_name)
  end
  if recipe.expensive ~= nil then
    recipe.expensive.ingredients = multiply_ingredients(recipe.expensive.ingredients, multiplier, ingredient_name)
  end
  if recipe.ingredients ~= nil then
    recipe.ingredients = multiply_ingredients(recipe.ingredients, multiplier, ingredient_name)
  end
end

-- Bridges automatically get ingredients based on "rail" cost and hardcoded setting

if data.raw.recipe["bbr-rail-wood"] then
  data.raw.recipe["bbr-rail-wood"].result_count = 1
  multiply_recipe_ingredients(data.raw.recipe["bbr-rail-wood"], 2)
end
if data.raw.recipe["bbr-rail-iron"] then
  data.raw.recipe["bbr-rail-iron"].result_count = 1
  multiply_recipe_ingredients(data.raw.recipe["bbr-rail-iron"], 2)
end
if data.raw.recipe["bbr-rail-brick"] then
  data.raw.recipe["bbr-rail-brick"].result_count = 1
  multiply_recipe_ingredients(data.raw.recipe["bbr-rail-brick"], 2)
end

-- Compatibility
require "__FreightForwarding__/compatibility/krastorio2/data-final-fixes"
