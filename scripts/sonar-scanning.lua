local util = require("scripts/chunk-util")
local entity_name = "ff-sonar-buoy"
local scanner_range = 125

---@class ShadowAngle
---@field start number
---@field length number

---@class SonarScannerData
---@field shadow_angles ShadowAngle[]
---@field explored_chunks table<string, boolean>
---@field explored_chunks_by_radius table<uint, string[]>
---@field to_be_explored_chunks table<string, boolean>
---@field current_radius uint
---@field current_circle_index uint

---@param scanner LuaEntity
---@return SonarScannerData
local function get_scanner_data(scanner)
  local unit_number = scanner.unit_number --[[@as uint]]
  storage.scanner_data = storage.scanner_data or {}
  if not storage.scanner_data[unit_number] then
    local chunk_position = util.to_chunk_position(scanner.position)
    storage.scanner_data[unit_number] = {
      shadow_angles = {},
      explored_chunks = {},
      explored_chunks_by_radius = { {} },
      to_be_explored_chunks = { [util.position_to_str(chunk_position)] = true },
      current_radius = 0,
      current_circle_index = 1,
      current_circle_len = 1,
    }
  end
  return storage.scanner_data[unit_number]
end

---@param radius uint
---@return ChunkPosition[] circle_points, uint point_count
local function get_chunks_circle(radius)
  storage.scanner_circle_cache = storage.scanner_circle_cache or { { points = { { x = 0, y = 0 } }, len = 1 } }
  local bucket = storage.scanner_circle_cache[radius + 1]
  if bucket then
    return bucket.points, bucket.len
  end

  -- thanks to codegreen for the circle spiral algorithm
  bucket = { points = {}, len = 0 }
  local points = bucket.points
  local c = 0
  local pos = { x = 0, y = -radius }

  while pos.y < 0 do
    local dist = math.floor(math.sqrt(pos.x ^ 2 + pos.y ^ 2) + 0.5)
    if dist > radius then
      pos.x = pos.x - 1
      pos.y = pos.y + 1
    else
      if dist == radius then
        c = c + 1
        points[c] = { x = pos.x, y = pos.y }
      end
      pos.x = pos.x + 1
    end
  end

  for i = 1, c do
    local p = points[i]
    points[c * 1 + i] = { x = -p.y, y = p.x }
    points[c * 2 + i] = { x = -p.x, y = -p.y }
    points[c * 3 + i] = { x = p.y, y = -p.x }
  end

  bucket.len = c * 4
  storage.scanner_circle_cache[radius + 1] = bucket
  return bucket.points, bucket.len
end

---@param origin MapPosition|ChunkPosition
---@param target MapPosition|ChunkPosition
---@return number angle The angle in degrees
function get_angle(origin, target)
  local dx = (target.x or target[1]) - (origin.x or origin[1])
  local dy = (target.y or target[2]) - (origin.y or origin[2])
  local rad = math.atan2(dy, dx)

  if rad < 0 then
    rad = rad + 2 * math.pi
  end

  return math.deg(rad)
end

---@param angle number angle to check
---@param segment ShadowAngle
function is_angle_in_segment(angle, segment)
  local end_angle = (segment.start + segment.length) % 360
  if segment.start < end_angle then
    return segment.start <= angle and angle <= end_angle
  else
    return segment.start <= angle or angle <= end_angle
  end
end

