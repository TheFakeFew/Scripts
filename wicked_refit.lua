if(not getfenv().owner)then
	getfenv().owner = script:FindFirstAncestorOfClass("Player") or game:GetService("Players"):GetPlayerFromCharacter(script:FindFirstAncestorOfClass("Model"))
end
if(not getfenv().NLS)then
	getfenv().NLS = function() end
end

script.Parent = game:GetService("ServerScriptService")

-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 3100 characters
local function Decode(str)
	local StringLength = #str

	-- Base64 decoding
	do
		local decoder = {}
		for b64code, char in pairs(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='):split('')) do
			decoder[char:byte()] = b64code-1
		end
		local n = StringLength
		local t,k = table.create(math.floor(n/4)+1),1
		local padding = str:sub(-2) == '==' and 2 or str:sub(-1) == '=' and 1 or 0
		for i = 1, padding > 0 and n-4 or n, 4 do
			local a, b, c, d = str:byte(i,i+3)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
			t[k] = string.char(bit32.extract(v,16,8),bit32.extract(v,8,8),bit32.extract(v,0,8))
			k = k + 1
		end
		if padding == 1 then
			local a, b, c = str:byte(n-3,n-1)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40
			t[k] = string.char(bit32.extract(v,16,8),bit32.extract(v,8,8))
		elseif padding == 2 then
			local a, b = str:byte(n-3,n-2)
			local v = decoder[a]*0x40000 + decoder[b]*0x1000
			t[k] = string.char(bit32.extract(v,16,8))
		end
		str = table.concat(t)
	end

	local Position = 1
	local function Parse(fmt)
		local Values = {string.unpack(fmt,str,Position)}
		Position = table.remove(Values)
		return table.unpack(Values)
	end

	local Settings = Parse('B')
	local Flags = Parse('B')
	Flags = {
		--[[ValueIndexByteLength]] bit32.extract(Flags,6,2)+1,
		--[[InstanceIndexByteLength]] bit32.extract(Flags,4,2)+1,
		--[[ConnectionsIndexByteLength]] bit32.extract(Flags,2,2)+1,
		--[[MaxPropertiesLengthByteLength]] bit32.extract(Flags,0,2)+1,
		--[[Use Double instead of Float]] bit32.band(Settings,0b1) > 0
	}

	local ValueFMT = ('I'..Flags[1])
	local InstanceFMT = ('I'..Flags[2])
	local ConnectionFMT = ('I'..Flags[3])
	local PropertyLengthFMT = ('I'..Flags[4])

	local ValuesLength = Parse(ValueFMT)
	local Values = table.create(ValuesLength)
	local CFrameIndexes = {}

	local ValueDecoders = {
		--!!Start
		[1] = function(Modifier)
			return Parse('s'..Modifier)
		end,
		--!!Split
		[2] = function(Modifier)
			return Modifier ~= 0
		end,
		--!!Split
		[3] = function()
			return Parse('d')
		end,
		--!!Split
		[4] = function(_,Index)
			table.insert(CFrameIndexes,{Index,Parse(('I'..Flags[1]):rep(3))})
		end,
		--!!Split
		[5] = {CFrame.new,Flags[5] and 'dddddddddddd' or 'ffffffffffff'},
		--!!Split
		[6] = {Color3.fromRGB,'BBB'},
		--!!Split
		[7] = {BrickColor.new,'I2'},
		--!!Split
		[8] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = ColorSequenceKeypoint.new(Parse('f'),Color3.fromRGB(Parse('BBB')))
			end
			return ColorSequence.new(kpts)
		end,
		--!!Split
		[9] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = NumberSequenceKeypoint.new(Parse(Flags[5] and 'ddd' or 'fff'))
			end
			return NumberSequence.new(kpts)
		end,
		--!!Split
		[10] = {Vector3.new,Flags[5] and 'ddd' or 'fff'},
		--!!Split
		[11] = {Vector2.new,Flags[5] and 'dd' or 'ff'},
		--!!Split
		[12] = {UDim2.new,Flags[5] and 'di2di2' or 'fi2fi2'},
		--!!Split
		[13] = {Rect.new,Flags[5] and 'dddd' or 'ffff'},
		--!!Split
		[14] = function()
			local flags = Parse('B')
			local ids = {"Top","Bottom","Left","Right","Front","Back"}
			local t = {}
			for i = 0,5 do
				if bit32.extract(flags,i,1)==1 then
					table.insert(t,Enum.NormalId[ids[i+1]])
				end
			end
			return Axes.new(unpack(t))
		end,
		--!!Split
		[15] = function()
			local flags = Parse('B')
			local ids = {"Top","Bottom","Left","Right","Front","Back"}
			local t = {}
			for i = 0,5 do
				if bit32.extract(flags,i,1)==1 then
					table.insert(t,Enum.NormalId[ids[i+1]])
				end
			end
			return Faces.new(unpack(t))
		end,
		--!!Split
		[16] = {PhysicalProperties.new,Flags[5] and 'ddddd' or 'fffff'},
		--!!Split
		[17] = {NumberRange.new,Flags[5] and 'dd' or 'ff'},
		--!!Split
		[18] = {UDim.new,Flags[5] and 'di2' or 'fi2'},
		--!!Split
		[19] = function()
			return Ray.new(Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')),Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')))
		end
		--!!End
	}

	for i = 1,ValuesLength do
		local TypeAndModifier = Parse('B')
		local Type = bit32.band(TypeAndModifier,0b11111)
		local Modifier = (TypeAndModifier - Type) / 0b100000
		local Decoder = ValueDecoders[Type]
		if type(Decoder)=='function' then
			Values[i] = Decoder(Modifier,i)
		else
			Values[i] = Decoder[1](Parse(Decoder[2]))
		end
	end

	for i,t in pairs(CFrameIndexes) do
		Values[t[1]] = CFrame.fromMatrix(Values[t[2]],Values[t[3]],Values[t[4]])
	end

	local InstancesLength = Parse(InstanceFMT)
	local Instances = {}
	local NoParent = {}

	for i = 1,InstancesLength do
		local ClassName = Values[Parse(ValueFMT)]
		local obj
		local MeshPartMesh,MeshPartScale
		if ClassName == "UnionOperation" then
			obj = DecodeUnion(Values,Flags,Parse)
			obj.UsePartColor = true
		elseif ClassName:find("Script") then
			obj = Instance.new("Folder")
			Script(obj,ClassName=='ModuleScript')
		elseif ClassName == "MeshPart" then
			obj = Instance.new("Part")
			MeshPartMesh = Instance.new("SpecialMesh")
			MeshPartMesh.MeshType = Enum.MeshType.FileMesh
			MeshPartMesh.Parent = obj
		else
			obj = Instance.new(ClassName)
		end
		local Parent = Instances[Parse(InstanceFMT)]
		local PropertiesLength = Parse(PropertyLengthFMT)
		local AttributesLength = Parse(PropertyLengthFMT)
		Instances[i] = obj
		for i = 1,PropertiesLength do
			local Prop,Value = Values[Parse(ValueFMT)],Values[Parse(ValueFMT)]

			-- ok this looks awful
			if MeshPartMesh then
				if Prop == "MeshId" then
					MeshPartMesh.MeshId = Value
					continue
				elseif Prop == "TextureID" then
					MeshPartMesh.TextureId = Value
					continue
				elseif Prop == "Size" then
					if not MeshPartScale then
						MeshPartScale = Value
					else
						MeshPartMesh.Scale = Value / MeshPartScale
					end
				elseif Prop == "MeshSize" then
					if not MeshPartScale then
						MeshPartScale = Value
						MeshPartMesh.Scale = obj.Size / Value
					else
						MeshPartMesh.Scale = MeshPartScale / Value
					end
					continue
				end
			end

			obj[Prop] = Value
		end
		if MeshPartMesh then
			if MeshPartMesh.MeshId=='' then
				if MeshPartMesh.TextureId=='' then
					MeshPartMesh.TextureId = 'rbxasset://textures/meshPartFallback.png'
				end
				MeshPartMesh.Scale = obj.Size
			end
		end
		for i = 1,AttributesLength do
			obj:SetAttribute(Values[Parse(ValueFMT)],Values[Parse(ValueFMT)])
		end
		if not Parent then
			table.insert(NoParent,obj)
		else
			obj.Parent = Parent
		end
	end

	local ConnectionsLength = Parse(ConnectionFMT)
	for i = 1,ConnectionsLength do
		local a,b,c = Parse(InstanceFMT),Parse(ValueFMT),Parse(InstanceFMT)
		Instances[a][Values[b]] = Instances[c]
	end

	return NoParent
