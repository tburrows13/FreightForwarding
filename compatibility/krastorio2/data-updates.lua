if not mods["Krastorio2"] then return end

-- Transport Tech Card
data.raw.tool["ff-transport-science-pack"].icon = "__FreightForwarding__/graphics/compatibility/krastorio2/transport-tech-card-item.png"
data.raw.tool["ff-transport-science-pack"].order = "b03[transport-science-pack]"
data.raw.technology["ff-transport-science-pack"].icon = "__FreightForwarding__/graphics/compatibility/krastorio2/transport-tech-card-technology.png"

-- Item containers and stack sizes
local items_data = {
  ["advanced-fuel"] = { name = "advanced-fuel", stack_size = 25 },
  ["advanced-tech-card"] = { name = "advanced-tech-card", stack_size = 100, source = "tool" },
  ["ai-core"] = { name = "ai-core", stack_size = 25 },
  ["automation-core"] = { name = "automation-core", stack_size = 50 },
  ["basic-tech-card"] = { name = "basic-tech-card", stack_size = 1, source = "tool" },
  ["bio-fuel"] = { name = "bio-fuel", stack_size = 25 },
  ["biomass"] = { name = "biomass", stack_size = 50 },
  ["blank-tech-card"] = { name = "blank-tech-card", stack_size = 100 },
  ["biters-research-data"] = { name = "biters-research-data", stack_size = 100 },
  ["charged-antimatter-fuel-cell"] = { name = "charged-antimatter-fuel-cell", stack_size = 50 },
  ["charged-matter-stabilizer"] = { name = "charged-matter-stabilizer", stack_size = 50 },
  ["coke"] = { name = "coke", stack_size = 25 },
  ["dt-fuel"] = { name = "dt-fuel", stack_size = 50 },
  ["electronic-components"] = { name = "electronic-components", stack_size = 50 },
  ["empty-antimatter-fuel-cell"] = { name = "empty-antimatter-fuel-cell", stack_size = 50 },
  ["empty-dt-fuel"] = { name = "empty-dt-fuel", stack_size = 50 },
  ["energy-control-unit"] = { name = "energy-control-unit", stack_size = 25 },
  ["enriched-copper"] = { name = "enriched-copper", stack_size = 25 },
  ["enriched-iron"] = { name = "enriched-iron", stack_size = 25 },
  ["enriched-lead"] = { name = "enriched-lead", stack_size = 25 },
  ["enriched-rare-metals"] = { name = "enriched-rare-metals", stack_size = 25 },
  ["enriched-titanium"] = { name = "enriched-titanium", stack_size = 25 },
  ["fertilizer"] = { name = "fertilizer", stack_size = 50 },
  ["fuel"] = { name = "fuel", stack_size = 25 },
  ["glass"] = { name = "glass", stack_size = 50 },
  ["imersite-crystal"] = { name = "imersite-crystal", stack_size = 25 },
  ["imersite-powder"] = { name = "imersite-powder", stack_size = 50 },
  ["imersium-beam"] = { name = "imersium-beam", stack_size = 50 },
  ["imersium-gear-wheel"] = { name = "imersium-gear-wheel", stack_size = 50 },
  ["imersium-plate"] = { name = "imersium-plate", stack_size = 50 },
  ["improved-pollution-filter"] = { name = "improved-pollution-filter", stack_size = 25 },
  ["inserter-parts"] = { name = "inserter-parts", stack_size = 50 },
  ["iron-beam"] = { name = "iron-beam", stack_size = 50 },
  ["lithium"] = { name = "lithium", stack_size = 50 },
  ["lithium-chloride"] = { name = "lithium-chloride", stack_size = 50 },
  ["lithium-sulfur-battery"] = { name = "lithium-sulfur-battery", stack_size = 50 },
  ["low-density-structure"] = { name = "low-density-structure", stack_size = 25 },
  ["matter-cube"] = { name = "matter-cube", stack_size = 50 },
  ["matter-research-data"] = { name = "matter-research-data", stack_size = 100},
  ["matter-stabilizer"] = { name = "matter-stabilizer", stack_size = 50 },
  ["matter-tech-card"] = { name = "matter-tech-card", stack_size = 100 , source = "tool" },
  ["pollution-filter"] = { name = "pollution-filter", stack_size = 50 },
  ["quartz"] = { name = "quartz", stack_size = 25 },
  ["rare-metals"] = { name = "rare-metals", stack_size = 50 },
  ["raw-imersite"] = { name = "raw-imersite", stack_size = 15 },
  ["raw-rare-metals"] = { name = "raw-rare-metals", stack_size = 25 },
  ["rocket-control-unit"] = { name = "rocket-control-unit", stack_size = 25 },
  ["rocket-fuel"] = { name = "rocket-fuel", stack_size = 25 },
  ["sand"] = { name = "sand", stack_size = 50 },
  ["silicon"] = { name = "silicon", stack_size = 50 },
  ["singularity-tech-card"] = { name = "singularity-tech-card", stack_size = 100 , source = "tool" },
  ["steel-beam"] = { name = "steel-beam", stack_size = 50 },
  ["steel-gear-wheel"] = { name = "steel-gear-wheel", stack_size = 50 },
  ["tritium"] = { name = "tritium", stack_size = 25 },
  ["used-improved-pollution-filter"] = { name = "used-improved-pollution-filter", stack_size = 25 },
  ["used-pollution-filter"] = { name = "used-pollution-filter", stack_size = 25 },
}

for ___, item in pairs(items_data) do
  if item.stack_size then data.raw[item.source or "item"][item.name].stack_size = item.stack_size end
  deadlock_crating.add_crate_autotech(item.name, item.crating)
end