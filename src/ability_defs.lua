ABILITY_DEFS = {
	["heal"] = {
		cost = 1,
		targetType = UNIT_TARGET,
		value = 1,
		range = 2,
		cast = function(self)
			local neighbors = board:getNeighbors(self.actor.tilePos)
	    	
	    	TargetState.tiles = neighbors
	    	TargetState.ability = self
	    	gameState.push(TargetState)
	    	--handle click event for targeting while in casting state
	    	--figure out a targeting state to  deal 
		end,
		execute = function(self, target) 
			print("heal")
			target:heal(self.value)
			self.actor.ap = self.actor.ap - self.cost
		end,
		undo = function()
		end
	},
	["smite"] = {
		cost = 1,
		range = 2,
		value = 2,
		targetType = UNIT_TARGET,
		execute = function()
			print("smite")
		end,
		undo = function()
		end
	},	
	["strike"] = {
		cost = 1,
		value = 2,
		targetType = UNIT_TARGET,
		cast = function(self)
			local neighbors = board:getNeighbors(self.actor.tilePos)
	    	
	    	TargetState.tiles = neighbors
	    	TargetState.ability = self
	    	gameState.push(TargetState)
	    	--how are we figuring out what the target is
		end,
		execute = function(self, target)
			print("strike")
			target:damage(self.value)
			self.actor.ap = self.actor.ap - self.cost
			screen:shake(100)

			--find out target
			-- target:damage(damage)
		end,
		undo = function()
		end
	},
	["block"] = {
		cost = 1,
		cd = 2,
		targetType = NONE,
		execute = function()
			print("block")
		end,
		undo = function()
		end
	},
	["taunt"] = {

	},
	["cleave"] = {

	},
	["eat"] = {
		cost = 1,
		value = 2,
		targetType = UNIT_TARGET,
		cast = function(self)
			local neighbors = board:getNeighbors(self.actor.tilePos)
	    
	    	TargetState.tiles = neighbors
	    	TargetState.ability = self
	    	gameState.push(TargetState)
		end,
		execute = function(self, target)
			print("eating")
			target:kill()
			table.insert(self.actor.stomach, target)
			self.actor.ap = self.actor.ap - self.cost
		end,
		undo = function()
		end 
	},
	["barf"] = {
		cost = 1,
		cd = 0,
		range = 1,
		targetType = UNIT_TARGET,
		cast = function(self)
		end,
		execute = function(self, target)
			local barfee = table.remove(self.actor.stomach)
			baffee.alive = true
			barfee.tilePos = target.tilePos
		end,
		undo = function(self)
		end 
	}
}