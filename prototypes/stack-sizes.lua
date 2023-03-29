-- changes value of stacks
function ff_restack(item_name)
  local item = data.raw.item[item_name] or data.raw.tool[item_name]
  if not item then return end
  local stack_size = tonumber(item.stack_size)
  if ff_stack_size_override[item_name] then item.stack_size = ff_stack_size_override[item_name]
  elseif stack_size >= 30 then item.stack_size = stack_size / 2 end
end

ff_stack_size_override = {
  -- Vanilla
  ["uranium-ore"] = 15,
  -- Freight Forwarding
  ["ff-cobalt-ore"] = 15,
  -- BZ
  ["lead-ore"] = 15,
  ["titanium-ore"] = 15,
  ["space-science-pack"] = 100,
}

-- Can't be set in ff_stack_size_override since they aren't containerisable
data.raw.item["uranium-fuel-cell"].stack_size = 10
data.raw.item["used-up-uranium-fuel-cell"].stack_size = 10

local intermediates = {
  -- -- Vanilla
  -- raw materials
  "wood", "iron-ore", "copper-ore", "stone", "coal", "iron-plate", "copper-plate", "steel-plate", "stone-brick", "uranium-ore",
  -- processed
  "copper-cable", "iron-gear-wheel", "iron-stick", "sulfur", "plastic-bar", "solid-fuel", "electronic-circuit", "advanced-circuit",
  "processing-unit", "battery", "uranium-235", "uranium-238", "explosives", "engine-unit",  "empty-barrel",
  "electric-engine-unit", "flying-robot-frame", "rocket-control-unit", "low-density-structure", "rocket-fuel", "nuclear-fuel",
  -- science packs
  "automation-science-pack", "logistic-science-pack", "chemical-science-pack", "military-science-pack", "production-science-pack", "utility-science-pack", "space-science-pack",
  -- -- Freight Forwarding
  "ff-transport-science-pack", "ff-battery-pack", "ff-charged-battery-pack", "ff-cobalt-ore", "ff-cobalt-concentrate", "ff-cobalt-ingot", "ff-titansteel-plate", "ff-charged-battery",
  -- -- BZ 
  "lead-ore", "lead-plate", "titanium-ore", "titanium-plate",
}

for _, item in pairs(intermediates) do
  ff_restack(item)
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