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
		self.boardSize = vector.new(9, 9)
		self.size = vector.new(love.graphics.getWidth(), love.graphics.getHeight())
		self.position = vector.new((self.size.x - TILE_SIZE * self.boardSize.x)/2, (self.size.y - TILE_SIZE * self.boardSize.y)/2)
	end
}


function Board:draw()
	for y, row in ipairs(self.tiles) do
        for x, cell in ipairs(row) do
            love.graphics.setColor(128,128,128)
            love.graphics.rectangle('fill', self.position.x + (x - 1) * TILE_SIZE, self.position.y + (y - 1) * TILE_SIZE, TILE_SIZE,TILE_SIZE)
            love.graphics.setColor(0, 0, 0)
            love.graphics.setLineWidth(TILE_SIZE * 0.1)
            love.graphics.rectangle('line', self.position.x + (x - 1) * TILE_SIZE, self.position.y + (y - 1) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
            love.graphics.print(x..",\n"..y, 5 + self.position.x + (x - 1) * TILE_SIZE, 5 + self.position.y + (y - 1) * TILE_SIZE)
            local world = self:toWorldPos(x,y)
            --love.graphics.print(world.x..",\n"..world.y, 5 + self.position.x + (x - 1) * TILE_SIZE, 5 + self.position.y + (y - 1) * TILE_SIZE)
    	end
 	end
end

function Board:update(dt)
	--iterate through entities
end

function Board:reset()
	self.tiles = {}
end

function Board:loadTiles()
end

function Board:render()
end

function Board:processAI(params, dt)
end

function Board:check(tx,ty)
	return self.tiles[ty][tx] == " "
end

function Board:toWorldPos(tx,ty)
	return vector.new(tx * TILE_SIZE + self.position.x, ty * TILE_SIZE + self.position.y)
end

function Board:toTilePos(tx,ty)
	return vector.new(math.floor((tx - self.position.x)/TILE_SIZE) + 1, math.floor((ty - self.position.y)/TILE_SIZE) + 1)
end

