local Meta = require("loveter.classes.meta")

local Text = {}
local Text_meta = {}

-- LuaTextatter off

Text.__index = Text
Text_meta.__index = Text_meta
setmetatable(Text, Text_meta)
setmetatable(Text_meta, Meta)

---@class Text
---@param settings {x: integer, y: integer, font: love.Font, text: string, id: string, position: string, fontColor: table}
function Text.new(settings)
	local instance = setmetatable({}, Text)
	instance.font              = settings.font or love.graphics.getFont()
	instance.x                 = settings.x or 0
	instance.y                 = settings.y or 0
	instance.w                 = instance.font:getWidth(settings.text)
	instance.h                 = instance.font:getHeight()
	instance.position          = settings.position
	instance.id                = settings.id
	instance.fontColor         = settings.fontColor or {1,1,1}
	instance.text              = settings.text or ""
	instance.start_x           = 0
	instance.start_y           = 0
	return instance
end

function Text:load()
	self.start_x = self.x
	self.start_y = self.y
end

function Text:update(dt)

end

function Text:centerTextY()
	return self.h / 2 - self.font:getHeight() / 2
end

function Text:draw()
	love.graphics.setColor(self.fontColor)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, self.x, self.y)
end

return Text