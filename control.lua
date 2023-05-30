local handler = require "__core__.lualib.event_handler"

---@class ScriptLib
---@field add_commands? fun()
---@field add_remote_interface? fun()
---@field on_init? fun()
---@field on_load? fun()
---@field on_configuration_changed? fun(d: ConfigurationChangedData)
---@field events? table<defines.events, fun(d: EventData)>
---@field on_nth_tick? table<integer, fun(d: NthTickEventData)>

handler.add_libraries{
  require "scripts.migrations",
  require "scripts.burnt-result",
  require "scripts.container-limitations",
  require "scripts.dredging-platform",
  require "scripts.endgame",
  require "scripts.landfill-hidden-tile",
  require "scripts.lava-pool",
  require "scripts.seamount",
  require "scripts.seismic-scanning",
  require "scripts.compatibility",
  require "scripts.collision-test",
  require "scripts.warning"
}