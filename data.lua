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
require "__FreightForwarding__/prototypes/lex-aircraft"
require "__FreightForwarding__/prototypes/cargo-ships"
require "__FreightForwarding__/prototypes/crating-machine"
require "__FreightForwarding__/prototypes/transport-science"
require "__FreightForwarding__/prototypes/resources"
require "__FreightForwarding__/prototypes/map-gen"
require "__FreightForwarding__/prototypes/map-gen-presets"
require "__FreightForwarding__/prototypes/recipe"

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

-- Compatibility
require "__FreightForwarding__/compatibility/beautiful-bridge-railway/data"
