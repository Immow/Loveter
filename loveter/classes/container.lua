local folder_path = (...):match("(.-)[^%.]+$")

local Meta = require(folder_path.."meta")
local Background = require(folder_path.."background")
local Class = require(folder_path.."class")

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

function Container.setOffset(settings)
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

function Container.setPadding(settings)
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

function Container.setAlign(settings)
	if not settings.align then
		return {top = true, bottom = false, left = true, right = false, center = false}
	else
		local top = settings.align.top or false
		local bottom = settings.align.bottom or false
		local left = settings.align.left or false
		local right = settings.align.right or false
		local center = settings.align.center or false

		if not top and not bottom and not center then top = true end
		if not left and not right and not center then left = true end

		return {top = top, bottom = bottom, left = left, right = right, center = center}
	end
end

function Container.setStretch(settings)
	if not settings.stretch then
		return {x = 0, y = 0}
	else
		local x = settings.stretch.x or 0
		local y = settings.stretch.y or 0
		return {x = x, y = y}
	end
end

function Container:positionChildren()
	if self.mainAlign.vertical then
		local y = 0
		local x = 0
		if self.align.bottom then
			y = self.y + (self.h - self.totalChildHeight - self.padding.bottom)
		elseif self.align.top then
			y = self.y + self.padding.top
		elseif self.align.center then
			x = self.x + self.w / 2 - self.totalChildWidth / 2
			y = self.y + self.h / 2 - self.totalChildHeight / 2
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
		elseif self.align.center then
			x = self.x + self.w / 2 - self.totalChildWidth / 2
			y = self.y + self.h / 2 - self.totalChildHeight / 2
		end

		for _, child in ipairs(self.children) do
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
				if child.stretch.x > 0 and child.w < w then
					child.w = ((w - (self.padding.left + self.padding.right)) - self.totalUnstretchedWidth) / 100 * child.stretch.x
				end
				if child.stretch.y > 0 and child.h < h then
					child.h = ((h - (self.padding.top + self.padding.bottom)) - self.totalUnstretchedHeight) / 100 * child.stretch.y
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

	-- for _, child in pairs(self.children) do
	-- 	child:loadPreset()
	-- end
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

function Container:mousemoved(x, y, dx, dy, istouch)
	for _, child in pairs(self.children) do
		child:mousemoved(x, y, dx, dy, istouch)
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
