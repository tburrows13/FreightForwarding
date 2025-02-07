local x_scale = 0.4
local y_scale = 0.4
local scale = 0.4
--local offset = {x = 0, y = -0.5}
local splash_positions = {
  {0, 0.6},
  {0, -0.8},
  {-0.7, 0},
  {0.7, 0},
  {0.35, 0.55},
  {-0.35, 0.55},
  {0.55, 0.35},
  {-0.55, 0.35},
  {0.45, -0.65},
  {-0.45, -0.65},
  {0.65, -0.45},
  {-0.65, -0.45},
}

--local shadow_offset = {0.3, 0.3}
local shadow_offset = {0.2, 0.2}
local legs_offset = {0, 0.6}

local function add_offset(position, offset)
  return {x = position.x + (offset[1] or offset.x), y = position.y + (offset[2] or offset.y)}
end

local function get_offset(walking_state)
  local offset = {x = 0, y = 0}
  if walking_state.walking then
    if walking_state.direction == defines.direction.north then
      offset.x = -0.05
    elseif walking_state.direction == defines.direction.west then
      offset.x = -0.1
    elseif walking_state.direction == defines.direction.south or walking_state.direction == defines.direction.southeast or walking_state.direction == defines.direction.southwest then
      offset.y = 0.05
    end
  else
    if walking_state.direction == defines.direction.east or walking_state.direction == defines.direction.northeast then
      offset.x = -0.15
    elseif walking_state.direction == defines.direction.west or walking_state.direction == defines.direction.northwest then
      offset.x = 0.15
    elseif walking_state.direction == defines.direction.south then
      offset.y = -0.15
    end
  end
  return {x = offset.x, y = offset.y-0.7}
end

local function on_tick()
  for _, player in pairs(game.players) do
    local tile = player.surface.get_tile(player.physical_position.x, player.physical_position.y)
    if not tile or not tile.valid then goto continue end
    local tile_name = tile.name
    if (tile_name == "water" or tile_name == "deepwater")
      and player.character and not player.vehicle
      and (not (remote.interfaces["jetpack"] and remote.interfaces["jetpack"].is_jetpacking) or not remote.call("jetpack", "is_jetpacking", {character=player.character}))
      then
      local offset = get_offset(player.walking_state)
      if not storage.liferings[player.index] and player.character then
        storage.liferings[player.index] = {
          front = rendering.draw_sprite{
            sprite = "ff-life-ring-front",
            target = player.character,
            surface = player.surface,
            target_offset = offset,
            x_scale = scale,
            y_scale = scale+0.1,
            render_layer = "higher-object-under",
          },
          back = rendering.draw_sprite{
            sprite = "ff-life-ring-back",
            target = player.character,
            surface = player.surface,
            target_offset = offset,
            x_scale = scale,
            y_scale = scale+0.1,
            render_layer = "lower-object-above-shadow",
          },
          shadow = rendering.draw_sprite{
            sprite = "ff-life-ring-front-shadow",
            target = player.character,
            surface = player.surface,
            target_offset = add_offset(offset, shadow_offset),
            x_scale = scale*1.25,
            y_scale = scale+0.1,
            render_layer = "lower-object",
          },
          legs = rendering.draw_sprite{
            sprite = "ff-water-legs",  -- Partially covers up legs
            target = player.character,
            surface = player.surface,
            target_offset = add_offset(offset, legs_offset),
            x_scale = 0.6,
            y_scale = 0.4,
            render_layer = "object",
          },

        }
      else
        if rendering.is_valid(storage.liferings[player.index].front) then
          rendering.set_target(storage.liferings[player.index].front, player.character, offset)
        end
        if rendering.is_valid(storage.liferings[player.index].back) then
          rendering.set_target(storage.liferings[player.index].back, player.character, offset)
        end
        if rendering.is_valid(storage.liferings[player.index].shadow or 0) then
          rendering.set_target(storage.liferings[player.index].shadow, player.character, add_offset(offset, shadow_offset))
        end
        if rendering.is_valid(storage.liferings[player.index].legs or 0) then
          rendering.set_target(storage.liferings[player.index].legs, player.character, add_offset(offset, legs_offset))
        end
      end
      for _, splash_position in pairs(splash_positions) do
        player.surface.create_entity{
          name = "ff-life-ring-splash",
          position = add_offset(add_offset(player.physical_position, splash_position), offset),
        }
      end
    else
      if storage.liferings[player.index] then
        rendering.destroy(storage.liferings[player.index].front)
        rendering.destroy(storage.liferings[player.index].back)
        rendering.destroy(storage.liferings[player.index].shadow or 0)
        rendering.destroy(storage.liferings[player.index].legs or 0)
        storage.liferings[player.index] = nil
      end
    end
    ::continue::
  end
end


---@type ScriptLib
local LifeRing = {}

LifeRing.events = {
  [defines.events.on_tick] = on_tick
}

LifeRing.on_init = function ()
  storage.liferings = {}
end

LifeRing.on_configuration_changed = function(changed_data)
  storage.liferings = storage.liferings or {}
end

return LifeRing

