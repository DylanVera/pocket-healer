MenuState = {}

function MenuState:init()
end

function MenuState:enter()
end

function MenuState:exit()
end

function MenuState:draw()
	push:start()
	love.graphics.setColor({255,255,255})
	love.graphics.printf("NO", 0, math.floor(VIRTUAL_HEIGHT/2), VIRTUAL_WIDTH, "center")
	push:finish()
end

function MenuState:update(dt)
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateStack:push(PlayState());
	end
end

function MenuState:keypressed(key)
	gameState.switch(PlayState)
end