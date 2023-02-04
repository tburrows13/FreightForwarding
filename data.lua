require "__X-Logistics__/prototypes/recipe"
require "__X-Logistics__/prototypes/shallow-water"
require "__X-Logistics__/prototypes/landfill"
require "__X-Logistics__/prototypes/rail-bridge"
require "__X-Logistics__/prototypes/crating-machine"
require "__X-Logistics__/prototypes/transport-science"
require "__X-Logistics__/prototypes/map-gen"
require "__X-Logistics__/prototypes/map-gen-presets"

local radar = data.raw["radar"]["radar"]
radar.max_distance_of_sector_revealed = 22  -- 45x45 chunk square
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
