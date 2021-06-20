local CallbackMap = {} -- { Callback = CallbackInfo }
local Scheduled = {} -- { CallbackInfo = os.clock }
local ScheduleFuncs = {}

game:GetService("RunService").Heartbeat:Connect(function()
	for CallbackInfo, CallDate in pairs(Scheduled) do
		if os.clock() < CallDate then continue end

		local Call = CallbackInfo.Call
		ScheduleFuncs.Remove(Call)
		
		Call(unpack(CallbackInfo.Args))
	end
end)

function ScheduleFuncs.Schedule(Time, Callback, ...)
	local CallbackInfo = {Call = Callback, Args = {...}}

	Scheduled[CallbackInfo] = (os.clock() + Time) - 0.005

	CallbackMap[Callback] = CallbackInfo
end

function ScheduleFuncs.Remove(Callback)
	Scheduled[CallbackMap[Callback]] = nil

	CallbackMap[Callback] = nil
end

return ScheduleFuncs
