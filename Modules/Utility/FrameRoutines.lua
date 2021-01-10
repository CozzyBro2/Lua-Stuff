local routineMap = {RenderStepped = {}, Heartbeat = {}}

local startIteration = function(stepType)
	game:GetService("RunService")[stepType]:Connect(function(delta)
		for _, subroutine in ipairs(stepType) do 
			subroutine(delta)
		end
	end); stepType = routineMap[stepType]
end

return game.Players.LocalPlayer and startIteration("RenderStepped") or startIteration("Heartbeat") or routineMap
