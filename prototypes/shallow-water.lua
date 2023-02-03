if mods["alien-biomes"] then return end

local mud_water = data.raw.tile["water-mud"]
mud_water.walking_speed_modifier = 0.7  -- Default 0.8
mud_water.vehicle_friction_modifier = 32

local shallow_water = data.raw.tile["water-shallow"]
shallow_water.walking_speed_modifier = 0.7  -- Default 0.8
shallow_water.vehicle_friction_modifier = 32  -- Default 1

shallow_water.collision_mask = {
  "water-tile",
  "floor-layer",
  "resource-layer",
  "doodad-layer",  -- Stops decoratives spawning on shallow water
}

-- max_elevation, influence
-- Water:     autoplace = make_water_autoplace_settings(0, 100),
-- Deepwater: autoplace = make_water_autoplace_settings(-2, 200),


data.raw["tile"]["water-shallow"].autoplace = make_water_autoplace_settings(0, 25)
-- data.raw["tile"]["water-mud"].autoplace = make_water_autoplace_settings(-2, 50)
data.raw["tile"]["water"].autoplace = make_water_autoplace_settings(-1, 100)
data.raw["tile"]["deepwater"].autoplace = make_water_autoplace_settings(-4, 200)