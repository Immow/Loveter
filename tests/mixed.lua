local c = require("container")
local b = require("box")

local selectedTest = 1

local Mixed = {
	tests = {
		"default",
		"test",
	}
}

Mixed.boxes = {}
Mixed.container = {}


function Mixed:default()
	self.boxes.b1 = b.new({w = 50, h = 100})
	self.boxes.b2 = b.new({w = 100, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})
	self.boxes.b4 = b.new({w = 50, h = 50})
	self.boxes.b5 = b.new({w = 50, h = 50})
	self.boxes.b6 = b.new({w = 50, h = 50})

	self.container = c.new({
		h = 600,
		w = 600,
		x = 10,
		y = 100,
		mainAlign = {horizontal = true},
		children = {
			c.new({
				mainAlign = {horizontal = true},
				-- stretch = {x = 100},
				stretch = {x = 50, y = 100},
				children = {
					self.boxes.b1,
					self.boxes.b2,
					-- self.boxes.b3
				}
			}),
			c.new({
				mainAlign = {horizontal = true},
				-- stretch = {x = 100},
				stretch = {x = 50, y = 100},
				children = {
					self.boxes.b3,
					self.boxes.b4
				}
			}),
			c.new({
				mainAlign = {horizontal = true},
				-- stretch = {x = 100},
				-- stretch = {y = 100},
				children = {
					self.boxes.b5,
					self.boxes.b6,
					-- self.boxes.b6
				}
			}),
		}
	})

	self.container:load()
end

function Mixed:test()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 100, h = 50})
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

function Mixed:load()
	self:default()
end

function Mixed:keypressed(key, scancode, isrepeat)
	if key == "down" then
		if selectedTest < #self.tests then
			selectedTest = selectedTest + 1
			c.createID = 0
			self[self.tests[selectedTest]](self)
		else
			c.createID = 0
			selectedTest = 1
			self[self.tests[selectedTest]](self)
		end
	end

	if key == "up" then
		if selectedTest > 1 then
			selectedTest = selectedTest - 1
			c.createID = 0
			self[self.tests[selectedTest]](self)
		else
			c.createID = 0
			selectedTest = #self.tests
			self[self.tests[selectedTest]](self)
		end
	end
end

function Mixed:update(dt)
	self.container:update(dt)
end


function Mixed:draw()
	self.container:draw()
	love.graphics.print("Mixed", WINDOW_WIDTH - (FONT:getWidth("Mixed") + 10))
	love.graphics.print(self.tests[selectedTest], WINDOW_WIDTH - (FONT:getWidth(self.tests[selectedTest]) + 10), FONT:getHeight() + 2)

end

return Mixed