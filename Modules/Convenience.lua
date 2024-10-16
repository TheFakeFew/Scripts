local module = {}

local _type = type;
local _typeof = typeof;
local select, next, unpack, pack, maxn, newproxy, getmetatable, setmetatable = select, next, unpack, table.pack, table.maxn, newproxy, getmetatable, setmetatable

function module.fsig()
	local HttpsService = game:GetService("HttpService")

	local FakeSignal = {}
	FakeSignal.ClassName = "FakeSignal"
	FakeSignal.__index = FakeSignal

	local function IsFunction(func)
		if _typeof(func) ~= "function" then
			error(string.format("invalid argument. function expected got %s", _typeof(func)))
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

function module.EZConvert(useahb)
	if(not getfenv().owner)then
		getfenv().owner = (script:FindFirstAncestorOfClass("Player") or game:GetService("Players"):GetPlayerFromCharacter(script:FindFirstAncestorOfClass("Model"))) or error("no owner")
	end

	if(not getfenv().NLS)then return error("this is made to be ran in a sandbox") end
	if(game:GetService("RunService"):IsClient())then return error("why are you running this on client") end

	getfenv().wait = task.wait
	getfenv().delay = task.delay

	print("starting converter")

	local ArtificialHB = useahb and Instance.new("BindableEvent", script) or nil
	if(ArtificialHB)then
		ArtificialHB.Name = "Heartbeat"
		
		local tf = 0
		local allowframeloss = false
		local tossremainder = false
		local lastframe = tick()
		local frame = 1/60
	
		game:GetService("RunService").Heartbeat:Connect(function(delta)
			tf = tf + delta
			if tf >= frame then
				if allowframeloss then
					ArtificialHB:Fire(tf)
					lastframe = tick()
				else
					for i = 1, math.floor(tf / frame) do
						ArtificialHB:Fire(tf)
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
	else
		ArtificialHB = {
			Event = game:GetService("RunService").Heartbeat
		}
	end

	local InternalData = {}
	local FakeSignal = module.fsig()
	local realowner = owner
	local FakeCamera = {FieldOfView=0,CFrame=CFrame.identity,CoordinateFrame=CFrame.identity}
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInput"
	local RemFunc = Instance.new("RemoteFunction")
	RemFunc.Name = "UserEvent"

	local TBFocus = nil
	local MouseDowns = {}
	local KeyDowns = {}

	local Mouse = {
		Target=nil,Hit=CFrame.index,
		KeyUp=FakeSignal.new(),KeyDown=FakeSignal.new(),
		Button1Up=FakeSignal.new(),Button1Down=FakeSignal.new(),
		Button2Up=FakeSignal.new(),Button2Down=FakeSignal.new()
	}
	local UserInputService = {
		properties = {InputBegan=FakeSignal.new(),InputEnded=FakeSignal.new()},

		methods = {GetFocusedTextBox=function(self)return TBFocus end,IsMouseButtonPressed=function(self,inputtype)return MouseDowns[inputtype] == true end,
		IsKeyDown=function(self,keycode)return KeyDowns[keycode] == true end}
	}

	local ContextActionService = {
		Actions={},
		BindAction = function(self,actionName,Func,touch,...)
			self.Actions[actionName] = Func and {Name=actionName,Function=Func,Keys={...}} or nil
		end
	};ContextActionService.UnBindAction = ContextActionService.BindAction

	InternalData["SoundLoudness"] = {}

	Event.OnServerEvent:Connect(function(FiredBy, type, data)
		if(FiredBy.Name ~= owner.Name)then return end
		if(type == "mouse")then
			if data.MouseEvent then
				Mouse.Target = data.Target
				Mouse.Hit = data.Hit
				TBFocus = data.TextBox
				FakeCamera.CFrame = data.CameraCF
				FakeCamera.CoordinateFrame = data.CameraCF

			elseif(data.UserInputState)then
				local Begin = data.UserInputState == Enum.UserInputState.Begin
				if(data.UserInputType == Enum.UserInputType.MouseButton1)then
					MouseDowns[data.UserInputType] = Begin
					return Mouse[Begin and "Button1Down" or "Button1Up"]:Fire()
				elseif(data.UserInputType == Enum.UserInputType.MouseButton2)then
					MouseDowns[data.UserInputType] = Begin
					return Mouse[Begin and "Button2Down" or "Button2Up"]:Fire()
				end

				for _,Action in pairs(ContextActionService.Actions) do
					for _,Key in pairs(Action.Keys) do
						if(Key==data.KeyCode)then
							Action.Function(Action.Name,data.UserInputState,data)
						end
					end
				end

				KeyDowns[Enum.KeyCode[data.KeyCode.Name]] = Begin
				UserInputService.properties[Begin and "InputBegan" or "InputEnded"]:Fire(data,false)

			elseif(data.Key)then
				Mouse[data.Up and "KeyUp" or "KeyDown"]:Fire(data.Key)

			end
		end
	end)
	InternalData["Mouse"] = Mouse
	InternalData["ContextActionService"] = ContextActionService
	InternalData["UserInputService"] = UserInputService

	function getClientProperty(object, prop)
		return RemFunc:InvokeClient(realowner, "getprop", object, prop)
	end

	local ls = NLS([[
			local Player = owner
local Event = script:WaitForChild("UserInput")
local Func = script:WaitForChild("UserEvent")
local UserInputService = game:GetService("UserInputService")
local Mouse = Player:GetMouse()
local Input = function(Input,gameProcessedEvent)
	if gameProcessedEvent then return end
	Event:FireServer("mouse", {KeyCode=Input.KeyCode,UserInputType=Input.UserInputType,UserInputState=Input.UserInputState})
end
UserInputService.InputBegan:Connect(Input)
UserInputService.InputEnded:Connect(Input)

Mouse.KeyDown:Connect(function(k)
	Event:FireServer("mouse", {Key = k, Up = false})
end)

Mouse.KeyUp:Connect(function(k)
	Event:FireServer("mouse", {Key = k, Up = true})
end)

Func.OnClientInvoke = function(type, a, b)
	if(type == "getprop")then
		return a[b]
	end
end

local Hit,Target,FT,FCF
local dt = 0
game:GetService("RunService").Heartbeat:Connect(function(delta)
	dt = dt + delta
	if Hit ~= Mouse.Hit or Target ~= Mouse.Target or FT ~= UserInputService:GetFocusedTextBox() or workspace.CurrentCamera.CFrame ~= FCF then
		Hit,Target,FT,FCF = Mouse.Hit,Mouse.Target,UserInputService:GetFocusedTextBox(),workspace.CurrentCamera.CFrame
		Event:FireServer("mouse", {["MouseEvent"]=true,["Target"]=Target,["Hit"]=Hit,["TextBox"]=UserInputService:GetFocusedTextBox(),["CameraCF"]=workspace.CurrentCamera.CFrame})
	end
end)
		]],owner.Character)
	Event.Parent = ls
	RemFunc.Parent = ls
	local RealGame = game;
	local realObjects = setmetatable({}, {__mode = "v"});
	local wrappedObjects = setmetatable({}, {__mode = "k"});

	local function unwrap(...)
		local amount = select("#", ...)
		if(amount==1)then
			local thing = (...)
			if wrappedObjects[thing] then
				return thing
			end
			if(_type(thing) == "table")then
				local success = pcall(function()
					for a, b in next, thing do
						thing[a] = unwrap(b)
					end
				end)
				if(success)then
					return thing
				else
					local tbl = {}
					for a, b in next, thing do
						tbl[a] = unwrap(b)
					end
					return tbl
				end
			else
				return realObjects[thing] or thing
			end
		end

		local unwrapped = {}
		for i,v in next, pack(...) do
			if(_type(v) == "table")then
				local success = pcall(function()
					for a, b in next, thing do
						thing[a] = unwrap(b)
					end
				end)
				if(not success)then
					local tbl = {}
					for a, b in next, v do
						tbl[a] = unwrap(b)
					end
					unwrapped[i] = tbl
				end
			else
				unwrapped[i] = realObjects[v] or v
			end
		end
		return unpack(unwrapped, 1, amount)
	end

	local function wrap(...)
		local amount = select("#", ...)
		if(amount==1)then
			local thing = (...)
			if realObjects[thing] then
				return thing
			end
			if(_type(thing) == "table")then
				local success = pcall(function()
					for a, b in next, thing do
						thing[a] = wrap(b)
					end
				end)
				if(success)then
					return thing
				else
					local tbl = {}
					for a, b in next, thing do
						tbl[a] = wrap(b)
					end
					return tbl
				end
			elseif(_type(thing) == "function")then
				return wrapfunction(thing)
			elseif(_type(thing) == "userdata")then
				return wrapuserdata(thing)
			else
				return wrappedObjects[unwrap(thing)] or sandbox(thing)
			end
		end

		local wrapped = {}
		for i,v in next, pack(...) do
			if(_type(v) == "table")then
				local success = pcall(function()
					for a, b in next, v do
						v[a] = wrap(b)
					end
				end)
				if(not success)then
					local tbl = {}
					for a, b in next, v do
						tbl[a] = wrap(b)
					end
					wrapped[i] = tbl
				end
			elseif(_type(v) == "function")then
				wrapped[i] = wrapfunction(v)
			elseif(_type(v) == "userdata")then
				wrapped[i] = wrapuserdata(v)
			else
				wrapped[i] = wrappedObjects[unwrap(v)] or sandbox(v)
			end
		end
		return unpack(wrapped, 1, amount)
	end

	function wrapfunction(f)
		return function(...)
			return wrap(f(unwrap(...)))
		end
	end

	function wrapuserdata(u)
		if(wrappedObjects[unwrap(u)])then return wrappedObjects[unwrap(u)] end
		local proxy = newproxy(true)
		local meta = getmetatable(proxy)
		meta.__index = function(self, index)
			return wrap(u[index])
		end
		meta.__newindex = function(self, index, value)
			u[unwrap(index)] = unwrap(value)
		end
		meta.__tostring = function()
			return tostring(u)
		end
		realObjects[proxy] = u;wrappedObjects[u] = proxy;
		return proxy
	end

	local loudnessfunc = function(obj)
		task.spawn(function()
			InternalData["SoundLoudness"][obj] = getClientProperty(obj, "PlaybackLoudness")
		end)
		return InternalData["SoundLoudness"][obj] or 0
	end

	function sandbox(object, settings)
		if(wrappedObjects[unwrap(object)])then return wrappedObjects[unwrap(object)] end
		if(not object or _typeof(object) ~= "Instance")then return object end

		settings = (settings and _type(settings) == "table") and settings or {};
		local custommethods, customproperties = settings.methods or {}, settings.properties or {};

		if(object:IsA("Sound"))then
			customproperties["PlaybackLoudness"] = loudnessfunc
			customproperties["playbackLoudness"] = loudnessfunc
		end

		local proxy = newproxy(true)
		local meta = getmetatable(proxy)

		meta.__index = function(self, index)
			local fetched = custommethods[index] or customproperties[index] or object[index]
			if(_type(fetched) == "function" and not (customproperties[index] and _type(customproperties[index]) == "function"))then
				return custommethods[index] or wrap(fetched)
			else
				if(customproperties[index] and _type(customproperties[index]) == "function")then
					return customproperties[index](object)
				end
				return customproperties[index] or wrap(fetched)
			end
		end
		meta.__newindex = function(self, index, value)
			object[index] = unwrap(value)
		end
		meta.__tostring = function(self) return tostring(unwrap(self)) end
		meta.__metatable = "The metatable is locked"

		realObjects[proxy] = object;wrappedObjects[object] = proxy;

		return proxy
	end

	local sandboxedOwner = sandbox(owner, {
		methods = {
			GetMouse = function(self)
				return InternalData["Mouse"]
			end,
		}
	})

	local boundToRS = {}

	local FakeServices = {
		Players = sandbox(RealGame:GetService("Players"),{
			properties = {LocalPlayer = sandboxedOwner}
		}),
		RunService = sandbox(RealGame:GetService("RunService"), {
			methods = {
				BindToRenderStep = function(self, Name, Priority, Function)
					local con = ArtificialHB.Event:Connect(Function)
					boundToRS[Name] = con
				end,
				UnbindFromRenderStep = function(Name)
					if(boundToRS[Name])then
						boundToRS[Name]:Disconnect()
						boundToRS[Name] = nil
					end
				end
			},
			properties = {
				RenderStepped = ArtificialHB.Event,
				Stepped = ArtificialHB.Event,
				Heartbeat = ArtificialHB.Event
			}
		}),
		TweenService = sandbox(RealGame:GetService("TweenService")),
		Debris = sandbox(RealGame:GetService("Debris")),
		UserInputService = sandbox(RealGame:GetService("UserInputService"), InternalData.UserInputService),
		Workspace = sandbox(workspace)
	}

	local gamemethods = {
		GetService = function(self, Service)
			return FakeServices[Service] or InternalData[Service] or RealGame:GetService(Service)
		end
	};
	gamemethods.getService = gamemethods.GetService;gamemethods.service = gamemethods.GetService;
	gamemethods.FindService = gamemethods.GetService;gamemethods.findService = gamemethods.GetService;

	local env = getfenv(2)

	env.game = sandbox(RealGame, {methods = gamemethods, properties = FakeServices});env.Game = env.game;
	env.workspace = FakeServices.Workspace;env.Workspace = env.workspace;

	env.Camera = FakeCamera;
	env.owner = sandboxedOwner;
	env.script = wrap(script)

	env.Instance = wrap(env.Instance)

	env.type = wrap(_type)
	env.typeof = wrap(_typeof)

	env.LoadLibrary=function(lib)
		if(lib == "RbxUtility")then
			return {
				Create=function(inst)
					local instance = env.Instance.new(inst)
					return function(tab)
						if(tab)then
							for i,v in next, tab do
								instance[i]=v
							end
						end
						return instance
					end
				end
			}
		else
			return {}
		end
	end

	local canuserequire = pcall(require, 12972812972)
	local _LoadAssets = canuserequire and require or env.LoadAssets
	env.LoadAssets = function(id)
		local Assets = _LoadAssets(id)
		return wrap({
			Get = function(self, ...)
				return Assets:Get(unwrap(...))
			end,
			Exists = function(self, ...)
				return Assets:Exists(unwrap(...))
			end,
			GetNames = function(self, ...)
				return Assets:GetNames(unwrap(...))
			end,
			GetArray = function(self, ...)
				return Assets:GetArray(unwrap(...))
			end,
			GetDictionary = function(self, ...)
				return Assets:GetDictionary(unwrap(...))
			end
		})
	end
	local _NLS, _NS = wrap(env.NLS), wrap(env.NS);
	env.NewLocalScript = _NLS;env.NLS = _NLS;
	env.NewScript = _NS;env.NS = _NS;

	if(owner.Character:FindFirstChildOfClass("Humanoid"))then
		owner.Character:FindFirstChildOfClass("Humanoid").UseJumpPower = true
	end

	print("finished")

	print("using ezier convert by "..game:GetService("Players"):GetNameFromUserIdAsync(3270554075))
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
	if(_typeof(part) ~= "Instance")then
		return error('Expected type Instance got '.._typeof(part))
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
		if(_typeof(Ignored) == "Instance")then
			table.insert(ignoring,Ignored)
		elseif(_typeof(Ignored) == "table")then
			for i,v in next, Ignored do
				table.insert(ignoring,v)
			end
		else
			return error('Expected type Instance or table got '.._typeof(Ignored))
		end
		returned.Parameters.FilterDescendantsInstances = ignoring
	end

	function returned:RemoveIgnore(Ignored : Instance | {})
		if(_typeof(Ignored) == "Instance")then
			for i,v in next, ignoring do
				if v == Ignored then
					table.remove(ignoring,i)
				end
			end
		elseif(_typeof(Ignored) == "table")then
			for i,v in next, Ignored do
				for ind,a in next, ignoring do
					if a == v then
						table.remove(ignoring,ind)
					end
				end
			end
		else
			return error('Expected type Instance or table got '.._typeof(Ignored))
		end
		returned.Parameters.FilterDescendantsInstances = ignoring
	end

	function returned:SetParameters(Parameters : OverlapParams)
		if(_typeof(Parameters) == "OverlapParams")then
			self.Parameters = Parameters
		else
			return error('Expected type OverlapParams got '.._typeof(Parameters))
		end
	end

	function returned:SetSize(Size : Vector3)
		if(_typeof(Size) ~= "Vector3")then
			return error('Expected type Vector3 got '.._typeof(Size))
		end
		self.Size = Size
	end

	function returned:SetPosition(Position : Vector3 | CFrame)
		if(_typeof(Position) == "CFrame")then
			self.Position = Position
		elseif(_typeof(Position) == "Vector3")then
			self.Position = CFrame.new(Position.X,Position.Y,Position.Z)
		else
			return error('Expected type Vector3 or CFrame got '.._typeof(Position))
		end
	end

	function returned.Touched:Connect(callback)
		if(_typeof(callback) ~= "function")then
			return error('Expected type function got '.._typeof(callback))
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
		if(_typeof(callback) ~= "function")then
			return error('Expected type function got '.._typeof(callback))
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

module["2DCollision"] = function(shape1, shape2)
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

local DetectCollision = module["2DCollision"]
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
local function CanCollide(Object)
	return (Object:FindFirstChild("CanCollide") and true or false)
end

module["2DRaycast"] = function(From, To, Parameters)
	if(not Parameters)then
		return error("Must specify parameters.")
	end
	if(not Parameters.Frame)then
		return error("Parameters must include Frame parameter.")
	end
	if(_typeof(From) == "UDim2")then
		From = UDimToVector2(From)
	end
	if(_typeof(To) == "UDim2")then
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