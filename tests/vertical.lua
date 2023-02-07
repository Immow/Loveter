local c = require("container")
local b = require("box")

local selectedTest = 1

-- TODO add multiple stretch container test

local Vertical = {
	tests = {
		"default",
		"twoContainers",
	}
}

Vertical.boxes = {}
Vertical.container = {}

function Vertical:default()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 150, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:twoContainers()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 150, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		children = {
			self.boxes.b1,
			c.new({
				mainAlign = {vertical = true},
				children = {
					self.boxes.b2,
					self.boxes.b3
				}
			})
		}
	})

	self.container:load()
end

function Vertical:load()
	self:default()
end

function Vertical:keypressed(key, scancode, isrepeat)
	if key == "down" then
		if selectedTest < #self.tests then
			selectedTest = selectedTest + 1
			c.createID = 0
			self[self.tests[selectedTest]](self)
			print(self.tests[selectedTest])
		else
			c.createID = 0
			selectedTest = 1
			self[self.tests[selectedTest]](self)
			print(self.tests[selectedTest])
		end
	end

	if key == "up" then
		if selectedTest > 1 then
			selectedTest = selectedTest - 1
			c.createID = 0
			self[self.tests[selectedTest]](self)
			print(self.tests[selectedTest])
		else
			c.createID = 0
			selectedTest = #self.tests
			self[self.tests[selectedTest]](self)
			print(self.tests[selectedTest])
		end
	end
end

function Vertical:update(dt)
	self.container:update(dt)
end


function Vertical:draw()
	self.container:draw()
	love.graphics.print("Vertical", WINDOW_WIDTH - (FONT:getWidth("Vertical") + 10))
	love.graphics.print(self.tests[selectedTest], WINDOW_WIDTH - (FONT:getWidth(self.tests[selectedTest]) + 10), FONT:getHeight() + 2)

end

return Vertical