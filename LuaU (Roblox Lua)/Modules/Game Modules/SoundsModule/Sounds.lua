--[[
	NOTE: This module is an auxillary table for the 'SoundModule' under this same folder. 
	This module is a table that maps material enums to sound strings, which later is used to reference sound objects.

	Name: Sounds.lua
--]]

local Materials = Enum.Material

return {
	--// Concrete
	
	[Materials.Brick] = "Concrete",
	[Materials.Concrete] = "Concrete",
	[Materials.Plastic] = "Concrete",
	[Materials.SmoothPlastic] = "Concrete",
	[Materials.Neon] = "Concrete",
	
	--// Dirt
	
	[Materials.CrackedLava] = "Dirt",
	[Materials.Foil] = "Dirt",
	[Materials.Ground] = "Dirt",
	[Materials.Mud] = "Dirt",
	[Materials.Pebble] = "Dirt",
	
	--// Fabric
	
	[Materials.Fabric] = "Fabric",
	[Materials.Glass] = "Fabric",
	
	--// Grass
	
	[Materials.LeafyGrass] = "Grass",
	[Materials.Grass] = "Grass",
	
	--// Gravel
	
	[Materials.Asphalt] = "Gravel",
	[Materials.Basalt] = "Gravel",
	[Materials.Cobblestone] = "Gravel",
	[Materials.Glacier] = "Gravel",
	[Materials.Granite] = "Gravel",
	[Materials.Rock] = "Gravel",
	[Materials.Salt] = "Gravel",
	[Materials.Slate] = "Gravel",
	
	--// Marble
	
	[Materials.ForceField] = "Marble",
	[Materials.Limestone] = "Marble",
	[Materials.Ice] = "Marble",
	[Materials.Marble] = "Marble",
	[Materials.Pavement] = "Marble",
	
	--// Metal
	
	[Materials.CorrodedMetal] = "Metal",
	[Materials.DiamondPlate] = "Metal",
	[Materials.Metal] = "Metal",
	
	--// Sand
	
	[Materials.Sand] = "Sand",
	[Materials.Sandstone] = "Sand",
	[Materials.Snow] = "Sand",
	
	--// Wood
	
	[Materials.Wood] = "Wood",
	[Materials.WoodPlanks] = "Wood"
}
