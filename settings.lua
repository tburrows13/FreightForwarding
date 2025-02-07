data:extend{
  {
    type = "bool-setting",
    name = "ff-disable-default-sims",
    order = "a",
    setting_type = "startup",
    default_value = true
  },
}

local function force_setting(setting_type, setting_name, value)
  local setting = data.raw[setting_type .. "-setting"][setting_name]
  if setting then
    if setting_type == "bool" then
      setting.forced_value = value
    else
      setting.allowed_values = { value }
    end
    setting.default_value = value
    setting.hidden = true
  end
end

-- Intermodal Containers
force_setting("string", "ic-machine-size", "4×4")
force_setting("double", "ic-stack-size-multiplier", 0.5)
force_setting("double", "ic-stacks-per-container", 20)
force_setting("int", "ic-container-stack-size", 1)
force_setting("double", "ic-cargo-wagon-inventory-multiplier", 1)  -- Handled in our own inventory-sizes.lua
force_setting("double", "ic-belts-per-machine", 1)
force_setting("double", "ic-container-loss-chance", 0.01)

-- Force offshore oil, no inland oil
force_setting("bool", "deep_oil", true)
force_setting("bool", "no_oil_on_land", true)
force_setting("bool", "no_shallow_oil", true)
force_setting("bool", "no_oil_for_oil_rig", true)
force_setting("string", "oil_richness", "good")
force_setting("string", "oil_rigs_require_external_power", "disabled")

-- Reduce tanker capacity from 250k to 200k
force_setting("int", "tanker_capacity", 200)
force_setting("double", "fuel_modifier", 2)

-- Increase oil rig storage to match oil tanker's
--force_setting("int", "oil_rig_capacity", 250)

-- Remove military science from spiderling and patrol technologies
force_setting("bool", "sp-remove-military-requirement", true)

-- Ensure missile hovercraft exists
force_setting("bool", "enable-mcraft", true)

-- Lex's Aircraft
-- Hide light gunship settings, ensure all ships support logistics requests
data.raw["double-setting"]["lex-flying-gunship-speed-settings"].hidden = true
data.raw["int-setting"]["lex-gunship-inventory-size-settings"].hidden = true
force_setting("int", "lex-flying-cargo-trash-inventory-size-settings", 20)
force_setting("int", "lex-gunship-trash-inventory-size-settings", 10)
force_setting("int", "lex-flying-heavyship-trash-inventory-size-settings", 10)

-- BZ hide extra options
force_setting("bool", "bzlead-byproduct", true)
force_setting("string", "bzlead-more-entities", "no")
force_setting("string", "bzlead-more-ammo", "no")
force_setting("string", "bztitanium-mining-fluid", "lubricant")
force_setting("int", "bztitanium-mining-fluid-amount", 3)

require "__FreightForwarding__.compatibility.beautiful-bridge-railway.settings"
require "__FreightForwarding__.compatibility.krastorio2.settings"
