local ChunkUtil = {}

---@param map_position MapPosition
---@return ChunkPosition
function ChunkUtil.to_chunk_position(map_position)
  return { math.floor(map_position.x / 32), math.floor(map_position.y / 32) }
end

---@param chunk_position ChunkPosition
---@return MapPosition
function ChunkUtil.to_map_position(chunk_position)
  return { chunk_position[1] * 32 + 16, chunk_position[2] * 32 + 16 }
end

---@param chunk_position ChunkPosition
---@return BoundingBox
function ChunkUtil.chunk_position_to_area(chunk_position)
  return {
    left_top = { chunk_position[1] * 32 + 1, chunk_position[2] * 32 + 1 },
    right_bottom = { chunk_position[1] * 32 + 31, chunk_position[2] * 32 + 31 },
  }
end

---@param position ChunkPosition
---@return string
function ChunkUtil.position_to_str(position)
  return position[1] .. "," .. position[2]
end

---@param str string
---@return ChunkPosition
function ChunkUtil.str_to_position(str)
  local x, y = str:match("^(%-?%d+),(%-?%d+)$")
  return { tonumber(x), tonumber(y) }
end

---@param chunk_position ChunkPosition
---@param surface LuaSurface
---@return boolean
function ChunkUtil.is_chunk_land(chunk_position, surface)
  -- 1024 tiles in a chunk
  local area = ChunkUtil.chunk_position_to_area(chunk_position)
  local ground_tiles = surface.count_tiles_filtered { area = area, collision_mask = "ground-tile" }
  return ground_tiles > 64
end

--- Check if 2 chunks are within a certain range of each other. The range is rectangular.
---@param chunk_position ChunkPosition
---@param scanner_position ChunkPosition
---@param range number Range in chunks
---@return boolean is_in_range True if `chunk_position` is within `range` chunks of `scanner_position`
function ChunkUtil.is_chunk_in_range(chunk_position, scanner_position, range)
  return math.abs(chunk_position[1] - scanner_position[1]) <= range and
      math.abs(chunk_position[2] - scanner_position[2]) <= range
end

--- Check if 2 chunks are within a certain range of each other. The range is circular.
---@param chunk_position ChunkPosition
---@param scanner_position ChunkPosition
---@param range number Range in chunks
---@return boolean is_in_range True if `chunk_position` is within `range` chunks of `scanner_position`
function ChunkUtil.is_chunk_in_range_circle(chunk_position, scanner_position, range)
  local dx = chunk_position[1] - scanner_position[1]
  local dy = chunk_position[2] - scanner_position[2]
  return (dx ^ 2 + dy ^ 2) <= (range ^ 2)
end

---@param chunk_position ChunkPosition
---@return ChunkPosition[] neighbours The 4 neighbouring chunks
function ChunkUtil.neighbouring_chunks(chunk_position)
  return {
    { chunk_position[1] - 1, chunk_position[2] },
    { chunk_position[1],     chunk_position[2] - 1 },
    { chunk_position[1],     chunk_position[2] + 1 },
    { chunk_position[1] + 1, chunk_position[2] },
  }
end

return ChunkUtil
