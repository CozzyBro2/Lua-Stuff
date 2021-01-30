local activeTweens = {}

local ToSineValue = function(origin, goal, alpha)
	return origin + (goal - origin) * -(math.cos(3.14 * alpha) - 1)
end

game:GetService("RunService").RenderStepped:Connect(function(elaspedDelta)
	for position, tweenParams in ipairs(activeTweens) do
		tweenParams.Progress += elaspedDelta / tweenParams.Duration
		local currentProgress = tweenParams.Progress
		
		tweenParams.Whom[tweenParams.What] = tweenParams.Interpolate(tweenParams.PointFirst, tweenParams.Where, currentProgress)
		
		if currentProgress > 1 then
			table.remove(activeTweens, position) -- pop current
		end
	end
end)

return function(tweenParams)
	tweenParams.Interpolate = tweenParams.Whom[tweenParams.What].Lerp or ToSineValue
	tweenParams.Progress = 0
	
	table.insert(activeTweens, tweenParams)
end
