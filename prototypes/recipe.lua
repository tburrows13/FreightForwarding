local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require("__bzlead__/data-util")

util.remove_prerequisite("railway", "engine")
util.add_prerequisite("railway", "deadlock-crating-1")

-- Rails are now used in transport science, so swap them out for uranium
bzutil.remove_ingredient("production-science-pack", "rail")
bzutil.add_ingredient("production-science-pack", "uranium-238", 2)

util.remove_prerequisite("production-science-pack", "railway")
util.add_prerequisite("production-science-pack", "uranium-processing")

-- Add lead to boats
bzutil.replace_ingredient("boat", "iron-gear-wheel", "lead-plate")
bzutil.replace_ingredient("cargo_ship", "iron-gear-wheel", "lead-plate")
bzutil.replace_ingredient("oil_tanker", "iron-gear-wheel", "lead-plate")

if data.raw.recipe["ironclad"] then
  bzutil.add_ingredient("ironclad", "lead-plate", 30)
end

util.add_prerequisite("oil-processing", "tank_ship")
util.add_prerequisite("ff-dredging", "cargo_ships")

bzutil.set_ingredient("big-electric-pole", "lead-plate", 10)  -- From 2
bzutil.set_ingredient("big-electric-pole", "steel-plate", 2)  -- From 5
bzutil.set_ingredient("substation", "lead-plate", 10)  -- From 2
bzutil.set_ingredient("substation", "steel-plate", 5)  -- From 10

-- Add titanium to lex aircraft
bzutil.replace_ingredient("lex-flying-gunship", "steel-plate", "titanium-plate")
bzutil.replace_ingredient("lex-flying-cargo", "steel-plate", "titanium-plate")
bzutil.replace_ingredient("lex-flying-heavyship", "steel-plate", "titanium-plate")

bzutil.replace_ingredient("big-mining-drill", "steel-plate", "titanium-plate")
util.add_prerequisite("big-mining-drill", "titanium-processing")

bzutil.add_ingredient("rocket-control-unit", "ff-cobalt-ingot", 1)
util.add_prerequisite("rocket-control-unit", "ff-cobalt-processing")

bzutil.add_ingredient("chcs-heliostat-mirror", "ff-cobalt-ingot", 1)
bzutil.add_ingredient("chcs-solar-power-tower", "ff-cobalt-ingot", 50)
bzutil.add_ingredient("chcs-solar-laser-tower", "ff-cobalt-ingot", 50)
util.add_prerequisite("chcs-concentrated-solar-energy", "ff-cobalt-processing")
util.add_research_ingredient("chcs-concentrated-solar-energy", "utility-science-pack")
util.add_research_ingredient("chcs-weaponized-solar-energy", "utility-science-pack")

bzutil.replace_ingredient("satellite", "accumulator", "ff-battery-pack")
util.add_prerequisite("space-science-pack", "ff-battery-pack")

bzutil.add_ingredient("plutonium-atomic-bomb", "ff-titansteel-plate", 1)
util.add_prerequisite("plutonium-atomic-bomb", "ff-titansteel-processing")
