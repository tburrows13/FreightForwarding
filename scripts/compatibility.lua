local disco_science = require "compatibility.disco-science.control"
local milestones    = require "compatibility.milestones.control"

local Compatibility = {}

function Compatibility.load()
  milestones.load()
end

function Compatibility.init()
  disco_science.init()
end

return Compatibility