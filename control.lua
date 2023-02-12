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

local function lava_pool_created(lava_pool)
  lava_pool.amount = 1
  local surface = lava_pool.surface
  local position = lava_pool.position
  local created = false
  if math.random() > 0.4 then
    if surface.can_place_entity{name = "ff-lava-pool", position = position, force = "neutral"} then
      created = surface.create_entity{name = "ff-lava-pool", position = position, force = "neutral", false}
    end
  end
  if not created then
    if surface.can_place_entity{name = "ff-lava-pool-small", position = position, force = "neutral"} then
      created = surface.create_entity{name = "ff-lava-pool-small", position = position, force = "neutral", false}
    end
  end
  if not created then
    game.print("Lava pool destroyed!")
    lava_pool.destroy()
  end
end

script.on_event(defines.events.on_script_trigger_effect,
  function(event)
    game.print("Lava pool created!")
    if event.effect_id == "ff-lava-pool-created" then
      local lava_pool = event.target_entity
      lava_pool_created(lava_pool)
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
    script.on_nth_tick(300, print_warning)  -- Probably desyncs if a player joins within 5 seconds

    --global.rng = game.create_random_generator()

    for _, surface in pairs(game.surfaces) do
      for _, entity in pairs(surface.find_entities_filtered{type = "resource", name = "ff-lava-pool-resource", force = "neutral"}) do
        lava_pool_created(entity)
      end
    end
  end
)

script.on_configuration_changed(
  function()
    for _, force in pairs(game.forces) do
      force.reset_technology_effects()
    end
  end
)
