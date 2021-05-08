local CallbackMap = {} -- { Callback = CallbackInfo }
local Scheduled = {} -- { CallbackInfo = os.clock }

game:GetService("RunService").Stepped:Connect(function()
    for CallbackInfo, CallDate in pairs(Scheduled) do
        if os.clock() - CallDate < 0 then return end
        
        local CallArgs = CallbackInfo.Args
        
        CallbackInfo.Call(CallArgs and unpack(CallArgs))
    end
end)

return {
    Insert = function(Callback, Time, ...)
        local CallbackInfo = {Call = Callback, Args = ( ... and {...} )}
        
        Scheduled[CallbackInfo] = (os.clock() + Time) - 0.005
        
        CallbackMap[Callback] = CallbackInfo
    end,
    
    Remove = function(Callback)
        Scheduled[CallbackMap[Callback]] = nil
    end
}
