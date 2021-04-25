local player = game:GetService("Players").LocalPlayer

player.CharacterAdded:Connect(function(newCharacter)
    
end)

player.CharacterRemoving:Connect(function(characterPending)
    
end)

local replicatedStorage = game:GetService("ReplicatedStorage")
local contentProvider = game:GetService("ContentProvider")
local guiFolder = replicatedStorage.Assets.GUI

coroutine.resume(coroutine.create(function() 
    contentProvider:PreloadAsync(replicatedStorage.Assets:GetChildren())

    guiFolder.Parent = player.PlayerGui

    for guiName, classes in pairs(require(script.Gui).GuiToClasses) do
        for _, class in ipairs(classes) do
            class.Start(guiFolder:FindFirstChild(guiName, true))
        end
    end
end))

require(replicatedStorage.Common.Data).Data = replicatedStorage.Remotes.RequestData:InvokeServer()
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)