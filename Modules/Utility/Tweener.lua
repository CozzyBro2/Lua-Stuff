local tweenService = game:GetService("TweenService")
local activeTweens = {}

local function AuxillaryLerp(self, target, alpha)
	return self + (target - self) * alpha
end

table.insert(require(game:GetService("ReplicatedStorage").Modules.FrameRoutines).RenderStepped, 2, function(step)
	for position, tweenInfo in pairs(activeTweens) do
		local alpha = tweenInfo.Alpha
		tweenInfo.Alpha = alpha + step / tweenInfo.Duration

		tweenInfo.Instance[tweenInfo.Target] = tweenInfo.Lerp(
			tweenInfo.StartPoint, 
			tweenInfo.Goal, 
			tweenService:GetValue(alpha, tweenInfo.Easing, tweenInfo.Direction)
		)

		if 1 < alpha then activeTweens[position] = nil end
	end
end)

return function(config)
	local target = config.Instance[config.Target]
	config.Lerp = type(target) == "userdata" and target.Lerp or AuxillaryLerp
	config.StartPoint = target
	config.Alpha = 0
	
	activeTweens[#activeTweens + 1] = config
end
