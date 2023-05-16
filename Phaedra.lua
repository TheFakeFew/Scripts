local loaded = LoadAssets(13233384945)
local assets = loaded:Get("PhaedraAssets")
for i,v in next, assets:GetChildren() do
	v.Parent = script
end
 -- zzz
getfenv().wait = task.wait
getfenv().delay = task.delay
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

NLS([[
while true do
	task.wait()
	workspace.CurrentCamera.CameraSubject = workspace:WaitForChild("Holy Shields")
end
]], script)

Mouse=Player:GetMouse()
moue=Mouse
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = Player.Character
Character.Archivable = true
Humanoid = Character.Humanoid
ShieldValue = false
RootPart = Character.HumanoidRootPart
Torso = Character.Torso
Head = Character.Head
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart.RootJoint
Neck = Torso.Neck
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
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
Animation_Speed = 3
Frame_Speed = 0.016666666666666666
local Speed = 45
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
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "Weapon GUI"
local Effects = IT("Folder", Character)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
local UNANCHOR = true
local DISPLAYANIMATIONS = true
ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"
script:WaitForChild("ArtificialHB")
frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()
local MeshT = Head.Mesh
Head.face:Destroy()
MeshT.MeshId = "rbxassetid://21057410"
MeshT.TextureId = "rbxassetid://1393532942"
MeshT.Name = "Dominus"
print(MeshT.Name)
MeshT.Scale = Vector3.new(1,1,1)
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
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id=" .. MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id=" .. TEXTUREID
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
local weldBetween = function(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end
Humanoid.PlatformStand = false	
function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m00 < m11 then
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
			local recip = 0.5 / s
			return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
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
	local startInterp, finishInterp
	if cosTheta >= 1.0E-4 then
		if 1 - cosTheta > 1.0E-4 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	elseif 1 + cosTheta > 1.0E-4 then
		local theta = ACOS(-cosTheta)
		local invSinTheta = 1 / SIN(theta)
		startInterp = SIN((t - 1) * theta) * invSinTheta
		finishInterp = SIN(t * theta) * invSinTheta
	else
		startInterp = t - 1
		finishInterp = t
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end
function Clerp(a, b, t)
	local qa = {
		QuaternionFromCFrame(a)
	}
	local qb = {
		QuaternionFromCFrame(b)
	}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
local BLASTS = {468991944, 468991990}
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
local M = CreateMesh("SpecialMesh", c, "FileMesh", "21057410", "1393532942", VT(1, 1, 1) * 1.1, VT(0, 0, 0))
M.Name = "Dominus"
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
	local NEWSOUND
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "rbxassetid://" .. ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat
				wait(1)
			until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end
function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end
function GetRoot(MODEL, ROOT)
	if ROOT == true then
		return MODEL:FindFirstChild("HumanoidRootPart") or MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	else
		return MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	end
end
function WACKYEFFECT(Table)
	local TYPE = Table.EffectType or "Sphere"
	local SIZE = Table.Size or VT(1, 1, 1)
	local ENDSIZE = Table.Size2 or VT(0.05, 0.05, 0.05)
	local TRANSPARENCY = Table.Transparency or 0
	local ENDTRANSPARENCY = Table.Transparency2 or 1
	local CFRAME = Table.CFrame or Torso.CFrame
	local MOVEDIRECTION = Table.MoveToPos or nil
	local ROTATION1 = Table.RotationX or 0
	local ROTATION2 = Table.RotationY or 0
	local ROTATION3 = Table.RotationZ or 0
	local MATERIAL = Table.Material or "Neon"
	local COLOR = Table.Color or C3(0, 0, 0)
	local TIME = Table.Time or 45
	local SOUNDID = Table.SoundID or nil
	local SOUNDPITCH = Table.SoundPitch or nil
	local SOUNDVOLUME = Table.SoundVolume or nil
	local USEBOOMERANGMATH = Table.UseBoomerangMath or false
	local BOOMERANG = Table.Boomerang or 0
	local SIZEBOOMERANG = Table.SizeBoomerang or 0
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1, 1, 1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh", EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0, 0, -SIZE.X / 8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X, SIZE.X, 0.1), VT(0, 0, 0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0, 0, 0))
		end
		if MSH ~= nil then
			local BOOMR1 = 1 + BOOMERANG / 50
			local BOOMR2 = 1 + SIZEBOOMERANG / 50
			local MOVESPEED
			if MOVEDIRECTION ~= nil then
				if USEBOOMERANGMATH == true then
					MOVESPEED = CFRAME.p - MOVEDIRECTION.Magnitude / TIME * BOOMR1
				else
					MOVESPEED = CFRAME.p - MOVEDIRECTION.Magnitude / TIME
				end
			end
			local GROWTH
			if USEBOOMERANGMATH == true then
				GROWTH = (SIZE - ENDSIZE) * (BOOMR2 + 1)
			else
				GROWTH = SIZE - ENDSIZE
			end
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
			else
				EFFECT.CFrame = CFRAME
			end
			if USEBOOMERANGMATH == true then
				for LOOP = 1, TIME + 1 do
					Swait()
					MSH.Scale = MSH.Scale - VT(GROWTH.X * (1 - LOOP / TIME * BOOMR2), GROWTH.Y * (1 - LOOP / TIME * BOOMR2), GROWTH.Z * (1 - LOOP / TIME * BOOMR2)) * BOOMR2 / TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0, 0, -MSH.Scale.Z / 8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
					else
						EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position, MOVEDIRECTION) * CF(0, 0, -MOVESPEED * (1 - LOOP / TIME * BOOMR1))
						EFFECT.CFrame = CF(EFFECT.Position) * ANGLES(RAD(ORI.X), RAD(ORI.Y), RAD(ORI.Z))
					end
				end
			else
				for LOOP = 1, TIME + 1 do
					Swait()
					MSH.Scale = MSH.Scale - GROWTH / TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0, 0, -MSH.Scale.Z / 8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
					else
						EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position, MOVEDIRECTION) * CF(0, 0, -MOVESPEED)
						EFFECT.CFrame = CF(EFFECT.Position) * ANGLES(RAD(ORI.X), RAD(ORI.Y), RAD(ORI.Z))
					end
				end
			end
			EFFECT.Transparency = 1
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat
					Swait()
				until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		elseif PLAYSSOUND == false then
			EFFECT:remove()
		else
			repeat
				Swait()
			until EFFECT:FindFirstChildOfClass("Sound") == nil
			EFFECT:remove()
		end
	end))
end
--------------------------------------------------------------------Foren Code
c = Character

RSC0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
RSC1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
LSC0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
LSC1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
RHC0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
RHC1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
LHC0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
LHC1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
NC0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
NC1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
RJC0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
RJC1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
RS = c.Torso:FindFirstChild("Right Shoulder")
LS = c.Torso:FindFirstChild("Left Shoulder")
RH = c.Torso:FindFirstChild("Right Hip")
LH = c.Torso:FindFirstChild("Left Hip")
RJ = c.HumanoidRootPart:FindFirstChild("RootJoint")
N = c.Torso:FindFirstChild("Neck")
cf = CFrame.new
ang = CFrame.Angles
rd = math.rad
rd2 = math.random

function makejoint(paren, co, ci, parto, parti, nam)local gloo = Instance.new("Motor6D")gloo.Name = nam gloo.C0 = co gloo.C1 = ci gloo.Part0 = parto gloo.Part1 = parti gloo.Parent = paren end

local LastPos = c.HumanoidRootPart.CFrame
local Resetting = false
function Reset()
	if Resetting == false then Resetting = true
		c.Parent = nil 
		c.Humanoid.Health = math.huge c.Humanoid.MaxHealth = math.huge
		for i,v in pairs(c:children()) do if v.ClassName == "Part" then v:remove() end end
		local Tors = Instance.new("Part",c)Tors.Name = "Torso" Tors.Size = Vector3.new(2,2,1)
		local Hed = Instance.new("Part",c)Hed.Name = "Head" Hed.Size = Vector3.new(2,1,1) 
		makejoint(c.Torso, NC0, NC1, c.Torso, c.Head, "Neck")
		local Hum = Instance.new("Part",c)Hum.Name = "HumanoidRootPart" Hum.Size = Vector3.new(2,2,1) Hum.Transparency = 1
		makejoint(c.HumanoidRootPart, RJC0, RJC1, c.HumanoidRootPart, c.Torso, "RootJoint")
		local P = Instance.new("Part",c)P.Size = Vector3.new(1,1,1)P.Anchored = false P.CanCollide = false P.Name = "HeadPart"
		local W = Instance.new("Weld",P)W.Part0 = P W.Part1 = c.Head
		local HM = Instance.new("SpecialMesh",P)HM.MeshId = "rbxassetid://539723444" HM.TextureId = "rbxassetid://64619306" HM.Scale = Vector3.new(0.97,0.97,0.97)
		local RiArm = Instance.new("Part",c)RiArm.Name = "Right Arm" RiArm.Size = Vector3.new(1,2,1)
		makejoint(c.Torso, RSC0, RSC1, c.Torso, RiArm, "Right Shoulder")
		local LeArm = Instance.new("Part",c)LeArm.Name = "Left Arm" LeArm.Size = Vector3.new(1,2,1)
		makejoint(c.Torso, LSC0, LSC1, c.Torso, LeArm, "Left Shoulder")
		local RiLeg = Instance.new("Part",c)RiLeg.Name = "Right Leg" RiLeg.Size = Vector3.new(1,2,1) 
		makejoint(c.Torso, RHC0, RHC1, c.Torso, RiLeg, "Right Hip")
		local LeLeg = Instance.new("Part",c)LeLeg.Name = "Left Leg" LeLeg.Size = Vector3.new(1,2,1) 
		makejoint(c.Torso, LHC0, LHC1, c.Torso, LeLeg, "Left Hip")
		c.HumanoidRootPart.CFrame = LastPos*CFrame.new(math.random(-5,5),0,math.random(-5,5))
		Resetting = false c.Humanoid.Died:connect(Reset) c.Parent = workspace
	end
end
-------------------------------------------------------------------------------------------------------------------------------------
function MakeForm(PART, TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh", PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Wedge"
	end
end
function SHAKECAM(POSITION, RANGE, INTENSITY, TIME)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					VT = Vector3.new
					MRANDOM = math.random
					local HUMANOID = CHILD:FindFirstChildOfClass("Humanoid")
					local TIMER = TIME
					local SHAKE = INTENSITY
					local FADE = true
					if HUMANOID and game:GetService("Players"):FindFirstChild(Player.Name) then
						local FADER = SHAKE / TIMER
						for i = 1, TIMER do
							wait()
							HUMANOID.CameraOffset = VT(MRANDOM(-(SHAKE - FADER * i), SHAKE - FADER * i) / 10, MRANDOM(-(SHAKE - FADER * i), SHAKE - FADER * i) / 10, MRANDOM(-(SHAKE - FADER * i), SHAKE - FADER * i) / 10)
						end
						HUMANOID.CameraOffset = VT(0, 0, 0)
					end
				end
			end
		end
	end
end
function WACKYEFFECT1(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or VT(1,1,1))
	local ENDSIZE = (Table.Size2 or VT(0.05,0.05,0.05))
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
		local EFFECT = CreatePart(3, Character:FindFirstChild("Effects"), MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1,1,1), true)
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
		elseif TYPE == "Cylinder" then
			MSH = IT("CylinderMesh",EFFECT)
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
		elseif TYPE == "Crown" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "173770780", "", SIZE, VT(0,0,0))
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
			EFFECT.Transparency = 1
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until SOUND.Playing == false
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until SOUND.Playing == false
				EFFECT:remove()
			end
		end
	end))
