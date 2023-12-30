local assetsload = LoadAssets(15811996920)
local assets = assetsload:Get("unex")

assets.Player.Parent = script

local unexstr = [==[
local unexcli = [=[local me = game:service'Players'.localPlayer;
local mouse = me:GetMouse();
local UIS = game:service'UserInputService'
local ch = workspace:WaitForChild(me.Name);
camera = workspace.CurrentCamera
camera.CameraSubject = me.Character.Humanoid
local UserEvent = ch:WaitForChild('UserInputEvent',30)

UIS.InputChanged:connect(function(io,gpe)
	if(io.UserInputType == Enum.UserInputType.MouseMovement)then
		UserEvent:FireServer{Mouse=true,Target=mouse.Target,Hit=mouse.Hit}
	end
end)

mouse.Changed:connect(function(o)
	if(o == 'Target' or o == 'Hit')then
		UserEvent:FireServer{Mouse=true,Target=mouse.Target,Hit=mouse.Hit}
	end
end)

UIS.InputBegan:connect(function(io,gpe)
	if(gpe)then return end
	UserEvent:FireServer{InputObject=true,KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState}
end)

UIS.InputEnded:connect(function(io,gpe)
	if(gpe)then return end
	UserEvent:FireServer{InputObject=true,KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState}
end)

mouse.KeyDown:connect(function(k)
	UserEvent:FireServer{KeyEvent='Down',Key=k}
end)

mouse.KeyUp:connect(function(k)
	UserEvent:FireServer{KeyEvent='Up',Key=k}
end)

local ClientProp = ch:WaitForChild('GetClientProperty',30)

local sounds = {}

--[[
function regSound(o)
	if(o:IsA'Sound')then
		
		local lastLoudness = o.PlaybackLoudness
		ClientProp:InvokeServer(o,lastLoudness)
		table.insert(sounds,{o,lastLoudness})
		--ClientProp:InvokeServer(o,o.PlaybackLoudness)
	end
end
ClientProp.OnClientInvoke = function(inst,prop)
	if(inst == 'RegSound')then
		regSound(prop)
		for i = 1, #sounds do
			 if(sounds[i][1] == prop)then 
				return sounds[i][2]
			end 
		end 
	else
		return inst[prop]
	end
end

for _,v in next, workspace:GetDescendants() do regSound(v) end
workspace.DescendantAdded:connect(regSound)
me.Character.DescendantAdded:connect(regSound)
]]
game:service'RunService'.RenderStepped:connect(function()
	coroutine.wrap(function()
		local HF = script:FindFirstChild("HF")
		if HF then
			local Root = script.Parent:FindFirstChild("HumanoidRootPart")
			if Root and Root:IsA("BasePart") then
				HF:FireServer(workspace:FindPartOnRay(Ray.new(Root.Position, (Root.CFrame * CFrame.Angles(math.rad(-90), 0, 0)).LookVector * 4), script.Parent) ~= nil) -- 749799107957297115101
			end
		end
	end)()
	for i = 1, #sounds do
		local tab = sounds[i]
		local object,last=unpack(tab)
		if(object.PlaybackLoudness ~= last)then
			sounds[i][2]=object.PlaybackLoudness
			ClientProp:InvokeServer(object,sounds[i][2])
		end
	end
end)]=]

lastitem = script:WaitForChild("Player")
Player = lastitem.Value or game:GetService("Players"):GetPlayerFromCharacter(script.Parent)
lastitem.Parent = nil
FakeMouse = NLS(unexcli, Player.Backpack)
HFRem = Instance.new("RemoteEvent", FakeMouse)
HFRem.Name = "HF"

local Mouse,mouse,UserInputService,ContextActionService
do
	local GUID = {}
	do
		GUID.IDs = {};
		function GUID:new(len)
			local id;
			if(not len)then
				id = (tostring(function() end))
				id = id:gsub("function: ","")
			else
				local function genID(len)
					local newID = ""
					for i = 1,len do
						newID = newID..string.Character(math.random(48,90))
					end
					return newID
				end
				repeat id = genID(len) until not GUID.IDs[id]
				local oid = id;
				id = {Trash=function() GUID.IDs[oid]=nil; end;Get=function() return oid; end}
				GUID.IDs[oid]=true;
			end
			return id
		end
	end

	local AHB = Instance.new("BindableEvent")

	local FPS = 60

	local TimeFrame = 0

	local LastFrame = tick()
	local Frame = 1/FPS

	game:service'RunService'.Heartbeat:connect(function(s,p)
		TimeFrame = TimeFrame + s
		if(TimeFrame >= Frame)then
			for i = 1,math.floor(TimeFrame/Frame) do
				AHB:Fire()
			end
			LastFrame=tick()
			TimeFrame=TimeFrame-Frame*math.floor(TimeFrame/Frame)
		end
	end)


	function swait(dur)
		if(dur == 0 or typeof(dur) ~= 'number')then
			AHB.Event:wait()
		else
			for i = 1, dur*FPS do
				AHB.Event:wait()
			end
		end
	end

	local loudnesses={}

	local CoAS = {Actions={}}
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInputEvent"
	Event.Parent = Player.Character
	local Func = Instance.new("RemoteFunction")
	Func.Name = "GetClientProperty"
	Func.Parent = Player.Character
	local fakeEvent = function()
		local t = {_fakeEvent=true,Waited={}}
		t.Connect = function(self,f)
			local ft={Disconnected=false;disconnect=function(s) s.Disconnected=true end}
			ft.Disconnect=ft.disconnect

			ft.Func=function(...)
				for id,_ in next, t.Waited do 
					t.Waited[id] = true 
				end 
				return f(...)
			end; 
			self.Function=ft;
			return ft;
		end
		t.connect = t.Connect
		t.Wait = function() 
			local guid = GUID:new(25)
			local waitingId = guid:Get()
			t.Waited[waitingId]=false
			repeat swait() until t.Waited[waitingId]==true  
			t.Waited[waitingId]=nil;
			guid:Trash()
		end
		t.wait = t.Wait
		return t
	end
	local m = {Target=nil,Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent()}
	local UsIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}

	function CoAS:BindAction(name,fun,touch,...)
		CoAS.Actions[name] = {Name=name,Function=fun,Keys={...}}
	end
	function CoAS:UnbindAction(name)
		CoAS.Actions[name] = nil
	end
	local function te(self,ev,...)
		local t = self[ev]
		if t and t._fakeEvent and t.Function and t.Function.Func and not t.Function.Disconnected then
			t.Function.Func(...)
		elseif t and t._fakeEvent and t.Function and t.Function.Func and t.Function.Disconnected then
			self[ev].Function=nil
		end
	end
	m.TrigEvent = te
	UsIS.TrigEvent = te
	Event.OnServerEvent:Connect(function(plr,io)
		if plr~=Player then return end
		if io.Mouse then
			m.Target = io.Target
			m.Hit = io.Hit
		elseif io.KeyEvent then
			m:TrigEvent('Key'..io.KeyEvent,io.Key)
		elseif io.UserInputType == Enum.UserInputType.MouseButton1 then
			if io.UserInputState == Enum.UserInputState.Begin then
				m:TrigEvent("Button1Down")

			else
				m:TrigEvent("Button1Up")
			end
		end
		if(not io.KeyEvent and not io.Mouse)then
			for n,t in pairs(CoAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			if io.UserInputState == Enum.UserInputState.Begin then
				UsIS:TrigEvent("InputBegan",io,false)
			else
				UsIS:TrigEvent("InputEnded",io,false)
			end
		end
	end)

--[[	Func.OnServerInvoke = function(plr,inst,play)
		if plr~=Player then return end
		if(inst and typeof(inst) == 'Instance' and inst:IsA'Sound')then
			loudnesses[inst]=play	
		end
		function GetClientProperty(inst,prop)
		if(prop == 'PlaybackLoudness' and loudnesses[inst])then 
			return loudnesses[inst] 
		elseif(prop == 'PlaybackLoudness')then
			return Func:InvokeClient(Player,'RegSound',inst)
		end
		return Func:InvokeClient(Player,inst,prop)
		end
	end]]
	Mouse, mouse, UserInputService, ContextActionService = m, m, UsIS, CoAS
end

--Variables
CachedCFrame = lastitem:GetAttribute("LastCFrame")

refreshtime = lastitem:GetAttribute("RefitTime")

CharacterTransparency = 0
NoHats = false
NoFace = false
it = Instance.new
cf = CFrame.new
vt = Vector3.new
rad = math.rad
c3 = Color3.new
--FakeMouse.Parent = script
ud2 = UDim2.new
brickc = BrickColor.new
angles = CFrame.Angles
euler = CFrame.fromEulerAnglesXYZ
cos = math.cos
acos = math.acos
sin = math.sin
asin = math.asin
abs = math.abs
rand = math.random
floor = math.floor
defaultsound = tonumber(lastitem:GetAttribute("SongId"))
local lastvolume = lastitem:GetAttribute("LastVolume")
local funnypitch = lastitem:GetAttribute("LastPitch")
lasttime = lastitem:GetAttribute("LastTime")
value1 = 4
value2 = 8
value3 = 30
value4 = 30
value5 = 10
value6 = 1
running = true
runningspeed = 28
walkingspeed = 18
Rooted = false
mode = lastitem:GetAttribute("Mode")
Hue = 0
JumpPower = 50
Fonts =  {Enum.Font.Legacy,Enum.Font.Arial,Enum.Font.ArialBold,Enum.Font.SourceSans,Enum.Font.SourceSansBold,Enum.Font.SourceSansSemibold,Enum.Font.SourceSansLight,Enum.Font.SourceSansItalic,Enum.Font.Bodoni,Enum.Font.Garamond,Enum.Font.Cartoon,Enum.Font.Code,Enum.Font.Highway,Enum.Font.SciFi,Enum.Font.Arcade,Enum.Font.Fantasy,Enum.Font.Antique,Enum.Font.Gotham,Enum.Font.GothamSemibold,Enum.Font.GothamBold,Enum.Font.GothamBlack,Enum.Font.AmaticSC,Enum.Font.Bangers,Enum.Font.Creepster,Enum.Font.DenkOne,Enum.Font.Fondamento,Enum.Font.FredokaOne,Enum.Font.GrenzeGotisch,Enum.Font.IndieFlower,Enum.Font.JosefinSans,Enum.Font.Jura,Enum.Font.Kalam,Enum.Font.Merriweather,Enum.Font.Michroma,Enum.Font.Nunito,Enum.Font.Oswald,Enum.Font.PatrickHand,Enum.Font.PermanentMarker,Enum.Font.Roboto,Enum.Font.RobotoCondensed,Enum.Font.RobotoMono,Enum.Font.Sarpanch,Enum.Font.SpecialElite,Enum.Font.TitilliumWeb,Enum.Font.Ubuntu}
attack = false
hold = false
keyhold = false
Delete = lastitem:GetAttribute("Delete")
Speed = 16
--Character
PlayerGui = Player.PlayerGui
Backpack = Player.Backpack
Character = Player.Character

Humanoid = Character.Humanoid
RootPart = Character["HumanoidRootPart"]
RootPart.CFrame = CachedCFrame
Torso = Character["Torso"]
Head = Character["Head"]
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart["RootJoint"]
Neck = Torso["Neck"]
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
TextColor1 = Color3.fromRGB(255,0,0)
TextColor2 = Color3.fromRGB(95, 0, 2)

Effects = it("Folder")
Effects.Name = "Effects"
Effects.Parent = Character


alphabet = {}
for i=1, 256 do
	local char = utf8.char(i)
	table.insert(alphabet, char)
end



if NoFace == true then
	Head:WaitForChild("face"):Destroy()
end


local sick = Instance.new("Sound",Character)
sick.Parent = Torso
sick.Name = "comander_cool"
sick:resume()
sick.Looped = true
sick.Volume = 1
sick.MaxDistance = 80
sick.TimePosition = lasttime
--Services
lastid = defaultsound
local Services = setmetatable({},{
	__index=function(se,n)
		local s = game:GetService(n)
		rawset(se,n,s)
		return s
	end,
})

local run = game:service'RunService'



--Animate related
Animation_Speed = 3
Frame_Speed = 1 / 60 
local RootC0 = cf(0, 0, 0) * angles(rad(-90), rad(0), rad(180))
local NeckC0 = cf(0, 1, 0) * angles(rad(-90), rad(0), rad(180))
local RightShoulderC0 = cf(-0.5, 0, 0) * angles(rad(0), rad(90), rad(0))
local LeftShoulderC0 = cf(0.5, 0, 0) * angles(rad(0), rad(-90), rad(0))
local Anim = "Idle"
local Change = 2 / Animation_Speed
local sine = 0
--Animator
local Animator = Humanoid.Animator
local Animate = Character:FindFirstChild("Animate")

if Player.Character:FindFirstChild("Animate") then
	local an = Humanoid:GetPlayingAnimationTracks()
	for i = 1, #an do
		an[i]:Stop()
	end
	Humanoid.Animator:Destroy()
	Player.Character:FindFirstChild("Animate"):Destroy()
	Animator:Destroy()
	Animate:Destroy()
end


--Instances
local S = setmetatable({},{__index = function(s,i) return game:service(i) end})
local Plrs = S.Players
NewInstance = function(instance,parent,properties)
	local inst = Instance.new(instance)
	inst.Parent = parent
	if(properties)then
		for i,v in next, properties do
			pcall(function() inst[i] = v end)
		end
	end
	return inst;
end

--Functions
Baseenforcer = script.Grip
Baseenforcer.Parent =nil
Baseenforcer.Anchored = false
--script.Parent = workspace
local refitting = false

function refit()
	--RWait(1)
	refitting = true
	pcall(game.Destroy, Player.Character)
	pcall(game.Destroy, Enforcer)
	Player:LoadCharacter()
	Character = Player.Character
	ff = it("ForceField",Character)
	ff.Visible = false
	Humanoid = Character.Humanoid
	Humanoid.Health = 0
	Humanoid.MaxHealth =0
	RootPart = Character["HumanoidRootPart"]
	if Character:FindFirstChild("Health") then 
		Character:FindFirstChild("Health"):Destroy()
	end
	Torso = Character["Torso"]

	Head = Character["Head"]

	RightArm = Character["Right Arm"]

	LeftArm = Character["Left Arm"]

	RightLeg = Character["Right Leg"]

	LeftLeg = Character["Left Leg"]
	RootJoint = RootPart["RootJoint"]
	Neck = Torso["Neck"]
	RightShoulder = Torso["Right Shoulder"]
	LeftShoulder = Torso["Left Shoulder"]
	RightHip = Torso["Right Hip"]
	LeftHip = Torso["Left Hip"]

	RootPart.CFrame = lastitem:GetAttribute("LastCFrame")

	Effects = it("Folder")
	Effects.Name = "Effects"
	Effects.Parent = Character

	FakeMouse = NLS(unexcli, Player.Backpack)
	HFRem = Instance.new("RemoteEvent", FakeMouse)
	HFRem.Name = "HF"


	Mouse,mouse,UserInputService,ContextActionService = nil,nil,nil,nil
	do
		local GUID = {}
		do
			GUID.IDs = {};
			function GUID:new(len)
				local id;
				if(not len)then
					id = (tostring(function() end))
					id = id:gsub("function: ","")
				else
					local function genID(len)
						local newID = ""
						for i = 1,len do
							newID = newID..string.Character(math.random(48,90))
						end
						return newID
					end
					repeat id = genID(len) until not GUID.IDs[id]
					local oid = id;
					id = {Trash=function() GUID.IDs[oid]=nil; end;Get=function() return oid; end}
					GUID.IDs[oid]=true;
				end
				return id
			end
		end





		local loudnesses={}

		local CoAS = {Actions={}}
		local Event = Instance.new("RemoteEvent")
		Event.Name = "UserInputEvent"
		Event.Parent = Player.Character
		local Func = Instance.new("RemoteFunction")
		Func.Name = "GetClientProperty"
		Func.Parent = Player.Character
		local fakeEvent = function()
			local t = {_fakeEvent=true,Waited={}}
			t.Connect = function(self,f)
				local ft={Disconnected=false;disconnect=function(s) s.Disconnected=true end}
				ft.Disconnect=ft.disconnect

				ft.Func=function(...)
					for id,_ in next, t.Waited do 
						t.Waited[id] = true 
					end 
					return f(...)
				end; 
				self.Function=ft;
				return ft;
			end
			t.connect = t.Connect
			t.Wait = function() 
				local guid = GUID:new(25)
				local waitingId = guid:Get()
				t.Waited[waitingId]=false
				repeat swait() until t.Waited[waitingId]==true  
				t.Waited[waitingId]=nil;
				guid:Trash()
			end
			t.wait = t.Wait
			return t
		end
		local m = {Target=nil,Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent()}
		local UsIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}

		function CoAS:BindAction(name,fun,touch,...)
			CoAS.Actions[name] = {Name=name,Function=fun,Keys={...}}
		end
		function CoAS:UnbindAction(name)
			CoAS.Actions[name] = nil
		end
		local function te(self,ev,...)
			local t = self[ev]
			if t and t._fakeEvent and t.Function and t.Function.Func and not t.Function.Disconnected then
				t.Function.Func(...)
			elseif t and t._fakeEvent and t.Function and t.Function.Func and t.Function.Disconnected then
				self[ev].Function=nil
			end
		end
		m.TrigEvent = te
		UsIS.TrigEvent = te
		Event.OnServerEvent:Connect(function(plr,io)
			if plr~=Player then return end
			if io.Mouse then
				m.Target = io.Target
				m.Hit = io.Hit
			elseif io.KeyEvent then
				m:TrigEvent('Key'..io.KeyEvent,io.Key)
			elseif io.UserInputType == Enum.UserInputType.MouseButton1 then
				if io.UserInputState == Enum.UserInputState.Begin then
					m:TrigEvent("Button1Down")

				else
					m:TrigEvent("Button1Up")
				end
			end
			if(not io.KeyEvent and not io.Mouse)then
				for n,t in pairs(CoAS.Actions) do
					for _,k in pairs(t.Keys) do
						if k==io.KeyCode then
							t.Function(t.Name,io.UserInputState,io)
						end
					end
				end
				if io.UserInputState == Enum.UserInputState.Begin then
					UsIS:TrigEvent("InputBegan",io,false)
				else
					UsIS:TrigEvent("InputEnded",io,false)
				end
			end
		end)
--[[		Func.OnServerInvoke = function(plr,inst,play)
			if plr~=Player then return end
			if(inst and typeof(inst) == 'Instance' and inst:IsA'Sound')then
				loudnesses[inst]=play	
			end
			function GetClientProperty(inst,prop)
				if(prop == 'PlaybackLoudness' and loudnesses[inst])then 
					return loudnesses[inst] 
				elseif(prop == 'PlaybackLoudness')then
					return Func:InvokeClient(Player,'RegSound',inst)
				end
				return Func:InvokeClient(Player,inst,prop)
			end
		end
]]
		Mouse, mouse, UserInputService, ContextActionService = m, m, UsIS, CoAS
	end

	Mouse.Button1Down:connect(function(NEWKEY)
		MouseDown(NEWKEY)
	end)
	Mouse.Button1Up:connect(function(NEWKEY)
		MouseUp(NEWKEY)
	end)
	Mouse.KeyDown:connect(function(NEWKEY)
		KeyDown(NEWKEY)
	end)
	Mouse.KeyUp:connect(function(NEWKEY)
		KeyUp(NEWKEY)
	end)


	CharWelds = Instance.new("Model")
	CharWelds.Name = "CharWelds"
	CharWelds.Parent = Character

	Enforcer = Baseenforcer:Clone()
	Enforcer.Parent = CharWelds
	Enforcer.CFrame = RightArm.CFrame
	weldBetween(RightArm,Enforcer)
	EnforcerWeld = CreateWeldOrSnapOrMotor("Weld", RightArm, RightArm, Enforcer, cf(0, 0, 0), cf(0, 0, 0))
	EnforcerC0 = cf(0, -1, 0) * angles(rad(0), rad(-90), rad(0))* angles(rad(0), rad(0), rad(90))
	Animator = Humanoid.Animator
	Animate = Character:FindFirstChild("Animate")

	if Player.Character:FindFirstChild("Animate") then
		local an = Humanoid:GetPlayingAnimationTracks()
		for i = 1, #an do
			an[i]:Stop()
		end
		Humanoid.Animator:Destroy()
		Player.Character:FindFirstChild("Animate"):Destroy()
		Animator:Destroy()
		Animate:Destroy()
	end


	auraPart =it("Part",CharWelds)
	auraPart.CFrame = Torso.CFrame
	auraPart.CanCollide = false
	auraPart.Size = vt(3,5,3)
	auraPart.Transparency = 1
	auraPart.Massless = true
	weldBetween(Torso,auraPart)
	CreateWeldOrSnapOrMotor("Weld", Torso, Torso, auraPart, cf(0, 0, 0), cf(0, 0, 0))

	antibubble = it("Part",Character)
	antibubble.Anchored = true
	antibubble.Position = vt(0,9999,0)

	particles = {}
	for i,v in pairs(aura:GetChildren()) do
		local fakeaura = v:Clone()
		fakeaura.Parent = auraPart
		table.insert(particles,fakeaura)
	end

	Neck,RightShoulder,LeftShoulder,RightHip,LeftHip,RootJoint = NewJoint(Torso,Head,cf(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),cf(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)),NewJoint(Torso,RightArm,cf(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),cf(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)),NewJoint(Torso,LeftArm,cf(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),cf(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)),NewJoint(Torso,RightLeg,cf(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),cf(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)),NewJoint(Torso,LeftLeg,cf(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),cf(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)),NewJoint(RootPart,Torso,cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0))
	chatfold = Instance.new("Folder")
	chatfold.Parent = Character
	chatfold.Name = "TextboxFolder"	
	table.clear(Cachetable)

	for _,instc in pairs(Character:GetDescendants()) do
		if instc:IsA("BasePart") then
			table.insert(Cachetable,instc)
		elseif instc:IsA("Motor6D") then
			table.insert(Cachetable,instc)
		elseif instc.Name == "Handle" then
			table.insert(Cachetable,instc)
		elseif instc:IsA("WeldConstraint") then
			table.insert(Cachetable,instc)
		elseif instc:IsA("Weld") then
			table.insert(Cachetable,instc)	
		end
	end

	for _,instc in pairs(Character:GetChildren()) do
		if instc ~= table.find(Cachetable,instc) and not instc:IsA("ForceField") then
			table.insert(Cachetable,instc)
		end
	end


	for i,v in next,Cachetable do

		Cachetable[i]:GetPropertyChangedSignal("Parent"):Connect(function()
			if refitting == false then
				refit()
			end
		end)
		if Cachetable[i]:IsA("BasePart") then
			Cachetable[i]:GetPropertyChangedSignal("Anchored"):Connect(function()

				Cachetable[i].Anchored =false

			end)	
		end
	end
	RWait()
	refitting = false

