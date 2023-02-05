local bzutil = require("__bzlead__.data-util");

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

-- Make rails more expensive
local recipe = data.raw.recipe["rail"]
recipe.result_count = 1
