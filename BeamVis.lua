if(not owner)then
	getfenv().owner = script:FindFirstAncestorOfClass("Player") and script:FindFirstAncestorOfClass("Player") or game:GetService('Players'):GetPlayerFromCharacter(script:FindFirstAncestorOfClass("Model"))
end
if(game:GetService("RunService"):IsServer())then script.Parent = workspace end
local ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"

script:WaitForChild("Heartbeat")

local tf = 0
local allowframeloss = false
local tossremainder = false
local lastframe = tick()
local frame = 1/120
ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)
local visframes = {}
local numberofframes = 100
local partfold = Instance.new("Folder", workspace)
partfold.Name = "VisParts"..owner.Name
local id = 0
local vol = 1
local pit = 1
local tpos = 0
local size = 4
local b = Instance.new("Part",partfold)
b.Name = "Base"
b.Anchored = true
b.CanCollide = false
b.Size = Vector3.new(1,1,1)
b.Position = Vector3.new(0,5,0)
b.Transparency = 1
local beams = {}
local beams2 = {}
local visframes2 = {}
for i = 1,numberofframes do
	local a = Instance.new("Attachment",b)
	a.CFrame = CFrame.Angles(0,math.rad((i-1)*3.6),0)*CFrame.new(0,0,size)
	if(visframes[i-1])then
		local beam = Instance.new("Beam", a)
		beam.Attachment0 = visframes[i-1].self
		beam.Attachment1 = a
		beam.LightEmission = 1
		beam.LightInfluence = 1
		beam.Width0 = .3
		beam.Width1 = .3
		beams[i-1] = beam
	end
	visframes[i]={self = a, OrigCF = a.CFrame}
end
for i = 1, numberofframes do
	local a = Instance.new("Attachment",b)
	a.CFrame = CFrame.Angles(0,math.rad((i-1)*3.6),0)*CFrame.new(0,0,size)
	if(visframes2[i-1])then
		local beam = Instance.new("Beam", a)
		beam.Attachment0 = visframes[i-1].self
		beam.Attachment1 = a
		beam.LightEmission = 1
		beam.LightInfluence = 1
		beam.Width0 = .15
		beam.Width1 = .15
		beams2[i-1] = beam
	end
	visframes2[i]={self = a, OrigCF = a.CFrame}
