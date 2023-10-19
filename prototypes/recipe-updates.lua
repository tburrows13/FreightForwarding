local util = require "__FreightForwarding__.prototypes.data-util"
local bzutil = require "__bzlead__.data-util"

-- Set recipes for poles touched by BZ & AAI
bzutil.set_ingredient("big-electric-pole", "lead-plate", 10)  -- From 2
bzutil.set_ingredient("big-electric-pole", "steel-plate", 2)  -- From 5
bzutil.set_ingredient("substation", "lead-plate", 10)  -- From 2
bzutil.set_ingredient("substation", "steel-plate", 5)  -- From 10

if not mods["bztin"] then
  -- Revert bzlead's changes to early game things that need to be built before lead is accessible
  bzutil.replace_ingredient("pipe", "lead-plate", "iron-plate")
  bzutil.remove_ingredient("gun-turret", "lead-plate")
  bzutil.set_ingredient("gun-turret", "iron-plate", 20)
  bzutil.replace_ingredient("firearm-magazine", "lead-plate", "iron-plate")
  bzutil.remove_ingredient("piercing-rounds-magazine", "firearm-magazine")
  bzutil.add_ingredient("piercing-rounds-magazine", "lead-plate", 5)

  -- Increase lead costs for overall usage balance
  bzutil.set_ingredient("sulfuric-acid", "lead-plate", 3)  -- From 1
  bzutil.set_ingredient("battery", "lead-plate", 2)  -- From 1
  bzutil.set_ingredient("electric-furnace", "lead-plate", 10)  -- From 4
end

-- Revert bztitanium's changes to hovercrafts
bzutil.replace_ingredient("hcraft-recipe", "titanium-plate", "steel-plate")
bzutil.remove_prerequisite("hcraft-tech", "titanium-processing")

bzutil.add_ingredient("mcraft-recipe", "titanium-plate", 20)
bzutil.add_prerequisite("mcraft-tech", "titanium-processing")