end

Debris = game:GetService("Debris")
function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos, EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end
local DECAL = IT("Decal")
function MagicRing()
	local RING = CreatePart(3, Effects, "Granite", 0, 1, "Maroon", "MagicRing", VT(0.05, 0.05, 0.05), true)
	local MESH = IT("BlockMesh", RING)
	local BOTTOMTEXTURE = DECAL:Clone()
	BOTTOMTEXTURE.Parent = RING
	BOTTOMTEXTURE.Face = "Bottom"
	BOTTOMTEXTURE.Name = "BottomTexture"
	local TOPTEXTURE = DECAL:Clone()
	TOPTEXTURE.Parent = RING
	TOPTEXTURE.Face = "Top"
	TOPTEXTURE.Name = "TopTexture"
	BOTTOMTEXTURE.Texture = "http://www.roblox.com/asset/?id=1208118228"
	TOPTEXTURE.Texture = "http://www.roblox.com/asset/?id=1208118228"
	BOTTOMTEXTURE.Color3 = BRICKC("Gold").Color
	TOPTEXTURE.Color3 = BRICKC("Gold").Color
	return RING, MESH
end
function R_RANDOM(CFRAME, DIST)
	return CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 0, -DIST)
end
local SKILLTEXTCOLOR = BRICKC("Gold").Color
local SKILLFONT = "Bodoni"
local SKILLTEXTSIZE = 7
local ATTACKS = {
	"Divinum Lumen - Z",
	"Quod sit lux in atmosphaera - C",
	"Divina CREPITUS - V",
	"Manu Dei - F",
	"Ianuae Magicae - Q",
	"Dominus Carcerem - B",
	"Dominus Carcerem Acem - N",
	"Ultima Consummatio - X"
}
for i = 1, #ATTACKS do
	local SKILLFRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.74, 0, 0.97 - 0.04 * i, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Skill Frame")
	local SKILLTEXT = CreateLabel(SKILLFRAME, "[" .. ATTACKS[i] .. "]", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0, "Skill text")
	SKILLTEXT.TextXAlignment = "Right"
	SKILLTEXT.TextStrokeColor3 = C3(0, 0, 0)
end
local BMUSIC = IT("Sound", Character)
local VOLUME = 5
local PITCH = 1
local SONGID = 1418800825
local EYE = CreatePart(3, Head, "Neon", 0, 0, "Gold", "Eyeball", VT(0.1, 0.4, 0.1), false)
MakeForm(EYE, "Ball")
EYE.CFrame = Head.CFrame * CF(0.2, 0.1, -0.72)
local EW = weldBetween(Head, EYE)
local EYE2 = CreatePart(3, Head, "Neon", 0, 0, "Gold", "Eyeball1", VT(0.4, 0.1, 0.1), false)
MakeForm(EYE2, "Ball")
EYE2.CFrame = Head.CFrame * CF(0.2, 0.1, -0.72)
local EW2 = weldBetween(Head, EYE2)
local NAMEGUI = IT("BillboardGui", Character)
NAMEGUI.AlwaysOnTop = true
NAMEGUI.Size = UD2(8, 35, 3, 15)
NAMEGUI.StudsOffset = VT(0, 2, 0)
NAMEGUI.Adornee = Head
NAMEGUI.Name = "Name"
--NAMEGUI.PlayerToHideFrom = Player
local NAME = IT("TextLabel", NAMEGUI)
NAME.Name = "NAMEGUI"
NAME.BackgroundTransparency = 1
NAME.TextScaled = true
NAME.BorderSizePixel = 0
NAME.Text = "DOMINUS PHAEDRA"
NAME.Font = "Bodoni"
NAME.TextSize = 30
NAME.TextStrokeTransparency = 0.5
NAME.TextColor3 = SKILLTEXTCOLOR
NAME.TextStrokeColor3 = C3(1, 1, 1)
NAME.Size = UD2(1, 0, 0.5, 0)
function AttackGyro()
	local GYRO = IT("BodyGyro", RootPart)
	GYRO.D = 25
	GYRO.P = 20000
	GYRO.MaxTorque = VT(0, 4000000, 0)
	GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
		until ATTACK == false
		GYRO:Remove()
	end))
end
function CamShake(SHAKE, TIMER)
	coroutine.resume(coroutine.create(function()
		local FADER = SHAKE / TIMER
		for i = 1, TIMER do
			wait()
			Humanoid.CameraOffset = VT(MRANDOM(-(SHAKE - FADER * i), SHAKE - FADER * i) / 10, MRANDOM(-(SHAKE - FADER * i), SHAKE - FADER * i) / 10, MRANDOM(-(SHAKE - FADER * i), SHAKE - FADER * i) / 10)
		end
		Humanoid.CameraOffset = VT(0, 0, 0)
	end))
end
function Chatter(Text, Timer, Delay, ChatterSound)
	local chat = coroutine.wrap(function()
		if Character:FindFirstChild("SpeechBoard") ~= nil then
			Character:FindFirstChild("SpeechBoard"):destroy()
		end
		NAME.Visible = false
		local naeeym2 = IT("BillboardGui", Character)
		naeeym2.Size = UD2(80, 35, 3, 15)
		naeeym2.StudsOffset = VT(0, 2, 0)
		naeeym2.Adornee = Head
		naeeym2.Name = "SpeechBoard"
		naeeym2.AlwaysOnTop = true
		local tecks2 = IT("TextLabel", naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = "Bodoni"
		tecks2.TextSize = 25
		tecks2.TextStrokeTransparency = 0.8
		tecks2.TextColor3 = BRICKC("Gold").Color
		tecks2.TextStrokeColor3 = C3(0, 0, 0)
		tecks2.Size = UDim2.new(1, 0, 0.5, 0)
		local FINISHED = false
		coroutine.resume(coroutine.create(function()
			for i = 1, string.len(Text) do
				if naeeym2.Parent ~= Character then
					FINISHED = true
				end
				if ChatterSound ~= false and naeeym2.Parent == Character then
					CreateSound(418252437, Head, 7, MRANDOM(8, 12) / 15, false)
				end
				tecks2.Text = string.sub(Text, 1, i)
				Swait(Timer)
			end
			FINISHED = true
		end))
		repeat
			wait()
		until FINISHED == true
		wait(Delay)
		naeeym2.Name = "FadingDialogue"
		if Character:FindFirstChild("SpeechBoard") == nil and NAME.Name == "NAMEGUI" then
			coroutine.resume(coroutine.create(function()
				NAME.Name = "FadingNameGUI"
				NAME.Visible = true
				NAME.TextStrokeTransparency = 1
				NAME.TextTransparency = 1
				for i = 1, 35 do
					Swait()
					NAME.TextStrokeTransparency = NAME.TextStrokeTransparency - 0.014285714285714285
					NAME.TextTransparency = NAME.TextTransparency - 0.02857142857142857
				end
				NAME.Name = "NAMEGUI"
			end))
		end
		for i = 1, 45 do
			Swait()
			naeeym2.StudsOffset = naeeym2.StudsOffset + VT(0, (2 - 0.044444444444444446 * i) / 45, 0)
			tecks2.TextTransparency = tecks2.TextTransparency + 0.022222222222222223
			tecks2.TextStrokeTransparency = tecks2.TextTransparency
		end
		naeeym2:Destroy()
	end)
	chat()
end
LeftArm.BrickColor = BrickColor.new("Gold")
RightArm.BrickColor = BrickColor.new("Gold")
LeftLeg.BrickColor = BrickColor.new("Cork")
RightLeg.BrickColor = BrickColor.new("Cork")
Torso.BrickColor = BrickColor.new("Institutional white")
local WING1SLOT = IT("Attachment", Head)
local WING2SLOT = IT("Attachment", Head)
WING1SLOT.Position = VT(-0.75, -0.4, 0.5)
WING2SLOT.Position = VT(0.75, -0.4, 0.5)
WING1SLOT.Orientation = VT(58.6, -16.325, 16.325)
WING2SLOT.Orientation = VT(58.6, 16.325, -16.325)
local WING1 = script.Wing:Clone()
local WING2 = script.Wing:Clone()
WING1.Parent = WING1SLOT
WING2.Parent = WING2SLOT
local WING3SLOT = IT("Attachment", Head)
local WING4SLOT = IT("Attachment", Head)
WING3SLOT.Position = VT(-0.75, -0.4, 0.5)
WING4SLOT.Position = VT(0.75, -0.4, 0.5)
WING3SLOT.Orientation = VT(44.032, -22.133, 15.753)
WING4SLOT.Orientation = VT(44.032, 22.133, -15.753)
local WING3 = script.Wing:Clone()
local WING4 = script.Wing:Clone()
WING3.Parent = WING3SLOT
WING4.Parent = WING4SLOT
local WING5SLOT = IT("Attachment", Head)
local WING6SLOT = IT("Attachment", Head)
WING5SLOT.Position = VT(-0.75, -0.4, 0.5)
WING6SLOT.Position = VT(0.75, -0.4, 0.5)
WING5SLOT.Orientation = VT(72.531, -2.301, 29.198)
WING6SLOT.Orientation = VT(72.531, 2.3, -29.199)
local WING5 = script.Wing:Clone()
local WING6 = script.Wing:Clone()
WING5.Parent = WING5SLOT
WING6.Parent = WING6SLOT
local HALO, HALOMESH = MagicRing()
HALO.Parent = Character
HALO.Anchored = false
HALO.CFrame = Head.CFrame * CF(0, 1.2, 0)
HALOMESH.Scale = VT(75, 0, 75)
weldBetween(Head, HALO)
for _, v in next, Humanoid:GetPlayingAnimationTracks() do
	v:Stop()
end
for _, c in pairs(Character:GetChildren()) do
	if c and c.Parent and c.ClassName == "Accessory" then
		c:Destroy()
	end
end
local BODY = {}
for _, c in pairs(Character:GetDescendants()) do
	if c:IsA("BasePart") and c.Name ~= "Handle" then
		if c ~= RootPart and c ~= Torso and c ~= Head and c ~= RightArm and c ~= LeftArm and c ~= RightLeg and c ~= LeftLeg then
			c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
		table.insert(BODY, {
			c,
			c.Parent,
			c.Material,
			c.Color,
			c.Transparency,
			c.Size,
			c.Name
		})
	elseif c:IsA("JointInstance") then
		table.insert(BODY, {
			c,
			c.Parent,
			nil,
			nil,
			nil,
			nil,
			nil
		})
	end
end
function refit()
	Character.Parent = workspace
	Effects.Parent = Character
	for e = 1, #BODY do
		if BODY[e] ~= nil then
			local STUFF = BODY[e]
			local PART = STUFF[1]
			local PARENT = Character:FindFirstChild("Safety") or STUFF[2]
			local MATERIAL = "Neon"
			local COLOR = STUFF[4]
			local TRANSPARENCY = STUFF[5]
			local NAME = STUFF[7]
			if PART.ClassName == "Part" and PART ~= RootPart then
				PART.Material = MATERIAL
				PART.Transparency = TRANSPARENCY
				PART.Name = NAME
			end
			if PART.Parent ~= PARENT then
				if PART.Name == "Head" or PART.Name == "Neck" or PART.Name == "Torso" then
					Humanoid:remove()
				end
				PART.Parent = PARENT
				if PART.Name == "Head" or PART.Name == "Neck" or PART.Name == "Torso" then
				end
			end
		end
	end
end
Humanoid.Died:connect(function()
	refit()
end)
local LEVEL = 1
local SKILLFRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.5, 0, 0.94, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Name Frame")
local LEVELTEXT = CreateLabel(SKILLFRAME, "[ " .. LEVEL .. " ]", SKILLTEXTCOLOR, 7, "Fantasy", 0, 2, 0, "Name text")
SKILLFRAME.Rotation = 5
LEVELTEXT.TextStrokeColor3 = C3(0, 0, 0)
function Eliminate(MODEL)
	MODEL:BreakJoints()
	coroutine.resume(coroutine.create(function()
		if MODEL:FindFirstChild("Terminus_Eliminate") == nil then
			do
				local F = IT("Folder", MODEL)
				F.Name = "Terminus_Eliminate"
				local PARENT = MODEL.Parent
				for index, CHILD in pairs(MODEL:GetChildren()) do
					if CHILD:IsA("BasePart") and CHILD:FindFirstChild("Terminus_Eliminate") == nil and CHILD.Name ~= "HumanoidRootPart" then
						coroutine.resume(coroutine.create(function()
							CHILD.Transparency = CHILD.Transparency + 0.04
							local PARTICLES = script.OVERLORDAURA:Clone()
							PARTICLES.Parent = CHILD
							PARTICLES.Enabled = true
							PARTICLES.Speed = NumberRange.new(0.2, 0.4)
							PARTICLES.Name = "Terminus_Eliminate"
							local FLIGHTFORCE = IT("BodyPosition", CHILD)
							FLIGHTFORCE.D = 215
							FLIGHTFORCE.P = 200
							FLIGHTFORCE.maxForce = VT(40000, 40000, 40000)
							FLIGHTFORCE.position = CHILD.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 0, MRANDOM(2, 7)).p
							wait(MRANDOM(50, 150) / 100)
							for i = 1, 24 do
								Swait()
								CHILD.Transparency = CHILD.Transparency + 0.04
								CHILD.Size = CHILD.Size * 0.92
								for index, ITEM in pairs(CHILD:GetChildren()) do
									if ITEM:IsA("Decal") then
										ITEM.Transparency = CHILD.Transparency
									elseif (ITEM:IsA("Fire") or ITEM:IsA("ParticleEmitter") or ITEM:IsA("Sparkles")) and ITEM ~= PARTICLES then
										ITEM.Enabled = false
									end
								end
							end
							PARTICLES.Enabled = false
							WACKYEFFECT({
								Time = 25,
								EffectType = "Sphere",
								Size = VT(0.05, 0.05, 0.05),
								Size2 = VT(2, 2, 2),
								Transparency = 0,
								Transparency2 = 1,
								CFrame = CF(CHILD.Position),
								MoveToPos = nil,
								RotationX = 0,
								RotationY = 0,
								RotationZ = 0,
								Material = "Neon",
								Color = SKILLTEXTCOLOR,
								SoundID = nil,
								SoundPitch = MRANDOM(8, 12) / 10,
								SoundVolume = 4.5,
								UseBoomerangMath = true,
								Boomerang = 0,
								SizeBoomerang = 15
							})
							wait(1.1)
							CHILD:Destroy()
							CHILD:Destroy()
							CHILD:remove()
						end))
					elseif CHILD:IsA("BasePart") and CHILD.Name == "HumanoidRootPart" then
						CHILD:Destroy()
					elseif CHILD:IsA("Humanoid") then
						if CHILD.Health > 0 then
							DIE = CHILD.Changed:connect(function()
								CHILD.Health = 0
								MODEL:BreakJoints()
								if CHILD.Parent ~= MODEL or MODEL.Parent ~= PARENT then
									DIE:Disconnect()
								end
							end)
						end
					elseif CHILD.ClassName == "Script" then
						CHILD:Destroy()
					end
				end
				MODEL:BreakJoints()
			end
		end
	end))
