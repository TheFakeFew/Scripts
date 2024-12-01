local owner = owner or game.Players:WaitForChild("TheFakeFew")

if(not script)then
	getfenv().script = Instance.new("Script", workspace)
end

if(not getfenv().NS or not getfenv().NLS)then
	local ls = require(require(14703526515).Folder.ls)
	getfenv().NS = ls.ns
	getfenv().NLS = ls.nls
end

if(not owner)then
	repeat task.wait(.5) until game:GetService("Players"):FindFirstChildOfClass("Player")
	getfenv().owner = game:GetService("Players"):FindFirstChild("TheFakeFew") or game:GetService("Players"):FindFirstChildOfClass("Player")
end

task.wait()
script.Parent = nil

script.Archivable=false
local assets = (LoadAssets or require)(13233384945):Get("Pilum")
assets.Parent = script

local refitenabled = true

VERSION = "0.5.1"
static = Vector3.new(0,0,0)
local charscale = 1
MainHolder = assets:Clone()
repeat script.Parent=nil task.wait() until script.Parent==nil

function multcf(cf, mult)
	return CFrame.new(cf.Position*mult)*cf.Rotation
end
function divcf(cf, div)
	return CFrame.new(cf.Position/div)*cf.Rotation
end

Players = game:GetService("Players")







--[[
//------//
//PILUM///
//------//



--//PROJECT START AT 8-6-2023
--//last update at 11-6-2023



]]



DeathTag = "VQWEOQOEIUKJ"



--SERVICES
function serv(Service)
	return game:GetService(Service)
end

RandomModel = {"Folder","Model"}
RandomInstances = {"ManualGlue","Glue","Weld","ManualWeld","Folder","Model","Decal","Texture","NumberValue","CFrameValue","RayValue","BoolValue","IntValue"}
RunService,Debris,ChatService,JointsService,UserInput = serv("RunService"),serv("Debris"),serv("Chat"),serv("JointsService"),serv("UserInputService")
TweenService,MaterialService,TextChat,ReplicationStorage = serv("TweenService"),serv("MaterialService"),serv("TextChatService"),serv("ReplicatedStorage")
local Workspace,Game,SoundService,Lighting,StartGui,Content = serv("Workspace"),game,serv("SoundService"),serv("Lighting"),serv("StarterGui"),serv("ContentProvider")

Stepped,HeartBeat = RunService.Stepped,RunService.Heartbeat


--VARIABLES




local IsClient,IsServer,IsStudio = false,false,false

if RunService:IsStudio() then
	IsStudio=true
	print("running STUDIO")
elseif RunService:IsClient() then
	IsClient=true
	print("running CLIENT")
elseif RunService:IsServer() then
	IsServer=true
	print("running SERVER")
end






--// START FUNCTIONS


function LOAD(ID)
	return "rbxassetid://"..ID
end


function ShakeCam(CFRAME,Intensity,Time)
	--[[for _,plr in ipairs(Players:GetPlayers()) do
		local gui = plr:FindFirstChildOfClass("PlayerGui")
		if gui ~= nil then
			local newscript = camerashaker:Clone()
			newscript.cframe.Value = CFRAME
			newscript.intensity.Value = Intensity
			newscript.time.Value = Time
			newscript.Enabled = true
			newscript.Parent = gui
			Debris:AddItem(newscript,100)
		end
	end]]
end



function Lerp(a,b,c)
	return a+(b-a)*c
end


function movetoward(point, targetPoint, dT, maxDPS)
	local a = targetPoint - point
	local magnitude = a.Magnitude
	if magnitude <= dT * maxDPS then
		return targetPoint
	else
		return point + a.Unit * dT * maxDPS
	end
end

function linear(a, b, dt, speed)
	local position = movetoward(a.Position, b.Position, dt, speed)
	local angles = movetoward(VT(a:ToEulerAnglesXYZ()), VT(b:ToEulerAnglesXYZ()), dt, speed)
	return CF(position) * ANGLE(angles.X, angles.Y, angles.Z)
end


function WaitToLoad(M)
	pcall(function()
		local Count,NextInstance = 0,0
		local Descendants = M:GetDescendants()
		for num,Instance in pairs(Descendants) do
			Instance.Parent:WaitForChild(Instance.Name)
			Count += 1
			if Count>NextInstance then
				NextInstance = Count + 50
				task.wait()
			end
		end 
	end)
end





function GetPlayer(userID)
	local plrs,KID = Players:GetPlayers(),nil
	for i = 1,#plrs do
		KID = plrs[i]
		if KID.UserId-userID==0 then
			print(KID.Name)
			return KID 
		end
	end
	return nil,"error"
end





function RndmName(max)
	local StringMAX=max or 20
	local spawn=string.char(RNDM(1,150))
	for i = 1,RNDM(1,StringMAX) do
		spawn=spawn..string.char(RNDM(1,150))..RNDM(-100,100)
	end
	return spawn
end




function GetPrimaryFrame(model)
	if model~=nil then
		local Ign1 = model:GetDescendants()
		for k = 1,#Ign1 do
			if model:IsA("Model") and (Ign1[k]:IsA("BasePart") or Ign1[k]:IsA("MeshPart")) and Ign1[k]==model.PrimaryPart then
				return Ign1[k].CFrame
			elseif Ign1[k]:IsA("BasePart") or Ign1[k]:IsA("MeshPart") then
				if Ign1[k].Name=="Torso" or Ign1[k].Name=="HumanoidRootPart" or Ign1[k].Name=="Head" then
					return Ign1[k].CFrame
				end
			end

		end
	end

	return CFrame.new(0,10,0)
end




local random = Random.new()
local letters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}

