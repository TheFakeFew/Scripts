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

local loaded = LoadAssets(13233384945)
local assets = loaded:Get("ZenAssets")
for i,v in next, assets:GetChildren() do
	v.Parent = script
end

Player = game:GetService("Players").LocalPlayer
Mouse = Player:GetMouse()
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = Player.Character
Humanoid = Character.Humanoid
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
local sick = Instance.new("Sound", Torso)
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
local Speed = 16
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local MELEE = false
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
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "Weapon GUI"
local Effects = IT("Folder", Character)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
local UNANCHOR = true
local HITPLAYERSOUNDS = {
	"263032172",
	"263032182",
	"263032200",
	"263032221",
	"263032252",
	"263033191"
}
local EXTRATRANS = 0
local DASHING = false
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
		game:GetService("RunService").Heartbeat:wait()
	else
		for i = 1, NUMBER do
			game:GetService("RunService").Heartbeat:wait()
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
	local NEWSOUND
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id=" .. ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat
				wait(1)
			until NEWSOUND.Playing == false or NEWSOUND.Parent ~= PARENT
			NEWSOUND.Playing = false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end
function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end
function WACKYEFFECT(Table)
	local TYPE = Table.EffectType or "Sphere"
	local SIZE = Table.Size or VT(1, 1, 1)
	local ENDSIZE = Table.Size2 or VT(0, 0, 0)
	local TRANSPARENCY = Table.Transparency or 0
	local ENDTRANSPARENCY = Table.Transparency2 or 1
	local CFRAME = Table.CFrame or Torso.CFrame
	local MOVEDIRECTION = Table.MoveToPos or nil
	local ROTATION1 = Table.RotationX or 0
	local ROTATION2 = Table.RotationY or 0
	local ROTATION3 = Table.RotationZ or 0
	local MATERIAL = Table.Material or "Neon"
	local COLOR = Table.Color or C3(1, 1, 1)
	local TIME = Table.Time or 45
	local SOUNDID = Table.SoundID or nil
	local SOUNDPITCH = Table.SoundPitch or nil
	local SOUNDVOLUME = Table.SoundVolume or nil
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
		elseif TYPE == "Block" then
			MSH = IT("BlockMesh", EFFECT)
			MSH.Scale = VT(SIZE.X, SIZE.X, SIZE.X)
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0, 0, -SIZE.X / 8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X, SIZE.X, 0.1), VT(0, 0, 0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0, 0, 0))
		end
		if MSH ~= nil then
			local MOVESPEED
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude / TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
			else
				EFFECT.CFrame = CFRAME
			end
			for LOOP = 1, TIME + 1 do
				Swait()
				MSH.Scale = MSH.Scale - GROWTH / TIME
				if TYPE == "Wave" then
					MSH.Offset = VT(0, 0, -MSH.Scale.X / 8)
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
					EFFECT.Orientation = ORI
				end
			end
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat
					Swait()
				until SOUND.Playing == false
				EFFECT:remove()
			end
		elseif PLAYSSOUND == false then
			EFFECT:remove()
		else
			repeat
				Swait()
			until SOUND.Playing == false
			EFFECT:remove()
		end
	end))
end
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
Debris = game:GetService("Debris")
function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos, EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end
function turnto(position)
	RootPart.CFrame = CFrame.new(RootPart.CFrame.p, VT(position.X, RootPart.Position.Y, position.Z)) * CFrame.new(0, 0, 0)
end
function WaveParticles(Position, Size, Color)
	local BASE = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "Shockwave", VT(0, 0, 0), true)
	BASE.CFrame = CF(Position)
	local A = IT("Attachment", BASE)
	local WAVE = script.Wave:Clone()
	WAVE.Parent = A
	WAVE.Size = NumberSequence.new(0, Size)
	WAVE.Color = ColorSequence.new(Color)
	Debris:AddItem(BASE, 0.5)
	WAVE:Emit(1)
end
for _, c in pairs(Character:GetChildren()) do
	if script:FindFirstChild(c.Name) then
		local Part = script[c.Name]
		Part.Parent = Character
		Part.Base.Anchored = false
		Part:SetPrimaryPartCFrame(c.CFrame)
		weldBetween(c, Part.Base)
		for _, e in pairs(Part:GetChildren()) do
			if e:IsA("BasePart") and e.Name ~= "Base" then
				e.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
				e.Locked = true
				e.Anchored = false
				e.Parent = Character
				weldBetween(c, e)
			end
		end
		Part:remove()
	end
end
--local WINGPART = script.Wing
--WINGPART.Parent = nil
local Weapon = script.Weapon
Weapon.Parent = Character
local Grip = CreateWeldOrSnapOrMotor("Weld", RightArm, RightArm, Weapon.Bostaff, CF(0, -1, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)), CF(0, 0, 0))
for _, c in pairs(Character:GetChildren()) do
	if c.ClassName == "Part" and c.Name ~= "Eye" then
		c.Material = "SmoothPlastic"
		if c:FindFirstChildOfClass("ParticleEmitter") then
			c:FindFirstChildOfClass("ParticleEmitter"):remove()
		end
		if c == LeftLeg or c == RightLeg then
			c.Color = C3(0.12, 0.12, 0.12)
		elseif c == Torso then
			c.Color = C3(0.15, 0.15, 0.15)
		else
			c.BrickColor = BRICKC("Bright yellow")
		end
		if c == Head and c:FindFirstChild("face") then
			c.face:remove()
		end
	elseif c.ClassName == "CharacterMesh" or c.ClassName == "Accessory" or c.Name == "Body Colors" then
		c:remove()
	elseif (c.ClassName == "Shirt" or c.ClassName == "Pants") and c.Name ~= "Cloth" then
		c:remove()
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
			c.Transparency
		})
	elseif c:IsA("JointInstance") then
		table.insert(BODY, {
			c,
			c.Parent,
			nil,
			nil,
			nil
		})
	end
end
for e = 1, #BODY do
	if BODY[e] ~= nil then
		do
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
				pcall(function()
					PART.Parent = PARENT
				end)
			end)
		end
	end
end
local humclone = Humanoid:Clone()
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
				PART.Transparency = TRANSPARENCY + EXTRATRANS
			end
			if PART.Parent ~= PARENT then
				Humanoid:remove()
				pcall(function()
					PART.Parent = PARENT
				end)
				Humanoid = humclone:Clone()
				Humanoid.Parent = Character
			end
		end
	end
