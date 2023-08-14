local module = {}

function module.fsig()
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

function module.EZConvert()
	if(not getfenv().owner or not getfenv().NLS)then error("this is made to be ran in a sandbox") end
	if(game:GetService("RunService"):IsClient())then error("why are you running this on client") end

	getfenv().wait = task.wait
	getfenv().delay = task.delay
	getfenv().spawn = task.spawn

	print("starting converter")
	local InternalData = {}
	local FakeSignal = module.fsig()
	local FakeCamera = {FieldOfView=0,CFrame=CFrame.identity,CoordinateFrame=CFrame.identity}
	do
		local Event = Instance.new("RemoteEvent")
		Event.Name = "UserInput"

		local TBFocus = nil
		local MouseDowns = {}
		local KeyDowns = {}

		local Mouse = {
			Target=nil,Hit=CFrame.index,
			KeyUp=FakeSignal.new(),KeyDown=FakeSignal.new(),
			Button1Up=FakeSignal.new(),Button1Down=FakeSignal.new()
		}
		local UserInputService = {
			InputBegan=FakeSignal.new(),InputEnded=FakeSignal.new(),
			GetFocusedTextBox=function()return TBFocus end,IsMouseButtonPressed=function(inputtype)return MouseDowns[inputtype] == true end,
			IsKeyDown=function(keycode)return KeyDowns[keycode] == true end
		}

		local ContextActionService = {
			Actions={},
			BindAction = function(self,actionName,Func,touch,...)
				self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil
			end
		};ContextActionService.UnBindAction = ContextActionService.BindAction

		Event.OnServerEvent:Connect(function(FiredBy,Input)
			if(FiredBy.Name ~= owner.Name)then return end
			if Input.MouseEvent then
				Mouse.Target = Input.Target
				Mouse.Hit = Input.Hit
				TBFocus = Input.TextBox
				FakeCamera.CFrame = Input.CameraCF
				FakeCamera.CoordinateFrame = Input.CameraCF
			else
				local Begin = Input.UserInputState == Enum.UserInputState.Begin
				if(Input.UserInputType == Enum.UserInputType.MouseButton1)then
					MouseDowns[Input.UserInputType] = Begin
					return Mouse[Begin and "Button1Down" or "Button1Up"]:Fire()
				end
				
				for _,Action in pairs(ContextActionService.Actions) do
					for _,Key in pairs(Action.Keys) do
						if(Key==Input.KeyCode)then
							Action.Function(Action.Name,Input.UserInputState,Input)
						end
					end
				end
				
				MouseDowns[Enum.KeyCode[Input.KeyCode.Name]] = Begin
				Mouse[Begin and "KeyDown" or "KeyUp"]:Fire(Input.KeyCode.Name:lower())
				UserInputService[Begin and "InputBegan" or "InputEnded"]:Fire(Input,false)
			end
		end)
		InternalData["Mouse"] = Mouse
		InternalData["ContextActionService"] = ContextActionService
		InternalData["UserInputService"] = UserInputService

		Event.Parent = NLS([[
			local Player = owner
			local Event = script:WaitForChild("UserInput")
			local UserInputService = game:GetService("UserInputService")
			local Mouse = Player:GetMouse()
			local Input = function(Input,gameProcessedEvent)
				if gameProcessedEvent then return end
				Event:FireServer({KeyCode=Input.KeyCode,UserInputType=Input.UserInputType,UserInputState=Input.UserInputState})
			end
			UserInputService.InputBegan:Connect(Input)
			UserInputService.InputEnded:Connect(Input)
			local Hit,Target,FT,FCF
			game:GetService("RunService").Heartbeat:Connect(function()
				if Hit ~= Mouse.Hit or Target ~= Mouse.Target or FT ~= UserInputService:GetFocusedTextBox() or workspace.CurrentCamera.CFrame ~= FCF then
					Hit,Target,FT,FCF = Mouse.Hit,Mouse.Target,UserInputService:GetFocusedTextBox(),workspace.CurrentCamera.CFrame
					Event:FireServer({["MouseEvent"]=true,["Target"]=Target,["Hit"]=Hit,["TextBox"]=UserInputService:GetFocusedTextBox(),["CameraCF"]=workspace.CurrentCamera.CFrame})
				end
			end)
		]],owner.Character)
	end
	local RealGame = game;

	local function Sandbox(Thing)
		if Thing:IsA("Player") then
			local RealPlayer = Thing
			return setmetatable({},{
				__index = function(self2,Index)
					local Index2 = RealPlayer[Index]
					if(Index2 and type(Index2) == "function")then
						if(string.lower(Index) == "getmouse" or string.lower(Index) == "mouse")then
							return function(self)
								return InternalData["Mouse"]
							end
						end

						return function(self,...)
							return Index2(self == self2 and RealPlayer or self,...)
						end
					else
						return Index2
					end
				end;
				__tostring = function(self)
					return RealPlayer.Name
				end
			})
		end
	end;

	local FakeServices = {
		Players = setmetatable({},{
			__index = function(self2,Index2)
				local Service = RealGame:GetService("Players")
				local Index = Service[Index2]
				
				if(Index and type(Index) == "function")then
					return function(self,...)
						return Index(self == self2 and Service or self,...)
					end
				else
					if(string.lower(Index2) == "localplayer")then
						return Sandbox(owner)
					end
					return Index
				end
			end,
			__tostring = function(self)
				return RealGame:GetService("Players").Name
			end
		}),
		RunService = setmetatable({},{
			__index = function(self2,Index2)
				local Service = RealGame:GetService("RunService")
				local Index = Service[Index2]
				if(Index and type(Index) == "function")then
					if(string.lower(Index2) == "bindtorenderstep")then
						return function(self,Name,Priority,Function)
							return Service.Stepped:Connect(Function)
						end
					end
					
					return function(self,...)
						return Index(self == self2 and Service or self,...)
					end
				else
					if(string.lower(Index2) == "renderstepped")then
						return Service["Stepped"]
					end
					return Index
				end
			end,
			__tostring = function(self)
				return RealGame:GetService("RunService").Name
			end
		})
	}

	getfenv().game = setmetatable({},{
		__index = function(self2,Index)
			local Index2 = RealGame[Index]
			if(Index2 and type(Index2) == "function")then
				local lower = string.lower(Index)
				if(lower == "getservice" or lower == "service" or lower == "findservice")then
					return function(self,Service)
						return FakeServices[Service] or InternalData[Service] or RealGame:GetService(Service)
					end
				end

				return function(self,...)
					return Index2(self == self2 and RealGame or self,...)
				end
			else
				if(Index and game:GetService(Index))then
					return game:GetService(Index)
				end
				return Index2
			end
		end,
		__tostring = function(self)
			return RealGame.Name
		end
	});getfenv().Game = game;
	getfenv().Camera=FakeCamera;

	task.wait(.5)

	print("finished")
