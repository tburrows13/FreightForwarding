if script.active_mods["Mining-Space-Industries-II"] or script.active_mods["LunarLandings"] or script.active_mods["space-exploration"] then return end

for _, surface in pairs(game.surfaces) do
  surface.regenerate_entity("ff-rocket-silo-hole")
end
