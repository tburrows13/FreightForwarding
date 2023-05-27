if not mods["Krastorio2"] then return end

local data_util = require "__FreightForwarding__.prototypes.data-util"

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

data_util.set_item_subgroup_order("ic-load-terrain", "a[load]-a-c")
data_util.set_item_subgroup_order("ic-unload-terrain", "b[unload]-a-c")

data_util.set_item_subgroup_order("ic-load-logistic-network", "a[load]-k")
data_util.set_item_subgroup_order("ic-unload-logistic-network", "b[unload]-k")

data_util.set_item_subgroup_order("ic-load-space-related", "a[load]-m")
data_util.set_item_subgroup_order("ic-unload-space-related", "b[unload]-m")

data_util.set_item_subgroup_order("ic-load-ammo", "a[load]-n")
data_util.set_item_subgroup_order("ic-unload-ammo", "b[unload]-n")

data_util.set_item_subgroup_order("ic-load-railgun-turret", "a[load]-o")
data_util.set_item_subgroup_order("ic-unload-railgun-turret", "b[unload]-o")

data_util.set_item_subgroup_order("ic-load-rocket-turret", "a[load]-p")
data_util.set_item_subgroup_order("ic-unload-rocket-turret", "b[unload]-p")
