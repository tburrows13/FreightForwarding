local inventory_blacklist = {
  ["broken_droid"] = true,  -- Science droids
  ["droid_work_station"] = true,
  ["companion"] = true,  -- Companion drones
  ["long-range-delivery-drone"] = true,  -- Long range delivery drones
}

local function divide_inventory_size(prototype, amount)
  if inventory_blacklist[prototype.name] then return end
  if prototype.inventory_size > 2 then
    prototype.inventory_size = math.max(math.ceil(prototype.inventory_size / amount), 2)
  end
end

for _, prototype in pairs(data.raw["cargo-wagon"]) do
  divide_inventory_size(prototype, 10)
end

for _, prototype in pairs(data.raw["car"]) do
  if prototype.name == "hcraft-entity" then
    prototype.inventory_size = 0
  elseif prototype.name == "mcraft-entity" then
    prototype.inventory_size = 10
  elseif prototype.name == "ironclad" or prototype.name == "ironclad-gunboat" then
    prototype.inventory_size = 20
  else
    divide_inventory_size(prototype, 2)
  end
end

-- Automated loading of containers into spider-vehicles is prohibited, so don't need to decrease by much,
-- only enough to discourage using them for non-containerized intermediate products
for _, prototype in pairs(data.raw["spider-vehicle"]) do
  divide_inventory_size(prototype, 2)
end

-- Increase inventory size of broken droids from Science Droids so that
-- they can fit all required materials even though stack sizes are reduced
local broken_droid = data.raw["container"]["broken_droid"]
if broken_droid then
  broken_droid.inventory_size = 30
end

-- Increase Rocket Silo result inventory since science pack stacks are 100 instead of 1000
data.raw["rocket-silo"]["rocket-silo"].rocket_result_inventory_size = 10

local burner_types = {
  "boiler",
  "burner-generator",
  "car",
  "assembling-machine",
  "furnace",
  "rocket-silo",
  "generator-equipment",
  "inserter",
  "lab",
  "locomotive",
  "mining-drill",
  "pump",
  "radar",
  --"reactor",
  "roboport-equipment",
  "spider-vehicle",
}

local function min(a, b)
  if a < b then return a
  else return b
  end
end

-- Increase burner fuel inventory sizes to compensate
local function increase_fuel_inventory_size(energy_source)
  if energy_source and energy_source.fuel_inventory_size and not energy_source.ff_no_double_inventory_size then
    energy_source.fuel_inventory_size = min(energy_source.fuel_inventory_size * 2, 10)
    if energy_source.burnt_inventory_size then
      energy_source.burnt_inventory_size = min(energy_source.burnt_inventory_size * 2, 10)
    end
  end
end

for _, type in pairs(burner_types) do
  for _, prototype in pairs(data.raw[type]) do
    increase_fuel_inventory_size(prototype.burner)
    increase_fuel_inventory_size(prototype.energy_source)
  end
end

-- Increase player inventory size to compensate
for _, character in pairs(data.raw.character) do
  character.inventory_size = math.floor(character.inventory_size * 1.25)
end