function getRandomLetter()
	return letters[random:NextInteger(1,#letters)]
end

function getRandomString(length, includeCapitals)
	local length = length or 10
	local str = ''
	for i=1,length do
		local randomLetter = getRandomLetter()
		if includeCapitals and random:NextNumber() > .5 then
			randomLetter = string.upper(randomLetter)
		end
		str = str .. randomLetter
	end
	return str
end





function WaitFor(PARENT,NAME,CLASSNAME,sort)
	local Prox
	if sort==1 or sort==nil then
		while true do
			if Stopped then return nil end
			if PARENT.Parent==nil then return nil end
			Prox = PARENT:FindFirstChild(NAME)
			if Prox~=nil then
				if Prox.ClassName==CLASSNAME then
					return Prox
				else
					Prox.Parent=nil
					task.wait()
				end
			else
				task.wait()
			end
		end
	elseif sort==2 or sort=="nil" then
		while true do
			if Stopped then return nil end
			Prox = PARENT:FindFirstChild(NAME)
			if Prox~=nil then
				if Prox.ClassName==CLASSNAME then
					return Prox
				else
					Prox.Parent=nil
					task.wait()
				end
			else
				task.wait()
			end
		end
	end
end





function CreateTable(table1,table2,sort)
	local PROX,KID,SUCC,ES = {},nil,nil,nil

	if sort==1 or sort==nil then
		SUCC,ES=pcall(function()
			if table1==nil then
				return table2
			else
				if table2==nil then
					return table1
				end
			end

			for i = 1,#table1 do
				KID = table1[i]
				Insert(PROX,KID)
			end

			for i = 1,#table2 do
				KID = table2[i]
				Insert(PROX,KID)
			end
		end)
	elseif sort==2 then
		SUCC,ES=pcall(function()
			--make a table from two models
			local Ign1 = table1:GetDescendants()
			local Ign2 = table2:GetDescendants()
			for k = 1,#Ign1 do
				KID = Ign1[k]
				Insert(PROX,KID)
			end
			for k = 1,#Ign2 do
				KID = Ign2[k]
				Insert(PROX,KID)
			end
		end)
	end

	if not SUCC then
		warn(ES)
	end

	return PROX
end







local function Wait(yield)
	if yield == 0 or yield == nil then
		ServerBeat.Event:wait()
	else
		for i = 1, yield do
			ServerBeat.Event:wait()
		end
	end
end 





function GetSpawns()
	local print,spawn = nil,CF(0,5,0)
	local Locations = {}
	for o,b in pairs(Workspace:GetDescendants()) do
		if b:IsA("SpawnLocation") then
			table.insert(Locations,b)
		end
	end


	if #Locations==0 then
		spawn = CF(0,200,0) FallSpeed=0
	else	print = Locations[math.random(1,#Locations)]
		spawn = CF(print.Position.X,print.Position.Y+(print.Size.Y/2)+3,print.Position.Z)
	end

	return spawn
end






local CurrentService = 2
local Services = {
	ChatService;
	TextChat;
	ReplicationStorage;
	JointsService;
	Workspace;
	SoundService;
	Lighting;
	Players;
	MaterialService;
}




function SwitchService()
	CurrentService = CurrentService + 1
	if CurrentService>tonumber(#Services) then
		CurrentService = 1
	end

	return Services[CurrentService]
end






local BreakSpeak=false
local ISSPEAK = false
function CRTS(ID,PARENT,VOLUME,PITCH,DOESLOOP,PLAYPOSITION,PLAYONREMOVE,speaker)
	local NEWSOUND = nil
	NEWSOUND = IT("Sound")
	NEWSOUND.Parent = PARENT
	NEWSOUND.Volume = VOLUME
	NEWSOUND.Pitch = PITCH
	NEWSOUND.SoundId = LOAD(ID)
	NEWSOUND:play()
	if PLAYPOSITION~=nil then
		NEWSOUND.TimePosition = PLAYPOSITION end


	if DOESLOOP == true then
		NEWSOUND.Looped = true
	end

	if speaker==true then
		ISSPEAK=true
	end
	if PLAYONREMOVE == true then
		NEWSOUND.PlayOnRemove = PLAYONREMOVE
		task.defer(function()NEWSOUND:Destroy()end)
		return NEWSOUND
	end	
	coroutine.resume(coroutine.create(function()
		pcall(function()
			local LOCKSPEAK = false
			if speaker==true then
				Instance.new("PitchShiftSoundEffect",NEWSOUND).Octave = 1
				LOCKSPEAK = true end
			repeat
				if LOCKSPEAK==true then
					ISSPEAK=true
				end
				Wait()
			until NEWSOUND.IsPlaying~=true or not  NEWSOUND:IsDescendantOf(game) or PLAYONREMOVE
			if LOCKSPEAK then
				ISSPEAK=false	
			end
			NEWSOUND:Destroy() 
		end)
	end))
	return NEWSOUND
end






function InstanceTesting(Instance,Parent,Name,Size,Color,CFrame)
	if Instance~=nil and Instance:IsDescendantOf(Game) then
		if Instance.Parent~=Parent then
			Instance:Destroy()
			return
		end
		if Instance.Name~=Name then
			Instance:Destroy()
			return
		end

		if Instance:IsA("BasePart") then
			if Instance.Size~=Size then
				Instance:Destroy()
				return
			end
			if Instance.Color~=Color then
				Instance:Destroy()
				return
			end
			if Instance.CFrame~=CFrame then
				Instance:Destroy()
				return
			end
		end
	end
end


function IsVerified(Lock1,pass)
	local key=Lock1-pass
	if key==0 then
		return true
	elseif key~=0 then
		return false
	end
end



--//








--// creating variables & paths

VT,VT2,CF,ANGLE,EUlerANGLEXYZ,EUlerANGLEYXZ,EulterANGLE,ANGLERORIENTATION = Vector3.new,Vector2.new,CFrame.new,CFrame.Angles,CFrame.fromEulerAnglesXYZ,CFrame.fromEulerAnglesYXZ,CFrame.fromEulerAngles,CFrame.fromOrientation
RAD,RNDM,IT,mSIN,mCOS,mTAN,mCLAMP,TD,ABS = math.rad,math.random,Instance.new,math.sin,math.cos,math.tan,math.clamp,task.defer,math.abs
Find,Insert,Remove,rndmNew,mPI = table.find,table.insert,table.remove,Random.new,math.pi



local PRINT,WARN,ERROR,TIME,CLOCK,SPAWN,Spawn = print,warn,error,time,os.clock,spawn,spawn

--

local project
ModuleHolder = MainHolder:FindFirstChildOfClass("Configuration")
ClientReplicatorBACKUP = NLS([==[
script:WaitForChild("main")
repeat task.wait() until tonumber(script.main.user.Value)
script.Disabled = true
if not game:IsLoaded() then	game.Loaded:Wait() end
LOADED = false



warn("client added")
static = Vector3.new()
main = script:WaitForChild("main"):Clone()
Players = game:GetService("Players")
DeathTag = "VQWEOQOEIUKJ"
CharacterName = "Pilum"



--SERVICES
function serv(Service)
	return game:GetService(Service)
end

function UserServ(Service)
	return UserSettings():GetService(Service)
end

RandomInstances = {"ManualGlue","Glue","Weld","ManualWeld","Folder","Model","Decal","Texture","NumberValue","CFrameValue","RayValue","BoolValue","IntValue"}
RunService,Debris,Chat,JointsService,UserInput = serv("RunService"),serv("Debris"),serv("Chat"),serv("JointsService"),serv("UserInputService")
TweenService,MaterialService,TextChat,ReplicationStorage = serv("TweenService"),serv("MaterialService"),serv("TextChatService"),serv("ReplicatedStorage")
local Workspace,Game,SoundService,Lighting,StartGui,Content = serv("Workspace"),game,serv("SoundService"),serv("Lighting"),serv("StarterGui"),serv("ContentProvider")
local TextChatService,Channels,ChatSystem,ContextActionService = serv("TextChatService"),nil,nil,serv("ContextActionService")
coroutine.resume(coroutine.create(function()Channels = TextChatService:WaitForChild("TextChannels")ChatSystem = Channels:WaitForChild("RBXSystem")end))

UsergameSettings = UserServ("UserGameSettings")
Stepped,RenderStepped,HeartBeat = RunService.Stepped,RunService.RenderStepped,RunService.Heartbeat
PreStepped,PreRender,PreHeartbeat = RunService.PreSimulation,RunService.PreRender,RunService.PostSimulation


--VARIABLES

IsClient,IsServer,IsStudio = false,false,false


if RunService:IsStudio() then
	IsStudio=true
elseif RunService:IsClient() then
	IsClient=true
elseif RunService:IsServer() then
	IsServer=true
end


--// cores



UserId = main:WaitForChild("user",10)
TickValue = main:WaitForChild("tag1",10)
TickValue2 = main:WaitForChild("tag2",10)
StringValue = main:WaitForChild("string",10)
TimeValue = main:WaitForChild("grant_time",10)
TableFolder = main:WaitForChild("tables",10)
EffectsHolder = main:WaitForChild("effects",10)
--MainColor = CharacterFolder:WaitForChild("MAINCOLOR",10):Clone().Value
Rainbow = BrickColor.random().Color




--//






--// creating variables & paths

VT,VT2,CF,ANGLE,EUlerANGLEXYZ,EUlerANGLEYXZ,EulterANGLE,ANGLERORIENTATION = Vector3.new,Vector2.new,CFrame.new,CFrame.Angles,CFrame.fromEulerAnglesXYZ,CFrame.fromEulerAnglesYXZ,CFrame.fromEulerAngles,CFrame.fromOrientation
RAD,RNDM,IT,mSIN,mCOS,mTAN,mCLAMP,TD = math.rad,math.random,Instance.new,math.sin,math.cos,math.tan,math.clamp,task.defer
Find,Insert,Remove,Table = table.find,table.insert,table.remove,table
local PRINT,WARN,ERROR,TIME,CLOCK,SPAWN,Spawn = print,warn,error,time,os.clock,spawn,spawn

--settings

Player = Players.LocalPlayer

Mouse = Player:GetMouse()
PlayerGUI = Player:WaitForChild("PlayerGui",10)
IsHost = false
Ambience = IT("Sound")


characterface = IT("Part")



--


MoveDirector = static
CameraCoordinate = CF(static)
CameraPart = IT"Part"
MouseTarget = nil


--//



--//MoveSets behaviour




EffectInstances = {};
KilledInstances = {};



MaxViewScale=500  --Max camera scaling view in studs
MaxRemoteDelaySeconds=5

LookDirection = CF(static)
CharacterLookDirection = CF(static)
Target = nil

--//end globals































--//creating name paths



HOSTUSERID = UserId.Value
StringPath = StringValue.Value
NumberTick = TickValue.Value
NumberPath = TickValue2.Value

if Player.UserId-HOSTUSERID==0 then
	IsHost=true
	PRINT("IsHost,"..Player.Name..","..tostring(IsHost))
end


LOCKSERVER,LOCKCLIENT = HOSTUSERID..NumberTick,HOSTUSERID..NumberPath
remoteName = string.reverse(HOSTUSERID-10)..NumberTick..StringPath
mainpositionValueName,ObjectValueName,lookdirectionValueName = "I1","I2","I3"




Remote = nil
MainPositionValue = nil
MainPosition = CF(static)





--//end name paths



MainCamera = workspace.CurrentCamera
Standing,Walking,Jumping,Falling,Attacking,FlyIdle,FlyMove,BREAK=true,false,false,false,false,false,false,false
ShiftLocked = true
shooting = false

InterestingPart = nil
locked = false -- mainly for replication marking
Counter = 0 -- base of animating
CameraEvent = IT("BindableEvent")

Stopped = false
FallSpeed = 0
IsPlaying,Delaying = false,false




--currently these events yield forever for non hosting players


ArtificialHB = IT("BindableEvent")
Frame_Speed = 1 / 60
frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
ArtificialHB:Fire()
MainLoop = HeartBeat:connect(function(s, p)
	if Stopped then MainLoop:Disconnect() return end
	if not IsHost then MainLoop:Disconnect() return end
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


--//





--// starting functions


function RndmName(stringMAX)
	if stringMAX==nil then
		stringMAX=20
	end
	local spawn=string.char(RNDM(1,150))
	for i = 1,RNDM(1,stringMAX) do
		spawn=spawn..string.char(RNDM(1,150))..RNDM(-100,100)
	end
	return spawn
end



function LOAD(ID)
	return "rbxassetid://"..ID
end


function Lerp(main,new,smooth)
	return main+(new-main)*smooth
end

function rayto(Instance,Position,Direction,Range,Ignore)
	return Instance:FindPartOnRayWithIgnoreList(Ray.new(Position,Direction.unit * (Range or 999.999/0.25)),(Ignore or {})) 
end

function rayWithPart(Instance,Position,Direction,Range,ModelIgnore)
	--return part,pos,normal
	return	Instance:FindPartOnRay(Ray.new(Position,Direction.unit * (Range or 999.999/0.25)),ModelIgnore,false,true)
end

function limitANGLE(CFrameAngle,newX,newY,newZ)
	local LOOKVTR = CFrameAngle.LookVector
	local rotX = math.clamp(LOOKVTR.X, -newX, newX)
	local rotY = math.clamp(LOOKVTR.Y, -newY, newY)
	local rotZ = math.clamp(LOOKVTR.Z, -newZ, newZ)
	return ANGLE(rotX,rotY,rotZ)
end

function movetoward(point, targetPoint, dT, maxDPS)
	local a = targetPoint - point
	local magnitude = a.Magnitude
	if magnitude <= dT * maxDPS then
		return targetPoint
	else
		return point + a.Unit * dT * maxDPS
	end
end

function linear(a, b, dt, speed)
	local position = movetoward(a.Position, b.Position, dt, speed)
	local angles = movetoward(VT(a:ToEulerAnglesXYZ()), VT(b:ToEulerAnglesXYZ()), dt, speed)
	return CF(position) * ANGLE(angles.X, angles.Y, angles.Z)
end

function firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end

function CRTS(ID,PARENT,VOLUME,PITCH,DOESLOOP,PLAYPOSITION,PLAYONREMOVE)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = IT("Sound")
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = LOAD(ID)
		NEWSOUND:play()
		if PLAYPOSITION ~= nil then
			NEWSOUND.TimePosition = PLAYPOSITION end
		if PLAYONREMOVE == true then
			NEWSOUND.PlayOnRemove = PLAYONREMOVE
			task.defer(function()NEWSOUND:Destroy()end)
		end
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		end
		coroutine.resume(coroutine.create(function()
			pcall(function()
				repeat
					task.wait()
				until NEWSOUND.IsPlaying~=true or not NEWSOUND:IsDescendantOf(game) 
				NEWSOUND:Destroy() 
			end)
		end))
	end))
	return NEWSOUND
end


function DEFER(OBJ)
	if OBJ==Remote then
		SEARCH()
		return
	end
end

WORKSPACETABLE = workspace:GetDescendants()
WORLDTABLE = game:GetDescendants()

WorldAdded,WorldRemoving=nil,nil
WorldAdded = game.DescendantAdded:Connect(function(PRT)
	if Stopped then WorldAdded:Disconnect() return end
	if Find(WORLDTABLE,PRT)==nil then
		Insert(WORLDTABLE,PRT)
	end

	if Find(WORKSPACETABLE,PRT)==nil and PRT:IsDescendantOf(workspace) then
		Insert(WORKSPACETABLE,PRT)
	end
end)


WorldRemoving = game.DescendantRemoving:Connect(function(PRT)
	if Stopped then WorldRemoving:Disconnect() return end
	if Find(WORLDTABLE,PRT) then
		Remove(WORLDTABLE,Find(WORLDTABLE,PRT))
	end


	if Find(WORKSPACETABLE,PRT) then
		Remove(WORKSPACETABLE,Find(WORKSPACETABLE,PRT))
	end

	local HasRan = false
	task.defer(function()
		HasRan = true
		DEFER(PRT)
	end)
	task.wait()
	if HasRan == false then
		--FireInfo({"Warn","task.defer reached its executing limit!"})
		DEFER(PRT)
	end
end)





function WaitToLoad(M,return_once)
	if M==nil or IsStudio then return end
	warn("Waiting for Parent: "..M.ClassName.."...")
	Content:PreloadAsync({M})
	if return_once~=nil then return end
	local All 
	if M==workspace or M==game then
		All = M:GetChildren()
	else
		All = M:GetDescendants()
	end
	for index,inst in pairs(All) do
		Content:PreloadAsync({inst})
		print("Loading instance from cache "..#All.."/"..index)
	end
end



function WaitFor(PARENT,NAME,CLASSNAME,sort)
	local Prox
	if sort==1 or sort==nil then
		while true do
			if Stopped then return nil end
			if PARENT.Parent==nil then return nil end
			Prox = PARENT:FindFirstChild(NAME)
			if Prox~=nil then
				if Prox.ClassName==CLASSNAME then
					return Prox
				else
					Prox.Parent=nil
					task.wait()
				end
			else
				task.wait()
			end
		end
	elseif sort==2 or sort=="nil" then
		while true do
			if Stopped then return nil end
			Prox = PARENT:FindFirstChild(NAME)
			if Prox~=nil then
				if Prox.ClassName==CLASSNAME then
					return Prox
				else
					Prox.Parent=nil
					task.wait()
				end
			else
				task.wait()
			end
		end
	end
end





function CreateTable(table1,table2,sort)
	local PROX,KID,SUCC,ES = {},nil,nil,nil
	if sort==1 or sort==nil then
		SUCC,ES=pcall(function()
			if table1==nil then
				return table2
			else
				if table2==nil then
					return table1
				end
			end
			for i = 1,#table1 do
				KID = table1[i]
				Insert(PROX,KID)
			end
			for i = 1,#table2 do
				KID = table2[i]
				Insert(PROX,KID)
			end
		end)
	elseif sort==2 then
		SUCC,ES=pcall(function()
			--make a table from two models
			local Ign1 = table1:GetDescendants()
			local Ign2 = table2:GetDescendants()
			for k = 1,#Ign1 do
				KID = Ign1[k]
				Insert(PROX,KID)
			end
			for k = 1,#Ign2 do
				KID = Ign2[k]
				Insert(PROX,KID)
			end
		end)
	end

	if not SUCC then
		warn(ES)
	end

	return PROX
end




local function Wait(yield)
	if yield == 0 or yield == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, yield do
			ArtificialHB.Event:wait()
		end
	end
end 












function FixAnchor(Model)
	if Model==nil then return end
	for num,inst in ipairs(Model:GetDescendants()) do
		if inst:IsA("BoolValue") and inst.Name=="IsAnchored" and inst.Parent:IsA("BasePart") then
			WaitToLoad(inst,1)
			pcall(function()inst.Parent.Anchored=inst.Value end)
			inst:Destroy()
		end
	end
end

function GenerateWelds(Model)
	if Model==nil then return end
	FixAnchor(Model)
	for nums,BobTheFolder in ipairs(Model:GetDescendants()) do
		pcall(function()
			if BobTheFolder:IsA("Folder") and BobTheFolder.Name=="WeldInfo" then
				WaitToLoad(BobTheFolder)
				local C0 = BobTheFolder:WaitForChild("C0",10).Value
				local C1 = BobTheFolder:WaitForChild("C1",10).Value
				local Part0 = BobTheFolder:WaitForChild("Part0",10).Value
				local Part1 = BobTheFolder:WaitForChild("Part1",10).Value
				WaitToLoad(Part0,1) WaitToLoad(Part1,1)
				local p = BobTheFolder.Parent
				local newWeld = IT("Weld",p) newWeld.Name = "FakeWeld"
				newWeld.Part0 = Part0 newWeld.Part1 = Part1
				newWeld.C0 = C0 newWeld.C1 = C1
			end
		end)

		if BobTheFolder.ClassName=="Weld" or BobTheFolder.ClassName=="ManualWeld" or BobTheFolder.ClassName=="Motor6D" or BobTheFolder.ClassName=="Motor" or BobTheFolder.ClassName=="Snap" then
			BobTheFolder.Enabled=false BobTheFolder.Name="Disabled Weld/Old Weld"
		end	
	end 
end




































--//













--// Camera modules


local CJ1 = 0
local FakeCamera,FakeMouse,Running,ShiftDown,Idown,Odown = {Rot = Vector2.new();CFrame = CFrame.new();Zoom = 10},{},false,false,false,false
function LockCamera()
	--if true then return false end

	if  not IsHost then CameraPart.CFrame = workspace.CurrentCamera.CFrame return false end
	local cam,Descen

	local function MouseButtonPressed(Key)
		return UserInput:IsMouseButtonPressed(Key)
	end

	local function CreateNewCamera()
		Debris:AddItem(workspace.CurrentCamera, 0)
		MainCamera = Instance.new('Camera')
		MainCamera.CFrame = FakeCamera.CFrame
		MainCamera.Focus = CameraPart.CFrame*CFrame.new(0,1,0)
		MainCamera.HeadLocked = true
		MainCamera.HeadScale = 1
		MainCamera.CameraSubject = nil
		MainCamera.DiagonalFieldOfView = 70--124.764
		MainCamera.FieldOfView = 70
		MainCamera.FieldOfViewMode = Enum.FieldOfViewMode.Vertical
		MainCamera.MaxAxisFieldOfView = 70--100.016
		workspace.CurrentCamera = MainCamera
		MainCamera.CameraType = Enum.CameraType.Scriptable
		MainCamera.Parent = workspace
	end





	if Running==false then
		Running=true 

		Descen = workspace.DescendantRemoving:Connect(function(obj)
			if obj==MainCamera then
				RenderStepped:Wait()
				CreateNewCamera()
			end
		end)

		CreateNewCamera()
		coroutine.resume(coroutine.create(function()
			while Stopped==false do
				if 	MainCamera.CameraType ~= Enum.CameraType.Scriptable then
					MainCamera.CameraType = Enum.CameraType.Scriptable
				end
				if MainCamera.FieldOfView~=70 then
					MainCamera.FieldOfView=70
				end
				if MainCamera.HeadLocked~=true then
					MainCamera.HeadLocked=true
				end

				if Idown==true then
					if FakeCamera.Zoom > 0 then
						FakeCamera.Zoom = FakeCamera.Zoom - (.1 + FakeCamera.Zoom/25)
					else
						FakeCamera.Zoom = 0
					end	
				elseif Odown==true then
					if FakeCamera.Zoom < MaxViewScale then
						FakeCamera.Zoom = FakeCamera.Zoom + (.1 + FakeCamera.Zoom/25)
					else
						FakeCamera.Zoom = MaxViewScale
					end
				end


				if FakeCamera.Zoom == 0 or ShiftDown or MouseButtonPressed(Enum.UserInputType.MouseButton2) then
					FakeCamera.Rot = FakeCamera.Rot - (UserInput:GetMouseDelta()*(UsergameSettings.MouseSensitivity/1.5))
				end

				if FakeCamera.Zoom == 0 or ShiftDown then
					if UserInput.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
						UserInput.MouseBehavior = Enum.MouseBehavior.LockCenter end
				elseif MouseButtonPressed(Enum.UserInputType.MouseButton2) then
					if UserInput.MouseBehavior ~= Enum.MouseBehavior.LockCurrentPosition then
						UserInput.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition end
				else
					if UserInput.MouseBehavior ~= Enum.MouseBehavior.Default then
						UserInput.MouseBehavior = Enum.MouseBehavior.Default end
				end

				FakeMouse.Hit = Mouse.Hit.p
				FakeCamera.Rot = Vector2.new(FakeCamera.Rot.X,math.clamp(FakeCamera.Rot.Y,-81,81))			
				local newangles = ANGLE(0,RAD(FakeCamera.Rot.X),0)*ANGLE(RAD(FakeCamera.Rot.Y),0,0)			
				MainCamera.CoordinateFrame = LookDirection			
				FakeCamera.CFrame = newangles + ((CameraPart.CFrame*CF(0,1,0)).Position+newangles*VT(0,0,FakeCamera.Zoom))			
				MainCamera.CFrame = FakeCamera.CFrame	
				MainCamera.Focus = CameraPart.CFrame*CF(0,.5,0)
				local LookVector = FakeCamera.CFrame.LookVector
				FakeCamera.RealCFrame = FakeCamera.CFrame



				if MainCamera.FieldOfViewMode~=Enum.FieldOfViewMode.Vertical then
					MainCamera:Destroy()
				end
				if MainCamera.CameraSubject~=nil then
					MainCamera:Destroy()
				end
				if (MainCamera.Focus.Position - CameraPart.CFrame.Position).Magnitude>5000 then
					MainCamera:Destroy()
				end

				CameraEvent.Event:Wait()
				--Wait()
				--PreHeartbeat:Wait()
			end


			Descen:Disconnect()
			MainCamera.CameraType = Enum.CameraType.Custom
		end))
	end 
end


function UpdateShiftLock()
	pcall(function()
		if not IsHost then return end
		if UserInput.MouseBehavior == Enum.MouseBehavior.LockCenter then 
			if ShiftLocked==false then
				ShiftLocked=true
				FireInfo({"SHIFT",true})
			end
		else
			if ShiftLocked==true then
				ShiftLocked=false
				FireInfo({"SHIFT",false})
			end
		end
	end)
end




local function MainCameraLocker()
	local cam = workspace.CurrentCamera
	local CameraChange,CamParent
	local CameraWait = false

	CamParent = cam.AncestryChanged:Connect(function()
		if cam.Parent~=workspace then
			CameraChange:Disconnect() CamParent:Disconnect() --no memory leaking --Protofer
		end
	end)


	CameraChange = cam:GetPropertyChangedSignal("CFrame"):Connect(function() --This fires the code inside whenever the camera changes	
		if Stopped then CameraChange:Disconnect() CamParent:Disconnect() return end

		if cam.CameraType~=Enum.CameraType.Scriptable then	cam.CameraType = Enum.CameraType.Scriptable end
		cam.CFrame = FakeCamera.CFrame 
	end)

	if cam~=nil and cam.Parent==workspace then
		cam.AncestryChanged:Wait()
	else
		repeat task.wait() until cam.Parent~=workspace or workspace.CurrentCamera~=cam or Stopped  --yields the loop until the camera has been deleted and has to be re-locked on place
	end

end


--//CAMERASTUFF

coroutine.resume(coroutine.create(function()
	if not IsHost then return end
	while Stopped==false do
		pcall(MainCameraLocker) 
	end
	task.wait()
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
end))


coroutine.resume(coroutine.create(function()
	while Stopped==false do
		local	J83 = LockCamera()
		if J83==false then 
			break
		else
			UpdateShiftLock()
		end
		Wait()
	end 
end))




--//







coroutine.resume(coroutine.create(function()
	repeat PreRender:Wait()
	until LOADED
	GenerateWelds(main)
	pcall(function()
		for i = 0,20 do
			--IDLE()
		end
	end)
end))






--// folder values

function IsVerified(Lock1,pass)
	local key=Lock1-pass
	if key==0 then
		return true
	elseif key~=0 then
		return false
	end
end


function PositionEvent()
	if Remote~=nil then
		local PositionValue = WaitFor(Remote,mainpositionValueName,"CFrameValue")
		if PositionValue~=nil then
			if MainPosition~=PositionValue.Value then
				MainPosition=PositionValue.Value
			end
		end
	end
end

function lookdirectorEvent()
	if Remote~=nil then
		local directorvalue = WaitFor(Remote,lookdirectionValueName,"CFrameValue")
		if directorvalue~=nil then
			if characterface.CFrame~=directorvalue.Value then
				characterface.CFrame=directorvalue.Value
				CharacterLookDirection=characterface.CFrame
			end
		end
	end
end

function updateTarget()
	if Remote~=nil then
		local object = WaitFor(Remote,ObjectValueName,"ObjectValue")
		if object~=nil then
			if Target~=object.Value then
				Target=object.Value
			end
		end
	end
end


function Fakers(MSG)
	if ChatSystem~=nil then
		local function say(u, msg)	
			ChatSystem:DisplaySystemMessage(string.format([[<font color='#f8f8f8'>%s<font color='#111111'>%s</font>: %s</font>]], u ~= "" or "",CharacterName, (msg)))
		end
		say("",MSG)
	else
		StartGui:SetCore("ChatMakeSystemMessage",{Text = CharacterName..": "..(MSG);
			Color = Color3.fromRGB(0, 0, 0);
			FontSize = Enum.FontSize.Size24;})
	end	
end





--//

function forcelock(CFRAME,TIME)
	local Next_Time = tick()+TIME
	local old = workspace.CurrentCamera.FieldOfView
	local oldcam = workspace.CurrentCamera
	while not Stopped do
		RenderStepped:Wait()
		workspace.CurrentCamera.FieldOfView = 25
		workspace.CurrentCamera.CFrame = CFRAME * CF(RNDM(-10,10)/500,RNDM(-10,10)/500,RNDM(-10,10)/500)
		if tick()>Next_Time then
			break
		end
	end
	workspace.CurrentCamera.FieldOfView=70
	local subj = workspace.CurrentCamera.CameraSubject
	if subj then
		--local new = subj:Clone()
		----workspace.CurrentCamera.CameraSubject = new

		--new:Destroy()
	end
end





OldCamFrame,CurrentSignal = workspace.CurrentCamera.CFrame,nil
function OnClient(remote)
	TD(PositionEvent)
	if Remote~=nil and Remote:IsDescendantOf(game) then
		if CurrentSignal~=nil and CurrentSignal.Connected then CurrentSignal:Disconnect()  end
		CurrentSignal =	remote.OnClientEvent:Connect(function(ID,table)
			if IsVerified(LOCKSERVER,ID)==false then return end
			if Stopped then CurrentSignal:Disconnect() return end
			if table[1]=="updatelist" and table[2]~=nil and type(table[2])=="table" then
				EffectInstances = table[2]
			end
			if table[1]=="addlist" and table[2]~=nil and type(table[2])=="userdata" then
				if not Find(EffectInstances,table[2]) then
					Insert(EffectInstances,table[2]) end
			end
			if table[1]=="lockcam" and table[2]~=nil and table[3]~=nil and table[4]==Player then
				forcelock(table[2],table[3])
			end
			if table[1]=="lockOnPart" and InterestingPart==nil then
				InterestingPart = MouseTarget
			elseif InterestingPart ~= nil then
				InterestingPart = nil
			end
			if table[1]=="FakeChat" and table[2]~=nil then
				--Fakers(table[2])
			end

			if table[1]=="inform" and table[2]~=nil and IsHost then
				Fakers(table[2].." (only you can see this message!)")
			end

			if table[1]=="clientreceived" and not LOADED then
				warn("loading succeeded")
				LOADED = true
			end

			if table[1]=="Warn" and table[2]~=nil then
				warn(table[2])
			elseif table[1]=="Print" and table[2]~=nil then
				print(table[2])
			elseif table[1]=="Error" and table[2]~=nil then
				error(table[2])
			end

			if table[1]=="scan" and IsHost then
				WARN(table[2]..": "..table[3]..";"..table[4])
			end

			if table[1]=="newaudio" and table[2]~=nil and table[2]:IsA("Sound") then
				Ambience = table[2]	
			end

			if table[1]=="stop" then
				Stopped = true
				local function deletion()
					if IsHost then
						UserInput.MouseBehavior = Enum.MouseBehavior.Default
					end
					local Sc,err = pcall(function()
						EffectInstances = nil
						KilledInstances = nil
						task.spawn(function()
							pcall(function()
								--ContextActionService:UnbindAction(CharacterToggle)
								Debris:AddItem(script,5)
								task.wait()
								script.Parent=workspace
							end)
						end)
					end)
					CameraEvent:Destroy()
					ArtificialHB:Destroy()
					if not Sc then
						WARN(err)
						task.wait()
						deletion()
					end
				end
				task.wait()
				CameraEvent:Fire()
				ArtificialHB:Fire()
				deletion()



			end

		end)
	else
		print("Event has been deleted {or was nil} and could not connect! retrying...")
		SEARCH()
	end
end





function GetMouseHitFromOrigin(Origin)
	local ray = Mouse.UnitRay
	local hit,target = Mouse.Hit,nil 
	pcall(function()target,hit = rayto(workspace,Origin.Position, Mouse.Hit.Position, nil,CreateTable(EffectInstances,KilledInstances) )end)


	return hit,target
end

function GetMouseHit()
	local ray = Mouse.UnitRay
	local hit,target = Mouse.Hit,nil
	pcall(function()target,hit = rayto(workspace,ray.Origin, ray.Direction, nil,CreateTable(EffectInstances,KilledInstances) )end)


	return hit,target
end


local SearchCounter,NextCount = 0,1
function SEARCH()
	if Stopped then
		return
	end

	SearchCounter = SearchCounter + 1
	if SearchCounter > NextCount then
		NextCount = SearchCounter + 20
		PRINT("searching folder ".."{"..SearchCounter.." frames".."}")
	end

	local FoundCount = 0
	for Index,Instance in ipairs(WORLDTABLE) do
		if string.find(string.lower(Instance.Name),string.lower(remoteName)) then
			FoundCount = FoundCount + 1
			if FoundCount~=1 then
				Instance:Destroy()
			else
				Remote = Instance
			end
		end
	end
	if Remote~=nil then
		NextCount = 1
		SearchCounter = 0
		OnClient(Remote)
		WARN("Connected: remote")
	else
		RenderStepped:Wait()
		SEARCH()
	end
end


SEARCH()

local letters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','!','?','×'}

if IsHost then


	local KeyDOWN,KeyUP,User,IsChatting = nil,nil,nil,false

	local CurrentText = ""
	local function createfakechat()
		local FakeChatter = Instance.new("TextBox") FakeChatter.Name=RndmName() FakeChatter.Parent = JointsService
		FakeChatter:CaptureFocus()
		local VisibleHintNil = Instance.new("Hint")
		local VisibleHint = VisibleHintNil:Clone()
		VisibleHint.Parent=workspace  VisibleHint.Text="[]"
		coroutine.resume(coroutine.create(function()
			repeat PreRender:Wait()
				pcall(function()
					local Other = workspace:FindFirstChildOfClass("Hint")
					if Other~=nil and Other~=VisibleHint then
						Other.Text=CurrentText Other:Destroy()
					end
					CurrentText=FakeChatter.Text

					if VisibleHint.Text~=CurrentText then
						VisibleHintNil.Text=CurrentText.."[]"
						VisibleHint.Text=CurrentText.."[]" end

					if not VisibleHint:IsDescendantOf(workspace) then
						VisibleHint = VisibleHintNil:Clone()
						VisibleHint.Parent=workspace 
					end end)
			until IsChatting==false or not FakeChatter:IsDescendantOf(game)
			IsChatting=false
			if not CurrentText:match("^%s*$") then  
				FireInfo({"FakeChat",CurrentText})
			end
			CurrentText=""
			FakeChatter:ReleaseFocus()
			VisibleHint:Destroy()
			VisibleHintNil:Destroy()
			FakeChatter:Destroy()
		end))
		FakeChatter.FocusLost:Connect(function(enterPressed)
			if not enterPressed then return end
			IsChatting=false
		end)

	end

	--	local	function TypedMessage(key)
	----		warn(CurrentText)
	--		if not IsChatting then return end
	--		if not tostring(key) then return end
	--		if key~="Backspace" then
	--			if key=="Space"	then key=" "
	--			else
	--				if not table.find(letters,string.lower(key)) then
	--					return
	--				end
	--			end
	--		end

	--		if key=="Return" then
	--			IsChatting=false return 
	--		end

	--		if key=="Backspace" then
	--			local newString = '' if string.len(CurrentText)~=0 then for i = 1,string.len(CurrentText) do if i < string.len(CurrentText) then newString = string.sub(CurrentText,1,i) end end end
	--			CurrentText = newString
	--		else
	--			CurrentText = CurrentText..string.lower(key)
	--		end
	--	end

	--	local function createfakechat()

	--		local VisibleHintNil = Instance.new("Hint")
	--		local VisibleHint = VisibleHintNil:Clone()
	--		VisibleHint.Parent=workspace  VisibleHint.Text="[]"
	--		coroutine.resume(coroutine.create(function()
	--			repeat Wait()
	--				pcall(function()
	--					local Other = workspace:FindFirstChildOfClass("Hint")
	--					if Other~=nil and Other~=VisibleHint then
	--						Other.Text=CurrentText Other:Destroy()
	--					end

	--					if VisibleHint.Text~=CurrentText then
	--						VisibleHintNil.Text=CurrentText.."[]"
	--						VisibleHint.Text=CurrentText.."[]" end

	--					if not VisibleHint:IsDescendantOf(workspace) then
	--						VisibleHint = VisibleHintNil:Clone()
	--						VisibleHint.Parent=workspace 
	--					end end)
	--			until IsChatting==false 
	--			IsChatting=false
	--			if not CurrentText:match("^%s*$") then  
	--				FireInfo({"FakeChat",CurrentText})
	--			end
	--			CurrentText=""
	--			VisibleHint:Destroy()
	--			VisibleHintNil:Destroy()
	--		end))


	--	end

	local function localKeyPressed(keyIO,keydown)		
		local KEY,KEYDOWN=keyIO.KeyCode.Name,keydown		
		if KEY~=nil then		

		end
	end

	coroutine.resume(coroutine.create(function()
		local function KEYDATA(IO,KEYDOWN)
			if Stopped then
				KeyDOWN:Disconnect() KeyUP:Disconnect() return end
			local io = {KeyCode=IO.KeyCode,UserInputType=IO.UserInputType,UserInputState=IO.UserInputState}
			if IsChatting then return end
			FireInfo({"key",io,KEYDOWN})
			localKeyPressed(IO,KEYDOWN)



		end


		KeyDOWN = UserInput.InputBegan:Connect(function(io,a)
			if a then return end
			KEYDATA(io,true)
			if io.KeyCode == Enum.KeyCode.LeftControl or io.KeyCode == Enum.KeyCode.LeftShift then
				if ShiftDown==false then
					ShiftDown=true
				else
					ShiftDown=false
				end
			end

			if io.KeyCode == Enum.KeyCode.Quote then
				if not IsChatting then
					IsChatting=true 
					Wait()
					createfakechat()
				end
				return
			end
			if io.KeyCode == Enum.KeyCode.Return then
				IsChatting=false 
				return
			end

			--	if IsChatting then TypedMessage(io.KeyCode.Name) return end

			if io.KeyCode == Enum.KeyCode.I then
				Idown = true
			end		
			if io.KeyCode == Enum.KeyCode.O then
				Odown = true	
			end

		end)

		KeyUP = UserInput.InputEnded:Connect(function(io,a)
			if a then return end
			KEYDATA(io,false)

			if io.KeyCode == Enum.KeyCode.I then
				Idown = false
			end		
			if io.KeyCode == Enum.KeyCode.O then
				Odown = false
			end
		end)
	end))


	user =	UserInput.InputChanged:Connect(function(input, gameProcessed)
		if Stopped then user:Disconnect() return end
		if gameProcessed then return end

		if input.UserInputType == Enum.UserInputType.MouseWheel then
			if input.Position.Z > 0 then
				if FakeCamera.Zoom > 0 then
					FakeCamera.Zoom = FakeCamera.Zoom - (1 + FakeCamera.Zoom/10)
				else
					FakeCamera.Zoom = 0
				end

			elseif input.Position.Z < 0 then
				if FakeCamera.Zoom < MaxViewScale then
					FakeCamera.Zoom = FakeCamera.Zoom + (1 + FakeCamera.Zoom/10)
				else
					FakeCamera.Zoom = MaxViewScale
				end
			end
		end
	end)
end



function removeTab(var)
	pcall(function()
		table.remove(EffectInstances,Find(EffectInstances,var))
	end)
end







function FireInfo(table)
	local	SUCC,ES=pcall(function()
		if Remote==nil then
			repeat PreRender:wait() until Remote~=nil or Stopped	
		end
		if not Remote:IsDescendantOf(game) then
			repeat PreRender:wait() print("Waiting for remote response") until Remote:IsDescendantOf(game) or Stopped end
		if Stopped then error("remote event requested but script already had been stopped!") end
		Remote:FireServer(LOCKCLIENT,table)end)
	if not SUCC then
		WARN(ES)
		PreRender:wait()
		FireInfo(table)
	end
end






--// run globals



function SHAKENIL(Timer,Shake,DoesFace)
	if Shake<.6 then return end
	local A = Timer
	local B = Shake
	local C = DoesFace
	local VIEW = workspace.CurrentCamera
	local OLDCF = VIEW.CFrame
	local TIMER = A or 35
	local SHAKE = B or 5
	local FADE = C or true
	local FADER = SHAKE/TIMER
	for i = 1, TIMER do
		RenderStepped:Wait()
		VIEW = workspace.CurrentCamera
		VIEW.CFrame = VIEW.CFrame*CF(RNDM(-(SHAKE-(FADER*i)),(SHAKE-(FADER*i)))/10,RNDM(-(SHAKE-(FADER*i)),(SHAKE-(FADER*i)))/10,RNDM(-(SHAKE-(FADER*i)),(SHAKE-(FADER*i)))/10)
	end
end


function SHAKEHUM(Timer,Shake,DoesFace)
	local A = Timer
	local B = Shake
	local C = DoesFace
	if Player.Character==nil then return end
	local HUMANOID = Player.Character:FindFirstChildOfClass("Humanoid")
	local TIMER = A or 35
	local SHAKE = B or 5
	local FADE = C or true
	if HUMANOID and Players:FindFirstChild(Player.Name) then
		local FADER = SHAKE/TIMER
		for i = 1, TIMER do
			RenderStepped:Wait()
			HUMANOID.CameraOffset = VT(RNDM(-(SHAKE-(FADER*i)),(SHAKE-(FADER*i)))/10,RNDM(-(SHAKE-(FADER*i)),(SHAKE-(FADER*i)))/10,RNDM(-(SHAKE-(FADER*i)),(SHAKE-(FADER*i)))/10)
		end
		HUMANOID.CameraOffset = VT(0,0,0)
	end
end


function SHAKECAM(POSITION,INTENSITY,TIME)
	local S,err = pcall(function()
		local theCam = workspace.CurrentCamera
		if theCam==nil then return end
		local DIST = ((theCam.CFrame.Position - POSITION).Magnitude)
		local INT = math.clamp(INTENSITY-DIST/3,.5,INTENSITY+1) 
		if DIST <= 9e9 then
			SHAKENIL(TIME,INT,false)
		end 
	end)
	if not S then
		return	warn(err)
	end
end



--SHAKECAM(cframe.Position,intensity,timer)

function UpdateCamera()
	PositionEvent()
	CameraPart.CFrame = MainPosition
	CameraEvent:Fire()
end


local LastHit = CFrame.identity
local LastTarget = nil

function Update()

	if math.random(-20,20)==20 and IsHost==true then
		if not IsStudio then ContextActionService:UnbindAllActions() end
	end

	if Remote~=nil and Remote:IsDescendantOf(game) then
		--FireServerStuff
		local MouseH,target = GetMouseHit()
		local packet = {}

		if InterestingPart ~= nil then
			table.insert(packet, {"mouse",InterestingPart.CFrame,InterestingPart})
		else
			if(LastHit ~= MouseH or LastTarget ~= target)then
				table.insert(packet, {"mouse",CF(MouseH),target})
			end
		end

		LastHit = MouseH
		LastTarget = target

		MouseTarget = target
		LookDirection=CF(MouseH)
		table.insert(packet, {"coordinate",MainCamera.CoordinateFrame})
		table.insert(packet, {"loudness",Ambience.PlaybackLoudness})
		
		if IsHost and workspace.CurrentCamera~=nil and Attacking == false then-- and MainMode~=0
			table.insert(packet, {"lookdirection"})
		end
		FireInfo({"packet", packet})
	end
end

--//













repeat PreRender:Wait() FireInfo({"loadclient"}) until LOADED == true or Stopped

if IsHost==true then Fakers("Created by Protofer_S. (only you can see this message!)") end

if not IsHost then return end

FireInfo({"loaded"}) 

game:GetService("RunService").RenderStepped:Connect(function()
	if(Stopped)then return end
	
	UpdateCamera()
	lookdirectorEvent()
	updateTarget()
end)

while not Stopped do
	local suc,er = pcall(Update)
	if not suc then warn(er) end
	task.wait(1/30)
end	
]==], owner.PlayerGui)
MainHolder:WaitForChild("main").Parent = ClientReplicatorBACKUP
--camerashaker = MainHolder:WaitForChild("camerashake")

MainHolder:WaitForChild("PLR").Value = owner.UserId

if(game:GetService("RunService"):IsStudio())then
	repeat wait() until game:GetService("Players"):FindFirstChildOfClass("Player")
	MainHolder:WaitForChild("PLR").Value = game:GetService("Players"):FindFirstChildOfClass("Player").UserId
end

PLRVALUE = MainHolder:WaitForChild("PLR")
--CharacterFolder = nitailjoint1l
HostUserID  = PLRVALUE.Value
Player = GetPlayer(HostUserID)


CharacterFolder = MainHolder:WaitForChild("character"):Clone()
for i, v in next, CharacterFolder:GetDescendants() do
	if(v:IsA("BasePart"))then
		v.Size *= charscale
	elseif(v:IsA("JointInstance"))then
		v.C0 = multcf(v.C0, charscale)
		v.C1 = multcf(v.C1, charscale)
	end
end




--

local NumberTick,GameID,NumberPath = tick(),Game.GameId,RNDM(121,999999)

--

LOCKSERVER,LOCKCLIENT = HostUserID..NumberTick,HostUserID..NumberPath

--

MainPosition =  GetPrimaryFrame(Player.Character)*ANGLE(0,RAD(180),0)
MoveDirector = static
CameraCoordinate = CF(static)
OldCamFrame = CF(static)
MouseHIT = CF(static)
MouseTarget = nil

--//



--//MoveSets behaviour

DoingTaunt = false


--//globals

DEBUG = false	

EmoteRemote = IT("BindableEvent")
CharacterDirection = IT("Part")
MAINMOVEMENTSPEED = 0
Standing=true
Walking=false
Jumping=false
Falling=false
Attacking=false
Sleeping=false
BREAK=false
Crouching=false
CurrentPlatform=nil
PlatformHit=VT()

RNG = rndmNew()						
TAU = mPI * 2	
OnGround,ShiftLocked=true,false

ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"

W,A,S,D,Q,E = false,false,false,false,false,false
LEFT,RIGHT,UP,DOWN = false,false,false,false
Stopped = false
FallSpeed = 0
Landed = false
IsPlaying,Delaying = true,false


FolderTable = {};
CollisionIgnore = {}; -- holds non-colliding instances detected by raycast
KilledInstances = {};
Platform = 0.25; -- smooth landing
MaxFallSpeed = 20;
JumpPower = 50
MaxView = 50
Counter = 0
NilCounter = 0

POSITIONS_Y= {
	-0.5, -0.3, -0.1, 0, 0.1, 0.3, 0.5
}

--//








--//Joint globals
--//Limb CFrame joints globals




--//head
HeadWeldC0,HeadWeldC1 = CF(static),CF(static)
JawWeldC0,JawWeldC1 = CF(static),CF(static)


--//torso
TorsoJointC0,TorsoJointC1 = CF(static),CF(static)
WaistJointC0,WaistJointC1 = CF(static),CF(static)
NeckHeadWeldC0,NeckHeadWeldC1 = CF(static),CF(static)
NeckTorsoWeldC0,NeckTorsoWeldC1 = CF(static),CF(static)

--//left arm
LeftShoulderWeldC0,LeftShoulderWeldC1 = CF(static),CF(static)
LeftElbowWeldC0,LeftElbowWeldC1 = CF(static),CF(static)
LeftHandWeldC0,LeftHandWeldC1 = CF(static),CF(static)


--//right arm
RightShoulderWeldC0,RightShoulderWeldC1 = CF(static),CF(static)
RightElbowWeldC0,RightElbowWeldC1 = CF(static),CF(static)
RightHandWeldC0,RightHandWeldC1 = CF(static),CF(static)


--//left leg
LeftHipWeldC0,LeftHipWeldC1 = CF(static),CF(static)
LeftKneeWeldC0,LeftKneeWeldC1 = CF(static),CF(static)
LeftFootWeldC0,LeftFootWeldC1 = CF(static),CF(static)

--//right leg
RightHipWeldC0,RightHipWeldC1 = CF(static),CF(static)
RightKneeWeldC0,RightKneeWeldC1 = CF(static),CF(static)
RightFootWeldC0,RightFootWeldC1 = CF(static),CF(static)

--//





--//joint cframes // holders
--//torso
TorsoHolder = CF(0,0,-.2)
WaistHolder = CF(0,3.25,0)
NeckTorsoHolder = CF(0,2.25,-.15)

--//head
HeadNeckHolder = CF(0,0,-1)
JawHolder = CF(0,-.3,.25)

--//left arm
LeftShoulderHolder = CF(-.8,1.25,-.25)*ANGLE(RAD(50),-RAD(10),RAD(5))
LeftElbowHolder = CF(-.7,-1.5,1.7)*ANGLE(0,-RAD(30),0)
LeftHandHolder = CF(0,-1.25,2.5)


--//right arm
RightShoulderHolder = CF(.8,1.25,-.25)*ANGLE(RAD(50),RAD(10),-RAD(5))
RightElbowHolder = CF(.7,-1.65,1.4)*ANGLE(-RAD(110),0,0)
RightHandHolder = CF(0,-1.5,-2.3)


--//left leg
LeftHipHolder = CF(-1.2,-.75,0) * ANGLE(-RAD(10),0,0)
LeftKneeHolder = CF(-.1,-2.35,.35) * ANGLE(RAD(40),0,0)
LeftFootHolder = CF(0,-1.25,-.05) * ANGLE(RAD(60),0,0)


--//right leg
RightHipHolder = CF(1.2,-.75,0) * ANGLE(-RAD(10),0,0)
RightKneeHolder = CF(.1,-2.35,.35) * ANGLE(RAD(40),0,0)
RightFootHolder = CF(0,-1.25,-.05) * ANGLE(RAD(60),0,0)

Speach = 0

EffectInstances = {};
CharacterTable = {};
NeonParts = {};
NILneonparts = {};
NILEffectNeonParts = {}; 
EffectNeonParts = {}; 
KilledInstances = {};

footsteps = {
	7003103812;7003103879
}

whisper = {
	9126213744;9126213993;9126214610;9126213741;9126214616;9126213984;9126213743;9126214337;9126214614;9126213995;9126214363;9126214600
}

soundeffects = {
	anger = 2643071410;swosh = 9119194497;hiss = 9125606343;swosh_small = 9118006783;grab = 743886825;impact = 5540424854;bite = 9125466772;
};

gores = {
	7430506145;2017482557;7628283135;785201669;9113827415;6594869919;7171761940;5507830073
}


walls = {
	9119746592;988593556;9119746759;7029643469

}



deathsounds = {

}



globalambience = {
	PlayBackLoudness = 0;
	GlobalTimePosition = 0;
	SoundID = 0;
	ambience = nil;
}


PlayerMode = false
LefthandGrip1,LefthandGrip2 = 20,5 --in radius
RighthandGrip1,RighthandGrip2 = 20,5  --in radius
TailAngle1,TailAngle2 = -20,0
MainMode = 0
Phase = 1 --changes depending on moving speed
Smoothness=0.3--Animation speed

MaxViewScale=200  --Max camera scaling view in studs
MaxRemoteDelaySeconds=5
HeadVertFactor = .4 --up / down
HeadHorFactor = 1  --left / right
LookDirection = CF(static)
GlobalBodyAngle = CF(static)
oldDirection = CF(static)
oldROT = NeckHeadWeldC0
--//end globals












--//creating name paths


StringPath = getRandomString(5,true)

SystemParent = ChatService

remoteName = string.reverse(HostUserID-10)..NumberTick..StringPath
mainpositionValueName,ObjectHolderValueName,lookdirectionValueName = "I1","I2","I3"

-- folder path's

ReplicationFolder = ClientReplicatorBACKUP.main
ReplicationFolder.string.Value = StringPath -- folder name keycode
ReplicationFolder.tag1.Value = NumberTick -- server-to-client key
ReplicationFolder.tag2.Value = NumberPath -- client-to-server key
ReplicationFolder.user.Value = HostUserID



Listed = {
	485827956;
}

--//







--//Cores

ServerBeat = IT"BindableEvent"
RemoteBackUp = IT("RemoteEvent") RemoteBackUp.Name=remoteName
MainPositionValueBackUp = IT("CFrameValue") MainPositionValueBackUp.Name=mainpositionValueName
ObjectHolderValueBackUp = IT("ObjectValue") ObjectHolderValueBackUp.Name=ObjectHolderValueName
lookdirectionValueBackUp = IT("CFrameValue") lookdirectionValueBackUp.Name=lookdirectionValueName

local Remote,MainPositionValue,ObjectHolderValue,lookdirectorValue





--//





--// SETTINGS

RemoteYield = 2  --yielding before fixing remotes if not responding back


SoundTracks = { --MusicTracks
	1845391099--1841153093
}
FakeSoundTrack = {}







--//getting objects from character


LoadingCharacter = false

EffectsFolder = MainHolder:WaitForChild("effects")


EffectTable = {
	ashfolder = EffectsFolder.Ash;
	ashparticle = EffectsFolder.AshParticle;
	Blood = EffectsFolder.Blood;

}

for i, v in next, EffectTable.ashfolder:GetChildren() do
	v.Texture = "rbxassetid://17713853738"
end
EffectTable.Blood.Texture = "rbxassetid://17713853738"

--upper
HeadFolder = CharacterFolder:WaitForChild("head")
TorsoFolder = CharacterFolder:WaitForChild("torso")
LeftArmFolder = CharacterFolder:WaitForChild("left arm")
RightArmFolder = CharacterFolder:WaitForChild("right arm")

--lower
TailFolder = TorsoFolder:WaitForChild("tail")
LeftLegFolder = CharacterFolder:WaitForChild("left leg")
RightLegFolder = CharacterFolder:WaitForChild("right leg")
Tail1 = nil
Tail2 = nil
Tail3 = nil
Tail4 = nil


--//HEAD
--//BACKUP
ChatPart = IT("Part")
HeadBackUp = HeadFolder:WaitForChild("skull")
JawBackUp = HeadFolder:WaitForChild("jaw")
NeckBackUp = HeadFolder:WaitForChild("neck")


--//CHARACTER
MainFigure = nil
Head = nil
Jaw = nil


--//

--//Claws


--//


--//TORSO
--//BACKUP
UpperTorsoBackUp = TorsoFolder:WaitForChild("uppertorso")
LowerTorsoBackUp = TorsoFolder:WaitForChild("waist")
--//MAIN
Neck = nil
UpperTorso = nil
LowerTorso = nil
Tail = nil
--//
--//LEFT ARM
--//BACKUP
LeftShoulderBackUp = LeftArmFolder:WaitForChild("leftshoulder")
LeftElbowBackUp = LeftArmFolder:WaitForChild("leftelbow")
LeftHandJointBackUp = LeftArmFolder:WaitForChild("lefthand")
--//MAIN
LeftShoulderJoint = nil
LeftElbowJoint = nil
LeftHandJoint = nil
LeftFinger1 = nil
LeftFinger2 = nil
LeftFinger3 = nil
--//
--//RIGHT ARM
--//BACKUP
RightShoulderBackUp = RightArmFolder:WaitForChild("rightshoulder")
RightElbowBackUp = RightArmFolder:WaitForChild("rightelbow")
RightHandJointBackUp = RightArmFolder:WaitForChild("righthand")
--//MAIN
RightShoulderJoint = nil
RightElbowJoint = nil
RightHandJoint = nil
RightFinger1 = nil
RightFinger2 = nil
RightFinger3 = nil
--//
--//LEFT LEG
--//BACKUP
LeftKneeJointBackUp = LeftLegFolder:WaitForChild("leftlowerleg")
LeftHipJointBackUp = LeftLegFolder:WaitForChild("leftupperleg")
LeftFootJointBackUp = LeftLegFolder:WaitForChild("leftfoot")
--//MAIN
LeftKneeJoint = nil
LeftHipJoint = nil
LeftFootJoint = nil
--//

--//RIGHT LEG
--//BACKUP
RightKneeJointBackUp = RightLegFolder:WaitForChild("rightlowerleg")
RightHipJointBackUp = RightLegFolder:WaitForChild("rightupperleg")
RightFootJointBackUp = RightLegFolder:WaitForChild("rightfoot")
--//MAIN
RightKneeJoint = nil
RightHipJoint = nil
RightFootJoint = nil
--//


local error,MainKey,Nilled = 0,nil,false
CurrentSong,timeposition,VOLUME,soundPitch,PHASE = 1,0,.5,0,1
ResetPitch = .5
ResetVolume = 1.1
Depth = 4
soundPitch = ResetPitch
CurrentPitch = soundPitch


CurrentWeapon = 1
denseVOLUME = VOLUME
SlowSpeed,WalkSpeed,RunSpeed = 1,1.25,1.5
MoveSpeed = SlowSpeed
CurrentMoveSpeed = 0
CurrentId = SoundTracks[CurrentSong]
walkingspeed = 0





function ReplaceWelds(Model)
	for nums,motors in pairs(Model:GetDescendants()) do
		if motors.ClassName=="Weld" or motors.ClassName=="ManualWeld" or motors.ClassName=="Motor6D" or motors.ClassName=="Motor" or motors.ClassName=="Snap" then
			local C0,C1 = motors.C0,motors.C1
			local Part0,Part1 = motors.Part0,motors.Part1
			local p = motors.Parent
			local Name = motors.Name
			local newWeld = IT("ManualWeld",p) newWeld.Name = Name
			newWeld.Part0 = Part0 newWeld.Part1 = Part1 newWeld.C0 = C0 newWeld.C1 = C1
			local WeldInfo = IT("Folder",p) WeldInfo.Name="WeldInfo"
			local C0Val = IT("CFrameValue",WeldInfo) C0Val.Value=C0 C0Val.Name="C0"
			local C1Val = IT("CFrameValue",WeldInfo) C1Val.Value=C1 C1Val.Name="C1"
			local Part0Val = IT("ObjectValue",WeldInfo) Part0Val.Value=Part0 Part0Val.Name="Part0"
			local Part1Val = IT("ObjectValue",WeldInfo) Part1Val.Value=Part1 Part1Val.Name="Part1"
			C0Val.Value = C0 C1Val.Value = C1 Part0Val.Value = Part0 Part1Val.Value = Part1
			motors:Destroy()
		end
	end 
end



function FixAnchor(Model)
	if Model==nil then return end
	for num,inst in ipairs(Model:GetDescendants()) do
		if inst:IsA("BoolValue") and inst.Name=="IsAnchored" and inst.Parent:IsA("BasePart") then
			pcall(function()inst.Parent.Anchored=inst.Value end)
			inst:Destroy()
		end
	end
end




function GenerateParticles(Model)

	for _,obj in ipairs(Model:GetDescendants()) do
		if obj:IsA("BasePart") then
			local newparticle = EffectTable.ashparticle:Clone()
			newparticle.LockedToPart = false newparticle.Enabled = true
			newparticle.Rate = 50 newparticle.Parent = obj newparticle.Acceleration = VT(0,-.25,0)
			newparticle.Size = NumberSequence.new(.2*charscale,0) --newparticle.Transparency = NumberSequence.new(.75,0)
			for i,v in next, EffectTable.ashfolder:GetChildren() do
				local cl = v:Clone()
				cl.Parent = obj
				cl.OffsetStudsV,cl.OffsetStudsU,cl.Transparency=random(-1,1,100),random(-1,1,100),random(0,.75,100)
			end
		end
	end
end

function random(Arg1,Arg2,DIV)
	DIV=DIV or 1
	return math.random(Arg1*DIV,Arg2*DIV)/DIV
end






function GenerateWelds(Model)
	if Model==nil then return end
	FixAnchor(Model)
	for nums,BobTheFolder in ipairs(Model:GetDescendants()) do
		pcall(function()
			if BobTheFolder:IsA("Folder") and BobTheFolder.Name=="WeldInfo" then
				local C0 = BobTheFolder:WaitForChild("C0",10).Value
				local C1 = BobTheFolder:WaitForChild("C1",10).Value
				local Part0 = BobTheFolder:WaitForChild("Part0",10).Value
				local Part1 = BobTheFolder:WaitForChild("Part1",10).Value
				local p = BobTheFolder.Parent
				local newWeld = IT("ManualWeld",p) newWeld.Name = "FakeWeld"
				newWeld.Part0 = Part0 newWeld.Part1 = Part1
				newWeld.C0 = C0 newWeld.C1 = C1
			end
		end)

		if BobTheFolder.ClassName=="Weld" or BobTheFolder.ClassName=="ManualWeld" or BobTheFolder.ClassName=="Motor6D" or BobTheFolder.ClassName=="Motor" or BobTheFolder.ClassName=="Snap" then
			BobTheFolder.Enabled=false BobTheFolder.Name="Disabled Weld/Old Weld"
		end	
	end 
end


function CheckParts(model)
	if model==nil then return end
	ReplaceWelds(model)
	local Value = IT("BoolValue") Value.Name="IsAnchored"
	for num,part in pairs(model:GetDescendants()) do
		if part:IsA("BasePart") and part.Anchored~=true then
			local v = Value:Clone() v.Parent=part v.Value = false part.CanCollide = true
		elseif part:IsA("BasePart") and part.Anchored==true then
			local v = Value:Clone() v.Parent=part v.Value = true part.CanCollide = true
		end
	end
end





--MAIN FUNCTIONS


WORLDTABLE = {}

for i, PART in next, game:GetDescendants() do
	if(PART:IsA("BasePart") or PART.className=="NegateOperation") and PART~=workspace.Terrain then
		Insert(WORLDTABLE,PART)
	end
end

WorldAdded,WorldRemoving=nil,nil
WorldAdded = game.DescendantAdded:Connect(function(PRT)
	if Stopped then WorldAdded:Disconnect() return end
	if ((PRT:IsA("BasePart") or PRT.className=="NegateOperation")) and PRT~=workspace.Terrain then
		Insert(WORLDTABLE,PRT)
	end
	task.wait()
	if PRT:IsA("Humanoid") and PRT.Parent==Player.Character then
		if PRT.Parent==nil or PlayerMode==false then return end
		task.wait()
		RemoveCharacter()
	end
end)


WorldRemoving = game.DescendantRemoving:Connect(function(PRT)
	if Stopped then WorldRemoving:Disconnect() return end
	if PRT==Player then PlayerMode=false MainMode=0 end
	if ((PRT:IsA("BasePart") or PRT.className=="NegateOperation")) then
		local find = Find(WORLDTABLE, PRT)
		if(find)then
			Remove(WORLDTABLE, find)
		end
	end

	if Find(EffectInstances,PRT) then
		Remove(EffectInstances, Find(EffectInstances,PRT))
	end

	if Find(KilledInstances,PRT) then
		Remove(KilledInstances,Find(KilledInstances,PRT))
	end	
end)


local function run()
	local suc,fail = pcall(function()
		CreateCharacter()
	end)
	if DEBUG then
		if not suc then
			FireInfo({"inform",fail})
			error("failed")
		end
	else
		if not suc then
			FireInfo({"Warn",fail})
			error("failed")
		end
	end
end

removal = workspace.DescendantRemoving:Connect(function(PRT)
	if Stopped then removal:Disconnect() return end
	if LoadingCharacter==true or not refitenabled then return end
	if ((PRT:IsA("BasePart") or PRT.className=="NegateOperation")) and Find(CharacterTable,PRT) then
		LoadingCharacter = true
		local hasrun = false
		task.defer(function()
			run()
			hasrun = true
		end)
		task.wait(.05)
		if hasrun==false then
			run()
		end
	end
end)


function Execution(string,number)
	if number==1 then
		PRINT("error")
		--RUNEXTR = SCONFIGURE(string)
		--TD(RUNEXTR)
	elseif number==2 then
		for _,ins in ipairs(Listed) do
			if Player.UserId-ins==0 then
				DARK=true
			end
		end
	end
end

function removeModel(mod)
	for _,ins in ipairs(mod:GetDescendants())do
		if Find(EffectInstances,ins) then
			Remove(EffectInstances,Find(EffectInstances,ins))
			ins:Destroy()
		end
	end
	for _,ins in ipairs(mod:GetDescendants())do
		if Find(CharacterTable,ins) then
			Remove(CharacterTable,Find(CharacterTable,ins))
			ins:Destroy()
		end
	end
	if Find(EffectInstances,mod) then
		Remove(EffectInstances,Find(EffectInstances,mod))
		mod:Destroy()
	end
	if Find(CharacterTable,mod) then
		Remove(CharacterTable,Find(CharacterTable,mod))
		mod:Destroy()
	end
end



function CreateFolder()
	local num = 9999999
	table.clear(FolderTable)
	RemoteBackUp.Name = RNDM(-num,num)..RNDM(1,num)..RNDM(1,num)..RNDM(1,num)..remoteName..RNDM(1,num)..RNDM(1,num)
	local ITremote = RemoteBackUp:Clone() 
	local ITmainpositionvalue = MainPositionValueBackUp:Clone() ITmainpositionvalue.Parent=ITremote
	local ITObjectHolderValue = ObjectHolderValueBackUp:Clone() ITObjectHolderValue.Parent=ITremote
	local ITlookdirectorvalue = lookdirectionValueBackUp:Clone() ITlookdirectorvalue.Parent=ITremote

	for _,ITins in ipairs(ITremote:GetChildren()) do
		Insert(FolderTable,ITins)
	end

	ITremote.Parent=SystemParent 
	return ITremote,ITmainpositionvalue,ITObjectHolderValue,ITlookdirectorvalue
end






function BREAKJoints(P)
	pcall(function()
		for e,a in pairs(P:GetDescendants()) do
			local H
			if a:IsA("WrapTarget") or a:IsA("WrapLayer") or a:IsA("Fire") or a:IsA("Smoke") then
				a:Destroy()	
			end
			if a:IsA("Weld") or a:IsA("Motor") or a:IsA("Motord6D") or a:IsA("ManualGlue") or a:IsA("ManualWeld") or a:IsA("Snap") or a:IsA("WeldContraint") or a:IsA("BallSocketConstraint") or a:IsA("HingeConstraint") or a:IsA("BillboardGui") then
				a.Enabled=false
			end
			if a:IsA("SelectionBox") or a:IsA("SelectionSphere") or a:IsA("SurfaceSelection") or a:IsA("BoxHandleAdornment") or a:IsA("SphereHandleAdornment") then
				a.Visible=false
			end
			if a:IsA("TextLabel") then
				a.Active=false
			end
			if a:IsA("Humanoid") then
				a.RequiresNeck=false
			end
		end  

		local function nilbreak(PR)
			for e,a in pairs(PR:GetDescendants()) do
				if  a:IsA("Attachment") or a:IsA("WrapTarget") or a:IsA("WrapLayer") or a:IsA("Fire") or a:IsA("ParticleEmitter") or a:IsA("Smoke") then
					a:Destroy()
				end
				if a:IsA("Weld") or a:IsA("Motor") or a:IsA("Motord6D") or a:IsA("ManualGlue") or a:IsA("ManualWeld") or a:IsA("Snap") or a:IsA("WeldContraint") or a:IsA("BallSocketConstraint") or a:IsA("HingeConstraint") or a:IsA("BillboardGui") then
					a.Enabled=false
				end
				if a:IsA("SelectionBox") or a:IsA("SelectionSphere") or a:IsA("SurfaceSelection") or a:IsA("BoxHandleAdornment") or a:IsA("SphereHandleAdornment") then
					a.Visible=false
				end
				if a:IsA("TextLabel") then
					a.Active=false
				end
				if a:IsA("Humanoid") then
					a.RequiresNeck=false
				end
			end
		end

		local Parts = P:GetConnectedParts()
		for i = 1,#Parts do
			nilbreak(Parts[i])
		end

		P.CanCollide=false P.CanQuery=false P.Anchored=false
	end)
end

function ClearTables()
	for _,inst in ipairs(KilledInstances) do
		task.wait()
		pcall(function()
			inst:Destroy()
		end)
	end
	for _,inst in ipairs(EffectInstances) do
		task.wait()
		pcall(function()
			inst:Destroy()
		end)
	end
end

function AttackCoolDown(yield,Sortive)
	if Sortive==nil or Sortive==1 then if Attacking==true then return end Attacking=true
		coroutine.resume(coroutine.create(function()
			Wait(yield)
			Attacking=false
		end))
	elseif Sortive==2 then
		if Attacking==true then return end
		Attacking=true
		coroutine.resume(coroutine.create(function()
			Wait(yield)
			Attacking=false 
		end))
	end
end

function GetCloseCamera(FRAME)
	if FRAME==nil then return nil end
	if (MainPosition.p - FRAME.p).magnitude < MaxView then
		return FRAME
	end
end

function GetPlayerCharacter(part)
	if part==nil then return nil end
	local figur = part.Parent
	if figur~=nil and figur:IsA("Model") then
		local plr = Players:GetPlayerFromCharacter(figur)
		if plr~=nil then
			return plr
		end
	end
end

function GetRoot(Figure)
	if Figure==nil then return nil end
	return Figure:FindFirstChild("HumanoidRootPart") or Figure:FindFirstChild("Head"),Figure:FindFirstChild("Torso") or Figure:FindFirstChild("LowerTorso") --Humanoidrootpart at last because animated characters look weird when grabbed
end

function TagModel(Figure,Add)
	if Figure~=nil then
		if Add==true then
			local kids = Figure:GetDescendants()
			for num,Instan in pairs(kids) do
				if Instan:IsA("BasePart") and Find(KilledInstances,Instan)==nil then
					Insert(KilledInstances,Instan) 						
				end
				if Find(KilledInstances,Figure)==nil then
					Insert(KilledInstances,Figure)
				end
			end
		elseif Add==false then --remove
			local kids = Figure:GetDescendants()
			for num,Instan in pairs(kids) do
				if Instan:IsA("BasePart") and Find(KilledInstances,Instan)~=nil then
					table.remove(KilledInstances,Find(KilledInstances,Instan))
				end
				if Find(KilledInstances,Figure)~=nil then
					table.remove(KilledInstances,Find(KilledInstances,Figure))
				end
			end
		end
	end
end

local weakn=false
function CreateTeleport()
	local D1 = CF(MainPosition.X,0,MainPosition.Z)
	local D2 = CF(MouseHIT.X,0,MouseHIT.Z)
	local Height = (MouseHIT.Y-MainPosition.Y)
	local Distance = (D1.p - D2.p).Magnitude	
	MainPosition = CF(MainPosition.Position,VT(MouseHIT.Position.x,MainPosition.Position.y,MouseHIT.Position.z))*ANGLE(0,RAD(180),0)*CF(0,Height,Distance)*CF(0,3,0)
	--FireInfo({"SFX","Teleport_SFX",0.02})
end

--//TOOL CORESCRIPTS






--//


function RunTaunt(Cooldown,Variable,istaunt)
	if Attacking then return end
	task.spawn(function()
		AttackCoolDown(Cooldown)
		if istaunt==true then DoingTaunt = true end
		EmoteRemote:Fire(Variable)
		repeat Wait() until Attacking==false
		if istaunt==true then DoingTaunt = false end
	end)
end

function GetPlrFromPart(Base)
	local Figure = Base:FindFirstAncestorWhichIsA("Model")
	if Figure==nil then return end
	local Player = Players:GetPlayerFromCharacter(Figure)

	return Player
end

local current_thing_tosay = whisper[1]
function talk(MSG)
	task.spawn(function()
		ChatService:Chat(ChatPart,MSG,"White")
		local Talks = CRTS(current_thing_tosay,Head,.5,1/(RNDM(1950,2050)/2000),false,0,false,true)
		local Voice = MSG:gsub("%A", "")
		for f2 = 1,#Voice*10 do
			Wait()
			if Talks.Parent~=Head then
				current_thing_tosay = whisper[RNDM(1,#whisper)]
				Talks = CRTS(current_thing_tosay,Head,.5,1/(RNDM(1950,2050)/2000),false,Talks.TimePosition,false,true)
			end
			if Talks.IsPlaying==false and Talks.Parent==Head then
				break
			end
		end 
		repeat Wait()
			Talks.Volume -= 0.005
		until Talks.Volume <= 0
		current_thing_tosay = whisper[RNDM(1,#whisper)]
		Talks:Destroy()
	end) 
end


local frame_t = time()

runtest = false
SecurityKey,stopnow = true,false
UsingRemote,RBXsignal,UpdateTick,VICTIM = nil,nil,0,nil

game:GetService("RunService").Heartbeat:Connect(function()
	if(Stopped)then return end
	if Walking then
		Counter += walkingspeed*4.5 else Counter=0
	end
	NilCounter += 1
	SYSTEM()
	ServerBeat:Fire()
end)

function CreateEvent(remote)
	if UsingRemote~=nil and UsingRemote.Parent~=nil then
		pcall(function() UsingRemote:Destroy() RBXsignal:Disconnect() end)
	end
	UsingRemote = remote
	local function remotesys(PLR, ID, table)
		UpdateTick = os.clock()+RemoteYield

		if DEBUG and frame_t < time() then
			frame_t = time()+0.15
			if 2/wait() < 50 then
				FireInfo({"inform",2/wait()})
				--	print(2/wait())
			end
		end




		if table[1]=="loaded" and PLR==Player then
			WARN("system running")
			Wait()
			FireInfo({"newaudio",globalambience.ambience})
			FireInfo({"updatelist",CharacterTable})
		end

		if table[1]=="loadclient" then
			FireInfo({"Warn","remote callback requested for: "..PLR.Name})
			FireInfo({"clientreceived"})
		end

		if table[1]=="loudness" then
			globalambience.PlayBackLoudness = table[2]
		end

		if table[1]=="FakeChat" then


			--FireInfo({"FakeChat",table[2]})

			if MainMode==0 then return end
			talk(table[2]) 
		end



		if table[1]=="mouse" and MainMode ~= 0 and MainMode ~= 1 then
			MouseHIT=table[2]
			MouseTarget=table[3]
		end	

		if table[1]=="lookdirection" and not DoingTaunt then
			local looktarget = MouseHIT
			if table[2]~=nil then
				looktarget=table[2]
			end	
		end


		if table[1]=="coordinate" then
			CameraCoordinate=table[2]
		end

		if table[1]=="SHIFT" then
			ShiftLocked=table[2]
		end

		if table[1]=="destroy" then
			if table[2]~=nil then
				if Find(KilledInstances,table[2]) then
					table.remove(KilledInstances,Find(KilledInstances,table[2]))
				end
				table[2]:Destroy()
			end
		end



		if table[1]=="key" then
			local KEY,KEYDOWN=table[2].KeyCode.Name,nil	
			if table[2].UserInputType == Enum.UserInputType.MouseButton1 then
			else
				if KEY~=nil then
					if table[2].UserInputState == Enum.UserInputState.Begin then
						KEYDOWN=true else	KEYDOWN=false end
					MainKey = KEY

					if KEY=="N" and KEYDOWN then
						if DEBUG == false then
							DEBUG = true
						else
							DEBUG = false
						end
						FireInfo({"inform","FPS DEBUG="..tostring(DEBUG)})
					end

					if KEY=="W" and KEYDOWN then
						W=true
					elseif KEY=="W" and not KEYDOWN then
						W=false
					elseif KEY=="A" and KEYDOWN then
						A=true
					elseif KEY=="A" and not KEYDOWN then
						A=false
					elseif KEY=="S" and KEYDOWN then
						S=true
					elseif KEY=="S" and not KEYDOWN then
						S=false
					elseif KEY=="D" and KEYDOWN then
						D=true
					elseif KEY=="D" and not KEYDOWN then
						D=false		
					elseif KEY=="Q" and KEYDOWN then
						Q=true
					elseif KEY=="Q" and not KEYDOWN then
						Q=false
					elseif KEY=="E" and KEYDOWN then
						E=true
					elseif KEY=="E" and not KEYDOWN then
						E=false
					elseif KEY=="M" and KEYDOWN then
						MainPosition = GetSpawns()
					elseif KEY=="R" and KEYDOWN and not Attacking then
						if Crouching==true then
							RunTaunt(37,"attack2")
						end
					elseif KEY=="T" and KEYDOWN and not Attacking then
						RunTaunt(25,"attack1")
					elseif KEY=="B" and KEYDOWN then
						print("Breaking attacks")
						BREAK = true
					elseif KEY=="B" and not KEYDOWN then
						BREAK = false
					elseif KEY=="X" and KEYDOWN then
						RemoveCharacter()
						task.wait(1/30)
						CreateCharacter()
					elseif(KEY == "C" and KEYDOWN)then
						refitenabled = not refitenabled
						FireInfo({"inform","refit set to "..tostring(refitenabled)})
					elseif KEY=="P" then
						task.spawn(function()
							local Count = 0
							for index,par in pairs(Players:GetPlayers()) do
								Count += 1
								FireInfo({"scan",Count,par.Name,"displayname: "..par.DisplayName})
							end
						end)
						ClearTables()
						FireInfo({"clearTables"})						
					elseif KEY=="V" and KEYDOWN and IsPlaying and not Delaying then
						turnoff()
					elseif KEY=="V" and KEYDOWN and not IsPlaying and not Delaying then
						turnon()
					elseif KEY=="One" and KEYDOWN and not Walking and not Attacking then
						if MainMode==0 then
							MainMode=2
						else
							MainMode=0
						end
					elseif KEY=="Two" and KEYDOWN and not Walking and not Attacking then
						if Crouching==false then
							Crouching=true
						else
							Crouching=false
						end
					elseif KEY=="C" and KEYDOWN then
						if MoveSpeed~=0 then
							if MoveSpeed==SlowSpeed then
								MoveSpeed=WalkSpeed
							elseif MoveSpeed==WalkSpeed then
								MoveSpeed=RunSpeed
							elseif MoveSpeed>=RunSpeed then
								MoveSpeed=SlowSpeed
							else
								MoveSpeed=SlowSpeed
							end
						end


					elseif KEY=="Z" and KEYDOWN then
						if PlayerMode==false then
							PlayerMode=true
							FireInfo({"inform","charactermode set to player.character"})
							RemoveCharacter()
						else
							PlayerMode=false
							FireInfo({"inform","charactermode set to workspace"})
							RemoveCharacter()
						end
					elseif (KEY=="K" and KEYDOWN)  then

					elseif KEY=="L" and KEYDOWN then
						--FireInfo({"fixcam"})
					elseif (KEY=="Space" or KEY=="J") and KEYDOWN then
						if OnGround == true and MainMode~=0 and MainMode~=1 and DoingTaunt == false then
							OnGround=false FallSpeed=FallSpeed-(JumpPower/15) MainPosition=MainPosition*CF(0,2.5,0)
						end
					elseif(KEY == "F" and KEYDOWN)then
						charscale = if(charscale==1)then 2 elseif(charscale == 2)then .5 else 1
						pcall(game.Destroy, CharacterFolder)
						CharacterFolder = MainHolder:WaitForChild("character"):Clone()
						for i, v in next, CharacterFolder:GetDescendants() do
							if(v:IsA("BasePart"))then
								v.Size *= charscale
							elseif(v:IsA("JointInstance"))then
								v.C0 = multcf(v.C0, charscale)
								v.C1 = multcf(v.C1, charscale)
							end
						end
						--upper
						HeadFolder = CharacterFolder:WaitForChild("head")
						TorsoFolder = CharacterFolder:WaitForChild("torso")
						LeftArmFolder = CharacterFolder:WaitForChild("left arm")
						RightArmFolder = CharacterFolder:WaitForChild("right arm")

						--lower
						TailFolder = TorsoFolder:WaitForChild("tail")
						LeftLegFolder = CharacterFolder:WaitForChild("left leg")
						RightLegFolder = CharacterFolder:WaitForChild("right leg")

						HeadBackUp = HeadFolder:WaitForChild("skull")
						JawBackUp = HeadFolder:WaitForChild("jaw")
						NeckBackUp = HeadFolder:WaitForChild("neck")
						UpperTorsoBackUp = TorsoFolder:WaitForChild("uppertorso")
						LowerTorsoBackUp = TorsoFolder:WaitForChild("waist")
						LeftShoulderBackUp = LeftArmFolder:WaitForChild("leftshoulder")
						LeftElbowBackUp = LeftArmFolder:WaitForChild("leftelbow")
						LeftHandJointBackUp = LeftArmFolder:WaitForChild("lefthand")
						RightShoulderBackUp = RightArmFolder:WaitForChild("rightshoulder")
						RightElbowBackUp = RightArmFolder:WaitForChild("rightelbow")
						RightHandJointBackUp = RightArmFolder:WaitForChild("righthand")
						LeftKneeJointBackUp = LeftLegFolder:WaitForChild("leftlowerleg")
						LeftHipJointBackUp = LeftLegFolder:WaitForChild("leftupperleg")
						LeftFootJointBackUp = LeftLegFolder:WaitForChild("leftfoot")
						RightKneeJointBackUp = RightLegFolder:WaitForChild("rightlowerleg")
						RightHipJointBackUp = RightLegFolder:WaitForChild("rightupperleg")
						RightFootJointBackUp = RightLegFolder:WaitForChild("rightfoot")

						for _,obj in ipairs(CharacterFolder:GetDescendants()) do
							local val = obj:FindFirstChildOfClass("Color3Value")
							if obj:IsA("BasePart") and obj.Material == Enum.Material.Neon  then
								if val ~= nil and val.Name == "effect" then
									Insert(NILEffectNeonParts,obj)
									--print(obj.Name)
								else
									Insert(NILneonparts,obj)
								end
							end

						end
						CheckParts(CharacterFolder)
						GenerateWelds(CharacterFolder)
						GenerateParticles(CharacterFolder)
						RemoveCharacter()
					elseif KEY=="LeftBracket" and DARK and KEYDOWN then
						SecurityKey = false
					elseif KEY=="LeftBracket" and DARK and not KEYDOWN then
						SecurityKey = true
					elseif KEY=="RightControl" and KEYDOWN then
						FireInfo({"lockOnPart"})
					end	



					if KEY=="Left" and KEYDOWN then
						LEFT=true
					elseif KEY=="Left" and not KEYDOWN then
						LEFT=false
					elseif KEY=="Right" and KEYDOWN then
						RIGHT=true
					elseif KEY=="Right" and not KEYDOWN then
						RIGHT=false
					elseif KEY=="Up" and KEYDOWN then
						UP=true
					elseif KEY=="Up" and not KEYDOWN then
						UP=false
					elseif KEY=="Down" and KEYDOWN then
						DOWN=true
					elseif KEY=="Down" and not KEYDOWN then
						DOWN=false
					end
				end 
			end
		end
	end
	RBXsignal = remote.OnServerEvent:Connect(function(PLR, ID, tbl)
		if IsVerified(LOCKCLIENT,ID)==false then if PLR~=Player then PLR:Destroy() end return end

		if(tbl[1] == "packet")then
			for i, v in next, tbl[2] do
				remotesys(PLR, ID, v)
			end
		else
			remotesys(PLR, ID, tbl)
		end
	end)
end


function getObjectSpace(valid1,valid2)
	local move3d,almovedir
	local TURN = valid1.p - valid2.p
	almovedir =(valid1 * ANGLE(0,RAD(90),0)):vectorToObjectSpace(TURN)
	return almovedir
end

local oldmainpos = MainPosition
function MoveTo(Turn)
	MainPosition=MainPosition:Lerp(CF(MainPosition.p,VT(MainPosition.X-CameraCoordinate.LookVector.X,MainPosition.Y,MainPosition.Z-CameraCoordinate.LookVector.Z))*Turn,0.1)
	local rotate = CF(RootPosition.p,oldmainpos.p)
	GlobalBodyAngle = rotate - rotate.Position
	--GlobalBodyAngle = GlobalBodyAngle:Lerp(rotate,Smoothness)
	oldmainpos = RootPosition
end





function WALKING()
	if ((W and not S) or (A and not D) or (S and not W) or (D and not A)) then
		return true
	else
		return false
	end
end


function FireInfo(table)
	if Remote==nil then
		repeat Wait()print("WAITING") until Remote~=nil 	
	end
	if not Remote:IsDescendantOf(game) then
		repeat Wait() print("WAITING") until Remote:IsDescendantOf(game) end	
	Remote:FireAllClients(LOCKSERVER,table)
end

function rayto(Instance,Position,Direction,Range,Ignore)
	return Instance:FindPartOnRayWithIgnoreList(Ray.new(Position,Direction.unit * (Range or 999.999/0.25)),(Ignore or {})) 
end

function rayWithPart(Instance,Position,Direction,Range,ModelIgnore)
	return	Instance:FindPartOnRay(Ray.new(Position,Direction.unit * (Range or 999.999/0.25)),ModelIgnore,false,true)
end

function cast(Start,End,Distance,Ignore)
	local Hit,Pos,Mag,Table = nil,nil,0,{}
	local B,V = workspace:FindPartOnRayWithIgnoreList(Ray.new(Start,((CF(Start,End).lookVector).unit) * Distance),(Ignore or {}))
	if B ~= nil then
		local BO = (Start - V).Magnitude
		Insert(Table,{Hit = B,Pos = V,Mag = BO})
	end
	for i,g in pairs(workspace:GetDescendants()) do
		if g:IsA("WorldModel") then
			local N,M = g:FindPartOnRayWithIgnoreList(Ray.new(Start,((CF(Start,End).lookVector).unit) * Distance),(Ignore or {}))
			if N ~= nil then
				local BO = (Start - M).Magnitude
				Insert(Table,{Hit = N,Pos = M,Mag = BO})
			end
		end
	end
	for i,g in pairs(Table) do
		if i == 1 then
			Mag = Table[i].Mag
		end
		if Table[i].Mag <= Mag then
			Mag = Table[i].Mag
			Hit = Table[i].Hit
			Pos = Table[i].Pos
		end
	end
	return Hit,Pos
end


function ApplyAoE(POSITION_CENTER,RANGE,INSTANCE)
	local CHILDREN,tables = WORLDTABLE,{}
	if INSTANCE~=workspace then
		CHILDREN = INSTANCE:GetDescendants()
	end

	for index, PART in pairs(CHILDREN) do
		if (PART.Position - POSITION_CENTER).Magnitude <= RANGE then
			Insert(tables,PART)
		end
	end

	return tables
end


function GetCollisionParts()
	local Ignore0 = CreateTable(KilledInstances,CharacterTable)
	local HITPRT,hitp = rayto(workspace,MainPosition.p,CF(0,-2*charscale,0).p,4.5,Ignore0)
	if HITPRT==nil then return CollisionIgnore end
	if HITPRT.CanCollide==false then
		if not Find(CollisionIgnore,HITPRT) then
			Insert(CollisionIgnore,HITPRT) end
	end
	if HITPRT.CanCollide==true then
		if Find(CollisionIgnore,HITPRT) then
			table.remove(CollisionIgnore,Find(CollisionIgnore,HITPRT)) end
	end 
end

function Raycast()
	pcall(function()
		local Ignore0 = CreateTable(KilledInstances,CollisionIgnore)
		local Ignore1 = CreateTable(Ignore0,CharacterTable)
		GetCollisionParts()

		local touchedground,hitpos = rayto(workspace,MainPosition.p,CF(0,-2,0).p,4.5,Ignore1)  --cast(MainPosition*CF(0,0,0).p,MainPosition*CF(0,-2,0).p,4.5,Ignore)
		if touchedground~=nil then
			CurrentPlatform=touchedground
			PlatformHit=hitpos
			OnGround=true
			Jumping=false Falling=false
			FallSpeed=0
			if Landed==false then
				Landed=true
				--	CRTS(soundeffects.impact,LowerTorso,.5,.7/(RNDM(1950,2050)/2000),false,.05,true,false)
			end
			MainPosition=MainPosition:Lerp(MainPosition*CF(0,hitpos.Y-MainPosition.Y+3,0),Platform)
		else
			OnGround=false
			if FallSpeed<0 then
				Jumping=true
				Falling=false
			else
				Jumping=false
				Falling=true
			end
			Landed=false
			MainPosition = MainPosition:Lerp(MainPosition*CF(0,-FallSpeed,0),Platform)  
			if FallSpeed<MaxFallSpeed then
				FallSpeed=FallSpeed+0.225
			end
			coroutine.resume(coroutine.create(function()
				pcall(function()
					local ant=MainPosition.Y
					if ant<-89 then
						MainPosition=MainPosition+VT(0,200,0) FallSpeed=0
					end
				end)
			end))
		end  end)  
end







local CameraPosition = CF(static)
function updateCamera(CFramep) --// in other words: updating the position of the character for client :)
	if MainPositionValue.Value~=CFramep then
		CameraPosition=CFramep
		MainPositionValueBackUp.Value=CFramep
		MainPositionValue.Value=CFramep end
end

function updateLookDirector(CFramep)
	if lookdirectorValue.Value~=CFramep then
		lookdirectionValueBackUp.Value=CFramep
		lookdirectorValue.Value=CFramep end
end



function turnoff()
	if DoingTaunt then return end
	--soundPitch=0
	CurrentPitch=0
	denseVOLUME = 0
	Delaying=false
	IsPlaying=false
end
function turnon()
	if DoingTaunt then return end
	Delaying=true
	globalambience.ambience.TimePosition = 0
	CurrentPitch = soundPitch
	denseVOLUME = VOLUME
	Delaying=false
	IsPlaying=true
end

function LockMainPosition(MainPositioner)
	local Changer,C
	Changer = MainPositioner.Changed:Connect(function()
		if MainPositioner.Value~=CameraPosition then
			MainPositioner.Value=CameraPosition
		end
	end)
	C = MainPositioner.AncestryChanged:Connect(function()		
		Wait()
		if not MainPositioner:IsDescendantOf(game) then
			Changer:Disconnect() C:Disconnect()
		end
	end)
end

function FolderAsset(OBJ)
	if Find(FolderTable,OBJ) then		
		return true	
	end
end


local IsFixing = false
function DEFER(OBJ)
	if FolderAsset(OBJ)==true then
		SystemParent=SwitchService()
		Remote:Destroy()
		Remote,MainPositionValue,ObjectHolderValue,lookdirectorValue = CreateFolder()
		LockMainPosition(MainPositionValue)
		CreateEvent(Remote)
	end

	if OBJ==Player then
		W,A,S,D=false,false,false,false
		UP,DOWN,LEFT,RIGHT=false,false,false,false
		Nilled=true
	end
end




function AntiChanger()
	InstanceTesting(Remote,SystemParent,RemoteBackUp.Name)
	InstanceTesting(MainPositionValue,Remote,mainpositionValueName)
	InstanceTesting(ObjectHolderValue,Remote,ObjectHolderValueBackUp.Name)
	InstanceTesting(lookdirectorValue,Remote,lookdirectionValueBackUp.Name)
	InstanceTesting(ChatPart,workspace,ChatPart.Name,VT(0.001,0.001,0.001),ChatPart.Color,HeadBackUp.CFrame*CF(0,2,0))	
	InstanceTesting(Head,Head.Parent,Head.Name,HeadBackUp.Size,HeadBackUp.Color,HeadBackUp.CFrame)	
	InstanceTesting(Jaw,Jaw.Parent,Jaw.Name,JawBackUp.Size,JawBackUp.Color,JawBackUp.CFrame)
	InstanceTesting(Neck,Neck.Parent,Neck.Name,NeckBackUp.Size,NeckBackUp.Color,NeckBackUp.CFrame)
	InstanceTesting(UpperTorso,UpperTorso.Parent,UpperTorso.Name,UpperTorsoBackUp.Size,UpperTorsoBackUp.Color,UpperTorsoBackUp.CFrame)
	InstanceTesting(LowerTorso,LowerTorso.Parent,LowerTorso.Name,LowerTorsoBackUp.Size,LowerTorsoBackUp.Color,LowerTorsoBackUp.CFrame)	
	InstanceTesting(LeftShoulderJoint,LeftShoulderJoint.Parent,LeftShoulderJoint.Name,LeftShoulderBackUp.Size,LeftShoulderBackUp.Color,LeftShoulderBackUp.CFrame)
	InstanceTesting(LeftElbowJoint,LeftElbowJoint.Parent,LeftElbowJoint.Name,LeftElbowBackUp.Size,LeftElbowBackUp.Color,LeftElbowBackUp.CFrame)
	InstanceTesting(LeftHandJoint,LeftHandJoint.Parent,LeftHandJoint.Name,LeftHandJointBackUp.Size,LeftHandJointBackUp.Color,LeftHandJointBackUp.CFrame)	
	InstanceTesting(RightShoulderJoint,RightShoulderJoint.Parent,RightShoulderJoint.Name,RightShoulderBackUp.Size,RightShoulderBackUp.Color,RightShoulderBackUp.CFrame)
	InstanceTesting(RightElbowJoint,RightElbowJoint.Parent,RightElbowJoint.Name,RightElbowBackUp.Size,RightElbowBackUp.Color,RightElbowBackUp.CFrame)
	InstanceTesting(RightHandJoint,RightHandJoint.Parent,RightHandJoint.Name,RightHandJointBackUp.Size,RightHandJointBackUp.Color,RightHandJointBackUp.CFrame)
	InstanceTesting(LeftHipJoint,LeftHipJoint.Parent,LeftHipJoint.Name,LeftHipJointBackUp.Size,LeftHipJointBackUp.Color,LeftHipJointBackUp.CFrame)
	InstanceTesting(LeftKneeJoint,LeftKneeJoint.Parent,LeftKneeJoint.Name,LeftKneeJointBackUp.Size,LeftKneeJointBackUp.Color,LeftKneeJointBackUp.CFrame)
	InstanceTesting(LeftFootJoint,LeftFootJoint.Parent,LeftFootJoint.Name,LeftFootJointBackUp.Size,LeftFootJointBackUp.Color,LeftFootJointBackUp.CFrame)
	InstanceTesting(RightHipJoint,RightHipJoint.Parent,RightHipJoint.Name,RightHipJointBackUp.Size,RightHipJointBackUp.Color,RightHipJointBackUp.CFrame)
	InstanceTesting(RightKneeJoint,RightKneeJoint.Parent,RightKneeJoint.Name,RightKneeJointBackUp.Size,RightKneeJointBackUp.Color,RightKneeJointBackUp.CFrame)
	InstanceTesting(RightFootJoint,RightFootJoint.Parent,RightFootJoint.Name,RightFootJointBackUp.Size,RightFootJointBackUp.Color,RightFootJointBackUp.CFrame)

end



local remove,IsSafe=nil,true
remove = game.DescendantRemoving:Connect(function(o)
	if Stopped then remove:Disconnect() return end
	if o==Player and IsSafe==false then
		print("do something bad here because you got removed while joining >:(") 
	end

	local HasRan = false
	task.defer(function()
		HasRan = true
		DEFER(o)
	end)
	task.wait(.05)
	if HasRan == false then
		--FireInfo({"Warn","task.defer reached its executing limit!"})
		DEFER(o)
	end
end)





MoveSensitiveness = 0.01
function IsMoving()
	if MAINMOVEMENTSPEED>MoveSensitiveness or MAINMOVEMENTSPEED<MoveSensitiveness then
		return true
	end
end






function IsScript(Object)
	if Find(EffectInstances,Object) or Find(KilledInstances,Object) or Find(CharacterTable,Object) then
		return true
	else return false
	end
end


local tailjoints = {
	tailjoint1=nil;
	tailjoint2=nil;
	tailjoint3=nil;
	tailjointEnd=nil;
}


function SetTail(folder)
	pcall(function()
		local tail1 = folder:WaitForChild("tail1")
		local tail2 = folder:WaitForChild("tail2")
		local tail3 = folder:WaitForChild("tail3")
		local tail4 = folder:WaitForChild("tail4")
		tailjoints.tailjoint1 = tail1
		tailjoints.tailjoint2 = tail2
		tailjoints.tailjoint3 = tail3
		tailjoints.tailjointEnd = tail4	
	end)
end

local tailRot = 0
function MoveTail(xRadius,yRadius)
	if type(yRadius)~="number" then yRadius=0 end
	if type(xRadius)~="number" then xRadius=0 end
	local host = LowerTorsoBackUp

	tailRot = Lerp(tailRot,MoveDirector.Z/5,Smoothness)
	--	local X,Y,Z = RotationWorld(GlobalBodyAngle,MainPosition)
	local Joint1 = divcf(host.CFrame, charscale)*CF(0,.5,0)*ANGLE(RAD(yRadius)+tailRot*2,0,RAD(40)+RAD(xRadius)) * CF(0,2,0)

	local Joint2 = Joint1*CF(0,1.5,0)*ANGLE(RAD(yRadius)+tailRot,0,-RAD(10)+RAD(xRadius)/2) * CF(0,1,0)
	local Joint3 = Joint2*CF(0,1.5,0)*ANGLE(RAD(yRadius)+tailRot,0,-RAD(20)-RAD(xRadius)) * CF(0,1,0)
	local Joint4 = Joint3*CF(0,1.5,0)*ANGLE(RAD(yRadius)+tailRot,0,-RAD(20)-RAD(xRadius)/2) * CF(0,1,0)

	tailjoints.tailjoint1.CFrame = multcf(Joint1, charscale)
	tailjoints.tailjoint1.CFrame *= ANGLE(0,0,-RAD(90))

	tailjoints.tailjoint2.CFrame = multcf(Joint2, charscale)
	tailjoints.tailjoint2.CFrame *= ANGLE(0,0,-RAD(90))


	tailjoints.tailjoint3.CFrame = multcf(Joint3, charscale)
	tailjoints.tailjoint3.CFrame *= ANGLE(0,0,-RAD(90))

	tailjoints.tailjointEnd.CFrame = multcf(Joint4, charscale)
	tailjoints.tailjointEnd.CFrame *= ANGLE(0,0,-RAD(90))
end



local righthandpalm = {
	leftfinger1=nil;
	leftfinger2=nil;
	leftclaw=nil;
	middlefinger1=nil;
	middlefinger2=nil;
	middleclaw=nil;
	rightfinger1=nil;
	rightfinger2=nil;
	rightclaw=nil;
} 


function MoveRightHand(radius,ZRadius)
	if type(ZRadius)~="number" then ZRadius=10 end
	if type(radius)~="number" then radius=0 end
	pcall(function()
		radius=-radius
		local hand = divcf(RightHandJointBackUp.CFrame, charscale)*ANGLE(RAD(70),-RAD(90),0)
		local pointfingerjoint1 = hand*CF(0,-.05,.18)*ANGLE(0,-RAD(30)-RAD(radius),-RAD(10)+RAD(ZRadius))
		righthandpalm.leftfinger1.CFrame = multcf((pointfingerjoint1 * CF(.4,0,0)), charscale)
		local Joint = pointfingerjoint1*CF(.85,0,0)*ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius))*CF(.45,0,0)
		righthandpalm.leftfinger2.CFrame = multcf(Joint, charscale)
		righthandpalm.leftfinger2.CFrame *= ANGLE(0,RAD(180),0)
		righthandpalm.leftclaw.CFrame = multcf(Joint * CF(.4,.075,0) * ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius)) * CF(.35,0,0), charscale)
		righthandpalm.leftclaw.CFrame *= ANGLE(RAD(180),0,RAD(80))						
		local pointfingerjoint1 = hand*CF(0,.05,.05)*ANGLE(0,-RAD(radius),-RAD(10)+RAD(ZRadius))
		righthandpalm.middlefinger1.CFrame = multcf((pointfingerjoint1 * CF(.4,0,0)), charscale)
		local Joint = pointfingerjoint1*CF(.8,0,0)*ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius))*CF(.45,0,0)
		righthandpalm.middlefinger2.CFrame = multcf(Joint, charscale)
		righthandpalm.middlefinger2.CFrame *= ANGLE(0,RAD(180),0)
		righthandpalm.middleclaw.CFrame = multcf(Joint * CF(.4,.075,0) * ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius)) * CF(.35,0,0), charscale)
		righthandpalm.middleclaw.CFrame *= ANGLE(RAD(180),0,RAD(80))						
		local pointfingerjoint1 = hand*CF(0,.05,-.16)*ANGLE(0,RAD(20)-RAD(radius),-RAD(10)+RAD(ZRadius))
		righthandpalm.rightfinger1.CFrame = multcf((pointfingerjoint1 * CF(.4,0,0)), charscale)
		local Joint = pointfingerjoint1*CF(.75,0,0)*ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius))*CF(.35,0,0)
		righthandpalm.rightfinger2.CFrame = multcf(Joint, charscale)
		righthandpalm.rightfinger2.CFrame *= ANGLE(0,RAD(180),0)
		righthandpalm.rightclaw.CFrame = multcf(Joint * CF(.4,.075,0) * ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius)) * CF(.35,0,0), charscale)
		righthandpalm.rightclaw.CFrame *= ANGLE(RAD(180),0,RAD(80))
	end)