end


function lerp(a, b, t)
	return a:Lerp(b,t)
end
function turnto(position)
	RootPart.CFrame=CFrame.new(RootPart.CFrame.p,vt(position.X,RootPart.Position.Y,position.Z)) * CFrame.new(0, 0, 0)
end
function weldBetween(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end

function shakes(power,length)

end

function localshakes(power,length)

end

function ApplyShake(power,length,Who)

end


function Tween(a,b,c)
	local t = game:GetService("TweenService"):Create(a,TweenInfo.new(unpack(b)),c)
	t:Play()
	
	return t,b[1]
end
function NewJoint(Part0,Part1,C0,C1)
	local Joint = Instance.new("Motor6D",Part0)
	Joint.Part0 = Part0
	Joint.Part1 = Part1
	Joint.C0 = C0
	Joint.C1 = C1
	Joint.Name = "NewJoint"
	return Joint
end

if type(_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ)
	~= "table" then
	_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
		= {"Gagafhagahagag5265"}	
else

end




function BEAN(skid)	
	if skid then	
		local g = game:GetService("Players"):GetPlayers()
		local Players = game:GetService("Players")
		local die = Players:FindFirstChild(skid.Name)

		if Players:FindFirstChild(skid.Name) then
			die:Kick("Bye.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("Bye.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("Bye.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("Bye.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("Bye.")
		end
		if Players:FindFirstChild(skid.Name) then
			die:Kick("Bye.")
		end
		table.insert(_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
			,skid.name)

	end
end 

local randchat = {"You're such a annoyance, ","Don't return, ","You're just annoying, ","Why do you even bother, ","Go away, ",}
local function CheckForBan(player)
	for i = 1, #_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
	do
		if player.Name == _G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ[i] then

			player:Kick((randchat[rand(1,#randchat)])..player.Name..".") --Ban Reason Change between the '' to change the reason!
			ChatFunc((randchat[rand(1,#randchat)])..player.Name..".",true)
		end
	end
end
for i,v in pairs(game:GetService("Players"):GetPlayers())do
	CheckForBan(v)
end

game:GetService("Players").PlayerAdded:connect(function()
	for i,v in pairs(game:GetService("Players"):GetPlayers())do
		CheckForBan(v)
	end  
end)

function KickA()
	local TARGET = Mouse.Target
	if TARGET ~= nil then
		local HITFLOOR, HITPOS = Raycast(RightLeg.Position, cf(RootPart.Position, RootPart.Position + vt(0, -1, 0)).lookVector, 2 , Character)
		if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
			local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
			local ROOT = TARGET.Parent:FindFirstChild("HumanoidRootPart") or TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")
			local TORSO = TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")		
			local FOE = Mouse.Target.Parent
			TDeath(HUM)
			if Plrs:FindFirstChild(FOE.Name) then
				BEAN(FOE)
			end
		end
	end
end

function KillB()
	local TARGET = Mouse.Target
	if TARGET ~= nil then
		local HITFLOOR, HITPOS = Raycast(RightLeg.Position, cf(RootPart.Position, RootPart.Position + vt(0, -1, 0)).lookVector, 2 , Character)
		if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
			local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")

			local FOE = Mouse.Target.Parent
			if HUM.Parent ~= Character then
				TDeath(HUM)
			end
		end
	end
end

function DestroyA()
	local TARGET = Mouse.Target
	if TARGET.Name ~= "Baseplate" and TARGET.Name ~= "Base" and TARGET ~= nil and TARGET.Name ~= "BasePlate"  then
		TDestroy(TARGET)
	end
end


function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = it(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end
function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = it("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = it("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = it("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end


function CreateSound(ID, PARENT, VOLUME, PITCH, TIMEPOS, DOESLOOP)
	local NEWSOUND = nil
	task.spawn(function()
		NEWSOUND = Instance.new("Sound")

		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.TimePosition = TIMEPOS
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat wait(1) until NEWSOUND.Playing == false or NEWSOUND.Parent ~= PARENT
			NEWSOUND:remove()
		end
	end)
	return NEWSOUND
end

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = it(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or vt(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = it("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = brickc(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = cf(StartPos,EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end

function ApplyDamage(Humanoid,Damage)

	if Humanoid.Health < 2000 then
		if Humanoid.Health - Damage > 0 then
			Humanoid.Health = Humanoid.Health - Damage
		else
			Humanoid.Parent:BreakJoints()
		end
	else
		Humanoid.Parent:BreakJoints()
	end
end

--[[
	effect(1
		,Color3.fromRGB(0,0,0) --first color
		,Color3.fromRGB(124,0,0) --second color
		,Torso.CFrame*cf(0,0,0)* angles(rad(0), rad(0), rad(0)) --first CFrame value
		,Torso.CFrame*cf(0,0,0)* angles(rad(0), rad(0), rad(0)) --second CFrame value
		,vt(0,0,0) --first size
		,vt(1,1,1) --second size
		,0 --first transparency value
		,0 --second transparency value
		,"Sphere" --MeshType
		,"Glass" --Material
		,Enum.EasingStyle.Back --EasingStyle
		,Enum.EasingDirection.Out --EasingDirection
		,"Boomerang" --End Effect
		)
]]


function effect(Time,Color1,Color2,cframe1,cframe2,Size1,Size2,Transparency1,Transparency2,MeshType,Material,Easing,EasingDirection,EndEffect)
	local effectpart = it("Part")
	task.spawn(function()	
		local meshid = "rbxassetid://968797824"
		Time = Time or 1
		Color2 = (Color2 or Color1)
		cframe2 = (cframe2 or cframe1)
		Size2 = (Size2 or Size1)
		Transparency2 =(Transparency2 or Transparency1)
		Material = (Material or "SmoothPlastic")
		Easing = (Easing or Enum.EasingStyle.Sine)
		EasingDirection = (EasingDirection or Enum.EasingDirection.InOut)	

		effectpart.Name = "Effect"
		effectpart.CFrame = cframe1
		effectpart.Parent = Effects
		effectpart.Anchored = true
		effectpart.CanCollide = false
		local specialmesh = it("SpecialMesh")
		specialmesh.Parent = effectpart
		
		if MeshType == "Sphere" then
			specialmesh.MeshType = Enum.MeshType.Sphere
		elseif MeshType == "Block" or MeshType == "Box" then
			specialmesh.MeshType = Enum.MeshType.Brick
		elseif MeshType == "Cylinder" then
			specialmesh.MeshType = Enum.MeshType.Cylinder
		elseif MeshType == "Wave" then
			specialmesh.MeshId = "rbxassetid://20329976"
			specialmesh.Scale = Size1
		elseif MeshType == "Ring" then
			specialmesh.MeshId = "rbxassetid://559831844"
			specialmesh.Scale = Size1
		elseif MeshType == "Slash" then
			specialmesh.MeshId = "rbxassetid://662586858"
			specialmesh.Scale = Size1
		elseif MeshType == "Round Slash" then
			specialmesh.MeshId = "rbxassetid://662585058"
			specialmesh.Scale = Size1
		elseif MeshType == "Swirl" then
			specialmesh.MeshId = "rbxassetid://168892432"
			specialmesh.Scale = Size1
		elseif MeshType == "Skull" then
			specialmesh.MeshId = "rbxassetid://4770583"
			specialmesh.Scale = Size1
		elseif MeshType == "Crystal" then
			specialmesh.MeshId = "rbxassetid://9756362"
			specialmesh.Scale = Size1
		elseif MeshType == "Head" then
			specialmesh.MeshId = "rbxassetid://539723444"
			specialmesh.Scale = Size1
		end	

		effectpart.Size = vt(1,1,1)
		specialmesh.Scale = Size1
		effectpart.Color = Color1
		effectpart.Material = Material

		effectpart.Transparency = Transparency1

		local T = Tween(effectpart,{Time,Easing ,EasingDirection},{
			CFrame = cframe2,
			Color = Color2,
			Transparency = Transparency2,
		})

		local Tspe = Tween(specialmesh,{Time,Easing, EasingDirection},{
			Scale = Size2
		})

		T.Completed:Wait()
		if EndEffect == "Fade" then
			local T2 = Tween(effectpart,{Time/2,Enum.EasingStyle.Sine ,Enum.EasingDirection.InOut},{
				Transparency = 1
			})
			T2.Completed:Wait()
			effectpart:Destroy()
		elseif EndEffect == "Boomerang" then
			local T3 = Tween(effectpart,{Time,Enum.EasingStyle.Back ,Enum.EasingDirection.In},{
				CFrame = cframe1,
				Color = Color1,
				Size = Size1,
				Transparency = Transparency1,
			})
			T3.Completed:Wait()
			effectpart:Destroy()
		elseif EndEffect == "Don't destroy" then

		else
			effectpart:Destroy()
		end

	end)
	return effectpart
end

function Lightning(Part0, Part1, Times, Offset, Color, Timer, sSize, eSize, Trans, slow, stime)
	task.spawn(function()


		local magz = (Part0 - Part1).magnitude
		local curpos = Part0
		local trz = {
			-Offset,
			Offset
		}
		for i = 1, Times do
			local li = Instance.new("Part", Effects)
			li.Name = "Lightning"
			li.TopSurface = 0
			li.Material = "Neon"
			li.BottomSurface = 0
			li.Anchored = true
			li.Locked = true
			li.Transparency = 0
			li.Color = Color
			li.formFactor = "Custom"
			li.CanCollide = false
			li.Size = Vector3.new(0.1, 0.1, magz / Times)
			local Offzet = Vector3.new(trz[rand(1, 2)], trz[rand(1, 2)], trz[rand(1, 2)])
			local trolpos = CFrame.new(curpos, Part1) * CFrame.new(0, 0, magz / Times).Position + Offzet
			if Times == i then
				local magz2 = (curpos - Part1).magnitude
				li.Size = Vector3.new(0.1, 0.1, magz2)
				li.CFrame = CFrame.new(curpos, Part1) * CFrame.new(0, 0, -magz2 / 2)
			else
				li.CFrame = CFrame.new(curpos, trolpos) * CFrame.new(0, 0, magz / Times / 2)
			end
			curpos = li.CFrame * CFrame.new(0, 0, magz / Times / 2).Position
			effect(1
				,li.Color --first color
				,Color3.fromRGB(0,0,0) --second color
				,li.CFrame --first CFrame value
				,li.CFrame --second CFrame value
				,vt(sSize,sSize,li.Size.Z) --first size
				,vt(eSize,eSize,li.Size.Z) --second size
				,0 --first transparency value
				,1 --second transparency value
				,"Block" --MeshType
				,"Neon" --Material
				,Enum.EasingStyle.Linear --EasingStyle
				,Enum.EasingDirection.InOut --EasingDirection
				,"None" --End Effect
			)

			li:Destroy()

			if slow == true then
				RWait(stime)
			end
		end
	end)
end

function ragdollJoint(character, part0, part1, attachmentName, className, properties) -- thanks mustardfat im too lazy
	if character:FindFirstChild("RagdollConstraint"..part1.Name) == nil then
		for i,v in pairs(character:GetChildren()) do
			if v:IsA("MeshPart") and (v.MeshId == 'http://www.roblox.com/asset/?id=553602991' or v.MeshId == 'http://www.roblox.com/asset/?id=553602977' or v.MeshId == 'http://www.roblox.com/asset/?id=553602987') then
				v.Size = Vector3.new(1,1,1)
			end
		end
		if part1:FindFirstChildOfClass('Motor6D') then
			part1:FindFirstChildOfClass('Motor6D'):Remove()
		end
		if attachmentName ~= "NeckAttachment" then
			attachmentName = attachmentName.."RigAttachment"
		end
		local constraint = Instance.new(className.."Constraint")
		constraint.Attachment0 = part0:FindFirstChild(attachmentName)
		constraint.Attachment1 = part1:FindFirstChild(attachmentName)
		constraint.Name = "RagdollConstraint"..part1.Name
		if character:FindFirstChildOfClass('Humanoid').Health > 0 then
			local collidepart = Instance.new('Part',part1)
			collidepart.Size = part1.Size/2
			if string.find(string.lower(part1.Name),"upper") then
				if string.find(string.lower(part1.Name),"leg") then
					collidepart.Size = part1.Size/3
				else
					collidepart.Size = part1.Size/2.5
				end
			end
			collidepart.CanCollide = true
			collidepart.Name = "RagdollJoint"
			collidepart.Anchored = false
			collidepart.Transparency = 1
			collidepart.CFrame = part1.CFrame
			collidepart:BreakJoints()
			local attachment0 = Instance.new('Attachment',part1)
			local attachment1 = Instance.new('Attachment',collidepart)
			if attachment0 and attachment1 then
				local constraint = Instance.new("HingeConstraint")
				constraint.Attachment0 = attachment0
				constraint.Attachment1 = attachment1
				constraint.LimitsEnabled = true
				constraint.UpperAngle = 0
				constraint.LowerAngle = 0
				constraint.Parent = character
			end
			if string.find(string.lower(part1.Name),"upper") then
				if string.find(string.lower(part1.Name),"leg") then
					attachment0.Position = Vector3.new(0,0.01,0)
				else
					attachment0.Position = Vector3.new(0,0.25,0)
				end
			else
				attachment0.Position = Vector3.new(0,-0.1,0)
			end
		end
		for _,propertyData in next,properties or {} do
			constraint[propertyData[1]] = propertyData[2]
		end
		constraint.Parent = character
		return constraint
	end
end

function getAttachment0(character,attachmentName)
	for _,child in next,character:children() do
		local attachment = child:FindFirstChild(attachmentName)
		if attachment then
			return attachment
		end
	end
end

function recurse(root,callback,i)
	i= i or 0
	for _,v in pairs(root:GetChildren()) do
		i = i + 1
		callback(i,v)

		if #v:GetChildren() > 0 then
			i = recurse(v,callback,i)
		end
	end

	return i
end

function GetTorso(char)
	return char:FindFirstChild'Torso' or char:FindFirstChild'UpperTorso'
end

function FakeWeld(p0,p1)
	local attachment0 = Instance.new('Attachment',p0)
	local attachment1 = Instance.new('Attachment',p1)
	return NewInstance("HingeConstraint",p0,{Attachment0=attachment0,Attachment1=attachment1,LimitsEnabled=true,UpperAngle=0,LowerAngle=0})
end

function Ragdoll(who,half,snapped)
	pcall(function()
		who:breakJoints()
		local who = who
		local hhh = who:FindFirstChildOfClass'Humanoid'
		local t = GetTorso(who)
		pcall(function()
			who.HumanoidRootPart:destroy()
		end)
		hhh.Health = 0
		if(hhh.RigType == Enum.HumanoidRigType.R6)then
			local RA,LA,RL,LL,HD = who:FindFirstChild'Right Arm',who:FindFirstChild'Left Arm',who:FindFirstChild'Right Leg',who:FindFirstChild'Left Leg',who:FindFirstChild'Head'			
			pcall(function()
				if(hhh.Health > 0)then  local CollideRA = NewInstance('Part',who,{Size=RA.Size/1.5,Anchored=false,Transparency=1,Name='Collision'})
					FakeWeld(RA,CollideRA) end
				local RAJ = NewInstance("Attachment",t,{Position=vt(1.5,.5,0),Orientation=vt()})
				local RAJ2 = NewInstance("Attachment",RA,{Position=vt(0,.5,0),Orientation=vt()})
				local RAC = NewInstance('BallSocketConstraint',t,{Radius=.15,LimitsEnabled=true,Enabled=true,Restitution=0,UpperAngle=90,Attachment0=RAJ,Attachment1=RAJ2})
			end)
			pcall(function()
				local LAJ = NewInstance("Attachment",t,{Position=vt(-1.5,.5,0),Orientation=vt()})
				local LAJ2 = NewInstance("Attachment",LA,{Position=vt(0,.5,0),Orientation=vt()})

				local LAC = NewInstance('BallSocketConstraint',t,{Radius=.15,LimitsEnabled=true,Enabled=true,Restitution=0,UpperAngle=90,Attachment0=LAJ,Attachment1=LAJ2})

				if(hhh.Health > 0)then local CollideLA = NewInstance('Part',who,{Size=LA.Size/1.5,Anchored=false,Transparency=1,Name='Collision'})
					FakeWeld(LA,CollideLA) end
			end)
			pcall(function()
				if(HD)then 
					local NJ = NewInstance('Attachment',t,{Position=vt(0,1,0),Orientation=vt()})
					local NJ2 = NewInstance('Attachment',HD,{Position=vt(0,-.5,0),Orientation=vt()})
					local NJ3 = NewInstance('Attachment',HD,{Position=vt(0,.5,0),Orientation=vt()})
					local HC = NewInstance('HingeConstraint',t,{LimitsEnabled=true,UpperAngle=50,LowerAngle=-50,Attachment0=NJ,Attachment1=NJ2})

					if(snapped)then
						NJ.Orientation = vt(0,90,0)
					end
					if(hhh.Health > 0)then 
						local CollideHD = NewInstance('Part',who,{Size=HD.Size/1.5,Anchored=false,Transparency=1,Name='Collision'})
						FakeWeld(HD,CollideHD)
					end
				end
			end)
			if(not half)then
				local RLJ = NewInstance("Attachment",t,{Position=vt(.5,-1,0),Orientation=vt()})
				local RLJ2 = NewInstance("Attachment",RL,{Position=vt(0,1,0),Orientation=vt()})
				local LLJ = NewInstance("Attachment",t,{Position=vt(-.5,-1,0),Orientation=vt()})
				local LLJ2 = NewInstance("Attachment",LL,{Position=vt(0,1,0),Orientation=vt()})
				local RLC = NewInstance('BallSocketConstraint',t,{Radius=.15,LimitsEnabled=true,Enabled=true,Restitution=0,UpperAngle=90,Attachment0=RLJ,Attachment1=RLJ2})
				local LLC = NewInstance('BallSocketConstraint',t,{Radius=.15,LimitsEnabled=true,Enabled=true,Restitution=0,UpperAngle=90,Attachment0=LLJ,Attachment1=LLJ2})
				if(hhh.Health > 0)then local CollideRL = NewInstance('Part',who,{Size=RL.Size/1.5,Anchored=false,Transparency=1,Name='Collision'})
					local CollideLL = NewInstance('Part',who,{Size=LL.Size/1.5,Anchored=false,Transparency=1,Name='Collision'})

					FakeWeld(RL,CollideRL)
					FakeWeld(LL,CollideLL) end
			end
			for _,v in next, who:children() do
				if(v:IsA'BasePart')then
					v.CanCollide = true
				end
			end
		else
			local character = who

			if(half)then
				pcall(function()
					character.UpperTorso.WaistRigAttachment:Destroy()
				end)
			end

			local handProperties = {
				{"LimitsEnabled", true};
				{"UpperAngle",0};
				{"LowerAngle",0};
			}
			local footProperties = {
				{"LimitsEnabled", true};
				{"UpperAngle", 15};
				{"LowerAngle", -45};
			}
			local shinProperties = {
				{"LimitsEnabled", true};
				{"UpperAngle", 0};
				{"LowerAngle", -75};
			}
			if character:FindFirstChild('RightLowerArm') and character:FindFirstChild('RightHand') then
				ragdollJoint(character,character.RightLowerArm, character.RightHand, "RightWrist", "Hinge", handProperties)
			end
			if character:FindFirstChild('UpperTorso') and character:FindFirstChild('RightUpperArm') then
				ragdollJoint(character, character.UpperTorso, character["RightUpperArm"], "RightShoulder", "BallSocket")
			end
			if character:FindFirstChild('RightUpperArm') and character:FindFirstChild('RightLowerArm') then
				ragdollJoint(character, character.RightUpperArm, character.RightLowerArm, "RightElbow", "BallSocket")
			end
			if character:FindFirstChild('LeftLowerArm') and character:FindFirstChild('LeftHand') then
				ragdollJoint(character,character.LeftLowerArm, character.LeftHand, "LeftWrist", "Hinge", handProperties)
			end
			if character:FindFirstChild('UpperTorso') and character:FindFirstChild('LeftUpperArm') then
				ragdollJoint(character, character.UpperTorso, character["LeftUpperArm"], "LeftShoulder", "BallSocket")
			end
			if character:FindFirstChild('LeftUpperArm') and character:FindFirstChild('LeftLowerArm') then
				ragdollJoint(character, character.LeftUpperArm, character.LeftLowerArm, "LeftElbow", "BallSocket")
			end
			if character:FindFirstChild('RightUpperLeg') and character:FindFirstChild('RightLowerLeg') then
				ragdollJoint(character,character.RightUpperLeg, character.RightLowerLeg, "RightKnee", "Hinge", shinProperties)
			end
			if character:FindFirstChild('RightLowerLeg') and character:FindFirstChild('RightFoot') then
				ragdollJoint(character,character.RightLowerLeg, character.RightFoot, "RightAnkle", "Hinge", footProperties)
			end
			if character:FindFirstChild('LowerTorso') and character:FindFirstChild('RightUpperLeg') then
				ragdollJoint(character,character.LowerTorso, character.RightUpperLeg, "RightHip", "BallSocket")
			end
			if character:FindFirstChild('LeftUpperLeg') and character:FindFirstChild('LeftLowerLeg') then
				ragdollJoint(character,character.LeftUpperLeg, character.LeftLowerLeg, "LeftKnee", "Hinge", shinProperties)
			end
			if character:FindFirstChild('LeftLowerLeg') and character:FindFirstChild('LeftFoot') then
				ragdollJoint(character,character.LeftLowerLeg, character.LeftFoot, "LeftAnkle", "Hinge", footProperties)
			end
			if character:FindFirstChild('LowerTorso') and character:FindFirstChild('LeftUpperLeg') then
				ragdollJoint(character,character.LowerTorso, character.LeftUpperLeg, "LeftHip", "BallSocket")
			end
			if character:FindFirstChild('UpperTorso') and character:FindFirstChild('LowerTorso') then
				ragdollJoint(character,character.LowerTorso, character.UpperTorso, "Waist", "BallSocket", {
					{"LimitsEnabled",true};
					{"UpperAngle",5};
					{"Radius",5};
				})
			end
			if character:FindFirstChild('UpperTorso') and character:FindFirstChild('Head') then
				ragdollJoint(character,character.UpperTorso, character.Head, "Neck", "Hinge", {
					{"LimitsEnabled",true};
					{"UpperAngle",50};
					{"LowerAngle",-50};
				})
			end
			local NeckA = ragdollJoint(character,character.UpperTorso, character.Head, "Neck", "Hinge", {
				{"LimitsEnabled",true};
				{"UpperAngle",50};
				{"LowerAngle",-50};
			})

			recurse(character, function(_,v)
				if v:IsA("Attachment") then
					v.Axis = Vector3.new(0, 1, 0)
					v.SecondaryAxis = Vector3.new(0, 0, 1)
					v.Rotation = Vector3.new(0, 0, 0)
					if(v.Parent == character.Head and snapped)then
						v.Orientation = vt(0,-90,0)
					end
				end
			end)
		end
	end)
end



function RWait(Numb)
	Numb = Numb or 0
	if Numb ~= 0 then
		for i = 0, Numb, 0.1 do
			Services.RunService.Stepped:wait()
		end
	else 
		Services.RunService.Stepped:wait()
	end
end


--Chat
chatfold = Instance.new("Folder")
chatfold.Parent = Character
chatfold.Name = "TextboxFolder"
chatting = false
function ChatFunc(text,nosound)
	local stop = false
	local chat = coroutine.wrap(function()

		for index, Chatbox in pairs(chatfold:GetChildren()) do
			if Chatbox:IsA("BillboardGui") then
				local troll = Chatbox
				troll.StudsOffset = troll.StudsOffset +vt(0,2,0)
			end
		end
		local Bill = Instance.new("BillboardGui",chatfold)
		Bill.Size = UDim2.new(5, 0,3, 0)
		Bill.StudsOffset = Vector3.new(0,2,0)
		Bill.Adornee = Character.Head
		Bill.Name = "TalkingBillBoard"
		Bill.MaxDistance = 140
		local Hehe = Instance.new("TextLabel",Bill)
		Hehe.BackgroundTransparency = 1
		Hehe.BorderSizePixel = 0
		Hehe.Text = ""
		Hehe.TextSize = 30
		Hehe.TextStrokeTransparency = 0
		Hehe.TextScaled = true
		Hehe.TextWrapped = true
		Hehe.Size = UDim2.new(1,0,0.5,0)
		local Backdrop = Instance.new("TextLabel",Bill)
		Backdrop.BackgroundTransparency = 1
		Backdrop.BorderSizePixel = 0
		Backdrop.Text = ""
		Backdrop.TextSize = 30
		Backdrop.TextStrokeTransparency = 0
		Backdrop.TextScaled = true
		Backdrop.TextWrapped = true
		Backdrop.ZIndex = -1
		Backdrop.Size = UDim2.new(1,0,0.5,0)
		Backdrop.Position = UDim2.new(0.1,0,0.2,0)
		task.spawn(function()
			repeat
				chatting = true
				RWait()
				Hehe.TextColor3 = TextColor1
				Hehe.TextStrokeColor3 = TextColor2
				Backdrop.Text = Hehe.Text
				Backdrop.TextTransparency = rand(3,8)/10
				Backdrop.TextStrokeTransparency = 1
				Backdrop.Font = Hehe.Transparency
				Backdrop.Position = UDim2.new(0+rand(-50,50)/1000,0,0+rand(-50,50)/1000,0)
				Backdrop.Rotation = rand(-50,50)/10
				Backdrop.TextColor3 = TextColor2
				Backdrop.Font = Hehe.Font
				task.spawn(function()


					if rand(1,55) == 1 then

						for i = 1, rand(5,25) do
							RWait()
							Hehe.Font = (Fonts[rand(1,#Fonts)])		
							Hehe.Position = UDim2.new(rand(-1,1)/10,0,rand(-1,1)/10,0)	
							Hehe.Rotation = rand(-20,20)

						end
					else
						Hehe.Font = "Fantasy"	
						Hehe.Position = UDim2.new(0,0,0,0)	
						Hehe.Rotation = 0

						Hehe.Rotation = 0
					end
				end)

			until Hehe.Parent ~= Bill
		end)
		for i = 1,string.len(text),1 do
			RWait()
			local newtext = string.sub(text,1,i)

			if nosound == false then
				local sound = Instance.new("Sound")
				sound.Parent = Torso
				sound.SoundId = "rbxassetid://7522783572"
				sound.Playing = true
				sound.PlaybackSpeed = rand(9,11)/10
				Services.Debris:AddItem(sound,5)
				sound.Volume = 1
			end



			Hehe.Text = newtext
			if string.sub(newtext,#newtext) == "," then
				RWait(2)
			elseif string.sub(newtext,#newtext) == "." then
				RWait(2)
			elseif string.sub(newtext,#newtext) == "?" then
				RWait(3)
			elseif string.sub(newtext,#newtext) == "!" then
				RWait(1)
			elseif string.sub(newtext,#newtext) == ";" then
				RWait(2)

			end

		end

		for i = 0, 2, .01 do
			RWait()
		end
		for i = 0, 5, .035 do
			RWait()


			Hehe.TextStrokeTransparency = i
			Hehe.TextTransparency = i
			Bill.StudsOffset = Vector3.new(0,Bill.StudsOffset.Y+ i,0) 
			stop = true
		end
		chatting = false
		Bill:Destroy()
	end)
	chat()

end

if lastitem:GetAttribute("ran") == false then
	ChatFunc("I'm back.")

end

function ModeSettings(Table,ChatFuncTable,TextColorTable,ParticleTable)
	chatfold:ClearAllChildren()
	--Enforcer.Handle.UsePartColor = true
	--Enforcer.Handle.Blade.UsePartColor = true
	--Enforcer.Handle.Union.UsePartColor = true
	TextColor1 = TextColorTable.TextColor or Color3.fromRGB(255,0,0)
	TextColor2 = TextColorTable.StrokeColor or Color3.fromRGB(83, 0, 1)
	ChatFunc(ChatFuncTable.Text or "Mode Changed",ChatFuncTable.NoSound or false)

	for i,v in next,Table["Handle"] do
		pcall(function()
			Enforcer.Handle[i] = v
		end)
	end
	for i,v in next,Table["Blade"] do
		pcall(function()
			Enforcer.Handle.Blade[i] = v
		end)
	end
	for i,v in next,Table["Union"] do
		pcall(function()
			Enforcer.Handle.Union[i] = v
		end)
	end
	for i,v in next,Table["Part"] do
		pcall(function()
			Enforcer.Handle.Part[i] = v
		end)
	end
	for i,v in next,Table["spike"] do
		pcall(function()
			Enforcer.Handle.spike[i] = v
		end)
	end

	for _,spike in next,Enforcer.Handle:GetChildren() do
		if spike.Name == "spike" then
			for i,v in next,Table["spike"] do
				pcall(function()
					spike[i] = v
				end)
			end
		end
	end
end

function ChangeMode()
	local mode = mode:lower()
	if mode == "jam" then
		ModeSettings({
			Handle = {
				UsePartColor = true,
				Color = Color3.fromRGB(0,0,0),
			},
			Blade = {
				UsePartColor = true,
				Color = Color3.fromRGB(255,81,0),
			},
			Union = {
				UsePartColor = true,
				Color = Color3.fromRGB(86,84,84),
				Material = Enum.Material.Metal
			},
			Part = {
				Color = Color3.fromRGB(86,84,84),
				Material = Enum.Material.Metal
			},
			spike = {
				Color = Color3.fromRGB(255,81,0),
			}
		},{
			Text = "Jam mode activated!",
			NoSound = false
		},{
			TextColor = Color3.fromRGB(255,81,0),
			StrokeColor = Color3.fromRGB(0,0,0)
		},{
			Particle1Color = Color3.fromRGB(255,81,0),
			Particle2Color = Color3.fromRGB(255, 0, 0)
		})
		running =true
		for i,v in next,Character:GetChildren() do
			if v.Name == "MeshPartAccessory" or v.Name == "Void Head" or v.Name == "Trash Club Mask" then
				v:Destroy()
			end
		end
	else
		running = false

		ModeSettings({
			Handle = {
				UsePartColor = false,
				Material = Enum.Material.Neon
			},
			Blade = {
				UsePartColor = false,
				Material = Enum.Material.Neon
			},
			Union = {
				UsePartColor = false,
				Material = Enum.Material.Neon
			},
			Part = {
				Color = Color3.fromRGB(151,0,0),
				Material = Enum.Material.Neon
			},
			spike = {
				Color = Color3.fromRGB(151,0,0),
				Material = Enum.Material.Neon
			}
		},{
			Text = "",
			NoSound = true
		},{
		},{
		})
	end
end

local Filter = true
Player.Chatted:connect(function(text)
	if text == "filter/" then

		filter()
		ChatFunc("Filter has been set to "..tostring(Filter)..".")
	elseif text:sub(1,5) == "play/" then
		lastitem:SetAttribute("SongId",text:sub(6))
		defaultsound = lastitem:GetAttribute("SongId")
		lastitem:SetAttribute("LastPitch",1)
		sick.TimePosition = 0
		funnypitch = lastitem:GetAttribute("LastPitch")	
		pcall(function()
			ChatFunc("Now playing "..game:GetService("MarketplaceService"):GetProductInfo(defaultsound).Name..".")	
		end)
	elseif text:sub(1,6) == "pitch/"  then
		lastitem:SetAttribute("LastPitch",text:sub(7))
		funnypitch = lastitem:GetAttribute("LastPitch")
		ChatFunc("Pitch was set to "..funnypitch..".")
	elseif text:sub(1,4) == "vol/" then
		lastitem:SetAttribute("LastVolume",text:sub(5))
		lastvolume = lastitem:GetAttribute("LastVolume")
		ChatFunc("Volume was set to "..lastvolume..".")
	elseif text:sub(1,5) == "mode/" then

		lastitem:SetAttribute("Mode",text:sub(6))
		mode = lastitem:GetAttribute("Mode")
		if mode == "Gungo" then
			lastitem:SetAttribute("SongId",12788777815)
			defaultsound = lastitem:GetAttribute("SongId")
			sick.TimePosition = 0
		else
			local songtable = {12725606539,12728172917,12753820609,12599940563,12467281179,12423860071,12425207359,12406848557}
			lastitem:SetAttribute("Mode","Default")
			mode = lastitem:GetAttribute("Mode")
			lastitem:SetAttribute("SongId",songtable[math.random(1,#songtable)])
			defaultsound = lastitem:GetAttribute("SongId")
			sick.TimePosition = 0
		end
	elseif text:sub(1,5) == "skip/"  then
		sick.TimePosition = text:sub(6)
		ChatFunc("Skipped to "..sick.TimePosition..".",true)

	elseif text:sub(1,6) == "unban/" then

		for i = 1, #_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
		do
			if _G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
				[i] == text:sub(7) then
				table.remove(_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
					,i)
			end
		end
		ChatFunc("Unbanned "..text:sub(7)..".",true)
	elseif text:sub(1,4) == "ban/" then

		--[[for i = 1, #_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
		do
		end]]
		table.insert (_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
			,text:sub(5))
		for i,v in pairs(game:GetService("Players"):GetPlayers())do
			CheckForBan(v)
		end
		ChatFunc("Banned "..text:sub(5)..".",true)
	elseif text:sub(1,6) == "clear/" then
		task.spawn(function()
			ChatFunc("Clearing ban tables.")
			RWait(2)
			if #_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ >1 then
				ChatFunc("Cleared "..#_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ.." bans.")
			else
				ChatFunc("Cleared "..#_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ.." ban.")
			end
			table.clear(_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ)
		end)
	elseif text:sub(1,5) == "bans/" then
		task.spawn(function()
			ChatFunc("Players currently banned are:")
			RWait(3)
			for i = 1, #_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ
			do
				RWait(0.5)
				ChatFunc(_G.GlobalbansDSKJLFDKLSJFKLJDSKLJFKLJSDFKLJSDKLJFKLJSDKLJDFKLJSDFSDKLJSDFKLJDFKLJFSKLJFFKLJFDKLJFFKLJSFSDKLJFSDKLJFSDKLJFDFKLJSFKLJFFKLJSDFSDKLJFKLJSDKLJSDSFDKLJSFDKLJFSFKLJSDFSDKLJFSDKLJFSDFKLJKLJFFKLJSFSKLJ[i])
			end
		end)
	elseif text:sub(1,8) == "players/" then
		task.spawn(function()
			ChatFunc("Current players on the server are:")
			RWait(3)
			for _,pl in pairs(Plrs:GetPlayers()) do
				RWait(0.5)
				ChatFunc(pl.Name)
			end
		end)
	elseif text:sub(1,2) == "/e" then

	else
		if(Filter)then
			local filter,text = pcall(function() return game:service'Chat':FilterStringForBroadcast(text,Player) end)
			if(not Filter)then
				text = string.rep("*",#text)
			end
			ChatFunc(text,false)
		else
			ChatFunc(text,false)
		end
	end
end)


function filter()
	if Filter == true then Filter = false  elseif Filter == false then Filter = true  end
end

--RayCast

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end
local ig = {Character}
function Raycast2(p1,p2,dist)
	local ray = Ray.new(p1, (p2 - p1).unit * dist)

	local part, position,normal = workspace:FindPartOnRayWithIgnoreList(ray, ig, false, true)

	if part.Parent:IsA("Accessory") then
		table.insert(ig,part) -- adds to the ignore list

		return Raycast2(p1,p2,dist) -- do the raycast again
	else
		return part,position,normal
	end
end


function LimbRemove(LOC,AIMTO,OUCH)
	pcall(function()
		for i = 1, 1 do
			local POS1 = cf(LOC,AIMTO)*cf(0,0,-45).p
			local AIMPOS = cf(LOC,POS1) * cf(0,0,-45) * angles(rad(0), rad(0), rad(0))*cf(0,0,10).p
			local HIT,POS = Raycast2(LOC,AIMPOS,5)
			local DISTANCE = (POS - LOC).Magnitude
			if HIT then
				local HUM = nil
				if HIT.Parent:FindFirstChildOfClass("Humanoid") then
					HUM = HIT.Parent:FindFirstChildOfClass("Humanoid")
				elseif HIT.Parent.Parent:FindFirstChildOfClass("Humanoid") then
					HUM = HIT.Parent.Parent:FindFirstChildOfClass("Humanoid")
				end
				if HUM then

				end
			end

			local Z = rand(150,255)
			print(HIT.Name)
			HIT:Destroy()
		end
	end)

end



function damagingPuddle(Cframe,size,damage,slow)
	task.spawn(function()
		local trol = nil
		if slow then
			trol = effect(2
				,Color3.fromRGB(255,0,0) --first color
				,Color3.fromRGB(0, 0, 0) --second color
				,Cframe --first CFrame value
				,Cframe --second CFrame value
				,vt(0.1,size,size) --first size
				,vt(0.09,size,size) --second size
				,0 --first transparency value
				,0 --second transparency value
				,"Cylinder" --MeshType
				,"Neon" --Material
				,Enum.EasingStyle.Sine--EasingStyle
				,Enum.EasingDirection.Out --EasingDirection
				,"Fade" --End Effect
			)
		else 
			trol = effect(2
				,Color3.fromRGB(255,0,0) --first color
				,Color3.fromRGB(0, 0, 0) --second color
				,Cframe --first CFrame value
				,Cframe --second CFrame value
				,vt(0.1,size,size) --first size
				,vt(0,0,0) --second size
				,0 --first transparency value
				,0 --second transparency value
				,"Cylinder" --MeshType
				,"Neon" --Material
				,Enum.EasingStyle.Sine--EasingStyle
				,Enum.EasingDirection.Out --EasingDirection
				,"None" --End Effect
			)
		end
		repeat 
			RWait()
			ApplyAoEH(trol.Position,size-2,damage,false)
		until trol.Parent ~= Effects

	end)

end

function TDeath(Human)
	if Human:FindFirstChild("Killed") == nil then
		local Mark = it("Folder",Human)
		Mark.Name = "Killed"
		local TORSO = Human.Parent:FindFirstChild("Torso") or Human.Parent:FindFirstChild("UpperTorso")
		--ChatFunc("Goodbye, "..Human.Parent.Name..".",false)

		task.spawn(function()
			RWait()
			local Z = rand(0,255)
			for index, CHILD in pairs(Human.Parent:GetChildren()) do
				if CHILD:IsA("BasePart") then
					if CHILD.Name == "Head" then
						local randx = rand(-360,360)
						local randy = rand(-360,360)
						local randz = rand(-360,360)
						local sounder =effect(
							1,
							Color3.fromRGB(124, 0, 0), --first color
							Color3.fromRGB(0, 0, 0), --second color
							CHILD.CFrame, --first CFrame value
							CHILD.CFrame*angles(rad(rand(-360,360)),rad(rand(-360,360)),rad(rand(-360,360))), --second CFrame value
							CHILD.Size, --first size
							vt(0,0,0),--second size
							0, --first transparency value
							1, --second transparency value
							"Block", --MeshType
							"Neon", --Material
							Enum.EasingStyle.Back, --EasingStyle
							Enum.EasingDirection.In, --EasingDirection
							"Don't destroy" --End Effect
						)
						CreateSound(9116406043,sounder,10,rand(7,9)/10,0,false)
						Services.Debris:AddItem(sounder,5)
						CHILD:Destroy()
					elseif CHILD.Name ~= "HumanoidRootPart" then
						local randx = rand(-360,360)
						local randy = rand(-360,360)
						local randz = rand(-360,360)
						local sounder=effect(
							1,
							Color3.fromRGB(124, 0, 0), --first color
							Color3.fromRGB(0, 0, 0), --second color
							CHILD.CFrame, --first CFrame value
							CHILD.CFrame*angles(rad(rand(-360,360)),rad(rand(-360,360)),rad(rand(-360,360))), --second CFrame value
							CHILD.Size, --first size
							vt(0,0,0),--second size
							0, --first transparency value
							1, --second transparency value
							"Block", --MeshType
							"Neon", --Material
							Enum.EasingStyle.Back, --EasingStyle
							Enum.EasingDirection.In, --EasingDirection
							"Don't destroy" --End Effect
						)
						CreateSound(9116406043,sounder,10,rand(7,9)/10,0,false)
						CreateSound(9116406043,sounder,10,rand(7,9)/10,0,false)
						Services.Debris:AddItem(sounder,5)
						CHILD:Destroy()
					end
				end
			end
			Human.MaxHealth = 0
			Human.Health = 0
			Human.Parent:Destroy()

		end)
	end
end

function TKick(Human)
	if Human:FindFirstChild("Killed") == nil then
		local Mark = it("Folder",Human)
		Mark.Name = "Killed"
		local TORSO = Human.Parent:FindFirstChild("Torso") or Human.Parent:FindFirstChild("UpperTorso")
		task.spawn(function()
			RWait()
			local Z = rand(0,255)
			for index, CHILD in pairs(Human.Parent:GetChildren()) do
				if CHILD:IsA("BasePart") then
					if CHILD.Name == "Head" then
						coroutine.resume(coroutine.create(function()
							local Proj = projectile:Clone()
							local hit = false
							Proj.Parent = Effects
							Proj.Position = CHILD.Position
							Proj.Orientation = vt(0,0,0)
							local GOTO = Proj.CFrame*cf(rand(-10,10),10,rand(-10,10)).Position
							Proj.CFrame = cf(Proj.Position,GOTO)
							for i = 1, 50 do
								RWait()				
								local hit,pos,normal = Raycast(Proj.Position,Proj.CFrame.lookVector,5,Character)
								Proj.CFrame = Proj.CFrame*cf(0,0,-2)*angles(rad(-5),rad(0),rad(0))
								if hit then
									Proj.CFrame = cf(pos)
									damagingPuddle(cf(pos,pos+normal)* angles(rad(0), rad(90), rad(0)),rand(1,5),1,false)

									break
								end
							end



							Proj.CFrame = cf(Proj.Position)
							Proj.Size = vt(0,0,0)
							hit = true
							Services.Debris:AddItem(Proj,2)
						end))
						local randx = rand(-360,360)
						local randy = rand(-360,360)
						local randz = rand(-360,360)
						local sounder =effect(
							0.5,
							Color3.fromRGB(124, 0, 0), --first color
							Color3.fromRGB(0, 0, 0), --second color
							CHILD.CFrame * cf(0, 0, 0) * angles(rad(randx), rad(randy), rad(randz)), --first CFrame value
							CHILD.CFrame * cf(0,0,0) * angles(rad(randx), rad(randy), rad(randz)), --second CFrame value
							vt(1,1,1), --first size
							vt(0,50,0),--second size
							0, --first transparency value
							1, --second transparency value
							"Sphere", --MeshType
							"Neon", --Material
							Enum.EasingStyle.Quad, --EasingStyle
							Enum.EasingDirection.InOut, --EasingDirection
							"Don't destroy" --End Effect
						)
						CreateSound(3359047385,sounder,5,rand(8,12)/10,0,false)
						Services.Debris:AddItem(sounder,5)
						CHILD:Destroy()
					elseif CHILD.Name ~= "HumanoidRootPart" then
						local randx = rand(-360,360)
						local randy = rand(-360,360)
						local randz = rand(-360,360)
						local sounder =effect(
							0.5,
							Color3.fromRGB(124, 0, 0), --first color
							Color3.fromRGB(0, 0, 0), --second color
							CHILD.CFrame * cf(0, 0, 0) * angles(rad(randx), rad(randy), rad(randz)), --first CFrame value
							CHILD.CFrame * cf(0,0,0) * angles(rad(randx), rad(randy), rad(randz)), --second CFrame value
							vt(1,1,1), --first size
							vt(0,50,0),--second size
							0, --first transparency value
							1, --second transparency value
							"Sphere", --MeshType
							"Neon", --Material
							Enum.EasingStyle.Quad, --EasingStyle
							Enum.EasingDirection.InOut, --EasingDirection
							"Don't destroy" --End Effect
						)
						coroutine.resume(coroutine.create(function()
							local Proj = projectile:Clone()
							local hit = false
							Proj.Parent = Effects
							Proj.Position = CHILD.Position
							Proj.Orientation = vt(0,0,0)
							local GOTO = Proj.CFrame*cf(rand(-10,10),10,rand(-10,10)).Position
							Proj.CFrame = cf(Proj.Position,GOTO)
							for i = 1, 50 do
								RWait()				
								local hit,pos,normal = Raycast(Proj.Position,Proj.CFrame.lookVector,5,Character)
								Proj.CFrame = Proj.CFrame*cf(0,0,-2)*angles(rad(-5),rad(0),rad(0))
								if hit then
									Proj.CFrame = cf(pos)
									damagingPuddle(cf(pos,pos+normal)* angles(rad(0), rad(90), rad(0)),rand(1,5),1,false)

									break
								end
							end




							Proj.CFrame = cf(Proj.Position)
							Proj.Size = vt(0,0,0)
							hit = true
							Services.Debris:AddItem(Proj,2)
						end))
						CreateSound(3359047385,sounder,5,rand(8,12)/10,0,false)
						Services.Debris:AddItem(sounder,5)
						CHILD:Destroy()
					end
				end
			end
			Human.MaxHealth = 0
			Human.Health = 0
			Human.Parent:Destroy()

		end)
	end
end

function TGrab(Human)
	if Human:FindFirstChild("Killed") == nil then
		local Mark = it("Folder",Human)
		Mark.Name = "Killed"
		local TORSO = Human.Parent:FindFirstChild("Torso") or Human.Parent:FindFirstChild("UpperTorso")

		task.spawn(function()
			RWait()
			local Z = rand(0,255)
			for index, CHILD in pairs(Human.Parent:GetChildren()) do
				if CHILD:IsA("BasePart") then
					if CHILD.Name == "Head" then
						local randx = rand(-360,360)
						local randy = rand(-360,360)
						local randz = rand(-360,360)
						local sounder =effect(
							1,
							Color3.fromRGB(124, 0, 0), --first color
							Color3.fromRGB(0, 0, 0), --second color
							CHILD.CFrame, --first CFrame value
							CHILD.CFrame*angles(rad(rand(-360,360)),rad(rand(-360,360)),rad(rand(-360,360))), --second CFrame value
							CHILD.Size, --first size
							vt(0,0,0),--second size
							0, --first transparency value
							1, --second transparency value
							"Block", --MeshType
							"Neon", --Material
							Enum.EasingStyle.Back, --EasingStyle
							Enum.EasingDirection.In, --EasingDirection
							"Don't destroy" --End Effect
						)
						CreateSound(9116406043,sounder,10,rand(7,9)/10,0,false)
						CHILD:Destroy()
					elseif CHILD.Name ~= "HumanoidRootPart" then
						local randx = rand(-360,360)
						local randy = rand(-360,360)
						local randz = rand(-360,360)
						local sounder=effect(
							1,
							Color3.fromRGB(124, 0, 0), --first color
							Color3.fromRGB(0, 0, 0), --second color
							CHILD.CFrame, --first CFrame value
							CHILD.CFrame*angles(rad(rand(-360,360)),rad(rand(-360,360)),rad(rand(-360,360))), --second CFrame value
							CHILD.Size, --first size
							vt(0,0,0),--second size
							0, --first transparency value
							1, --second transparency value
							"Block", --MeshType
							"Neon", --Material
							Enum.EasingStyle.Back, --EasingStyle
							Enum.EasingDirection.In, --EasingDirection
							"Don't destroy" --End Effect
						)
						CreateSound(9116406043,sounder,10,rand(7,9)/10,0,false)

						CHILD:Destroy()
					end
				end
			end
			Human.MaxHealth = 0
			Human.Health = 0
			Human.Parent:Destroy()

		end)
	end
end

function TDestroy(Part)

	--ChatFunc("Goodbye, "..Part.Name..".",false)

	task.spawn(function()
		RWait()
		local Z = rand(0,255)
--[[		coroutine.resume(coroutine.create(function()
			local Proj = projectile:Clone()
			local hit = false
			Proj.Parent = Effects
			Proj.Position = Part.Position
			Proj.Orientation = vt(0,0,0)
			local GOTO = Proj.CFrame*cf(rand(-10,10),10+Part.Size.Y,rand(-10,10)).Position
			Proj.CFrame = cf(Proj.Position,GOTO)
			for i = 1, 50 do
				RWait()				
				local hit,pos,normal = Raycast(Proj.Position,Proj.CFrame.lookVector,5,Character)
				Proj.CFrame = Proj.CFrame*cf(0,0,-2)*angles(rad(-5),rad(0),rad(0))
				if hit then
					Proj.CFrame = cf(pos)
					for i = 1,math.floor(Part.Size.Z) do
						damagingPuddle(cf(pos,pos+normal)* angles(rad(0), rad(90), rad(0)),rand(1,5),1,false)
					end
					break
				end
			end



			Proj.CFrame = cf(Proj.Position)
			Proj.Size = vt(0,0,0)
			hit = true
			Services.Debris:AddItem(Proj,2)
		end))]]

		local sounder =effect(
			1,
			Color3.fromRGB(124, 0, 0), --first color
			Color3.fromRGB(0, 0, 0), --second color
			Part.CFrame, --first CFrame value
			Part.CFrame*angles(rad(rand(-360,360)),rad(rand(-360,360)),rad(rand(-360,360))), --second CFrame value
			Part.Size, --first size
			vt(0,0,0),--second size
			0, --first transparency value
			1, --second transparency value
			"Block", --MeshType
			"Neon", --Material
			Enum.EasingStyle.Back, --EasingStyle
			Enum.EasingDirection.In, --EasingDirection
			"Don't destroy" --End Effect
		)
		CreateSound(9116406043,sounder,5,rand(7,9)/10,0,false)
		CreateSound(9116406043,sounder,5,rand(7,9)/10,0,false)
		CreateSound(9116406043,sounder,5,rand(7,9)/10,0,false)
		Services.Debris:AddItem(sounder,5)
		Part:Destroy()



	end)

end


function SpawnRay(Spawnfrom,aimto,random)

	local POS1 = cf(Spawnfrom,aimto)*cf(0,0,-45).p
	local AIMPOS = cf(Spawnfrom,POS1) * cf(0,0,-45) * angles(rad(rand(-random,random)), rad(rand(-random,random)), rad(rand(-random,random)))*cf(0,0,10).p
	local HIT,POS = CastProperRay(Spawnfrom,AIMPOS,1000,Character)
	local DISTANCE = (POS - Spawnfrom).Magnitude
	local raytable = {POS,HIT}


	return raytable

end

function TDamage(Human,Damage,effecte)
	if Human:FindFirstChild("Killed") == nil then
		local TORSO = Human.Parent:FindFirstChild("Torso") or Human.Parent:FindFirstChild("UpperTorso")

		task.spawn(function()
			RWait()
			local Z = rand(0,255)
			for index, CHILD in pairs(Human.Parent:GetChildren()) do
				if CHILD:IsA("BasePart") then
					if CHILD.Name == "Head" then
						local randx = rand(-360,360)
						local randy = rand(-360,360)
						local randz = rand(-360,360)
						if effecte then
							local sounder =effect(
								0.5,
								Color3.fromRGB(124, 0, 0), --first color
								Color3.fromRGB(0, 0, 0), --second color
								CHILD.CFrame * cf(0, 0, 0) * angles(rad(randx), rad(randy), rad(randz)), --first CFrame value
								CHILD.CFrame * cf(0,0,0) * angles(rad(randx), rad(randy), rad(randz)), --second CFrame value
								vt(1,1,1), --first size
								vt(1,10,1),--second size
								0, --first transparency value
								1, --second transparency value
								"Sphere", --MeshType
								"Neon", --Material
								Enum.EasingStyle.Sine, --EasingStyle
								Enum.EasingDirection.InOut, --EasingDirection
								"Don't destroy" --End Effect
							)
							CreateSound(8117381233,sounder,1,1,1,false)
							Services.Debris:AddItem(sounder,5)
						end


					elseif CHILD.Name ~= "HumanoidRootPart" then
						local randx = rand(-360,360)
						local randy = rand(-360,360)
						local randz = rand(-360,360)
						if effecte then
							local sounder =effect(
								0.5,
								Color3.fromRGB(124, 0, 0), --first color
								Color3.fromRGB(0, 0, 0), --second color
								CHILD.CFrame * cf(0, 0, 0) * angles(rad(randx), rad(randy), rad(randz)), --first CFrame value
								CHILD.CFrame * cf(0,0,0) * angles(rad(randx), rad(randy), rad(randz)), --second CFrame value
								vt(1,1,1), --first size
								vt(1,10,1),
								--second size
								0, --first transparency value
								1, --second transparency value
								"Sphere", --MeshType
								"Neon", --Material
								Enum.EasingStyle.Sine, --EasingStyle
								Enum.EasingDirection.InOut, --EasingDirection
								"Don't destroy" --End Effect
							)
							CreateSound(8117381233,sounder,1,1,1,false)
							Services.Debris:AddItem(sounder,5)
						end

					end
				end
			end
			Human.Health = Human.Health -Damage

		end)
	end
end

function ApplyAoEH(Position,Range,Damage,Insta)
	local boxPosition = cf(Position)
	local boxSize = vt(Range,Range,Range)
	local maxObjectsAllowed = 10
	local params = OverlapParams.new(Cachetable,Enum.RaycastFilterType.Blacklist,maxObjectsAllowed,"Default")
	local CHILDREN =workspace:GetPartBoundsInBox(boxPosition,boxSize,params)	
	for index, CHILD in pairs(CHILDREN) do
		if  CHILD.Parent ~= Effects and CHILD.Name == "HumanoidRootPart" then
			local HUM = CHILD.Parent:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD.Parent:FindFirstChild("Torso") or CHILD.Parent:FindFirstChild("UpperTorso")
				if TORSO then

					if table.find(Cachetable, CHILD) then

					else
						TDeath(TORSO)
					end	
				end
			end
		end
	end
end

function ApplyAoEP(Position,Range)

	local boxPosition = cf(Position)
	local boxSize = vt(Range,Range,Range)
	local maxObjectsAllowed = 10
	local params = OverlapParams.new(Cachetable,Enum.RaycastFilterType.Blacklist,10,"Default")

	local CHILDREN = workspace:GetPartBoundsInBox(boxPosition,boxSize,params)
	for i, v in pairs(CHILDREN) do

	end
	for index, CHILD in pairs(CHILDREN) do

		if CHILD.Parent ~= Effects and CHILD.Parent.Parent ~= Character then
			local truesize = CHILD.Size.x +CHILD.Size.y +CHILD.Size.z
			local sw = CHILD:FindFirstChildOfClass("SpecialMesh")
			local MassSize = 0
			local Sizev = CHILD.Size
			if sw then
				MassSize = sw.Scale.X + sw.Scale.Y +  sw.Scale.Z
				Sizev = Vector3.new(sw.Scale.X,sw.Scale.Y,sw.Scale.Z)
			else
				MassSize = CHILD.Size.X + CHILD.Size.Y + CHILD.Size.Z
			end
			if table.find(Cachetable, CHILD) then

			else

				if MassSize >= 300 and not CHILD:IsA("UnionOperation") then
				else
					TDestroy(CHILD)
				end


			end	



		end
	end
end



function ShakeArea(Position,Range,Power,Length)
	local boxPosition = cf(Position)
	local boxSize = vt(Range,Range,Range)
	local maxObjectsAllowed = 10
	local params = OverlapParams.new(Cachetable,Enum.RaycastFilterType.Blacklist,maxObjectsAllowed,"Default")
	local CHILDREN =workspace:GetPartBoundsInBox(boxPosition,boxSize,params)	
	for index, CHILD in pairs(CHILDREN) do
		if  CHILD.Parent ~= Effects and CHILD.Name == "HumanoidRootPart" then
			local HUM = CHILD.Parent:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD.Parent:FindFirstChild("Torso") or CHILD.Parent:FindFirstChild("UpperTorso")
				if TORSO then
					ApplyShake(Power,Length,HUM.Parent)
				end
			end
		end
	end
end


projectile = script.Proj
projectile.Parent = nil

--welds and such

--[[
local hd = script.hd
hd.Parent = Character
hd.CFrame = Head.CFrame
weldBetween(Head,hd)
local headweld = CreateWeldOrSnapOrMotor("Weld", Head, Head, hd, cf(0, 0, 0), cf(0, 0, 0))
headweld.C0 = headweld.C0 * angles(rad(-0), rad(0), rad(0))
]]
CharWelds = Instance.new("Model")
CharWelds.Name = "CharWelds"
CharWelds.Parent = Character


Enforcer = Baseenforcer:Clone()
Enforcer.Parent = CharWelds
Enforcer.CFrame = RightArm.CFrame
weldBetween(RightArm,Enforcer)
EnforcerWeld = CreateWeldOrSnapOrMotor("Weld", RightArm, RightArm, Enforcer, cf(0, 0, 0), cf(0, 0, 0))
EnforcerWeld.C0 = EnforcerWeld.C0 * angles(rad(0), rad(0), rad(0))
EnforcerC0 = cf(0, -1, 0) * angles(rad(0), rad(-90), rad(0))* angles(rad(0), rad(0), rad(90))
EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), 3 / Animation_Speed)



auraPart =it("Part",CharWelds)
auraPart.CFrame = Torso.CFrame
auraPart.CanCollide = false
auraPart.Size = vt(3,5,3)
auraPart.Transparency = 1
auraPart.Massless = true
weldBetween(Torso,auraPart)
CreateWeldOrSnapOrMotor("Weld", Torso, Torso, auraPart, cf(0, 0, 0), cf(0, 0, 0))

antibubble = it("Part",Character)
antibubble.Anchored = true
antibubble.Position = vt(0,9999,0)


aura = script.Aura

aura.Parent = nil
particles = {}
for i,v in pairs(aura:GetChildren()) do
	local fakeaura = v:Clone()
	fakeaura.Parent = auraPart
	table.insert(particles,fakeaura)
end



--New Joints
Neck,RightShoulder,LeftShoulder,RightHip,LeftHip,RootJoint = NewJoint(Torso,Head,cf(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),cf(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)),NewJoint(Torso,RightArm,cf(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),cf(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)),NewJoint(Torso,LeftArm,cf(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),cf(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)),NewJoint(Torso,RightLeg,cf(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),cf(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)),NewJoint(Torso,LeftLeg,cf(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),cf(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)),NewJoint(RootPart,Torso,cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0))

--attacks
function Taunt()
	attack = true
	Rooted = true
	CreateSound(6276581181,Torso,10,0.8,false)
	for i=0, 0.1, 0.003 / Animation_Speed do
		RWait()	

		EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(-0.1, 0, 0) * angles(rad(0-5*cos(sine / 3)), rad(0), rad(95+5*cos(sine / 3))), 0.6 / Animation_Speed)
		RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0.3, -0.1+0.2*cos(sine/3)) * angles(rad(-20), rad(0), rad(0)), 0.6 / Animation_Speed)
		Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, -0.05, 0+0.05*sin(sine/3)) * angles(rad(-10), rad(0), rad(0)), 0.6 / Animation_Speed)
		RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5+0.1*sin(sine/3), 0) * angles(rad(-20), rad(0), rad(10+10*sin(sine/3)))* RightShoulderC0, 0.6 / Animation_Speed)
		LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5+0.1*sin(sine/3), 0) * angles(rad(-20), rad(0), rad(-10-10*sin(sine/3))) * LeftShoulderC0, 0.6 / Animation_Speed)
		RightHip.C0 = lerp(RightHip.C0, cf(1, -1-0.2*cos(sine/3), 0) * angles(rad(-20), rad(-5), rad(5)) * angles(rad(-3*cos(sine/3)), rad(90), rad(0)), 0.6 / Animation_Speed)
		LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1-0.2*cos(sine/3) , 0) * angles(rad(-20), rad(5), rad(-5)) * angles(rad(-3*cos(sine/3)), rad(-90), rad(0)), 0.6 / Animation_Speed)
	end
	attack = false
	Rooted = false
end

function Shoot()
	attack = true
	Rooted = false
	Speed = 14
	local GYRO = it("BodyGyro", RootPart)
	GYRO.D = 20
	GYRO.P = 900000000000000
	GYRO.MaxTorque = vt(0, 400000000, 0)
	CreateSound(9119720940,Torso,10,0.8,false)
	for i=0, 0.1, 0.015 / Animation_Speed do
		RWait()	
		EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), 0.35 / Animation_Speed)

		GYRO.CFrame = cf(RootPart.Position, mouse.Hit.Position)

		RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0) * angles(rad(0), rad(0), rad(20)), 0.35 / Animation_Speed)
		Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(-20)), 0.35 / Animation_Speed)
		RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad(90), rad(0), rad(15))* RightShoulderC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5-0.1*sin(sine / 22), 0) * angles(rad(170), rad(0), rad(30)) * LeftShoulderC0, 0.35 / Animation_Speed)
		RightHip.C0 = lerp(RightHip.C0, cf(1, -1, 0) * angles(rad(0), rad(-5), rad(2)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1 , 0) * angles(rad(0), rad(5), rad(-2)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)
		if keyhold == false then
			break
		end		
	end
	if keyhold then
		repeat
			GYRO.CFrame = cf(RootPart.Position, mouse.Hit.Position)

			local shot = SpawnRay(Torso.Position,Mouse.Hit.Position,0)
			if Delete then

				ApplyAoEP(shot[1],8)
			else
				ApplyAoEH(shot[1],8,0,true)	
			end
			ShakeArea(shot[1],15,1,1)
			Lightning(Enforcer.Enforcer.Barrel.Position,shot[1],5,1,Color3.fromRGB(255,0,0),0.5,0,2,0,true,0.05)
			RWait(0.05)
			local sound =effect(1
				,Color3.fromRGB(244,0,0)
				,Color3.fromRGB(124,0,0) 
				,cf(shot[1])* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
				,cf(shot[1])* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
				,vt(0,0,0) 
				,vt(5,5,5) 
				,0 
				,0 
				,"Block" 
				,"Neon" 
				,Enum.EasingStyle.Back 
				,Enum.EasingDirection.Out 
				,"Fade" 
			)
			effect(0.5
				,Color3.fromRGB(244,0,0)
				,Color3.fromRGB(244,0,0) 
				,Enforcer.Enforcer.Barrel.CFrame* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
				,Enforcer.Enforcer.Barrel.CFrame* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
				,vt(0,0,0) 
				,vt(5,5,5) 
				,0 
				,1
				,"Block" 
				,"Neon" 
				,Enum.EasingStyle.Linear 
				,Enum.EasingDirection.InOut 
				,"Fade" 
			)
			--CreateSound(305695604,sound,0.5,0.8,false)
			CreateSound(9058737882,Enforcer.Enforcer.Barrel,1,0.8,false)
			for i=0, 0.1, 0.03 / Animation_Speed do
				RWait()	
				EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(-30)), 1 / Animation_Speed)

				GYRO.CFrame = cf(RootPart.Position, mouse.Hit.Position)

				RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0) * angles(rad(0), rad(0), rad(20)), 0.35 / Animation_Speed)
				Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(-20)), 0.35 / Animation_Speed)
				RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad(120), rad(0), rad(15))* RightShoulderC0, 1 / Animation_Speed)
				LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5-0.1*sin(sine / 22), 0) * angles(rad(170), rad(0), rad(30)) * LeftShoulderC0, 0.35 / Animation_Speed)
				RightHip.C0 = lerp(RightHip.C0, cf(1, -1, 0) * angles(rad(0), rad(-5), rad(2)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
				LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1 , 0) * angles(rad(0), rad(5), rad(-2)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)

			end

			for i=0, 0.1, 0.02 / Animation_Speed do
				RWait()	
				EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), 0.35 / Animation_Speed)

				GYRO.CFrame = cf(RootPart.Position, mouse.Hit.Position)

				RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0) * angles(rad(0), rad(0), rad(20)), 0.35 / Animation_Speed)
				Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(-20)), 0.35 / Animation_Speed)
				RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad(90), rad(0), rad(15))* RightShoulderC0, 0.35 / Animation_Speed)
				LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5-0.1*sin(sine / 22), 0) * angles(rad(170), rad(0), rad(30)) * LeftShoulderC0, 0.35 / Animation_Speed)
				RightHip.C0 = lerp(RightHip.C0, cf(1, -1, 0) * angles(rad(0), rad(-5), rad(2)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
				LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1 , 0) * angles(rad(0), rad(5), rad(-2)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)
				if keyhold == false then
					break
				end		
			end
		until keyhold == false
	end

	GYRO:Destroy()
	attack = false
	Rooted = false
end

function Skybomb()
	attack = true
	Rooted = false
	Speed = 14
	local GYRO = it("BodyGyro", RootPart)
	GYRO.D = 20
	GYRO.P = 900000000000000
	GYRO.MaxTorque = vt(0, 400000000, 0)
	local amount = 0
	CreateSound(9119720940,Torso,10,0.8,false)
	local chargeup = CreateSound(864313872,Enforcer.Enforcer,5,0.1,0,true)
	chargeup.Looped = true
	for i=0, 25, 0.5 / Animation_Speed do
		RWait()	
		EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), 0.35 / Animation_Speed)
		amount = i
		chargeup.PlaybackSpeed = i /20
		GYRO.CFrame = cf(RootPart.Position, mouse.Hit.Position)

		RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0) * angles(rad(0), rad(0), rad(20)), 0.35 / Animation_Speed)
		Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(-20)), 0.35 / Animation_Speed)
		RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad(180), rad(0), rad(0))* RightShoulderC0, 0.35 / Animation_Speed)
		LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5-0.1*sin(sine / 22), 0) * angles(rad(170), rad(0), rad(30)) * LeftShoulderC0, 0.35 / Animation_Speed)
		RightHip.C0 = lerp(RightHip.C0, cf(1, -1, 0) * angles(rad(0), rad(-5), rad(2)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
		LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1 , 0) * angles(rad(0), rad(5), rad(-2)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)	
		if keyhold == false then
			break
		end		
	end
	chargeup:Destroy()
	if amount > 5 then
		local mousepos = Mouse.Hit.Position


		task.spawn(function()

			for i = 1,math.floor(amount) do
				RWait(0.3)
				local aim = math.random(0-i*2,0+i*2)
				local aim2 = math.random(0-i*2,0+i*2)
				local shot = SpawnRay(mousepos+vt(aim,55,aim2),mousepos+vt(aim,0,aim2),0)
				ShakeArea(shot[1],15+i,1+i/15,1+i/5)

				Lightning(mousepos+vt(aim,55,aim2),shot[1],5,3.5,Color3.fromRGB(255,0,0),0.5,0,1,0,false,0.1)		
				effect(1
					,Color3.fromRGB(124,0,0)
					,Color3.fromRGB(244,0,0) 
					,cf(mousepos+vt(aim,55,aim2))* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
					,cf(mousepos+vt(aim,55,aim2))* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
					,vt(5,5,5) 
					,vt(0,0,0) 
					,0 
					,0 
					,"Block" 
					,"Neon" 
					,Enum.EasingStyle.Back 
					,Enum.EasingDirection.In 
					,"Fade" 
				)
				local sound =effect(1
					,Color3.fromRGB(244,0,0)
					,Color3.fromRGB(124,0,0) 
					,cf(shot[1])* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
					,cf(shot[1])* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
					,vt(0,0,0) 
					,vt(5,5,5) 
					,0 
					,0 
					,"Block" 
					,"Neon" 
					,Enum.EasingStyle.Back 
					,Enum.EasingDirection.Out 
					,"Fade" 
				)

				if Delete then

					ApplyAoEP(shot[1],8+i/3)
				else
					ApplyAoEH(shot[1],8+i/3,0,true)	
				end
				CreateSound(305695604,sound,0.5,0.8,false)

			end



		end)
		CreateSound(9058737882,Enforcer.Enforcer.Barrel,1,0.8,false)
		effect(0.5
			,Color3.fromRGB(244,0,0)
			,Color3.fromRGB(244,0,0) 
			,Enforcer.Enforcer.Barrel.CFrame* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
			,Enforcer.Enforcer.Barrel.CFrame* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
			,vt(0,0,0) 
			,vt(5,5,5) 
			,0 
			,1
			,"Block" 
			,"Neon" 
			,Enum.EasingStyle.Linear 
			,Enum.EasingDirection.InOut 
			,"Fade" 
		)
		Lightning(Enforcer.Enforcer.Barrel.Position,Enforcer.Enforcer.Barrel.Position+vt(0,55,0),5,3.5,Color3.fromRGB(255,0,0),0.5,0,1,0,false,0.1)		
		effect(1
			,Color3.fromRGB(124,0,0)
			,Color3.fromRGB(244,0,0) 
			,cf(Enforcer.Enforcer.Barrel.Position+vt(0,55,0))* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
			,cf(Enforcer.Enforcer.Barrel.Position+vt(0,55,0))* angles(rad(rand(-360,360)), rad(rand(-360,360)), rad(rand(-360,360))) 
			,vt(5,5,5) 
			,vt(0,0,0) 
			,0 
			,0 
			,"Block" 
			,"Neon" 
			,Enum.EasingStyle.Back 
			,Enum.EasingDirection.In 
			,"Fade" 
		)
		for i=0, 0.1, 0.02 / Animation_Speed do
			RWait()	
			EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), 0.35 / Animation_Speed)


			RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0) * angles(rad(0), rad(0), rad(20)), 0.35 / Animation_Speed)
			Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(-20)), 0.35 / Animation_Speed)
			RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0, 0) * angles(rad(180), rad(0), rad(0))* RightShoulderC0, 1 / Animation_Speed)
			LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5-0.1*sin(sine / 22), 0) * angles(rad(170), rad(0), rad(30)) * LeftShoulderC0, 0.35 / Animation_Speed)
			RightHip.C0 = lerp(RightHip.C0, cf(1, -1, 0) * angles(rad(0), rad(-5), rad(2)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
			LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1 , 0) * angles(rad(0), rad(5), rad(-2)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)
			GYRO.CFrame = cf(RootPart.Position, mouse.Hit.Position)

		end
	end
	GYRO:Destroy()

	attack = false
	Rooted = false
end



teleport = false
function Warp()
	teleport = true
	local Z = rand(0,255)
	local HITFLOOR,HITPOS = Raycast(Mouse.Hit.p+vt(0,1,0), (cf(RootPart.Position, RootPart.Position + vt(0, -1, 0))).lookVector, 100, Character)
	if HITFLOOR then
		HITPOS = HITPOS + vt(0,1,0)
		local POS = RootPart.Position



		for index, CHILD in pairs(Character:GetChildren()) do
			if CHILD:IsA("BasePart") then
				if CHILD.Name == "Head" then

					local sound =effect(
						5,
						Color3.fromRGB(124, 0, 0), --first color
						Color3.fromRGB(0, 0, 0), --second color
						CHILD.CFrame * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), --first CFrame value
						CHILD.CFrame * cf(rand(-10, 10), rand(-10, 10), rand(-10, 10)) *
							angles(rad(rand(-360, 360)), rad(rand(-360, 360)), rad(rand(-360, 360))), --second CFrame value
						vt(1,1,1), --first size
						vt(rand(8, 16) / 12,rand(8, 16) / 12,rand(8, 16) / 12),
						--second size
						0, --first transparency value
						1, --second transparency value
						"Block", --MeshType
						"Neon", --Material
						Enum.EasingStyle.Sine, --EasingStyle
						Enum.EasingDirection.InOut, --EasingDirection
						"None" --End Effect
					)
					CreateSound(164320294,sound,3,rand(9,11)/10,0,false)
					Services.Debris:AddItem(sound,5)
				elseif CHILD.Name ~= "HumanoidRootPart" then
					effect(
						5,
						Color3.fromRGB(124, 0, 0), --first color
						Color3.fromRGB(0, 0, 0), --second color
						CHILD.CFrame * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), --first CFrame value
						CHILD.CFrame * cf(rand(-10, 10), rand(-10, 10), rand(-10, 10)) *
							angles(rad(rand(-360, 360)), rad(rand(-360, 360)), rad(rand(-360, 360))), --second CFrame value
						CHILD.Size, --first size
						vt(rand(8, 16) / 12,rand(8, 16) / 12,rand(8, 16) / 12),
						--second size
						0, --first transparency value
						1, --second transparency value
						"Block", --MeshType
						"Neon", --Material
						Enum.EasingStyle.Sine, --EasingStyle
						Enum.EasingDirection.InOut, --EasingDirection
						"None" --End Effect
					)

				end

			end
		end



		RootPart.CFrame = cf(HITPOS,cf(POS,HITPOS)*cf(0,0,-100000).p)
		RWait(0.1)
		localshakes(0.1,0.2)
	end
	teleport =false
