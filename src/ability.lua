Ability = class{
	init = function(self, def)
		self.cost = def.cost or 1
		self.name = def.name or "thing"
		self.particles = {} --
		self.animations = {} --
		self.icon = def.icon or nil
		self.cd = def.cd or 1
		self.cdTimer = 0
		self.lvl = 1
		self.execute = def.execute or function() end
		self.undo = def.undo or function() end
	end
}