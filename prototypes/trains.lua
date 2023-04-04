local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require("__bzlead__/data-util")

data:extend{
  {
    type = "fuel-category",
    name = "advanced-chemical"
  },
}
data.raw.item["rocket-fuel"].fuel_category = "advanced-chemical"
data.raw.item["nuclear-fuel"].fuel_category = "advanced-chemical"

-- These 2 won't get "advanced-chemical" added
data.raw["locomotive"]["mini-locomotive"].ff_no_advanced_fuel = true
if not settings.startup["ff-revert-locomotive-fuel-category"].value then
  data.raw["locomotive"]["locomotive"].burner.fuel_category = "battery"
else
  data.raw["locomotive"]["locomotive"].burner.fuel_category = nil
  data.raw["locomotive"]["locomotive"].burner.fuel_categories = {"chemical", "battery"}
end
data.raw["locomotive"]["locomotive"].burner.fuel_inventory_size = 3
data.raw["locomotive"]["locomotive"].burner.burnt_inventory_size = 3
data.raw["locomotive"]["locomotive"].burner.ff_no_double_inventory_size = true

-- Integrate mini trains, move regular trains to later in the tech tree
data.raw.technology["mini-trains"] = nil
local railway_tech = data.raw.technology["railway"]
railway_tech.icon = "__Mini_Trains__/data/icons/tech256.png"
railway_tech.icon_size = 256
bzutil.remove_recipe_effect("railway", "locomotive")
bzutil.remove_recipe_effect("railway", "cargo-wagon")
bzutil.add_unlock("railway", "mini-locomotive")
bzutil.add_unlock("railway", "mini-cargo-wagon")

local fluid_wagon_tech = data.raw.technology["fluid-wagon"]
fluid_wagon_tech.icon = "__Mini_Trains__/data/icons/fluid256.png"
fluid_wagon_tech.icon_size = 256
bzutil.remove_recipe_effect("fluid-wagon", "fluid-wagon")
bzutil.add_unlock("fluid-wagon", "mini-fluid-wagon")

data.raw.item["mini-locomotive"].subgroup = "train-transport"
data.raw.item["mini-cargo-wagon"].subgroup = "train-transport"
data.raw.item["mini-fluid-wagon"].subgroup = "train-transport"

data.raw.item["mini-locomotive"].order = "a[train-system]-ef[mini]-a[locomotive]"
data.raw.item["mini-cargo-wagon"].order = "a[train-system]-ef[mini]-b[cargo-wagon]"
data.raw.item["mini-fluid-wagon"].order = "a[train-system]-ef[mini]-c[fluid-wagon]"

bzutil.set_ingredient("mini-locomotive", "engine-unit", 15)  -- Was 5
bzutil.set_ingredient("mini-cargo-wagon", "iron-plate", 20)  -- Was 5
bzutil.set_ingredient("mini-fluid-wagon", "pipe", 4)  -- Was 20
bzutil.add_ingredient("mini-fluid-wagon", "storage-tank", 1)

data:extend{
  {
    type = "technology",
    name = "ff-advanced-railway",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/railway.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "locomotive"
      },
      {
        type = "unlock-recipe",
        recipe = "cargo-wagon"
      },
      {
        type = "unlock-recipe",
        recipe = "fluid-wagon"
      },
    },
    prerequisites = {"ff-battery-charging", "electric-engine", "fluid-wagon"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "c-g-a"
  },
}

--[[ Was
  {
    {"engine-unit", 20},
    {"electronic-circuit", 10},
    {"steel-plate", 30}
  },
]]
data.raw.recipe["locomotive"].ingredients = {
  {"electric-engine-unit", 20},
  {"advanced-circuit", 10},
  {"steel-plate", 50}
}

data.raw.recipe["cargo-wagon"].ingredients = {
  {"iron-gear-wheel", 20},
  {"iron-plate", 40},
  {"steel-plate", 40}
}

data.raw.recipe["fluid-wagon"].ingredients = {
  {"iron-gear-wheel", 20},
  {"steel-plate", 32},
  {"pipe", 16},
  {"storage-tank", 1}
}

data.raw["cargo-wagon"]["cargo-wagon"].inventory_size = 50  -- was 40, will become 5 later on