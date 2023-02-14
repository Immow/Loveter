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
	local instance = setmetatable(Meta.new(settings), Text)
	instance.font              = settings.font or love.graphics.getFont()
	instance.w                 = instance.font:getWidth(settings.text)
	instance.h                 = instance.font:getHeight()
	instance.fontColor         = settings.fontColor or {1,1,1}
	instance.text              = settings.text or ""
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