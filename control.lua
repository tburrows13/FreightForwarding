local function print_warning()
  if game.tick > 0 then
    if game.default_map_gen_settings.property_expression_names.elevation ~= "x-continents" then
      game.print({"x-mod.warn-nondefault-mapgen", {"map-gen-preset-name.x-default"}})
    end
    script.on_nth_tick(300, nil)
  end
end

script.on_init(
  function()
    script.on_nth_tick(300, print_warning)
  end
)

script.on_configuration_changed(
  function()
    for _, force in pairs(game.forces) do
      force.reset_technology_effects()
    end
  end
)

-- Temporary Power Overload fix
script.on_event(defines.events.on_player_created,
  function(event)
    if game.active_mods["PowerOverload"] then
      local player = game.get_player(event.player_index)
      player.set_shortcut_toggled("po-auto-connect-poles", true)
    end
  end
)
