local Service = {Subscriptions = {}}
Service.__index = Service

function Service.new(Parameters)
	assert(type(Parameters) == "table", "Expected parameters table")
	assert(type(Parameters.Topic) == "string", "Expected string topic parameter")

	local Subscription = setmetatable({

		_WrapCalls 		= Parameters.WrapCalls,
		_ResumePoints   = {},
		_CanListen 		= true,
		Topic 			= Parameters.Topic,

	}, Service)

	return Subscription
end

function Service:Connect(Callback)
	assert(type(Callback) == "function", "Expected type 'function'")
	
	self._ResumePoints[Callback] = {}
end

function Service:Wait()
	self._ResumePoints[coroutine.running()] = {}

	return coroutine.yield()
end
	
function Service:Post(...)
	local ResumePoints = self._ResumePoints

	for Point in pairs(ResumePoints) do
		local Resumed = type(Point) == "function" and Service._Call(Point, ...) or Service._Resume(Point, ...)

		ResumePoints[Point] = nil
	end
end

function Service:Revoke()
	self._CanListen = false
	
	self = nil
end

function Service:Destroy()
	
end

function Service:_Resume(Thread, ...)
	coroutine.resume(Thread, ...)
end

function Service:_Call(Callback, ...)
	Callback = self._WrapCalls and coroutine.wrap(Callback) or Callback
   
	Callback(...)
	
	return Callback
end

return Service
