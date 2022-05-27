require "prototypes.stack-sizes"
require "prototypes.inventory-sizes"

local wood_rail_recipe = data.raw.recipe["bbr-rail-wood"]
if wood_rail_recipe then
  local ingredients = wood_rail_recipe.ingredients
  for i = 1, #ingredients do
    if ingredients[i][1] == "wood" then
      ingredients[i] = nil
      break
    end
  end
end