local boundInputs = {}

local HandleInput = function(input, isFocused)
	local foundInput = boundInputs[input.KeyCode == Enum.KeyCode.Unknown and input.UserInputType or input.KeyCode]

	if foundInput then
		for _, callback in ipairs(foundInput) do
			callback(input, isFocused)
		end
	end
end
	
local inputService = game:GetService("UserInputService")
	
inputService.InputChanged:Connect(HandleInput)
inputService.InputBegan:Connect(HandleInput)
inputService.InputEnded:Connect(HandleInput)

return boundInputs
