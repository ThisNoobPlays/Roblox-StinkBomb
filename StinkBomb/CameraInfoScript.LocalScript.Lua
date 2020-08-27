-- Script by Minedani129
-- Sends mouse hit to CameraInfo event for server script

local tool = script.Parent

tool.Activated:Connect(function()
	script.Parent.CameraInfo:FireServer(game.Players.LocalPlayer:GetMouse().Hit.Position)
end)

