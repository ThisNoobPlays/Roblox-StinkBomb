-- Script by Minedani129
-- Change bomb settings here!
-- You can add more settings and code however much you like! If you want to contribute to the main source code look in BombScript for link

local bombSettings = {
  smokeColor = Color3.fromRGB(149, 85, 0), -- Color of smoke and blind GUI. Put in an RGB color code inside the parentheses.
  maxThrowDistance = 100, -- Maximum distance that the bomb can be thrown. Don't put over 200 because then it can fly across the map.
  bombColor = BrickColor.new("Dark stone grey"), -- The color of the bomb object. Set to a Roblox color name.
  bombVelocityMultiplier = 1.5 -- The amount of force used to throw the bomb. Higher number means farther throw. Recommended 1.5 - 2.0
  
}

return bombSettings
