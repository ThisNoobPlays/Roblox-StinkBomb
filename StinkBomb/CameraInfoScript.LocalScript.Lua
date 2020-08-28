-- Script by Minedani129
-- Sends mouse hit position and velocity increase to CameraInfo event for server script

-- You can modify this script however much you like! Contribute by going to the link in BombScript

local tool = script.Parent
local mouse = game.Players.LocalPlayer:GetMouse()


local function checkWall() -- Check if the target part appears to be a wall
  if mouse.Target.Size.Y > mouse.Target.Size.X or mouse.Target.Size.Y > mouse.Target.Size.Z then
    print("Wall detect")
    return true
  else
    return false
  end -- If statement
end -- Function

tool.Activated:Connect(function()
  local status, isWall = pcall(checkWall)
  if status and isWall then
    script.Parent.CameraInfo:FireServer(mouse.Hit.Position, 2)
  else
    script.Parent.CameraInfo:FireServer(mouse.Hit.Position, 0)
  end -- If statement
end) -- Function

