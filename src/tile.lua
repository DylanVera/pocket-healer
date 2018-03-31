Tile = class{
	init = function(self, position, solid, color)
		self.position = position
		self.isSolid = solid or false
		self.effects = {}
		self.entity = {}	--queue/stack?
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