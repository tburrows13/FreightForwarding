local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require "__bzlead__/data-util"

-- Revert bzlead's changes to early game things that need to be built before lead is accessible
bzutil.replace_ingredient("pipe", "lead-plate", "iron-plate")
bzutil.remove_ingredient("gun-turret", "lead-plate")
bzutil.set_ingredient("gun-turret", "iron-plate", 20)
bzutil.replace_ingredient("firearm-magazine", "lead-plate", "iron-plate")
bzutil.remove_ingredient("piercing-rounds-magazine", "firearm-magazine")
bzutil.add_ingredient("piercing-rounds-magazine", "lead-plate", 4)
