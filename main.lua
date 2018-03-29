require("src.dependencies")

function love.load()
    love.graphics.setBackgroundColor(1, 1, .75)
    love.window.setTitle("Pocket Healer")

    io.stdout:setvbuf("no")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gameState.registerEvents()
    gameState.switch(playState)   
end

function love.update(dt)
	flux.update(dt)
	timer.update(dt)
	screen:update(dt)
end

function love.draw()
	screen:apply()
	suit.draw()
end

function love.resize(w, h)
    push:resize(w, h)
end