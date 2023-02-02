require("globals")
local c = require("container")
local b = require("box")

local c1
local b1
local b2

function love.load()
	b1 = b.new({w = 50, h = 50})
	b2 = b.new({w = 50, h = 50})

	c1 = c.new({
		-- w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		-- align = {right = true},
		-- padding = {left = 50},
		children = {
			c.new({
				-- w = 200,
				mainAlign = {horizontal = true},
				-- padding = {left = 50},
				-- spacing = {evenly = true},
				-- align = {right = true},
				stretch = {x = 50},
				children = {
					b1,
					b2
				}
			})
		}
	})

	c1:load()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "up" then
		c1.y =  c1.y - 1
	end
	if key == "down" then
		c1.y =  c1.y + 1
	end
end

function love.update(dt)
	c1:update(dt)
end

function love.draw()
	c1:draw()
end