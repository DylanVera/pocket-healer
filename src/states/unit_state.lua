UnitState = {}

function UnitState:init()
	
end

function UnitState:update(dt)
	PlayState:update(dt)
end

function UnitState:draw()
	PlayState:draw()
end

function UnitState:keypressed(key)

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
		local path = board:getSimplePath(self.unit, cursor)
		for i, t in ipairs(path) do
			local moveDir = table.remove(path).tilePos - self.unit.tilePos
    		self.unit:move(moveDir)
		end
    	--self.unit.position = board:toWorldPos(self.unit.tilePos)
	end

	if key == "space" then
		gameState.pop()
	end
end

function UnitState:enter()
	self.moveRange = board:getSimpleReachable(self.unit.tilePos, self.unit.ap)
	for i, t in ipairs(self.moveRange) do
		t.color = {64, 196, 128}
	end	
end

function UnitState:leave()
	for i, t in ipairs(self.moveRange) do
		t.color = t.baseColor
	end	
end