---@param scanner_data SonarScannerData
---@param scanner_chunk_position ChunkPosition
---@param scanner_position MapPosition
---@param surface LuaSurface
---@param max_iterations uint?
---@return ChunkPosition? chunk_to_scan, boolean completed, uint iterations
function run_scan(scanner_data, scanner_chunk_position, scanner_position, surface, max_iterations)
  local chunk_str
  local chunk --[[@type ChunkPosition]]
  local iteration = 0
  local radius_increases = 0
  local circle, circle_len = get_chunks_circle(scanner_data.current_radius)
  while not chunk_str do
    iteration = iteration + 1
    if max_iterations and iteration > max_iterations then
      return scanner_chunk_position, false, iteration
    end

    local cc = circle[scanner_data.current_circle_index]
    local check = { cc.x + scanner_chunk_position[1], cc.y + scanner_chunk_position[2] } --[[@type ChunkPosition]]
    local check_str = util.position_to_str(check)

    scanner_data.current_circle_index = scanner_data.current_circle_index + 1
    if scanner_data.current_circle_index > circle_len then
      radius_increases = radius_increases + 1
      if radius_increases > 1 or scanner_data.current_radius > scanner_range then
        -- increased radius twice without finding a chunk to explore
        -- means there are no more chunks to explore
        scanner_data.to_be_explored_chunks = {}
        return nil, true, iteration
      end

      if scanner_data.current_radius >= 2 then
        -- remove inner explored chunks
        local inner_chunks = scanner_data.explored_chunks_by_radius[scanner_data.current_radius - 1] or {}
        for inner, _ in pairs(inner_chunks) do
          scanner_data.explored_chunks[inner] = nil
        end
        scanner_data.explored_chunks_by_radius[scanner_data.current_radius - 1] = nil
      end

      scanner_data.current_radius = scanner_data.current_radius + 1
      scanner_data.current_circle_index = 1
      circle, circle_len = get_chunks_circle(scanner_data.current_radius)
      scanner_data.explored_chunks_by_radius[scanner_data.current_radius + 1] = {}
    end

    if scanner_data.to_be_explored_chunks[check_str] then
      chunk_str = check_str
      chunk = check
      break
    end
  end

  scanner_data.explored_chunks[chunk_str] = true
  table.insert(scanner_data.explored_chunks_by_radius[scanner_data.current_radius + 1], chunk_str)
  scanner_data.to_be_explored_chunks[chunk_str] = nil

  if util.is_chunk_land(chunk, surface) then
    -- sonar hit land, calculate shadow angles
    -- calculating max angle based on the center points of the chunks edges
    local chunk_center = util.to_map_position(chunk)
    local chunk_edges = {
      { chunk_center[1] - 16, chunk_center[2] },
      { chunk_center[1],      chunk_center[2] - 16 },
      { chunk_center[1],      chunk_center[2] + 16 },
      { chunk_center[1] + 16, chunk_center[2] },
    }

    local angles = {}
    for _, edge in pairs(chunk_edges) do
      table.insert(angles, get_angle(scanner_position, edge))
    end

    -- check all angle pair permutations to find the largest shadow
    local shadow = { start = 0, length = 0 }
    for _, pair in pairs({ { 1, 2 }, { 1, 3 }, { 1, 4 }, { 2, 3 }, { 2, 4 }, { 3, 4 } }) do
      local angle1 = angles[pair[1]]
      local angle2 = angles[pair[2]]
      local start = math.min(angle1, angle2)
      local stop = math.max(angle1, angle2)
      local diff = stop - start

      -- if the shadow crosses the 0/360 degree line, adjust the start and diff
      if diff > 180 then
        diff = 360 - diff
        start = stop
      end

      if diff > shadow.length then
        shadow.start = start
        shadow.length = diff
      end
    end

    local start = shadow.start
    local stop = (start + shadow.length) % 360

    for i, segment in pairs(scanner_data.shadow_angles) do
      local merged = false

      if is_angle_in_segment(start, segment) then
        start = segment.start
        merged = true
      end

      if is_angle_in_segment(stop, segment) then
        stop = (segment.start + segment.length) % 360
        merged = true
      end

      if merged then
        scanner_data.shadow_angles[i] = nil
      end
    end

    local diff = stop - start
    if diff < 0 then
      diff = 360 + diff
    end

    shadow.start = start
    shadow.length = diff


    table.insert(scanner_data.shadow_angles, shadow)

    -- TODO: merge overlapping shadows in shadow_angles?
  else
    -- add neighbouring chunks to to_be_explored_chunks
    for _, neighbouring_chunk in pairs(util.neighbouring_chunks(chunk)) do
      if not util.is_chunk_in_range_circle(neighbouring_chunk, scanner_chunk_position, scanner_range) then
        goto continue
      end

      local angle = get_angle(scanner_position, util.to_map_position(neighbouring_chunk))
      for _, shadow in pairs(scanner_data.shadow_angles) do
        if is_angle_in_segment(angle, shadow) then
          goto continue
        end
      end

      local neighbouring_chunk_str = util.position_to_str(neighbouring_chunk)
      if scanner_data.explored_chunks[neighbouring_chunk_str] then
        goto continue
      end

      scanner_data.to_be_explored_chunks[neighbouring_chunk_str] = true

      ::continue::
    end
  end

  return chunk, false, iteration
