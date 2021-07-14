local Service = {Subscriptions = {}}
Service.__index = Service

function Service.Subscribe(Parameters)
    assert(Parameters, "Invalid parameters")
    local Topic = assert(Parameters.Topic, "Invalid topic")

    local Subscription = setmetatable({

        _WrapCalls = Parameters.WrapCalls,
        _ResumePoints = {},
        Topic = Topic,
        _CanListen = true

    }, Service)

    Service.Subscriptions[Topic] = Subscription
    return Subscription
end

function Service:Listen(Point, ...)
    assert(self._CanListen, "Forbidden from listenting to: " .. self.Topic)
    assert(Point, "Invalid resumption point")
    
    Point = ( typeof(Point) == "function" and self:_MakeCallback(Point) )
    
    self._ResumePoints[Point] = {}
    return Point or coroutine.yield()
end

function Service:Post(...)
    local ResumePoints = self._ResumePoints

    for Point in pairs(ResumePoints) do
        local Resumed = typeof(Point) == "function" and self:_Call(Point, ...) or self:_Resume(Point, ...)

        ResumePoints[Point] = nil
    end
end

function Service:Revoke(Topic)
    self._CanListen = false
    
    Service.Subscriptions[Topic] = nil
end

function Service:_Resume(Thread, ...)
    coroutine.resume(Thread, ...)
end

function Service:_Call(Callback, ...)
    Callback(...)

    return Callback
end

function Service:_MakeCallback(Callback)
    Callback = self._WrapCalls and coroutine.wrap(Callback) or Callback

    return Callback
end

return Service
