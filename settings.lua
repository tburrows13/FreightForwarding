-- Force offshore oil, no inland oil
data.raw["bool-setting"]["deep_oil"].forced_value = true
data.raw["bool-setting"]["deep_oil"].hidden = true
data.raw["bool-setting"]["no_oil_on_land"].forced_value = true
data.raw["bool-setting"]["no_oil_on_land"].hidden = true
data.raw["bool-setting"]["no_shallow_oil"].forced_value = true
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

require "__FreightForwarding__/compatibility/beautiful-bridge-railway/settings"