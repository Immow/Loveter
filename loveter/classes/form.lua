local Meta = require("loveter.classes.meta")
local utf8 = require("utf8")

local Form = {}
local Form_meta = {}

-- LuaFormatter off

Form.__index = Form
Form_meta.__index = Form_meta
setmetatable(Form, Form_meta)
setmetatable(Form_meta, Meta)

---@class Form
---@param settings {x: integer, y: integer, w: integer, h: integer, previewText: string, fontPreviewColor: table, font: userdata, id: string, position: string, formColor: table, formBorderColor: table, fontColor: table}
function Form.new(settings)
	local instance = setmetatable({}, Form)
	instance.x                 = settings.x or 0
	instance.y                 = settings.y or 0
	instance.w                 = settings.w or 200
	instance.h                 = settings.h or 80
	instance.position          = settings.position
	instance.id                = settings.id
	instance.font              = settings.font or love.graphics.getFont()
	instance.fontColor         = settings.fontColor or {1,1,1}
	instance.fontPreviewColor  = settings.fontPreviewColor or {1,1,1}
	instance.text              = ""
	instance.formColor         = settings.formColor or {0.3,0.3,0.3,1}
	instance.formBorderColor   = settings.formBorderColor or {0,0,0,0}
	instance.previewText       = settings.previewText or ""
	instance.start_x           = 0
	instance.start_y           = 0
	instance.clickedInForm     = false
	instance.byteoffset        = utf8.offset(instance.text, 0)
	instance.cursorbyteoffset  = utf8.offset(instance.text, 1)
	instance.cursorTimer       = 0
	instance.cursorBlinkSpeed  = 1.5

	return instance
end

function Form:containsPoint(x, y)
	return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
end

function Form:load()
	self.start_x = self.x
	self.start_y = self.y
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

function Form:mousereleased(x,y,button,istouch,presses)
	if self:containsPoint(x, y) then

	end
end

function Form:keypressed(key, scancode, isrepeat)
	if self.clickedInForm then
		if key == "backspace" then
			if string.len(self.text) >= 1 then
				self.byteoffset = utf8.offset(self.text, -1)
				self.text = string.sub(self.text, 1, self.byteoffset - 1)
				-- self.byteoffset = utf8.offset(self.text, 0)
			end
		end
	end
end

function Form:textinput(t)
	if self.clickedInForm then
		self.text = self.text .. t
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

function Form:centerTextY()
	return self.h / 2 - self.font:getHeight() / 2
end

function Form:drawCursor()
	if dir == 1 and self.clickedInForm then
		love.graphics.print("|", self.x + 10 + self.font:getWidth(self.text), self.y + self:centerTextY())
	end
end

function Form:drawPreviewText()
	if not self.clickedInForm then
		love.graphics.setColor(self.fontPreviewColor)
		love.graphics.print(self.previewText, self.x + 10, self.y + self:centerTextY())
	end
end

function Form:draw()
	love.graphics.setFont(self.font)
	love.graphics.setColor(self.formColor)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	
	self:drawPreviewText()
	love.graphics.setColor(self.fontColor)
	love.graphics.print(self.text, self.x + 10, self.y + self:centerTextY())

	self:drawCursor()
end

return Form