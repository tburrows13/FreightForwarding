local bzutil = require "__bzlead__/data-util";

-- These ones are already added by deadlock crating
local raw_material_list = {
  [1] = { "wood", "iron-ore", "copper-ore", "stone", "coal", "iron-plate", "copper-plate", "steel-plate", "stone-brick", "lead-ore", "lead-plate" },
  [2] = { "copper-cable", "iron-gear-wheel", "iron-stick", "sulfur", "plastic-bar", "solid-fuel", "electronic-circuit", "advanced-circuit", "titanium-ore", "titanium-plate" },
  [3] = { "processing-unit", "battery", "uranium-ore", "uranium-235", "uranium-238" },
}

-- These are checked for existence before being added so it doesn't matter if their mod isn't loaded
local new_material_list = {
  [1] = { "sand", "glass", "stone-tablet" },  -- AAI Industry
  [2] = {
    "automation-science-pack", "logistic-science-pack", "x-transport-science-pack", "chemical-science-pack", "military-science-pack",  -- Vanilla
    "explosives", "engine-unit", "electric-engine-unit",  -- Vanilla
    "ff-charged-battery",  -- Freight Forwarding
    "motor", "electric-motor", "processed-fuel",  -- AAI Industry
  },
  [3] = {
    "flying-robot-frame", "rocket-control-unit", "low-density-structure", "rocket-fuel", "nuclear-fuel",  -- Vanilla
    "production-science-pack", "utility-science-pack", "space-science-pack",  -- Vanilla
    "ff-battery-pack", "ff-charged-battery-pack", "ff-titansteel-plate",  -- Freight Forwarding
    "plutonium-238", "plutonium-239", "plutonium-fuel" },  -- Plutonium Energy
}

stack_size_override = {
  ["lead-ore"] = 15,
  ["titanium-ore"] = 15,
  ["uranium-ore"] = 15,
}

local raw_materials = {}
for tier, material_list in pairs(new_material_list) do
  local tech_name = "deadlock-crating-" .. tier
  for _, name in pairs(material_list) do
    if data.raw.tool[name] then
      -- Hack to make science packs work with DCM's code, which only expects items in data.raw.item
      local item = data.raw.tool[name]
      item.tool = true
      item.type = "item"
      data:extend{item}
      data.raw.tool[name] = nil
    end
    if data.raw.item[name] then
      raw_materials[name] = tech_name
    end
  end
end

for name, tech_name in pairs(raw_materials) do
  deadlock_crating.add_crate(name, tech_name)
end

local stacks_per_crate = 0.05
local belt_speed = 15

-- Convert all crates from 5 crates/stack to 0.01 crates/stack
for _, recipe in pairs(data.raw.recipe) do
  if recipe.category and recipe.category == "packing" and recipe.subgroup then
    if recipe.subgroup == "deadlock-crates-pack" then
      local item_name = recipe.ingredients[2][1]
      local item = data.raw.item[item_name]
      local stack_size = tonumber(item.stack_size)
      if stack_size_override[item_name] then
        item.stack_size = stack_size_override[item_name]
      elseif stack_size >= 50 then
        item.stack_size = stack_size / 2
      end

      local items_per_crate = item.stack_size / stacks_per_crate
      recipe.ingredients[2][2] = items_per_crate
      recipe.energy_required = items_per_crate / belt_speed

      local crate_item = data.raw.item[recipe.result]
      crate_item.stack_size = 1
      crate_item.localised_name = {"item-name.deadlock-crate-item", items_per_crate, {"item-name." .. item_name}}

    elseif recipe.subgroup == "deadlock-crates-unpack" then
      local item_name = recipe.results[2][1]
      local item = data.raw.item[item_name]
      local items_per_crate = tonumber(item.stack_size) / stacks_per_crate
      recipe.results[2][2] = items_per_crate
      recipe.energy_required = items_per_crate / belt_speed
    end
  end
end

