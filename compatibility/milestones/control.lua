local presets = require "presets"

---@return table<string, function>
local function remote_interface_fragment()
  if not script.active_mods["Milestones"] then return {} end

  return {
    milestones_presets = function()
      return presets
    end
  }
end

return
{
  remote_interface_fragment = remote_interface_fragment,
}
