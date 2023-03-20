if not mods["ch-concentrated-solar"] then return end

local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require "__bzlead__/data-util"

bzutil.add_ingredient("chcs-heliostat-mirror", "ff-cobalt-ingot", 1)
bzutil.add_ingredient("chcs-solar-power-tower", "ff-cobalt-ingot", 50)
bzutil.add_ingredient("chcs-solar-laser-tower", "ff-cobalt-ingot", 50)
util.add_prerequisite("chcs-concentrated-solar-energy", "ff-cobalt-processing")
util.add_research_ingredient("chcs-concentrated-solar-energy", "utility-science-pack")
util.add_research_ingredient("chcs-weaponized-solar-energy", "utility-science-pack")
