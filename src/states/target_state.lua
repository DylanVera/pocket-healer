TargetState = {}

function TargetState:init()
end

function TargetState:update(dt)
	UnitState:update(dt)
end

function TargetState:draw()
	UnitState:draw()
end	

function TargetState:enter()
	for i,n in ipairs(self.tiles) do
		n.color = {255,64,96}
	end
end

function TargetState:leave()
	for i,n in ipairs(self.tiles) do
		n.color = n.baseColor
	end
end

function TargetState:keypressed(key)
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
		self:checkTarget()
	end

	if key == "space" then
		gameState.pop()
	end
end

function TargetState:mousepressed(x, y, button, isTouch)
	local nx, ny = push:toGame(x,y)
	local tile = board:getTile(board:toTilePos(Vector(nx, ny)))
	if tile ~= nil then
		if button == 1 then		
			for i, n in ipairs(self.tiles) do
				if n == tile then
					self.ability:execute()
				end
			end
		end
	end
	
	gameState.pop()
end	

function TargetState:checkTarget()
	--if self.ability.targetType == UNIT_TARGET then
	--end
	local tile = board:getTile(cursor.tilePos)
	local entity = board:entityAt(cursor.tilePos)
	if tile ~= nil then
		for i, n in ipairs(self.tiles) do
			if n == tile then
				self.ability:execute()
				gameState.pop()
			end
		end
	end
end