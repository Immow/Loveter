local c = require("container")
local b = require("box")

local selectedTest = 1

local Horizontal = {
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
		"TripleContainerStretch",
		-- "ThreeContainersStretch",
		-- "ThreeContainersStretchOnlyContainers",
	}
}

Horizontal.boxes = {}
Horizontal.container = {}


function Horizontal:default()
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

function Horizontal:alignRight()
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

function Horizontal:alignRightPaddingRight()
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

function Horizontal:fixedWidthSpaceEvenely()
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

function Horizontal:fixedWidthSpaceEvenelyPaddingLeft()
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


function Horizontal:fixedWidthSpaceEvenelyPaddingLeftRight()
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

function Horizontal:fixedWidthSpaceBetween()
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

function Horizontal:fixedWidthSpaceBetweenPaddingLeftAndRight()
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

function Horizontal:fixedWidthSpaceFixed()
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

function Horizontal:wrapWidthSpaceFixed()
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

function Horizontal:wrap()
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

function Horizontal:wrapPadding()
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

function Horizontal:wrapPaddingLeftRight()
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

function Horizontal:TwoContainersFixedWidth()
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

function Horizontal:TwoContainersFixedWidthPaddingLeft()
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

function Horizontal:TwoContainersFixedWidthPaddingRightAlignRight()
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

function Horizontal:TwoContainersWrap()
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

function Horizontal:TwoContainersWrapDoublePadding()
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

function Horizontal:TwoContainersSpaceEvenly()
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

function Horizontal:TwoContainersSpaceEvenlyPadding()
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

function Horizontal:TripleContainerStretch()
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
				stretch = {x = 33.3},
				children = {
					self.boxes.b1
				}
			}),
			c.new({
				mainAlign = {horizontal = true},
				stretch = {x = 33.3},
				children = {
					self.boxes.b2
				}
			}),
			c.new({
				mainAlign = {horizontal = true},
				stretch = {x = 33.3},
				children = {
					self.boxes.b3
				}
			}),
		},
	})

	self.container:load()
end

function Horizontal:ThreeContainersStretch()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		children = {
			c.new({
				stretch = {x = 50},
				mainAlign = {horizontal = true},
				children = {
					self.boxes.b2,
					c.new({
						stretch = {x = 100},
						mainAlign = {horizontal = true},
						children = {
							self.boxes.b1,
						}
					}),
				}
			}),
		}
	})

	self.container:load()
end

function Horizontal:ThreeContainersStretchOnlyContainers()
	self.boxes.b1 = b.new({w = 50, h = 50})

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		mainAlign = {horizontal = true},
		children = {
			c.new({
				stretch = {x = 50},
				mainAlign = {horizontal = true},
				children = {
					c.new({
						stretch = {x = 50},
						mainAlign = {horizontal = true},
						children = {
							self.boxes.b1,
						}
					}),
				}
			}),
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
			c.createID = 0
			selectedTest = selectedTest + 1
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
			c.createID = 0
			selectedTest = selectedTest - 1
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