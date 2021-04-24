local gameSounds = game:GetService("ReplicatedStorage").Assets.Sounds
local hoverClick = gameSounds.ScrollingClick
local standardClick = gameSounds.SharpClick

local TweenInstance = require(script.Parent.SineTweening)
local playerGui = game.Players.LocalPlayer.PlayerGui.GUI
local BindInput = require(script.Parent.Input)

local guiClasses = {
    ToggleMenu = {
        Start = function(gui)
            local normalSize = gui.Size
            local bigSize = UDim2.fromScale(normalSize.X.Scale * 1.1, normalSize.Y.Scale * 1.1)

            gui.MouseEnter:Connect(function()
                TweenInstance(gui, "Size", bigSize, 0.2)

                hoverClick:Play()
            end)

            gui.MouseLeave:Connect(function()
                TweenInstance(gui, "Size", normalSize, 0.2)
            end)

            local menuAway = UDim2.fromScale(1.3, 0.5)
            local menuHere = UDim2.fromScale(0.5, 0.5)
            local menu = playerGui.Menu
            local menuOpen = true

            local function Visual()
                menuOpen = not menuOpen

                TweenInstance(menu, "Position", menuOpen and menuAway or menuHere, 0.4)

                standardClick:Play()
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
        end
	},
	
	ChatFrame = {
		Start = function(chatFrame)
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

            local sampleMessage = game.ReplicatedStorage.Assets.Message
            local messageHolder = chatFrame.Messages
            local messageCount = 0
            local messages = {}

            chatRemote.OnClientEvent:Connect(function(sender, message)
                local newMessage = sampleMessage:Clone()
                
                newMessage.Text = '<b><font color = "rgb(0, 120, 160)">['..sender..']: </font></b>'..message
                newMessage.Parent = messageHolder
                messageCount += 1
                
                table.insert(messages, newMessage)
                
                if messageCount > 30 then
                    messages[1]:Destroy()
                    
                    table.remove(messages, 1)
                end
            end)

            messageBox.ReturnPressedFromOnScreenKeyboard:Connect(PushText)

            BindInput {
                [Enum.KeyCode.DPadLeft] = FocusTextbox,
                [Enum.KeyCode.Slash] = FocusTextbox
            }
        end
	}
}

local guiToClasses = {
	ToggleMenu = guiClasses.ToggleMenu,
	ChatFrame = guiClasses.ChatFrame
}

return {GuiClasses = guiClasses, GuiToClasses = guiToClasses}