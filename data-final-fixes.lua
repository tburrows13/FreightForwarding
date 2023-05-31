require "__FreightForwarding__.prototypes.containers"
require "__FreightForwarding__.prototypes.fuel-categories"

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

-- Ensure pump collides with underwater pipes
local pump = data.raw["pump"]["pump"]
pump_underwater_pipe_collision_layer = collision_mask_util.get_first_unused_layer()
log("FF pump_underwater_pipe_collision_layer assigned to " .. pump_underwater_pipe_collision_layer)
collision_mask_util.add_layer(pump.collision_mask, pump_underwater_pipe_collision_layer)
collision_mask_util.add_layer(data.raw.pipe["ff-underwater-pipe"].collision_mask, pump_underwater_pipe_collision_layer)

-- Compatibility for pump upgrade mods
local next_pump = data.raw.pump["pump"].next_upgrade
while next_pump and data.raw.pump[next_pump] do
  data.raw.pump[next_pump].collision_mask = table.deepcopy(data.raw.pump["pump"].collision_mask)
  next_pump = data.raw.pump[next_pump].next_upgrade
end

local offshore_tank_collision = table.deepcopy(data.raw["pump"]["pump"].collision_mask)
table.insert(offshore_tank_collision, "ground-tile")
data.raw["storage-tank"]["ff-offshore-storage-tank"].collision_mask = offshore_tank_collision

-- Science
local util = require "__FreightForwarding__.prototypes.data-util"

for _, tech in pairs(data.raw.technology) do
  if tech.unit then
    local ingredients = tech.unit.ingredients
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
end

if data.raw.technology["ff-interstellar-communication"] then
  for name, tech in pairs(data.raw.technology) do
    if name ~= "ff-interstellar-communication" then
      for _, prereq in pairs(tech.prerequisites or {}) do
        if prereq == "space-science-pack" then
          table.insert(tech.prerequisites, "ff-interstellar-communication")
        end
      end
    end
  end
end
-- Compatibility
require "__FreightForwarding__.compatibility.beautiful-bridge-railway.data-final-fixes"
require "__FreightForwarding__.compatibility.krastorio2.data-final-fixes"
require "__FreightForwarding__.compatibility.transport-drones.data-final-fixes"
