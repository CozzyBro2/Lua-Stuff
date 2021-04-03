local frameRoutines = {PreSimulation = game.Players.LocalPlayer and {}} -- Add support for more events here as you see fit 

for routineType, routines in pairs(frameRoutines) do
    game:GetService("RunService")[routineType]:Connect(function(...) -- swap for a single named arg if you don't use Stepped or it's equivalents
        for _, routine in ipairs(routines) do
            routine(...)
        end
    end)

    routineType = nil
end

return frameRoutines
