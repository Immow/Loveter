local HoverStyle = {}
HoverStyle.__index = HoverStyle

function HoverStyle.new(settings)
	local instance = setmetatable({}, HoverStyle)
		instance.hoverStyle = settings.hoverStyle
		instance.hoverColor = settings.hoverColor or {1,0,0}
		instance.growOffset = settings.growOffset or 5
	return instance
end

function HoverStyle:getHoverStyle(settings)
	if self.hoverStyle then
		if self.hoverStyle.highlight then
			love.graphics.setColor(self.hoverColor)
			love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
		elseif self.hoverStyle.grow then
			love.graphics.rectangle("fill", self.x - self.growOffset, self.y - self.growOffset, self.w + self.growOffset * 2, self.h + self.growOffset * 2)
		end
	end
end

return HoverStyle