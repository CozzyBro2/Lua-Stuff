local chatRemote = game:GetService("ReplicatedStorage").Remotes.PushMessage
local textService = game:GetService("TextService")
local players = game:GetService("Players")
local chatCooldowns = {}

chatRemote.OnServerEvent:Connect(function(player, chatMessage)
    if os.clock() - chatCooldowns[player] < 1.2 or 512 < #chatMessage then return end
    chatCooldowns[player] = os.clock()

    local filterResult = textService:FilterStringAsync(chatMessage, player.UserId)

    for _, recipient in ipairs(players:GetPlayers()) do
        coroutine.resume(coroutine.create(function()
            chatRemote:FireClient(recipient, player.Name, filterResult:GetChatForUserAsync(recipient.UserId))
        end))
    end
end)

return chatCooldowns