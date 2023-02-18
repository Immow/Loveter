local Meta = require("loveter.classes.meta")
local Background = require("loveter.classes.background")
local Class = require("loveter.classes.class")

local Container = {}

-- LuaFormatter off

Container.__index = Container
Container.parents = Class.registerParents({Background, Meta})
setmetatable(Container, Container.parents)

Container.createID = 0
local defaultFont = love.graphics.getFont()

function Container.new(settings)
	local m = Meta.new(settings)
	local b = Background.new(settings)
	local instance = setmetatable(Class.inject({m, b}), Container)

	instance.w         = settings.w or 0
	instance.h         = settings.h or 0
	instance.id        = Container.createID
	instance.children  = settings.children
	instance.padding   = Container.setPadding(settings)
	instance.offset    = Container.setOffset(settings)
	instance.stretch   = Container.setStretch(settings)
	instance.mainAlign = settings.mainAlign or {horizontal = true}
	instance.align     = Container.setAlign(settings)
	instance.spacing   = settings.spacing or {}
	instance.backgroundColor = settings.backgroundColor or {0,0,0,0}
	instance.totalChildWidth = 0
	instance.totalChildHeight = 0
	instance.totalUnstretchedWidth = 0
	instance.totalUnstretchedHeight = 0
	Container.createID = Container.createID + 1
	return instance
end

-- LuaFormatter on

function Container:positionChildren()
	if self.mainAlign.vertical then
		local y = 0
		local x = 0
		if self.align.bottom then
			y = self.y + (self.h - self.totalChildHeight - self.padding.bottom)
		elseif self.align.top then
			y = self.y + self.padding.top
		end

		for i, child in ipairs(self.children) do
			if self.align.left then
				x = self.x + self.padding.left
			elseif self.align.right then
				x = self.x + self.w - (child:getWidth() + self.padding.right)
			end

			if self.spacing.evenly then
				local spacing  = (self.h - self.padding.top - self.padding.bottom - self.totalChildHeight) / (#self.children + 1)
				y = y + spacing
				child:setPosition(x, y)
				y = y + child:getHeight()
			elseif self.spacing.between then
				local spacing = (self.h - (self.totalChildHeight + self.padding.top + self.padding.bottom)) / (#self.children -1)
				child:setPosition(x, y)
				y = y + child:getHeight() + spacing
			elseif self.spacing.fixed then
				child:setPosition(x, y)
				y = y + child:getHeight() + self.spacing.fixed
			else
				child:setPosition(x, y)
				y = y + child:getHeight()
			end

			if child.children then
				child:positionChildren()
			end
		end
	elseif self.mainAlign.horizontal then
		local x = 0
		local y = 0
		if self.align.right then
			x = self.x + (self.w - self.totalChildWidth) - self.padding.right
		elseif self.align.left then
			x = self.x + self.padding.left
		end

		for i, child in ipairs(self.children) do
			if self.align.top then
				y = self.y + self.padding.top
			elseif self.align.bottom then
				y = self.y + self.h - (child:getHeight() + self.padding.bottom)
			end

			if self.spacing.evenly then
				local spacing  = (self.w - self.padding.left - self.padding.right - self.totalChildWidth) / (#self.children + 1)
				x = x + spacing
				child:setPosition(x, y)
				x = x + child:getWidth()
			elseif self.spacing.between then
				local spacing = (self.w - (self.totalChildWidth + self.padding.left + self.padding.right)) / (#self.children -1)
				child:setPosition(x, y)
				x = x + child:getWidth() + spacing
			elseif self.spacing.fixed then
				child:setPosition(x, y)
				x = x + child:getWidth() + self.spacing.fixed
			else
				child:setPosition(x, y)
				x = x + child:getWidth()
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

		if self.mainAlign.horizontal then
			w = w + child:getWidth()
			if child.children and child.stretch.x == 0 or not child.children then
				self.totalUnstretchedWidth = self.totalUnstretchedWidth + child:getWidth()
			end
		elseif self.mainAlign.vertical then
			if child:getWidth() > w then
				w = child:getWidth()
			end
		end
		
	end

	return w
end

function Container:getChildrenTotalHeight()
	local h = 0
	for _, child in ipairs(self.children) do
		if child.children then
			child:setHeight()
		end
		if self.mainAlign.horizontal then
			if child.h > h then
				h = child:getHeight()
			end
		elseif self.mainAlign.vertical then
			h = h + child:getHeight()
			if not child.children or child.stretch.y == 0 then
				self.totalUnstretchedHeight = self.totalUnstretchedHeight + child.h
			end
		end

	end

	return h
end

function Container:giveChildrenParentDimensions(w, h)
	for i, child in ipairs(self.children) do
		if child.children then
			if child.stretch then
				if child.stretch.x > 0 and child.w < w then
					if self.id == 1 then
						-- print("self.w: "..self.w.." w: "..w)
						print(self.totalUnstretchedWidth)
					end
					child.w = ((w - (self.padding.left + self.padding.right)) - self.totalUnstretchedWidth) / 100 * child.stretch.x
				end
				if child.stretch.y > 0 and child.h < h then
					child.h = ((h - (self.padding.top + self.padding.bottom)) - self.totalUnstretchedHeight) / 100 * child.stretch.y
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
		elseif self.spacing.between or self.spacing.evenly then
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
		elseif self.spacing.between or self.spacing.evenly then
			if self.h < h then error("container <= to childs width in combination with spacing") end
		end
	end
	
	if self.h <= h then
		self.h = h + self.padding.top + self.padding.bottom
	end

	self.totalChildHeight = h
end

function Container:load()
	love.keyboard.setKeyRepeat(true)
	self.start_x = self.x
	self.start_y = self.y
	
	self:setWidth()
	self:setHeight()
	self:setQuad()
	self:giveChildrenParentDimensions(self.w, self.h)
	self:positionChildren()

	for _, child in pairs(self.children) do
		if not child.children then
			child:load()
		end
	end
end

function Container:mousepressed(x, y, button, istouch, presses)
	for _, child in pairs(self.children) do
		child:mousepressed(x, y, button, istouch, presses)
	end
end

function Container:mousereleased(x, y, button, istouch, presses)
	for _, child in pairs(self.children) do
		child:mousereleased(x, y, button, istouch, presses)
	end
end

function Container:keypressed(key, scancode, isrepeat)
	for _, child in pairs(self.children) do
		child:keypressed(key, scancode, isrepeat)
	end
end

function Container:textinput(t)
	for _, child in pairs(self.children) do
		child:textinput(t)
	end
end

function Container:update(dt)
	for _, child in pairs(self.children) do
		child:update(dt)
	end
end

function Container:draw()
	self:drawBackgroundColor()
	self:drawBackgroundImage()

	for _, child in pairs(self.children) do
		child:draw()
	end
	
	love.graphics.setFont(defaultFont)
	love.graphics.setColor(1,1,1,1)
	self:debug()
end

return Container
