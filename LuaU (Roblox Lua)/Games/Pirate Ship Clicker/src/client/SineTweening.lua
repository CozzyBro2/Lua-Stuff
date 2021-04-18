local frameRoutines = require(game:GetService("ReplicatedStorage"):WaitForChild("Common").FrameRoutines)
local tweenCount = 0
local toTween = {}

local StepTweens = function (tweenStep)
    for tweenObject, tweenParams in pairs(toTween) do
        tweenParams.TweenAlpha += tweenStep / tweenParams.TweenLength
        local tweenAlpha = math.min(tweenParams.TweenAlpha, 1)

        tweenObject[tweenParams.TweenProperty] = tweenParams.TweenOrigin:Lerp(tweenParams.TweenGoal, math.sin((tweenAlpha * 3.14159265) * 0.5))

        if tweenAlpha == 1 then
            toTween[tweenObject] = nil
            tweenCount -= 1

            if tweenCount == 0 then
                table.remove(frameRoutines.RenderStepped, 1)
            end
        end
    end
end

return function (tweenObject, tweenProperty, tweenGoal, tweenLength)
    toTween[tweenObject] = {
        TweenOrigin = tweenObject[tweenProperty],
        TweenProperty = tweenProperty,
        TweenLength = tweenLength,
        TweenGoal = tweenGoal,
        TweenAlpha = 0
    }

    tweenCount += 1

    if tweenCount == 1 then
        table.insert(frameRoutines.RenderStepped, 1, StepTweens)
    end
end