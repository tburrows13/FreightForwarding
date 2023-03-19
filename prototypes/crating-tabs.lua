if not settings.startup["ff-enable-split-tabs"].value then return end

data:extend({
  -- Pack Group
  {
    name = "deadlock-crates",
    order = "z-1",
    type = "item-group",
    localised_name = "Pack containers",
    icon_size = 128,
    icons = {
      {
        icon = "__DeadlockCrating__/graphics/icons/square/crating-icon-base-128.png"
      },
      {
        icon = "__DeadlockCrating__/graphics/icons/square/crating-icon-mask-128.png",
        tint = {
          b = 80,
          g = 180,
          r = 210
        }
      },
      {
        icon = "__FreightForwarding__/graphics/container/arrow.png",
        icon_size = 64,
        icon_mipmaps = 1,
        scale = 1.6,
        shift = {0, 0}
      }
    },
  },
  -- Unpack Group
  {
    name = "deadlock-crates-unpack-group",
    order = "z-2",
    type = "item-group",
    localised_name = "Unpack containers",
    icon_size = 128,
    icons = {
      {
        icon = "__DeadlockCrating__/graphics/icons/square/crating-icon-base-128.png"
      },
      {
        icon = "__DeadlockCrating__/graphics/icons/square/crating-icon-mask-128.png",
        tint = {
          b = 80,
          g = 180,
          r = 210
        }
      },
      {
        icon = "__FreightForwarding__/graphics/container/arrow-up.png",
        icon_size = 64,
        icon_mipmaps = 1,
        scale = 1.6,
        shift = {0, 0}
      }
    },
  },
})

-- Override subgroups' group
for _, subgroup in pairs(data.raw["item-subgroup"]) do
  if subgroup.name:match("ff%-unload") then
    subgroup.group = "deadlock-crates-unpack-group"
  end
end
-- Override recipes' group
for _, recipe in pairs(data.raw.recipe) do
  if recipe.name:match("deadlock-unpackrecipe") then
    recipe.group = "deadlock-crates-unpack-group"
  end
end