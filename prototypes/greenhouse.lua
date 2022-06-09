local item = data.raw.item["jag-greenhouse"]
item.order = "d-d[greenhouse]"  -- Put after assembling machines

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

local recipe_normal = data.raw.recipe["jag-growing-normal"]

-- Decrease normal growth profit
--[[ Default
{type="item", name="wood", amount=50},
{type="item", name="jag-seeds", amount=2, probability=0.55},
]]
recipe_normal.results = {
  {type = "item", name = "wood", amount = 50},
  {type = "item", name = "jag-seeds", amount = 2, probability = 0.525},
}
