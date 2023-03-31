-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 4840 characters
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


local Objects = Decode('AADHIQZGb2xkZXIhBE5hbWUhD0Q0QzogTG92ZSBUcmFpbiEFTW9kZWwhCkxvdmUgVHJhaW4hCldvcmxkUGl2b3QEu7y9IQRQYXJ0IQZHcm91bmQhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhCkJyaWNrQ29sb3IH8QMhBkNGcmFtZQQcvr8hCkNhbkNvbGxpZGUCIQpD'
	..'YXN0U2hhZG93IQVDb2xvcgb//ychCE1hc3NsZXNzIiEITWF0ZXJpYWwDAAAAAADAmEAhC09yaWVudGF0aW9uCgAAAAAAALRCAAAAACEIUG9zaXRpb24KMIagQrNcxD+4yYzCIQhSb3RhdGlvbiEEU2l6ZQoAAIhB46WbPQAAiEEhClRvcFN1cmZhY2UhDFRyYW5zcGFy'
	..'ZW5jeQMAAAAAAADwPyEFU2hhcGUDAAAAAAAAAEAhD1BhcnRpY2xlRW1pdHRlciEJTGluZXMoNTApKAIAAAAA/x0AAACAP/8dACEERHJhZyEHRW5hYmxlZCEITGlmZXRpbWURAACgPwAAoD8hDUxpZ2h0RW1pc3Npb24hBFJhdGUDAAAAAAAAWUApAgAAAADNzMw9zczM'
	..'PQAAgD8AAAAAAAAAACEFU3BlZWQRAADIQQAAyEEhC1NwcmVhZEFuZ2xlCwAAyEEAAMhBIQdUZXh0dXJlIRdyYnhhc3NldGlkOi8vMTAxNjEwODc3MyEJRW1pdERlbGF5IQlFbWl0Q291bnQDAAAAAAAASUAhCkF0dGFjaG1lbnQhClBvaW50TGlnaHQhCkJyaWdodG5l'
	..'c3MDAAAAAAAACEAG/6oAIQdTaGFkb3dzIQVSYW5nZQMAAAAAAAAkQCEEQmVhbQREvL0KAAAAAAAAtEIAALTCCpZsn0IiJWZB7fyMwgoAALTCAAC0QgAAAAAKAADIQQAAgD8AAIA/IQZCb3R0b20ESsDBCgAAtEIW/hm/AAAAAAoAAEBBAAAAAAAAAAAhBlNwYXJrcyEM'
	..'QWNjZWxlcmF0aW9uCgAAAACE6/1AAAAAACgCAAAAAP8uAAAAgD//LgADAAAAAAAAFEARAACAPwAAgD8DAAAAAABYgUAhCFJvdFNwZWVkEQCAJsQAgCZEEQAAtMMAALRDKQQAAAAAvQQcPwAAAABN2Rs+Dm3aPgAAAAAXySU+RKH5PQAAAAAAAIA/AAAAAAAAAAARM7Oe'
	..'QTOznkELAAC0QwAAtMMhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9NzM4NjkxMDYyOSEJVGltZVNjYWxlAwAAAAAAAOA/KQMAAAAAAAAAAAAAAADxQgA/AACAPwAAAAAAAIA/AAAAAAAAAAAhE1ZlbG9jaXR5SW5oZXJpdGFuY2UDAAAAAAAA9D8hBUxp'
	..'Z2h0KAIAAAAA/5QpAACAP/+UKQMAAAAAAGr4QCEMTG9ja2VkVG9QYXJ0EQDjCkcA4wpHEQAASEIAAEhCEQAAAAAAAAAAISlodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTI3NzQ5NTY4MikCAAAAAJqZGT8AAAAAAACAP5qZGT8AAAAAIQNUb3AEasLDCgAA'
	..'tELJ/Rm/AAAAAAoAAIjBAAAAAAAAAAAhC0F0dGFjaG1lbnQwIQtBdHRhY2htZW50MSgCAAAAAP+LJQAAgD//iyUhCkZhY2VDYW1lcmEhFnJieGFzc2V0aWQ6Ly80NTcxMDI4MTMhDVRleHR1cmVMZW5ndGgpBAAAAAAAAAAAAAAAACwLPD8AAAAAAAAAAL6FWT8AAGg/'
	..'AAAAAAAAgD8AAIA/AAAAACEGV2lkdGgwAwAAAGBmZtY/IQZXaWR0aDEDAAAAQDMzwz8hB1pPZmZzZXQDAAAAoJmZub8hBkNlbnRlcgR6xMUKAAAgQQAAAAAAAAAAIQVMVEhpdAR9xMUKAADCwsN+/z8AAJ/DCgAAgD8AAIA/AACAPyEMTFQgSGl0ZWZmZWN0BILGxwoA'
	..'ALRCAAA0QwAAAAAKAAAAAEBddT4A0n+/IQREb3RzKAIAAAAA/6oAAACAP/+qAAMAAAAAAIAqQBHNzEw/zcxMPwMAAAAAAEBfQCkFAAAAABOeij+4JeA+av+cPeDxaz7g8Ws+A7X/PuDxaz7sCdo9qGBPPxiRDT6ofgU9AACAPwAAAAAAAAAAEQAAcEEAAAxCCwAANEQA'
	..'ADREISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTgyNTQ4MjYxOTIpAwAAAAAAAAAAAAAAAKTGLD8AAAAAAAAAAAAAgD/wvXc/AAAAACEITWFya3NIaXQoAwAAAAD/VQCkxTA//6oAAACAP/9VABGamZk+mpmZPgMAAAAAAAAuQCkDAAAAAAAAAAAAAAAA'
	..'8AKaPv//Q0AAAAAAAACAPwAAPEAAAAAAISpodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTgyNTQ3MDgyMTMpBQAAAAAAAIA/AAAAAGVqej4AAAAAAAAAALK3GT8AAAAAAAAAAOfiJD+amWk/AAAAAAAAgD8AAIA/AAAAAAMAAAAAAAAEQCEJTWFya3NIaXQy'
	..'KAMAAAAA/1UAsDIxP/9rJwAAgD//VQAhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9ODIxNjE4Mjc5MiEGQmx1bnQyKAIAAAAAAAAAAACAPwAAABEAAAA/AAAAPxEAAAAAAAC0QykDAAAAAAAAAAAAAAAA9K6GPvmsW0AAAAAAAACAP6bIZ0AAAAAAISpo'
	..'dHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTgyMjMxMjg4NzApBQAAAAAAAIA/AAAAAHtEUT6amQk/AAAAAFhe6T4zM1s/AAAAAD70Fz+amWk/AAAAAAAAgD8AAIA/AAAAACEFU291bmQhEUxvdmV0cmFpbkFjdGl2YXRlIRJSb2xsT2ZmTWF4RGlzdGFuY2UD'
	..'AAAAAAAAaUAhElJvbGxPZmZNaW5EaXN0YW5jZQMAAAAAAAA0QCELUm9sbE9mZk1vZGUhB1NvdW5kSWQhF3JieGFzc2V0aWQ6Ly84OTc1MzUzMDIyIQZWb2x1bWUhEExvdmV0cmFpbkRpc2FibGUhF3JieGFzc2V0aWQ6Ly84OTc1MzUzNzExIQ1Mb3ZldHJhaW5JZGxl'
	..'IQZMb29wZWQhF3JieGFzc2V0aWQ6Ly83NDYyMTcwODQ4IQ9Mb3ZldHJhaW5XaW5kdXAhF3JieGFzc2V0aWQ6Ly84OTc1MzUyMzA0IQtSZWRpcmVjdGlvbgMAAAAAAIBbQAMAAAAAAAA+QCEXcmJ4YXNzZXRpZDovLzg2MDEyNzYzMzQhFVBpdGNoU2hpZnRTb3VuZEVm'
	..'ZmVjdCEGT2N0YXZlIRJUcmVtb2xvU291bmRFZmZlY3QhBURlcHRoIQREdXR5IRNMb3ZldHJhaW5XaW5kdXBDYWxsIRdyYnhhc3NldGlkOi8vODM4NzM4NTg4NgqWbJ9CMyVmQez8jMIKAAAAAAAAgL+lX5AQCgAAAAClX5AQAACAvwrh//+u7/8PsAAAgL8KAAAAAAAA'
	..'gD/v/w+wCmP8fz8AABs0FQIsPAoWAiy8AIDmN2T8fz8KY/x/P7BfGzS/ASw8CsABLLz9f+Y3ZPx/PwoAAIA/AAAAAAAAAAAKAAAAAAAAgD8AAAAACgAAgL8AAAAAAAAAAAoAAAAAAAAAAAAAgL8bAQABAAIDBAECAAIFBgcIAhAAAgkKCwwNDg8QERIRExQVFhcYGRob'
	..'HB0aHh8gCyEiIyQlAwsCAiYTJygiKREqKywiLS4eLzAxMjM0NTYLNzg5AwAAOgMEADs8Ez0+Fj9ACAEQAAJBCgsMDQ5CEBESERMUFRYXGBlDG0QdRR5GIAshIiMkOQcEAAJHDkgZSRtKJQgQAAJLTE0TTihPKlAsIi1RUlMdVB5VMFYyVzRYWVohW1xdJQgMAAJeE18o'
	..'YCpQLCJhFi1AUmIdYzBkNGUhZjkHBAACZw5oGWkbakEHCQATbW4WLCI0b3BaIXFyc3R1dnc5BwMAAngOeRt6CAEHAAJ7CgsOfBt9Hn4gCyEiOQ4EAAJ/DoAZgRuCJQ8QAQKDE4QohSkRKoYsImEWLYdSVB1UHogwiTKKNIshjHYkN0AlDwwBAo0TjikRKo8sImEWLZAe'
	..'kTBkNJIhk3aUNyIlDwwBApUTlikRKo8sImEWLZAekTBkNJchk3aUNyIlDwwBApgTmSkRKpphFi2QHZsenDBkNJ0hnnYiNyKfAQYAAqChoqOkpTymp6gknwEGAAKpoaKjpKU8pqqoJJ8BBwACq6wWoaKjpKU8pq2oIp8BBgACrqGio6SlPKavqCSfAQYAArChsaOypTym'
	..'s6g8tBgBALUithgCALdauCKfAQYAArmhoqOkpTymuqgkAgxrCAxsCw==')
