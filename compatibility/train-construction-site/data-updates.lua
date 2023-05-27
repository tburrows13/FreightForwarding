if not mods["trainConstructionSite"] then return end

local util = require "__FreightForwarding__.prototypes.data-util"
local bzutil = require "__bzlead__.data-util"

-- Move all TCS techs before Transport Science (needed to deploy trains **)
-- > mini-trains get unlocked before FF's Transport Science
-- > all vanilla trains + TCS recipes get unlocked at Adv. Railways
--
-- ** it's important to unlock all TCS techs before Transport Science otherwise player might not be 
--    able to deploy locos/wagons/fluid-wagons if startup settings from TCS dont allow manual placing

--------------------
-- RECIPE UNLOCKS --
--------------------

-- move locomotives from Railways to Adv. Railways
bzutil.remove_recipe_effect("railway", "locomotive-manual-build")
bzutil.add_unlock("ff-advanced-railway", "locomotive-manual-build")

-- move mini-cargo-wagons from Railways to Ta Cargo Wagons
bzutil.remove_recipe_effect("railway", "mini-cargo-wagon")
bzutil.add_unlock("trainassembly-cargo-wagon", "mini-cargo-wagon")
bzutil.remove_recipe_effect("railway", "mini-cargo-wagon-fluid[cargo-wagon]")
bzutil.add_unlock("trainassembly-cargo-wagon", "mini-cargo-wagon-fluid[cargo-wagon]")

-- remove cargo-wagons from Ta Cargo Wagons (already in Adv. Railways)
bzutil.remove_recipe_effect("trainassembly-cargo-wagon", "cargo-wagon")
bzutil.remove_recipe_effect("trainassembly-cargo-wagon", "cargo-wagon-fluid[cargo-wagon]")

-- move locomotives from TaATA to Adv. Railway
bzutil.remove_recipe_effect("trainassembly-automated-train-assembling", "locomotive-fluid[locomotive]")
bzutil.add_unlock("ff-advanced-railway", "locomotive-fluid[locomotive]")

-- move fluid-wagons from Fluid Wagon to Adv. Railway
bzutil.remove_recipe_effect("fluid-wagon", "fluid-wagon-fluid[fluid-wagon]")
bzutil.add_unlock("ff-advanced-railway", "fluid-wagon-fluid[fluid-wagon]")

--- move BBR Cargo Ships recipes to TCS tab
if mods["beautiful_bridge_railway_Cargoships"] then
  for _, item in pairs({ "wood", "iron", "brick" }) do 
    local recipe = data.raw.recipe["bbr-rail-"..item]
    if recipe then recipe.subgroup = "transport-railway" end
  end
end

-----------------------
-- TECH DEPENDENCIES --
-----------------------
-- set Ta Cargo Wagon right after Locos
bzutil.set_prerequisite("trainassembly-cargo-wagon", { "railway" })

-- add TaATA as prereq to Transport Science
util.add_prerequisite("ff-transport-science-pack", "trainassembly-automated-train-assembling")

-- clean tech tree dependencies
util.remove_prerequisite("fluid-wagon", "trainassembly-automated-train-assembling")

-- remove tech prereq. loops introduced by TCS
util.remove_prerequisite("railway", "trainassembly-automated-train-assembling")
util.remove_prerequisite("railway", "trainassembly-cargo-wagon")
util.remove_prerequisite("fluid-wagon", "fluid-wagon")
