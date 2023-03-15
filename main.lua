require("globals")
State_Manager = require("libs.state_manager.state_manager")
require("libs.tprint")

function love.load()
	State_Manager.requireState("test")
	State_Manager.setState("testing")
	State_Manager:load()
end

function love.update(dt)
	State_Manager:update(dt)
end

function love.draw()
	State_Manager:draw()
end

function love.mousepressed(mx, my, mouseButton)
	State_Manager:mousepressed(mx, my, mouseButton)
end

function love.mousereleased(mx, my, mouseButton)
	State_Manager:mousereleased(mx, my, mouseButton)
end

function love.mousemoved(x, y, dx, dy, istouch)
	State_Manager:mousemoved(x, y, dx, dy, istouch)
end

function love.keypressed(key,scancode,isrepeat)
	State_Manager:keypressed(key,scancode,isrepeat)
end

function love.textinput(t)
	State_Manager:textinput(t)
end