local player = game:GetService("Players").LocalPlayer

player.CharacterAdded:Connect(function(newCharacter)
    
end)

player.CharacterRemoving:Connect(function(characterPending)
    
end)

local replicatedStorage = game:GetService("ReplicatedStorage")
local contentProvider = game:GetService("ContentProvider")
local guiFolder = replicatedStorage.Assets.GUI

coroutine.resume(coroutine.create(contentProvider.PreloadAsync), contentProvider, replicatedStorage:WaitForChild("Assets"):GetChildren())
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

replicatedStorage:WaitForChild("Remotes").Parent = nil
guiFolder.Parent = player.PlayerGui

for guiName, class in pairs(require(script.Gui).GuiToClasses) do
    class.Start(guiFolder[guiName])
end