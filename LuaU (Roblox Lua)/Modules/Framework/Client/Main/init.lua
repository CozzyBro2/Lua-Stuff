local playerService = game:GetService("Players")

local jobs = require(script.PlayerJobs)
local client = playerService.LocalPlayer

task.spawn(jobs.Start, client, true)

for _, player in ipairs(playerService:GetPlayers()) do
	task.spawn(jobs.Start, player)
end

playerService.PlayerAdded:Connect(jobs.Start)
playerService.PlayerRemoving:Connect(jobs.Stop)
