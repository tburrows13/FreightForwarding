if mods["Krastorio2"] or mods["SpaceMod"] then return end

data:extend{
  {
    type = "technology",
    name = "ff-interstellar-communication",
    icon_size = 64,
    icon = "__FreightForwarding__/graphics/item/interstellar-communicator.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ff-interstellar-communicator"
      }
    },
    unit =
    {
      count = 2000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    prerequisites = {"space-science-pack"},
    order = "c-a"
  },
  {
    type = "item",
    name = "ff-interstellar-communicator",
    icon = "__FreightForwarding__/graphics/item/interstellar-communicator.png",
    icon_size = 64,
    pictures = {
      layers = {
        {
          size = 64,
          filename = "__FreightForwarding__/graphics/item/interstellar-communicator.png",
          scale = 0.5,
          mipmap_count = 4,
        },
        {
          draw_as_light = true,
          flags = { "light" },
          size = 64,
          filename = "__FreightForwarding__/graphics/item/interstellar-communicator-light.png",
          scale = 0.5,
          mipmap_count = 4,
        },
      },
    },
    subgroup = "space-related",
    order = "n[interstellar-communicator]",
    stack_size = 1,
    rocket_launch_products = {{type="item", name="space-science-pack", amount=1000}}
  },
  {
    type = "recipe",
    name = "ff-interstellar-communicator",
    energy_required = 20,
    enabled = false,
    category = "crafting",
    ingredients =
    {
      {type="item", name="satellite", amount=1},
      {type="item", name="low-density-structure", amount=50},
      --{type="item", name="rocket-control-unit", amount=50},
      {type="item", name="nuclear-fuel", amount=10}
    },
    results = {{type="item", name="ff-interstellar-communicator", amount=1}},
    requester_paste_multiplier = 1
  },
}
--[[
  satellite recipe:
  {"low-density-structure", 100},
  {"solar-panel", 100},
  {"accumulator", 100},
  {"radar", 5},
  {"processing-unit", 100},
  {"rocket-fuel", 50}
]]
local satellite_item = data.raw.item["satellite"]
satellite_item.rocket_launch_products = {{type="item", name="space-science-pack", amount=200}}

-- Reduce satellite cost
x_util.set_ingredient("satellite", "low-density-structure", 50)
x_util.set_ingredient("satellite", "solar-panel", 50)
x_util.set_ingredient("satellite", "accumulator", 50)  -- Will be replaced by charged battery pack