end
Player.CharacterAdded:Connect(function()
	script:remove()
	Character:Destroy()
end)
Humanoid.Died:connect(function()
	refit()
end)
local SKILLTEXTCOLOR = C3(1, 1, 1)
local SKILLFONT = "Fantasy"
local SKILLTEXTSIZE = 5
local MOBILITY = {
	"Z",
	"B",
	"C",
	"G",
	"H"
}
local ATTACKS = {
	"Mouse",
	"Q",
	"E",
	"V"
}
local MOBILITYFRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.71, 0, 0.9, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Skill Frame")
local TEXT = CreateLabel(MOBILITYFRAME, "[MOBILITY]", SKILLTEXTCOLOR, SKILLTEXTSIZE + 1, SKILLFONT, 0, 2, 0.5, "Skill text")
local ATTACKSFRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.8, 0, 0.9, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Skill Frame")
local TEXT = CreateLabel(ATTACKSFRAME, "[ATTACKS]", SKILLTEXTCOLOR, SKILLTEXTSIZE + 1, SKILLFONT, 0, 2, 0.5, "Skill text")
for i = 1, #MOBILITY do
	local SKILLFRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.71, 0, 0.9 - 0.04 * i, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Skill Frame")
	local SKILLTEXT = CreateLabel(SKILLFRAME, "[" .. MOBILITY[i] .. "]", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0.5, "Skill text")
end
for i = 1, #ATTACKS do
	local SKILLFRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.8, 0, 0.9 - 0.04 * i, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Skill Frame")
	local SKILLTEXT = CreateLabel(SKILLFRAME, "[" .. ATTACKS[i] .. "]", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0.5, "Skill text")
end
function ApplyDamage(Humanoid, Damage)
	Damage = Damage * DAMAGEMULTIPLIER
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
function ApplyAoE(POSITION, RANGE, MINDMG, MAXDMG, FLING, INSTAKILL, STUN)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					if INSTAKILL == true then
						CHILD:BreakJoints()
					else
						local DMG = MRANDOM(MINDMG, MAXDMG)
						ApplyDamage(HUM, DMG)
					end
					if STUN == true then
						TORSO.CFrame = TORSO.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
					end
					if FLING ~= 0 then
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
function APPLYMELEE(PART, MINDMG, MAXDMG, CANSTUN)
	local HITS = {}
	local TOUCH = PART.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChildOfClass("Humanoid") then
			local HUM = hit.Parent:FindFirstChildOfClass("Humanoid")
			local TORSO = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")
			if TORSO and HUM.Health > 0 then
				local PASS = true
				for i = 1, #HITS do
					if HITS[i] == hit.Parent then
						PASS = false
					end
				end
				table.insert(HITS, hit.Parent)
				if PASS == true then
					for i = 1, 3 do
						WACKYEFFECT({
							Time = 15,
							EffectType = "Sphere",
							Size = VT(0.3, 0.3, 0.3),
							Size2 = VT(0, 25, 0),
							Transparency = 0,
							Transparency2 = 1,
							CFrame = CF(TORSO.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
							MoveToPos = nil,
							RotationX = 0,
							RotationY = MRANDOM(-35, 35),
							RotationZ = 0,
							Material = "Glass",
							Color = C3(0.3, 0, 0),
							SoundID = nil,
							SoundPitch = MRANDOM(7, 15) / 10,
							SoundVolume = 10
						})
					end
					ApplyDamage(HUM, MRANDOM(MINDMG, MAXDMG), TORSO, CANSTUN)
					CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], TORSO, 2, MRANDOM(8, 12) / 10, false)
				end
			end
		end
	end)
	return TOUCH
