require "__FreightForwarding__/prototypes/containers"
require "__FreightForwarding__/prototypes/description-updates"
local collision_mask_util = require "__core__.lualib.collision-mask-util"

data.raw["resource"]["ff-seamount"].collision_mask = {"resource-layer", non_deep_water_mask, "ground-tile"}

local platform_layer = collision_mask_util.get_first_unused_layer()
log("FF platform_layer assigned to " .. platform_layer)
table.insert(data.raw.tile["ff-dredging-platform"].collision_mask, platform_layer)
local banned_types = {"electric-pole", "underground-belt"}
for _, type in pairs(banned_types) do
  for _, prototype in pairs(data.raw[type]) do
    local mask = collision_mask_util.get_mask(prototype)
    collision_mask_util.add_layer(mask, platform_layer)
    prototype.collision_mask = mask
  end
end
table.insert(data.raw["offshore-pump"]["offshore-pump"].center_collision_mask, platform_layer)
table.insert(data.raw["offshore-pump"]["waterfill-placer"].center_collision_mask, platform_layer)


-- Science
local util = require "__FreightForwarding__/prototypes/data-util"

for _, tech in pairs(data.raw.technology) do
  local ingredients = tech.unit.ingredients
  if tech.name == "rocket-silo" then log(serpent.block(tech)) end
  if util.contains_research_ingredient(tech.name, "chemical-science-pack")
    and not util.contains_research_ingredient(tech.name, "ff-transport-science-pack") then
    table.insert(ingredients, {"ff-transport-science-pack", 1})
  else
    -- Add to all techs descending from key techs
    if (util.is_descendant_of(tech.name, "water_transport")
      or util.is_descendant_of(tech.name, "fluid-handling")
      or util.is_descendant_of(tech.name, "automobilism")
      or util.is_descendant_of(tech.name, "ff-transport-science-pack"))
      and util.contains_research_ingredient(tech.name, "logistic-science-pack")
      and not util.contains_research_ingredient(tech.name, "ff-transport-science-pack") then
      table.insert(ingredients, {"ff-transport-science-pack", 1})
    end
  end
end

-- Compatibility
require "__FreightForwarding__/compatibility/beautiful-bridge-railway/data-final-fixes"
require "__FreightForwarding__/compatibility/krastorio2/data-final-fixes"
require "__FreightForwarding__/compatibility/transport-drones/data-final-fixes"
