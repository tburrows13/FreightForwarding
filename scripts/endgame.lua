local function interfering_mods()
  return script.active_mods["Krastorio2"] or script.active_mods["SpaceMod"]
end

local function on_rocket_launched(event)
  if interfering_mods() then return end

  local rocket = event.rocket
  if not (rocket and rocket.valid) then return end
  local force = rocket.force

  if game.finished or game.finished_but_continuing or global.finished[force.name] then return end
  global.finished[force.name] = true

  local inventory = rocket.get_inventory(defines.inventory.rocket)
  if inventory.get_item_count("ff-interstellar-communicator") > 0 then

    if remote.interfaces["better-victory-screen"] and remote.interfaces["better-victory-screen"]["trigger_victory"] then
      remote.call("better-victory-screen", "trigger_victory", force)
    else
      game.set_game_state{
        game_finished = true,
        player_won = true,
        can_continue = true,
        victorious_force = force
      }
    end

  end
end

local function disable_rocket_victory()
  -- Keep track if if force has achieved victory. This is good practice,
  -- and also BVS does not mark the game as finished.
  ---@type table<string, boolean> where the key is the force name
  global.finished = global.finished or { }

  -- We do this always to improve some compat with BVS and K2
  -- while K2 doesn't support BVS yet.
  -- Technically we should only set the no_victory if FF will handle
  -- the victory itself when there are no interfering mods. But it's
  -- a safe assumption to make that the interfering mods will set no_victory
  -- anyway. 
  for interface, functions in pairs(remote.interfaces) do
    if (functions["set_no_victory"] ~= nil) then
      remote.call(interface, "set_no_victory", true)
    end
  end

  if interfering_mods() then return end

  if remote.interfaces["freeplay"] and remote.interfaces["freeplay"]["set_custom_intro_message"] then
    remote.call("freeplay", "set_custom_intro_message", {"freight-forwarding.msg-intro"})
  end
end

---@type ScriptLib
local Endgame = {}

Endgame.events = {
  [defines.events.on_rocket_launched] = on_rocket_launched
}

Endgame.on_init = disable_rocket_victory
Endgame.on_configuration_changed = disable_rocket_victory

return Endgame