end


local Objects = Decode('AACXIQZGb2xkZXIhBE5hbWUhB0NPVU5URVIhCVBhcnRpY2xlcyEPUGFydGljbGVFbWl0dGVyIQ1Db3VudGVyQ2hhcmdlIQVDb2xvcigCAAAAAP8AAAAAgD//AAAhB0VuYWJsZWQCIQhMaWZldGltZREzM7M+MzOzPiENTGlnaHRFbWlzc2lvbgMAAABgZmbWPyEMTG9j'
	..'a2VkVG9QYXJ0IiEEUmF0ZQMAAAAAAAAUQCEIUm90YXRpb24RAAAAAAAAtEMhBFNpemUpAgAAAAAAACBBAAAAAAAAgD8AAAAAAAAAACEFU3BlZWQRAAAAAAAAAAAhB1RleHR1cmUhKWh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9NTU0NzcwOTcwIQxUcmFu'
	..'c3BhcmVuY3kpAgAAAAAAAIA/AAAAAAAAgD8AAAAAAAAAACELQ291bnRlclJpbmcRAACAPgAAAD8DAAAAABJFJUEDAAAAAAAACEApAgAAAAAAAAAAAAAAAAAAgD8AAMhBAAAAACEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD03NzU5MDcwOTk0KQIAAAAA'
	..'AAAAAAAAAAAAAIA/AACAPwAAAAAhCUVZRV9HbGFyZSERRW1pc3Npb25EaXJlY3Rpb24RAAAAPwAAgD8hC09yaWVudGF0aW9uAwAAAAAAAAxAKQMAAAAAAAAAAAAAAAAAAAA/AABgQAAAAAAAAIA/AAAAAAAAAAARCtejOwrXozshKmh0dHA6Ly93d3cucm9ibG94LmNv'
	..'bS9hc3NldC8/aWQ9NzczOTIzOTExOCkCAAAAAAAAAD8AAAAAAACAPwAAAD8AAAAAIQJVSSEMQmlsbGJvYXJkR3VpIQ5Db3VudGVyRGlzcGxheSEOWkluZGV4QmVoYXZpb3IDAAAAAAAA8D8hBkFjdGl2ZSELQWx3YXlzT25Ub3AMAAAgQQAAAAAgQQAAIQVGcmFtZSEQ'
	..'QmFja2dyb3VuZENvbG9yMwb///8hFkJhY2tncm91bmRUcmFuc3BhcmVuY3khD0JvcmRlclNpemVQaXhlbAMAAAAAAAAAAAwAAIA/AAAAAIA/AAAhCVRleHRMYWJlbCELQ291bnRlclRleHQhCFBvc2l0aW9uDAAAAD4AAAAAgL4AAAwAAEA/AAAAAEA/AAAhBEZvbnQD'
	..'AAAAAAAAQ0AhBFRleHQhClRleHRDb2xvcjMG/0tLIQpUZXh0U2NhbGVkIQhUZXh0U2l6ZQMAAAAAAABJQCEQVGV4dFN0cm9rZUNvbG9yMwZkAAAhFlRleHRTdHJva2VUcmFuc3BhcmVuY3kDAAAAAAAA6D8hEFRleHRUcmFuc3BhcmVuY3khC1RleHRXcmFwcGVkIQpJ'
	..'bWFnZUxhYmVsDAAAgD4AAAAAgD4AAAwAAAA/AAApXB8/AAAhBlpJbmRleCEFSW1hZ2UhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9OTU3NDMxMzU4NiELSW1hZ2VDb2xvcjMG/5aWIRFJbWFnZVRyYW5zcGFyZW5jeQMAAAAAAADgPyEKQXR0YWNrVGV4'
	..'dAMAAAAAAEBRQAMAAAAAAAA5QCEGYXR0YWNrBngAACEEUGFydCEFQnJvb20hDUJvdHRvbVN1cmZhY2UhCkJyaWNrQ29sb3IH6QMhBkNGcmFtZQRplJUhCkNhbkNvbGxpZGUhCE1hc3NsZXNzIQhNYXRlcmlhbAMAAAAAAAByQAoINmpBAAAAQFBDST8KAABAPwAAQD8A'
	..'AChBIQpUb3BTdXJmYWNlIQtTcGVjaWFsTWVzaCEFU2NhbGUKAAAQQAAAEEAAABBAIQtWZXJ0ZXhDb2xvcgoAAHpEAAB6RAAAekQhBk1lc2hJZCEoaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0zNjM2NTgzMCEITWVzaFR5cGUhB01vdG9yNkQhAkMxBJaU'
	..'lSEFUGFydDEhBEV2aWwhCEFuY2hvcmVkB+sDBH2UlQYAAAAKaB86Qy3JmEU1pwlFCgAAAEDNzMw9AAAAQCEKU3VyZmFjZUd1aSEERmFjZQMAAAAAAAAQQCEOTGlnaHRJbmZsdWVuY2UhClNpemluZ01vZGUhBkJvcmRlcgMAAAAAAIBWwCEqaHR0cDovL3d3dy5yb2Js'
	..'b3guY29tL2Fzc2V0Lz9pZD02NTU2MDY2MTc3IQpTbGljZVNjYWxlIQZXSUNLRUQMKVyPPQAATTTRPQAADAAAgD8AAO2ySz8AACEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD05OTAwMDc1ODM5BsGRkSEDRXllB+wDBJKXlQb/AAAKAAAAAAAAtMIAAAAA'
	..'Co+aecSF65lAZLsWwgoAAAA+mpmZPgAAAD4KAACAPwAAAAAAAAAACgAAAAAAAIA/AAAAAAoAAAAAAACAPwAAQEAKLr07swAAAAAAAIA/GQEAAQACAwEBAQACBAUCDAACBgcICQoLDA0ODxAREhMUFRYXGBkaGxwFAgsAAh0HCAkKCx4NHw8QESAVIRcYGSIbIwUCDAAC'
	..'JCUSCQoLJg0fDxAnIBEoFSkXKhkrGywBAQEAAi0uBgUAAi8wMTIQMxAVNDUHBAA2NzgxOToVOzwIDgACPTY3ODE+PxVAQUJDA0RFRhBHSElKS0xNTE4QTwgJADY3ODE5Oj5QFVFSOlNUVVZXWDwIDQACWTY3ODE+PxVAUlpBW0NcRF1GEEdISV1OEF4ACwACX2A6YWJj'
	..'ZGUKBzdmEGdoPmkVams6bAwEAG1ub3BxcnMSdAwBAHV2XgALAAJ4eRBgOmF6Y3sHfGdoPn0Vfms6GzF/DwQAMDGAgYIxgzE1EAMANjc4MRU7TxEJAAKENjc4MROFFTtSWlOGVXyHWk8RCAACiDY3ODE+iROFFYpTi1WMfw8EADAxgDGCMYMxNRQDADY3ODEVO08VCQAC'
	..'hDY3ODEThRU7UlpThlV8h1pPFQgAAog2NzgxPokThRWKU4tVjF4ACwACjWA6YY5jjweQZ2gnkT6SE5EVk2s6bBgBAHMgAQ53DA==')

