-- Create item subgroups

for name, subgroup in pairs(data.raw["item-subgroup"]) do
  if subgroup.group == "intermediate-products" then
    data:extend{
      {
        type = "item-subgroup",
        name = "ff-load-" .. name,
        group = "deadlock-crates",
        order = "a[load]-" .. subgroup.order,
      },
      {
        type = "item-subgroup",
        name = "ff-unload-" .. name,
        group = "deadlock-crates",
        order = "b[unload]-" .. subgroup.order,
      },
    }
  end
end

for _, recipe in pairs(data.raw.recipe) do
  if recipe.category and recipe.category == "packing" and recipe.subgroup then
    if recipe.subgroup == "deadlock-crates-pack" then
      recipe.hide_from_player_crafting = true

      local item_name = recipe.ingredients[2][1]
      local item = data.raw.item[item_name] or data.raw.tool[item_name]

      recipe.subgroup = "ff-load-" .. item.subgroup
      recipe.order = item.order

      local crate_item = data.raw.item[recipe.result]
      crate_item.subgroup = "ff-load-" .. item.subgroup
      crate_item.order = item.order

    elseif recipe.subgroup == "deadlock-crates-unpack" then
      recipe.hide_from_player_crafting = true

      local item_name = recipe.results[2][1]
      local item = data.raw.item[item_name] or data.raw.tool[item_name]

      recipe.subgroup = "ff-unload-" .. item.subgroup
      recipe.order = item.order
    end
  end
end

-- Hardcode stone-brick since it isn't an intermediate product, but can still be put into containers
-- Move explosives/battery since they makes more sense in intermediate-product and makes space for stone-brick in raw-material
local function set_subgroup(item_name, subgroup)
  data.raw.item["deadlock-crate-" .. item_name].subgroup = "ff-load-" .. subgroup
  data.raw.recipe["deadlock-packrecipe-" .. item_name].subgroup = "ff-load-" .. subgroup
  data.raw.recipe["deadlock-unpackrecipe-" .. item_name].subgroup = "ff-unload-" .. subgroup
end

-- Probably need to clean up order strings at some point
set_subgroup("stone-brick", "raw-material")
set_subgroup("explosives", "intermediate-product")
set_subgroup("battery", "intermediate-product")
