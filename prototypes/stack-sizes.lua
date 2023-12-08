local restack = require "__FreightForwarding__.prototypes.data-util".set_stack_size

-- Each of these will get halved by IntermodalContainers
local stack_size_override = {
  -- Vanilla
  ["uranium-ore"] = 30,
  ["uranium-235"] = 50,
  ["uranium-238"] = 50,
  ["uranium-fuel-cell"] = 20,
  ["used-up-uranium-fuel-cell"] = 20,
  -- BZ
  ["lead-ore"] = 30,
  ["titanium-ore"] = 30,

  -- Sciences
  ["automation-science-pack"] = 100,
  ["logistic-science-pack"] = 100,
  ["chemical-science-pack"] = 100,
  ["military-science-pack"] = 100,
  ["production-science-pack"] = 100,
  ["utility-science-pack"] = 100,
  ["space-science-pack"] = 100,
}

for name, stack_size in pairs(stack_size_override) do
  restack(name, stack_size)
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