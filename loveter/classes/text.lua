local folder_path = (...):match("(.-)[^%.]+$")

local Meta = require(folder_path.."meta")
local Class = require(folder_path.."class")
local Color = require(folder_path.."color")

-- LuaFormatter off

local Text = {}
Text.__index = Text
Text.parents = Class.registerParents({Meta})
setmetatable(Text, Text.parents)

Text.createID = 0

---@class Text
function Text.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({m}), Text)
	if not settings.textColor then settings.textColor = {} end

	instance.font              = settings.font or love.graphics.getFont()
	instance.textColor         = Color.new({textColor = settings.textColor or {}})
	instance.text              = settings.text or ""
	instance.textAlign         = settings.textAlign or "left"
	instance.state             = "idle"
	instance.id                = "text"..Text.createID
	instance.limit             = settings.limit or instance.font:getWidth(instance.text)
	return instance
end

function Text:load()
	self.start_x = self.x
	self.start_y = self.y
end

function Text:init()

end

function Text:centerTextX()
	return self.parentWidth / 2 - self.font:getWidth(self.text) / 2
end

function Text:centerTextY()
	return self.parentHeight / 2 - self.font:getHeight() / 2
end

function Text:getWidth()
	return self.limit
end

function Text:getHeight()
	local _, wrappedtext = self.font:getWrap(self.text, self.limit)
	return #wrappedtext * self.font:getHeight()
end

function Text:update(dt)

end

function Text:drawText()
	self.textColor:draw(self.state)
	love.graphics.setFont(self.font)
	love.graphics.printf(self.text, self.x, self.y, self.limit, self.textAlign)
end

function Text:draw()
	self:drawText()
end

return Text