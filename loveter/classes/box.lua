local folder_path = (...):match("(.-)[^%.]+$")

local Meta = require(folder_path.."meta")
local Background = require(folder_path.."background")
local Class = require(folder_path.."class")

-- LuaFormatter off

local Box = {}

Box.__index = Box
Box.parents = Class.registerParents({Meta, Background})
setmetatable(Box, Box.parents)

Box.createID = 0

function Box.new(settings)
	local b = Background.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({b, m}), Box)
	instance.id = "box"..Box.createID
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