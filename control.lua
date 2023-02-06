local function get_logistic_slot(entity, slot_index)
  if entity.type == "character" then
    return entity.get_personal_logistic_slot(slot_index)
  elseif entity.type == "spider-vehicle" then
    return entity.get_vehicle_logistic_slot(slot_index)
  end
end

local function clear_logistic_slot(entity, slot_index)
  if entity.type == "character" then
    entity.clear_personal_logistic_slot(slot_index)
  elseif entity.type == "spider-vehicle" then
    entity.clear_vehicle_logistic_slot(slot_index)
  end
end


script.on_event(defines.events.on_entity_logistic_slot_changed,
  function(event)
    local entity = event.entity
    local slot = get_logistic_slot(entity, event.slot_index)
    local name = slot.name
    if name and slot.max > 0 then
      if name:sub(1, 15) == "deadlock-crate-" then
        clear_logistic_slot(entity, event.slot_index)
        local player = game.get_player(event.player_index)
        if player then
          player.print({"x-mod.logistic-slot-set-to-container"})
        else
          entity.force.print({"x-mod.logistic-slot-set-to-container"})
        end
      end
    end
  end
)

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
