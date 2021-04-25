local sampleMessage = game.ReplicatedStorage.Assets.Message
local messageCount = 0
local messages = {}
local messageHolder

local function ChatIncoming(sender, message)
    local newMessage = sampleMessage:Clone()
                
    newMessage.Text = '<b><font color = "rgb(0, 120, 160)">['..sender..']: </font></b>'..message
    newMessage.Parent = messageHolder
    messageCount += 1
                
    table.insert(messages, newMessage)
                
    if messageCount > 30 then
        messages[1]:Destroy()
                    
        table.remove(messages, 1)
    end
end

local chatRemote = game.ReplicatedStorage.Remotes.PushMessage
local chatConnection

return {
    StartChat = function(chatFrame)
        chatConnection = chatRemote.OnClientEvent:Connect(ChatIncoming)

        messageHolder = chatFrame.Messages
    end,

    StopChat = function()
        chatConnection = chatConnection:Disconnect()
    end
}