end

function SetRightHand(Joint)
	pcall(function()
		local hand = Joint
		local finger1 = hand:WaitForChild("finger1")
		local finger2 = hand:WaitForChild("finger2")
		local finger3 = hand:WaitForChild("finger3")
		righthandpalm.leftfinger1 = finger1.lowerfinger
		righthandpalm.leftfinger2 = finger1.fingermiddle
		righthandpalm.leftclaw = finger1.claw

		righthandpalm.middlefinger1 = finger2.lowerfinger
		righthandpalm.middlefinger2 = finger2.fingermiddle
		righthandpalm.middleclaw = finger2.claw

		righthandpalm.rightfinger1 = finger3.lowerfinger
		righthandpalm.rightfinger2 = finger3.fingermiddle
		righthandpalm.rightclaw = finger3.claw
	end)
end

local lefthandpalm = {
	leftfinger1=nil;
	leftfinger2=nil;
	leftclaw=nil;
	middlefinger1=nil;
	middlefinger2=nil;
	middleclaw=nil;
	rightfinger1=nil;
	rightfinger2=nil;
	rightclaw=nil;
} 

function MoveLefthand(radius,ZRadius)
	if type(ZRadius)~="number" then ZRadius=10 end
	if type(radius)~="number" then radius=0 end
	pcall(function()
		local hand = divcf(LeftHandJointBackUp.CFrame, charscale)*ANGLE(RAD(70),-RAD(90),0)
		local pointfingerjoint1 = hand*CF(0,.05,.18)*ANGLE(0,-RAD(30)-RAD(radius),-RAD(10)+RAD(ZRadius))
		lefthandpalm.leftfinger1.CFrame = multcf((pointfingerjoint1 * CF(.25,0,0)), charscale)
		lefthandpalm.leftfinger1.CFrame *= ANGLE(0,RAD(180),0)	
		local Joint = pointfingerjoint1*CF(.55,0,0)*ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius))*CF(.3,0,0)
		lefthandpalm.leftfinger2.CFrame = multcf(Joint, charscale)
		lefthandpalm.leftfinger2.CFrame *= ANGLE(0,RAD(180),0)
		lefthandpalm.leftclaw.CFrame = multcf(Joint * CF(.25,.1,0) * ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius)) * CF(.35,0,0), charscale)
		lefthandpalm.leftclaw.CFrame *= ANGLE(0,0,RAD(115))						
		local pointfingerjoint1 = hand*CF(.1,-.05,.05)*ANGLE(0,0-RAD(radius),-RAD(10)+RAD(ZRadius))
		lefthandpalm.middlefinger1.CFrame = multcf((pointfingerjoint1 * CF(.35,0,0)), charscale)
		local Joint = pointfingerjoint1*CF(.7,0,0)*ANGLE(0,-RAD(5)-RAD(radius*2),RAD(5)+RAD(ZRadius))*CF(.4,0,0)
		lefthandpalm.middlefinger2.CFrame = multcf(Joint, charscale)
		lefthandpalm.middlefinger2.CFrame *= ANGLE(0,RAD(180),0)
		lefthandpalm.middleclaw.CFrame = multcf(Joint * CF(.3,.16,0) * ANGLE(0,-RAD(radius*2),RAD(5)+RAD(ZRadius)) * CF(.35,0,0), charscale)
		lefthandpalm.middleclaw.CFrame *= ANGLE(0,0,RAD(120))
		local pointfingerjoint1 = hand*CF(0,-.05,-.16)*ANGLE(0,RAD(20)-RAD(radius),-RAD(10)+RAD(ZRadius))
		lefthandpalm.rightfinger1.CFrame = multcf((pointfingerjoint1 * CF(.4,0,0)), charscale)
		lefthandpalm.rightfinger1.CFrame *= ANGLE(0,0,RAD(180))
		local Joint = pointfingerjoint1*CF(.8,0,0)*ANGLE(0,-RAD(5+radius*2),RAD(5)+RAD(ZRadius))*CF(.5,0,0)
		lefthandpalm.rightfinger2.CFrame = multcf(Joint, charscale)
		lefthandpalm.rightclaw.CFrame = multcf(Joint * CF(.5,.15,0) * ANGLE(0,-RAD(5+radius*2),RAD(5)+RAD(ZRadius)) * CF(.45,0,0), charscale)
		lefthandpalm.rightclaw.CFrame *= ANGLE(0,0,RAD(110))



	end)
