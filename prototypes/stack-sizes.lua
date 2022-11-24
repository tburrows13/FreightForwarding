-- These ones are already added by deadlock crating
local raw_material_list = {
  [1] = { "wood", "iron-ore", "copper-ore", "stone", "coal", "iron-plate", "copper-plate", "steel-plate", "stone-brick", "lead-ore", "lead-plate" },
  [2] = { "copper-cable", "iron-gear-wheel", "iron-stick", "sulfur", "plastic-bar", "solid-fuel", "electronic-circuit", "advanced-circuit", "titanium-ore", "titanium-plate" },
  [3] = { "processing-unit", "battery", "uranium-ore", "uranium-235", "uranium-238" },
}

-- These are checked for existence before being added so it doesn't matter if their mod isn't loaded
local new_material_list = {
  [1] = { "jag-seeds", "sng-sand", "sng-glass-plate" },
  [2] = { "explosives", "engine-unit", "electric-engine-unit" },
  [3] = { "plutonium" },
}

local raw_materials = {}
for tier, material_list in pairs(new_material_list) do
  local tech_name = "deadlock-crating-" .. tier
  for _, name in pairs(material_list) do
    if data.raw.item[name] then
      raw_materials[name] = tech_name
    end
  end
end

for name, tech_name in pairs(raw_materials) do
  deadlock_crating.add_crate(name, tech_name)
end

local function update_description_stack_size(description, stack_size)
  if not description then return end
  if type(description) ~= "table" then return end
  if description[1] == "description.stack-size" or description[1] = "other.stack-size-description" then
    -- Extended Descriptions and Stack Size Tooltip
    description[2] = stack_size
  end
  for _, item in pairs(description) do
    update_description_stack_size(item, stack_size)
  end
end

local stacks_per_crate = 0.01
local belt_speed = 15

-- Convert all crates from 5 crates/stack to 0.01 crates/stack
for _, recipe in pairs(data.raw.recipe) do
  if recipe.category and recipe.category == "packing" and recipe.subgroup then
    if recipe.subgroup == "deadlock-crates-pack" then
      local item_name = recipe.ingredients[2][1]
      local item = data.raw.item[item_name]
      local stack_size = tonumber(item.stack_size)
      if stack_size >= 50 then
        item.stack_size = stack_size / 10
      elseif stack_size >= 20 then
        item.stack_size = stack_size / 4
      end

      -- Update stack size descriptions added by other mods
      update_description_stack_size(item.localised_description, tostring(item.stack_size))

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

data.raw.item["uranium-fuel-cell"].stack_size = 10  -- Was 50
data.raw.item["used-up-uranium-fuel-cell"].stack_size = 10  -- Was 50
if mods["Nuclear Fuel"] then
  data.raw.item["breeder-fuel-cell"].stack_size = 10  -- Was 50
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