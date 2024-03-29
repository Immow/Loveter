local folder_path = (...):match("(.-)[^%.]+$")

local Meta  = require(folder_path.."meta")
local Class = require(folder_path.."class")
local Color = require(folder_path.."color")
local Font  = require(folder_path.."font")
local Container  = require(folder_path.."container")

-- LuaFormatter off

local Text = {}
Text.__index = Text
Text.parents = Class.registerParents({Meta})
setmetatable(Text, Text.parents)

Text.createID = 0

---@class Text
---@return table instance
function Text.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({m}), Text)
	if not settings.textColor then settings.textColor = {} end
	local padding = Container.setPadding(settings)

	instance.font                    = settings.font or love.graphics.getFont()
	-- instance.font                    = Font.new({font = settings.font or love.graphics.getFont()})
	instance.textColor               = Color.new({textColor = settings.textColor or {}})
	instance.text                    = settings.text or ""
	instance.textAlign               = settings.textAlign or "left"
	instance.state                   = "idle"
	instance.id                      = "text"..Text.createID
	instance.limit                   = settings.limit or instance.font:getWidth(instance.text)
	instance.w, instance.wrappedtext = instance.font:getWrap(instance.text, instance.limit)
	instance.w                       = instance.w + padding.left + padding.right
	instance.h                       = #instance.wrappedtext * instance.font:getHeight() + padding.top + padding.bottom
	instance.padding                 = Container.setPadding(settings)

	return instance
end

function Text:load()
	self.start_x = self.x
	self.start_y = self.y
end

function Text:init()
end

function Text:centerTextX() --TODO remove this and change other stuff to use printf
	return self.parentWidth / 2 - self.font:getWidth(self.text) / 2
end

---@param scale integer
---@return integer
function Text:centerTextY(scale, height)
	return height / 2 * scale - self.font:getHeight() / 2
end

function Text:getWidth()
	return self.w
end

function Text:getHeight()
	return self.h
end

function Text:setState(state)
	self.state = state or "idle"
end

function Text:drawText()
	self.textColor:draw(self.state)
	love.graphics.setFont(self.font)
	love.graphics.printf(self.text, self.x + self.padding.left, self.y + self.padding.top, self.limit, self.textAlign)
end

function Text:draw()
	self:drawText()
end

return Text