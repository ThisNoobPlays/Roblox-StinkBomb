local function has(tab, val)
	for _, i in pairs(tab) do
		if i.Name == val then
			return true
		end
	end
	return false
end

while true do
	if has(game.Players.LocalPlayer.Character.Head:GetTouchingParts(), "StinkBombSmoke") then
		local beforeTime = os.clock()
		local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
		while os.clock() - beforeTime < 2 do
			humanoid.CameraOffset = Vector3.new(math.random(), math.random(), math.random())
			wait(0.05)
		end
		humanoid.CameraOffset = Vector3.new(0,0,0)	
	end
	wait()
end