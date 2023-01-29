local Meta = require("meta")

local Container = {}
local Container_meta = {}

-- LuaFormatter off

Container.__index = Container
Container_meta.__index = Container_meta
setmetatable(Container, Container_meta)
setmetatable(Container_meta, Meta)

local createID = 0

function Container.new(settings)
	local instance = setmetatable({}, Container)
	instance.x        = settings.x or 0
	instance.y        = settings.y or 0
	instance.w        = settings.w or 0
	instance.h        = settings.h or 50
	instance.id       = createID
	instance.children = settings.children
	instance.padding  = Container.setPadding(settings)
	instance.stretch  = settings.stretch

	createID = createID + 1
	return instance
end

-- LuaFormatter on

function Container:getTotalChildWidth()
	if not self.children then
		return self:getWidth()
	end
	local w = 0
	for _, child in ipairs(self.children) do
		child:setPosition(self.x + self.padding.left, self.y)
		w = w + child:getWidth()
		child:load()
	end

	if self.w > 0 then
		return self.w + self.padding.left + self.padding.right
	end

	return w + self.padding.left + self.padding.right
end

local maxWidth = 0
function Container:setStretch()
	if maxWidth < self.w then
		maxWidth = self.w
	end

	if self.stretch then
		if self.stretch.x > 0 then
			if self.w < maxWidth then
				self.w = maxWidth / 100 * self.stretch.x
			end
		end
	end
end

function Container:load()
	self.w = self:getTotalChildWidth() -- + self.padding.left + self.padding.right
end

function Container:update(dt)
	for _, child in ipairs(self.children) do
		child:update()
	end
end

function Container:draw()
	for _, child in ipairs(self.children) do
		child:draw()
	end
	
	self:debug()
end

return Container
