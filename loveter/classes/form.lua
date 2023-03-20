local class_path = (...):match("(.-)[^%.]+$")

local utf8 = require("utf8")
local Meta = require(class_path.."meta")
local Background = require(class_path.."background")
local Class = require(class_path.."class")
local Text = require(class_path.."text")

-- LuaFormatter off

local Form = {}
Form.__index = Form
Form.parents = Class.registerParents({Meta, Background})
setmetatable(Form, Form.parents)

Form.createID = 0

---@class Form
function Form.new(settings)
	local b = Background.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({b, m}), Form)

	instance.text                    = Text.new({
						parentWidth  = settings.w,
						parentHeight = settings.h,
						font         = settings.font,
						textColor    = settings.textColor,
						text         = settings.text,
						textAlign    = settings.textAlign,
						textOffset   = settings.textOffset,
						limit        = settings.limit
					})
	instance.fontPreviewColor        = settings.fontPreviewColor or {1,1,1}
	instance.previewText             = settings.previewText or ""
	instance.clickedInForm           = false
	instance.byteoffset              = utf8.offset(instance.text.text, 0)
	instance.cursorbyteoffset        = utf8.offset(instance.text.text, 1)
	instance.cursorTimer             = 0
	instance.cursorBlinkSpeed        = 1.5
	instance.iconColor               = settings.iconColor or {1,1,1,1}
	instance.iconScale               = settings.iconScale or 1
	instance.offset                  = settings.offset or 10
	instance.icon                    = settings.icon or nil
	instance.state                   = "idle"
	instance.id                      = "form"..Form.createID
	return instance
end

function Form:containsPoint(x, y)
	return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
end

function Form:load()
	self.start_x = self.x
	self.start_y = self.y
	self:setQuad()
end

function Form:mousepressed(x,y,button,istouch,presses)
	if button == 1 then
		if self:containsPoint(x, y) then
			self.previewText = ""
			self.clickedInForm = true
		else
			self.clickedInForm = false
		end
	end
end

function Form:keypressed(key, scancode, isrepeat)
	if self.clickedInForm then
		if key == "backspace" then
			if string.len(self.text.text) >= 1 then
				self.byteoffset = utf8.offset(self.text.text, -1)
				self.text.text = string.sub(self.text.text, 1, self.byteoffset - 1)
			end
		end
	end
end

function Form:textinput(t)
	if self.clickedInForm then
		if self.text.font:getWidth(self.text.text) + self.offset + self.offset < self.w then
			self.text.text = self.text.text .. t
		end
	end
end

local dir = 1
function Form:update(dt)
	if self.cursorTimer < 0 then
		self.cursorTimer = 0
		dir = dir * -1
	elseif self.cursorTimer > 1 then
		self.cursorTimer = 1
		dir = dir * -1
	end
	self.cursorTimer = self.cursorTimer + (dt * self.cursorBlinkSpeed) * dir
end

function Form:drawCursor()
	if dir == 1 and self.clickedInForm then
		local x = self.x + self.offset + self.text.font:getWidth(self.text.text)
		local y = self.y + self.text:centerTextY()
		love.graphics.print("|", x, y)
	end
end

function Form:drawPreviewText()
	if not self.clickedInForm then
		love.graphics.setColor(self.fontPreviewColor)
		love.graphics.print(self.previewText, self.x + self.offset, self.y + self.text:centerTextY())
	end
end

function Form:drawText()
	self.text.textColor:draw(self.state)
	love.graphics.print(self.text.text, self.x + self.offset, self.y + self.text:centerTextY())
end

function Form:drawIcon()
	love.graphics.setColor(self.iconColor)
	if self.icon then
		local iconW = self.icon:getWidth() * self.iconScale
		local iconH = self.icon:getHeight() * self.iconScale
		local x = self.x + self.w - iconW - self.offset
		local y = self.y + self.h / 2 - iconH / 2

		love.graphics.draw(self.icon, x, y, 0, self.iconScale, self.iconScale)
	end
end

function Form:draw()
	love.graphics.setFont(self.text.font)
	self:drawBackgroundColor()
	self:drawBackgroundImage()
	self:drawIcon()
	self:drawPreviewText()
	self:drawText()
	self:drawCursor()
end

return Form