local heartbeat = game:GetService("RunService").Heartbeat
local deb = game:GetService("Debris")
local ts = game:GetService("TweenService")

local fakeobjects = {}
for i,v in next, Objects do
	fakeobjects[v.Name] = v
end
local realscript = script
script = setmetatable({}, {
	__index = function(self, index)
		return fakeobjects[index] or realscript[index]
	end,
	__newindex = function(self, index, value)
		realscript[index] = value
	end
})

local evil = Instance.new("Tool", owner.Character)
evil.Name = "Evil"
evil.Grip = CFrame.new(-5.5636356e-08, 0.0338564515, -1.07650006, -1, -5.56362707e-08, 8.74227695e-08, 6.312181e-08, 0.342020094, 0.939692557, -8.21813444e-08, 0.939692557, -0.342020065)
local evilp = script.Evil:Clone()
evilp.Name = "Handle"
evilp.Parent = evil
evilp.Anchored = false

local activated = false

evil.Activated:Once(function()
	activated = true
	evil:Destroy()
end)

repeat task.wait() until activated

local counteranim = {
	Properties = {
		Looping = false,
		Priority = Enum.AnimationPriority.Core
	},
	Keyframes = {
		[0] = {
			["HumanoidRootPart"] = {
				["Torso"] = {
					CFrame = CFrame.Angles(math.rad(15.011), 0, 0),
					["Left Leg"] = {
						CFrame = CFrame.new(-0.29, 0.078, 0) * CFrame.Angles(math.rad(3.953), math.rad(14.496), math.rad(-15.527)),
					},
					["Right Leg"] = {
						CFrame = CFrame.new(0.3, 0, 0) * CFrame.Angles(math.rad(-3.953), math.rad(-14.496), math.rad(-15.527)),
					},
					["Head"] = {
						CFrame = CFrame.Angles(math.rad(-15.011), 0, 0),
					},
					["Left Arm"] = {
						CFrame = CFrame.new(-0.308, 0.183, 0.014) * CFrame.Angles(math.rad(16.96), math.rad(-8.938), math.rad(-82.907)),
						["Broom"] = {
							CFrame = CFrame.new(-0.76, 0.062, -0.432) * CFrame.Angles(math.rad(-154.469), math.rad(-72.536), math.rad(-142.437)),
						},
					},
					["Right Arm"] = {
						CFrame = CFrame.new(0.3, 0, 0) * CFrame.Angles(math.rad(15.011), 0, math.rad(90.012)),
					},
				},
			},
		},
		[0.267] = {
			["HumanoidRootPart"] = {
				["Torso"] = {
					CFrame = CFrame.Angles(math.rad(15.011), 0, 0),
					["Left Leg"] = {
						CFrame = CFrame.new(-0.29, 0.078, 0) * CFrame.Angles(math.rad(3.953), math.rad(14.496), math.rad(-15.527)),
					},
					["Right Leg"] = {
						CFrame = CFrame.new(0.3, 0, 0) * CFrame.Angles(math.rad(-3.953), math.rad(-14.496), math.rad(-15.527)),
					},
					["Head"] = {
						CFrame = CFrame.Angles(math.rad(-15.011), 0, 0),
					},
					["Left Arm"] = {
						CFrame = CFrame.new(-0.308, 0.183, 0.014) * CFrame.Angles(math.rad(16.96), math.rad(-8.938), math.rad(-82.907)),
						["Broom"] = {
							CFrame = CFrame.new(-0.76, 0.062, -0.432) * CFrame.Angles(math.rad(-154.469), math.rad(-72.536), math.rad(-142.437)),
						},
					},
					["Right Arm"] = {
						CFrame = CFrame.new(0.3, 0, 0) * CFrame.Angles(math.rad(15.011), 0, math.rad(90.012)),
					},
				},
			},
		},
		[0.467] = {
			["HumanoidRootPart"] = {
				["Torso"] = {
					CFrame = CFrame.Angles(math.rad(-15.011), 0, 0),
					["Left Leg"] = {
						CFrame = CFrame.new(-0.29, 0.078, 0) * CFrame.Angles(math.rad(3.953), math.rad(14.496), math.rad(-0.516)),
					},
					["Right Leg"] = {
						CFrame = CFrame.new(-0.161, 0.01, 0.087) * CFrame.Angles(math.rad(-3.953), math.rad(-14.496), math.rad(-45.493)),
					},
					["Head"] = {
					},
					["Left Arm"] = {
						CFrame = CFrame.new(0.186, 0.152, 0.086) * CFrame.Angles(math.rad(16.96), math.rad(-8.938), math.rad(142.094)),
					},
					["Right Arm"] = {
						CFrame = CFrame.new(-0.083, 0.321, 0.006) * CFrame.Angles(math.rad(18.965), math.rad(-14.496), math.rad(-164.496)),
					},
				},
			},
		},
	}
}

