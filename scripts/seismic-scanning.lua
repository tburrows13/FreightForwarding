local util = require("scripts/chunk-util")
local entity_name = "ff-seismic-scanner"
local scanner_range = 80
local min_tiles_from_water = 16

---@class SeismicScannerData
---@field explored_chunks table<string, boolean>
---@field to_be_explored_chunks table<string, boolean>

---@param scanner LuaEntity
---@return SeismicScannerData
local function get_scanner_data(scanner)
  local unit_number = scanner.unit_number --[[@as uint]]
  storage.scanner_data = storage.scanner_data or {}
  if not storage.scanner_data[unit_number] then
    local chunk_position = util.to_chunk_position(scanner.position)
    storage.scanner_data[unit_number] = { explored_chunks = {}, to_be_explored_chunks = { [util.position_to_str(chunk_position)] = true } }
  end
  return storage.scanner_data[unit_number]
end

---@param event EventData.on_sector_scanned
local function on_sector_scanned(event)
  -- Raised when radar does scan, but the scanner prototype has a very small radius
  -- so that the actual chunk scan is done by the following script
  local scanner = event.radar
  if scanner.name ~= entity_name then return end

  local surface = scanner.surface
  local force = scanner.force
  local scanner_chunk_position = util.to_chunk_position(scanner.position)

  local scanner_data = get_scanner_data(scanner)

  local charted_chunk_yet = false

  while not charted_chunk_yet do
    local chunk_str = next(scanner_data.to_be_explored_chunks)
    if chunk_str then
      local chunk = util.str_to_position(chunk_str)

      if not force.is_chunk_charted(surface, chunk) and not force.is_chunk_requested_for_charting(surface, chunk)
      then
        force.chart(surface, util.chunk_position_to_area(chunk))
        charted_chunk_yet = true
      end

      scanner_data.explored_chunks[chunk_str] = true
      scanner_data.to_be_explored_chunks[chunk_str] = nil
      if util.is_chunk_land(chunk, surface) then
        -- Add neighbouring chunks to to_be_explored_chunks
        for _, neighbouring_chunk in pairs(util.neighbouring_chunks(chunk)) do
          if util.is_chunk_in_range(neighbouring_chunk, scanner_chunk_position, scanner_range) then
            local neighbouring_chunk_str = util.position_to_str(neighbouring_chunk)
            if not scanner_data.explored_chunks[neighbouring_chunk_str] then
              scanner_data.to_be_explored_chunks[neighbouring_chunk_str] = true
            end
          end
        end
      end
    else
      storage.scanner_data[scanner.unit_number] = nil
      -- scanner.active = false
      return
    end
  end
end

---@param event
---| EventData.on_built_entity
---| EventData.on_robot_built_entity
local function on_scanner_built(event)
  -- Disable scanner if within 16 tiles of water
  local scanner = event.entity
  if scanner.name ~= entity_name then return end

  scanner.backer_name = ""
  local surface = scanner.surface
  local water_tile_count = surface.count_tiles_filtered { position = scanner.position, radius = min_tiles_from_water, collision_mask = {water_tile = true}, limit = 1 }
  if water_tile_count > 0 then
    scanner.active = false
    if event.player_index then
      game.get_player(event.player_index).create_local_flying_text({ text = { "freight-forwarding.seismic-scanner-too-close-to-water", min_tiles_from_water }, create_at_cursor = true })
    end
  end

  script.register_on_object_destroyed(scanner)
end

---@type ScriptLib
local SeismicScanning = {}

-- no need to handle on_object_destroyed since its handled by sonar-scanning.lua
SeismicScanning.events = {
  [defines.events.on_built_entity]       = on_scanner_built,
  [defines.events.on_robot_built_entity] = on_scanner_built,
  [defines.events.on_sector_scanned]     = on_sector_scanned,
}

return SeismicScanning
