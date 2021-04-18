local dataModule = require(game:GetService("ReplicatedStorage").Common.Data)
local datastore = require(script.Datastore)
local players = game:GetService("Players")
local dataHolder = dataModule.Data

players.PlayerAdded:Connect(function(player)
    dataModule.Data[player] = dataModule.NewData()

    local playerData = dataHolder[player]
    local loadedData = datastore.Load(player)  
   
    for key, value in pairs(loadedData) do
        playerData[key] = playerData[key] and value
    end
end)

players.PlayerRemoving:Connect(function(player)
    datastore.Save(player.UserId, dataHolder[player])

    dataHolder[player] = nil
end)

game:BindToClose(function()
    for _, player in ipairs(players:GetPlayers()) do
        local playerData = dataHolder[player]

        if not playerData then continue end

        coroutine.resume(coroutine.create(datastore.Save), player.UserId, playerData)
    end
end)
