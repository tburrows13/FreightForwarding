local function on_lava_pool_created(event)
  if event.effect_id ~= "ff-lava-pool-created" then return end
  local lava_pool = event.target_entity
  lava_pool.amount = 1
  local surface = lava_pool.surface
  local position = lava_pool.position
  local created = false
  if math.random() > 0.4 then
    if surface.can_place_entity{name = "ff-lava-pool", position = position, force = "player"} then
      created = surface.create_entity{name = "ff-lava-pool", position = position, force = "player", false}
    end
  end
  if not created then
    if surface.can_place_entity{name = "ff-lava-pool-small", position = position, force = "player"} then
      created = surface.create_entity{name = "ff-lava-pool-small", position = position, force = "player", false}
    end
  end
  if created then
    created.destructible = false
  else
    --game.print("Lava pool destroyed!")
    lava_pool.destroy()
  end
end

---@type ScriptLib
local LavaPool = {}

LavaPool.events = {
  [defines.events.on_script_trigger_effect] = on_lava_pool_created
}

LavaPool.on_init = function()
  for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered{type = "resource", name = "ff-lava-pool-resource", force = "neutral"}) do
      on_lava_pool_created({ event_id = "ff-lava-pool-created", target_entity = entity })
    end
  end
end

LavaPool.on_configuration_changed = function()
  for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered{type = "assembling-machine", name = {"ff-lava-pool", "ff-lava-pool-small"}, force = "player"}) do
      entity.destructible = false
    end
  end
end

return LavaPool