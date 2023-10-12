local function on_rocket_silo_hole_created(event)
  game.print("Rocket silo hole created!")
  local rocket_silo = event.target_entity
  rocket_silo.amount = 1
  rocket_silo.destructible = false

  rocket_silo.surface.destroy_decoratives{
    area = rocket_silo.bounding_box,
  }
end

local function on_rocket_silo_created(event)
  local rocket_silo = event.target_entity
  local force = rocket_silo.force
  local surface = rocket_silo.surface
  local position = rocket_silo.position
  rocket_silo.destroy()
  local rocket_silo = surface.create_entity{
    name = game.active_mods["Rocket-Silo-Construction"] and "rsc-silo-stage1" or "rocket-silo",
    position = position,
    force = force,
    create_build_effect_smoke = false,
  }
end

local function on_script_trigger_effect(event)
  if event.effect_id == "ff-rocket-silo-hole-created" then on_rocket_silo_hole_created(event) end
  if event.effect_id == "ff-rocket-silo-created" then on_rocket_silo_created(event) end
end

local function on_configuration_changed(event)
  if event.mod_changes["FreightForwarding"] then
    for _, force in pairs(game.forces) do
      force.reset_recipes()
      force.reset_technologies()
    end
  end
end

---@type ScriptLib
local RocketSilo = {}

RocketSilo.events = {
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect
}

RocketSilo.on_init = function()
  for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered{type = "resource", name = "ff-rocket-silo-hole", force = "neutral"}) do
      on_rocket_silo_hole_created({ target_entity = entity })
    end
  end
end

return RocketSilo
