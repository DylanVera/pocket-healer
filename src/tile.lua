Tile = class{
	init = function(self, position, solid, color)
		self.tilePos = position
		self.center = self.tilePos + Vector(TILE_SIZE/2, TILE_SIZE/2)
		self.isSolid = solid or false
		self.effects = {}
		self.entity = nil	--queue/stack?
		self.color = color or {128,128,128}
	end
}

function Tile:getEntity()
	if self.entity ~= nil then
		return self.entity
	end
end

function Tile:getEffect()
	return self.effects[#self.effects]
end