MoveCommand = class{
	--_includes = Command,
	init = function(self, actor, dir)
		self.dir = dir
		self.actor = actor
		self.oldPos = board:toTilePos(actor.position.x, actor.position.y)
	end
}

function MoveCommand:execute()
	local tilePos = board:toTilePos(self.actor.position.x + self.dir.x * TILE_SIZE, self.actor.position.y + self.dir.y * TILE_SIZE)
	if not self.actor.moving and board:check(tilePos.x, tilePos.y) then		
		print("#commands before: "..commands.last + 1)
		print("moving to "..tilePos.x..","..tilePos.y)
		commands:pushRight(self)
		print("#commands after: "..(commands.last + 1).."\n")
		self.actor.moving = true
		flux.to(self.actor.position, self.actor.moveSpeed, { x = self.actor.position.x + self.dir.x * TILE_SIZE, y = self.actor.position.y + self.dir.y * TILE_SIZE})
			:oncomplete(function() 
				self.actor.moving = false 
				board.tiles[tilePos.y][tilePos.x] = "*" 
			end)
	end
end

function MoveCommand:undo()
	local tilePos = board:toTilePos(self.actor.position.x - self.dir.x * TILE_SIZE, self.actor.position.y - self.dir.y * TILE_SIZE)
	if not self.actor.moving and board:check(tilePos.x, tilePos.y) then
		print("#commands before: "..commands.last + 1)
		print("undoing move from "..tilePos.x..","..tilePos.y)
		commands:popRight()
		print("#commands after: "..(commands.last + 1).."\n")
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
				board.tiles[tilePos.y][tilePos.x] = "*" 
			end
		)
	end
end