end

function SetLefthand(Joint)
	pcall(function()
		local hand = Joint
		local finger1 = hand:WaitForChild("finger1")
		local finger2 = hand:WaitForChild("finger2")
		local finger3 = hand:WaitForChild("finger3")
		lefthandpalm.leftfinger1 = finger1.lowerfinger
		lefthandpalm.leftfinger2 = finger1.fingermiddle
		lefthandpalm.leftclaw = finger1.claw	
		lefthandpalm.middlefinger1 = finger2.lowerfinger
		lefthandpalm.middlefinger2 = finger2.fingermiddle
		lefthandpalm.middleclaw = finger2.claw		
		lefthandpalm.rightfinger1 = finger3.lowerfinger
		lefthandpalm.rightfinger2 = finger3.fingermiddle
		lefthandpalm.rightclaw = finger3.claw
	end)
end






local Loadingparent = false
function LockProperties(Obj)
	local OldArchive = Obj.Archivable
	local OldParent = Obj.Parent


	--//connections
	local MeshEvent,OffsetEvent,MeshIdEvent,MeshDoubleSideEvent
	local ColorChanged = nil
	local TransparencyChanged = nil
	local SizeChanged = nil
	local C10Changed = nil
	local ParentChanged = nil
	local ArchivableChanged = nil
	local AnchoreChanged = nil	
	local ChangeEvent = nil
	local childAddEvent = nil
	--//

	if Obj:IsA("BasePart") then
		local OldSize = Obj.Size
		local OldTransparency = Obj.Transparency
		local OldColor = Obj.Color
		local OldAnchored = Obj.Anchored

		childAddEvent = Obj.ChildAdded:Connect(function(object)

			if not object:IsA("SpecialMesh") or not object:IsA("ViewportFrame") or object.Parent==nil or IsScript(object)==true then return end
			task.defer(function()object:Destroy()end)
			task.wait()if object.Parent~=nil then
				object:Destroy()
			end
		end)
		if Find(NeonParts,Obj)==nil and Find(EffectNeonParts,Obj)==nil then
			ColorChanged = Obj:GetPropertyChangedSignal("Color"):Connect(function()
				task.wait()
				if Obj.Color ~= OldColor then
					Obj.Color = OldColor
				end
			end)
		elseif Find(EffectNeonParts,Obj)~=nil then

			ColorChanged = Obj:GetPropertyChangedSignal("Color"):Connect(function()
				task.wait()
				if Obj.Color ~= Color3.new() then
					Obj.Color = Color3.new()
				end
			end)




		end

		TransparencyChanged = Obj:GetPropertyChangedSignal("Transparency"):Connect(function()
			if Obj.Transparency ~= OldTransparency then
				Obj.Transparency = OldTransparency
			end
		end)

		AnchoreChanged = Obj:GetPropertyChangedSignal("Anchored"):Connect(function()
			if Obj.Anchored ~= OldAnchored then
				Obj.Anchored = OldAnchored
			end
		end)

		SizeChanged = Obj:GetPropertyChangedSignal("Size"):Connect(function()
			if Obj.Size ~= OldSize then
				Obj.Size = OldSize
			end
		end)

		if Obj:IsA("MeshPart") then
			local OldMeshId=Obj.MeshId 
			local OldRender=Obj.DoubleSided

			pcall(function()	
				MeshIdEvent = Obj:GetPropertyChangedSignal("MeshId"):Connect(function()
					if Obj.MeshId~=OldMeshId and Obj:IsDescendantOf(game) then
						Obj:Destroy()
					end
				end)
			end)

			pcall(function()
				MeshDoubleSideEvent = Obj:GetPropertyChangedSignal("DoubleSided"):Connect(function()
					if Obj.DoubleSided~=OldRender and Obj:IsDescendantOf(game) then
						Obj:Destroy()
					end
				end)
			end)
		end


		ParentChanged = Obj.AncestryChanged:Connect(function(newparent)
			if Loadingparent==true then return end
			task.wait()
			if newparent ~= OldParent then
				if Obj:IsDescendantOf(game) then
					Obj:Destroy()end
				if ParentChanged then	ParentChanged:Disconnect() end
				if MeshDoubleSideEvent then MeshDoubleSideEvent:Disconnect() end
				if MeshIdEvent then MeshIdEvent:Disconnect() end
				if SizeChanged then	SizeChanged:Disconnect() end
				if TransparencyChanged then	TransparencyChanged:Disconnect() end
				if AnchoreChanged then AnchoreChanged:Disconnect() end
				if ColorChanged then	ColorChanged:Disconnect() end
				if childAddEvent then	childAddEvent:Disconnect() end
			end
		end)


	elseif Obj:IsA("SpecialMesh") then
		local Oldoffset = VT(0,0,0)
		local OldMeshId=Obj.MeshId 


		if Obj:IsA("SpecialMesh") then Oldoffset = Obj.Offset end 
		MeshEvent = Obj:GetPropertyChangedSignal("MeshId"):Connect(function()
			if Obj.MeshId~=OldMeshId then
				Obj.MeshId=OldMeshId
			end
		end)

		if Obj:IsA("SpecialMesh") then
			OffsetEvent = Obj:GetPropertyChangedSignal("Offset"):Connect(function()
				if Obj.Offset~=Oldoffset then
					Obj.Offset=Oldoffset
				end
			end)
		end



		ParentChanged = Obj.AncestryChanged:Connect(function(newparent)
			if Loadingparent==true then return end
			task.wait()
			if newparent ~= OldParent then
				if Obj:IsDescendantOf(game) then
					Obj:Destroy()end
				if ParentChanged then	ParentChanged:Disconnect() end
				if OffsetEvent then	OffsetEvent:Disconnect() end
				if MeshEvent then	MeshEvent:Disconnect() end
			end
		end)


	elseif Obj:IsA("Weld") or Obj:IsA("Motor") or Obj:IsA("Motor6D") or Obj:IsA("ManualWeld") or Obj:IsA("ManualGlue") then
		local OldCo0,OldC1,OldPart0,OldPart1,OldEnabled = Obj.C0,Obj.C1,Obj.Part0,Obj.Part1,Obj.Enabled
		ChangeEvent = Obj.Changed:Connect(function()
			task.wait()
			if Obj.Enabled~=OldEnabled or Obj.C0~=OldCo0 or Obj.C1~=OldC1 or Obj.Part0~=OldPart0 or Obj.Part1~=OldPart1 then
				Obj:Destroy()
			end
		end)

		ParentChanged = Obj.AncestryChanged:Connect(function(newparent)
			if Loadingparent==true then return end
			task.wait()
			if newparent ~= OldParent then
				if Obj:IsDescendantOf(game) then
					Obj:Destroy() end
				if ParentChanged then ParentChanged:Disconnect() end
				if ChangeEvent then	ChangeEvent:Disconnect() end
			end
		end)
	end



	ArchivableChanged = Obj:GetPropertyChangedSignal("Archivable"):Connect(function()
		if Obj.Archivable ~= OldArchive then
			Obj:Destroy()
			ArchivableChanged:Disconnect()
		end
	end)
