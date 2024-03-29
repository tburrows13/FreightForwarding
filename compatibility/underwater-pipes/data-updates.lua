if not mods["underwater-pipes"] then return end

local util = require "__FreightForwarding__.prototypes.data-util"

-- Main underwater pipe is now provided by FF, so hide it

table.insert(data.raw.pipe["underwater-pipe"].flags, "hidden")
table.insert(data.raw.pipe["underwater-pipe-placer"].flags, "hidden")
data.raw.item["underwater-pipe"].flags = {"hidden"}
data.raw.recipe["underwater-pipe"].hidden = true

data.raw.recipe["underwater-pipe-to-ground"].ingredients = {
  {"ff-underwater-pipe", 20},
}

table.remove(data.raw.technology["underwater-pipes"].effects, 1)  -- Remove underwater pipe

-- Revert bztitanium's changes to underwater pipes
util.remove_prerequisite("underwater-pipes", "titanium-processing")
util.add_prerequisite("underwater-pipes", "automated_water_transport")
