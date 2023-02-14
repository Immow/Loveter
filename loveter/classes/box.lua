local Meta = require("loveter.classes.meta")

local Box = {}
local Box_meta = {}

-- LuaFormatter off

Box.__index = Box
Box_meta.__index = Box_meta
setmetatable(Box, Box_meta)
setmetatable(Box_meta, Meta)

function Box.new(settings)
	local instance = setmetatable(Meta.new(settings), Box)
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