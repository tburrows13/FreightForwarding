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

-- BZ Lead compatibility - override resource autoplace
if mods["bzlead"] then
  -- import custom Resource Autoplace
  local resource_autoplace = require("resource-autoplace/resource-autoplace")

  -- override BZ's autoplace, but keeping same values for richness
  data.raw.resource["lead-ore"].autoplace = resource_autoplace.resource_autoplace_settings{
    name = "lead-ore",
    order = "b-z",
    base_density = 6,
    base_spots_per_km2 = 1,
    has_starting_area_placement = nil,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.7,
    starting_resource_placement_radius = 100,
    regular_patch_fade_in_distance = 300,
  }
end
