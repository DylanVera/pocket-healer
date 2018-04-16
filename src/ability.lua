Ability = class{
	init = function(self, def, actor)
		self.actor = actor
		self.cost = def.cost or 1
		self.name = def.name or "thing"
		self.particles = {} --particle system for spell fx and whatever else.
		self.animations = {} --sprite anims
		self.icon = def.icon or nil
		self.cd = def.cd or 1
		self.cdTimer = 0
		self.lvl = 1
		self.cast = def.cast or function() end
		self.execute = def.execute or function() end
		self.undo = def.undo or function() end
	end
}