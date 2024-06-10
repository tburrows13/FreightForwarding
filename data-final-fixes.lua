require "__FreightForwarding__.prototypes.fuel-categories"

local collision_mask_util = require "__core__.lualib.collision-mask-util"

data.raw["resource"]["ff-seamount"].collision_mask = { "resource-layer", non_deep_water_mask, "ground-tile" }

local platform_layer = collision_mask_util.get_first_unused_layer()
log("FF platform_layer assigned to " .. platform_layer)
table.insert(data.raw.tile["ff-dredging-platform"].collision_mask, platform_layer)
local banned_types = { "electric-pole", "underground-belt" }
for _, type in pairs(banned_types) do
  for _, prototype in pairs(data.raw[type]) do
    local mask = collision_mask_util.get_mask(prototype)
    collision_mask_util.add_layer(mask, platform_layer)
    prototype.collision_mask = mask
  end
end
table.insert(data.raw["offshore-pump"]["offshore-pump"].center_collision_mask, platform_layer)
table.insert(data.raw["offshore-pump"]["waterfill-placer"].center_collision_mask, platform_layer)

-- Ensure collisions between pump, underwater pipe, oil rig, offshore storage tank, sonar buoy
local pump = data.raw["pump"]["pump"]
water_object_layer = collision_mask_util.get_first_unused_layer()
log("FF water_object_layer assigned to " .. water_object_layer)
collision_mask_util.add_layer(pump.collision_mask, water_object_layer)
collision_mask_util.add_layer(data.raw.pipe["ff-underwater-pipe"].collision_mask, water_object_layer)
collision_mask_util.add_layer(data.raw["storage-tank"]["ff-offshore-storage-tank"].collision_mask, water_object_layer)
collision_mask_util.add_layer(data.raw["mining-drill"]["oil_rig"].collision_mask, water_object_layer)
collision_mask_util.add_layer(data.raw["radar"]["ff-sonar-buoy"].collision_mask, water_object_layer)

-- Compatibility for pump upgrade mods
local next_pump = data.raw.pump["pump"].next_upgrade
while next_pump and data.raw.pump[next_pump] do
  data.raw.pump[next_pump].collision_mask = table.deepcopy(data.raw.pump["pump"].collision_mask)
  next_pump = data.raw.pump[next_pump].next_upgrade
end

local offshore_tank_collision = table.deepcopy(data.raw["pump"]["pump"].collision_mask)
table.insert(offshore_tank_collision, "ground-tile")
data.raw["storage-tank"]["ff-offshore-storage-tank"].collision_mask = offshore_tank_collision

-- Ensure vehicles and units still collide with water even though player can walk on it
substitute_player_collision_layer = collision_mask_util.get_first_unused_layer()
log("FF substitute_player_collision_layer assigned to " .. substitute_player_collision_layer)

local water = data.raw.tile["water"]
local deep_water = data.raw.tile["deepwater"]
for _, water_tile in pairs { water, deep_water } do
  collision_mask_util.add_layer(water_tile.collision_mask, substitute_player_collision_layer)
end

for _, type in pairs { "unit", "car", "spider-leg" } do
  for _, prototype in pairs(data.raw[type]) do
    local mask = collision_mask_util.get_mask(prototype)
    if collision_mask_util.mask_contains_layer(mask, "player-layer") then
      collision_mask_util.add_layer(mask, substitute_player_collision_layer)
      prototype.collision_mask = mask
    end
  end
end

-- Ensure that underwater pipes can't be placed on ground but also don't collide with ships
underwater_pipe_layer = collision_mask_util.get_first_unused_layer()
log("FF underwater_pipe_layer assigned to " .. underwater_pipe_layer)
for _, tile in pairs(data.raw.tile) do
  if collision_mask_util.mask_contains_layer(tile.collision_mask, "ground-tile") then
    table.insert(tile.collision_mask, underwater_pipe_layer)
  end
end
collision_mask_util.add_layer(data.raw.pipe["ff-underwater-pipe"].collision_mask, underwater_pipe_layer)

-- Science
local util = require "__FreightForwarding__.prototypes.data-util"

for _, tech in pairs(data.raw.technology) do
  if tech.unit then
    local ingredients = tech.unit.ingredients
    if util.contains_research_ingredient(tech.name, "chemical-science-pack")
        and not util.contains_research_ingredient(tech.name, "ff-transport-science-pack") then
      table.insert(ingredients, { "ff-transport-science-pack", 1 })
    else
      -- Add to all techs descending from key techs
      if (util.is_descendant_of(tech.name, "water_transport")
          or util.is_descendant_of(tech.name, "fluid-handling")
          or util.is_descendant_of(tech.name, "automobilism")
          or util.is_descendant_of(tech.name, "ff-transport-science-pack"))
          and util.contains_research_ingredient(tech.name, "logistic-science-pack")
          and not util.contains_research_ingredient(tech.name, "ff-transport-science-pack") then
        table.insert(ingredients, { "ff-transport-science-pack", 1 })
      end
    end
  end
end

if data.raw.technology["ff-interstellar-communication"] then
  for name, tech in pairs(data.raw.technology) do
    if name ~= "ff-interstellar-communication" then
      for i, prereq in pairs(tech.prerequisites or {}) do
        if prereq == "space-science-pack" then
          table.insert(tech.prerequisites, "ff-interstellar-communication")
          table.remove(tech.prerequisites, i)
        end
      end
    end
  end
end
-- Compatibility
require "__FreightForwarding__.compatibility.beautiful-bridge-railway.data-final-fixes"
require "__FreightForwarding__.compatibility.krastorio2.data-final-fixes"
require "__FreightForwarding__.compatibility.transport-drones.data-final-fixes"


--[[
  Layers with only FF
  FF non_deep_water_mask assigned to layer-13
  FF deep_water_mask assigned to layer-16
  layer-19: Hovercrafts
  layer-20: CS waterway_layer
  layer-21: CS pump_collision_layer
  layer-22: CS land_resource_layer
  layer-23: FF platform_layer
  layer-24: FF water_object_layer
  layer-25: FF substitute_player_collision_layer
  layer-26: FF underwater_pipe_layer

 deep_oil and grass-1 should collide. {["resource-layer"] = true} | {["ground-tile"] = true, ["layer-20"] = true}
 straight-water-way and ff-seamount should collide. {["layer-20"] = true, ["object-layer"] = true} | {["ground-tile"] = true, ["layer-13"] = true, ["resource-layer"] = true}
 pump and ff-seamount should collide. {["layer-21"] = true, ["layer-24"] = true, ["object-layer"] = true} | {["ground-tile"] = true, ["layer-13"] = true, ["resource-layer"] = true}
 ff-underwater-pipe and indep-boat should not collide. {["ground-tile"] = true, ["layer-24"] = true} | {["ground-tile"] = true, ["train-layer"] = true}
 ff-underwater-pipe and oil_rig should collide. {["ground-tile"] = true, ["layer-24"] = true} | {["object-layer"] = true, ["train-layer"] = true}

]]
