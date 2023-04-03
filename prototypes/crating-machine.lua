local IC_PREFIX = "ic-containerization-"

data.raw.item["red-wire"].ic_create_container = false
data.raw.item["green-wire"].ic_create_container = false

local recipe1 = data.raw.recipe[IC_PREFIX.."machine-1"]
recipe1.ingredients = {
  {"engine-unit", 2},
  {"fast-inserter", 4},
  {"steel-plate", 5},
}

local technology1 = data.raw.technology[IC_PREFIX.."1"]
-- Original: {"automation", "stack-inserter"}
technology1.prerequisites = {"engine", "fast-inserter"}
technology1.unit.count = 100

local recipe2 = data.raw.recipe[IC_PREFIX.."machine-2"]
recipe2.ingredients = {
  {IC_PREFIX.."machine-1", 1},
  {"electric-engine-unit", 2},
  {"stack-inserter", 2},
  {"steel-plate", 20},
}

local technology2 = data.raw.technology[IC_PREFIX.."2"]
-- Original: {"automation-2", IC_PREFIX.."1"},
technology2.prerequisites = {"electric-engine", "stack-inserter", IC_PREFIX.."1"}
technology2.unit.count = 200

local recipe3 = data.raw.recipe[IC_PREFIX.."machine-3"]
recipe3.ingredients = {
  {IC_PREFIX.."machine-2", 1},
  {"electric-engine-unit", 8},
  {"advanced-circuit", 8},
  {"steel-plate", 30},
}

local technology3 = data.raw.technology[IC_PREFIX.."3"]
-- Original: {"automation-3", IC_PREFIX.."2"}
technology3.prerequisites = {"automation-3", IC_PREFIX.."2"}
technology3.unit.count = 300
