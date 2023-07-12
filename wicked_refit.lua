if(not getfenv().owner)then
	getfenv().owner = script:FindFirstAncestorOfClass("Player") or game:GetService("Players"):GetPlayerFromCharacter(script:FindFirstAncestorOfClass("Model"))
end

script.Parent = game:GetService("ServerScriptService")

-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 2776 characters
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


local Objects = Decode('AACFIQZGb2xkZXIhBE5hbWUhB0NPVU5URVIhCVBhcnRpY2xlcyEPUGFydGljbGVFbWl0dGVyIQ1Db3VudGVyQ2hhcmdlIQVDb2xvcigCAAAAAP8AAAAAgD//AAAhB0VuYWJsZWQCIQhMaWZldGltZREzM7M+MzOzPiENTGlnaHRFbWlzc2lvbgMAAABgZmbWPyEMTG9j'
	..'a2VkVG9QYXJ0IiEEUmF0ZQMAAAAAAAAUQCEIUm90YXRpb24RAAAAAAAAtEMhBFNpemUpAgAAAAAAACBBAAAAAAAAgD8AAAAAAAAAACEFU3BlZWQRAAAAAAAAAAAhB1RleHR1cmUhKWh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9NTU0NzcwOTcwIQxUcmFu'
	..'c3BhcmVuY3kpAgAAAAAAAIA/AAAAAAAAgD8AAAAAAAAAACELQ291bnRlclJpbmcRAACAPgAAAD8DAAAAABJFJUEDAAAAAAAACEApAgAAAAAAAAAAAAAAAAAAgD8AAMhBAAAAACEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD03NzU5MDcwOTk0KQIAAAAA'
	..'AAAAAAAAAAAAAIA/AACAPwAAAAAhCUVZRV9HbGFyZSERRW1pc3Npb25EaXJlY3Rpb24RAAAAPwAAgD8hC09yaWVudGF0aW9uAwAAAAAAAAxAKQMAAAAAAAAAAAAAAAAAAAA/AABgQAAAAAAAAIA/AAAAAAAAAAARCtejOwrXozshKmh0dHA6Ly93d3cucm9ibG94LmNv'
	..'bS9hc3NldC8/aWQ9NzczOTIzOTExOCkCAAAAAAAAAD8AAAAAAACAPwAAAD8AAAAAIQJVSSEMQmlsbGJvYXJkR3VpIQ5Db3VudGVyRGlzcGxheSEOWkluZGV4QmVoYXZpb3IDAAAAAAAA8D8hBkFjdGl2ZSELQWx3YXlzT25Ub3AMAAAgQQAAAAAgQQAAIQVGcmFtZSEQ'
	..'QmFja2dyb3VuZENvbG9yMwb///8hFkJhY2tncm91bmRUcmFuc3BhcmVuY3khD0JvcmRlclNpemVQaXhlbAMAAAAAAAAAAAwAAIA/AAAAAIA/AAAhCVRleHRMYWJlbCELQ291bnRlclRleHQhCFBvc2l0aW9uDAAAAD4AAAAAgL4AAAwAAEA/AAAAAEA/AAAhBEZvbnQD'
	..'AAAAAAAAQ0AhBFRleHQhClRleHRDb2xvcjMG/0tLIQpUZXh0U2NhbGVkIQhUZXh0U2l6ZQMAAAAAAABJQCEQVGV4dFN0cm9rZUNvbG9yMwZkAAAhFlRleHRTdHJva2VUcmFuc3BhcmVuY3kDAAAAAAAA6D8hEFRleHRUcmFuc3BhcmVuY3khC1RleHRXcmFwcGVkIQpJ'
	..'bWFnZUxhYmVsDAAAgD4AAAAAgD4AAAwAAAA/AAApXB8/AAAhBlpJbmRleCEFSW1hZ2UhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9OTU3NDMxMzU4NiELSW1hZ2VDb2xvcjMG/5aWIRFJbWFnZVRyYW5zcGFyZW5jeQMAAAAAAADgPyEKQXR0YWNrVGV4'
	..'dAMAAAAAAEBRQAMAAAAAAAA5QCEGYXR0YWNrBngAACEEUGFydCEERXZpbCEIQW5jaG9yZWQhDUJvdHRvbVN1cmZhY2UhCkJyaWNrQ29sb3IH6wMhBkNGcmFtZQRpg4QGAAAAIQhNYXRlcmlhbAMAAAAAAAByQApoHzpDLcmYRTWnCUUKAAAAQM3MzD0AAABAIQpUb3BT'
	..'dXJmYWNlIQpTdXJmYWNlR3VpIQRGYWNlAwAAAAAAABBAIQ5MaWdodEluZmx1ZW5jZSEKU2l6aW5nTW9kZSEGQm9yZGVyAwAAAAAAgFbAISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTY1NTYwNjYxNzchClNsaWNlU2NhbGUhBldJQ0tFRAwpXI89AABN'
	..'NNE9AAAMAACAPwAA7bJLPwAAISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTk5MDAwNzU4MzkGwZGRIQNFeWUH7AMEf4WEBv8AAAoAAAAAAAC0wgAAAAAKj5p5xIXrmUBkuxbCCgAAAD6amZk+AAAAPiELU3BlY2lhbE1lc2ghCE1lc2hUeXBlCgAAgD8A'
	..'AAAAAAAAAAoAAAAAAACAPwAAAAAKLr07swAAAAAAAIA/FgEAAQACAwEBAQACBAUCDAACBgcICQoLDA0ODxAREhMUFRYXGBkaGxwFAgsAAh0HCAkKCx4NHw8QESAVIRcYGSIbIwUCDAACJCUSCQoLJg0fDxAnIBEoFSkXKhkrGywBAQEAAi0uBgUAAi8wMTIQMxAVNDUH'
	..'BAA2NzgxOToVOzwIDgACPTY3ODE+PxVAQUJDA0RFRhBHSElKS0xNTE4QTwgJADY3ODE5Oj5QFVFSOlNUVVZXWDwIDQACWTY3ODE+PxVAUlpBW0NcRF1GEEdISV1OEF4ACwACX2AQYTpiY2RlB2ZnaD5pFWprOhsxbAwEADAxbW5vMXAxNQ0DADY3ODEVO08OCQACcTY3'
	..'ODETchU7UlpTc1VmdFpPDggAAnU2NzgxPnYTchV3U3hVeWwMBAAwMW0xbzFwMTURAwA2NzgxFTtPEgkAAnE2NzgxE3IVO1JaU3NVZnRaTxIIAAJ1Njc4MT52E3IVd1N4VXleAAsAAnphOmJ7ZHwHfWdoJ34+fxN+FYBrOoEVAQCCIAA=')

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