end

--Input
function MouseDown(Mouse)
	if attack == false then
		hold = true
	end
end
function MouseUp(Mouse)
	hold = false
end
sitting = false
keyheld = ""
function KeyDown(Key)
	if Key ~= "w" and Key ~= "a" and Key ~= "s" and Key ~= "d" and Key ~= " " and Key ~= "0" then
		if keyheld == "" then
			keyheld = Key
			keyhold = true
		end
		if Key == "z"   then
			if Delete == false then
				KillB()
			else
				DestroyA()
			end
		end	
		if Key == "x" then
			KickA()
		end
		if Key == "r"   then
			lastitem:SetAttribute("Delete", not lastitem:GetAttribute("Delete"))
			Delete = lastitem:GetAttribute("Delete")

			ChatFunc("Part destroy has been set to "..tostring(Delete)..".",true)
		end

		if Key == "t" and attack == false  then
			Taunt()
		end

		if Key == "f" and attack == false  then
			Shoot()
		end
		if Key == "c" and attack == false then
			Skybomb()
		end
		if Key == "q" and attack == false and sitting == false then
			Warp()
		end

		if Key == "p" then
			keyhold = false
			keyheld = ""
		end
	end
end




function KeyUp(Key)
	if Key ~= "w" and Key ~= "a" and Key ~= "s" and Key ~= "d" and Key ~= " " and Key ~= "0" then

		if Key == keyheld then
			keyhold = false
			keyheld = ""
		end
	end
