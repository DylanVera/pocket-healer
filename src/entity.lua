Entity = class{
	init = function(self, def, position)
		self.tilePos = position
		self.position = board:toWorldPos(self.tilePos)
		self.width = def.size.x
		self.height = def.size.y
		self.offset = Vector((TILE_SIZE - self.width)/2, (TILE_SIZE - self.height)/2)

		self.moving = false
		self.color = def.color
		self.facingRight = false

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
		self.maxAp = 7
		self.ap = self.maxAp
		self.apRegen = 5
		self.maxHealth = 3
		self.health = self.maxHealth
		self.onCollide = function() end
		self.flipOffset = def.flipOffset or 0
		self.effects = {}

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
    	--gameover state (just go back to menu for now)
    	gameState.switch(MenuState)
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
	local scaledX, scaledY, scaledW, scaledH = gFrames[anim.texture][anim:getCurrentFrame()]:getViewport() --why am i doing this every frame...
	scaledW = self.width/scaledW
	scaledH = self.height/scaledH 	
	
	if self.facingRight then
		scaledW = -scaledW
	end

	love.graphics.setColor({255, 255, 255}) --or white
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.position.x + self.offset.x , self.position.y + self.offset.y, 0, scaledW, scaledH)
end

function Entity:move(dir)
	local tilePos = board:toTilePos(self.position + (dir * TILE_SIZE))
	if board:isEmpty(tilePos) and self.ap > 0 then
		self.ap = self.ap - 1
		if (self.facingRight and dir == VEC_LEFT) or (not self.facingRight and dir == VEC_RIGHT) then
			self:flip(self.flipOffset)
		end
		MoveCommand(self, dir):execute()
	end
end

--this is definitely gonna become a problem some day...
function Entity:flip()
	self.facingRight = not self.facingRight
	if self.facingRight then
		self.offset.x = self.offset.x + self.flipOffset
	else
		self.offset.x = self.offset.x - self.flipOffset
	end
end

function Entity:endTurn()
	self.ap = math.min(self.ap + self.apRegen, self.maxAp)
	--end of turn effects and stuff
end

function Entity:startTurn()
	--beginning of turn effects and stuff
end