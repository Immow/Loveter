local TextOffset = {}
TextOffset.__index = TextOffset

---@class TextOffset
function TextOffset.new(settings)
	local instance = setmetatable({}, TextOffset)

	if settings.textPosition == "left" then
		instance.textOffset = settings.textOffset or 5
	elseif settings.textPosition == "right" then
		instance.textOffset = settings.textOffset or -5
	else
		instance.textOffset = 0
	end

	return instance.textOffset
end

return TextOffset