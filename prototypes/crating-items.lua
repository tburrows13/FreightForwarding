local bzutil = require "__bzlead__/data-util";

local base_icon_layer = {
  icon = "__base__/graphics/icons/steel-chest.png",
  icon_size = 64,
  icon_mipmaps = 4,
  scale = 0.5,
}

for _, recipe in pairs(data.raw.recipe) do
  if recipe.category and recipe.category == "packing" and recipe.subgroup then
    if recipe.subgroup == "deadlock-crates-pack" then
      recipe.ingredients[1][1] = "ff-container"
      recipe.icons[1] = base_icon_layer

      local crate_item = data.raw.item[recipe.result]
      crate_item.icons[1] = base_icon_layer

    elseif recipe.subgroup == "deadlock-crates-unpack" then
      recipe.results[1] = {type = "item", name = "ff-container", amount = 1, probability = 0.99}
      recipe.icons[1] = base_icon_layer
    end
  end
end
