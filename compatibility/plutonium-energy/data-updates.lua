if not mods["PlutoniumEnergy"] then return end

local util = require "__FreightForwarding__.prototypes.data-util"
local bzutil = require "__bzlead__.data-util"
local restack = util.set_stack_size

data.raw.item["plutonium-238"].order = "r[uranium-238]-[plutonium238]"
data.raw.item["plutonium-239"].order = "r[uranium-238]-[plutonium239]"

restack("MOX-fuel", 10)  -- Was 50
restack("breeder-fuel-cell", 5)  -- Was 20
restack("used-up-MOX-fuel", 10)  -- Was 50
restack("used-up-breeder-fuel-cell", 5)  -- Was 20

bzutil.add_ingredient("plutonium-atomic-bomb", "ff-titansteel-plate", 1)
util.add_prerequisite("plutonium-atomic-bomb", "ff-titansteel-processing")

data.raw.item["plutonium-fuel"].fuel_category = "advanced-chemical"
