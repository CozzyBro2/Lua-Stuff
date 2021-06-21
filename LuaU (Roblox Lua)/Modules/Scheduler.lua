local CallbackMap = {} -- { Callback = Info }
local Scheduled = {} -- { Info = os.clock }
local Scheduler = {}

game:GetService("RunService").Heartbeat:Connect(function()
	for Info, Date in pairs(Scheduled) do
		if os.clock() < Date then continue end

		local Call = Info.Call

		Scheduler.Remove(Call)
		Call(unpack(Info.Args))
	end
end)

function Scheduler.Add(Time, Callback, ...)
	local Info = {
		Call = Callback, 
		Args = {...}
	}

	Scheduled[Info] = (os.clock() + Time) - 0.005
	CallbackMap[Callback] = Info
end

function Scheduler.Remove(Callback)
	local ToRemove = CallbackMap[Callback]

	Scheduled[ToRemove] = nil
	CallbackMap[Callback] = nil
end

return Scheduler
