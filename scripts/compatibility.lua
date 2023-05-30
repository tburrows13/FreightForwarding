local disco_science = require "compatibility.disco-science.control"
local milestones    = require "compatibility.milestones.control"

local Compatibility = {}

Compatibility.on_load = function()
  milestones.load()
end

Compatibility.on_init = function()
  disco_science.init()
end

return Compatibility