end
function Mobility(CFR)
	Weapon.TrailBlade.Trail.Enabled = false
	local POS = RootPart.Position
	EXTRATRANS = 1
	DASHING = true
	WACKYEFFECT({
		Time = 35,
		EffectType = "Sphere",
		Size = VT(5, 5, 5),
		Size2 = VT(12, 12, 12),
		Transparency = 0,
		Transparency2 = 1,
		CFrame = CF(POS),
		MoveToPos = nil,
		RotationX = 0,
		RotationY = 0,
		RotationZ = 0,
		Material = "Neon",
		Color = C3(1, 1, 1),
		SoundID = 182765513,
		SoundPitch = 1,
		SoundVolume = 3
	})
	repeat
		RootPart.CFrame = RootPart.CFrame * CFR
		for i = 1, 5 do
			WACKYEFFECT({
				Time = MRANDOM(10, 40),
				EffectType = "Sphere",
				Size = VT(2, 2, 0.7),
				Size2 = VT(0, 0, 10),
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(CF(POS) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 0, 2).p, RootPart.Position),
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
		end
		WACKYEFFECT({
			Time = 15,
			EffectType = "Wave",
			Size = VT(6, 8, 6),
			Size2 = VT(0, 4, 0),
			Transparency = 1,
			Transparency2 = 0.8,
			CFrame = CF(RootPart.Position, POS) * ANGLES(RAD(-90), RAD(0), RAD(0)),
			MoveToPos = CF(RootPart.Position, POS) * CF(0, 0, -35).p,
			RotationX = 0,
			RotationY = 0,
			RotationZ = 0,
			Material = "Neon",
			Color = C3(1, 1, 1),
			SoundID = nil,
			SoundPitch = nil,
			SoundVolume = nil
		})
		POS = RootPart.Position
		local bv = Instance.new("BodyVelocity", RootPart)
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = VT(0, 0, 0)
		Debris:AddItem(bv, .1)
		Swait()
	until KEYHOLD == false or ATTACK == true or MELEE == true
	EXTRATRANS = 0
	DASHING = false
	WACKYEFFECT({
		Time = 35,
		EffectType = "Sphere",
		Size = VT(5, 5, 5),
		Size2 = VT(12, 12, 12),
		Transparency = 0,
		Transparency2 = 1,
		CFrame = CF(POS),
		MoveToPos = nil,
		RotationX = 0,
		RotationY = 0,
		RotationZ = 0,
		Material = "Neon",
		Color = C3(1, 1, 1),
		SoundID = 182765513,
		SoundPitch = 1,
		SoundVolume = 3
	})
	local bv = Instance.new("BodyVelocity", RootPart)
	bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	bv.Velocity = VT(0, 0, 0)
	Debris:AddItem(bv, .1)
	Weapon.TrailBlade.Trail.Enabled = true
end
function Clicks()
	MELEE = true
	Weapon.MainBlade.CanCollide = true
	repeat
		if COMBO == 1 and ATTACK == false then
			COMBO = 2
			for i = 0, 0.15, 0.1 / Animation_Speed do
				Swait()
				if ATTACK == true then
					break
				end
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-45)), 2 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(40)), 2 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15, 0.5, -0.5) * ANGLES(RAD(90), RAD(0), RAD(0)) * ANGLES(RAD(0), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 2 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 2 / Animation_Speed)
			end
			CreateSound(143501853, Weapon.TrailBlade, 2, MRANDOM(8, 13) / 10, false)
			local DMGER = APPLYMELEE(Weapon.MainBlade, 8, 12, false)
			for i = 0, 0.4, 0.1 / Animation_Speed do
				Swait()
				if ATTACK == true then
					break
				end
				Grip.C1 = Clerp(Grip.C1, CF(0, -1, 0.35) * ANGLES(RAD(80), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(80)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-50)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			DMGER:Disconnect()
		elseif COMBO == 2 and ATTACK == false then
			COMBO = 3
			local DMGER = APPLYMELEE(Weapon.MainBlade, 25, 35, false)
			CreateSound(134012322, Weapon.TrailBlade, 4, MRANDOM(8, 13) / 10, false)
			for i = 1, 15 do
				Swait()
				if ATTACK == true then
					break
				end
				RootPart.CFrame = RootPart.CFrame * CF(0, 0, -0.02)
				Grip.C1 = Clerp(Grip.C1, CF(0, 1, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(80 - i * 24)), 2.5 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(30), RAD(0), RAD(0)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(0), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.25, -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			DMGER:Disconnect()
		elseif COMBO == 3 and ATTACK == false then
			COMBO = 1
			for i = 0, 0.5, 0.1 / Animation_Speed do
				Swait()
				if ATTACK == true then
					break
				end
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(60), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)), 2 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(25)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(45)) * ANGLES(RAD(0), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			CreateSound(143501853, Weapon.TrailBlade, 2, MRANDOM(8, 13) / 10, false)
			local DMGER = APPLYMELEE(Weapon.MainBlade, 10, 15, false)
			for i = 0, 0.6, 0.1 / Animation_Speed do
				Swait()
				if ATTACK == true then
					break
				end
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(55), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(80)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-40)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(0)) * ANGLES(RAD(0), RAD(120), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(5), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			DMGER:Disconnect()
		end
	until HOLD == false or ATTACK == true
	if COMBO == 2 and ATTACK == false then
		for i = 0, 0.5, 0.1 / Animation_Speed do
			Swait()
			if ATTACK == true then
				break
			end
			Grip.C1 = Clerp(Grip.C1, CF(0, -1, 0.35) * ANGLES(RAD(80), RAD(0), RAD(0)), 1 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(80)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-50)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	end
	Weapon.MainBlade.CanCollide = false
	coroutine.resume(coroutine.create(function()
		for i = 1, 50 do
			Swait()
			if MELEE == true then
				break
			end
		end
		if MELEE == false then
			COMBO = 1
		end
	end))
	MELEE = false
end
function Aerial()
	ATTACK = true
	Rooted = false
	local DMGER = APPLYMELEE(Weapon.MainBlade, 35, 45, false)
	CreateSound(134012322, Weapon.TrailBlade, 4, MRANDOM(8, 13) / 10, false)
	for i = 1, 12 do
		Swait()
		Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(-i * 36)), 2 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(-65)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	DMGER:Disconnect()
	ATTACK = false
	Rooted = false
