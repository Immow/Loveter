local Meta = require("meta")

local Container = {}
local Container_meta = {}

-- LuaFormatter off

Container.__index = Container
Container_meta.__index = Container_meta
setmetatable(Container, Container_meta)
setmetatable(Container_meta, Meta)

local createID = 0
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
	instance.id        = createID
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

	createID = createID + 1
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
		else
			x = self.x + self.padding.left
		end

		for i, child in ipairs(self.children) do
			if self.spacing.evenly then
				local spacing  = (self.w - self.padding.left - self:getChildrenTotalWidth()) / (#self.children + 1)
				x = x + spacing
				child:setPosition(x, self.y + self.offset.top + self.padding.top)
				x = x + child.w
			elseif self.spacing.between then
				local spacing  = (self.w - self.padding.left - self:getChildrenTotalWidth()) / (#self.children - 1) + self.spacing.between
				child:setPosition(x, self.y + self.offset.top + self.padding.top)
				x = x + child.w + spacing
			else
				if self.align.right then
					child:setPosition(x, self.y)
				else
					child:setPosition(x, self.y)
				end
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
		if child.children then
			child:setWidth()
		end
		w = w + child:getWidth()
	end
	return w
end

function Container:giveChildrenParentDimensions()
	for _, child in ipairs(self.children) do
		if child.children then
			child.parentWidth = self.w
		end
	end
end

function Container:setWidth()
	local w = self:getChildrenTotalWidth()
	self.totalChildWidth = w

	-- if maxWidth < self.w then
	-- 	maxWidth = self.w -- self.padding.left  --+ self.padding.left + self.padding.right
	-- end

	if self.w > w then
		self.w = self.w + self.padding.left + self.padding.right
	else
		self.w = w + self.padding.left + self.padding.right
	end
end

function Container:setStretch()
	for _, child in ipairs(self.children) do
		if child.children then
			child:setStretch()
		end
	end

	if self.stretch then
		if self.stretch.x > 0 then
			-- print(self.w.." "..self.totalChildWidth)
			if self.parentWidth > self.w then
				self.w = self.parentWidth / 100 * self.stretch.x
			end
		end
	end
end

function Container:load()
	self.start_x = self.x
	self.start_y = self.y

	
	self:setWidth()
	self:giveChildrenParentDimensions()
	self:setStretch()
	self:positionChildren()
	-- print(self.totalChildWidth)
	


	-- for _, child in ipairs(self.children) do
	-- 	child:load()
	-- end
end

function Container:update(dt)
	for _, child in ipairs(self.children) do
		child:update()
	end
	-- self:setStretch()
	
	-- if self.x ~= self.start_x or self.y ~= self.start_y then
	-- 	self.start_x = self.x
	-- 	self.start_y = self.y
	-- 	for _, child in ipairs(self.children) do
	-- 		child:setPosition(self.x + self.padding.left, self.y)
	-- 	end
	-- end
end

function Container:draw()
	for _, child in ipairs(self.children) do
		child:draw()
	end
	
	self:debug()
end

return Container