function relocate()
	local spawns = {}
	for _, v in next, workspace:GetDescendants() do
		if v:IsA("SpawnLocation") then
			table.insert(spawns, v)
		end
	end
	return #spawns > 0 and spawns[math.random(1, #spawns)].CFrame + (Vector3.yAxis * 5) or CFrame.new(0, 100, 0)
end

function clone(inst)
	inst.Archivable = true
	for _, v in next, inst:GetDescendants() do
		v.Archivable = true
	end
	return inst:Clone()
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

function EWait(num)
	local num = num or 0
	local t = os.clock()
	repeat
		heartbeat:Wait()
	until os.clock() - t >= num
end

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
	s.PlayOnRemove = true
	deb:AddItem(p, 0)
end

local rnd = Random.new(tick())

local CFRAMES = {
	CHARACTER = {}
}
local counterdeb = 0

function counter(counterlist)
	if(tick() - counterdeb) < 5 then
		return
	end
	counterdeb = tick()
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
			EWait(rnd:NextNumber(0.13, 0.3))
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

	local EyeOffset = CFrame.new(Vector3.new(-0.125, 0.25, -0.57 + (-0.125/2 * 0.75)))
	local eye = script.Eye:Clone()
	eye.Color = Color3.new(1, 1, 1)
	eye.Size = eye.Size

	local eyeparticle = script.COUNTER.Particles.EYE_Glare:Clone()
	local con

	eye.Anchored = true
	eye.CanCollide = false
	con = heartbeat:Connect(function()
		eye.CFrame = CFRAMES.CHARACTER.Head * EyeOffset
	end)
	local att = Instance.new("Attachment", eye)
	eyeparticle.Parent = att
	eye.Parent = workspace
	EmitParticle(eyeparticle, 3)
	task.delay(3, function()
		local del = eyeparticle.Lifetime.Max
		ts:Create(eye, TweenInfo.new(eyeparticle.Lifetime.Min, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Transparency = 1
		}):Play()
		con:Disconnect()
		con = nil
		deb:AddItem(eye, del)
	end)

	newsoundat(cframe, 1085317309, 2, math.random(90, 110)/100)
	newsoundat(cframe, 2370794297, 4, math.random(90, 110)/100)
end

local connections = {}
local joints = {}
local limbs = {}
local oldcframes = CFRAMES
local hum = nil
local char = nil
local orighp = 0
local cbackup = clone(owner.Character)

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
	nc.Archivable = false
	nc.Name = tostring({}):match("0x.*"):sub(3,17)
	owner.Character = nc
	char = nc
	nc.Parent = workspace
	CFRAMES = oldcframes
	nc:PivotTo(CFRAMES.CHARACTER.Character)
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

	task.wait()
	if(nc and nc:IsDescendantOf(workspace))and(owner.Character ~= nc)then
		pcall(game.Destroy, nc)
		pcall(game.Destroy, char)
		pcall(game.Destroy, owner.Character)
		nc = remakechar()
	end
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
		c(`character_ancestry_tamper({char and tostring(char.Parent) or "nil?"})`)
	end

	if(char and char:IsDescendantOf(workspace))then
		if(not hum or not hum:IsDescendantOf(char))then
			c("humanoid_removal")
		end
		if(hum.Health ~= orighp)then
			c("health_tampering")
		end
		if(hum.Health <= 0)then
			c("humanoid_death")
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
	if(not char)then char = owner.CharacterAdded:Wait() end
	repeat task.wait() until char and char:IsDescendantOf(workspace)
	char:WaitForChild("HumanoidRootPart")

	CFRAMES.CHARACTER.Character = char:GetPivot()
	CFRAMES.CHARACTER.Head = char.Head.CFrame

	hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
	task.defer(function()
		if(char:FindFirstChildOfClass("ForceField"))then
			char:FindFirstChildOfClass("ForceField"):Destroy()
		end
	end)

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

newchar()
owner.CharacterAdded:Connect(newchar)