-- Change uranium stacking to tier 2
bzutil.remove_recipe_effect("deadlock-crating-3", "deadlock-packrecipe-uranium-ore")
bzutil.remove_recipe_effect("deadlock-crating-3", "deadlock-unpackrecipe-uranium-ore")
bzutil.remove_recipe_effect("deadlock-crating-3", "deadlock-packrecipe-uranium-235")
bzutil.remove_recipe_effect("deadlock-crating-3", "deadlock-unpackrecipe-uranium-235")
bzutil.remove_recipe_effect("deadlock-crating-3", "deadlock-packrecipe-uranium-238")
bzutil.remove_recipe_effect("deadlock-crating-3", "deadlock-unpackrecipe-uranium-238")

bzutil.add_unlock("deadlock-crating-2", "deadlock-packrecipe-uranium-ore")
bzutil.add_unlock("deadlock-crating-2", "deadlock-unpackrecipe-uranium-ore")
bzutil.add_unlock("deadlock-crating-2", "deadlock-packrecipe-uranium-235")
bzutil.add_unlock("deadlock-crating-2", "deadlock-unpackrecipe-uranium-235")
bzutil.add_unlock("deadlock-crating-2", "deadlock-packrecipe-uranium-238")
bzutil.add_unlock("deadlock-crating-2", "deadlock-unpackrecipe-uranium-238")

-- Change battery stacking to tier 2
bzutil.remove_recipe_effect("deadlock-crating-3", "deadlock-packrecipe-battery")
bzutil.remove_recipe_effect("deadlock-crating-3", "deadlock-unpackrecipe-battery")

bzutil.add_unlock("deadlock-crating-2", "deadlock-packrecipe-battery")
bzutil.add_unlock("deadlock-crating-2", "deadlock-unpackrecipe-battery")


data.raw.item["uranium-fuel-cell"].stack_size = 10  -- Was 50
data.raw.item["used-up-uranium-fuel-cell"].stack_size = 10  -- Was 50
if mods["PlutoniumEnergy"] then
  data.raw.item["MOX-fuel"].stack_size = 10  -- Was 50
  data.raw.item["breeder-fuel-cell"].stack_size = 5  -- Was 20
  data.raw.item["used-up-MOX-fuel"].stack_size = 10  -- Was 50
  data.raw.item["used-up-breeder-fuel-cell"].stack_size = 5  -- Was 20
end

-- Increase stack inserter stack sizes
local stack_bonus_techs = { "stack-inserter", "inserter-capacity-bonus-1", "inserter-capacity-bonus-2", "inserter-capacity-bonus-3", "inserter-capacity-bonus-4", "inserter-capacity-bonus-5", "inserter-capacity-bonus-6", "inserter-capacity-bonus-7", }
for _, tech_name in pairs(stack_bonus_techs) do
  local bonus_tech = data.raw.technology[tech_name]
  if bonus_tech then
    for _, effect in pairs(bonus_tech.effects) do
      if effect.type == "stack-inserter-capacity-bonus" then
        effect.modifier = effect.modifier + 1
      end
    end
  end
end

local function update_description_stack_size(description, stack_size)
  if not description then return end
  if type(description) ~= "table" then return end
  if description[1] == "description.stack-size" or description[1] == "other.stack-size-description" then
    -- Extended Descriptions and Stack Size Tooltip
    description[2] = stack_size
  end
  for _, item in pairs(description) do
    update_description_stack_size(item, stack_size)
  end
end

for _, item in pairs(data.raw.item) do
  -- Update stack size descriptions added by other mods because we run in data-final-fixes
  update_description_stack_size(item.localised_description, tostring(item.stack_size))
end

for name, _ in pairs(raw_materials) do
  -- Put back the science packs into "tool" type
  if data.raw.item[name].tool then
    local item = data.raw.item[name]
    item.tool = nil
    item.type = "tool"
    data:extend{item}
    data.raw.item[name] = nil
  end
end
