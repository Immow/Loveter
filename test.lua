require("globals")
local c = require("loveter.classes.container")
local horizontal = require("tests.horizontal")
local vertical = require("tests.vertical")
local mixed = require("tests.mixed")

State_Manager.addState("testing", "test")

local Test = {}

local selectedGroup = {vertical, horizontal, mixed}

local selectedGroupIndex = 3

function Test:load()
	selectedGroup[selectedGroupIndex]:load()
end

function Test:keypressed(key, scancode, isrepeat)
	selectedGroup[selectedGroupIndex]:keypressed(key, scancode, isrepeat)

	if key == "left" then
		if selectedGroupIndex > 1 then
			selectedGroupIndex = selectedGroupIndex - 1
			c.createID = 0
			selectedGroup[selectedGroupIndex]:load()
		else
			selectedGroupIndex = #selectedGroup
			c.createID = 0
			selectedGroup[selectedGroupIndex]:load()
		end
	end

	if key == "right" then
		if selectedGroupIndex < #selectedGroup then
			selectedGroupIndex = selectedGroupIndex + 1
			c.createID = 0
			selectedGroup[selectedGroupIndex]:load()
		else
			selectedGroupIndex = 1
			c.createID = 0
			selectedGroup[selectedGroupIndex]:load()
		end
	end
end

function Test:textinput(t)
	selectedGroup[selectedGroupIndex]:textinput(t)
end

function Test:mousepressed(x, y, button, istouch, presses)
	if selectedGroup[selectedGroupIndex].mousepressed then
		selectedGroup[selectedGroupIndex]:mousepressed(x, y, button, istouch, presses)
	end
end

function Test:mousereleased(x, y, button, istouch, presses)
	if selectedGroup[selectedGroupIndex].mousereleased then
		selectedGroup[selectedGroupIndex]:mousereleased(x, y, button, istouch, presses)
	end
end

function Test:mousemoved(x, y, dx, dy, istouch)
	if selectedGroup[selectedGroupIndex].mousemoved then
		selectedGroup[selectedGroupIndex]:mousemoved(x, y, dx, dy, istouch)
	end
end

function Test:update(dt)
	selectedGroup[selectedGroupIndex]:update(dt)
end


function Test:draw()
	selectedGroup[selectedGroupIndex]:draw()
end

return Test