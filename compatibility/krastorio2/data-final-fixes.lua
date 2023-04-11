if not mods["Krastorio2"] then return end

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

data.raw["item-subgroup"]["ic-load-terrain"].order = "a[load]-a-c"
data.raw["item-subgroup"]["ic-unload-terrain"].order = "b[unload]-a-c"

data.raw["item-subgroup"]["ic-load-logistic-network"].order = "a[load]-k"
data.raw["item-subgroup"]["ic-unload-logistic-network"].order = "b[unload]-k"

data.raw["item-subgroup"]["ic-load-space-related"].order = "a[load]-m"
data.raw["item-subgroup"]["ic-unload-space-related"].order = "b[unload]-m"

data.raw["item-subgroup"]["ic-load-ammo"].order = "a[load]-n"
data.raw["item-subgroup"]["ic-unload-ammo"].order = "b[unload]-n"

data.raw["item-subgroup"]["ic-load-railgun-turret"].order = "a[load]-o"
data.raw["item-subgroup"]["ic-unload-railgun-turret"].order = "b[unload]-o"

data.raw["item-subgroup"]["ic-load-rocket-turret"].order = "a[load]-p"
data.raw["item-subgroup"]["ic-unload-rocket-turret"].order = "b[unload]-p"
