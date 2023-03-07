require "scripts.container-limitations"
require "scripts.milestones"
require "scripts.seismic-scanning"

local function lava_pool_created(lava_pool)
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

script.on_event(defines.events.on_script_trigger_effect,
  function(event)
    --game.print("Lava pool created!")
    if event.effect_id == "ff-lava-pool-created" then
      local lava_pool = event.target_entity
      lava_pool_created(lava_pool)
    end
  end
)

local function print_warning()
  if game.tick > 0 then
    if game.default_map_gen_settings.property_expression_names.elevation ~= "x-continents" then
      game.print({"freight-forwarding.warn-nondefault-mapgen", {"map-gen-preset-name.x-default"}})
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
    for _, surface in pairs(game.surfaces) do
      for _, entity in pairs(surface.find_entities_filtered{type = "assembling-machine", name = {"ff-lava-pool", "ff-lava-pool-small"}, force = "player"}) do
        entity.destructible = false
      end
    end
  end
)
