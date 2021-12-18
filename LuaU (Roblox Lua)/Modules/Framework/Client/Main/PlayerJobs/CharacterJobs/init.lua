local module = {}

local common = game:GetService("ReplicatedStorage").Modules
local client = script

local jobs = {

	Local = {
		
	},

	Other = {
		
	}

}

local performer = require(client.Parent.Parent.JobUtil).new(jobs)

function module.Start(...)
	performer:PerformJobs("Start", ...)
end

function module.Stop(...)
	performer:PerformJobs("Stop", ...)
end

return module
