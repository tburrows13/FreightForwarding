local util = require "__X-Logistics__/prototypes/data-util"
local bzutil = require "__bzlead__/data-util";

-- Revert bzlead's changes to early game things that need to be built before lead is accessible
bzutil.replace_ingredient("pipe", "lead-plate", "iron-plate")
bzutil.replace_ingredient("gun-turret", "lead-plate", "iron-plate")
bzutil.replace_ingredient("firearm-magazine", "lead-plate", "iron-plate")
bzutil.remove_ingredient("piercing-rounds-magazine", "firearm-magazine")
bzutil.add_ingredient("piercing-rounds-magazine", "lead-plate", 4)

-- Revert bztitanium's changes to underwater pipes
if mods["underwater-pipes"] then
  util.remove_prerequisite("underwater-pipes", "titanium-processing")
  util.add_prerequisite("underwater-pipes", "automated_water_transport")
  data.raw.recipe["underwater-pipe"].ingredients = {
    { "pipe", 2 },
    { "steel-plate", 5 },
    { "concrete", 20 },
  }
end
