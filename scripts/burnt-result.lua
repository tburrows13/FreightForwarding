-- Recover empty batteries when mining discharging station
local function recover_burnt_result(event)
  local entity = event.entity
  local buffer = event.buffer
  if entity and buffer then
    local burner = entity.burner
    if burner then
      local burning = burner.currently_burning
      if burning then
        local burnt_result = burning.burnt_result
        if burnt_result then
          event.buffer.insert{name=burnt_result.name,count=1}
        end
      end
    end
  end
end

---@type ScriptLib
local BurntResult = {}

BurntResult.events = {
  [defines.events.on_player_mined_entity] = recover_burnt_result,
  [defines.events.on_robot_mined_entity]  = recover_burnt_result,
}

return BurntResult