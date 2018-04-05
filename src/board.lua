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

--BFS
function Board:getSimplePath(p1, p2)
	local frontier = {}
	local goal = self:getTile(p2.tilePos)
	table.insert(frontier, self:getTile(p1.tilePos))
	visited = {}
	cameFrom = {}

	while #frontier > 0 do
		current = table.remove(frontier, 1)

		if current == goal then
			print("goal reached")	
			--build the path
			current = goal 
			path = {}
			while current ~= self:getTile(p1.tilePos) do
			   table.insert(path, current)
			   current = cameFrom[current]
			end
			--goal.color = {98, 255, 128}
			print("Path found: "..#path.." moves")
			return path
		end

		local neighbors = self:getNeighbors(current.tilePos)
		for i, n in ipairs(neighbors) do
			if not visited[n] then
				table.insert(frontier, n)
				visited[n] = true
				cameFrom[n] = current
				--n.color = {64, 255, 255}	
			end
		end	
	end

	print("no path found")
	return {}
end

function Board:isPawnSpace(tile)
end

function Board:getTile(tile)
	if self:isValid(tile) then
		return self.tiles[tile.y][tile.x]
	end
end

function Board:isEmpty(tile)
	return self:isValid(tile) and self:getPawn(tile) == nil and not self.tiles[tile.y][tile.x].isSolid
end

function Board:getPawn(tile)
	local entity = self.tiles[tile.y][tile.x]:getEntity()
	if entity ~= nil then
		print("Entity at ("..tile.x..","..tile.y.."):")
		print(entity)
		return entity
	end
end

function Board:isValid(tile)
	return tile.x <= #self.tiles[1] and tile.x > 0 and tile.y <= #self.tiles  and tile.y > 0
end

function Board:getSimpleReachable(point, pathSize, CornersAllowed)
end

function Board:getNeighbors(tile)
	local neighbors = {
						self.tiles[tile.y+1][tile.x],
						self.tiles[tile.y-1][tile.x],
						self.tiles[tile.y][tile.x+1],
						self.tiles[tile.y][tile.x-1]
					}

	--filter out walls and invalid stuff
	for n=#neighbors, 1, -1 do
		if not self:isValid(neighbors[n].tilePos) or neighbors[n].isSolid then
			table.remove(neighbors, n)
		end
	end

	return neighbors
end

function Board:manhattan(p1,p2)
end