ABILITY_DEFS = {
	["heal"] = {
		cost = 1,
		execute = function()
			print("heal")
		end,
		undo = function()
		end
	},
	["smite"] = {
		cost = 1,
		execute = function()
			print("smite")
		end,
		undo = function()
		end
	},	
	["strike"] = {
		cost = 1,
		execute = function()
			print("strike")
		end,
		undo = function()
		end
	},
	["block"] = {
		cost = 1,
		cd = 2,
		execute = function()
			print("block")
		end,
		undo = function()
			print("undo block")
		end
	}
}