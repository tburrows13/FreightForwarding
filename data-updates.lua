require "__X-Logistics__/prototypes/inventory-sizes"

-- Revert bztitanium's changes to underwater pipes
if mods["underwater-pipes"] then
  data.raw.technology["underwater-pipes"].prerequisites = { "concrete", "steel-processing" }
  data.raw.recipe["underwater-pipe"].ingredients = {
    { "pipe", 2 },
    { "steel-plate", 5 },
    { "concrete", 20 },
  }
end

-- Remove water-tile from collision check so that player can exit onto shallow water
if mods["cargo-ships"] then
  local collision_mask = data.raw["simple-entity-with-force"]["tile_player_test_item"].collision_mask
  for i, mask in pairs(collision_mask) do
    if mask == "water-tile" then
      table.remove(collision_mask, i)
      break
    end
  end
  table.insert(collision_mask, "train-layer")
end