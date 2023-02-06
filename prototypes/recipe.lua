local util = require "__X-Logistics__/prototypes/data-util"
local bzutil = require("__bzlead__/data-util")

-- Rails are now used in transport science, so swap them out for uranium
bzutil.remove_ingredient("production-science-pack", "rail")
bzutil.add_ingredient("production-science-pack", "uranium-238", 2)

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

-- Move lex aicraft to lategame
util.add_prerequisite("lex-jet-engine", "hcraft-tech")
util.add_prerequisite("lex-jet-engine", "utility-science-pack")
util.remove_prerequisite("lex-jet-engine", "automobilism")
util.remove_prerequisite("lex-jet-engine", "robotics")

util.add_research_ingredient("lex-jet-engine", "utility-science-pack")
data.raw.technology["lex-jet-engine"].unit.count = 500  -- 350

util.add_research_ingredient("lex-flying-gunship-ships", "utility-science-pack")
data.raw.technology["lex-flying-gunship-ships"].unit.count = 1000  -- 500
util.add_prerequisite("lex-flying-gunship-ships", "mcraft-tech")

util.add_research_ingredient("lex-flying-cargo-ships", "utility-science-pack")
data.raw.technology["lex-flying-cargo-ships"].unit.count = 1000  -- 500
util.add_prerequisite("lex-flying-cargo-ships", "sp-spidertron-automation")

util.add_prerequisite("lex-flying-heavyship-ships", "production-science-pack")
bzutil.remove_recipe_effect("lex-flying-heavyship-ships", "spidertron-remote")

-- Make rails more expensive
local recipe = data.raw.recipe["rail"]
recipe.result_count = 1
