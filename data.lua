require "__FreightForwarding__/prototypes/shallow-water"
require "__FreightForwarding__/prototypes/landfill"
require "__FreightForwarding__/prototypes/titansteel"
require "__FreightForwarding__/prototypes/slag"
require "__FreightForwarding__/prototypes/lava-pool"
require "__FreightForwarding__/prototypes/battery-transport"
require "__FreightForwarding__/prototypes/seismic-scanner"
require "__FreightForwarding__/prototypes/seamount"
require "__FreightForwarding__/prototypes/dredger"
require "__FreightForwarding__/prototypes/nodule"
require "__FreightForwarding__/prototypes/cobalt"
require "__FreightForwarding__/prototypes/rail-bridge"
require "__FreightForwarding__/prototypes/lex-aircraft"
require "__FreightForwarding__/prototypes/cargo-ships"
require "__FreightForwarding__/prototypes/crating-machine"
require "__FreightForwarding__/prototypes/transport-science"
require "__FreightForwarding__/prototypes/resources"
require "__FreightForwarding__/prototypes/map-gen"
require "__FreightForwarding__/prototypes/map-gen-presets"
require "__FreightForwarding__/prototypes/recipe"

local crating_util = require "__FreightForwarding__/prototypes/crating-util"

local radar = data.raw["radar"]["radar"]
radar.max_distance_of_sector_revealed = 17  -- 35x35 chunk square
radar.energy_per_sector = "3MJ"
radar.max_distance_of_nearby_sector_revealed = 4
radar.energy_per_nearby_scan = "150kJ"

--[[
Vanilla radar:
  max_distance_of_sector_revealed = 14  -- 29x29 chunk square
  energy_per_sector = "10MJ"
  max_distance_of_nearby_sector_revealed = 3
  energy_per_nearby_scan = "250kJ"
]]

data.raw["spider-vehicle"]["lex-flying-gunship"].torso_bob_speed = 0.7
data.raw["spider-vehicle"]["lex-flying-cargo"].torso_bob_speed = 0.3
data.raw["spider-vehicle"]["lex-flying-heavyship"].torso_bob_speed = 0.45
data.raw["spider-vehicle"]["lex-flying-cargo"].chunk_exploration_radius = 6
data.raw["spider-vehicle"]["lex-flying-heavyship"].chunk_exploration_radius = 6