end

Mouse.Button1Down:connect(function(NEWKEY)
	MouseDown(NEWKEY)
end)
Mouse.Button1Up:connect(function(NEWKEY)
	MouseUp(NEWKEY)
end)
Mouse.KeyDown:connect(function(NEWKEY)
	KeyDown(NEWKEY)
end)
Mouse.KeyUp:connect(function(NEWKEY)
	KeyUp(NEWKEY)
end)


--Loop
local spinning = false
local n360 = 0
local snapping = false
local lastshadow = 5

Character:FindFirstChild("Health"):Destroy()
Cachetable = {}

for _,instc in pairs(Character:GetDescendants()) do
	if instc:IsA("BasePart") then
		table.insert(Cachetable,instc)
	elseif instc:IsA("Motor6D") then
		table.insert(Cachetable,instc)
	elseif instc:IsA("WeldConstraint") then
		table.insert(Cachetable,instc)
	elseif instc:IsA("Weld") then
		table.insert(Cachetable,instc)	
	end
end

for _,instc in pairs(Character:GetChildren()) do
	if instc ~= table.find(Cachetable,instc) and not instc:IsA("ForceField") then
		table.insert(Cachetable,instc)
	end
end


for i,v in next,Cachetable do

	Cachetable[i]:GetPropertyChangedSignal("Parent"):Connect(function()
		if refitting == false then
			refit()
		end
	end)
	if Cachetable[i]:IsA("BasePart") then
		Cachetable[i]:GetPropertyChangedSignal("Anchored"):Connect(function()

			Cachetable[i].Anchored =false

		end)	
	end
