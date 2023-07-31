if(not owner)then
	getfenv(1).owner = script.Parent:IsA("PlayerGui") and script.Parent.Parent or game:GetService('Players'):GetPlayerFromCharacter(script.Parent)
end

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
		
		[1] = function(Modifier)
			return Parse('s'..Modifier)
		end,
		
		[2] = function(Modifier)
			return Modifier ~= 0
		end,
		
		[3] = function()
			return Parse('d')
		end,
		
		[4] = function(_,Index)
			table.insert(CFrameIndexes,{Index,Parse(('I'..Flags[1]):rep(3))})
		end,
		
		[5] = {CFrame.new,Flags[5] and 'dddddddddddd' or 'ffffffffffff'},
		
		[6] = {Color3.fromRGB,'BBB'},
		
		[7] = {BrickColor.new,'I2'},
		
		[8] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = ColorSequenceKeypoint.new(Parse('f'),Color3.fromRGB(Parse('BBB')))
			end
			return ColorSequence.new(kpts)
		end,
		
		[9] = function(Modifier)
			local len = Parse('I'..Modifier)
			local kpts = table.create(len)
			for i = 1,len do
				kpts[i] = NumberSequenceKeypoint.new(Parse(Flags[5] and 'ddd' or 'fff'))
			end
			return NumberSequence.new(kpts)
		end,
		
		[10] = {Vector3.new,Flags[5] and 'ddd' or 'fff'},
		
		[11] = {Vector2.new,Flags[5] and 'dd' or 'ff'},
		
		[12] = {UDim2.new,Flags[5] and 'di2di2' or 'fi2fi2'},
		
		[13] = {Rect.new,Flags[5] and 'dddd' or 'ffff'},
		
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
		
		[16] = {PhysicalProperties.new,Flags[5] and 'ddddd' or 'fffff'},
		
		[17] = {NumberRange.new,Flags[5] and 'dd' or 'ff'},
		
		[18] = {UDim.new,Flags[5] and 'di2' or 'fi2'},
		
		[19] = function()
			return Ray.new(Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')),Vector3.new(Parse(Flags[5] and 'ddd' or 'fff')))
		end
		
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


local Objects = Decode('AAAxIQlTY3JlZW5HdWkhBE5hbWUhAnVpIQxSZXNldE9uU3Bhd24CIQ5aSW5kZXhCZWhhdmlvcgMAAAAAAADwPyEFRnJhbWUhEEJhY2tncm91bmRDb2xvcjMGLCwsIQxCb3JkZXJDb2xvcjMG////IQhQb3NpdGlvbgyMLFU/AADUmTs/AAAhBFNpemUMAAAAAL0AAAAA'
	..'ANMAIQdUZXh0Qm94IQN1cmwMZC6ZPQAA0yYxPQAADAAAAACfAAAAAAApACEOQ3Vyc29yUG9zaXRpb24DAAAAAAAA8L8hBEZvbnQDAAAAAAAACEAhEVBsYWNlaG9sZGVyQ29sb3IzIQ9QbGFjZWhvbGRlclRleHQhA1VSTCEEVGV4dCEAIQpUZXh0Q29sb3IzIQhUZXh0'
	..'U2l6ZQMAAAAAAAAzQCELVGV4dFdyYXBwZWQiIQRjb21wDGQumT0AAPjUjz4AACELQ29tcHJlc3Npb24hBXNjYWxlDGQumT0AALw3BD8AACEFU2NhbGUhClRleHRCdXR0b24hA2dlbgxkLpk9AAC3v0c/AAAMAAAAAEMAAAAAACIAIQhHZW5lcmF0ZSEDY2xyDOnsBD8A'
	..'ALe/Rz8AAAwAAAAASwAAAAAAIgAhBUNsZWFyBwEAAwACAwQFBgcIAQQACQoLDA0ODxARAg0AAhIJCgsMDRMPFBUWFxgZDBobHB0eDB8gISIRAg0AAiMJCgsMDSQPFBUWFxgZDBolHB0eDB8gISIRAg0AAiYJCgsMDScPFBUWFxgZDBooHB0eDB8gISIpAgoAAioJCgsM'
	..'DSsPLBcYHC0eDB8gISIpAgoAAi4JCgsMDS8PMBcYHDEeDB8gISIA')

local ui = Objects[1]
ui.Parent = owner.PlayerGui

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function ball(url, threshold, scale)
	local start = tick()

	scale = 0.05 * scale
	threshold = math.clamp(tonumber(threshold) or 0.05, 0.05, 1)

	print("sending request to api")

	local encodedurl = game:GetService("HttpService"):UrlEncode(url);
	local json = game:GetService("HttpService"):GetAsync("https://zv7i.dev/imagejson?url="..encodedurl.."&compress="..(threshold or 0.05))
	
	if(not json or not tostring(json) or tostring(json):lower():find("error"))then
		return error(tostring(json))
	end

	print("decoding json")

	local data = game:GetService("HttpService"):JSONDecode(json)
	
	if(not data or typeof(data) ~= "table")then
		return error(data)
	end

	print("compressed "..data.width*data.height.." pixels to "..data.cuboids.." pixels")
	print("loading image "..url.." with "..(threshold*100).."% compression took "..round(tick() - start, 2).." seconds")

	start = tick()

	local scale = scale or 0.1
	local tpos = owner.Character:FindFirstChild("HumanoidRootPart").Position
	scale = (scale / 2) / 0.08
	local cuboids = data

	local ExamplePart = Instance.new("Part")
	local SurfaceGui = Instance.new("SurfaceGui", ExamplePart)
	local TextLabel = Instance.new("TextBox", SurfaceGui)
	SurfaceGui.Adornee = ExamplePart
	SurfaceGui.Face = "Top"

	TextLabel.Size = UDim2.new(0.5, 0, 0.75, 0)
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.Position = UDim2.new(0.5,0,0.5,0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextStrokeTransparency = 0
	TextLabel.Font = Enum.Font.Highway
	TextLabel.TextEditable = false
	TextLabel.Rotation = 90
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true

	ExamplePart.Anchored = true
	ExamplePart.Size = Vector3.new(data.width * scale, scale + 0.05, data.height * scale) * 0.08
	ExamplePart.Color = Color3.new()
	ExamplePart.Position = tpos + Vector3.new((data.width / 2) * scale, 0, (data.height / 2) * scale) * scale
	ExamplePart.CanCollide = false
	ExamplePart.Transparency = 0.5
	ExamplePart.Position = tpos - Vector3.new(-ExamplePart.Size.X / 2, 0, -ExamplePart.Size.Z / 2)
	ExamplePart.Parent = workspace

	for i,v in next, data.data do
		if i % 80 == 0 then
			task.wait()
			TextLabel.Text = tostring(math.floor((i / data.cuboids) * 100)) .. "% completed"
		end

		local x = (v["startX"] + v["endX"])/50 local sizex = ((v["endX"]-v["startX"])*0.08)+0.08
		local z = (v["startZ"] + v["endZ"])/50 local sizez = ((v["endZ"]-v["startZ"])*0.08)+0.08

		local c = Instance.new("Part")
		c.CanCollide = false
		c.CastShadow = false
		c.CanQuery = false
		c.CanTouch = false
		c.Anchored = true
		c.TopSurface = "Smooth"
		c.Position = tpos + Vector3.new(x*2,0,z*2) * scale
		c.Size = Vector3.new(sizex,0.08,sizez) * scale
		c.Color = Color3.new(v["color"].R, v["color"].G, v["color"].B)
		c.Parent = script
	end

	table.clear(data)
	pcall(game.Destroy, ExamplePart)

	print("image loaded. took "..round(tick() - start, 2).." seconds")
end

function clearparts()
	for i, v in next, script:GetChildren() do
		if i % 350 == 0 then
			task.wait()
		end
		pcall(game.Destroy, v)
	end
end

local handler = NLS([=[
local rem = script:WaitForChild("RemoteEvent")
local f = script.Parent.Frame
local urlt = f.url
local compt = f.comp
local scalet = f.scale
local gen = f.gen
local clear = f.clr

gen.MouseButton1Click:Connect(function()
	rem:FireServer("gen", {urlt.Text, compt.Text, tonumber(scalet.Text)})
end)

clear.MouseButton1Click:Connect(function()
	rem:FireServer("clr", true)
end)
]=], ui)

local remote = Instance.new("RemoteEvent", handler)
remote.OnServerEvent:Connect(function(player,type,tbl)
	if(player ~= owner)then
		return
	end
	if(not tbl)then
		return
	end
	if(type == "gen")then
		ball(tbl[1], tbl[2], tbl[3] or 1)
	elseif(type == "clr")then
		clearparts()
	end
end)