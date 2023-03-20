if not mods["PlutoniumEnergy"] then return end

local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require "__bzlead__/data-util"

data.raw.item["plutonium-238"].order = "r[uranium-238]-[plutonium238]"
data.raw.item["plutonium-239"].order = "r[uranium-238]-[plutonium239]"
data.raw.item["MOX-fuel"].stack_size = 10  -- Was 50
data.raw.item["breeder-fuel-cell"].stack_size = 5  -- Was 20
data.raw.item["used-up-MOX-fuel"].stack_size = 10  -- Was 50
data.raw.item["used-up-breeder-fuel-cell"].stack_size = 5  -- Was 20


bzutil.add_ingredient("plutonium-atomic-bomb", "ff-titansteel-plate", 1)
util.add_prerequisite("plutonium-atomic-bomb", "ff-titansteel-processing")
