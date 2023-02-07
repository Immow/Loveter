local Meta = require("meta")

local Container = {}
local Container_meta = {}

-- LuaFormatter off

Container.__index = Container
Container_meta.__index = Container_meta
setmetatable(Container, Container_meta)
setmetatable(Container_meta, Meta)

Container.createID = 0
local maxWidth = 0

function Container.new(settings)
	local instance = setmetatable({}, Container)
	if not settings.mainAlign or (not settings.mainAlign.vertical and not settings.mainAlign.horizontal) then
		error("Did not specify an mainAlign, ea: mainAlign = {horizontal = true}")
	end

	instance.x         = settings.x or 0
	instance.y         = settings.y or 0
	instance.w         = settings.w or 0
	instance.h         = settings.h or 50
	instance.id        = Container.createID
	instance.children  = settings.children
	instance.padding   = Container.setPadding(settings)
	instance.offset    = Container.setOffset(settings)
	instance.stretch   = settings.stretch
	instance.start_x   = 0
	instance.start_y   = 0
	instance.mainAlign = settings.mainAlign
	instance.align     = Container.setAlign(settings)
	instance.spacing   = settings.spacing or {}
	instance.totalChildWidth = 0
	instance.totalChildHeight = 0
	instance.parentWidth = 0
	instance.parentHeight = 0
	instance.totalWidthOfNonContainers = 0
	instance.totalHeightOfNonContainers = 0

	Container.createID = Container.createID + 1
	return instance
end

-- LuaFormatter on

function Container:positionChildren()
	if self.mainAlign.vertical then
		local y = self.y + self.offset.top + self.padding.top
		for i, child in ipairs(self.children) do
			if self.spacing.evenly then
				local spacing = (self.h - self:getChildrenTotalHeight()) / (#self.children + 1)
				y = y + spacing
				child:setPosition(self.x + self.offset.left + self.padding.left, y)
				y = y + child.h
			elseif self.spacing.between then
				local spacing = (self.h - self:getChildrenTotalHeight()) / (#self.children - 1) + self.spacing.between
				child:setPosition(self.x + self.offset.left + self.padding.left, y)
				y = y + child.h + spacing
			else
				child:setPosition(self.x + self.offset.left + self.padding.left, y)
				y = y + child.h
			end

			if child.children then
				child:positionChildren()
			end
		end
	elseif self.mainAlign.horizontal then
		local x = 0
		if self.align.right then
			x = self.x + (self.w - self.totalChildWidth - self.padding.right)
		elseif self.align.left then
			x = self.x + self.padding.left
		end

		if self.spacing.evenly then
			x = self.x + self.padding.left
		elseif self.spacing.between then
			x = self.x + self.padding.left
		elseif self.spacing.fixed then
			x = self.x + (self.w - self.totalChildWidth) / 2
		end

		for i, child in ipairs(self.children) do
			if self.spacing.evenly then
				local spacing  = (self.w - self.padding.left - self.padding.right - self.totalChildWidth) / (#self.children + 1)
				x = x + spacing
				child:setPosition(x, self.y + self.offset.top + self.padding.top)
				x = x + child.w
			elseif self.spacing.between then
				local spacing = (self.w - (self.totalChildWidth + self.padding.left + self.padding.right)) / (#self.children -1)
				child:setPosition(x, self.y + self.offset.top + self.padding.top)
				x = x + child.w + spacing
			elseif self.spacing.fixed then
				child:setPosition(x, self.y + self.offset.top + self.padding.top)
				x = x + child.w + self.spacing.fixed
			else
				child:setPosition(x, self.y)
				x = x + child.w
			end

			if child.children then
				child:positionChildren()
			end
		end
	end
end

function Container:getChildrenTotalWidth()
	local w = 0
	for _, child in ipairs(self.children) do
		if self.mainAlign.horizontal then
			if child.children then
				child:setWidth()
			else
				self.totalWidthOfNonContainers = self.totalWidthOfNonContainers + child.w
			end
			w = w + child:getWidth()
		elseif self.mainAlign.vertical then
			if child.children then
				child:setWidth()
			end
			
			if child.w > w then
				w = child:getWidth()
				self.totalWidthOfNonContainers = w
			end
		end
	end
	return w
end

function Container:getChildrenTotalHeight()
	local h = 0
	local childHeight = 0
	for _, child in ipairs(self.children) do
		if self.mainAlign.horizontal then
			if child.children then
				child:setHeight()
			end
			
			if child.h > h then
				h = child:getHeight()
				self.totalHeightOfNonContainers = h
			end
		elseif self.mainAlign.vertical then
			if child.h > childHeight then
				h = child.h
			end
			if child.children then
				child:setHeight()
			else
				self.totalHeightOfNonContainers = self.totalHeightOfNonContainers + child.h
			end
			h = h + child:getHeight()
		end
	end
	return h
end

function Container:giveChildrenParentDimensions(w, h)
	for i, child in ipairs(self.children) do
		if child.children then
			child.parentWidth = w - self.padding.left - self.padding.right - self.totalWidthOfNonContainers
			child.parentWidth = h - self.padding.top - self.padding.bottom - self.totalHeightOfNonContainers
			
			if child.stretch then
				if child.stretch.x > 0 and child.w < w then
					child.w = (w / 100 * child.stretch.x) - self.totalWidthOfNonContainers
				elseif child.stretch.y > 0  and child.h < h then
					child.h = (h / 100 * child.stretch.y) - self.totalHeightOfNonContainers
				end
			end
			child:giveChildrenParentDimensions(child.w, child.h)
		end
	end
end

function Container:setWidth()
	local w = self:getChildrenTotalWidth()

	if self.mainAlign.horizontal then
		if self.spacing.fixed then
			w = w + self.spacing.fixed * (#self.children -1)
		elseif self.spacing.between then
			if self.w < w then error("container <= to childs width in combination with spacing") end
		end
	end
	
	if self.w < w then
		self.w = w + self.padding.left + self.padding.right
	end

	self.totalChildWidth = w
end

function Container:setHeight()
	local h = self:getChildrenTotalHeight()

	if self.mainAlign.vertical then
		if self.spacing.fixed then
			h = h + self.spacing.fixed * (#self.children -1)
		elseif self.spacing.between then
			if self.h < h then error("container <= to childs width in combination with spacing") end
		end
	end
	
	if self.h < h then
		self.h = h + self.padding.top + self.padding.bottom
	end

	self.totalChildHeight = h
end

function Container:load()
	self.start_x = self.x
	self.start_y = self.y

	self:setWidth()
	self:setHeight()
	self:giveChildrenParentDimensions(self.w, self.h)
	self:positionChildren()
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
