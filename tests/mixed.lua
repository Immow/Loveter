local c = require("loveter.classes.container")
local b = require("loveter.classes.box")
local newButton = require("loveter.classes.button")
local newForm = require("loveter.classes.form")
local newText = require("loveter.classes.text")

local selectedTest = 1

local Mixed = {
	tests = {
		"default",
		-- "test",
		"login",
	}
}

Mixed.boxes = {}
Mixed.container = {}
Mixed.buttons = {}
Mixed.forms = {}
Mixed.texts = {}


function Mixed:default()
	self.boxes.b1 = b.new({w = 50, h = 100})
	self.boxes.b2 = b.new({w = 100, h = 50})
	self.boxes.b3 = b.new({w = 50, h = 50})
	self.boxes.b4 = b.new({w = 50, h = 50})
	self.boxes.b5 = b.new({w = 50, h = 50})
	self.boxes.b6 = b.new({w = 50, h = 50})
	self.boxes.b7 = b.new({w = 75, h = 75})

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
				mainAlign = {vertical = true},
				-- stretch = {x = 100},
				stretch = {x = 50, y = 100},
				children = {
					c.new({
						mainAlign = {horizontal = true},
						stretch = {y = 100, x = 100},
						children = {
							self.boxes.b3,
							self.boxes.b7
						}
					}),
					self.boxes.b4,
				}
			}),
			c.new({
				mainAlign = {horizontal = true},
				-- stretch = {x = 100},
				stretch = {y = 100},
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

local textFont = love.graphics.newFont("loveter/assets/font/Roboto-Regular.ttf", 50)
local buttonFont = love.graphics.newFont("loveter/assets/font/Roboto-Regular.ttf", 20)

function Mixed:login()
	self.buttons.b1 = newButton.new({
									w = 300,
									h = 50,
									text = "SIGN IN",
									func = function() return print("test") end,
									buttonBackgroundColor = {0.6, 0.1, 0.1},
									font = buttonFont,
									clickEffect = true
								})
	self.forms.f1 = newForm.new({w = 300, h = 50, previewText = "username", icon = "loveter/assets/icon/user.png", iconColor = {0.5,0.5,0.5}, iconScale = 0.75})
	self.forms.f2 = newForm.new({w = 300, h = 50, previewText = "password", icon = "loveter/assets/icon/password.png", iconColor = {0.5,0.5,0.5}, iconScale = 0.75})
	self.texts.t1 = newText.new({text = "SIGN IN", font = textFont})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {top = 20, bottom = 20 , left = 20, right = 20},
		spacing = {fixed = 10},
		background = {0.1, 0.1, 0.1},
		children = {
			self.texts.t1,
			self.forms.f1,
			self.forms.f2,
			self.buttons.b1,
			c.new({
				mainAlign = {horizontal = true},
				spacing = {fixed = 10},
				children = {
					newButton.new({text = "Forgot password?", func = function() return print("Forgot password?") end,}),
					newButton.new({
						text = "Create an account", 
						func = function() return print("Create an account") end,
						fontColor = {0.6, 0.1, 0.1},
					})
				}
			})
		}
	})

	self.container:load()
end

function Mixed:load()
	self:default()
end

function Mixed:keypressed(key, scancode, isrepeat)
	self.container:keypressed(key, scancode, isrepeat)
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

function Mixed:textinput(t)
	self.container:textinput(t)
end

function Mixed:mousepressed(x, y, b, istouch, presses)
	self.container:mousepressed(x, y, b, istouch, presses)
end

function Mixed:mousereleased(x, y, b, istouch, presses)
	self.container:mousereleased(x, y, b, istouch, presses)
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