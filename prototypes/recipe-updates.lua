-- Set recipes for poles touched by BZ & AAI
x_util.set_ingredient("big-electric-pole", "lead-plate", 10)  -- From 2
x_util.set_ingredient("big-electric-pole", "steel-plate", 2)  -- From 5
x_util.set_ingredient("substation", "lead-plate", 10)  -- From 2
x_util.set_ingredient("substation", "steel-plate", 5)  -- From 10

if not mods["bztin"] then
  -- Revert bzlead's changes to early game things that need to be built before lead is accessible
  x_util.replace_ingredient("pipe", "lead-plate", "iron-plate")
  x_util.remove_ingredient("gun-turret", "lead-plate")
  x_util.set_ingredient("gun-turret", "iron-plate", 20)
  x_util.replace_ingredient("firearm-magazine", "lead-plate", "iron-plate")
  x_util.remove_ingredient("piercing-rounds-magazine", "firearm-magazine")
  x_util.add_ingredient("piercing-rounds-magazine", "lead-plate", 5)

  -- Increase lead costs for overall usage balance
  x_util.set_ingredient("sulfuric-acid", "lead-plate", 3)  -- From 1
  x_util.set_ingredient("battery", "lead-plate", 2)  -- From 1
  x_util.set_ingredient("electric-furnace", "lead-plate", 10)  -- From 4
end

-- Revert bztitanium's changes to hovercrafts
x_util.replace_ingredient("hcraft-recipe", "titanium-plate", "steel-plate")
x_util.remove_prerequisite("hcraft-tech", "titanium-processing")

x_util.add_ingredient("mcraft-recipe", "titanium-plate", 20)
x_util.add_prerequisite("mcraft-tech", "titanium-processing")
