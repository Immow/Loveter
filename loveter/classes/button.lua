local folder_path = (...):match("(.-)[^%.]+$")

local Meta = require(folder_path.."meta")
-- local Background = require(folder_path.."background")
local Class = require(folder_path.."class")
local Text = require(folder_path.."text")
local HoverStyle = require(folder_path.."hoverstyle")

-- LuaFormatter off

local Button = {}
Button.__index = Button
Button.parents = Class.registerParents({Meta, Text, HoverStyle})
setmetatable(Button, Button.parents)

local clickedButton = {}
function Button.new(settings)
	-- local b = Background.new(settings)
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
	instance.defaultBackgroundColor = {1,1,1,1}
	instance.backgroundImages       = settings.backgroundImages or nil
	instance.backgroundImageStyle   = settings.backgroundImageStyle or {default          = true}
	instance.borderColor            = settings.borderColor or {0,0,0}
	instance.quad                   = nil
	instance.offsetX                = settings.offsetX or 0
	instance.offsetY                = settings.offsetY or 0
	instance.growX                  = settings.growX or 0
	instance.growY                  = settings.growY or 0
	instance.textOffset             = settings.textOffset or 5
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

function HoverStyle:getHoverStyle()
	if self.hoverStyle then
		if self.hoverStyle.highlight then
			love.graphics.setColor(self.hoverColor)
			love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		elseif self.hoverStyle.grow then
			love.graphics.rectangle("fill", self.x - self.growOffset, self.y - self.growOffset, self.w + self.growOffset * 2, self.h + self.growOffset * 2)
		end
	end
end

function Button:resize()
	if self.state ~= "idle" then
		if self.hoverStyle then
			if self.hoverStyle.nudge then
				self.offsetX = self.hoverStyle.nudge.x
			end
		end
	else
		self.offsetX = 0
		self.offsetY = 0
	end
end

function Button:update(dt)
	self:resize()
	self:setState()
end

function Button:drawBackgroundColor()
	if self.backgroundColors and self.backgroundColors[self.state] then
		love.graphics.setColor(self.backgroundColors[self.state])
	else
		love.graphics.setColor(self.defaultBackgroundColor)
	end
end

function Button:setQuad()
	if self.backgroundImage then
		self.quad = love.graphics.newQuad(0, 0, self.w, self.h, self.backgroundImage)
	end
end

function Button:drawBackgroundImages()
	if next(self.backgroundImages) ~= nil then
	-- local imgW = self.backgroundImage:getWidth()
	-- local imgH = self.backgroundImage:getHeight()
		if self.backgroundImageStyle.default then
			if self.backgroundImages[self.state] then
				love.graphics.draw(self.backgroundImages[self.state], self.x + self.offsetX, self.y + self.offsetY)
			else
				love.graphics.draw(self.backgroundImage["idle"], self.x + self.offsetX, self.y + self.offsetY)
			end
		elseif self.backgroundImageStyle.fill then
			-- love.graphics.draw(self.backgroundImage, self.x + self.offsetX, self.y + self.offsetY, 0, self.w / imgW, self.h / imgH)
		elseif self.backgroundImageStyle.texture then
			-- self.backgroundImage:setWrap("repeat")
			-- love.graphics.draw(self.backgroundImage, self.quad, self.x + self.offsetX, self.y + self.offsetY)
		end
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
			love.graphics.print(self.text, self.x + self.offsetX + self.textOffset, self.y + self:centerTextY() + self.offsetY)
		elseif self.textAlign.right then
			love.graphics.print(self.text, self.x + self.w - self.font:getWidth(self.text) + self.offsetX, self.y + self:centerTextY() + self.offsetY)
		elseif self.textAlign.center then
			love.graphics.print(self.text, self.x + self:centerTextX() + self.offsetX, self.y + self:centerTextY() + self.offsetY)
		end
	end
end

function Button:drawState()
	if next(self.backgroundImages) == nil then
		love.graphics.rectangle("fill", self.x + self.offsetX, self.y + self.offsetY, self.w + self.growX, self.h + self.growY, self.fillet, self.fillet)
	else
		-- local imgW = self.backgroundImage:getWidth()
		-- local imgH = self.backgroundImage:getHeight()
		if self.backgroundImageStyle.default then
			if self.backgroundImages[self.state] then
				love.graphics.draw(self.backgroundImages[self.state], self.x + self.offsetX, self.y + self.offsetY)
			else
				love.graphics.draw(self.backgroundImages["idle"], self.x + self.offsetX, self.y + self.offsetY)
			end
		-- elseif self.backgroundImageStyle.fill then
				-- love.graphics.draw(self.backgroundImage, self.x + self.offsetX, self.y + self.offsetY, 0, self.w / imgW, self.h / imgH)
		-- elseif self.backgroundImageStyle.texture then
				-- self.backgroundImage:setWrap("repeat")
				-- love.graphics.draw(self.backgroundImage, self.quad, self.x + self.offsetX, self.y + self.offsetY)
		end
	end
end

function Button:draw()
	self:drawBackgroundColor()
	self:drawState()
	self:drawText()
end

return Button