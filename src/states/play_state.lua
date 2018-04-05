PlayState = {}

function PlayState:init()
	board = Board()
    player = Entity(board.position + Vector((TILE_SIZE * 1.25), (TILE_SIZE * 1.25)), {128, 96, 255})
    enemy = Entity(board.position + Vector((TILE_SIZE * 7) + (TILE_SIZE * 0.25), (TILE_SIZE * 7) + (TILE_SIZE * 0.25)), {255, 96, 128})
    
    commands = {}
    actionbar = ActionBar(player)
end

function PlayState:enter()
end

function PlayState:leave()
end

function PlayState:draw()
	push:start()
	board:draw()
	player:draw()
	enemy:draw()
	actionbar:draw()
	push:finish()
end

function PlayState:update(dt)
	if suit.Button("neighbors", TILE_SIZE, TILE_SIZE, TILE_SIZE * 2.5, TILE_SIZE).hit then
    	local neighbors = board:getNeighbors(player.tilePos)
    	for i,n in ipairs(neighbors) do
    		n.color = {255,64,96}
    	end	
    end

    if suit.Button("path", TILE_SIZE, TILE_SIZE*2.5, TILE_SIZE * 2.5, TILE_SIZE).hit then
    	local path = board:getSimplePath(player, enemy)
    	for i,n in ipairs(path) do
    		n.color = {255,64,255}
    	end	
    end

    if suit.Button("AI move", TILE_SIZE, TILE_SIZE*4, TILE_SIZE*2.5, TILE_SIZE).hit then
    	local path = board:getSimplePath(enemy, player)
    	local moveDir = table.remove(path).tilePos - enemy.tilePos
    	MoveCommand(enemy, moveDir):execute()
    end
end

--only push successful movement to commandlist
function PlayState:keypressed(key)
	if key == "w" then
		MoveCommand(player, VEC_UP):execute()
	end
	if key == "a" then
		MoveCommand(player, VEC_LEFT):execute()
	end
	if key == "s" then
		MoveCommand(player, VEC_DOWN):execute()
	end
	if key == "d" then
		MoveCommand(player, VEC_RIGHT):execute()
	end

	if key == "z" then
		if #commands > 0 then
			commands[#commands]:undo()
		else
			print("no commands to undo")
		end
	end

	if key == "space" then
    	local neighbors = board:getNeighbors(player.tilePos)
    	for i,n in ipairs(neighbors) do
    		n.color = {255,64,96}
    	end	
    end

	-- --be able to undo a redo
	-- if key == "r" then
	-- 	if commands.last >= commands.first then
	-- 		player.position = board:toWorldPos(commands[commands.first].oldPos)
	-- 		print(commands[commands.first].oldPos)
	-- 	else
	-- 		print("no commands to undo")
	-- 	end
	-- end
end

function PlayState:mousepressed(x, y, button, istouch)
	if button == 2 then
		local tile = board:getTile(board:toTilePos(Vector(x/2,y/2)))
		tile:toggleSolid()
	end
end

function PlayState:processTurn()
	currentUnit = 0;
end