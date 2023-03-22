-- LuaFormatter off

local Color = {}
Color.__index = Color

---@class Color
function Color.new(settings)
	local instance = setmetatable({}, Color)
	local states = {"pressed", "hover", "idle", "holding"}

	for _, value in pairs(settings) do
		if type(value[1]) == "number" and type(value[2]) == "number" and type(value[3]) == "number" then
			for _, state in pairs(states) do
				instance[state] = value
			end

			return instance
		end
	end

	if settings.imageColor then
		instance.pressed = settings.imageColor.pressed or {1,1,1,1}
		instance.hover   = settings.imageColor.hover   or {1,1,1,1}
		instance.idle    = settings.imageColor.idle    or {1,1,1,1}
		instance.holding = settings.imageColor.holding or {1,1,1,1}
	elseif settings.borderColor then
		instance.pressed = settings.borderColor.pressed or {0,0,0,0}
		instance.hover   = settings.borderColor.hover   or {0,0,0,0}
		instance.idle    = settings.borderColor.idle    or {0,0,0,0}
		instance.holding = settings.borderColor.holding or {0,0,0,0}
	elseif settings.textColor then
		instance.pressed = settings.textColor.pressed or {0,0,0,1}
		instance.hover   = settings.textColor.hover   or {0,0,0,1}
		instance.idle    = settings.textColor.idle    or {0,0,0,1}
		instance.holding = settings.textColor.holding or {0,0,0,1}
	elseif settings.shapeColor then
		instance.pressed = settings.shapeColor.pressed or {1,1,1,1}
		instance.hover   = settings.shapeColor.hover   or {1,1,1,1}
		instance.idle    = settings.shapeColor.idle    or {1,1,1,1}
		instance.holding = settings.shapeColor.holding or {1,1,1,1}
	end
	return instance
end

-- LuaFormatter on

function Color:draw(state)
	if not state then state = "idle" end
	love.graphics.setColor(self[state])
end

return Color