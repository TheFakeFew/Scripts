function liquidreq()
	local module = {}

	function regiontouchreq()
		-- made by zv7i

		local module = {}

		function module:Parse(part : Instance)
			if(typeof(part) ~= "Instance")then
				return error('Expected type Instance got '..typeof(part))
			end
			local returned = {}
			returned.Part = part
			returned.Touched = {}
			returned.TouchEnded = {}
			returned.Position = part.CFrame
			returned.Size = part.Size
			returned.AlwaysSetToPartSize = true
			returned.AlwaysSetToPartPosition = true
			returned.Parameters = OverlapParams.new()
			returned.TouchedCallback = nil
			returned.TouchEndedCallback = nil
			local touching = {}
			local connections = {}
			local ignoring = {}
			local PositionChanged = part:GetPropertyChangedSignal("CFrame"):Connect(function()
				if(returned.AlwaysSetToPartPosition)then
					returned.Position = part.CFrame
				end
			end)
			connections[#connections+1] = PositionChanged

			local SizeChanged = part:GetPropertyChangedSignal("Size"):Connect(function()
				if(returned.AlwaysSetToPartSize)then
					returned.Size = part.Size
				end
			end)
			connections[#connections+1] = SizeChanged

			local MainLoop = game:GetService('RunService').Heartbeat:Connect(function()
				if(returned.AlwaysSetToPartPosition)then
					returned.Position = part.CFrame
				end
				if(returned.AlwaysSetToPartSize)then
					returned.Size = part.Size
				end
			end)
			connections[#connections+1] = MainLoop

			function returned:AddIgnore(Ignored : Instance | {})
				if(typeof(Ignored) == "Instance")then
					table.insert(ignoring,Ignored)
				elseif(typeof(Ignored) == "table")then
					for i,v in next, Ignored do
						table.insert(ignoring,v)
					end
				else
					return error('Expected type Instance or table got '..typeof(Ignored))
				end
				returned.Parameters.FilterDescendantsInstances = ignoring
			end

			function returned:RemoveIgnore(Ignored : Instance | {})
				if(typeof(Ignored) == "Instance")then
					for i,v in next, ignoring do
						if v == Ignored then
							table.remove(ignoring,i)
						end
					end
				elseif(typeof(Ignored) == "table")then
					for i,v in next, Ignored do
						for ind,a in next, ignoring do
							if a == v then
								table.remove(ignoring,ind)
							end
						end
					end
				else
					return error('Expected type Instance or table got '..typeof(Ignored))
				end
				returned.Parameters.FilterDescendantsInstances = ignoring
			end

			function returned:SetParameters(Parameters : OverlapParams)
				if(typeof(Parameters) == "OverlapParams")then
					self.Parameters = Parameters
				else
					return error('Expected type OverlapParams got '..typeof(Parameters))
				end
			end

			function returned:SetSize(Size : Vector3)
				if(typeof(Size) ~= "Vector3")then
					return error('Expected type Vector3 got '..typeof(Size))
				end
				self.Size = Size
			end

			function returned:SetPosition(Position : Vector3 | CFrame)
				if(typeof(Position) == "CFrame")then
					self.Position = Position
				elseif(typeof(Position) == "Vector3")then
					self.Position = CFrame.new(Position.X,Position.Y,Position.Z)
				else
					return error('Expected type Vector3 or CFrame got '..typeof(Position))
				end
			end

			function returned.Touched:Connect(callback)
				if(typeof(callback) ~= "function")then
					return error('Expected type function got '..typeof(callback))
				end
				local self = returned
				self.TouchedCallback = callback
				local connection = game:GetService('RunService').Heartbeat:Connect(function()
					local parts = workspace:GetPartBoundsInBox(self.Position, self.Size, self.Parameters)
					for i,v in next, parts do
						if(not table.find(touching,v))and(v~=part)then
							table.insert(touching,v)
							callback(v)
						end
					end
				end)
				connections[#connections+1] = connection
				local connection2 = game:GetService('RunService').Heartbeat:Connect(function()
					local parts = workspace:GetPartBoundsInBox(self.Position, self.Size, self.Parameters)
					for i,v in next, touching do
						if(not table.find(parts,v))and(v~=part)then
							table.remove(touching,i)
							if(self.TouchEndedCallback)then
								self.TouchEndedCallback(v)
							end
						end
					end
				end)
				connections[#connections+1] = connection2
				local returned = {}
				function returned:Disconnect()
					connection:Disconnect()
					connection2:Disconnect()
				end
				return returned
			end

			function returned.TouchEnded:Connect(callback)
				if(typeof(callback) ~= "function")then
					return error('Expected type function got '..typeof(callback))
				end
				local self = returned
				self.TouchEndedCallback = callback
				local connection = game:GetService('RunService').Heartbeat:Connect(function()
					local parts = workspace:GetPartBoundsInBox(self.Position, self.Size, self.Parameters)
					for i,v in next, touching do
						if(not table.find(parts,v))and(v~=part)then
							table.remove(touching,i)
							callback(v)
						end
					end
				end)
				connections[#connections+1] = connection
				local connection2 = game:GetService('RunService').Heartbeat:Connect(function()
					local parts = workspace:GetPartBoundsInBox(self.Position, self.Size, self.Parameters)
					for i,v in next, parts do
						if(not table.find(touching,v))and(v~=part)then
							table.insert(touching,v)
							if(self.TouchedCallback)then
								self.TouchedCallback(v)
							end
						end
					end
				end)
				connections[#connections+1] = connection2
				local returned = {}
				function returned:Disconnect()
					connection:Disconnect()
					connection2:Disconnect()
				end
				return returned
			end

			function returned:GetTouchingParts()
				return touching
			end

			function returned:KillOperation()
				for i,v in next, connections do
					pcall(function()
						v:Disconnect()
					end)
				end
				ignoring = {}
				returned = nil
				self = nil
			end

			return returned
		end

		return module
	end

	function fakesignalreq()
		local HttpsService = game:GetService("HttpService")

		local FakeSignal = {}
		FakeSignal.ClassName = "FakeSignal"
		FakeSignal.__index = FakeSignal

		local function IsFunction(func)
			if typeof(func) ~= "function" then
				error(string.format("invalid argument. function expected got %s", typeof(func)))
			end
		end

		function FakeSignal.new()
			return setmetatable({
				_connections = {},
			}, FakeSignal)
		end

		function FakeSignal:Once(func)
			IsFunction(func)

			local once = nil

			once = self:Connect(function(...)
				once:Disconnect()

				func(...)
			end)

			return once
		end

		function FakeSignal:Connect(func)
			IsFunction(func)

			local connection = {
				_name = HttpsService:GenerateGUID(),
				_func = func,
				_connected = true,
			}

			self._connections[connection._name] = connection

			function connection:Disconnect()
				connection._connected = false
			end

			connection.disconnect = connection.Disconnect

			return connection
		end

		function FakeSignal:Wait()
			local yield = coroutine.running()

			self:Once(function(...)
				task.spawn(yield, ...)
			end)

			return coroutine.yield()
		end

		function FakeSignal:Fire(...: any)
			for i, connection in pairs(self._connections) do
				if connection._connected then
					IsFunction(connection._func)

					connection._func(...)
				else
					local index = table.find(self._connections, connection._name)

					table.remove(self._connections, index)
				end
			end
		end

		FakeSignal.connect = FakeSignal.Connect
		FakeSignal.wait = FakeSignal.Wait
		FakeSignal.fire = FakeSignal.Fire
		FakeSignal.once = FakeSignal.Once

		return FakeSignal
	end

	local RegionTouched = regiontouchreq()
	local FakeSignal = fakesignalreq()
	local RaySides = {
		Vector3.new(0, 100, 0);
		Vector3.new(0, -100, 0);
		Vector3.new(0, 0, 100);
		Vector3.new(0, 0, -100);
		Vector3.new(100, 0, 0);
		Vector3.new(-100, 0, 0);
		Vector3.new(100, 100, 0);
		Vector3.new(-100, 100, 0);
		Vector3.new(100, -100, 0);
		Vector3.new(-100, -100, 0);
		Vector3.new(0, 100, 100);
		Vector3.new(0, 100, -100);
		Vector3.new(0, -100, 100);
		Vector3.new(0, -100, -100);
		Vector3.new(100, 100, 100);
		Vector3.new(100, -100, 100);
		Vector3.new(100, 100, -100);
		Vector3.new(100, -100, -100);
		Vector3.new(-100, 100, 100);
		Vector3.new(-100, -100, 100);
		Vector3.new(-100, 100, -100);
		Vector3.new(-100, -100, -100);
		Vector3.new(100, 100, -100);
		Vector3.new(-100, -100, 100);
		Vector3.new(-100, 100, -100);
		Vector3.new(100, -100, 100);
	}
	local drops = {}
	local mult = 4

	function checkifbigger(v, v2)
		local bigger = false
		if(v.X > v2.X)then
			bigger = true
		end
		if(v.Y > v2.Y)then
			bigger = true
		end
		if(v.Z > v2.Z)then
			bigger = true
		end
		return bigger
	end

	function getbiggestaxis(v)
		local biggest = 0
		if(v.X > biggest)then
			biggest = v.X
		end
		if(v.Y > biggest)then
			biggest = v.Y
		end
		if(v.Z > biggest)then
			biggest = v.Z
		end
		return biggest
	end

	function checkifdrop(inst)
		for i,v in next, drops do
			if(inst == i)then
				return true
			end
		end
		return false
	end

	function module.new(settings, properties)
		local ignore = (settings.Ignore or {})
		local size = (settings.Size or 1)
		local pos = (settings.Position or Vector3.zero)
		local velocity = (settings.Velocity or Vector3.zero)
		local decaytime = (settings.DecayTime or 5)
		local onsplat = FakeSignal.new()
		local touch = FakeSignal.new()
		local drop = Instance.new("Part")
		drop.Size = Vector3.one*size
		drop.Anchored = true
		drop.CanCollide = false
		drop.Position = pos
		drop.Name = "__LiquidDroplet"
		drop.Parent = workspace
		for i, v in next, properties or {} do
			pcall(function()
				drop[i] = v
			end)
		end
		local mesh = Instance.new("SpecialMesh")
		mesh.MeshType = Enum.MeshType.Sphere
		mesh.Parent = drop
		local connections = {}
		local parsed = RegionTouched:Parse(drop)
		local gravity = Vector3.zero
		velocity /= 3
		local function disconnectAll()
			for i, v in next, connections do
				pcall(function()
					v:Disconnect()
				end)
			end
		end
		game:GetService("Debris"):AddItem(drop, decaytime+20)
		local replace = {
			OnSplat = onsplat,
			Touched = touch
		}
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {drop, table.unpack(ignore)}
		local ovparams = OverlapParams.new()
		ovparams.FilterDescendantsInstances = params.FilterDescendantsInstances
		table.insert(connections, parsed.Touched:Connect(function(obj)
			touch:Fire(obj)
			if(table.find(ignore, obj))then
				return
			end
			for i,v in next, ignore do
				if(obj:IsDescendantOf(v))then
					return
				end
			end
			if(checkifdrop(obj))then
				return
			end
			disconnectAll()
			parsed:KillOperation()
			for i, v in next, RaySides do
				local size = size*2
				local maxsize = size*5
				local ray = workspace:Raycast(drop.Position, ((drop.Position + v) - drop.Position).unit*3.5, params)
				if(ray)then
					pcall(game.Destroy, drop)
					if(not checkifdrop(ray.Instance))then
						drop = Instance.new("Part")
						drop.Size = Vector3.zero
						drop.Anchored = true
						drop.CanCollide = false
						drop.CFrame = CFrame.lookAt(ray.Position, ray.Position + ray.Normal) * CFrame.Angles(math.rad(-90), 0, 0)
						drop.Name = "__LiquidPuddle"
						drop.Parent = workspace
						for i, v in next, properties or {} do
							pcall(function()
								drop[i] = v
							end)
						end
						local mesh = Instance.new("SpecialMesh")
						mesh.MeshType = Enum.MeshType.Sphere
						mesh.Parent = drop
						drops[drop] = true
						game:GetService("Debris"):AddItem(drop, decaytime+20)
						local splat = Instance.new("Sound", drop)
						splat.SoundId = "rbxassetid://"..180083298
						splat.Volume = 1
						splat.Pitch = math.random(90,110)/100
						splat:Play()
						game:GetService("TweenService"):Create(drop, TweenInfo.new(.5), {
							Size = Vector3.new(size, .3, size)
						}):Play()
						task.delay(decaytime, function()
							local time = getbiggestaxis(drop.Size)/2
							game:GetService("TweenService"):Create(drop, TweenInfo.new(time), {
								Size = Vector3.zero
							}):Play()
							task.delay(time, pcall, game.Destroy, drop)
						end)
					else
						local splat = Instance.new("Sound", ray.Instance)
						splat.SoundId = "rbxassetid://"..180083298
						splat.Volume = 1
						splat.Pitch = math.random(90,110)/100
						splat:Play()
						local newsize = ray.Instance.Size + Vector3.new(size, 0, size)
						newsize = Vector3.new(math.clamp(newsize.X, 0, maxsize), math.clamp(newsize.Y, 0, maxsize), math.clamp(newsize.Z, 0, maxsize))
						drop = ray.Instance
						if(checkifbigger(newsize, ray.Instance.Size))then
							game:GetService("TweenService"):Create(ray.Instance, TweenInfo.new(.5), {
								Size = newsize
							}):Play()
						end
					end
					replace.Touched = nil
					onsplat:Fire()
					break
				end
			end
		end))
		drops[drop] = {
			size = size,
			gravity = gravity,
			velocity = velocity
		};
		return setmetatable({}, {
			__index = function(self, index)
				return replace[index] or drop[index]
			end,
			__newindex = function(self, index, value)
				drop[index] = value
			end,
			__tostring = function(self)
				return self.Name
			end,
			ClassName = "Part"
		})
	end

	game:GetService("RunService").Heartbeat:Connect(function(delta)
		for drop, data in next, drops do
			if(drop:IsDescendantOf(workspace))then
				if(typeof(data) == "table")then
					local mul = delta*60
					local oldpos = drop.Position
					local newpos = drop.Position + (data.velocity * mul + data.gravity)
					drop.CFrame = CFrame.lookAt(oldpos, newpos)
					drop.Position = newpos
					local mag = (oldpos - drop.Position).Magnitude
					drop.Size = Vector3.new(data.size,data.size,math.clamp(data.size*mag*mult, data.size, data.size*10))
					data.gravity -= Vector3.yAxis*(delta*(workspace.Gravity/196.1999969482422))
					data.velocity -= data.velocity.unit*delta
				end
			else
				drops[drop] = nil
			end
		end
	end)

	return module
end

-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 1108 characters
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


local Objects = Decode('AAA6IQVNb2RlbCEKV29ybGRQaXZvdAQ4OTohCUFjY2Vzc29yeSEETmFtZSEEVGFpbCERQXR0YWNobWVudEZvcndhcmQKAAAAgAAAAIAAAIA/IQ9BdHRhY2htZW50UG9pbnQEDA46IQ1BdHRhY2htZW50UG9zCgAAAADMDsA+C4rGPyEPQXR0YWNobWVudFJpZ2h0CgAA'
	..'gL8AAAAAAAAAACEEUGFydCEGSGFuZGxlIQ1Cb3R0b21TdXJmYWNlAwAAAAAAAAAAIQZDRnJhbWUEGDk6IQZMb2NrZWQiIQhQb3NpdGlvbgoAAPBCxf+UQYZEA8AhBFNpemUKAACAPwAAgD8AAIA/IQpUb3BTdXJmYWNlIQtTcGVjaWFsTWVzaCEGTWVzaElkIRdyYnhh'
	..'c3NldGlkOi8vNjQ1NjE1OTk1MiEJVGV4dHVyZUlkIRdyYnhhc3NldGlkOi8vNjQ1NjM5ODkyNiEITWVzaFR5cGUDAAAAAAAAFEAhC1N0cmluZ1ZhbHVlIRNBdmF0YXJQYXJ0U2NhbGVUeXBlIQVWYWx1ZSEHQ2xhc3NpYyEKQXR0YWNobWVudCETV2Fpc3RCYWNrQXR0'
	..'YWNobWVudCELT3JpZW50YXRpb24KAAAAgAAANEMAAAAAIQRFYXJzCkpVWifu6O4lAACAPwQuLzEKAAAAAAAjqDwAyKQ8CgAAgL+tOgeySlVaJyEMQXR0YWNobWVudFVwCq06B7IAAIA/7ejupQQzOToKAAAdQ4hFcUEAiKS8IRdyYnhhc3NldGlkOi8vNjU4NDg1MzU2'
	..'MiEXcmJ4YXNzZXRpZDovLzY1ODQ4NjE5MzchDUhhdEF0dGFjaG1lbnQKHOLVKAAANMN/IPK0CgCACkNE0YZBlo2EvwoAAIA/AAAAAAAAAAAKAAAAAAAAgD8AAAAACwEAAQACAwQBBQAFBgcICQoLDA0ODwIHAAUQERITFBUWFxgZGhsSHAMEAAUcHR4fICEiIwMCAAUk'
	..'JSYnAwQABSgTCikqFwwEAQYABSsHLAktCy4NLzAxDwcHAAUQERITMhUWFzMZGhsSHAgEAAUcHTQfNSEiIwgCAAUkJSYnCAQABTYTLSk3Fy4A')
Objects = Objects[1]

local Liquid = liquidreq()
local tool = Instance.new("Tool", owner.Backpack)
tool.Name = "Goo"
tool.Grip = CFrame.new(0,0,.3)
local handle = Instance.new("Part", tool)
handle.Name = "Handle"
handle.Color = Color3.new(0,0,0)
handle.Size = Vector3.new(.8,.8,.8)
handle.Material = Enum.Material.Glass
local char = owner.Character

tool.Equipped:Connect(function()
	char = tool.Parent
end)

tool.Activated:Connect(function()
	if(not tool.Parent:IsA("Model"))then return end
	for i = 1, 5 do
		local drop = Liquid.new({
			Position = handle.Position,
			Velocity = Vector3.new(math.random(-100,100)/100, math.random(1, 2), math.random(-100,100)/100),
			Size = 1,
			DecayTime = 30,
			Ignore = {handle, tool.Parent}
		}, {
			Material = Enum.Material.Glass,
			Color = handle.Color
		})
		drop.OnSplat:Once(function()
			drop.Touched:Connect(function(v)
				if(v:IsDescendantOf(char))then
					return
				end
				local model = v:FindFirstAncestorOfClass("Model")
				if(model)and(not model:FindFirstChild("_Changed"))then
					Instance.new("BoolValue", model).Name = "_Changed"
					local splat = Instance.new("Sound", model:FindFirstChildWhichIsA("BasePart"))
					splat.SoundId = "rbxassetid://"..5656490592
					splat.Volume = 1
					splat.Pitch = math.random(90,110)/100
					splat:Play()
					local tailfound = false
					local earsfound = false
					for i, v in next, model:GetChildren() do
						if(v:IsA("Accessory"))then
							if(v.Name:lower():find("tail"))then
								tailfound = true
							elseif(v.Name:lower():find("ears"))then
								earsfound = true
							end
						end
						if(tailfound)and(earsfound)then
							break
						end
					end
					if(not tailfound)then
						Objects.Tail:Clone().Parent = model
					end
					if(not earsfound)then
						Objects.Ears:Clone().Parent = model
					end
					pcall(game.Destroy, model:FindFirstChildWhichIsA("BodyColors", true))
					local function colorize()
						for i,v in next, model:GetDescendants() do
							if(v:IsA("BasePart"))then
								v.Color = drop.Color
								v.Material = drop.Material
							elseif(v:IsA("SpecialMesh"))then
								v.TextureId = ""
							elseif(v:IsA("BodyColors"))then
								v:Destroy()
							elseif(v:IsA("Shirt"))then
								v:Destroy()
							elseif(v:IsA("Pants"))then
								v:Destroy()
							end
						end
					end
					pcall(colorize)
					task.defer(colorize)
				end
			end)
		end)
	end
end)