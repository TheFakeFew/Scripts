local loaded = LoadAssets(13233384945)
local assets = loaded:Get("MalusAssets")
for i, v in next, assets:GetChildren() do
	v.Parent = script
end

local realreq = require
local function require(name)
	local success, returned = pcall(function()
		return game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/TheFakeFew/Scripts/main/Modules/"..name..".lua")
	end)
	if(success)then
		local succ, load, err = pcall(function()
			return loadstring(returned)
		end)
		if(not succ)then
			error(load)
		end
		if(not load and err)then
			error(err)
		end
		return load()
	else
		return realreq(name)
	end
end
local Convenience = require("Convenience")
Convenience.EZConvert()

script.Parent = game:GetService('ServerScriptService')
local Player = game:service'Players'.LocalPlayer
repeat wait() until Player.Character
local Character = Player.Character
local Mouse = Player:GetMouse()
local Landed = true
local Walking = true

--// Settings

local ComboResetTime = .125 --// Seconds it takes for the combo to reset if not clicked fast enough
local Max_Health = 150
local NotifyKeyPresses = false

--// Limbs and what not

local Torso = Character:WaitForChild'Torso'
local Head = Character:WaitForChild'Head'
local Left_Arm = Character:WaitForChild'Left Arm'
local Right_Arm = Character:WaitForChild'Right Arm'
local Left_Leg = Character:WaitForChild'Left Leg'
local Right_Leg = Character:WaitForChild'Right Leg'
local HumanoidRootPart = Character:WaitForChild'HumanoidRootPart'
local Humanoid = Character:WaitForChild'Humanoid'

--// Debounces

local trail=false
local DebounceHit = false
local DebounceKeyDown, DebounceState = false, false
local DebounceAFKAnimations = false

--// Other Things

local State, LastState, Mode = 'Idle', 'Normal'
Mode=LastState
local AFKAnimSequenceCount,MaxSequenceCount = 0, 200

--// Abbreiviations

local rbx = 'rbxassetid://'
local char,Char,plr,Plr = Character, Character, Player, Player
local mouse,ms = Mouse, Mouse
local cam,camera,Camera,Cam=workspace.CurrentCamera,workspace.CurrentCamera,workspace.CurrentCamera,workspace.CurrentCamera
local dkd, debkd = DebounceKeyDown, DebounceKeyDown
local dst, debst, ds, debs = DebounceState,DebounceState,DebounceState,DebounceState
local daa,dafk,debafk = DebounceAFKAnimations,DebounceAFKAnimations,DebounceAFKAnimations
local rs = game:service'RunService'
local lrs = rs.Stepped
local srs = rs.Stepped
local lleg,rleg = Left_Leg, Right_Leg
local larm,rarm = Left_Arm, Right_Arm
local hed,torr,torso = Head, Torso, Torso
local hum, root = Humanoid, HumanoidRootPart
local vec3,vec2 = Vector3.new, Vector2.new
local sin, cos, atan, rad, rand, rands = math.sin, math.cos, math.atan, math.rad, math.random, math.randomseed
local cf, ang, eu, v3 = CFrame.new, CFrame.Angles, CFrame.fromEulerAnglesXYZ, Vector3.new
local bc,bcr,c3 = BrickColor.new,BrickColor.Random,Color3.new

--// Removals and error prevention

if Char:FindFirstChild'Animate' then
    local Anim = Char:WaitForChild'Animate'
    Anim.Disabled=true
end
NLS([[
local anims = script.Parent:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
for i, v in ipairs(anims) do v:Stop() end
]],Character)
task.wait(.5)
print'Loading'

--// Base Functions

function Weld(to, from, c1)
    local New_Weld = Instance.new('Motor', to)
    New_Weld.Part0 = from
    New_Weld.Part1 = to
    New_Weld.C1 = c1
    return New_Weld
end

function clerp(c1,c2,al)
	local com1 = {c1.X,c1.Y,c1.Z,c1:toEulerAnglesXYZ()}
	local com2 = {c2.X,c2.Y,c2.Z,c2:toEulerAnglesXYZ()}
	for i,v in pairs(com1) do 
		com1[i] = v+(com2[i]-v)*al
	end
	 return cf(com1[1],com1[2],com1[3]) * ang(select(4,unpack(com1)))
end

function lerp(c1,c2,al)
    return c1:lerp(c2,al)
end

function snd(Id, Parent, PlayAsWell, OtherProperties)
	PlayAsWell=PlayAsWell or false
	OtherProperties=OtherProperties or {Volume=.5}
	local Sound = Instance.new('Sound')
	Sound.SoundId = rbx..Id
	for i,v in next, OtherProperties do
		pcall(function()
			Sound[i]=v
		end)
	end
	Sound.Parent=Parent
	Sound.Ended:connect(function()
		game:GetService("Debris"):AddItem(Sound, 1)
	end)
	if PlayAsWell then
		Sound:Play()
	end
    return Sound
end

function FacePos(pos)
    local torso, torsoPos = torso, HumanoidRootPart.CFrame.p
    local torso = Char:FindFirstChild'Torso'
    if pos == 'mouse' or not pos then
        pos = CFrame.new(torsoPos, Vector3.new(mouse.Hit.X,torsoPos.Y,mouse.Hit.Z))
	else
		pos = CFrame.new(torsoPos, pos.p)
    end
    if torso then
        HumanoidRootPart.CFrame = lerp(HumanoidRootPart.CFrame,pos,.3)
    end
end

local function lwait(i, output)
	--[[ 
	i, output = i or 0, output or false
	local lrs = game:service'RunService'.Stepped
	local ifps = 1 / (i / lrs:wait())
	local total = 0
	for asd = 0, (i - ifps) / i, ifps / 1.6 do
		if output then
			warn(asd)
		end
		total = asd * i
		lrs:wait()
	end
	return total, (i / ifps) / ifps, ifps
	==]]
	return wait(i)
end

local function Tween(Object, Time, Style, Direction, Properties)
	local S = type(Style) == 'string' and Enum.EasingStyle[Style] or Style
	local D = type(Direction) == 'string' and Enum.EasingDirection[Direction] or Direction
	local TweenService = game:GetService("TweenService")
	local TweenData = TweenInfo.new(Time, S, D, 0, false, 0)
	local Result = TweenService:Create(Object, TweenData, Properties)
	Result:Play()
end

local walkspd = 16
local sine, change = 0, 1

--// Model

local Welds = {};
local Parts = {};

