--[[ TODO:
     Stop returning a function, remove the do end, remove the dumb variables, etc.
--]]

local boundInputs, bindList = {}, {} do
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
end

return function(callback, inputs)
	if not bindList[callback] then bindList[callback] = inputs end
	
	local inputList = inputs or bindList[callback]
	
	for _, input in ipairs(inputList) do
		if inputs and boundInputs[input] then
			table.insert(boundInputs[input], callback); return
		end
		
		boundInputs[input] = inputs and {callback}
	end
end
