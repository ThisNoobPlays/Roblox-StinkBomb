# Roblox-StinkBomb
A standalone stink bomb tool that you can put in Roblox Studio!
Originally developed for Theruvia.

# Usage
Go to the releases section and get the RBXM file which you can add to your game.

# Contribute
1. Clone repository
2. Edit any of the files:
- You can edit the script files using a text editor
- The BombMesh.mesh file contains a rbxassetid link that you can change 
- Handle is an RBXM file so you can edit it in Roblox Studio and save it again
- You do not need to edit the remoteEvents because they are just remoteEvents there as a placeholder

3. Make a pull request

If you want to convert the repository format to a Roblox object, follow these steps:
1. Make a new tool called "StinkBomb"
2. Make a new script inside StinkBomb and paste in BombScript.ServerScript.Lua
3. Make a new localscript inside StinkBomb and paste in CameraInfoScript.LocalScript.Lua
4. Make a new localscript inside StinkBomb and paste in ShakeHelper.LocalScript.lua
5. Add two RemoteEvents. One called "CameraInfoEvent", the other called "ShakeEvent"
6. Add the MeshPart from the Handle.rbxm file into StinkBomb
