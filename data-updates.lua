require "__FreightForwarding__/prototypes/inventory-sizes"
require "__FreightForwarding__/prototypes/recipe-updates"

local collision_mask_util = require "__core__.lualib.collision-mask-util"

for _, tile in pairs(data.raw.tile) do
  tile.check_collision_with_entities = true
end

-- Prevent concrete, etc, from being placed on landfill because now that landfill is minable, it would return the item
local landfill_collision_mask = collision_mask_util.get_first_unused_layer()
collision_mask_util.add_layer(data.raw.tile.landfill.collision_mask, landfill_collision_mask)  -- (tiles much have `collision_mask`)

for name, item in pairs(data.raw.item) do
  if item.place_as_tile and name ~= "landfill" then
    collision_mask_util.add_layer(item.place_as_tile.condition, landfill_collision_mask)
  end
end

-- Cargo ships patches

table.insert(data.raw["generator"]["or_power"].flags, "placeable-off-grid")
table.insert(data.raw["electric-pole"]["or_pole"].flags, "placeable-off-grid")
table.insert(data.raw["radar"]["or_radar"].flags, "placeable-off-grid")

data.raw["electric-pole"]["or_pole"].supply_area_distance = 7.5  -- 4.5