end
function ZenBullet()
	ATTACK = true
	Rooted = true
	if MELEE == true then
		do
			local POS = RootPart.CFrame * CF(0, 5, -1)
			UNANCHOR = false
			local BULLET = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "Bullet", VT(2, 2, 2), true)
			MakeForm(BULLET, "Ball")
			for i = 1, 15 do
				Swait()
				BULLET.CFrame = LeftArm.CFrame * CF(0, -1, 0)
				BULLET.Transparency = BULLET.Transparency - 0.06666666666666667
				RootPart.CFrame = Clerp(RootPart.CFrame, POS, 0.3)
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(30), RAD(0), RAD(25)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(165), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.1, -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			coroutine.resume(coroutine.create(function()
				wait(0.5)
				BULLET.CFrame = CF(BULLET.Position, BULLET.Position - VT(0, 2, 0))
				BULLET.Size = VT(1.5, 1.5, 3)
				WACKYEFFECT({
					Time = 15,
					EffectType = "Wave",
					Size = VT(0, 1, 0),
					Size2 = VT(15, 1, 15),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = CF(BULLET.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Fabric",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
				for i = 1, 50 do
					Swait()
					BULLET.CFrame = BULLET.CFrame * CF(0, 0, -2)
					local HIT, HITPOS = Raycast(BULLET.Position, BULLET.CFrame.lookVector, 2.5, Character)
					if HIT then
						break
					end
				end
				ApplyAoE(BULLET.Position, 20, 25, 25, 70, false)
				WACKYEFFECT({
					Time = 15,
					EffectType = "Wave",
					Size = VT(0, 1, 0),
					Size2 = VT(45, 2, 45),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = CF(BULLET.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 5,
					RotationZ = 0,
					Material = "Fabric",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
				WACKYEFFECT({
					Time = 25,
					EffectType = "Sphere",
					Size = BULLET.Size,
					Size2 = VT(35, 35, 35),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = CF(BULLET.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = 424195952,
					SoundPitch = 1,
					SoundVolume = 5
				})
				BULLET:remove()
			end))
			for i = 0, 0.3, 0.1 / Animation_Speed do
				Swait()
				RootPart.CFrame = Clerp(RootPart.CFrame, POS, 0.3)
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(30), RAD(0), RAD(25)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.1, -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			UNANCHOR = true
		end
	else
		do
			local GYRO = IT("BodyGyro", RootPart)
			GYRO.D = 2
			GYRO.P = 2000
			GYRO.MaxTorque = VT(0, 4000000, 0)
			coroutine.resume(coroutine.create(function()
				repeat
					Swait()
					GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
				until ATTACK == false
				GYRO:Remove()
			end))
			local BULLET = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "Bullet", VT(2, 2, 2), true)
			MakeForm(BULLET, "Ball")
			for i = 1, 15 do
				Swait()
				BULLET.CFrame = LeftArm.CFrame * CF(0, -1, 0)
				BULLET.Transparency = BULLET.Transparency - 0.06666666666666667
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(-25)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(95), RAD(0), RAD(15)) * ANGLES(RAD(0), RAD(45), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0.2) * ANGLES(RAD(-45), RAD(0), RAD(-45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(60), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			coroutine.resume(coroutine.create(function()
				BULLET.CFrame = CF(BULLET.Position, Mouse.Hit.p)
				wait(0.5)
				BULLET.Size = VT(1.5, 1.5, 3)
				WACKYEFFECT({
					Time = 15,
					EffectType = "Wave",
					Size = VT(0, 1, 0),
					Size2 = VT(15, 1, 15),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = BULLET.CFrame * ANGLES(RAD(90), RAD(0), RAD(0)),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Fabric",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
				for i = 1, 170 do
					Swait()
					BULLET.CFrame = BULLET.CFrame * CF(0, 0, -2)
					local HIT, HITPOS = Raycast(BULLET.Position, BULLET.CFrame.lookVector, 2.5, Character)
					if HIT then
						break
					end
				end
				ApplyAoE(BULLET.Position, 30, 25, 25, 70, false)
				WACKYEFFECT({
					Time = 15,
					EffectType = "Wave",
					Size = VT(0, 1, 0),
					Size2 = VT(70, 2, 70),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = CF(BULLET.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 5,
					RotationZ = 0,
					Material = "Fabric",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
				WACKYEFFECT({
					Time = 25,
					EffectType = "Sphere",
					Size = BULLET.Size,
					Size2 = VT(60, 60, 60),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = CF(BULLET.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = 424195952,
					SoundPitch = 1,
					SoundVolume = 5
				})
				for i = 1, 10 do
					WACKYEFFECT({
						Time = 25 + i * 3,
						EffectType = "Wave",
						Size = VT(0, 0, 0),
						Size2 = VT(150, 1, 150),
						Transparency = 0.8,
						Transparency2 = 1,
						CFrame = CF(BULLET.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
						MoveToPos = nil,
						RotationX = 0.2,
						RotationY = 5,
						RotationZ = 0,
						Material = "Neon",
						Color = C3(1, 1, 1),
						SoundID = nil,
						SoundPitch = MRANDOM(9, 11) / 10,
						SoundVolume = MRANDOM(9, 11) / 2
					})
				end
				BULLET:remove()
			end))
			for i = 1, 15 do
				Swait()
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-45)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(45)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(95), RAD(0), RAD(15)) * ANGLES(RAD(0), RAD(45), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0.2) * ANGLES(RAD(45), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(60), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
		end
	end
	ATTACK = false
	Rooted = false
end
function Jab()
	ATTACK = true
	Rooted = true
	local SLASHSOUNDS = {
		"28144268",
		"28144277",
		"28144291"
	}
	if MELEE == true then
		for i = 0, 0.8, 0.1 / Animation_Speed do
			Swait()
			Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-75)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(75)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		for i = 1, 8 do
			for i = 1, 2 do
				Swait()
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(-80), RAD(0), RAD(0)), 3 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-75)), 3 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(75)), 3 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 3 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 3 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 3 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 3 / Animation_Speed)
			end
			local OFFSET1 = MRANDOM(-35, 35) / 2
			local OFFSET2 = MRANDOM(-35, 35) / 2
			for i = 0, 0.1, 0.1 / Animation_Speed do
				Swait()
				RootPart.CFrame = RootPart.CFrame * CF(0, 0, -0.2)
				Grip.C1 = Clerp(Grip.C1, CF(0, -1, 0.35) * ANGLES(RAD(80), RAD(0), RAD(0)), 2.7 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(90)), 2.7 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 2.7 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(OFFSET2), RAD(0), RAD(90 + OFFSET1)) * RIGHTSHOULDERC0, 2.7 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2.7 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 2.7 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 2.7 / Animation_Speed)
			end
			for i = 1, 5 do
				ApplyAoE(CF(RootPart.Position, Weapon.TrailBlade.Position) * CF(0, 0, -i * 3).p, 5, 2, 7, 0, false, true)
			end
			WACKYEFFECT({
				Time = 20,
				EffectType = "Wave",
				Size = VT(1, 1, 1),
				Size2 = VT(15, 5, 15),
				Transparency = 0.4,
				Transparency2 = 1,
				CFrame = RootPart.CFrame * CF(0, 0, -5) * ANGLES(RAD(-90), RAD(0), RAD(0)),
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 5,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 15,
				EffectType = "Sphere",
				Size = VT(1, 1, 15) / 1.1,
				Size2 = VT(2, 2, 25) / 1.1,
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(RootPart.Position, Weapon.TrailBlade.Position),
				MoveToPos = CF(RootPart.Position, Weapon.TrailBlade.Position) * CF(0, 0, -35).p,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 15,
				EffectType = "Sphere",
				Size = VT(1, 1, 15),
				Size2 = VT(2, 2, 25),
				Transparency = 0.7,
				Transparency2 = 1,
				CFrame = CF(RootPart.Position, Weapon.TrailBlade.Position),
				MoveToPos = CF(RootPart.Position, Weapon.TrailBlade.Position) * CF(0, 0, -35).p,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 0.9, 0.9),
				SoundID = SLASHSOUNDS[MRANDOM(1, #SLASHSOUNDS)],
				SoundPitch = 1,
				SoundVolume = 4
			})
		end
	else
		for i = 0, 1, 0.1 / Animation_Speed do
			Swait()
			Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-75)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(75)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		for i = 1, 4 do
			for i = 1, 2 do
				Swait()
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(-80), RAD(0), RAD(0)), 3 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-75)), 3 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(75)), 3 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 3 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 3 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 3 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 3 / Animation_Speed)
			end
			local OFFSET1 = MRANDOM(-35, 35) / 2
			local OFFSET2 = MRANDOM(-35, 35) / 2
			for i = 0, 0.1, 0.1 / Animation_Speed do
				Swait()
				Grip.C1 = Clerp(Grip.C1, CF(0, -1, 0.35) * ANGLES(RAD(80), RAD(0), RAD(0)), 2.7 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(90)), 2.7 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 2.7 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(OFFSET2), RAD(0), RAD(90 + OFFSET1)) * RIGHTSHOULDERC0, 2.7 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2.7 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 2.7 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 2.7 / Animation_Speed)
			end
			for i = 1, 5 do
				ApplyAoE(CF(RootPart.Position, Weapon.TrailBlade.Position) * CF(0, 0, -i * 3).p, 5, 2, 7, 0, false, true)
			end
			WACKYEFFECT({
				Time = 20,
				EffectType = "Wave",
				Size = VT(1, 1, 1),
				Size2 = VT(15, 5, 15),
				Transparency = 0.4,
				Transparency2 = 1,
				CFrame = RootPart.CFrame * CF(0, 0, -5) * ANGLES(RAD(-90), RAD(0), RAD(0)),
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 5,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 15,
				EffectType = "Sphere",
				Size = VT(1, 1, 15) / 1.1,
				Size2 = VT(2, 2, 25) / 1.1,
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(RootPart.Position, Weapon.TrailBlade.Position),
				MoveToPos = CF(RootPart.Position, Weapon.TrailBlade.Position) * CF(0, 0, -35).p,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 15,
				EffectType = "Sphere",
				Size = VT(1, 1, 15),
				Size2 = VT(2, 2, 25),
				Transparency = 0.7,
				Transparency2 = 1,
				CFrame = CF(RootPart.Position, Weapon.TrailBlade.Position),
				MoveToPos = CF(RootPart.Position, Weapon.TrailBlade.Position) * CF(0, 0, -35).p,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 0.9, 0.9),
				SoundID = SLASHSOUNDS[MRANDOM(1, #SLASHSOUNDS)],
				SoundPitch = 1,
				SoundVolume = 4
			})
		end
		for i = 1, 50 do
			Swait()
			WACKYEFFECT({
				Time = 10,
				EffectType = "Sphere",
				Size = VT(1, 1, 1),
				Size2 = VT(0, 0, 0),
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(Weapon.TrailBlade.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 0, 5),
				MoveToPos = Weapon.TrailBlade.Position,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(-80), RAD(0), RAD(0)), 0.2 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-75)), 0.2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(75)), 0.2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 0.2 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(100), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 0.2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		end
		Grip.C1 = CF(0, -1, 0.35) * ANGLES(RAD(80), RAD(0), RAD(0))
		RootJoint.C0 = ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(90))
		Neck.C0 = NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90))
		RightShoulder.C0 = CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0
		LeftShoulder.C0 = CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0
		RightHip.C0 = CF(1, -1, 0) * ANGLES(RAD(0), RAD(50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0))
		LeftHip.C0 = CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0))
		do
			local OFFSET = -8
			local HITS = {}
			for i = 1, 5 do
				WACKYEFFECT({
					Time = 35,
					EffectType = "Wave",
					Size = VT(1, 1, 1),
					Size2 = VT(35 - i * 3, 5, 35 - i * 3),
					Transparency = 0.4,
					Transparency2 = 1,
					CFrame = RootPart.CFrame * CF(0, 0, -5) * ANGLES(RAD(-90), RAD(0), RAD(0)),
					MoveToPos = RootPart.CFrame * CF(0, 0, -5 - i * 6).p,
					RotationX = 0,
					RotationY = 5,
					RotationZ = 0,
					Material = "Neon",
					Color = C3(1, 1, 1),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
			end
			WACKYEFFECT({
				Time = 25,
				EffectType = "Sphere",
				Size = VT(1, 1, 15) / 1.1,
				Size2 = VT(8, 8, 45) / 1.1,
				Transparency = 0,
				Transparency2 = 1,
				CFrame = CF(RootPart.Position, Weapon.TrailBlade.Position),
				MoveToPos = CF(RootPart.Position, Weapon.TrailBlade.Position) * CF(0, 0, -35).p,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			WACKYEFFECT({
				Time = 25,
				EffectType = "Sphere",
				Size = VT(1, 1, 15),
				Size2 = VT(8, 8, 45),
				Transparency = 0.7,
				Transparency2 = 1,
				CFrame = CF(RootPart.Position, Weapon.TrailBlade.Position),
				MoveToPos = CF(RootPart.Position, Weapon.TrailBlade.Position) * CF(0, 0, -35).p,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 0.9, 0.9),
				SoundID = SLASHSOUNDS[MRANDOM(1, #SLASHSOUNDS)],
				SoundPitch = 1,
				SoundVolume = 4
			})
			for _, c in pairs(workspace:GetDescendants()) do
				if c.ClassName == "Model" and c ~= Character and c:FindFirstChildOfClass("Humanoid") and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")) then
					local HUMANOID = c:FindFirstChildOfClass("Humanoid")
					local TORSO = c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
					if 15 > (TORSO.Position - RootPart.CFrame * CF(0, 0, -7).p).Magnitude then
						table.insert(HITS, {
							c,
							TORSO,
							HUMANOID
						})
					end
				end
			end
			local DONE = false
			if #HITS > 0 then
				coroutine.resume(coroutine.create(function()
					local POS = RootPart.CFrame * CF(0, 0, -7).p
					for i = 1, #HITS do
						local ITEMS = HITS[i]
						local BODY = ITEMS[1]
						local TORSO = ITEMS[2]
						local HUMAN = ITEMS[3]
						HUMAN.PlatformStand = true
						--script.BodyForce:Clone().Parent = TORSO
					end
					repeat
						wait()
					until DONE == true
					for i = 1, 10 do
						WACKYEFFECT({
							Time = 55 + i * 3,
							EffectType = "Wave",
							Size = VT(0, 0, 0),
							Size2 = VT(250, 1, 250),
							Transparency = 0.6,
							Transparency2 = 1,
							CFrame = CF(POS) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))),
							MoveToPos = nil,
							RotationX = 0.2,
							RotationY = 5,
							RotationZ = 0,
							Material = "Neon",
							Color = C3(1, 0.9, 0.9),
							SoundID = nil,
							SoundPitch = MRANDOM(9, 11) / 10,
							SoundVolume = MRANDOM(9, 11) / 2
						})
					end
					for i = 1, 5 do
						WACKYEFFECT({
							Time = 70,
							EffectType = "Sphere",
							Size = VT(70 - i * 3, 0, 70 - i * 3),
							Size2 = VT(100 - i * 5, 2, 100 - i * 5),
							Transparency = 0,
							Transparency2 = 1,
							CFrame = CF(POS - VT(0, 5.3 - i * 2, 0)),
							MoveToPos = nil,
							RotationX = 0,
							RotationY = 0,
							RotationZ = 0,
							Material = "Neon",
							Color = C3(1, 0.95, 0.95),
							SoundID = nil,
							SoundPitch = nil,
							SoundVolume = nil
						})
					end
					WACKYEFFECT({
						Time = 70,
						EffectType = "Sphere",
						Size = VT(45, 45, 45),
						Size2 = VT(60, 60, 60),
						Transparency = 0,
						Transparency2 = 1,
						CFrame = CF(POS),
						MoveToPos = nil,
						RotationX = 0,
						RotationY = 0,
						RotationZ = 0,
						Material = "Neon",
						Color = C3(1, 1, 1),
						SoundID = 461105534,
						SoundPitch = 1,
						SoundVolume = 10
					})
					for i = 1, #HITS do
						local ITEMS = HITS[i]
						local BODY = ITEMS[1]
						local TORSO = ITEMS[2]
						TORSO:ClearAllChildren()
						BODY:BreakJoints()
					end
					ApplyAoE(POS, 40, 60, 85, 250, false, false)
				end))
			end
			for i = 1, 100 do
				Swait()
				OFFSET = OFFSET + 0.15
				if OFFSET >= 0 then
					OFFSET = 0
				end
				RootPart.CFrame = RootPart.CFrame * CF(0, 0, OFFSET)
				Grip.C1 = Clerp(Grip.C1, CF(0, -1, 0.35) * ANGLES(RAD(80), RAD(0), RAD(0)), 2.7 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(90)), 2.7 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-90)), 2.7 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * RIGHTSHOULDERC0, 2.7 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2.7 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 2.7 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 2.7 / Animation_Speed)
			end
			if #HITS > 0 then
				for i = 1, 65 do
					Swait()
					Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-i * 25)), 1 / Animation_Speed)
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(40), RAD(0), RAD(0)), 0.2 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(160), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 0.2 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
				for i = 0, 0.2, 0.1 / Animation_Speed do
					Swait()
					Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(0)), 1 / Animation_Speed)
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-15)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(15)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(45), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
				DONE = true
				for i = 0, 0.7, 0.1 / Animation_Speed do
					Swait()
					Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(0)), 1 / Animation_Speed)
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-15)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(15)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(45), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
			end
		end
	end
	ATTACK = false
	Rooted = false