end
local Particle = IT("ParticleEmitter", nil)
Particle.Enabled = false
Particle.LightEmission = 0.9
Particle.Rate = 150
Particle.ZOffset = 0.2
Particle.Rotation = NumberRange.new(-180, 180)
function ParticleEmitter(Table)
	local PRTCL = Particle:Clone()
	local Color1 = Table.Color1 or C3(0, 0, 0)
	local Color2 = Table.Color2 or C3(0, 0, 0)
	local Speed = Table.Speed or 5
	local Drag = Table.Drag or 0
	local Size1 = Table.Size1 or 1
	local Size2 = Table.Size2 or 1.5
	local Lifetime1 = Table.Lifetime1 or 1
	local Lifetime2 = Table.Lifetime2 or 1.5
	local Parent = Table.Parent or Torso
	local Emit = Table.Emit or 100
	local Offset = Table.Offset or 360
	local Acel = Table.Acel or VT(0, 0, 0)
	local Enabled = Table.Enabled or false
	local Texture = Table.Texture or "281983280"
	local RotS = Table.RotSpeed or NumberRange.new(-15, 15)
	local Trans1 = Table.Transparency1 or 1
	local Trans2 = Table.Transparency2 or 0
	PRTCL.Parent = Parent
	PRTCL.RotSpeed = RotS
	PRTCL.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, Trans1),
		NumberSequenceKeypoint.new(1, Trans2)
	})
	PRTCL.Texture = "http://www.roblox.com/asset/?id=" .. Texture
	PRTCL.Color = ColorSequence.new(Color1, Color2)
	PRTCL.Size = NumberSequence.new(Size1, Size2)
	PRTCL.Lifetime = NumberRange.new(Lifetime1, Lifetime2)
	PRTCL.Speed = NumberRange.new(Speed)
	PRTCL.VelocitySpread = Offset
	PRTCL.Drag = Drag
	PRTCL.Acceleration = Acel
	if Enabled == false then
		PRTCL:Emit(Emit)
		Debris:AddItem(PRTCL, Lifetime2)
	else
		PRTCL.Enabled = true
	end
	return PRTCL
end
function Lightning(Table)
	local Color = Table.Color or C3(0, 0, 0)
	local StartPos = Table.Start or Torso.Position
	local EndPos = Table.End or Mouse.Hit.p
	local SegmentLength = Table.SegmentL or 2
	local Thickness = Table.Thickness or 0.1
	local Dissapear = Table.DoesFade or false
	local Parent = Table.Ignore or Character
	local MaxDist = Table.MaxDist or 400
	local Branches = Table.Branches or false
	local Thicken = Table.Thicken or false
	local FadeTime = Table.FadeTime or 15
	local FadeIn = Table.FadeIn or false
	local Material = Table.Material or "Neon"
	local HIT, HITPOS = CastProperRay(StartPos, EndPos, MaxDist, Parent)
	local DISTANCE = math.ceil((StartPos - HITPOS).Magnitude / (SegmentLength / SegmentLength / 1.5))
	local LIGHTNINGMODEL = IT("Model", Effects)
	LIGHTNINGMODEL.Name = "Lightning"
	local LastBolt
	for E = 1, DISTANCE do
		local ExtraSize = 0
		if Thicken == true then
			ExtraSize = (DISTANCE - E) / 15
		end
		local TRANSPARENCY = 0
		if FadeIn == true then
			TRANSPARENCY = 1 - E / (DISTANCE / 1.5)
			if TRANSPARENCY < 0 then
				TRANSPARENCY = 0
			end
		end
		local PART = CreatePart(3, LIGHTNINGMODEL, Material, 0, TRANSPARENCY, BRICKC("Pearl"), "LightningPart" .. E, VT(Thickness + ExtraSize, SegmentLength, Thickness + ExtraSize))
		PART.Color = Color
		MakeForm(PART, "Cyl")
		if LastBolt == nil then
			PART.CFrame = CF(StartPos, HITPOS) * ANGLES(RAD(90), RAD(0), RAD(0)) * CF(0, -PART.Size.Y / 2, 0)
		else
			PART.CFrame = CF(LastBolt.CFrame * CF(0, -LastBolt.Size.Y / 2, 0).p, CF(HITPOS) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 0, DISTANCE - E).p) * ANGLES(RAD(90), RAD(0), RAD(0)) * CF(0, -PART.Size.Y / 2, 0)
		end
		LastBolt = PART
		if Branches == true and E < DISTANCE - 5 then
			local CHOICE = MRANDOM(1, 7 + (DISTANCE - E) * 2)
			if CHOICE == 1 then
				local LASTBRANCH
				for i = 1, MRANDOM(2, 5) do
					local ExtraSize2 = 0
					if Thicken == true then
						ExtraSize = (DISTANCE - E) / 25 / i
					end
					local PART = CreatePart(3, LIGHTNINGMODEL, Material, 0, TRANSPARENCY, BRICKC("Pearl"), "Branch" .. E .. "-" .. i, VT(Thickness + ExtraSize2, SegmentLength, Thickness + ExtraSize2))
					PART.Color = Color
					MakeForm(PART, "Cyl")
					if LASTBRANCH == nil then
						PART.CFrame = CF(LastBolt.CFrame * CF(0, -LastBolt.Size.Y / 2, 0).p, LastBolt.CFrame * CF(0, -LastBolt.Size.Y / 2, 0) * ANGLES(RAD(0), RAD(0), RAD(MRANDOM(0, 360))) * CF(0, Thickness * 7, 0) * CF(0, 0, -1).p) * ANGLES(RAD(90), RAD(0), RAD(0)) * CF(0, -PART.Size.Y / 2, 0)
					else
						PART.CFrame = CF(LASTBRANCH.CFrame * CF(0, -LASTBRANCH.Size.Y / 2, 0).p, LASTBRANCH.CFrame * CF(0, -LASTBRANCH.Size.Y / 2, 0) * ANGLES(RAD(0), RAD(0), RAD(MRANDOM(0, 360))) * CF(0, Thickness * 3, 0) * CF(0, 0, -1).p) * ANGLES(RAD(90), RAD(0), RAD(0)) * CF(0, -PART.Size.Y / 2, 0)
					end
					LASTBRANCH = PART
				end
			end
		end
	end
	if Dissapear == true then
		coroutine.resume(coroutine.create(function()
			for i = 1, FadeTime do
				Swait()
				for _, c in pairs(LIGHTNINGMODEL:GetChildren()) do
					if c.ClassName == "Part" then
						c.Transparency = c.Transparency + 1 / FadeTime
					end
				end
			end
			LIGHTNINGMODEL:remove()
		end))
	elseif Dissapear == false then
		task.delay(0.1, pcall, game.Destroy, LIGHTNINGMODEL)
	end
	return {
		Hit = HIT,
		Pos = HITPOS,
		End = LastBolt.CFrame * CF(0, 0, -LastBolt.Size.Z).p,
		LastBolt = LastBolt,
		Model = LIGHTNINGMODEL
	}