end
Humanoid.Health = 0
Humanoid.MaxHealth = 0

local randomchat = {"DISGUST","HATRED","ROT","ROTTEN","DESTROYED","PAIN","MONSTER","FLESH","BLOOD","ENDLESS","DEPRESSION","SADISTIC","INSANITY","MAYHEM","CHAOS","POISION","DEATH","DESPAIR"}
allvals = CachedCFrame.Position.X +CachedCFrame.Position.Y +CachedCFrame.Position.Z
ff = it("ForceField",Character)
ff.Visible = false
Services.RunService.Stepped:Connect(
	function()

		task.spawn(function()
			Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
			Humanoid.Health = 0
			Humanoid.MaxHealth = 0
			if chatting == false then
				Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer


				if rand(1,8) == 1 then

					Humanoid.DisplayName = alphabet[rand(1,#alphabet)].."------------"..alphabet[rand(1,#alphabet)].."\n"..randomchat[rand(1,#randomchat)].."\n"..alphabet[rand(1,#alphabet)].."------------"..alphabet[rand(1,#alphabet)]	
				else
					Humanoid.DisplayName = alphabet[rand(1,#alphabet)].."------------"..alphabet[rand(1,#alphabet)].."\n Unexpectancy \n"..alphabet[rand(1,#alphabet)].."------------"..alphabet[rand(1,#alphabet)]
				end	
			else
				Humanoid.DisplayName = " "
			end
		end)
	--[[	local pl = GetClientProperty(sick,'PlaybackLoudness')
		if refitting == false then
			pl = GetClientProperty(sick,'PlaybackLoudness')
		else pl = 0
		end
		]]
		if Torso:FindFirstChild("comander_cool") ~= nil then
			lastitem:SetAttribute("LastTime", sick.TimePosition)
			lasttime = lastitem:GetAttribute("LastTime")
		end
		if Torso:FindFirstChild("comander_cool") == nil then
			sick:Destroy()
			local sickb = Instance.new("Sound",Character)
			sickb.Parent = Torso
			sick = sickb
			sickb.Pitch = funnypitch
			sickb.SoundId = "rbxassetid://"..defaultsound
			sickb.Name = "comander_cool"
			sickb:resume()
			sickb.Looped = true
			sickb.Volume = lastvolume
			sickb.MaxDistance = 80
			sickb.TimePosition = lasttime

		end
		if Character.Parent ~= workspace then
			Torso:Destroy()
		end
		if Player.Character ~= Character then
			refit()
		end
		if RootPart.Parent == Character then
			RootPart.PivotOffset=CFrame.new(0,0,0)
			if (RootPart.CFrame.Position - CachedCFrame.Position).Magnitude >= 8 and teleport == false  then

				RootPart.CFrame = CachedCFrame
				RootPart.Velocity = vt(0,0,0)
			elseif (RootPart.CFrame.Position - vt(0,0,0)).Magnitude >= 1500 then
				RootPart.CFrame = cf(0,50,0)*CachedCFrame.Rotation
			elseif RootPart.Velocity.y < -150 then
				RootPart.CFrame = cf(CachedCFrame.Position.X,50,CachedCFrame.Position.Z)*CachedCFrame.Rotation

				RootPart.Velocity = vt(0,0,0)

			elseif RootPart.Velocity.y > 150 then
				RootPart.CFrame = cf(CachedCFrame.Position.X,50,CachedCFrame.Position.Z)*CachedCFrame.Rotation

				RootPart.Velocity = vt(0,0,0)

			end

			lastitem:SetAttribute("LastCFrame",RootPart.CFrame)
			CachedCFrame = lastitem:GetAttribute("LastCFrame")

		end

		sick:ClearAllChildren()
		sick.Pitch = funnypitch
		sick.SoundId = "rbxassetid://"..defaultsound
		sick.Name = "comander_cool"
		sick.Playing = true
		sick.Looped = true
		sick.Volume = lastvolume
		sick.MaxDistance = 80
		sick.Playing = true
		Humanoid.PlatformStand = false
		sine = sine + Change
		local Testwalk1 = Humanoid.MoveDirection*Torso.CFrame.LookVector
		local Testwalk2 = Humanoid.MoveDirection*Torso.CFrame.RightVector
		local LOOKVEC = Testwalk1.X+Testwalk1.Z
		local RIGHTVEC = Testwalk2.X+Testwalk2.Z
		antibubble.Position = vt(0,9999,0)


		if (sine>360000) then sine = 0 end
		Hue = Hue + 1
		if (Hue>360) then Hue = 0 end

	--[[	if mode == "Gungo" then
			effect(0.05
				,Color3.fromRGB(pl,0,0) --first color
				,nil
				,RootPart.CFrame*cf(0,-3,0)* angles(rad(0), rad(0), rad(0)) --first CFrame value
				,nil --second CFrame value
				,vt(2+pl/100,0.3,2+pl/100) --first size
				,vt(2+pl/100,0.3,2+pl/100) --second size
				,0 --first transparency value
				,0 --second transparency value
				,"Sphere" --MeshType
				,"Neon" --Material
				,Enum.EasingStyle.Linear --EasingStyle
				,Enum.EasingDirection.Out --EasingDirection
				,"None" --End Effect
			)
		end
		]]
		local TORSOVELOCITY = (RootPart.Velocity * vt(1, 0, 1)).magnitude
		local TORSOVERTICALVELOCITY = RootPart.Velocity.y
		local HITFLOOR = Raycast(RootPart.Position, (cf(RootPart.Position, RootPart.Position + vt(0, -1, 0))).lookVector, 4, Character)

		if Humanoid.Sit == true then
			sitting = true

			EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), 0.35 / Animation_Speed)
			RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0) * angles(rad(0), rad(0), rad(0)), 0.35 / Animation_Speed)
			Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(0)), 0.35 / Animation_Speed)
			RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad(90), rad(0), rad(0))* RightShoulderC0, 1 / Animation_Speed)
			LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5, 0) * angles(rad(90), rad(0), rad(0)) * LeftShoulderC0, 0.35 / Animation_Speed)
			RightHip.C0 = lerp(RightHip.C0, cf(1, -1, 0) * angles(rad(90), rad(0), rad(0)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
			LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1 , 0) * angles(rad(90), rad(0), rad(0)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)
		else
			sitting =false
			if Anim == "Walk" and TORSOVELOCITY > 1 then
				if attack == true then

					value1 = 2.5
					value2 = value1*2
					value3 = 60
					value4 = 30
					value5 = 5
					value6 = 1
					--RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf((RIGHTVEC  - RIGHTVEC/5  * cos(sine / value1))*(value6/20)*sin(sine/value2), (LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*(value6/20)*sin(sine/value2), 0.085 - 0.045 * cos(sine / value1) + -sin(sine / value1) / 8) , 0.35 / Animation_Speed)
					RightHip.C0 = lerp(RightHip.C0, cf(1, -1+ 0.187 * sin(sine / value2),  (-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*(value6/25)*sin(sine/value2))* angles(rad((-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*value3* cos(sine / value2)),rad(0),rad((-RIGHTVEC + RIGHTVEC/5  * cos(sine / value2))*value4*cos(sine/value2)))*angles(rad(0),rad(90),rad(0)), 1 / Animation_Speed)
					LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1- 0.187 * sin(sine / value2),  (-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*-(value6/25)*sin(sine/value2))* angles(rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value3* cos(sine / value2)),rad(0),rad((RIGHTVEC - RIGHTVEC/5  * cos(sine / value2))*value4*cos(sine/value2)))*angles(rad(0),rad(-90),rad(0)), 1 / Animation_Speed)				
				end
			end
			if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
				Anim = "Jump"
				if attack == false then
					value3 = 25

					RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0) * angles(rad(-(-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(0)), 0.35 / Animation_Speed)
					Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(0)), 0.35 / Animation_Speed)
					RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(30), rad(20))* RightShoulderC0, 0.35 / Animation_Speed)
					EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(-40), rad(135)), 0.35 / Animation_Speed)
					LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(-30)) * LeftShoulderC0, 0.35 / Animation_Speed)
					RightHip.C0 = lerp(RightHip.C0, cf(1, -1, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(0)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
					LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1 , 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(0)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)
				end
			elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
				Anim = "Fall"
				if attack == false then


					RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0) * angles(rad(-(-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(0)), 0.35 / Animation_Speed)
					Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(0)), 0.35 / Animation_Speed)
					RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(30), rad(20))* RightShoulderC0, 0.35 / Animation_Speed)
					EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(-40), rad(135)), 0.35 / Animation_Speed)
					LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(-30)) * LeftShoulderC0, 0.35 / Animation_Speed)
					RightHip.C0 = lerp(RightHip.C0, cf(1, -1, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(0)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
					LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1 , 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(0), rad(0)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)
				end
			elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
				Anim = "Idle"
				if attack == false then

					--MAIN PART

					if running == true then
						Speed = runningspeed	
					else
						Speed = walkingspeed
					end


					if mode == "Default" then

						local _, Point = workspace:FindPartOnRay(Ray.new(Head.CFrame.p, Mouse.Hit.lookVector), workspace, false, true)
						local Dist = (Head.CFrame.p-Point).magnitude
						local Diff = Head.CFrame.Y-Point.Y

						EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(-0.1, 0, 0) * angles(rad(0-5*cos(sine / 22)), rad(0), rad(135+5*cos(sine / 22))), 0.35 / Animation_Speed)


						RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , -0.8 , 0+0.1*cos(sine / 22)) * angles(rad(40), rad(0), rad(0)), 0.35 / Animation_Speed)
						Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad(20-5*sin(sine / 22)+rand(-5,5)), rad(0+rand(-5,5)), rad(15*cos(sine/15)+rand(-5,5))), 0.35 / Animation_Speed)
						RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5-0.1*sin(sine / 22), 0) * angles(rad(40+5*sin(sine / 22)), rad(10), rad(0+5*sin(sine / 22)))* RightShoulderC0, 0.35 / Animation_Speed)
						LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5-0.1*sin(sine / 22), 0) * angles(rad(170), rad(0), rad(30)) * LeftShoulderC0, 0.35 / Animation_Speed)
						RightHip.C0 = lerp(RightHip.C0, cf(1, -1.3-0.1*cos(sine / 22), 0-0.05*cos(sine / 22)) * angles(rad(40), rad(-5), rad(5)) * angles(rad(0+1*cos(sine/22)), rad(90), rad(0)), 0.35 / Animation_Speed)
						LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1.3-0.1*cos(sine / 22) , 0-0.05*cos(sine / 22)) * angles(rad(40), rad(5), rad(-5)) * angles(rad(0+1*cos(sine/22)), rad(-90), rad(0)), 0.35 / Animation_Speed)

					elseif mode == "Gungo" then

						EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(-0.1, 0.2, 0) * angles(rad(-70), rad(0), rad(80+5*sin(sine/22))), 0.35 / Animation_Speed)
						RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf(0 , 0 , 0+0.1*cos(sine / 22)) * angles(rad(0), rad(0), rad(-30)), 0.35 / Animation_Speed)
						Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(30)), 0.35 / Animation_Speed)
						RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.4, 0.5, 0.1) * angles(rad(-20), rad(0), rad(-15))* RightShoulderC0, 0.35 / Animation_Speed)
						LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-0.9, 0.45+0.05*sin(sine / 22), -0.9) * angles(rad(0), rad(0), rad(0-3*cos(sine / 22)))* angles(rad(90), rad(0), rad(90)) * LeftShoulderC0, 0.35 / Animation_Speed)
						RightHip.C0 = lerp(RightHip.C0, cf(1, -1-0.1*cos(sine / 22), 0) * angles(rad(0), rad(-5), rad(0)) * angles(rad(0), rad(90), rad(0)), 0.35 / Animation_Speed)
						LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1-0.1*cos(sine / 22) , 0) * angles(rad(0), rad(5), rad(0)) * angles(rad(0), rad(-90), rad(0)), 0.35 / Animation_Speed)



					end

				end	
			elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
				Anim = "Walk"
				if attack == false then
					local _, Point = workspace:FindPartOnRay(Ray.new(Head.CFrame.p, Mouse.Hit.lookVector), workspace, false, true)
					local Dist = (Head.CFrame.p-Point).magnitude
					local Diff = Head.CFrame.Y-Point.Y
					if running then	
						Speed = runningspeed					
						value1 = 1.7
						value2 = value1*2
						value3 = 80
						value4 = 50
						value5 = 10
						value6 = 10


						EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(0), rad(115)), 0.35 / Animation_Speed)


						RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf((RIGHTVEC  - RIGHTVEC/5  * cos(sine / value1))*(value6/20)*sin(sine/value2), (LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*(value6/20)*sin(sine/value2), 0.025 - 0.015 * cos(sine / value1) + -sin(sine / value1) / 8) * angles(rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value5), rad((-RIGHTVEC - -RIGHTVEC/5  * cos(sine / value1))*value5+ (LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value6*cos(sine/value2)) , rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value6*sin(sine/value2))), 0.35 / Animation_Speed)
						RightHip.C0 = lerp(RightHip.C0, cf(1, -1+ 0.487 * sin(sine / value2),  (-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*(value6/25)*sin(sine/value2))* angles(rad((-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*value3* cos(sine / value2)),rad(0),rad((-RIGHTVEC + RIGHTVEC/5  * cos(sine / value2))*value4*cos(sine/value2)))*angles(rad(0),rad(90),rad(0)), 0.35 / Animation_Speed)
						LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1- 0.487 * sin(sine / value2),  (-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*-(value6/25)*sin(sine/value2))* angles(rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value3* cos(sine / value2)),rad(0),rad((RIGHTVEC - RIGHTVEC/5  * cos(sine / value2))*value4*cos(sine/value2)))*angles(rad(0),rad(-90),rad(0)), 0.35 / Animation_Speed)				
						Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*-value5), rad(0), rad((RIGHTVEC - -RIGHTVEC/5  * cos(sine /value1))*-value5))* angles((math.tan(Diff/Dist)*1), 0, (((Head.CFrame.p-Point).Unit):Cross(Torso.CFrame.lookVector)).Y*1), 0.35 / Animation_Speed)
						RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3/3), rad(30), rad(20))* RightShoulderC0, 0.35 / Animation_Speed)
						LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5, (-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*(value6/20)*sin(sine/value2)) * angles(rad((-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*value3* cos(sine /value2)), rad(0), rad((RIGHTVEC - RIGHTVEC/5  * cos(sine /value2))*value5)) * LeftShoulderC0, 0.35 / Animation_Speed)

					else
						Speed = walkingspeed				
						value1 = 2.5
						value2 = value1*2
						value3 = 60
						value4 = 30
						value5 = 5
						value6 = 1
						RootJoint.C0 = lerp(RootJoint.C0,RootC0 * cf((RIGHTVEC  - RIGHTVEC/5  * cos(sine / value1))*(value6/20)*sin(sine/value2), (LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*(value6/20)*sin(sine/value2), 0.085 - 0.045 * cos(sine / value1) + -sin(sine / value1) / 8) * angles(rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value5), rad((-RIGHTVEC - -RIGHTVEC/5  * cos(sine / value1))*value5+ (LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value6*cos(sine/value2)) , rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value6*sin(sine/value2))), 0.35 / Animation_Speed)
						RightHip.C0 = lerp(RightHip.C0, cf(1, -1+ 0.187 * sin(sine / value2),  (-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*(value6/25)*sin(sine/value2))* angles(rad((-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*value3* cos(sine / value2)),rad(0),rad((-RIGHTVEC + RIGHTVEC/5  * cos(sine / value2))*value4*cos(sine/value2)))*angles(rad(0),rad(90),rad(0)), 0.35 / Animation_Speed)
						LeftHip.C0 = lerp(LeftHip.C0, cf(-1, -1- 0.187 * sin(sine / value2),  (-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*-(value6/25)*sin(sine/value2))* angles(rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*value3* cos(sine / value2)),rad(0),rad((RIGHTVEC - RIGHTVEC/5  * cos(sine / value2))*value4*cos(sine/value2)))*angles(rad(0),rad(-90),rad(0)), 0.35 / Animation_Speed)				
						Neck.C0 = lerp(Neck.C0, NeckC0 * cf(0, 0, 0) * angles(rad((LOOKVEC  - LOOKVEC/5  * cos(sine / value1))*-value5), rad(0), rad((RIGHTVEC - -RIGHTVEC/5  * cos(sine /value1))*-value5))* angles((math.tan(Diff/Dist)*1), 0, (((Head.CFrame.p-Point).Unit):Cross(Torso.CFrame.lookVector)).Y*1), 0.35 / Animation_Speed)
						RightShoulder.C0 = lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(rad((-LOOKVEC  + LOOKVEC/5 )*value3), rad(30), rad(20))* RightShoulderC0, 0.35 / Animation_Speed)
						EnforcerWeld.C0 = lerp(EnforcerWeld.C0, EnforcerC0 * cf(0, 0, 0) * angles(rad(0), rad(-40), rad(135)), 0.35 / Animation_Speed)
						LeftShoulder.C0 = lerp(LeftShoulder.C0, cf(-1.5, 0.5, (-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*(value6/20)*sin(sine/value2)) * angles(rad((-LOOKVEC  + LOOKVEC/5  * cos(sine / value1))*value3* cos(sine /value2)), rad(0), rad((RIGHTVEC - RIGHTVEC/5  * cos(sine /value2))*value5)) * LeftShoulderC0, 0.35 / Animation_Speed)

					end
				end
			end 
		end



		--Humanoid.maxHealth = 1/0
		--Humanoid.Health = 1/0

		if Rooted == false then
			Humanoid.JumpPower = JumpPower
			Humanoid.WalkSpeed = Speed
			--RootPart.Anchored = false
		elseif Rooted == true then
			--RootPart.Anchored = true
			Humanoid.JumpPower = 0
			Humanoid.WalkSpeed = 0
		end

		task.spawn(function()
			n360 = n360 + 1
			if n360 > 360 then n360 = 0 end
			RightLeg.Transparency = Torso.Transparency
			LeftArm.Transparency = Torso.Transparency
			RightArm.Transparency = Torso.Transparency
			LeftLeg.Transparency = Torso.Transparency
			Head.Transparency = Torso.Transparency
			Torso.Transparency = CharacterTransparency
			for i = 1,#particles do
				particles[i]:Emit(2)
			end
			--[[for _,c in pairs(Character:GetDescendants()) do
				if c.ClassName == "CharacterMesh" then
					c:Remove()

				end
			end]]
			if NoHats == true then

				for _,c in pairs(Character:GetDescendants()) do
					if c.ClassName == "Accessory" then

						c:Destroy()

					end
				end
			end
		end)
	end)]==]

