ActionBar = class{
	init = function(self, actor)
		self.abilities = {0,0,0,0,0,0}
		self.position = Vector.new(ACTIONBAR_RENDER_OFFSET_X, ACTIONBAR_RENDER_OFFSET_Y)
		print(self.position.x)
	end
}

function ActionBar:cast(id)

end

function ActionBar:render()
end

function ActionBar:draw()
	for i,ability in ipairs(self.abilities) do
		love.graphics.setColor(128,128,128)
		love.graphics.rectangle("fill", self.position.x + (i - 1) * TILE_SIZE, self.position.y, TILE_SIZE, TILE_SIZE)
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", self.position.x + (i - 1) * TILE_SIZE, self.position.y, TILE_SIZE, TILE_SIZE)
		love.graphics.setNewFont(TILE_SIZE/4)
		love.graphics.print(i, self.position.x + (TILE_SIZE * 0.1) + (i - 1) * TILE_SIZE, self.position.y + (TILE_SIZE * 0.1))
	end
end