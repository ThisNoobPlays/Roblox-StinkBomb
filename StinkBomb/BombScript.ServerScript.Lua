-- script by Minedani129 / ThisNoobPlays
-- This script gives the stink bomb functionality

-- You can modify this script however much you like!
-- Help code and contribute by going to the Github page : https://github.com/ThisNoobPlays/Roblox-StinkBomb
-- Just edit any code or object, save the tool as an RBXM file, and make a pull request with it to have your improvements uploaded!
-- You can also make new issues if there is a bug or feature request.

-- DO NOT name anything in PlayerGui or StarterGui to "StinkBomb" as it will cause conflicts!

-- CONSTANTS --
local TOOL = script.Parent 
local CAMERA_INFO_EVENT = script.Parent.CameraInfo
local TWEENSERVICE = game:GetService("TweenService")
local SHAKE_EVENT = script.Parent.ShakeEvent
local SETTINGS = require(script.Parent.SettingsModule)

-- GLOBALS --
local activationTimes = 0
local screenDebounce = false


-- Function that makes a blind and shakes the screen
local function makeScreen(player)
  if not screenDebounce and not player.PlayerGui:FindFirstChild("StinkBomb") then
    screenDebounce = true
    local screenGui = Instance.new("ScreenGui", player.PlayerGui)
    screenGui.Name = "StinkBomb"
    local frame = Instance.new("Frame", screenGui)
    local humanoid = player.Character.Humanoid
    frame.BackgroundColor3 = SETTINGS.smokeColor
    frame.BackgroundTransparency = 0.2
    frame.Size = UDim2.new(1, 0, 1, 0)
    local beforeTime = os.clock()
    SHAKE_EVENT:FireClient(player)
    wait(2)
    screenGui:Destroy()
    screenDebounce = false
  end -- If statement
end -- Function


-- Main function that runs on tool activation
local function onEvent(player, hitPosition, velocityAddition)
  if activationTimes == 0 then
    local startPos =  Vector3.new(TOOL.Handle.Position.X + 1, TOOL.Handle.Position.Y, TOOL.Handle.Position.Z) -- Start position offset +1 x
    if (startPos - hitPosition).Magnitude < SETTINGS.maxThrowDistance then	-- Check if distance less than 100 studs      
      -- Bomb Object --
      TOOL.Name = "StinkBomb (used)"	
      activationTimes = activationTimes + 1 
      local grenade = Instance.new("Part", workspace)
      grenade.Name = "StinkBomb"
      local grenadeMesh = TOOL.BombMesh:Clone()
      grenadeMesh.Parent = grenade
      grenade.Size = Vector3.new(0.54, 0.6, 0.55)
      grenade.Material = Enum.Material.Glass
      grenade.BrickColor = BrickColor.new("Dark stone grey")
      grenade.Transparency = 0
      grenade.CFrame =  CFrame.new(startPos, hitPosition) -- Point bomb in direction of hit
      grenade.Velocity = Vector3.new(hitPosition.X - startPos.X, hitPosition.Y - startPos.Y, hitPosition.Z - startPos.Z) * (SETTINGS.bombVelocityMultiplier + velocityAddition) -- Throw the bomb (could use an upgrade)
      wait(1.2) -- Wait for the grenade to stop for a bit
   
      -- Smoke Collision Creation --
      local stink = Instance.new("Part", workspace)
      stink.Name = "StinkBombSmoke"
      stink.Anchored = true
      stink.Position = grenade.Position
      stink.CanCollide = false
      stink.Transparency = 1
      stink.Shape = Enum.PartType.Ball
      stink.Size = Vector3.new(1,1,1)
      
      -- Visible Smoke Creation --
      local smokeStink = Instance.new("Smoke", grenade)
      smokeStink.Color = SETTINGS.smokeColor
      smokeStink.Size = 15
      
      -- Smoke Collision Scale Up --
      local sizeGoal = {}
      sizeGoal.Size = Vector3.new(30, 30, 30)
      local tweenInfo = TweenInfo.new(10) -- Try to scale up with the same speed as the smoke does
      TWEENSERVICE:Create(stink, tweenInfo, sizeGoal):Play()
      local touchedEvent = stink.Touched:Connect(function(part) -- Run when a part collides with the smoke collision object
        if part.Parent:FindFirstChild("Humanoid") then 
          local smokedPlayer = game.Players:GetPlayerFromCharacter(part.Parent)
          local sound = part.Parent.Head:FindFirstChild("Sound") 
          makeScreen(smokedPlayer) -- Make a blind screen on player GUI
          if not sound then -- If sound doesnt exist, make it
            sound = Instance.new("Sound", part.Parent.Head)
            sound.SoundId = "rbxassetid://186581757"
          end -- If not sound then
          if not sound.IsPlaying then -- Play sound if it is not playing
            sound.TimePosition = 2
            sound:Play()
          end -- if not sound.Isplaying
        end -- if part.Parent:FindFirstChild("Humanoid)
      end) -- function
      
      wait(10) -- tweening is asynchronous so wait until the smoke collision grows to its full size
      
      -- Change the size minutely so collisions still work -- 
      local beforeWait = os.clock()
      while os.clock() - beforeWait < 17 do -- Repeat for 17 seconds
        stink.Size = Vector3.new(30, 29.999, 30)
        wait()
        stink.Size = Vector3.new(30, 30, 30)
        wait()
      end
      
      -- Destroy everything -- 
      touchedEvent:Disconnect()
      wait(2) -- Wait 2 seconds for any effects to clear 
      smokeStink:Destroy()
      stink:Destroy()
      TOOL:Destroy()
    else
      print("Too far")
    end
  else
    print("Cannot use more than once")
  end
end

CAMERA_INFO_EVENT.OnServerEvent:Connect(onEvent) -- Connect to main onEvent() function
