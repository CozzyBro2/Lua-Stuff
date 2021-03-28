local inputBinds = {}

local HandleInput = function(inputObject) 
    local keyCode = inputObject.KeyCode
    local boundInput = inputBinds[keyCode == Enum.KeyCode.Unknown and inputObject.UserInputType or keyCode]

    if boundInput then
        for _, callback in ipairs(boundInput.Callbacks) do
            callback(inputObject)
        end
    end
end

local inputService = game:GetService("UserInputService")

inputService.InputChanged:Connect(HandleInput)
inputService.InputBegan:Connect(HandleInput)
inputService.InputEnded:Connect(HandleInput)

return inputBinds
