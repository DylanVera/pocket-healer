PlayState = {}

function PlayState:init()
	board = Board()
    healer = Entity(ENTITY_DEFS['healer'], Vector(2,2))
  	healer:changeAnimation("idle")
  	tank = Entity(ENTITY_DEFS['tank'], Vector(2,3))
  	tank:changeAnimation("idle")
    enemy = Entity(ENTITY_DEFS['enemy'], Vector(8,8))
    enemy2 = Entity(ENTITY_DEFS['enemy'], Vector(5,5))
    enemy2:changeAnimation("idle")
    cursor = Cursor(Vector(2,2))
    --box = GameObject(GAME_OBJECT_DEFS['box'], Vector(4,4))

 --    box.onCollide = function(actor, dir)
 --    	if board:isEmpty(board.getTile(box.tilePos + dir)) then
 --        	box.moveSpeed = actor.moveSpeed
 --        	MoveCommand(box, dir)
 --    	end
	-- end

	-- timer.every(enemy.moveSpeed * 2, function()
	-- 	local path = board:getSimplePath(enemy, healer)
 --    	local moveDir = table.remove(path).tilePos - enemy.tilePos 
 --    	enemy:move(moveDir)
	-- end)
	currentUnit = 1
    commands = {}
    actionbar = ActionBar(healer)
    entities = {tank, enemy, healer, enemy2}
end 

function PlayState:enter()
end

function PlayState:exit()
end

function PlayState:draw()
	push:start()
	board:draw()
	tank:render()
	healer:render()
	enemy:draw()
	enemy2:render()
	cursor:draw()
	--box:draw()	
	


	push:finish()
end

function PlayState:update(dt)
	healer:update(dt)
	-- actionbar:update(dt)

    if suit.Button("Clear", TILE_SIZE, TILE_SIZE * 7, TILE_SIZE * 4, TILE_SIZE).hit then
    	board:clear()
    end
end

function PlayState:keypressed(key)
	if key == "w" or key == "up" then
		cursor:move(VEC_UP)
		-- entities[currentUnit]:move(VEC_UP)
	end
	if key == "a" or key == "left" then
		cursor:move(VEC_LEFT)
		-- entities[currentUnit]:move(VEC_LEFT)
	end
	if key == "s" or key == "down" then
		cursor:move(VEC_DOWN)
		-- entities[currentUnit]:move(VEC_DOWN)
	end
	if key == "d" or key == "right" then
		cursor:move(VEC_RIGHT)
		-- entities[currentUnit]:move(VEC_RIGHT)
	end

	
	
	if key == "x" then
		local entity = board:entityAt(cursor.tilePos)
		if entity ~= nil then
			UnitState.unit = entity
			gameState.push(UnitState)
		end
	end

	if key == "space" then
		self:endTurn()
	end

 	-- 	if key == "z" then
	-- 	if #commands > 0 then
	-- 		commands[#commands]:undo()
	-- 	else
	-- 		print("no commands to undo")
	-- 	end
	-- end
	-- --be able to undo a redo
	-- if key == "r" then
	-- 	if commands.last >= commands.first then
	-- 		healer.position = board:toWorldPos(commands[commands.first].oldPos)
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
			cursor.tilePos = tile.tilePos
			cursor.position = board:toWorldPos(cursor.tilePos)
		end
		-- if button == 1 then		
		-- 	local path = board:getSimplePath(entities[currentUnit], tile)
		-- 	if #path > 0 then
	 --    		local moveDir = table.remove(path).tilePos - entities[currentUnit].tilePos
	 --    		entities[currentUnit]:move(moveDir)
	 --    	end
		-- end
		if button == 2 then
			tile:toggleSolid()
		end
	end
end

function PlayState:process() 
  --local command = actors[_currentActor].getAction();

  --// Don't advance past the actor if it didn't take a turn.
  --if action == nil then return nil end

  --action.perform();
  --_currentActor = (_currentActor + 1) % actors.length;
end

function PlayState:endTurn()
	--move all this garbage to an entity end turn function
	entities[currentUnit]:endTurn()
	currentUnit = currentUnit % #entities + 1
	actionbar:changeActor(entities[currentUnit])
end