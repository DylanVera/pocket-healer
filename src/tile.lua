Tile = class{
	init = function(self, type, position)
		self.tilePos = position
		self.center = (self.tilePos * TILE_SIZE) + Vector(TILE_SIZE/2, TILE_SIZE/2)
		self.isSolid = type.isSolid or false
		self.effects = {}
		self.entity = nil	--queue/stack?
		self.color = type.color or {0,0,0}
		self.onEnter = type.onEnter or function() end
		self.prop = nil
	end
}

function Tile:getEntity()
	return self.entity
end

function Tile:getProp()
	return self.prop
end

function Tile:getEffect()
	return self.effects[#self.effects]
end
 
function Tile:toggleSolid()
	self.isSolid = not self.isSolid
	if self.isSolid then
		self.color = TILE_TYPES["wall"].color
	else
		self.color = TILE_TYPES["blank"].color
	end
end