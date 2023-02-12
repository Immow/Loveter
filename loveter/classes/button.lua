local Meta = require("loveter.classes.meta")

local Button = {}
local Button_meta = {}

-- LuaFormatter off

Button.__index = Button
Button_meta.__index = Button_meta
setmetatable(Button, Button_meta)
setmetatable(Button_meta, Meta)

---@class Button
---@param settings {x: integer, y: integer, w: integer, h: integer, func: function, argument: string, font: userdata, fontSize: integer, text: string, id: string, position: string, target_id: string, offset: {top: integer, bottom: integer, left: integer, right: integer}, buttonColor: table, buttonBorderColor: table, buttonFillet: integer, fontColor: table}
function Button.new(settings)
	local instance = setmetatable({}, Button)
	instance.x            = settings.x or 0
	instance.y            = settings.y or 0
	instance.w            = settings.w or 200
	instance.h            = settings.h or 80
	instance.position     = settings.position
	instance.id           = settings.id
	instance.target_id    = settings.target_id
	instance.font         = settings.font or love.graphics.getFont()
	instance.func         = settings.func
	instance.argument     = settings.argument
	instance.circleX      = 0
	instance.circleY      = 0
	instance.circleRadius = 0
	instance.offset       = Button.getOffset(settings)
	instance.run          = false
	instance.speed        = 500
	instance.offsetCircle = 10
	instance.buttonFillet = settings or 5
	instance.fontSize     = settings.fontSize or 12
	instance.fontColor    = settings or {0,0,0}
	instance.text         = settings.text or ""
	instance.buttonColor = settings or {1,1,1}
	instance.buttonBorderColor = settings or {1,0,0}

	return instance
end

function Button:getWidth()
	return self.w
end

function Button:getHeight()
	return self.h
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

end

function Button:mousepressed(x,y,button,istouch,presses)
	if button == 1 then
		if self:containsPoint(x, y) then
			self.circleX = x
			self.circleY = y
			self.run = true
			-- Sound:play("click", "click", Settings.sfxVolume, 1)
		end
	end
end

function Button:mousereleased(x,y,button,istouch,presses)
	if self:containsPoint(x, y) then
		self:runFunction()
	end
end

function Button:update(dt)
	if self.run and self.circleRadius < self.w + self.offsetCircle then
		self.circleRadius = self.circleRadius + self.speed * dt
	end

	if self.circleRadius >= self.w + self.offsetCircle then
		self.run = false
		self.circleRadius = 0
	end
end

function Button:centerTextX()
	return self.w / 2 - self.font:getWidth(self.text) / 2
end

function Button:centerTextY()
	return self.h / 2 - self.font:getHeight() / 2
end

function Button:draw()
	local rec = function() love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, self.buttonFillet, self.buttonFillet) end
	rec()
	love.graphics.setColor(self.buttonColor)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, self.buttonFillet, self.buttonFillet)
	if self.run then
		love.graphics.stencil(rec, "replace", 1)
		love.graphics.setStencilTest("greater", 0)
		love.graphics.setColor(1,1,1)
		love.graphics.circle("fill", self.circleX, self.circleY, self.circleRadius)
		love.graphics.setStencilTest()
	end
	love.graphics.setColor(self.fontColor)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, self.x + self:centerTextX(), self.y + self:centerTextY())
	love.graphics.reset()
end

return Button