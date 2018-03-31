require("src.dependencies")

function love.load()
    love.graphics.setBackgroundColor(0,0,0)
    love.window.setTitle("Tiny X-Com")

    -- love.graphics.setDefaultFilter("nearest", "nearest", 1)

    io.stdout:setvbuf("no")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        pixelperfect = true,
        highdpi = true,
        canvas = false
    })

    gameState.registerEvents()
    gameState.switch(MenuState)   
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