end
function taunt()
	Rooted = true
	ATTACK = true
	for i = 1, 65 do
		Swait()
		Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-i * 25)), 1 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(40), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(160), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 0.2 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	for i = 0, 0.2, 0.1 / Animation_Speed do
		Swait()
		Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(0)), 1 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-15)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(15)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(45), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	for i = 0, 0.7, 0.1 / Animation_Speed do
		Swait()
		Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(0)), 1 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-15)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(15)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(45), RAD(0), RAD(45)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-50), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end
function CorruptBullet()
	ATTACK = true
	Rooted = true
	if MELEE == true then
		do
			local POS = RootPart.CFrame * CF(0, 45, -1)
			UNANCHOR = false
			local BULLET = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "Bullet", VT(2, 2, 2), true)
			BULLET.Color = C3(0, 0, 0)
			MakeForm(BULLET, "Ball")
			for i = 1, 15 do
				Swait()
				BULLET.CFrame = LeftArm.CFrame * CF(0, -1, 0)
				BULLET.Transparency = BULLET.Transparency - 0.06666666666666667
				RootPart.CFrame = Clerp(RootPart.CFrame, POS, 0.3)
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(30), RAD(0), RAD(25)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(165), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.1, -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			coroutine.resume(coroutine.create(function()
				BULLET.CFrame = CF(BULLET.Position, BULLET.Position - VT(0, 2, 0))
				BULLET.Size = VT(1.5, 1.5, 3)
				WACKYEFFECT({
					Time = 15,
					EffectType = "Wave",
					Size = VT(0, 1, 0),
					Size2 = VT(15, 1, 15),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = CF(BULLET.Position),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Fabric",
					Color = C3(0, 0, 0),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
				for i = 1, 50 do
					Swait()
					BULLET.CFrame = BULLET.CFrame * CF(0, 0, -2)
					local HIT, HITPOS = Raycast(BULLET.Position, BULLET.CFrame.lookVector, 2.5, Character)
					if HIT then
						break
					end
				end
				BULLET:remove()
				for i = 1, 5 do
					WACKYEFFECT({
						Time = 15,
						EffectType = "Sphere",
						Size = VT(80, 80, 80),
						Size2 = VT(35, 35, 35),
						Transparency = 0.9,
						Transparency2 = 1,
						CFrame = CF(BULLET.Position),
						MoveToPos = nil,
						RotationX = 0,
						RotationY = 5,
						RotationZ = 0,
						Material = "Neon",
						Color = C3(0, 0, 0),
						SoundID = 84005018,
						SoundPitch = 1,
						SoundVolume = 4
					})
					ApplyAoE(BULLET.Position, 40, 0, 0, -75, false, false)
					for i = 1, 30 do
						WACKYEFFECT({
							Time = 15,
							EffectType = "Sphere",
							Size = VT(42, 42, 42) / (1 + 0.3 * SIN(i / 6)),
							Size2 = VT(35, 35, 35) / (1 + 0.3 * SIN(i / 3)),
							Transparency = 0.8,
							Transparency2 = 1,
							CFrame = CF(BULLET.Position),
							MoveToPos = nil,
							RotationX = 0,
							RotationY = 5,
							RotationZ = 0,
							Material = "Neon",
							Color = C3(0, 0, 0),
							SoundID = nil,
							SoundPitch = nil,
							SoundVolume = nil
						})
						Swait()
						ApplyAoE(BULLET.Position, 10, 3, 3, 0, false, false)
					end
				end
			end))
			for i = 0, 0.3, 0.1 / Animation_Speed do
				Swait()
				RootPart.CFrame = Clerp(RootPart.CFrame, POS, 0.3)
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(30), RAD(0), RAD(25)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(15), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.1, -0.6) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			UNANCHOR = true
		end
	else
		do
			local GYRO = IT("BodyGyro", RootPart)
			GYRO.D = 2
			GYRO.P = 2000
			GYRO.MaxTorque = VT(0, 4000000, 0)
			coroutine.resume(coroutine.create(function()
				repeat
					Swait()
					GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
				until ATTACK == false
				GYRO:Remove()
			end))
			local BULLET = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "Bullet", VT(2, 2, 2), true)
			BULLET.Color = C3(0, 0, 0)
			MakeForm(BULLET, "Ball")
			for i = 1, 15 do
				Swait()
				BULLET.CFrame = LeftArm.CFrame * CF(0, -1, 0)
				BULLET.Transparency = BULLET.Transparency - 0.06666666666666667
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(-25)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(95), RAD(0), RAD(15)) * ANGLES(RAD(0), RAD(45), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0.2) * ANGLES(RAD(-45), RAD(0), RAD(-45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(60), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			coroutine.resume(coroutine.create(function()
				BULLET.CFrame = CF(BULLET.Position, Mouse.Hit.p)
				BULLET.Size = VT(1.5, 1.5, 3)
				WACKYEFFECT({
					Time = 15,
					EffectType = "Wave",
					Size = VT(0, 1, 0),
					Size2 = VT(15, 1, 15),
					Transparency = 0,
					Transparency2 = 1,
					CFrame = BULLET.CFrame * ANGLES(RAD(90), RAD(0), RAD(0)),
					MoveToPos = nil,
					RotationX = 0,
					RotationY = 0,
					RotationZ = 0,
					Material = "Fabric",
					Color = C3(0, 0, 0),
					SoundID = nil,
					SoundPitch = nil,
					SoundVolume = nil
				})
				for i = 1, 170 do
					Swait()
					BULLET.CFrame = BULLET.CFrame * CF(0, 0, -2)
					local HIT, HITPOS = Raycast(BULLET.Position, BULLET.CFrame.lookVector, 2.5, Character)
					if HIT then
						break
					end
				end
				BULLET:remove()
				for i = 1, 25 do
					WACKYEFFECT({
						Time = 15,
						EffectType = "Sphere",
						Size = VT(80, 80, 80),
						Size2 = VT(35, 35, 35),
						Transparency = 0.9,
						Transparency2 = 1,
						CFrame = CF(BULLET.Position),
						MoveToPos = nil,
						RotationX = 0,
						RotationY = 5,
						RotationZ = 0,
						Material = "Neon",
						Color = C3(0, 0, 0),
						SoundID = 84005018,
						SoundPitch = 1,
						SoundVolume = 4
					})
					ApplyAoE(BULLET.Position, 40, 0, 0, -35, false, false)
					for i = 1, 30 do
						WACKYEFFECT({
							Time = 15,
							EffectType = "Sphere",
							Size = VT(42, 42, 42) / (1 + 0.3 * SIN(i / 6)),
							Size2 = VT(35, 35, 35) / (1 + 0.3 * SIN(i / 3)),
							Transparency = 0.8,
							Transparency2 = 1,
							CFrame = CF(BULLET.Position),
							MoveToPos = nil,
							RotationX = 0,
							RotationY = 5,
							RotationZ = 0,
							Material = "Neon",
							Color = C3(0, 0, 0),
							SoundID = nil,
							SoundPitch = nil,
							SoundVolume = nil
						})
						Swait()
						ApplyAoE(BULLET.Position, 10, 3, 3, 0, false, false)
					end
				end
			end))
			for i = 1, 15 do
				Swait()
				Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-45)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(45)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(95), RAD(0), RAD(15)) * ANGLES(RAD(0), RAD(45), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0.2) * ANGLES(RAD(45), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(60), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
		end
	end
	ATTACK = false
	Rooted = false
end
function AttackTemplate()
	ATTACK = true
	Rooted = false
	for i = 0, 1, 0.1 / Animation_Speed do
		Swait()
		Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(10), RAD(0), RAD(0)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(95), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45), RAD(0), RAD(45)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end