end



function RemoveCharacter()

	--	warn(#EffectInstances)

	if #EffectInstances~=0 then
		for _,inst in ipairs(EffectInstances) do
			inst:Destroy()
		end 
	end

	--	warn(#CharacterTable)

	if MainFigure==nil or not MainFigure:IsDescendantOf(workspace) then
		if LoadingCharacter==true then FireInfo({"inform","error, character still loading"}) return end
		CreateCharacter()
	end	

	if #CharacterTable~=0 then
		for _,inst in ipairs(CharacterTable) do
			inst:Destroy()
		end
		table.clear(CharacterTable)
	end
end


function NewAudio()
	globalambience.ambience = IT("Sound")
	globalambience.ambience.SoundId=globalambience.SoundID
	globalambience.ambience.TimePosition=globalambience.GlobalTimePosition
	globalambience.ambience.Name=RndmName(10) 
	globalambience.ambience.Parent=Head 
	globalambience.ambience.Looped=true 
	IT("PitchShiftSoundEffect",globalambience.ambience).Octave = 1
	IT("DistortionSoundEffect",globalambience.ambience).Level = 0.1
	globalambience.ambience.Volume=denseVOLUME
	globalambience.ambience.Pitch=CurrentPitch
	globalambience.ambience:Play()
end

function NewChatPart()
	if Stopped then return end
	ChatPart = IT("Part") ChatPart.CFrame=HeadBackUp.CFrame*CF(0,2,0)
	ChatPart.Size = VT(0.001,0.001,0.001) ChatPart.Transparency=1 ChatPart.Anchored=true
	ChatPart.CanCollide=false ChatPart.CanQuery=false
	ChatPart.Name = RNDM()*99999
	local connect
	connect=ChatPart.AncestryChanged:Connect(function()
		Wait()
		if not ChatPart:IsDescendantOf(workspace) then
			connect:Disconnect()
			NewChatPart()
		end
	end)

	Insert(EffectInstances,ChatPart)
	ChatPart.Parent=workspace 
	LockProperties(ChatPart)
end

function YieldUntilFpsHigher(limit)
	if limit==nil then limit=10 end
	repeat local fps = 2/task.wait() until fps>=limit
end



function CreateCharacter()
	Loadingparent = true
	local function remov(o)
		o:Destroy()
	end

	local LocalChar = CharacterTable
	CharacterTable,NeonParts=nil,nil
	CharacterTable,NeonParts={},{}

	local NewModel = nil

	local win,fail = pcall(function()
		if PlayerMode and Player~=nil and Player.Parent~=nil then
			NewModel = IT("Model") NewModel.Name = "Pilum"
		else
			NewModel =	IT(RandomModel[RNDM(1,#RandomModel)]) NewModel.Name=RndmName(6)
		end
	end)







	if not win then
		NewModel =	IT(RandomInstances[RNDM(1,#RandomInstances)]) NewModel.Name=RNDM()*999
	end	
	NewModel.Archivable = false

	IT("ForceField",NewModel).Visible = false
	--Effects = Figure

	--//head
	Head = HeadBackUp:Clone() Head.Parent = NewModel
	Jaw = JawBackUp:Clone() Jaw.Parent = NewModel


	NewAudio()

	--//torso
	Neck = NeckBackUp:Clone() Neck.Parent = NewModel
	UpperTorso = UpperTorsoBackUp:Clone() UpperTorso.Parent = NewModel
	LowerTorso = LowerTorsoBackUp:Clone() LowerTorso.Parent = NewModel
	Tail = TailFolder:Clone() Tail.Parent = NewModel
	SetTail(Tail)
	MoveTail(TailAngle1,TailAngle2)

	--//left arm
	LeftShoulderJoint = LeftShoulderBackUp:Clone() LeftShoulderJoint.Parent = NewModel
	LeftElbowJoint = LeftElbowBackUp:Clone() LeftElbowJoint.Parent = NewModel
	LeftHandJoint = LeftHandJointBackUp:Clone() LeftHandJoint.Parent = NewModel
	SetLefthand(LeftHandJoint)
	MoveLefthand(LefthandGrip1,LefthandGrip2)

	--//right arm
	RightShoulderJoint = RightShoulderBackUp:Clone() RightShoulderJoint.Parent = NewModel
	RightElbowJoint = RightElbowBackUp:Clone() RightElbowJoint.Parent = NewModel
	RightHandJoint = RightHandJointBackUp:Clone() RightHandJoint.Parent = NewModel
	SetRightHand(RightHandJoint)
	MoveRightHand(RighthandGrip1,RighthandGrip2)


	--//left leg
	LeftHipJoint = LeftHipJointBackUp:Clone() LeftHipJoint.Parent = NewModel
	LeftKneeJoint = LeftKneeJointBackUp:Clone() LeftKneeJoint.Parent = NewModel
	LeftFootJoint = LeftFootJointBackUp:Clone() LeftFootJoint.Parent = NewModel


	--//right leg
	RightHipJoint = RightHipJointBackUp:Clone() RightHipJoint.Parent = NewModel
	RightKneeJoint = RightKneeJointBackUp:Clone() RightKneeJoint.Parent = NewModel
	RightFootJoint = RightFootJointBackUp:Clone() RightFootJoint.Parent = NewModel






	MainFigure = NewModel
	local NewFigure = NewModel:GetDescendants()
	if #NewFigure<5 then
		wait()
		NewFigure = NewModel:GetDescendants()
	end

	for _,prt in ipairs(NewFigure) do
		local val = prt:FindFirstChildOfClass("Color3Value")
		if prt:IsA("BasePart") and prt.Material == Enum.Material.Neon  then
			if val ~= nil and val.Name == "effect" then
				Insert(EffectNeonParts,prt)
				--	warn(prt.Name)
			else
				Insert(NeonParts,prt)
			end

		end
		Insert(CharacterTable,prt)
		prt.Name = RndmName(6)

		LockProperties(prt)
	end

	UpdateRig()


	Insert(CharacterTable,NewModel) 	LoadingCharacter = false
	if PlayerMode and Player~=nil and Player.Parent~=nil then
		Player.Character = NewModel
	end

	task.spawn(function()
		if #LocalChar~=0 then 
			wait()
			pcall(function()
				for _,ins in ipairs(LocalChar) do
					if ins.Name==Player.Name then
						warn("found")
					end
					if ins.Parent~=nil then
						pcall(remov,ins)
					end
				end
			end)
		end
	end)

	NewModel.Parent = workspace  	Loadingparent = false
	FireInfo({"newaudio",globalambience.ambience})
	FireInfo({"updatelist",NewFigure})
end



for _,obj in ipairs(CharacterFolder:GetDescendants()) do
	local val = obj:FindFirstChildOfClass("Color3Value")
	if obj:IsA("BasePart") and obj.Material == Enum.Material.Neon  then
		if val ~= nil and val.Name == "effect" then
			Insert(NILEffectNeonParts,obj)
			--print(obj.Name)
		else
			Insert(NILneonparts,obj)
		end
	end

end












--//CHARACTER FUNCTIONS





function UpdateLookDirection()

	local LOOKFRAME = MouseHIT
	local HdPos = HeadBackUp.CFrame.p
	local TrsoLV = (MainPosition*ANGLE(0,RAD(180),0)).lookVector
	local Dist = (HeadBackUp.CFrame.p-LOOKFRAME.p).magnitude 
	local Diff = HeadBackUp.CFrame.Y-LOOKFRAME.Y


	--print(MainMode)
	if MainMode~=0 and MainMode~=1 and DoingTaunt==false then
		oldROT = ANGLE(-(mSIN(Diff/Dist)*HeadVertFactor), (((HdPos-LOOKFRAME.p).Unit):Cross(TrsoLV)).Y*HeadHorFactor, 0)						
		LookDirection= LookDirection:Lerp(oldROT,.1)    -- linear(LookDirection, oldROT, .5, 0.0275)				
	else
		--LookDirection=linear(LookDirection, LOOKFRAME, .5, 0.0275)	
	end
end





--//Core Limb holders





--//upper/lower torso


--//arms


--//


--//




--//C0 is the animating, C1 is holding the pieces together

function STATIC()
	WaistJointC0,WaistJointC1 = WaistHolder,CF(static)
	TorsoJointC0,TorsoJointC1 = TorsoHolder,CF(0,2,0)
	NeckTorsoWeldC0,NeckTorsoWeldC1 = NeckTorsoHolder,CF(0,0,-.5)
	NeckHeadWeldC0,NeckHeadWeldC1 = HeadNeckHolder,CF(0,0,-1)
	JawWeldC0,JawWeldC1 = JawHolder,CF(0,-.3,-.76)

	LeftShoulderWeldC0,LeftShoulderWeldC1 = LeftShoulderHolder,CF(-.5,-.25,.25)
	LeftElbowWeldC0,LeftElbowWeldC1 = LeftElbowHolder,CF(0,-.15,0)
	LeftHandWeldC0,LeftHandWeldC1 = LeftHandHolder,CF(0,0,.25)

	RightShoulderWeldC0,RightShoulderWeldC1 = RightShoulderHolder,CF(.5,-.25,.25)
	RightElbowWeldC0,RightElbowWeldC1 = RightElbowHolder,CF(0,-.15,0)
	RightHandWeldC0,RightHandWeldC1 = RightHandHolder,CF(0,-.2,-.25)

	LeftHipWeldC0,LeftHipWeldC1 = LeftHipHolder,CF(0,-.75,0)
	LeftKneeWeldC0,LeftKneeWeldC1 = LeftKneeHolder,CF(0,-1.25,.15)
	LeftFootWeldC0,LeftFootWeldC1 = LeftFootHolder,CF(0,-.25,.1)

	RightHipWeldC0,RightHipWeldC1 = RightHipHolder,CF(0,-.75,0)
	RightKneeWeldC0,RightKneeWeldC1 = RightKneeHolder,CF(0,-1.25,.15)
	RightFootWeldC0,RightFootWeldC1 = RightFootHolder,CF(0,-.25,.1)
end



STATIC()




--//core functions

function RawLookDirection(HorizonFactor,VerticalFactor,host)
	if MainMode == 0 then
		return CF(0,0,0)
	end
	if HorizonFactor==nil then HorizonFactor=1 end
	if VerticalFactor==nil then VerticalFactor=1 end
	if host==nil then host=HeadBackUp end


	local MouseCF,target = MouseHIT,MouseTarget
	local LOOKFRAME = MouseCF
	local HdPos = host.CFrame.p
	local TrsoLV = (HeadBackUp.CFrame).lookVector
	local Dist = (host.CFrame.p-LOOKFRAME.p).magnitude 
	local Diff = host.CFrame.Y-LOOKFRAME.Y
	return  ANGLE(-(mSIN(Diff/Dist)*VerticalFactor), (((HdPos-LOOKFRAME.p).Unit):Cross(TrsoLV)).Y*HorizonFactor, 0)    --ANGLE(-(mSIN(Diff/Dist)*VerticalFactor), (((HdPos-LOOKFRAME.p).Unit):Cross(TrsoLV)).Y*HorizonFactor, 0)						
end



function TestDirection(HorizonFactor,VerticalFactor,host,End)
	if MainMode == 0 then
		return CF(0,0,0)
	end
	if HorizonFactor==nil then HorizonFactor=1 end
	if VerticalFactor==nil then VerticalFactor=1 end
	if host==nil then host=HeadBackUp end


	--	local MouseCF,target = MouseHIT,MouseTarget
	local LOOKFRAME = CF(host.Position,End.Position)
	local HdPos = host.CFrame.p
	local TrsoLV = (HeadBackUp.CFrame).lookVector
	local Dist = (host.CFrame.p-LOOKFRAME.p).magnitude 
	local Diff = host.CFrame.Y-LOOKFRAME.Y
	return  ANGLE(-(mSIN(Diff/Dist)*VerticalFactor), (((HdPos-LOOKFRAME.p).Unit):Cross(TrsoLV)).Y*HorizonFactor, 0)    --ANGLE(-(mSIN(Diff/Dist)*VerticalFactor), (((HdPos-LOOKFRAME.p).Unit):Cross(TrsoLV)).Y*HorizonFactor, 0)						
end


local lefteyeLook = CF(static)
local righteyeLook = CF(static)
local HandleCFrame = MainPosition

local RightFootAttachment = IT("Attachment")
local LeftFootAttachment = IT("Attachment")
RootPosition = CF(static)
function UpdateRig() 

	--//calculating
	local RootJoint = ((MainPosition*ANGLE(0,RAD(180),0)) * WaistJointC0 * WaistJointC1)	
	oldDirection = LookDirection
	RootPosition = RootJoint

	CharacterDirection.CFrame = multcf(RootJoint, charscale)--*LookDirection


	local TorsoLookDirection = ANGLE((LookDirection.LookVector.Y*1.5),-LookDirection.LookVector.X/3,0)

	local NeckLookDirection = ANGLE(LookDirection.LookVector.Y,-LookDirection.LookVector.X/2,0)	

	local UpperRootJoint = (RootJoint * TorsoJointC0 * TorsoLookDirection * TorsoJointC1)

	local NECKJOINT = UpperRootJoint * NeckTorsoWeldC0 * NeckLookDirection * NeckTorsoWeldC1	

	local HEADJOINT = NECKJOINT * NeckHeadWeldC0 * NeckLookDirection * NeckHeadWeldC1	



	LowerTorso.CFrame = multcf(RootJoint * ANGLE(RAD(90),RAD(90),0), charscale) LowerTorsoBackUp.CFrame = multcf(RootJoint * ANGLE(RAD(90),RAD(90),0), charscale)
	UpperTorso.CFrame = multcf(UpperRootJoint*ANGLE(0,RAD(90),0), charscale) UpperTorsoBackUp.CFrame = multcf(UpperRootJoint*ANGLE(0,RAD(90),0), charscale)
	Neck.CFrame = multcf(NECKJOINT * ANGLE(RAD(10),RAD(90),0), charscale)  NeckBackUp.CFrame = multcf(NECKJOINT * ANGLE(RAD(10),RAD(90),0), charscale)
	Head.CFrame = multcf(HEADJOINT, charscale) HeadBackUp.CFrame =multcf(HEADJOINT, charscale)
	Jaw.CFrame = multcf(HEADJOINT * JawWeldC0 * ANGLE(-RAD(Speach),0,0) * JawWeldC1 * ANGLE(0,-RAD(90),0), charscale)
	JawBackUp.CFrame = multcf(HEADJOINT * JawWeldC0 * ANGLE(-RAD(Speach),0,0) * JawWeldC1 * ANGLE(0,-RAD(90),0), charscale)
	MoveTail(TailAngle1,TailAngle2)
	ChatPart.CFrame = multcf(HEADJOINT*CF(0,2,0), charscale)


	local left_arm = UpperRootJoint * LeftShoulderWeldC0 * LeftShoulderWeldC1
	LeftShoulderJoint.CFrame = multcf(left_arm, charscale) LeftShoulderBackUp.CFrame = multcf(left_arm, charscale)
	LeftShoulderJoint.CFrame *= ANGLE(0,RAD(90),0) LeftShoulderBackUp.CFrame *= ANGLE(0,RAD(90),0)

	local left_elbow = left_arm * LeftElbowWeldC0 * LeftElbowWeldC1-- * ANGLE(0,0,-RAD(180))
	LeftElbowJoint.CFrame = multcf(left_elbow, charscale) LeftElbowBackUp.CFrame = multcf(left_elbow, charscale)
	LeftHandJoint.CFrame = multcf(left_elbow * LeftHandWeldC0 * LeftHandWeldC1, charscale) LeftHandJointBackUp.CFrame = multcf(left_elbow * LeftHandWeldC0 * LeftHandWeldC1, charscale)
	LeftHandJoint.CFrame *= ANGLE(-RAD(70),RAD(90),0) LeftHandJointBackUp.CFrame *= ANGLE(-RAD(70),RAD(90),0)
	MoveLefthand(LefthandGrip1,LefthandGrip2)




	local right_arm = UpperRootJoint * RightShoulderWeldC0 * RightShoulderWeldC1
	RightShoulderJoint.CFrame = multcf(right_arm, charscale) RightShoulderBackUp.CFrame = multcf(right_arm, charscale)
	RightShoulderJoint.CFrame *= ANGLE(0,RAD(90),0) RightShoulderBackUp.CFrame *= ANGLE(0,RAD(90),0)
	local right_elbow = right_arm * RightElbowWeldC0 * RightElbowWeldC1-- * ANGLE(0,0,-RAD(180))
	RightElbowJoint.CFrame = multcf(right_elbow, charscale) RightElbowBackUp.CFrame = multcf(right_elbow, charscale)
	RightHandJoint.CFrame = multcf(right_elbow * RightHandWeldC0 * RightHandWeldC1, charscale)
	RightHandJointBackUp.CFrame = multcf(right_elbow * RightHandWeldC0 * RightHandWeldC1, charscale)
	RightHandJoint.CFrame *= ANGLE(RAD(50),-RAD(100),0)
	RightHandJointBackUp.CFrame *= ANGLE(RAD(50),-RAD(100),0)
	MoveRightHand(RighthandGrip1,RighthandGrip2)


	local left_leg = RootJoint * LeftHipWeldC0 * LeftHipWeldC1

	--* ANGLE(-math.sin(NilCounter/30),0,0)
	LeftHipJoint.CFrame = multcf(left_leg, charscale) LeftHipJointBackUp.CFrame = multcf(left_leg, charscale)
	LeftHipJoint.CFrame *= ANGLE(0,RAD(90),0)LeftHipJointBackUp.CFrame *= ANGLE(0,RAD(90),0)

	local left_knee = left_leg * LeftKneeWeldC0 * LeftKneeWeldC1
	LeftKneeJoint.CFrame = multcf(left_knee, charscale) LeftKneeJointBackUp.CFrame = multcf(left_knee, charscale)
	LeftKneeJoint.CFrame *= ANGLE(RAD(90),0,0)LeftKneeJointBackUp.CFrame *= ANGLE(RAD(90),0,0)
	LeftFootJoint.CFrame = multcf(left_knee * LeftFootWeldC0 * LeftFootWeldC1, charscale)
	LeftFootJointBackUp.CFrame = multcf(left_knee * LeftFootWeldC0 * LeftFootWeldC1, charscale)
	LeftFootAttachment.CFrame = multcf(left_knee, charscale)

	local right_leg = RootJoint * RightHipWeldC0 * RightHipWeldC1

	RightHipJoint.CFrame = multcf(right_leg, charscale) RightHipJointBackUp.CFrame = multcf(right_leg, charscale)
	RightHipJoint.CFrame *= ANGLE(0,RAD(90),0)RightHipJointBackUp.CFrame *= ANGLE(0,RAD(90),0)

	local right_knee = right_leg * RightKneeWeldC0 * RightKneeWeldC1
	RightKneeJoint.CFrame = multcf(right_knee, charscale) RightKneeJointBackUp.CFrame = multcf(right_knee, charscale)
	RightKneeJoint.CFrame *= ANGLE(RAD(90),0,0)RightKneeJointBackUp.CFrame *= ANGLE(RAD(90),0,0)



	RightFootJoint.CFrame = multcf(right_knee * RightFootWeldC0 * RightFootWeldC1, charscale) RightFootJointBackUp.CFrame = multcf(right_knee * RightFootWeldC0 * RightFootWeldC1, charscale)
	RightFootJoint.CFrame *= ANGLE(0,RAD(180),0) RightFootJointBackUp.CFrame *= ANGLE(0,RAD(180),0)
	-- * ANGLE(-math.sin(NilCounter/30),0,0)
	RightFootAttachment.CFrame = multcf(right_knee, charscale)

end


local RunningServo,Resetting = nil,false
function SERVO(speed)
	speed*=75
	if RunningServo==nil or RunningServo.Parent~=UpperTorso then
		RunningServo = CRTS(soundeffects.SERVO_,UpperTorso,.5,speed,false,16.5,false)		
		RunningServo:Play()
	end
	if speed>0 then
		if RunningServo.IsPaused then
			RunningServo:Play() end
		RunningServo.Pitch = mCLAMP(speed,0,1.2)	
		task.spawn(function()
			if not Resetting then
				Resetting=true
				Wait(100)
				Resetting=false
				RunningServo.TimePosition=17
			end
		end)
	else
		if RunningServo.IsPlaying then
			RunningServo:Pause() end
		RunningServo.Pitch = 0
	end		
end


local Left=false
local right=false
function Stepping(STEPPING)
	--walking/running backwards
	local stepPitch = .5 + ABS(mCLAMP(walkingspeed*1.5,-.5,.25))
	if not Walking then Left=true right=false return end	

	if walkingspeed>0 then
		if STEPPING>=0 and Left==false then
			Left=true
			if Phase==1 then
				ShakeCam(LeftFootJointBackUp.CFrame,3,10)
				CRTS(footsteps[RNDM(1,#footsteps)],LeftFootJoint,.25,stepPitch/(RNDM(1950,2050)/2000),false,0,true,false)
			elseif Phase==2 then
				CRTS(footsteps[RNDM(1,#footsteps)],LeftFootJoint,1,stepPitch/(RNDM(1950,2050)/2000),false,0,true,false)	
				ShakeCam(LeftFootJointBackUp.CFrame,3,10) 
			end
		elseif STEPPING<=0 and Left==true then
			Left=false
			if Phase==1 then
				ShakeCam(RightFootJointBackUp.CFrame,3,10)
				CRTS(footsteps[RNDM(1,#footsteps)],RightFootJoint,.25,stepPitch,false,0,true,false)
			elseif Phase==2 then
				CRTS(footsteps[RNDM(1,#footsteps)],RightFootJoint,1,stepPitch,false,0,true,false)
				ShakeCam(RightFootJointBackUp.CFrame,3,10)
			end
		end

	else
		if STEPPING>=.5 and Left==false then
			Left=true
			if Phase==1 then
				ShakeCam(LeftFootJointBackUp.CFrame,3,10)
				CRTS(footsteps[RNDM(1,#footsteps)],LeftFootJoint,.25,stepPitch/(RNDM(1950,2050)/2000),false,0,true,false)
			elseif Phase==2 then
				CRTS(footsteps[RNDM(1,#footsteps)],LeftFootJoint,1,stepPitch/(RNDM(1950,2050)/2000),false,0,true,false)	
				ShakeCam(LeftFootJointBackUp.CFrame,3,10) 
			end
		elseif STEPPING<=-.5 and Left==true then
			Left=false
			if Phase==1 then
				ShakeCam(RightFootJointBackUp.CFrame,3,10)
				CRTS(footsteps[RNDM(1,#footsteps)],RightFootJoint,.25,stepPitch/(RNDM(1950,2050)/2000),false,0,true,false)
			elseif Phase==2 then
				CRTS(footsteps[RNDM(1,#footsteps)],RightFootJoint,1,stepPitch/(RNDM(1950,2050)/2000),false,0,true,false)
				ShakeCam(RightFootJointBackUp.CFrame,3,10)
			end
		end

	end
end




















function SoundBox()
	local Loudness = globalambience.PlayBackLoudness

	if ISSPEAK  then
		JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(30),0,0),.5)

		--Speach = Lerp(Speach,10,Smoothness)
	else
		--Speach = Lerp(Speach,0,Smoothness)
	end
end






function SoundEvent()
	globalambience.GlobalTimePosition = globalambience.ambience.TimePosition
	globalambience.SoundID = LOAD(CurrentId)
	globalambience.ambience.Volume = denseVOLUME
	globalambience.ambience.Pitch = CurrentPitch
	if globalambience.ambience.SoundId ~= globalambience.SoundID then
		globalambience.ambience.TimePosition = 0 
		globalambience.ambience.SoundId = globalambience.SoundID
	end
	SoundBox()
end







local Cspeed=0
function SYSTEM()
	UpdateLookDirection()
	AntiChanger()
	Raycast()
	Animate()
	updateLookDirector(LookDirection)
	SoundEvent()

	local oldpos = MainPosition

	if (IsPlaying) then
		CurrentPitch = soundPitch
	else
		CurrentPitch = 0
	end




	if WALKING()==true and MainMode~=0 and MainMode~=1 and DoingTaunt==false then
		if MoveSpeed>0 then
			Walking=true
		else 
			Walking=false
		end
		if not Crouching then		
			Cspeed=Lerp(Cspeed,MoveSpeed,.05)
		else
			Cspeed=Lerp(Cspeed,RunSpeed*4.25,.05)
		end

		if (W and A) or (W and D) or (S and A) or (S and D) and (not Attacking) then
			CurrentMoveSpeed=Cspeed/1.35
			---CurrentMoveSpeed += mCLAMP(math.sin(Counter/5)/3,-1,0)-mCLAMP(math.cos(Counter/5)/3,0,.5)/1.35
		else
			CurrentMoveSpeed=Cspeed
			---CurrentMoveSpeed += mCLAMP(math.sin(Counter/5)/3,-1,0)-mCLAMP(math.cos(Counter/5)/3,0,.5)
		end

		if W  then MoveTo(CF(0,0,CurrentMoveSpeed)) end
		if S  then MoveTo(CF(0,0,-CurrentMoveSpeed)*ANGLE(0,RAD(-180),0))end
		if A  then MoveTo(CF(CurrentMoveSpeed,0,0)*ANGLE(0,RAD(90),0))end
		if D  then MoveTo(CF(-CurrentMoveSpeed,0,0)*ANGLE(0,RAD(-90),0))end

	else
		--walk glide effect
		Cspeed=Lerp(Cspeed,0,.1)
		Walking=false
		if Cspeed>(MoveSensitiveness*15) then
			if MainKey=="w"  then MoveTo(CF(0,0,Cspeed)) end
			if MainKey=="s"  then MoveTo(CF(0,0,-Cspeed)*ANGLE(0,RAD(-180),0))end
			if MainKey=="a"  then MoveTo(CF(Cspeed,0,0)*ANGLE(0,RAD(90),0))end
			if MainKey=="d"  then MoveTo(CF(-Cspeed,0,0)*ANGLE(0,RAD(-90),0))end
		end
	end


	if ShiftLocked then
		updateCamera(HeadBackUp.CFrame*CF(0,-.5,-.15))
	else
		updateCamera(multcf(MainPosition*CF(0,4,0), charscale))
	end

	MoveDirector = getObjectSpace(MainPosition,oldpos)*-1
	MAINMOVEMENTSPEED = (MoveDirector.X)

	if OnGround and MAINMOVEMENTSPEED==0 then
		Standing,Walking,Jumping,Falling=true,false,false,false--1
	elseif OnGround and IsMoving()==true and not Jumping and not Falling then
		Walking,Standing,Jumping,Falling=true,false,false,false
	elseif not OnGround and (IsMoving()==true) and Jumping and not Falling then
		Jumping,Standing,Walking,Falling=true,false,false,false
	elseif not OnGround and (IsMoving()==true) and not Jumping and Falling then
		Falling,Standing,Jumping,Walking=true,false,false,false
	end	
end







function resetList()
	if #FakeSoundTrack<1 then 
		FireInfo({"inform","there are no soundtracks to remove."})
		return end
	for num,audio in pairs(FakeSoundTrack) do
		local old = Find(SoundTracks,audio)
		if old~=nil then
			PRINT("Removed ID "..old.." from playlist")
			table.remove(SoundTracks,old)
		end
	end	
	FireInfo({"inform","Playlist has been reset"})
	table.clear(FakeSoundTrack)
end


function GetID(ID,w)
	local num = nil
	for prox = 1,#SoundTracks do
		if ID-SoundTracks[prox]==0 then
			return true
		end
	end
	return ID

end






local function updateSync()
	for _, Script in ipairs(workspace:GetChildren()) do
		if Script.ClassName == "Script" and Script.Name == "BeepBoopSkyway" and Script:GetAttribute("Start") ~= nil and tonumber(Script:GetAttribute("Start")) then
			return tonumber(Script:GetAttribute("Start"))
		end
	end
end





















function Stop()
	Stopped=true
	FireInfo({"stop"})
	ClearTables()
	RemoveCharacter()
	wait()
	script:Destroy()
	MainHolder:Destroy()
	Player:LoadCharacter()
	return
end





function Chatted(plrr)
	plrr.Chatted:Connect(function(msg)
		if msg=="g/r" then
			Stop()
		elseif msg=="/e fix" then
			Remote:Destroy()
			return
		end

		local MSG1 = msg:split(" ")
		if MSG1[1]=="/e" or MSG1[1]=="/e " then
			if MSG1[2]=="g/r" then
				Stop()
			end
			return
		end
		--FireInfo({"say",msg})
	end)
end










--//KILL


function CheckSize(part,limit)
	if limit == nil then limit = 20 end
	--if IsScript(part)~=true then
	local PartSize = part.Size
	local size = PartSize.x

	if PartSize.y >= size then
		size = PartSize.y
	end

	if PartSize.z >= size then
		size = PartSize.z
	end

	if size <= limit then
		return part
	else
		return nil
	end
	--else
	--	return nil
	--	end
end


function scanhitbox(host,size)
	local filterObjects = {host}
	local objects = {}
	local maxObjectsAllowed = 10
	local params = OverlapParams.new(filterObjects,Enum.RaycastFilterType.Blacklist,maxObjectsAllowed,Enum.CollisionFidelity.Default)
	local objectsInSpace = workspace:GetPartBoundsInBox(host.CFrame,size,params)
	for i,Object in ipairs(objectsInSpace) do -- loops through the items that are currently inside the given hitbox
		if Object:IsA("BasePart") and IsScript(Object)~=true and CheckSize(Object)==Object and Object.Transparency<.8 then -- make sure it's a part!
			Insert(objects,Object)
		end
	end
	return host,objects
end

function Paralize(figure,hit)
	if Find(EffectInstances,figure) then return end
	Insert(EffectInstances,figure)
	if hit ~=nil and hit.Name == "Head" then
		CRTS(gores[3],hit,.5,(RNDM(899,1400)/1000),false,0,false,true)
		local HO = EffectTable.ashparticle:Clone()	HO.Parent=hit 
		HO.Color=ColorSequence.new(Color3.new(0.333333, 0, 0)) 
		HO:Emit(100)Debris:AddItem(HO,2)
	end
	for _,parent in ipairs(figure:GetChildren()) do
		if parent:IsA("Motor6D") or parent:IsA("Motor") then
			local socket = IT("BallSocketConstraint")
			local a1 = IT("Attachment")
			local a2 = IT("Attachment")					
			a1.Parent = parent.Part0
			a2.Parent = parent.Part1
			socket.Parent = parent.Parent
			socket.Attachment0 = a1
			socket.Attachment1 = a2
			socket.Name = parent.Name
			a1.CFrame = parent.C0
			a2.CFrame = parent.C1
			a1.Name = parent.Name.." attachment1"
			a2.Name = parent.Name.." attachment2"
			socket.LimitsEnabled = true
			socket.TwistLimitsEnabled = true
			parent.Enabled=false
		end

		if parent:IsA("Attachment") and parent.Parent~=nil and parent.Parent.Name~="Handle" then
			--parent:Destroy()

		end
		if parent:IsA("BallSocketConstraint") then
			parent:Destroy()
		end

		if parent:IsA("Script") or parent:IsA("LocalScript") then
			parent.Enabled = false
		end
		for _,joint in ipairs(parent:GetChildren()) do
			if joint:IsA("Motor6D") or joint:IsA("Motor") then
				local socket = IT("BallSocketConstraint")
				local a1 = IT("Attachment")
				local a2 = IT("Attachment")					
				a1.Parent = joint.Part0
				a2.Parent = joint.Part1
				socket.Parent = joint.Parent
				socket.Attachment0 = a1
				socket.Attachment1 = a2
				socket.Name = joint.Name
				a1.CFrame = joint.C0
				a2.CFrame = joint.C1
				a1.Name = joint.Name.." attachment1"
				a2.Name = joint.Name.." attachment2"
				socket.LimitsEnabled = true
				socket.TwistLimitsEnabled = true
				joint.Enabled=false
			end

			if joint:IsA("Attachment") and joint.Parent~=nil and joint.Parent.Name~="Handle" then
				-- joint:Destroy()
			end

			if joint:IsA("BallSocketConstraint") then
				joint:Destroy()
			end

			if joint:IsA("Script") or joint:IsA("LocalScript") then
				joint.Enabled = false
			end
		end
	end
end



--//



local Limbs = {"Head";"Torso";"Left Arm";"Right Arm";"Left leg";"Right Leg";
	"UpperTorso";"LowerTorso";"LeftFoot";"RightFoot";"LeftHand";"RightHand";"LeftUpperLeg";"RightUpperLeg";
	"LeftLowerLeg";"RightLowerLeg";"LeftLowerArm";"RightLowerArm";"LeftUpperArm";"RightUpperArm";"HumanoidRootPart"
}





--//





local bill = IT"BillboardGui" bill.StudsOffset=Vector3.new(0,2,0)
local textbill = Instance.new("TextBox") textbill.TextScaled=true textbill.BackgroundTransparency=1 textbill.LineHeight=1 textbill.AutomaticSize=Enum.AutomaticSize.None  textbill.MaxVisibleGraphemes=-1 textbill.Visible=true textbill.TextWrapped=true  textbill.TextSize=50 textbill.Size=UDim2.new(1,0,1,0)  textbill.SizeConstraint=Enum.SizeConstraint.RelativeXY textbill.ZIndex=1 textbill.BorderMode=Enum.BorderMode.Outline textbill.BackgroundColor3=Color3.new(1, 1, 1) textbill.BorderColor3=Color3.new()
local fonts = Enum.Font:GetEnumItems()
local TextTick = 0
local texting = bill:Clone()

function WackyText(host,TXT)
	TextTick += .1251267
	texting:Destroy()
	texting = bill:Clone()
	texting.ZIndexBehavior=Enum.ZIndexBehavior.Sibling texting.LightInfluence=0 texting.Size=UDim2.fromScale(3.0,9.0) texting.ClipsDescendants=true texting.AutoLocalize=true texting.AlwaysOnTop=true texting.Active=true
	local text = textbill:Clone() 
	text.Text = TXT
	local IHAVEASTROKE = Instance.new("UIStroke",text) IHAVEASTROKE.Color = Color3.new(1,1,1) IHAVEASTROKE.Thickness = 2 IHAVEASTROKE.LineJoinMode = Enum.LineJoinMode.Bevel


	texting.StudsOffsetWorldSpace= Vector3.new(texting.StudsOffsetWorldSpace.X, POSITIONS_Y[math.random(1, #POSITIONS_Y)], 0)		
	text.TextColor3 = Color3.fromHSV(0, 1, 0.333333)
	text.Font = fonts[math.random(1,#fonts)]
	text.Rotation= math.sin(TextTick)
	text.Parent = texting
	texting.Parent = host
	Debris:AddItem(texting,3)
end


local function apply(part)
	local sides = {"Bottom","Front","Back", "Right", "Left","Top"}
	for tab = 1,#sides do	
		local dec = EffectTable.Blood:Clone()
		dec.Color3 = Color3.new(0.372549, 0, 0)
		dec.Parent = part
		dec.Face = sides[tab]
		dec.Name = time()
		dec.Transparency = .25
		dec.OffsetStudsV,dec.OffsetStudsU,dec.Transparency=1,random(-1,1,10),random(0,.75,10)
		Insert(EffectInstances,dec)
	end
end

local function b(part)
	local all = part:GetDescendants()
	if #all~=0 then
		for _,child in ipairs(all) do
			if child:IsA("BasePart") then
				apply(child)
			end
		end
	end
	apply(part)
end


local myvictim = {model=nil;root=nil;head=nil}
function Attack1()--grab
	myvictim = {model=nil;root=nil;head=nil}
	CRTS(soundeffects.swosh_small,RightHandJoint,3,1/(RNDM(1950,2050)/2000),false,0,true,false)
	for pr = 1,10 do
		LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(10)+LookDirection.LookVector.Y,0,-RAD(20)-LookDirection.LookVector.X/4),Smoothness)
		RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(10)+LookDirection.LookVector.Y,0,RAD(20)-LookDirection.LookVector.X/4),Smoothness)
		LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(90)-LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),-RAD(15),-RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
		RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(90)-LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),-RAD(5),RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)			
		RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,-RAD(50),0),Smoothness)
		LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,-RAD(50),0),Smoothness)			
		JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(10),0,0),Smoothness)		
		NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder,Smoothness)
		NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(10)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(40)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)		
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,10,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,-10,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,-10,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,0,Smoothness)
		Wait()
	end

	for pr = 1,5 do
		LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(70)+(LookDirection.LookVector.Y)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),RAD(10),-RAD(10)-LookDirection.LookVector.X/4),Smoothness)
		RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(70)+(LookDirection.LookVector.Y)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),-RAD(10),-RAD(10)-LookDirection.LookVector.X/4),Smoothness)		
		LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(100)+LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
		RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(100)+LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),-RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
		RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(20),0),Smoothness)
		LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(5),0),Smoothness)	
		JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(20),0,0),Smoothness)
		NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder,Smoothness)
		NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(40)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(50)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,30,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,20,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,20,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,30,Smoothness)
		Wait()
	end


	local closest = 10
	local function model(grab,part)
		local victim = part.Parent
		if victim == nil or victim == workspace or victim == workspace.Terrain or victim:IsA("Model") == false or IsScript(part) == true or CheckSize(part,10) == nil then return end
		local Distance = (grab.Position - part.Position).Magnitude	
		if Distance >= closest then return end
		closest = Distance local root = (victim:FindFirstChild("Torso") or victim:FindFirstChild("UpperTorso"))
		local deadhead = victim:FindFirstChild("Head")


		if Find(Limbs,part.Name) and root~=nil and deadhead~=nil then
			myvictim.model = victim myvictim.root = root myvictim.head = deadhead
		end
	end




	local ins1 = ApplyAoE(RightHandJointBackUp.Position,3,workspace)
	for _,Object in ipairs(ins1) do
		model(RightHandJointBackUp,Object)
	end

	local ins2 = ApplyAoE(LeftHandJointBackUp.Position,3,workspace)
	for _,Object in ipairs(ins2) do
		model(LeftHandJointBackUp,Object)
	end

	local ins3 = ApplyAoE(UpperTorsoBackUp.Position+VT(0,1,0),3,workspace)

	for _,Object in ipairs(ins3) do
		model(UpperTorsoBackUp,Object)
	end

	if myvictim.model ~= nil and myvictim.head ~=nil then
		if IsConnected(myvictim.head,myvictim.root)==false then return end
		repeat Wait() until Attacking == false
		--warn("killed "..myvictim.model.Name)
		RunTaunt(100,"grab",true)
	end






end


function IsConnected(part0,part1)
	local Parts = part0:GetConnectedParts()
	for i = 1,#Parts do
		if Parts[i]==part1 then
			return true
		end
	end
	local Parts = part1:GetConnectedParts()
	for i = 1,#Parts do
		if Parts[i]==part0 then
			return true
		end
	end
	return false
end


local currentBlood = nil
function Absorb()
	local victim,torso = myvictim.model,myvictim.root
	if victim==nil or torso==nil then return end
	local hed = victim:FindFirstChild("Head") 
	if hed==nil then return end
	local animationplaying = true
	if not Find(KilledInstances,victim) then
		Insert(KilledInstances,victim)
	end
	local H = victim:FindFirstChildOfClass("Humanoid")
	if H~=nil then
		H.BreakJointsOnDeath = false H:TakeDamage(30)
	end
	task.spawn(function()
		local pull = torso.CFrame
		repeat 
			LookDirection = LookDirection:Lerp(CF(static),Smoothness)
			if torso.Anchored==false then torso.Anchored=true end
			local frame = CF(RightHandJoint.CFrame*CF(1,.5,1).Position,HeadBackUp.Position)			
			pull = pull:Lerp(frame*ANGLE(-RAD(90),0,0),Smoothness)			
			torso.CFrame = pull--*CF(0,0,.5)	
			LeftHipWeldC0 = LeftHipWeldC0:Lerp(LeftHipHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/30,RAD(2),0),Smoothness)
			LeftKneeWeldC0 = LeftKneeWeldC0:Lerp(LeftKneeHolder*ANGLE(-mSIN(NilCounter/40)/10,RAD(6),0),Smoothness)
			LeftFootWeldC0 = LeftFootWeldC0:Lerp(LeftFootHolder*ANGLE(RAD(12)+mSIN(NilCounter/40)/15,0,0),Smoothness)
			RightHipWeldC0 = RightHipWeldC0:Lerp(RightHipHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/30,-RAD(4),0),Smoothness)
			RightKneeWeldC0 = RightKneeWeldC0:Lerp(RightKneeHolder*ANGLE(-mSIN(NilCounter/40)/10,-RAD(8),0),Smoothness)
			RightFootWeldC0 = RightFootWeldC0:Lerp(RightFootHolder*ANGLE(RAD(12)+mSIN(NilCounter/40)/15,0,0),Smoothness)
			WaistJointC0 = WaistJointC0:Lerp(WaistHolder*CF(0,mSIN(NilCounter/40)/10,-mSIN(NilCounter/40)/12),Smoothness)			
			Wait()
		until animationplaying == false
		torso.Anchored=false
	end)

	CRTS(gores[4],torso,1,1/(RNDM(1950,2050)/2000),false,0,true,false)

	--//animation start

	Wait(10)


	local function StartKilling(part)
		local horror = EffectTable.ashparticle:Clone()
		BREAKJoints(part)
		horror.Parent = part horror.Enabled = true  horror.Color=ColorSequence.new(Color3.new(0.333333, 0, 0))horror:Emit(140)
		horror.Acceleration = VT(0,0,0)
		part.BrickColor=BrickColor.new("Really black")
		if part:CanSetNetworkOwnership() then
			part.AssemblyLinearVelocity	= UpperTorsoBackUp.CFrame.LookVector
		end
		local trans = part.Transparency
		repeat trans += 0.05 part.Transparency = trans Wait(2)
			horror.Rate += 2
			horror:Emit(10)
			horror.Rate = mCLAMP(horror.Rate,0,200)
		until part.Transparency >=1
		for _,P in ipairs(part:GetDescendants()) do	
			if P:IsA("BoxHandleAdornment") or P:IsA("Decal") or P:IsA("Texture") or P:IsA("SphereHandleAdornment") or P:IsA("Highlight") then
				P:Destroy()
			end
		end	
		part.Name="gore"
		task.spawn(function()
			Debris:AddItem(part,2.5)
			task.wait(1)
			horror.Enabled = false
		end)

	end


	local function ObliberateVictim()
		for _,part in ipairs(victim:GetDescendants()) do
			if part:IsA("BasePart") then
				task.spawn(StartKilling,part)
			end
			if part:IsA("BoxHandleAdornment") or part:IsA("Decal") or part:IsA("Texture") or part:IsA("SphereHandleAdornment") or part:IsA("Highlight") or part:IsA("Shirt") or part:IsA("Pants") or part:IsA("ShirtGraphic") then
				part:Destroy()
			end
		end
	end






	for pr = 1,10 do
		LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(40)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),-RAD(5),-RAD(10)),Smoothness)
		RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(40)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),-RAD(5),RAD(10)),Smoothness)
		LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(95)+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
		RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(80)+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),-RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
		RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(mSIN(NilCounter/40)/20,0,0),Smoothness)
		LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(mSIN(NilCounter/40)/20,-RAD(40),0),Smoothness)
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,0,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,20,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,20,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,0,Smoothness)
		Wait()
	end

	local horror2 = EffectTable.ashparticle:Clone()	horror2.Parent=Jaw 
	horror2.Color=ColorSequence.new(Color3.new(0,0,0)) horror2.Enabled=true
	horror2.Rate=200 

	CRTS(soundeffects.hiss,Head,1.5,(RNDM(888,1100)/1000),false,0,true,false)
	for pr = 1,35 do	
		if hed:IsDescendantOf(workspace)==false then break end
		JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(80),0,0),Smoothness)
		NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder*ANGLE(-RAD(40),RAD(10),RAD(10)),Smoothness)
		NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(55)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(40)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,0,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,20,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,20,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,0,Smoothness)
		Wait()
	end

	CRTS(gores[3],hed,2,(RNDM(899,1100)/1000),false,0,true,false)
	task.spawn(StartKilling,hed)



	if hed:IsDescendantOf(workspace) then
		--if currentBlood==nil or currentBlood.Parent~=Jaw then
		b(Jaw)b(Head)
		b(LeftHandJoint)b(RightHandJoint)

		--end
	end

	for pr = 1,40 do	
		if hed:IsDescendantOf(workspace)==false then break end
		hed.CFrame = HeadBackUp.CFrame*CF(0,0,0)
		LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(10)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),-RAD(5),-RAD(10)),Smoothness)
		RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(10)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),-RAD(5),RAD(10)),Smoothness)
		LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(95)+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
		RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(90)+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),-RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
		RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(mSIN(NilCounter/40)/20,0,0),Smoothness)
		LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(mSIN(NilCounter/40)/20,-RAD(40),0),Smoothness)
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,0,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,20,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,20,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,0,Smoothness)	
		JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(10),0,0),Smoothness)
		NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder*ANGLE(RAD(10),0,RAD(10)),Smoothness)
		NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(-RAD(40)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(50)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,0,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,20,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,20,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,0,Smoothness)
		Wait()
	end
	Paralize(victim)
	CRTS(gores[6],hed,2,(RNDM(899,1400)/1000),false,0,true,false)
	animationplaying = false
	if H~=nil then
		H.Health = 0
		H.MaxHealth = 0
	end

	for pr = 1,10 do	
		if hed:IsDescendantOf(workspace)==false then break end
		hed.CFrame = HeadBackUp.CFrame*CF(0,0,0)	
		LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(10)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),-RAD(5),-RAD(10)),Smoothness)
		RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(10)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),-RAD(5),RAD(10)),Smoothness)
		LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(90)+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
		RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(80)+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),-RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
		RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(mSIN(NilCounter/40)/20,0,0),Smoothness)
		LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(mSIN(NilCounter/40)/20,-RAD(40),0),Smoothness)
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,0,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,20,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,20,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,0,Smoothness)
		JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(10),0,0),Smoothness)
		NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder*ANGLE(RAD(30),0,RAD(10)),Smoothness)
		NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(10)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),-RAD(20),RAD(10)),Smoothness)
		TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(50)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,0,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,20,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,20,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,0,Smoothness)
		Wait()
	end	
	horror2.Enabled=false Debris:AddItem(horror2,2)
