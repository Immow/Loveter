local Class = {}

function Class.searchParents(key, parents)
	for i = 1, #parents do
		local found = parents[i][key]
		if found then
			return found
		end
	end
end

function Class.registerParents(parents)
	return {
		__index = function (self, key)
			return Class.searchParents(key, parents)
		end
	}
end

function Class.inject(objects)
	local t = {}
	for i = 1, #objects do
		for key, _ in pairs(objects[i]) do
			t[key] = objects[i][key]
		end
	end

	return t
end

return Class