local module = {}

local common = game:GetService("ReplicatedStorage").Modules
local client = script

local jobs = {

	Local = {
		client.CharacterJobs,
	},

	Other = {
		client.CharacterJobs,
	}

}

local performer = require(client.JobUtil).new(jobs)

function module.Start(...)
	performer:PerformJobs("Start", ...)
end

function module.Stop(...)
	performer:PerformJobs("Stop", ...)
end

return module
