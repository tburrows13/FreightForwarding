if not mods["aai-industry"] then return end

local crating_util = require "__FreightForwarding__/prototypes/crating-util"

local items_data = {
  ["electric-motor"] = { name = "electric-motor", stack_size = 25, crating = 2 },
  ["glass"] = { name = "glass", stack_size = 50, crating = 1 },
  ["motor"] = { name = "motor", stack_size = 25, crating = 2 },
  ["processed-fuel"] = { name = "processed-fuel", stack_size = 25, crating = 2 },
  ["sand"] = { name = "sand", stack_size = 50, crating = 1 },
  ["stone-tablet"] = { name = "stone-tablet", stack_size = 50, crating = 1 },
}

crating_util.extend_items_data(items_data)