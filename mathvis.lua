if(not owner)then
	getfenv().owner = script.Parent:IsA("PlayerGui") and script.Parent.Parent or game:GetService('Players'):GetPlayerFromCharacter(script.Parent)
end

local size = 10
local div = 15

local func = "sin"
local attachments = {}
local part = Instance.new("Part", workspace)
part.Anchored = true
part.CanCollide = false
part.Transparency = .5
part.Size = Vector3.new(size,1,1)
part.Position = owner.Character:WaitForChild("HumanoidRootPart").Position

function start(func)
	part:ClearAllChildren()
	attachments = {}
	local snd = Instance.new("Sound", part)
	snd.SoundId = "rbxassetid://9085536418"
	snd.Volume = 1
	snd.Looped = true
	for i = 1, size*div do
		local a = Instance.new("Attachment", part)
		local funct = (func)(i/div)
		a.Position = Vector3.new((-size/2)+i/div, funct, 0)
		snd.Pitch = 0.5+(funct > 0 and funct or -funct)
		snd:Resume()
		if(attachments[#attachments-1])then
			local beam = Instance.new("Beam", a)
			beam.Attachment0 = attachments[#attachments-1]
			beam.Attachment1 = a
			beam.LightEmission = 1
			beam.Width0 = .3
			beam.Width1 = .3
		end
		table.insert(attachments, a)
		task.wait()
	end
	snd:Destroy()
end

owner.Chatted:Connect(function(msg)
	local args = string.split(msg, "!")
	if(args[1] == "start")then
		start(loadstring("return function(x) return "..args[2].." end")())
	end
end)