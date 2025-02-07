if not mods["underwater-pipes"] then return end

-- Main underwater pipe is now provided by FF, so hide it

data.raw.pipe["underwater-pipe"].hidden = true
data.raw.pipe["underwater-pipe-placer"].hidden = true
data.raw.item["underwater-pipe"].hidden = true
data.raw.recipe["underwater-pipe"].hidden = true

data.raw.recipe["underwater-pipe-to-ground"].ingredients = {
  {"ff-underwater-pipe", 20},
}

table.remove(data.raw.technology["underwater-pipes"].effects, 1)  -- Remove underwater pipe

-- Revert bztitanium's changes to underwater pipes
x_util.remove_prerequisite("underwater-pipes", "titanium-processing")
x_util.add_prerequisite("underwater-pipes", "automated_water_transport")
