local chatRemote = game:GetService("ReplicatedStorage").Remotes.PushMessage
local textService = game:GetService("TextService")
local chatCooldowns = {}

chatRemote.OnServerEvent:Connect(function(player, chatMessage)
    if os.clock() - chatCooldowns[player] < 1.2 or 512 < #chatMessage then return end
    chatCooldowns[player] = os.clock()

    local filterResult = textService:FilterStringAsync(chatMessage, player.UserId)
    local sendersName = player.Name

    for recipient in pairs(chatCooldowns) do
        coroutine.resume(coroutine.create(function()
            chatRemote:FireClient(recipient, sendersName, filterResult:GetChatForUserAsync(recipient.UserId))
        end))
    end
end)

return chatCooldowns