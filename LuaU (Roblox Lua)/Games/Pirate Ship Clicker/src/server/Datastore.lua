local playerDatastore = game:GetService("DataStoreService"):GetDataStore("PSC-4")

return {
    Load = function(player)
        local userId = player.UserId

        pcall(playerDatastore.UpdateAsync, playerDatastore, userId.."L", function(isLocked)
            local currentTimestamp = DateTime.now().UnixTimestamp

            if isLocked and currentTimestamp - isLocked < 18000 then
                player:Kick("Session Locked. please rejoin in 5 minutes")

                return
            end

            return currentTimestamp
        end)

        local state, returned = pcall(playerDatastore.GetAsync, playerDatastore, userId)

        if not state then
            player:Kick("Datastore Error, please rejoin in a few minutes. (your data has not been lost) Error: "..returned)

            returned = {Immutable = true}
        end

        return returned or {}
    end, 
    
    Save = function(userId, toSave)
        pcall(playerDatastore.RemoveAsync, playerDatastore, userId.."L")

        if toSave.Immutable then return end

        playerDatastore:SetAsync(userId, toSave)
    end
}