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
  milestones.add_remote_interface()
end

return Compatibility