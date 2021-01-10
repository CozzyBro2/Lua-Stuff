local boundInputs = {}; do
	local CheckInput = function(input, focusedGui)
		local foundInput = boundInputs[input.KeyCode == Enum.KeyCode.Unknown and input.UserInputType or input.KeyCode]

		if foundInput then
			foundInput(input, focusedGui)
		end
	end

	local inputService = game:GetService("UserInputService")

	inputService.InputBegan:Connect(CheckInput)
	inputService.InputEnded:Connect(CheckInput)
end

return function(inputs, callback, shouldEnable) 
	for _, inputType in ipairs(inputs) do
		boundInputs[inputType] = shouldEnable and callback
	end
end
