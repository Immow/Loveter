local Scale = {}

Scale.__index = Scale

---@class Scale
function Scale.new(settings)
	local instance = setmetatable({}, Scale)
	if not settings.scale then
		instance = {idle = 1, hover = 1, pressed = 1, holding = 1}
		return instance
	else
		local states = {"idle", "hover", "pressed", "holding"}
		
		for _, value in pairs(states) do
			if not settings.scale[value] then
				instance[value] = 1
			else
				instance[value] = settings.scale[value]
			end
		end

		return instance
	end
end

return Scale