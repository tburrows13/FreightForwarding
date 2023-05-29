-- data structure:
-- global.landfill -> array of
--   {
--     x : x-position of tile
--   , y : y-position of tile
--   , tile : original hidden tile of landfill
--   }

local function set_landfill_hidden_tile(x, y, tile)
	if global.landfill == nil then
		global.landfill = {}
	end

	for _, data in pairs(global.landfill) do
		if data.x == x and data.y == y then
			data.tile = tile
			return
		end
	end
	local data = {x = x, y = y, tile = tile}
	table.insert(global.landfill, data)
end

local function get_landfill_hidden_tile(x, y)
	if global.landfill == nil then
		game.print("error failed to get tile below landfill. using default")
		return "water"
	end

	for index, data in pairs(global.landfill) do
		if data.x == x and data.y == y then
			table.remove(global.landfill, index)
			return data.tile
		end
	end
	game.print("error failed to get tile below landfill. using default")
	return "water"
end

local function save_landfill_hidden_tile(event)
	--game.print("restore_landfill_hidden_tile")
	local surface = game.surfaces[event.surface_index]
	local landfill_count = 0

	for _, tile in pairs(event.tiles) do
		if tile.old_tile.name == "landfill" then
			--game.print("replaced landfill"..tile.position.x.."-"..tile.position.y)
			local hidden_tile = surface.get_hidden_tile(tile.position)
			set_landfill_hidden_tile(tile.position.x, tile.position.y, hidden_tile)
			surface.set_hidden_tile(tile.position, "landfill")
			landfill_count = landfill_count + 1
		end
	end

	return landfill_count
end

local function on_player_built_tile(event)
	--game.print("on_player_built_tile")
	local landfill_count = save_landfill_hidden_tile(event)

	if landfill_count > 0 then
		--game.print("steal player "..landfill_count.." landfill")
		local player = game.players[event.player_index]
		local inventory = player.get_inventory(defines.inventory.character_main)
		if inventory then 
			inventory.remove({name="landfill", count=landfill_count})
		end
	end
end

local function on_robot_built_tile(event)
	--game.print("on_robot_built_tile")
	local landfill_count = save_landfill_hidden_tile(event)

	if landfill_count > 0 then
		--game.print("steal robot "..landfill_count.." landfill")
		local inventory = event.robot.get_inventory(defines.inventory.character_main)
		inventory.remove({name="landfill", count=landfill_count})
	end
end

local function on_mined_tile(event)
	--game.print("on_mined_tile")
	local surface = game.surfaces[event.surface_index]
	for _, tile in pairs(event.tiles) do
		if surface.get_tile(tile.position.x, tile.position.y).name == "landfill" then
			local original_hidden_tile = get_landfill_hidden_tile(tile.position.x, tile.position.y)
			surface.set_hidden_tile(tile.position, original_hidden_tile)
			--if hidden_tile == nil then
			--	hidden_tile = "nil"
			--end
			--game.print("mined to landfill"..tile.position.x.."-"..tile.position.y.." now: "..hidden_tile)
		end
	end
end

---@type ScriptLib
local Landfill = {}

Landfill.events = {
	[defines.events.on_player_built_tile] = on_player_built_tile,
	[defines.events.on_player_mined_tile] = on_mined_tile,
	[defines.events.on_robot_built_tile] 	= on_robot_built_tile,
	[defines.events.on_robot_mined_tile] 	= on_mined_tile,
}

return Landfill
