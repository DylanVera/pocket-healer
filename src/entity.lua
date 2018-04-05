Entity = class{
	init = function(self, position, color)
		self.position = position
		self.tilePos = board:toTilePos(self.position)
		self.moving = false
		self.width = TILE_SIZE * 0.5
		self.height = TILE_SIZE * 0.5
		self.color = color
		-- self.state = stateMachine {
	 --        ['start'] = function() end,
	 --        ['play'] = function() end,
	 --        ['game-over'] = function() end
	 --    }

	    -- self.state:change('start')
		self.moveSpeed = 0.25
		self.abilities = {}
		self.animations = {}--self:createAnimations()
		self.maxAp = 5
		self.ap = self.maxAp
		self.maxHealth = 3
		self.health = self.maxHealth

		board.tiles[self.tilePos.y][self.tilePos.x].entity = self
		board.tiles[self.tilePos.y][self.tilePos.x].color = self.color
	end
}

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

-- function Entity:changeState(name)
--     --self.state:change(name)
-- end

function Entity:update(dt)
	--self.state:update(dt)
end

function Entity:damage(dmg)
    self.health = self.health - dmg
    if self.health <= 0 then
    	print("you got dead")
    	--gameover state
    end
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