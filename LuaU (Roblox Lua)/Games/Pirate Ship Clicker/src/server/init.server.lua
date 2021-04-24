local replicatedStorage = game:GetService("ReplicatedStorage")
local dataModule = require(replicatedStorage.Common.Data)
local datastore = require(script.Datastore)
local chatModule = require(script.Chat)
local dataHolder = dataModule.Data

game.Players.PlayerAdded:Connect(function(player)
    dataHolder[player] = dataModule.NewData(datastore.Load(player))
    
    chatModule[player] = os.clock()
end)

game.Players.PlayerRemoving:Connect(function(player)
    datastore.Save(player.UserId, dataHolder[player])

    chatModule[player] = nil
    dataHolder[player] = nil
end)

game:BindToClose(function()
    for _, player in ipairs(game.Players:GetPlayers()) do
        local playerData = dataHolder[player]

        if not playerData then continue end

        coroutine.resume(coroutine.create(datastore.Save), player.UserId, playerData)
    end
end)

function replicatedStorage.Remotes.RequestData.OnServerInvoke(player)
    return dataHolder[player]
end