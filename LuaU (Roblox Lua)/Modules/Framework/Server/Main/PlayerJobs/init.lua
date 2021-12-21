local module = {}

local common = game:GetService("ReplicatedStorage").Modules
local server = script

local jobs = {

	server.CharacterJobs,

}

local performer = require(server.JobUtil).new(jobs)

function module.Start(...)
	performer:PerformJobs("Start", ...)
end

function module.Stop(...)
	performer:PerformJobs("Stop", ...)
end

return module
