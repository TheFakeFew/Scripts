game:GetService("JointsService"):ClearAllChildren()

local plrr = owner 
local plname = plrr.Name
-- Project Glitcher by Ietahuoy
wait(1/60)
script.Parent=nil

local charr = plrr.Character
local MainPosition=CFrame.new(0,0,0)
if charr and charr:FindFirstChildOfClass("Part") then
	MainPosition = charr:FindFirstChildOfClass("Part").CFrame
elseif workspace:FindFirstChildOfClass("Part") and charr==nil then
	MainPosition = workspace:FindFirstChildOfClass("Part").CFrame*CFrame.new(0,2,0)
else
	MainPosition = CFrame.new(0,4,0)
end
local accs = {}	local f = nil local face = nil local name = ""
if charr then
	name = charr.Name
	for _, acc in pairs(charr:GetDescendants()) do
        pcall(function()
	    	if acc:IsA'Accessory' or acc:IsA'Hat' or acc:IsA'BodyColors' or acc:IsA'Shirt' or acc:IsA'Pants' or acc:IsA'ShirtGraphic' or acc:IsA'CharacterMesh' then 
	    		table.insert(accs,acc:Clone()) 
	    	elseif acc:IsA'Part' and acc.Name == "Head" and acc:FindFirstChildOfClass'Decal' then
	    		f = acc:FindFirstChildOfClass'Decal'.Texture
	    	end
        end)
	end
end

local sn = 0
local attacking = false
local repeatkey = false
local repeatmouse = false
local Neck=CFrame.new(0,0,0)
local Torso=CFrame.new(0,0,0)
local LeftArm=CFrame.new(0,0,0)
local RightArm=CFrame.new(0,0,0)
local LeftLeg=CFrame.new(0,0,0)
local RightLeg=CFrame.new(0,0,0)
function InstanceNW(typp,anth)
	local part = Instance.new(typp)
	if anth ~= nil then for i,v in next, anth do pcall(function() part[i] = v end) end end
	return part
end
function alerp(tble,animspeed)
	Torso=Torso:Lerp(tble[1],animspeed)
	Neck=Neck:Lerp(tble[2],animspeed)
	LeftArm=LeftArm:Lerp(tble[3],animspeed)
	RightArm=RightArm:Lerp(tble[4],animspeed)
	LeftLeg=LeftLeg:Lerp(tble[5],animspeed)
	RightLeg=RightLeg:Lerp(tble[6],animspeed)
end
local mode = 1
local lastmode = math.random(2,5)
local flymode = false
local wings = true
local maincolor = Color3.fromRGB(155,15,15)
local maincolor2 = Color3.fromRGB(0,0,0)
local stoped = false
local W,A,S,D=false,false,false,false
local fallingspeed = 0
local falling = true
local stopeffects = false
local Ignores = {}
local walkspeed = 0.22 local CCF=nil
local goreSounds = {3739362156,4459576935,3739364168,4459571224,4459570664,4459572763,4459571342,4459571443,4459573960,3847883680,3929462189,3739335394,3929462677}
local acidburnSounds = {3755119951,3755119738,3755119108}
local swooshSounds = {3932508290,3755637386,3755637186,3755636992,3932507990,3755636825,3755636638,3755636438}
local MainModel = Instance.new("Model",workspace) MainModel.Name = name MainModel.Archivable=true
local EffectModel = Instance.new("Model",MainModel) EffectModel.Name = "EffectModel" MainModel.Archivable=true
local h=Instance.new("Part",MainModel)h.Size=Vector3.new(2,1,1)h.Color=Color3.new() h.Transparency=0 h.Anchored=true h.CanCollide=true h.Name="Head"
local m=Instance.new("SpecialMesh",h)m.MeshType="Head"m.Scale=Vector3.new(1.25,1.25,1.25)
local t=Instance.new("Part",MainModel)t.Material="Plastic"t.Size=Vector3.new(2,2,1)t.Color=Color3.new() t.Transparency=0 t.Anchored=true t.CanCollide=true t.Name="Torso"
local ll=Instance.new("Part",MainModel)ll.Material="Plastic"ll.Size=Vector3.new(1,2,1)ll.Color=Color3.new() ll.Transparency=0 ll.Anchored=true ll.CanCollide=true ll.Name="Left Leg"
local rl=Instance.new("Part",MainModel)rl.Material="Plastic"rl.Size=Vector3.new(1,2,1)rl.Color=Color3.new() rl.Transparency=0 rl.Anchored=true rl.CanCollide=true rl.Name="Right Leg"
local la=Instance.new("Part",MainModel)la.Material="Plastic"la.Size=Vector3.new(1,2,1)la.Color=Color3.new() la.Transparency=0 la.Anchored=true la.CanCollide=true la.Name="Left Arm"
local ra=Instance.new("Part",MainModel)ra.Material="Plastic"ra.Size=Vector3.new(1,2,1)ra.Color=Color3.new() ra.Transparency=0 ra.Anchored=true ra.CanCollide=true ra.Name="Right Arm"
local hum=Instance.new("Humanoid",MainModel) hum.Name = "" hum.HealthDisplayType = "AlwaysOff"
local hairat = Instance.new("Attachment") hairat.Parent = h hairat.Position = Vector3.new(0,0.6,0) hairat.Name = "HairAttachment"
local hatat = Instance.new("Attachment") hatat.Parent = h hatat.Position = Vector3.new(0,0.6,0) hatat.Name = "HatAttachment"
local ffat = Instance.new("Attachment") ffat.Parent = h ffat.Position = Vector3.new(0,0,-0.6) ffat.Name = "FaceFrontAttachment"
local fcat = Instance.new("Attachment") fcat.Parent = h fcat.Position = Vector3.new(0,0,0) fcat.Name = "FaceCenterAttachment"
local bbat = Instance.new("Attachment") bbat.Parent = t bbat.Position = Vector3.new(0,0,0.5) bbat.Name = "BodyBackAttachment"
local bfat = Instance.new("Attachment") bfat.Parent = t bfat.Position = Vector3.new(0,0,-0.5) bfat.Name = "BodyFrontAttachment"
local lcat = Instance.new("Attachment") lcat.Parent = t lcat.Position = Vector3.new(-1,1,0) lcat.Name = "LeftCollarAttachment"
local necat = Instance.new("Attachment") necat.Parent = t necat.Position = Vector3.new(0,1,0) necat.Name = "NeckAttachment"
local rcat = Instance.new("Attachment") rcat.Parent = t rcat.Position = Vector3.new(1,1,0) rcat.Name = "RightCollarAttachment"
local wbat = Instance.new("Attachment") wbat.Parent = t wbat.Position = Vector3.new(0,-1,0.5) wbat.Name = "WaistBackAttachment"
local wcat = Instance.new("Attachment") wcat.Parent = t wcat.Position = Vector3.new(0,-1,0) wcat.Name = "WaistCenterAttachment"
local wfat = Instance.new("Attachment") wfat.Parent = t wfat.Position = Vector3.new(0,-1,-0.5) wfat.Name = "WaistFrontAttachment"
local wfat = Instance.new("Attachment") wfat.Parent = ll wfat.Position = Vector3.new(0,-1,0) wfat.Name = "LeftFootAttachment"
local wfat = Instance.new("Attachment") wfat.Parent = rl wfat.Position = Vector3.new(0,-1,0) wfat.Name = "RightFootAttachment"
local wfat = Instance.new("Attachment") wfat.Parent = ra wfat.Position = Vector3.new(0,1,0) wfat.Name = "RightShoulderAttachment"
local wfat = Instance.new("Attachment") wfat.Parent = ra wfat.Position = Vector3.new(0,-1,0) wfat.Name = "RightGripAttachment"
local wfat = Instance.new("Attachment") wfat.Parent = la wfat.Position = Vector3.new(0,1,0) wfat.Name = "LeftShoulderAttachment"
local wfat = Instance.new("Attachment") wfat.Parent = la wfat.Position = Vector3.new(0,-1,0) wfat.Name = "LeftGripAttachment"
local cam = Instance.new("Part",workspace) cam.Name = "<["..plrr.Name.."]>" cam.Anchored=true cam.CanCollide=false cam.Transparency=1 cam.Size=Vector3.new()
local playmus = true local musid=13048663695 local mus = Instance.new("Sound") mus.Volume = 0.5 mus.Pitch = 1 mus.EmitterSize = 50 mus.SoundId = "rbxassetid://"..musid mus.Parent = t mus.Playing = playmus mus.Looped = true
local muspos = nil muspos = mus.TimePosition local fixmus = false
local EventBackup = Instance.new("RemoteEvent")
EventBackup.Name = "InputEventFrom"..plrr.Name
local CamBackup = Instance.new("RemoteEvent")
CamBackup.Name = "CamEventFrom"..plrr.Name
local EventBackupC = EventBackup:Clone()
local CamBackupC = CamBackup:Clone()

local input = NLS([[local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Event = game:GetService("JointsService"):WaitForChild("InputEventFrom"..Player.Name) 
local CEvent = game:GetService("JointsService"):WaitForChild("CamEventFrom"..Player.Name) 
local UIS = game:GetService("UserInputService")
local h,t = Mouse.Hit,Mouse.Target
local input = function(io,a)
    if a then return end
    local io = {KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState}
    Event:FireServer(io)
end
UIS.InputBegan:Connect(input)
UIS.InputEnded:Connect(input)
while wait() do
	CEvent:FireServer(workspace.Camera.CoordinateFrame)
	local cam = workspace.Camera
	cam.CameraSubject = workspace:FindFirstChild("<["..Player.Name.."]>")
	cam.CameraType = "Custom"
	cam.HeadLocked = true
	cam.HeadScale = 1
	cam.FieldOfView = 70   
	if h~=Mouse.Hit or t~=Mouse.Target then
        Event:FireServer({isMouse=true,Target=Mouse.Target,Hit=Mouse.Hit})
        h,t=Mouse.Hit,Mouse.Target
    end
end]], plrr:WaitForChild("PlayerGui"))

local InputEvent = Instance.new("RemoteEvent")
InputEvent.Name = "InputEventFrom"..plrr.Name
InputEvent.Parent = game:GetService("JointsService")
local CamEvent = Instance.new("RemoteEvent")
CamEvent.Name = "CamEventFrom"..plrr.Name
CamEvent.Parent = game:GetService("JointsService")
CamEvent.OnServerEvent:Connect(function(plr, e)
	CCF=e
end)
local CAS = {Actions={}}
local fakeEvent = function()
	local t = {_fakeEvent=true}
	t.Connect = function(self,f)self.Function=f end
	t.connect = t.Connect
	return t
end
local m = {Target=nil,Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent()}
local UIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}
function CAS:BindAction(name,fun,touch,...)
	CAS.Actions[name] = {Name=name,Function=fun,Keys={...}}
end
function CAS:UnbindAction(name)
	CAS.Actions[name] = nil
end
local function te(self,ev,...)
	local t = m[ev]
	if t and t._fakeEvent and t.Function then
		t.Function(...)
	end
