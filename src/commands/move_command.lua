MoveCommand = class{
	--_includes = Command,
	init = function(self, actor, dir)
		self.dir = dir
		self.actor = actor
		self.oldPos = board:toTilePos(actor.position)
	end
}

function MoveCommand:execute()
	local tilePos = board:toTilePos(self.actor.position + (self.dir * TILE_SIZE))
	if not self.actor.moving and board:isEmpty(self.actor.tilePos + self.dir) then
		board.tiles[self.oldPos.y][self.oldPos.x].entity = nil	
		print("#commands before: "..#commands)
		print("moving to "..tilePos.x..","..tilePos.y)
		table.insert(commands, self)
		print("#commands after: "..#commands.."\n")
		self.actor.moving = true
		flux.to(
			self.actor.position, 
			self.actor.moveSpeed, 
			{ 
				x = self.actor.position.x + self.dir.x * TILE_SIZE, 
				y = self.actor.position.y + self.dir.y * TILE_SIZE
			})
		:oncomplete(function() 
			self.actor.moving = false 
			self.actor.tilePos = self.actor.tilePos + self.dir
			board.tiles[tilePos.y][tilePos.x].entity = self.actor
		end)
	end
end

function MoveCommand:undo()
	local tilePos = board:toTilePos(self.actor.position - (self.dir * TILE_SIZE))
	if not self.actor.moving and board:isEmpty(self.actor.tilePos - self.dir) then
		board.tiles[self.actor.tilePos.y][self.actor.tilePos.x].entity = nil	
		print("#commands before: "..#commands)
		print("undoing move from "..tilePos.x..","..tilePos.y)
		table.remove(commands, #commands)
		print("#commands after: "..#commands.."\n")
		self.actor.moving = true
		flux.to(
			self.actor.position, 
			self.actor.moveSpeed, 
			{ 
				x = self.actor.position.x - self.dir.x * TILE_SIZE, 
				y = self.actor.position.y - self.dir.y * TILE_SIZE
			})
		:oncomplete(function() 
			self.actor.moving = false 
			self.actor.tilePos = self.actor.tilePos - self.dir
			board.tiles[tilePos.y][tilePos.x].entity = self.actor
		end)
	end
end