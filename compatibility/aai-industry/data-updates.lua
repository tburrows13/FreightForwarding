if not mods["aai-industry"] then return end

local items_data = {
  ["electric-motor"] = { name = "electric-motor", stack_size = 25, crating = 2 },
  ["glass"] = { name = "glass", stack_size = 50, crating = 1 },
  ["motor"] = { name = "motor", stack_size = 25, crating = 2 },
  ["processed-fuel"] = { name = "processed-fuel", stack_size = 25, crating = 2 },
  ["sand"] = { name = "sand", stack_size = 50, crating = 1 },
  ["stone-tablet"] = { name = "stone-tablet", stack_size = 50, crating = 1 },
}

for ___, item in pairs(items_data) do
  if item.stack_size then data.raw[item.source or "item"][item.name].stack_size = item.stack_size end
  deadlock_crating.add_crate(item.name, "ic-containerization-"..item.crating)
end