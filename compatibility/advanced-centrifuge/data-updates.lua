if not mods["advanced-centrifuge"] then return end

-- Entity rebalance
local k11 = data.raw["assembling-machine"]["k11-advanced-centrifuge"]
table.insert(k11.crafting_categories, "advanced-centrifuging")
k11.scale_entity_info_icon = true
if not mods["Krastorio2"] then k11.crafting_speed = 4 end

-- Recipe rebalance
x_util.add_ingredient("k11-advanced-centrifuge", "lead-plate", 200)

-- Recipe extensions
x_util.add_unlock("k11-advanced-centrifuge", "ff-advanced-uranium-processing")

-- Fix prerequisites
for ___, science in pairs({"production-science-pack", "utility-science-pack"}) do
  local tech = data.raw.technology["k11-advanced-centrifuge"]
  if tech ~= nil then
    if x_util.contains_research_ingredient(tech.name, science) and not x_util.is_descendant_of(tech.name, science)then
      x_util.add_prerequisite(tech.name, science)
    end
  end
end



