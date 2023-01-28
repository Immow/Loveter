require("debug")
local c = require("container")
local b = require("box")

local c1
local b1

function love.load()
	b1 = b.new({w = 100, h = 50})

	c1 = c.new({
		w = 400,
		x = 10,
		y = 200,
		children = {
			c.new({
				-- padding = {left = 50, right = 100},
				-- stretch = {x = 75},
				children = {
					b1
				}
			})
		}
	})

	c1:load()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "q" then
		c1.y =  c1.y - 1
	end
	if key == "w" then
		c1.children[1].y =  c1.children[1].y + 1
	end
	if key == "e" then
		c1.children[1].children[1].y =  c1.children[1].children[1].y + 1
	end
end

function love.update(dt)
	c1:update(dt)
end

function love.draw()
	c1:draw()
end