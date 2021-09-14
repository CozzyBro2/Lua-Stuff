-- NOTE: This module is completely redundant, there is no real reason to use this. Only downsides.

local frameRoutines = {RenderStepped = game.Players.LocalPlayer and {}}

for routineType, routines in pairs(frameRoutines) do
    game:GetService("RunService")[routineType]:Connect(function(deltaTime)
        for _, routine in ipairs(routines) do
            routine(deltaTime)
        end
    end)

    routineType = nil
end

return frameRoutines

