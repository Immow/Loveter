-- LuaFormatter off

local Color = {}
Color.__index = Color

---@class Color
function Color.new(settings)
	local instance = setmetatable({}, Color)
	settings.color = settings.color or {}
	if settings.image then
		if settings.color.pressed == nil then settings.color.pressed = {1,1,1,1} end
		if settings.color.hover   == nil then settings.color.hover   = {1,1,1,1} end
		if settings.color.idle    == nil then settings.color.idle    = {1,1,1,1} end
		if settings.color.holding == nil then settings.color.holding = {1,1,1,1} end
	else
		if settings.color.pressed == nil then settings.color.pressed = {1,0,0,1} end
		if settings.color.hover   == nil then settings.color.hover   = {0,1,0,1} end
		if settings.color.idle    == nil then settings.color.idle    = {1,1,1,1} end
		if settings.color.holding == nil then settings.color.holding = {0,0,1,1} end
	end

	instance.pressed = settings.color.pressed
	instance.hover   = settings.color.hover
	instance.idle    = settings.color.idle
	instance.holding = settings.color.holding

	return instance
end

-- LuaFormatter on

function Color:draw(state)
	love.graphics.setColor(self[state])
end

return Color