local Image = {}

Image.__index = Image

---@class Image
function Image.new(settings)
	local instance = setmetatable({}, Image)

	if not settings.image then return nil end

	local states = {"idle", "hover", "pressed", "holding"}

	for _, value in pairs(settings) do
		if type(value) == "userdata" then
			for _, state in pairs(states) do
				instance[state] = value
			end

			return instance
		end
	end

	for _, value in pairs(states) do
		if not settings.image[value] then
			instance[value] = {}
			instance[value] = settings.image["idle"]
		else
			instance[value] = {}
			instance[value] = settings.image[value]
		end
	end

	return instance
end

return Image