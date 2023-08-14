-------------------||
--------------------\
--||||||||||]]]]]]]]]\
---------------------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
--EDIT OF MURDER BY IGNORANTROJO AND INFINITEONEWITHDANK                                   |]]>>
--NAME OF SCRIPT: CRESCENDIAC V2                                                           |]]>>
---------------------////////////////////////////////////////////////////////////////////////
--||||||||||]]]]]]]]]//
--------------------//
-------------------||

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

Player = game:GetService("Players").LocalPlayer
Mouse, mouse = Player:GetMouse(), Player:GetMouse()
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = Player.Character
Humanoid = Character.Humanoid
RootPart = Character["HumanoidRootPart"]
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
RW = Torso["Right Shoulder"]
LW = Torso["Left Shoulder"]
LH = Torso["Left Hip"]
RH = Torso["Right Hip"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor
CF = CFrame.new
angles = CFrame.Angles
attack = false
Euler = CFrame.fromEulerAnglesXYZ
Rad = math.rad
IT = Instance.new
BrickC = BrickColor.new
Cos = math.cos
Acos = math.acos
Sin = math.sin
Asin = math.asin
Abs = math.abs
Mrandom = math.random
Floor = math.floor
radian = math.rad
Rad = math.rad
Sin = math.sin
cos = math.cos
random = math.random
Vec3 = Vector3.new
Inst = Instance.new
cFrame = CFrame.new
Euler = CFrame.fromEulerAnglesXYZ
vt = Vector3.new
bc = BrickColor.new
br = BrickColor.random
it = Instance.new
cf = CFrame.new
local cn = CFrame.new
local plr = Player
local char = plr.Character
local hum = char.Humanoid
local hed = char.Head
local root = char.HumanoidRootPart
local rootj = root.RootJoint
local tors = char.Torso
local ra = char["Right Arm"]
local la = char["Left Arm"]
local rl = char["Right Leg"]
local ll = char["Left Leg"]
local neck = tors["Neck"]

if Player.Name == "Taphly" or Player.Name == "Cloudcroix0123" then
	Player:Kick("Don't ever fucking trade the script around again, you hear me?")
end
--//=================================\\
--|| 	      USEFUL VALUES
--\\=================================//
local SIZE = 1
Animation_Speed = 3
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)
local Speed = 12
local CrossedArms = true
local SELFDEFENSE = false
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local EQUIPPED = false
local HOLD = false
local COMBO = 1
local Rooted = false
local SINE = 0
local sine = 0
local change = 1
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
--ROBLOXIDLEANIMATION.Parent = Humanoid
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "[C R E S C E]"
local Effects = IT("Folder", Character)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
local UNANCHOR = true
local MODE = "CRES"
local WeaponB = IT("Model")
WeaponB.Name = "Add-ons"
local RootCF = CFrame.fromEulerAnglesXYZ(-1.57, 0, 3.14)
local RHCF = CFrame.fromEulerAnglesXYZ(0, 1.6, 0)
local LHCF = CFrame.fromEulerAnglesXYZ(0, -1.6, 0)
--//=================================\\
--\\=================================//
local actualrotationvalue = 0

--//=================================\\
--|| SAZERENOS' ARTIFICIAL HEARTBEAT
--\\=================================//

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.ArtificialHB:Fire()
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

--//=================================\\
--\\=================================//

local Speed = 12

--//=================================\\
--|| 	      SOME FUNCTIONS
--\\=================================//

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

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

local function weldBetween(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end


function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then 
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end

function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end

function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
function clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = IT("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end

function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end

function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end

function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end

local S = IT("Sound")
function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat wait(1) until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end

function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end

--WACKYEFFECT({EffectType = "", Size = VT(1,1,1), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = CF(), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
function WACKYEFFECT(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or VT(1,1,1))
	local ENDSIZE = (Table.Size2 or VT(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			for LOOP = 1, TIME+1 do
				Swait()
				MSH.Scale = MSH.Scale - GROWTH/TIME
				if TYPE == "Wave" then
					MSH.Offset = VT(0,0,-MSH.Scale.X/8)
				end
				EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
				if TYPE == "Block" then
					EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				else
					EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
				end
				if MOVEDIRECTION ~= nil then
					local ORI = EFFECT.Orientation
					EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
					EFFECT.Orientation = ORI
				end
			end
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end
	end))
end

Debris = game:GetService("Debris")

function CharacterFade(COLOR,TIMER)
	coroutine.resume(coroutine.create(function()
		local FADE = IT("Model",Effects)
		FADE.Name = "FadingEffect"
		for _, c in pairs(Character:GetChildren()) do
			if c.ClassName == "Part" and c ~= RootPart then
				local FADER = c:Clone()
				FADER.Color = COLOR
				FADER.CFrame = c.CFrame
				FADER.Parent = FADE
				FADER.Anchored = true
				FADER.Transparency = 0.25+c.Transparency
				FADER:BreakJoints()
				FADER.Material = "Neon"
				if FADER.Name == "Head" then
					FADER:ClearAllChildren()
					FADER.Size = VT(1,1,1)
				end
				FADER.CanCollide = false
			end
		end
		local TRANS = 0.75/TIMER
		for i = 1, TIMER do
			Swait()
			for _, c in pairs(FADE:GetChildren()) do
				if c.ClassName == "Part" then
					c.Transparency = c.Transparency + TRANS
				end
			end
		end
		FADE:remove()
	end))
end

function Chunks(PART)
	for i = 1, MRANDOM(3,5) do
		coroutine.resume(coroutine.create(function()
			local CHUNK = CreatePart(3, workspace, PART.Material, 0, PART.Transparency, PART.BrickColor, "Chunk", VT(0.3,0.3,0.3)*MRANDOM(7,13)/10, false)
			CHUNK.CFrame = PART.CFrame*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
			local CFRAME = PART.CFrame*CF(MRANDOM(-4,4)/2,MRANDOM(-4,4)/2,-6)
			CHUNK.Velocity = CF(PART.Position,CFRAME.p).lookVector*MRANDOM(15,65)
			wait(0.1)
			CHUNK.CanCollide = true
			wait(MRANDOM(15,25)/5)
			for i = 1, 25 do
				Swait()
				CHUNK.Transparency = CHUNK.Transparency + 1/25
			end
			CHUNK:remove()
		end))
	end
end

function CreateFlyingDebree(FLOOR,POSITION,AMOUNT,BLOCKSIZE,SWAIT,STRENGTH)
	if FLOOR ~= nil then
		for i = 1, AMOUNT do
			local DEBREE = CreatePart(3, Effects, "Neon", FLOOR.Reflectance, FLOOR.Transparency, "Peal", "Debree", BLOCKSIZE, false)
			DEBREE.Material = FLOOR.Material
			DEBREE.Color = FLOOR.Color
			DEBREE.CFrame = POSITION * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)))
			DEBREE.Velocity = VT(MRANDOM(-STRENGTH,STRENGTH),MRANDOM(-STRENGTH,STRENGTH),MRANDOM(-STRENGTH,STRENGTH))
			coroutine.resume(coroutine.create(function()
				Swait(15)
				DEBREE.Parent = workspace
				DEBREE.CanCollide = true
				Debris:AddItem(DEBREE,SWAIT)
			end))
		end
	end
end

--//=================================\\
--||	    GUIS AND MISC
--\\=================================//

local BODY = {}
for _, c in pairs(Character:GetDescendants()) do
	if c:IsA("BasePart") and c.Name ~= "Handle" then
		if c ~= RootPart and c ~= Torso and c ~= Head and c ~= RightArm and c ~= LeftArm and c ~= RightLeg and c ~= LeftLeg then
			c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
		table.insert(BODY,{c,c.Parent,c.Material,c.Color,c.Transparency})
	elseif c:IsA("JointInstance") then
		table.insert(BODY,{c,c.Parent,nil,nil,nil})
	end
end
for e = 1, #BODY do
	if BODY[e] ~= nil then
		local STUFF = BODY[e]
		local PART = STUFF[1]
		local PARENT = STUFF[2]
		local MATERIAL = STUFF[3]
		local COLOR = STUFF[4]
		local TRANSPARENCY = STUFF[5]
		if PART.ClassName == "Part" and PART ~= RootPart then
			PART.Material = MATERIAL
			PART.Color = COLOR
			PART.Transparency = TRANSPARENCY
		end
		PART.AncestryChanged:Connect(function()
			PART.Parent = PARENT
		end)
	end
end

function refit()
	Character.Parent = workspace
	for e = 1, #BODY do
		if BODY[e] ~= nil then
			local STUFF = BODY[e]
			local PART = STUFF[1]
			local PARENT = STUFF[2]
			local MATERIAL = STUFF[3]
			local COLOR = STUFF[4]
			local TRANSPARENCY = STUFF[5]
			if PART:IsA("BasePart") and PART ~= RootPart then
				PART.Material = MATERIAL
				PART.Color = COLOR
				PART.Transparency = TRANSPARENCY+EXTRATRANS
			end
			if PART.Parent ~= PARENT then
				Humanoid:remove()
				PART.Parent = PARENT
				Humanoid = IT("Humanoid",Character)
			end
		end
	end
end

local Particle = IT("ParticleEmitter",nil)
Particle.Enabled = false
Particle.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(0.3,0),NumberSequenceKeypoint.new(1,1)})
Particle.LightEmission = 0.5
Particle.Rate = 150
Particle.ZOffset = 0.2
Particle.Rotation = NumberRange.new(-180, 180)
Particle.RotSpeed = NumberRange.new(-180, 180)
Particle.Texture = "http://www.roblox.com/asset/?id=304437537"
Particle.Color = ColorSequence.new(C3(255,0,0),C3(0,0,155),C3(0,255,255),C3(255,0,255),C3(255,255,0),C3(150,0,0),C3(0,191,0),C3(0,0,150))

--ParticleEmitter({Speed = 5, Drag = 0, Size1 = 1, Size2 = 5, Lifetime1 = 1, Lifetime2 = 1.5, Parent = Torso, Emit = 100, Offset = 360, Enabled = false})
function ParticleEmitter(Table)
	local PRTCL = Particle:Clone()
	local Speed = Table.Speed or 5
	local Drag = Table.Drag or 0
	local Size1 = Table.Size1 or 1
	local Size2 = Table.Size2 or 5
	local Lifetime1 = Table.Lifetime1 or 1
	local Lifetime2 = Table.Lifetime2 or 1.5
	local Parent = Table.Parent or Torso
	local Emit = Table.Emit or 100
	local Offset = Table.Offset or 360
	local Acel = Table.Acel or VT(0,0,0)
	local Enabled = Table.Enabled or false
	PRTCL.Parent = Parent
	PRTCL.Size = NumberSequence.new(Size1,Size2)
	PRTCL.Lifetime = NumberRange.new(Lifetime1,Lifetime2)
	PRTCL.Speed = NumberRange.new(Speed)
	PRTCL.VelocitySpread = Offset
	PRTCL.Drag = Drag
	PRTCL.Acceleration = Acel
	if Enabled == false then
		PRTCL:Emit(Emit)
		Debris:AddItem(PRTCL,Lifetime2)
	else
		PRTCL.Enabled = true
	end
	return PRTCL
end

function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end

function CharacterFadeB(COLOR,TIMER,MOVEDIRECTION,PARENT)
	coroutine.resume(coroutine.create(function()
		local FADE = IT("Model",Effects)
		if PARENT ~= nil then
			FADE.Parent = PARENT
		end
		FADE.Name = "FadingEffect"
		for _, c in pairs(Character:GetChildren()) do
			if c.ClassName == "Part" then
				c.CanCollide = false
				local FADER = CreatePart(3, FADE, "Neon", 0, 0.75, BRICKC("Pearl"), c.Name, c.Size, true)
				FADER.CFrame = c.CFrame
				FADER.Color = COLOR
				if FADER.Name == "Head" then
					Head:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = FADER
				elseif FADER.Name == "HumanoidRootPart" then
					FADE.PrimaryPart = FADER
					FADER.Transparency = 1
				end
			end
		end
		local TRANS = 0.25/TIMER
		local DIST = nil
		if MOVEDIRECTION ~= nil then
			DIST = (FADE.PrimaryPart.Position - MOVEDIRECTION).Magnitude
		end
		for i = 1, TIMER do
			Swait()
			for _, c in pairs(FADE:GetChildren()) do
				if c.ClassName == "Part" then
					c.Transparency = c.Transparency + TRANS
				end
			end
			if MOVEDIRECTION ~= nil then
				local ORI = FADE.PrimaryPart.Orientation
				FADE:SetPrimaryPartCFrame(CF(CF(FADE.PrimaryPart.Position,MOVEDIRECTION)*CF(0,0,-DIST/TIMER).p) * ANGLES(RAD(ORI.X), RAD(ORI.Y), RAD(ORI.Z)))
			end
		end
		FADE:remove()
	end))
end

local Characterb = IT("Model")
Characterb.Name = "shackisgaylol"
local CharacterA = IT("Model")
CharacterA.Name = "shackismegagaylol"
local Sword = IT("Model")
Sword.Name = "shackisultimategaylol"

for i = 1, 10 do
	local FACE = CreatePart(3, Head, "Fabric", 0, 0+(i-1)/10.2, "Dark stone grey", "FaceGradient", VT(1.01,0.65,1.01),false)
	FACE.Color = C3(0,0,0)
	Head:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = FACE
	CreateWeldOrSnapOrMotor("Weld", Head, Head, FACE, CF(0,0.28-(i-1)/30,0), CF(0, 0, 0))
end
local Handle = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.2,1.2,0.2),false)
Handle.Color = C3(0,0,0)
local RightArmGrasp = CreateWeldOrSnapOrMotor("Weld", Handle, RightArm, Handle, CF(0,-0.8, 0) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0.3, 0))
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.2,0.8,0.2),false)
MakeForm(Part,"Wedge")
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, 0.2, 0.2) * ANGLES(RAD(0), RAD(180), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.3,0.5,0.6),false)
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.5, 0.4) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.4,0.4,0.4),false)
MakeForm(Part,"Cyl")
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.45, 0.4) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
for i = 1, 8 do
	local Piece = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Eye", VT(0,0.35,0.41),false)
	Piece.Color = C3(1,1,0)
	CreateWeldOrSnapOrMotor("Weld", Handle, Part, Piece, CF(0, 0, 0) * ANGLES(RAD(0), RAD((360/8)*i), RAD(0)), CF(0, 0, 0))
end
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.2,0.5,0.2),false)
MakeForm(Part,"Wedge")
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.55, 0.2) * ANGLES(RAD(-135), RAD(0), RAD(0)), CF(0, -0.3, 0))
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Eye", VT(0.39,0.41,0.39),false)
MakeForm(Part,"Cyl")
Part.Color = C3(1,1,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.45, 0.4) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.3,0.5,0.5),false)
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.5, 0.2) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.3,0.4,0.5),false)
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.55, 0.65) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.2,0,0.6),false)
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(0)), CF(0, -0.2, -0.3))
local RightBarrel = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0.28,5,0.28),false)
MakeForm(RightBarrel,"Cyl")
RightBarrel.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, RightBarrel, CF(0, -0.6, 0.5) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, -2.5, 0))
local Part = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Part", VT(0,0.2,0.2),false)
MakeForm(Part,"Wedge")
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, RightBarrel, Part, CF(0, 2.415, 0.15) * ANGLES(RAD(180), RAD(0), RAD(0)), CF(0, 0, 0))
local RightHole = CreatePart(3, CharacterA, "Neon", 0, 0, "Lily white", "Eye", VT(0.2,0,0.2),false)
MakeForm(RightHole,"Cyl")
RightHole.Color = C3(1,1,0)
CreateWeldOrSnapOrMotor("Weld", Handle, RightBarrel, RightHole, CF(0, 2.5, 0), CF(0, 0, 0))
local Handle = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.2,1.2,0.2),false)
Handle.Color = C3(0,0,0)
local LeftArmGraps = CreateWeldOrSnapOrMotor("Weld", Handle, LeftArm, Handle, CF(0,-0.8, 0) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0.3, 0))
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.2,0.8,0.2),false)
MakeForm(Part,"Wedge")
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, 0.2, 0.2) * ANGLES(RAD(0), RAD(180), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.3,0.5,0.6),false)
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.5, 0.4) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.4,0.4,0.4),false)
MakeForm(Part,"Cyl")
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.45, 0.4) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
for i = 1, 8 do
	local Piece = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Eye", VT(0,0.35,0.41),false)
	Piece.Color = C3(1,0,1)
	CreateWeldOrSnapOrMotor("Weld", Handle, Part, Piece, CF(0, 0, 0) * ANGLES(RAD(0), RAD((360/8)*i), RAD(0)), CF(0, 0, 0))
end
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.2,0.5,0.2),false)
MakeForm(Part,"Wedge")
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.55, 0.2) * ANGLES(RAD(-135), RAD(0), RAD(0)), CF(0, -0.3, 0))
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Eye", VT(0.39,0.41,0.39),false)
MakeForm(Part,"Cyl")
Part.Color = C3(1,0,1)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.45, 0.4) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.3,0.5,0.5),false)
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.5, 0.2) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.3,0.4,0.5),false)
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, -0.55, 0.65) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, 0, 0))
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.2,0,0.6),false)
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, Part, CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(0)), CF(0, -0.2, -0.3))
local LeftBarrel = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0.28,5,0.28),false)
MakeForm(LeftBarrel,"Cyl")
LeftBarrel.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, Handle, LeftBarrel, CF(0, -0.6, 0.5) * ANGLES(RAD(90), RAD(0), RAD(0)), CF(0, -2.5, 0))
local Part = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Part", VT(0,0.2,0.2),false)
MakeForm(Part,"Wedge")
Part.Color = C3(0,0,0)
CreateWeldOrSnapOrMotor("Weld", Handle, LeftBarrel, Part, CF(0, 2.415, 0.15) * ANGLES(RAD(180), RAD(0), RAD(0)), CF(0, 0, 0))
local LeftHole = CreatePart(3, Characterb, "Neon", 0, 0, "Lily white", "Eye", VT(0.2,0,0.2),false)
MakeForm(LeftHole,"Cyl")
LeftHole.Color = C3(1,0,1)
CreateWeldOrSnapOrMotor("Weld", Handle, LeftBarrel, LeftHole, CF(0, 2.5, 0), CF(0, 0, 0))

