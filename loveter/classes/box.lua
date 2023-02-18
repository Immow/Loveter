local Meta = require("loveter.classes.meta")
local Background = require("loveter.classes.background")
local Class = require("loveter.classes.class")

-- LuaFormatter off

local Box = {}
Box.__index = Box
Box.parents = Class.registerParents({Meta, Background})
setmetatable(Box, Box.parents)

function Box.new(settings)
	local b = Background.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({b, m}), Box)
	instance.id = "box"
	return instance
end

-- LuaFormatter on

function Box:load()
	self.start_x = self.x
	self.start_y = self.y
	self:setQuad()
end

function Box:update(dt)
end

function Box:draw()
	self:drawBackgroundColor()
	self:drawBackgroundImage()
end

return Box