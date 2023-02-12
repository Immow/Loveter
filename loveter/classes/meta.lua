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

function Meta:mousepressed()
end

function Meta:mousereleased()
end

function Meta:keypressed()
end

function Meta:textinput()
end

function Meta.setOffset(settings)
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

function Meta.setAlign(settings)
	if not settings.align then
		return {top = true, bottom = false, left = true, right = false}
	else
		local top = settings.align.top or false
		local bottom = settings.align.bottom or false
		local left = settings.align.left or false
		local right = settings.align.right or false

		if not top and not bottom then top = true end
		if not left and not right then left = true end

		return {top = top, bottom = bottom, left = left, right = right}
	end
end

function Meta.setStretch(settings)
	if not settings.stretch then
		return {x = 0, y = 0}
	else
		local x = settings.stretch.x or 0
		local y = settings.stretch.y or 0
		return {x = x, y = y}
	end
end

function Meta:debug()
	if DEBUG then
		love.graphics.setFont(FONT)
		love.graphics.setColor(1,0,0)
		love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
		love.graphics.print("ID: "..self.id.." x: "..self.x..", y: "..self.y.." w: "..self.w.." h: "..self.h.." TCW: "..self.totalChildWidth.." TCH: "..self.totalChildHeight, 10, 0 + (12 * self.id))
		love.graphics.setColor(1,1,1)
	end
end

return Meta