-- Set the special item cost for each bridge to 20
if data.raw["int-setting"]["bbr-fix-cost"] then
  data.raw["int-setting"]["bbr-fix-cost"].allowed_values = {2}  -- gets multiplied by 2 in data-final-fixes
  data.raw["int-setting"]["bbr-fix-cost"].default_value = 2
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

-- Remove military science from spiderling and patrol technologies
data.raw["bool-setting"]["sp-remove-military-requirement"].forced_value = true
data.raw["bool-setting"]["sp-remove-military-requirement"].hidden = true