function clone(inst)
	inst.Archivable = true
	for _, v in next, inst:GetDescendants() do
		v.Archivable = true
	end
	return inst:Clone()
end

local rnd = Random.new(tick())
local CFRAMES = {
	CHARACTER = {}
}
local counterdeb = 0
local connections = {}
local joints = {}
local limbs = {}
local oldcframes = CFRAMES
local hum = nil
local char = nil
local orighp = 0
local numofdesc = 0
local cbackup = clone(owner.Character)

function relocate()
	local spawns = {}
	for _, v in next, workspace:GetDescendants() do
		if v:IsA("SpawnLocation") then
			table.insert(spawns, v)
		end
	end
	return #spawns > 0 and spawns[math.random(1, #spawns)].CFrame + (Vector3.yAxis * 5) or CFrame.new(0, 100, 0)
end

function newpart(size, cf)
	local a = Instance.new("Part")
	a.Anchored = true
	a.CanCollide = false
	a.Size = size
	a.CFrame = cf
	return a
end

function fwrap(str)
	return string.gsub(str, " ", "⠀")
end

local EWait = task.wait

local EmittingParticles = {}
function EmitParticle(Particle, Duration)
	task.spawn(function()
		local Rate = Particle.Rate
		local Duration = Duration or 9e9
		local Amount = Rate/60
		local AmountFloor = math.floor(Amount)
		local Remainder = Amount-AmountFloor
		local RCount = 0
		local CurrentAmount = 0
		local Time = os.clock()
		EmittingParticles[Particle] = true
		while os.clock()-Time <= Duration and EmittingParticles[Particle] == true and Particle.Parent ~= nil do
			local NewRC = RCount + Remainder
			local Add = math.floor(NewRC)
			RCount = NewRC - Add

			local Combined = CurrentAmount + AmountFloor + Add
			local FINAL = math.floor(Combined)
			CurrentAmount = Combined - FINAL
			Particle:Emit(FINAL)
			EWait()
		end
		EmittingParticles[Particle] = nil
	end)
