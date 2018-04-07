Entity = class{
	init = function(self, def, position)
		self.tilePos = position
		self.position = board:toWorldPos(self.tilePos)
		self.width = TILE_SIZE * 0.6
		self.height = TILE_SIZE * 0.6
		self.offset = Vector((TILE_SIZE - self.width)/2, (TILE_SIZE - self.height)/2)

		self.moving = false
		self.color = def.color

		-- self.state = stateMachine {
	 --        ['start'] = function() end,
	 --        ['play'] = function() end,
	 --        ['game-over'] = function() end
	 --    }

	    -- self.state:change('start')

		self.moveSpeed = 0.25
		self.moveRange = 4
		self.abilities = {}
		self.animations = self:createAnimations(def.animations)
		self.maxAp = 5
		self.ap = self.maxAp
		self.maxHealth = 3
		self.health = self.maxHealth
		self.onCollide = function() end

		board.tiles[self.tilePos.y][self.tilePos.x].entity = self
		board.tiles[self.tilePos.y][self.tilePos.x].color = self.color
	end
}

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'tiles',
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
	if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Entity:damage(dmg)
    self.health = self.health - dmg
    if self.health <= 0 then
    	print("you got dead")
    	--gameover state
    	--gameState.switch(MenuState)
    end
end

function Entity:processAI(params, dt)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.position.x + self.offset.x, self.position.y + self.offset.y, self.width, self.height)
	love.graphics.setColor(0,0,0)
	love.graphics.setLineWidth(self.width * 0.1)
	love.graphics.rectangle("line", self.position.x + self.offset.x, self.position.y + self.offset.y, self.width, self.height)
end

function Entity:render()
	local anim = self.currentAnimation
	local scaledX, scaledY, scaledW, scaledH = gFrames[anim.texture][anim:getCurrentFrame()]:getViewport()
	scaledW = self.width/scaledW
	scaledH = self.height/scaledH
	
	love.graphics.setColor(self.color) --or white
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.position.x + self.offset.x, self.position.y + self.offset.y, 0, scaledW, scaledH)
        --math.floor(self.position.x - self.position.offsetX), math.floor(self.position.y - self.position.offsetY))
end

--chceck move is valid
function Entity:move(dir)
	MoveCommand(self, dir):execute()
end