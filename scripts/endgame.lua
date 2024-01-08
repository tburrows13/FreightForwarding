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

    if remote.interfaces["better-victory-screen"] and remote.interfaces["better-victory-screen"]["trigger_victory"] then
      remote.call("better-victory-screen", "trigger_victory", rocket.force)
    else
      game.set_game_state{
        game_finished = true,
        player_won = true,
        can_continue = true,
        victorious_force = rocket.force
      }
    end

  end
end

local function disable_rocket_victory()
  if interfering_mods() then return end

  for interface, functions in pairs(remote.interfaces) do
    if (functions["set_no_victory"] ~= nil) then
      remote.call(interface, "set_no_victory", true)
    end
  end

  if remote.interfaces["freeplay"] and remote.interfaces["freeplay"]["set_custom_intro_message"] then
    remote.call("freeplay", "set_custom_intro_message", {"freight-forwarding.msg-intro"})
  end
end

---@param winning_force LuaForce the force that triggered the victory
---@param forces LuaForce[] list of forces victory screen will be shown to
---@return unknown
local function better_victory_screen_statistics(winning_force, forces)
  local statistics = { by_force = { } }
  for _, force in pairs(forces) do
    local containers_created = force.item_production_statistics.get_input_count("ic-container")
    statistics.by_force[force.name] = {
      -- Add it to the existing production category
      ["production"] = { stats = {
        ["containers"] = { value = containers_created, order = "p"},
      }}
    }
  end
  return statistics
end

---@type ScriptLib
local Endgame = {}

Endgame.events = {
  [defines.events.on_rocket_launched] = on_rocket_launched
}

Endgame.add_remote_interface = function()
	remote.add_interface("FreightForwarding", {
    ["better-victory-screen-statistics"] = function(winning_force, forces)
      return better_victory_screen_statistics(winning_force, forces)
    end
  })
end

Endgame.on_init = disable_rocket_victory
Endgame.on_configuration_changed = disable_rocket_victory

return Endgame