-- Setting to enable/disable deep landfill and landfill changes
local deep_landfill = {
  type = "bool-setting",
  name = "x-deep-landfill",
  setting_type = "startup",
  default_value = true,
}
data:extend{deep_landfill}

-- Set the special item cost for each bridge to 20
if data.raw["int-setting"]["bbr-fix-cost"] then
  data.raw["int-setting"]["bbr-fix-cost"].allowed_values = {20}
  data.raw["int-setting"]["bbr-fix-cost"].default_value = 20
  data.raw["int-setting"]["bbr-fix-cost"].hidden = true

  data.raw["bool-setting"]["rail-signal-on-water"].forced_value = false
  data.raw["bool-setting"]["rail-signal-on-water"].hidden = true
  data.raw["bool-setting"]["big-power-poles-on-water"].forced_value = false
  data.raw["bool-setting"]["big-power-poles-on-water"].hidden = true

end

-- Force offshore oil, no inland oil
data.raw["bool-setting"]["deep_oil"].forced_value = true
data.raw["bool-setting"]["deep_oil"].hidden = true
data.raw["bool-setting"]["no_oil_on_land"].forced_value = true
data.raw["bool-setting"]["no_oil_on_land"].hidden = true
data.raw["bool-setting"]["no_shallow_oil"].forced_value = false
data.raw["bool-setting"]["no_shallow_oil"].hidden = true
data.raw["bool-setting"]["no_oil_for_oil_rig"].forced_value = true
data.raw["bool-setting"]["no_oil_for_oil_rig"].hidden = true
data.raw["string-setting"]["oil_richness"].allowed_values = { "good" }
data.raw["string-setting"]["oil_richness"].default_value = "good"
data.raw["string-setting"]["oil_richness"].hidden = true

-- Increase oil rig storage to match oil tanker's
data.raw["int-setting"]["oil_rig_capacity"].allowed_values = { 250 }
data.raw["int-setting"]["oil_rig_capacity"].default_value = 250
data.raw["int-setting"]["oil_rig_capacity"].hidden = true

-- Hide legacy IslandStart settings (settings 2 and 3 have no effect when 1 is false)
data.raw["bool-setting"]["IslandStart-enabled"].forced_value = false
data.raw["bool-setting"]["IslandStart-enabled"].hidden = true
data.raw["string-setting"]["IslandStart-perimeter-type"].hidden = true
data.raw["bool-setting"]["IslandStart-place-override"].hidden = true

-- Increase default seed drop probability
data.raw["double-setting"]["jag-seeds-trees"].default_value = 0.04
-- Remove starting seeds
data.raw["int-setting"]["jag-starting-seeds"].allowed_values = { 0 }
data.raw["int-setting"]["jag-starting-seeds"].default_value = 0
data.raw["int-setting"]["jag-starting-seeds"].hidden = true