local Eye1 = CreatePart(3, Character, "Neon", 0, 0, "Lily white", "Eye", VT(0.6,0.1,1)/2,false)
MakeForm(Eye1,"Ball")
CreateWeldOrSnapOrMotor("Weld", Eye1, Head, Eye1, CF(0,0.2,0) * ANGLES(RAD(0), RAD(-18), RAD(15)), CF(0, 0, 0.4))
local Eye2 = CreatePart(3, Character, "Neon", 0, 0, "Lily white", "Eye", VT(0.6,0.1,1)/2,false)
MakeForm(Eye2,"Ball")
CreateWeldOrSnapOrMotor("Weld", Eye2, Head, Eye2, CF(0,0.2,0) * ANGLES(RAD(0), RAD(18), RAD(-15)), CF(0, 0, 0.4))
local Eye = CreatePart(3, Character, "Neon", 0, 0, "Lily white", "Eye", VT(0.1,1,1)/2,false)
MakeForm(Eye,"Ball")
CreateWeldOrSnapOrMotor("Weld", Eye, Head, Eye, CF(0,0.15,0) * ANGLES(RAD(0), RAD(-18), RAD(0)), CF(0, 0, 0.4))
local Eye = CreatePart(3, Character, "Neon", 0, 0, "Lily white", "Eye", VT(0.1,1,1)/2,false)
MakeForm(Eye,"Ball")
CreateWeldOrSnapOrMotor("Weld", Eye, Head, Eye, CF(0,0.15,0) * ANGLES(RAD(0), RAD(18), RAD(0)), CF(0, 0, 0.4))

local HandlePart = CreatePart(3, Sword, "SmoothPlastic", 0, 0, "Lily white", "Handle", VT(0.2, 3.39, 1.61),false)
local HandleMesh = CreateMesh("SpecialMesh", HandlePart, "FileMesh", "94840342", "94840359", VT(1,1,1), VT(0, 0, 0))
local HandleWeld = CreateWeldOrSnapOrMotor("Weld", HandlePart, RightArm, HandlePart, CF(0,-1.2,-2.8) * ANGLES(RAD(-100), RAD(0), RAD(0)), CF(0, 0, 0))


for _, c in pairs(Characterb:GetChildren()) do
	if c.ClassName == "Part" then
		c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	end
end

Characterb.Parent = Character

for _, c in pairs(CharacterA:GetChildren()) do
	if c.ClassName == "Part" then
		c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	end
end

CharacterA.Parent = Character

for _, c in pairs(Sword:GetChildren()) do
	if c.ClassName == "Part" then
		c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	end
end

Sword.Parent = nil


local EyeSizes={
	NumberSequenceKeypoint.new(0,0.65,0),
	NumberSequenceKeypoint.new(0.5,0.7,0),
	NumberSequenceKeypoint.new(1,0,0)
}
local EyeTrans={
	NumberSequenceKeypoint.new(0,0,0),
	NumberSequenceKeypoint.new(0.5,0,0),
	NumberSequenceKeypoint.new(1,1,0)
}
local PE2=Instance.new("ParticleEmitter", Eye2)
PE2.LightEmission=.9
PE2.Color = ColorSequence.new(C3(255,0,0),C3(0,0,155),C3(0,255,255),C3(255,0,255),C3(255,255,0),C3(150,0,0),C3(0,191,0),C3(0,0,150))
PE2.Size=NumberSequence.new(EyeSizes)
PE2.Transparency=NumberSequence.new(EyeTrans)
PE2.Lifetime=NumberRange.new(0.35)
PE2.Rotation=NumberRange.new(0,360)
PE2.Rate=6
PE2.VelocitySpread = 6
PE2.Acceleration = Vector3.new(0,25,0)
PE2.ZOffset = 0.5
PE2.Drag = 0
PE2.Speed = NumberRange.new(0,0,0)
PE2.Texture="rbxasset://textures/particles/explosion01_implosion_main.dds"
PE2.Name = "PE2"
PE2.Enabled = true
PE2.LockedToPart = true

local EyeSizes={
	NumberSequenceKeypoint.new(0,0.65,0),
	NumberSequenceKeypoint.new(0.5,0.7,0),
	NumberSequenceKeypoint.new(1,0,0)
}
local EyeTrans={
	NumberSequenceKeypoint.new(0,0,0),
	NumberSequenceKeypoint.new(0.5,0,0),
	NumberSequenceKeypoint.new(1,1,0)
}
local PE2=Instance.new("ParticleEmitter", Eye1)
PE2.LightEmission=.9
PE2.Color = ColorSequence.new(C3(255,0,0),C3(0,0,155),C3(0,255,255),C3(255,0,255),C3(255,255,0),C3(150,0,0),C3(0,191,0),C3(0,0,150))
PE2.Size=NumberSequence.new(EyeSizes)
PE2.Transparency=NumberSequence.new(EyeTrans)
PE2.Lifetime=NumberRange.new(0.35)
PE2.Rotation=NumberRange.new(0,360)
PE2.Rate=6
PE2.VelocitySpread = 6
PE2.Acceleration = Vector3.new(0,25,0)
PE2.ZOffset = 0.5
PE2.Drag = 0
PE2.Speed = NumberRange.new(0,0,0)
PE2.Texture="rbxasset://textures/particles/explosion01_implosion_main.dds"
PE2.Name = "PE2"
PE2.Enabled = true
PE2.LockedToPart = true

ParticleEmitter({Speed = 0.2, Drag = 0, Size1 = 0.7, Size2 = 0, Lifetime1 = 0.7, Lifetime2 = 0.7, Parent = RightHole, Emit = 100, Offset = 360, Enabled = true, Acel = VT(3,9,8)})
ParticleEmitter({Speed = 0.2, Drag = 0, Size1 = 0.7, Size2 = 0, Lifetime1 = 0.7, Lifetime2 = 0.7, Parent = LeftHole, Emit = 100, Offset = 360, Enabled = true, Acel = VT(3,9,8)})

local sick = IT("Sound",RootPart)

warn("YOU KNOW WHAT YOU DID")
warn("YOU WANT MORE OF IT DONT YOU")
warn("LOOK WHAT YOU DID WITH ALL THIS POWER")
--//=================================\\
--||		    INSANITY
--\\=================================//

local FRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0, 0, 0, 0), UD2(0.26, 0, 0.07, 0), C3(0,0,0), C3(0, 0, 0), "MURDER")
local FACEME = {"DAS","IST","WAS","DU","VöLKERMORD","HABEN","WOLLTEST"}
local INSANITYGUIS = {}
for e = 1, 28 do
	for i = 1, 22 do
		local MURDERFRAME = FRAME:Clone()
		MURDERFRAME.Position = UD2(-0.05+i/30, 0, e/30, 0)
		MURDERFRAME.Parent = WEAPONGUI
		table.insert(INSANITYGUIS,MURDERFRAME)
	end
end
coroutine.resume(coroutine.create(function()
	while true do
		wait()
		coroutine.resume(coroutine.create(function()
			local COLOR = C3(MRANDOM(100,255)/155,155,155)
			local APPEARTEXT = FACEME[MRANDOM(1,#FACEME)]
			local SHOW = ""
			for i = 1,string.len(APPEARTEXT),1 do
				local STRING = string.sub(APPEARTEXT,i,i)
				if MRANDOM(1,2) == 1 then
					SHOW = SHOW..string.lower(STRING)
				else
					SHOW = SHOW..STRING
				end
			end
			local PARENT = INSANITYGUIS[MRANDOM(1,#INSANITYGUIS)]
			local TEXT = CreateLabel(PARENT, SHOW, COLOR, 14, SKILLFONT, 1, 2, 1, "YOUMADEMEDOTHIS")
			for i = 1, 15 do
				Swait()
				TEXT.Rotation = MRANDOM(-15,15)
				TEXT.TextTransparency = TEXT.TextTransparency - 1/15
			end
			for i = 1, 15 do
				Swait()
				TEXT.Rotation = MRANDOM(-15,15)
				TEXT.TextTransparency = TEXT.TextTransparency + 1/15
			end
			TEXT:Remove()
		end))
	end
end))
FRAME:remove()

--//=================================\\
--||			DAMAGING
--\\=================================//

function ApplyDamage(Humanoid,Damage,OneShot)
	Damage = Damage * DAMAGEMULTIPLIER
	local DEAD = false
	if Humanoid.Health < 2000 and OneShot == false then
		if Humanoid.Health - Damage > 0 then
			Humanoid.Health = Humanoid.Health - Damage
		else
			Banish(Humanoid.Parent)
			DEAD = true
		end
	else
		DEAD = true
		Banish(Humanoid.Parent)
	end
	if DEAD == true then
		local PARTS = {}
		for index, CHILD in pairs(Humanoid.Parent:GetChildren()) do
			if CHILD:IsA("BasePart") then
				table.insert(PARTS,CHILD)
			end
		end
		coroutine.resume(coroutine.create(function()
			wait(2)
			repeat
				Swait()
				local PIECE = nil
				if MRANDOM(1,5) == 1 then
					for E = 1, #PARTS do
						if MRANDOM(1,5) == 1 then
							PIECE = PARTS[E]
							table.remove(PARTS,E)
							break
						end
					end
				end
				if PIECE ~= nil then
					if PIECE.Name == "Head" then
						WACKYEFFECT({Time = MRANDOM(10,30)*5, EffectType = "Box", Size = VT(PIECE.Size.Z,PIECE.Size.Y,PIECE.Size.Z), Size2 = (VT(PIECE.Size.Z,PIECE.Size.Y,PIECE.Size.Z))*MRANDOM(7,14)/10, Transparency = PIECE.Transparency, Transparency2 = 1, CFrame = PIECE.CFrame, MoveToPos = PIECE.Position+VT(0,MRANDOM(5,8)/1.5,0), RotationX = MRANDOM(-25,25)/35, RotationY = MRANDOM(-25,25)/35, RotationZ = MRANDOM(-25,25)/35, Material = "Neon", Color = C3(0,0,0), SoundID = 0, SoundPitch = MRANDOM(12,16)/10, SoundVolume = 2})
					else
						WACKYEFFECT({Time = MRANDOM(10,30)*5, EffectType = "Box", Size = PIECE.Size, Size2 = PIECE.Size*MRANDOM(7,14)/10, Transparency = PIECE.Transparency, Transparency2 = 1, CFrame = PIECE.CFrame, MoveToPos = PIECE.Position+VT(0,MRANDOM(5,8)/1.5,0), MRANDOM(-25,25)/35, RotationY = MRANDOM(-25,25)/35, RotationZ = MRANDOM(-25,25)/35, Material = "Neon", Color = C3(0,0,0), SoundID = 0, SoundPitch = MRANDOM(12,16)/10, SoundVolume = 2})
					end
					PIECE:remove()
				end
			until #PARTS == 0
		end))
	end
end

--//=================================\\
--||          SOME TAG EDIT
--\\=================================//

m = plr
char = m.Character
local txt = Instance.new("BillboardGui", char)
txt.Adornee = char.Head
txt.Name = "_status"
txt.Size = UDim2.new(2, 0, 1.2, 0)
txt.StudsOffset = Vector3.new(-9, 8, 0)
local text = Instance.new("TextLabel", txt)
text.Size = UDim2.new(10, 0, 7, 0)
text.FontSize = "Size24"
text.TextScaled = true
text.TextTransparency = 0
text.BackgroundTransparency = 1
text.TextTransparency = 0
text.TextStrokeTransparency = 0
text.Font = "Bodoni"
text.TextStrokeColor3 = Color3.new(0, 0, 0)
v = Instance.new("Part")
v.Name = "ColorBrick"
v.Parent = m.Character
v.FormFactor = "Symmetric"
v.Anchored = true
v.CanCollide = false
v.BottomSurface = "Smooth"
v.TopSurface = "Smooth"
v.Size = Vector3.new(10, 5, 3)
v.Transparency = 1
v.CFrame = char.Torso.CFrame
v.BrickColor = BrickColor.new("Lily white")
v.Transparency = 1
v.Shape = "Block"
spawn(function()
	local TweenService = game:GetService("TweenService")
	local Colours = {Color3.fromRGB(255,0,0),Color3.fromRGB(255,0,255),Color3.fromRGB(255,255,0),Color3.fromRGB(0,255,255),Color3.fromRGB(150,0,175),Color3.fromRGB(0,0,0),Color3.fromRGB(100,100,100),Color3.fromRGB(0,0,0)}
	local Int = 0
	while wait(0.5) do
		if Int == #Colours then Int = 0 end
		Int = Int+1
		TweenService:Create(text,TweenInfo.new(1),{TextColor3 = Colours[Int]}):Play()
	end
end)
text.Text = "Crescendiac"
local SONG = 13734022624
--local SONG = 1812212957
local PLAYSONG = true

--//=================================\\
--||	ATTACK FUNCTIONS AND STUFF
--\\=================================//

local TOBANISH = {}

function swait(num)
	if num == 0 or num == nil then
		ArtificialHB.Event:wait()
	else
		for i = 0, num do
			ArtificialHB.Event:wait()
		end
	end
end

function chatfunc(text)
	local chat = coroutine.wrap(function()
		if Character:FindFirstChild("TalkingBillBoard")~= nil then
			Character:FindFirstChild("TalkingBillBoard"):destroy()
		end
		local Bill = Instance.new("BillboardGui",Character)
		Bill.Size = UDim2.new(0,100,0,40)
		Bill.StudsOffset = Vector3.new(0,3,0)
		Bill.Adornee = Character.Head
		Bill.Name = "TalkingBillBoard"
		local Hehe = Instance.new("TextLabel",Bill)
		Hehe.BackgroundTransparency = 1
		Hehe.BorderSizePixel = 0
		Hehe.Text = ""
		Hehe.Font = "Fantasy"
		Hehe.TextSize = 40
		Hehe.TextStrokeTransparency = 0
		Hehe.Size = UDim2.new(1,0,0.5,0)
		coroutine.resume(coroutine.create(function()
			while Hehe ~= nil do
				swait()	
				Hehe.Position = UDim2.new(math.random(-.4,.4),math.random(-5,5),.05,math.random(-5,5))	
				Hehe.Rotation = math.random(-5,5)
				Hehe.TextColor3 = Color3.new(50,15,15)
				Hehe.TextStrokeColor3 = Color3.new(0,0,0)
			end
		end))
		for i = 1,string.len(text),1 do
			swait()
			Hehe.Text = string.sub(text,1,i)
		end
		swait(90)--Re[math.random(1, 93)]
		for i = 0, 1, .025 do
			swait()
			Bill.ExtentsOffset = Vector3.new(math.random(-i, i), math.random(-i, i), math.random(-i, i))
			Hehe.TextStrokeTransparency = i
			Hehe.TextTransparency = i
		end
		Bill:Destroy()
	end)
	chat()
end

function onChatted(msg)
	chatfunc(msg)
end

Player.Chatted:connect(onChatted)

function printbye(Name)
	local MESSAGES = {"BE GONE FROM HERE AND DONT RETURN, "}
	chatfunc(MESSAGES[MRANDOM(1,#MESSAGES)]..Name..".")	
end

workspace.ChildAdded:connect(function(instance)
	for BANISH = 1, #TOBANISH do
		if TOBANISH[BANISH] ~= nil then
			if instance.Name == TOBANISH[BANISH] then
				coroutine.resume(coroutine.create(function()
					printbye(instance.Name)
					instance:ClearAllChildren()
					Debris:AddItem(instance,0.0005)
				end))
			end
		end
	end
end)

function Banish(Foe)
	if Foe then
		coroutine.resume(coroutine.create(function()
			--if game.Players:FindFirstChild(Foe.Name) then
			table.insert(TOBANISH,Foe.Name)
			printbye(Foe.Name)
			--end
			Foe.Archivable = true
			local CLONE = Foe:Clone()
			Foe:Destroy()
			CLONE.Parent = Effects
			CLONE:BreakJoints()
			local MATERIALS = {"Glass","Neon"}
			for _, c in pairs(CLONE:GetDescendants()) do
				if c:IsA("BasePart") then
					if c.Name == "Torso" or c.Name == "UpperTorso" or c == CLONE.PrimaryPart then
						CreateSound(340722848, c, 10, 1, false)
					end
					c.Anchored = true
					c.Transparency = c.Transparency + 0.2
					c.Material = MATERIALS[MRANDOM(1,2)]
					c.Color = C3(0,255,0)
					if c.ClassName == "MeshPart" then
						c.TextureID = ""
					end
					if c:FindFirstChildOfClass("SpecialMesh") then
						c:FindFirstChildOfClass("SpecialMesh").TextureId = ""
					end
					if c:FindFirstChildOfClass("Decal") then
						c:FindFirstChildOfClass("Decal"):remove()
					end
					c.Name = "Banished"
					c.CanCollide = false
				else
					c:remove()
				end
			end
			local A = false
			for i = 1, 35 do
				if A == false then
					A = true
				elseif A == true then
					A = false
				end
				for _, c in pairs(CLONE:GetDescendants()) do
					if c:IsA("BasePart") then
						c.Anchored = true
						c.Material = MATERIALS[MRANDOM(1,2)]
						c.Transparency = c.Transparency + 0.8/35
						if A == false then
							c.CFrame = c.CFrame*CF(MRANDOM(-45,45)/45,MRANDOM(-45,45)/45,MRANDOM(-45,45)/45)
						elseif A == true then
							c.CFrame = c.CFrame*CF(MRANDOM(-45,45)/45,MRANDOM(-45,45)/45,MRANDOM(-45,45)/45)						
						end
					end
				end
				Swait()
			end
			CLONE:remove()
		end))
	end
end

function ChangeSanity()
	ATTACK = true
	Rooted = true
	if MODE == "CRES" then
		CreateSound(1295446488, Torso, 10, 1, false)
		CreateSound(1368598393, Torso, 10, 1, false)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(90)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(180)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(270)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(90)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(180)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(270)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(90)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(180)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(270)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1.05,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(7),math.rad(0),math.rad(-16)),.8)
			LH.C0=clerp(LH.C0,cf(-1,-1.05,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(3),math.rad(0),math.rad(10)),.8)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.8)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-5),math.rad(0),math.rad(0)),.8)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-25),math.rad(0),math.rad(97)),.8)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-27),math.rad(0),math.rad(-98)),.8)
		end
		ApplyAoE6(LeftBarrel.Position, 5, 0, 0, 0, true)
		ApplyAoE6(RightBarrel.Position, 5, 0, 0, 0, true)
		for i=0, 0.6, 0.1 / Animation_Speed do
			Swait()
			RH.C0=clerp(RH.C0,cf(1,-0.35,-0.5)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-2.5),math.rad(-20),math.rad(30)),.5)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-2.5),math.rad(0),math.rad(10)),.5)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,-0.75)*angles(math.rad(30),math.rad(0),math.rad(20)),.5)
			Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(-10),math.rad(0),math.rad(-20)),.5)
			RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(40),math.rad(-8),math.rad(-10)),.5)
			LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(-50),math.rad(0),math.rad(-30)),.5)
		end
		--SONG = 899090278
		SONG = 1812212957
		Characterb.Parent = nil
		text.Text = "Revenger"
		MODE = "RR"
	elseif MODE == "RR" then
		CreateSound(147722227, Torso, 4, 1.3, false)
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		Characterb.Parent = Character
		SONG = 923445685
		text.Text = "Crescendiac"
		MODE = "CRES"
	end
	ATTACK = false
	Rooted = false
