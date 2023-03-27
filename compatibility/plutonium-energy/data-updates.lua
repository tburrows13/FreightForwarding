if not mods["PlutoniumEnergy"] then return end

local util = require "__FreightForwarding__/prototypes/data-util"
local bzutil = require "__bzlead__/data-util"

data.raw.item["plutonium-238"].order = "r[uranium-238]-[plutonium238]"
data.raw.item["plutonium-239"].order = "r[uranium-238]-[plutonium239]"

data.raw.item["MOX-fuel"].stack_size = 10  -- Was 50
data.raw.item["breeder-fuel-cell"].stack_size = 5  -- Was 20
data.raw.item["used-up-MOX-fuel"].stack_size = 10  -- Was 50
data.raw.item["used-up-breeder-fuel-cell"].stack_size = 5  -- Was 20


bzutil.add_ingredient("plutonium-atomic-bomb", "ff-titansteel-plate", 1)
util.add_prerequisite("plutonium-atomic-bomb", "ff-titansteel-processing")

local items_data = {
  ["plutonium-238"] = {},
  ["plutonium-239"] = {},
  ["plutonium-fuel"] = { stack_size = 1 },
}

for item_name, item in pairs(items_data) do
  if item.stack_size then 
    data.raw[item.source or "item"][item_name].stack_size = item.stack_size 
  else
    ff_restack(item_name)
  end

  deadlock_crating.add_crate_autotech(item_name, item.tech)
end
