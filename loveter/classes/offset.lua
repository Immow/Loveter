local Offset = {}

Offset.__index = Offset

---@class Offset
function Offset.new(settings)
	local instance = setmetatable({}, Offset)

	if not settings then
		instance = {idle = {x = 0, y = 0}, hover = {x = 0, y = 0}, pressed = {x = 0, y = 0}, holding = {x = 0, y = 0}}
		return instance
	else
		local states = {"idle", "hover", "pressed", "holding"}

		for _, value in pairs(states) do
			if not settings[value] then
				instance[value] = {}
				instance[value].x = 0
				instance[value].y = 0
			else
				instance[value] = {}
				instance[value].x = settings[value].x or 0
				instance[value].y = settings[value].y or 0
			end
		end

		return instance
	end
end

return Offset