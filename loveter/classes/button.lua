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

local function setHoverStyle(settings)
	if not settings.hoverStyle then return
		nil
	elseif settings.hoverStyle.grow then
		local x = settings.hoverStyle.grow.x or 0
		local y = settings.hoverStyle.grow.y or 0
		return {hoverStyle = {grow = {x = x, y = y}}}
	end
end

function Button.new(settings)
	-- local b = Background.new(settings)
	local m = Meta.new(settings)
	local t = Text.new(settings)
	local h = HoverStyle.new(settings)
	local instance = setmetatable(Class.inject({m, t, h}), Button)
	
	instance.w                    = settings.w or instance.font:getWidth(settings.text)
	instance.h                    = settings.h or instance.font:getHeight()
	instance.func                 = settings.func
	instance.argument             = settings.argument
	instance.circleX              = 0
	instance.circleY              = 0
	instance.circleRadius         = 0
	instance.run                  = false
	instance.speed                = 1000
	instance.offsetCircle         = 10
	-- instance.hover                = false
	instance.fillet               = settings.fillet or 0
	instance.clickEffect          = settings.clickEffect or false
	instance.animationColor       = settings.animationColor or {0.5, 0.5, 0.5}
	instance.hoverStyle           = settings.hoverStyle or nil
	instance.hoverColor           = settings.hoverColor or nil
	instance.growOffset           = settings.growOffset or 5
	instance.backgroundColor      = settings.backgroundColor or {0.5,0.5,0.5,1}
	instance.backgroundImage      = settings.backgroundImage or nil
	instance.backgroundImageStyle = settings.backgroundImageStyle or {default = true}
	instance.borderColor          = settings.borderColor or {0,0,0}
	instance.quad                 = nil
	instance.fillet               = settings.fillet or 0
	instance.offsetX              = settings.offsetX or 0
	instance.offsetY              = settings.offsetY or 0
	instance.growX                = settings.growX or 0
	instance.growY                = settings.growY or 0
	return instance
end

function Button:containsPoint(x, y)
	return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
end

function Button:runFunction()
	if self.func then
		self.func(self.argument)
	end
end

function Button:load()
	self.start_x = self.x
	self.start_y = self.y
	-- self:setShapePosition()
	self:setQuad()
	self:cleanUp()
end

function Button:cleanUp()
	self.run = false
	self.circleRadius = 0
end

function Button:mousepressed(x,y,button,istouch,presses)
	if button == 1 then
		if self:containsPoint(x, y) then
			self.circleX = x
			self.circleY = y
			-- self.run = true
			-- Sound:play("click", "click", Settings.sfxVolume, 1)
		end
	end
end

function Button:mousereleased(x,y,button,istouch,presses)
	if self:containsPoint(x, y) then
		-- self:cleanUp()
		self.run = true
		self:runFunction()
	end
end

function Button:updateClickEffect(dt)
	if self.clickEffect and self.run and self.circleRadius < self.w + self.offsetCircle then
		self.circleRadius = self.circleRadius + self.speed * dt
	end

	if self.clickEffect and self.run and self.circleRadius >= self.w + self.offsetCircle then
		self:cleanUp()
	end
end

function Button:hover()
	local mx, my = love.mouse.getPosition()
	if self:containsPoint(mx, my) then
		return true
	else
		return false
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

function Button:update(dt)
	self:updateClickEffect(dt)
end

function Button:drawClickAnimation()
	if self.run then
		local rec = function() love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, self.fillet, self.fillet) end
		love.graphics.stencil(rec, "replace", 1)
		love.graphics.setStencilTest("greater", 0)
		love.graphics.setColor(self.animationColor)
		love.graphics.circle("fill", self.circleX, self.circleY, self.circleRadius)
		love.graphics.setStencilTest()
	end
end

function Button:drawBackgroundColor()
	if self.backgroundColor then
		love.graphics.setColor(self.backgroundColor)
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, self.fillet, self.fillet)
	end
end

function Button:setQuad()
	if self.backgroundImage then
		self.quad = love.graphics.newQuad(0, 0, self.w, self.h, self.backgroundImage)
	end
end

function Button:drawBackgroundImage()
	if self.backgroundImage then
		local imgW = self.backgroundImage:getWidth()
		local imgH = self.backgroundImage:getHeight()
		love.graphics.setColor(self.backgroundColor)
		if self.backgroundImageStyle.default then
			love.graphics.draw(self.backgroundImage, self.x, self.y)
		elseif self.backgroundImageStyle.fill then
			love.graphics.draw(self.backgroundImage, self.x, self.y, 0, self.w / imgW, self.h / imgH)
		elseif self.backgroundImageStyle.texture then
			self.backgroundImage:setWrap("repeat")
			love.graphics.draw(self.backgroundImage, self.quad, self.x, self.y)
		end
	else
		love.graphics.setColor(self.backgroundColor)
		love.graphics.rectangle("fill", self.x + self.offsetX, self.y + self.offsetY, self.w + self.growX, self.h + self.growY, self.fillet, self.fillet)
	end
end

function Button:setShapePosition()
	if self.hoverStyle then
		if self.hoverStyle.grow then
			self.offsetX = - (self.hoverStyle.grow.x or 0)
			self.offsetY = - (self.hoverStyle.grow.y or 0)
			self.growX   = self.offsetX * -2
			self.growY   = self.offsetY * -2
		elseif self.hoverStyle.nudge then
			self.offsetX = (self.hoverStyle.nudge.x or 0)
			self.offsetY = (self.hoverStyle.nudge.y or 0)
		end
	end
end

-- function Button:drawText()
-- 	love.graphics.setColor(self.textColor)
-- 	love.graphics.setFont(self.font)
-- 	love.graphics.print(self.text, self.x + self:centerTextX(), self.y + self:centerTextY())
-- end

function Button:drawText()
	love.graphics.setColor(self.textColor)
	love.graphics.setFont(self.font)
	if self:hover() then
		if self.textAlign then
			if self.textAlign.left then
				love.graphics.print(self.text, self.x, self.y + self:centerTextY())
			elseif self.textAlign.right then
				love.graphics.print(self.text, self.x + self.w - self.font:getWidth(self.text), self.y + self:centerTextY())
			end
		end
		love.graphics.print(self.text, self.x + self:centerTextX() + self.offsetX, self.y + self:centerTextY() + self.offsetY)
	else
		love.graphics.print(self.text, self.x + self:centerTextX(), self.y + self:centerTextY())
	end
end

function Button:drawHover()
	if self:hover() then
		if self.hoverColor then
			love.graphics.setColor(self.hoverColor)
		else
			love.graphics.setColor(self.backgroundColor)
		end
		love.graphics.rectangle("fill", self.x + self.offsetX, self.y + self.offsetY, self.w + self.growX, self.h + self.growY, self.fillet, self.fillet)
	else
		love.graphics.setColor(self.backgroundColor)
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, self.fillet, self.fillet)
	end
end

function Button:draw()
	-- self:drawBackgroundColor()
	-- self:drawBackgroundImage()
	-- self:drawHover()
	-- self:drawClickAnimation()
	self:drawHover()
	self:drawText()
end

return Button