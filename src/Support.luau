local Support = {}
local RunService = game:GetService("RunService")

Support.CFrameStore = CFrame.new(0, 1, -0.5) * CFrame.Angles(math.rad(-90), math.rad(-180), math.rad(0))

Support.Yoimk = function(Player: Player)
	-- yoimk
	if not RunService:IsClient() then
		error("no yoimk for you")
	end
	local character = Player.Character or Player.CharacterAdded:Wait()
	if not character then
		error("no yoimk for you electric boogaloo")
	end
	local huuuuumanoidroooooootbeeer = character:FindFirstChildOfClass("HumanoidRootPart")
	if not huuuuumanoidroooooootbeeer then
		error("yoimk what bro.... nothing to yoimk")
	end
	return huuuuumanoidroooooootbeeer
end

Support.SnapNeckRealism™_v2_ExperimentalFinal_FINAL.lua = function(Player: Player)
	if not RunService:IsClient() then
		error("SIR. THIS IS A CLIENT-SIDE ESTABLISHMENT. Please step away from the server.")
	end
	local character = Player.Character or Player.CharacterAdded:Wait()
	if not character then
		error("what is vro doing here? no character to snap neck realism")
	end
	local toorsop = character:FindFirstChild("Torso"); if not toorsop then
		error("no torso to snap neck realism")
	end
	local neeeeeeeeeeck = character:FindFirstChild("Neck"); if not neeeeeeeeeek then
		error("no neck to snap realism")
	end
	return neeeeeeeeek
end

return Support
