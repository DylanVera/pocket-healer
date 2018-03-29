Entity = class{
	init = function(self,x,y,color)
		self.position = vector.new(x,y)
		self.moving = false
		self.width = 36
		self.height = 36
		self.color = color
		-- self.state = stateMachine {
	 --        ['start'] = function() end,
	 --        ['play'] = function() end,
	 --        ['game-over'] = function() end
	 --    }

	    -- self.state:change('start')
		self.moveSpeed = 0.25
		self.abilities = {}
		self.animations = {}
		self.maxAp = 5
		self.ap = self.maxAp
		self.maxHealth = 5
		self.health = self.maxHealth

		self.tilePos = board:toTilePos(x,y)
		board.tiles[self.tilePos.y][self.tilePos.x] = "*"
	end
}

-- function Entity:changeState(name)
--     --self.state:change(name)
-- end

function Entity:update(dt)
	--self.state:update(dt)
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:processAI(params, dt)
	
end

function Entity:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.position.x, self.position.y, self.width, self.height)
	love.graphics.setColor(0,0,0)
	love.graphics.setLineWidth(self.width * 0.1)
	love.graphics.rectangle("line", self.position.x, self.position.y, self.width, self.height)
end