-- NOTE: This module is redundant as of the deferred signal update, and impractical to begin with.

local inputBinds = {}

local function HandleInput(input, guiFocused)
    local keyCode = input.KeyCode
    local inputBind = inputBinds[keyCode == Enum.KeyCode.Unknown and input.UserInputType or keyCode]

    if inputBind and not guiFocused then
        for _, callback in ipairs(inputBind) do
            callback(input)
        end
    end
end

local inputService = game:GetService("UserInputService")
inputService.InputChanged:Connect(HandleInput)
inputService.InputBegan:Connect(HandleInput)
inputService.InputEnded:Connect(HandleInput)

return function (inputsToCallbacks)
    for inputType, callback in pairs(inputsToCallbacks) do
        local currentBind = inputBinds[inputType]

        if callback and currentBind then
            table.insert(currentBind, callback)

            return
        end

        inputBinds[inputType] = callback and {callback}
    end
end
