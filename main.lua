require("globals")
local Test = require("test")

function love.load()
	Test:default()
end

function love.keypressed(key, scancode, isrepeat)
	Test:keypressed(key, scancode, isrepeat)
end

function love.update(dt)
	Test:update(dt)
end

function love.draw()
	Test:draw()
end