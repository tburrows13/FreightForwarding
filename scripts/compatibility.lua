local better_victory = require "compatibility.better-victory-screen.control"
local disco_science  = require "compatibility.disco-science.control"
local milestones     = require "compatibility.milestones.control"
local picker_dollies = require "compatibility.picker-dollies.control"

---@type ScriptLib
local Compatibility = {}

Compatibility.on_load = function()
  picker_dollies.load()
end

Compatibility.on_init = function()
  disco_science.init()
end

Compatibility.preload_remote_interface = function()
  local remote_functions = {}

  for _, mod in pairs({
    better_victory,
    milestones,
  }) do
    if mod.remote_interface_fragment then
      for name, func in pairs(mod.remote_interface_fragment()) do
        remote_functions[name] = func
      end
    end
  end

  remote.add_interface("FreightForwarding", remote_functions)
end

return Compatibility