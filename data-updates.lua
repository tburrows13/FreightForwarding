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
