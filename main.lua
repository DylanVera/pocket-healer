require("src.dependencies")

function love.load()
    love.graphics.setBackgroundColor(0,0,0)
    love.window.setTitle("Tiny X-Com")

    math.randomseed(os.time())
    love.math.setRandomSeed(os.time())
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    
    io.stdout:setvbuf("no")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        pixelperfect = true,
        highdpi = true,
        canvas = false
    })

    gStateStack = StateStack()
    -- gStateStack:push(MenuState())

    -- love.keyboard.keysPressed = {}
    gameState.registerEvents()
    gameState.switch(MenuState)   
end

function love.update(dt)
	flux.update(dt)
	timer.update(dt)
	screen:update(dt)
    
    -- gStateStack:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    -- push:start()
    suit.draw()
	screen:apply()
    -- push:finish()
    -- gStateStack:render()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end