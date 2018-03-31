--1D-array for tiles?
Board = class{
	init = function(self)
		self.entities = {}
		self.tiles = {}
					-- 	{'#', '#', '#', '#', '#', '#', '#', '#', '#'},
					-- 	{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
					-- 	{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
					-- 	{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
					-- 	{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
					-- 	{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
					-- 	{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
					-- 	{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'},
					-- 	{'#', '#', '#', '#', '#', '#', '#', '#', '#'}
					-- }
		self.boardSize = Vector(9, 9)
		self.position = Vector(MAP_RENDER_OFFSET_X, MAP_RENDER_OFFSET_Y)

		--init tiles to a square arena
		self:loadTiles()
	end
}


function Board:draw()
	for y, row in ipairs(self.tiles) do
		for x, cell in ipairs(row) do
			love.graphics.setColor(self.tiles[y][x].color)
			love.graphics.rectangle('fill', self.position.x + (x - 1) * TILE_SIZE, self.position.y + (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
			love.graphics.setColor(0, 0, 0)
			love.graphics.setLineWidth(TILE_SIZE * 0.1)
			love.graphics.rectangle('line', self.position.x + (x - 1) * TILE_SIZE, self.position.y + (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
		end
	end
end

function Board:loadTiles()
	for y=1, self.boardSize.y do
		table.insert(self.tiles, {})
		for x=1, self.boardSize.x do
			if x == 1 or y == 1 or y == self.boardSize.y or x == self.boardSize.x then
				self.tiles[y][x] = Tile(Vector(x,y), true, {64,64,64})
			else
				self.tiles[y][x] = Tile(Vector(x,y), false)
			end
		end
	end
end

function Board:update(dt)
	--iterate through entities
end

function Board:reset()
	self.tiles = {}
end

function Board:toWorldPos(tile)
	return Vector(tile.x * TILE_SIZE + self.position.x, tile.y * TILE_SIZE + self.position.y)
end

function Board:toTilePos(tile)
	return Vector(math.floor((tile.x - self.position.x)/TILE_SIZE) + 1, math.floor((tile.y - self.position.y)/TILE_SIZE) + 1)
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

function Board:isEmpty(tile)
	return self:isValid(tile) and self:getPawn(tile) == nil and not self.tiles[tile.y][tile.x].isSolid
end

function Board:getPawn(tile)
	print("Entity at ("..tile.x..","..tile.y.."):")
	print(self.tiles[tile.y][tile.x]:getEntity())
	return self.tiles[tile.y][tile.x]:getEntity()
end

function Board:isValid(tile)
	--account for edge tiles in array
	return tile.x <= #self.tiles[1] - 1 and tile.x > 1 and tile.y <= #self.tiles - 1 and tile.y > 1
end

function Board:getSimpleReachable(point, pathSize, CornersAllowed)
end