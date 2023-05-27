local bzutil = require "__bzlead__.data-util"

local entity_types = {"assembling-machine", "beacon", "boiler", "burner-generator", "car", "spider-vehicle", "furnace", "inserter", "lab", "locomotive", "mining-drill", "reactor", "generator-equipment"}

for _, type in pairs(entity_types) do
  for name, prototype in pairs(data.raw[type]) do
    if not prototype.ff_no_advanced_fuel then
      local energy_source = prototype.burner or prototype.energy_source
      if energy_source.fuel_categories and bzutil.contains(energy_source.fuel_categories, "chemical") then
        table.insert(energy_source.fuel_categories, "advanced-chemical")
      elseif energy_source.fuel_category == "chemical" then
        energy_source.fuel_categories = {"chemical", "advanced-chemical"}
        energy_source.fuel_category = nil
      end
    end
  end
end
