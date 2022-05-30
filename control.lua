script.on_event(defines.events.on_player_created, function(event)
  game.get_player(event.player_index).remove_item{name = "jag-seeds", count = 1}
end)

script.on_event(defines.events.on_cutscene_cancelled, function(event)
  game.get_player(event.player_index).remove_item{name = "jag-seeds", count = 1}
end)


script.on_nth_tick(600,
  function()
    if game.tick ~= 0 then
      if game.default_map_gen_settings.property_expression_names.elevation ~= "IS_0_17-islands+continents" then
        game.print({"x-mod.warn-nondefault-mapgen", {"map-gen-preset-name.x-default"}})
      end
      script.on_nth_tick(600, nil)
    end
  end
)
