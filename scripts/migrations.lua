require "util"

---@type ScriptLib
local Migrations = {}

Migrations.on_configuration_changed = function(changed_data)
  for _, force in pairs(game.forces) do
    force.reset_technology_effects()
  end
  
  local old_version
  local mod_changes = changed_data.mod_changes
  if mod_changes and mod_changes["FreightForwarding"] and mod_changes["FreightForwarding"]["old_version"] then
    old_version = mod_changes["FreightForwarding"]["old_version"]
  else
    return
  end

  old_version = util.split(old_version, ".")
  if tonumber(old_version[1]) == 1 then
    if tonumber(old_version[2]) <= 5 then
      -- Run on 1.5.0 load
      for _, force in pairs(game.forces) do
        if force.technologies["railway"].researched then
          force.print("[Freight Forwarding] This update changes trains to use batteries rather than burnable fuel. If you wish to revert this behaviour so that your existing factory continues to run, you can do so from [font=default-large-semibold]Main Menu > Settings > Mod settings > Startup[/font]")
        end
      end
    end
  end
end

return Migrations