-- Populate FF_items_data from crating_util with vanilla+FF's items data before compatibility scripts
--[[ 
  FF_items_data: Table<ItemDataPrototype>
  ItemDataPrototype: 
  {
    name: String, mandatory, should be the internal-name of the item prototype
    [stack_size]: Number, optional, if specified, overrides item's stack_size
    [source]: String, optional, must speficy if different from "item"
    [crating]: Number, specifies the tier at wich the crate recipes are unlocked, default = 1
  }
]]
local items_data = {
  ["advanced-circuit"] = { name = "advanced-circuit", stack_size = 100, crating = 2 },
  ["automation-science-pack"] = { name = "automation-science-pack", stack_size = 100, crating = 2, source = "tool" },
  ["battery"] = { name = "battery", stack_size = 50, crating = 2 },
  ["chemical-science-pack"] = { name = "chemical-science-pack", stack_size = 100, crating = 2, source = "tool" },
  ["coal"] = { name = "coal", stack_size = 25, crating = 1 },
  ["copper-cable"] = { name = "copper-cable", stack_size = 100, crating = 2 },
  ["copper-ore"] = { name = "copper-ore", stack_size = 25, crating = 1 },
  ["copper-plate"] = { name = "copper-plate", stack_size = 50, crating = 1 },
  ["electric-engine-unit"] = { name = "electric-engine-unit", stack_size = 25, crating = 2 },
  ["electronic-circuit"] = { name = "electronic-circuit", stack_size = 100, crating = 2 },
  ["empty-barrel"] = { name = "empty-barrel", stack_size = 10, crating = 2 },
  ["engine-unit"] = { name = "engine-unit", stack_size = 25, crating = 2 },
  ["explosives"] = { name = "explosives", stack_size = 25, crating = 2 },
  ["ff-battery-pack"] = { name = "ff-battery-pack", stack_size = 50, crating = 3 },
  ["ff-charged-battery"] = { name = "ff-charged-battery", stack_size = 50, crating = 2 },
  ["ff-charged-battery-pack"] = { name = "ff-charged-battery-pack", stack_size = 50, crating = 3 },
  ["ff-cobalt-concentrate"] = { name = "ff-cobalt-concentrate", stack_size = 25, crating = 3 },
  ["ff-cobalt-ingot"] = { name = "ff-cobalt-ingot", stack_size = 50, crating = 3 },
  ["ff-cobalt-ore"] = { name = "ff-cobalt-ore", stack_size = 15, crating = 3 },
  ["ff-titansteel-plate"] = { name = "ff-titansteel-plate", stack_size = 50, crating = 3 },
  ["ff-transport-science-pack"] = { name = "ff-transport-science-pack", stack_size = 100, crating = 2, source = "tool" },
  ["flying-robot-frame"] = { name = "flying-robot-frame", stack_size = 25, crating = 3 },
  ["iron-gear-wheel"] = { name = "iron-gear-wheel", stack_size = 50, crating = 2 },
  ["iron-ore"] = { name = "iron-ore", stack_size = 25, crating = 1 },
  ["iron-plate"] = { name = "iron-plate", stack_size = 50, crating = 1 },
  ["iron-stick"] = { name = "iron-stick", stack_size = 50, crating = 2 },
  ["lead-ore"] = { name = "lead-ore", stack_size = 15, crating = 1 },
  ["lead-plate"] = { name = "lead-plate", stack_size = 50, crating = 1 },
  ["logistic-science-pack"] = { name = "logistic-science-pack", stack_size = 100, crating = 2, source = "tool" },
  ["low-density-structure"] = { name = "low-density-structure", stack_size = 10, crating = 3 },
  ["military-science-pack"] = { name = "military-science-pack", stack_size = 100, crating = 2, source = "tool" },
  ["nuclear-fuel"] = { name = "nuclear-fuel", stack_size = 1, crating = 3 },
  ["plastic-bar"] = { name = "plastic-bar", stack_size = 50, crating = 2 },
  ["processing-unit"] = { name = "processing-unit", stack_size = 100, crating = 3 },
  ["production-science-pack"] = { name = "production-science-pack", stack_size = 100, crating = 3, source = "tool" },
  ["rocket-control-unit"] = { name = "rocket-control-unit", stack_size = 10, crating = 3 },
  ["rocket-fuel"] = { name = "rocket-fuel", stack_size = 10, crating = 3 },
  ["solid-fuel"] = { name = "solid-fuel", stack_size = 25, crating = 2 },
  ["space-science-pack"] = { name = "space-science-pack", stack_size = 1000, crating = 3, source = "tool" },
  ["steel-plate"] = { name = "steel-plate", stack_size = 50, crating = 1 },
  ["stone"] = { name = "stone", stack_size = 25, crating = 1 },
  ["stone-brick"] = { name = "stone-brick", stack_size = 50, crating = 1 },
  ["sulfur"] = { name = "sulfur", stack_size = 25, crating = 2 },
  ["titanium-ore"] = { name = "titanium-ore", stack_size = 15, crating = 2 },
  ["titanium-plate"] = { name = "titanium-plate", stack_size = 50, crating = 2 },
  ["uranium-235"] = { name = "uranium-235", stack_size = 50, crating = 2 },
  ["uranium-238"] = { name = "uranium-238", stack_size = 50, crating = 2 },
  ["uranium-ore"] = { name = "uranium-ore", stack_size = 15, crating = 2 },
  ["utility-science-pack"] = { name = "utility-science-pack", stack_size = 100, crating = 3, source = "tool" },
  ["wood"] = { name = "wood", stack_size = 50, crating = 1 },
}

crating_util.extend_items_data(items_data)

-- Compatibility
require "__FreightForwarding__/compatibility/aai-industry/data"
--require "__FreightForwarding__/compatibility/krastorio2/data"
require "__FreightForwarding__/compatibility/plutonium-energy/data"
