if not mods["aai-industry"] then return end

local TIER_1 = "ic-containerization-1"
local TIER_2 = "ic-containerization-2"
local TIER_3 = "ic-containerization-3"

local items_data = {
  ["electric-motor"] = { tech = TIER_2 },
  ["glass"] = {},
  ["motor"] = { tech = TIER_2 },
  ["processed-fuel"] = {},
  ["sand"] = {},
  ["stone-tablet"] = {},
}
--[[
for item_name, item in pairs(items_data) do
  if item.stack_size then 
    data.raw[item.source or "item"][item_name].stack_size = item.stack_size 
  else
    ff_restack(item_name)
  end

  deadlock_crating.add_crate_autotech(item_name, item.tech)
end]]