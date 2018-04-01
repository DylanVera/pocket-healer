PlayState = {}

function PlayState:init()
	board = Board()
    player = Entity(board.position + Vector((TILE_SIZE * 1.25), (TILE_SIZE * 1.25)), {128, 96, 255})
    enemy = Entity(board.position + Vector((TILE_SIZE * 7) + (TILE_SIZE * 0.25), (TILE_SIZE * 7) + (TILE_SIZE * 0.25)), {255, 96, 128})
    
  --randomly move the enemy around to test movement stuff
  --   timer.every(1.5, function()
  --   	local moveDir = {}
  --   	--repeat
  --   	local moveAmt = love.math.random(-6,6)
	    
	 --    if(love.math.random() > 0.5) then
	 --    	moveDir = Vector(moveAmt,0)
	 --    else
	 --    	moveDir = Vector(0, moveAmt)
	 --    end
		-- --until board:isValid(enemy.tilePos + moveDir)
	 --    MoveCommand(enemy, moveDir):execute() 
  --   end)

    --timer.every(1.5, function() MoveCommand(enemy, Vector(-2,0)):execute() end)
    commands = Queue()
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
    	local neighbors = board:getSimplePath(player, enemy)
    	for i,n in ipairs(neighbors) do
    		n.color = {255,64,255}
    	end	
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
	-- if key == "z" then
	-- 	if commands.last >= commands.first then
	-- 		commands[commands.last]:undo()
	-- 	else
	-- 		print("no commands to undo")
	-- 	end
	-- end

	-- --be able to undo redo
	-- if key == "r" then
	-- 	if commands.last >= commands.first then
	-- 		player.position = board:toWorldPos(commands[commands.first].oldPos)
	-- 		print(commands[commands.first].oldPos)
	-- 	else
	-- 		print("no commands to undo")
	-- 	end
	-- end
end

function PlayState:processTurn()
	currentUnit = 0;
end