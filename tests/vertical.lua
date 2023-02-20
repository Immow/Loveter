local c = require("loveter.classes.container")
local b = require("loveter.classes.box")

local selectedTest = 1

local Vertical = {
	tests = {
		"default",
		"wrap",
		"alignBottom",
		"paddingTop",
		"alignBottomPaddingBottom",
		"fixedHeighthSpaceEvenely",
		"fixedHeighthSpaceEvenelyPaddingTop",
		"fixedHeighthSpaceEvenelyPaddingTopBottom",
		"fixedHeighthSpaceFixed",
		"wrapSpaceFixed",
		"fixedHeighthSpaceBetween",
		"fixedHeighthSpaceBetweenPaddingTopBottom",
		"wrapPaddingTop",
		"wrapPaddingTopBottom",
		"TwoContainersFixedHeight",
		"TwoContainersFixedHeightPaddingTop",
		"TwoContainersFixedHeightPaddingBottomAlignBottom",
		"TwoContainersWrap",
		"TwoContainersWrapDoublePadding",
		"TwoContainersSpaceEvenly",
		"TwoContainersSpaceEvenlyPadding",
		"TripleContainerStretch",
		"ThreeContainersStretch",
		"ThreeContainersStretchOnlyContainers",
		"fixedHeightpaddingLeftRight",
		"fixedHeightpaddingTopBottomLeftRight",
		"wrapPaddingTopBottomLeftRight",
		"fixedHeightSpaceEvenelyPaddingTopBottomLeftRight",
		"fixedHeightSpaceEvenelyPaddingTopBottomRight",
		"fixedHeightSpaceEvenelyPaddingTopBottomTwoContainers",
	}
}

Vertical.boxes = {}
Vertical.container = {}


function Vertical:default()
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

function Vertical:wrap()
	self.container = c.new({
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

function Vertical:paddingTop()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {top = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:alignBottom()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		align = {bottom = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:alignBottomPaddingBottom()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		align = {bottom = true},
		padding = {bottom = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:fixedHeighthSpaceEvenely()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:fixedHeighthSpaceEvenelyPaddingTop()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		padding = {top = 50},
		mainAlign = {vertical = true},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end


function Vertical:fixedHeighthSpaceEvenelyPaddingTopBottom()

	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50},
		mainAlign = {vertical = true},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})
	
	self.container:load()
end

function Vertical:fixedHeighthSpaceBetween()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		spacing = {between = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:fixedHeighthSpaceBetweenPaddingTopBottom()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50},
		mainAlign = {vertical = true},
		spacing = {between = true},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:fixedHeighthSpaceFixed()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		spacing = {fixed = 25},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:wrapSpaceFixed()
	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		spacing = {fixed = 25},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3,
		}
	})

	self.container:load()
end

function Vertical:wrapPaddingTop()
	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {top = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:wrapPaddingTopBottom()
	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {top = 50, bottom = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:TwoContainersFixedHeight()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		children = {
			c.new({
				mainAlign = {vertical = true},
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

function Vertical:TwoContainersFixedHeightPaddingTop()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		padding = {top = 50},
		mainAlign = {vertical = true},
		children = {
			c.new({
				mainAlign = {vertical = true},
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

function Vertical:TwoContainersFixedHeightPaddingBottomAlignBottom()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		padding = {bottom = 50},
		align = {bottom = true},
		mainAlign = {vertical = true},
		children = {
			c.new({
				mainAlign = {vertical = true},
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
	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		children = {
			c.new({
				mainAlign = {vertical = true},
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
	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {top = 50, bottom = 50},
		children = {
			c.new({
				mainAlign = {vertical = true},
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
	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		children = {
			c.new({
				h = 400,
				mainAlign = {vertical = true},
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
	self.container = c.new({
		x = 10,
		y = 200,
		padding = {top = 50, bottom = 50},
		mainAlign = {vertical = true},
		children = {
			c.new({
				h = 400,
				mainAlign = {vertical = true},
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

function Vertical:TripleContainerStretch()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		children = {
			c.new({
				mainAlign = {vertical = true},
				stretch = {y = 33.3},
				children = {
					self.boxes.b1
				}
			}),
			c.new({
				mainAlign = {vertical = true},
				stretch = {y = 33.3},
				children = {
					self.boxes.b2
				}
			}),
			c.new({
				mainAlign = {vertical = true},
				stretch = {y = 33.3},
				children = {
					self.boxes.b3
				}
			}),
		},
	})

	self.container:load()
end

function Vertical:ThreeContainersStretch()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 100, h = 50})

	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		children = {
			c.new({
				stretch = {y = 50},
				mainAlign = {vertical = true},
				children = {
					self.boxes.b2,
					c.new({
						stretch = {y = 100},
						mainAlign = {vertical = true},
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

function Vertical:ThreeContainersStretchOnlyContainers()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		children = {
			c.new({
				stretch = {y = 50},
				mainAlign = {vertical = true},
				children = {
					c.new({
						stretch = {y = 50},
						mainAlign = {vertical = true},
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

function Vertical:fixedHeightpaddingLeftRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {left = 50, right = 50},
		children = {
			self.boxes.b1
		}
	})

	self.container:load()
end

function Vertical:fixedHeightpaddingTopBottomLeftRight()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {top = 50, bottom = 50, left = 50, right = 50},
		children = {
			self.boxes.b1
		}
	})

	self.container:load()
end

function Vertical:wrapPaddingTopBottomLeftRight()
self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {top = 50, bottom = 50, left = 50, right = 50},
		children = {
			self.boxes.b1,
			self.boxes.b2,
			self.boxes.b3
		}
	})

	self.container:load()
end

function Vertical:fixedHeightSpaceEvenelyPaddingTopBottomLeftRight()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
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

function Vertical:fixedHeightSpaceEvenelyPaddingTopBottomRight()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
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

function Vertical:fixedHeightSpaceEvenelyPaddingTopBottomTwoContainers()
	self.container = c.new({
		h = 400,
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {left = 50, right = 50},
		spacing = {evenly = true},
		children = {
			self.boxes.b1,
			c.new({
				mainAlign = {vertical = true},
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

function Vertical:load()
	self.boxes.b1 = b.new({w = 50, h = 50})
	self.boxes.b2 = b.new({w = 100, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})
	self.boxes.b4 = b.new({w = 50, h = 50})
	self:default()
end

function Vertical:keypressed(key, scancode, isrepeat)
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

function Vertical:textinput(t)

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