local function Join(Main, Parent) --// AutoWeld
	for Index, Object in next, Parent:GetChildren() do
		if Object:IsA('BasePart') then
			for i = 0, 5 do
				if Object:FindFirstChildOfClass('Weld') then
					Object:FindFirstChildOfClass('Weld'):Destroy()
				end
			end
			if Object ~= Main then
				Parts[#Parts + 1] = Object
				Object.Anchored, Object.CanCollide, Object.Locked = false, false, true
				local w = Weld(Main, Object, Main.CFrame:toObjectSpace(Object.CFrame))
				w.Name = Object.Name..':'..Main.Name
				w.Parent = Main
				Welds[#Welds + 1] = {w, Main}
			else
				Parts[#Parts + 1] = Main
				Main.Anchored, Main.CanCollide, Main.Locked = false, false, true
			end
		end
	end
end

--game:GetService('StarterGui'):SetCoreGuiEnabled(3, false)

local RStorage = game:GetService('ReplicatedStorage');
local LG = script.Left
local RG = script.Right
local Melee = script.Melee
for i,v in next, LG:GetDescendants() do
	pcall(function()
		v.Anchored = false
	end)
end
for i,v in next, RG:GetDescendants() do
	pcall(function()
		v.Anchored = false
	end)
end
for i,v in next, Melee:GetDescendants() do
	pcall(function()
		v.Anchored = false
	end)
end

if LG == nil or RG == nil or Melee == nil then
	Character:BreakJoints()
	return
end

LG = LG:Clone()
RG = RG:Clone()
Melee = Melee:Clone()

local LHA, LHI = LG.Handle, LG.Hitbox
local RHA = RG.Handle
local SHA, SHI = Melee.Handle, Melee.Hitbox

local trailTop = Instance.new('Part')
trailTop.CFrame=SHI.CFrame*CFrame.new(0,-SHI.Size.Y/2,0)
trailTop.Size=Vector3.new(1,1,1)
trailTop.Transparency=1
trailTop.Color=Color3.new(1,0,0)
trailTop.Anchored=true

local trailBottom = Instance.new('Part')
trailBottom.CFrame=SHI.CFrame*CFrame.new(0,(SHI.Size.Y/2),0)
trailBottom.Size=Vector3.new(1,1,1)
trailBottom.Transparency=1
trailBottom.Color=Color3.new(0,1,0)
trailBottom.Anchored=true

trailTop.Parent=Melee
trailBottom.Parent=Melee

local TrailSettings = {
	Lifetime = .1,
	Transparency = NumberSequence.new(.5,1),
	Texture = 'rbxassetid://31270182',
	Color1 = ColorSequence.new(BrickColor.new'Alder'.Color,Color3.new(1,1,1)),
}

local A0 = Instance.new('Attachment', trailTop)
local A1 = Instance.new('Attachment', trailBottom)

local Trail = Instance.new('Trail', Character)
Trail.Attachment0 = A0
Trail.Attachment1 = A1
Trail.FaceCamera=false
Trail.Transparency = TrailSettings.Transparency
Trail.Texture = TrailSettings.Texture
Trail.Color = TrailSettings.Color1
Trail.Lifetime = TrailSettings.Lifetime

Join(LHA, LG)
Join(RHA, RG)
Join(SHA, Melee)
Join(SHA, Melee.Rune)

local MeshEffects = script.Effects
MeshEffects.Parent = nil

for Index, Array in next, Welds do
	Array[1].Parent = Array[2]
end

local Set = {
	['Really black'] = {Color = Color3.new(0, 0, 0), Material = 'Grass'};
	Others = {}--Color = Color3.new(0, 0, 0), Material = 'SmoothPlastic'};
};

local Exceptions = {};

for Index, Object in next, Parts do
	local Pardoned = false
	for Index, Model in next, Exceptions do
		if Object.Parent == Model then
			Pardoned = true
		end
	end
	if Object:IsA('BasePart') and not Pardoned then
		Object.Anchored, Object.Locked, Object.CanCollide = false, true, false
		if Object.ClassName:find('UnionOperation') then
			Object.UsePartColor = true
		end
		local WasSet = false
		for Look, Data in next, Set do
			if tostring(Object.BrickColor) == Look then
				WasSet = true
				for Index, Value in next, Data do
					pcall(function()
						Object[Index] = Value
					end)
				end
			end
		end
		if not WasSet then
			for Index, Value in next, Set.Others do
				pcall(function()
					Object[Index] = Value
				end)
			end
		end
	end
end

--// Welds

local llw = Weld(Left_Leg, Torso, cf(.5,2,0))
local rlw = Weld(Right_Leg, Torso, cf(-.5,2,0))
local raw = Weld(Right_Arm, Torso, cf(-1.5,0,0))
local law = Weld(Left_Arm, Torso, cf(1.5,0,0))
local torw = Weld(Torso, HumanoidRootPart, cf(0,0,0))
local hedw = Weld(Head, Torso, cf(0,-1.5,0))
local lhw = Weld(Left_Arm, LHA, cf(0,0,0))
local rhw = Weld(Right_Arm, RHA, cf(0,0,0)*ang(0,0,0))
local shw = Weld(Right_Arm, SHA, cf(0,-1,0)*ang(0,-rad(90),-rad(90)))

--[[ State Example: Arms Out
	raw.C0 = clerp(raw.C0, cf(0,.5,-.5)*ang(rad(90),0,0),.1)
	law.C0 = clerp(law.C0, cf(0,.5,-.5)*ang(rad(90),0,0),.1)
--]]

local keyz={};
local Used = {
	Executed={};
	Failed={};
};

local BindKey = function(Name, Key, Function)
	local keydown
	keyz[Key:upper()]=Name
	keydown = mouse.KeyDown:connect(function(key)
		if Key:lower() == key:lower() then
			local detect=dkd
			if dkd then
				table.insert(Used.Failed, {Name, Key, Function})        
			elseif not dkd and Walking then
				if NotifyKeyPresses then
					warn('executed('..Name..', "'..tostring(Key:upper())..'")')
				end
				Function(Name, Key)
				if NotifyKeyPresses then
					warn('ended('..Name..')')
				end
				table.insert(Used.Executed, {Name, Key, Function})
			elseif Walking then
				warn('You must Walking enabled to use this key')
			end
		end
	end)
end

local pitches = {}
for i = -.1,.1,.01 do table.insert(pitches,1.5+i) end

--[[

BindKey('Attack Name', 'Key{Not case sensative}', function(AttackName, Key)
	ds,dkd = true,true
	for i = 0,1,.05 do
		local animspd = .1
		local Right_Arm_ = cf(0,0,0)
		local Left_Arm_ = cf(0,0,0)
		local Right_Leg_ = cf(0,0,0)
		local Left_Leg_ = cf(0,0,0)
		local Head_ = cf(0,0,0)
		local Torso_ = cf(0,0,0)
		
		torw.C0 = clerp(torw.C0, cf(0,0,0)*Torso_*ang(0,0,0),animspd)
		hedw.C0 = clerp(hedw.C0, cf(0,0,0)*Head_*ang(0,0,0),animspd)
		law.C0 = clerp(law.C0, cf(0,0,0)*Left_Arm_*ang(0,0,0),animspd)
		raw.C0 = clerp(raw.C0, cf(0,0,0)*Right_Arm_*ang(0,0,0),animspd)
		rlw.C0 = clerp(rlw.C0, cf(0,0,0)*Right_Leg_*ang(0,0,0),animspd)
		llw.C0 = clerp(llw.C0, cf(0,0,0)*Left_Leg_*ang(0,0,0),animspd)
		lrs:wait()
		lrs:wait()
	end
	for i = 0,1,.05 do
		local animspd = .1
		local Right_Arm_ = cf(0,0,0)
		local Left_Arm_ = cf(0,0,0)
		local Right_Leg_ = cf(0,0,0)
		local Left_Leg_ = cf(0,0,0)
		local Head_ = cf(0,0,0)
		local Torso_ = cf(0,0,0)
		
		torw.C0 = clerp(torw.C0, cf(0,0,0)*Torso_*ang(0,0,0),animspd)
		hedw.C0 = clerp(hedw.C0, cf(0,0,0)*Head_*ang(0,0,0),animspd)
		law.C0 = clerp(law.C0, cf(0,0,0)*Left_Arm_*ang(0,0,0),animspd)
		raw.C0 = clerp(raw.C0, cf(0,0,0)*Right_Arm_*ang(0,0,0),animspd)
		rlw.C0 = clerp(rlw.C0, cf(0,0,0)*Right_Leg_*ang(0,0,0),animspd)
		llw.C0 = clerp(llw.C0, cf(0,0,0)*Left_Leg_*ang(0,0,0),animspd)
		lrs:wait()
	end
	ds,dkd = false,false
end)

--]]

function rainb(hue)
    local section = hue % 1 * 3
    local secondary = 0.5 * math.pi * (section % 1)
    if section < 1 then
        return c3(1, 1 - cos(secondary), 1 - sin(secondary))
    elseif section < 2 then
		return c3(1 - sin(secondary), 1, 1 - cos(secondary))
    else
        return c3(1 - cos(secondary), 1 - sin(secondary), 1)
    end
end

function showDmg(To, From, Txt, Others)
	local bc,c3=BrickColor.new,Color3.new
	local vec3,cf=Vector3.new,CFrame.new
	local rand=math.random
	local n = 2
	local lrs=game:service'RunService'.Stepped
	local Color = 'Pearl'
	local Clr_Raw = Color
	if Clr == nil then Clr = 'Pearl' end
	Clr = bc(Color).Color
	local Pert = Instance.new('Part', Character)
	Pert.Size = vec3(.2,.2,.2)
	Pert.Transparency = 1
	Pert.CanCollide = false
	Pert.Anchored = true
	Pert.CFrame = To:FindFirstChild'Head'.CFrame * cf(rand(-n,n),n,rand(-n,n))
	Pert.BrickColor = bc('Black')
	local Rod = nil
	if (Others.Rod ~= nil and Others.Rod == true) then
		Rod = Instance.new('Part', Character)
		local to,from = Pert.CFrame.p, From:WaitForChild'HumanoidRootPart'.CFrame.p
		local dist = (to-from).magnitude
		Rod.Size = vec3(.2,.2,dist)
		Instance.new('BlockMesh',Rod).Scale=vec3(.1,.1,1)
		Rod.CFrame = cf(to,from)*cf(0,0,-dist/2)
		Rod.Transparency = .5 or Rod.RodTrans
		Rod.CanCollide = false
		Rod.Anchored = true
		Rod.BrickColor = bc(Clr_Raw)
	end
	local Gui = Instance.new('BillboardGui',Pert)
	Gui.Adornee = Pert
	local n2 = 10
	Gui.Size = UDim2.new(n2,0,n2,0)
	local TextL = Instance.new('TextLabel', Gui)
	local r,g,b = Clr.r,Clr.g,Clr.b
	local clr = c3(r,g,b)
	TextL.BackgroundTransparency = 1
	TextL.Font = 'SciFi'
	TextL.Size = UDim2.new(1,0,1,0)
	TextL.TextTransparency = .1
	TextL.TextStrokeTransparency = .2
	TextL.TextStrokeColor3 = clr
	TextL.Position = UDim2.new(0,0,0,0)
	Txt=tostring(Txt):upper()
	if string.find(Txt:lower(),'critical') or (Others.Crit ~= nil and Others.Crit == true)then
		Txt='(CRITICAL) // '..Txt
	end
	TextL.Text=Txt
	TextL.TextScaled = false
	TextL.FontSize = 'Size18'
	TextL.TextColor3 = Color3.new(1,1,1)
	local sp = Pert.CFrame*cf(rand(n,n*2),rand(n,n*2),rand(n,n*2)) --Pert.CFrame * cf(rand(-n,n),n,rand(-n,n))
	delay(.1,function()
		repeat lrs:wait()
			TextL.TextTransparency=TextL.TextTransparency+.005
			TextL.TextStrokeTransparency=TextL.TextStrokeTransparency+.005
			if Rod ~= nil then
				Rod.Transparency = Rod.Transparency + .0025
			end
			Pert.CFrame = Pert.CFrame:lerp(sp,.01)
			clr = c3(r,g,b)
			if Rod ~= nil then
				local to,from = Pert.CFrame.p, From:WaitForChild'HumanoidRootPart'.CFrame.p
				local dist = (to-from).magnitude
				Rod.Size = vec3(.2,.2,dist)
				Rod.CFrame = cf(to,from)*cf(0,0,-dist/2)
			end
			--TextL.TextColor3 = clr
		until TextL.TextTransparency>=1
		Pert:Destroy()
		if Rod ~= nil then
			Rod:Destroy()
		end
	end)
end

--// Example // showDmg(workspace.SavageMunkey, workspace.Base, 'Damage Dealt'..math.random(0,100), {Rod=false,RodTrans=0,Crit=false})

function CheckIfLanded()
	local Ray = Ray.new(root.Position,vec3(0,-1,0)*3.5)
	local Ignore = {Char}
	local Hit,Pos,SurfaceNorm = workspace:FindPartOnRayWithIgnoreList(Ray,Ignore)
	if Hit == nil then return false,nil end
	return true, Hit
end;

function FindNearestTorso(Position, Distance, SinglePlayer)
    if SinglePlayer then return(SinglePlayer.Torso.CFrame.p -Position).magnitude < Distance end
        local List = {}
        for i,v in pairs(workspace:GetChildren())do
            if v:IsA("Model")then
                if v:findFirstChild("Torso")then
                    if v ~= Char then
                        if(v.Torso.Position -Position).magnitude <= Distance then
                            table.insert(List,v)
                        end 
                    end 
                end 
            end 
        end
    return List
end

local function ExpellWithForce(Origin, Radius, Force, OnHit, Break, Ignore)
	Origin = Origin or Vector3.zero
	Origin = typeof(Origin) == 'Vector3' and Origin or Origin.p
	Ignore = Ignore or {};
	Ignore = typeof(Ignore) == 'table' and Ignore or {};
	Radius = Radius or 5
	Force = Force or 50
	if Break == nil then
		Break = true
	end
	OnHit = OnHit or function(Part, Distance) 
		--// oof
	end
	
	local SearchRegion = Region3.new(Origin - Vector3.new(Radius, Radius, Radius),Origin + Vector3.new(Radius, Radius, Radius))
	local Parts = workspace:FindPartsInRegion3WithIgnoreList(SearchRegion, Ignore, 100)
	
	for Index, Part in next, Parts do
		spawn(function()
			OnHit(Part, (Origin - Part.Position).magnitude)
		end)
		if not Part.Anchored then
			if Break then
				Part:BreakJoints()
			end
			local Direction = CFrame.new(Origin, Part.Position).lookVector * Force
			local Propell = Instance.new('BodyVelocity')
			Propell.Velocity = Direction
			Propell.Parent = Part
			game:GetService("Debris"):AddItem(Propell, .1)
		end
	end
end

function NewFXBox(name,prnt)
	if prnt == nil then
		prnt = Character
	end
	local FXBox = Instance.new('Model', prnt)
	FXBox.Name = 'FXBox'
	if name then
		FXBox.Name = name
	end
	local Count = 0
	local Check
	Check = FXBox.ChildAdded:connect(function(Object)
		if Object:IsA'BasePart' then
			FXBox.PrimaryPart = Object
			Check:disconnect()
		end
	end)
	return FXBox
end

function ReSurface(Part, Integer)
	if Part ~= nil and Part:IsA'BasePart' then
		Part.TopSurface = Integer
		Part.BottomSurface = Integer
		Part.LeftSurface = Integer
		Part.RightSurface = Integer
		Part.FrontSurface = Integer
		Part.BackSurface = Integer
	end
end

function ni(name,prnt)
	return Instance.new(tostring(name),prnt)
end

local FX = NewFXBox('FXBox', Character)
function NewObject(Type, prnt, others)
	if not prnt then prnt = workspace end
	local New = ni(Type)
	if New:IsA'BasePart' then
		ReSurface(New,10)
		New.Anchored = true
		New.Size = vec3(1,1,1)
		New.CanCollide = false
	end
	for i,v in next, others do
		local suc,err = pcall(function()
			New[i] = v
		end)
		if not suc then
			print(err)
		end
	end
	New.Parent = prnt
	return New
end

function NewPart(prnt)
	return NewObject('Part', prnt, {Anchored = true, Size = Vector3.new(1,1,1), CanCollide = false, CFrame = prnt:IsA'BasePart' and prnt.CFrame or CFrame.new(0,1,0)})
end

function OnHumanoidFind(Detector, Offset, Function, Range, Multi) --// R15 Support
    spawn(function()
        if not Multi then Multi = false end
        local PlayerModels={};
        local SearchAndStuff
        local First = true
        SearchAndStuff=function(Parent)
            for Index, Obj in next, Parent:children() do
                if Obj:IsA'Model' and Obj:FindFirstChild'Humanoid' then
                    if Obj:FindFirstChild'HumanoidRootPart' and (Obj.HumanoidRootPart.CFrame.p-(Detector.CFrame*Offset).p).magnitude <= Range and Obj~=char then
                        --print'derp'
                        table.insert(PlayerModels, Obj)
                        if First then
                            if not Multi then
                                First = false
                            end
                            pcall(function()
                                Obj.Health.Disabled = true
                            end)
                            spawn(function()
                                Function(Obj:WaitForChild'HumanoidRootPart', Obj:WaitForChild'Humanoid', Obj)
                            end)
                        end
                    end
                end
                SearchAndStuff(Obj)
            end
        end
        SearchAndStuff(workspace)
        return PlayerModels
    end)
end

function debri(item,time)
	return game:service'Debris':AddItem(item,time)
end

local effects={MagicCircles={};};
local trans={};
local grows={}

function effects:MagicCircle(waitt, id, Offset,clr,sz)
	sz=sz or 4.5
	local mcPart=NewObject('Part', FX,{Transparency=1,Size=vec3(sz,sz,.2)})
	debri(mcPart, 40)
	clr=clr or 'Pearl'
	local mesh=NewObject('BlockMesh',mcPart,{Scale=vec3(1,1,0)})
	local backDecal=NewObject('Decal',mcPart,{Color3=bc(clr).Color,Face='Back',Texture=rbx..id})
	local frontDecal=NewObject('Decal',mcPart,{Color3=bc(clr).Color,Face='Front',Texture=rbx..id})
	local r=rand()
	local dir=5
	if r>.5 then dir=-5 end
	spawn(function()
		repeat lwait() until frontDecal.Parent==nil mcPart:Destroy()
	end)
	table.insert(effects.MagicCircles, {mcPart,backDecal,frontDecal,dir})
	mcPart.CFrame = Offset
	delay(waitt,function() trans[backDecal]={.05,1} trans[frontDecal]={.05,1}end)
	return mcPart,frontDecal,backDecal
end

function effects:particle(waitt,mx,num, shape,Offset, clrz,cancollide)
	local sz={};
	if not clrz or #clrz < 1 then
		clrz={'Alder','Pearl'}
	end
	for i = .4,mx,.025 do table.insert(sz,i) end
	local tings={};
	for i = 1,num do
		local val = sz[rand(1,#sz)]
		local part=NewObject('Part', FX,{Material='Neon', CanCollide=cancollide,Shape=shape, Transparency=.6,Size=vec3(val,val,val),Color = bc(clrz[rand(1,#clrz)]).Color, CFrame = Offset*ang(rad(rand(-360,360)),rad(rand(-360,360)),rad(rand(-360,360)))})
		tings[i]=part
		delay(waitt,function() trans[part]={.05,1} end)
	end
	return tings
end

function effects:Debris(cancollide, radius, mx, num, pos, waitt,velocitymax)
	local Ray = Ray.new(pos+vec3(0,1,0),vec3(0,-1,0)*5)
	local Ignore = {FX,Character}
	local Hit, Pos, SurfaceNorm = workspace:FindPartOnRayWithIgnoreList(Ray,Ignore)
	local tings={};
	if Hit then
		local sz={};
		for i = .2,mx,.025 do table.insert(sz,i) end
		for i = 1,num do
			local val = sz[rand(1,#sz)]
			local y = 45
			if not cancollide then y = 65 end
			local top,bottom=velocitymax[1],velocitymax[2]
			local x,z=rand(bottom,top),rand(bottom,top)
			local part=NewObject('Part', FX,{Anchored=false, Velocity = vec3(rand(-x,x),y,rand(-z,z)), Material=Hit.Material, CanCollide=cancollide, Transparency=Hit.Transparency,Size=vec3(val,val,val),Color = Hit.Color, CFrame = cf(pos)*cf(rand(-radius,radius),0,rand(-radius,radius))*ang(rad(rand(-360,360)),rad(rand(-360,360)),rad(rand(-360,360)))})
			tings[i]=part
			if cancollide then
				delay(waitt,function() trans[part]={.05,1} end)
			end
		end
		return tings
	else
		--// Derp
	end
end

function effects:Crown(waitt, origin, sz, height,clr, others,ut)
	local props={CanCollide=false,Anchored=true,Size=vec3(sz,height,sz),Color = bc(clr).Color, CFrame = origin*ang(0,rad(rand(-360,360)),0)}
	for i,v in next, others do
		props[i]=v
	end
	local cr=MeshEffects.Crown:Clone()
	for i,v in next, props do
		if tostring(i)~='Parent' then
			pcall(function() cr[i]=v end)
		end
	end
	cr.Parent=FX
	delay(waitt,function() trans[cr]={ut,1} end)
	return cr
end

function effects:Ring(waitt, origin, sz, height,clr, slim, others,ut)
	local props={CanCollide=false,Anchored=true,Size=vec3(sz,height,sz),Color = bc(clr).Color, CFrame = origin*ang(0,rad(rand(-360,360)),0)}
	slim = slim or false
	others = others or {};
	for i,v in next, others do
		props[i]=v
	end
	local cr=MeshEffects[slim and 'Ring' or 'Donut']:Clone()
	for i,v in next, props do
		if tostring(i)~='Parent' then
			pcall(function() cr[i]=v end)
		end
	end
	cr.Parent=FX
	delay(waitt,function() trans[cr]={ut,1} end)
	return cr
end

function effects:BlastRad(cancollide, radius, num, mx, pos, waitt)
	local Ray = Ray.new(pos+vec3(0,1,0),vec3(0,-1,0)*5)
	local Ignore = {FX,Character}
	local Hit, Pos, SurfaceNorm = workspace:FindPartOnRayWithIgnoreList(Ray,Ignore)
	local tings={};
	local org=mx/4
	mx=mx
	if Hit then
		local sz={};
		for i = .2,num,.025 do table.insert(sz,i) end
		for i = 1,360,mx do
			local val = sz[rand(1,#sz)]
			local function rr()
				local vlz={}
				for i = .45,1,.025 do table.insert(vlz,i) end
				return vlz[rand(1,#vlz)]
			end
			local part=NewObject('Part', FX,{Material=Hit.Material, CanCollide=cancollide, Transparency=Hit.Transparency,Size=vec3(val/rr(),val/rr(),val/rr()),Color = Hit.Color, CFrame = cf(pos) * ang(0,rad(i),0)*cf(radius,(Hit.CFrame.Y+(Hit.Size.Y/2))-val,0)*ang(rad(rand(-360,360)),rad(rand(-360,360)),rad(rand(-360,360)))})
			tings[i]=part
			if cancollide then
				delay(waitt,function() trans[part]={.05,1} end)
			end
		end
		return tings
	else
		--// Derp
	end
end

--[[ examples
	effects:BlastRad(true, 15, 2, 18, pos, .5)
	
	effects:Debris(true, 2.5, 2, rand(10,20), pos, .5,{50,25})
	
	effects:MagicCircle(.15,124339738, cf(0,-1.5,0))
	
	effects:Particle(.5,1.2,rand(2,5),'Ball',cf(0,-1.5,0),{'Pearl','Pearl'})
--]]

function SetSwordTransparency(Transparency, Speed)
	Speed = Speed or .5
	for Index, Obj in next, Parts do
		if Obj:IsDescendantOf(Melee) and Obj ~= SHA and Obj ~= trailTop and Obj ~= trailBottom then
			Tween(Obj, Speed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, {Transparency = Transparency})
		end
	end
	lwait(Speed)
end

function FadeSword(Type)
	if Type == 'Out' then
		snd(588738712,root,true)
		SetSwordTransparency(1, .5)
	elseif Type == 'In' then
		snd(588733880,root,true)
		SetSwordTransparency(0, .5)
	end
	if Type == 'In' or Type == 'Out' then
		--// asd
	else
		warn('Invalid Tween Type')
	end
end

local function CalculateArc(Smoothness, From, To)
	local PeakFactor = 5
	local Peak, To = (From - To).magnitude / PeakFactor, To - Vector3.new(0, From.Y, 0)
	local Algorithm = math.abs(2 * (Peak * 2 - From.Y + To.Y))
	local Fraction, Last, Return = (1 / (Peak * PeakFactor)) / Smoothness, From, {};
	for Integer = 0, 1, Fraction do
		local New = CFrame.new(From:lerp(To, Integer) + Vector3.new(0, -Algorithm * Integer ^ 2 + Algorithm * Integer + From.Y, 0))
		Return[#Return + 1] = New.p
	end
	return Return
end

local function DisplayArc(Arc)
	local Storage, Last = Instance.new('Folder', Character), Arc[1]
	for Index, Point in next, Arc do
		if Index > 1 then
			local Part = Instance.new('Part')
			Part.Anchored = true
			Part.Material = 'Plastic'
			Part.BrickColor = BrickColor.new('Buttermilk')
			Part.TopSurface, Part.BottomSurface = 0, 0
			Part.CanCollide = false
			local Distance = (Last - Point).magnitude
			Part.Size = Vector3.new(.15, .15, Distance)
			Part.CFrame = CFrame.new(Point, Last) * CFrame.new(0, 0, -Distance / 2)
			Part.Parent = Storage
		end
		Last = Point
	end
	return Storage
end 

local function TweenC0(Obj, C0, Style, Direction, Time)
	local S = type(Style) == 'string' and Enum.EasingStyle[Style] or Style
	local D = type(Direction) == 'string' and Enum.EasingDirection[Direction] or Direction
	return Tween(Obj, Time, S, D, {C0 = C0})
end

local function TweenJoints(Array)
	local Style, Direction, Time = Array.Style, Array.Direction, Array.Time
	TweenC0(torw, CFrame.new(0,0,0) * Array.Torso_ * CFrame.Angles(0,0,0), Enum.EasingStyle[Style], Enum.EasingDirection[Direction], Time)
	TweenC0(hedw, CFrame.new(0,0,0) * Array.Head_ * CFrame.Angles(0,0,0), Enum.EasingStyle[Style], Enum.EasingDirection[Direction], Time)
	TweenC0(law, CFrame.new(0,0,0) * Array.Left_Arm_ * CFrame.Angles(0,0,0), Enum.EasingStyle[Style], Enum.EasingDirection[Direction], Time)
	TweenC0(raw, CFrame.new(0,0,0) * Array.Right_Arm_ * CFrame.Angles(0,0,0), Enum.EasingStyle[Style], Enum.EasingDirection[Direction], Time)
	TweenC0(rlw, CFrame.new(0,0,0) * Array.Right_Leg_ * CFrame.Angles(0,0,0), Enum.EasingStyle[Style], Enum.EasingDirection[Direction], Time)
	TweenC0(llw, CFrame.new(0,0,0) * Array.Left_Leg_ * CFrame.Angles(0,0,0), Enum.EasingStyle[Style], Enum.EasingDirection[Direction], Time)
	lwait(Time)
end

BindKey('Shatter', 'g', function()
	local actual,floor = CheckIfLanded(5)
	if floor ~= nil then
		dkd,ds = true,true
		walkspd=0
		spawn(function()
			FadeSword'Out'
		end)
		spawn(function()
			TweenJoints{
				Style = 'Quad',
				Direction = 'InOut',
				Time = 2,
				Right_Arm_ = CFrame.new(0.465010166, -0.439316332, -0.871765137, 0.747874916, -0.654143095, 0.1130483, 0.493739158, 0.434284091, -0.753404915, 0.443739593, 0.619269013, 0.647766173),
				Left_Arm_ = CFrame.new(-0.170354724, -0.342900693, -0.237001896, 0.933956206, 0.284371793, 0.216468185, -0.290408731, 0.95689404, -0.00408667326, -0.208299309, -0.0590473711, 0.976281226),
				Right_Leg_ = CFrame.new(5.82933426e-05, -0.162627101, -0.864352643, 0.99999994, 5.28991222e-07, 8.41915607e-07, -7.22706318e-07, 0.963203788, 0.268772095, -6.85453415e-07, -0.268772036, 0.963203907),
				Left_Leg_ = CFrame.new(0.0951830149, 0.54995501, -0.323918521, 0.984639764, 0.100627825, 0.142683357, -0.0181532614, 0.871783793, -0.489554465, -0.173651829, 0.479444683, 0.860219717),
				Head_ = CFrame.new(-0.0422370695, 0.00290894508, -0.0818053484, 0.984639764, 0.0281961933, 0.172306329, -0.0181532614, 0.99805814, -0.0595857799, -0.173651829, 0.0555427074, 0.983239532),
				Torso_ = CFrame.new(0.0194549561, -0.49135685, -0.340732574, 0.984639764, -0.0181533415, -0.173651904, 0.131810531, 0.729528904, 0.671128631, 0.114500739, -0.683708429, 0.720715284),
			}
		end)
		local s2=snd(588697034,root)
		s2.Pitch=1
		s2:Play()
		for i = 1,3 do
			lwait(.4)
			local s = snd(588738949, root)
			s.Pitch=1+(i/3)
			s:Play()
			effects:MagicCircle(2, 124339738, Right_Arm.CFrame*cf(0,1.25+i,0)*ang(rad(90),0,0),'Alder',.4+(i*2))
		end
		lwait(1)
		local pe=effects:particle(.5,1.2,rand(2,5),'Cylinder',Right_Arm.CFrame*cf(0,1.25,0),{'Alder','Pearl'})
		for i,v in next, pe do
			v.Material='Neon'
			v.Transparency=.5
		end
		TweenJoints{
			Style = 'Bounce',
			Direction = 'Out',
			Time = .1,
			Right_Arm_ = CFrame.new(-0.0323668718, -0.33607614, -1.25630379, 0.91932112, -0.32731083, 0.218440875, 0.34712559, 0.413077384, -0.841944814, 0.185344651, 0.849843979, 0.493368685),
			Left_Arm_ = CFrame.new(-0.209303617, -0.521940768, 0.209407374, 0.936596692, 0.341231942, 0.0796716437, -0.350254416, 0.904899955, 0.24182263, 0.0104227364, -0.254395574, 0.967044115),
			Right_Leg_ = CFrame.new(-0.144759536, -0.00181019306, -0.561343014, 0.955083072, -0.217188269, -0.201608062, 0.221891105, 0.975071311, 0.000745773315, 0.196420282, -0.0454473495, 0.979466081),
			Left_Leg_ = CFrame.new(-0.314982504, 0.547448993, 0.130197883, 0.968778491, -0.198621765, 0.148383692, 0.246814638, 0.715970933, -0.653045356, 0.0234706104, 0.669279575, 0.742639899),
			Head_ = CFrame.new(0.181634739, 0.0164057016, -0.124970227, 0.991457701, -0.121056765, 0.0485501736, 0.124629587, 0.989057779, -0.0789446831, -0.0384620987, 0.0843212008, 0.995696187),
			Torso_ = CFrame.new(0.35552597, -0.773739338, -0.511285782, 0.919321179, 0.34712553, 0.185344562, -0.344054341, 0.480445355, 0.806721151, 0.190985352, -0.80540365, 0.561113119),
		}
		Tween(s2, .1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, {Volume=0,Pitch=0})
		lwait(.08)
		OnHumanoidFind(root, cf(0,0,0), function(proot,phum,body)
			local dmg = math.random(20,35)
			phum.Health = phum.Health - dmg
			showDmg(body, Character,  dmg, {Rod=true,RodTrans=0,Crit=math.random()>.85})
			phum.PlatformStand=proot:GetMass()<4 and true or false
			delay(1,function()
				phum.PlatformStand=false
			end)
		end, 15, true)
		ExpellWithForce(Right_Arm.CFrame*cf(0,-.5,0), 15, math.random(30,80), function(Part, Distance)
		end, false, {workspace:FindFirstChild'Base', Character})
		local cr=effects:Crown(.5, cf((Right_Arm.CFrame*cf(0,-.5,0)).p), 10, 1, tostring(floor.BrickColor),{Material=floor.Material},.2)
		local cr2=effects:Ring(0, cf((Right_Arm.CFrame*cf(0,-.5,0)).p), 10, 2, tostring(floor.BrickColor),false,{Material=floor.Material},.15)
		table.insert(grows,{{cr},vec3(4,0,4)*4,ang(0,rad(10),0)})
		table.insert(grows,{{cr2},vec3(2,0,2)*4,ang(0,0,0)})
		s2:Destroy()
		snd(610359590,root,true)
		snd(610359515,root,true)
		snd(471882019,root,true)
		snd(284228088,root,true)
		effects:Debris(true, 2.5, 2, rand(10,20), (Right_Arm.CFrame*CFrame.new(0,-1,0)).p, .5,{50,25})
		effects:BlastRad(true, 10, 4, 6, (Right_Arm.CFrame*cf(0,-1,0)).p, .5)
		lwait(.2)
		dkd,ds = false,false
		FadeSword'In'
	end
end)

local canmine=true
BindKey('Mine', 'x', function(an,key)
	if canmine then
		canmine=false
		ds,dkd = true,true
		walkspd=0
		TweenJoints{
			Style = 'Quint',
			Direction = 'In',
			Time = .1,
			Right_Arm_ = CFrame.new(0.206053138, -0.214844942, 4.48524952e-06, 0.950437307, -0.310916245, 3.57627869e-07, 0.310916275, 0.950437307, 4.52626892e-07, -4.47034836e-07, -3.27825546e-07, 0.99999994),
			Left_Arm_ = CFrame.new(-0.450706005, 0.440005541, -1.68257201, 0.674415231, 0.738352239, -3.22744e-08, 0, -4.37113883e-08, -1, -0.738352239, 0.674415231, -2.94796259e-08),
			Right_Leg_ = CFrame.new(4.7981739e-06, 1.08480453e-05, 3.81469727e-06, 0.99999994, 0, 0, 0, 1, 0, 0, 0, 0.99999994),
			Left_Leg_ = CFrame.new(-0.280058563, -0.0610874891, -0.665026188, 0.889047265, -0.112292051, 0.443835318, 4.33083471e-07, 0.969455719, 0.245275185, -0.457815409, -0.218061626, 0.861891985),
			Head_ = CFrame.new(0, -6.10351563e-05, 0, 0.560465097, 0, 0.828179061, 0, 1, 0, -0.828179061, 0, 0.560465097),
			Torso_ = CFrame.new(-1.1920929e-06, 0, 2.86102295e-06, 0.674415231, 0, -0.738352239, 0, 1, 0, 0.738352239, 0, 0.674415231),
		}

		for i=0,1,.1 do
			FacePos(old)
			lrs:wait()
		end

		lwait(.2)
		for i=0,1,.1 do
			FacePos(old)
		end

		local bl=NewPart(Character)
		bl.Color=c3(0,0,0)
		bl.Size=Vector3.new(2,2,2)
		bl.CFrame=larm.CFrame*cf(0,-1.5,0)
		bl.Shape='Ball'
		bl.Material='Neon'
		bl.Transparency=.001
		local active=true
		spawn(function()
			game:GetService("Debris"):AddItem(bl,25)
			delay(24,function()
				active=false
				local c=bl.CFrame
				bl.CanCollide=false
				Tween(bl,1,Enum.EasingStyle.Back,Enum.EasingDirection.In,{Size=Vector3.new(.05,.05,.05),CFrame=c,Transparency=1})
			end)
			local tic=0
			local ontouch
			ontouch=bl.Touched:connect(function(Hit)
				if not Hit:IsDescendantOf(Character) then
					bl.CanCollide=true
					OnHumanoidFind(bl, cf(0,0,0), function(proot,phum,body)
						local dmg = math.random(15,30)
						phum.Health = phum.Health - dmg
						hum.Health=hum.Health+15
						showDmg(body, Character,  'LIFE STEAL '..dmg, {Rod=true,RodTrans=0,Crit=false})
					end, 8, true)
					snd(144699494,root,true)
					snd(260433487,root,true)
					local neww=bl:Clone()
					neww.Color=c3(0,0,0)
					local c=bl.CFrame
					bl:Destroy()
					neww.Parent=Character
					effects:particle(.5,7,rand(2,5),'Cylinder',c,{'Pearl','Alder'})
					for i = 0,8,.45 do
						neww.Transparency=neww.Transparency+.056274620146314
						neww.Size=neww.Size:lerp(Vector3.new(2+i,2+i,2+i),.2)
						neww.CFrame=c
						lrs:wait()
					end
					neww:Destroy()
					ontouch:disconnect()
					neww.CFrame=c
				end
			end)
			while lwait(.2) and bl and active do
				if bl.Parent~=nil then
					tic=tic+.1
					if tic > .65 then
						snd(171137312,bl,true)
						OnHumanoidFind(bl, cf(0,0,0), function(proot,phum,body)
							local took=math.random(5,20)
							phum.Health = phum.Health - took
							--hum.Health=hum.Health+took
							showDmg(body, Character,  took, {Rod=true,RodTrans=0,Crit=false})
						end, 6, true)
						local cr=effects:Crown(.1, cf(bl.Position)*cf(0,-3,0), 1, .25, 'Pearl',{Material='Neon'},.05)
						local cr2=effects:Ring(.1, cf(bl.Position)*cf(0,-3.5,0), 2, .1, 'Pearl',true,{Material='Neon'},.05)
						table.insert(grows,{{cr,cr2},vec3(.05,.005,.05)*3,ang(0,rad(1),0)})
						tic=0
						local neww=bl:Clone()
						neww.Color=c3(1,1,1)
						neww.Parent=Character
						local c=bl.CFrame
						spawn(function()
							for i = 0,3,.1 do
								neww.Transparency=neww.Transparency+.0333
								neww.Size=neww.Size:lerp(Vector3.new(2+i,2+i,2+i),.2)
								neww.CFrame=c
								lrs:wait()
							end
							neww:Destroy()
						end)
					end
				end
			end
			ontouch:disconnect()
		end)
		
		snd(171137312,root,true)
		snd(187747824,root,true)

		spawn(function()
			TweenJoints{
				Style = 'Back',
				Direction = 'Out',
				Time = .1,
				Right_Arm_ = CFrame.new(0.206047893, -0.21484524, 5.28991222e-06, 0.950437486, -0.310916156, 9.23871994e-07, 0.310916156, 0.950437367, 3.18055783e-07, -9.83476639e-07, -1.49011612e-08, 1.00000024), 
				Left_Arm_ = CFrame.new(0.333840013, 0.20000568, -0.701913893, 0.985808611, 0.140995234, 0.0911340564, -6.04101302e-08, 0.542838275, -0.839838743, -0.167884231, 0.827917576, 0.535135746),
				Right_Leg_ = CFrame.new(0.406761706, 0.198160172, -0.827177048, 0.861753821, 0.0901806355, -0.499247611, 0, 0.984074771, 0.177756459, 0.507326901, -0.153182313, 0.84803021),
				Left_Leg_ = CFrame.new(0.428323984, -0.535795689, -1.22677946, 0.797612667, 0.302806526, 0.521652818, -0.546524048, 0.728732705, 0.41263321, -0.255197555, -0.614223242, 0.74672997),
				Head_ = CFrame.new(0.106018938, 0.00909304619, 0.160875916, 0.97453934, -0.0714026541, -0.212544471, 0.0874781013, 0.993896961, 0.0672045946, 0.206448734, -0.0840865001, 0.97483778),
				Torso_ = CFrame.new(-0.0166940689, -0.179999828, -0.0304899216, 0.861753821, 0, 0.507326901, 0, 1, 0, -0.507326901, 0, 0.861753821),
			}
		end)
		local bv=Instance.new('BodyVelocity',root)
		bv.MaxForce=vec3(9e9,0,9e9)
		bv.Velocity=Head.CFrame.lookVector*-13
		game:GetService("Debris"):AddItem(bv,.2)
		for i = 0,1,.2 do
			local ptc1 = effects:particle(.1,.5,3,'Block',Left_Leg.CFrame*cf(0,-1,0),{'Really black','Really black', 'Pearl'})
			local ptc2 = effects:particle(.1,.5,3,'Block',Right_Leg.CFrame*cf(0,-1,0),{'Really black','Really black', 'Pearl'})
			local ss=1.6
			table.insert(grows,{{ptc1},vec3(.2,0,.2),ang(rad(10),rad(10),rad(10))})
			table.insert(grows,{{ptc2},vec3(.2,.2,.2),ang(rad(10),rad(10),rad(10))})
			lrs:wait()
		end
		lwait()
		ds,dkd = false,false
		delay(0,function()
			canmine=true
		end)
	end
end)

local clsr=true
BindKey('Incinerate', 'q', function()
	if not clsr then return end
	clsr=false
	ds,dkd = true,true
	walkspd=0
	FadeSword'Out'
	spawn(function()
		TweenJoints{
			Style = 'Quint',
			Direction = 'Out',
			Time = .45,
			Right_Arm_ = CFrame.new(-0.231867522, 0.277298152, 0.793980241, 0.274041951, 0.959314048, -0.0679790825, 0.0029127209, -0.071512714, -0.997437716, -0.961713552, 0.273141831, -0.0223916993),
			Left_Arm_ = CFrame.new(-0.503219903, 0.412600666, -1.63814199, 0.586037755, 0.81028372, -3.54186263e-08, 0.00245406968, -0.00177494972, -0.99999547, -0.810280085, 0.586035132, -0.00302868057),
			Right_Leg_ = CFrame.new(-0.1793679, -0.194476008, -1.1458993e-05, 0.983692706, -0.17985943, 2.98023224e-08, 0.179859221, 0.983697474, -7.10133463e-09, -2.98023224e-08, -1.49011612e-08, 1.0000062),
			Left_Leg_ = CFrame.new(0.103276968, -0.0279527903, -0.087505281, 0.983025551, 0.0558601618, 0.174757063, -0.0549976081, 0.998438716, -0.00977835804, -0.17503038, 1.13807619e-06, 0.98456347),
			Head_ = CFrame.new(4.57763672e-05, 3.93390656e-06, -0.00303999148, 0.586037755, 0, 0.81028372, 0.00245406968, 0.99999547, -0.00177490606, -0.810280085, 0.00302865496, 0.586035132),
			Torso_ = CFrame.new(0.368801117, -0.00288367271, 0.00219345093, 0.586037755, 0.00245395955, -0.810280085, -0.00245499588, 0.999996245, 0.00125324936, 0.81027925, 0.00125479547, 0.586041093),
		}
	end)
	for i=0,1,.05 do
		FacePos'mouse'
		lrs:wait()
	end

	local beam = NewPart(Character)
	beam.Parent=nil
	beam.CFrame=Right_Arm.CFrame*cf(0,-1,0)
	beam.Material='Neon'
	beam.BrickColor=bc'Alder'
	Instance.new('CylinderMesh',beam).Scale=Vector3.new(.05,1,.05)
	beam.Parent=Character
	local canfrag=true
	spawn(function()
		while beam.Parent ~= nil and lwait(.25) do
			canfrag=true
		end
	end)
	snd(588734767,root,true,{Pitch=1.25})
	snd(588736245,root,true)
	local hums,bps = {},{};
	local ignore={Character};
	local replace
	for i=0, 2048, 50 do
		FacePos'mouse'
		local StartPos = Left_Arm.CFrame*cf(0,-1,0)
		local Ray = Ray.new(StartPos.p, (StartPos.p - (StartPos * CFrame.new(0, 1, 0)).p).unit * i)
		local Hit, Pos = workspace:FindPartOnRayWithIgnoreList(Ray, ignore)
		local dist = Hit and not Hit:IsDescendantOf(Character) and (Pos-StartPos.p).magnitude or i
		beam.Size=vec3(.85,dist,1)
		beam.CFrame=StartPos*cf(0,-(dist/2),0)
		if Hit then
			local ptc2 = effects:particle(.1,2,1,'Block',cf(Pos),{'Really black',tostring(Hit.BrickColor), 'Pearl'})
			for i,v in next, ptc2 do v.Material='Neon' end
			table.insert(grows,{{ptc2},vec3(1,0,1),ang(rad(10),rad(10),rad(10))})
			if Hit and (Hit.Parent:FindFirstChildOfClass'Humanoid' or Hit.Parent.Parent:FindFirstChildOfClass'Humanoid') and #hums < 5 then
				if Hit:GetMass()<=4 then
					local bp = Instance.new('BodyPosition', Hit)
					game:GetService("Debris"):AddItem(bp,10)
					local dist = (StartPos.p-Hit.Position).magnitude
					bp.Position=(StartPos*cf(0,-dist,1)).p
					spawn(function()
						while lwait() and bp.Parent ~= nil do
							local pos = ((replace or Left_Arm.CFrame)*cf(0,-1-dist,0)).p
							bp.Position=pos
						end
					end)
					table.insert(bps, bp)
				end
				local phum = Hit.Parent:FindFirstChildOfClass'Humanoid' or Hit.Parent.Parent:FindFirstChildOfClass'Humanoid' or Hit.Parent.Parent.Parent:FindFirstChildOfClass'Humanoid'
				table.insert(ignore,phum.Parent)
				hums[phum]=true
			end
		end
		lrs:wait()
	end
	local pos = Left_Arm.CFrame*cf(0,-1,0)
	ds,dkd = false,false
	replace=Left_Arm.CFrame
	FadeSword'In'
	
	local b2 = beam:Clone()
	b2.Mesh.Scale=vec3(2,1,2)
	b2.Transparency=.8
	local b3 = beam:Clone()
	b3.Mesh.Scale=vec3(.3,1,.3)
	b3.Transparency=1
	b2.Parent,b3.Parent=Character,Character
	
	Tween(b2.Mesh,.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,{Scale=vec3(.45,1,.45)})
	Tween(b2,.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,{Transparency=0})
	Tween(b3.Mesh,.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,{Scale=vec3(3,1,3)})
	Tween(b3,.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,{Transparency=.85})
	snd(763718573,root,true)
	lwait(.7)
	--b2:Destroy();b3:Destroy()
	snd(763717897, root, true)
	snd(782354294, root,true)
	
	for i = 1, 6, 1 do
		local effected={};
		for i,v in next, hums do
			local can=true
			for a,b in next, effected do
				if b==i then
					can=false
				end
			end
			if can then
				for a,b in next, bps do
					if b:IsDescendantOf(i.Parent) and (b.Position-i.Parent:WaitForChild'Head'.Position).magnitude < 6 then
						table.insert(effected,i)
						local dmgg = rand(2, 4)*1
						i:TakeDamage(dmgg)
						showDmg(i.Parent, Character,  dmgg, {Rod=false,RodTrans=0,Crit=rand()>.5})
						spawn(function()
							snd(588694531,i.Parent:WaitForChild'Head',true)
						end)
					end
				end
			end
		end
		local b4 = beam:Clone()
		b4.Mesh.Scale=vec3(2,1,2)
		b4.Transparency=.2
		b4.Parent=Character

		local cone = MeshEffects.Cone:Clone()
		cone.CFrame = pos*cf(0,1.25,0)
		cone.Anchored=true
		cone.BrickColor=bc'Pearl'
		cone.CanCollide=false
		cone.Material='Neon'
		cone.Transparency=.2
		cone.Parent=Character
		Tween(cone,.65,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,{Transparency = 1, Size=vec3(15,4,15)/2.5})

		local cone2 = MeshEffects.Cone:Clone()
		cone2.CFrame = pos*cf(0,1.5,0)
		cone2.Anchored=true
		cone2.BrickColor=bc'Alder'
		cone2.CanCollide=false
		cone2.Material='Neon'
		cone2.Transparency=.2
		cone2.Parent=Character
		Tween(cone2,.65,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,{Transparency = 1, Size=vec3(15,4,15)/1.25})
		
		Tween(b4.Mesh,.65,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,{Scale=vec3(15,1,15)})
		Tween(b4,.65,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,{Transparency=1})
		delay(.65,function()
			b4:Destroy();cone:Destroy()
		end)
		lwait(.6)
	end
	b2:Destroy();b3:Destroy()
	for i,v in next, bps do
		v:Destroy()
	end
	delay(5,function()
		clsr=true
	end)
	beam:Destroy()
end)

BindKey('Buster', 'r', function(_,k)
	dkd,ds=true,true
	local fire=false
	local ev
	walkspd=0
	ev=mouse.KeyUp:connect(function(key)
		if k==key then
			fire=true
			ev:disconnect()
		end
	end)
	walkspd=0
	local tweened=false
	spawn(function()
		TweenC0(shw, cf(0,0,0)*ang(0,rad(45),rad(70)), 'Quint', 'Out', 1)
		TweenJoints{
			Style = 'Quint',
			Direction = 'Out',
			Time = 1,
			Right_Arm_ = CFrame.new(0.535389304, 0.15619868, -1.28274536, 0.680957854, -0.702149034, 0.208047509, 0.284585983, -0.00804074015, -0.958620548, 0.674766183, 0.711983562, 0.19434683),
			Left_Arm_ = CFrame.new(-1.80736709, 0.506341934, -1.62024987, 0.117187969, 0.993109763, -4.3410207e-08, 0, -4.37113883e-08, -1, -0.993109763, 0.117187969, -5.12244869e-09),
			Right_Leg_ = CFrame.new(-6.61611557e-06, -0.905116677, -1.40443158, 1, 7.5250864e-07, -5.30853868e-06, 4.43911813e-06, 0.440601975, 0.897702694, 3.02493572e-06, -0.897702754, 0.440601975),
			Left_Leg_ = CFrame.new(-0.244986176, 0.385205865, -0.7590608, 0.939282835, -0.0607775971, 0.337720811, -2.25848567e-07, 0.98419106, 0.177119762, -0.343143851, -0.166365743, 0.924440086),
			Head_ = CFrame.new(4.76837158e-07, 0, -2.86102295e-06, 0.117187969, 0, 0.993109763, 0, 1, 0, -0.993109763, 0, 0.117187969),
			Torso_ = CFrame.new(0.0551037788, -0.53477335, -1.43051147e-06, 0.117187969, 0, -0.993109763, 0, 1, 0, 0.993109763, 0, 0.117187969),
		}
		tweened=true
	end)
	repeat lrs:wait() FacePos'mouse' 
	until fire and tweened
	dkd,ds=false,false
	local to = mouse.Hit.p
	local from = (Left_Arm.CFrame*cf(0,-1.5,1.25)).p
	local Arc = CalculateArc(.5, from, to)
	--local Segment = DisplayArc(Arc)
	local Ball = NewObject('Part', Character, {Size = vec3(2.5,2.5,2.5), Material='Neon', Color=bc'Alder'.Color, CFrame=cf(Arc[1]), Shape = 'Ball'})
	local msh=Instance.new('SpecialMesh',Ball)
	msh.MeshType='Sphere'
	msh.Scale=vec3(1,1,1)
	local loop=snd(228343433,Ball,true,{Pitch=2,Volume=3,Looped=true})
	snd(231917750,root,true,{Pitch=.9})
	local finished=false
	spawn(function()
		local t=0
		local lcf=Arc[1]
		repeat lrs:wait() 
			t=t+1
			Tween(msh,.15,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,{Scale=msh.Scale.Y < 5 and msh.Scale+vec3(1,1,1) or msh.Scale})
			if t > 10 then
				t=0
				local ri=effects:Ring(.5, cf(lcf,Ball.Position)*ang(rad(90),0,0), 1, .5, 'Alder', true,{Material='Neon'},.15)
				table.insert(grows,{{ri},vec3(.15,0,.15)*4,ang(0,0,0)})
			end
			lcf=Ball.Position
			spawn(function()
				local bl = NewPart(Character)
				bl.Parent=nil
				local random = vec3(rand(-3,3),rand(-3,3),rand(-3,3))
				bl.CFrame=Ball.CFrame*cf(random*(msh.Scale.Y/2))
				bl.Material='Neon'
				bl.Size=vec3(1,1,1)
				bl.BrickColor=math.random()>.5 and bc'Alder' or bc'Pearl'
				local msh2=Instance.new('SpecialMesh',bl)
				msh2.MeshType='Sphere'
				msh2.Scale=msh.Scale/2
				bl.Parent=Character
				Tween(bl,.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,{CFrame=Ball.CFrame})
				Tween(msh2,.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,{Scale=vec3(0,0,0)})
				delay(.5, function()
					bl:Destroy()
				end)
			end)
		until finished
	end)
	for i,v in next, Arc do
		Tween(Ball, .025, 'Linear', 'InOut', {CFrame = cf(v)})
		lrs:wait()
	end
	finished=true
	Ball.Transparency=1
	loop:Stop()
	local strt = cf(to)*cf(0,3,0)
	local rayray = Ray.new(strt.p, (strt.p - (strt * CFrame.new(0, 1, 0)).p).unit * 10)
	local hit, pp = workspace:FindPartOnRayWithIgnoreList(rayray, {Character})
	game:GetService("Debris"):AddItem(Ball,3)
	snd(610359515,Ball,true)
	local ptc1 = effects:particle(.1,.5,5,'Block', cf(to),{'Alder','Pearl'})
	local ptc2 = effects:particle(.1,.5,5,'Cylinder',cf(to),{'Alder', 'Pearl'})
	local ss=10
	for i,v in next, ptc1 do v.Material = 'Neon' Tween(v, .5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, {Size=Vector3.new(ss,ss,ss)}) end
	for i,v in next, ptc2 do v.Material='Neon' Tween(v, .5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, {Size=Vector3.new(ss,ss,ss)}) end
	OnHumanoidFind(Ball,cf(0,0,0), function(proot,phum,body)
		local dmg = math.random(8,16)
		phum.Health = phum.Health - dmg
		pcall(function()
			showDmg(body, Character,  dmg, {Rod=false,RodTrans=0,Crit=false})
		end)
		phum.PlatformStand=proot:GetMass()<4 and true or false
		delay(.25,function()
			phum.PlatformStand=false
		end)
	end, 20, true)
	ExpellWithForce(strt, 10, 15, function(Part, Distance)
	end, false, {workspace:FindFirstChild'Base', Character})
	local ri=effects:Ring(.5, cf(pp+vec3(0,0,0)), 3, 2, tostring(hit ~= nil and hit.BrickColor or 'Pearl'),false,{Material=hit ~= nil and hit.Material or 'Neon'},.15)
	local cr=effects:Crown(.5, cf(pp+vec3(0,0,0)), 7, 4, tostring(hit ~= nil and hit.BrickColor or 'Pearl'),{Material=hit ~= nil and hit.Material or 'Neon'},.15)
	table.insert(grows,{{ri},vec3(.5,0,.5)*4,ang(0,0,0)})
	table.insert(grows,{{cr},vec3(.5,0,.5)*4,ang(0,rad(3),0)})
	snd(782202168,Ball,true)
	snd(228343412,Ball,true)
	snd(231917742,Ball,true)
	effects:Debris(true, 2.5, 2, rand(5,10), to, .005,{50,25})
	--effects:BlastRad(true, 15, 3, 5, to, .05)
end)

function Attack4()
	dkd,ds = true,true
	TweenJoints{
		Style = 'Quint',
		Direction = 'Out',
		Time = .5,
		Right_Arm_ = cf(0,0,0),
		Left_Arm_ = cf(0,0,0),
		Right_Leg_ = cf(0,0,0),
		Left_Leg_ = cf(0,0,0),
		Head_ = cf(0,0,0),
		Torso_ = cf(0,0,0),
	}
	TweenJoints{
		Style = 'Quint',
		Direction = 'Out',
		Time = .5,
		Right_Arm_ = cf(0,0,0),
		Left_Arm_ = cf(0,0,0),
		Right_Leg_ = cf(0,0,0),
		Left_Leg_ = cf(0,0,0),
		Head_ = cf(0,0,0),
		Torso_ = cf(0,0,0),
	}
	dkd,ds = false,false
end

function Attack2()
	dkd,ds = true,true
	TweenJoints{
		Style = 'Quint',
		Direction = 'Out',
		Time = .5,
		Right_Arm_ = cf(0,0,0),
		Left_Arm_ = cf(0,0,0),
		Right_Leg_ = cf(0,0,0),
		Left_Leg_ = cf(0,0,0),
		Head_ = cf(0,0,0),
		Torso_ = cf(0,0,0),
	}
	TweenJoints{
		Style = 'Quint',
		Direction = 'Out',
		Time = .5,
		Right_Arm_ = cf(0,0,0),
		Left_Arm_ = cf(0,0,0),
		Right_Leg_ = cf(0,0,0),
		Left_Leg_ = cf(0,0,0),
		Head_ = cf(0,0,0),
		Torso_ = cf(0,0,0),
	}
	dkd,ds = false,false
end

function Attack3()
	dkd,ds = true,true
	TweenJoints{
		Style = 'Quint',
		Direction = 'Out',
		Time = .5,
		Right_Arm_ = cf(0,0,0),
		Left_Arm_ = cf(0,0,0),
		Right_Leg_ = cf(0,0,0),
		Left_Leg_ = cf(0,0,0),
		Head_ = cf(0,0,0),
		Torso_ = cf(0,0,0),
	}
	TweenJoints{
		Style = 'Quint',
		Direction = 'Out',
		Time = .5,
		Right_Arm_ = cf(0,0,0),
		Left_Arm_ = cf(0,0,0),
		Right_Leg_ = cf(0,0,0),
		Left_Leg_ = cf(0,0,0),
		Head_ = cf(0,0,0),
		Torso_ = cf(0,0,0),
	}
	dkd,ds = false,false
end

function Attack1()
	dkd,ds = true,true
	TweenC0(shw, ang(0,-rad(180),rad(135)), 'Linear', 'Out', .05)
	TweenJoints{
		Style = 'Quint',
		Direction = 'Out',
		Time = .15,
		Right_Arm_ = CFrame.new(0.480937481, -0.623095155, 0.207057506, 0.829737663, -0.543632448, -0.126478553, 0.558150053, 0.808969557, 0.184476554, 0.00202971697, -0.223660082, 0.974669456),
		Left_Arm_ = CFrame.new(-0.223258257, -0.312400937, 0.592300892, 0.647217274, -0.554238617, -0.523383737, -0.253734976, 0.490803808, -0.833504915, 0.718839288, 0.672259688, 0.177026629),
		Right_Leg_ = CFrame.new(5.14984131e-05, -0.0270439386, -0.340497971, 1, 7.4505806e-09, -8.94069672e-08, -5.12227416e-09, 0.98540169, 0.170247093, -2.98023224e-08, -0.170247093, 0.985401392),
		Left_Leg_ = CFrame.new(-0.0214843154, 0.00267851353, -0.145123824, 0.956951261, -1.0477379e-09, 0.290260822, 1.86264515e-09, 1.00000489, -9.42964107e-09, -0.290262878, -9.54605639e-09, 0.956948757),
		Head_ = CFrame.new(3.81469727e-05, 4.17232513e-06, -0.00303199375, 0.584618986, 0, 0.811308026, 0.00245903619, 0.99999547, -0.00177195237, -0.811304271, 0.0030309523, 0.584616244),
		Torso_ = CFrame.new(0.00667190552, -0.00287604332, -0.000377655029, 0.584618986, 0.00245892606, -0.811304271, -0.00245809881, 0.999996245, 0.0012598458, 0.811303556, 0.00125774904, 0.584622204),
	}
	TweenC0(shw, ang(0,-rad(180),-rad(135)), 'Linear', 'Out', .4)
	snd(588693156,root,true)
	TweenJoints{
		Style = 'Linear',
		Direction = 'Out',
		Time = .15,
		Right_Arm_ = CFrame.new(1.22454464, -1.18362045, -0.306676567, 0.0752486736, -0.146807969, 0.98629868, 0.997097671, 0.02256638, -0.0727136135, -0.0115822516, 0.988907576, 0.148080021),
		Left_Arm_ = CFrame.new(-0.516955376, -0.73023963, -0.855697036, 0.655881882, 0.60047102, 0.457442462, -0.493600518, 0.799645245, -0.341944873, -0.571119547, -0.00151839852, 0.820865571),
		Right_Leg_ = CFrame.new(3.68356705e-05, -0.0779465437, -0.447924763, 1.00000942, -2.08616257e-07, 2.38418579e-07, -1.59139745e-07, 0.975493431, 0.220059082, -7.74860382e-07, -0.22006014, 0.97549367),
		Left_Leg_ = CFrame.new(0.246763051, -0.165307999, 7.34627247e-06, 0.97661984, 0.21497333, 1.34110451e-06, -0.21497333, 0.976619899, -5.21395123e-07, -1.43051147e-06, 2.16066837e-07, 1),
		Head_ = CFrame.new(-0.175744906, 0.017444849, 0.146904826, 0.648833036, 0.1171887, -0.75185281, -0.00230547017, 0.988368213, 0.152063951, 0.76092732, -0.0969307423, 0.641555905),
		Torso_ = CFrame.new(-0.00162887573, -0.00289463997, 0.00579071045, 0.374878913, -0.0028091569, 0.927069545, 0.00280869659, 0.999994338, 0.00189410418, -0.92706871, 0.00189380953, 0.374884337),
	}
	local poss = SHA.CFrame
	local offset = root.CFrame:toObjectSpace(SHA.CFrame)
	shw:Destroy()
	SHA.CFrame=poss
	SHA.Anchored=true
	local done=false
	local half=false
	OnHumanoidFind(SHA, cf(0,0,0), function(proot,phum,body)
		local dmg = math.random(5,13)
		phum.Health = phum.Health - dmg
		pcall(function()
			showDmg(body, Character,  dmg, {Rod=false,RodTrans=0,Crit=math.random()>.9})
		end)
	end, 7, true)
	spawn(function()
		while lwait(.5) and not done do
			OnHumanoidFind(SHA, cf(0,0,0), function(proot,phum,body)
				local dmg = math.random(3,7)
				phum.Health = phum.Health - dmg
				pcall(function()
					showDmg(body, Character,  dmg, {Rod=false,RodTrans=0,Crit=math.random()>.9})
				end)
			end, 7, true)
		end
	end)
	trail=true
	spawn(function()
		repeat lrs:wait();lrs:wait();lrs:wait()
			--local ptc1 = effects:particle(.1,.5,1,'Block', SHI.CFrame,{'Alder', 'Pearl'})
			local ptc2 = effects:particle(.1,.5,2,'Cylinder',SHI.CFrame,{'Alder', 'Pearl'})
			local ss=3.4
			--for i,v in next, ptc1 do Tween(v, 1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out, {Size=Vector3.new(ss,ss,ss)}) end
			for i,v in next, ptc2 do Tween(v, 1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out, {Size=Vector3.new(ss,ss,ss)}) end
		until done
	end)
	spawn(function()
		snd(233856097,root,true)
		local lp = snd(235097691,root,true,{Pitch=.45,Looped=true})
		for i = 0,360,10 do
			local set = (root.CFrame*cf(0,0,-1-(-1/(360/(360-i))))*ang(0,math.rad(i),0)*offset*ang(rad(i),0,rad(i*3))*cf(1.5,0,0))
			SHA.CFrame = set
			lrs:wait()
		end
		for i = 0,200,10 do
			local set = (root.CFrame*cf(0,0,-1/(360/(360-i)))*ang(0,math.rad(i),0)*offset*ang(rad(13),0,rad(i*3))*cf(6,0,0))
			SHA.CFrame = set
			lrs:wait()
		end
		half=true
		for i = 200,360,10 do
			local set = (root.CFrame*cf(0,0,-1/(360/(360-i)))*ang(0,math.rad(i),0)*offset*ang(rad(9),0,rad(i*3))*cf(6,0,0))
			SHA.CFrame = set
			lrs:wait()
		end
		lp:Destroy()
		done=true
		trail=false
	end)
	lwait(.3)
	TweenJoints{
		Style = 'Quint',
		Direction = 'In',
		Time = .3,
		Right_Arm_ = CFrame.new(0.998920679, 0.14364481, 1.68959856, 0.300145298, -0.618172228, 0.726481915, -0.0739984512, 0.74421227, 0.663831592, -0.951018989, -0.253004432, 0.177628011),
		Left_Arm_ = CFrame.new(-1.36803436, -0.0923654437, -1.48961067, 0.0884984732, 0.600464821, 0.794741571, -0.0683499575, 0.799651325, -0.596564591, -0.993728042, -0.00152620673, 0.111809149),
		Right_Leg_ = CFrame.new(0.10795176, 0.137223721, -0.322895944, 0.868303895, -0.172812983, -0.464955926, -0.00150111609, 0.936429739, -0.350851864, 0.496030331, 0.305344015, 0.812846243),
		Left_Leg_ = CFrame.new(0.24675554, -0.16530633, 1.2665987e-06, 0.976619899, 0.214973375, 3.57627869e-06, -0.21497333, 0.976620018, 1.66893005e-06, -3.1888485e-06, -2.38418579e-06, 1),
		Head_ = CFrame.new(0.0915586054, 0.0196099281, -0.111794382, 0.869667768, -0.0338301063, -0.492476821, 0.104621723, 0.987616539, 0.116908997, 0.482423246, -0.153195754, 0.862437844),
		Torso_ = CFrame.new(-0.315471649, -0.31086731, -0.393325806, 0.394115746, -0.218366832, 0.892742395, -0.170076683, 0.937257767, 0.304338545, -0.903187037, -0.271779239, 0.332248896),
	}
	snd(588693579,root,true)
	TweenJoints{
		Style = 'Linear',
		Direction = 'Out',
		Time = .2,
		Right_Arm_ = CFrame.new(0.0439815521, -0.135678574, -0.440430045, 0.806191146, 0.397307813, -0.438409001, -0.0213991497, 0.76008296, 0.649473667, 0.591268122, -0.514218271, 0.621274173),
		Left_Arm_ = CFrame.new(0.236092269, 0.785143495, 0.332070351, 0.558541417, -0.762449682, 0.326653212, 0.206355974, -0.253699929, -0.945015788, 0.803398728, 0.595236301, 0.0156343132),
		Right_Leg_ = CFrame.new(-0.351975918, -0.201288223, -0.3103953, 0.947356284, -0.32018137, 3.57627869e-06, 0.315506399, 0.93352598, 0.170250237, -0.0545143187, -0.161286473, 0.985400915),
		Left_Leg_ = CFrame.new(-0.178579241, 0.00266909599, -0.383025676, 0.642761528, -3.51574272e-08, 0.766066432, 7.49423634e-09, 1.00000024, 3.99304554e-08, -0.766066551, -1.94413587e-08, 0.64276135),
		Head_ = CFrame.new(3.9100647e-05, 3.93390656e-06, -0.00303199375, 0.584618986, 0, 0.811308026, 0.00245903619, 0.99999547, -0.00177195237, -0.811304271, 0.0030309523, 0.584616244),
		Torso_ = CFrame.new(0.00667190552, -0.00287604332, -0.000377655029, 0.584618986, 0.00245892606, -0.811304271, -0.00245809881, 0.999996245, 0.0012598458, 0.811303556, 0.00125774904, 0.584622204),
	}
	OnHumanoidFind(Left_Arm, cf(0,0,0), function(proot,phum,body)
		local dmg = math.random(3,9) * (rand()>.8 and 2 or 1)
		phum.Health = phum.Health - dmg
		pcall(function()
			showDmg(body, Character,  dmg, {Rod=true,RodTrans=0,Crit=dmg>9})
		end)
	end, 10, true)
	repeat lrs:wait() until half
	TweenJoints{
		Style = 'Linear',
		Direction = 'Out',
		Time = .15,
		Right_Arm_ = CFrame.new(0.829519689, 0.381413698, -1.57987428, 0.374878913, -0.927073777, 4.05236804e-08, -0.00280904677, -0.00113593217, -0.99999547, 0.927069545, 0.374877214, -0.00303003029),
		Left_Arm_ = CFrame.new(-0.519713402, -0.873377562, -0.158320561, 0.739482224, 0.668240309, 0.0813785493, -0.665690601, 0.74387598, -0.0592175536, -0.100107282, -0.0103825331, 0.994922578),
		Right_Leg_ = CFrame.new(3.68356705e-05, -0.0779465437, -0.447928578, 1.00000942, -2.08616257e-07, 2.38418579e-07, -1.59139745e-07, 0.975493431, 0.220059082, -7.74860382e-07, -0.22006014, 0.97549367),
		Left_Leg_ = CFrame.new(0.246763051, -0.165307999, 5.43892384e-06, 0.97661984, 0.21497333, 1.34110451e-06, -0.21497333, 0.976619899, -5.21395123e-07, -1.43051147e-06, 2.16066837e-07, 1),
		Head_ = CFrame.new(-0.175744906, 0.0174450874, 0.14690578, 0.648833036, 0.1171887, -0.75185281, -0.00230547017, 0.988368213, 0.152063951, 0.76092732, -0.0969307423, 0.641555905),
		Torso_ = CFrame.new(-0.00162887573, -0.00289463997, 0.00579071045, 0.374878913, -0.0028091569, 0.927069545, 0.00280869659, 0.999994338, 0.00189410418, -0.92706871, 0.00189380953, 0.374884337),
	}
	snd(231917871,root,true)
	repeat lrs:wait() until done
	SHA.Anchored=false
	shw = Weld(Right_Arm, SHA, Right_Arm.CFrame:toObjectSpace(SHA.CFrame))
	Tween(shw,.25/2,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,{C1=cf(0,-1,0)*ang(0,-rad(0),-rad(90))})
	lwait(.25/2)
	Tween(shw,.25/2,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,{C1=cf(0,-1,0)*ang(0,-rad(90),-rad(90))})
	lwait(.25/2)
	dkd,ds = false,false
end


hum.MaxHealth = Max_Health
lwait(.1)
hum.Health = Max_Health
HumanoidRootPart.Transparency = 1

local debvals={};
debvals['CLEAN']=0
debvals['walkparticles']=0
local Handle = function()
	spawn(function()
		for i,v in next, effects.MagicCircles do
			if v[1].Parent ~= nil then
				v[1].CFrame = lerp(v[1].CFrame, v[1].CFrame * CFrame.Angles(0,0,rad(v[4])), .9)
			else
				--table.remove(effects.MagicCircles,i)
				effects.MagicCircles[i]=nil
			end
		end
	end)
	spawn(function()
		for ting,data in next, trans do
			if ting.Transparency~=nil and ting.Transparency < data[2] then
				--print(ting.Transparency,data[2])
				ting.Transparency=ting.Transparency+data[1]
			elseif ting.Transparency >= tonumber(data[2]) and ting.Parent ~= nil then
				--print'ded'
				trans[ting]=nil
				ting:Destroy()
			end
		end
	end)
	spawn(function()
		for a,b in next, grows do
			if a==grows[15] then
				grows={};
				for i,v in next, grows do
					grows[i]=v
				end
				print'ded'
			else
				if #b > 1 then
					for __,v in next, b[1] do
						if v.Parent ~= nil then
							if v.Transparency > 1 then
								v:Destroy()
							else
								local c=v.CFrame
								v.Size=v.Size+b[2] or vec3(b[2],b[2],b[2]) or vec3(0,0,0)
								v.CFrame=c*b[3] or cf(0,0,0)
							end
						else
							b[1][__]=nil
						end
					end
				else
					grows[a]=nil
				end
			end
		end
	end)
	local actual,floor = CheckIfLanded(5)
	if debvals['CLEAN'] > 40 then
		debvals['CLEAN']=0
		grows={};
		trans={};
		effects.MagicCircles={};
		for i,v in next, FX:children() do
			v:Destroy()
		end
	end
	for i,v in next,debvals do
		debvals[i]=v+.1
		--print(i,v)
	end
end

--_G.g=function(mdl)local t,s=0 function s(p)for i,v in next,p:children()do if v:IsA'Part'then t=t+v:GetMass()end;s(v)end;end s(mdl) return t end

Mouse.KeyDown:connect(function(Key)
	if Key:byte() == 48 then
		Walking = false
	elseif Key:byte() == 93 then
		table.foreach(keyz,print)
	end
end)

Mouse.KeyUp:connect(function(Key)
	if Key:byte() == 48 then
		Walking = true
	end
end)

local ComboResetTime,canatk = .1,true
local combo = 0
local output_clicks = false

function ComboUp()
	if dkd == true then return end
	if combo == 0 and canatk == true then
		canatk = false
		Attack1()
		combo = 1
		canatk = true
		spawn(function()
			ds = true
			lwait(ComboResetTime)
			if canatk == true then
				ds = false
			end
			if combo == 1 and not ds then
				combo = 0
			end
		end)
		return
	end
	if combo == 1 and canatk == true then
		canatk = false
		--print'2'
		Attack2()
		combo = 2
		canatk = true
		spawn(function()
			ds = true
			lwait(ComboResetTime)
			if canatk == true then
				ds = false
			end
			if combo == 2 and not ds then
				combo = 0
			end
		end)
		return
	end
	if combo == 2 and canatk == true then
		canatk = false
		Attack3()
		combo = 3
		canatk = true
		spawn(function()
			ds = true
			lwait(ComboResetTime)
			if canatk == true then
				ds = false
			end
			if combo == 3 and not ds then
				combo = 0
			end
		end)
		return
	end
	if combo == 3 and canatk == true then
		canatk = false
		Attack4()
		combo = 0
		lwait(ComboResetTime)
		canatk = true
		spawn(function()
			if canatk == true then
				ds = false
			end
			if combo == 0 and not ds then
				combo = 0
			end
		end)
		return
	end
end

mouse.Button1Down:connect(function()
	ComboUp()	
end)

local can=true
function FootStep()
	if root.CFrame.Y < -10 then
		root.CFrame = cf(rand(-10, 10), 5, rand(-10, 10))
	end
	if can then
		--// continue
	else
		return
	end
	can=false
	delay(.2,function()
		can=true
	end)
	local ping = Instance.new('Sound',Torso)
	local ov = .5
	local pitches={}
	for i = -.05,.05,.005 do table.insert(pitches,1+i) end
	ping.Volume = .25/ov
	game:service'RunService'.RenderStepped:wait()
	local ray = Ray.new(HumanoidRootPart.CFrame.p,(HumanoidRootPart.CFrame.p-(HumanoidRootPart.CFrame*cf(0,2.5,0)).p).unit*3.15)
	local Hit,Pos = workspace:FindPartOnRayWithIgnoreList(ray, {Char})
	if Hit and (Hit:IsDescendantOf(Character) == false) then
		local num=0
		if Hit.Material == Enum.Material.Plastic or Hit.Material == Enum.Material.SmoothPlastic then
			local ss={379483672, 379398649};
			ping.SoundId = rbx..ss[math.random(1,#ss)]
			ping.Pitch = pitches[math.random(1,#pitches)]
			ping:Play()
			return
		end
		if Hit.Material == Enum.Material.Grass then
			ping.SoundId = rbx..379482039
			ping.Volume = .05/ov
			ping.Pitch = pitches[math.random(1,#pitches)]
			ping:Play()
			return
		end
		if Hit.Material == Enum.Material.Neon then
			ping.SoundId = rbx..236989198
			ping.Volume = 1/ov
			ping.Pitch = pitches[math.random(1,#pitches)]
			local ping2 = Instance.new('Sound',Torso)
			ping2.Volume = .075/ov
			ping2.SoundId = rbx..379482691
			ping2.Pitch = pitches[math.random(1,#pitches)]
			ping:Play()
			ping2:Play()
			return
		end
		if Hit.Material == Enum.Material.Metal or Hit.Material == Enum.Material.DiamondPlate or Hit.Material == Enum.Material.CorrodedMetal then
			local ss={379482691,};
			ping.SoundId = rbx..ss[math.random(1,#ss)]			
			ping.Volume = .5/ov
			ping.Pitch = pitches[math.random(1,#pitches)]
			ping:Play()
			return
		end --510932495
		if Hit.Material == Enum.Material.WoodPlanks or Hit.Material == Enum.Material.Wood then
			local ss={ 379484117};
			ping.SoundId = rbx..ss[math.random(1,#ss)]
			ping.Volume = .15/ov
			ping.Pitch = pitches[math.random(1,#pitches)]
			ping:Play()
			return
		end 
		if Hit.Material == Enum.Material.Ice or Hit.Material == Enum.Material.Foil then
			local ss={ 510932495};
			ping.SoundId = rbx..ss[math.random(1,#ss)]
			ping.Volume = .5/ov
			ping.Pitch = pitches[math.random(1,#pitches)]
			ping:Play()
			return
		end 
		if Hit.Material == Enum.Material.Fabric or Hit.Material == Enum.Material.Sand or Hit.Name == 'Snow' then
			--warn'derp'
			local ss={145536125,145536149};
			ping.SoundId = rbx..ss[math.random(1,#ss)]
			ping.Pitch = pitches[math.random(1,#pitches)]
			ping:Play()
			return
		end
		if Hit.Material == Enum.Material.Slate or Hit.Material == Enum.Material.Pebble or Hit.Material == Enum.Material.Marble or Hit.Material == Enum.Material.Brick or Hit.Material == Enum.Material.Cobblestone or Hit.Material == Enum.Material.Concrete or Hit.Material == Enum.Material.Granite  then
			local ss={379483672, 379398649};
			ping.SoundId = rbx..ss[math.random(1,#ss)]
			ping.Volume = .5/ov
			ping.Pitch = pitches[math.random(1,#pitches)]
			ping:Play()
			return
		end
	end
end

local upv=0

srs:connect(function()
	sine = tick() * (change * 25)
	Handle()
end)

local once=false
lrs:connect(function()
	Trail.Enabled=trail
	Landed = CheckIfLanded()
    hum.PlatformStand = false
	if ds then
		if Mode == 'Running' and  not once then
			once=true
			spawn(function()
				FadeSword'In'
			end)
		end
		return
	end
    hum.JumpPower = 0
    hum.Jump=false
	hum.WalkSpeed = hum.WalkSpeed + (walkspd - hum.WalkSpeed) * .1;
	walkspd=7
	if not Walking then
		walkspd = 25
	end
	local tmag_xz = (torso.Velocity*vec3(1, 0, 1)).magnitude
	local tmag_y = torso.Velocity.Y
	local trot = torso.RotVelocity.Y/50
	local speed = Vector3.new(Torso.Velocity.X,0,Torso.Velocity.Z)
	local TiltOnAxis = (root.CFrame-root.CFrame.p):inverse()*speed/200
	local Tilt = ang(TiltOnAxis.Z,-TiltOnAxis.X,-TiltOnAxis.X)
	if Landed == false then
		State, Mode = 'Falling', 'Normal'
	elseif tmag_xz < 3 then
			State, Mode = 'Idle', 'Normal'
	elseif tmag_xz >= 4 then
		State = 'Walking'
		if tmag_xz > 20 then
			Mode = 'Running'
		else
			Mode = 'Normal'
		end
	end
	local RestoreDefault = function(Current)
		Current = Current or State
		local Current2 = Mode
		if LastMode ~= Current2 then
			if Current2 == 'Running' then
				spawn(function()
					FadeSword'Out'
				end)
			elseif Current2 ~= 'Running' or once then
				spawn(function()
					FadeSword'In'
				end)
			end
			LastMode = Current2
		end
		if LastState ~= Current then
			LastState = Current
			sine = 0
		end
    end
    once=false
    local Default_Anims = function()
		local animspd = .1
		local Right_Arm_ = cf(0,0,0)
		local Left_Arm_ = cf(0,0,0)
		local Right_Leg_ = cf(0,0,0)
		local Left_Leg_ = cf(0,0,0)
		local Head_ = cf(0,0,0)
		local Torso_ = cf(0,0,0)
		
		torw.C0 = clerp(torw.C0, cf(0,0,0)*Torso_*ang(0,0,0),animspd)
		hedw.C0 = clerp(hedw.C0, cf(0,0,0)*Head_*ang(0,0,0),animspd)
		law.C0 = clerp(law.C0, cf(0,0,0)*Left_Arm_*ang(0,0,0),animspd)
		raw.C0 = clerp(raw.C0, cf(0,0,0)*Right_Arm_*ang(0,0,0),animspd)
		rlw.C0 = clerp(rlw.C0, cf(0,0,0)*Right_Leg_*ang(0,0,0),animspd)
		llw.C0 = clerp(llw.C0, cf(0,0,0)*Left_Leg_*ang(0,0,0),animspd)
    end
    if State == 'Falling' and ds == false then
		
    elseif State == 'Idle' and ds == false then
		RestoreDefault()
		if Mode == 'Normal' and ds == false then
			local animspd = .125
			change = .35
			local Right_Arm_ = CFrame.new(0.467620611, -0.552611947, -0.132565618, 0.842239499, -0.53289324, -0.0816002488, 0.520031989, 0.842986345, -0.137627944, 0.142128706, 0.0734807402, 0.987117887)
			local Left_Arm_ = CFrame.new(-0.781376958, 0.0332048535, -1.34890664, 0.59977144, 0.799722373, -0.0268236771, -0.304636121, 0.197214842, -0.931828678, -0.739913702, 0.567055464, 0.361907959)
			local Right_Leg_ = CFrame.new(-0.272229075, -0.24053812, 0.000354528427, 0.955758393, -0.294165701, -1.257658e-05, 0.294165134, 0.955759764, 6.22232903e-07, 1.13546848e-05, -4.07546759e-06, 1.00000012)
			local Left_Leg_ = CFrame.new(0.0260814428, 0.0450050831, -0.361847639, 0.775439262, 0.110567033, 0.621666431, -0.0906994343, 0.993843734, -0.0636264831, -0.624874234, -0.00704631209, 0.780693769)
			local Head_ = CFrame.new(0.270924807, 0.0874993801, 0.260071456, 0.390913397, -0.180617183, 0.90253222, -0.0901362225, 0.96833241, 0.23282595, -0.916003525, -0.172365636, 0.362253964)
			local Torso_ = CFrame.new(0.0059170723, -0.182877302, -0.00212669373, 0.392511159, 0, -0.919747353, 0, 1, 0, 0.919747353, 0, 0.392511159)
			
			torw.C0 = clerp(torw.C0, cf(0,0,0)*Torso_*ang(0,0,0),animspd)
			hedw.C0 = lerp(hedw.C0, cf(0,0,-cos(sine/8)/16)*Head_*ang(cos(sine/8)/16,0,0),animspd)
			law.C0 = lerp(law.C0, cf(sin(sine/8)/20,cos(sine/8)/14,0)*Left_Arm_*ang(cos(sine/8)/14,0,sin(sine/8)/20),animspd)
			raw.C0 = lerp(raw.C0, cf(0,.5+sin(sine/8)/14,-.5)*Right_Arm_*ang(rad(70)+sin(sine/8)/14,0,0),animspd)
			rlw.C0 = clerp(rlw.C0, cf(0,0,0)*Right_Leg_*ang(0,0,0),animspd)
			llw.C0 = clerp(llw.C0, cf(0,0,0)*Left_Leg_*ang(0,0,0),animspd)
			rhw.C0 = clerp(rhw.C0, cf(0,0,0)*ang(0,0,0),animspd)
			lhw.C0 = clerp(lhw.C0, cf(0,0,0)*ang(0,0,0),animspd)
			shw.C0 = clerp(shw.C0, cf(0,0,0)*ang(0,-rad(15),rad(70)), animspd)
		else
			Default_Anims()
			warn'Idle: Unknown Mode Used'
		end
    elseif State == 'Walking' and ds == false then
		RestoreDefault()
		if Mode == 'Normal' and ds == false then
			local up = sin(sine/6)
			if math.abs(up)>=.995 then
				local actual,floor = CheckIfLanded(7)
				local clrs={'Really black','Pearl'}
				local mtrl='Neon'
				local ss = 3
				if actual then
					clrs={tostring(floor.BrickColor)}
					mtrl=floor.Material
				end
				FootStep()
				if up > 0 then
					
				else
					
				end
			end
			local animspd = .25
			change = 1.4
			local Right_Arm_ = cf(0,0,0)
			local Left_Arm_ = cf(0,0,0)
			local Right_Leg_ = cf(0,0,0)
			local Left_Leg_ = cf(0,0,0)
			local Head_ = cf(0,0,0)
			local Torso_ = cf(0,0,0)
			
			torw.C0 = clerp(torw.C0, cf(0,-.2,0)*Torso_*ang(-rad(12)+sin(sine/3)/18,sin(sine/6)/13,0),animspd)
			hedw.C0 = clerp(hedw.C0, cf(0,0,-rad(4))*Head_*ang(rad(4),0,0),animspd)
			law.C0 = clerp(law.C0, cf(-.265,-.359/2,sin(sine/6)/4)*Left_Arm_*ang(-sin(sine/6)/4,0,-rad(20)),animspd)
			raw.C0 = clerp(raw.C0, cf(.265+cos(sine/6)/8,(-.359/2)+.65,-.85)*Right_Arm_*ang(rad(90),0,rad(20)+cos(sine/6)/8),animspd)
			rlw.C0 = clerp(rlw.C0, cf(-.034/2,.1-cos(sine/6)/4,-.4+cos(sine/6)/4+-sin(sine/6)/2)*ang(-rad(5)+-sin(sine/6)/2,-sin(sine/6)/13,rad(1)),animspd)
    		llw.C0 = clerp(llw.C0, cf(.034/2,.1+cos(sine/6)/4,-.4+-cos(sine/6)/4+sin(sine/6)/2)*ang(-rad(5)+sin(sine/6)/2,-sin(sine/6)/13,-rad(1)),animspd)
			
    		rhw.C0 = clerp(rhw.C0, cf(0,0,0)*ang(0,0,0),animspd)
			lhw.C0 = clerp(lhw.C0, cf(0,0,0)*ang(0,0,0),animspd)
			shw.C0 = clerp(shw.C0, cf(0,0,0)*ang(0,rad(15),rad(70)), .1)
		elseif Mode == 'Running' and ds == false then
			local up = sin(sine/6)
			if math.abs(up)>=.995 then
				local actual,floor = CheckIfLanded(7)
				local clrs={'Really black','Pearl'}
				local mtrl='Neon'
				local ss = 3
				if actual then
					clrs={tostring(floor.BrickColor)}
					mtrl=floor.Material
				end
				FootStep()
				if up > 0 then
					
				else
					
				end
			end
			local animspd = .25
			change = 1.4
			local Right_Arm_ = cf(0,0,0)
			local Left_Arm_ = cf(0,0,0)
			local Right_Leg_ = cf(0,0,0)
			local Left_Leg_ = cf(0,0,0)
			local Head_ = cf(0,0,0)
			local Torso_ = cf(0,0,0)
			
			torw.C0 = clerp(torw.C0, cf(0,-.2,0)*Torso_*ang(-rad(12)+sin(sine/3)/18,sin(sine/6)/13,0),animspd)
			hedw.C0 = clerp(hedw.C0, cf(0,0,-rad(4))*Head_*ang(rad(4),0,0),animspd)
			law.C0 = clerp(law.C0, cf(-.265,-.359/2,sin(sine/6)/4)*Left_Arm_*ang(-sin(sine/6)/4,0,-rad(20)),animspd)
			raw.C0 = clerp(raw.C0, cf(.265,-.359/2,-sin(sine/6)/4)*Right_Arm_*ang(sin(sine/6)/4,0,rad(20)),animspd)
			rlw.C0 = clerp(rlw.C0, cf(-.034/2,.1-cos(sine/6)/4,-.4+cos(sine/6)/4+-sin(sine/6)/2)*ang(-rad(5)+-sin(sine/6)/2,-sin(sine/6)/13,rad(1)),animspd)
    		llw.C0 = clerp(llw.C0, cf(.034/2,.1+cos(sine/6)/4,-.4+-cos(sine/6)/4+sin(sine/6)/2)*ang(-rad(5)+sin(sine/6)/2,-sin(sine/6)/13,-rad(1)),animspd)
			
    		rhw.C0 = clerp(rhw.C0, cf(0,0,0)*ang(0,0,0),animspd)
			lhw.C0 = clerp(lhw.C0, cf(0,0,0)*ang(0,0,0),animspd)
			shw.C0 = clerp(shw.C0, cf(0,0,0)*ang(0,rad(15),rad(70)), .1)
		else --// 59426=74955
			Default_Anims()
			warn'Walking: Unknown Mode Used'
		end
    else --// New Animation Test Stage
		local animspd = .1
		local Right_Arm_ = cf(0,0,0)
		local Left_Arm_ = cf(0,0,0)
		local Right_Leg_ = cf(0,0,0)
		local Left_Leg_ = cf(0,0,0)
		local Head_ = cf(0,0,0)
		local Torso_ = cf(0,0,0)
		
		torw.C0 = clerp(torw.C0, cf(0,0,0)*Torso_*ang(0,0,0),animspd)
		hedw.C0 = clerp(hedw.C0, cf(0,0,0)*Head_*ang(0,0,0),animspd)
		law.C0 = clerp(law.C0, cf(0,0,0)*Left_Arm_*ang(0,0,0),animspd)
		raw.C0 = clerp(raw.C0, cf(0,0,0)*Right_Arm_*ang(0,0,0),animspd)
		rlw.C0 = clerp(rlw.C0, cf(0,0,0)*Right_Leg_*ang(0,0,0),animspd)
		llw.C0 = clerp(llw.C0, cf(0,0,0)*Left_Leg_*ang(0,0,0),animspd)
    end
        
end)

--[[ Default Welds
		local animspd = .3
		change = 1
		
		local Right_Arm_ = cf(0,0,0)
		local Left_Arm_ = cf(0,0,0)
		local Right_Leg_ = cf(0,0,0)
		local Left_Leg_ = cf(0,0,0)
		local Head_ = cf(0,0,0)
		local Torso_ = cf(0,0,0)

		torw.C0 = clerp(torw.C0, cf(0,0,0)*Torso_*ang(0,0,0),animspd)
		hedw.C0 = clerp(hedw.C0, cf(0,0,0)*Head_*ang(0,0,0),animspd)
		law.C0 = clerp(law.C0, cf(0,0,0)*Left_Arm_*ang(0,0,0),animspd)
		raw.C0 = clerp(raw.C0, cf(0,0,0)*Right_Arm_*ang(0,0,0),animspd)
		rlw.C0 = clerp(rlw.C0, cf(0,0,0)*Right_Leg_*ang(0,0,0),animspd)
		rhw.C0 = clerp(rhw.C0, cf(0,0,0)*ang(0,0,0),animspd)
		lhw.C0 = clerp(lhw.C0, cf(0,0,0)*ang(0,0,0),animspd)
		shw.C0 = clerp(shw.C0, cf(0,0,0)*ang(0,0,0),animspd)
		
--]]

Player.Chatted:connect(function(Message)
	if Message == '~debug' then
		ds,dkd=false,false
		for i,v in next, FX:children() do
			v:Destroy()
		end
		FadeSword'In'
	end
end)

LG.Parent, RG.Parent, Melee.Parent = Character,Character,Character
script:ClearAllChildren()

print("Press ']' to see all KeyBinds")
print('Say ~debug to... debug..............................')

       