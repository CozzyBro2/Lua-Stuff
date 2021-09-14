local module = {}
module.__index = module

function module.new()
	local signal = setmetatable({

		Connections = {}

	}, module)
	
	signal.__index = signal
	
	return signal
end

function module:Fire(...)
	for _, resume in pairs(self.Connections) do
		task.defer(resume, ...)
	end
end

function module:Connect(callback)
	assert(type(callback) == "function", "Expected function for argument 1")
	
	local connection = setmetatable({}, self)
	
	self.Connections[connection] = callback
	
	return connection
end

function module:Wait()
	table.insert(self.Connections, coroutine.running())

	return coroutine.yield()
end

function module:Disconnect()
	self.Connections[self] = nil
end

function module:Destroy()
	self.Connections = nil
end

return module
