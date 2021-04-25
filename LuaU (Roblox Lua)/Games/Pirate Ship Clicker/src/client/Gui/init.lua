local gameSounds = game:GetService("ReplicatedStorage").Assets.Sounds
local hoverClick = gameSounds.ScrollingClick
local standardClick = gameSounds.SharpClick

local TweenInstance = require(script.Parent.SineTweening)
local playerGui = game.Players.LocalPlayer.PlayerGui.GUI
local BindInput = require(script.Parent.Input)

local guiClasses = {
    HoverGui = {Start = function(gui)
        local normalSize = gui.Size
        local bigSize = UDim2.fromScale(normalSize.X.Scale * 1.1, normalSize.Y.Scale * 1.1)

        gui.MouseEnter:Connect(function()
            TweenInstance(gui, "Size", bigSize, 0.2)

            hoverClick:Play()
         end)

        gui.MouseLeave:Connect(function()
            TweenInstance(gui, "Size", normalSize, 0.2)
        end)
    end},

    ToggleMenu = {Start = function(gui)
        local menuAway = UDim2.fromScale(1.3, 0.5)
        local menuHere = UDim2.fromScale(0.5, 0.5)
        local menu = playerGui.Menu
        local menuOpen = false

        local function Visual()
            TweenInstance(menu, "Position", menuOpen and menuAway or menuHere, 0.4)

            standardClick:Play()

            menuOpen = not menuOpen
        end

        local function ToggleMenu(input)
            if input.UserInputState == Enum.UserInputState.Begin then
                Visual()
            end
        end

        BindInput {
            [Enum.KeyCode.DPadUp] = ToggleMenu,
            [Enum.KeyCode.M] = ToggleMenu,
        }
            
        gui.MouseButton1Down:Connect(Visual)
    end},
	
	ChatFrame = {Start = function(chatFrame)
        local chatRemote = game.ReplicatedStorage.Remotes.PushMessage
        local messageBox = chatFrame.MessageBox
        local lastChat = os.clock()
            
        local function PushText()
            local message = messageBox.Text

            if os.clock() - lastChat < 1.2 or 512 < #message then return end
            lastChat = os.clock()

            chatRemote:FireServer(message)
        end

        local function FocusTextbox(input)
            if input.UserInputState == Enum.UserInputState.Begin then
                messageBox:CaptureFocus()
            end
        end
            
        messageBox.FocusLost:Connect(function(pressedEnter)
            if pressedEnter then
                PushText()

                messageBox.Text = ""
            end
        end)

        messageBox.ReturnPressedFromOnScreenKeyboard:Connect(PushText)

        BindInput {
            [Enum.KeyCode.DPadLeft] = FocusTextbox,
            [Enum.KeyCode.Slash] = FocusTextbox
        } 

        require(script.Chat).StartChat(chatFrame)
	end},

    ToggleChat = {Start = function(gui)
        local chatAway = UDim2.fromScale(-0.45, 0.4)
        local chatHere = UDim2.fromScale(0.005, 0.4)
        local chatFrame = playerGui.ChatFrame
        local chatToggled = true

        gui.MouseButton1Down:Connect(function()
            TweenInstance(chatFrame, "Position", chatToggled and chatAway or chatHere, 1)

            standardClick:Play()

            chatToggled = not chatToggled
        end)
    end}
}

local guiToClasses = {
	ToggleMenu = {guiClasses.HoverGui, guiClasses.ToggleMenu},
    ChatButton = {guiClasses.HoverGui, guiClasses.ToggleChat},
    SettingsButton = {guiClasses.HoverGui},
	ChatFrame = {guiClasses.ChatFrame}
}

return {GuiClasses = guiClasses, GuiToClasses = guiToClasses}