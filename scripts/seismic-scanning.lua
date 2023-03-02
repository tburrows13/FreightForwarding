local scanner_range = 24
local min_tiles_from_water = 16

local function to_chunk_position(map_position)
  return { math.floor(map_position.x / 32), math.floor(map_position.y / 32) }
end

local function to_map_position(chunk_position)
  return { chunk_position[1] * 32 + 16, chunk_position[2] * 32 + 16 }
end

local function chunk_position_to_area(chunk_position)
  return {
    left_top = {chunk_position[1] * 32, chunk_position[2] * 32},
    right_bottom = {chunk_position[1] * 32 + 32, chunk_position[2] * 32 + 32},
  }
end

local function position_to_str(position)
  return position[1] .. "," .. position[2]
end

local function str_to_position(str)
  local x, y = str:match("^(%-?%d+),(%-?%d+)$")
  return {tonumber(x), tonumber(y)}
end

local function is_chunk_land(chunk_position, surface)
  -- 1024 tiles in a chunk
  local area = chunk_position_to_area(chunk_position)
  local ground_tiles = surface.count_tiles_filtered{area = area, collision_mask = "ground-tile"}
  return ground_tiles > 128
end

local function is_chunk_in_range(chunk_position, scanner_position)
  return math.abs(chunk_position[1] - scanner_position[1]) <= scanner_range and math.abs(chunk_position[2] - scanner_position[2]) <= scanner_range
end

local function get_scanner_data(scanner)
  local unit_number = scanner.unit_number
  global.scanner_data = global.scanner_data or {}
  if not global.scanner_data[unit_number] then
    local chunk_position = to_chunk_position(scanner.position)
    global.scanner_data[unit_number] = {explored_chunks = {}, to_be_explored_chunks = {[position_to_str(chunk_position)] = true}}
  end
  return global.scanner_data[unit_number]
end

local function neighbouring_chunks(chunk_position)
  return {
    {chunk_position[1] - 1, chunk_position[2]},
    {chunk_position[1], chunk_position[2] - 1},
    {chunk_position[1], chunk_position[2] + 1},
    {chunk_position[1] + 1, chunk_position[2]},
  }
end

local function on_sector_scanned(event)
  -- Raised when radar does scan, but the scanner prototype has a very small radius
  -- so that the actual chunk scan is done by the following script
  local scanner = event.radar
  local surface = scanner.surface
  local scanner_chunk_position = to_chunk_position(scanner.position)

  local scanner_data = get_scanner_data(scanner)

  local chunk_str = next(scanner_data.to_be_explored_chunks)
  if chunk_str then
    local chunk = str_to_position(chunk_str)

    scanner.force.chart(scanner.surface, chunk_position_to_area(chunk))

    scanner_data.explored_chunks[chunk_str] = true
    scanner_data.to_be_explored_chunks[chunk_str] = nil
    if is_chunk_land(chunk, surface) then
      -- Add neighbouring chunks to to_be_explored_chunks
      for _, neighbouring_chunk in pairs(neighbouring_chunks(chunk)) do
        if is_chunk_in_range(neighbouring_chunk, scanner_chunk_position) then
          local neighbouring_chunk_str = position_to_str(neighbouring_chunk)
          if not scanner_data.explored_chunks[neighbouring_chunk_str] then
            scanner_data.to_be_explored_chunks[neighbouring_chunk_str] = true
          end
        end
      end
    end
  else
    global.scanner_data[scanner.unit_number] = nil
    on_sector_scanned(event)
  end
end

script.on_event(defines.events.on_sector_scanned, on_sector_scanned, {{filter = "name", name = "ff-seismic-scanner"}})

local function on_scanner_built(event)
  -- Disable scanner if within 16 tiles of water
  local scanner = event.created_entity
  scanner.backer_name = ""
  local surface = scanner.surface
  local water_tile_count = surface.count_tiles_filtered{position = scanner.position, radius = min_tiles_from_water, collision_mask = "water-tile", limit = 1}
  if water_tile_count > 0 then
    scanner.active = false
    if event.player_index then
      game.get_player(event.player_index).create_local_flying_text({text = {"freight-forwarding.seismic-scanner-too-close-to-water", min_tiles_from_water}, create_at_cursor = true})
    end
  end
end

script.on_event(defines.events.on_built_entity, on_scanner_built, {{filter = "name", name = "ff-seismic-scanner"}})
script.on_event(defines.events.on_robot_built_entity, on_scanner_built, {{filter = "name", name = "ff-seismic-scanner"}})
