local function on_lava_pool_machine_created(event)
  local created = event.target_entity
  created.destructible = false
  if created.name == "ff-lava-pool" then
    rendering.draw_animation{
      animation = "ff-lava-pool-animation",
      target = created,
      surface = created.surface,
      render_layer = "lower-object-above-shadow",
      animation_offset = math.floor(math.random() * 10),
    }
  else
    rendering.draw_animation{
      animation = "ff-lava-pool-small-animation",
      target = created,
      surface = created.surface,
      render_layer = "lower-object-above-shadow",
      animation_offset = math.floor(math.random() * 10),
    }
  end
end

local function on_lava_pool_resource_created(event)
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
  if not created then
    lava_pool.destroy()
  end
end

local function on_lava_pool_created(event)
  if event.effect_id == "ff-lava-pool-resource-created" then
    on_lava_pool_resource_created(event)
  elseif event.effect_id == "ff-lava-pool-machine-created" then
    on_lava_pool_machine_created(event)
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
      on_lava_pool_resource_created({ target_entity = entity })
    end
    for _, entity in pairs(surface.find_entities_filtered{type = "resource", name = {"ff-lava-pool", "ff-lava-pool-small"}, force = "neutral"}) do
      on_lava_pool_machine_created({ target_entity = entity })
    end
  end
end

return LavaPool