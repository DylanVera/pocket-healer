local playState = {}

function playState:init()
	board = Board()
    player = Entity(board.position.x + (TILE_SIZE * 1.25), board.position.y + (TILE_SIZE * 1.25), {128, 96, 255})
    enemy = Entity(board.position.x + (TILE_SIZE * 7) + (TILE_SIZE * 0.2), board.position.y + (TILE_SIZE * 7) + (TILE_SIZE * 0.2), {255, 96, 128})
    --timer.every(1.5, function() MoveCommand(enemy, vector.new(-2,0)):execute() end)
    commands = Queue()
    actionbar = ActionBar(player)
end

function playState:enter()
end

function playState:leave()
end

function playState:draw()
	push:start()
	board:draw()
	player:draw()
	enemy:draw()
	actionbar:draw()
	push:finish()
end

function playState:update(dt)
	actionbar:update(dt)
end

--only push successful movement to commandlist
function playState:keypressed(key)
	if key == "w" then
		MoveCommand(player, vector.new(0,-1)):execute()
	end
	if key == "a" then
		MoveCommand(player, vector.new(-1,0)):execute()
	end
	if key == "s" then
		MoveCommand(player, vector.new(0,1)):execute()
	end
	if key == "d" then
		MoveCommand(player, vector.new(1,0)):execute()
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

return playState