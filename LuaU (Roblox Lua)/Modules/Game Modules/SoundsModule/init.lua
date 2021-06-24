--[[
	Name: SoundsModule.lua
--]]

local Sounds = require(script.Sounds) --// {Enum.Materials.SomeMaterial = "SomeSound"}

return {
	Start = function(Character)
		local Humanoid = Character:WaitForChild("Humanoid")
		local SoundPlayer = Character:WaitForChild("LowerTorso")
		local Sound = SoundPlayer.Concrete

		Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
			local MappedMaterial = Sounds[Humanoid.FloorMaterial] 
			local NewSound = MappedMaterial and SoundPlayer:FindFirstChild(MappedMaterial)

			if NewSound then
				NewSound.TimePosition = Sound.TimePosition
				NewSound.PlaybackSpeed = Sound.PlaybackSpeed

				NewSound.Playing = Sound.Playing
			end

			Sound.Playing = false
			Sound = NewSound or Sound
		end)

		Humanoid.Running:Connect(function(Speed)
			Sound.Playing = ( Speed > 0.1 )

			Sound.PlaybackSpeed = math.clamp(Speed / 9, 0.5, 2)
		end)
	end,
}
