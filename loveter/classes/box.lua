local Meta = require("loveter.classes.meta")

local Box = {}
local Box_meta = {}

-- LuaFormatter off

Box.__index = Box
Box_meta.__index = Box_meta
setmetatable(Box, Box_meta)
setmetatable(Box_meta, Meta)

function Box.new(settings)
	local instance = setmetatable({}, Box)
	instance.x                    = settings.x or 0
	instance.y                    = settings.y or 0
	instance.w                    = settings.w or 100
	instance.h                    = settings.h or 50
	instance.start_x              = 0
	instance.start_y              = 0
	instance.offset               = Box.setOffset(settings)
	instance.fillet               = settings.fillet or 0
	instance.backgroundColor      = settings.backgroundColor or {0.3,0.3,0.3,1}
	instance.backgroundImage      = settings.backgroundImage or nil
	instance.backgroundImageStyle = settings.backgroundImageStyle or {default  = true}
	instance.quad                 = nil
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