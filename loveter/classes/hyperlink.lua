local folder_path = (...):match("(.-)[^%.]+$")

local Meta = require(folder_path.."meta")
local Class = require(folder_path.."class")
local Text = require(folder_path.."text")

-- LuaFormatter off

local Hyperlink = {}
Hyperlink.__index = Hyperlink
Hyperlink.parents = Class.registerParents({Meta})
setmetatable(Hyperlink, Hyperlink.parents)

---@class Hyperlink
---@param settings {x: integer, y: integer, w: integer, h: integer}
function Hyperlink.new(settings)
	local instance = setmetatable({}, Hyperlink)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.w      = settings.w or 100
	instance.h      = settings.h or 50
	instance.text   = Text.new(settings)
	return instance
end

-- LuaFormatter on

function Hyperlink:update(dt)
	
end

function Hyperlink:draw()
	
end

return Hyperlink