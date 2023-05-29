local handler = require "__core__/lualib/event_handler"

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
  require "scripts.collision-test"
}

local scanner_filter = {{filter = "name", name = "ff-seismic-scanner"}}

script.set_event_filter(defines.events.on_sector_scanned     --[[@as uint]], scanner_filter)
script.set_event_filter(defines.events.on_robot_built_entity --[[@as uint]], scanner_filter)
script.set_event_filter(defines.events.on_sector_scanned     --[[@as uint]], scanner_filter)

local function print_warning()
  if game.tick > 0 then
    if game.default_map_gen_settings.property_expression_names.elevation ~= "x-continents" then
      game.print({"freight-forwarding.warn-nondefault-mapgen", {"map-gen-preset-name.x-default"}})
    end
    script.on_nth_tick(300, nil)
  end
end

script.on_init(
  function()
    script.on_nth_tick(300, print_warning)  -- Probably desyncs if a player joins within 5 seconds
  end
)