end

function ChangeSanityMadness()
	ATTACK = true
	Rooted = true
	if MODE == "CRES" then
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		MagicSphere3(VT(0,0,0),45,Torso.CFrame,"Lily white",VT(500,500,500))
		ApplyAoE6(Torso.Position, 5, 0, 0, 0, true)
		CreateSound(363808674, Torso, 6, 1, false)
		CreateRing2(VT(0,0,0),false,0,45,RootPart.CFrame*ANGLES(RAD(90),RAD(0),RAD(0)),"Lily white",VT(100,100,100))
		CreateSound(363808674, Torso, 6, 1, false)
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-70)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(80)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		MagicSphere3(VT(0,0,0),45,Torso.CFrame,"Lily white",VT(500,500,500))
		ApplyAoE6(Torso.Position, 5, 0, 0, 0, true)
		CreateSound(363808674, Torso, 6, 1, false)
		CreateRing2(VT(0,0,0),false,0,45,RootPart.CFrame*ANGLES(RAD(90),RAD(0),RAD(0)),"Lily white",VT(100,100,100))
		CreateSound(363808674, Torso, 6, 1, false)
		CreateSound(363808674, Torso, 6, 1, false)
		for i=0, 0.6, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(25), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-50)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(60)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		MagicSphere3(VT(0,0,0),45,Torso.CFrame,"Lily white",VT(500,500,500))
		ApplyAoE6(Torso.Position, 5, 0, 0, 0, true)
		CreateSound(363808674, Torso, 6, 1, false)
		CreateRing2(VT(0,0,0),false,0,45,RootPart.CFrame*ANGLES(RAD(90),RAD(0),RAD(0)),"Lily white",VT(100,100,100))
		CreateSound(363808674, Torso, 6, 1, false)
		for i=0, 0.6, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(-25), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		MagicSphere3(VT(0,0,0),45,Torso.CFrame,"Lily white",VT(500,500,500))
		ApplyAoE6(Torso.Position, 5, 0, 0, 0, true)
		CreateSound(363808674, Torso, 6, 1, false)
		CreateRing2(VT(0,0,0),false,0,45,RootPart.CFrame*ANGLES(RAD(90),RAD(0),RAD(0)),"Lily white",VT(100,100,100))
		CreateSound(363808674, Torso, 6, 1, false)
		SONG = 779838221
		text.Text = "Corrupted Burning Hope"
		MODE = "GC"
	elseif MODE == "GC" then
		CreateSound(147722227, Torso, 4, 1.3, false)
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		SONG = 923445685
		text.Text = "Crescendiac"
		MODE = "CRES"
	end
	ATTACK = false
	Rooted = false
end

function BreakSanity()
	ATTACK = true
	Rooted = true
	if MODE == "CRES" then
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-70)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(80)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		CreateSound(363808674, Torso, 6, 1, false)
		for i=0, 0.6, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(25), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-50)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(60)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		MagicSphere3(VT(0,0,0),45,Torso.CFrame,"Maroon",VT(500,500,500))
		ApplyAoE4(Torso.Position, 5, 0, 0, 0, true)
		CreateSound(363808674, Torso, 6, 1, false)
		CreateRing2(VT(0,0,0),false,0,45,RootPart.CFrame*ANGLES(RAD(90),RAD(0),RAD(0)),"Crimson",VT(100,100,100))
		for i=0, 0.6, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(-25), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		MagicSphere3(VT(0,0,0),45,Torso.CFrame,"Maroon",VT(500,500,500))
		ApplyAoE4(Torso.Position, 5, 0, 0, 0, true)
		CreateRing2(VT(0,0,0),false,0,45,RootPart.CFrame*ANGLES(RAD(90),RAD(0),RAD(0)),"Crimson",VT(100,100,100))
		SONG = 603566564
		text.Text = "Infiltrator"
		MODE = "SR"			
	elseif MODE == "SR" then
		CreateSound(147722227, Torso, 4, 1.3, false)
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		SONG = 923445685
		text.Text = "Crescendiac"
		MODE = "CRES"
	end
	ATTACK = false
	Rooted = false
end


function BreakSanityTEST()
	ATTACK = true
	Rooted = true
	if MODE == "CRES" then
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-70)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(80)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		CreateSound(363808674, Torso, 6, 1, false)
		for i=0, 0.6, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(25), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-50)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(60)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		WACKYEFFECT({Time = 60, EffectType = "Block", Size = VT(4,4,4), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame*CF(0,0,0), MoveToPos = nil,RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(0.4,0,0), SoundID = nil, SoundPitch = MRANDOM(12,16)/10, SoundVolume = 2})
		CreateSound(363808674, Torso, 6, 1, false)
		for i=0, 0.6, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5), RAD(-25), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, -0.5) * ANGLES(RAD(100), RAD(0), RAD(-90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35, -0.35) * ANGLES(RAD(70), RAD(0), RAD(90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		WACKYEFFECT({Time = MRANDOM(45,65), EffectType = "Sphere", Size = VT(2.5,999,2.5), Size2 = VT(7.5,999,7.5), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame*CF(1.65,-1,-0.35), MoveToPos = nil,RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(0.4,0,0), SoundID = nil, SoundPitch = MRANDOM(12,16)/10, SoundVolume = 2})
		CreateSound(147722227, Torso, 10, 1.3, false)
		CreateSound(588736245, Torso, 2.5, 0.7, false)
		CreateRing2(VT(0,0,0),false,0,45,RootPart.CFrame*ANGLES(RAD(90),RAD(0),RAD(0)),"Crimson",VT(100,100,100))
		SONG = 948358380
		text.Text = "Crescendio"
		MODE = "CRESCENDO"			
		CharacterA.Parent = nil
		Characterb.Parent = nil
		Sword.Parent = Character
		CrossedArms = false
	elseif MODE == "CRESCENDO" then
		CreateSound(147722227, Torso, 4, 1.3, false)
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-83), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		Sword.Parent = nil
		CrossedArms = true
		CharacterA.Parent = Character
		Characterb.Parent = Character
		SONG = 923445685
		text.Text = "Crescendiac"
		MODE = "CRES"
	end
	ATTACK = false
	Rooted = false
end

function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos,EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end

function SpawnTrail(FROM,TO,BIG)
	local TRAIL = CreatePart(3, Effects, "Neon", 0, 0.5, "Deep orange", "Trail", VT(0,0,0))
	MakeForm(TRAIL,"Cyl")
	local DIST = (FROM - TO).Magnitude
	if BIG == true then
		TRAIL.Size = VT(0.15,DIST,0.15)
	else
		TRAIL.Size = VT(0.45,DIST,0.45)
	end
	TRAIL.CFrame = CF(FROM, TO) * CF(0, 0, -DIST/2) * ANGLES(RAD(90),RAD(0),RAD(0))
	coroutine.resume(coroutine.create(function()
		for i = 1, 5 do
			Swait()
			TRAIL.Transparency = TRAIL.Transparency + 0.1
		end
		TRAIL:remove()
	end))
end

local asd = Instance.new("ParticleEmitter")
asd.Color = ColorSequence.new(Color3.new(0.5, 0, 0), Color3.new(.3, 0, 0))
asd.LightEmission = .1
asd.Texture = "http://www.roblox.com/asset/?ID=0"
aaa = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6),NumberSequenceKeypoint.new(1, 2)})
bbb = NumberSequence.new({NumberSequenceKeypoint.new(0, 1),NumberSequenceKeypoint.new(0.0636, 0), NumberSequenceKeypoint.new(1, 1)})
asd.Transparency = bbb
asd.Size = aaa
asd.ZOffset = .9
asd.Acceleration = Vector3.new(0, -15, 0)
asd.LockedToPart = false
asd.EmissionDirection = "Back"
asd.Lifetime = NumberRange.new(1, 2)
asd.Rotation = NumberRange.new(-100, 100)
asd.RotSpeed = NumberRange.new(-100, 100)
asd.Speed = NumberRange.new(10)
asd.Enabled = false
asd.VelocitySpread = 999

function getbloody(victim,amount)
	local PART = CreatePart(3, Effects, "Neon", 0, 1, "Really black", "Blood", victim.Size)
	PART.CFrame = victim.CFrame
	local HITPLAYERSOUNDS = {"373066560","373066560"}
	Debris:AddItem(PART,5)
	CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], PART, 1, (math.random(8,12)/10))
	CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], PART, 1, (math.random(8,12)/10))
	CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], PART, 1, (math.random(8,12)/10))
	local prtcl = asd:Clone()
	prtcl.Parent = PART
	prtcl:Emit(amount*10)
end

function Kill2(Char)
	local NewCharacter = IT("Model",Effects)
	NewCharacter.Name = "Ow im ded ;-;"
	for _, c in pairs(Char:GetDescendants()) do
		if c:IsA("BasePart") and c.Transparency == 0 then
			if c.Parent == Char then
				getbloody(c,5)
			end
			c:BreakJoints()
			c.Material = "Glass"
			c.Color = C3(0.5,0.3,0)
			c.CanCollide = true
			c.Transparency = 0.3
			if c:FindFirstChildOfClass("SpecialMesh") then
				c:FindFirstChildOfClass("SpecialMesh").TextureId = ""
			end
			if c.Name == "Head" then
				c:ClearAllChildren()
				c.Size = VT(c.Size.Y,c.Size.Y,c.Size.Y)
			end
			if c.ClassName == "MeshPart" then
				c.TextureID = ""
			end
			if c:FindFirstChildOfClass("BodyPosition") then
				c:FindFirstChildOfClass("BodyPosition"):remove()
			end
			if c:FindFirstChildOfClass("ParticleEmitter") then
				c:FindFirstChildOfClass("ParticleEmitter"):remove()
			end
			c.Parent = NewCharacter
			c.Name = "DeadPart"
			c.Velocity = VT(MRANDOM(-45,45),MRANDOM(-45,45),MRANDOM(-45,45))/15
			c.RotVelocity = VT(MRANDOM(-45,45),MRANDOM(-15,85),MRANDOM(-45,45))
		end
	end
	Char:remove()
	Debris:AddItem(NewCharacter,5)
end

function BulletDetection(FROM,TO,BRUTAL)
	local AIMHIT,AIMPOS,NORMAL = CastProperRay(FROM,TO,2000,Character)
	coroutine.resume(coroutine.create(function()
		if AIMHIT ~= nil then
			if AIMHIT.Parent ~= Character then
				if AIMHIT.Parent:FindFirstChildOfClass("Humanoid") or AIMHIT.Parent.Parent:FindFirstChildOfClass("Humanoid") then
					if AIMHIT.Parent:FindFirstChildOfClass("Humanoid") then
						if BRUTAL == true then
							Kill2(AIMHIT.Parent)
						else
							getbloody(AIMHIT,15)
							AIMHIT.Parent:BreakJoints()
							if AIMHIT.Name == "Head" then
								AIMHIT.Name = "HEADSHOT"
								AIMHIT:remove()
							end
						end
					else
						if BRUTAL == true then
							Kill2(AIMHIT.Parent.Parent)
						else
							Banish(AIMHIT.Parent.Parent)
						end
					end
				end
			end
		end
	end))
	SpawnTrail(FROM,AIMPOS)
	return AIMHIT,AIMPOS,NORMAL
end

function BulletDetection2(FROM,TO,BRUTAL)
	local AIMHIT,AIMPOS,NORMAL = CastProperRay(FROM,TO,2000,Character)
	coroutine.resume(coroutine.create(function()
		if AIMHIT ~= nil then
			if AIMHIT.Parent ~= Character then
				if AIMHIT.Parent:FindFirstChildOfClass("Humanoid") or AIMHIT.Parent.Parent:FindFirstChildOfClass("Humanoid") then
					if AIMHIT.Parent:FindFirstChildOfClass("Humanoid") then
						if BRUTAL == true then
							Banish(AIMHIT.Parent)
						else
							getbloody(AIMHIT,15)
							AIMHIT.Parent:BreakJoints()
							if AIMHIT.Name == "Head" then
								AIMHIT.Name = "HEADSHOT"
								AIMHIT:remove()
							end
						end
					else
						if BRUTAL == true then
							Banish(AIMHIT.Parent.Parent)
						else
							Kill2(AIMHIT.Parent.Parent)
						end
					end
				end
			end
		end
	end))
	SpawnTrail(FROM,AIMPOS)
	return AIMHIT,AIMPOS,NORMAL
end

function ApplyAoE2(POSITION,RANGE,ISBANISH)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						if ISBANISH == true then
							Banish(CHILD)
						else
							if ISBANISH == "Gravity" then
								HUM.PlatformStand = true
								if TORSO:FindFirstChild("V3BanishForce"..Player.Name) then
									local grav = Instance.new("BodyPosition",TORSO)
									grav.D = 15
									grav.P = 20000
									grav.maxForce = Vector3.new(math.huge,math.huge,math.huge)
									grav.position = TORSO.Position
									grav.Name = "V3BanishForce"..Player.Name
								else
									TORSO:FindFirstChild("V3BanishForce"..Player.Name).position = TORSO.Position+VT(0,0.3,0)
									TORSO.RotVelocity = VT(MRANDOM(-25,25),MRANDOM(-25,25),MRANDOM(-25,25))
								end
							else
								HUM.PlatformStand = false
							end
						end
					elseif ISBANISH == "Gravity" then
						if TORSO:FindFirstChild("V3BanishForce"..Player.Name) then
							TORSO:FindFirstChild("V3BanishForce"..Player.Name):remove()
							HUM.PlatformStand = false
						end
					end
				end
			end
		end
	end
end

