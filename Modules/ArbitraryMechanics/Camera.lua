local activeMode = require(game:GetService("ReplicatedStorage").Modules.GameInformation).CameraModes.Lax()
local frameRoutines = require(game.ReplicatedStorage.Modules.FrameRoutines)
local actionService = game:GetService("ContextActionService")

return {
	Start = function(primaryPart)
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		activeMode.ChangeSubject(primaryPart)
		
		actionService:BindAction("StepCamera", activeMode.Step, false, Enum.UserInputType.MouseMovement, Enum.UserInputType.Touch)
		table.insert(frameRoutines.RenderStepped, 1, activeMode.Update)
	end,
	
	Stop = function()
		table.remove(frameRoutines.RenderStepped, 1)
		actionService:UnbindAction("StepCamera")
	end,
	
	ChangeMode = function(newMode)
		activeMode = newMode
	end
}
