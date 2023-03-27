if not mods["aai-industry"] then return end

local items_data = {
  ["electric-motor"] = {},
  ["glass"] = {},
  ["motor"] = {},
  ["processed-fuel"] = {},
  ["sand"] = {},
  ["stone-tablet"] = {},
}

for item_name, item in pairs(items_data) do
  if item.stack_size then 
    data.raw[item.source or "item"][item_name].stack_size = item.stack_size 
  else
    ff_restack(item_name)
  end

  deadlock_crating.add_crate_autotech(item_name, item.tech)
end