local templates = Objects[1]
templates.Parent = nil
local ltmode = false
if(not owner)then
	getfenv().owner = script.Parent:IsA("PlayerGui") and script.Parent.Parent or game:GetService('Players'):GetPlayerFromCharacter(script.Parent)
end
if(not NLS)then
	getfenv().NLS = function(code, parent) return Instance.new("LocalScript", parent) end
end

function redirectdamage(hum,dam)
	pcall(function()
		local root = hum.Parent:FindFirstChild("HumanoidRootPart")
		if(not root)then
			return
		end
		local fx = templates.LTHit:Clone()
		fx.Parent = workspace
		fx.CanCollide = false
		fx.Anchored = true
		fx.CanQuery = false
		fx.CanTouch = false
		fx.Position = root.Position:Lerp(owner.Character.HumanoidRootPart.Position, 0.3)
		for i,v in next, fx:GetDescendants() do
			pcall(function()
				v:Emit(math.random(1,30))
			end)
		end
		game:GetService("Debris"):AddItem(fx, 5)
		local snd = templates.Redirection:Clone()
		snd.Parent = hum.Parent:FindFirstChild("HumanoidRootPart")
		snd.Pitch = math.random(90,110)/100
		snd.Volume = 1
		snd:Play()
		game:GetService("Debris"):AddItem(snd, snd.TimeLength*snd.Pitch)
		local vel = Instance.new("BodyVelocity", root) 
		vel.maxForce = Vector3.new(9999999999999,9999999999999,9999999999999)
		vel.velocity = CFrame.new(owner.Character.HumanoidRootPart.Position,root.Position).lookVector*50
		game:GetService("Debris"):AddItem(vel,0.1)
		hum:TakeDamage(dam)
	end)
