if not mods["Rocket-Silo-Construction"] then return end

x_util.replace_ingredient("rsc-construction-stage5", "steel-plate", "ff-titansteel-plate")

if mods["Mining-Space-Industries-II"] or mods["LunarLandings"] or mods["space-exploration"] then return end

local rocket_silo_item = data.raw["item"]["rsc-excavation-site"]
rocket_silo_item.place_result = "ff-rocket-silo-dummy"
