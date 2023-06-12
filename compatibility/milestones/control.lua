local presets = require "presets"

local function add_remote_interface()
  if not script.active_mods["Milestones"] then return end

  remote.add_interface("FreightForwarding", {
    milestones_presets = function()
      return presets
    end
  })
end

return
{
  add_remote_interface = add_remote_interface,
}