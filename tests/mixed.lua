local c = require("loveter.classes.container")
local b = require("loveter.classes.box")
local newSlider = require("loveter.classes.slider")
local newButton = require("loveter.classes.button")
local newForm = require("loveter.classes.form")
local newText = require("loveter.classes.text")

local selectedTest = 1

local Mixed = {
	tests = {
		"default",
		"stretch",
		"login",
	}
}

Mixed.boxes = {}
Mixed.container = {}
Mixed.buttons = {}
Mixed.forms = {}
Mixed.texts = {}
Mixed.sliders = {}

local textFont = love.graphics.newFont("loveter/assets/font/Roboto-Regular.ttf", 50)
local buttonFont = love.graphics.newFont("loveter/assets/font/Roboto-Regular.ttf", 20)

function Mixed:default()
	local background = love.graphics.newImage("loveter/assets/image/b4.png")
	local button_idle = love.graphics.newImage("loveter/assets/image/idle.png")
	local button_hover = love.graphics.newImage("loveter/assets/image/hover.png")
	local button_holding = love.graphics.newImage("loveter/assets/image/holding.png")
	-- local button_hover_big = love.graphics.newImage("loveter/assets/image/hover_big.png")
	self.buttons.b1 = newButton.new({
		w = 250,
		h = 50,
		text = "SIGN IN",
		func = function() return print("test") end,
		-- backgroundColors = { idle = {0.1, 0.1, 0.1}, hover = {1,0,0} },
		-- backgroundImage = background,
		-- backgroundImages = {idle = button_idle, hover = button_hover},
		-- backgroundImageStyle = {fill = true},
		-- hoverStyle = {grow = {x = 5, y = 5}},
		-- hoverStyle = {nudge = {x = 30}},
		-- hoverColor = {1,0,0},
		textAlign = {center = true},
		-- textAlign = {right = true},
		offset = {hover = {x = 50, y = 0}, holding = {x = -50, y = 5}},
		font = buttonFont,
		-- textColor = {0,0,0},
		-- clickEffect = true
	})

	self.buttons.b = newButton.new({
		w = 300,
		h = 50,
		text = "SIGN IN",
		func = function() return print("test") end,
		-- backgroundColor = {0.6, 0.1, 0.1},
		-- backgroundImage = background,
		-- backgroundImageStyle = {texture = true},
		-- hoverStyle = {grow = {x = 5, y = 5}},
		hoverStyle = {nudge = {x = 30}},
		-- hoverColor = {1,0,0},
		font = buttonFont,
		-- textColor = {0,0,0},
		-- clickEffect = true
	})

	self.container = c.new({
		x = 200,
		y = 200,
		-- backgroundImage = background,
		-- backgroundImageStyle = {texture = true},
		children = {
			self.buttons.b1,
		}
	})

	self.container:load()
end

function Mixed:stretch()
	self.buttons.b1 = newButton.new({
		w = 300,
		h = 50,
		text = "FOX",
		func = function() return print("FOX") end,
		font = buttonFont,
		textColor = {0,0,0},
		hoverStyle = {nudge = {x = 30}},
	})

	self.buttons.b2 = newButton.new({
		w = 300,
		h = 50,
		text = "COW",
		func = function() return print("COW") end,
		font = buttonFont,
		textColor = {0,0,0},
		hoverStyle = {nudge = {x = 30}},
	})

	self.buttons.b3 = newButton.new({
		w = 300,
		h = 50,
		text = "DOG",
		func = function() return print("DOG") end,
		font = buttonFont,
		textColor = {0,0,0},
		hoverStyle = {nudge = {x = 30}},
	})

	self.buttons.b4 = newButton.new({
		w = 300,
		h = 50,
		text = "HORSE",
		func = function() return print("test") end,
		font = buttonFont,
		textColor = {0,0,0},
	})

	self.container = c.new({
		w = love.graphics.getWidth(),
		h = love.graphics.getHeight(),
		mainAlign = {vertical = true},
		children = {
			c.new({
				h = 100,
				stretch = {x = 100},
				children = {},
			}),
			c.new({
				align = {center = true},
				stretch = {x = 100, y = 100},
				mainAlign = {vertical = true},
				spacing = {fixed = 10},
				children = {
					self.buttons.b1,
					self.buttons.b2,
					self.buttons.b3,
				}
			}),
			c.new({
				h = 100,
				align = {bottom = true, right = true},
				stretch = {x = 100},
				children = {self.buttons.b4,},
			}),
		}
	})

	self.container:load()
end

function Mixed:login()
	local user = love.graphics.newImage("loveter/assets/icon/user.png")
	local password = love.graphics.newImage("loveter/assets/icon/password.png")
	local background = love.graphics.newImage("loveter/assets/image/b2.png")
	self.buttons.b1 = newButton.new({
									w = 300,
									h = 50,
									text = "SIGN IN",
									func = function() return print("test") end,
									backgroundColor = {0.6, 0.1, 0.1},
									hoverStyle = {nudge = {x = 30}},
									-- backgroundImage = background,
									-- backgroundImageStyle = {texture = true},
									font = buttonFont,
									-- clickEffect = true,
									-- hoverStyle = {nudge = {x = 30}}
								})
	self.forms.f1 = newForm.new({
								w = 300,
								h = 50,
								previewText = "username",
								icon = user,
								iconColor = {0.5, 0.5, 0.5},
								iconScale = 0.75,
								backgroundColor = {0.2,0.2,0.2}
							})
	self.forms.f2 = newForm.new({
								w = 300,
								h = 50,
								previewText = "password",
								icon = password,
								iconColor = {0.5, 0.5, 0.5},
								iconScale = 0.75,
								backgroundColor = {0.2,0.2,0.2}
							})
	self.texts.t1 = newText.new({text = "SIGN IN", font = textFont})
	self.sliders.s1 = newSlider.new({})

	self.container = c.new({
		x = 10,
		y = 200,
		mainAlign = {vertical = true},
		padding = {top = 20, bottom = 20 , left = 20, right = 20},
		spacing = {fixed = 10},
		backgroundColor = {0.1, 0.1, 0.1},
		-- backgroundImage = background,
		-- backgroundImageStyle = {texture = true},
		-- align = {bottom = true, right = true},
		children = {
			c.new({
				align = {right = true},
				stretch = {x = 100},
				children = {
					self.texts.t1,
				}
			}),
			self.forms.f1,
			self.forms.f2,
			self.buttons.b1,
			self.sliders.s1,
			c.new({
				spacing = {fixed = 10},
				children = {
					newButton.new({
						text = "Forgot password?",
						func = function() return print("Forgot password?") end,
						backgroundColor = {0,0,0,0}
					}),
					newButton.new({
						text = "Create an account",
						func = function() return print("Create an account") end,
						textColor = {0.6, 0.1, 0.1},
						backgroundColor = {0,0,0,0},
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

function Mixed:mousemoved(x, y, dx, dy, istouch)
	self.container:mousemoved(x, y, dx, dy, istouch)
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