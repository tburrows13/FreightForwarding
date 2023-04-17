if script.active_mods["Krastorio2"] or script.active_mods["SpaceMod"] then return end

script.on_event(defines.events.on_rocket_launched, function(event)
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
end)