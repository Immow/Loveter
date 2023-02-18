local Meta = require("loveter.classes.meta")
local Background = require("loveter.classes.background")
local Class = require("loveter.classes.class")

-- LuaFormatter off

local Slider = {}
Slider.__index = Slider
Slider.parents = Class.registerParents({Meta, Background})
setmetatable(Slider, Slider.parents)

---@class Slider
---@param settings {x: integer, y: integer, w: integer, h: integer, groove_h: integer, knob_w: integer, knob_h: integer, sliderRangeMax: integer, sliderRangeMin: integer, startValue: integer, backgroundColor: table, backgroundImage: love.Image, backgroundImageStyle: {default: boolean, fill: boolean, texture: boolean}, borderColor: table, fillet: integer}
function Slider.new(settings)
	local b = Background.new(settings)
	local m = Meta.new(settings)
	local instance = setmetatable(Class.inject({b, m}), Slider)
	instance.w = settings.w or 100
	instance.h = settings.h or 80
	instance.startValue     = settings.startValue or 0
	instance.groove_h       = settings.groove_h or 8
	instance.knob_w         = settings.knob_w or 20
	instance.knob_h         = settings.knob_h or 20
	instance.knob_x         = instance.x + (instance.w - instance.knob_w) * instance.startValue
	instance.start_x        = settings.x or 0
	instance.start_y        = settings.y or 0
	instance.sliderRangeMax = settings.sliderRangeMax or 1
	instance.sliderRangeMin = settings.sliderRangeMin or 0
	instance.active         = false
	instance.parentDimensions = {}
	return instance
end

-- LuaFormatter on

function Slider:containsPointKnob(x, y)
	local knob_y = self.y + self.h / 2 - self.knob_h / 2
	local rangeX = x >= self.knob_x and x <= self.knob_x + self.knob_w
	local rangeY = y >= knob_y and y <= knob_y + self.knob_h
	return rangeX and rangeY
end

function Slider:containsPointGroove(x, y)
	local groove_y = self.y + self.h / 2 - self.groove_h / 2
	local rangeX = x >= self.x and x <= self.x + self.w
	local rangeY = y >= groove_y and y <= groove_y + self.groove_h
	return rangeX and rangeY
end

function Slider:getValue()
	local value = self.sliderRangeMin + ((self.knob_x - self.x) / (self.w - self.knob_w))
		              * (self.sliderRangeMax - self.sliderRangeMin)
	if value < 0 + self.sliderRangeMin then
		return 0 + self.sliderRangeMin
	elseif value > 1 + self.sliderRangeMax then
		return 1 + self.sliderRangeMax
	end
	return value
end

function Slider:load()

end

function Slider:mousemoved(x, y, dx, dy, istouch)
	if love.mouse.isDown(1) and self:containsPointKnob(x, y) then
		self.active = true
	end
	if self.active and x > self.x and x < self.x + self.w then
		self.knob_x = self.knob_x + dx
		self:getValue()
	end
end

function Slider:mousepressed(x, y, button, istouch, presses)
	if button == 1 and self:containsPointGroove(x, y) and not self:containsPointKnob(x, y) then
		self.knob_x = x - self.knob_w / 2
	end
end

function Slider:mousereleased(x, y, button, istouch, presses)
	self.active = false
end

function Slider:maintainBounds()
	if self.knob_x < self.x then
		self.knob_x = self.x
	elseif self.knob_x + self.knob_w > self.x + self.w then
		self.knob_x = self.x + self.w - self.knob_w
	end
end

function Slider:updatePosition()
	if self.x ~= self.start_x then
		self.knob_x = self.x - self.start_x + self.knob_x
		self.start_x = self.x
	end
end

function Slider:update(dt)
	self:maintainBounds()
end

function Slider:drawGroove()
	love.graphics.setColor(0.5,0.5,0.5) -- change
	local y = self.y + self.h / 2 - self.groove_h / 2
	love.graphics.rectangle("fill", self.x, y, self.w, self.groove_h)
end

function Slider:drawKnob()
	local y = self.y + self.h / 2 - self.knob_h / 2
	love.graphics.setColor(1,1,1)  -- change
	love.graphics.rectangle("fill", self.knob_x, y, self.knob_w, self.knob_h)
	love.graphics.setColor(0,0,0)  -- change
	love.graphics.rectangle("line", self.knob_x, y, self.knob_w, self.knob_h)
	love.graphics.setColor(1, 1, 1)
end

function Slider:draw()
	self:drawGroove()
	self:drawKnob()
end

return Slider
