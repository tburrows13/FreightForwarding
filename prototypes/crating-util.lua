local bzutil = require "__bzlead__/data-util";

local crating_util = {}
local STACKS_PER_CRATE = 20 -- 1 / 0.05
local BELT_SPEED = 15

if not FF_items_data then FF_items_data = {} end

---------------------------------------------------------------------------
--[[ 
  FF_items_data: Table<ItemDataPrototype>
  ItemDataPrototype: 
  {
    name: String, mandatory, should be the internal-name of the item prototype
    [stack_size]: Number, optional, if specified, overrides item's stack_size
    [source]: String, optional, must speficy if different from "item"
    [crating]: Number, specifies the tier at wich the crate recipes are unlocked, default = 1
  }
]]
---------------------------------------------------------------------------

-- @ item_data: ItemDataPrototype
local function ItemDataPrototype(item_data)
  return {
    name       = item_data.name,
    source     = item_data.source or "item",
    crating    = item_data.crating or 1,
    stack_size = item_data.stack_size,
  }
end

-- @ stack_size: Number
local function reduced_stack_size(stack_size)
  if stack_size > 100 then return 50 end
  if stack_size >= 50 then return stack_size / 2 end
  return stack_size
end

-- @ item_data: ItemDataPrototype
local function to_item(item_data)
  if (not item_data.source) or (item_data.source == "item") then return end
  local item = data.raw[item_data.source][item_data.name]
  item.tool = true
  item.type = "item"
  data:extend({ item })
  data.raw[item_data.source][item_data.name] = nil
end

-- @ item_data: ItemDataPrototype
local function from_item(item_data)
  if (not item_data.source) or (item_data.source == "item") then return end
  local item = data.raw.item[item_data.name]
  item.tool = nil
  item.type = item_data.source
  data:extend({ item })
  data.raw.item[item_data.name] = nil
end

-- @ items_data: Dict<ItemDataPrototype>
-- Add local 'items_data' to global 'FF_items_data'
-- NOTE: method is intentionally coded to work on overvrite
-- to allow compatibility scripts to change to new values
local function extend_items_data(items_data)
  for key, item_data in pairs(items_data) do
    FF_items_data[key] = item_data
  end
end

-- @ item_name: String
-- create DCM's recipes from item's name and additional parameters specified in 'FF_items_data'
local function crate_item_wrapper(item_name)
  local idp = ItemDataPrototype(FF_items_data[item_name] or { name = item_name })
  
  -- Check for prototype existence
  if not data.raw[idp.source][idp.name] then return end
  
  -- RedCompute reduced stack value if not specified otherwise
  if not idp.stack_size then
    idp.stack_size = reduced_stack_size(data.raw[idp.source][idp.name].stack_size)
  end
  
  -- DCM only expects items in data.raw.item 
  to_item(idp)
  
  -- Adjust stack size before crating is called
  data.raw.item[idp.name].stack_size = idp.stack_size
  
  -- Create crate item & recipe with DCM's API
  deadlock_crating.add_crate(idp.name, "deadlock-crating-" .. tostring(idp.crating))
  
  -- Adjust crating recipes time and values
  local items_per_crate = idp.stack_size * STACKS_PER_CRATE
  local energy_required = items_per_crate / BELT_SPEED
  bzutil.set_ingredient("deadlock-packrecipe-" .. idp.name, idp.name, items_per_crate)
  bzutil.set_product_amount("deadlock-unpackrecipe-" .. idp.name, idp.name, items_per_crate)
  bzutil.set_recipe_time("deadlock-packrecipe-" .. idp.name, energy_required)
  bzutil.set_recipe_time("deadlock-unpackrecipe-" .. idp.name, energy_required)
  
  -- Adjust new crate items
  local crate_item = data.raw.item["deadlock-crate-" .. idp.name]
  crate_item.stack_size = 1
  crate_item.localised_name = {"item-name.deadlock-crate-item", items_per_crate, {"item-name." .. item_name}}
  
  -- Revert to original type
  from_item(idp)
end

-- @ item_name: String
-- @ tier: { (OldTier): Number, (NewTier): Number }
-- @ [source]: String (defeult = "item")
-- example: crating_util.update_crating_tier( "iron-gear-wheel", [2, 1])
local function update_crating_tier(item_name, tier, source)
  local item_type = source or "item"
  if not data.raw[item_type][item_name] then return end
  if data.raw.recipe["deadlock-packrecipe-" .. item_name] and data.raw.recipe["deadlock-unpackrecipe-" .. item_name] then
    bzutil.remove_recipe_effect("deadlock-crating-" .. tostring(tier[1]), "deadlock-packrecipe-" .. item_name)
    bzutil.remove_recipe_effect("deadlock-crating-" .. tostring(tier[1]), "deadlock-unpackrecipe-" .. item_name)
    bzutil.add_unlock("deadlock-crating-" .. tostring(tier[2]), "deadlock-packrecipe-" .. item_name)
    bzutil.add_unlock("deadlock-crating-" .. tostring(tier[2]), "deadlock-unpackrecipe-" .. item_name)
  end
end

---------------------------------------------------------------------------

crating_util.extend_items_data   = extend_items_data
crating_util.crate_item          = crate_item_wrapper
crating_util.update_crating_tier = update_crating_tier

return crating_util