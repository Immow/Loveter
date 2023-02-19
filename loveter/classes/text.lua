local folder_path = (...):match("(.-)[^%.]+$")

local Meta = require(folder_path.."meta")
local Class = require(folder_path.."class")

-- LuaFormatter off

local Text = {}
Text.__index = Text
Text.parents = Class.registerParents({Meta})
setmetatable(Text, Text.parents)

---@class Text
---@param settings {x: integer, y: integer, textAlign: table, textOffset: integer, font: love.Font, text: string, id: string, position: string, textColor: table} | ...
function Text.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({m}), Text)

	instance.font              = settings.font or love.graphics.getFont()
	instance.textColor         = settings.textColor or {1,1,1}
	instance.text              = settings.text or ""
	instance.textAlign         = settings.textAlign or {left = true}
	instance.textOffset        = settings.textOffset or 0
	return instance
end

function Text:load()
	self.start_x = self.x
	self.start_y = self.y
end

function Text:centerTextX()
	return self.w / 2 - self.font:getWidth(self.text) / 2
end

function Text:centerTextY()
	return self.h / 2 - self.font:getHeight() / 2
end

function Text:getWidth()
	return self.font:getWidth(self.text)
end

function Text:getHeight()
	return self.font:getHeight()
end

function Text:update(dt)

end

function Text:drawText()
	love.graphics.setColor(self.textColor)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, self.x, self.y)
end

function Text:draw()
	self:drawText()
end

return Text