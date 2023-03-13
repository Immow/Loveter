local Offset = {}

function Offset.set(settings)
	if not settings.offset then
		return {idle = {x = 0, y = 0}, hover = {x = 0, y = 0}, pressed = {x = 0, y = 0}, holding = {x = 0, y = 0}}
	else
		local idle
		local hover
		local pressed
		local holding
		if not settings.offset.idle then
			idle = {x = 0, y = 0}
		else
			idle = {x = settings.offset.idle.x, y = settings.offset.idle.y}
		end

		if not settings.offset.hover then
			hover = {x = 0, y = 0}
		else
			hover = {x = settings.offset.hover.x, y = settings.offset.hover.y}
		end

		if not settings.offset.pressed then
			pressed = {x = 0, y = 0}
		else
			pressed = {x = settings.offset.pressed.x, y = settings.offset.pressed.y}
		end

		if not settings.offset.holding then
			holding = {x = 0, y = 0}
		else
			holding = {x = settings.offset.holding.x, y = settings.offset.holding.y}
		end

		return {idle = idle, hover = hover, pressed = pressed, holding = holding}
	end
end

return Offset