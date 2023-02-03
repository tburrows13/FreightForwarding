require "__X-Logistics__/prototypes/stack-sizes"
require "__X-Logistics__/prototypes/transport-drones"

-- Science
local util = require "__X-Logistics__/prototypes/data-util"

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

-- Sum duplicate wood costs. Only works if wood isn't included 3 or more times.
local wood_rail_recipe = data.raw.recipe["bbr-rail-wood"]
if wood_rail_recipe then
  local ingredients = wood_rail_recipe.ingredients
  local to_delete
  local found = 0
  for i = 1, #ingredients do
    if ingredients[i][1] == "wood" then
      if found > 0 then
        ingredients[i] = {"wood", ingredients[i][2] + found}
      else
        found = ingredients[i][2]
        to_delete = i
      end
    end
  end
  if to_delete then
    table.remove(ingredients, to_delete)
  end
end