x_util.remove_prerequisite("railway", "engine")
x_util.add_prerequisite("railway", "ic-containerization-1")

-- Increase stone consumption for overall usage balance
x_util.set_ingredient("rail", "stone", 4)  -- From 1
x_util.set_ingredient("electric-furnace", "stone-brick", 20)  -- From 10

x_util.set_ingredient("low-density-structure", "copper-plate", 10)  -- From 20

-- Rails are now used in transport science, so swap them out for uranium
x_util.remove_ingredient("production-science-pack", "rail")
x_util.add_ingredient("production-science-pack", "uranium-238", 3)

x_util.remove_prerequisite("production-science-pack", "railway")
x_util.add_prerequisite("production-science-pack", "uranium-processing")

-- Add lead to boats
x_util.replace_ingredient("boat", "iron-gear-wheel", "lead-plate")
x_util.replace_ingredient("cargo_ship", "iron-gear-wheel", "lead-plate")
x_util.replace_ingredient("oil_tanker", "iron-gear-wheel", "lead-plate")

x_util.add_prerequisite("oil-processing", "tank_ship")
x_util.add_prerequisite("ff-dredging", "cargo_ships")

-- Add titanium to lex aircraft
x_util.replace_ingredient("lex-flying-gunship", "steel-plate", "titanium-plate")
x_util.replace_ingredient("lex-flying-cargo", "steel-plate", "titanium-plate")
x_util.replace_ingredient("lex-flying-heavyship", "steel-plate", "titanium-plate")

x_util.add_ingredient("rocket-control-unit", "ff-charged-battery-pack", 1)
x_util.add_prerequisite("rocket-control-unit", "ff-battery-pack")

x_util.replace_ingredient("satellite", "accumulator", "ff-charged-battery-pack")
x_util.add_prerequisite("space-science-pack", "ff-battery-pack")