end
local Mouse,mouse,UserInputService,ContextActionService
do
	m.TrigEvent = te
	UIS.TrigEvent = te
	InputEvent.OnServerEvent:Connect(function(plr,io)
		if plr~=plrr then return end
		if io.isMouse then
			m.Target = io.Target
			m.Hit = io.Hit
		elseif io.UserInputType == Enum.UserInputType.MouseButton1 then
			if io.UserInputState == Enum.UserInputState.Begin then
				m:TrigEvent("Button1Down")
			else
				m:TrigEvent("Button1Up")
			end
		else
			for n,t in pairs(CAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			if io.UserInputState == Enum.UserInputState.Begin then
				m:TrigEvent("KeyDown",io.KeyCode.Name:lower())
				UIS:TrigEvent("InputBegan",io,false)
			else
				m:TrigEvent("KeyUp",io.KeyCode.Name:lower())
				UIS:TrigEvent("InputEnded",io,false)
			end
		end
	end)
	Mouse,mouse,UserInputService,ContextActionService,mausee = m,m,UIS,CAS,m
end
function EndScript() script:ClearAllChildren() script.Disabled = true script:Destroy() stoped=true EventBackup:Destroy() CamBackupC:Destroy() EventBackupC:Destroy() pcall(function() game:GetService("JointsService")["InputEventFrom"..plrr.Name]:Destroy() game:GetService("JointsService")["CamEventFrom"..plrr.Name]:Destroy() end) end 
function onChatted(msg) if (msg == ".Stop" or msg == ".stop" or msg == "/e .Stop" or msg == "/e .stop" or msg == "/e get/nog sr" or msg == "get/nog sr") then EndScript() end end 
plrr.Chatted:connect(onChatted)
game.Players.PlayerAdded:Connect(function(p) if p.Name==plrr.Name then p.Chatted:connect(onChatted) end end)
table.insert(Ignores,MainModel)table.insert(Ignores,EffectModel)table.insert(Ignores,cam)
function system()
	game:GetService("RunService").Heartbeat:Connect(function() sn=sn+(1/2) 
		if stoped == false then
			if game.Players:FindFirstChild(plrr.Name) then plrr=game.Players:FindFirstChild(plrr.Name) end
			if game.Players:FindFirstChild(plrr.Name) and plrr.Character then local ch = plrr.Character plrr.Character=nil ch:Destroy() end
			if MainModel == nil or MainModel.Parent ~= workspace or MainModel.Parent == nil or not MainModel then
				MainModel = Instance.new("Model",workspace) MainModel.Name = name MainModel.Archivable=true
				EffectModel = Instance.new("Model",MainModel) EffectModel.Name = "EffectModel" MainModel.Archivable=true
				table.insert(Ignores,MainModel)table.insert(Ignores,EffectModel)
			end
			if EffectModel == nil or EffectModel.Parent ~= MainModel or EffectModel.Parent == nil or not EffectModel then
				EffectModel = Instance.new("Model",MainModel) EffectModel.Name = "EffectModel" MainModel.Archivable=true
				table.insert(Ignores,EffectModel)
			end
			if cam == nil or cam.Parent ~= workspace or cam.Parent == nil or not cam then
				cam = Instance.new("Part",workspace) cam.Name = "<["..plrr.Name.."]>" cam.Anchored=true cam.CanCollide=false cam.Transparency=1 cam.Size=Vector3.new()
				table.insert(Ignores,cam)
			end
			if h == nil or h.Parent ~= MainModel or h.Parent == nil or not h then
				h=Instance.new("Part",MainModel)h.Size=Vector3.new(2,1,1)h.Color=Color3.new() h.Transparency=0 h.Anchored=true h.CanCollide=true h.Name="Head"
				local m=Instance.new("SpecialMesh",h)m.MeshType="Head"m.Scale=Vector3.new(1.25,1.25,1.25) 
				local hairat = Instance.new("Attachment") hairat.Parent = h hairat.Position = Vector3.new(0,0.6,0) hairat.Name = "HairAttachment"
				local hatat = Instance.new("Attachment") hatat.Parent = h hatat.Position = Vector3.new(0,0.6,0) hatat.Name = "HatAttachment"
				local ffat = Instance.new("Attachment") ffat.Parent = h ffat.Position = Vector3.new(0,0,-0.6) ffat.Name = "FaceFrontAttachment"
				local fcat = Instance.new("Attachment") fcat.Parent = h fcat.Position = Vector3.new(0,0,0) fcat.Name = "FaceCenterAttachment"		
				if MainModel:FindFirstChildOfClass("BodyColors") then MainModel:FindFirstChildOfClass("BodyColors"):Destroy() end
			end
			if t == nil or t.Parent ~= MainModel or t.Parent == nil or not t then
				t=Instance.new("Part",MainModel)t.Material="Plastic"t.Size=Vector3.new(2,2,1)t.Color=Color3.new() t.Transparency=0 t.Anchored=true t.CanCollide=true t.Name="Torso"
				local bbat = Instance.new("Attachment") bbat.Parent = t bbat.Position = Vector3.new(0,0,0.5) bbat.Name = "BodyBackAttachment"
				local bfat = Instance.new("Attachment") bfat.Parent = t bfat.Position = Vector3.new(0,0,-0.5) bfat.Name = "BodyFrontAttachment"
				local lcat = Instance.new("Attachment") lcat.Parent = t lcat.Position = Vector3.new(-1,1,0) lcat.Name = "LeftCollarAttachment"
				local necat = Instance.new("Attachment") necat.Parent = t necat.Position = Vector3.new(0,1,0) necat.Name = "NeckAttachment"
				local rcat = Instance.new("Attachment") rcat.Parent = t rcat.Position = Vector3.new(1,1,0) rcat.Name = "RightCollarAttachment"
				local wbat = Instance.new("Attachment") wbat.Parent = t wbat.Position = Vector3.new(0,-1,0.5) wbat.Name = "WaistBackAttachment"
				local wcat = Instance.new("Attachment") wcat.Parent = t wcat.Position = Vector3.new(0,-1,0) wcat.Name = "WaistCenterAttachment"
				local wfat = Instance.new("Attachment") wfat.Parent = t wfat.Position = Vector3.new(0,-1,-0.5) wfat.Name = "WaistFrontAttachment"	
				if MainModel:FindFirstChildOfClass("BodyColors") then MainModel:FindFirstChildOfClass("BodyColors"):Destroy() end
			end
			if ll == nil or ll.Parent ~= MainModel or ll.Parent == nil or not ll then
				ll=Instance.new("Part",MainModel)ll.Material="Plastic"ll.Size=Vector3.new(1,2,1)ll.Color=Color3.new() ll.Transparency=0 ll.Anchored=true ll.CanCollide=true ll.Name="Left Leg"
				local wfat = Instance.new("Attachment") wfat.Parent = ll wfat.Position = Vector3.new(0,-1,0) wfat.Name = "LeftFootAttachment"
				if MainModel:FindFirstChildOfClass("BodyColors") then MainModel:FindFirstChildOfClass("BodyColors"):Destroy() end
			end
			if rl == nil or rl.Parent ~= MainModel or rl.Parent == nil or not rl then
				rl=Instance.new("Part",MainModel)rl.Material="Plastic"rl.Size=Vector3.new(1,2,1)rl.Color=Color3.new() rl.Transparency=0 rl.Anchored=true rl.CanCollide=true rl.Name="Right Leg"
				local wfat = Instance.new("Attachment") wfat.Parent = rl wfat.Position = Vector3.new(0,-1,0) wfat.Name = "RightFootAttachment"
				if MainModel:FindFirstChildOfClass("BodyColors") then MainModel:FindFirstChildOfClass("BodyColors"):Destroy() end
			end
			if la == nil or la.Parent ~= MainModel or la.Parent == nil or not la then
				la=Instance.new("Part",MainModel)la.Material="Plastic"la.Size=Vector3.new(1,2,1)la.Color=Color3.new() la.Transparency=0 la.Anchored=true la.CanCollide=true la.Name="Left Arm"
				local wfat = Instance.new("Attachment") wfat.Parent = la wfat.Position = Vector3.new(0,1,0) wfat.Name = "LeftShoulderAttachment"
				local wfat = Instance.new("Attachment") wfat.Parent = la wfat.Position = Vector3.new(0,-1,0) wfat.Name = "LeftGripAttachment"
				if MainModel:FindFirstChildOfClass("BodyColors") then MainModel:FindFirstChildOfClass("BodyColors"):Destroy() end
			end
			if ra == nil or ra.Parent ~= MainModel or ra.Parent == nil or not ra then
				ra=Instance.new("Part",MainModel)ra.Material="Plastic"ra.Size=Vector3.new(1,2,1)ra.Color=Color3.new() ra.Transparency=0 ra.Anchored=true ra.CanCollide=true ra.Name="Right Arm"
				local wfat = Instance.new("Attachment") wfat.Parent = ra wfat.Position = Vector3.new(0,1,0) wfat.Name = "RightShoulderAttachment"
				local wfat = Instance.new("Attachment") wfat.Parent = ra wfat.Position = Vector3.new(0,-1,0) wfat.Name = "RightGripAttachment"		
				if MainModel:FindFirstChildOfClass("BodyColors") then MainModel:FindFirstChildOfClass("BodyColors"):Destroy() end
			end 
			if h:FindFirstChildOfClass("SpecialMesh")==nil then
				local m=Instance.new("SpecialMesh",h)m.MeshType="Head"m.Scale=Vector3.new(1.25,1.25,1.25)
			end
			if hum == nil or hum.Parent ~= MainModel or hum.Parent == nil or not hum then
				hum=Instance.new("Humanoid",MainModel) hum.Name = "" hum.HealthDisplayType = "AlwaysOff"
			end
			if face == nil or face.Parent ~= h or face.Parent == nil or not face then
				face = InstanceNW("Decal",{Parent=h,Face="Front",Texture=f})
			end
			if MainModel:FindFirstChildOfClass("Accessory") == nil then for i=1,#accs do if accs[i]:IsA'Accessory' then accs[i]:Clone().Parent=MainModel end end end
			if MainModel:FindFirstChildOfClass("Hat") == nil then for i=1,#accs do if accs[i]:IsA'Hat' then accs[i]:Clone().Parent=MainModel end end end
			if MainModel:FindFirstChildOfClass("BodyColors") == nil then for i=1,#accs do if accs[i]:IsA'BodyColors' then accs[i]:Clone().Parent=MainModel end end end
			if MainModel:FindFirstChildOfClass("Shirt") == nil then for i=1,#accs do if accs[i]:IsA'Shirt' then accs[i]:Clone().Parent=MainModel end end end
			if MainModel:FindFirstChildOfClass("Pants") == nil then for i=1,#accs do if accs[i]:IsA'Pants' then accs[i]:Clone().Parent=MainModel end end end
			if MainModel:FindFirstChildOfClass("ShirtGraphic") == nil then for i=1,#accs do if accs[i]:IsA'ShirtGraphic' then accs[i]:Clone().Parent=MainModel end end end
			if MainModel:FindFirstChildOfClass("CharacterMesh") == nil then for i=1,#accs do if accs[i]:IsA'CharacterMesh' then accs[i]:Clone().Parent=MainModel end end end
			cam.CFrame=MainPosition*CFrame.new(0,1.5,0) cam.Anchored=true cam.CanCollide=false cam.Transparency=1 cam.Size=Vector3.new()
			local chrrr = MainModel:GetChildren() for i=1,#chrrr do
				if chrrr[i] == EffectModel or chrrr[i] == h or chrrr[i] == t or chrrr[i] == rl or chrrr[i] == hum or chrrr[i] == ll or chrrr[i] == ra or chrrr[i] == la or chrrr[i] == mus or chrrr[i]:IsA'Accessory' or chrrr[i]:IsA'Hat' or chrrr[i]:IsA'Shirt' or chrrr[i]:IsA'Pants' or chrrr[i]:IsA'BodyColors' or chrrr[i]:IsA'ShirtGraphic' or chrrr[i]:IsA'CharacterMesh' or chrrr[i]:IsA'BillboardGui' then else chrrr[i]:Destroy() end
			end
			if game.Players:FindFirstChild(plrr.Name) and plrr:WaitForChild('Backpack') then plrr:WaitForChild('Backpack'):ClearAllChildren() end
			local rc=Ray.new(MainPosition.p,(CFrame.new(0,-1,0).p).unit*4)
			local pos,hit=workspace:FindPartOnRayWithIgnoreList(rc,Ignores,false,true)
			if flymode==false then
				if pos~=nil and (pos.CanCollide~=false or pos.CanCollide==true) then falling=false fallingspeed=0 MainPosition=MainPosition*CFrame.new(0,hit.Y-MainPosition.Y+3,0)
				elseif pos~=nil and (pos.CanCollide~=true or pos.CanCollide==false) then table.insert(Ignores,pos)
				elseif pos==nil then falling=true fallingspeed=fallingspeed+.06 MainPosition=MainPosition-Vector3.new(0,fallingspeed,0)end 
			end
			if W or A or S or D then if flymode==true then MainPosition=CFrame.new(MainPosition.p,CCF.p) else MainPosition=CFrame.new(MainPosition.p,Vector3.new(CCF.x,MainPosition.y,CCF.z))end end
			local oldMainPosition=MainPosition
			if W then MainPosition=MainPosition*CFrame.new(0,0,walkspeed)end
			if S then MainPosition=MainPosition*CFrame.new(0,0,-walkspeed)end
			if A then MainPosition=MainPosition*CFrame.new(walkspeed,0,0)end
			if D then MainPosition=MainPosition*CFrame.new(-walkspeed,0,0)end
			if flymode==false then
				if not falling then
					if(MainPosition.X~=oldMainPosition.X or MainPosition.Z~=oldMainPosition.Z)then MainPosition=CFrame.new(MainPosition.p,oldMainPosition.p)
						if attacking == false then
							if mode==1 then
								alerp({CFrame.new(0,0+0.125*math.sin(sn/6),0)*CFrame.Angles(math.rad(5+1*math.cos(sn/8)),math.rad(180-5*math.cos(sn/6)),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-6*math.cos(sn/8)),math.rad(0+5*math.cos(sn/6)),math.rad(0)),CFrame.new(-1.5,0-0.15*math.cos(sn/6),0+0.5*math.sin(sn/6))*CFrame.Angles(math.rad(0-30*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),0),
									CFrame.new(0.75,0+0.075*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(-20),math.rad(-15+10*math.cos(sn/8)),math.rad(-25-5*math.cos(sn/8))),CFrame.new(-.5,-1.9+0.2*math.cos(sn/6),0-1*math.sin(sn/6))*CFrame.Angles(math.rad(-10+40*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),math.rad(0+2.5*math.cos(sn/6))),CFrame.new(.5,-1.9-0.2*math.cos(sn/6),0+1*math.sin(sn/6))*CFrame.Angles(math.rad(-10-40*math.sin(sn/6)),math.rad(0),math.rad(0))},.2)					
							elseif mode==2 then
								alerp({CFrame.new(0,0+0.125*math.sin(sn/6),0)*CFrame.Angles(math.rad(5+1*math.cos(sn/8)),math.rad(180-5*math.cos(sn/6)),math.rad(0)),CFrame.new(-0.1,1.5,-0.25)*CFrame.Angles(math.rad(-20-5*math.cos(sn/8)),math.rad(-5),math.rad(10)),CFrame.new(-1.35,-0.01-0.075*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(5+1*math.cos(sn/8)),math.rad(-10-5*math.cos(sn/8)),math.rad(0)),
									CFrame.new(1.35,-0.1-0.075*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(5),math.rad(15+5*math.cos(sn/8)),math.rad(0)),CFrame.new(-.5,-1.9+0.2*math.cos(sn/6),0-1*math.sin(sn/6))*CFrame.Angles(math.rad(-10+40*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),math.rad(0+2.5*math.cos(sn/6))),CFrame.new(.5,-1.9-0.2*math.cos(sn/6),0+1*math.sin(sn/6))*CFrame.Angles(math.rad(-10-40*math.sin(sn/6)),math.rad(0),math.rad(0))},.2)					
							elseif mode==3 then
								alerp({CFrame.new(0,0+0.125*math.sin(sn/6),0)*CFrame.Angles(math.rad(10+1*math.cos(sn/8)),math.rad(180-5*math.cos(sn/6)),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-6*math.cos(sn/6)),math.rad(0+5*math.cos(sn/6)),math.rad(0)),CFrame.new(-0.25,0.5+0.025*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(100+1*math.cos(sn/8)),math.rad(-10-5*math.cos(sn/8)),math.rad(100)),
									CFrame.new(0.25,0.5+0.075*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(80),math.rad(0+5*math.cos(sn/8)),math.rad(-80-5*math.cos(sn/8))),CFrame.new(-.5,-1.9+0.2*math.cos(sn/6),0-1*math.sin(sn/6))*CFrame.Angles(math.rad(-5+40*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),math.rad(0+2.5*math.cos(sn/6))),CFrame.new(.5,-1.9-0.2*math.cos(sn/6),0+1*math.sin(sn/6))*CFrame.Angles(math.rad(-5-40*math.sin(sn/6)),math.rad(0),math.rad(0))},.2)					
							elseif mode==4 then
								alerp({CFrame.new(0,0+0.125*math.sin(sn/6),0)*CFrame.Angles(math.rad(5+1*math.cos(sn/8)),math.rad(180-5*math.cos(sn/6)),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(5-6*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),math.rad(0)),CFrame.new(-1.5,0-0.15*math.cos(sn/6),0+0.5*math.sin(sn/6))*CFrame.Angles(math.rad(0-30*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),0),
									CFrame.new(1.5,0+0.15*math.cos(sn/6),0-0.5*math.sin(sn/6))*CFrame.Angles(math.rad(0+30*math.sin(sn/6)),math.rad(0-5*math.cos(sn/6)),0),CFrame.new(-.5,-1.9+0.2*math.cos(sn/6),0-1*math.sin(sn/6))*CFrame.Angles(math.rad(-10+40*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),math.rad(0+2.5*math.cos(sn/6))),CFrame.new(.5,-1.9-0.2*math.cos(sn/6),0+1*math.sin(sn/6))*CFrame.Angles(math.rad(-10-40*math.sin(sn/6)),math.rad(0),math.rad(0))},.2)					
							elseif mode==5 then
								alerp({CFrame.new(0,0+0.125*math.sin(sn/6),0)*CFrame.Angles(math.rad(5+1*math.cos(sn/8)),math.rad(180-5*math.cos(sn/6)),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(5+6*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),math.rad(0)),CFrame.new(-0.75,0+0.025*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(-20+1*math.cos(sn/8)),math.rad(15-5*math.cos(sn/8)),math.rad(25)),
									CFrame.new(0.75,0+0.075*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(-20),math.rad(-15+10*math.cos(sn/8)),math.rad(-25-5*math.cos(sn/8))),CFrame.new(-.5,-1.9+0.2*math.cos(sn/6),0-1*math.sin(sn/6))*CFrame.Angles(math.rad(-10+40*math.sin(sn/6)),math.rad(0+5*math.cos(sn/6)),math.rad(0+2.5*math.cos(sn/6))),CFrame.new(.5,-1.9-0.2*math.cos(sn/6),0+1*math.sin(sn/6))*CFrame.Angles(math.rad(-10-40*math.sin(sn/6)),math.rad(0),math.rad(0))},.2)					
							end
						end
					else
						if attacking == false then
							if mode==1 then
								alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(5-1*math.cos(sn/8)),math.rad(180),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-5*math.cos(sn/8)),math.rad(0),math.rad(0)),CFrame.new(-1.4,0+0.025*math.sin(sn/8),-0.2)*CFrame.Angles(math.rad(5+1*math.cos(sn/8)),math.rad(-10-5*math.cos(sn/8)),math.rad(0)),
									CFrame.new(0.75,0+0.075*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(-20),math.rad(-15+10*math.cos(sn/8)),math.rad(-25-5*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(5-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
							elseif mode==2 then
								alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(15-1*math.cos(sn/8)),math.rad(180),math.rad(0)),CFrame.new(-0.1,1.5,-0.25)*CFrame.Angles(math.rad(-20-5*math.cos(sn/8)),math.rad(-5),math.rad(10)),CFrame.new(-1.25,-0.01+0.025*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(15+1*math.cos(sn/8)),math.rad(-30-5*math.cos(sn/8)),math.rad(0)),
									CFrame.new(1.25,-0.1+0.075*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(15),math.rad(35+10*math.cos(sn/8)),math.rad(0)),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.35)*CFrame.Angles(math.rad(15-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(10-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
							elseif mode==3 then
								alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(200),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-5-5*math.cos(sn/8)),math.rad(-20),math.rad(0)),CFrame.new(-0.25,0.5+0.025*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(100+1*math.cos(sn/8)),math.rad(-10-5*math.cos(sn/8)),math.rad(100)),
									CFrame.new(0.25,0.5+0.075*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(80),math.rad(0+5*math.cos(sn/8)),math.rad(-80-5*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2.05-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
							elseif mode==4 then
								alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(180),math.rad(0)),CFrame.new(0,1.5,0)*CFrame.Angles(math.rad(0+5*math.cos(sn/8)),math.rad(0),math.rad(0)),CFrame.new(-1.5,0+0.025*math.sin(sn/8),0)*CFrame.Angles(math.rad(0+1*math.cos(sn/8)),math.rad(-5+5*math.cos(sn/8)),math.rad(0)),
									CFrame.new(1.5,0+0.075*math.sin(sn/8),0)*CFrame.Angles(math.rad(0),math.rad(5-5*math.cos(sn/8)),math.rad(0)),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
							elseif mode==5 then
								alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(5-1*math.cos(sn/8)),math.rad(180),math.rad(0)),CFrame.new(0,1.5,0)*CFrame.Angles(math.rad(5-5*math.cos(sn/8)),math.rad(0),math.rad(0)),CFrame.new(-0.75,0+0.025*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(-20+1*math.cos(sn/8)),math.rad(15-5*math.cos(sn/8)),math.rad(25)),
									CFrame.new(0.75,0+0.075*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(-20),math.rad(-15+10*math.cos(sn/8)),math.rad(-25-5*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(5-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
							end
						end
					end
				elseif falling then 
					if(MainPosition.X~=oldMainPosition.X or MainPosition.Z~=oldMainPosition.Z) then MainPosition=CFrame.new(MainPosition.p,oldMainPosition.p)end
					if attacking == false then
						if fallingspeed>0 then
							alerp({CFrame.new(0,0,0)*CFrame.Angles(math.rad(15-10*math.cos(sn/9)),math.rad(180),0),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-20-10*math.cos(sn/9)),0,0),CFrame.new(-1.75,0.25,-0.15)*CFrame.Angles(math.rad(15+10*math.sin(sn/9)),0,math.rad(-35-10*math.sin(sn/9))),
								CFrame.new(1.75,0.25,-0.15)*CFrame.Angles(math.rad(15+10*math.sin(sn/9)),0,math.rad(35+10*math.sin(sn/9))),CFrame.new(-.5,-2,0)*CFrame.Angles(math.rad(-5+2.5*math.cos(sn/9)),math.rad(10),0),CFrame.new(.5,-1,-0.25)*CFrame.Angles(math.rad(-10-5*math.sin(sn/9)),math.rad(-5),0)},.2)
						else
							alerp({CFrame.new(0,0,0)*CFrame.Angles(math.rad(-5-5*math.cos(sn/9)),math.rad(180),0),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(5-10*math.cos(sn/9)),0,0),CFrame.new(-1.5,0.75,-0.75)*CFrame.Angles(math.rad(115+10*math.sin(sn/9)),0,math.rad(-10-5*math.sin(sn/9))),
								CFrame.new(1.5,0.75,-0.75)*CFrame.Angles(math.rad(115+10*math.sin(sn/9)),0,math.rad(10+5*math.sin(sn/9))),CFrame.new(-.5,-1.5,-0.15)*CFrame.Angles(math.rad(-10+5*math.cos(sn/9)),math.rad(5),0),CFrame.new(.5,-0.5,-0.35)*CFrame.Angles(math.rad(-20-10*math.sin(sn/9)),0,0)},.2)
						end
					end
				end
			else
				if attacking == false then
					if(MainPosition.X~=oldMainPosition.X or MainPosition.Z~=oldMainPosition.Z)then
						alerp({CFrame.new(0,0+0.5*math.sin(sn/8),0)*CFrame.Angles(math.rad(40-1*math.cos(sn/8)),math.rad(180),math.rad(0)),CFrame.new(0,1.5,0)*CFrame.Angles(math.rad(35-5*math.cos(sn/8)),math.rad(0),math.rad(0)),CFrame.new(-1.5,0.25-0.025*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(-60),math.rad(15-10*math.cos(sn/8)),math.rad(-10+5*math.cos(sn/8))),
							CFrame.new(1.5,0.25-0.025*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(-60),math.rad(-15+10*math.cos(sn/8)),math.rad(15-5*math.cos(sn/8))),CFrame.new(-.5,-1.75+0.15*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(5-5*math.cos(sn/8)),math.rad(10),math.rad(0)),CFrame.new(.5,-1.5+0.15*math.sin(sn/8),-.5)*CFrame.Angles(math.rad(-20+15*math.cos(sn/8)),math.rad(-5),math.rad(0))},.2)
					else
						alerp({CFrame.new(0,0+0.5*math.sin(sn/8),0)*CFrame.Angles(math.rad(10-1*math.cos(sn/8)),math.rad(180),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(5-5*math.cos(sn/8)),math.rad(0),math.rad(0)),CFrame.new(-1.5,0-0.025*math.sin(sn/8),0)*CFrame.Angles(math.rad(10),math.rad(15-10*math.cos(sn/8)),math.rad(-5+5*math.cos(sn/8))),
							CFrame.new(1.5,0-0.025*math.sin(sn/8),0)*CFrame.Angles(math.rad(10),math.rad(-15+10*math.cos(sn/8)),math.rad(5-5*math.cos(sn/8))),CFrame.new(-.5,-1.75+0.15*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(5-5*math.cos(sn/8)),math.rad(10),math.rad(0)),CFrame.new(.5,-1.5+0.15*math.sin(sn/8),-.5)*CFrame.Angles(math.rad(-20+15*math.cos(sn/8)),math.rad(-5),math.rad(0))},.2)
					end
				end
			end
			if MainPosition.Y<=-200 then fallingspeed=0 MainPosition=MainPosition+Vector3.new(0,250,0)end
			t.CFrame=MainPosition*Torso
			h.CFrame=t.CFrame*Neck
			ll.CFrame=t.CFrame*LeftLeg
			rl.CFrame=t.CFrame*RightLeg
			la.CFrame=t.CFrame*LeftArm
			ra.CFrame=t.CFrame*RightArm
			t.Transparency=0 h.Transparency=0 ll.Transparency=0 rl.Transparency=0 la.Transparency=0 ra.Transparency=0
			t.Material="Plastic" h.Material="Plastic" ll.Material="Plastic" rl.Material="Plastic" la.Material="Plastic" ra.Material="Plastic"
			for i=1,#accs do if accs[i]:IsA'BodyColors' then t.Color=accs[i].TorsoColor3 h.Color=accs[i].HeadColor3 ll.Color=accs[i].LeftLegColor3 rl.Color=accs[i].RightLegColor3 la.Color=accs[i].LeftArmColor3 ra.Color=accs[i].RightArmColor3 end end
			if mus.Parent == nil or mus.Parent ~= t or mus == nil or not mus then
				mus = Instance.new("Sound") mus.Volume = 0.5 mus.Pitch = 1 mus.EmitterSize = 50 mus.SoundId = "rbxassetid://"..musid mus.Parent = t mus.Playing = playmus mus.Looped = true mus.TimePosition = muspos fixmus = true
			elseif fixmus == false then
				mus.SoundId = "rbxassetid://"..musid
				mus.Playing = playmus
				muspos = mus.TimePosition
			else
				fixmus = false
			end
			if wings==true then
				local move=nil
				if mode==1 then
					move=CFrame.new(0,5,0)
				elseif mode==2 then
					move=CFrame.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
				elseif mode==3 then
					move=CFrame.new(0,-10,0)
				elseif mode==4 then
					move=CFrame.new(math.random(-4,4),0,0)
				elseif mode==5 then
					move=CFrame.new(0,0,-1)
				end
				Effect({cf=MainPosition*CFrame.new(0,0.5,-2)*CFrame.Angles(0,0,math.rad(math.random(0,360))),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(10,15),size=Vector3.new(3,3,1),size2=Vector3.new(0,math.random(4,15),0)/math.random(1,2),radX=math.random(-1,1),radY=math.random(-1,1),radZ=math.random(-5,5),mat="Neon",lock=false,tran=0,tran2=1,bmr=false,sbm=0,mbm=0})
				for i=1,4 do
					local pos=MainPosition*CFrame.new(3*(i/1.5)+1+(i/1.5)*math.sin(sn/8),1.5*i-2-i*math.sin(sn/8)+2+i*math.cos(sn/8),-2-(i/2))
					Effect({cf=pos*CFrame.Angles(0,0,math.rad(math.random(0,360))),moveto=pos*move,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(10,15),size=Vector3.new(3-(i/2),3-(i/2),1/i),size2=Vector3.new(2.5-(i/2),2.5-(i/2),1/i)/math.random(1,2),radX=math.random(-1,1),radY=math.random(-1,1),radZ=math.random(-5,5),mat="Neon",lock=false,tran=0,tran2=1,bmr=false,sbm=0,mbm=0})
				end
				for i=1,4 do
					local pos=MainPosition*CFrame.new(-3*(i/1.5)-1-(i/1.5)*math.sin(sn/8),1.5*i-2-i*math.sin(sn/8)+2+i*math.cos(sn/8),-2-(i/2))
					Effect({cf=pos*CFrame.Angles(0,0,math.rad(math.random(0,360))),moveto=pos*move,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(10,15),size=Vector3.new(3-(i/2),3-(i/2),1/i),size2=Vector3.new(2.5-(i/2),2.5-(i/2),1/i)/math.random(1,2),radX=math.random(-1,1),radY=math.random(-1,1),radZ=math.random(-5,5),mat="Neon",lock=false,tran=0,tran2=1,bmr=false,sbm=0,mbm=0})
				end
			end
			if game.Players:FindFirstChild(plrr.Name) and plrr:WaitForChild("PlayerGui") and plrr:WaitForChild("PlayerGui"):FindFirstChild("Input") == nil then
				NLS([[local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Event = game:GetService("JointsService"):WaitForChild("InputEventFrom"..Player.Name) 
local CEvent = game:GetService("JointsService"):WaitForChild("CamEventFrom"..Player.Name) 
local UIS = game:GetService("UserInputService")
local h,t = Mouse.Hit,Mouse.Target
local input = function(io,a)
    if a then return end
    local io = {KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState}
    Event:FireServer(io)
end
UIS.InputBegan:Connect(input)
UIS.InputEnded:Connect(input)
while wait() do
	CEvent:FireServer(workspace.Camera.CoordinateFrame)
	local cam = workspace.Camera
	cam.CameraSubject = workspace:FindFirstChild("<["..Player.Name.."]>")
	cam.CameraType = "Custom"
	cam.HeadLocked = true
	cam.HeadScale = 1
	cam.FieldOfView = 70   
	if h~=Mouse.Hit or t~=Mouse.Target then
        Event:FireServer({isMouse=true,Target=Mouse.Target,Hit=Mouse.Hit})
        h,t=Mouse.Hit,Mouse.Target
    end
end]], plrr:WaitForChild("PlayerGui"))
			end
			if game.Players:FindFirstChild(plrr.Name) and plrr:WaitForChild("PlayerGui") and plrr:WaitForChild("PlayerGui"):FindFirstChild("Input") then
				plrr:WaitForChild("PlayerGui").Input.Disabled = false
			end
			if game.Players:FindFirstChild(plrr.Name) and game:GetService("JointsService"):FindFirstChild("InputEventFrom"..plrr.Name) == nil then
				local NewInput = EventBackupC:Clone()
				NewInput.Parent = game:GetService("JointsService")
				do
					m.TrigEvent = te
					UIS.TrigEvent = te
					NewInput.OnServerEvent:Connect(function(plr,io)
						if plr~=plrr then return end
						if io.isMouse then
							m.Target = io.Target
							m.Hit = io.Hit
						elseif io.UserInputType == Enum.UserInputType.MouseButton1 then
							if io.UserInputState == Enum.UserInputState.Begin then
								m:TrigEvent("Button1Down")
							else
								m:TrigEvent("Button1Up")
							end
						else
							for n,t in pairs(CAS.Actions) do
								for _,k in pairs(t.Keys) do
									if k==io.KeyCode then
										t.Function(t.Name,io.UserInputState,io)
									end
								end
							end
							if io.UserInputState == Enum.UserInputState.Begin then
								m:TrigEvent("KeyDown",io.KeyCode.Name:lower())
								UIS:TrigEvent("InputBegan",io,false)
							else
								m:TrigEvent("KeyUp",io.KeyCode.Name:lower())
								UIS:TrigEvent("InputEnded",io,false)
							end
						end
					end)
					Mouse,mouse,UserInputService,ContextActionService,mausee = m,m,UIS,CAS,m
				end
				if game.Players:FindFirstChild(plrr.Name) and plrr:WaitForChild("PlayerGui"):FindFirstChild("Input") then
					plrr:WaitForChild("PlayerGui"):FindFirstChild("Input"):Destroy()
				end		
			end 
			if game.Players:FindFirstChild(plrr.Name) and game:GetService("JointsService"):FindFirstChild("CamEventFrom"..plrr.Name) == nil then
				local NewCam = CamBackupC:Clone()
				NewCam.Parent = game:GetService("JointsService")
				NewCam.OnServerEvent:Connect(function(plr, e)
					CCF=e
				end)
			end
		elseif stoped == true then
			if MainModel then MainModel:Destroy() end
			if cam then cam:Destroy() end
		end
	end)
end
spawn(system)
function r(o,dir,ran,ignor)
	return workspace:FindPartOnRayWithIgnoreList(Ray.new(o, dir.unit * ran), ignor)
end
function cr(pos,dir,ran,ignor)
	local ray = Ray.new(pos,(dir-pos).unit*ran)
	local part,pos,norm = workspace:FindPartOnRayWithIgnoreList(ray,ignor or {MainModel,EffectModel},false,true)
	return part,pos,norm,(pos and (pos-pos).magnitude)
end
function Sound(i,p,v,pi,por)
	local s = nil
	coroutine.resume(coroutine.create(function()
		s = InstanceNW("Sound",{Parent=p,Volume=v,Pitch=pi,SoundId ="rbxassetid://"..i})
		s:play()
		if por == true then
			s.PlayOnRemove=true
			s:Destroy()
		end
	end))
	return s
end
--Effect({cf=MainPosition,moveto=Mouse.Hit.p,clr=Color3.new(1,0,0),clr2=Color3.new(0,0,0),mtype="Box",waits=100,size=Vector3.new(3,3,3),size2=Vector3.new(3,3,3),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=50})
function Effect(tblee)
	coroutine.resume(coroutine.create(function()
		local origpos = (tblee.cf or nil)
		local moveto = (tblee.moveto or nil)
		local color = (tblee.clr or Color3.new(0,0,0))
		local color2 = (tblee.clr2 or nil)
		local defaultsize = (tblee.size or Vector3.new(2,2,2))
		local material = (tblee.mat or "Neon")
		local locker = (tblee.lock or false)
		local rotateX = (tblee.radX or 0)
		local rotateY = (tblee.radY or 0)
		local rotateZ = (tblee.radZ or 0)
		local secondsize = (tblee.size2 or Vector3.new(4,4,4))
		local acttime = (tblee.waits or 100)
		local transpar = (tblee.tran or 0)
		local transpar2 = (tblee.tran2 or 1)
		local typeofmesh = (tblee.mtype or "S")
		local boomerang = (tblee.bmr or false)
		local sizeboomerang = (tblee.sbm or 0)
		local moveboomerang = (tblee.mbm or 0)
		local sou = (tblee.pls or false)
		local vo = (tblee.vol or 1)
		local pitc = (tblee.pit or 1)
		local i = (tblee.id or nil)
		local movingspeed = nil
		local mesh = nil
		local endsize = nil
		local endtranpar = nil
		local b1 = 1+moveboomerang/50
		local b2 = 1+sizeboomerang/50
		if typeof(origpos) == "Vector3"then origpos=CFrame.new(origpos) end 
		if typeof(moveto) == "CFrame"then moveto=moveto.p end 
		if typeof(color) == "BrickColor"then color=color.Color end 
		if typeof(color2) == "BrickColor"then color2=color2.Color end
		if origpos then
			local p=Instance.new("Part",EffectModel)p.Anchored=true p.CanCollide=false p.Color=color p.CFrame=origpos p.Material=material p.Size=Vector3.new(1,1,1)p.CanCollide=false p.Transparency=transpar p.CastShadow=false p.Locked=true
			if typeofmesh == "Box" or typeofmesh == "B" or typeofmesh == "1" then
				mesh=Instance.new("BlockMesh",p)mesh.Scale=defaultsize
			elseif typeofmesh == "Sphere" or typeofmesh == "S" or typeofmesh == "2" then
				mesh=Instance.new("SpecialMesh",p)mesh.MeshType="Sphere"mesh.Scale=defaultsize
			elseif typeofmesh == "Cylinder" or typeofmesh == "C" or typeofmesh == "3" then
				mesh=Instance.new("SpecialMesh",p)mesh.MeshType="Cylinder"mesh.Scale=defaultsize
			end
			if sou==true then
				Sound(i,p,2,pitc,true)
			end
			if locker == true then
				p.Position = origpos.p
				if typeofmesh == "Cylinder" or typeofmesh == "C" or typeofmesh == "3" then 
					p.CFrame = CFrame.new(p.Position,moveto)*CFrame.new(0,0,-(p.Size.Z/1.5))*CFrame.Angles(0,math.rad(90),0)
				else
					p.CFrame = CFrame.new(p.Position,moveto)*CFrame.new(0,0,-(p.Size.Z/1.5))
				end
			else
				if typeofmesh == "Cylinder" or typeofmesh == "C" or typeofmesh == "3" then 
					p.CFrame = origpos*CFrame.Angles(0,math.rad(90),0)
				else
					p.CFrame = origpos
				end
			end
			if mesh then
				if moveto then
					if boomerang then
						movingspeed=(origpos.p - moveto).Magnitude/acttime*b1
					else
						movingspeed=(origpos.p - moveto).Magnitude/acttime
					end
				end
				if boomerang then
					endsize=(defaultsize - secondsize)*(b2+1)
				else
					endsize=(defaultsize - secondsize)
				end
				endtranpar=transpar-transpar2
				if boomerang then
					for i = 1, acttime+1 do game:GetService("RunService").Heartbeat:wait() if stopeffects == true then break end
						mesh.Scale=mesh.Scale-(Vector3.new((endsize.X)*((1 - (i/acttime)*b2)),(endsize.Y)*((1 - (i/acttime)*b2)),(endsize.Z)*((1 - (i/acttime)*b2)))*b2)/acttime
						p.Transparency = p.Transparency - endtranpar/acttime
						p.CFrame=p.CFrame*CFrame.Angles(math.rad(rotateX),math.rad(rotateY),math.rad(rotateZ))
						if color2 then
							p.Color = color:Lerp(color2,i/acttime)
						end
						if moveto ~= nil then
							local a = p.Orientation
							if typeofmesh == "Cylinder" or typeofmesh == "C" or typeofmesh == "3" then 
								p.CFrame = CFrame.new(p.Position,moveto)*CFrame.new(0,0,-(movingspeed)*((1-(i/acttime)*b1)))*CFrame.Angles(0,math.rad(90),0)
							else
								p.CFrame = CFrame.new(p.Position,moveto)*CFrame.new(0,0,-(movingspeed)*((1-(i/acttime)*b1)))
							end
							p.Orientation = a
						end
					end
				else
					for i = 1, acttime+1 do game:GetService("RunService").Heartbeat:wait() if stopeffects == true then break end
						mesh.Scale=mesh.Scale-endsize/acttime
						p.Transparency = p.Transparency - endtranpar/acttime
						p.CFrame=p.CFrame*CFrame.Angles(math.rad(rotateX),math.rad(rotateY),math.rad(rotateZ))
						if color2 then
							p.Color = color:Lerp(color2,i/acttime)
						end
						if moveto ~= nil then
							local a = p.Orientation
							if typeofmesh == "Cylinder" or typeofmesh == "C" or typeofmesh == "3" then 
								p.CFrame = CFrame.new(p.Position,moveto)*CFrame.new(0,0,-movingspeed)*CFrame.Angles(0,math.rad(90),0)
							else
								p.CFrame = CFrame.new(p.Position,moveto)*CFrame.new(0,0,-movingspeed)
							end
							p.Orientation = a
						end
					end
				end
				p:Destroy()
			end
		elseif origpos == nil then
			warn("Origpos is nil!")
		end
	end))
end
--LightningBolt({startp=MainPosition,endp=Mouse.Hit.p,rdm=3,ss=2,tran=100,clr=Color3.new(1,0,0),clr2=Color3.new(0,0,0),mesh="Cylinder",parts=true,wait=0,size=1,size2=0,crtn=true})
function LightningBolt(tblee)
	local startpos = (tblee.startp or nil)
	local endpos = (tblee.endp or nil)
	local randomz = (tblee.rdm or 1)
	local segmentsize = (tblee.ss or 2)
	local fadetime = (tblee.tran or 75)
	local color = (tblee.clr or Color3.new(0,0,0))
	local color2 = (tblee.clr2 or Color3.new(0,0,0))
	local segmentwaiting = (tblee.wait or 0)
	local defaultsize = (tblee.size or 1)
	local corout = (tblee.crtn or false)
	local meshtype = (tblee.mesh or "Box")
	local secondsize = (tblee.size2 or 1)
	local endparts = (tblee.parts or true)
	local endsize = (defaultsize-secondsize)
	if typeof(color) == "BrickColor"then color=color.Color end 
	if typeof(startpos) == "CFrame"then startpos=startpos.p end 
	if typeof(endpos) == "CFrame"then endpos=endpos.p end
	if startpos and endpos then
		local magnitude = (startpos-endpos).magnitude local cframe = CFrame.new(startpos,endpos)
		if corout == true then 
			coroutine.resume(coroutine.create(function()
				local oldsegment = nil
				for i=1,magnitude+1,segmentsize do if stopeffects == true then break end
					local ex=CFrame.Angles(math.rad(math.random(360)),math.rad(math.random(360)),math.rad(math.random(360)))*CFrame.new(math.random(randomz*100)/100,0,0)
					local new=cframe*CFrame.new(0,0,-i/magnitude*magnitude)*ex
					if oldsegment then
						if meshtype == nil or meshtype == "Box" or meshtype == "1" or meshtype == "B" then
							local p=Instance.new("Part",EffectModel)p.Anchored=true p.CanCollide=false p.Color=color p.CFrame=CFrame.new(new.p,oldsegment.p)*CFrame.new(0,0,-(new.p-oldsegment.p).magnitude/2)p.Material="Neon"p.Size=Vector3.new(0.05, 0.05, 0.05)p.CanCollide=false p.CastShadow=false p.Locked=true
							local mesh=Instance.new("BlockMesh",p)mesh.Scale=Vector3.new(10*defaultsize,10*defaultsize,(new.p-oldsegment.p).magnitude*20)
							coroutine.resume(coroutine.create(function()
								for i=1,fadetime do game:GetService("RunService").Heartbeat:wait() if stopeffects == true then break end
									if color2 then
										p.Color = color:Lerp(color2,i/fadetime)
									end
									mesh.Scale=mesh.Scale-Vector3.new(10*(endsize/fadetime),10*(endsize/fadetime),0)
									p.Transparency=p.Transparency+1/fadetime
								end 
								p:Destroy()
							end))
						elseif meshtype == "Cylinder" or meshtype == "2" or meshtype == "C" then
							local p=Instance.new("Part",EffectModel)p.Anchored=true p.CanCollide=false p.Color=color p.CFrame=CFrame.new(new.p,oldsegment.p)*CFrame.new(0,0,-(new.p-oldsegment.p).magnitude/2)*CFrame.Angles(0,math.rad(90),0) p.Material="Neon"p.Size=Vector3.new(0.05, 0.05, 0.05)p.CanCollide=false p.CastShadow=false p.Locked=true
							local mesh=Instance.new("SpecialMesh",p)mesh.MeshType="Cylinder"mesh.Scale=Vector3.new((new.p-oldsegment.p).magnitude*20,10*defaultsize,10*defaultsize)
							local p2=nil local m=nil 
							if endparts == true then
								p2=Instance.new("Part",EffectModel)p2.Anchored=true p2.CanCollide=false p2.Color=color p2.CFrame=CFrame.new(new.p,oldsegment.p)*CFrame.new(0,0,-(new.p-oldsegment.p).magnitude) p2.Material="Neon"p2.Size=Vector3.new(0.05, 0.05, 0.05)p2.CanCollide=false 
								m=Instance.new("SpecialMesh",p2)m.MeshType="Sphere"m.Scale=Vector3.new(10*defaultsize,10*defaultsize,10*defaultsize)
							end
							coroutine.resume(coroutine.create(function()
								for i=1,fadetime do game:GetService("RunService").Heartbeat:wait() if stopeffects == true then break end
									if color2 then
										p.Color = color:Lerp(color2,i/fadetime)
										if endparts == true then
											p2.Color = color:Lerp(color2,i/fadetime)
										end
									end
									if endparts == true then
										m.Scale=m.Scale-Vector3.new(10*(endsize/fadetime),10*(endsize/fadetime),10*(endsize/fadetime))
										p2.Transparency=p2.Transparency+1/fadetime
									end
									mesh.Scale=mesh.Scale-Vector3.new(0,10*(endsize/fadetime),10*(endsize/fadetime))
									p.Transparency=p.Transparency+1/fadetime
								end 
								p:Destroy()
								if endparts then
									p2:Destroy()
								end
							end))
						end
						oldsegment=new 
					else 
						oldsegment=new
					end
					if segmentwaiting~=0 then wait(segmentwaiting) end
				end
			end))
		elseif corout == false then
			local oldsegment = nil
			for i=1,magnitude+1,segmentsize do if stopeffects == true then break end
				local ex=CFrame.Angles(math.rad(math.random(360)),math.rad(math.random(360)),math.rad(math.random(360)))*CFrame.new(math.random(randomz*100)/100,0,0)
				local new=cframe*CFrame.new(0,0,-i/magnitude*magnitude)*ex
				if oldsegment then
					if meshtype == nil or meshtype == "Box" or meshtype == "1" or meshtype == "B" then
						local p=Instance.new("Part",EffectModel)p.Anchored=true p.CanCollide=false p.Color=color p.CFrame=CFrame.new(new.p,oldsegment.p)*CFrame.new(0,0,-(new.p-oldsegment.p).magnitude/2)p.Material="Neon"p.Size=Vector3.new(0.05, 0.05, 0.05)p.CanCollide=false p.CastShadow=false p.Locked=true
						local mesh=Instance.new("BlockMesh",p)mesh.Scale=Vector3.new(10*defaultsize,10*defaultsize,(new.p-oldsegment.p).magnitude*20)
						coroutine.resume(coroutine.create(function()
							for i=1,fadetime do game:GetService("RunService").Heartbeat:wait() if stopeffects == true then break end
								if color2 then
									p.Color = color:Lerp(color2,i/fadetime)
								end
								mesh.Scale=mesh.Scale-Vector3.new(10*(endsize/fadetime),10*(endsize/fadetime),0)
								p.Transparency=p.Transparency+1/fadetime
							end 
							p:Destroy()
						end))
					elseif meshtype == "Cylinder" or meshtype == "2" or meshtype == "C" then
						local p=Instance.new("Part",EffectModel)p.Anchored=true p.CanCollide=false p.Color=color p.CFrame=CFrame.new(new.p,oldsegment.p)*CFrame.new(0,0,-(new.p-oldsegment.p).magnitude/2)*CFrame.Angles(0,math.rad(90),0) p.Material="Neon"p.Size=Vector3.new(0.05, 0.05, 0.05)p.CanCollide=false p.CastShadow=false p.Locked=true
						local mesh=Instance.new("SpecialMesh",p)mesh.MeshType="Cylinder"mesh.Scale=Vector3.new((new.p-oldsegment.p).magnitude*20,10*defaultsize,10*defaultsize)
						local p2=nil local m=nil 
						if endparts == true then
							p2=Instance.new("Part",EffectModel)p2.Anchored=true p2.CanCollide=false p2.Color=color p2.CFrame=CFrame.new(new.p,oldsegment.p)*CFrame.new(0,0,-(new.p-oldsegment.p).magnitude) p2.Material="Neon"p2.Size=Vector3.new(0.05, 0.05, 0.05)p2.CanCollide=false 
							m=Instance.new("SpecialMesh",p2)m.MeshType="Sphere"m.Scale=Vector3.new(10*defaultsize,10*defaultsize,10*defaultsize)
						end
						coroutine.resume(coroutine.create(function()
							for i=1,fadetime do game:GetService("RunService").Heartbeat:wait() if stopeffects == true then break end
								if color2 then
									p.Color = color:Lerp(color2,i/fadetime)
									if endparts == true then
										p2.Color = color:Lerp(color2,i/fadetime)
									end
								end
								if endparts == true then
									m.Scale=m.Scale-Vector3.new(10*(endsize/fadetime),10*(endsize/fadetime),10*(endsize/fadetime))
									p2.Transparency=p2.Transparency+1/fadetime
								end
								mesh.Scale=mesh.Scale-Vector3.new(0,10*(endsize/fadetime),10*(endsize/fadetime))
								p.Transparency=p.Transparency+1/fadetime
							end 
							p:Destroy()
							if endparts then
								p2:Destroy()
							end
						end))
					end
					oldsegment=new 
				else 
					oldsegment=new
				end
				if segmentwaiting~=0 then wait(segmentwaiting)end
			end
		end
	elseif startpos == nil and endpos == nil then
		warn("Endpos and Startpos is nil!")
	elseif startpos == nil then
		warn("Startpos is nil!")
	elseif endpos == nil then
		warn("Endpos is nil!")
	end
end
function Kill(who)
	coroutine.resume(coroutine.create(function()
		if who.Parent ~= MainModel and who.Parent ~= EffectModel and who ~= MainModel and who ~= EffectModel and who ~= cam and who.Parent ~= cam and who ~= script and who.Parent ~= script and who:FindFirstChild("KilledBy"..plrr.Name) == nil and who.Name ~= plname then
			InstanceNW("Folder",{Parent=who,Name="KilledBy"..plrr.Name})
			coroutine.resume(coroutine.create(function()
				for _,a in pairs(who:GetDescendants()) do
                    pcall(function()
				    	if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
				    		a.Disabled=true
				    		a:Destroy()
				    	elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
				    		a:Destroy()
				    	end
                    end)
				end
				local clkas = NLS([[local plr = game:GetService("Players").LocalPlayer
                if plr.PlayerGui then
                    for _,a in pairs(plr.PlayerGui:GetDescendants()) do
                        pcall(function()
                            if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                a.Disabled=true
                                a:Destroy()
                            elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                a:Destroy()
                            end
                        end)
                    end
                elseif plr.Backpack then
                    for _,a in pairs(plr.Backpack:GetDescendants()) do
                        pcall(function()
                            if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                a.Disabled=true
                                a:Destroy()
                            elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                a:Destroy()
                            end
                        end)
                    end
                elseif plr.Character then
                    for _,a in pairs(plr.Character:GetDescendants()) do
                        pcall(function()
                            if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                a.Disabled=true
                                a:Destroy()
                            elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                a:Destroy()
                            end
                        end)
                    end
                elseif script.Parent then
                    for _,a in pairs(script.Parent:GetDescendants()) do
                        pcall(function()
                            if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                a.Disabled=true
                                a:Destroy()
                            elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                a:Destroy()
                            end
                        end)
                    end
                end
                script.Disabled=true
                script:Destroy()]], who)
				if game:GetService("Players"):GetPlayerFromCharacter(who) then
					local plr = game:GetService("Players"):GetPlayerFromCharacter(who)
					for _,a in pairs(plr:WaitForChild'PlayerGui':GetDescendants()) do
                        pcall(function()
					    	if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
					    		a.Disabled=true
					    		a:Destroy()
					    	elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
					    		a:Destroy()
					    	end
                        end)
					end
					local clkas = NLS([[local plr = game:GetService("Players").LocalPlayer
                    if plr.PlayerGui then
                        for _,a in pairs(plr.PlayerGui:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif plr.Backpack then
                        for _,a in pairs(plr.Backpack:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif plr.Character then
                        for _,a in pairs(plr.Character:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif script.Parent then
                        for _,a in pairs(script.Parent:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    end
                    script.Disabled=true
                    script:Destroy()]], plr:WaitForChild'PlayerGui')
					for _,a in pairs(plr:WaitForChild'StarterGear':GetDescendants()) do
                        pcall(function()
					    	if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
					    		a.Disabled=true
					    		a:Destroy()
					    	elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
					    		a:Destroy()
					    	end
                        end)
					end
					local clkas = NLS([[local plr = game:GetService("Players").LocalPlayer
                    if plr.PlayerGui then
                        for _,a in pairs(plr.PlayerGui:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif plr.Backpack then
                        for _,a in pairs(plr.Backpack:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif plr.Character then
                        for _,a in pairs(plr.Character:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif script.Parent then
                        for _,a in pairs(script.Parent:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    end
                    script.Disabled=true
                    script:Destroy()]], plr:WaitForChild'StarterGear')
					for _,a in pairs(plr:WaitForChild'Backpack':GetDescendants()) do
                        pcall(function()
					    	if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
					    		a.Disabled=true
					    		a:Destroy()
					    	elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
					    		a:Destroy()
					    	end
                        end)
					end
					local clkas = NLS([[local plr = game:GetService("Players").LocalPlayer
                    if plr.PlayerGui then
                        for _,a in pairs(plr.PlayerGui:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif plr.Backpack then
                        for _,a in pairs(plr.Backpack:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif plr.Character then
                        for _,a in pairs(plr.Character:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    elseif script.Parent then
                        for _,a in pairs(script.Parent:GetDescendants()) do
                            pcall(function()
                                if a:IsA'Script' or a:IsA'LocalScript' or a.ClassName == "Script" or a.ClassName == "LocalScript" then
                                    a.Disabled=true
                                    a:Destroy()
                                elseif a:IsA'ModuleScript' or a.ClassName == "ModuleScript" then
                                    a:Destroy()
                                end
                            end)
                        end
                    end
                    script.Disabled=true
                    script:Destroy()]], plr:WaitForChild'Backpack')
				end
			end))
			spawn(function()
				while who ~= nil do game:GetService("RunService").Heartbeat:wait()
					who:BreakJoints()
					if who:FindFirstChildOfClass("Humanoid") ~= nil then who:FindFirstChildOfClass("Humanoid").MaxHealth=nil who:FindFirstChildOfClass("Humanoid").Health=nil end
				end
			end)
			local mainpart = (who:FindFirstChildOfClass'Part' or who:FindFirstChildOfClass'MeshPart' or who:FindFirstChildOfClass'UnionOperation')
			Effect({cf=mainpart.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,225),size=Vector3.new(mainpart.Size.Y,mainpart.Size.Y,mainpart.Size.Y),size2=Vector3.new(mainpart.Size.Y,mainpart.Size.Y,mainpart.Size.Y)*10,radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0.4,tran2=1,bmr=true,sbm=3,mbm=0})
			Sound(62339698,mainpart,4,math.random(1,3)/10,true)
			who:BreakJoints() for _, part in pairs(who:GetDescendants()) do
				coroutine.resume(coroutine.create(function()
					local act=math.random(25,150)
					if part:IsA'BasePart' then
						part:BreakJoints() part:Destroy()
						local pos = part.CFrame*CFrame.new(math.random(-10,10),math.random(-10,10),math.random(-10,10))
						Effect({cf=part.CFrame,moveto=pos,clr=maincolor,clr2=maincolor2,mtype="B",waits=act,size=part.Size,size2=part.Size,radX=math.random(-100,100)/50,radY=math.random(-100,100)/50,radZ=math.random(-100,100)/50,mat="Neon",lock=false,tran=0,tran2=0,bmr=false,sbm=0,mbm=0})
						for i=1,act do
							game:GetService("RunService").Heartbeat:wait()
						end
						Effect({cf=pos,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,75),size=Vector3.new(part.Size.Y,part.Size.Y,part.Size.Y),size2=Vector3.new(part.Size.Y,part.Size.Y,part.Size.Y)*math.random(2,6),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(9,11)/10,id=1192402877,bmr=false,sbm=0,mbm=0})
						for i=1,math.random(3,5) do
							Effect({cf=pos*CFrame.new(math.random(-part.Size.X,part.Size.X)/2,math.random(-part.Size.Y,part.Size.Y)/2,math.random(-part.Size.Z,part.Size.Z)/2),moveto=Vector3.new(pos.X+math.random(-2,2),pos.Y+(i*math.random(1.5,3)),pos.Z+math.random(-2,2)),clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(75,125),size=Vector3.new(part.Size.Y,part.Size.Y,part.Size.Y)/math.random(1,2),size2=Vector3.new(0,0,0),radX=math.random(-5,5),radY=math.random(-5,5),radZ=math.random(-5,5),mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
						end
					end
				end))
			end who:ClearAllChildren() who:Destroy()
		end
	end))
end
function AoeDam(Where,Range)
	coroutine.resume(coroutine.create(function()
		if Where ~= nil then
			if typeof(Where) == "CFrame"then Where=Where.p end 
			for index, a in pairs(workspace:GetDescendants()) do
				if (a.Parent ~= MainModel and a.Parent ~= EffectModel and a ~= MainModel and a ~= EffectModel and a ~= cam and a.Parent ~= cam and a ~= script and a.Parent ~= script) and a:IsA'BasePart' then
					if a and a.Parent ~= nil and (a.Parent:IsA("Model") or a.Parent.ClassName == "Model" or a.Parent:IsA("Folder") or a.Parent.ClassName == "Folder") and a.Size == Vector3.new(2,2,1) or a.Size == Vector3.new(2,2.1,1) or a.Size == Vector3.new(1,1.105,1) or a.Size == Vector3.new(1,1.227,1) or a.Size == Vector3.new(1,1.253,1) or a.Size == Vector3.new(1,1.277,1) or a.Size == Vector3.new(1,2,1) or a.Size == Vector3.new(2,1,1) or a.Name == "Head" or a.Name == "Torso" or a.Name == "Right Arm" or a.Name == "Left Arm" or a.Name == "Right Leg" or a.Name == "Left Leg" or a.Name == "UpperTorso" or a.Name == "HumanoidRootPart" or a.Name == "LowerTorso" or a.Name == "RightHand" or a.Name == "LeftHand" or a.Name == "RightFoot" or a.Name == "LeftFoot" or a.Name == "LeftUpperArm" or a.Name == "LeftLowerArm" or a.Name == "RightUpperArm" or a.Name == "RightLowerArm" or a.Name == "LeftUpperLeg" or a.Name == "LeftLowerLeg" or a.Name == "RightUpperLeg" or a.Name == "RightLowerLeg" then
						if (a.Position - Where).Magnitude <= Range+a.Size.Magnitude then
							Kill(a.Parent)
						end
					end
				end
			end
		end
	end))
end
function ClickAttacks()
	attacking=true if flymode==true then walkspeed=0.5 else walkspeed=0.09 end
	repeat game:GetService("RunService").Heartbeat:wait()
		local randomp = math.random(1,5)
		if randomp==1 then
			for i=0,0.75,0.05 do game:GetService("RunService").Heartbeat:wait()
				alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(110),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(70),math.rad(0)),CFrame.new(-1,0+0.025*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(25+1*math.cos(sn/8)),math.rad(-10-1*math.cos(sn/8)),math.rad(30)),
					CFrame.new(1,0.75+0.075*math.sin(sn/8),-1)*CFrame.Angles(math.rad(90),math.rad(-15+1*math.cos(sn/8)),math.rad(-45-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
			end
			AoeDam(ra.CFrame*CFrame.new(0,-1,0),3)
			Sound(swooshSounds[math.random(1,#swooshSounds)],ra,2,math.random(8,12)/10,true)
			for i=0,0.75,0.1 do game:GetService("RunService").Heartbeat:wait()
				Effect({cf=ra.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=ra.Size,size2=ra.Size,radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
				alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(260),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(-80),math.rad(0)),CFrame.new(-1.5,0+0.025*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(25+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-15)),
					CFrame.new(2,0.5+0.075*math.sin(sn/8),0)*CFrame.Angles(math.rad(90),math.rad(0+1*math.cos(sn/8)),math.rad(80-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},1)
			end
			AoeDam(ra.CFrame*CFrame.new(0,-1,0),3)
		elseif randomp==2 then
			for i=0,0.75,0.05 do game:GetService("RunService").Heartbeat:wait()
				alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(250),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(-70),math.rad(0)),CFrame.new(-1,0.75+0.025*math.sin(sn/8),-1)*CFrame.Angles(math.rad(90+1*math.cos(sn/8)),math.rad(15-1*math.cos(sn/8)),math.rad(45)),
					CFrame.new(1,0.+0.075*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(25),math.rad(10+1*math.cos(sn/8)),math.rad(-30-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
			end
			AoeDam(la.CFrame*CFrame.new(0,-1,0),3)
			Sound(swooshSounds[math.random(1,#swooshSounds)],la,2,math.random(8,12)/10,true)
			for i=0,0.75,0.1 do game:GetService("RunService").Heartbeat:wait()
				Effect({cf=la.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=la.Size,size2=la.Size,radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
				alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(100),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(80),math.rad(0)),CFrame.new(-2,0.5+0.025*math.sin(sn/8),0)*CFrame.Angles(math.rad(90+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-80)),
					CFrame.new(1.5,0+0.075*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(25),math.rad(0+1*math.cos(sn/8)),math.rad(15-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},1)
			end
			AoeDam(la.CFrame*CFrame.new(0,-1,0),3)
		elseif randomp==3 and math.random(1,100) <= 45 then
			for i=0,0.75,0.025 do game:GetService("RunService").Heartbeat:wait()
				alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(270),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(-90),math.rad(0)),CFrame.new(-1.5,0+0.025*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(25+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-15)),
					CFrame.new(2,0.5+0.075*math.sin(sn/8),0)*CFrame.Angles(math.rad(90),math.rad(0+1*math.cos(sn/8)),math.rad(90-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
			end
			local pos=ra.CFrame
			Effect({cf=pos*CFrame.new(0,-1,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,100),size=Vector3.new(2,2,2),size2=Vector3.new(5,5,5),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,12)/10,id=231917784,bmr=true,sbm=20,mbm=0})
			Effect({cf=pos*CFrame.new(0,-1,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(1,1,1),size2=Vector3.new(7,7,7),radX=math.random(-7,7),radY=math.random(-7,7),radZ=math.random(-7,7),mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=0})
			AoeDam(pos*CFrame.new(0,-1,0),7)
			for i=1,math.random(2,5) do
				Effect({cf=pos*CFrame.new(0,-1,0)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=pos*CFrame.new(0,-1,0)*CFrame.new(math.random(-7,7),math.random(-7,-1),math.random(-7,7)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(1,1,5),size2=Vector3.new(0,0,5),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
			end
			local ran = math.random(7,17)
			spawn(function() for i=1,ran do game:GetService("RunService").Heartbeat:wait()
					if i~=ran then
						Effect({cf=pos*CFrame.new(0,-1-(i*5),0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(1,1,1),size2=Vector3.new(7,7,7),radX=math.random(-7,7),radY=math.random(-7,7),radZ=math.random(-7,7),mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=0})
						Effect({cf=pos*CFrame.new(0,-1-(i*5),0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,100),size=Vector3.new(2,2,2),size2=Vector3.new(5,5,5),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,12)/10,id=231917784,bmr=true,sbm=20,mbm=0})
						AoeDam(pos*CFrame.new(0,-1-(i*5),0),7)
						for a=1,math.random(2,3) do
							Effect({cf=pos*CFrame.new(0,-1-(i*5),0)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=pos*CFrame.new(0,-1-(i*5),0)*CFrame.new(math.random(-7,7),math.random(-7,7),math.random(-7,7)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(0.5,0.5,5),size2=Vector3.new(0,0,5),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
						end
					else
						Effect({cf=pos*CFrame.new(0,-1-(i*5),0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(4,4,4),size2=Vector3.new(13,13,13),radX=math.random(-7,7),radY=math.random(-7,7),radZ=math.random(-7,7),mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=0})
						Effect({cf=pos*CFrame.new(0,-1-(i*5),0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,100),size=Vector3.new(2,2,2),size2=Vector3.new(15,15,15),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,12)/10,id=231917784,bmr=true,sbm=20,mbm=0})
						AoeDam(pos*CFrame.new(0,-1-(i*5),0),13)
						for a=1,math.random(5,9) do
							Effect({cf=pos*CFrame.new(0,-1-(i*5),0)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=pos*CFrame.new(0,-1-(i*5),0)*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(2,2,7),size2=Vector3.new(3,3,7),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=30,mbm=0})
							LightningBolt({startp=pos*CFrame.new(0,-1-(i*5),0),endp=pos*CFrame.new(0,-1-(i*5),0)*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),rdm=3,ss=2,tran=100,clr=maincolor,clr2=maincolor2,mesh="Cylinder",parts=true,wait=0,size=3,size2=0,crtn=true})
						end
					end
				end end)
		elseif randomp==4 and math.random(1,100) <= 35 then
			for i=0,0.75,0.025 do game:GetService("RunService").Heartbeat:wait()
				alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(90),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(90),math.rad(0)),CFrame.new(-2,0.5+0.025*math.sin(sn/8),0)*CFrame.Angles(math.rad(90+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-90)),
					CFrame.new(1.5,0+0.075*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(25),math.rad(0+1*math.cos(sn/8)),math.rad(15-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
			end
			local pos=la.CFrame
			Effect({cf=pos*CFrame.new(0,-1,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,100),size=Vector3.new(2,2,2),size2=Vector3.new(5,5,5),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,12)/10,id=231917784,bmr=true,sbm=20,mbm=0})
			Effect({cf=pos*CFrame.new(0,-1,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(1,1,1),size2=Vector3.new(7,7,7),radX=math.random(-7,7),radY=math.random(-7,7),radZ=math.random(-7,7),mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=0})
			AoeDam(pos*CFrame.new(0,-1,0),7)
			for i=1,math.random(2,5) do
				Effect({cf=pos*CFrame.new(0,-1,0)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=pos*CFrame.new(0,-1,0)*CFrame.new(math.random(-7,7),math.random(-7,-1),math.random(-7,7)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(1,1,5),size2=Vector3.new(0,0,5),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
			end
			local ran = math.random(2,8)
			spawn(function() for i=1,ran do game:GetService("RunService").Heartbeat:wait()
					if i~=ran then
						Effect({cf=pos*CFrame.new(0,-1-(i*5),0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(1,1,1),size2=Vector3.new(7,7,7),radX=math.random(-7,7),radY=math.random(-7,7),radZ=math.random(-7,7),mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=0})
						Effect({cf=pos*CFrame.new(0,-1-(i*5),0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,100),size=Vector3.new(2,2,2),size2=Vector3.new(5,5,5),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,12)/10,id=231917784,bmr=true,sbm=20,mbm=0})
						AoeDam(pos*CFrame.new(0,-1-(i*5),0),7)
						for a=1,math.random(2,3) do
							Effect({cf=pos*CFrame.new(0,-1-(i*5),0)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=pos*CFrame.new(0,-1-(i*5),0)*CFrame.new(math.random(-7,7),math.random(-7,7),math.random(-7,7)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(0.5,0.5,5),size2=Vector3.new(0,0,5),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
						end
					else
						Effect({cf=pos*CFrame.new(0,-1-(i*5),0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(4,4,4),size2=Vector3.new(13,13,13),radX=math.random(-7,7),radY=math.random(-7,7),radZ=math.random(-7,7),mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=0})
						Effect({cf=pos*CFrame.new(0,-1-(i*5),0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,100),size=Vector3.new(2,2,2),size2=Vector3.new(15,15,15),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,12)/10,id=231917784,bmr=true,sbm=20,mbm=0})
						AoeDam(pos*CFrame.new(0,-1-(i*5),0),13)
						for a=1,math.random(5,9) do
							Effect({cf=pos*CFrame.new(0,-1-(i*5),0)*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=pos*CFrame.new(0,-1-(i*5),0)*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(2,2,7),size2=Vector3.new(3,3,7),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=30,mbm=0})
							LightningBolt({startp=pos*CFrame.new(0,-1-(i*5),0),endp=pos*CFrame.new(0,-1-(i*5),0)*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),rdm=3,ss=2,tran=100,clr=maincolor,clr2=maincolor2,mesh="Cylinder",parts=true,wait=0,size=3,size2=0,crtn=true})
						end
					end
				end end)
		elseif randomp==5 and math.random(1,100) <= 25 then
			for i=0,0.75,0.025 do game:GetService("RunService").Heartbeat:wait()
				alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(150),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(30),math.rad(0)),CFrame.new(-0.5,0.25+0.025*math.sin(sn/8),-0.75)*CFrame.Angles(math.rad(70+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(80)),
					CFrame.new(1.5,0+0.075*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(25),math.rad(0+1*math.cos(sn/8)),math.rad(15-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
			end
			spawn(function() for i=1,5 do
					local bullet=InstanceNW("Part",{Parent=EffectModel,Size=Vector3.new(5,0.5,5),Material="Neon",Color=maincolor,Anchored=true,CanCollide=false,CFrame=MainPosition*CFrame.new(0,1,5),Transparency=0}) Instance.new("SpecialMesh",bullet).MeshType="Sphere"
					spawn(function()
						bullet.CFrame=CFrame.new(bullet.Position,Mouse.Hit*CFrame.new(-45+(i*15),0,0).p)
						for i=1,100 do game:GetService("RunService").Heartbeat:wait()
							bullet.CFrame=bullet.CFrame*CFrame.new(0,0,-3)
							Effect({cf=bullet.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,50),size=bullet.Size,size2=bullet.Size*1.05,radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=80,mbm=0})
							local o,h=r(bullet.CFrame.p,bullet.CFrame.lookVector,3,{MainModel,EffectModel,cam})
							if o then
								break
							end
						end
						Effect({cf=bullet.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(6,6,6),size2=Vector3.new(2,2,2),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,12)/10,id=183763506,bmr=true,sbm=40,mbm=0})
						Effect({cf=bullet.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,175),size=Vector3.new(2,2,2),size2=Vector3.new(12,12,12),radX=math.random(-250,250)/100,radY=math.random(-250,250)/100,radZ=math.random(-250,250)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(6,8)/10,id=178452221,bmr=true,sbm=10,mbm=0})
						for i=1,3 do
							LightningBolt({startp=bullet.CFrame,endp=bullet.CFrame*CFrame.new(math.random(-25,25),math.random(-25,25),math.random(-25,25)),rdm=1,ss=5,tran=math.random(50,125),clr=maincolor,clr2=maincolor2,mesh="Cylinder",parts=true,wait=0.01,size=1,size2=2,crtn=true})
							Effect({cf=bullet.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,75),size=Vector3.new(4,4,4),size2=Vector3.new(0,20,0),radX=math.random(-250,250)/100,radY=math.random(-250,250)/100,radZ=math.random(-250,250)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=40,mbm=0})
						end
						AoeDam(bullet.CFrame,7)
						bullet:Destroy()
					end)
				end end)
			for i=0,0.75,0.025 do game:GetService("RunService").Heartbeat:wait()
				alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(260),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(-80),math.rad(0)),CFrame.new(-2,0.5+0.025*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(110+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-80)),
					CFrame.new(1.5,0+0.075*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(25),math.rad(0+1*math.cos(sn/8)),math.rad(15-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
			end
		end
	until repeatmouse==false
	attacking=false if flymode==true then walkspeed=1 else walkspeed=0.22 end
end
function ModeOne_AttackOne()
	attacking=true if flymode==true then walkspeed=0.1 else walkspeed=0.01 end
	Sound(4299626396,ra,2,math.random(8,12)/10,true)
	local bullet=InstanceNW("Part",{Parent=EffectModel,Size=Vector3.new(0,0,0),Material="Neon",Color=maincolor,Anchored=true,CanCollide=false,CFrame=ra.CFrame*CFrame.new(0,-1,0),Transparency=0}) Instance.new("SpecialMesh",bullet).MeshType="Sphere"
	for i=0,1.5,0.025 do game:GetService("RunService").Heartbeat:wait()
		Effect({cf=bullet.CFrame*CFrame.new(math.random(-25,25),math.random(-25,25),math.random(-25,25)),moveto=bullet.CFrame,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(15,25),size=Vector3.new(0.5,0.5,2),size2=Vector3.new(0,0,2),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
		bullet.CFrame=ra.CFrame*CFrame.new(0,-1-(bullet.Size.Z),0)
		bullet.Size=Vector3.new(i*3+0.5,i*3+0.5,i*3+0.5)
		alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(110),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(70),math.rad(0)),CFrame.new(-1.5,0+0.025*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(30+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-20)),
			CFrame.new(1.5,1+0.075*math.sin(sn/8),0.5)*CFrame.Angles(math.rad(230),math.rad(0+1*math.cos(sn/8)),math.rad(60-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
	end
	for i=0,0.75,0.05 do game:GetService("RunService").Heartbeat:wait()
		bullet.CFrame=ra.CFrame*CFrame.new(0,-1-(bullet.Size.Z),0)
		alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(270),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(-90),math.rad(0)),CFrame.new(-1.75,0+0.025*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(50+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-50)),
			CFrame.new(2,0.5+0.075*math.sin(sn/8),0)*CFrame.Angles(math.rad(90),math.rad(0+1*math.cos(sn/8)),math.rad(90-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
	end
	bullet.CFrame=CFrame.new(bullet.Position,Mouse.Hit.p)
	spawn(function()
		local foundpart=nil
		for i=1,1000 do game:GetService("RunService").Heartbeat:wait()
			bullet.CFrame=bullet.CFrame*CFrame.new(0,0,-2+1.5*math.cos(sn/12))
			bullet.Size=Vector3.new(5-1*math.cos(sn/4),5-1*math.cos(sn/4),5-1*math.cos(sn/4))
			if foundpart~=nil then bullet.CFrame=bullet.CFrame:lerp(CFrame.new(bullet.Position,foundpart.Position),.2) end
			Effect({cf=bullet.CFrame*CFrame.new(math.random(-bullet.Size.X,bullet.Size.X)/2,math.random(-bullet.Size.Y,bullet.Size.Y)/2,math.random(-bullet.Size.Z,bullet.Size.Z)/2),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,75),size=bullet.Size/2,size2=Vector3.new(0,0,0),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
			if math.random(1,25) == 1 then
				local bullet2=InstanceNW("Part",{Parent=EffectModel,Size=Vector3.new(0.25,0.25,2),Material="Neon",Color=maincolor,Anchored=true,CanCollide=false,CFrame=bullet.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),Transparency=0}) Instance.new("SpecialMesh",bullet).MeshType="Sphere"
				spawn(function()
					for i=1,100 do game:GetService("RunService").Heartbeat:wait()
						bullet2.CFrame=bullet2.CFrame*CFrame.new(0,0,-2)
						Effect({cf=bullet2.CFrame,moveto=bullet2.CFrame*CFrame.new(math.random(-2,2),math.random(-2,2),math.random(2,5)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(15,25),size=bullet2.Size,size2=Vector3.new(0,0,bullet2.Size.Z),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
						local o,h=r(bullet2.CFrame.p,bullet2.CFrame.lookVector,2,{MainModel,EffectModel,cam})
						if o then
							break
						end
					end
					Effect({cf=bullet2.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,100),size=Vector3.new(2,2,2),size2=Vector3.new(6,6,6),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(9,11)/10,id=4299512779,bmr=true,sbm=30,mbm=0})
					Effect({cf=bullet2.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,75),size=Vector3.new(1,1,1),size2=Vector3.new(8,8,8),radX=math.random(-500,500)/100,radY=math.random(-500,500)/100,radZ=math.random(-500,500)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=0})
					for i=1,math.random(1,3) do
						Effect({cf=bullet2.CFrame,moveto=bullet2.CFrame*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,200),size=Vector3.new(1,1,6),size2=Vector3.new(2,2,8),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=60,mbm=0})
					end
					AoeDam(bullet2.Position,5)
					bullet2:Destroy()			
				end)
			end
			local o,h=r(bullet.CFrame.p,bullet.CFrame.lookVector,2-1.5*math.cos(sn/12),{MainModel,EffectModel,cam})
			if o then
				break
			elseif o==nil and foundpart==nil then
				for index, a in pairs(workspace:GetDescendants()) do
					if (a.Parent ~= MainModel and a.Parent ~= EffectModel and a ~= MainModel and a ~= EffectModel and a ~= cam and a.Parent ~= cam and a ~= script and a.Parent ~= script) and a:IsA'BasePart' then
						if a and a.Parent ~= nil and (a.Parent:IsA("Model") or a.Parent.ClassName == "Model" or a.Parent:IsA("Folder") or a.Parent.ClassName == "Folder") and a.Size == Vector3.new(2,2,1) or a.Size == Vector3.new(2,2.1,1) or a.Size == Vector3.new(1,1.105,1) or a.Size == Vector3.new(1,1.227,1) or a.Size == Vector3.new(1,1.253,1) or a.Size == Vector3.new(1,1.277,1) or a.Size == Vector3.new(1,2,1) or a.Size == Vector3.new(2,1,1) or a.Name == "Head" or a.Name == "Torso" or a.Name == "Right Arm" or a.Name == "Left Arm" or a.Name == "Right Leg" or a.Name == "Left Leg" or a.Name == "UpperTorso" or a.Name == "HumanoidRootPart" or a.Name == "LowerTorso" or a.Name == "RightHand" or a.Name == "LeftHand" or a.Name == "RightFoot" or a.Name == "LeftFoot" or a.Name == "LeftUpperArm" or a.Name == "LeftLowerArm" or a.Name == "RightUpperArm" or a.Name == "RightLowerArm" or a.Name == "LeftUpperLeg" or a.Name == "LeftLowerLeg" or a.Name == "RightUpperLeg" or a.Name == "RightLowerLeg" then
							if (a.Position - bullet.Position).Magnitude <= 40+a.Size.Magnitude then
								foundpart=a
							end
						end
					end
				end
			end
		end
		Effect({cf=bullet.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,200),size=Vector3.new(5,5,5),size2=Vector3.new(11,11,11),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(6,8)/10,id=3750956745,bmr=true,sbm=30,mbm=0})
		Effect({cf=bullet.CFrame,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(50,125),size=Vector3.new(1,1,1),size2=Vector3.new(14,14,14),radX=math.random(-500,500)/100,radY=math.random(-500,500)/100,radZ=math.random(-500,500)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=50,mbm=0})
		for i=1,math.random(2,4) do
			Effect({cf=bullet.CFrame,moveto=bullet.CFrame*CFrame.new(math.random(-35,35),math.random(-35,35),math.random(-35,35)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,200),size=Vector3.new(3,3,10),size2=Vector3.new(4,4,12),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=60,mbm=0})
			LightningBolt({startp=bullet.CFrame,endp=bullet.CFrame*CFrame.new(math.random(-55,55),math.random(-55,55),math.random(-55,55)),rdm=3,ss=5,tran=math.random(25,75),clr=maincolor,clr2=maincolor2,mesh="Cylinder",parts=true,wait=0.01,size=2,size2=0,crtn=true})
		end
		AoeDam(bullet.Position,25)
		bullet:Destroy()	
	end)
	attacking=false if flymode==true then walkspeed=1 else walkspeed=0.22 end
end
function ModeOne_AttackTwo()
	attacking=true if flymode==true then walkspeed=0.1 else walkspeed=0.01 end
	Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,125),size=Vector3.new(21,21,21),size2=Vector3.new(0,0,0),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=1,tran2=0,pls=true,vol=2,pit=math.random(9,11)/10,id=3744392667,bmr=false,sbm=0,mbm=0})
	for i=0,0.75,0.01 do game:GetService("RunService").Heartbeat:wait()
		if math.random(1,2)==1 then
			LightningBolt({startp=MainPosition*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),endp=MainPosition,rdm=2,ss=2,tran=math.random(25,75),clr=maincolor,clr2=maincolor2,mesh="Cylinder",parts=true,wait=0.01,size=1,size2=0,crtn=true})
		end
		alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(20-1*math.cos(sn/8)),math.rad(180),math.rad(0)),CFrame.new(0,1.5,-0.25)*CFrame.Angles(math.rad(-30-1*math.cos(sn/8)),math.rad(0),math.rad(0)),CFrame.new(-0.5,0+0.025*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(50+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(50)),
			CFrame.new(0.5,0+0.075*math.sin(sn/8),-0.5)*CFrame.Angles(math.rad(40),math.rad(0+1*math.cos(sn/8)),math.rad(-60-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.45)*CFrame.Angles(math.rad(20-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),-0.25)*CFrame.Angles(math.rad(15-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
	end
	Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,175),size=Vector3.new(4,4,4),size2=Vector3.new(21,21,21),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,10)/10,id=4299510970,bmr=true,sbm=30,mbm=0})
	Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(1,1,1),size2=Vector3.new(14,14,14),radX=math.random(-1000,1000)/100,radY=math.random(-1000,1000)/100,radZ=math.random(-1000,1000)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=70,mbm=0})
	AoeDam(MainPosition,14)
	for i=0,1.5,0.025 do game:GetService("RunService").Heartbeat:wait()
		if math.random(1,2)==1 then
			Effect({cf=MainPosition,moveto=MainPosition*CFrame.new(math.random(-55,55),math.random(-55,55),math.random(-55,55)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,75),size=Vector3.new(0,0,4),size2=Vector3.new(1,1,6),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
			LightningBolt({startp=MainPosition,endp=MainPosition*CFrame.new(math.random(-55,55),math.random(-55,55),math.random(-55,55)),rdm=2,ss=5,tran=math.random(5,15),clr=maincolor,clr2=maincolor2,mesh="Cylinder",parts=true,wait=0,size=1,size2=2,crtn=true})
		end
		local ran = MainPosition*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15))
		Effect({cf=ran,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,75),size=Vector3.new(2,2,2),size2=Vector3.new(5,5,5),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(8,10)/10,id=4299512229,bmr=true,sbm=30,mbm=0})
		Effect({cf=ran,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(50,75),size=Vector3.new(1,1,1),size2=Vector3.new(4,4,4),radX=math.random(-500,500)/100,radY=math.random(-500,500)/100,radZ=math.random(-500,500)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=70,mbm=0})
		AoeDam(ran,5)
		alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(180),math.rad(0)),CFrame.new(0,1.5,0)*CFrame.Angles(math.rad(10-1*math.cos(sn/8)),math.rad(0),math.rad(0)),CFrame.new(-2,0.5+0.025*math.sin(sn/8),0)*CFrame.Angles(math.rad(90+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-90)),
			CFrame.new(2,0.5+0.075*math.sin(sn/8),0)*CFrame.Angles(math.rad(90),math.rad(0+1*math.cos(sn/8)),math.rad(90-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),0.35)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0.15)*CFrame.Angles(math.rad(-15-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
	end
	attacking=false if flymode==true then walkspeed=1 else walkspeed=0.22 end
end
function ModeOne_AttackThree()
	attacking=true if flymode==true then walkspeed=0.1 else walkspeed=0.01 end
	for i=0,0.75,0.05 do game:GetService("RunService").Heartbeat:wait()
		Effect({cf=la.CFrame*CFrame.new(0,-1,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,75),size=Vector3.new(0.5,0.5,0.5),size2=Vector3.new(1,1,1),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=30,mbm=0})
		Effect({cf=la.CFrame*CFrame.new(0,-1,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(50,75),size=Vector3.new(0,0,0),size2=Vector3.new(0.5,0.5,0.5),radX=math.random(-500,500)/100,radY=math.random(-500,500)/100,radZ=math.random(-500,500)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=70,mbm=0})
		alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(120),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(60),math.rad(0)),CFrame.new(-1.75,1.5+0.025*math.sin(sn/8),0)*CFrame.Angles(math.rad(170+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-30)),
			CFrame.new(1.6,0+0.075*math.sin(sn/8),-0.1)*CFrame.Angles(math.rad(30),math.rad(0+1*math.cos(sn/8)),math.rad(10-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
	end
	Effect({cf=la.CFrame*CFrame.new(0,-3,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,75),size=Vector3.new(2,2,2),size2=Vector3.new(5,5,5),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(7,13)/10,id=4299512490,bmr=true,sbm=30,mbm=0})
	Effect({cf=la.CFrame*CFrame.new(0,-3,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(50,75),size=Vector3.new(1,1,1),size2=Vector3.new(4,4,4),radX=math.random(-500,500)/100,radY=math.random(-500,500)/100,radZ=math.random(-500,500)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=70,mbm=0})
	for i=1,math.random(5,7) do
		Effect({cf=la.CFrame*CFrame.new(0,-3,0),moveto=la.CFrame*CFrame.new(0,-3,0)*CFrame.new(math.random(-5,5),math.random(-5,5),math.random(-5,5)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,75),size=Vector3.new(0,0,2),size2=Vector3.new(2,2,4),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
		LightningBolt({startp=la.CFrame*CFrame.new(0,-3,0),endp=la.CFrame*CFrame.new(0,-3,0)*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),rdm=1,ss=2,tran=math.random(25,50),clr=maincolor,clr2=maincolor2,mesh="Cylinder",parts=true,wait=0.001,size=1,size2=0,crtn=true})
	end
	local o,h=r(Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+1000,Mouse.Hit.Z),Vector3.new(Mouse.Hit.X,Mouse.Hit.Y,Mouse.Hit.Z)-Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+1000,Mouse.Hit.Z),1000,{MainModel,cam})
	Effect({cf=CFrame.new(h)*CFrame.Angles(math.rad(-90),0,0)*CFrame.new(0,0,(Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+1000,Mouse.Hit.Z)-h).magnitude/2),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="C",waits=math.random(50,75),size=Vector3.new((Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+1000,Mouse.Hit.Z)-h).magnitude,11,11),size2=Vector3.new((Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+1000,Mouse.Hit.Z)-h).magnitude,0,0),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
	Effect({cf=CFrame.new(h)*CFrame.new(0,(Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+1000,Mouse.Hit.Z)-h).magnitude/2,0),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(11,(Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+1000,Mouse.Hit.Z)-h).magnitude,11),size2=Vector3.new(13,(Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+1000,Mouse.Hit.Z)-h).magnitude,13),radX=0,radY=math.random(-500,500)/100,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=70,mbm=0})
	for i=1,math.random(4,6) do game:GetService("RunService").Heartbeat:wait()
		Effect({cf=CFrame.new(h),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(100,150),size=Vector3.new(5,5,5)*i,size2=Vector3.new(8,8,8)*i,radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(9,11)/(i/4)/10,id=4299584756,bmr=true,sbm=30,mbm=0})
		Effect({cf=CFrame.new(h),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(75,100),size=Vector3.new(1,1,1),size2=Vector3.new(9,9,9)*i,radX=math.random(-500,500)/100,radY=math.random(-500,500)/100,radZ=math.random(-500,500)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=70,mbm=0})
		for a=1,2 do
			LightningBolt({startp=h,endp=CFrame.new(h)*CFrame.new(math.random(-75,75),math.random(-75,75),math.random(-75,75)),rdm=3,ss=5,tran=math.random(25,50),clr=maincolor,clr2=maincolor2,mesh="Cylinder",parts=true,wait=0.001,size=20,size2=0,crtn=true})
			Effect({cf=CFrame.new(h),moveto=CFrame.new(h)*CFrame.new(math.random(-75,75),math.random(-75,75),math.random(-75,75)),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,125),size=Vector3.new(4,4,4),size2=Vector3.new(0,0,8),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
		end
		AoeDam(h,6*i)
	end
	for i=0,0.75,0.05 do game:GetService("RunService").Heartbeat:wait()
		alerp({CFrame.new(0,0+0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(100),math.rad(0)),CFrame.new(0,1.5,-0.15)*CFrame.Angles(math.rad(-10-1*math.cos(sn/8)),math.rad(80),math.rad(0)),CFrame.new(-1.75,0+0.025*math.sin(sn/8),0)*CFrame.Angles(math.rad(30+1*math.cos(sn/8)),math.rad(0-1*math.cos(sn/8)),math.rad(-60)),
			CFrame.new(1.6,0+0.075*math.sin(sn/8),-0.1)*CFrame.Angles(math.rad(30),math.rad(0+1*math.cos(sn/8)),math.rad(10-1*math.cos(sn/8))),CFrame.new(-.5,-2-0.1*math.sin(sn/8),-0.15)*CFrame.Angles(math.rad(0-1*math.cos(sn/8)),math.rad(20),math.rad(0)),CFrame.new(.5,-2-0.1*math.sin(sn/8),0)*CFrame.Angles(math.rad(-5-1*math.cos(sn/8)),math.rad(-10),math.rad(0))},.2)
	end
	attacking=false if flymode==true then walkspeed=1 else walkspeed=0.22 end
end
function Blink()
	attacking=true if flymode==true then walkspeed=0.1 else walkspeed=0.01 end
	for i=1,math.random(4,7) do
		local pos=MainPosition*CFrame.new(math.random(-2,2),math.random(-2,2),math.random(-2,2))
		local pos2=Vector3.new(Mouse.Hit.X+math.random(-2,2),Mouse.Hit.Y+3+math.random(-2,2),Mouse.Hit.Z+math.random(-2,2))
		Effect({cf=CFrame.new(pos.p,pos2)*CFrame.new(0,0,-(pos.p-pos2).magnitude/2),moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(2,2,(pos.p-pos2).magnitude),size2=Vector3.new(0,0,(pos.p-pos2).magnitude),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
	end
	MainPosition=CFrame.new(Vector3.new(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z))
	Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(50,100),size=Vector3.new(5,5,5),size2=Vector3.new(9,9,9),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=true,vol=2,pit=math.random(7,13)/10,id=4085858772,bmr=true,sbm=60,mbm=0})
	Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,75),size=Vector3.new(1,1,1),size2=Vector3.new(11,11,11),radX=math.random(-500,500)/100,radY=math.random(-500,500)/100,radZ=math.random(-500,500)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=20,mbm=0})
	attacking=false if flymode==true then walkspeed=1 else walkspeed=0.22 end
end
Mouse.Button1Down:connect(function()
	repeatmouse = true
	if attacking == false then
		ClickAttacks()
	end
end)
Mouse.Button1Up:connect(function()
	repeatmouse = false
end)
Mouse.KeyDown:connect(function(key)
	if stoped == false and game.Players:FindFirstChild(plrr.Name) then repeatkey=true
		if key == "w" then
			W=true 
		elseif key == "a" then
			A=true 
		elseif key == "s" then
			S=true 
		elseif key == "d" then
			D=true
		elseif key == "space" or key == "j" then
			if falling == false then
				falling=true MainPosition=MainPosition*CFrame.new(0,2,0)fallingspeed=fallingspeed-1
			end
		elseif key == "e" and attacking==false and mode==1 then
			ModeOne_AttackOne()
		elseif key == "f" and attacking==false and mode==1 then
			ModeOne_AttackTwo()
		elseif key == "r" and attacking==false and mode==1 then
			ModeOne_AttackThree()
		elseif key == "one" and attacking==false then
			if mode==1 then mode=lastmode 
				if mode==2 then
					maincolor=Color3.new(0,0,0)maincolor2=Color3.new(1,1,1)mode=2 lastmode=mode musid=13048663695
					for i=1,math.random(7,13) do
						Effect({cf=MainPosition*CFrame.new(math.random(-35,35),math.random(-35,35),math.random(-35,35)),moveto=MainPosition,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(0,0,0),size2=Vector3.new(2,2,2),radX=math.random(-1000,1000)/100,radY=math.random(-1000,1000)/100,radZ=math.random(-1000,1000)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
					end
				elseif mode==3 then
					maincolor=Color3.fromRGB(75,25,115)maincolor2=Color3.fromRGB(200,200,200)mode=3 lastmode=mode musid=13048663695
					spawn(function()
						for i=1,math.random(7,11) do for i=1,math.random(1,5) do game:GetService("RunService").Heartbeat:wait() end
							local pos=MainPosition*CFrame.new(math.random(-15,15),math.random(0,10),math.random(-15,15))
							Effect({cf=pos,moveto=pos*CFrame.new(0,-5,0),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(2,2,2),size2=Vector3.new(0,0,0),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
						end
					end)
				elseif mode==4 then
					maincolor=Color3.fromRGB(150,150,15)maincolor2=Color3.fromRGB(100,200,0)mode=4 lastmode=mode musid=13048663695
					local pos=MainPosition*CFrame.new(0,-2,0)
					for i=1,math.random(7,11) do
						Effect({cf=pos*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=pos*CFrame.new(math.random(-2,2),math.random(5,10),math.random(-2,2)),clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(50,75),size=Vector3.new(4,4,4),size2=Vector3.new(0,0,0),radX=math.random(-1000,1000)/100,radY=math.random(-1000,1000)/100,radZ=math.random(-1000,1000)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
					end
				elseif mode==5 then
					maincolor=Color3.fromRGB(25,150,150)maincolor2=Color3.fromRGB(0,0,255)mode=5 lastmode=mode musid=4447465339
					for i=1,math.random(3,6) do
						Effect({cf=MainPosition*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),moveto=MainPosition,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,50),size=Vector3.new(1,1,4),size2=Vector3.new(1,1,0),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
					end
				end
			else 
				maincolor=Color3.fromRGB(155,15,15)maincolor2=Color3.fromRGB(0,0,0) mode=1 musid=2970853819
				Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,50),size=Vector3.new(0,0,0),size2=Vector3.new(8,8,8),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=40,mbm=0})
			end
		elseif key == "two" and attacking==false then
			if mode==2 then 
				maincolor=Color3.fromRGB(155,15,15)maincolor2=Color3.fromRGB(0,0,0) mode=1 musid=13048663265
				Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,50),size=Vector3.new(0,0,0),size2=Vector3.new(8,8,8),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=40,mbm=0})
			else 
				maincolor=Color3.new(0,0,0)maincolor2=Color3.new(1,1,1)mode=2 lastmode=mode musid=13048663265
				for i=1,math.random(7,13) do
					Effect({cf=MainPosition*CFrame.new(math.random(-35,35),math.random(-35,35),math.random(-35,35)),moveto=MainPosition,clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(25,50),size=Vector3.new(0,0,0),size2=Vector3.new(2,2,2),radX=math.random(-1000,1000)/100,radY=math.random(-1000,1000)/100,radZ=math.random(-1000,1000)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
				end
			end
		elseif key == "three" and attacking==false then
			if mode==3 then
				maincolor=Color3.fromRGB(155,15,15)maincolor2=Color3.fromRGB(0,0,0) mode=1 musid=1205762052
				Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,50),size=Vector3.new(0,0,0),size2=Vector3.new(8,8,8),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=40,mbm=0})
			else
				maincolor=Color3.fromRGB(75,25,115)maincolor2=Color3.fromRGB(200,200,200)mode=3 lastmode=mode musid=1205762052
				spawn(function()
					for i=1,math.random(7,11) do for i=1,math.random(1,5) do game:GetService("RunService").Heartbeat:wait() end
						local pos=MainPosition*CFrame.new(math.random(-15,15),math.random(0,10),math.random(-15,15))
						Effect({cf=pos,moveto=pos*CFrame.new(0,-5,0),clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(75,125),size=Vector3.new(2,2,2),size2=Vector3.new(0,0,0),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
					end
				end)
			end
		elseif key == "four" and attacking==false then
			if mode==4 then 
				maincolor=Color3.fromRGB(155,15,15)maincolor2=Color3.fromRGB(0,0,0) mode=1 musid=13048662144
				Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,50),size=Vector3.new(0,0,0),size2=Vector3.new(8,8,8),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=40,mbm=0})
			else
				maincolor=Color3.fromRGB(150,150,15)maincolor2=Color3.fromRGB(100,200,0)mode=4 lastmode=mode musid=13048662144
				local pos=MainPosition*CFrame.new(0,-2,0)
				for i=1,math.random(7,11) do
					Effect({cf=pos*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))),moveto=pos*CFrame.new(math.random(-2,2),math.random(5,10),math.random(-2,2)),clr=maincolor,clr2=maincolor2,mtype="B",waits=math.random(50,75),size=Vector3.new(4,4,4),size2=Vector3.new(0,0,0),radX=math.random(-1000,1000)/100,radY=math.random(-1000,1000)/100,radZ=math.random(-1000,1000)/100,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
				end
			end
		elseif key == "five" and attacking==false then
			if mode==5 then
				maincolor=Color3.fromRGB(155,15,15)maincolor2=Color3.fromRGB(0,0,0) mode=1 musid=13048664612
				Effect({cf=MainPosition,moveto=nil,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,50),size=Vector3.new(0,0,0),size2=Vector3.new(8,8,8),radX=0,radY=0,radZ=0,mat="Neon",lock=false,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=true,sbm=40,mbm=0})
			else
				maincolor=Color3.fromRGB(25,150,150)maincolor2=Color3.fromRGB(0,0,255)mode=5 lastmode=mode musid=13048664612
				for i=1,math.random(3,6) do
					Effect({cf=MainPosition*CFrame.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)),moveto=MainPosition,clr=maincolor,clr2=maincolor2,mtype="S",waits=math.random(25,50),size=Vector3.new(1,1,4),size2=Vector3.new(1,1,0),radX=0,radY=0,radZ=0,mat="Neon",lock=true,tran=0,tran2=1,pls=false,vol=0,pit=0,id=nil,bmr=false,sbm=0,mbm=0})
				end
			end
		elseif key == "q" and attacking==false then
			Blink()
		elseif key == "p" then
			MainModel:Destroy()
		elseif key == "l" then
			stopeffects=true EffectModel:ClearAllChildren() wait() stopeffects=false
		elseif key == "m" then
			playmus = not playmus
		elseif key == "k" then
			wings = not wings
		elseif key == "n" and attacking==false then
			if flymode == false then flymode=true walkspeed=1 fallingspeed=0 else flymode=false walkspeed=0.22 MainPosition=CFrame.new(MainPosition.p,Vector3.new(MainPosition.X,MainPosition.Y,MainPosition.Z+1)) end
		end
	end
end)

Mouse.KeyUp:connect(function(key)
	if stoped == false and game.Players:FindFirstChild(plrr.Name) then
		if key=="w" then 
			W=false 
		elseif key=="a" then
			A=false
		elseif key=="s" then
			S=false
		elseif key=="d" then
			D=false
		end
	end
end)