end

function GetNearestHumanoid(pos,minimumDistance)
	local closestMagnitude = minimumDistance or math.huge
	local closestPlayer
	for i,v in next, workspace:GetDescendants() do
		if(v:IsA("Humanoid") and v:FindFirstAncestorOfClass("Model"))then
			local Character = v:FindFirstAncestorOfClass("Model")
			if(Character ~= owner.Character)then
				local humanoid = Character:FindFirstChildOfClass("Humanoid")
				local HRP = Character:FindFirstChild("HumanoidRootPart")
				if humanoid and (humanoid.Health > 0) and HRP then
					local mag = (pos - HRP.Position).Magnitude
					if (mag <= closestMagnitude) then
						closestPlayer = humanoid
						closestMagnitude = mag
					end
				end
			end
		end
	end
	return closestPlayer
end

function effects(bc)
	local windup = templates.LovetrainWindup:Clone()
	windup.Parent = owner.Character.HumanoidRootPart
	windup:Play()
	game:GetService("Debris"):AddItem(windup,windup.TimeLength*windup.Pitch)
	task.wait(windup.TimeLength/1.5)
	local activate = templates.LovetrainActivate:Clone()
	activate.Parent = owner.Character.HumanoidRootPart
	activate:Play()
	game:GetService("Debris"):AddItem(activate,activate.TimeLength*activate.Pitch)
	local idle = templates.LovetrainIdle:Clone()
	idle.Parent = owner.Character.HumanoidRootPart
	idle:Play()
	local mus = Instance.new("Sound", owner.Character.HumanoidRootPart) mus.SoundId = "rbxassetid://12704426010" mus.Volume = 4 mus.Pitch = .5 mus.Looped = true mus:Play()
	local lt = templates:FindFirstChild("Love Train"):Clone()
	lt:WaitForChild("Ground").CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0)
	lt.Parent = owner.Character
	local w = Instance.new("Weld", lt)
	w.Part0 = lt.Ground
	w.Part1 = owner.Character.HumanoidRootPart
	w.C0 = CFrame.new(0, -2, 0)
	for _, v in next, lt.Ground:GetDescendants() do
		if v:IsA("ParticleEmitter") or v:IsA("PointLight") then
			v.Enabled = true
		end
	end
	for i = 1, bc do
		local b = templates.Beam:Clone()
		b.Center.Position = Vector3.new(10, Random.new():NextInteger(-4, 4), Random.new():NextInteger(-4, 4))
		b.CanCollide = false
		b.CanQuery = false
		b.CanTouch = false
		b.Massless = true
		b.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0) * CFrame.Angles(0, 0, -(math.pi / 2))
		local ap = Instance.new("AlignPosition")
		ap.RigidityEnabled = false
		ap.Responsiveness = 800
		ap.MaxVelocity = 1e6
		ap.Attachment0 = b.Center
		ap.Attachment1 = owner.Character:FindFirstChild("WaistCenterAttachment", true)
		ap.Parent = b
		local bg = Instance.new("BodyGyro")
		bg.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, 0, -(math.pi / 2))
		bg.P = 10000
		bg.D = 100
		bg.MaxTorque = Vector3.new(10000, 10000, 10000)
		b.Parent = lt
		coroutine.wrap(function()
			local pcf = owner.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, 0, -(math.pi / 2))
			while ltmode == true and b:FindFirstChild("Beam") do
				local b2 = b.Beam
				local tto = Random.new():NextNumber(0.5, 2)
				local tb = game:GetService("TweenService"):Create(b2, TweenInfo.new(tto, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, true), {Width0 = 0, Width1 = 0})
				tb:Play()
				tb.Completed:Wait()
				if b and b:FindFirstChild("Center") then
					b.Center.Position = Vector3.new(10, Random.new():NextInteger(-4, 4), Random.new():NextInteger(-4, 4))
					b.Bottom.Light.Enabled = false
					b.Bottom.Sparks.Enabled = false
				end
				task.wait(tto)
				if b and b:FindFirstChild("Bottom") then
					b.Bottom.Light.Enabled = true
					b.Bottom.Sparks.Enabled = true
				end
			end
		end)()
		bg.Parent = b
	end
	local lasthp = owner.Character:FindFirstChildOfClass("Humanoid").Health
	local ondam = owner.Character:FindFirstChildOfClass("Humanoid").HealthChanged:Connect(function()
		local damage = lasthp-owner.Character:FindFirstChildOfClass("Humanoid").Health
		if(damage>0)then
			owner.Character:FindFirstChildOfClass("Humanoid").Health = lasthp
			local hum = GetNearestHumanoid(owner.Character.HumanoidRootPart.Position, 20)
			if(hum)then
				redirectdamage(hum, damage)
			end
		else
			lasthp = owner.Character:FindFirstChildOfClass("Humanoid").Health
		end
	end)
	repeat
		task.wait()
	until ltmode == false
	for _, v in next, lt.Ground:GetDescendants() do
		if v:IsA("ParticleEmitter") or v:IsA("SurfaceLight") then
			v.Enabled = false
		end
	end
	for _, v in next, lt:GetChildren() do
		if v.Name == "Beam" then
			local at1 = v.Beam.Attachment1
			game:GetService("TweenService"):Create(at1, TweenInfo.new(), {Position = Vector3.new(12, 0, 0)}):Play()
		end
	end
	pcall(game.Destroy,idle)
	pcall(game.Destroy, mus)
	pcall(function()
		ondam:Disconnect()
	end)
	coroutine.wrap(function()
		task.wait(1)
		lt:Destroy()
	end)()
end

local keyrem = Instance.new("RemoteEvent", owner.Character)
local LS = NLS([[
	task.wait()
	local mous = owner:GetMouse()
	mous.KeyDown:Connect(function(k) script.rem.Value:FireServer({key = tostring(k), hit = mous.Hit, target = mous.Target, up = false}) end)
	mous.KeyUp:Connect(function(k) script.rem.Value:FireServer({key = tostring(k), hit = mous.Hit, target = mous.Target, up = true}) end)
]],owner.PlayerGui)
local a = Instance.new("ObjectValue", LS)
a.Name = "rem"
a.Value = keyrem

keyrem.OnServerEvent:Connect(function(plr, data)
	if(plr ~= owner)then
		return
	end
	if(data.key == "f")and(data.up)then
		ltmode = not ltmode
		if(ltmode)then
			effects(15)
		else
			local activate = templates.LovetrainDisable:Clone()
			activate.Parent = owner.Character.HumanoidRootPart
			activate:Play()
			game:GetService("Debris"):AddItem(activate,activate.TimeLength*activate.Pitch)
		end
	end
end)

if(game:GetService('RunService'):IsStudio())then
	task.wait(2)
	ltmode = true
	effects(15)
end