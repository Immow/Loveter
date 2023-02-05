local c = require("container")
local b = require("box")

local selectedTest = 1

local Horizontal = {
	tests = {
		"default",
		"paddingLeft",
	}
}

Horizontal.boxes = {}
Horizontal.container = {}

function Horizontal:default() -- Change mainAlign to horizontal
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Horizontal:paddingLeft()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		padding = {left = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Horizontal:load()
	self:default()
end

function Horizontal:keypressed(key, scancode, isrepeat)
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

function Horizontal:update(dt)
	self.container:update(dt)
end


function Horizontal:draw()
	self.container:draw()
	love.graphics.print("Horizontal", WINDOW_WIDTH - (FONT:getWidth("Horizontal") + 10))
end

return Horizontal