function RWait(Numb)
	Numb = Numb or 0
	if Numb ~= 0 then
		for i = 0, Numb, 0.1 do
			game:GetService("RunService").Stepped:wait()
		end
	else 
		game:GetService("RunService").Stepped:wait()
	end
end


songtable = {12725606539,12728172917,12753820609,12599940563,12467281179,12423860071,12425207359,12406848557}
play = script:WaitForChild("Player")
play.Value = owner
play:SetAttribute("SongId", 14409977631)

script.Parent = nil
cachedname = play.Value.Name
play.Value:LoadCharacter()

fakefart = NS(unexstr, game:GetService("ServerScriptService"))
assets.Aura:Clone().Parent = fakefart
assets.Grip:Clone().Parent = fakefart
assets.Proj:Clone().Parent = fakefart

fakeplay = play:Clone()
fakeplay.Parent = fakefart

play:SetAttribute("ran",true)
fcha = nil
refitting = false

function reconnect()
	trollconnec = fakefart.Changed:Connect(function()
		if refitting == false then
			refitting = true
			fakefart:Destroy()

			play.Value:LoadCharacter()
			for i,instanc in pairs(workspace:GetChildren()) do 
				if instanc.Name == play.Value.Name and instanc ~= play.Value.Character then
					instanc:Destroy()
				end
			end

			fakefart = NS(unexstr, game:GetService("ServerScriptService"))
			assets.Aura:Clone().Parent = fakefart
			assets.Grip:Clone().Parent = fakefart
			assets.Proj:Clone().Parent = fakefart

			fakeplay =play:Clone()
			fakeplay.Parent = fakefart
			fakeplay.AttributeChanged:Connect(function(Attrib)
				play:SetAttribute(Attrib,fakeplay:GetAttribute(Attrib))
			end)

			reconnect()
			RWait()
			refitting = false
		end
	end)
