local function print_warning()
  if game.tick > 0 then
    if game.default_map_gen_settings.property_expression_names.elevation ~= "x-continents" then
      game.print({"freight-forwarding.warn-nondefault-mapgen", {"map-gen-preset-name.x-default"}})
    end
    script.on_nth_tick(300, nil)
  end
end

---@type ScriptLib
local Warning = {}

Warning.on_init = function ()
  script.on_nth_tick(300, print_warning)  -- Probably desyncs if a player joins within 5 seconds
end

return Warning