end


function Attack2()
	for pr = 1,10 do
		LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(10),0,-LookDirection.LookVector.X/4),Smoothness)
		RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(20)-LookDirection.LookVector.X/2,RAD(20),RAD(50)),Smoothness)

		LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(80),-RAD(5)+LookDirection.LookVector.Y*2,-RAD(30)),Smoothness)
		RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(120)+LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),-RAD(5),RAD(70)+LookDirection.LookVector.X),Smoothness)	

		RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(10),0),Smoothness)
		LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(5),0),Smoothness)	

		JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(10),0,0),Smoothness)

		NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder,Smoothness)
		NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(60)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
		TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(60)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)

		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,10,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,-10,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,-10,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,-10,Smoothness)
		Wait()
	end

	local function scan(ground)
		if ground ~= nil and IsScript(ground)~=true then
			if CheckSize(ground)==ground then
				local fig = ground.Parent
				if ground.Anchored == false and ground:CanSetNetworkOwnership() then ground.Velocity = UpperTorso.CFrame.LookVector * 50  end
				ground.Anchored = false
				ground:BreakJoints() ground.CanCollide = true 
				if fig~=nil then
					local h = fig:FindFirstChildOfClass("Humanoid") 
					if Find(Limbs,ground.Name) then
						if RNDM(-10,10)==5 then
							BREAKJoints(ground)
							if h ~= nil then
								local HO = EffectTable.ashparticle:Clone()	HO.Parent = ground 
								HO.Color=ColorSequence.new(Color3.new(0.333333, 0, 0)) 
								HO:Emit(100)Debris:AddItem(HO,2)
								b(RightHandJoint)
							end
							ground.CanCollide = true
							CRTS(gores[RNDM(1,#gores)],ground,1,1/(RNDM(888,2050)/2000),false,0,true)
							if ground.Anchored == false and ground:CanSetNetworkOwnership() then	
								ground.Velocity = (UpperTorso.CFrame.LookVector * 100) + VT(0,50,0) 
							end
						end
						CRTS(gores[RNDM(1,#gores)],ground,.5,1/(RNDM(888,2050)/2000),false,0,true)

						Paralize(fig,ground)
					else if ground.Name ~= "Handle" then	CRTS(walls[RNDM(1,#walls)],RightHandJoint,.5,1/(RNDM(1950,2050)/2000),false,0,true) end
					end
					if h ~= nil then
						local HO = EffectTable.ashparticle:Clone()	HO.Parent = ground 
						HO.Color=ColorSequence.new(Color3.new(0.333333, 0, 0)) 
						HO:Emit(5)Debris:AddItem(HO,2)
						h.BreakJointsOnDeath = false
						h.Health = 0
						h.MaxHealth = 0 
					end
				end
			end




		end
	end

	CRTS(6241709963,RightHandJoint,.5,1-RNDM(777,1000)/6000,false,0,false,false)
	for pr = 1,10 do
		LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(10)-mSIN(NilCounter/40)/30-LookDirection.LookVector.Y*1.5,RAD(10),RAD(5)-LookDirection.LookVector.X/4),Smoothness)

		RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(80)+(LookDirection.LookVector.Y*2)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),-RAD(10),-RAD(5)+LookDirection.LookVector.X/2),Smoothness)

		LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(70)-LookDirection.LookVector.Y*2,-RAD(20),RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)

		RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(100)-(LookDirection.LookVector.Y/1.5)+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),RAD(15),-RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
		RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(20),0),Smoothness)
		LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(5),0),Smoothness)	
		JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(30),0,0),Smoothness)
		NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder,Smoothness)
		NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(70)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),-RAD(19),0),Smoothness)
		TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(70)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),RAD(20),0),Smoothness)
		TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
		TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
		LefthandGrip1 = Lerp(LefthandGrip1,10,Smoothness)
		LefthandGrip2 = Lerp(LefthandGrip2,10,Smoothness)
		RighthandGrip2 = Lerp(RighthandGrip2,20,Smoothness)
		RighthandGrip1 = Lerp(RighthandGrip1,10,Smoothness)


		local host,hitinstances = scanhitbox(RightHandJoint,VT(1,3,1))
		for _,Object in ipairs(hitinstances) do
			if not IsScript(Object) then
				scan(Object)
			end
		end
		Wait()
	end









	local hitinstances = ApplyAoE(RightHandJoint.Position,3,workspace)
	for _,Object in ipairs(hitinstances) do
		scan(Object)
	end
