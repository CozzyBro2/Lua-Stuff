return game.Players.LocalPlayer and {Data = {}} or {
    Data = {}, 
    
    NewData = function(loadedData)
        local playerData = {
            Gold = 0
        }
        
        for key, value in pairs(loadedData) do
            playerData[key] = playerData[key] and value
        end

        return playerData
    end
}