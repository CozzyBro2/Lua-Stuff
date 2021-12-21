local module = {}

local common = game:GetService("ReplicatedStorage").Modules
local server = script

local jobs = {
	
}

local performer = require(server.Parent.JobUtil).new(jobs)

function module.Start(...)
	performer:PerformJobs("Start", ...)
end

function module.Stop(...)
	performer:PerformJobs("Stop", ...)
end

return module