end

function newsoundat(cframe, id, vol, pit)
	local p = newpart(Vector3.zero, cframe)
	p.Parent = workspace
	local s = Instance.new("Sound", p)
	s.SoundId = "rbxassetid://"..id
	s.Volume = vol
	s.Pitch = pit
	s:Play()
	if(not s.IsLoaded)then
		repeat task.wait() until s.IsLoaded
	end
	game:GetService("Debris"):AddItem(p, s.TimeLength/s.Pitch)
end

function charclone()
	for i, v in next, char:GetChildren() do
		if(not v:IsA("BasePart"))then
			continue
		end
		pcall(function()
			local a = v:Clone()
			a:BreakJoints()
			for i, vv in next, a:GetDescendants() do
				if(not vv:IsA("DataModelMesh") and not vv:IsA("BasePart"))then
					pcall(game.Destroy, vv)
				end
			end
			a.Material = Enum.Material.Neon
			a.Color = Color3.new(0,0,0)
			a.Anchored = true
			a.CanCollide = false
			a.Size = a.Size - Vector3.new(0.05, 0.05, 0.05)
			a.Name = tostring({}):match("0x.*"):sub(3,17)
			a.Parent = workspace
			game:GetService("TweenService"):Create(a, TweenInfo.new(1), {
				Transparency = 1
			}):Play()
			game:GetService("Debris"):AddItem(a, 1)
		end)
	end
