require("globals")
local c = require("container")
local b = require("box")

local Test = {container = {}, boxes = {}}

local list = {
	"default",
	"paddingleft",
	"wrap",
	"alignRight",
	"alignRightPaddingRight",
	"wrapPadding",
}

function Test:default()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		children = {
			self.boxes.b1,
			self.boxes.b2
		}
	})

	self.container:load()
end

function Test:paddingleft()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		padding = {left = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2
		}
	})

	self.container:load()
end

function Test:alignRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		align = {right = true},
		children = {
			self.boxes.b1,
			self.boxes.b2
		}
	})

	self.container:load()
end

function Test:alignRightPaddingRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		align = {right = true},
		padding = {right = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2
		}
	})

	self.container:load()
end

function Test:wrap()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		children = {
			self.boxes.b1,
			self.boxes.b2
		}
	})

	self.container:load()
end

function Test:wrapPadding()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		padding = {left = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2
		}
	})

	self.container:load()
end

local selected = 1
function Test:keypressed(key, scancode, isrepeat)
	if key == "down" then
		if selected < #list then
			selected = selected + 1
			c.createID = 0
			self[list[selected]](self)
			print(list[selected])
		else
			c.createID = 0
			selected = 1
			self[list[selected]](self)
			print(list[selected])
		end
	end

	if key == "up" then
		if selected > 1 then
			selected = selected - 1
			c.createID = 0
			self[list[selected]](self)
			print(list[selected])
		else
			c.createID = 0
			selected = #list
			self[list[selected]](self)
			print(list[selected])
		end
	end
end

function Test:update(dt)
	self.container:update(dt)
end

function Test:draw()
	self.container:draw()
end

return Test