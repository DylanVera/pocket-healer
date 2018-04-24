PlayState = {}

function PlayState:init()
end 

function PlayState:enter()
	board = Board()
    healer = Entity(ENTITY_DEFS['tank'], Vector(2,2))
  	healer:changeAnimation("idle")
  	bigboy = Entity(ENTITY_DEFS['bigboy'], Vector(2,3))
  	bigboy:changeAnimation("idle")
    enemy = Entity(ENTITY_DEFS['enemy'], Vector(8,8))
    enemy2 = Entity(ENTITY_DEFS['enemy'], Vector(4,4))
    --enemy2:changeAnimation("idle")
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
	-- end)?>
	currentUnit = 1
    commands = {}
    bigboy.health = 1
    actionbar = ActionBar(healer)

    allies = {bigboy, healer}
    enemies = {enemy, enemy2}
    entities = {allies, enemies}
    enemiesKilled = 0
end

function PlayState:leave()
end

function PlayState:draw()
	push:start()
	board:draw()
	cursor:draw()
	for i, team in ipairs(entities) do
		for j, unit in ipairs(team) do
			if unit.alive then
				if i == 1 then
					unit:render()
				else
					unit:draw()
				end
			end
		end
	end
	love.graphics.setColor(255,255,255)
	love.graphics.print("fps: " .. love.timer.getFPS(), 0,0)
	push:finish()
end

function PlayState:update(dt)
	-- remove entity from the table if health is <= 0
	if enemiesKilled == #enemies then
    	gameState.switch(MenuState)
    end
	for i, team in ipairs(entities) do
		for j, entity in ipairs(team) do
			if entity.alive then
		        entity:processAI({room = self}, dt)
		        entity:update(dt)
    		end
		end
	end
   
	-- actionbar:update(dt)
    if suit.Button("Clear", TILE_SIZE, TILE_SIZE, TILE_SIZE * 4, TILE_SIZE).hit then
    	board:clear()
    end

    if suit.Button("End Turn", TILE_SIZE, TILE_SIZE * 2, TILE_SIZE * 4, TILE_SIZE).hit then
    	self:endTurn()
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

	if key == "x" or key == "space" then
		local entity = board:entityAt(cursor.tilePos)
		if entity ~= nil then
			UnitState.unit = entity
			gameState.push(UnitState)
		end
	end
end

function PlayState:mousepressed(x, y, button, istouch)
	local nx, ny = push:toGame(x,y)
	local tile = board:getTile(board:toTilePos(Vector(nx, ny)))
	-- print(board:euclidean(healer.tilePos, tile.tilePos))
	if tile ~= nil then
		if button == 1 then
			cursor.tilePos = tile.tilePos
			cursor.position = board:toWorldPos(cursor.tilePos)
			if tile:getEntity() ~= nil then
				UnitState.unit = tile:getEntity()
				gameState.push(UnitState)
			end
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
	for i, team in ipairs(entities) do
		for j, entity in ipairs(team) do
			entity:endTurn()
		end
	end
end