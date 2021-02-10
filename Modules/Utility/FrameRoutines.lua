local frameRoutines = {RenderStepped = "TBD"}; frameRoutines.RenderStepped = game.Players.LocalPlayer and {}
local runService = game:GetService("RunService")

for frameStep, callbacks in pairs(frameRoutines) do
	runService[frameStep]:Connect(function(deltaTime)
		for _, callback in ipairs(callbacks) do
			callback(deltaTime)
		end
	end); frameStep = nil
end

return frameRoutines
