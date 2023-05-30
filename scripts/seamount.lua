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
  seamount.teleport{x = x, y = y}
end

---@type ScriptLib
local Seamount = {}

Seamount.events = {
  [defines.events.on_script_trigger_effect] = on_seamount_created
}

return Seamount

