if not mods["big-mining-drill"] then return end

local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require "__bzlead__/data-util"

bzutil.replace_ingredient("big-mining-drill", "steel-plate", "titanium-plate")
util.add_prerequisite("big-mining-drill", "titanium-processing")