local item = data.raw.item["jag-greenhouse"]
item.order = "d-d[greenhouse]"

-- Lock wood growth behind research
for _, recipe in pairs({"jag-greenhouse", "jag-growing-normal", "jag-growing-fast", "jag-growing-breed"}) do
  data.raw.recipe[recipe].enabled = false
end

local technology = {
  type = "technology",
  name = "x-greenhouse",
  icon_size = 320, icon_mipmaps = 1,
  icon = "__just-another-greenhouse__/graphics/entity/greenhouse-on.png",
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "jag-greenhouse"
    },
    {
      type = "unlock-recipe",
      recipe = "jag-growing-normal"
    },
    {
      type = "unlock-recipe",
      recipe = "jag-growing-fast"
    },
    {
      type = "unlock-recipe",
      recipe = "jag-growing-breed"
    },
  },
  prerequisites = {"automation"},
  unit =
  {
    count = 10,
    ingredients = {{"automation-science-pack", 1}},
    time = 10
  },
  order = "a-c-a"
}

data:extend{technology}

-- Improve wood recipe icons
local speed_icon = {
  icon = "__core__/graphics/icons/technology/effect-constant/effect-constant-movement-speed.png",
  icon_size = 64,
  mipmap_count = 2,
}

local wood = data.raw.item["wood"]
local wood_icon = {
  icon = wood.icon,
  icon_size = wood.icon_size,
  icon_mipmaps = wood.icon_mipmaps,
}

local seed_icon = {
  icon = "__just-another-greenhouse__/graphics/icons/seeds.png",
  icon_size = 64,
}

local recipe_normal = data.raw.recipe["jag-growing-normal"]
recipe_normal.icons = {wood_icon}
local recipe_fast = data.raw.recipe["jag-growing-fast"]
recipe_fast.icons = {wood_icon, speed_icon}
local recipe_breed = data.raw.recipe["jag-growing-breed"]
recipe_breed.icons = {seed_icon}

-- Add more luck to normal growth
--[[ Default
{type="item", name="wood", amount=50},
{type="item", name="jag-seeds", amount=1},
{type="item", name="jag-seeds", amount=1, probability=0.05},
]]
recipe_normal.results = {
  {type = "item", name = "wood", amount = 50},
  {type = "item", name = "jag-seeds", amount = 2, probability = 0.525},
}
