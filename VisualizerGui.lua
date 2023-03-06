task.wait()
-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 1656 characters
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


local Objects = Decode('AABPIQlTY3JlZW5HdWkhBE5hbWUhClZpc3VhbGl6ZXIhBUZyYW1lIQZDb3JuZXIhC0FuY2hvclBvaW50CwAAAD8AAAA/IRBCYWNrZ3JvdW5kQ29sb3IzBv///yEIUG9zaXRpb24M9ihcPwAAObRIPwAAIQRTaXplDMdLNz4FAGiRrT4FACEIVUlDb3JuZXIGQ0NDDBcm'
	..'XD8AAASoSD8AAAywEDc+AAC6zq0+AAAhB1RleHRCb3ghB0lERnJhbWUGLCwsDLZ02T4AALJHYT0AAAwnR1U/AADNzMw9AAAhBlpJbmRleAMAAAAAAAAAQCEQQ2xlYXJUZXh0T25Gb2N1cwIhDkN1cnNvclBvc2l0aW9uAwAAAAAAAPC/IQRGb250AwAAAAAAAAhAIRFQ'
	..'bGFjZWhvbGRlckNvbG9yMyEPUGxhY2Vob2xkZXJUZXh0IRNJRCA6IFZvbHVtZSA6IFBpdGNoIQRUZXh0IQAhClRleHRDb2xvcjMhClRleHRTY2FsZWQiIQhUZXh0U2l6ZQMAAAAAAAAxQCELVGV4dFdyYXBwZWQMAAAAPwAAAAAAPwAADAAAgD8CAAAAgD8CACEEUGxh'
	..'eQwxP2w/AACyR2E9AAAMcT0KPgAAzczMPQAAIQpUZXh0QnV0dG9uIQlQbGF5UGF1c2UhFkJhY2tncm91bmRUcmFuc3BhcmVuY3kDAAAAAAAA8D8MAACAPwAAAACAPwAAIQPilrYDAAAAAAAALEAMIuwAPwAAZbnuPgAADLGqfT8AABkDNj8AACEDVmlzIRBDbGlwc0Rl'
	..'c2NlbmRhbnRzDAXO/j4AAFsa/z4AAAwFzn4/AABeGn8/AAAhDFVJTGlzdExheW91dCENRmlsbERpcmVjdGlvbgMAAAAAAAAAACETSG9yaXpvbnRhbEFsaWdubWVudCEJU29ydE9yZGVyIRFWZXJ0aWNhbEFsaWdubWVudCEERGF0YQwi7AA/AAAimmk/AAAMsap9PwAA'
	..'5C4zPgAAIQlUZXh0TGFiZWwhBVRpdGxlDO///z4AADYjnD4AAAz0/38/AAA8Ixw/AAAhDlRleHRYQWxpZ25tZW50IQtEZXNjcmlwdGlvbgzv//8+AACaEU4/AAAM9P9/PwAAmLnHPgAAIRBUZXh0VHJhbnNwYXJlbmN5AwAAAAAAAOA/IQxUZXh0VHJ1bmNhdGUbAQAB'
	..'AAIDBAEFAAIFBgcICQoLDA0OAgAABAEEAAYHCA8KEAwRDgQAABIEEAACEwYHCBQKFQwWFxgZGhscHR4fCSAhIiMkCSUmJygpJg4GAAAEBgUAAgUGBwgJCioMKw4IAAAEBAYAAiwGBwgUCi0MLhcYDgoAAC8KDQACMAYHCAkxMgoqDDMXGB0eIjQkCSUmJzUpJgQKBQAC'
	..'BQYHCAkKKgwrDg0AAAQEBgACAwYHCBQKNgw3FxgODwAABA8FAAIFBgcICQoqDCsOEQAABA8IAAI4BgcICTEyOSYKOgw7Fxg8EwQAPT4/GEAYQRgOEwAABAQGAAJCBgcIFApDDEQXGA4WAAAEFgUAAgUGBwgJCioMKw4YAABFFg0AAkYGBwgJMTIKRwxIFxgdHiQJJSYn'
	..'NSkmST5FFg8AAkoGBwgJMTIKSwxMFxgdHiQJJSYnNU1OTzIpJkk+AA==')
