local Meta = require("loveter.classes.meta")
local Class = require("loveter.classes.class")

-- LuaFormatter off

local Text = {}
Text.__index = Text
Text.parents = Class.registerParents({Meta})
setmetatable(Text, Text.parents)

---@class Text
---@param settings {x: integer, y: integer, font: love.Font, text: string, id: string, position: string, fontColor: table}
function Text.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({m}), Text)

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

function Text:draw()
	love.graphics.setColor(self.fontColor)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, self.x, self.y)
end

return Text