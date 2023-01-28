local Meta = {}
Meta.__index = Meta

function Meta:getValue(arg)
	return self[arg]
end

function Meta:setPosition(x, y)
	self.x = x
	self.y = y
end

function Meta:setArea(w, h)
	self.areaWidth = w
	self.areaHeight = h
end

function Meta:getPosition()
	return self.x, self.y
end

function Meta:getWidth()
	return self.w
end

function Meta:getHeight()
	return self.h
end

function Meta.getOffset(settings)
	if not settings.offset then
		return {top = 0, bottom = 0, left = 0, right = 0}
	else
		local top = settings.offset.top or 0
		local bottom = settings.offset.bottom or 0
		local left = settings.offset.left or 0
		local right = settings.offset.right or 0
		return {top = top, bottom = bottom, left = left, right = right}
	end
end

function Meta.setPadding(settings)
	if not settings.padding then
		return {top = 0, bottom = 0, left = 0, right = 0}
	else
		local top = settings.padding.top or 0
		local bottom = settings.padding.bottom or 0
		local left = settings.padding.left or 0
		local right = settings.padding.right or 0

		return {top = top, bottom = bottom, left = left, right = right}
	end
end

function Meta:debug()
	if DEBUG then
		love.graphics.setColor(1,0,0)
		love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
		love.graphics.print("x: "..self.x..", y:"..self.y.." w: "..self.w.." h: "..self.h, self.x, self.y)
		love.graphics.setColor(1,1,1)
	end
end

return Meta