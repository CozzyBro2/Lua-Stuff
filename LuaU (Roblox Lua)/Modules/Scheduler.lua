local CallbackMap = {} -- { Callback = CallbackInfo }
local Scheduled = {} -- { CallbackInfo = os.clock }
local Scheduler = {}

game:GetService("RunService").Heartbeat:Connect(function()
	for CallbackInfo, CallDate in pairs(Scheduled) do
		if os.clock() < CallDate then continue end

		local Call = CallbackInfo.Call
		Scheduler.Remove(Call)

		Call(unpack(CallbackInfo.Args))
	end
end)

function Scheduler.Add(Time, Callback, ...)
	local CallbackInfo = {
		Call = Callback, 
		Args = {...}
	}

	Scheduled[CallbackInfo] = (os.clock() + Time) - 0.005
	CallbackMap[Callback] = CallbackInfo
end

function Scheduler.Remove(Callback)
	local ToRemove = CallbackMap[Callback]

	Scheduled[ToRemove] = nil
	CallbackMap[Callback] = nil
end

return Scheduler