end

module.BezierCurve = {
	new = function(...)
		local points = {...}
		assert(#points >= 2, "bezier.new requires atleast 2 points")
		local operation = ""
		local s = "local points = ...\n"
		for k,v in next, points do
			s = s .. `local p{k - 1} = points[{k}]\n`
			if k == 1 then
				operation = operation .. `(1 - t)^{#points-1}*p0 + `
				continue
			end
			if k == #points then
				operation = operation .. `t^{#points-1}*p{k - 1}`
				continue
			end
			operation = operation .. `{#points-1}*(1 - t){string.rep("*t", k - 2)}^{#points - 2}{k == 2 and "*t" or ""}*p{k - 1}`
			if k ~= #points then
				operation = operation .. " + "
			end
		end
		s = s .. `\nreturn function(t) return {operation} end`
		local func, err = loadstring(s)
		if func then
			func = func(points)
		else
			error(`{err}`)
		end
		return {
			calc = func
		}
	end
}

module.RegionHitbox = {}

function module.RegionHitbox:Parse(part : Instance)
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

module["2DCollision"] = function(shape1, shape2)
	local function getCorners(frame)
		local corners, rot = {}, math.rad(frame.Rotation)
		local center = frame.AbsolutePosition + frame.AbsoluteSize/2
		local world_cords = {
			Vector2.new(frame.AbsolutePosition.x, frame.AbsolutePosition.y),
			Vector2.new(frame.AbsolutePosition.x + frame.AbsoluteSize.x, frame.AbsolutePosition.y),
			Vector2.new(frame.AbsolutePosition.x + frame.AbsoluteSize.x, frame.AbsolutePosition.y + frame.AbsoluteSize.y),
			Vector2.new(frame.AbsolutePosition.x, frame.AbsolutePosition.y + frame.AbsoluteSize.y),
		}
		for i, corner in ipairs(world_cords) do
			local x = center.x + (corner.x - center.x) * math.cos(rot) - (corner.y - center.y) * math.sin(rot)
			local y = center.y + (corner.x - center.x) * math.sin(rot) + (corner.y - center.y) * math.cos(rot)
			corners[i] = Vector2.new(x, y)
		end
		return corners
	end

	local function dot2d(x,y)
		return x.X*y.X+x.Y*y.Y
	end

	local function getAxis(c1, c2)
		local axis = {}
		axis[1] = (c1[2] - c1[1]).unit
		axis[2] = (c1[4] - c1[1]).unit
		axis[3] = (c2[2] - c2[1]).unit
		axis[4] = (c2[4] - c2[1]).unit
		return axis
	end

	local c1, c2 = getCorners(shape1), getCorners(shape2)
	local axis = getAxis(c1, c2)
	local scalars, mtv = {}, Vector2.new(math.huge, math.huge)
	local a = nil
	for i = 1, #axis do
		for i2, set in next, {c1, c2} do
			scalars[i2] = {}
			for _, point in next, set do
				table.insert(scalars[i2], dot2d(point, axis[i]))
			end
		end
		local s1max, s1min = math.max(unpack(scalars[1])), math.min(unpack(scalars[1]))
		local s2max, s2min = math.max(unpack(scalars[2])), math.min(unpack(scalars[2]))
		if s2min > s1max or s2max < s1min then
			return false, Vector2.new()
		end
		local overlap = s1max > s2max and -(s2max - s1min) or (s1max - s2min)
		if math.abs(overlap) < mtv.magnitude then
			mtv = axis[i] * overlap
		end
	end
	return true, mtv
end

module["2DRaycast"] = function(From, To, Parameters)
	local DetectCollision = module["2DCollision"]
	local function CanCollide(Object)
		return (Object:FindFirstChild("CanCollide") and true or false)
	end
	if(not Parameters)then
		return error("Must specify parameters.")
	end
	if(not Parameters.Frame)then
		return error("Parameters must include Frame parameter.")
	end
	local function ToOffset(Offset,XorY)
		return Offset*(Parameters.Frame).AbsoluteSize[XorY or "X"]
	end
	local function UDimToVector2(UDi)
		if(UDi.X.Scale ~= 0)then
			UDi = UDim2.new(0, UDi.X.Offset + ToOffset(UDi.X.Scale, "X"), UDi.Y.Scale, UDi.Y.Offset)
		end
		if(UDi.Y.Scale ~= 0)then
			UDi = UDim2.new(0, UDi.X.Offset, 0, UDi.Y.Offset + ToOffset(UDi.Y.Scale, "Y"))
		end
		return Vector2.new(UDi.X.Offset, UDi.Y.Offset)
	end
	local function CeilOrFloor(Number)
		local Floor = false
		if(Number > 0)and(Number > 0.001)then
			return math.ceil(Number)
		elseif(Number < 0)and(Number < -0.001)then
			return math.floor(Number)
		else
			return 0
		end
	end
	local function IsIgnored(Object)
		for i,v in next, (Parameters.FilterDescendantsInstances or {}) do
			if(v == Object or Object:IsDescendantOf(v))then
				return true
			end
		end
		return false
	end
	if(typeof(From) == "UDim2")then
		From = UDimToVector2(From)
	end
	if(typeof(To) == "UDim2")then
		To = UDimToVector2(To)
	end
	local a = Instance.new("Frame", Parameters.Frame)
	a.Position = UDim2.fromOffset(From.X, From.Y)
	a.Size = UDim2.fromOffset(1,1)
	a.AnchorPoint = Vector2.new(0.5,0.5)
	a.BackgroundTransparency = 0
	a.BorderSizePixel = 1
	local Direction = (To - From);
	local MaximumMaxDistance = ((Parameters.Frame).AbsoluteSize.X*(Parameters.Frame).AbsoluteSize.Y)/100
	local MaxDistance = math.clamp((Parameters.MaxDistance or MaximumMaxDistance), 0, MaximumMaxDistance)
	for i = 1, MaxDistance do
		local Offset = UDim2.fromOffset(CeilOrFloor(Direction.X/(Parameters.Frame).AbsoluteSize.X), CeilOrFloor(Direction.Y/(Parameters.Frame).AbsoluteSize.Y))
		a.Position += Offset
		Direction = (To - a.AbsolutePosition);
		local DidHit = false
		local Hit = nil
		for i,v in next, (Parameters.Frame):GetDescendants() do
			if(v:IsA("GuiObject"))and(v ~= a)and(not IsIgnored(v))and(v.Visible)then
				local success, Collided, Overlap = pcall(function()
					return DetectCollision(a, v)
				end)
				if(success)then
					if(Collided)then
						if(Parameters.RespectCanCollide and CanCollide(v))then
							DidHit = true
							Hit = v
							break
						elseif(not Parameters.RespectCanCollide)then
							DidHit = true
							Hit = v
							break
						end
					end
				end
			end
		end
		if(DidHit)then
			pcall(game.Destroy,a)
			return {
				Position = a.Position,
				Instance = Hit
			}
		end
		if(Offset.X.Offset == 0 and Offset.Y.Offset == 0)or(Direction.X == 0 and Direction.Y == 0)then
			break
		end
	end
	pcall(game.Destroy,a)
	return nil
end

return module