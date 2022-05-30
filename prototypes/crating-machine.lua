-- Convert crating machines from 3x3 to 5x5

SCALE = 1.33333

local function scale_pos(pos)
  return {pos[1] * SCALE, pos[2] * SCALE}
end

local function scale_box(box)
  return {scale_pos(box[1]), scale_pos(box[2])}
end

for tier = 1, 3 do
  local name = "deadlock-crating-machine-" .. tier
  local entity = data.raw["assembling-machine"][name]
  entity.tile_width = 4
  entity.tile_height = 4
  entity.collision_box = scale_box(entity.collision_box)
  entity.selection_box = scale_box(entity.selection_box)
  entity.animation.layers[1].scale = 1 * SCALE
  entity.animation.layers[1].hr_version.scale = 0.5 * SCALE
  entity.animation.layers[2].scale = 1 * SCALE
  entity.animation.layers[2].hr_version.scale = 0.5 * SCALE
  entity.animation.layers[3].scale = 1 * SCALE
  entity.animation.layers[3].hr_version.scale = 0.5 * SCALE
  entity.animation.layers[3].shift = scale_pos(entity.animation.layers[3].shift)
  entity.animation.layers[3].hr_version.shift = scale_pos(entity.animation.layers[3].shift)
  entity.working_visualisations[1].animation.scale = 1 * SCALE
  entity.working_visualisations[1].animation.hr_version.scale = 0.5 * SCALE
  entity.working_visualisations[1].light.scale = 0.5 * SCALE
end


local item1 = data.raw.item["deadlock-crating-machine-1"]
item1.order = "d-a[crating-machine-1]"

local recipe1 = data.raw.recipe["deadlock-crating-machine-1"]
--[[ Original:
{
	{"assembling-machine-1",1},
	{"electric-engine-unit",1},
	{"stack-inserter",2},
	{"steel-plate",20},
}]]
recipe1.ingredients = {
	{"engine-unit", 2},
	{"fast-inserter", 4},
	{"steel-plate", 5},
}

local technology1 = data.raw.technology["deadlock-crating-1"]
-- Original: {"automation", "electric-engine", "stack-inserter"}
technology1.prerequisites = {"engine", "fast-inserter"}
technology1.unit.count = 100


local item2 = data.raw.item["deadlock-crating-machine-2"]
item2.order = "d-b[crating-machine-2]"

local recipe2 = data.raw.recipe["deadlock-crating-machine-2"]
--[[ Original:
	{"deadlock-crating-machine-1",1},
	{"electric-engine-unit",1},
	{"stack-inserter",2},
	{"steel-plate",30},
]]
recipe2.ingredients = {
	{"deadlock-crating-machine-1",1},
	{"electric-engine-unit", 2},
	{"stack-inserter", 2},
	{"steel-plate", 20},
}

local technology2 = data.raw.technology["deadlock-crating-2"]
-- Original: {"automation-2", "deadlock-crating-1"},
technology2.prerequisites = {"electric-engine", "stack-inserter", "deadlock-crating-1"}
technology2.unit.count = 200


local item3 = data.raw.item["deadlock-crating-machine-3"]
item3.order = "d-c[crating-machine-3]"

local recipe3 = data.raw.recipe["deadlock-crating-machine-3"]
--[[ Original:
	{"deadlock-crating-machine-2",1},
	{"electric-engine-unit",1},
	{"stack-inserter",2},
	{"steel-plate",50},
]]
recipe3.ingredients = {
	{"deadlock-crating-machine-2", 1},
	{"electric-engine-unit", 8},
	{"advanced-circuit", 8},
	{"steel-plate", 30},
}

local technology3 = data.raw.technology["deadlock-crating-3"]
-- Original: {"automation-3", "deadlock-crating-2"}
technology3.prerequisites = {"automation-3", "deadlock-crating-2"}
technology3.unit.count = 300