function MouseDown(Mouse)
	HOLD = true
	local HITFLOOR = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 4, Character)
	if HITFLOOR then
		if ATTACK == false and MELEE == false then
			Clicks()
		end
	elseif ATTACK == false then
		Aerial()
	end
end
function MouseUp(Mouse)
	HOLD = false
end
local DOUBLE = false
function KeyDown(Key)
	KEYHOLD = true
	if DASHING == false and MELEE == false then
		if Key == "z" and ATTACK == false then
			Mobility(CF(0, 5, 0))
		end
		if Key == "b" and ATTACK == false then
			Mobility(CF(0, 0, -5))
		end
		if Key == "c" and ATTACK == false then
			Mobility(CF(0, 0, 5))
		end
		if Key == "g" and ATTACK == false then
			Mobility(CF(5, 0, 0))
		end
		if Key == "h" and ATTACK == false then
			Mobility(CF(-5, 0, 0))
		end
	end
	if Key == "q" and ATTACK == false then
		ZenBullet()
	end
	if Key == "e" and ATTACK == false then
		Jab()
	end
	if Key == "v" and ATTACK == false then
		CorruptBullet()
	end
	if Key == "t" and ATTACK == false then
		taunt()
	end
	if(Key == " ")then
		Humanoid.Jump = true
	end
	if Key == " " and MELEE == false and ATTACK == false and Humanoid.Jump == true then
		local HITFLOOR = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 6, Character)
		if HITFLOOR == nil and DOUBLE == false then
			DOUBLE = true
			local bv = Instance.new("BodyVelocity", RootPart)
			bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			bv.Velocity = VT(RootPart.Velocity.X, 160, RootPart.Velocity.Z)
			Debris:AddItem(bv, .1)
			coroutine.resume(coroutine.create(function()
				--local RWING = WINGPART:Clone()
				--local LWING = WINGPART:Clone()
				--RWING.Parent = Effects
				--LWING.Parent = Effects
				--local RWELD = CreateWeldOrSnapOrMotor("Weld", Torso, Torso, RWING, CF(-1, 1, 0.75) * ANGLES(RAD(0), RAD(0), RAD(0)) * ANGLES(RAD(0), RAD(25), RAD(0)), CF(1.5, -0.5, 0))
				--local LWELD = CreateWeldOrSnapOrMotor("Weld", Torso, Torso, LWING, CF(1, 1, 0.75) * ANGLES(RAD(0), RAD(180), RAD(0)) * ANGLES(RAD(0), RAD(-25), RAD(0)), CF(1.5, -0.5, 0))
				Speed = 50
				CreateSound(462676772, Torso, 3, 1, false)
				--local FEATHERS = script.Feathers:Clone()
				--FEATHERS.Parent = RWING
				--FEATHERS:Emit(10)
			--	local FEATHERS = script.Feathers:Clone()
				--FEATHERS.Parent = LWING
				--FEATHERS:Emit(10)
				for i = 1, 45 do
					Swait()
					--RWELD.C1 = Clerp(RWELD.C1, CF(1.5, -0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-35)), 0.3)
					--LWELD.C1 = Clerp(LWELD.C1, CF(1.5, -0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-35)), 0.3)
					--RWING.Transparency = RWING.Transparency + 0.022222222222222223
					--LWING.Transparency = RWING.Transparency
				end
				Speed = 16
				DOUBLE = false
				--Debris:AddItem(RWING, 3)
				--Debris:AddItem(LWING, 3)
			end))
		end
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
Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and Disable_Jump == true then
		Humanoid.Jump = false
	end
