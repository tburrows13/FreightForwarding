-- Modifications to beautiful_bridge_railway_Cargoships
-- Recipe changes are in data-final-fixes

local collision_mask_util = require "__core__.lualib.collision-mask-util"

-- Prevent bridges being placed on deep water
local deep_water_mask = collision_mask_util.get_first_unused_layer()
table.insert(data.raw.tile["deepwater"].collision_mask, deep_water_mask)
table.insert(data.raw.tile["deepwater-green"].collision_mask, deep_water_mask)

for _, bridge_type in pairs({"wood", "iron", "brick"}) do
  for _, rail_type in pairs({"straight-rail", "curved-rail"}) do
    local prototype = data.raw[rail_type]["bbr-" .. rail_type .. "-" .. bridge_type]
    if prototype then
      local collision_mask = collision_mask_util.get_mask(prototype)
      collision_mask_util.add_layer(collision_mask, deep_water_mask)
      prototype.collision_mask = collision_mask
      prototype.localised_description = {"item-description.bbr-rail-common"}
    end
  end
end


-- Increase selection priority of vehicles so that they can be selected over bridges
for _, type in pairs({"car", "locomotive", "cargo-wagon", "fluid-wagon", "artillery-wagon", "spider-vehicle"}) do
  for _, prototype in pairs(data.raw[type]) do
    log(prototype.name)
    if not prototype.selection_priority or prototype.selection_priority == 50 then
      prototype.selection_priority = 51
    end
  end
end