local ui = Objects[1]
ui.ResetOnSpawn = false
ui.Parent = owner.PlayerGui
if(not owner)then
	getfenv().owner = script.Parent:IsA("PlayerGui") and script.Parent.Parent or game:GetService('Players'):GetPlayerFromCharacter(script.Parent)
end

local client = NLS([[task.wait() local UserInputService = game:GetService("UserInputService")
local dragToggle
local dragInput
local dragSpeed
local dragStart
local dragPos
local startPos

function dragify(Frame)
	dragToggle = nil
	dragSpeed = 0.50
	dragInput = nil
	dragStart = nil
	dragPos = nil
	local function updateInput(input)
		local Delta = input.Position - dragStart
		local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.30), {Position = Position}):Play()
	end
	Frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UserInputService:GetFocusedTextBox() == nil then
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	Frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			updateInput(input)
		end
	end)
end

local ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"

script:WaitForChild("Heartbeat")

local tf = 0
local allowframeloss = false
local tossremainder = false
local lastframe = tick()
local frame = 1/120
ArtificialHB:Fire()

game:GetService("RunService").RenderStepped:connect(function(s, p)
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

local ui = script.Parent
local corner = ui.Corner
local mainframe = ui.Frame
local playpause = mainframe.Play.PlayPause
local visframe = mainframe.Visualizer.Vis
local idframe = mainframe.IDFrame
local dataframe = mainframe.Data
local tempframe = script.Frame
local pause = " ▌▌"
local play = "▶"
local paused = false
local maxdescriptionsize = 33
local id = 0
local volume = 1
local pitch = 1
local isediting = false
local music = nil

dragify(mainframe)

---------- customization ----------

local color = BrickColor.new('Medium stone grey').Color
local transparency = 0
local whitestuffs = {}

for i,v in next, ui:GetDescendants() do
	pcall(function()
		v.BackgroundTransparency = v.BackgroundTransparency + transparency
	end)
	pcall(function()
		v.TextTransparency = v.TextTransparency + transparency
	end)
	pcall(function()
		v.TextStrokeTransparency = v.TextStrokeTransparency + transparency
	end)
end

for i,v in next, ui:GetDescendants() do
	pcall(function()
		if(v.TextColor3 == Color3.new(1,1,1))then
			table.insert(whitestuffs, v)
		end
	end)
	pcall(function()
		if(v.BackgroundColor3 == Color3.new(1,1,1))then
			table.insert(whitestuffs, v)
		end
	end)
	pcall(function()
		if(v.PlaceholderColor3 == Color3.new(1,1,1))then
			table.insert(whitestuffs, v)
		end
	end)
end

for i,v in next, whitestuffs do
	local tbl = {self = v}
	pcall(function()
		if(v.TextColor3)then
			tbl.oldtextcolor3 = v.TextColor3
		end
	end)
	pcall(function()
		if(v.PlaceholderColor3)then
			tbl.oldplaceholdercolor3 = v.PlaceholderColor3
		end
	end)
	pcall(function()
		if(v.BackgroundColor3)then
			tbl.oldbackgroundcolor3 = v.BackgroundColor3
		end
	end)
	whitestuffs[i] = tbl
end

coroutine.wrap(function()
	while task.wait() do
		local was = color
		if(color == "rgb")then
			color = Color3.fromHSV(math.acos(math.cos((tick()/5)*math.pi))/math.pi,1,1)
		end
		for i,v in next, whitestuffs do
			pcall(function()
				if(v.oldtextcolor3 and v.oldtextcolor3 == Color3.new(1,1,1))then
					v.self.TextColor3 = color
				end
			end)
			pcall(function()
				if(v.oldplaceholdercolor3 and v.oldplaceholdercolor3 == Color3.new(1,1,1))then
					v.self.PlaceholderColor3 = color
				end
			end)
			pcall(function()
				if(v.oldbackgroundcolor3 and v.oldbackgroundcolor3 == Color3.new(1,1,1))then
					v.self.BackgroundColor3 = color
				end
			end)
		end
		if(was == "rgb")then
			color = was
		end
	end
end)()

-----------------------------------

local success, data = pcall(function() return game:GetService('MarketplaceService'):GetProductInfo(id) end)
if(success)and(data)then
	mainframe.Data.Title.Text = (data.Name and data.Name ~= "") and data.Name or "No Title"
	mainframe.Data.Description.Text = (data.Description and data.Description ~= "") and data.Description or "No Description"
else
	mainframe.Data.Title.Text = "No Title"
	mainframe.Data.Description.Text = "No Description"
end

playpause.MouseButton1Click:Connect(function()
	paused = not paused
end)

idframe.Focused:Connect(function()
	isediting = true
end)

function updatetx()
	if(not isediting)and(id~=0)then
		idframe.Text = tostring(id).." : "..tostring(volume).." : "..tostring(pitch)
	elseif(not isediting)and(id==0)then
		idframe.Text = ""
	end
end

idframe.FocusLost:Connect(function(enterPressed)
	isediting = false
	local function tonumberall(tbl)
		local faketbl = tbl
		for i,v in next, faketbl do
			faketbl[i] = tonumber(v)
		end
		return faketbl
	end
	local split = tonumberall(idframe.Text:split(" : "))
	local idd = split[1]
	local voll = split[2]
	local pitt = split[3]
	if(idd)then
		if(id ~= idd)then
			pcall(function()
				music.TimePosition = 0
			end)
		end
		id = idd
		local success, data = pcall(function() return game:GetService('MarketplaceService'):GetProductInfo(id) end)
		if(success)and(data)then
			mainframe.Data.Title.Text = (data.Name and data.Name ~= "") and data.Name or "No Title"
			mainframe.Data.Description.Text = (data.Description and data.Description ~= "") and data.Description or "No Description"
		else
			mainframe.Data.Title.Text = "No Title"
			mainframe.Data.Description.Text = "No Description"
		end
	end
	if(voll)then
		volume = voll
	end
	if(pitt)then
		pitch = pitt
	end
	updatetx()
end)

ArtificialHB.Event:Connect(function()
	corner.Position = mainframe.Position
	corner.Size = mainframe.Size+UDim2.fromOffset(5,5)
	playpause.Text = paused and pause or play
	updatetx()
	if(not music or not music:IsDescendantOf(ui))then
		music = Instance.new("Sound", ui)
		music.Volume = volume
		music.Pitch = pitch
		music.SoundId = "rbxassetid://"..id
		music.Looped = true
	elseif(music and music:IsDescendantOf(ui))then
		music.Volume = volume
		music.Pitch = pitch
		music.SoundId = "rbxassetid://"..id
		music.Looped = true
	end
	music.Playing = not paused
	if(mainframe.Data.Description.Text:len() > maxdescriptionsize)then
		local des = mainframe.Data.Description.Text:sub(1,maxdescriptionsize)
		mainframe.Data.Description.Text = des.."..."
	end
	local fr = tempframe:Clone()
	fr.Parent = visframe
	fr.Size = UDim2.new(0, 1.5, 0, music.PlaybackLoudness/3.7)
	game:GetService('Debris'):AddItem(fr, 5)
end)

owner.Chatted:Connect(function(msg)
	local m = msg
	if(msg:sub(1,3) == "/e ")then
		m = msg:sub(4)
	end
	local split = string.split(m,"!")
	if(string.lower(split[1]) == "col")then
		local colorr = split[2]
		if(colorr)then
			if(colorr ~= "rgb")then
				if(BrickColor.new(colorr))then
					color = BrickColor.new(colorr).Color
				end
			else
				color = "rgb"
			end
		end
	end
end)]], ui)

local Objects = Decode('AAAJIQVGcmFtZSEQQmFja2dyb3VuZENvbG9yMwb///8hD0JvcmRlclNpemVQaXhlbAMAAAAAAAAAACEEU2l6ZQwAAAAABQAAAAAAMgAhBlpJbmRleAMAAAAAAAAAQAEBAAQAAgMEBQYHCAkA'
	..'')
Objects[1].Parent = client