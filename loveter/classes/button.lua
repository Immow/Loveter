local folder_path = (...):match("(.-)[^%.]+$")

local Meta = require(folder_path.."meta")
local Background = require(folder_path.."background")
local Class = require(folder_path.."class")
local Text = require(folder_path.."text")

-- LuaFormatter off

local Button = {}
Button.__index = Button
Button.parents = Class.registerParents({Meta, Background, Text})
setmetatable(Button, Button.parents)

---@class Button
---@param settings {x: integer, y: integer, w: integer, h: integer, backgroundImageStyle: table, func: function, argument: string, font: love.Font, text: string, id: string, position: string, backgroundColor: table, backgroundImage: love.Image ,borderColor: table, fillet: integer, textColor: table, clickEffect: boolean, animationColor: table, hoverColor: table}
function Button.new(settings)
	local b = Background.new(settings)
	local m = Meta.new(settings)
	local t = Text.new(settings)
	local instance = setmetatable(Class.inject({b, m, t}), Button)
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
	instance.hover                = false
	instance.hoverColor           = settings.hoverColor or nil
	instance.fillet               = settings.fillet or 0
	instance.clickEffect          = settings.clickEffect or false
	instance.animationColor       = settings.animationColor or {0.5, 0.5, 0.5}

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

function Button:drawHover()
	local mx, my = love.mouse.getPosition()
	if self:containsPoint(mx, my) then
		if self.hoverColor then
			love.graphics.setColor(self.hoverColor)
			love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		end
	end
end

function Button:update(dt)
	self:updateClickEffect(dt)
end

function Button:drawText()
	love.graphics.setColor(self.textColor)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, self.x + self:centerTextX(), self.y + self:centerTextY())
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

function Button:draw()
	self:drawBackgroundColor()
	self:drawBackgroundImage()
	self:drawHover()
	self:drawClickAnimation()
	self:drawText()
end

return Button