end

function counter(counterlist)
	task.wait()
	if(tick() - counterdeb) < 5 then
		return
	end
	counterdeb = tick()
	local anims = {}
	local welds = {}
	local tweens = {}
	local animate = char:FindFirstChild("Animate")
	local origc0s = {}

	local function stopAnims()
		for i,v in next, anims do
			pcall(function()
				task.cancel(v)
			end)
		end
		task.wait()
		anims = {}
		for i,v in next, tweens do
			pcall(function()
				v:Cancel()
			end)
		end 
		tweens = {}
		for i,v in next, origc0s do
			welds[i].C0 = v
		end
		if(animate)then
			animate.Disabled = false
		end
	end

	local function setC0s(tbl, time)
		local function recurse(v)
			for i,v in next, v do
				if(welds[i])then
					pcall(function()
						local tw = game:GetService('TweenService'):Create(welds[i],TweenInfo.new(time),{
							C0 = origc0s[i]*v.CFrame
						})
						tw:Play()
						table.insert(tweens,tw)
					end)
				end
				pcall(recurse,v)
			end
		end
		pcall(recurse,tbl)
	end

	local lastt = 0

	task.spawn(pcall, function()
		if(hum.RigType == Enum.HumanoidRigType.R6)then
			if(animate)then
				animate.Disabled = true
			end
			NLS([[for i, v in next, owner.Character:FindFirstChildOfClass("Humanoid").Animator:GetPlayingAnimationTracks() do v:Stop() end]], owner.PlayerGui)
			stopAnims()
			hum.WalkSpeed = 0
			task.wait(.1)
			local broom = script.Broom:Clone()
			broom.Parent = char
			broom.Motor6D.Part0 = char["Left Arm"]
			
			local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
			bv.Velocity = -char.HumanoidRootPart.CFrame.LookVector*7
			bv.MaxForce = Vector3.new(99e9, 99e9, 99e9)

			for i,v in next, char:GetDescendants() do
				if(v:IsA("JointInstance") and not v:FindFirstAncestorOfClass("Accessory"))then
					welds[v.Part1 and v.Part1.Name or ""] = v
				end
			end

			for i,v in next, welds do
				origc0s[i] = v.C0
			end

			local lastkeyframe = 0
			for i,v in next, counteranim.Keyframes do
				if(i>lastkeyframe)then
					lastkeyframe = i
				end
			end
			local thread = task.delay(lastkeyframe+1, function()
				stopAnims()
				hum.WalkSpeed = 16
			end)
			table.insert(anims,thread)

			for i,v in next, counteranim.Keyframes do
				local thread 
				thread = task.delay(i,function()
					if(i == 0.467)then
						pcall(game.Destroy, bv)
						pcall(game.Destroy, broom)
					end
					local time = i-lastt
					setC0s(v,time)
					lastt = i
				end)
				table.insert(anims,thread)
			end
		end
	end)

	local cframe = CFRAMES.CHARACTER.Character

	task.delay(1/30, function()
		local chargepart = newpart(Vector3.zero, cframe)
		local chargeparticle = script.COUNTER.Particles.CounterCharge:Clone()
		chargeparticle.Parent = chargepart
		chargepart.Parent = workspace
		task.spawn(function()
			for i = 1, 5 do
				chargeparticle:Emit(1)
				EWait(0.05)
			end
			deb:AddItem(chargepart, chargeparticle.Lifetime.Max)
		end)
		newsoundat(cframe, 1085317309, 1, math.random(90, 110)/100)
	end)

	EWait(.2)

	local labelpart = newpart(Vector3.zero, cframe)
	local ui = script.COUNTER.UI.CounterDisplay:Clone()
	local frame = ui.Frame
	local imglabel = frame.ImageLabel
	imglabel.ImageTransparency = 1
	local countertext = frame.CounterText
	local attacktext = frame.AttackText

	imglabel.ImageTransparency = 1
	countertext.TextTransparency = 1
	countertext.TextStrokeTransparency = 1
	countertext.Visible = true
	attacktext.Visible = false

	ui.Size = UDim2.new(70, 0, 70, 0)
	ui.Adornee = labelpart
	ui.Parent = labelpart
	labelpart.Parent = workspace

	ts:Create(labelpart, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		CFrame = cframe + Vector3.new(0, 8.5, 0)
	}):Play()

	ts:Create(ui, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.new(10, 0, 10, 0)
	}):Play()

	ts:Create(imglabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		ImageTransparency = 0.5
	}):Play()

	EWait(.5)
	countertext.TextTransparency = 0.75
	countertext.TextStrokeTransparency = 0.75

	task.spawn(function()
		local cindex = 1
		local i = 0
		while labelpart.Parent ~= nil do
			i = i + 1

			local showattack = i % 2 == 1
			if showattack == true then
				local attack = counterlist[cindex] or "undefined"
				attack = fwrap(attack)
				attacktext.Text = fwrap("? "..attack.." ?")

				cindex = cindex + 1
				if cindex > #counterlist then
					cindex = 1
				end
			else
				if rnd:NextInteger(1, 2) == 1 then
					countertext.Text = "COUNTER"
				else
					countertext.Text = fwrap("? ANTIFADE ?")
				end
			end

			countertext.Visible = not showattack
			attacktext.Visible = showattack
			EWait(rnd:NextNumber(0.25, 0.4))
		end
	end)

	task.spawn(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0, 0.25))
			i = i + 1

			imglabel.ImageTransparency = (i % 2) + 0.5
			countertext.TextTransparency = (i % 2) + 0.75
			countertext.TextStrokeTransparency = (i % 2) + 0.75
			attacktext.TextTransparency = (i % 2) + 0.5
		end
	end)
	deb:AddItem(labelpart, 3.5)

	local counterpart = newpart(Vector3.zero, cframe)
	local counterparticle = script.COUNTER.Particles.CounterRing:Clone()
	counterpart.Parent = workspace
	counterparticle.Parent = counterpart
	task.spawn(function()
		task.wait()
		counterparticle:Emit(10)
		deb:AddItem(counterpart, counterparticle.Lifetime.Max)
	end)

	pcall(function()
		local EyeOffset = CFrame.new(Vector3.new(-0.125, 0.25, -0.57 + (-0.125/2 * 0.75)))
		local eye = script.Eye:Clone()
		eye.Color = Color3.new(1, 1, 1)
		eye.Size = eye.Size

		local eyeparticle = script.COUNTER.Particles.EYE_Glare:Clone()
		eye.Anchored = false
		eye.CanCollide = false

		local att = Instance.new("Attachment", eye)
		eyeparticle.Parent = att
		eye.CFrame = CFRAMES.CHARACTER.Head*EyeOffset
		eye.Parent = char

		local a = Instance.new("WeldConstraint", eye)
		a.Part0 = eye
		a.Part1 = char.Head
		EmitParticle(eyeparticle, 3)

		task.delay(3, function()
			local del = eyeparticle.Lifetime.Max
			ts:Create(eye, TweenInfo.new(eyeparticle.Lifetime.Min, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1
			}):Play()
			deb:AddItem(eye, del)
		end)
	end)

	newsoundat(cframe, 1085317309, 2, math.random(90, 110)/100)
	newsoundat(cframe, 2370794297, 4, math.random(90, 110)/100)
