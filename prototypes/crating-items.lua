local bzutil = require "__bzlead__/data-util";

local base_icon_layer = {
  icon = "__FreightForwarding__/graphics/container/container.png",
  icon_size = 64,
  icon_mipmaps = 1,
  scale = 0.5,  -- Causes them to be oversized when placed in world
}

local top_icon_layer = {
  icon = "__FreightForwarding__/graphics/container/container-top.png",
  icon_size = 64,
  icon_mipmaps = 1,
  scale = 0.5,
}

local right_corner_layer = {
  icon = "__FreightForwarding__/graphics/container/container-corner-right.png",
  icon_size = 64,
  icon_mipmaps = 1,
  scale = 0.5,
}

local left_corner_layer = {
  icon = "__FreightForwarding__/graphics/container/container-corner-left.png",
  icon_size = 64,
  icon_mipmaps = 1,
  scale = 0.5,
}

local load_base_layer = {
  icon = "__FreightForwarding__/graphics/container/load-background.png",
  icon_size = 64,
  icon_mipmaps = 1,
  scale = 0.5,
}

local unload_base_layer = {
  icon = "__FreightForwarding__/graphics/container/unload-background.png",
  icon_size = 64,
  icon_mipmaps = 1,
  scale = 0.5,
}

local arrow_layer = {
  icon = "__FreightForwarding__/graphics/container/arrow.png",
  icon_size = 64,
  icon_mipmaps = 1,
  scale = 0.5,
}

local arrow_up_layer = {
  icon = "__FreightForwarding__/graphics/container/arrow-up.png",
  icon_size = 64,
  icon_mipmaps = 1,
  scale = 0.5,
}

local function shift_icon(icon, x, y)
  icon.shift = icon.shift or {0, 0}
  icon.shift = {icon.shift[1] + x, icon.shift[2] + y}
end

local function scale_icon(icon, scale)
  icon.scale = (icon.scale or 1) * scale
end

local item_scale = 0.5

for _, recipe in pairs(data.raw.recipe) do
  if recipe.category and recipe.category == "packing" and recipe.subgroup then
    if recipe.subgroup == "deadlock-crates-pack" then
      recipe.ingredients[1][1] = "ff-container"

      recipe.icons[1] = table.deepcopy(right_corner_layer)
      scale_icon(recipe.icons[2], 1.05 * item_scale)
      shift_icon(recipe.icons[2], -4.5, -4.5)
      recipe.icons[3] = table.deepcopy(arrow_layer)
      scale_icon(recipe.icons[3], 0.8)
      shift_icon(recipe.icons[3], 4, 1)

      -- Insert mostly transparent png at base layer so that the black background is drawn in alt-mode
      table.insert(recipe.icons, 1, load_base_layer)

      local crate_item = data.raw.item[recipe.result]
      crate_item.icons[1] = table.deepcopy(base_icon_layer)
      crate_item.icons[3] = table.deepcopy(crate_item.icons[2])
      crate_item.icons[4] = table.deepcopy(crate_item.icons[2])
      shift_icon(crate_item.icons[2], 0, -10)
      shift_icon(crate_item.icons[3], 0, -4.5)
      shift_icon(crate_item.icons[4], 0, 1)
      scale_icon(crate_item.icons[2], 0.85 * item_scale)
      scale_icon(crate_item.icons[3], 0.85 * item_scale)
      scale_icon(crate_item.icons[4], 0.85 * item_scale)

      crate_item.icons[5] = table.deepcopy(top_icon_layer)

      -- Add crate_item.pictures so they are oversized on belts and ground
      crate_item.pictures = {layers = table.deepcopy(crate_item.icons)}
      for _, layer in pairs(crate_item.pictures.layers) do
        layer.filename = layer.icon
        layer.icon = nil
        layer.size = layer.icon_size
        layer.icon_size = nil
        layer.mipmap_count = layer.icon_mipmaps
        layer.icon_mipmaps = nil
        layer.shift = layer.shift or {0, 0}
        layer.shift = util.by_pixel(layer.shift[1], layer.shift[2])
      end

    elseif recipe.subgroup == "deadlock-crates-unpack" then
      recipe.results[1] = {type = "item", name = "ff-container", amount = 1, probability = 0.99}
      recipe.icons[1] = table.deepcopy(left_corner_layer)
      scale_icon(recipe.icons[2], 1.05 * item_scale)
      shift_icon(recipe.icons[2], 4.5, -4.5)
      recipe.icons[3] = table.deepcopy(arrow_up_layer)
      scale_icon(recipe.icons[3], 0.8)
      shift_icon(recipe.icons[3], -4, 0)

      table.insert(recipe.icons, 1, unload_base_layer)
    end
  end
end