end

---@param event EventData.on_sector_scanned
local function on_sector_scanned(event)
  -- Raised when radar does scan, but the scanner prototype has a very small radius
  -- so that the actual chunk scan is done by the following script
  local scanner = event.radar
  if scanner.name ~= entity_name then return end

  local surface = scanner.surface
  local force = scanner.force --[[@as LuaForce]]
  local scanner_chunk_position = util.to_chunk_position(scanner.position)

  local scanner_data = get_scanner_data(scanner)

  local charted_chunk_yet = false
  while not charted_chunk_yet do
    if table_size(scanner_data.to_be_explored_chunks) == 0 then
      storage.scanner_data[scanner.unit_number] = nil
      scanner.active = false
      return
    end

    local chunk, completed = run_scan(scanner_data, scanner_chunk_position, scanner.position, surface)

    if completed or not chunk then goto continue end

    if not force.is_chunk_charted(surface, chunk) and not force.is_chunk_requested_for_charting(surface, chunk) then
      force.chart(surface, util.chunk_position_to_area(chunk))
      charted_chunk_yet = true
    end

    ::continue::
  end
end

---@param event
---| EventData.on_built_entity
---| EventData.on_robot_built_entity
local function on_scanner_built(event)
  local scanner = event.entity
  if scanner.name ~= entity_name then return end

  script.register_on_object_destroyed(scanner)
  scanner.backer_name = ""
  scanner.active = false

  local player
  if event.player_index then
    player = game.get_player(event.player_index)
  else
    player = event.entity.last_user
  end
  player.create_local_flying_text({
    text = { "freight-forwarding.sonar-buoy-warmup" },
    position = scanner.position,
  })

  storage.sonar_scanner_warmup = storage.sonar_scanner_warmup or {}
  storage.sonar_scanner_warmup[scanner.unit_number] = scanner
end

---@param event EventData.on_object_destroyed
local function on_scanner_destroyed(event)
  if event.type ~= defines.target_type.entity then return end

  storage.scanner_data = storage.scanner_data or {}
  storage.scanner_data[event.useful_id] = nil
end

---@param event EventData.on_tick
local function scanner_warmup(event)
  local warmups = table_size(storage.sonar_scanner_warmup or {})
  if warmups == 0 then return end

  local checks = math.ceil(10 / warmups) -- do a total of 10 chunks per tick

  for unit_number, scanner in pairs(storage.sonar_scanner_warmup) do
    if not scanner or not scanner.valid then
      storage.sonar_scanner_warmup[unit_number] = nil
      goto next
    end

    local surface = scanner.surface
    local force = scanner.force --[[@as LuaForce]]
    local scanner_position = scanner.position
    local scanner_chunk_position = util.to_chunk_position(scanner.position)
    local scanner_data = get_scanner_data(scanner)

    local cost = 0
    while cost < checks do
      local chunk, completed, iters = run_scan(
        scanner_data,
        scanner_chunk_position,
        scanner_position,
        surface,
        checks - cost
      )
      cost = cost + iters

      if completed or not chunk then
        storage.sonar_scanner_warmup[unit_number] = nil
        scanner.active = true
        goto next
      end

      if not force.is_chunk_charted(surface, chunk) and not force.is_chunk_requested_for_charting(surface, chunk) then
        if scanner_data.current_circle_index > 1 then
          scanner_data.current_circle_index = scanner_data.current_circle_index - 1
        elseif scanner_data.current_radius > 0 then
          scanner_data.current_radius = scanner_data.current_radius - 1
          scanner_data.current_circle_index = 1
        end

        local chunk_str = util.position_to_str(chunk)
        scanner_data.explored_chunks[chunk_str] = nil
        scanner_data.to_be_explored_chunks[chunk_str] = true

        storage.sonar_scanner_warmup[unit_number] = nil
        scanner.active = true
        goto next
      end
    end

    ::next::
  end
end

---@type ScriptLib
local SonarScanning = {}

SonarScanning.events = {
  [defines.events.on_built_entity]       = on_scanner_built,
  [defines.events.on_robot_built_entity] = on_scanner_built,
  [defines.events.on_object_destroyed]   = on_scanner_destroyed,
  [defines.events.on_sector_scanned]     = on_sector_scanned,
  [defines.events.on_tick]               = scanner_warmup,
}

return SonarScanning