function CORRUPTEDBURNINGBULLETS()
	ATTACK = true
	Rooted = false
	repeat
		local GYRO = IT("BodyGyro",RootPart)
		GYRO.D = 175
		GYRO.P = 20000
		GYRO.MaxTorque = VT(0,40000,0)
		GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
		if COMBO == 1 then
			COMBO = 2
			for i=0, 0, 0.1 / Animation_Speed do
				Swait()
				GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-50)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(110), RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(35 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-50)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0.3,0,0.3), Size2 = VT(1,1.5,1), Transparency = 0, Transparency2 = 1, CFrame = LeftHole.CFrame, MoveToPos = LeftHole.CFrame*CF(0,0.5,0).p, RotationX = 0, RotationY = 15, RotationZ = 0, Material = "Neon", Color = C3(255,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0.3,0,0.3), Size2 = VT(2,0.5,2), Transparency = 0, Transparency2 = 1, CFrame = LeftHole.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 5, RotationZ = 0, Material = "Neon", Color = C3(255,0,255), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			CreateSound(275326592, LeftHole, 7, 1, false)
			BulletDetection2(LeftHole.Position,Mouse.Hit.p,true)
			for i=0, 0, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-50)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(110), RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(35 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(130), RAD(0), RAD(-50)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
		elseif COMBO == 2 then
			COMBO = 1
			for i=0, 0.1, 0.1 / Animation_Speed do
				Swait()
				GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(50)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(50)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(140), RAD(15 + 2.5 * SIN(SINE / 12)), RAD(-35 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0.3,0,0.3), Size2 = VT(1,1.5,1), Transparency = 0, Transparency2 = 1, CFrame = RightHole.CFrame, MoveToPos = RightHole.CFrame*CF(0,0.5,0).p, RotationX = 0, RotationY = -15, RotationZ = 0, Material = "Neon", Color = C3(255,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0.3,0,0.3), Size2 = VT(2,0.5,2), Transparency = 0, Transparency2 = 1, CFrame = RightHole.CFrame, MoveToPos = nil, RotationX = 0, RotationY = -15, RotationZ = 0, Material = "Neon", Color = C3(255,0,255), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			CreateSound(275326592, RightHole, 7, 1, false)
			BulletDetection2(RightHole.Position,Mouse.Hit.p,true)
			for i=0, 0.1, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(50)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(130), RAD(0), RAD(50)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(140), RAD(15 + 2.5 * SIN(SINE / 12)), RAD(-35 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
		end
		GYRO:remove()
	until KEYHOLD == false
	ATTACK = false
	Rooted = false
end

function CORRUPTEDLETHALBULLETS()
	ATTACK = true
	Rooted = false
	repeat
		local GYRO = IT("BodyGyro",RootPart)
		GYRO.D = 175
		GYRO.P = 20000
		GYRO.MaxTorque = VT(0,40000,0)
		GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
		if COMBO == 1 then
			COMBO = 2
			for i=0, 0, 0.1 / Animation_Speed do
				Swait()
				GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-50)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(110), RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(35 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-50)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0.3,0,0.3), Size2 = VT(1,1.5,1), Transparency = 0, Transparency2 = 1, CFrame = LeftHole.CFrame, MoveToPos = LeftHole.CFrame*CF(0,0.5,0).p, RotationX = 0, RotationY = 15, RotationZ = 0, Material = "Neon", Color = C3(255,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0.3,0,0.3), Size2 = VT(2,0.5,2), Transparency = 0, Transparency2 = 1, CFrame = LeftHole.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 5, RotationZ = 0, Material = "Neon", Color = C3(255,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			CreateSound(1590205662, LeftHole, 7, 1, false)
			BulletDetection(LeftHole.Position,Mouse.Hit.p,true)
			for i=0, 0, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-50)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(110), RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(35 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(130), RAD(0), RAD(-50)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
		elseif COMBO == 2 then
			COMBO = 1
			for i=0, 0.1, 0.1 / Animation_Speed do
				Swait()
				GYRO.cframe = CF(RootPart.Position,Mouse.Hit.p)
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(50)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(50)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(140), RAD(15 + 2.5 * SIN(SINE / 12)), RAD(-35 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0.3,0,0.3), Size2 = VT(1,1.5,1), Transparency = 0, Transparency2 = 1, CFrame = RightHole.CFrame, MoveToPos = RightHole.CFrame*CF(0,0.5,0).p, RotationX = 0, RotationY = -15, RotationZ = 0, Material = "Neon", Color = C3(255,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0.3,0,0.3), Size2 = VT(2,0.5,2), Transparency = 0, Transparency2 = 1, CFrame = RightHole.CFrame, MoveToPos = nil, RotationX = 0, RotationY = -15, RotationZ = 0, Material = "Neon", Color = C3(255,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			CreateSound(1590205662, RightHole, 7, 1, false)
			BulletDetection(RightHole.Position,Mouse.Hit.p,true)
			for i=0, 0.1, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(50)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(130), RAD(0), RAD(50)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(140), RAD(15 + 2.5 * SIN(SINE / 12)), RAD(-35 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
		end
		GYRO:remove()
	until KEYHOLD == false
	ATTACK = false
	Rooted = false
end

function Corrupted_Burn()
	ATTACK = true
	Rooted = true
	for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, -0.5) * ANGLES(RAD(0), RAD(0), RAD(-85)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.15, -0.5) * ANGLES(RAD(-15), RAD(0), RAD(85)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end	
	coroutine.resume(coroutine.create(function()
		local POS = Mouse.Hit.p
		local RAY = CreatePart(3, Effects, "Neon", 0, 0, "Really red", "Strike", VT(0,2000,0))
		MakeForm(RAY,"Cyl")
		local SPHERE = CreatePart(3, Effects, "Neon", 0, 0, "Hot pink", "Strike", VT(0,0,0))
		MakeForm(SPHERE,"Ball")
		local SHIELD = CreatePart(3, Effects, "Neon", 0, 0.5, "Deep orange", "Strike", VT(0,0,0))
		MakeForm(SHIELD,"Ball")
		SHIELD.CFrame = CF(POS)
		RAY.CFrame = CF(POS)
		SPHERE.CFrame = CF(POS)
		CreateSound(440145570, SPHERE, 10, 0.8, false)
		CreateSound(415700134, SPHERE, 10, 0.8, false)
		for i = 1, 200 do
			Swait()
			WACKYEFFECT({Time = 15, EffectType = "Wave", Size = VT(0,0,0), Size2 = VT(SPHERE.Size.X*1.2,5+(i),SPHERE.Size.X*1.2), Transparency = 0, Transparency2 = 1, CFrame = SPHERE.CFrame*ANGLES(RAD(0), RAD(i), RAD(0)), MoveToPos = nil, RotationX = 0, RotationY = i, RotationZ = 0, Material = "Neon", Color = C3(0,255,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
			RAY.Size = RAY.Size + VT(0.05,0,0.05)
			SPHERE.Size = SPHERE.Size + VT(5,5,5)
			SHIELD.Size = SPHERE.Size + VT(10,10,10)
			ApplyAoE2(SPHERE.Position,SPHERE.Size.X/5,true)
		end	
		for i = 1, 45 do
			Swait()
			RAY.Transparency = RAY.Transparency + 1/45
			SPHERE.Transparency = RAY.Transparency 
			SHIELD.Transparency = SPHERE.Transparency + 1/45
		end
		RAY:remove()
		SHIELD:remove()
		SPHERE:remove()
	end))
	for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0  + 0.25 * COS(SINE / 12)) * ANGLES(RAD(-35), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, -0.15) * ANGLES(RAD(65), RAD(-45), RAD(85)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, -0.15) * ANGLES(RAD(65), RAD(45), RAD(-85)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-35-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-35-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end

local Weapon = IT("Model")
Weapon.Name = "Adds"

local Eon = CreatePart(3, Weapon, "Neon", 0, 0, "Lime green", "Eon", VT(0,0,0),false)
CreateWeldOrSnapOrMotor("Weld", Torso, Torso, Eon, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), CF(0, 0, 0))

function MagicSpheres(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = VT(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function Warp()
	ATTACK = true
	Rooted = true
	UNANCHOR = false
	RootPart.Anchored = true
	MagicSpheres(VT(0,0,0),15,Eon.CFrame,"Really red",VT(2,2,2))
	MagicSpheres(VT(0,0,0),15,Eon.CFrame,"Royal Purple",VT(2,2,2))
	for i=0, 0.5, 0.1 / Animation_Speed do
		Swait()
		WACKYEFFECT({
			Time = 5,
			EffectType = "Round Slash",
			Size = VT(0, 0, 0),
			Size2 = VT(0.01, 0, 0.01),
			Transparency = 0.5,
			Transparency2 = 1,
			CFrame = CF(Eon.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
			MoveToPos = nil,
			RotationX = MRANDOM(-50, 50) / 10,
			RotationY = MRANDOM(-50, 50) / 10,
			RotationZ = MRANDOM(-50, 50) / 10,
			Material = "Neon",
			Color = C3(1, 0, 0),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		MagicSpheres(VT(0,0.2,0),15,CF(RootPart.Position-VT(0,3,0)),"Lily white",VT(0.5,0,0.5))
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.1, -0.1 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.35, 0) * ANGLES(RAD(15), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.35, 0) * ANGLES(RAD(15), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(20), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(5), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
	for i = 1, 10 do
		Swait()
		MagicSpheres(VT(0,0.2,0),15,CF(RootPart.Position-VT(0,3,0)),"Deep orange",VT(0.5,0,0.5))
	end
	for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		WACKYEFFECT({
			Time = 5,
			EffectType = "Round Slash",
			Size = VT(0, 0, 0),
			Size2 = VT(0.01, 0, 0.01),
			Transparency = 0.5,
			Transparency2 = 1,
			CFrame = CF(Eon.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
			MoveToPos = nil,
			RotationX = MRANDOM(-50, 50) / 10,
			RotationY = MRANDOM(-50, 50) / 10,
			RotationZ = MRANDOM(-50, 50) / 10,
			Material = "Neon",
			Color = C3(1, 0, 0),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		MagicSpheres(VT(0,0.2,0),15,CF(RootPart.Position-VT(0,3,0)),"Crimson",VT(0.5,0,0.5))
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -25) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.35, 0) * ANGLES(RAD(15), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.35, 0) * ANGLES(RAD(15), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(20), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(5), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
	local ORIGIN = RootPart.Position
	RootPart.CFrame = CF(Mouse.Hit.p+VT(0,3,0),ORIGIN)
	for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		WACKYEFFECT({
			Time = 5,
			EffectType = "Round Slash",
			Size = VT(0, 0, 0),
			Size2 = VT(0.01, 0, 0.01),
			Transparency = 0.5,
			Transparency2 = 1,
			CFrame = CF(Eon.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
			MoveToPos = nil,
			RotationX = MRANDOM(-50, 50) / 10,
			RotationY = MRANDOM(-50, 50) / 10,
			RotationZ = MRANDOM(-50, 50) / 10,
			Material = "Neon",
			Color = C3(1, 0, 0),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		MagicSpheres(VT(0,0.2,0),15,CF(RootPart.Position-VT(0,3,0)),"Lily white",VT(0.5,0,0.5))
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.35, 0) * ANGLES(RAD(15), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.35, 0) * ANGLES(RAD(15), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(20), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(5), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
	UNANCHOR = true
	RootPart.Anchored = false
	for i = 1, 10 do
		Swait()
		MagicSpheres(VT(0,0.2,0),15,CF(RootPart.Position-VT(0,3,0)),"Hot pink",VT(0.5,0,0.5))
	end
	ATTACK = false
	Rooted = false
end

function Neckless()
	local TARGET = Mouse.Target
	if TARGET ~= nil then
		if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
			local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
			local ROOT = TARGET.Parent:FindFirstChild("HumanoidRootPart") or TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")
			if ROOT and HUM.Health > 0 then
				local FOE = Mouse.Target.Parent
				local HEAD = FOE:FindFirstChild("Head")
				if HEAD then
					ATTACK = true
					Rooted = false
					CharacterFade(C3(0,0,0),150)
					RootPart.CFrame = ROOT.CFrame*CF(0,0,2)
					for _, c in pairs(FOE:GetChildren()) do
						if c.ClassName == "Part" then
							c.Anchored = true
						end
					end
					CreateSound(235097614, Torso, 2, 3, false)
					for i=0, 0.5, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.6) * ANGLES(RAD(130), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.5, -0.6) * ANGLES(RAD(130), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					if ROOT.Name == "HumanoidRootPart" then
						ROOT:remove()
					end
					FOE:BreakJoints()
					ApplyDamage(HUM,0,true)
					CreateSound(363808674, HEAD, 5, 1, false)
					ROOT.Anchored = false
					for i=0, 0.5, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.65, -1.5) * ANGLES(RAD(130), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.5, 0) * ANGLES(RAD(130), RAD(0), RAD(0)) * LEFTSHOULDERC0, 2 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for _, c in pairs(FOE:GetChildren()) do
						if c.ClassName == "Part" then
							c.Anchored = false
						end
					end
					ATTACK = false
					Rooted = false
				end
			end
		end
	end
end
function BraveSpeed()
	CreateSound(235097614, Torso, 0.2, 3, false)
	for i = 1, 7 do
		CharacterFade(C3(0,0,0),25+(i*10))
		RootPart.CFrame = RootPart.CFrame*CF(0,0,-4)
	end
end
function Slashed()
	local TARGET = Mouse.Target
	if TARGET ~= nil then
		if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
			local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
			local ROOT = TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")
			if ROOT and HUM.Health > 0 then
				local FOE = Mouse.Target.Parent
				ATTACK = true
				coroutine.resume(coroutine.create(function()
					repeat
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0.05, -0.05 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(MRANDOM(-5,5) - 2.5 * COS(SINE / 12)), RAD(MRANDOM(-5,5)), RAD(0)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.45, 0.5, -0.1) * ANGLES(RAD(50), RAD(0), RAD(-30)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(15), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(15), RAD(-85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					until ATTACK == false
				end))
				for i=0, 0.2, 0.1 / Animation_Speed do
					Swait()
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.15, -0.85) * ANGLES(RAD(35), RAD(0), RAD(90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				end
				for i=0, 1.2, 0.1 / Animation_Speed do
					Swait()
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.25, -0.5) * ANGLES(RAD(90), RAD(0), RAD(0)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
				end
				CreateSound(971125740, LeftArm, 5, 1, false)
				for i=0, 0.1, 0.1 / Animation_Speed do
					Swait()
					WACKYEFFECT({Time = 25, EffectType = "Box", Size = VT(1,2,1), Size2 = VT(1,2,1), Transparency = 0.2, Transparency2 = 1, CFrame = LeftArm.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(0,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.85) * ANGLES(RAD(35), RAD(0), RAD(90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * LEFTSHOULDERC0, 2 / Animation_Speed)
				end
				ROOT.CFrame = ROOT.CFrame * ANGLES(RAD(-15), RAD(0), RAD(15))
				WACKYEFFECT({Time = 30, EffectType = "Sphere", Size = VT(1,0.1,1), Size2 = VT(6,0,6)*ROOT.Size.Z, Transparency = 0, Transparency2 = 1, CFrame = ROOT.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(0,0,0), SoundID = 971126018, SoundPitch = 1.5, SoundVolume = 4})
				WACKYEFFECT({Time = 30, EffectType = "Sphere", Size = VT(1,0.1,1), Size2 = VT(6,0,6)*ROOT.Size.Z, Transparency = 0, Transparency2 = 1, CFrame = Torso.CFrame, MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(0,0,0), SoundID = 971126018, SoundPitch = 1.5, SoundVolume = 4})
				coroutine.resume(coroutine.create(function()
					for i = 1, 5 do
						Chunks(ROOT)
					end
					local FAKEROOT1 = CreatePart(3, FOE, ROOT.Material, 0, 0, ROOT.BrickColor, "SlicedTorso", VT(ROOT.Size.X,ROOT.Size.Y/2,ROOT.Size.Z),false)
					FAKEROOT1.CanCollide = true
					local FAKEROOT2 = CreatePart(3, FOE, ROOT.Material, 0, 0, ROOT.BrickColor, "SlicedTorso", VT(ROOT.Size.X,ROOT.Size.Y/2,ROOT.Size.Z),false)
					FAKEROOT2.CanCollide = true
					FAKEROOT1.CFrame = ROOT.CFrame*CF(0,ROOT.Size.Y/4,0)
					FAKEROOT2.CFrame = ROOT.CFrame*CF(0,-ROOT.Size.Y/4,0)
					ROOT:Remove()
					ApplyDamage(HUM,0,true)
				end))
				for i=0, 0.4, 0.1 / Animation_Speed do
					Swait()
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.85) * ANGLES(RAD(35), RAD(0), RAD(90)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * LEFTSHOULDERC0, 2 / Animation_Speed)
				end
				ATTACK = false
			end
		end
	end
end
function Dirtface()
	local TARGET = Mouse.Target
	if TARGET ~= nil then
		if TARGET.Parent:FindFirstChildOfClass("Humanoid") then
			local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
			local ROOT = TARGET.Parent:FindFirstChild("HumanoidRootPart") or TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")
			if ROOT and HUM.Health > 0 then
				local FOE = Mouse.Target.Parent
				local HEAD = FOE:FindFirstChild("Head")
				local HITFLOOR = Raycast(ROOT.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4*ROOT.Size.Z, FOE)
				if HEAD and HITFLOOR then
					ATTACK = true
					Rooted = true
					CharacterFade(C3(0,0,0),150)
					RootPart.CFrame = ROOT.CFrame*CF(0,0,2)
					ROOT.Anchored = true
					CreateSound(235097614, Torso, 2, 3, false)
					for i=0, 0.4, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(25)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(140), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-65), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i=0, 0.1, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(-25)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(140), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					ROOT.Anchored = false
					UNANCHOR = false
					local DEAD = false
					local CFRAME = RootPart.CFrame
					CreateSound(260411131, Torso, 2, 3, false)
					coroutine.resume(coroutine.create(function()
						repeat
							Swait()
							RootPart.CFrame = CFRAME
							HEAD.CFrame = RightArm.CFrame*CF(0,-(1+HEAD.Size.Z/2),0) * ANGLES(RAD(-90), RAD(0), RAD(0))
							HEAD.Velocity = VT(0,0,0)
							HUM.PlatformStand = true
						until DEAD == true
					end))
					for i=0, 0.2, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * COS(SINE / 12)), RAD(0), RAD(-25)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.45, 0.5, -0.3) * ANGLES(RAD(140), RAD(0), RAD(-15)) * RIGHTSHOULDERC0, 0.3 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					for i=0, 1, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-15)), 1 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35 - 2.5 * COS(SINE / 12)), RAD(0), RAD(15)), 1 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.45, 1, 0) * ANGLES(RAD(60), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-70), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					end
					local ERUPT = function()
						local HITFLOOR,HITPOS = Raycast(HEAD.CFrame*CF(0,0.2,0).p+VT(0,0.2,0), (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4*ROOT.Size.X, FOE)
						if HITFLOOR then
							for i = 1, 5 do
								CreateFlyingDebree(HITFLOOR,CF(HITPOS),MRANDOM(1,2),VT(MRANDOM(10,60)/20,MRANDOM(10,60)/20,MRANDOM(10,60)/20),5,MRANDOM(45,85))
							end
							Chunks(HEAD)
							WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(1,2,1), Size2 = VT(15,0,15), Transparency = 0, Transparency2 = 1, CFrame = CF(HITPOS) * ANGLES(RAD(0), RAD(MRANDOM(0,360)), RAD(0)) , MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = 765590102, SoundPitch = MRANDOM(8,12)/10, SoundVolume = 4})
						end
					end
					local ATE = false
					local DEPTH = 1
					coroutine.resume(coroutine.create(function()
						repeat
							Swait()
							RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.75 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(45), RAD(0), RAD(15)), 1 / Animation_Speed)
							Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(35 + MRANDOM(-5,5) - 2.5 * COS(SINE / 12)), RAD(MRANDOM(-5,5)), RAD(-15)), 1 / Animation_Speed)
							RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.45, 1-DEPTH/5, -DEPTH/8) * ANGLES(RAD(60 + MRANDOM(-5,5)), RAD(0), RAD(25 + MRANDOM(-5,5))) * ANGLES(RAD(0), RAD(80), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
							LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(5), RAD(0), RAD(5)) * LEFTSHOULDERC0, 1 / Animation_Speed)
							RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.25 - 0.05 * COS(SINE / 12), -0.5) * ANGLES(RAD(40), RAD(70), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
							LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.3) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
						until ATE == true
					end))
					wait()
					ERUPT()
					wait(2)
					ERUPT()
					DEPTH = 2
					wait(2)
					ERUPT()
					DEPTH = 2.5
					wait(3)
					ERUPT()
					ERUPT()
					HEAD:remove()
					DEAD = true
					ApplyDamage(HUM,0,true)
					wait(0.2)
					ATE = true
					UNANCHOR = true
					ATTACK = false
					Rooted = false
				end
			end
		end
	end
end


function ApplyAoE5(POSITION, RANGE, MINDMG, MAXDMG, FLING, EBANISH)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					if EBANISH == true then
						Banish(CHILD)
					else
						local DMG = MRANDOM(MINDMG, MAXDMG)
						ApplyDamage(HUM, DMG, TORSO)
					end
					if FLING > 0 then
						for _, c in pairs(CHILD:GetChildren()) do
							if c:IsA("BasePart") then
								local bv = Instance.new("BodyVelocity")
								bv.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
								bv.velocity = CF(POSITION, TORSO.Position).lookVector * FLING
								bv.Parent = c
								Debris:AddItem(bv, 0.05)
							end
						end
					end
				end
			end
		end
	end
end

local A = IT("Attachment",RightBarrel)
A.Position = VT(0,-2.5,0)
local B = IT("Attachment",RightBarrel)
B.Position = VT(0,2.5,0)
local Trail = IT("Trail",RightBarrel)
Trail.Attachment0 = A
Trail.Attachment1 = B
Trail.Lifetime = 0.2
Trail.Color = ColorSequence.new(BRICKC"Crimson".Color)
Trail.Transparency = NumberSequence.new(0, 1)
Trail.Enabled = false

function Execute()
	ATTACK = true
	Rooted = false
	local Part = CreatePart(3, Character, "Neon", 0, 0, "Crimson", "Part", VT(0,1,4),false)
	Part.Color = C3(0,0,0)
	MakeForm(Part,"Wedge")
	Part.CanCollide = true
	CreateWeldOrSnapOrMotor("Weld", Handle, RightBarrel, Part, CF(0, 0, 0) * ANGLES(RAD(90), RAD(0), RAD(135)) *CF(0, 0.5, 0), CF(0, 0, 0))
	for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.2 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-50)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(50)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(125), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(140 - 12 * SIN(SINE / 12)), RAD(15 + 2.5 * SIN(SINE / 12)), RAD(-35 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-35-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-35-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	Trail.Enabled = true
	CreateSound(541909867, RightBarrel, 7, 1, false)
	local TOCH = Part.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChildOfClass("Humanoid") and hit.Parent ~= Character then
			Banish(hit.Parent)
		end
	end)
	for i=0, 0.35, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.2 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(50)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-45)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.25, -0.3) * ANGLES(RAD(50), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(140 - 12 * SIN(SINE / 12)), RAD(15 + 2.5 * SIN(SINE / 12)), RAD(-35 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-35-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-35-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	TOCH:disconnect()
	Trail.Enabled = false
	for i=0, 0.35, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.2 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(60)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-55)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.25, -0.3) * ANGLES(RAD(50), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.35 + 0.15 * COS(SINE / 12), 0) * ANGLES(RAD(140 - 12 * SIN(SINE / 12)), RAD(15 + 2.5 * SIN(SINE / 12)), RAD(-35 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(-35-2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(-35-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	Part:remove()
	ATTACK = false
	Rooted = false
end

local DECAL = IT("Decal")
function MakeRing()
	local RING = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "MagicRing", VT(0, 0, 0), true)
	local MSH = IT("BlockMesh", RING)
	local TOP = DECAL:Clone()
	local BOTTOM = DECAL:Clone()
	TOP.Parent = RING
	BOTTOM.Parent = RING
	TOP.Face = "Top"
	BOTTOM.Face = "Bottom"
	TOP.Texture = "http://www.roblox.com/asset/?id=647661410"
	BOTTOM.Texture = "http://www.roblox.com/asset/?id=647661410"
	local function REMOVE()
		coroutine.resume(coroutine.create(function()
			local SIZE = MSH.Scale.X
			for i = 1, 35 do
				Swait()
				MSH.Scale = MSH.Scale - VT(SIZE, 0, SIZE) / 60
				TOP.Transparency = TOP.Transparency + 0.02857142857142857
				BOTTOM.Transparency = BOTTOM.Transparency + 0.02857142857142857
				RING.CFrame = RING.CFrame * ANGLES(RAD(0), RAD(-5), RAD(0))
			end
			RING:remove()
		end))
	end
	return RING, MSH, REMOVE
end

function ApplyAoE(POSITION,RANGE,ISBANISH)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						if ISBANISH == true then
							Banish(CHILD)
						else
							if ISBANISH == "Gravity" then
								HUM.PlatformStand = true
								if TORSO:FindFirstChild("V3BanishForce"..Player.Name) then
									local grav = Instance.new("BodyPosition",TORSO)
									grav.D = 15
									grav.P = 20000
									grav.maxForce = Vector3.new(math.huge,math.huge,math.huge)
									grav.position = TORSO.Position
									grav.Name = "V3BanishForce"..Player.Name
								else
									TORSO:FindFirstChild("V3BanishForce"..Player.Name).position = TORSO.Position+VT(0,0.3,0)
									TORSO.RotVelocity = VT(MRANDOM(-25,25),MRANDOM(-25,25),MRANDOM(-25,25))
								end
							else
								HUM.PlatformStand = false
							end
						end
					elseif ISBANISH == "Gravity" then
						if TORSO:FindFirstChild("V3BanishForce"..Player.Name) then
							TORSO:FindFirstChild("V3BanishForce"..Player.Name):remove()
							HUM.PlatformStand = false
						end
					end
				end
			end
		end
	end
end

function Smite()
	local RING, MESH, DELET = MakeRing()
	local POS = Mouse.Hit.p
	RING.CFrame = CF(Mouse.Hit.p + VT(MRANDOM(-25, 25), 200, MRANDOM(-25, 25)), Mouse.Hit.p) * ANGLES(RAD(90), RAD(0), RAD(0))
	for i = 1, 45 do
		Swait()
		MESH.Scale = MESH.Scale + VT(12, 0, 12)
		RING.CFrame = RING.CFrame * ANGLES(RAD(0), RAD(5), RAD(0))
	end
	local HITFLOOR, HITPOS = Raycast(RING.Position, CF(RING.Position, RING.CFrame * CF(0, -1, 0).p).lookVector, 500, Character)
	if HITFLOOR then
		local BEAM = CreatePart(3, Effects, "Neon", 0, 0, BRICKC("Lily white"), "Beam", VT(0, 0, 0), true)
		MakeForm(BEAM, "Cyl")
		local DIST = (RING.Position - HITPOS).Magnitude
		BEAM.Size = VT(0, DIST, 0)
		BEAM.CFrame = CF(RING.Position, HITPOS) * CF(0, 0, -DIST / 2) * ANGLES(RAD(90), RAD(0), RAD(0))
		for i = 1, 5 do
			WACKYEFFECT({
				EffectType = "Wave",
				Size = VT(25, 0, 25),
				Size2 = VT(40, 0, 40) + VT(i * 6, i / 5, i * 6),
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(HITPOS) * ANGLES(RAD(0), RAD(72 * i), RAD(0)),
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 3,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 0, 0),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				EffectType = "Round Slash",
				Size = VT(3, 0, 3) / 13,
				Size2 = (VT(3, 0, 3) + VT(i, 0, i)) / 5,
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(HITPOS) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)) * ANGLES(RAD(MRANDOM(-35, 35)), RAD(0), RAD(MRANDOM(-35, 35))),
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 0, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 35,
				EffectType = "Sphere",
				Size = VT(22, 22, 22),
				Size2 = VT(45, 45, 45) + VT(i * 5, i * 5, i * 5),
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(HITPOS),
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(0, .7, 0),
				SoundID = 459523898,
				SoundPitch = MRANDOM(9, 12) / 10,
				SoundVolume = 10
			})
		end
		ApplyAoE(HITPOS, 50, true)
		for i = 1, 25 do
			Swait()
			BEAM.Size = BEAM.Size + VT(0.15, 0, 0.15)
			BEAM.Transparency = BEAM.Transparency + 0.04
		end
		BEAM:remove()
	end
	wait(0.2)
	DELET()