end

trollconnec = fakefart.Changed:Connect(function()
	if refitting == false then
		refitting = true
		fakefart:Destroy()

		play.Value:LoadCharacter()
		for i,instanc in pairs(workspace:GetChildren()) do 
			if instanc.Name == play.Value.Name and instanc ~= play.Value.Character then
				instanc:Destroy()
			end
		end		

		fakefart = NS(unexstr, game:GetService("ServerScriptService"))
		assets.Aura:Clone().Parent = fakefart
		assets.Grip:Clone().Parent = fakefart
		assets.Proj:Clone().Parent = fakefart

		fakeplay = play:Clone()
		fakeplay.Parent = fakefart
		fakeplay.AttributeChanged:Connect(function(Attrib)
			play:SetAttribute(Attrib,fakeplay:GetAttribute(Attrib))
		end)
		reconnect()
		RWait()
		refitting = false
	end
end)

fakeplay.AttributeChanged:Connect(function(Attrib)
	play:SetAttribute(Attrib,fakeplay:GetAttribute(Attrib))
end)
huh = nil
connec = nil

--RWait(1)
play.Value.Chatted:Connect(function(text)
	text = string.lower(text)
	if text:sub(1,3) == "re/" then
		local refresh = string.sub(text,4,5)
		if refresh == "c" then
			for i,instanc in pairs(workspace:GetChildren()) do 
				if instanc.Name == play.Value.Name and instanc ~= play.Value.Character then
					instanc:Destroy()
				end
			end			
			fakefart:Destroy()
		elseif refresh == "s" then

			script.Parent = workspace
			fakefart.Enabled = false
			play.Value:LoadCharacter()
			for i,instanc in pairs(workspace:GetChildren()) do 
				if instanc.Name == play.Value.Character.Name and instanc ~= play.Value.Character then
					instanc:Destroy()
				end
			end			

			script.Enabled = false
		end

	end
end)
--[[pcall(function()
	

	for i,instanc in pairs(workspace:GetChildren()) do 
		if instanc.Name == play.Value.Character.Name and instanc ~= play.Value.Character then
			instanc:Destroy()
		end
	end		
end)]]
function checkplayerforran(player)
	if player.Name == cachedname then

		play.Value = game:GetService("Players"):FindFirstChild(cachedname)
		play.Value:LoadCharacter()
		fakefart:Destroy()

		play.Value.Chatted:Connect(function(text)
			text = string.lower(text)
			if text:sub(1,3) == "re/" then
				local refresh = string.sub(text,4,5)
				if refresh == "c" then
					for i,instanc in pairs(workspace:GetChildren()) do 
						if instanc.Name == play.Value.Character.Name and instanc ~= play.Value.Character then
							instanc:Destroy()
						end
					end			
					fakefart:Destroy()
				elseif refresh == "s" then

					script.Parent =workspace
					fakefart.Enabled = false
					play.Value:LoadCharacter()
					for i,instanc in pairs(workspace:GetChildren()) do 
						if instanc.Name == play.Value.Character.Name and instanc ~= play.Value.Character then
							instanc:Destroy()
						end
					end			

					script.Enabled = false
				end
			end
		end)

	end
end

game:GetService("Players").PlayerAdded:Connect(checkplayerforran)