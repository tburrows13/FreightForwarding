local function add_tile_circle(tiles, position, radius, tile_name)
  for i = -radius, radius do
    for j = -radius, radius do
      if i * i + j * j < radius * radius then
        table.insert(tiles, {name = tile_name, position = {position.x + i, position.y + j}})
      end
    end
  end
end

local function on_seamount_created(event)
  if event.effect_id ~= "ff-seamount-created" then return end

  local seamount = event.target_entity
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
  position = {x = x, y = y}
  seamount.teleport{x = x, y = y}

  -- Create regular water 'blob' around it
  local radius = 6.5
  local tiles = {}
  add_tile_circle(tiles, position, radius, "water")

  local rng = game.create_random_generator((x * seamount.surface.map_gen_settings.seed + y) % 10000000)
  for _ = 1, 10 do
    local theta = rng() * 2 * math.pi
    local distance = 1.5 + rng() * 5
    local blob_radius = 0.5 + rng() * 3
    local blob_position = {
      x = x + distance * math.cos(theta),
      y = y + distance * math.sin(theta)
    }
    add_tile_circle(tiles, blob_position, blob_radius, "water")
  end
  seamount.surface.set_tiles(tiles, true, false, false)
end

---@type ScriptLib
local Seamount = {}

Seamount.events = {
  [defines.events.on_script_trigger_effect] = on_seamount_created
}

return Seamount

