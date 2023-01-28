local Meta = require("meta")

local Box = {}
local Box_meta = {}

-- LuaFormatter off

Box.__index = Box
Box_meta.__index = Box_meta
setmetatable(Box, Box_meta)
setmetatable(Box_meta, Meta)

function Box.new(settings)
	local instance = setmetatable({}, Box)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.w  = settings.w or 100
	instance.h = settings.h or 50
	-- instance.padding = {left = 0}
	return instance
end

-- LuaFormatter on

function Box:load()
end

function Box:update(dt)
end

function Box:draw()
	love.graphics.setColor(0,0,1)
	love.graphics.rectangle("fill", self.x , self.y, self.w, self.h)
	love.graphics.setColor(1,1,1)
end

return Box