end
local beam = Instance.new("Beam", visframes[1].self)
beam.Attachment0 = visframes[#visframes].self
beam.Attachment1 = visframes[1].self
beam.LightEmission = 1
beam.LightInfluence = 1
beam.Width0 = .3
beam.Width1 = .3
beams[#beams+1] = beam
local beam = Instance.new("Beam", visframes2[1].self)
beam.Attachment0 = visframes[#visframes].self
beam.Attachment1 = visframes2[1].self
beam.LightEmission = 1
beam.LightInfluence = 1
beam.Width0 = .15
beam.Width1 = .15
beams2[#beams+1] = beam
local mus = Instance.new("Sound", b)
mus.SoundId = "rbxassetid://"..id
mus.Volume = vol
mus.Pitch = pit
mus.TimePosition = tpos
mus.Name = "Music"
mus.Looped = true
mus:Play()
local loudness = 0
if(game:GetService("RunService"):IsServer())then
	if(game:GetService('ReplicatedStorage'):FindFirstChild(owner.Name.."FunnyVis"))then
		game:GetService('ReplicatedStorage')[owner.Name.."FunnyVis"]:Destroy()
	end
	local rem = Instance.new("RemoteEvent",game:GetService('ReplicatedStorage'))
	rem.Name = owner.Name.."FunnyVis"
	rem.OnServerEvent:Connect(function(player,pl)
		loudness = pl
	end)
	NLS([[if(not owner)then
		getfenv().owner = script:FindFirstAncestorOfClass("Player") and script:FindFirstAncestorOfClass("Player") or game:GetService('Players'):GetPlayerFromCharacter(script:FindFirstAncestorOfClass("Model"))
	end
	local rem = game:GetService('ReplicatedStorage'):WaitForChild(owner.Name.."FunnyVis")
	local Music = workspace:WaitForChild("VisParts"..owner.Name):WaitForChild("Base"):WaitForChild("Music")
	local hb
	hb = game:GetService('RunService').Heartbeat:Connect(function()
		Music = workspace:WaitForChild("VisParts"..owner.Name):WaitForChild("Base"):WaitForChild("Music")
		rem = game:GetService('ReplicatedStorage'):WaitForChild(owner.Name.."FunnyVis")
		if(not rem or not rem:IsDescendantOf(game:GetService('ReplicatedStorage')))then
			hb:Disconnect()
			script.Disabled = true
			script:Destroy()
			return
		end
		rem:FireServer(Music.PlaybackLoudness)
	end)]], owner.Character)
else
	local Music = workspace:WaitForChild("VisParts"..owner.Name):WaitForChild("Base"):WaitForChild("Music")
	local hb
	hb = game:GetService('RunService').Heartbeat:Connect(function()
		Music = workspace:WaitForChild("VisParts"..owner.Name):WaitForChild("Base"):WaitForChild("Music")
		loudness = Music.PlaybackLoudness
	end)
end
owner.Chatted:Connect(function(message)
	if(message:sub(1,3) == "id!")then
		id = tonumber(string.split(message,"!")[2])
	elseif message:sub(1,4) == "vol!" then
		vol = tonumber(string.split(message,"!")[2])
	elseif message:sub(1,4) == "pit!" then
		pit = tonumber(string.split(message,"!")[2])
	elseif message:sub(1,8) == "timepos!" then
		mus.TimePosition = tonumber(string.split(message,"!")[2])
	end
end)
ArtificialHB.Event:Connect(function()
	if(not mus or not mus:IsDescendantOf(b))then
		pcall(game.Destroy, mus)
		mus = Instance.new("Sound", b)
		mus.SoundId = "rbxassetid://"..id
		mus.Volume = vol
		mus.Pitch = pit
		mus.TimePosition = tpos
		mus.Name = "Music"
		mus.Looped = true
		mus:Play()
	end
	timepos = mus.TimePosition
	mus.SoundId = "rbxassetid://"..id
	mus.Volume = vol
	mus.Pitch = pit
	mus.Name = "Music"
	mus.Looped = true
	local rootpart = owner.Character:FindFirstChild("HumanoidRootPart")
	if(rootpart)then
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {owner.Character, partfold}
		local ray = workspace:Raycast(rootpart.Position, Vector3.new(0, -99999, 0), params)
		if(ray)then
			game:GetService("TweenService"):Create(b, TweenInfo.new(.5), {
				CFrame = CFrame.new(ray.Position, ray.Position + ray.Normal) * CFrame.Angles(math.rad(-90), math.rad((tick()*10)%360), 0)
			}):Play()
		end
	end
	for i,v in next, visframes do
		if(not mus)then
			return
		end
		local noise = math.noise((tick()%1)/(i/(#visframes*math.random(1,2))), loudness%1, 0)
		local col = math.clamp(loudness/400*(i/(#visframes*math.random(1,2))), .5, 1)
		local beam = beams[i-1]
		local beam2 = beams2[i-1]
		game:GetService("TweenService"):Create(v.self, TweenInfo.new(.5), {
			CFrame = v.OrigCF*CFrame.new(0,(noise > 0 and noise or -noise)*(loudness/50),0)
		}):Play()
		if(beam)then
			beam.Color = ColorSequence.new(beam.Color.Keypoints[1].Value:Lerp(Color3.fromHSV(tick()%1, col, col), .1))
			beam2.Color = ColorSequence.new(beam2.Color.Keypoints[1].Value:Lerp(Color3.fromHSV(tick()%1, col, col), .1))
		end
		if(i == #visframes)then
			beam = beams[#beams]
			beam2 = beams2[#beams2]
			beam.Color = ColorSequence.new(beam.Color.Keypoints[1].Value:Lerp(Color3.fromHSV(tick()%1, col, col), .1))
			beam2.Color = ColorSequence.new(beam2.Color.Keypoints[1].Value:Lerp(Color3.fromHSV(tick()%1, col, col), .1))
		end
	end
end)