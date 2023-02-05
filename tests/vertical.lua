local c = require("container")
local b = require("box")

local selectedTest = 1

local Vertical = {
	tests = {
		"default",
		"wrap",
		"alignRight",
		"paddingLeft",
		"alignRightPaddingRight",
		"fixedWidthSpaceEvenely",
		"fixedWidthSpaceEvenelyPaddingLeft",
		"fixedWidthSpaceEvenelyPaddingLeftRight",
		"fixedWidthSpaceFixed",
		"wrapWidthSpaceFixed",
		"fixedWidthSpaceBetween",
		"fixedWidthSpaceBetweenPaddingLeftAndRight",
		"wrapPadding",
		"wrapPaddingLeftRight",
		"TwoContainersFixedWidth",
		"TwoContainersFixedWidthPaddingLeft",
		"TwoContainersFixedWidthPaddingRightAlignRight",
		"TwoContainersWrap",
		"TwoContainersWrapDoublePadding",
		"TwoContainersSpaceEvenly",
		"TwoContainersSpaceEvenlyPadding",
	}
}

Vertical.boxes = {}
Vertical.container = {}

function Vertical:default()
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

function Vertical:paddingLeft()
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

function Vertical:alignRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		align = {right = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:alignRightPaddingRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		align = {right = true},
		padding = {right = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:fixedWidthSpaceEvenely()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:fixedWidthSpaceEvenelyPaddingLeft()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {left = 50},
		mainAlign = {horizontal = true},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end


function Vertical:fixedWidthSpaceEvenelyPaddingLeftRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})
	
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {left = 50, right = 50},
		mainAlign = {horizontal = true},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})
	
	self.container:load()
end

function Vertical:fixedWidthSpaceBetween()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		spacing = {between = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:fixedWidthSpaceBetweenPaddingLeftAndRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {left = 50, right = 50},
		mainAlign = {horizontal = true},
		spacing = {between = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:fixedWidthSpaceFixed()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		spacing = {fixed = 25},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:wrapWidthSpaceFixed()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		spacing = {fixed = 25},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:wrap()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
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

function Vertical:wrapPadding()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
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

function Vertical:wrapPaddingLeftRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		padding = {left = 50, right = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:TwoContainersFixedWidth()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		children = {
			c.new({
				mainAlign = {horizontal = true},
				children = {
					self.boxes.b1,
					self.boxes.b2,
					self.boxes.b3,
				}
			}),
		}
	})

	self.container:load()
end

function Vertical:TwoContainersFixedWidthPaddingLeft()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {left = 50},
		mainAlign = {horizontal = true},
		children = {
			c.new({
				mainAlign = {horizontal = true},
				children = {
					self.boxes.b1,
					self.boxes.b2,
					self.boxes.b3
				}
			}),
		}
	})

	self.container:load()
end

function Vertical:TwoContainersFixedWidthPaddingRightAlignRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {right = 50},
		align = {right = true},
		mainAlign = {horizontal = true},
		children = {
			c.new({
				mainAlign = {horizontal = true},
				children = {
					self.boxes.b1,
					self.boxes.b2,
					self.boxes.b3
				}
			}),
		}
	})

	self.container:load()
end

function Vertical:TwoContainersWrap()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		children = {
			c.new({
				mainAlign = {horizontal = true},
				children = {
					self.boxes.b1,
					self.boxes.b2,
					self.boxes.b3,
				}
			}),
		}
	})

	self.container:load()
end

function Vertical:TwoContainersWrapDoublePadding()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		padding = {left = 50, right = 50},
		children = {
			c.new({
				mainAlign = {horizontal = true},
				children = {
					self.boxes.b1,
					self.boxes.b2,
					self.boxes.b3
				}
			}),
		}
	})

	self.container:load()
end

function Vertical:TwoContainersSpaceEvenly()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		children = {
			c.new({
				w = 400,
				mainAlign = {horizontal = true},
				spacing = {evenly = true},
				children = {
					self.boxes.b1,
					self.boxes.b2,
					self.boxes.b3
				}
			}),
		}
	})

	self.container:load()
end

function Vertical:TwoContainersSpaceEvenlyPadding()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})

	self.container = c.new({
		x = 10,
		y = 200,
		padding = {left = 50, right = 50},
		mainAlign = {horizontal = true},
		children = {
			c.new({
				w = 400,
				mainAlign = {horizontal = true},
				spacing = {evenly = true},
				children = {
					self.boxes.b1,
					self.boxes.b2,
					self.boxes.b3
				}
			}),
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
end

return Vertical