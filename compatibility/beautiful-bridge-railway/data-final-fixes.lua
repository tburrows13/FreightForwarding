if not mods["beautiful_bridge_railway_Cargoships"] then return end

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