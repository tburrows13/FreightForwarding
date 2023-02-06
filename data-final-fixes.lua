require "__FreightForwarding__/prototypes/stack-sizes"
require "__FreightForwarding__/prototypes/transport-drones"
require "__FreightForwarding__/prototypes/crating-items"

-- Science
local util = require "__FreightForwarding__/prototypes/data-util"

for _, tech in pairs(data.raw.technology) do
  local ingredients = tech.unit.ingredients
  if ingredients[3] and ingredients[3][1] == "chemical-science-pack" then
    table.insert(ingredients, 3, {"x-transport-science-pack", 1})
  else
    -- Add to all techs descending from key techs
    if util.is_descendant_of(tech.name, "fluid-handling") or
      util.is_descendant_of(tech.name, "water_transport") or
      util.is_descendant_of(tech.name, "automobilism") then
      table.insert(ingredients, {"x-transport-science-pack", 1})
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
