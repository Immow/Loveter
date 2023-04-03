local class_path = (...):match("(.-)[^%.]+$")

local Meta = require(class_path.."meta")
local Class = require(class_path.."class")
local Text = require(class_path.."text")
local Offset = require(class_path.."offset")
local Color = require(class_path.."color")
local Scale = require(class_path.."scale")
local Image = require(class_path.."image")
local TextOffset = require(class_path.."textoffset")

-- LuaFormatter off

local Button = {}
Button.__index = Button
Button.parents = Class.registerParents({Meta})
setmetatable(Button, Button.parents)

Button.createID = 0

local clickedButton = {}
function Button.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({m}), Button)

	instance.w                       = settings.w
	instance.h                       = settings.h
	instance.text                    = Text.new({
												font         = settings.font,
												textColor    = settings.textColor,
												text         = settings.text,
												textAlign    = settings.textAlign,
												limit        = settings.limit
											})
	instance.func                    = settings.func
	instance.fillet                  = settings.fillet or 0
	instance.image                   = Image.new({image = settings.image})
	instance.backgroundImageStyle    = settings.backgroundImageStyle or {default = true}
	instance.quad                    = nil
	instance.offset                  = Offset.new({offset = settings.offset})
	instance.state                   = "idle"
	instance.toggle                  = false
	instance.shapeColor              = Color.new({shapeColor = settings.shapeColor or {}})
	instance.borderColor             = Color.new({borderColor = settings.borderColor or {}})
	instance.imageColor              = Color.new({imageColor = settings.imageColor or {}})
	instance.textPosition            = settings.textPosition or "center"
	instance.textOffset              = TextOffset.new({textOffset = settings.textOffset, textPosition = instance.textPosition})
	instance.id                      = "button"..Button.createID
	instance.scale                   = Scale.new({scale = settings.scale})
	return instance
end

function Button:containsPoint(x, y)
	return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
end

function Button:runFunction()
	if self.func then
		self:func()
	end
	self.toggle = not self.toggle
end

function Button:init()

end

function Button:load()
	self.start_x = self.x
	self.start_y = self.y
end


function Button:mousepressed(mx,my,button,istouch,presses)
	if button == 1 then
		if self:containsPoint(mx, my) then
			self.state = "pressed"
			clickedButton = self
		end
	end
end

function Button:mousereleased(mx,my,button,istouch,presses)
	if self:containsPoint(mx, my) then
		if clickedButton == self then
			self:runFunction()
			clickedButton = {}
		end
	end
end

function Button:setState()
	local mx, my = love.mouse.getPosition()
	if self:containsPoint(mx, my) then
		if love.mouse.isDown(1) then
			return "holding"
		else
			return "hover"
		end
	else
		return "idle"
	end
end

function Button:update(dt)
	self.state = self:setState()
	self.text:setState(self.state)
end

function Button:setQuad()
	if self.backgroundImage then
		self.quad = love.graphics.newQuad(0, 0, self.w, self.h, self.backgroundImage)
	end
end

function Button:drawText()
	self.text.textColor:draw(self.state)
	love.graphics.setFont(self.text.font)
	local w = self.image and self.image[self.state]:getWidth() or self.w
	local h = self.image and self.image[self.state]:getHeight() or self.h
	local limit = w * self.scale[self.state]
	local x = self.x + self.offset[self.state].x + self.textOffset --* self.scale[self.state]
	local y = self.y + self.text:centerTextY(self.scale[self.state], h) + self.offset[self.state].y * self.scale[self.state]
	love.graphics.printf(self.text.text, x, y, limit, self.textPosition)
end

function Button:drawState()
	local x = self.x + self.offset[self.state].x
	local y = self.y + self.offset[self.state].y
	local w = self.w * self.scale[self.state]
	local h = self.h * self.scale[self.state]
	if self.image == nil then
		self.shapeColor:draw(self.state)
		love.graphics.rectangle("fill", x , y, w, h, self.fillet, self.fillet)
	else
		self.imageColor:draw(self.state)
		if self.backgroundImageStyle.fill then
			love.graphics.draw(self.image[self.state], x, y, 0, self.w / self.image[self.state]:getWidth(), self.h / self.image[self.state]:getHeight())
		elseif self.backgroundImageStyle.texture then
			--
		else
			love.graphics.draw(self.image[self.state], x, y)
		end
	end
end

function Button:drawBorder()
	self.borderColor:draw(self.state)
	local x = self.x + self.offset[self.state].x
	local y = self.y + self.offset[self.state].y
	local w = self.w * self.scale[self.state]
	local h = self.h * self.scale[self.state]
	love.graphics.rectangle("line", x, y, w, h, self.fillet, self.fillet)
end



function Button:draw()

	self:drawState()
	self:drawBorder()
	self:drawText()
end

return Button