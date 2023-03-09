---@author: Koen Schippers 2023-03-07 01:23:52
local State_Manager = {}

local states = {}
local requiredStates = {}
local currentState = nil
local activeState = nil

---@param state string: state the module belongs to.
---@param module string: the file name that your required in main.lua.
---@param order? integer: optional draw order (defaults to 1 if omitted), draws from low to high.
function State_Manager.addState(state, module, order)
	if not state and not module then error("state needs a state and module") end

	if not states[state] then
		states[state] = {
			drawOrder = {},
			module = {},
		}
	end

	order = order or 1
	states[state].module[module] = {
		exclude = {},
		drawPosition = order,
		name = module,
		forceLoad = false
	}

	if #states[state].drawOrder == 0 then
		table.insert(states[state].drawOrder, module)
	else
		for i = #states[state].drawOrder, 1, -1 do
			local v = states[state].drawOrder[i]
			if order == states[state].module[v].drawPosition then
				table.insert(states[state].drawOrder, i, module)
				break
			elseif order > states[state].module[v].drawPosition then
				table.insert(states[state].drawOrder, i+1, module)
				break
			elseif i == 1 then
				table.insert(states[state].drawOrder, i, module)
			end
		end
	end
end

---@param state string: require path, ea: "myfolder.filename"
function State_Manager.requireState(state)
	requiredStates[state:match("[^.]+$")] = require(state)
end

---@param state string: sets active state
function State_Manager.setState(state)
	if state == nil then error("state can't be nil") end
	if next(states) == nil then error("states does not contain any states / modules") end
	activeState = currentState or state
	currentState = state
	State_Manager:init()
end

---@return string activeState
function State_Manager.getState()
	return activeState
end

---@param state string: state the module belongs to
---@param module string: the file that your required in main.lua.
---@param fn {update: true|false, draw: true|false, mouspressed: true|false, mousereleased: true|false, mousemoved: true|false, keypressed: true|false}, functions you want to exclude from running
function State_Manager.exclude(state, module, fn)
	states[state].module[module].exclude = fn
end

--- load gets called once.
function State_Manager:load()
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].load then
			if not states[activeState].module[state].exclude.load then
				requiredStates[state]:load()
			end
		end
	end
end

--- init gets called when you switch state.
function State_Manager:init()
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].init then
			if not states[activeState].module[state].exclude.init then
				requiredStates[state]:init()
			end
		end
	end
end

function State_Manager:update(dt)
	if activeState ~= currentState then activeState = currentState end
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].update then
			if not states[activeState].module[state].exclude.update then
				requiredStates[state]:update(dt)
			end
		end
	end
end

function State_Manager:draw()
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].draw then
			if not states[activeState].module[state].exclude.draw then
				requiredStates[state]:draw()
			end
		end
	end
end

function State_Manager:mousepressed(mx, my, mouseButton)
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].mousepressed then
			if not states[activeState].module[state].exclude.mousepressed then
				requiredStates[state]:mousepressed(mx, my, mouseButton)
			end
		end
	end
end

function State_Manager:mousereleased(mx, my, mouseButton)
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].mousereleased then
			if not states[activeState].module[state].exclude.mousereleased then
				requiredStates[state]:mousereleased(mx, my, mouseButton)
			end
		end
	end
end

function State_Manager:mousemoved(x, y, dx, dy, istouch)
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].mousemoved then
			if not states[activeState].module[state].exclude.mousemoved then
				requiredStates[state]:mousemoved(x, y, dx, dy, istouch)
			end
		end
	end
end

function State_Manager:keypressed(key,scancode,isrepeat)
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].keypressed then
			if not states[activeState].module[state].exclude.keypressed then
				requiredStates[state]:keypressed(key,scancode,isrepeat)
			end
		end
	end
end

function State_Manager:textinput(t)
	for _, state in ipairs(states[activeState].drawOrder) do
		if requiredStates[state].textinput then
			if not states[activeState].module[state].exclude.textinput then
				requiredStates[state]:textinput(t)
			end
		end
	end
end

return State_Manager