--[[
	Name: FootstepController.lua
--]]

local Module = {}
Module.__index = Module

local StepMap = require(script.StepMap)

function Module.new(Character)
	local self do
		local Humanoid = assert(Character:WaitForChild("Humanoid", 2), "Null humanoid")
		local Player   = assert(Character:WaitForChild("LowerTorso", 2):FindFirstChild("Sounds"), "Null sound player")

		self = setmetatable({

			_Humanoid = Humanoid,
			_Player   = Player,
			_Run	  = Instance.new("Sound"),
			Jump 	  = Character:GetAttribute("Jump"),
			Fall	  = Character:GetAttribute("Fall"),
			Land	 = Character:GetAttribute("Land"),

			Connections = {
				_Running = Humanoid.Running:Connect(function(...)
					self:Running(...)
				end),

				_Jumping = Humanoid.Jumping:Connect(function(...)
					self:Jumping(...)
				end),

				_Falling = Humanoid.FreeFalling:Connect(function(...)
					self:FreeFalling(...)
				end),
				
				_FloorMaterial = Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
					self:MaterialChanged(self._Humanoid.FloorMaterial.Name)
				end)
			}

		}, Module)
	end
	
	self:MaterialChanged(self._Humanoid.FloorMaterial.Name)
	
	return self
end


function Module:Running(Speed)
	self._Run.Playing = ( Speed > 0.1 )
end

function Module:Jumping(IsJumping)
	
end

function Module:FreeFalling(IsFalling)
	
end

function Module:MaterialChanged(Name)
	local Material   	= StepMap[Name] 
	local MaterialSound = Material and self._Player:FindFirstChild(Material)
	local IsPlaying     = self._Run.Playing
	
	self._Run.Playing = false
	
	if MaterialSound then
		self._Run = MaterialSound
		
		self._Run.Playing = IsPlaying
	end
end

function Module:Destroy()
	for _, Connection in pairs(self.Connections) do
		Connection:Disconnect()
	end
end

return Module
