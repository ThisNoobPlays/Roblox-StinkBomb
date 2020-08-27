-- script by Minedani129
-- This script gives the stink bomb functionality

-- DO NOT name anything in PlayerGui or StarterGui to "StinkBomb" as it will cause conflicts!

local tool = script.Parent
local cameraInfoEvent = script.Parent.CameraInfo
local tweenService = game:GetService("TweenService")
local shakeEvent = script.Parent.ShakeEvent
local activationTimes = 0
local screenDebounce = false

local function makeScreen(player)
	if not screenDebounce and not player.PlayerGui:FindFirstChild("StinkBomb")then
		screenDebounce = true
		local screenGui = Instance.new("ScreenGui", player.PlayerGui)
		screenGui.Name = "StinkBomb"
		local frame = Instance.new("Frame", screenGui)
		local humanoid = player.Character.Humanoid
		frame.BackgroundColor3 = Color3.new(237, 201, 175)
		frame.BackgroundTransparency = 0.2
		frame.Size = UDim2.new(1, 0, 1, 0)
		local beforeTime = os.clock()
		shakeEvent:FireClient(player)
		wait(2)
		screenGui:Destroy()
		screenDebounce = false
	end
end

local function onEvent(player, hitPosition)
	if activationTimes == 0 then
		local startPos =  Vector3.new(tool.Handle.Position.X + 1, tool.Handle.Position.Y, tool.Handle.Position.Z)
		if (startPos - hitPosition).Magnitude < 100 then	
			script.Parent.Name = "StinkBomb (used)"	
			activationTimes = activationTimes + 1
			local grenade = Instance.new("Part")
			local grenadeMesh = script.Parent.Mesh:Clone()
			grenadeMesh.Parent = grenade
			grenade.Size = Vector3.new(0.54, 0.6, 0.55)
			grenade.Material = Enum.Material.Glass
			grenade.BrickColor = BrickColor.new("Dark stone grey")
			grenade.Parent = workspace
			grenade.Transparency = 0
			grenade.CFrame =  CFrame.new(startPos, hitPosition)
			grenade.Velocity = Vector3.new(hitPosition.X - startPos.X, hitPosition.Y - startPos.Y, hitPosition.Z - startPos.Z) * 1.5
			tool.Enabled = false
			wait(1.2)
			local stink = Instance.new("Part")
			stink.Parent = workspace
			stink.Name = "StinkBombSmoke"
			stink.Anchored = true
			stink.Position = grenade.Position
			stink.CanCollide = false
			stink.Transparency = 1
			stink.Shape = Enum.PartType.Ball
			stink.Size = Vector3.new(1,1,1)
			stink.BrickColor = BrickColor.new("Cool yellow")
			stink.Material = Enum.Material.Sand
			local smokeStink = Instance.new("Smoke", grenade)
			smokeStink.Color = Color3.fromRGB(149, 85, 0)
			smokeStink.Size = 15
			local sizeGoal = {}
			sizeGoal.Size = Vector3.new(30, 30, 30)
			local tweenInfo = TweenInfo.new(10)
			tweenService:Create(stink, tweenInfo, sizeGoal):Play()
			local touchedEvent = stink.Touched:Connect(function(part)
				if part.Parent:FindFirstChild("Humanoid") then
					local smokedPlayer = game.Players:GetPlayerFromCharacter(part.Parent)
					local sound = part.Parent.Head:FindFirstChild("Sound")
					makeScreen(smokedPlayer)
					if not sound then
						sound = Instance.new("Sound", part.Parent.Head)
						sound.SoundId = "rbxassetid://186581757"
					end
					if not sound.IsPlaying then
						sound.TimePosition = 2
						sound:Play()
					end
				end
			end)
			wait(5)
			local beforeWait = os.clock()
			while os.clock() - beforeWait < 17 do
				stink.Size = Vector3.new(30, 29.999, 30)
				wait()
				stink.Size = Vector3.new(30, 30, 30)
				wait()
			end
			touchedEvent:Disconnect()
			wait(5)
			smokeStink:Destroy()
			stink:Destroy()
			tool:Destroy()
		else
			print("Too far")
		end
	else
		print("Cannot use more than once")
	end
end

cameraInfoEvent.OnServerEvent:Connect(onEvent)