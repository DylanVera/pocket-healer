PlayState = {}

function PlayState:init()
	board = Board()
    player = Entity(ENTITY_DEFS['player'], Vector(2,2))
  	player:changeAnimation("walk")
    enemy = Entity(ENTITY_DEFS['enemy'], Vector(8,8))
    --box = GameObject(GAME_OBJECT_DEFS['box'], Vector(4,4))

 --    box.onCollide = function(actor, dir)
 --    	if board:isEmpty(board.getTile(box.tilePos + dir)) then
 --        	box.moveSpeed = actor.moveSpeed
 --        	MoveCommand(box, dir)
 --    	end
	-- end

	-- timer.every(enemy.moveSpeed * 2, function()
	-- 	local path = board:getSimplePath(enemy, player)
 --    	local moveDir = table.remove(path).tilePos - enemy.tilePos
 --    	enemy:move(moveDir)
	-- end)

    commands = {}
    actionbar = ActionBar(player)
    entities = {}
end

function PlayState:enter()
end

function PlayState:leave()
end

function PlayState:draw()
	push:start()
	board:draw()
	player:render()
	enemy:draw()
	--box:draw()
	actionbar:draw()
	push:finish()
end

function PlayState:update(dt)
	player:update(dt)
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

function PlayState:keypressed(key)
	if key == "w" then
		player:move(VEC_UP)
	end
	if key == "a" then
		player:move(VEC_LEFT)
	end
	if key == "s" then
		player:move(VEC_DOWN)
	end
	if key == "d" then
		player:move(VEC_RIGHT)
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
	local nx, ny = push:toGame(x,y)
	local tile = board:getTile(board:toTilePos(Vector(nx, ny)))
	if tile ~= nil then
		if button == 1 then		
			local path = board:getSimplePath(player, tile)
			if #path > 0 then
	    		local moveDir = table.remove(path).tilePos - player.tilePos
	    		MoveCommand(player, moveDir):execute()
	    	end
		end
		if button == 2 then
			tile:toggleSolid()
		end
	end
end

function PlayState:processTurn()
	currentUnit = 0;
end