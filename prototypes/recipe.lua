local util = require "__X-Logistics__/prototypes/data-util"
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

bzutil.set_ingredient("big-electric-pole", "lead-plate", 5)  -- From 2
bzutil.set_ingredient("big-electric-pole", "steel-plate", 3)  -- From 5

-- Add titanium to lex aircraft
bzutil.replace_ingredient("lex-flying-gunship", "steel-plate", "titanium-plate")
bzutil.replace_ingredient("lex-flying-cargo", "steel-plate", "titanium-plate")
bzutil.replace_ingredient("lex-flying-heavyship", "steel-plate", "titanium-plate")

-- Gets removed by Spidertron Patrols 'peaceful mode'
util.add_research_ingredient("spidertron", "military-science-pack")

-- Make rails more expensive
local recipe = data.raw.recipe["rail"]
recipe.result_count = 1
