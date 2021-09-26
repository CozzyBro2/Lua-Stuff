local module = {}

local inputService = game:GetService("UserInputService")
local sounds = game:GetService("ReplicatedStorage").Assets.Sounds
local buttons = {}

local function Lerp(origin, goal, alpha)
	return origin + (goal - origin) * alpha
end

function module.Start(frame, info)
	local connections = {}
	
	local button = frame.Ball
	local amount = frame.Amount
	
	local function Update(x)
		x = math.clamp(x, info.LowerBound, info.UpperBound)
		
		amount.Text = string.format("%.1f", x)
		button.Position = UDim2.fromScale(math.clamp(x, -0.1, 0.9), 0)
		
		info.ChangeValue(x)
	end
	
	local function Validate()
		local value = tonumber(amount.Text)

		if value then
			Update(value / info.UpperBound)
		end
	end
	
	local function FocusLost(returnPressed)
		if returnPressed then
			Validate()
		end
	end
	
	local function Drag(mouse)
		local inputType = mouse.UserInputType
		
		if inputType == Enum.UserInputType.MouseMovement or inputType == Enum.UserInputType.Touch then
			local difference = mouse.Position.X - frame.AbsolutePosition.X
			
			local alpha = math.clamp(difference / frame.AbsoluteSize.X - 0.1, 0, 1)
			
			Update(alpha)
		end
	end
	
	local function StopDragging()
		local drag, stopDrag = connections.Drag, connections.StopDrag
		
		if drag then
			drag:Disconnect()
		end

		if stopDrag then
			stopDrag:Disconnect()
		end
	end
	
	local function StartDragging(input)
		local inputType = input.UserInputType
		
		if inputType == Enum.UserInputType.MouseButton1 or inputType == Enum.UserInputType.Touch then
			connections.StopDrag = inputService.InputEnded:Connect(StopDragging)
			
			sounds.AlternateClick:Play()
			
			connections.Drag = inputService.InputChanged:Connect(Drag)
		end
	end
	
	table.insert(connections, button.InputBegan:Connect(StartDragging))
	table.insert(connections, amount.FocusLost:Connect(FocusLost))
	table.insert(connections, amount.ReturnPressedFromOnScreenKeyboard:Connect(Validate))
	
	info.Connections = connections
	buttons[button] = info
end

function module.Stop(button)
	local info = buttons[button]

	if info then
		for _, connection in ipairs(info.Connections) do
			connection:Disconnect()
		end

		buttons[button] = nil
	end
end

return module