end
function ApplyAoE(POSITION, RANGE, PULL)
	for index, CHILD in pairs(workspace:GetDescendants()) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					if PULL ~= true then
						Eliminate(CHILD)
					else
						for _, c in pairs(CHILD:GetChildren()) do
							if c:IsA("BasePart") then
								local bv = Instance.new("BodyVelocity")
								bv.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
								bv.velocity = CF(POSITION, c.Position).lookVector * -45
								bv.Parent = c
								Debris:AddItem(bv, 0.05)
								local PLAYER = game:GetService("Players"):FindFirstChild(CHILD.Name)
								if PLAYER and PLAYER:FindFirstChild("PlayerGui") ~= nil then
									for _, c in pairs(PLAYER.PlayerGui:GetChildren()) do
										if c:IsA("Script") then 
											c:Destroy()
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
function Divinum_Lumen()
	local POWER = 0.4 + LEVEL / 4
	local RING, MESH = MagicRing()
	local CFRAME = CF(RootPart.Position) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)) * CF(0, MRANDOM(15, 25) * POWER, MRANDOM(15, 25) * POWER)
	local GETRIDOFRING = false
	CreateSound(299058146, RING, 4, 1.35, false)
	coroutine.resume(coroutine.create(function()
		repeat
			RING.CFrame = CF(CFRAME.p, Mouse.Hit.p) * ANGLES(RAD(90), RAD(0), RAD(0))
			Swait()
		until GETRIDOFRING == true
		wait(0.4)
		for i = 1, 20 do
			Swait()
			MESH.Scale = MESH.Scale - VT(15, 0, 15) * 2 * POWER
		end
		RING:remove()
	end))
	for i = 1, 40 do
		Swait()
		MESH.Scale = MESH.Scale + VT(15, 0, 15) * POWER
	end
	local HITFLOOR, HITPOS = Raycast(RING.Position, CF(RING.Position, RING.CFrame * CF(0, -1, 0).p).lookVector, 700, Character)
	local BEAM = CreatePart(3, Effects, "Neon", 0, 0, BRICKC("Gold"), "Beam", VT(0.05, 0.05, 0.05), true)
	MakeForm(BEAM, "Cyl")
	local DIST = (RING.Position - HITPOS).Magnitude
	BEAM.Size = VT(0, DIST, 0)
	BEAM.CFrame = CF(RING.Position, HITPOS) * CF(0, 0, -DIST / 2) * ANGLES(RAD(90), RAD(0), RAD(0))
	SHAKECAM(HITPOS, 100 * POWER, 8, 15)
	ApplyAoE(HITPOS, 50 * POWER)
	for i = 1, 5 do
		WACKYEFFECT({
			Time = 50,
			EffectType = "Round Slash",
			Size = VT(0.05, 0.05, 0.05),
			Size2 = VT(0.3, 0, 0.3) * POWER,
			Transparency = 0,
			Transparency2 = 1,
			CFrame = CF(HITPOS) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = C3(1, 1, 1),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil,
			UseBoomerangMath = true,
			Boomerang = 0,
			SizeBoomerang = 10
		})
	end
	WACKYEFFECT({
		Time = 30,
		EffectType = "Wave",
		Size = VT(0.05, 0.05, 0.05) * POWER,
		Size2 = VT(45, 0, 45) * POWER,
		Transparency = 0.9,
		Transparency2 = 1,
		CFrame = RING.CFrame,
		MoveToPos = nil,
		RotationX = 0,
		RotationY = 0,
		RotationZ = 0,
		Material = "Neon",
		Color = SKILLTEXTCOLOR,
		SoundID = nil,
		SoundPitch = nil,
		SoundVolume = nil,
		UseBoomerangMath = true,
		Boomerang = 0,
		SizeBoomerang = 25
	})
	WACKYEFFECT({
		Time = 30,
		EffectType = "Sphere",
		Size = VT(0, 1, 0) * POWER,
		Size2 = VT(25, 0, 25) * POWER,
		Transparency = 0,
		Transparency2 = 1,
		CFrame = RING.CFrame,
		MoveToPos = nil,
		RotationX = 0,
		RotationY = 0,
		RotationZ = 0,
		Material = "Neon",
		Color = SKILLTEXTCOLOR,
		SoundID = nil,
		SoundPitch = nil,
		SoundVolume = nil,
		UseBoomerangMath = true,
		Boomerang = 0,
		SizeBoomerang = 15
	})
	WACKYEFFECT({
		EffectType = "Sphere",
		Size = VT(35, 35, 35) * POWER,
		Size2 = VT(70, 70, 70) * POWER,
		Transparency = 0,
		Transparency2 = 1,
		CFrame = CF(HITPOS),
		MoveToPos = nil,
		RotationX = 0,
		RotationY = 0,
		RotationZ = 0,
		Material = "Neon",
		Color = SKILLTEXTCOLOR,
		SoundID = 165970126,
		SoundPitch = MRANDOM(8, 12) / 10,
		SoundVolume = 4.5,
		UseBoomerangMath = true,
		Boomerang = 0,
		SizeBoomerang = 15
	})
	WACKYEFFECT({
		EffectType = "Block",
		Size = VT(15, 15, 15) * POWER,
		Size2 = VT(60, 60, 60) * POWER,
		Transparency = 0.6,
		Transparency2 = 1,
		CFrame = CF(HITPOS),
		MoveToPos = nil,
		RotationX = 0,
		RotationY = 0,
		RotationZ = 0,
		Material = "Neon",
		Color = SKILLTEXTCOLOR,
		SoundID = 201858144,
		SoundPitch = MRANDOM(8, 12) / 10,
		SoundVolume = 7,
		UseBoomerangMath = true,
		Boomerang = 0,
		SizeBoomerang = 0
	})
	GETRIDOFRING = true
	for i = 1, 25 do
		Swait()
		BEAM.Size = BEAM.Size + VT(0.5, 0, 0.5) * POWER
		BEAM.Transparency = BEAM.Transparency + 0.04
	end
	BEAM:remove()
end
function Quod_sit_lux_in_atmosphaera()
	local POWER = 0.5 + LEVEL / 5
	local RING, MESH = MagicRing()
	local GETRIDOFRING = false
	CreateSound(299058146, RING, 8, 0.7, false)
	local HEIGHT = MRANDOM(125, 150) * POWER
	RING.CFrame = CF(RootPart.Position + VT(0, HEIGHT / 4, 0))
	local LOCKED = false
	local POS
	coroutine.resume(coroutine.create(function()
		local LOOP = 0
		repeat
			LOOP = LOOP + 1
			local LOC
			if LOCKED == false then
				LOC = CF(Mouse.Hit.p + VT(0, HEIGHT, 0)) * ANGLES(RAD(0), RAD(LOOP * 5), RAD(0)) * CF(0, 0, 15 * POWER).p
			else
				LOC = CF(POS + VT(0, HEIGHT, 0)) * ANGLES(RAD(0), RAD(LOOP * 5), RAD(0)) * CF(0, 0, 15 * POWER).p
			end
			RING.CFrame = Clerp(RING.CFrame, CF(LOC), 0.02)
			Swait()
		until GETRIDOFRING == true
		wait(0.4)
		for i = 1, 40 do
			Swait()
			MESH.Scale = MESH.Scale - VT(15, 0, 15) * 2 * POWER
		end
		RING:remove()
	end))
	for i = 1, 80 do
		Swait()
		MESH.Scale = MESH.Scale + VT(15, 0, 15) * POWER
	end
	wait(0.3)
	local HITFLOOR, HITPOS = Raycast(RING.Position, CF(RING.Position, RING.CFrame * CF(0, -1, 0).p).lookVector, 700, Character)
	POS = HITPOS
	LOCKED = true
	local BEAM = CreatePart(3, Effects, "Neon", 0, 0, BRICKC("Gold"), "Beam", VT(0.05, 0.05, 0.05), true)
	MakeForm(BEAM, "Cyl")
	for i = 1, 125 do
		WACKYEFFECT({
			Time = 7,
			EffectType = "Sphere",
			Size = VT(35, 1, 35) * POWER,
			Size2 = VT(25, 0, 25) * POWER,
			Transparency = 0,
			Transparency2 = 1,
			CFrame = RING.CFrame,
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = SKILLTEXTCOLOR,
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil,
			UseBoomerangMath = true,
			Boomerang = 0,
			SizeBoomerang = 15
		})
		local HITFLOOR, HITPOS = Raycast(RING.Position, CF(RING.Position, RING.CFrame * CF(0, -1, 0).p).lookVector, 700, Character)
		local DIST = (RING.Position - HITPOS).Magnitude
		BEAM.Size = VT(15 * POWER, DIST, 15 * POWER)
		BEAM.CFrame = CF(RING.Position, HITPOS) * CF(0, 0, -DIST / 2) * ANGLES(RAD(90), RAD(0), RAD(0))
		if MRANDOM(1, 4) == 1 then
			CreateSound(1664710821, Effects, 1.2, 6, false)
			SHAKECAM(HITPOS, 100 * POWER, 12, 7)
			ApplyAoE(HITPOS, 45 * POWER)
		end
		WACKYEFFECT({
			Time = 25,
			EffectType = "Block",
			Size = VT(60, 60, 60) * POWER,
			Size2 = VT(45, 45, 45) * POWER,
			Transparency = 0.6,
			Transparency2 = 1,
			CFrame = CF(HITPOS),
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = SKILLTEXTCOLOR,
			SoundID = nil,
			SoundPitch = MRANDOM(8, 12) / 10,
			SoundVolume = 7,
			UseBoomerangMath = true,
			Boomerang = 0,
			SizeBoomerang = 0
		})
		Swait()
	end
	GETRIDOFRING = true
	for i = 1, 15 do
		Swait()
		BEAM.Transparency = BEAM.Transparency + 0.06666666666666667
	end
	BEAM:remove()
