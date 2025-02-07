data:extend{
  {
    type = "fuel-category",
    name = "advanced-chemical"
  },
}
data.raw.item["rocket-fuel"].fuel_category = "advanced-chemical"
data.raw.item["nuclear-fuel"].fuel_category = "advanced-chemical"

local locomotive = data.raw["locomotive"]["locomotive"]

-- These 2 won't get "advanced-chemical" added
data.raw["locomotive"]["mini-locomotive"].ff_no_advanced_fuel = true
  locomotive.energy_source.fuel_categories = {"battery"}
locomotive.energy_source.fuel_inventory_size = 3
locomotive.energy_source.burnt_inventory_size = 3
locomotive.energy_source.ff_no_double_inventory_size = true

--locomotive.friction_force = 0.30  -- Was 0.50
--locomotive.air_resistance = 0.0050 -- Was 0.0075

-- Integrate mini trains, move regular trains to later in the tech tree
data.raw.technology["mini-trains"] = nil
local railway_tech = data.raw.technology["railway"]
railway_tech.icon = "__Mini_Trains__/data/icons/tech256.png"
railway_tech.icon_size = 256
x_util.remove_recipe_effect("railway", "locomotive")
x_util.remove_recipe_effect("railway", "cargo-wagon")
x_util.add_unlock("railway", "mini-locomotive")
x_util.add_unlock("railway", "mini-cargo-wagon")

local fluid_wagon_tech = data.raw.technology["fluid-wagon"]
fluid_wagon_tech.icon = "__Mini_Trains__/data/icons/fluid256.png"
fluid_wagon_tech.icon_size = 256
x_util.remove_recipe_effect("fluid-wagon", "fluid-wagon")
x_util.add_unlock("fluid-wagon", "mini-fluid-wagon")

data.raw.item["mini-locomotive"].subgroup = "train-transport"
data.raw.item["mini-cargo-wagon"].subgroup = "train-transport"
data.raw.item["mini-fluid-wagon"].subgroup = "train-transport"

data.raw.item["mini-locomotive"].order = "a[train-system]-ef[mini]-a[locomotive]"
data.raw.item["mini-cargo-wagon"].order = "a[train-system]-ef[mini]-b[cargo-wagon]"
data.raw.item["mini-fluid-wagon"].order = "a[train-system]-ef[mini]-c[fluid-wagon]"

x_util.set_ingredient("mini-locomotive", "engine-unit", 15)  -- Was 5
x_util.set_ingredient("mini-cargo-wagon", "iron-plate", 20)  -- Was 5
x_util.set_ingredient("mini-fluid-wagon", "pipe", 4)  -- Was 20
x_util.add_ingredient("mini-fluid-wagon", "storage-tank", 1)

data:extend{
  {
    type = "technology",
    name = "ff-advanced-railway",
    icon_size = 256,
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
    {type="item", name="engine-unit", amount=20},
    {type="item", name="electronic-circuit", amount=10},
    {type="item", name="steel-plate", amount=30}
  },
]]
data.raw.recipe["locomotive"].ingredients = {
  {type="item", name="electric-engine-unit", amount=20},
  {type="item", name="advanced-circuit", amount=10},
  {type="item", name="steel-plate", amount=50}
}

data.raw.recipe["cargo-wagon"].ingredients = {
  {type="item", name="iron-gear-wheel", amount=20},
  {type="item", name="iron-plate", amount=40},
  {type="item", name="steel-plate", amount=40}
}

data.raw.recipe["fluid-wagon"].ingredients = {
  {type="item", name="iron-gear-wheel", amount=20},
  {type="item", name="steel-plate", amount=32},
  {type="item", name="pipe", amount=16},
  {type="item", name="storage-tank", amount=1}
}

data.raw["cargo-wagon"]["cargo-wagon"].inventory_size = 50  -- was 40, will become 5 later on