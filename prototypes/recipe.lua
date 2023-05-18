local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require("__bzlead__/data-util")

util.remove_prerequisite("railway", "engine")
util.add_prerequisite("railway", "ic-containerization-1")

-- Increase stone consumption for overall usage balance
bzutil.set_ingredient("rail", "stone", 4)  -- From 1
bzutil.set_ingredient("electric-furnace", "stone-brick", 20)  -- From 10

bzutil.set_ingredient("low-density-structure", "copper-plate", 10)  -- From 20

-- Rails are now used in transport science, so swap them out for uranium
bzutil.remove_ingredient("production-science-pack", "rail")
bzutil.add_ingredient("production-science-pack", "uranium-238", 3)

util.remove_prerequisite("production-science-pack", "railway")
util.add_prerequisite("production-science-pack", "uranium-processing")

-- Add lead to boats
bzutil.replace_ingredient("boat", "iron-gear-wheel", "lead-plate")
bzutil.replace_ingredient("cargo_ship", "iron-gear-wheel", "lead-plate")
bzutil.replace_ingredient("oil_tanker", "iron-gear-wheel", "lead-plate")

util.add_prerequisite("oil-processing", "tank_ship")
util.add_prerequisite("ff-dredging", "cargo_ships")

-- Add titanium to lex aircraft
bzutil.replace_ingredient("lex-flying-gunship", "steel-plate", "titanium-plate")
bzutil.replace_ingredient("lex-flying-cargo", "steel-plate", "titanium-plate")
bzutil.replace_ingredient("lex-flying-heavyship", "steel-plate", "titanium-plate")

bzutil.add_ingredient("rocket-control-unit", "ff-charged-battery-pack", 1)
util.add_prerequisite("rocket-control-unit", "ff-battery-pack")

bzutil.replace_ingredient("satellite", "accumulator", "ff-charged-battery-pack")
util.add_prerequisite("space-science-pack", "ff-battery-pack")
