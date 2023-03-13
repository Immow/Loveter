local class_path = (...):match("(.-)[^%.]+$")
local module_path = (...):gsub("[^.]+$", ""):gsub("[^.]+%.$", "")

local Meta = require(class_path.."meta")
local Class = require(class_path.."class")
local Text = require(class_path.."text")
local HoverStyle = require(class_path.."hoverstyle")
local Offset = require(module_path.."modules.offset")

-- LuaFormatter off

local Button = {}
Button.__index = Button
Button.parents = Class.registerParents({Meta, Text, HoverStyle})
setmetatable(Button, Button.parents)

local clickedButton = {}
function Button.new(settings)
	local m = Meta.new(settings)
	local t = Text.new(settings)
	local h = HoverStyle.new(settings)
	local instance = setmetatable(Class.inject({m, t, h}), Button)
	
	instance.w                      = settings.w or instance.font:getWidth(settings.text)
	instance.h                      = settings.h or instance.font:getHeight()
	instance.func                   = settings.func
	instance.fillet                 = settings.fillet or 0
	instance.hoverStyle             = settings.hoverStyle or nil
	instance.hoverColor             = settings.hoverColor or {1, 0, 0}
	instance.pressedColor           = settings.hoverColor or {0, 1, 0}
	instance.growOffset             = settings.growOffset or 5 -- decide on a better name
	instance.backgroundColors       = settings.backgroundColors or nil
	instance.defaultBackgroundColors = {idle = {1,1,1,1}, hover = {0.5,0.5,0.5,1}, holding = {0.2,0.2,0.2,1}}
	instance.backgroundImages       = settings.backgroundImages or nil
	instance.backgroundImageStyle   = settings.backgroundImageStyle or {default = true}
	instance.borderColor            = settings.borderColor or {0,0,0}
	instance.quad                   = nil
	instance.offsetX                = settings.offsetX or 0
	instance.offsetY                = settings.offsetY or 0
	instance.growX                  = settings.growX or 0
	instance.growY                  = settings.growY or 0
	instance.textOffset             = settings.textOffset or 5
	instance.offset                 = Offset.set(settings)
	instance.state                  = "idle"
	instance.toggle                 = false

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

function Button:load()
	self.start_x = self.x
	self.start_y = self.y
	self:setQuad()
end


function Button:mousepressed(x,y,button,istouch,presses)
	if button == 1 then
		if self:containsPoint(x, y) then
			self.state = "pressed"
			clickedButton = self
		end
	end
end

function Button:mousereleased(x,y,button,istouch,presses)
	if self:containsPoint(x, y) then
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
			self.state = "holding"
		else
			self.state = "hover"
		end
	else
		self.state = "idle"
	end
end

function Button:update(dt)
	self:setState()
end

function Button:drawBackgroundColor()
	if self.backgroundColors and self.backgroundColors[self.state] then
		love.graphics.setColor(self.backgroundColors[self.state])
	elseif self.backgroundImages ~= nil then
		love.graphics.setColor(1,1,1,1)
	else
		love.graphics.setColor(self.defaultBackgroundColors[self.state])
	end
end

function Button:setQuad()
	if self.backgroundImage then
		self.quad = love.graphics.newQuad(0, 0, self.w, self.h, self.backgroundImage)
	end
end

function Button:drawText()
	love.graphics.setColor(self.textColor)
	love.graphics.setFont(self.font)
	if self.state == "idle" then
		if self.textAlign.left then
			love.graphics.print(self.text, self.x + self.textOffset, self.y + self:centerTextY())
		elseif self.textAlign.right then
			love.graphics.print(self.text, self.x + self.w - self.font:getWidth(self.text) - self.textOffset, self.y + self:centerTextY())
		elseif self.textAlign.center then
			love.graphics.print(self.text, self.x + self:centerTextX(), self.y + self:centerTextY())
		end
	end

	if self.state == "hover" or self.state == "holding" then
		if self.textAlign.left then
			love.graphics.print(self.text, self.x + self.offset[self.state].x + self.textOffset, self.y + self:centerTextY() + self.offset[self.state].y)
		elseif self.textAlign.right then
			love.graphics.print(self.text, self.x + self.w - self.font:getWidth(self.text) + self.offset[self.state].x, self.y + self:centerTextY() + self.offset[self.state].y)
		elseif self.textAlign.center then
			love.graphics.print(self.text, self.x + self:centerTextX() + self.offset[self.state].x, self.y + self:centerTextY() + self.offset[self.state].y)
		end
	end
end

function Button:drawState()
	if self.backgroundImages == nil then
		love.graphics.rectangle("fill", self.x + self.offset[self.state].x, self.y + self.offset[self.state].y, self.w + self.growX, self.h + self.growY, self.fillet, self.fillet)
	else
		local imgW = self.backgroundImages["idle"]:getWidth() --TODO bug, does not work
		local imgH = self.backgroundImages["idle"]:getHeight() --TODO bug, does not work
		if self.backgroundImageStyle.default then
			if self.backgroundImages[self.state] then
				love.graphics.draw(self.backgroundImages[self.state], self.x + self.offset[self.state].x, self.y + self.offset[self.state].y)
			else
				love.graphics.draw(self.backgroundImages["idle"], self.x + self.offset[self.state].x, self.y + self.offset[self.state].y)
			end
		elseif self.backgroundImageStyle.fill then
				if self.backgroundImages[self.state] then
					love.graphics.draw(self.backgroundImages[self.state], self.x + self.offset[self.state].x, self.y + self.offset[self.state].y, 0, self.w / imgW, self.h / imgH)
				else
					love.graphics.draw(self.backgroundImages["idle"], self.x + self.offset[self.state].x, self.y + self.offset[self.state].y, 0, self.w / imgW, self.h / imgH)
				end
		elseif self.backgroundImageStyle.texture then
			--
		end
	end
end

function Button:draw()
	self:drawBackgroundColor()
	self:drawState()
	self:drawText()
end

return Button