end

function CorruptedBurningBeam()
	ATTACK = true
	Rooted = false
	chatfunc("Why Dont You Just Leave My Sights Already")
	local GYRO = IT("BodyGyro", RootPart)
	GYRO.D = 20
	GYRO.P = 4000
	GYRO.MaxTorque = VT(0, 40000, 0)
	local RING, MESH, DELET = MakeRing()
	local POS = RootPart.Position + VT(0, 25, 0)
	RING.CFrame = CF(POS, Mouse.Hit.p) * ANGLES(RAD(90), RAD(0), RAD(0))
	CreateSound(459523787, RING, 8, 1, false)
	local BLASTS = {468991944, 468991990}
	coroutine.resume(coroutine.create(function()
		local E = 0
		repeat
			E = E + 5
			GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
			Swait()
			RING.CFrame = CF(POS, Mouse.Hit.p) * ANGLES(RAD(90), RAD(E), RAD(0))
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.45 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(90)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-90)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.25 * COS(SINE / 12), 0) * ANGLES(RAD(0 - 7.5 * SIN(SINE / 12)), RAD(0 + 7.5 * SIN(SINE / 12)), RAD(-12 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.15 * COS(SINE / 12), -0.01) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.25 * COS(SINE / 12), -0.5) * ANGLES(RAD(-7.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		until ATTACK == false
		GYRO:remove()
		DELET()
	end))
	for i = 1, 50 do
		Swait()
		MESH.Scale = MESH.Scale + VT(22, 0, 22)
	end
	for i = 1, 25 do
		Swait()
		WACKYEFFECT({
			Time = 15,
			EffectType = "Sphere",
			Size = VT(4, 4, 4),
			Size2 = VT(0, 0, 0),
			Transparency = 1,
			Transparency2 = 0,
			CFrame = CF(RING.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 0, 35),
			MoveToPos = RING.Position,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = C3(1, 0, 0),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
	end
	local LOOP = 0
	local BEAM = CreatePart(3, Effects, "Neon", 0, 0, BRICKC("Dark indigo"), "Beam", VT(0, 0, 0), true)
	MakeForm(BEAM, "Cyl")
	CreateSound(BLASTS[MRANDOM(1, #BLASTS)], RING, 5, MRANDOM(9, 11) / 10, false)
	repeat
		local DISTANCE = (RING.Position - Mouse.Hit.p).Magnitude
		if DISTANCE < 2000 then
			BEAM.Size = VT(10 + 2 * COS(SINE / 4), DISTANCE, 10 + 2 * COS(SINE / 4))
			BEAM.CFrame = CF(RING.Position, Mouse.Hit.p) * CF(0, 0, -DISTANCE / 2) * ANGLES(RAD(90), RAD(0), RAD(0))
			ApplyAoE(Mouse.Hit.p, 35, true)
			WACKYEFFECT({
				Time = 35,
				EffectType = "Sphere",
				Size = VT(10 + 2 * COS(SINE / 4), 10 + 2 * COS(SINE / 4), 10 + 2 * COS(SINE / 4)) * 2,
				Size2 = VT(5, 75, 5),
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(Mouse.Hit.p) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(0, 0, 0),
				SoundID = nil,
				SoundPitch = MRANDOM(9, 12) / 10,
				SoundVolume = 10
			})
			Swait()
			LOOP = LOOP + 1
		end
	until KEYHOLD == false and LOOP >= 35 or DISTANCE >= 2000
	coroutine.resume(coroutine.create(function()
		for i = 1, 15 do
			Swait()
			BEAM.Size = BEAM.Size - VT(0.8, 0, 0.8)
			BEAM.Transparency = BEAM.Transparency + 0.06666666666666667
		end
		BEAM:remove()
	end))
	ATTACK = false
	Rooted = false
end

function PlanetaryDevastation()
	ATTACK = true
	Rooted = true
	chatfunc("Burn In My Special Hell")
	local SIZE = 1
	local GYRO = IT("BodyGyro", RootPart)
	GYRO.D = 20
	GYRO.P = 4000
	GYRO.MaxTorque = VT(0, 40000, 0)
	local RING, MESH, DELET = MakeRing()
	local HITFLOOR, HITPOS = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 15, Character)
	RING.CFrame = CF(HITPOS)
	for i = 0, 0.6, 0.1 / Animation_Speed do
		GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
		Swait()
		MESH.Scale = MESH.Scale + VT(53, 0, 53)
		RING.CFrame = RING.CFrame * ANGLES(RAD(0), RAD(5), RAD(0))
		WACKYEFFECT({TIME = 15, EffectType = "Block", Size = VT(3,3,3)/3, Size2 = VT(1,1,1)/3, Transparency = 0.5, Transparency2 = 1, CFrame = RightArm.CFrame*CF(0,-1.3,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 5})
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1.1*SIZE) - 1)) * ANGLES(RAD(-25 - 4 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.6, 0.75, -0.5) * ANGLES(RAD(0), RAD(-45), RAD(12)) * ANGLES(RAD(125 - 2.5 * COS(SINE / 12) + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 2.5 / Animation_Speed)
	end
	local BLASTS = {468991944, 468991990}
	coroutine.resume(coroutine.create(function()
		local CFRAME = RootPart.CFrame
		for i = 1, 100 do
			CFRAME = CFRAME * CF(0, 0, -35)
			do
				local HITFLOOR, HITPOS = Raycast(CFRAME.p, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 15, Character)
				if HITFLOOR then
					Swait()
					do
						local OFFSET = CFRAME * CF(MRANDOM(-25, 25), 0, 0)
						coroutine.resume(coroutine.create(function()
							local RING, MESH, DELET = MakeRing()
							RING.CFrame = CF(OFFSET.p.X, HITPOS.Y, OFFSET.p.Z)
							for i = 1, 25 do
								Swait()
								MESH.Scale = MESH.Scale + VT(42, 0, 42)
								RING.CFrame = RING.CFrame * ANGLES(RAD(0), RAD(5), RAD(0))
							end
							ApplyAoE(RING.Position, 65, true)
							local TURN = ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)) * ANGLES(RAD(MRANDOM(0, 25)), RAD(0), RAD(0))
							WACKYEFFECT({
								Time = 25,
								EffectType = "Sphere",
								Size = VT(22, 22, 22),
								Size2 = VT(85, 85, 85),
								Transparency = 0,
								Transparency2 = 1,
								CFrame = CF(RING.Position),
								MoveToPos = nil,
								RotationX = 0,
								RotationY = 0,
								RotationZ = 0,
								Material = "Neon",
								Color = C3(1, 0, 0),
								SoundID = BLASTS[MRANDOM(1, #BLASTS)],
								SoundPitch = MRANDOM(9, 12) / 10,
								SoundVolume = 10
							})
							for e = 1, 3 do
								WACKYEFFECT({
									EffectType = "Wave",
									Size = VT(25, 0, 25),
									Size2 = VT(40, 0, 40) + VT(e * 6, e / 5, e * 6),
									Transparency = 0,
									Transparency2 = 1,
									CFrame = CF(RING.Position) * ANGLES(RAD(0), RAD(72 * i), RAD(0)),
									MoveToPos = nil,
									RotationX = 0,
									RotationY = 3,
									RotationZ = 0,
									Material = "Neon",
									Color = C3(1, 0, 1),
									SoundID = nil,
									SoundPitch = nil,
									SoundVolume = nil
								})
								WACKYEFFECT({
									Time = 35,
									EffectType = "Sphere",
									Size = VT(22, 45, 22),
									Size2 = VT(25, 45 + e * 75, 25),
									Transparency = 0,
									Transparency2 = 1,
									CFrame = CF(RING.Position) * TURN,
									MoveToPos = nil,
									RotationX = 0,
									RotationY = 0,
									RotationZ = 0,
									Material = "Neon",
									Color = C3(0, .5, 0),
									SoundID = nil,
									SoundPitch = MRANDOM(9, 12) / 10,
									SoundVolume = 10
								})
							end
							wait(0.3)
							DELET()
						end))
					end
				end
			end
		end
	end))
	Rooted = false
	DELET()
	GYRO:remove()
	ATTACK = false
	Rooted = false
end

function CreateFlyingDebree(FLOOR, POSITION, AMOUNT, BLOCKSIZE, SWAIT, STRENGTH)
	if FLOOR ~= nil then
		for i = 1, AMOUNT do
			do
				local DEBREE = CreatePart(3, Effects, "Neon", FLOOR.Reflectance, 0, "Peal", "Debree", BLOCKSIZE, false)
				DEBREE.Material = FLOOR.Material
				DEBREE.Color = FLOOR.Color
				DEBREE.CFrame = POSITION * ANGLES(RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)))
				DEBREE.Velocity = VT(MRANDOM(-STRENGTH, STRENGTH), STRENGTH, MRANDOM(-STRENGTH, STRENGTH))
				coroutine.resume(coroutine.create(function()
					Swait(15)
					DEBREE.Parent = workspace
					DEBREE.CanCollide = true
					Debris:AddItem(DEBREE, SWAIT)
				end))
			end
		end
	end
end

function CreateFlyingDebree2(FLOOR,POSITION,AMOUNT,BLOCKSIZE,SWAIT,STRENGTH)
	if FLOOR ~= nil then
		for i = 1, AMOUNT do
			local DEBREE = CreatePart(3, Effects, "Neon", 0, 0, "Deep orange", "Debree", BLOCKSIZE, false)
			DEBREE.Material = FLOOR.Material
			DEBREE.Color = FLOOR.Color
			DEBREE.CFrame = POSITION * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)))
			DEBREE.Velocity = VT(MRANDOM(-STRENGTH,STRENGTH),STRENGTH,MRANDOM(-STRENGTH,STRENGTH))
			coroutine.resume(coroutine.create(function()
				Swait(15)
				DEBREE.Parent = workspace
				DEBREE.CanCollide = true
				Debris:AddItem(DEBREE,SWAIT)
			end))
		end
	end