end

function clearall()
	for i, v in next, connections do
		pcall(function()
			v:Disconnect()
		end)
	end
	table.clear(connections)
	table.clear(joints)
	table.clear(limbs)
end

function remakechar()
	local nc = cbackup:Clone()
	pcall(function()
		nc.Archivable = false
		nc.Name = tostring({}):match("0x.*"):sub(3,17)
		owner.Character = nc
		char = nc
		nc.Parent = workspace
		CFRAMES = oldcframes
		nc:PivotTo(CFRAMES.CHARACTER.Character)
	end)
	return nc
end

function respawn()
	pcall(game.Destroy, char)
	pcall(game.Destroy, owner.Character)

	oldcframes = {
		CHARACTER = {
			Character = CFRAMES.CHARACTER.Character.Y <= workspace.FallenPartsDestroyHeight + 20 and relocate() or CFRAMES.CHARACTER.Character,
			Head = CFRAMES.CHARACTER.Head
		}
	};
	local nc = remakechar()
	task.defer(function()
		if(nc and nc:IsDescendantOf(workspace))and(owner.Character ~= nc)then
			pcall(game.Destroy, nc)
			pcall(game.Destroy, char)
			pcall(game.Destroy, owner.Character)
			nc = remakechar()
		end
	end)
end

function dochecks(object)
	local cl = {}
	local shouldrefit = false

	local function c(offense)
		if not table.find(cl, offense) then
			table.insert(cl, offense)
		end
		shouldrefit = true
	end

	if(not char or not char:IsDescendantOf(workspace))then
		c(`ancestry_tamper({char and tostring(char.Parent) or "nil?"})`)
	end

	if(char and char:IsDescendantOf(workspace))then
		if(not hum or not hum:IsDescendantOf(char))then
			c("humanoid_removal")
		end
		if(hum.Health < orighp)then
			c("health_tampering")
		end
		if(hum.Health <= 0)then
			c("humanoid_death")
		end

		local numofdescc = 0
		local physicstamper = false
		for i, v in next, char:GetDescendants() do
			if(v:IsA("ForceField") or v:IsA("LuaSourceContainer") or v:IsA("JointInstance") or v.Name == "Eye" or v:FindFirstAncestor("Eye") or v.Name == "Broom" or v:FindFirstAncestor("Broom"))then
				continue
			end
			numofdescc = numofdescc + 1
			if(v:IsA("BasePart") and v.Anchored)then
				physicstamper = true
			end
		end
		if(numofdescc > numofdesc)then
			c("intrusion")
		end
		if(physicstamper)then
			c("physics_tampering")
		end

		if(object)then
			if(table.find(limbs, object))then
				c(`limb_removal({object.Name})`)
			end
		end
		for i, v in next, limbs do
			if(not v:IsDescendantOf(char))then
				c(`limb_removal({v.Name})`)
			end
		end

		if(object)then
			if(table.find(joints, object))then
				c(`joint_removal({object.Name})`)
			end
		end
		for i, v in next, joints do
			if(not v:IsDescendantOf(char))then
				c(`joint_removal({v.Name})`)
			end
		end

		if(Vector3.zero - char:GetPivot().Position).Magnitude > 1e5 then
			c("void_throw")
		end
	end

	if(shouldrefit)then
		clearall()
		respawn()

		counter(cl)
		return true
	end

	return false
