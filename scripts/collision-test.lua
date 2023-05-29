-- tile, entity, should_collide
local test_cases = {
  {"water", "character", true},
  {"deepwater", "character", true},
  {"water-shallow", "character", false},
  {"grass-1", "character", false},
  {"water", "pipe", true},
  {"deepwater", "pipe", true},
  {"water-shallow", "pipe", true},
  {"grass-1", "pipe", false},
  {"water", "pump", false},
  {"deepwater", "pump", false},
  {"water-shallow", "pump", false},
  {"grass-1", "pump", false},
  {"water", "iron-ore", true},
  {"deepwater", "iron-ore", true},
  {"water-shallow", "iron-ore", true},
  {"grass-1", "iron-ore", false},
  {"water", "crude-oil", true},
  {"deepwater", "crude-oil", false},
  {"water-shallow", "crude-oil", true},
  {"grass-1", "crude-oil", true},
  {"water", "deep_oil", true},
  {"deepwater", "deep_oil", false},
  {"water-shallow", "deep_oil", true},
  {"grass-1", "deep_oil", true},
  {"water", "ff-seamount", true},
  {"deepwater", "ff-seamount", false},
  {"water-shallow", "ff-seamount", true},
  {"grass-1", "ff-seamount", true},
  {"water", "ff-lava-pool-resource", true},
  {"deepwater", "ff-lava-pool-resource", true},
  {"water-shallow", "ff-lava-pool-resource", true},
  {"grass-1", "ff-lava-pool-resource", false},
  {"water", "straight-rail", true},
  {"deepwater", "straight-rail", true},
  {"water-shallow", "straight-rail", true},
  {"grass-1", "straight-rail", false},
  {"water", "straight-water-way", false},
  {"deepwater", "straight-water-way", false},
  {"water-shallow", "straight-water-way", false},
  {"grass-1", "straight-water-way", true},
  {"water", "bbr-straight-rail-iron", false},
  {"deepwater", "bbr-straight-rail-iron", true},
  {"water-shallow", "bbr-straight-rail-iron", false},
  {"grass-1", "bbr-straight-rail-iron", false},
  {"water", "indep-boat", false},
  {"deepwater", "indep-boat", false},
  {"water-shallow", "indep-boat", false},
  {"grass-1", "indep-boat", true},

}

local function run_test()
  local tiles = game.tile_prototypes
  local entities = game.entity_prototypes
  local tests_failed = 0
  local tests_passed = 0
  for _, test_case in pairs(test_cases) do
    local collides = false
    local collision_mask1 = tiles[test_case[1]].collision_mask
    local collision_mask2 = entities[test_case[2]].collision_mask
    for layer in pairs(collision_mask1) do
      if collision_mask2[layer] then
        collides = true
        break
      end
    end
    if test_case[3] and not collides then
      tests_failed = tests_failed + 1
      log("CollisionTest failed: " .. test_case[1] .. " and " .. test_case[2] .. " should collide. " .. serpent.line(collision_mask1) .. " " .. serpent.line(collision_mask2))
    elseif not test_case[3] and collides then
      tests_failed = tests_failed + 1
      log("CollisionTest failed: " .. test_case[1] .. " and " .. test_case[2] .. " should not collide. " .. serpent.line(collision_mask1) .. " " .. serpent.line(collision_mask2))
    else
      tests_passed = tests_passed + 1
    end
  end
  log("CollisionTest finished: " .. tests_passed .. " tests passed, " .. tests_failed .. " tests failed.")
end

---@type ScriptLib
local CollisionTest = {}

CollisionTest.on_init = run_test
CollisionTest.on_configuration_changed = run_test

return CollisionTest