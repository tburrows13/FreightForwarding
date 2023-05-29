local function add_square(x, y, tiles)
  for i = 0, 1 do
    for j = 0, 1 do
      table.insert(tiles, {name = "ff-dredging-platform", position = {x + i, y + j}})
    end
  end
end

function dredger_created(dredger)
  local force = dredger.force
  local surface = dredger.surface
  local position = dredger.position
  dredger.destroy()
  local seamount = surface.find_entity("ff-seamount", position)
  seamount.destroy()
  local created = surface.create_entity{
    name = "ff-dredger",
    position = position,
    force = force,
    create_build_effect_smoke = false,
  }
  created.destructible = false

  local pole = surface.create_entity{
    name = "ff-dredger-pole",
    position = position,
    force = force,
    create_build_effect_smoke = false,
  }
  pole.destructible = false

  local radar = surface.create_entity{
    name = "ff-dredger-radar",
    position = position,
    force = force,
    create_build_effect_smoke = false,
  }
  radar.destructible = false

  local x = position.x
  local y = position.y
  local tiles = {}
  for i = -9, 8 do
    for j = -9, 8 do
      table.insert(tiles, {name = "ff-dredging-platform", position = {x + i, y + j}})
    end
  end
  -- Add 'piers'
  for _, i in pairs({-9, -1, 7}) do
    for _, j in pairs({-11, 9}) do
      add_square(x + i, y + j, tiles)
      add_square(x + j, y + i, tiles)
    end
  end

  surface.set_tiles(tiles, true, false)
end