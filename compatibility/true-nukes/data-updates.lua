if not mods["True-Nukes"] then return end

function startsWith(inputstr, start) 
  return inputstr:sub(1, #start) == start 
end

local util = require "__FreightForwarding__.prototypes.data-util"
local bzutil = require "__bzlead__.data-util"
local restack = util.set_stack_size

restack("tritium-breeder-fuel-cell", 20)  -- Was 50
restack("advanced-tritium-breeder-fuel-cell", 20)  -- Was 50
restack("plutonium-239", 50)
restack("californium", 50)
restack("TN-thermobaric-1", 20)
restack("TN-warhead-0-1--1", 10)
restack("TN-warhead-0-1--2", 10)
restack("TN-warhead-0-5--2", 10)
restack("TN-warhead-0-5--1", 10)
restack("TN-warhead-0-5--2", 10)
restack("TN-warhead-0-5--3", 10)
restack("TN-warhead-2--1", 10)
restack("TN-warhead-2--2", 10)
restack("TN-warhead-4--1", 10)
restack("TN-warhead-4--2", 10)
restack("TN-warhead-4--3", 10)
restack("TN-warhead-8--1", 10)
restack("TN-warhead-8--2", 10)

bzutil.replace_ingredient("nuclear-test-site", "steel-plate", "ff-titansteel-plate", 0.2, true)
bzutil.replace_ingredient("fusion-test-site", "steel-plate", "ff-titansteel-plate", 0.2, true)

for name, recipe in pairs(data.raw.recipe) do
  if startsWith(name, "TN-warhead") then
    local steel_count = bzutil.get_ingredient_amount(name, "steel-plate")
    if steel_count < 5 then
      bzutil.replace_ingredient(name, "steel-plate", "ff-titansteel-plate", 1)
    else
      bzutil.replace_ingredient(name, "steel-plate", "ff-titansteel-plate", 0.2, true)
    end
  end
end

util.add_prerequisite("basic-atomic-weapons", "ff-titansteel-processing")
