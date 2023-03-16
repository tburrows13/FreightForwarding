local seconds = 60
local sims = data.raw["utility-constants"]["default"].main_menu_simulations

-- disable vanilla sims

sims.solar_power_construction = nil
sims.lab = nil
sims.burner_city = nil
sims.mining_defense = nil
sims.forest_fire = nil
sims.oil_pumpjacks = nil
sims.oil_refinery = nil
sims.early_smelting = nil
sims.train_station = nil
sims.logistic_robots = nil
sims.nuclear_power = nil
sims.train_junction = nil
sims.artillery = nil
sims.biter_base_spidertron = nil
sims.biter_base_artillery = nil
sims.biter_base_laser_defense = nil
sims.biter_base_player_attack = nil
sims.biter_base_steamrolled = nil
sims.chase_player = nil
sims.big_defense = nil
sims.brutal_defeat = nil
sims.spider_ponds = nil

-- sims.name = 
-- {
--   checkboard = false,
--   save = "__mod__/path/name-of-save.zip",
--   save = "__FreightForwarding__/simulations/name.zip",
--   length = 11.5 * seconds,
--   init =
--   [[
--     local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
--     game.camera_position = {logo.position.x, logo.position.y+9.75}
--     game.camera_zoom = 1
--     game.tick_paused = false
--     game.surfaces.nauvis.daytime = 1
--   ]],
-- }

sims.lead_mine = 
{
  checkboard = false,
  save = "__FreightForwarding__/simulations/leadMine.zip",
  length = 14 * seconds,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-16tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+9.75}
    game.camera_zoom = 1
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 1
  ]],
}

sims.oil_rigs = 
{
  checkboard = false,
  save = "__FreightForwarding__/simulations/oilRigs.zip",
  length = 10 * seconds,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-22tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+9.75}
    game.camera_zoom = 1
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0

    local function powerOilRig(e)
      if e.tick % 120 == 0 then
        if global.or_generators == nil then
          global.or_generators = {}
          for _, surface in pairs(game.surfaces) do
            for _, generator in pairs(surface.find_entities_filtered{name="or_power"}) do
              table.insert(global.or_generators, generator)
            end
          end
        end
        for i, generator in pairs(global.or_generators) do
          if(generator.valid) then
            generator.fluidbox[1] = {name="steam", amount = 200, temperature=165}
          else
            --game.players[1].print("found invalid")
            table.remove(global.or_generators,i)
          end
        end
      end
    end
    script.on_event(defines.events.on_tick, powerOilRig)
  ]],
}


sims.titansteel = 
{
  checkboard = false,
  save = "__FreightForwarding__/simulations/titansteel.zip",
  length = 10 * seconds,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+9.75}
    game.surfaces.nauvis.daytime = 0.5
    game.camera_zoom = 1
    game.tick_paused = false
  ]],
}

sims.spaghetti = 
{
  checkboard = false,
  save = "__FreightForwarding__/simulations/spaghetti.zip",
  length = 10 * seconds,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-16tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+9.75}
    game.camera_zoom = 0.9
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0.75
  ]],
}

sims.boat_to_trains = 
{
  checkboard = false,
  save = "__FreightForwarding__/simulations/boatToTrains.zip",
  length = 27 * seconds,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-22tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+15.272}
    game.camera_zoom = 0.75
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0
  ]],
}

sims.many_trains = 
{
  checkboard = false,
  save = "__FreightForwarding__/simulations/manyTrains.zip",
  length = 10 * seconds,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-11tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+9.75}
    game.camera_zoom = 1
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0
  ]],
}

sims.dredging = 
{
  checkboard = false,
  save = "__FreightForwarding__/simulations/Dredging.zip",
  length = 10 * seconds,
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "factorio-logo-16tiles", limit = 1}[1]
    game.camera_position = {logo.position.x, logo.position.y+15.272}
    game.camera_zoom = 0.75
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0.15
  ]],
}