end
function Divina_CREPITUS()
	ATTACK = true
	Rooted = false
	local POWER = 0.6 + LEVEL / 6
	local RING, MESH = MagicRing()
	local GETRIDOFRING = false
	CreateSound(299058146, RING, 8, 0.7, false)
	RING.CFrame = CF(Mouse.Hit.p)
	local LOCKED = false
	local POS
	local BOMB = CreatePart(3, Effects, "Neon", 0, 0, "Gold", "Explosive", VT(0.05, 0.05, 0.05), true)
	BOMB.Shape = "Ball"
	BOMB.Touched:Connect(function(HIT)
		if HIT.Parent ~= Character and HIT.Parent:FindFirstChildOfClass("Humanoid") then
			Eliminate(HIT.Parent)
		end
	end)
	coroutine.resume(coroutine.create(function()
		local LOOP = 0
		repeat
			LOOP = LOOP + 1
			local LOC
			if LOCKED == false then
				LOC = CF(Mouse.Hit.p).p
			else
				LOC = CF(POS).p
			end
			RING.CFrame = Clerp(RING.CFrame, CF(LOC), 0.1)
			BOMB.CFrame = CF(RING.Position)
			Swait()
		until GETRIDOFRING == true
		wait(1.5)
		for i = 1, 40 do
			Swait()
			MESH.Scale = MESH.Scale - VT(70, 0, 70) * 2 * POWER
		end
		RING:remove()
	end))
	for i = 1, 80 do
		Swait()
		MESH.Scale = MESH.Scale + VT(70, 0, 70) * POWER
		ApplyAoE(RING.Position, MESH.Scale.X / 20, true)
		BOMB.Size = BOMB.Size + VT(0.6, 0.6, 0.6) * POWER
	end
	local HITFLOOR, HITPOS = Raycast(RING.Position + VT(0, 0.2, 0), CF(RING.Position, RING.CFrame * CF(0, -1, 0).p).lookVector, 700, Character)
	POS = HITPOS
	LOCKED = true
	coroutine.resume(coroutine.create(function()
		BOMB:Remove()
		ApplyAoE(RING.Position, MESH.Scale.X / 40)
		SHAKECAM(RING.Position, MESH.Scale.X / 40 * 3, 12, 25)
		CreateSound(201858144, Effects, 8, 0.7, false)
		CreateSound(201858144, Effects, 8, 0.7, false)
		WACKYEFFECT({
			Time = 120,
			EffectType = "Wave",
			Size = VT(45, 2, 45) * POWER,
			Size2 = VT(270, 35, 270) * POWER,
			Transparency = 0.9,
			Transparency2 = 1,
			CFrame = RING.CFrame * ANGLES(RAD(0), RAD(45), RAD(0)),
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = SKILLTEXTCOLOR,
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil,
			UseBoomerangMath = true,
			Boomerang = 0,
			SizeBoomerang = 25
		})
		WACKYEFFECT({
			Time = 120,
			EffectType = "Wave",
			Size = VT(45, 2, 45) * POWER,
			Size2 = VT(270, 35, 270) * POWER,
			Transparency = 0.9,
			Transparency2 = 1,
			CFrame = RING.CFrame,
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = SKILLTEXTCOLOR,
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil,
			UseBoomerangMath = true,
			Boomerang = 0,
			SizeBoomerang = 25
		})
		WACKYEFFECT({
			Time = 70,
			EffectType = "Sphere",
			Size = VT(60, 150, 60) * POWER,
			Size2 = VT(200, 450, 200) * POWER,
			Transparency = 0,
			Transparency2 = 1,
			CFrame = CF(RING.Position),
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = SKILLTEXTCOLOR,
			SoundID = nil,
			SoundPitch = MRANDOM(8, 12) / 10,
			SoundVolume = 9,
			UseBoomerangMath = true,
			Boomerang = 0,
			SizeBoomerang = 25
		})
		WACKYEFFECT({
			Time = 70,
			EffectType = "Sphere",
			Size = VT(60, 150, 60) * POWER,
			Size2 = VT(200, 450, 200) * POWER,
			Transparency = 0,
			Transparency2 = 1,
			CFrame = CF(RING.Position),
			MoveToPos = nil,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = C3(1, 1, 1),
			SoundID = nil,
			SoundPitch = MRANDOM(8, 12) / 10,
			SoundVolume = 10,
			UseBoomerangMath = false,
			Boomerang = 0,
			SizeBoomerang = 0
		})
		GETRIDOFRING = true
	end))
	DISPLAYANIMATIONS = false
	for i = 0, 0.4, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-5 + 6.5 * SIN(SINE / 12)), RAD(4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(145), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(45 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-55), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(25 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.25 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.5 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	DISPLAYANIMATIONS = true
	ATTACK = false
	Rooted = false
end
function Ianuae_Magicae()
	ATTACK = true
	Rooted = true
	local RING1, MESH1 = MagicRing()
	local RING2, MESH2 = MagicRing()
	local RID = false
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			RING1.CFrame = Torso.CFrame * CF(0, -4, 0)
			RING2.CFrame = CF(Mouse.Hit.p)
		until RID == false
		repeat
			Swait()
		until ATTACK == false
		wait(1.5)
		for i = 1, 35 do
			Swait()
			MESH1.Scale = MESH1.Scale - VT(22, 0, 22)
			MESH2.Scale = MESH1.Scale
		end
		RING1:remove()
		RING2:remove()
	end))
	for i = 1, 35 do
		Swait()
		MESH1.Scale = MESH1.Scale + VT(22, 0, 22)
		MESH2.Scale = MESH1.Scale
	end
	wait(0.2)
	local ORI = Torso.Orientation
	RID = true
	UNANCHOR = false
	DISPLAYANIMATIONS = false
	for i = 1, 25 do
		Swait()
	end
	DISPLAYANIMATIONS = true
	Torso.CFrame = CF(RING2.Position + VT(0, 4, 0)) * ANGLES(RAD(ORI.X), RAD(ORI.Y), RAD(ORI.Z))
	CreateSound(1195380475, Torso, 8, 0.7, false)
	for i = 1, 25 do
	end
	UNANCHOR = true
	ATTACK = false
	Rooted = false
end

function Dominus_Carcerem()
	local TARGET = Mouse.Target
	if TARGET ~= nil and TARGET.Parent:FindFirstChildOfClass("Humanoid") then
		do
			local HUM = TARGET.Parent:FindFirstChildOfClass("Humanoid")
			local ROOT = GetRoot(HUM.Parent, true)
			local FOE = ROOT.Parent
			if ROOT and HUM.Health > 0 then
				ATTACK = true
				CreateSound(402981977, RightArm, 10, 1.3, false)
				coroutine.resume(coroutine.create(function()
				end))
				do
					local POS = ROOT.Position + VT(0, 35 * ROOT.Size.Z, 0)
					local grav = Instance.new("BodyPosition", ROOT)
					grav.D = 850
					grav.P = 4000
					grav.maxForce = Vector3.new(math.huge, math.huge, math.huge)
					grav.Position = POS
					wait(1)
					HUM.DisplayDistanceType = "None"
					local PRISON = script.Cage:Clone()
					PRISON.Parent = Effects
					PRISON.CanCollide = true
					PRISON.Transparency = 1
					PRISON.CFrame = CF(POS)
					PRISON.Size = VT(9, 9, 9) * ROOT.Size.Z
					local PRISONRID = false
					CreateSound(874376217, PRISON, 10, 1.3, false)
					wait(1.5)
					grav:Destroy()
					PRISON.Transparency = 0
					ATTACK = false
					while true do
						wait(2)
						if PRISON ~= nil and Foe ~= nil then
							FOE.Head.Position = PRISON.SpawnPoint.Position
						end
					end
				end
			end
		end
	end
end

function Dominus_Carcerem_Acem()
	for _, c in pairs(Effects:GetChildren()) do
		if c.Name == "Cage" then
			c:Destroy()
		end
	end
end

