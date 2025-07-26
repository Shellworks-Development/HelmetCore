-- HelmetCore
-- Copyright (c) 2025, Shellworks Development
-- All rights reserved
-- Permission is hereby granted to any individual or entity ("You") to use, modify, and distribute this software (the "Software") solely for non-commercial purposes

local HelmetCore = {}
local UserInputService = game:GetService("UserInputService")

function SetupFakeHead(Head: BasePart, Camera: Camera)
	--[[
		SetupFakeHead(Head: BasePart, Camera: Camera)
		Creates a fake head model in the camera for rendering purposes.
		Head is the original head part, and Camera is the camera to attach the fake head to.
	]]

	-- We check if the Head is a BasePart and Camera is a Camera
	-- to ensure that the function is used correctly.
	assert(Head:IsA("BasePart"), "Argument #1 must be a BasePart")
	assert(Camera:IsA("Camera"), "Argument #2 must be a Camera")

	-- Make it invisible
	Head.Transparency = 1

	-- Setup FakeHead or update existing one
	local FakeHead = Camera:FindFirstChild("FakeHead") or Instance.new("Model", Camera)
	FakeHead.Name = "FakeHead"
	FakeHead:ClearAllChildren()

	-- Clone head and parent to FakeHead
	local HeadClone = Head:Clone()
	HeadClone.CollisionGroup = "ViewModel"
	HeadClone.CanCollide = false
	HeadClone.Transparency = 0
	HeadClone.Parent = FakeHead

	-- I'm not sure why this is necessary, but it seems to be
	-- to ensure the head is rendered correctly in the camera.
	for _, child in ipairs(HeadClone:GetChildren()) do
		if child:IsA("Weld") then
			local clone = child.Part1:Clone()
			clone.LocalTransparencyModifier = 0
			clone.CanCollide = false
			child.Part1:Destroy()
			part:FindFirstChildOfClass("Weld"):Destroy()
			child.Part1 = clone
			clone.Parent = FakeHead
		end
	end

	-- Hide all other parts in the original head
	for _, descendant in pairs(Head:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Transparency = 1
		end
	end
end

function RenderLoop(Camera: Camera, Vector: Vector3, Head: BasePart, XOffset: number, MouseState: Enum.MouseBehavior)
	--[[
		RenderLoop(Camera: Camera, Vector: Vector3, Head: BasePart, XOffset: number, MouseState: Enum.MouseBehavior)
		This function is intended to be called every frame to update the camera's view.
		It should be connected to the RenderStepped event of the RunService.
	]]

	-- Standard checks to ensure the arguments are correct
	assert(Camera:IsA("Camera"), "Argument #1 must be a Camera")
	assert(typeof(Vector) == "Vector3", "Argument #2 must be a Vector3")
	assert(Head:IsA("BasePart"), "Argument #3 must be a BasePart")
	assert(type(XOffset) == "number", "Argument #4 must be a number")
	assert(
		MouseState == Enum.MouseBehavior.Default or MouseState == Enum.MouseBehavior.LockCenter,
		"Argument #5 must be Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter"
	)

	-- Ensure the MouseBehavior is set to the correct type
	if UserInputService.MouseBehavior ~= MouseState then
		UserInputService.MouseBehavior = MouseState
	end

	-- XOffset isn't here because it's independant (kinda)
	local YOffset = Vector.Y
	local ZOffset = Vector.Z
	local FakeHead = Camera:FindFirstChild("FakeHead")
	assert(FakeHead, "FakeHead must be set up before calling RenderLoop")

	-- Update the camera's CFrame based on the head's position and the offsets
	Camera.CFrame = (Head.CFrame * CFrame.new(Vector3.new(XOffset, YOffset, ZOffset)))
	FakeHead.CFrame = Camera.CFrame * CFrame.new(-XOffset, -YOffset, -ZOffset)
end

return HelmetCore
