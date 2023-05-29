local function interfering_mods()
  return script.active_mods["Krastorio2"] or script.active_mods["SpaceMod"]
end

local function on_rocket_launched(event)
  if interfering_mods() then return end

  local rocket = event.rocket
  if not (rocket and rocket.valid) then return end
  
  if game.finished or game.finished_but_continuing then return end

  local inventory = rocket.get_inventory(defines.inventory.rocket)
  if inventory.get_item_count("ff-interstellar-communicator") > 0 then
    game.set_game_state{
      game_finished = true,
      player_won = true,
      can_continue = true,
      victorious_force = rocket.force
    }
  end
end

local function disable_rocket_vistory()
  if interfering_mods() then return end
  
  if remote.interfaces["silo_script"] and remote.interfaces["silo_script"]["set_no_victory"] then
    remote.call("silo_script", "set_no_victory", true)
  end
  if remote.interfaces["freeplay"] and remote.interfaces["freeplay"]["set_custom_intro_message"] then
    remote.call("freeplay", "set_custom_intro_message", {"freight-forwarding.msg-intro"})
  end
end

---@type ScriptLib
local Endgame = {}

Endgame.events = {
  [defines.events.on_rocket_launched] = on_rocket_launched
}

Endgame.on_init = disable_rocket_vistory
Endgame.on_configuration_changed = disable_rocket_vistory

return Endgame