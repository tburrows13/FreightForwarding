local tests_failed = 0
local tests_passed = 0

-- tile, entity, should_collide
local tile_tests = {
  -- name, grass, shallow, regular, deep
  {"character", false, false, false, false},
  {"small-biter", false, false, true, true},
  {"biter-spawner", false, true, true, true},
  {"car", false, false, true, true},
  {"pipe", false, true, true, true},
  {"pump", false, false, false, false},
  {"iron-ore", false, true, true, true},
  {"crude-oil", true, true, true, false},
  --{"deep_oil", true, true, true, true},  -- doesn't really matter since script-created
  {"ff-underwater-pipe", true, false, false, false},
  {"ff-offshore-storage-tank", true, false, false, false},
  {"ff-seamount", true, true, true, false},
  {"ff-lava-pool-resource", false, true, true, true},
  {"ff-rocket-silo-hole", false, true, true, true},
  {"straight-rail", false, true, true, true},
  {"straight-water-way", true, false, false, false},
  {"bbr-straight-rail-iron", false, false, false, true},
  {"indep-boat", true, false, false, false},
}

local entity_tests = {
  {"character", {"straight-water-way", "ff-underwater-pipe"}, false},
  {"character", {"pump", "ff-offshore-storage-tank", "assembling-machine-1", "ic-containerization-machine-1"}, true},
  {"indep-boat", {"straight-water-way", "ff-underwater-pipe", "buoy", "chain_buoy", "port", "pump"}, false},
  {"indep-boat", {"ff-seamount", "ff-offshore-storage-tank", "oil_rig"}, true},
  {"straight-water-way", {"ff-underwater-pipe"}, false},
  {"straight-water-way", {"ff-offshore-storage-tank", "pump"}, true},
  {"pump", {"ff-underwater-pipe", "ff-offshore-storage-tank"}, true},
  {"ff-underwater-pipe", {"hovercraft"}, false},
  {"ff-underwater-pipe", {"oil_rig", "ff-offshore-storage-tank"}, true},
  {"ff-rocket-silo-hole", {"ff-rocket-silo-dummy"}, false},
  {"ff-rocket-silo-hole", {"stone-furnace", "character"}, true},
}

local function test_collision(mask1, mask2, name1, name2, should_collide)
  local collides = false
  for layer in pairs(mask1) do
    if mask2[layer] then
      collides = true
      break
    end
  end
  if should_collide and not collides then
    tests_failed = tests_failed + 1
    log("CollisionTest failed: " .. name1 .. " and " .. name2 .. " should collide. " .. serpent.line(mask1) .. " | " .. serpent.line(mask2))
  elseif not should_collide and collides then
    tests_failed = tests_failed + 1
    log("CollisionTest failed: " .. name1 .. " and " .. name2 .. " should not collide. " .. serpent.line(mask1) .. " | " .. serpent.line(mask2))
  else
    tests_passed = tests_passed + 1
  end
end

local function test_tile_collisions()
  local tiles = prototype.tile
  local entities = prototype.entity

  local grass_mask = tiles["grass-1"].collision_mask
  local shallow_mask = tiles["water-shallow"].collision_mask
  local regular_mask = tiles["water"].collision_mask
  local deep_mask = tiles["deepwater"].collision_mask

  for _, test_case in pairs(tile_tests) do
    local entity_name = test_case[1]
    local entity = entities[entity_name]
    if entity then
      local mask1 = entity.collision_mask
      test_collision(mask1, grass_mask, entity_name, "grass-1", test_case[2])
      test_collision(mask1, shallow_mask, entity_name, "water-shallow", test_case[3])
      test_collision(mask1, regular_mask, entity_name, "water", test_case[4])
      test_collision(mask1, deep_mask, entity_name, "deepwater", test_case[5])
    end
  end
end

local function test_entity_collisions()
  local entities = prototype.entity

  for _, test_case in pairs(entity_tests) do
    local entity_name = test_case[1]
    local entity1 = entities[entity_name]
    if entity1 then
      local mask1 = entity1.collision_mask
      for _, other_entity_name in pairs(test_case[2]) do
        local entity2 = entities[other_entity_name]
        if entity2 then
          local mask2 = entity2.collision_mask
          test_collision(mask1, mask2, entity_name, other_entity_name, test_case[3])
        end
      end
    end
  end
end

local function run_test()
  test_tile_collisions()
  test_entity_collisions()
  log("CollisionTest finished: " .. tests_passed .. " tests passed, " .. tests_failed .. " tests failed.")
end

---@type ScriptLib
local CollisionTest = {}

CollisionTest.on_init = run_test
CollisionTest.on_configuration_changed = run_test

return CollisionTest