local function force_setting(setting_type, setting_name, value)
  local setting = data.raw[setting_type .. "-setting"][setting_name]
  if setting_type == "bool" then
    setting.forced_value = value
  else
    setting.allowed_values = { value }
  end
  setting.default_value = value
  setting.hidden = true
end

-- Intermodal Containers
force_setting("string", "ic-machine-size", "4×4")
force_setting("double", "ic-stacks-per-container", 20)
force_setting("int", "ic-container-stack-size", 1)
force_setting("double", "ic-cargo-wagon-inventory-multiplier", 1)  -- Handled in our own inventory-sizes.lua
force_setting("double", "ic-belts-per-machine", 1)
force_setting("double", "ic-container-loss-rate", 0.01)

-- Force offshore oil, no inland oil
force_setting("bool", "deep_oil", true)
force_setting("bool", "no_oil_on_land", true)
force_setting("bool", "no_shallow_oil", true)
force_setting("bool", "no_oil_for_oil_rig", true)
force_setting("string", "oil_richness", "good")

-- Increase oil rig storage to match oil tanker's
force_setting("int", "oil_rig_capacity", 250)

-- Remove military science from spiderling and patrol technologies
force_setting("bool", "sp-remove-military-requirement", true)

require "__FreightForwarding__/compatibility/beautiful-bridge-railway/settings"
require "__FreightForwarding__/compatibility/krastorio2/settings"
