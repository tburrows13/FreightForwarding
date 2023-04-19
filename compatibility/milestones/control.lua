local preset = require "preset"

local function load()
  if not script.active_mods["Milestones"] then return end

  remote.add_interface(
    "FreightForwardingMilestones", 
    {
      milestones_presets = function() return preset end
    }
  )
end

return
{
  load = load
}