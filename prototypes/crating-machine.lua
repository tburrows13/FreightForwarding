local IC_PREFIX = "ic-containerization-"

data.raw.item["red-wire"].ic_create_container = false
data.raw.item["green-wire"].ic_create_container = false

local recipe1 = data.raw.recipe[IC_PREFIX.."machine-1"]
recipe1.ingredients = {
  {type="item", name="engine-unit", amount=2},
  {type="item", name="fast-inserter", amount=4},
  {type="item", name="steel-plate", amount=5},
}

local technology1 = data.raw.technology[IC_PREFIX.."1"]
-- Original: {"automation", "stack-inserter"}
technology1.prerequisites = {"engine", "fast-inserter"}
technology1.unit.count = 100

local recipe2 = data.raw.recipe[IC_PREFIX.."machine-2"]
recipe2.ingredients = {
  {type="item", name=IC_PREFIX.."machine-1", amount=1},
  {type="item", name="electric-engine-unit", amount=2},
  {type="item", name="stack-inserter", amount=2},
  {type="item", name="steel-plate", amount=20},
}

local technology2 = data.raw.technology[IC_PREFIX.."2"]
-- Original: {"automation-2", IC_PREFIX.."1"},
technology2.prerequisites = {"electric-engine", "stack-inserter", IC_PREFIX.."1"}
technology2.unit.count = 200

local recipe3 = data.raw.recipe[IC_PREFIX.."machine-3"]
recipe3.ingredients = {
  {type="item", name=IC_PREFIX.."machine-2", amount=1},
  {type="item", name="electric-engine-unit", amount=8},
  {type="item", name="advanced-circuit", amount=8},
  {type="item", name="steel-plate", amount=30},
}

local technology3 = data.raw.technology[IC_PREFIX.."3"]
-- Original: {"automation-3", IC_PREFIX.."2"}
technology3.prerequisites = {"automation-3", IC_PREFIX.."2"}
technology3.unit.count = 300
