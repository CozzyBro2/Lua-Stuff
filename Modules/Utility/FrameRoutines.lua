local frameRoutines = {RenderStepped = game.Players.LocalPlayer and {}, Heartbeat = {}}

for routineType, routines in pairs(frameRoutines) do
    game:GetService("RunService")[routineType]:Connect(function(deltaTime)
        for _, routine in ipairs(routines) do
            routine(deltaTime)
        end
    end)
    
    routineType = nil
end

return frameRoutines