end

function newchar()
	clearall()
	char = owner.Character
	numofdesc = 0
	if(not char)then char = owner.CharacterAdded:Wait() end
	if(not char or not char:IsDescendantOf(workspace))then
		repeat task.wait() until char and char:IsDescendantOf(workspace)
	end
	char:WaitForChild("HumanoidRootPart")

	CFRAMES.CHARACTER.Character = char:GetPivot()
	CFRAMES.CHARACTER.Head = char.Head.CFrame

	hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
	task.defer(function()
		if(char:FindFirstChildOfClass("ForceField"))then
			char:FindFirstChildOfClass("ForceField"):Destroy()
		end
	end)
	for i, v in next, char:GetDescendants() do
		if(v:IsA("ForceField") or v:IsA("LuaSourceContainer") or v:IsA("JointInstance") or v.Name == "Eye" or v:FindFirstAncestor("Eye") or v.Name == "Broom" or v:FindFirstAncestor("Broom"))then
			continue
		end
		numofdesc = numofdesc + 1
	end

	for i,v in next, char:GetDescendants() do
		if(v:IsA("JointInstance") and not v:FindFirstAncestorOfClass("Accessory"))then
			table.insert(joints, v)
		end
	end
	for i,v in next, char:GetChildren() do
		if(v:IsA("BasePart"))then
			table.insert(limbs, v)
		end
	end

	orighp = hum.Health
	table.insert(connections, hum.HealthChanged:Connect(function()
		dochecks()
	end))

	table.insert(connections, char.HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Connect(function()
		dochecks()
	end))

	table.insert(connections, char.DescendantRemoving:Connect(function(v)
		dochecks(v)
	end))

	table.insert(connections, char.DescendantAdded:Connect(function(v)
		dochecks(v)
	end))

	table.insert(connections, char.AncestryChanged:Connect(function()
		dochecks()
	end))

	table.insert(connections, heartbeat:Connect(function()
		pcall(function()
			if(Vector3.zero - char:GetPivot().Position).Magnitude < 1e5 then
				CFRAMES.CHARACTER.Character = char:GetPivot()
				CFRAMES.CHARACTER.Head = char.Head.CFrame
			end
		end)
		dochecks()
	end))
end

local delta = 0

heartbeat:Connect(function(dt)
	delta = delta + dt
	if(delta >= .1)then
		delta = 0
		if(not char or not char:IsDescendantOf(workspace))then
			clearall()
			respawn()
			counter({"ancestry_tamper(nil?)"})
		end
		charclone()
	end
end)

newchar()
owner.CharacterAdded:Connect(newchar)