local gameSounds = game.ReplicatedStorage.Assets.Sounds
local hoverClick = gameSounds.ScrollingClick
local standardClick = gameSounds.SharpClick

local TweenInstance = require(script.Parent.SineTweening)
local playerGui = game.Players.LocalPlayer.PlayerGui.GUI

local guiClasses = {
    FlashyButton = {
        Start = function (gui)
            local normalSize = gui.Size
            local bigSize = UDim2.fromScale(normalSize.X.Scale * 1.1, normalSize.Y.Scale * 1.1)

            local menuAway = UDim2.fromScale(1.3, 0.5)
            local menuHere = UDim2.fromScale(0.5, 0.5)
            local menu = playerGui.Menu
            local menuOpen = true
            
            gui.MouseEnter:Connect(function ()
                TweenInstance(gui, "Size", bigSize, 0.2)

                hoverClick:Play()
            end)

            gui.MouseLeave:Connect(function ()
                TweenInstance(gui, "Size", normalSize, 0.2)
            end)

            gui.MouseButton1Down:Connect(function ()
                menuOpen = not menuOpen

                TweenInstance(menu, "Position", menuOpen and menuAway or menuHere, 0.4)

                standardClick:Play()
            end)
        end
    }
}

local guiToClasses = {
    ButtonTest = guiClasses.FlashyButton
}

return {GuiClasses = guiClasses, GuiToClasses = guiToClasses}