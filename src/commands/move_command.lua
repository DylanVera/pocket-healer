MoveCommand = class{
	--_includes = Command,
	init = function(self, actor, dir)
		self.dir = dir
		self.actor = actor
		self.oldPos = board:toTilePos(actor.position)
	end
}

--check for exit/enter callbacks
function MoveCommand:execute()
	local tilePos = board:toTilePos(self.actor.position + (self.dir * TILE_SIZE))
	if not self.actor.moving then
		board.tiles[self.oldPos.y][self.oldPos.x].entity = nil	
		board.tiles[tilePos.y][tilePos.x].color = self.actor.color
		table.insert(commands, self)
		self.actor.moving = true
		self.actor.tilePos = self.actor.tilePos + self.dir
		board.tiles[tilePos.y][tilePos.x].entity = self.actor
		self.actor:changeAnimation("walk")
		flux.to(
			self.actor.position, 
			self.actor.moveSpeed, 
			{ 
				x = self.actor.position.x + self.dir.x * TILE_SIZE, 
				y = self.actor.position.y + self.dir.y * TILE_SIZE
			})
		:oncomplete(function() 
			self.actor.moving = false 
			self.actor:changeAnimation("idle")
		end)
	end
end

--todo: take collision logic out if we decide undo is necessary
function MoveCommand:undo()
	local tilePos = board:toTilePos(self.actor.position - (self.dir * TILE_SIZE))
	if not self.actor.moving and board:isEmpty(self.actor.tilePos - self.dir) then
		if (self.actor.facingRight and self.dir == VEC_RIGHT) or (not self.actor.facingRight and self.dir == VEC_LEFT) then
			self.actor:flip()
		end
		board.tiles[self.actor.tilePos.y][self.actor.tilePos.x].entity = nil
		board.tiles[self.actor.tilePos.y][self.actor.tilePos.x].color = {128,128,128}
		table.remove(commands, #commands)
		self.actor.moving = true
		self.actor.tilePos = self.actor.tilePos - self.dir
		board.tiles[tilePos.y][tilePos.x].entity = self.actor

		flux.to(
			self.actor.position,
			self.actor.moveSpeed,
			{ 
				x = self.actor.position.x - self.dir.x * TILE_SIZE,
				y = self.actor.position.y - self.dir.y * TILE_SIZE
			})
		:oncomplete(function()
			self.actor.moving = false
		end)
	end
end