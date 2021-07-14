local Service = {Subscriptions = {}}
Service.__index = Service

function Service.new(Parameters)
	assert(Parameters, "Null parameters")
	assert(Parameters.Topic, "Null topic")

	local Subscription = setmetatable({

		_WrapCalls 		= Parameters.WrapCalls,
		_ResumePoints   = {},
		_CanListen 		= true,
		Topic 			= Parameters.Topic,

	}, Service)

	Service.Subscriptions[Subscription.Topic] = Subscription
	
	return Subscription
end

function Service:Connect(Callback)
	assert(type(Callback) == "function", "Expected type 'function'")
	
	Callback = self._WrapCalls and coroutine.wrap(Callback) or Callback
	
	self._ResumePoints[Callback] = {}
end

function Service:Wait()
	self._ResumePoints[coroutine.running()] = {}

	return coroutine.yield()
end
	
function Service:Post(...)
	local ResumePoints = self._ResumePoints

	for Point in pairs(ResumePoints) do
		local Resumed = typeof(Point) == "function" and Service._Call(Point, ...) or Service._Resume(Point, ...)

		ResumePoints[Point] = nil
	end
end

function Service:Revoke()
	self._CanListen = false

	Service.Subscriptions[self.Topic] = nil
end

function Service:_Resume(Thread, ...)
	coroutine.resume(Thread, ...)
end

function Service:_Call(Callback, ...)
	Callback(...)

	return Callback
end

return Service
