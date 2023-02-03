local function add_ingredient(recipe_name, ingredient)
  local recipe = data.raw.recipe[recipe_name]
  if recipe.normal ~= nil then
    table.insert(recipe.normal.ingredients, ingredient)
  end
  if recipe.expensive ~= nil then
    table.insert(recipe.expensive.ingredients, ingredient)
  end
  if recipe.ingredients ~= nil then
    table.insert(recipe.ingredients, ingredient)
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

-- Add glass to deadlock lamps
--add_ingredient("deadlock-large-lamp", { "sng-glass-plate", 6 })
--add_ingredient("deadlock-floor-lamp", { "sng-glass-plate", 6 })

-- Make rails more expensive
local recipe = data.raw.recipe["rail"]
recipe.result_count = 1
--add_ingredient("rail", { "wood", 1 })
--multiply_recipe_ingredients(recipe, 2)

-- Cost 30 rails, but now rails are 2x more expensive (0.5x result_count, 1x ingredient cost, +2 wood)
local science_recipe = data.raw.recipe["production-science-pack"]
multiply_recipe_ingredients(science_recipe, 0.5, "rail")