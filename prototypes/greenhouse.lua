local item = data.raw.item["jag-greenhouse"]
item.order = "d-a[greenhouse]"

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