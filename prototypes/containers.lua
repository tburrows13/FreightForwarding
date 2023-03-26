local bzutil = require "__bzlead__/data-util";

local IC_PREFIX = "ic-containerization-"
local IC_LOAD   = "ic-load-"
local IC_UNLOAD = "ic-unload-"

-- These ones are already added by Intermodal Containers
local raw_material_list = {
  [1] = { "wood", "iron-ore", "copper-ore", "stone", "coal", "iron-plate", "copper-plate", "steel-plate", "stone-brick", "lead-ore", "lead-plate" },
  [2] = { "copper-cable", "iron-gear-wheel", "iron-stick", "sulfur", "plastic-bar", "solid-fuel", "electronic-circuit", "advanced-circuit", "titanium-ore", "titanium-plate" },
  [3] = { "processing-unit", "battery", "uranium-ore", "uranium-235", "uranium-238" },
}

-- These are checked for existence before being added so it doesn't matter if their mod isn't loaded
local new_material_list = {
  [1] = { },
  [2] = {
    "automation-science-pack", "logistic-science-pack", "ff-transport-science-pack", "chemical-science-pack", "military-science-pack",  -- Vanilla
    "explosives", "engine-unit", "electric-engine-unit", "empty-barrel",  -- Vanilla
    "ff-charged-battery",  -- Freight Forwarding
  },
  [3] = {
    "flying-robot-frame", "rocket-control-unit", "low-density-structure", "rocket-fuel", "nuclear-fuel",  -- Vanilla
    "production-science-pack", "utility-science-pack", "space-science-pack",  -- Vanilla
    "ff-battery-pack", "ff-charged-battery-pack", "ff-cobalt-ore", "ff-cobalt-concentrate", "ff-cobalt-ingot", "ff-titansteel-plate",  -- Freight Forwarding
  }
}

local raw_materials = {}
for tier, material_list in pairs(new_material_list) do
  local tech_name = IC_PREFIX .. tier
  for _, name in pairs(material_list) do
    if data.raw.tool[name] then
      raw_materials[name] = tech_name
    end
    if data.raw.item[name] then
      raw_materials[name] = tech_name
    end
  end
end

for name, tech_name in pairs(raw_materials) do
  deadlock_crating.add_crate(name, tech_name)
end


-- Change uranium stacking to tier 2
bzutil.remove_recipe_effect(IC_PREFIX.."3", IC_LOAD.."uranium-ore")
bzutil.remove_recipe_effect(IC_PREFIX.."3", IC_UNLOAD.."uranium-ore")
bzutil.remove_recipe_effect(IC_PREFIX.."3", IC_LOAD.."uranium-235")
bzutil.remove_recipe_effect(IC_PREFIX.."3", IC_UNLOAD.."uranium-235")
bzutil.remove_recipe_effect(IC_PREFIX.."3", IC_LOAD.."uranium-238")
bzutil.remove_recipe_effect(IC_PREFIX.."3", IC_UNLOAD.."uranium-238")

bzutil.add_unlock(IC_PREFIX.."2", IC_LOAD.."uranium-ore")
bzutil.add_unlock(IC_PREFIX.."2", IC_UNLOAD.."uranium-ore")
bzutil.add_unlock(IC_PREFIX.."2", IC_LOAD.."uranium-235")
bzutil.add_unlock(IC_PREFIX.."2", IC_UNLOAD.."uranium-235")
bzutil.add_unlock(IC_PREFIX.."2", IC_LOAD.."uranium-238")
bzutil.add_unlock(IC_PREFIX.."2", IC_UNLOAD.."uranium-238")

-- Change battery stacking to tier 2
bzutil.remove_recipe_effect(IC_PREFIX.."3", IC_LOAD.."battery")
bzutil.remove_recipe_effect(IC_PREFIX.."3", IC_UNLOAD.."battery")

bzutil.add_unlock(IC_PREFIX.."2", IC_LOAD.."battery")
bzutil.add_unlock(IC_PREFIX.."2", IC_UNLOAD.."battery")


local function update_description_stack_size(description, stack_size)
  if not description then return end
  if type(description) ~= "table" then return end
  if description[1] == "description.stack-size" or description[1] == "other.stack-size-description" then
    -- Extended Descriptions and Stack Size Tooltip
    description[2] = stack_size
  end
  for _, item in pairs(description) do
    update_description_stack_size(item, stack_size)
  end
end

for _, item in pairs(data.raw.item) do
  -- Update stack size descriptions added by other mods because we run in data-final-fixes
  update_description_stack_size(item.localised_description, tostring(item.stack_size))
end
