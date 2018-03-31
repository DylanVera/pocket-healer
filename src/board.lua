Board = class{
	init = function(self)
		self.entities = {}
		self.tiles = {
						{'#', '#', '#', '#', '#', '#', '#', '#', '#'},
						{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
						{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
						{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
						{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
						{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
						{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
						{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
						{'#', '#', '#', '#', '#', '#', '#', '#', '#'}
					}
		self.boardSize = Vector.new(9, 9)
		self.size = Vector.new(love.graphics.getWidth(), love.graphics.getHeight())
		self.position = Vector.new(MAP_RENDER_OFFSET_X, MAP_RENDER_OFFSET_Y)
	end
}


function Board:draw()
	for y, row in ipairs(self.tiles) do
		for x, cell in ipairs(row) do
			love.graphics.setColor(128,128,128)
			
			if(self.tiles[y][x] == "#") then
				love.graphics.setColor(64,64,64)
			end

			love.graphics.rectangle('fill', self.position.x + (x - 1) * TILE_SIZE, self.position.y + (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
			love.graphics.setColor(0, 0, 0)
			love.graphics.setLineWidth(TILE_SIZE * 0.1)
			love.graphics.rectangle('line', self.position.x + (x - 1) * TILE_SIZE, self.position.y + (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
		end
	end
end

function Board:loadTiles()
end

function Board:update(dt)
	--iterate through entities
end

function Board:reset()
	self.tiles = {}
end

function Board:toWorldPos(tile)
	return Vector.new(tile.x * TILE_SIZE + self.position.x, tile.y * TILE_SIZE + self.position.y)
end

function Board:toTilePos(tile)
	return Vector.new(math.floor((tile.x - self.position.x)/TILE_SIZE) + 1, math.floor((tile.y - self.position.y)/TILE_SIZE) + 1)
end

function Board:loadTiles()
end

function Board:render()
end

function Board:processAI(params, dt)
end

--check if path of given type to target is blocked at all
function Board:isBlocked(target, path)
end

function Board:getSimplePath(p1, p2)
end

function Board:isPawnSpace(tile)
end

--this function really tells us if a space is empty or not
function Board:isEmpty(tile)
	return self:isValid(tile) and self.tiles[tile.y][tile.x] == " "
end

function Board:getPawn(tile)
	return self.tiles[tile.y][tile.x] == "*"
end

function Board:isValid(tile)
	--account for edge tiles in array
	return tile.x <= #self.tiles[1] - 1 and tile.x > 1 and tile.y <= #self.tiles - 1 and tile.y > 1
end

function Board:getSimpleReachable(point, pathSize, CornersAllowed)

end