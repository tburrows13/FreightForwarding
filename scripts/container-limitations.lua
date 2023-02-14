local function is_container(name)
  return name == "ff-container" or name:sub(1, 15) == "deadlock-crate-"
end

local function is_filled_container(name)
  return name:sub(1, 15) == "deadlock-crate-"
end

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
      if is_container(name) then
        clear_logistic_slot(entity, event.slot_index)
        local player = game.get_player(event.player_index)
        if player then
          player.create_local_flying_text{
            text = {"freight-forwarding.containers-too-heavy"},
            create_at_cursor = true,
          }
        else
          entity.force.print({"freight-forwarding.containers-too-heavy"})
        end
      end
    end
  end
)

-- Logistic chests don't raise events when their requests slots are changed
local function check_requester_slots(entity)
  local slots_cleared = false
  for i = 1, entity.request_slot_count do
    local slot = entity.get_request_slot(i)
    if slot and is_container(slot.name) then
      entity.clear_request_slot(i)
      -- If request slot is set by circuit network, then clearing it has no effect.
      -- Ignore exploit for now - in future could disconnect circuit wire or set mode off "Set requests".
      if not entity.get_request_slot(i) then
        slots_cleared = true
      end
    end
  end

  -- Logistic storage chests
  for i = 1, entity.filter_slot_count do
    local name = entity.get_filter(i)
    if name and is_container(name) then
      entity.set_filter(i, nil)
      slots_cleared = true
    end
  end

  return slots_cleared
end

script.on_event(defines.events.on_entity_settings_pasted,
  function(event)
    local entity = event.destination
    if entity.type == "logistic-container" then
      if check_requester_slots(entity) then
        local player = game.get_player(event.player_index)
        player.create_local_flying_text{
          text = {"freight-forwarding.containers-too-heavy"},
          create_at_cursor = true,
        }
      end
    end
  end
)

local function check_spidertron_inventory(entity)
  local items_spilled = false
  for _, inventory_defines in pairs({defines.inventory.spider_trunk, defines.inventory.spider_trash}) do
    local inventory = entity.get_inventory(inventory_defines)
    local contents = inventory.get_contents()
    for name, count in pairs(contents) do
      if is_filled_container(name) then
        local removed = inventory.remove({name = name, count = count})
        if removed > 0 then
          items_spilled = true
          local spilled = entity.surface.spill_item_stack(entity.position, {name = name, count = removed}, true, nil, false)
          if not next(spilled) then
            game.print("Error: could not spill container from spidertron")
          end
        end
      end
    end
  end
  return items_spilled
end

script.on_event(defines.events.on_player_fast_transferred,
  function(event)
    local entity = event.entity
    if entity.type == "spider-vehicle" then
      if check_spidertron_inventory(entity) then
        local player = game.get_player(event.player_index)
        player.create_local_flying_text{
          text = {"freight-forwarding.containers-in-spider-vehicles-by-player"},
          create_at_cursor = true,
        }
      end
    end
  end
)

-- If player presses Z over a spidertron
script.on_event(defines.events.on_player_cursor_stack_changed,
  function(event)
    local player = game.get_player(event.player_index)
    local entity = player.selected
    if entity and entity.type == "spider-vehicle" then
      if check_spidertron_inventory(entity) then
        player.create_local_flying_text{
          text = {"freight-forwarding.containers-in-spider-vehicles-by-player"},
          create_at_cursor = true,
        }
      end
    end
  end
)


script.on_event(defines.events.on_tick,
  function(event)
    for _, player in pairs(game.players) do
      local entity = player.opened
      if entity then
        if entity.type == "logistic-container" then
          if check_requester_slots(entity) then
            player.create_local_flying_text{
              text = {"freight-forwarding.containers-too-heavy"},
              create_at_cursor = true,
            }
          end
        elseif entity.type == "spider-vehicle" then
          if check_spidertron_inventory(entity) then
            player.create_local_flying_text{
              text = {"freight-forwarding.containers-in-spider-vehicles-by-player"},
              create_at_cursor = true,
            }
          end
        end
      end
    end
  end
)