end)
while true do
	Swait()
	--script.Parent = WEAPONGUI
	ANIMATE.Parent = nil
	ANIMATOR.Parent = nil
	if Character:FindFirstChildOfClass("Humanoid") == nil then
		Humanoid = IT("Humanoid", Character)
	end
	SINE = SINE + CHANGE
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 4, Character)
	local WALKSPEEDVALUE = 4
	if ANIM == "Walk" and TORSOVELOCITY > 1 and Rooted == false then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, -0.05 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(0), RAD(0) - RootPart.RotVelocity.Y / 75, RAD(0)), 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - Head.RotVelocity.Y / 30), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 0.875 - 0.125 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE * 2), -0.125 * COS(SINE / WALKSPEEDVALUE) + 0.2 - 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0) - RightLeg.RotVelocity.Y / 75, RAD(0), RAD(76 * COS(SINE / WALKSPEEDVALUE))), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 0.875 + 0.125 * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE * 2), 0.125 * COS(SINE / WALKSPEEDVALUE) + 0.2 + 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0) + LeftLeg.RotVelocity.Y / 75, RAD(0), RAD(76 * COS(SINE / WALKSPEEDVALUE))), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
	elseif ANIM ~= "Walk" or TORSOVELOCITY < 1 or Rooted == true then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false and MELEE == false then
			Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(25 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(-25 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.4, -0.6) * ANGLES(RAD(1), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false and MELEE == false then
			Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(45 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(-45 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -0.7) * ANGLES(RAD(-25 + 5 * SIN(SINE / 12)), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.8, -0.3) * ANGLES(RAD(-10), RAD(-80), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		ANIM = "Idle"
		if ATTACK == false and MELEE == false then
			Grip.C1 = Clerp(Grip.C1, CF(0, 0.2 + 0.1 * SIN(SINE / 12), 0) * ANGLES(RAD(5), RAD(2 * COS(SINE / 12)), RAD(0)), 1 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.1 * SIN(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12) + 0) * ANGLES(RAD(10), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35, 0.5, -0.4) * ANGLES(RAD(95), RAD(0), RAD(15 + 1 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.25, 0.5, 0.4) * ANGLES(RAD(-45 - 2 * COS(SINE / 12)), RAD(0), RAD(45 + 2 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.1 * SIN(SINE / 12), 0) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.1 * SIN(SINE / 12), 0) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false and MELEE == false then
			Grip.C1 = Clerp(Grip.C1, CF(0, 0, 0) * ANGLES(RAD(5), RAD(0), RAD(0)), 1 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, -0.05) * ANGLES(RAD(5), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(5 - 1 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-5), RAD(0), RAD(5)) * ANGLES(RAD(0), RAD(25), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-30 * COS(SINE / WALKSPEEDVALUE)), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(-5), RAD(85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(-5), RAD(-85), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
		end
	end
	unanchor()
	Humanoid.MaxHealth = 15000000000000000
	Humanoid.Health = 15000000000000000
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	refit()
	Effects.Parent = Character
	for _, c in pairs(Character:GetChildren()) do
		if c.ClassName == "Part" and c.Name ~= "Eye" then
			c.Material = "SmoothPlastic"
			if c:FindFirstChildOfClass("ParticleEmitter") then
				c:FindFirstChildOfClass("ParticleEmitter"):remove()
			end
			if c == LeftLeg or c == RightLeg then
				c.Color = C3(0.12, 0.12, 0.12)
				if c:FindFirstChildOfClass("BlockMesh") == nil then
					IT("BlockMesh", c)
				end
			elseif c == Torso then
				c.Color = C3(0.15, 0.15, 0.15)
				if c:FindFirstChildOfClass("BlockMesh") == nil then
					IT("BlockMesh", c)
				end
			else
				c.BrickColor = BRICKC("Bright yellow")
			end
			if c == Head and c:FindFirstChild("face") then
				c.face:remove()
			end
		elseif c.ClassName == "CharacterMesh" or c.ClassName == "Accessory" or c.Name == "Body Colors" then
			c:remove()
		elseif (c.ClassName == "Shirt" or c.ClassName == "Pants") and c.Name ~= "Cloth" then
			c:remove()
		end
	end
	sick.SoundId = "rbxassetid://12704439440"
	sick.Looped = true
	sick.Pitch = 1
	sick.Volume = 1
	sick.Parent = Torso
	sick.Playing = true
	Humanoid.Name = "ZenMan"
	Effects.Parent = Character
	for _, c in pairs(Character:GetChildren()) do
		if c:IsA("BasePart") and ATTACK == false then
			for _, e in pairs(c:GetChildren()) do
				if (e:IsA("ParticleEmitter") or e:IsA("BodyPosition") or e:IsA("BodyGyro")) and e:FindFirstChild("ZenKeeper") == nil then
					e:remove()
				end
			end
		end
	end
	if Head:FindFirstChild("face") then
		Head.face:remove()
	elseif Head:FindFirstChildOfClass("Sound") then
		Head:FindFirstChildOfClass("Sound"):remove()
	end
end