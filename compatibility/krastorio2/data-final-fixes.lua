if not mods["Krastorio2"] then return end

local util = require "__FreightForwarding__.prototypes.data-util"
local bzutil = require "__bzlead__.data-util"

-- Adjust lead requirements for k2 ammos, moved to piercing- types
if settings.startup["ff-k2-no-lead-ammo"].value then
  bzutil.replace_ingredient("rifle-magazine", "lead-plate", "iron-plate")
  bzutil.add_ingredient("armor-piercing-rifle-magazine", "lead-plate", 2)

  bzutil.replace_ingredient("anti-material-rifle-magazine", "lead-plate", "iron-plate")
  bzutil.add_ingredient("armor-piercing-anti-material-rifle-magazine", "lead-plate", 3)
else
  for name, rock in pairs(data.raw["simple-entity"]) do
    if name:match('rock') and rock.minable then
      local results = {}
      if rock.minable.result then
        results = {{ rock.minable.result, rock.minable.count or 1 }}
        rock.minable.result = nil
        rock.minable.count = nil
      end
      if rock.minable.results then
        results = rock.minable.results
      end
      results[#results+1] = { name = 'lead-ore', amount_min = 12, amount_max = 28 }
      rock.minable.results = results
    end
  end
end

-- -- Reorder containers recipes
-- "a[load]-a"   = "ic-load-fluid-recipes"
-- "a[load]-a-b" = "ic-load-fuel-processing"
-- "a[load]-a-c" = "ic-load-terrain"
-- "a[load]-b"   = "ic-load-raw-resource"
-- "a[load]-c"   = "ic-load-raw-material"
-- "a[load]-d"   = "ic-load-barrel"
-- "a[load]-e"   = "ic-load-fill-barrel"
-- "a[load]-f"   = "ic-load-empty-barrel"
-- "a[load]-g"   = "ic-load-intermediate-product"
-- "a[load]-h"   = "ic-load-science-pack"
-- "a[load]-k"   = "ic-load-logistic-network"
-- "a[load]-m"   = "ic-load-space-related"
-- "a[load]-n"   = "ic-load-ammo" 
-- "a[load]-o"   = "ic-load-railgun-turret"
-- "a[load]-p"   = "ic-load-rocket-turret"

util.set_item_subgroup_order("ic-load-terrain", "a[load]-a-c")
util.set_item_subgroup_order("ic-unload-terrain", "b[unload]-a-c")

util.set_item_subgroup_order("ic-load-logistic-network", "a[load]-k")
util.set_item_subgroup_order("ic-unload-logistic-network", "b[unload]-k")

util.set_item_subgroup_order("ic-load-space-related", "a[load]-m")
util.set_item_subgroup_order("ic-unload-space-related", "b[unload]-m")

util.set_item_subgroup_order("ic-load-ammo", "a[load]-n")
util.set_item_subgroup_order("ic-unload-ammo", "b[unload]-n")

util.set_item_subgroup_order("ic-load-railgun-turret", "a[load]-o")
util.set_item_subgroup_order("ic-unload-railgun-turret", "b[unload]-o")

util.set_item_subgroup_order("ic-load-rocket-turret", "a[load]-p")
util.set_item_subgroup_order("ic-unload-rocket-turret", "b[unload]-p")
