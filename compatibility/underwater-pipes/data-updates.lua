if not mods["underwater-pipes"] then return end

local util = require "__FreightForwarding__.prototypes.data-util"

-- Revert bztitanium's changes to underwater pipes
util.remove_prerequisite("underwater-pipes", "titanium-processing")
util.add_prerequisite("underwater-pipes", "automated_water_transport")
data.raw.recipe["underwater-pipe"].ingredients = {
  { "pipe", 2 },
  { "steel-plate", 5 },
  { "concrete", 20 },
}