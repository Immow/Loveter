local c = require("loveter.classes.container")
local b = require("loveter.classes.box")

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
		"wrapSpaceFixed",
		"fixedWidthSpaceBetween",
		"fixedWidthSpaceBetweenPaddingLeftAndRight",
		"wrapPaddingLeft",
		"wrapPaddingLeftRight",
		"TwoContainersFixedWidth",
		"TwoContainersFixedWidthPaddingLeft",
		"TwoContainersFixedWidthPaddingRightAlignRight",
		"TwoContainersWrap",
		"TwoContainersWrapDoublePadding",
		"TwoContainersSpaceEvenly",
		"TwoContainersSpaceEvenlyPadding",
		"TripleContainerStretch",
		"ThreeContainersStretch",
		"ThreeContainersStretchOnlyContainers",
		"fixedWidthpaddingTopBottom",
		"fixedWidthpaddingTopBottomLeftRight",
		"wrapPaddingTopBottomLeftRight",
		"fixedWidthSpaceEvenelyPaddingTopBottomLeftRight",
		"fixedWidthSpaceEvenelyPaddingTopBottomRight",
		"fixedWidthSpaceEvenelyPaddingTopBottomTwoContainers",
	}
}

Horizontal.boxes = {}
Horizontal.container = {}


function Horizontal:default()
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Horizontal:paddingLeft()
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {left = 50},
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {left = 50, right = 50},
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {left = 50, right = 50},
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		spacing = {fixed = 25},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Horizontal:wrapSpaceFixed()
	self.container = c.new({
		x = 10,
		y = 200,
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
	self.container = c.new({
		x = 10,
		y = 200,
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Horizontal:wrapPaddingLeft()
	self.container = c.new({
		x = 10,
		y = 200,
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
	self.container = c.new({
		x = 10,
		y = 200,
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		children = {
			c.new({
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {left = 50},
		children = {
			c.new({
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {right = 50},
		align = {right = true},
		children = {
			c.new({
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
	self.container = c.new({
		x = 10,
		y = 200,
		children = {
			c.new({
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
	self.container = c.new({
		x = 10,
		y = 200,
		padding = {left = 50, right = 50},
		children = {
			c.new({
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
	self.container = c.new({
		x = 10,
		y = 200,
		children = {
			c.new({
				w = 400,
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
	self.container = c.new({
		x = 10,
		y = 200,
		padding = {left = 50, right = 50},
		children = {
			c.new({
				w = 400,
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		children = {
			c.new({
				stretch = {x = 33.3},
				children = {
					self.boxes.b1
				}
			}),
			c.new({
				stretch = {x = 33.3},
				children = {
					self.boxes.b2
				}
			}),
			c.new({
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

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		children = {
			c.new({
				stretch = {x = 50},
				children = {
					self.boxes.b2,
					c.new({
						stretch = {x = 100},
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
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		children = {
			c.new({
				stretch = {x = 50},
				children = {
					c.new({
						stretch = {x = 50},
						children = {
							self.boxes.b1
						}
					}),
				}
			}),
		}
	})

	self.container:load()
end

function Horizontal:fixedWidthpaddingTopBottom()
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50},
		children = {
			self.boxes.b1
		}
	})

	self.container:load()
end

function Horizontal:fixedWidthpaddingTopBottomLeftRight()
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50, left = 50, right = 50},
		children = {
			self.boxes.b1
		}
	})

	self.container:load()
end

function Horizontal:wrapPaddingTopBottomLeftRight()	self.container = c.new({
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50, left = 50, right = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Horizontal:fixedWidthSpaceEvenelyPaddingTopBottomLeftRight()
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50, left = 50, right = 50},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Horizontal:fixedWidthSpaceEvenelyPaddingTopBottomRight()
	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50, right = 50},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Horizontal:fixedWidthSpaceEvenelyPaddingTopBottomTwoContainers()
	

	self.container = c.new({
		w = 400,
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			c.new({
				children = {
					self.boxes.b2,
					self.boxes.b3
				}
			}),
			self.boxes.b4,
		}
	})

	self.container:load()
end

function Horizontal:load()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 50, h = 100})
	self.boxes.b3 = b.new({w = 50, h = 50})
	self.boxes.b4 = b.new({w = 50, h = 50})
	self:default()
end

function Horizontal:keypressed(key, scancode, isrepeat)
	if key == "down" then
		if selectedTest < #self.tests then
			c.createID = 0
			selectedTest = selectedTest + 1
			self[self.tests[selectedTest]](self)
			-- print(self.tests[selectedTest])
		else
			c.createID = 0
			selectedTest = 1
			self[self.tests[selectedTest]](self)
			-- print(self.tests[selectedTest])
		end
	end

	if key == "up" then
		if selectedTest > 1 then
			c.createID = 0
			selectedTest = selectedTest - 1
			self[self.tests[selectedTest]](self)
			-- print(self.tests[selectedTest])
		else
			c.createID = 0
			selectedTest = #self.tests
			self[self.tests[selectedTest]](self)
			-- print(self.tests[selectedTest])
		end
	end
end

function Horizontal:textinput(t)

end

function Horizontal:update(dt)
	self.container:update(dt)
end


function Horizontal:draw()
	self.container:draw()
	love.graphics.print("Horizontal", WINDOW_WIDTH - (FONT:getWidth("Horizontal") + 10))
	love.graphics.print(self.tests[selectedTest], WINDOW_WIDTH - (FONT:getWidth(self.tests[selectedTest]) + 10), FONT:getHeight() + 2)
end

return Horizontal