require("globals")

local Test = require("test")

function love.load()
	Test:load()
end

function love.keypressed(key, scancode, isrepeat)
	Test:keypressed(key, scancode, isrepeat)
end

function love.mousepressed(x, y, button, istouch, presses)
	Test:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
	Test:mousereleased(x, y, button, istouch, presses)
end

function love.textinput(t)
	Test:textinput(t)
end

function love.update(dt)
	Test:update(dt)
end

function love.draw()
	Test:draw()
end