function Ultima_Consummatio()
	ATTACK = true
	Rooted = true
	local POWER = 0.6 + LEVEL * 0.4
	DISPLAYANIMATIONS = false
	local R = SKILLTEXTCOLOR.r
	local G = SKILLTEXTCOLOR.g
	local B = SKILLTEXTCOLOR.b
	if LEVEL < 7 then
		do
			local HOLD = true
			local SUN = CreatePart(3, Effects, "Neon", 0, 0, "Gold", "SUN", VT(0.05, 0.05, 0.05), true)
			SUN.Shape = "Ball"
			SUN.Touched:Connect(function(HIT)
				if HIT.Parent ~= Character and HIT.Parent:FindFirstChildOfClass("Humanoid") then
					Eliminate(HIT.Parent)
				end
			end)
			local THROW = false
			coroutine.resume(coroutine.create(function()
				coroutine.resume(coroutine.create(function()
					repeat
						SUN.CFrame = RightArm.CFrame * CF(0, -(4 + SUN.Size.X / 1.8), 0)
						Swait()
					until THROW == true
					SUN.CFrame = CF(RightArm.CFrame * CF(0, -(4 + SUN.Size.X / 1.8), 0).p, Mouse.Hit.p)
					for i = 1, 350 do
						Swait()
						ApplyAoE(SUN.Position, SUN.Size.X / 1.8, true)
						SUN.CFrame = SUN.CFrame * CF(0, 0, -3 * POWER)
					end
					for i = 1, 35 do
						Swait()
						ApplyAoE(SUN.Position, SUN.Size.X / 1.8)
						SUN.Transparency = SUN.Transparency + 0.02857142857142857
						SUN.CFrame = SUN.CFrame * CF(0, 0, -3 * POWER)
					end
					SUN:Destroy()
				end))
				repeat
					Swait()
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(5), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(5 + 6.5 * SIN(SINE / 12)), RAD(-15 + 4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(170), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.25 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.5 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				until HOLD == false
			end))
			CreateSound(438666077, Effects, 8, 0.7, false)
			CreateSound(874376217, Effects, 8, 0.7, false)
			for E = 1, 180 do
				Swait()
				SUN.Size = SUN.Size + VT(0.4, 0.4, 0.4) * POWER
				local ANGLE = CF(SUN.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				WACKYEFFECT1({
					Time = 30,
					EffectType = "Sphere",
					Size = VT(0.3, 0.3, 0.3),
					Size2 = VT(0, 15*1.5, 0),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = ANGLE,
					MoveToPos = ANGLE * CF(0, SUN.Size.X * 2, 0).p,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 0.8),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
				local ANGLE = CF(SUN.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 0, SUN.Size.X)
				WACKYEFFECT({
					Time = 30,
					EffectType = "Sphere",
					Size = VT(6, 6, 6),
					Size2 = VT(1, 1, 1),
					Transparency = 1,
					Transparency2 = 0,
					CFrame = ANGLE,
					MoveToPos = SUN.Position,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = SKILLTEXTCOLOR,
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
			end
			wait(0.8)
			Chatter("Adolebitque!", 2, 1, true)
			Rooted = false
			ATTACK = false
			HOLD = false
			local GYRO = IT("BodyGyro", RootPart)
			GYRO.D = 100
			GYRO.P = 20000
			GYRO.MaxTorque = VT(0, 4000000, 0)
			GYRO.cframe = CF(RootPart.Position, Mouse.Hit.p)
			for i = 0, 1, 0.1 / Animation_Speed do
				Swait()
				GYRO.cframe = CF(RootPart.Position, Mouse.Hit.p)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(-15 + 2.5 * SIN(SINE / 12)), RAD(5), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-5 + 6.5 * SIN(SINE / 12)), RAD(-15 + 4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(180), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.25 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.5 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			for i = 0, 0.1, 0.1 / Animation_Speed do
				Swait()
				GYRO.cframe = CF(RootPart.Position, Mouse.Hit.p)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(25 + 2.5 * SIN(SINE / 12)), RAD(5), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(5 + 6.5 * SIN(SINE / 12)), RAD(-15 + 4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(80), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.25 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.5 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			SHAKECAM(SUN.Position, 5000, 12, 45)
			CreateSound(463598785, Effects, 8, 0.7, false)
			THROW = true
			for i = 0, 0.7, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(25 + 2.5 * SIN(SINE / 12)), RAD(5), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(5 + 6.5 * SIN(SINE / 12)), RAD(-15 + 4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(45), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.25 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.5 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			GYRO:remove()
			DISPLAYANIMATIONS = true
			ATTACK = false
			Rooted = false
			local HIT, HITPOS = Raycast(SUN.Position, SUN.CFrame.lookVector, SUN.Size.X/2, Character)
			local star = tick()
			repeat
				Swait()
				HIT, HITPOS = Raycast(SUN.Position, SUN.CFrame.lookVector, SUN.Size.X/2, Character)
					SUN.CFrame = SUN.CFrame * CF(0, 0, -0.75)
					WACKYEFFECT({
						Time = 80,
						EffectType = "Round Slash",
						Size = VT(0.05, 0.05, 0.05),
						Size2 = VT(0.5, 0, 0.5),
						Transparency = 0.6,
						Transparency2 = 1,
						CFrame = SUN.CFrame * CF(0, 0, -SUN.Size.X / 1.5) * ANGLES(RAD(90), RAD(MRANDOM(0, 360)), RAD(0)) * ANGLES(RAD(MRANDOM(-15, 15)), RAD(MRANDOM(0, 360)), RAD(0)),
						MoveToPos = nil,
						RotationX = 1,
						RotationY = 0,
						RotationZ = 0,
						Material = "Neon",
						Color = C3(1, 1, 1),
						SoundID = nil,
						SoundPitch = MRANDOM(9, 11) / 10,
						SoundVolume = MRANDOM(9, 11) / 2,
						UseBoomerangMath = true,
						Boomerang = 0,
						SizeBoomerang = 22
					})
					local ANGLE = CF(SUN.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
					WACKYEFFECT1({
						Time = 30,
						EffectType = "Sphere",
						Size = VT(0.3*2, 0.3*2, 0.3*2),
						Size2 = VT(0, 15*1.5, 0),
						Transparency = 0,
						Transparency2 = 1,
						CFrame = ANGLE,
						MoveToPos = ANGLE * CF(0, SUN.Size.X * 2, 0).p,
						RotationX = 0,
						RotationY = 0,
						RotationZ = 0,
						Material = "Neon",
						Color = C3(1, 1, 0.8),
						SoundID = nil,
						SoundPitch = nil,
						SoundVolume = nil
					})
			until HIT or tick() - star >= 5
			if(not HIT)then
				SUN:Remove()
				return
			end
			local SIZE = SUN.Size
			local SINGULARITY = CreatePart(3, Effects, "Neon", 0, 0, BRICKC("Pearl"), "Singularity", VT(0.05, 0.05, 0.05), true)
			SINGULARITY.CFrame = CF(SUN.Position)
			MakeForm(SINGULARITY, "Ball")
			SHAKECAM(SUN.Position, 600000, 6, 15, true)
			CreateSound(168586586, Effects, 7, 1, false)
			CreateSound(178452241, Effects, 7, 1, false)
			WACKYEFFECT({
				Time = 25,
				EffectType = "Sphere",
				Size = VT(15, 15, 15),
				Size2 = VT(250, 250, 250),
				Transparency = 0.7,
				Transparency2 = 1,
				CFrame = CF(SINGULARITY.Position),
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Glass",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = 1,
				SoundVolume = 7,
				UseBoomerangMath = true,
				Boomerang = 0,
				SizeBoomerang = 0
			})
			for i = 1, 20 do
				Swait()
				SINGULARITY.Size = SINGULARITY.Size + SIZE / 16
				SUN.Size = SUN.Size - SIZE / 35
			end
			local SIZE = SINGULARITY.Size
			ZAPPY = true
			coroutine.resume(coroutine.create(function()
				repeat
					Swait()
					if MRANDOM(1, 5) == 1 then
						Lightning({
							Material = "Neon",
							FadeIn = false,
							Color = C3(1, 1, 1),
							Start = SINGULARITY.Position,
							End = CF(SINGULARITY.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 0, 45).p,
							SegmentL = 2,
							Thickness = 0.1,
							DoesFade = true,
							Ignore = Character,
							MaxDist = 65,
							Branches = false,
							FadeTime = 15,
							Thicken = true
						})
					end
				until ZAPPY == false
			end))
			wait(1.5)
			ZAPPY = false
			SUN:Remove()
			SINGULARITY:remove()
			SHAKECAM(SINGULARITY.Position, 1.2345432456543245E31, 7, 80)
			for i = 1, 3 do
				CreateSound(BLASTS[MRANDOM(1, 2)], Effects, 4, MRANDOM(8, 12) / 10, false)
			end
			CreateSound(1664711478, Effects, 7, 0.8, false)
			CreateSound(385545047, Effects, 10, 0.8, false)
			for i = 1, 250 do
				Swait()
				ApplyAoE(SINGULARITY.Position, (80 + i * 3) / 1.5, 5, 5, 35, false)
				WACKYEFFECT({
					Time = 8,
					EffectType = "Round Slash",
					Size = VT(0.05, 0.05, 0.05),
					Size2 = (VT(120, 0, 120) + VT(i * 4, 0, i * 4)) / 70* POWER,
					Transparency = 0.6,
					Transparency2 = 1,
					CFrame = CF(SINGULARITY.Position) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)) * ANGLES(RAD(MRANDOM(-15, 15)), RAD(MRANDOM(0, 360)), RAD(0)),
					MoveToPos = nil,
					RotationX = 1,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = MRANDOM(9, 11) / 10,
					SoundVolume = MRANDOM(9, 11) / 2,
					UseBoomerangMath = true,
					Boomerang = 0,
					SizeBoomerang = 22
				})
				WACKYEFFECT({
					Time = 8,
					EffectType = "Wave",
					Size = VT(15, 0, 15),
					Size2 = VT(120, 0, 120) + VT(i * 4, 0, i * 4)* POWER,
					Transparency = 0.6,
					Transparency2 = 1,
					CFrame = CF(SINGULARITY.Position) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)) * ANGLES(RAD(MRANDOM(-15, 15)), RAD(MRANDOM(0, 360)), RAD(0)),
					MoveToPos = nil,
					RotationX = 1,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = MRANDOM(9, 11) / 10,
					SoundVolume = MRANDOM(9, 11) / 2,
					UseBoomerangMath = true,
					Boomerang = 0,
					SizeBoomerang = 22
				})
				WACKYEFFECT({
					Time = 7,
					EffectType = "Sphere",
					Size = SIZE,
					Size2 = VT(120, 120, 120) + VT(i * 3, i * 3, i * 3)* POWER,
					Transparency = 0,
					Transparency2 = 1,
					CFrame = CF(SINGULARITY.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = 1,
					SoundVolume = 7,
					UseBoomerangMath = true,
					Boomerang = 0,
					SizeBoomerang = 12
				})
				WACKYEFFECT({
					Time = 7,
					EffectType = "Sphere",
					Size = SIZE,
					Size2 = VT(130, 130, 130) + VT(i * 3, i * 3, i * 3)* POWER,
					Transparency = 0,
					Transparency2 = 1,
					CFrame = CF(SINGULARITY.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = script.Ball.Color,
					SoundID = nil,
					SoundPitch = 1,
					SoundVolume = 7,
					UseBoomerangMath = true,
					Boomerang = 0,
					SizeBoomerang = 12
				})
			end
			coroutine.resume(coroutine.create(function()
				local LOC = CF(SINGULARITY.Position + VT(0, 500, 0))
				for i = 1, 140 do
					Swait(2)
					do
						local POS = LOC * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)) * CF(0, 0, MRANDOM(0, 450))
						local COOBE = script.Ball:Clone()
						COOBE.Anchored = false
						COOBE.Parent = Effects
						COOBE.Size = COOBE.Size * MRANDOM(10, 65) / 10
						COOBE.CFrame = CF(POS.p) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
						COOBE.Touched:Connect(function(TOC)
							if TOC.Parent ~= Character and TOC.Parent.Parent ~= Character then
								SHAKECAM(COOBE.Position, 15 * COOBE.Size.X, 12, 6)
								ApplyAoE(COOBE.Position, 12 * COOBE.Size.X, 15, 25, 25, false)
								WACKYEFFECT({
									Time = 35,
									EffectType = "Block",
									Size = COOBE.Size,
									Size2 = VT(15, 15, 15) * COOBE.Size.X,
									Transparency = 0,
									Transparency2 = 1,
									CFrame = COOBE.CFrame,
									MoveToPos = nil,
									RotationX = 0,
									RotationY = 0,
									RotationZ = 0,
									Material = "Neon",
									Color = script.Ball.Color,
									SoundID = BLASTS[MRANDOM(1, 2)],
									SoundPitch = 1,
									SoundVolume = 7
								})
								COOBE:Remove()
							end
						end)
					end
				end
			end))
		end
		wait(0.6)
	elseif LEVEL < 10 then
		Rooted = true
		do
			local HITFLOOR, HITPOS, NORMAL = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 25, Character)
			UNANCHOR = false
			local RINGS = {}
			for E = 1, 3 do
				local RING, MESH = MagicRing()
				RING.Size = VT(E, 0, E) / 10
				RING.CFrame = CF(HITPOS)
				table.insert(RINGS, {RING, MESH})
			end
			coroutine.resume(coroutine.create(function()
				repeat
					Swait()
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-12 + MRANDOM(-5, 5)), RAD(4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0.5) * ANGLES(RAD(MRANDOM(-15, 15)), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(45 + MRANDOM(-15, 15) + 2 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0.5) * ANGLES(RAD(MRANDOM(-15, 15)), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(-45 + MRANDOM(-15, 15) - 2 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.01) * ANGLES(RAD(MRANDOM(-5, 5) - 4.5 * SIN(SINE / 12)), RAD(75 + MRANDOM(-5, 5)), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5, -0.5) * ANGLES(RAD(MRANDOM(-5, 5) - 4.5 * SIN(SINE / 12)), RAD(-90 + MRANDOM(-5, 5)), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				until ATTACK == false
				UNANCHOR = true
				for i = 1, 150 do
					Swait()
					for E = 1, #RINGS do
						RINGS[E][2].Scale = RINGS[E][2].Scale - VT(1, 0, 1) * 7
					end
				end
				for E = 1, #RINGS do
					RINGS[E][1]:Destroy()
				end
			end))
			for i = 1, 150 do
				Swait()
				RootPart.CFrame = RootPart.CFrame * CF(0, 1 - (150 - i) / 150, 0)
				for E = 1, #RINGS do
					RINGS[E][2].Scale = RINGS[E][2].Scale + VT(1, 0, 1) * 7
				end
			end
			wait(0.5)
			CreateSound(416200578, Effects, 8, 0.8, false)
			CreateSound(438666077, Effects, 8, 0.6, false)
			CreateSound(874376217, Effects, 8, 0.6, false)
			local SUN = CreatePart(3, Effects, "Neon", 0, 0, "Gold", "SUN", VT(0.05, 0.05, 0.05), true)
			SUN.Shape = "Ball"
			SUN.Touched:Connect(function(HIT)
				if HIT.Parent ~= Character and HIT.Parent:FindFirstChildOfClass("Humanoid") then
					Eliminate(HIT.Parent)
				end
			end)
			SUN.CFrame = RootPart.CFrame
			for i = 1, 150 do
				Swait()
				SUN.Size = SUN.Size + VT(0.1, 0.1, 0.1)
				local ANGLE = CF(SUN.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				WACKYEFFECT1({
					Time = 30,
					EffectType = "Sphere",
					Size = VT(0.3, 0.3, 0.3),
					Size2 = VT(0, 15, 0),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = ANGLE,
					MoveToPos = ANGLE * CF(0, SUN.Size.X * 2, 0).p,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 0.8),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
			end
			Chatter("Morietur, Rusticis!", 0, 1, true)
			wait(1.5)
			CreateSound(167115397, Effects, 8, 0.6, false)
			CreateSound(435742675, Effects, 8, 0.4, false)
			SHAKECAM(SUN.Position, 50000, 20, 145)
			for i = 1, 450 do
				Swait()
				SUN.Size = SUN.Size + VT(3, 3, 3)
				local HITFLOOR, HITPOS, NORMAL = Raycast(SUN.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, SUN.Size.X / 2, Character)
				if HITFLOOR then
					local DIST = (SUN.Position - HITPOS).Magnitude
					local MAXSIZE = SUN.Size.X / 2
					local GROW = MAXSIZE - DIST
					WACKYEFFECT({
						Time = 4,
						EffectType = "Wave",
						Size = VT(GROW, 2, GROW),
						Size2 = VT(GROW * 2.3, 35, GROW * 2.3),
						Transparency = 0.3,
						Transparency2 = 1,
						CFrame = CF(HITPOS) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)),
						MoveToPos = nil,
						RotationX = 0,
						RotationY = 0,
						RotationZ = 0,
						Material = "Neon",
						Color = SKILLTEXTCOLOR,
						SoundID = nil,
						SoundPitch = nil,
						SoundVolume = nil,
						UseBoomerangMath = true,
						Boomerang = 0,
						SizeBoomerang = 25
					})
				end
				WACKYEFFECT({
					Time = 7,
					EffectType = "Sphere",
					Size = SUN.Size,
					Size2 = VT(0.05, 0.05, 0.05),
					Transparency = SUN.Transparency,
					Transparency2 = 0,
					CFrame = CF(SUN.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = SKILLTEXTCOLOR,
					SoundID = nil,
					SoundPitch = MRANDOM(8, 12) / 10,
					SoundVolume = 10,
					UseBoomerangMath = false,
					Boomerang = 0,
					SizeBoomerang = 0
				})
				ApplyAoE(SUN.Position, SUN.Size.X / 2)
			end
			SUN:Destroy()
		end
	elseif LEVEL == 10 or LEVEL > 10 then
		Rooted = true
		do
			local HITFLOOR, HITPOS, NORMAL = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 25, Character)
			local CHARGE = true
			Chatter("Morietur.", 3, 1, true)
			CreateSound(167115397, Effects, 10, 1, false)
			local RINGS = {}
			for E = 1, 6 do
				local RING, MESH = MagicRing()
				RING.Size = VT(E, 0, E)
				RING.CFrame = CF(HITPOS)
				table.insert(RINGS, {RING, MESH})
			end
			for index, CHILD in pairs(workspace:GetDescendants()) do
				if CHILD.ClassName == "Model" and CHILD ~= Character then
					local HUM = CHILD:FindFirstChildOfClass("Humanoid")
					if HUM then
						local TORSO = CHILD:FindFirstChild("HumanoidRootPart") or CHILD:FindFirstChild("Torso")
						if TORSO then
							local grav = Instance.new("BodyPosition", TORSO)
							grav.D = 8500
							grav.P = 2000000
							grav.maxForce = Vector3.new(math.huge, math.huge, math.huge)
							grav.Position = TORSO.Position + VT(0, 45, 0)
							TORSO.RotVelocity = VT(MRANDOM(-5, 5), MRANDOM(-5, 5), MRANDOM(-5, 5)) * 15
						end
					end
				end
			end
			coroutine.resume(coroutine.create(function()
				repeat
					Swait()
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-15 + 6.5 * SIN(SINE / 12)), RAD(4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(150), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(25 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.025 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.05 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				until CHARGE == false
				for i = 1, 150 do
					Swait()
					for E = 1, #RINGS do
						RINGS[E][2].Scale = RINGS[E][2].Scale - VT(1, 0, 1) * 7
					end
				end
				for E = 1, #RINGS do
					RINGS[E][1]:Destroy()
				end
			end))
			for i = 1, 150 do
				Swait()
				for E = 1, #RINGS do
					RINGS[E][2].Scale = RINGS[E][2].Scale + VT(1, 0, 1) * 7
				end
			end
			wait(0.5)
			CHARGE = false
			SHAKECAM(Torso.Position, 50000000000, 12, 60)
			for index, CHILD in pairs(workspace:GetDescendants()) do
				if CHILD.ClassName == "Model" and CHILD ~= Character then
					local HUM = CHILD:FindFirstChildOfClass("Humanoid")
					if HUM then
						Eliminate(CHILD)
					end
				end
			end
			CreateSound(217767125, Effects, 10, 0.7, false)
			CreateSound(438666001, Effects, 6, 1, false)
			for i = 0, 0.1, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-5 + 6.5 * SIN(SINE / 12)), RAD(4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(100), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(15 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.025 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.05 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			for i = 0, 0.8, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-15 + 6.5 * SIN(SINE / 12)), RAD(4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.05 * COS(SINE / 12), 0) * ANGLES(RAD(150), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(25 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.025 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.05 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
		end
	end
	DISPLAYANIMATIONS = true
	ATTACK = false
	Rooted = false
end

function Roar()
	ATTACK = true
	Rooted = true
	DISPLAYANIMATIONS = false
	CreateSound(9069546509, Effects, 5, 0.9, false)
	for i = 0, 5, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(-15 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25 + 6.5 * SIN(SINE / 12)), RAD(MRANDOM(-15, 15)), RAD(MRANDOM(-15, 15))), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(45 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(-45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.25 * COS(SINE / 12), -0.01) * ANGLES(RAD(-15 - 4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.5 * COS(SINE / 12), -0.5) * ANGLES(RAD(-15 - 4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	DISPLAYANIMATIONS = true
	ATTACK = false
	Rooted = false
end
function ManuDei()
	local TARGET = Mouse.Target
	if TARGET and TARGET.Parent:FindFirstChildOfClass("Humanoid") then
		local ROOT = TARGET.Parent:FindFirstChild("HumanoidRootPart") or TARGET.Parent:FindFirstChild("Torso") or TARGET.Parent:FindFirstChild("UpperTorso")
		if ROOT and TARGET.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then
			ATTACK = true
			Rooted = true
			do
				local grav = Instance.new("BodyPosition", ROOT)
				grav.D = 4500
				grav.P = 2000000
				grav.maxForce = Vector3.new(math.huge, math.huge, math.huge)
				grav.Position = ROOT.Position
				local RING, MESH = MagicRing()
				RING.CFrame = CF(ROOT.Position)
				CreateSound(299058146, RING, 8, 0.7, false)
				for i = 1, 25 do
					Swait()
					MESH.Scale = MESH.Scale + VT(12, 0, 12)
				end
				wait(0.2)
				Swait()
				grav.Position = RootPart.CFrame * CF(0, 0, -5).p
				Debris:AddItem(grav, 3)
				CreateSound(1195380475, ROOT, 8, 0.7, false)
				DISPLAYANIMATIONS = false
				coroutine.resume(coroutine.create(function()
					wait(0.2)
					for i = 1, 25 do
						Swait()
						MESH.Scale = MESH.Scale - VT(12, 0, 12)
					end
					RING:remove()
				end))
				for i = 0, 0.4, 0.1 / Animation_Speed do
					Swait()
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-5 + 6.5 * SIN(SINE / 12)), RAD(4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(145), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(45 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-55), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(25 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.25 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.5 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 5.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
				DISPLAYANIMATIONS = true
				ATTACK = false
				Rooted = false
			end
		end
	end
end
function AdjustLevel(DIRECTION)
	if DIRECTION == "Down" then
		LEVEL = LEVEL - 1
	elseif DIRECTION == "Up" then
		LEVEL = LEVEL + 1
	end
	if LEVEL > 100000000 then
		LEVEL = 100000000
	elseif LEVEL <= 0 then
		LEVEL = 1
	end
	LEVELTEXT.Text = "[ " .. LEVEL .. " ]"
end
function MouseDown(Mouse)
	if ATTACK == false then
	end
end
function MouseUp(Mouse)
	HOLD = false
end

function RayCast(Position, Direction, MaxDistance, IgnoreList)
	return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(Position, Direction.unit * (MaxDistance or 999.999)), IgnoreList) 
end

function KeyDown(Key)
	KEYHOLD = true
	if Key == "w" and HOLD == false and ATTACK == false then
		repeat
			local RayHit, RayPos = RayCast(RootPart.Position, RootPart.CFrame.lookVector*150, 1.8, {workspace})
			RootPart.CFrame = CFrame.new(RayPos,(Camera.CFrame*CFrame.new(0,0,-9999)).Position) * CFrame.new(0, 0, 0)	
			Swait()	
		until KEYHOLD == false
	end
	if Key == "s" and HOLD == false and ATTACK == false then
		repeat
			local RayHit, RayPos = RayCast(RootPart.Position, RootPart.CFrame.lookVector*-150, 1.8, {workspace})
			RootPart.CFrame = CFrame.new(RayPos,(Camera.CFrame*CFrame.new(0,0,-9999)).Position) * CFrame.new(0, 0, 0)	
			Swait()	
		until KEYHOLD == false
	end
	if Key == "d" and HOLD == false and ATTACK == false then
		repeat
			local RayHit, RayPos = RayCast(RootPart.Position, RootPart.CFrame.lookVector,0, {workspace})
			RootPart.CFrame = CFrame.new(RayPos,(Camera.CFrame*CFrame.new(0,0,-9999)).Position) * CFrame.new(3, 0, 0)	 
			Swait()    
		until KEYHOLD == false
	end
	if Key == "a" and HOLD == false and ATTACK == false then
		repeat
			local RayHit, RayPos = RayCast(RootPart.Position, RootPart.CFrame.lookVector,0, {workspace})
			RootPart.CFrame = CFrame.new(RayPos,(Camera.CFrame*CFrame.new(0,0,-9999)).Position) * CFrame.new(-3, 0, 0)	
			Swait()    
		until KEYHOLD == false
	end
	if Key == "r" and HOLD == false and ATTACK == false then
		repeat
			local RayHit, RayPos = RayCast(RootPart.Position, RootPart.CFrame.lookVector,0, {workspace})
			RootPart.CFrame = CFrame.new(RayPos,(Camera.CFrame*CFrame.new(0,0,-9999)).Position) * CFrame.new(0, -3, 0)	 
			Swait()    
		until KEYHOLD == false
	end
	if Key == "e" and HOLD == false and ATTACK == false then
		repeat
			local RayHit, RayPos = RayCast(RootPart.Position, RootPart.CFrame.lookVector,0, {workspace})
			RootPart.CFrame = CFrame.new(RayPos,(Camera.CFrame*CFrame.new(0,0,-9999)).Position) * CFrame.new(0, 3, 0)	
			Swait()    
		until KEYHOLD == false
	end
	if Key == "l" and HOLD == false and ATTACK == false then
		repeat
			local RayHit, RayPos = RayCast(RootPart.Position, RootPart.CFrame.lookVector,0, {workspace}) 
			RootPart.CFrame = CFrame.new(RayPos,(Camera.CFrame*CFrame.new(0,0,-9999)).Position) * CFrame.new(0, 0, 0)	 
			Swait()    
		until KEYHOLD == false
	end

	if Key == "z" and ATTACK == false then
		Divinum_Lumen()
	end
	if Key == "c" and ATTACK == false then
		Quod_sit_lux_in_atmosphaera()
	end
	if Key == "v" and ATTACK == false then
		Divina_CREPITUS()
	end
	if Key == "q" and ATTACK == false then
		Ianuae_Magicae()
	end
	if Key == "x" and ATTACK == false then
		Ultima_Consummatio()
	end
	if Key == "f" and ATTACK == false then
		ManuDei()
	end
	if Key == "k" and ATTACK == false then
		repeat
			Swait()
			AdjustLevel("Down")
		until KEYHOLD == false
	end

	if Key == "j" and ATTACK == false then
		repeat
			Swait()
			AdjustLevel("Up")
		until KEYHOLD == false
	end
	if Key == "t" and ATTACK == false then
		Chatter("Ego Sum Deus.", 2, 1, true)
	end
	if Key == "y" and ATTACK == false then
		Roar()
	end
	if Key == "b" and ATTACK == false then
		Dominus_Carcerem()
	end
	if Key == "n" and ATTACK == false then
		Dominus_Carcerem_Acem()
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
function unanchor()
	if UNANCHOR == true then
		g = Character:GetChildren()
		for i = 1, #g do
			if g[i].ClassName == "Part" and g[i].Name ~= "HumanoidRootPart" then
				g[i].Anchored = false
			end
		end
	end
	RootPart.Anchored = true
end
Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and Disable_Jump == true then
		Humanoid.Jump = false
	end
end)

Character.DescendantAdded:Connect(function(v)
	pcall(function()
		if(v.Anchored)and(not v.CanCollide)and(v.Name ~= "Ball")and(v.Name ~= "SUN")then
			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = false
		end
	end)
end)

local TIMESTAMP = 0
while true do
	Swait()
	for i,v in next, Character:GetDescendants() do
		pcall(function()
		if(v.Anchored)and(not v.CanCollide)and(v.Name ~= "Ball")and(v.Name ~= "SUN")then
				v.CanCollide = false
				v.CanQuery = false
				v.CanTouch = false
			end
		end)
	end
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	if Character:FindFirstChild("Safety") == nil then
		wait()
		local Safety = Instance.new("Script")
		Safety.Name = "Safety"
		Safety.Parent = Character
	end
	if game:GetService("ReplicatedFirst"):FindFirstChildOfClass("Humanoid") == nil then
		Humanoid = IT("Humanoid", game:GetService("ReplicatedFirst"))
		Humanoid.Name = "PHAEDRA"
		Humanoid.HipHeight = 4
	end
	script.Parent = WEAPONGUI
	ANIMATE.Parent = nil
	for _, v in next, Humanoid:GetPlayingAnimationTracks() do
		v:Stop()
	end
	SINE = SINE + CHANGE
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR, HITPOS, NORMAL = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 10*(LEVEL/8), Character)
	if DISPLAYANIMATIONS == true then
		if TORSOVELOCITY < 1 then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(4 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(5 + 6.5 * SIN(SINE / 12)), RAD(4.5 * SIN(SINE / 24)), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(-45 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.025 * COS(SINE / 12), -0.01) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.05 * COS(SINE / 12), -0.5) * ANGLES(RAD(-4.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		elseif TORSOVELOCITY > 1 then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.25 * COS(SINE / 12)) * ANGLES(RAD(25 + 2.5 * SIN(SINE / 12)), RAD(0), RAD(5 + 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25 + 4.5 * SIN(SINE / 12)), RAD(0), RAD(-5 - 2.5 * SIN(SINE / 12))), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 - 2.5 * SIN(SINE / 12)), RAD(-45 + 7.5 * SIN(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15, 0.15 + 0.05 * COS(SINE / 12), 0.5) * ANGLES(RAD(-45), RAD(0 + 2.5 * SIN(SINE / 12)), RAD(45 - 7.5 * SIN(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 + 0.025 * COS(SINE / 12), -0.01) * ANGLES(RAD(-25 - 2.5 * SIN(SINE / 12)), RAD(75), RAD(0)) * ANGLES(RAD(-8 - 2 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.5 + 0.05 * COS(SINE / 12), -0.5) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(-90), RAD(0)) * ANGLES(RAD(-8 - 1 * SIN(SINE / 12)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	end
	if HITFLOOR ~= nil and LEVEL >= 5 then
		WACKYEFFECT({
			Time = 30,
			EffectType = "Sphere",
			Size = VT(0.5, 0, 0.5),
			Size2 = VT(LEVEL / 25, LEVEL * 5, LEVEL / 25),
			Transparency = 0.7,
			Transparency2 = 1,
			CFrame = CF(HITPOS) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)) * CF(0, 0, MRANDOM(3, 5 + LEVEL * 4)) * ANGLES(RAD(MRANDOM(-15, 15) * (LEVEL / 5)), RAD(0), RAD(MRANDOM(-15, 15) * (LEVEL / 5))),
			MoveToPos = nil,
			RotationX = 0,
			RotationY = MRANDOM(-1, 1) * 5,
			RotationZ = 0,
			Material = "Neon",
			Color = SKILLTEXTCOLOR,
			UseBoomerangMath = true,
			SizeBoomerang = 50,
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
	end
	unanchor()
	Humanoid.MaxHealth = "inf"
	Humanoid.Health = "inf"
	WING1.Enabled = true
	WING2.Enabled = true
	WING1.Acceleration = VT(0, 0, 1.5 * COS(SINE / 12))
	WING2.Acceleration = VT(0, 0, 1.5 * COS(SINE / 12))
	WING3.Enabled = true
	WING4.Enabled = true
	WING3.Acceleration = VT(0, 0, 1.5 * COS(SINE / 12))
	WING4.Acceleration = VT(0, 0, 1.5 * COS(SINE / 12))
	WING5.Enabled = true
	WING6.Enabled = true
	WING5.Acceleration = VT(0, 0, 1.5 * COS(SINE / 12))
	WING6.Acceleration = VT(0, 0, 1.5 * COS(SINE / 12))
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	refit()
	ApplyAoE(Torso.Position,10,0)
	if workspace:FindFirstChild("Holy Shields") == nil or not workspace:FindFirstChild("Holy Shields") then
		Shield = Instance.new ("MeshPart", workspace)
		Shield.Name = "Holy Shields"
		Shield.CanCollide = false
		Shield.Transparency = 0.999
		Shield.Material = "Neon"
		Shield.BrickColor = BrickColor.new("Gold")
		Shield.Size = Vector3.new(5,5,5)
		Shield.CFrame = Torso.CFrame
		local Wed = Instance.new("Weld", Shield)
		Wed.Part0 = Shield
		Wed.Part1 = Torso
	end
	for _, c in pairs(Character:GetChildren()) do
		if c.ClassName == "Part" then
			c.Material = "Neon"
			for _, q in pairs(c:GetChildren()) do
				if q.ClassName == "ParticleEmitter" and q.Name ~= "OVERLORDAURA" then
					q:remove()
				elseif q.ClassName == "Fire" then
					q:remove()
				end
			end
			if c.Transparency == 0 and c:FindFirstChild("OVERLORDAURA") == nil then
				local AURA = script.OVERLORDAURA:Clone()
				AURA.Parent = c
				AURA.Enabled = true
			end
			if c == Torso then
				c.Color = C3(1, 1, 1)
			elseif c == RightArm then
				c.Color = C3(0.9372549019607843, 0.7215686274509804, 0.2196078431372549)
			elseif c == LeftArm then
				c.Color = C3(0.9372549019607843, 0.7215686274509804, 0.2196078431372549)
			elseif c == RightLeg then
				c.Color = C3(0.7372549019607844, 0.6078431372549019, 0.36470588235294116)
			elseif c == LeftLeg then
				c.Color = C3(0.7372549019607844, 0.6078431372549019, 0.36470588235294116)
			elseif c == Head then
				c.Material = "Fabric"
			end
		elseif c.ClassName == "Shirt" or c.ClassName == "Pants" or c.ClassName == "CharacterMesh" or c.ClassName == "Accessory" or c.Name == "Body Colors" then
			c:remove()
		end
	end
	if Character:FindFirstChildOfClass("BoolValue") ~= nil then
		Character:FindFirstChildOfClass("BoolValue"):Destroy()	
	end
	LeftArm.Name = "Phaedra [ " .. MRANDOM(100000, 999999) .. " ]"
	RightArm.Name = "Phaedra [ " .. MRANDOM(100000, 999999) .. " ]"
	LeftLeg.Name = "Phaedra [ " .. MRANDOM(100000, 999999) .. " ]"
	RightLeg.Name = "Phaedra [ " .. MRANDOM(100000, 999999) .. " ]"
	Torso.Name = "Phaedra [ " .. MRANDOM(100000, 999999) .. " ]"
	Head.Name = "Phaedra [ " .. MRANDOM(100000, 999999) .. " ]"
	RootPart.Name = "Phaedra [ " .. MRANDOM(100000, 999999) .. " ]"
	script.Parent = WEAPONGUI
	Character.Parent = workspace
	Humanoid.Name = "PHAEDRA"
	Humanoid.DisplayDistanceType = "None"
	BMUSIC.SoundId = "rbxassetid://" .. SONGID
	BMUSIC.Looped = true
	BMUSIC.Pitch = PITCH
	BMUSIC.Volume = 10
	BMUSIC.Playing = true
	BMUSIC.EmitterSize = 35
	if BMUSIC.Parent ~= Character then
		print("Fixing music")
		BMUSIC = IT("Sound", Character)
		BMUSIC.SoundId = "rbxassetid://" .. SONGID
		BMUSIC.Looped = true
		BMUSIC.Pitch = PITCH
		BMUSIC.Volume = 10
		BMUSIC.Playing = true
		BMUSIC.EmitterSize = 25
		BMUSIC.TimePosition = TIMESTAMP
		FIXING = true
	elseif FIXING == false then
		TIMESTAMP = BMUSIC.TimePosition
	else
		FIXING = false
	end

	Humanoid.HipHeight = 4
	Humanoid.PlatformStand = false
	for _, c in pairs(Character:GetChildren()) do
		if c.ClassName == "Part" then
			if c:FindFirstChildOfClass("BodyPosition") then
				c:FindFirstChildOfClass("BodyPosition"):remove()
			end
			for _, c in pairs(Character:GetChildren()) do
				if c.ClassName == "Part" then
					if c:FindFirstChildOfClass("BodyGyro") then
						c:FindFirstChildOfClass("BodyGyro"):remove()
					end
					for _, c in pairs(Character:GetChildren()) do
						if c.ClassName == "Part" then
							if c:FindFirstChildOfClass("BodyVelocity") then
								c:FindFirstChildOfClass("BodyVelocity"):remove()
								for _, c in pairs(Character:GetChildren()) do
									if c.ClassName == "Part" then
										if c:FindFirstChildOfClass("ParticleEmitter") then
											c:FindFirstChildOfClass("ParticleEmitter"):remove()
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end