if not mods["PlutoniumEnergy"] then return end

local crating_util = require "__FreightForwarding__/prototypes/crating-util"

local items_data = {
  ["plutonium-238"] = { name = "plutonium-238", stack_size = 50, crating = 2 },
  ["plutonium-239"] = { name = "plutonium-239", stack_size = 50, crating = 2 },
  ["plutonium-fuel"] = { name = "plutonium-fuel", stack_size = 1, crating = 2 },
}

crating_util.extend_items_data(items_data)
