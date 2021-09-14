local module = {}

local soundInstances = script:WaitForChild("SoundInstances")
local sounds = require(script.Sounds)
local connections = {}

local function GetSound(soundPlayer, material)
	local name = sounds[material] or "Air"
	
	return soundPlayer:FindFirstChild(name)
end

local function GiveSounds(soundPlayer)
	if soundPlayer:FindFirstChild("Air") then
		warn("Sounds exist for: " .. soundPlayer:GetFullName())
		
		return
	end
	
	for _, sound in ipairs(soundInstances:GetChildren()) do
		if sound:IsA("Sound") then
			sound:Clone().Parent = soundPlayer
		end
	end
end

function module.Start(character)
	local humanoid = character:WaitForChild("Humanoid")
	local soundPlayer = character:WaitForChild("LowerTorso")
	
	GiveSounds(soundPlayer)
	
	local theseConnections = {}
	local sound = GetSound(soundPlayer, humanoid.FloorMaterial)
	
	humanoid.Died:Connect(function()
		module.Stop(character)
	end)
	
	local function OnRunning(speed)
		sound.PlaybackSpeed = math.clamp(speed / 12.5, 0.5, 2)

		sound.Playing = (speed > 0.1)
	end
	
	local function OnMaterialChange()
		local newSound = GetSound(soundPlayer, humanoid.FloorMaterial)

		newSound.PlaybackSpeed = sound.PlaybackSpeed
		newSound.Playing = sound.Playing

		sound.Playing = false
		sound = newSound
	end
	
	table.insert(theseConnections, humanoid.Running:Connect(OnRunning))
	table.insert(theseConnections, humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(OnMaterialChange))
	
	connections[character] = theseConnections
end

function module.Stop(character)
	local toRemove = connections[character] 
	
	if toRemove then
		for _, connection in ipairs(toRemove) do
			connection:Disconnect()
		end
	end
end

return module
