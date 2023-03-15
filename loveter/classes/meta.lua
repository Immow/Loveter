local Meta = {}
Meta.__index = Meta

function Meta.new(settings)
	local instance = setmetatable({}, Meta)
	instance.x                    = settings.x or 0
	instance.y                    = settings.y or 0
	instance.w                    = settings.w or 100
	instance.h                    = settings.h or 50
	instance.start_x              = 0
	instance.start_y              = 0
	instance.position             = settings.position
	instance.id                   = settings.id
	return instance
end

function Meta:setPosition(x, y)
	self.x = x
	self.y = y
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

function Meta:mousemoved()
end

function Meta:keypressed()
end

function Meta:textinput()
end

function Meta:debug()
	if DEBUG then
		love.graphics.setFont(FONT)
		love.graphics.setColor(1,0,0)
		love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
		love.graphics.print("ID: "..self.id.." x: "..self.x..", y: "..self.y.." w: "..self.w.." h: "..self.h.." TCW: "..self.totalChildWidth.." TCH: "..self.totalChildHeight.." TRCW: "..self.totalUnstretchedWidth.." TRCH: "..self.totalUnstretchedHeight, 10, 0 + (12 * self.id))
		love.graphics.setColor(1,1,1)
	end
end

return Meta