end

function CreateDebreeRing2(FLOOR,POSITION,SIZE,BLOCKSIZE,SWAIT)
	if FLOOR ~= nil then
		coroutine.resume(coroutine.create(function()
			local PART = CreatePart(3, Effects, "Plastic", 0, 1, "Lime green", "DebreeCenter", VT(0,0,0))
			PART.CFrame = CF(POSITION)
			for i = 1, 45 do
				local RingPiece = CreatePart(3, Effects, "Plastic", 0, 0, "Really blue", "DebreePart", BLOCKSIZE)
				RingPiece.Material = FLOOR.Material
				RingPiece.Color = FLOOR.Color
				RingPiece.CFrame = PART.CFrame * ANGLES(RAD(0), RAD(i*8), RAD(0)) * CF(SIZE*4, 0, 0) * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)))
				Debris:AddItem(RingPiece,SWAIT)
			end
			PART:remove()
		end))
	end
end

function CreateDebreeRing(FLOOR, POSITION, SIZE, BLOCKSIZE, SWAIT)
	if FLOOR ~= nil then
		coroutine.resume(coroutine.create(function()
			local PART = CreatePart(3, Effects, "Plastic", 0, 1, "Pearl", "DebreeCenter", VT(0, 0, 0))
			PART.CFrame = CF(POSITION)
			for i = 1, 45 do
				local RingPiece = CreatePart(3, Effects, "Plastic", 0, 0, "Pearl", "DebreePart", BLOCKSIZE)
				RingPiece.Material = FLOOR.Material
				RingPiece.Color = FLOOR.Color
				RingPiece.CFrame = PART.CFrame * ANGLES(RAD(0), RAD(i * 8), RAD(0)) * CF(SIZE * 4, 0, 0) * ANGLES(RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)))
				Debris:AddItem(RingPiece, SWAIT)
			end
			PART:remove()
		end))
	end
end

