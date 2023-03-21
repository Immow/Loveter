local class_path = (...):match("(.-)[^%.]+$")

local Meta = require(class_path.."meta")
local Class = require(class_path.."class")
local Text = require(class_path.."text")
local Offset = require(class_path.."offset")
local Color = require(class_path.."color")

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
												parentWidth  = settings.w,
												parentHeight = settings.h,
												font         = settings.font,
												textColor    = settings.textColor,
												text         = settings.text,
												textAlign    = settings.textAlign,
												limit        = settings.limit
											})
	instance.func                    = settings.func
	instance.fillet                  = settings.fillet or 0
	instance.image                   = settings.image or nil
	instance.backgroundImageStyle    = settings.backgroundImageStyle or {default = true}
	instance.quad                    = nil
	instance.textOffset              = settings.textOffset or 5
	instance.offset                  = Offset.new(settings.offset)
	instance.state                   = "idle"
	instance.toggle                  = false
	instance.shapeColor              = Color.new({shapeColor = settings.shapeColor or {}})
	instance.borderColor             = Color.new({borderColor = settings.borderColor or {}})
	instance.imageColor              = Color.new({imageColor = settings.imageColor or {}})
	instance.textPosition           = settings.textPosition or {left = true}
	-- instance.border                  = settings.border or false
	instance.id                      = "button"..Button.createID

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
	self.text:init()
end

function Button:load()
	self.start_x = self.x
	self.start_y = self.y
	-- self:setQuad()
	-- print(self.parentWidth, self.parentHeight)
	-- self.text.parentWidth = self.w
	-- self.text.parentHeight = self.h
	-- self.text:load()
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

function Button:setQuad()
	if self.backgroundImage then
		self.quad = love.graphics.newQuad(0, 0, self.w, self.h, self.backgroundImage)
	end
end

function Button:drawText()
	self.text.textColor:draw(self.state)
	love.graphics.setFont(self.text.font)
	if self.textPosition.left then
		love.graphics.printf(self.text.text, self.x + self.offset[self.state].x + self.textOffset, self.y + self.text:centerTextY() + self.offset[self.state].y, self.text.limit)
	elseif self.textPosition.right then
		love.graphics.printf(self.text.text, self.x + self.offset[self.state].x - self.textOffset, self.y + self.text:centerTextY() + self.offset[self.state].y, self.w, "right")
	elseif self.textPosition.center then
		love.graphics.printf(self.text.text, self.x + self.offset[self.state].x, self.y + self.text:centerTextY() + self.offset[self.state].y, self.w, "center")
	end
end

function Button:drawState()
	if self.image == nil then
		self.shapeColor:draw(self.state)
		love.graphics.rectangle("fill", self.x + self.offset[self.state].x, self.y + self.offset[self.state].y, self.w, self.h, self.fillet, self.fillet)
	else
		self.imageColor:draw(self.state)
		local imgW = self.image["idle"]:getWidth()
		local imgH = self.image["idle"]:getHeight()

		if self.backgroundImageStyle.fill then
				if self.image[self.state] then
					love.graphics.draw(self.image[self.state], self.x + self.offset[self.state].x, self.y + self.offset[self.state].y, 0, self.w / imgW, self.h / imgH)
				else
					love.graphics.draw(self.image["idle"], self.x + self.offset[self.state].x, self.y + self.offset[self.state].y, 0, self.w / imgW, self.h / imgH)
				end
		elseif self.backgroundImageStyle.texture then
			--
		else
			if self.image[self.state] then
				love.graphics.draw(self.image[self.state], self.x + self.offset[self.state].x, self.y + self.offset[self.state].y)
			else
				love.graphics.draw(self.image["idle"], self.x + self.offset[self.state].x, self.y + self.offset[self.state].y)
			end
		end
	end
end

function Button:drawBorder()
	self.borderColor:draw(self.state)
	love.graphics.rectangle("line", self.x + self.offset[self.state].x, self.y + self.offset[self.state].y, self.w , self.h, self.fillet, self.fillet)
end



function Button:draw()

	self:drawState()
	self:drawBorder()
	self:drawText()
end

return Button