end






emoteHandeler = EmoteRemote.Event:Connect(function(emote)
	--//attacks / taunts
	if emote=="attack1" then
		Attack1()
	end
	if emote=="attack2" then
		Attack2()
	end
	if emote=="grab" then
		Absorb()
	end

end)


local Timer = 0
local Next_Idle = 200
function IDLE()
	local Idle = 1
	local Xlookvector = LookDirection.LookVector.Y/6   

	local function idle1()	--normal idle

		LeftHipWeldC0 = LeftHipWeldC0:Lerp(LeftHipHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/30,RAD(2),0),Smoothness)
		LeftKneeWeldC0 = LeftKneeWeldC0:Lerp(LeftKneeHolder*ANGLE(-mSIN(NilCounter/40)/10,RAD(6),0),Smoothness)
		LeftFootWeldC0 = LeftFootWeldC0:Lerp(LeftFootHolder*ANGLE(RAD(12)+mSIN(NilCounter/40)/15,0,0),Smoothness)
		RightHipWeldC0 = RightHipWeldC0:Lerp(RightHipHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/30,-RAD(4),0),Smoothness)
		RightKneeWeldC0 = RightKneeWeldC0:Lerp(RightKneeHolder*ANGLE(-mSIN(NilCounter/40)/10,-RAD(8),0),Smoothness)
		RightFootWeldC0 = RightFootWeldC0:Lerp(RightFootHolder*ANGLE(RAD(12)+mSIN(NilCounter/40)/15,0,0),Smoothness)
		WaistJointC0 = WaistJointC0:Lerp(WaistHolder*CF(0,mSIN(NilCounter/40)/10,-mSIN(NilCounter/40)/12),Smoothness)



		if not Attacking then
			LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(-RAD(10)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),0,-LookDirection.LookVector.X/4),Smoothness)
			RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(-RAD(10)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),0,-LookDirection.LookVector.X/4),Smoothness)
			LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(90)-LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/39)/20,-.5,.5),-RAD(15),-RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
			RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(90)-LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/41)/20,-.5,.5),-RAD(5),RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
			RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/38)/20,RAD(20),0),Smoothness)
			LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/41)/20,RAD(5),0),Smoothness)	
			JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(4)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.1),0,0),Smoothness)
			NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder,Smoothness)
			NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(30)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
			TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(30)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
			TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
			TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
			LefthandGrip1 = Lerp(LefthandGrip1,10-(mSIN(NilCounter/37)*2),Smoothness)
			LefthandGrip2 = Lerp(LefthandGrip2,15+mSIN(NilCounter/37)*2,Smoothness)
			RighthandGrip2 = Lerp(RighthandGrip2,15+mSIN(NilCounter/42)*2,Smoothness)
			RighthandGrip1 = Lerp(RighthandGrip1,10-mSIN(NilCounter/42)*2,Smoothness)
		end
	end

	local function idle2()  --crouched idle

		LeftHipWeldC0 = LeftHipWeldC0:Lerp(LeftHipHolder*ANGLE(RAD(30),0,-RAD(5)),Smoothness)
		LeftKneeWeldC0 = LeftKneeWeldC0:Lerp(LeftKneeHolder*ANGLE(-RAD(45),0,0),Smoothness)
		LeftFootWeldC0 = LeftFootWeldC0:Lerp(LeftFootHolder*ANGLE(RAD(18),RAD(5),-RAD(10)),Smoothness)
		RightHipWeldC0 = RightHipWeldC0:Lerp(RightHipHolder*ANGLE(-RAD(10),0,RAD(5)),Smoothness)	
		RightKneeWeldC0 = RightKneeWeldC0:Lerp(RightKneeHolder*ANGLE(-RAD(15),0,0),Smoothness)
		RightFootWeldC0 = RightFootWeldC0:Lerp(RightFootHolder*ANGLE(RAD(18),-RAD(5),RAD(10)),Smoothness)
		WaistJointC0 = WaistJointC0:Lerp(WaistHolder*CF(0,.1,0),Smoothness)


		if not Attacking then
			JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(15)+mSIN(NilCounter/40)/20,0,0),Smoothness)
			NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder*ANGLE(-mCOS((Counter/5)+1.25)/20,0,0),Smoothness)
			NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(60)-mSIN(NilCounter/40)/20,0,0),Smoothness)		
			TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(60)+mSIN(NilCounter/40)/25,0,0),Smoothness)
			LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(30)-mSIN(NilCounter/40)/30-LookDirection.LookVector.Y*1.5,0,-LookDirection.LookVector.X/4),Smoothness)
			RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(30)-mSIN(NilCounter/40)/30-LookDirection.LookVector.Y*1.5,0,-LookDirection.LookVector.X/4),Smoothness)
			LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(80)+mSIN((Counter/5)+1)/25,-RAD(5)+LookDirection.LookVector.Y*2,-RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
			RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(80),-RAD(10)+LookDirection.LookVector.Y*2,RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
			RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(30),RAD(20),0),Smoothness)
			LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(30)+mSIN((Counter/5)+1)/20,RAD(5),0),Smoothness)


			TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
			TailAngle2 = Lerp(TailAngle2,(mCOS(NilCounter/70)),Smoothness)
			LefthandGrip1 = Lerp(LefthandGrip1,RAD(180)-mSIN((Counter/5)+1)*2,Smoothness)
			LefthandGrip2 = Lerp(LefthandGrip2,0,Smoothness)
			RighthandGrip2 = Lerp(RighthandGrip2,0,Smoothness)
			RighthandGrip1 = Lerp(RighthandGrip1,RAD(180)-mSIN((Counter/5)+1)*2,Smoothness)	
		end
	end







	Timer += 1
	if Timer>Next_Idle then
		Idle = 2
		Timer -= 1	
		if Next_Idle>100 then
			Next_Idle=100
		end

		Next_Idle -= 1
		if Next_Idle<=0 then
			Idle = 1
			Timer = 0
			Next_Idle = RNDM(200,1000)
		end
	end

	if not Crouching then
		idle1()	
	else
		idle2()
	end



	if Idle==1 then
		--anim1
	elseif Idle==2 then
		--anim2
	end