function BIGSMASH()
	local HITFLOOR, HITPOS = Raycast(Mouse.Hit.p + VT(0, 1, 0), CF(Mouse.Hit.p + VT(0, 10, 0), Mouse.Hit.p - VT(0, 10, 0)).lookVector, 25, Character)
	chatfunc("Die.")
	if HITFLOOR then
		local ORIGINPOS = VT(RootPart.Position.X, HITPOS.Y + 8, RootPart.Position.Z)
		CreateSound("1295446488", Torso, 5, 1)
		for i = 1, 5 do
			WACKYEFFECT({
				Time = MRANDOM(15, 35),
				EffectType = "Round Slash",
				Size = VT(0, 0, 0),
				Size2 = VT(0.3, 0, 0.3),
				Transparency = 0.5,
				Transparency2 = 1,
				CFrame = CF(Torso.Position) * ANGLES(RAD(MRANDOM(-25, 25)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(-25, 25))),
				MoveToPos = nil,
				RotationX = MRANDOM(-50, 50) / 10,
				RotationY = MRANDOM(-50, 50) / 10,
				RotationZ = MRANDOM(-50, 50) / 10,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
		end
		ATTACK = true
		Rooted = true
		UNANCHOR = false
		RootPart.Anchored = true
		RootPart.CFrame = CF(HITPOS + VT(0, 8, 0), ORIGINPOS) * ANGLES(RAD(0), RAD(180), RAD(0))
		for i = 1, 5 do
			WACKYEFFECT({
				Time = MRANDOM(15, 35),
				EffectType = "Round Slash",
				Size = VT(0, 0, 0),
				Size2 = VT(0.3, 0, 0.3),
				Transparency = 0.5,
				Transparency2 = 1,
				CFrame = CF(Torso.Position) * ANGLES(RAD(MRANDOM(-25, 25)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(-25, 25))),
				MoveToPos = nil,
				RotationX = MRANDOM(-50, 50) / 10,
				RotationY = MRANDOM(-50, 50) / 10,
				RotationZ = MRANDOM(-50, 50) / 10,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
		end
		for i = 0, 0.2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(90), RAD(0), RAD(150)), 2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-12)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 2 / Animation_Speed)
		end
		for i = 0, 1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(90), RAD(0), RAD(300)), 0.02 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-45)), 0.02 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-12)) * RIGHTSHOULDERC0, 0.02 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.02 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.02 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 0.02 / Animation_Speed)
		end
		for i = 1, 10 do
			Swait()
			RootPart.CFrame = RootPart.CFrame * CF(0, -0.4, 0)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(90), RAD(0), RAD(300)), 1.7 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-45)), 1.7 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-12)) * RIGHTSHOULDERC0, 1.7 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 1.7 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.7 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1.7 / Animation_Speed)
		end
		for i = 0, 0.2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(90), RAD(0), RAD(90)), 1.5 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 1.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 1.5 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1.5 / Animation_Speed)
		end
		local HITFLOOR, HITPOS = Raycast(RightArm.Position, CF(RightArm.Position, RightArm.Position + VT(0, -1, 0)).lookVector, 8, Character)
		if HITFLOOR then
			if HITFLOOR.Parent:FindFirstChildOfClass("Humanoid") then
				local CHILDREN = HITFLOOR.Parent:GetDescendants()
				for index, CHILD in pairs(CHILDREN) do
					if CHILD:IsA("BasePart") and CHILD.Parent:FindFirstChildOfClass("Humanoid") then
						for i = 1, 5 do
							CreateFlyingDebree(CHILD, CF(CHILD.Position), 1, CHILD.Size / 2, 5, MRANDOM(15, 25))
							CHILD:remove()
						end
					end
				end
				local SOUNDPART = CreatePart(3, Effects, "Grass", 0, 1, "Lily white", "Sound", VT(0, 0, 0))
				SOUNDPART.CFrame = CF(HITPOS)
				Debris:AddItem(SOUNDPART, 5)
				CreateSound("130972023", SOUNDPART, 6, 3)
				CreateSound("182765513", SOUNDPART, 6, 1)
				WACKYEFFECT({
					EffectType = "Ring",
					Size = VT(0, 0, 0),
					Size2 = VT(1, 1, 0),
					Transparency = 0.7,
					Transparency2 = 1,
					CFrame = CF(HITPOS) * ANGLES(RAD(90), RAD(0), RAD(0)),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
			elseif HITFLOOR.Parent.Parent:FindFirstChildOfClass("Humanoid") then
				local CHILDREN = HITFLOOR.Parent.Parent:GetDescendants()
				for index, CHILD in pairs(CHILDREN) do
					if CHILD:IsA("BasePart") and CHILD.Parent:FindFirstChildOfClass("Humanoid") then
						for i = 1, 5 do
							CreateFlyingDebree(CHILD, CF(CHILD.Position), 1, CHILD.Size / 2, 5, MRANDOM(15, 25))
							CHILD:remove()
						end
					end
				end
				local SOUNDPART = CreatePart(3, Effects, "Grass", 0, 1, "Lily white", "Sound", VT(0, 0, 0))
				SOUNDPART.CFrame = CF(HITPOS)
				Debris:AddItem(SOUNDPART, 5)
				CreateSound("130972023", SOUNDPART, 6, 3)
				CreateSound("182765513", SOUNDPART, 6, 1)
				WACKYEFFECT({
					EffectType = "Ring",
					Size = VT(0, 0, 0),
					Size2 = VT(1, 1, 0),
					Transparency = 0.7,
					Transparency2 = 1,
					CFrame = CF(HITPOS) * ANGLES(RAD(90), RAD(0), RAD(0)),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
			elseif HITFLOOR.Anchored == false then
				if HITFLOOR.Parent ~= workspace then
					local CHILDREN = HITFLOOR.Parent:GetDescendants()
					for index, CHILD in pairs(CHILDREN) do
						if CHILD:IsA("BasePart") and CHILD.Position.Y < HITPOS.Y then
							for i = 1, 5 do
								CreateFlyingDebree(CHILD, CF(CHILD.Position), 1, CHILD.Size / 3, 5, MRANDOM(15, 25))
							end
							CHILD:remove()
						end
					end
				else
					for i = 1, 5 do
						CreateFlyingDebree(HITFLOOR, CF(HITFLOOR.Position), 1, HITFLOOR.Size / 3, 5, MRANDOM(15, 25))
					end
					HITFLOOR:remove()
				end
				local SOUNDPART = CreatePart(3, Effects, "Grass", 0, 1, "Lily white", "Sound", VT(0, 0, 0))
				SOUNDPART.CFrame = CF(HITPOS)
				Debris:AddItem(SOUNDPART, 5)
				CreateSound("130972023", SOUNDPART, 10, 3)
				CreateSound("178452217", SOUNDPART, 6, 1)
				WACKYEFFECT({
					EffectType = "Ring",
					Size = VT(0, 0, 0),
					Size2 = VT(1, 1, 0),
					Transparency = 0.7,
					Transparency2 = 1,
					CFrame = CF(HITPOS) * ANGLES(RAD(90), RAD(0), RAD(0)),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
			else
				local SOUNDPART = CreatePart(3, Effects, "Grass", 0, 1, "Lily white", "Sound", VT(0, 0, 0))
				SOUNDPART.CFrame = CF(HITPOS)
				Debris:AddItem(SOUNDPART, 5)
				CreateSound("130972023", SOUNDPART, 10, 1)
				CreateSound("130972023", SOUNDPART, 6, 0.7)
				CreateDebreeRing(HITFLOOR, HITPOS, 5, VT(5, 5, 5), 5)
				CreateDebreeRing(HITFLOOR, HITPOS, 8, VT(8, 8, 8), 5)
				ApplyAoE5(HITPOS, 15, 45, 75, 75, true)
				ApplyAoE5(HITPOS, 25, 25, 35, 35, true)
				for i = 1, 5 do
					CreateFlyingDebree(HITFLOOR, CF(HITPOS), 1, VT(MRANDOM(10, 30) / 10, MRANDOM(10, 30) / 10, MRANDOM(10, 30) / 10), 5, MRANDOM(75, 150))
				end
				for i = 1, 5 do
					CreateFlyingDebree(HITFLOOR, CF(HITPOS), 1, VT(MRANDOM(10, 30) / 2, MRANDOM(10, 30) / 2, MRANDOM(10, 30) / 2), 5, MRANDOM(75, 150))
				end
			end
		end
		for i = 0, 1.2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(90), RAD(0), RAD(90)), 1.5 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 1.5 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(40)) * RIGHTSHOULDERC0, 1.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 1.5 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1.5 / Animation_Speed)
		end
		ATTACK = false
		Rooted = false
		UNANCHOR = true
		RootPart.Anchored = false
	end
end

function calamity()
	ATTACK = true
	Rooted = true
	local GYRO = IT("BodyGyro", RootPart)
	GYRO.D = 15
	GYRO.P = 2000
	GYRO.MaxTorque = VT(0, 4000000, 0)
	CreateSound("341301115", Head, 5, 1.1)
	CreateSound("93724183", Head, 6, 1)
	for i = 1, 200 do
		Swait()
		WACKYEFFECT({
			Time = MRANDOM(5, 15),
			EffectType = "Round Slash",
			Size = VT(0, 0, 0),
			Size2 = VT(0.12, 0, 0.12),
			Transparency = 0.5,
			Transparency2 = 1,
			CFrame = RootPart.CFrame * CF(0, -2.8, 0) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)),
			MoveToPos = nil,
			RotationX = MRANDOM(-50, 50) / 50,
			RotationY = MRANDOM(-50, 50) / 10,
			RotationZ = MRANDOM(-50, 50) / 50,
			Material = "Neon",
			Color = C3(0, 0, 0),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		WACKYEFFECT({
			Time = MRANDOM(5, 15),
			EffectType = "Round Slash",
			Size = VT(0, 0, 0),
			Size2 = VT(0.1, 0, 0.1),
			Transparency = 0.5,
			Transparency2 = 1,
			CFrame = Torso.CFrame * CF(0, -2.5, 1) * ANGLES(RAD(-35), RAD(MRANDOM(0, 360)), RAD(0)),
			MoveToPos = nil,
			RotationX = MRANDOM(-50, 50) / 50,
			RotationY = MRANDOM(-50, 50) / 10,
			RotationZ = MRANDOM(-50, 50) / 50,
			Material = "Neon",
			Color = C3(.2, 0, 0),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		WACKYEFFECT({
			Time = MRANDOM(5, 15),
			EffectType = "Round Slash",
			Size = VT(0, 0, 0),
			Size2 = VT(0.16, 0, 0.16),
			Transparency = 0.5,
			Transparency2 = 1,
			CFrame = Torso.CFrame * CF(0, -2.5, 1) * ANGLES(RAD(-45), RAD(MRANDOM(0, 360)), RAD(0)),
			MoveToPos = nil,
			RotationX = MRANDOM(-50, 50) / 50,
			RotationY = MRANDOM(-50, 50) / 10,
			RotationZ = MRANDOM(-50, 50) / 50,
			Material = "Neon",
			Color = C3(.3, 0, 0),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		WACKYEFFECT({
			Time = 5,
			EffectType = "Sphere",
			Size = VT(i, i, i) / 150,
			Size2 = VT(0, 0, 0),
			Transparency = 0.5,
			Transparency2 = 1,
			CFrame = Head.CFrame * CF(0, -0.25, -1),
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = C3(.4, 0, 0),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		GYRO.cframe = CF(RootPart.Position, Mouse.Hit.p)
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0.1, -0.05 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 0.05 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.05 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-20), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.05 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-20), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.05 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(-15), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.05 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(-15), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.05 / Animation_Speed)
	end
	GYRO:remove()
	for i = 0, 0.3, 0.1 / Animation_Speed do
		Swait()
		WACKYEFFECT({
			Time = 25,
			EffectType = "Sphere",
			Size = VT(200, 200, 200) / 150,
			Size2 = VT(0, 0, 0),
			Transparency = 0.5,
			Transparency2 = 1,
			CFrame = Head.CFrame * CF(0, -0.25, -1),
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = C3(.5, 0, .5),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, -0.1, -0.05 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-20), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-20), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(15), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(15), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	end
	coroutine.resume(coroutine.create(function()
		local FIREBALL = CreatePart(3, Effects, "Neon", 0, 0, "Dark Orange", "DOOM", VT(1, 1, 1))
		MakeForm(FIREBALL, "Ball")
		local SOUND = CreateSound(463593339, FIREBALL, 8, 1, false)
		FIREBALL.CFrame = CF(Head.Position, Mouse.Hit.p) * CF(0, 0, -2)
		for i = 1, 500 do
			Swait()
			FIREBALL.CFrame = FIREBALL.CFrame * CF(0, 0, -2)
			local HITFLOOR, HITPOS = Raycast(FIREBALL.Position, FIREBALL.CFrame.lookVector, 2.2, Character)
			if HITFLOOR ~= nil then
				break
			end
		end
		CreateSound(325132788, Effects, 8, 1, false)
		for i = 1, 120 do
			Swait()
			WACKYEFFECT({
				Time = 85,
				EffectType = "Sphere",
				Size = FIREBALL.Size,
				Size2 = VT(0, 9000, 0),
				Transparency = 0.5,
				Transparency2 = 1,
				CFrame = FIREBALL.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
				MoveToPos = nil,
				RotationX = MRANDOM(-50, 50) / 10,
				RotationY = MRANDOM(-50, 50) / 10,
				RotationZ = MRANDOM(-50, 50) / 10,
				Material = "Neon",
				Color = C3(.6, 0, .6),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			FIREBALL.Size = FIREBALL.Size - VT(1, 1, 1) / 120
		end
		Swait(5)
		ApplyAoE5(FIREBALL.Position, 435, 65, 65, 600, true)
		for i = 1, 10 do
			WACKYEFFECT({
				Time = 85 + 5 * i,
				EffectType = "Slash",
				Size = VT(9, 0, 9),
				Size2 = VT(32, 0, 32),
				Transparency = 0.5,
				Transparency2 = 1,
				CFrame = FIREBALL.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
				MoveToPos = nil,
				RotationX = MRANDOM(-50, 50) / 50,
				RotationY = MRANDOM(-50, 50) / 10,
				RotationZ = MRANDOM(-50, 50) / 50,
				Material = "Neon",
				Color = C3(0, 0, 0),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 185 + 5 * i,
				EffectType = "Swirl",
				Size = VT(25, 25, 25),
				Size2 = VT(900, 900, 900) + VT(35, 35, 35) * i,
				Transparency = 0.5,
				Transparency2 = 1,
				CFrame = FIREBALL.CFrame * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)),
				MoveToPos = nil,
				RotationX = MRANDOM(-50, 50) / 50,
				RotationY = MRANDOM(-50, 50) / 10,
				RotationZ = MRANDOM(-50, 50) / 50,
				Material = "Neon",
				Color = C3(1, 0.5, 0.5),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 285 + 5 * i,
				EffectType = "Round Slash",
				Size = VT(6, 0, 6),
				Size2 = VT(22, 0, 22),
				Transparency = 0.5,
				Transparency2 = 1,
				CFrame = FIREBALL.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
				MoveToPos = nil,
				RotationX = MRANDOM(-50, 50) / 50,
				RotationY = MRANDOM(-50, 50) / 10,
				RotationZ = MRANDOM(-50, 50) / 50,
				Material = "Neon",
				Color = C3(1, 1, 0),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 285 + 5 * i,
				EffectType = "Sphere",
				Size = VT(850, 850, 850),
				Size2 = VT(1050, 1050, 1050) + VT(35, 35, 35) * i,
				Transparency = 0.5,
				Transparency2 = 1,
				CFrame = FIREBALL.CFrame,
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(0, 1, 1),
				SoundID = nil,
				SoundPitch = 0,
				SoundVolume = 0
			})
		end
		wait(1)
		WACKYEFFECT({
			Time = 75,
			EffectType = "Sphere",
			Size = VT(550, 550, 550),
			Size2 = VT(6500, 6500, 6500),
			Transparency = 0.8,
			Transparency2 = 1,
			CFrame = FIREBALL.CFrame,
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = C3(1, 1, 1),
			SoundID = nil,
			SoundPitch = 0,
			SoundVolume = 0
		})
		for i = 1, 15 do
			Swait()
			ApplyAoE5(FIREBALL.Position, 435 + 85 * i, 3, 3, 100, true)
			WACKYEFFECT({
				Time = 85,
				EffectType = "Sphere",
				Size = VT(95, 95, 95),
				Size2 = VT(0, 6500, 0),
				Transparency = 0.5,
				Transparency2 = 1,
				CFrame = FIREBALL.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
				MoveToPos = nil,
				RotationX = MRANDOM(-50, 50) / 10,
				RotationY = MRANDOM(-50, 50) / 10,
				RotationZ = MRANDOM(-50, 50) / 10,
				Material = "Neon",
				Color = C3(0, 0, 0),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
		end
		FIREBALL:remove()
	end))
	WACKYEFFECT({
		Time = 25,
		EffectType = "Ring",
		Size = VT(0, 0, 0),
		Size2 = VT(9.75, 9.75, 0),
		Transparency = 0.7,
		Transparency2 = 1,
		CFrame = Head.CFrame * CF(0, -0.25, -0.75),
		MoveToPos = nil,
		RotationX = 0,
		RotationY = 0,
		RotationZ = 0,
		Material = "Neon",
		Color = C3(1, 0, 0),
		SoundID = nil,
		SoundPitch = nil,
		SoundVolume = nil
	})
	WACKYEFFECT({
		Time = 50,
		EffectType = "Ring",
		Size = VT(0, 0, 0),
		Size2 = VT(35, 35, 0),
		Transparency = 0.7,
		Transparency2 = 1,
		CFrame = Head.CFrame * CF(0, -0.25, -0.75),
		MoveToPos = nil,
		RotationX = 0,
		RotationY = 0,
		RotationZ = 0,
		Material = "Neon",
		Color = C3(.4, .1, 0),
		SoundID = nil,
		SoundPitch = nil,
		SoundVolume = nil
	})
	for i = 0, 0.3, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, -0.1, -0.05 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-20), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-20), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(15), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(15), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.5 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end

function MagicSphere3(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = VT(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function CreateRing2(SIZE,DOESROT,ROT,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.5, BRICKC(COLOR), "Effect", VT(0,0,0))
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "FileMesh"
	mesh.MeshId = "http://www.roblox.com/asset/?id=3270017"
	mesh.Scale = SIZE
	mesh.Offset = VT(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			if DOESROT == true then
				wave.CFrame = wave.CFrame * CFrame.fromEulerAnglesXYZ(0,ROT,0)
			end
			wave.Transparency = wave.Transparency + (0.5/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end


function ApplyAoE4(POSITION, RANGE, MINDMG, MAXDMG, FLING, IZBANISH)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					if IZBANISH == true then
						Banish(CHILD)
					else
						local DMG = MRANDOM(MINDMG, MAXDMG)
						ApplyDamage(HUM, DMG, TORSO)
					end
					if FLING > 0 then
						for _, c in pairs(CHILD:GetChildren()) do
							if c:IsA("BasePart") then
								local bv = Instance.new("BodyVelocity")
								bv.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
								bv.velocity = CF(POSITION, TORSO.Position).lookVector * FLING
								bv.Parent = c
								Debris:AddItem(bv, 0.05)
							end
						end
					end
				end
			end
		end
	end
end

function ApplyAoE6(POSITION, RANGE, MINDMG, MAXDMG, FLING, KILLD)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					if KILLD == true then
						Kill2(CHILD)
					else
						local DMG = MRANDOM(MINDMG, MAXDMG)
						ApplyDamage(HUM, DMG, TORSO)
					end
					if FLING > 0 then
						for _, c in pairs(CHILD:GetChildren()) do
							if c:IsA("BasePart") then
								local bv = Instance.new("BodyVelocity")
								bv.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
								bv.velocity = CF(POSITION, TORSO.Position).lookVector * FLING
								bv.Parent = c
								Debris:AddItem(bv, 0.05)
							end
						end
					end
				end
			end
		end
	end
end

function Complete_Control()
	ATTACK = true
	Rooted = true
	chatfunc("Do Not Try To Get Evade This.")
	CreateRing2(VT(0,0,0),false,0,45,RootPart.CFrame*ANGLES(RAD(90),RAD(0),RAD(0)),"Crimson",VT(100,100,100))
	CreateSound("1137548130", Effects, 10, 1)
	MagicSphere3(VT(0,0,0),45,Torso.CFrame,"Maroon",VT(500,500,500))
	ApplyAoE4(Torso.Position, 9999, 0, 0, 0, true)
	ATTACK = false
	Rooted = false
end

function TrustIssues()
	ATTACK = true
	Rooted = false
	CreateSound(649634100,Head,10,0.5,false)
	for i=1, 80 do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.15* COS(i / 5)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-25 + MRANDOM(-5,5)), RAD(MRANDOM(-5,5)), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.15 * SIN(i / 5), 0) * ANGLES(RAD(0), RAD(-15), RAD(5)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.15 * SIN(i / 5), 0) * ANGLES(RAD(0), RAD(15), RAD(-5)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.15 * COS(i / 5), -0.01) * ANGLES(RAD(0), RAD(85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.15 * COS(i / 5), -0.01) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end
function ApplyDamageXY(Humanoid,Damage)
	if Humanoid.Health == math.huge then
		Humanoid.Parent:BreakJoints()
	else
		local MULTIPLY = Humanoid.MaxHealth/100
		Damage = Damage * DAMAGEMULTIPLIER
		if Humanoid.Health ~= 0 then
			Humanoid.Health = Humanoid.Health - Damage*MULTIPLY
		end
	end
end

function ApplyAoEXY(POSITION,RANGE,MINDMG,MAXDMG,FLING,CAMSINSTAKILL,INSTAKILL)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						if INSTAKILL == true or HUM.MaxHealth == math.huge then
							CHILD:BreakJoints()
						else
							local DMG = MRANDOM(MINDMG,MAXDMG)
							ApplyDamageXY(HUM,DMG)
						end
						if FLING > 0 then
							for _, c in pairs(CHILD:GetChildren()) do
								if c:IsA("BasePart") then
									local bv = Instance.new("BodyVelocity") 
									bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
									bv.velocity = CF(POSITION,TORSO.Position).lookVector*FLING
									bv.Parent = c
									Debris:AddItem(bv,0.05)
								end
							end
						end
					end
				end
			end
		end
	end
end

--//=================================\\
--||	ATTACK FUNCTIONS AND STUFF
--\\=================================//

function Fireball()
	ATTACK = true
	Rooted = true
	local GYRO = IT("BodyGyro",RootPart)
	GYRO.D = 20
	GYRO.P = 4000
	GYRO.MaxTorque = VT(40000,40000,40000)
	local POSITION = IT("BodyPosition",RootPart)
	POSITION.Position = RootPart.Position+VT(0,2,0)
	POSITION.D = 450
	POSITION.P = 40000
	POSITION.maxForce = Vector3.new(math.huge,math.huge,math.huge)
	CreateSound(CHARGE,RightArm,6,1,false)
	chatfunc("Die.")
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			GYRO.CFrame = CF(RootPart.Position,Mouse.Hit.p)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(24)), 2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(-24)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.75, -0.3) * ANGLES(RAD(90), RAD(0), RAD(24)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.45, 0.75, 0) * ANGLES(RAD(-25), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		until ATTACK == false
		GYRO:remove()
		POSITION:remove()
	end))
	wait(1)
	repeat
		coroutine.resume(coroutine.create(function()
			local FIREBALL = CreatePart(3, Effects, "Neon", 0, 1, "Cyan", "Flight", VT(10,10,10))
			FIREBALL.CFrame = CF(RightArm.CFrame*CF(0,-1,0).p,Mouse.Hit.p)
			CreateSound(FIREBALLSOUND,FIREBALL,6,1,false)
			for i = 1, 250 do
				Swait()
				local HIT,HITPOS = Raycast(FIREBALL.Position, FIREBALL.CFrame.lookVector, 10, Character)
				FIREBALL.CFrame = FIREBALL.CFrame*CF(0,0,-5)
				if HIT then
					ApplyAoEXY(FIREBALL.Position,200,15,25,35,true,{SHAKE = 2, TIMER = 25, DOESFADE = true})
					for i = 1, 3 do
						WACKYEFFECT({Time = 70, EffectType = "Sphere", Size = VT(50,50,50), Size2 = VT(MRANDOM(200,300),MRANDOM(200,300),MRANDOM(200,300)), Transparency = 0.5, Transparency2 = 1, CFrame = CF(FIREBALL.Position)*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,0,45), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"Bright blue".Color, SoundID = EXPLOSIONMEDIUMSOUND, SoundPitch = MRANDOM(8,12)/10, SoundVolume = MRANDOM(5,10)})
					end
					for i = 1, 3 do
						WACKYEFFECT({Time = 120, EffectType = "Sphere", Size = VT(50,50,50), Size2 = VT(MRANDOM(200,300),MRANDOM(200,300),MRANDOM(200,300)), Transparency = 0.8, Transparency2 = 1, CFrame = CF(FIREBALL.Position)*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,0,45), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = BRICKC"Crimson".Color, SoundID = EXPLOSIONMEDIUMSOUND, SoundPitch = MRANDOM(8,12)/10, SoundVolume = MRANDOM(5,10)})
					end
					for i = 1, 5 do
						WACKYEFFECT({Time = 80+(i*5), EffectType = "Ring", Size = VT(0,0,0), Size2 = VT(40,40,0), Transparency = 0.8, Transparency2 = 1, CFrame = CF(FIREBALL.Position)*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360))), MoveToPos = nil, RotationX = MRANDOM(-15,15)/15, RotationY = MRANDOM(-15,15)/15, RotationZ = MRANDOM(-15,15)/15, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
					end
					break
				end
			end
			Debris:AddItem(FIREBALL,7)
		end))
		wait(0.1)
	until KEYHOLD == false
	wait(0.2)
	ATTACK = false
	Rooted = false
end
function VisualiserStomp()
	ATTACK = true
	Rooted = true
	local HITFLOOR,HITPOS = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 25*SIZE, Character)
	coroutine.resume(coroutine.create(function()
		Swait(65)
		CreateSound(262562442,RightLeg,60,1,false)
		CreateFlyingDebree(HITFLOOR,CF(HITPOS),10,VT(5,5,5),4,125)
		WACKYEFFECT({Time = 25, EffectType = "Sphere", Size = VT(0,0.55,0)*SIZE, Size2 = VT(200,4,200), Transparency = 0, Transparency2 = 1, CFrame = CF(HITPOS), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = Color3.new(1,1,1), SoundID = nil, SoundPitch = 0.96, SoundVolume = 10})
		WACKYEFFECT({Time = 25, EffectType = "Wave", Size = VT(0,7.5,0)*SIZE, Size2 = VT(100,6.5,100), Transparency = 0, Transparency2 = 1, CFrame = CF(HITPOS), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = Color3.new(1,1,1), SoundID = nil, SoundPitch = 0.96, SoundVolume = 10})
		ApplyAoE4(HITPOS,78,45,67,75,false)
	end))
	for i=0, 1.9999999999999999, 0.1 / Animation_Speed do
		WACKYEFFECT({EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(0.25,0.25,0.25), Transparency = 0.5, Transparency2 = 1, CFrame = RightArm.CFrame*CF(0,-1.3,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = Color3.new(1,1,1), SoundID = nil, SoundPitch = 1, SoundVolume = 5})
		Swait()
		RightHip.C0=Clerp(RightHip.C0,cf(1,-1 - 0.05 * math.cos(sine / 28) + sick.PlaybackLoudness/5000,-0.1)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-2.5),math.rad(-20),math.rad(0 - 2 * math.cos(sine / 56) + sick.PlaybackLoudness/450)),.4)
		LeftHip.C0=Clerp(LeftHip.C0,cf(-1,-1 - 0.05 * math.cos(sine / 28) - sick.PlaybackLoudness/6500,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-2.5),math.rad(5),math.rad(0 + 2 * math.cos(sine / 56) + sick.PlaybackLoudness/500)),.4)
		RootJoint.C0=Clerp(RootJoint.C0,RootCF*cf(0,0 + 0.02 * math.cos(sine / 56) ,0 + 0.05 * math.cos(sine / 28) + sick.PlaybackLoudness/7000)*angles(math.rad(0 - 2 * math.cos(sine / 56)),math.rad(0),math.rad(30)),.4)
		Neck.C0=clerp(Neck.C0,NECKC0*angles(math.rad(10 + 2 * math.cos(sine / 28) - sick.PlaybackLoudness/60),math.rad(0 + 2 * math.cos(sine / 73)),math.rad(-30)),.4)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,cf(-1.5,0.5 + 0.02 * math.cos(sine / 28),0)*angles(math.rad(10),math.rad(5),math.rad(7.5)),.4)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.6, 0.75, -0.5) * ANGLES(RAD(0), RAD(-45), RAD(12)) * ANGLES(RAD(125 - 2.5 * COS(SINE / 12) + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 2.5 / Animation_Speed)
	end
	for i=0, 0.4, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.3, -0.75) * ANGLES(RAD(40), RAD(0), RAD(35)), 1.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.45, -1.45) * ANGLES(RAD(75), RAD(0), RAD(35)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(-25), RAD(-12)) * ANGLES(RAD(-35), RAD(55), RAD(0)) * LEFTSHOULDERC0, 2 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -0.5) * ANGLES(RAD(0), RAD(55), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(65)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.6, -0.2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(-15)), 1 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end

function SPEEDYDASH()
	ATTACK = true
	Rooted = false
	CreateSound(1112042117, Torso, 5, 1, false)
	for i = 1, 50 do
		WACKYEFFECT({Time = 25, EffectType = "Sphere", Size = VT(1.5,1,1.5), Size2 = VT(4,0,4), Transparency = 0.35, Transparency2 = 1, CFrame = CF(RightLeg.CFrame*CF(0,-1,0).p), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
		WACKYEFFECT({Time = 25, EffectType = "Sphere", Size = VT(1.5,1,1.5), Size2 = VT(4,0,4), Transparency = 0.35, Transparency2 = 1, CFrame = CF(LeftLeg.CFrame*CF(0,-1,0).p), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
		local DASHTHROUGH = Raycast(RootPart.Position, RootPart.CFrame.lookVector, 4, Character)
		RootPart.CFrame = RootPart.CFrame*CF(0,0,-2)
		if DASHTHROUGH ~= nil then
			if DASHTHROUGH.Parent:FindFirstChildOfClass("Humanoid") then
				local HUM = DASHTHROUGH.Parent:FindFirstChildOfClass("Humanoid")
				local TORSO = DASHTHROUGH.Parent:FindFirstChild("Torso") or DASHTHROUGH.Parent:FindFirstChild("UpperTorso") 
				if TORSO ~= nil and DASHTHROUGH.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then
					Rooted = true
					local SOUND = CreateSound("147758746", TORSO, 10, 1,false)
					RootPart.CFrame = RootPart.CFrame*CF(0,0,-12)
					RootPart.CFrame = CF(RootPart.Position,TORSO.Position)*ANGLES(RAD(0),RAD(180),RAD(0))
					for i=0, 0.5, 0.1 / Animation_Speed do
						Swait()
						TORSO.Anchored = true
						RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, -1.2) * ANGLES(RAD(65), RAD(0), RAD(0)), 3 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 3 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.5, 0.5) * ANGLES(RAD(-35), RAD(0), RAD(-15)) * RIGHTSHOULDERC0, 3 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.5, 0.5) * ANGLES(RAD(-40), RAD(0), RAD(15)) * LEFTSHOULDERC0, 3 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -1) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-20)), 3 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.3, -1) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 3 / Animation_Speed)
					end
					TORSO.Anchored = false
					TORSO.Parent:BreakJoints()
					if TORSO.Parent:FindFirstChild("Head") then
						TORSO.Parent:FindFirstChild("Head"):remove()
					end
					for i=0, 0.1, 0.1 / Animation_Speed do
						Swait()
						RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, -1.2) * ANGLES(RAD(65), RAD(0), RAD(0)), 3 / Animation_Speed)
						Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0)), 3 / Animation_Speed)
						RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.5, 0.5) * ANGLES(RAD(-35), RAD(0), RAD(-15)) * RIGHTSHOULDERC0, 3 / Animation_Speed)
						LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.5, 0.5) * ANGLES(RAD(-40), RAD(0), RAD(15)) * LEFTSHOULDERC0, 3 / Animation_Speed)
						RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -1) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-20)), 3 / Animation_Speed)
						LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.3, -1) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 3 / Animation_Speed)
					end
				end
			end
			break
		end
	end
	ATTACK = false
	Rooted = false
