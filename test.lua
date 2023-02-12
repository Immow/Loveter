require("globals")
local c = require("loveter.classes.container")
local horizontal = require("tests.horizontal")
local vertical = require("tests.vertical")
local mixed = require("tests.mixed")

local Test = {}

local selectedGroup = {vertical, horizontal, mixed}

local selectedGroupIndex = 2

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

function Test:update(dt)
	selectedGroup[selectedGroupIndex]:update(dt)
end


function Test:draw()
	selectedGroup[selectedGroupIndex]:draw()
end

return Test