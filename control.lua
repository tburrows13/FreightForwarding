require "util"
require "scripts.container-limitations"
require "scripts.milestones"
require "scripts.seismic-scanning"
require "scripts.dredging-platform"
local CollisionTest = require "scripts.collision-test"

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

local function seamount_created(seamount)
  seamount.amount = 1

  -- Resources are created centered on a tile, we need to change that, and teleport it to a 2x2-tile position
  local position = seamount.position
  local x = math.floor(position.x)
  local y = math.floor(position.y)
  if x % 2 == 1 then
    x = x + 1
  end
  if y % 2 == 1 then
    y = y + 1
  end
  seamount.teleport{x = x, y = y}
end

script.on_event(defines.events.on_script_trigger_effect,
  function(event)
    --game.print("Lava pool created!")
    if event.effect_id == "ff-lava-pool-created" then
      local lava_pool = event.target_entity
      lava_pool_created(lava_pool)
    elseif event.effect_id == "ff-dredger-created" then
      local dredger = event.target_entity
      dredger_created(dredger)
    elseif event.effect_id == "ff-seamount-created" then
      local seamount = event.target_entity
      seamount_created(seamount)
    end
  end
)

-- Recover empty batteries when mining discharging station
local function recover_burnt_result(event)
  local entity = event.entity
  local buffer = event.buffer
  if entity and buffer then
    local burner = entity.burner
    if burner then
      local burning = burner.currently_burning
      if burning then
        local burnt_result = burning.burnt_result
        if burnt_result then
          event.buffer.insert{name=burnt_result.name,count=1}
        end
      end
    end
  end
end
script.on_event(defines.events.on_player_mined_entity, recover_burnt_result)
script.on_event(defines.events.on_robot_mined_entity, recover_burnt_result)

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
    CollisionTest.run()
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
  function(changed_data)
    CollisionTest.run()
    for _, force in pairs(game.forces) do
      force.reset_technology_effects()
    end
    for _, surface in pairs(game.surfaces) do
      for _, entity in pairs(surface.find_entities_filtered{type = "assembling-machine", name = {"ff-lava-pool", "ff-lava-pool-small"}, force = "player"}) do
        entity.destructible = false
      end
    end

    local old_version
    local mod_changes = changed_data.mod_changes
    if mod_changes and mod_changes["FreightForwarding"] and mod_changes["FreightForwarding"]["old_version"] then
      old_version = mod_changes["FreightForwarding"]["old_version"]
    else
      return
    end

    old_version = util.split(old_version, ".")
    for i=1,#old_version do
      old_version[i] = tonumber(old_version[i])
    end
    if old_version[1] == 1 then
      if old_version[2] <= 5 then
        -- Run on 1.5.0 load
        for _, force in pairs(game.forces) do
          if force.technologies["railway"].researched then
            force.print("[Freight Forwarding] This update changes trains to use batteries rather than burnable fuel. If you wish to revert this behaviour so that your existing factory continues to run, you can do so from [font=default-large-semibold]Main Menu > Settings > Mod settings > Startup[/font]")
          end
        end
      end
    end
  end
)
