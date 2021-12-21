local module = {}
module.__index = module

function module.new(jobs)
	local performer = setmetatable({
		
		Jobs = jobs
		
	}, module)
	
	return performer
end

function module:PerformJobs(contentType, worker, isLocal)
	local jobs = self.Jobs
	local jobType = if isLocal then jobs.Local else jobs.Other

	for _, job in ipairs(jobType) do
		local content = require(job)

		-- NOTE: Jobs are executed in parallel --
		task.spawn(content[contentType], worker)
	end
end

return module
