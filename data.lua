require "__X-Logistics__/prototypes/greenhouse"
require "__X-Logistics__/prototypes/recipe"
require "__X-Logistics__/prototypes/shallow-water"
require "__X-Logistics__/prototypes/landfill"
require "__X-Logistics__/prototypes/crating-machine"
require "__X-Logistics__/prototypes/map-gen-presets"

local radar = data.raw["radar"]["radar"]
radar.max_distance_of_sector_revealed = 20
radar.energy_per_sector = "4MJ"
--[[
Vanilla radar:
  max_distance_of_sector_revealed = 14
  energy_per_sector = "10MJ"
  max_distance_of_nearby_sector_revealed = 3
  energy_per_nearby_scan = "250kJ"
]]

-- Increase selection priority of cargo ships so that they can be selected over waterway
for name, type in pairs({
  ["ironclad"] = "car",
  ["indep-boat"] = "car",
  ["boat"] = "cargo-wagon",
  ["boat_engine"] = "locomotive",
  ["cargo_ship"] = "cargo-wagon",
  ["oil_tanker"] = "fluid-wagon",
  ["cargo_ship_engine"] = "locomotive"}) do
    log(name)
    log(type)
  data.raw[type][name].selection_priority = 51
end
