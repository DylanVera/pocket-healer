MenuState = {}

function MenuState:init()
end

function MenuState:enter()
end

function MenuState:leave()
end

function MenuState:draw()
	push:start()
	love.graphics.setColor({255,255,255})
	love.graphics.print("NO", VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2)
	push:finish()
end

function MenuState:update(dt)
end

function MenuState:keypressed(key)
	if key == "return" then
		gameState.switch(PlayState);
	end
end