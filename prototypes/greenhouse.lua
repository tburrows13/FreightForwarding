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
local recipe_fast = data.raw.recipe["jag-growing-fast"]
local recipe_breed = data.raw.recipe["jag-growing-breed"]

recipe_normal.energy_required = 120  -- was 600
recipe_normal.results = {
  {type = "item", name = "wood", amount = 50},
  {type = "item", name = "jag-seeds", amount = 2, probability = 0.55},
}

recipe_fast.energy_required = 60  -- was 300
recipe_fast.ingredients = {
  {type = "item", name = "jag-seeds", amount = 1},
  {type = "fluid", name = "water", amount = 200},  -- Was 110
}
recipe_fast.results = {
  {type = "item", name = "wood", amount = 80},  -- Was 50
  {type = "item", name = "jag-seeds", amount = 1, probability = 0.4},
}

recipe_breed.energy_required = 180  -- was 600
recipe_breed.results = {
  {type = "item", name = "wood", amount = 20},
  {type = "item", name = "jag-seeds", amount = 2},
  {type = "item", name = "jag-seeds", amount = 1, probability = 0.5},  -- Was 0.4
}