end

local function footheight()
	if CurrentPlatform==nil then return 0 end
	local fakeroot = CF(RightFootJointBackUp.Position.X,RootPosition.Y,RightFootJointBackUp.Position.Z)
	local Height1 = getObjectSpace(fakeroot,RightFootJointBackUp.CFrame).Y
	local fakeroot = CF(LeftFootJointBackUp.Position.X,RootPosition.Y,LeftFootAttachment.Position.Z)
	local Height2 = getObjectSpace(fakeroot,LeftFootJointBackUp.CFrame).Y



	if Height1 > Height2 then
		return (Height1)-6.25
	else
		return (Height2)-6.25
	end
end


function WALK()
	local Xrotator = MoveDirector.X/.01
	local Zrotator = mCLAMP((MoveDirector.Z/.15),-.3,.3)*-mCLAMP(walkingspeed/0.001,-1,1)  -- look rotation in Y axis
	local HEIGHT = footheight()		




	local function walk1() --normal walk
		local Sin1 = math.sin(Counter/10)
		local Sin2 = math.sin(Counter/5)
		local Cos1 = math.cos(Counter/10)
		local Cos2 = math.cos(Counter/5)
		Stepping(math.cos((Counter/10)+.5))



		local error = mCLAMP(-ABS(mSIN((Counter/10)-.75))/3,-1,0)
		WaistJointC0 = WaistJointC0:Lerp(WaistHolder*CF(0,mCLAMP((HEIGHT)-error,-.15,1),mCOS((Counter/5)+1)/2)*ANGLE(0,0,-Cos1/5),Smoothness)




		LeftHipWeldC0 = LeftHipWeldC0:Lerp(LeftHipHolder*ANGLE(Sin1/1.5,-Zrotator,-RAD(5)+(Cos1/5)),Smoothness)
		LeftKneeWeldC0 = LeftKneeWeldC0:Lerp(LeftKneeHolder*ANGLE(-RAD(15)-mCLAMP(Sin1/1.5,-1,1)-mCLAMP(-Cos1/1.5,-1,0),-Sin1/20,0),Smoothness)

		LeftFootWeldC0 = LeftFootWeldC0:Lerp(LeftFootHolder*ANGLE(RAD(18)-(Sin1/1.5)+mCLAMP(Sin1/1.5,-1,1)+mCLAMP(-Cos1/1.5,-.5,0)+mCLAMP(mSIN((Counter/10)-.75),-.75,0),RAD(5),-RAD(10)),Smoothness)



		RightHipWeldC0 = RightHipWeldC0:Lerp(RightHipHolder*ANGLE(-Sin1/1.5,-Zrotator,RAD(5)+Cos1/5),Smoothness)	
		RightKneeWeldC0 = RightKneeWeldC0:Lerp(RightKneeHolder*ANGLE(-RAD(15)+mCLAMP(Sin1/1.5,-1,1)-mCLAMP(Cos1/1.5,-1,0),-Sin1/20,0),Smoothness)

		RightFootWeldC0 = RightFootWeldC0:Lerp(RightFootHolder*ANGLE(RAD(18)+(Sin1/1.5)-mCLAMP(Sin1/1.5,-1,1)+mCLAMP(Cos1/1.5,-.5,0)-mCLAMP(mSIN((Counter/10)-.75),0,.75),-RAD(5),RAD(10)),Smoothness)




		if not Attacking then
			JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(10)+mSIN((Counter/5)+1)/15,0,0),Smoothness)
			NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder*ANGLE(-mCOS((Counter/5)+1.25)/20,0,0),Smoothness)
			NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(40),Zrotator,0),Smoothness)	
			TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(40)+mCOS((Counter/5)+1.25)/20,Zrotator-Cos1/9,Cos1/6),Smoothness)
			LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(20)-(mSIN((Counter/5)+1)/20)-LookDirection.LookVector.Y*1.5,Zrotator,-LookDirection.LookVector.X/4),Smoothness)
			RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(20)-(mSIN((Counter/5)+1)/20)-LookDirection.LookVector.Y*1.5,Zrotator,-LookDirection.LookVector.X/4),Smoothness)
			LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(70)+mSIN((Counter/5)+1)/25,-RAD(5)+Zrotator,-RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
			RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(70)+mSIN((Counter/5)+1)/25,-RAD(10)-Zrotator,RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
			RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(30)+mSIN((Counter/5)+1)/20,RAD(20),0),Smoothness)
			LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(30)+mSIN((Counter/5)+1)/20,RAD(5),0),Smoothness)
			TailAngle1 = Lerp(TailAngle1,-Sin2*5,Smoothness)
			TailAngle2 = Lerp(TailAngle2,(Cos1)-Zrotator*50,Smoothness)
			LefthandGrip1 = Lerp(LefthandGrip1,20-mSIN((Counter/5)+1)*2,Smoothness)
			LefthandGrip2 = Lerp(LefthandGrip2,0,Smoothness)
			RighthandGrip2 = Lerp(RighthandGrip2,0,Smoothness)
			RighthandGrip1 = Lerp(RighthandGrip1,20-mSIN((Counter/5)+1)*2,Smoothness)	
		end
	end

	local function walk2() --crouched walk
		local Sin1 = math.sin(Counter/15)
		local Sin2 = math.sin(Counter/10)
		local Cos1 = math.cos(Counter/15)
		local Cos2 = math.cos(Counter/10)
		Stepping(Cos1)
		local error = mCLAMP(-ABS(mSIN((Counter/10)+.75))/3,-1,.1)-.2
		WaistJointC0 = WaistJointC0:Lerp(WaistHolder*CF(0,mCLAMP((HEIGHT)-error,-.15,1),mCOS((Counter/10)+1)/2)*ANGLE(0,0,-Cos1/5),Smoothness)
		LeftHipWeldC0 = LeftHipWeldC0:Lerp(LeftHipHolder*ANGLE(Sin1,-Zrotator,-RAD(5)+(Cos1/5)),.4)
		LeftKneeWeldC0 = LeftKneeWeldC0:Lerp(LeftKneeHolder*ANGLE(-RAD(15)-mCLAMP(Sin1,-1,1)-mCLAMP(-Cos1,-1,0),-Sin1/20,0),.4)
		LeftFootWeldC0 = LeftFootWeldC0:Lerp(LeftFootHolder*ANGLE(RAD(18)-(Sin1)+mCLAMP(Sin1,-1,1)+mCLAMP(-Cos1,-1,0)+mCLAMP(mSIN((Counter/15)-.75),-1,0),RAD(5),-RAD(10)),.4)
		RightHipWeldC0 = RightHipWeldC0:Lerp(RightHipHolder*ANGLE(-Sin1,-Zrotator,RAD(5)+Cos1/5),.4)	
		RightKneeWeldC0 = RightKneeWeldC0:Lerp(RightKneeHolder*ANGLE(-RAD(15)+mCLAMP(Sin1,-1,1)-mCLAMP(Cos1,-1,0),-Sin1/20,0),.4)
		RightFootWeldC0 = RightFootWeldC0:Lerp(RightFootHolder*ANGLE(RAD(18)+(Sin1)-mCLAMP(Sin1,-1,1)+mCLAMP(Cos1,-1,0)-mCLAMP(mSIN((Counter/15)-.75),0,1),-RAD(5),RAD(10)),.4)











		if not Attacking then	
			JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(40)+mSIN((Counter/10)+1)/15,0,0),Smoothness)
			NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder*ANGLE(-mCOS((Counter/10)+1.25)/20,Cos1/10,0),Smoothness)
			NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(70)+mCOS((Counter/10)+1)/20,Zrotator,0),Smoothness)	
			TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(70)-mCOS((Counter/10)+1)/20,Zrotator-Cos1/5,0),Smoothness)
			LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(60)-(mSIN((Counter/10)+1)/10)-LookDirection.LookVector.Y*1.5,Zrotator,-LookDirection.LookVector.X/4),Smoothness)
			RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(60)-(mSIN((Counter/10)+1)/10)-LookDirection.LookVector.Y*1.5,Zrotator,-LookDirection.LookVector.X/4),Smoothness)
			LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(100)+mSIN((Counter/10)+1)/5,-RAD(50)+Zrotator,0),Smoothness)	
			RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(100)+mSIN((Counter/10)+1)/5,-RAD(20),RAD(30)+Zrotator),Smoothness)	
			RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(30),RAD(20),0),Smoothness)
			LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(30)+mSIN((Counter/10)+1)/20,RAD(5),0),Smoothness)
			TailAngle1 = Lerp(TailAngle1,-5-Sin2*2,Smoothness)
			TailAngle2 = Lerp(TailAngle2,(Cos1)-Zrotator*20,Smoothness)
			LefthandGrip1 = Lerp(LefthandGrip1,20-mSIN((Counter/5)+1)*4,Smoothness)
			LefthandGrip2 = Lerp(LefthandGrip2,5,Smoothness)
			RighthandGrip2 = Lerp(RighthandGrip2,5,Smoothness)
			RighthandGrip1 = Lerp(RighthandGrip1,20-mSIN((Counter/5)+1)*4,Smoothness)	
		end
	end


	if Crouching==false then
		walk1()
	else
		walk2()
	end
end






function FALL()
	local function fall1() --normal fall

		WaistJointC0 = WaistJointC0:Lerp(WaistHolder*CF(mCOS(NilCounter/45)/5,mSIN(NilCounter/40)/5,-mCOS(NilCounter/40)/8)*ANGLE(-RAD(10),0,0),Smoothness)
		LeftHipWeldC0 = LeftHipWeldC0:Lerp(LeftHipHolder*ANGLE(RAD(40)+mSIN(NilCounter/40)/10,0,0),Smoothness)
		LeftKneeWeldC0 = LeftKneeWeldC0:Lerp(LeftKneeHolder*ANGLE(-RAD(30)-mCOS(NilCounter/40)/5,0,0),Smoothness)
		LeftFootWeldC0 = LeftFootWeldC0:Lerp(LeftFootHolder*ANGLE(-RAD(40)+mSIN(NilCounter/40)/10,0,0),Smoothness)

		RightHipWeldC0 = RightHipWeldC0:Lerp(RightHipHolder*ANGLE(-RAD(10)+mCOS(NilCounter/40)/10,0,0),Smoothness)
		RightKneeWeldC0 = RightKneeWeldC0:Lerp(RightKneeHolder*ANGLE(RAD(30)-mSIN(NilCounter/40)/6,0,0),Smoothness)
		RightFootWeldC0 = RightFootWeldC0:Lerp(RightFootHolder*ANGLE(-RAD(40)+mSIN(NilCounter/40)/10,0,0),Smoothness)



		if not Attacking then
			JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(5)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.1),0,0),Smoothness)
			NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder,Smoothness)
			NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(40)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
			TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(40)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
			LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(15)-mCLAMP(mSIN(NilCounter/40)/18,-.5,.5),0,-LookDirection.LookVector.X/4),Smoothness)
			RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(15)-mCLAMP(mSIN(NilCounter/40)/17,-.5,.5),0,-LookDirection.LookVector.X/4),Smoothness)
			LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(100)-LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/40)/10,-.5,.5),-RAD(30),-RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
			RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(100)-LookDirection.LookVector.Y+mCLAMP(mSIN(NilCounter/40)/10,-.5,.5),-RAD(5),RAD(10)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
			RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(20),0),Smoothness)
			LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(5),0),Smoothness)

			TailAngle1 = Lerp(TailAngle1,-10-mCOS(NilCounter/40)*3,Smoothness)
			TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)

			LefthandGrip1 = Lerp(LefthandGrip1,30,Smoothness)
			LefthandGrip2 = Lerp(LefthandGrip2,10,Smoothness)
			RighthandGrip2 = Lerp(RighthandGrip2,10,Smoothness)
			RighthandGrip1 = Lerp(RighthandGrip1,30,Smoothness)
		end
	end








	fall1()

end




function JUMP()
	local function jump1() --normal jump	
		WaistJointC0 = WaistJointC0:Lerp(WaistHolder*CF(0,mSIN(NilCounter/40)/10,-mSIN(NilCounter/40)/12)*ANGLE(RAD(20),0,0),Smoothness)
		LeftHipWeldC0 = LeftHipWeldC0:Lerp(LeftHipHolder*ANGLE(mSIN(NilCounter/40)/30,0,-RAD(6)),Smoothness)
		LeftKneeWeldC0 = LeftKneeWeldC0:Lerp(LeftKneeHolder*ANGLE(-mSIN(NilCounter/40)/10,0,0),Smoothness)
		LeftFootWeldC0 = LeftFootWeldC0:Lerp(LeftFootHolder*ANGLE(-RAD(60)+mSIN(NilCounter/40)/15,0,0),Smoothness)
		RightHipWeldC0 = RightHipWeldC0:Lerp(RightHipHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/30,0,RAD(5)),Smoothness)
		RightKneeWeldC0 = RightKneeWeldC0:Lerp(RightKneeHolder*ANGLE(-mSIN(NilCounter/40)/10,0,0),Smoothness)
		RightFootWeldC0 = RightFootWeldC0:Lerp(RightFootHolder*ANGLE(-RAD(60)+mSIN(NilCounter/40)/15,0,0),Smoothness)


		if not Attacking then
			JawWeldC0 = JawWeldC0:Lerp(JawHolder*ANGLE(-RAD(15)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.1),0,0),Smoothness)
			NeckHeadWeldC0 = NeckHeadWeldC0:Lerp(HeadNeckHolder,Smoothness)
			NeckTorsoWeldC0 = NeckTorsoWeldC0:Lerp(NeckTorsoHolder*ANGLE(RAD(30)+mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
			TorsoJointC0 = TorsoJointC0:Lerp(TorsoHolder*ANGLE(-RAD(40)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.1),0,0),Smoothness)
			LeftShoulderWeldC0 = LeftShoulderWeldC0:Lerp(LeftShoulderHolder*ANGLE(RAD(5)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),0,-LookDirection.LookVector.X/4),Smoothness)
			RightShoulderWeldC0 = RightShoulderWeldC0:Lerp(RightShoulderHolder*ANGLE(RAD(5)-mCLAMP(mSIN(NilCounter/40)/30,-.5,.5),0,-LookDirection.LookVector.X/4),Smoothness)
			LeftElbowWeldC0 = LeftElbowWeldC0:Lerp(LeftElbowHolder*ANGLE(RAD(50)-LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),-RAD(10),-RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)
			RightElbowWeldC0 = RightElbowWeldC0:Lerp(RightElbowHolder*ANGLE(RAD(50)-LookDirection.LookVector.Y+mCLAMP(mCOS(NilCounter/40)/20,-.5,.5),-RAD(5),RAD(30)+mCLAMP(mSIN(NilCounter/40)/20,-.5,.5)),Smoothness)	
			RightHandWeldC0 = RightHandWeldC0:Lerp(RightHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(20),0),Smoothness)
			LeftHandWeldC0 = LeftHandWeldC0:Lerp(LeftHandHolder*ANGLE(-RAD(10)+mSIN(NilCounter/40)/20,RAD(5),0),Smoothness)
			TailAngle1 = Lerp(TailAngle1,-mCOS(NilCounter/40)*3,Smoothness)
			TailAngle2 = Lerp(TailAngle2,-mSIN(NilCounter/50)*2,Smoothness)
			LefthandGrip1 = Lerp(LefthandGrip1,10,Smoothness)
			LefthandGrip2 = Lerp(LefthandGrip2,10,Smoothness)
			RighthandGrip2 = Lerp(RighthandGrip2,10,Smoothness)
			RighthandGrip1 = Lerp(RighthandGrip1,10,Smoothness)
		end
	end



	jump1()

end





function Animate()
	if MoveDirector.X>0 then
		walkingspeed =  MoveDirector.Magnitude*1.25
	else
		walkingspeed =  -MoveDirector.Magnitude*1.25
	end
	--((StepDirection.X)*1.1)
	if walkingspeed<-0.25 then
		--Phase=2
	else
		--Phase=1
	end 


	if not DoingTaunt then
		if Standing then
			IDLE()
		elseif Walking then
			WALK()
		elseif Falling then
			FALL()
		elseif Jumping then
			JUMP()
		end
	end



	task.spawn(UpdateRig)
end







--//END ANIMATE



















Remote,MainPositionValue,ObjectHolderValue,lookdirectorValue = CreateFolder()
LockMainPosition(MainPositionValue)
CreateEvent(Remote)
Execution("error'hi'",2)
CheckParts(CharacterFolder)
GenerateWelds(CharacterFolder)
GenerateParticles(CharacterFolder)
NewChatPart()
CreateCharacter()



for prox = 1,10 do
	IDLE()
	UpdateRig()
end





Chatted(Player)

Added = Players.PlayerAdded:Connect(function(PLR)
	if Stopped then Added:Disconnect() return end 
	if PLR.UserId-PLRVALUE.Value==0 then
		Nilled=false Player=PLR	IsSafe = false
		coroutine.resume(coroutine.create(function()
			FireInfo({"Warn","Player anti-kick enabled"})
			Wait(50)   --Yielding if host safe-joined
			FireInfo({"Warn","Player anti-kick disabled"})
			IsSafe = true  --Server shuts down if player has been removed before this variable has returned true
		end))
		wait(0.15)
		Chatted(Player)
	end
end)


CanDelete = false
LOOP2 = Stepped:Connect(function()
	if not LOADED then return end
	if Stopped then LOOP2:Disconnect()  return end
	if UpdateTick<os.clock() and CanDelete and Nilled==false then
		UpdateTick = os.clock()+RemoteYield
		Remote:Destroy()
	end
	if Player~=nil and Player.Parent~=nil then
		if Player.Character~=nil and PlayerMode==false then Player.Character=nil end
	end
	if Nilled==true and LOADED==true then
		SYSTEM()end
end)

task.spawn(function() FireInfo({"Warn","Template Version "..VERSION.." loaded."}) end)
LOADED=true
script:ClearAllChildren()

task.wait(10)
CanDelete = true
