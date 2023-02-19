local Background = {}
Background.__index = Background

---@class Background
---@param settings {backgroundColor: table, backgroundImage: love.Image, backgroundImageStyle: {default: boolean, fill: boolean, texture: boolean}, borderColor: table, fillet: integer} | ...
function Background.new(settings)
	local instance = setmetatable({}, Background)
	instance.backgroundColor      = settings.backgroundColor or {1,1,1,1}
	instance.backgroundImage      = settings.backgroundImage or nil
	instance.backgroundImageStyle = settings.backgroundImageStyle or {default = true}
	instance.borderColor          = settings.borderColor or {0,0,0}
	instance.quad                 = nil
	instance.fillet               = settings.fillet or 0
	return instance
end

function Background:drawBackgroundColor()
	if self.backgroundColor then
		love.graphics.setColor(self.backgroundColor)
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, self.fillet, self.fillet)
	end
end

function Background:setQuad()
	if self.backgroundImage then
		self.quad = love.graphics.newQuad(0, 0, self.w, self.h, self.backgroundImage)
	end
end

function Background:drawBackgroundImage()
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
	end
end

return Background