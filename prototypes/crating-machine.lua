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

local recipe1 = data.raw.recipe["deadlock-crating-machine-1"]
--[[ Original:
{
	{"assembling-machine-1",1},
	{"electric-engine-unit",1},
	{"stack-inserter",2},
	{"steel-plate",20},
}]]
recipe1.ingredients = {
  {"assembling-machine-1", 1},
	{"engine-unit", 1},
	{"fast-inserter", 2},
	{"steel-plate", 20},
}

local technology1 = data.raw.technology["deadlock-crating-1"]
-- Original: {"automation", "electric-engine", "stack-inserter"}
technology1.prerequisites = {"automation", "engine", "fast-inserter"}
technology1.unit.count = 100