end

function SwordMove()
	local HASSTARTED = false
	local target = nil
	local targettorso = nil
	if Mouse.Target.Parent ~= Character and Mouse.Target.Parent.Parent ~= Character and Mouse.Target.Parent:FindFirstChild("Humanoid") ~= nil then
		if Mouse.Target.Parent.Humanoid.PlatformStand == false then
			target = Mouse.Target.Parent.Humanoid
			targettorso = Mouse.Target.Parent:FindFirstChild("Torso") or Mouse.Target.Parent:FindFirstChild("UpperTorso")
		end
	end
	if target ~= nil then
		targettorso.Anchored = true
		HASSTARTED = true
		ATTACK = true
		Rooted = true
		RootPart.CFrame = targettorso.CFrame * CF(0,0,2)
		coroutine.resume(coroutine.create(function()
			Swait(10*100)
			if HASSTARTED == true then
				ATTACK = false
				Rooted = false
				UNANCHOR = true
			end
		end))
		UNANCHOR = false
		RootPart.Anchored = true
		coroutine.resume(coroutine.create(function()
			for i=0, 3, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-45)), 0.05 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(45)), 0.05 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.05 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.05 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.05 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, -0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.05 / Animation_Speed)
			end
			for i=0, 3, 0.1 / Animation_Speed do
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(85)), 0.5 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-85)), 0.5 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.25, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(85)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, -0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
			end
			Swait(5)
			targettorso:remove()
			Swait(15)
			ATTACK = false
			Rooted = false
			HASSTARTED = false
			UNANCHOR = true
		end))
	end
end

function R_RANDOM(CFRAME,DIST)
	return CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,0,-DIST)
end
--//=================================\\
--||	  ASSIGN THINGS TO KEYS
--\\=================================//

function MouseDown(Mouse)
	if ATTACK == false then
	end
end

function MouseUp(Mouse)
	HOLD = false
end

function KeyDown(Key)
	KEYHOLD = true
	if Key == "e" and ATTACK == false then
		ChangeSanity()
	end

	if Key == "l" and ATTACK == false and SELFDEFENSE == false then
		SELFDEFENSE = true
		chatfunc("Self Defense mode enabled")
	elseif Key == "l" and ATTACK == false and SELFDEFENSE == true then
		SELFDEFENSE = false
		chatfunc("Self Defense mode disabled")
	end

	if Key == "m" and ATTACK == false then
		BreakSanity()
	end
	if Key == "k" and ATTACK == false then
		BreakSanityTEST()
	end
	if Key == "p" and ATTACK == false then
		chatfunc("Maybe i can forgive you")
		TOBANISH = {}
	end
	if Key == "q" and ATTACK == false then
		ChangeSanityMadness()
	end

	if Key == "n" and ATTACK == false then
		if MODE == "SR" then
			if Speed == 12 then
				Speed = 50
			elseif Speed == 50 then
				Speed = 12
			end
		end
	end

	if Key == "z" and ATTACK == false then
		if MODE == "CRES" then
			CORRUPTEDBURNINGBULLETS()
		elseif MODE == "RR" then
			BIGSMASH()
		elseif MODE == "GC" then
			Smite()		
		elseif MODE == "SR" then
			VisualiserStomp()
		elseif MODE == "CRESCENDO" then
			SwordMove()	
		end
	end

	if Key == "c" and ATTACK == false then
		if MODE == "CRES" then
			CORRUPTEDLETHALBULLETS()
		elseif MODE == "RR" then
			Complete_Control()
		elseif MODE == "GC" then
			CorruptedBurningBeam()	
		end
	end

	if Key == "g" and ATTACK == false then
		if MODE == "CRES" then
			Warp()
		elseif MODE == "RR" then
			Execute()
		elseif MODE == "GC" then
			PlanetaryDevastation()	
		end
	end

	if Key == "v" and ATTACK == false then
		if MODE == "CRES" then
			Corrupted_Burn()
		elseif MODE == "RR" then
			Fireball()
		elseif MODE == "GC" then
			calamity()	
		elseif MODE == "SR" then
			SPEEDYDASH()
		end
	end

	if Key == "t" and ATTACK == false then
		TrustIssues()
	end
end

function KeyUp(Key)
	KEYHOLD = false
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

--//=================================\\
--\\=================================//

function unanchor()
	for _, c in pairs(Character:GetChildren()) do
		if c:IsA("BasePart") and c ~= RootPart then
			c.Anchored = false
		end
	end
	if UNANCHOR == true then
		RootPart.Anchored = false
	else
		RootPart.Anchored = true
	end
end

--//=================================\\
--||	WRAP THE WHOLE SCRIPT UP
--\\=================================//

Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and (Disable_Jump == true) then
		Humanoid.Jump = false
	end
end)
Player_Size = 1 --Size of the player.
local FF = IT("ForceField",Character)
FF.Visible = false
plr.Chatted:connect(function(message)
	if message:sub(1,5) == "play/" then
		SONG = message:sub(6)
	end
end)
while true do
	Swait()
	script.Parent = WEAPONGUI
	ANIMATE.Parent = nil
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
		v:Stop();
	end
	sine = sine + change
	SINE = SINE + CHANGE
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR,HITPOS = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
	local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)
	if ANIM == "Walk" and TORSOVELOCITY > 1 then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0.1 * COS(SINE / (WALKSPEEDVALUE/2))) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0) - Head.RotVelocity.Y / 30), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 0.875 - 0.125 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE*2), 0.25 * SIN(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10+50 * COS(SINE / WALKSPEEDVALUE))), 0.6 / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 0.875 + 0.125 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE*2), -0.25 * SIN(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-10+50 * COS(SINE / WALKSPEEDVALUE))), 0.6 / Animation_Speed)
	elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.7 / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.7 / Animation_Speed)
	end
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(25 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(-25 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.4, -0.6) * ANGLES(RAD(1), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-35 - 4 * COS(SINE / 6)), RAD(0), RAD(45 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-35 - 4 * COS(SINE / 6)), RAD(0), RAD(-45 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -0.7) * ANGLES(RAD(-25 + 5 * SIN(SINE / 12)), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.8, -0.3) * ANGLES(RAD(-10), RAD(-80), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		ANIM = "Idle"
		if ATTACK == false then
			if MODE == "CRES" then
				--RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.03 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(-35)), 1 / Animation_Speed)
				if MRANDOM(1,56) == 1 then
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 + MRANDOM(-25,25) - 4 * COS(SINE / 12)), RAD(MRANDOM(-25,25)), RAD(0)), 1.5 / Animation_Speed)
				end
				--           Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(35)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(0.75, 0.5 + 0.05 * SIN(SINE / 24), -0.7) * ANGLES(RAD(0), RAD(0), RAD(-95)) * ANGLES(RAD(5), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-0.75, 0.35 + 0.05 * SIN(SINE / 24), -0.6) * ANGLES(RAD(0), RAD(0), RAD(92)) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
--[[			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(95), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-55), RAD(0)) * ANGLES(RAD(-12), RAD(0), RAD(0)), 1 / Animation_Speed)]]--
				RH.C0=Clerp(RH.C0,cf(1,-1 - 0.05 * math.cos(SINE / 32),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0 - 1 * math.cos(SINE / 56)),math.rad(1 - 2 * math.cos(SINE / 32))),.1)
				LH.C0=Clerp(LH.C0,cf(-1,-1 - 0.05 * math.cos(SINE / 32),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0 - 1 * math.cos(SINE / 56)),math.rad(-1 + 2 * math.cos(SINE / 32))),.1)
				RootJoint.C0=Clerp(RootJoint.C0,RootCF*cf(0,0.02 + 0.02 * math.cos(SINE / 30),0 + 0.05 * math.cos(SINE / 30))*angles(math.rad(2 - 2 * math.cos(SINE / 30)),math.rad(0),math.rad(0 - 1 * math.cos(SINE / 42))),.1)
				Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*angles(math.rad(22 - 3 * math.cos(SINE / 37)),math.rad(0 + 1 * math.cos(SINE / 58)),math.rad(0 + 2 * math.cos(SINE / 53))),.1)
			elseif MODE == "GC" then
				RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.03 + 0.05 * COS(SINE / 11)) * ANGLES(RAD(0), RAD(0), RAD(-35)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
--[[			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(0.75, 0.5 + 0.05 * SIN(SINE / 12), -0.7) * ANGLES(RAD(0), RAD(0), RAD(-95)) * ANGLES(RAD(5), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-0.75, 0.35 + 0.05 * SIN(SINE / 12), -0.6) * ANGLES(RAD(0), RAD(0), RAD(92)) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)]]--
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0, -0.5) * ANGLES(RAD(140 + 2.5 * SIN(SINE / 12)), RAD(15), RAD(0)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0, -0.5) * ANGLES(RAD(140 + 2.5 * SIN(SINE / 12)), RAD(-15), RAD(0)) * LEFTSHOULDERC0, 2 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(95), RAD(0)) * ANGLES(RAD(-15), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(-55), RAD(0)) * ANGLES(RAD(-12), RAD(0), RAD(0)), 1 / Animation_Speed)
			elseif MODE == "RR" then
--[[			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)]]--
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.1, 0.5, -0.45) * ANGLES(RAD(110), RAD(0), RAD(-80)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.1, 0.15, -0.45) * ANGLES(RAD(80), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
--[[			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)]]--
				RH.C0=clerp(RH.C0,cf(1,-1 - 0.05 * math.cos(sine / 28),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-2.5),math.rad(-5),math.rad(0 - 3 * math.cos(sine / 34))),.1)
				LH.C0=clerp(LH.C0,cf(-1,-1 - 0.05 * math.cos(sine / 28),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-1.5),math.rad(0),math.rad(10 + 3 * math.cos(sine / 34))),.1)
				RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0 + 0.03 * math.cos(sine / 48),0 + 0.05 * math.cos(sine / 48))*angles(math.rad(0 - 3 * math.cos(sine / 34)),math.rad(0),math.rad(34)),.1)
				Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(10 - 2.5 * math.cos(sine / 28)),math.rad(0 + 2 * math.cos(sine / 57)),math.rad(-25)),.1)
			elseif MODE == "SR" then
 --[[               rootj.C0 = Clerp(rootj.C0, RootCF * CF(0* Player_Size, 0* Player_Size, -0.1 + 0.1* Player_Size * Cos(SINE / 15)) * angles(Rad(0), Rad(0), Rad(0)), 0.08)
                tors.Neck.C0 = Clerp(tors.Neck.C0, NECKC0 * angles(Rad(20 - 4.5 * Sin(SINE / 25)), Rad(0), Rad(-10)), 0.3)
                RH.C0 = Clerp(RH.C0, CF(1* Player_Size, -0.9 - 0.1 * Cos(SINE / 12)* Player_Size, 0* Player_Size) * angles(Rad(0), Rad(80), Rad(0)) * angles(Rad(-6.5), Rad(0), Rad(0)), 0.08)
                LH.C0 = Clerp(LH.C0, CF(-1* Player_Size, -0.9 - 0.1 * Cos(SINE / 12)* Player_Size, 0* Player_Size) * angles(Rad(0), Rad(-80), Rad(0)) * angles(Rad(-6.5), Rad(0), Rad(0)), 0.08)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(0.75, 0.5 + 0.05 * SIN(SINE / 12), -0.7) * ANGLES(RAD(0), RAD(0), RAD(-95)) * ANGLES(RAD(5), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)]]--
				RootJoint.C0 = clerp(RootJoint.C0,RootCF*cf(0,0,0)* angles(math.rad(0),math.rad(0),math.rad(40)),0.3)
				Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(5 - 2.5 * math.cos(sine / 28)),math.rad(0 - 2 * math.cos(sine / 47)),math.rad(-10 + 2 * math.cos(sine / 43))),.1)
				RW.C0 = clerp(RW.C0, CFrame.new(1.5, 0.5, 0) * angles(math.rad(170), math.rad(0), math.rad(10)), 0.3)
				RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-1.5),math.rad(-20),math.rad(0)),.3)
				LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-1),math.rad(0),math.rad(0)),.3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-0.75, 0.35 + 0.05 * SIN(SINE / 28), -0.6) * ANGLES(RAD(0), RAD(0), RAD(92)) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			elseif MODE == "CRESCENDO" then
				if MRANDOM(1,12) == 1 then
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 + MRANDOM(-25,25) - 4 * COS(SINE / 12)), RAD(MRANDOM(-25,25)), RAD(0)), 1.5 / Animation_Speed)
				end
				RH.C0=clerp(RH.C0,cf(1,-1 + 0.05 * math.cos(sine / 20)  - 0.02 * math.cos(sine / 40),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3 + 2 * math.cos(sine / 40)),math.rad(0 - 6 * math.cos(sine / 40)),math.rad(-6 + 2 * math.cos(sine / 20) - 6 * math.cos(sine / 40))),.1)
				LH.C0=clerp(LH.C0,cf(-1,-1 + 0.05 * math.cos(sine / 20) - 0.02 * math.cos(sine / 40),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3 - 2 * math.cos(sine / 40)),math.rad(10 - 6 * math.cos(sine / 40)),math.rad(3 - 2 * math.cos(sine / 20) - 3 * math.cos(sine / 40))),.1)
				RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0 + 0.02 * math.cos(sine / 40),0 - 0.06 * math.cos(sine / 40),-0.05 - 0.05 * math.cos(sine / 20))*angles(math.rad(0 + 2 * math.cos(sine / 20)),math.rad(0 + 2 * math.cos(sine / 40)),math.rad(-20 + 6 * math.cos(sine / 40))),.1)
				Torso.Neck.C0=clerp(Torso.Neck.C0,NECKC0*angles(math.rad(6),math.rad(0 - 2 * math.cos(sine / 42)),math.rad(20 - 6 * math.cos(sine / 40))),.1)
				RW.C0=clerp(RW.C0,cf(1.5,0.5 + 0.05 * math.cos(sine / 28),0)*angles(math.rad(-2 - 4 * math.cos(sine / 28)),math.rad(-20),math.rad(18 + 8 * math.cos(sine / 28))),.1)
				LW.C0=clerp(LW.C0,cf(-1.5,0.5 + 0.1 * math.cos(sine / 28),0)*angles(math.rad(170 + 3 * math.cos(sine / 46)),math.rad(10 + 5 * math.cos(sine / 52)),math.rad(-10 - 2 * math.cos(sine / 28))),.1)
			end
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.05) * ANGLES(RAD(5), RAD(0), RAD(-15-7 * COS(SINE / (WALKSPEEDVALUE)))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 1 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(15+7 * COS(SINE / (WALKSPEEDVALUE)))), 1 / Animation_Speed)
			if CrossedArms == true then
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(0.75, 0.5 + 0.05 * SIN(SINE / 12), -0.7) * ANGLES(RAD(0), RAD(0), RAD(-95)) * ANGLES(RAD(5), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-0.75, 0.35 + 0.05 * SIN(SINE / 12), -0.6) * ANGLES(RAD(0), RAD(0), RAD(92)) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			elseif CrossedArms == false then
				RW.C0 = clerp(RW.C0, CF(1.5* Player_Size, 0.5 + 0.05 * Sin(sine / 7)* Player_Size, 0* Player_Size) * angles(Rad(37)  * Cos(sine / 7) , Rad(8 * Cos(sine / 7)), Rad(6) - ra.RotVelocity.Y / 75), 0.1)
				LW.C0 = clerp(LW.C0, CF(-1.5* Player_Size, 0.5 + 0.05 * Sin(sine / 7)* Player_Size, 0* Player_Size) * angles(Rad(-37) * Cos(sine / 7) , Rad(8 * Cos(sine / 7)) ,	Rad(-6) + la.RotVelocity.Y / 75), 0.1)
			end
			RightHip.C0 = Clerp(RightHip.C0, CF(1 , -1, 0) * ANGLES(RAD(0), RAD(105), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
		end
	end
	unanchor()
	if MODE == "CRESCENDO" then
		WACKYEFFECT({Time = 5, EffectType = "Sphere", Size = VT(3,3,3), Size2 = VT(0,0,0), Transparency = 1, Transparency2 = 0.25, CFrame = LeftArm.CFrame*CF(0,-1.45,0), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = 0.6, SoundVolume = 6})
	end
	if MRANDOM(1,65) == 1 then
		CharacterFadeB(C3(0,0,0),65,R_RANDOM(Torso.CFrame,0.5).p)
	end
	Humanoid.MaxHealth = 1e+1000000
	Humanoid.Health = 1e+1000000
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	if SELFDEFENSE == true then
		ApplyAoE4(Torso.Position, 8, 0, 0, 0, true)
	end
	sick.SoundId = "rbxassetid://"..SONG
	sick.Looped = true
	sick.Pitch = 1
	sick.Volume = 2
	sick.Parent = Effects
	sick.Playing = PLAYSONG
end
Humanoid.Name = "CRESEE"

--//=================================\\
--\\=================================//





--//====================================================\\--
--||			  		 END OF SCRIPT
--\\====================================================//--
