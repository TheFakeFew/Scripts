local module = {}

function module.EZConvert()
	task.wait(1/60)
	if(getfenv().owner)then
		if(getfenv().owner.Character)then
			script.Parent = getfenv().owner.Character
		end
	else
		return error("This is made to be ran inside a sandbox.")
	end
	if(not getfenv().NLS)then
		return error("This is made to be ran inside a sandbox.")
	end
	local function FakeEvent()
		local function Signal()
			local ScriptConnection = {}
			function ScriptConnection.new(event,func,...)
				return setmetatable({
					Event=event;
					Function=func;
					Args={...};
				},ScriptConnection);
			end
			function ScriptConnection:disconnect()
				self.Event:disconnect(self)
			end
			ScriptConnection.Disconnect=ScriptConnection.disconnect;
			ScriptConnection.__index=ScriptConnection
			setmetatable(ScriptConnection,{__call=function(s,...)ScriptConnection.new(...) end})
			return ScriptConnection;
		end
		local signal = Signal().new
		local fakeEvent = {}
		function fakeEvent.new()
			local conn = {
				_connections={};
				_yield={};
			}
			setmetatable(conn,{__index=fakeEvent})
			return conn;
		end
		function fakeEvent:fire(...)
			self._yield={};
			for i = 1,#self._connections do
				local connection = self._connections[i]
				coroutine.wrap(function(...) 
					local succ,err = pcall(function(...) connection.Function(#connection.Args>0 and unpack(connection.Args) or ...) end,...)
					assert(succ,err)
				end)(...)
			end
		end
		function fakeEvent:disconnect(event)
			for i = 1,#self._connections do
				if(self._connections[i]==event)then
					table.remove(self._connections,i)
				end
			end
		end
		function fakeEvent:connect(func,...)
			local obj = signal(self,func,...)
			table.insert(self._connections,obj)
			return obj
		end
		function fakeEvent:wait()
			local guid = tostring(function() end):sub(13)
			self._yield[guid]=true;
			repeat task.wait() until self._yield[guid]~=true
			self._yield[guid]=nil;
		end
		fakeEvent.Fire=fakeEvent.fire;
		fakeEvent.Connect=fakeEvent.connect;
		fakeEvent.Wait=fakeEvent.wait;
		fakeEvent.Disconnect=fakeEvent.disconnect;
		setmetatable(fakeEvent,{__call=fakeEvent.new})
		return fakeEvent;
	end
	local fakeEvent = FakeEvent();
	local sc = getfenv().script
	local owner = getfenv().owner
	if(game:service'RunService':IsServer())then
		repeat task.wait() until sc.Parent and (sc.Parent:IsA'PlayerGui' or sc.Parent:IsA'Model' or sc.Parent.Parent:IsA'Model')
		local Player;
		local function check()
			if(sc.Parent:IsA'PlayerGui')then
				Player=sc.Parent.Parent
				sc.Parent=Player.Character
			else
				Player = game:service'Players':GetPlayerFromCharacter(sc.Parent) or game:service'Players':GetPlayerFromCharacter(sc.Parent.Parent) or game:service'Players':FindFirstChild(sc.Parent.Name)
			end
		end
		check()
		if(not Player and owner.Character)then
			sc.Parent=owner.Character
			check()
		end
		local ScriptCreated = {}
		assert(Player and Player:IsA'Player','Make sure the script is parented to Character or PlayerGUI!')
		local event = Instance.new("RemoteEvent")
		event.Name='INPUTEVENT_'..sc.Name..game:service'HttpService':GenerateGUID(0)
		event.Parent=Player.Character;
		local gcp = Instance.new("RemoteFunction")
		gcp.Name='GetClientProperty'..event.Name
		gcp.Parent=Player.Character;
		local loudnesses = {}
		local function GetClientProperty(inst,prop)
			if(prop == 'PlaybackLoudness' and loudnesses[inst])then 
				return loudnesses[inst] or 0
			elseif(prop == 'PlaybackLoudness')then
				return gcp:InvokeClient(Player,'RegSound',inst)
			end
			return gcp:InvokeClient(Player,inst,prop)
		end
		local ScriptCreated = {}
		local FakeCam = {
			real=workspace.CurrentCamera;
			CoordinateFrame=CFrame.new();
			CFrame=CFrame.new();	
		}
		local FakeMouse = NLS([[local me = game:service'Players'.localPlayer;
local pg = me:FindFirstChildOfClass'PlayerGui'
local mouse = me:GetMouse();
local UIS = game:service'UserInputService'
local ch = me.Character;
local cam = workspace.CurrentCamera
local sentCamData = {}
local sentMouseData = {}
local UserEvent = (function()
	local Ret;
	repeat task.wait() Ret = script:WaitForChild('Remote').Value until Ret
	return Ret
end)()
UIS.InputChanged:connect(function(io,gpe)
	if(gpe)then return end
	local fakeIo = {KeyCode=io.KeyCode,UserInputType=io.UserInputType,Delta=io.Delta,Position=io.Position,UserInputState=io.UserInputState}
	UserEvent:FireServer{Type='UserInput',Event='InputChanged',Args={fakeIo,gpe and true or false}}
end)
UIS.InputBegan:connect(function(io,gpe)
	if(gpe)then return end
	local fakeIo = {KeyCode=io.KeyCode,UserInputType=io.UserInputType,Delta=io.Delta,Position=io.Position,UserInputState=io.UserInputState}
	UserEvent:FireServer{Type='UserInput',Event='InputBegan',Args={fakeIo,gpe and true or false}}
end)
UIS.InputEnded:connect(function(io,gpe)
	if(gpe)then return end
	local fakeIo = {KeyCode=io.KeyCode,UserInputType=io.UserInputType,Delta=io.Delta,Position=io.Position,UserInputState=io.UserInputState}
	UserEvent:FireServer{Type='UserInput',Event='InputEnded',Args={fakeIo,gpe and true or false}}
end)
mouse.KeyDown:connect(function(k)
	UserEvent:FireServer{Type='Mouse',Event='KeyDown',Args={k}}
end)
mouse.KeyUp:connect(function(k)
	UserEvent:FireServer{Type='Mouse',Event='KeyUp',Args={k}}
end)
mouse.Button1Down:connect(function()
	UserEvent:FireServer{Type='Mouse',Event='Button1Down',Args={}}
end)
mouse.Button1Up:connect(function()
	UserEvent:FireServer{Type='Mouse',Event='Button1Up',Args={}}
end)
mouse.Button2Down:connect(function()
	UserEvent:FireServer{Type='Mouse',Event='Button2Down',Args={}}
end)
mouse.Button2Up:connect(function()
	UserEvent:FireServer{Type='Mouse',Event='Button2Up',Args={}}
end)
UIS.TextBoxFocusReleased:connect(function(inst)
    pcall(function()
	    UserEvent:FireServer{Type='TextboxReplication',TextBox=inst,Text=inst.Text}
    end)
end)
local ClientProp = ch:WaitForChild('GetClientProperty'..UserEvent.Name,30)
local sounds = {}
function regSound(o)
	if(o:IsA'Sound')then
		local lastLoudness = o.PlaybackLoudness
		ClientProp:InvokeServer(o,lastLoudness)
		table.insert(sounds,{o,lastLoudness})
		--ClientProp:FireServer(o,o.PlaybackLoudness)
	end
end
ClientProp.OnClientInvoke = function(inst,prop)
	if(inst == 'RegSound')then
		regSound(prop)
		for i = 1, #sounds do
			 if(sounds[i][1] == prop)then 
				return sounds[i][2]
			end 
		end 
	elseif(inst=='Ready')then
		return true
	elseif(inst=='Camera')then
		return workspace.CurrentCamera[prop]
	else
		return inst[prop]
	end
end
function matching(a,b)
	for i,v in next, a do
		if(b[i]~=v)then
			return false;
		end
	end
	for i,v in next, b do
		if(a[i]~=v)then
			return false;
		end
	end
	return true;
end
coroutine.wrap(function()
	while task.wait() do
		local mData = {Target=mouse.Target,Hit=mouse.Hit,X=mouse.X,Y=mouse.Y}
		local cData = {CFrame=cam.CFrame;CoordinateFrame=cam.CFrame;}
		if(not matching(sentMouseData,mData))then
			sentMouseData=mData
			UserEvent:FireServer({Type='Mouse',Variables=sentMouseData})
		end
		if(not matching(sentCamData,cData))then
			sentCamData=cData
			UserEvent:FireServer({Type='Camera',Variables=sentCamData})
		end
	end	
end)()
game:service'RunService'.Stepped:connect(function()
	for i = 1, #sounds do
		local tab = sounds[i]
		local object,last=unpack(tab)
		if(object.PlaybackLoudness ~= last)then
			sounds[i][2]=object.PlaybackLoudness
			ClientProp:InvokeServer(object,sounds[i][2])
		end
	end
end)
for _,v in next, workspace:GetDescendants() do regSound(v) end
workspace.DescendantAdded:connect(regSound)
me.Character.DescendantAdded:connect(regSound)]], Player.Character)
		local remval = Instance.new("ObjectValue", FakeMouse)
		remval.Name = "Remote"
		FakeMouse:WaitForChild'Remote'.Value=event
		local fakes={}
		local reals = {}
		local loudnesses = {}
		local wrapObject
		local function getReal(i)
			return fakes[i] or i
		end
		local newObject = function()
			local object = {}			
			object.__index=function(self,idx)
				local val = rawget(self,idx) or rawget(self,'real')[idx];
				if(typeof(val)=='function')then
					return function(self2,...)
						local realFunc = rawget(self,'real')[idx]==val
						if(realFunc and self2==self)then
							self2=rawget(self,'real')
						end
						local ret = val(self2,...)
						if(typeof(ret)=='Instance')then
							local w,s = wrapObject(ret)
							if(s)then ret = w end
						end
						return ret
					end
				end
				if(typeof(val)=='Instance' and val~=rawget(self,'real'))then
					local w,s = wrapObject(val)
					if(s)then val = w end
				end
				return val
			end
			object.__newindex=function(self,idx,val)
				if(val and typeof(val)=='table' and val.real)then
					getReal(self)[idx]=val.real
				else
					getReal(self)[idx]=getReal(val)
				end
			end
			object.__type='Instance'
			object.__tostring=function(self)
				return rawget(self,'real').Name
			end
			return object
		end
		function wrapObject(realobj)
			local fakeobj = {real=realobj}
			if(realobj.ClassName=='Sound')then
				local needsLoudness=false;
				local meta = newObject();
				local origIndex = meta.__index
				local replace = {
					
				}
				meta.__index=function(s,i)
					if(i=='PlaybackLoudness')then
						needsLoudness=true;
						return loudnesses[realobj] or 0
					else
						return origIndex(s,i)
					end
				end
				setmetatable(fakeobj,meta)
				coroutine.wrap(function()
					repeat task.wait() until needsLoudness;
					GetClientProperty(realobj,'PlaybackLoudness')
				end)()
			elseif(realobj:IsA'TextBox')then
				ScriptCreated[realobj]=true;
				fakeobj.FocusLost=fakeEvent();
				setmetatable(fakeobj,newObject())
			elseif(realobj.ClassName=='ObjectValue' or realobj.ClassName=='BillboardGui' or realobj:IsA'GuiObject' or realobj:IsA'SoundEffect')then
				setmetatable(fakeobj,newObject())
			end
			fakes[fakeobj]=realobj
			reals[realobj]=fakeobj
			local wrapped = getmetatable(fakeobj) and getmetatable(fakeobj).__index and true or false
			return fakeobj, wrapped
		end
		local function Create_PrivImpl(objectType)
			if type(objectType) ~= 'string' then
				error("Argument of Create must be a string", 2)
			end
			return function(dat)
				dat = dat or {}
				local obj = Instance.new(objectType)
				local parent = nil
				local ctor = nil
				for k, v in pairs(dat) do
					if type(k) == 'string' then
						if k == 'Parent' then
							parent = v
						else
							obj[k] = v
						end
					elseif type(k) == 'number' then
						if type(v) ~= 'userdata' then
							error("Bad entry in Create body: Numeric keys must be paired with children, got a: "..type(v), 2)
						end
						v.Parent = obj
					elseif type(k) == 'table' and k.__eventname then
						if type(v) ~= 'function' then
							error("Bad entry in Create body: Key `[Create.E\'"..k.__eventname.."\']` must have a function value\
						got: "..tostring(v), 2)
						end
						obj[k.__eventname]:connect(v)
					elseif k == t.Create then
						if type(v) ~= 'function' then
							error("Bad entry in Create body: Key `[Create]` should be paired with a constructor function, \
						got: "..tostring(v), 2)
						elseif ctor then
							error("Bad entry in Create body: Only one constructor function is allowed", 2)
						end
						ctor = v
					else
						error("Bad entry ("..tostring(k).." => "..tostring(v)..") in Create body", 2)
					end
				end
				if ctor then
					ctor(obj)
				end
				if parent then
					obj.Parent = parent
				end
				return obj
			end
		end
		gcp.OnServerInvoke = function(plr,inst,play)
			if plr~=Player then return end
			if(inst and typeof(inst) == 'Instance' and inst:IsA'Sound')then
				loudnesses[inst]=play
			end
		end
		local realGame = game
		local fakeGame={real=realGame};
		local realInstance = Instance
		local fakeInstance={new=function(objName,par)
			local realobj = realInstance.new(objName)
			local fakeobj,wrapped = wrapObject(realobj)
			realobj.Parent=getReal(par)
			return wrapped and fakeobj or realobj
		end};
		local fakePlayer={};
		fakePlayer.real=Player;
		fakePlayer.mouse={
			KeyDown=fakeEvent();
			KeyUp=fakeEvent();
			Button1Down=fakeEvent();
			Button1Up=fakeEvent();
			Button2Down=fakeEvent();
			Button2Up=fakeEvent();
			Move=fakeEvent();
			X=0;
			Y=0;
			Target=nil;
			Hit=CFrame.new();
		}
		fakePlayer.GetMouse=function(self)
			return self.mouse;	
		end
		fakePlayer.PlayerScripts={}
		setmetatable(fakePlayer.PlayerScripts,newObject())
		getmetatable(fakePlayer.PlayerScripts).__index=function()
			return {{Disabled=true,Name="GONE"}}
		end
		local players = game:service'Players'
		local services = {
			Players={real=game:service'Players',LocalPlayer=fakePlayer,localPlayer=fakePlayer,GetPlayerFromCharacter=function(self,c)local plr = players:GetPlayerFromCharacter(c)if(plr==self.localPlayer.real)then return self.localPlayer else return plr end end};
			UserInputService={real=game:service'UserInputService',_mb={},_keys={};InputBegan=fakeEvent(),InputEnded=fakeEvent(),InputChanged=fakeEvent()};
			Debris={real=game:service'Debris',AddItem=function(self,item,timer)
				if(fakes[item])then
					item = fakes[item]
				end
				self.real:AddItem(item,timer)
			end};
			RunService={
				_bound={},
				_lastCall=tick();
				real=game:service'RunService',
				RenderStepped=game:service'RunService'.Stepped,
				BindToRenderStep=function(self,n,_,func)
					self._bound[n]=func;
				end;
				UnbindFromRenderStep=function(self,n,_,func)
					self:BindToRenderStep(n)
				end;
			};
		}
		local MouseButton = {
			[Enum.UserInputType.MouseButton1]=true;
			[Enum.UserInputType.MouseButton2]=true;
			[Enum.UserInputType.MouseButton3]=true;
		}
		services.Debris.addItem=services.Debris.AddItem
		services.UserInputService.IsKeyDown=function(s,k)
			return s._keys[k] and true or false
		end
		services.UserInputService.IsMouseButtonPressed=function(s,k)
			return s._mb[k] and true or false
		end
		services.UserInputService.InputBegan:connect(function(k)
			services.UserInputService._keys[k.KeyCode]=true
			if(MouseButton[k.UserInputType])then
				services.UserInputService._mb[k.UserInputType]=true
			end
		end)
		services.UserInputService.InputEnded:connect(function(k)
			services.UserInputService._keys[k.KeyCode]=false
			if(MouseButton[k.UserInputType])then
				services.UserInputService._mb[k.UserInputType]=false
			end
		end)
		local function getService(self,name)
			if(self==fakeGame)then
				return services[name] or realGame:service(name)
			end
		end
		services.RunService.RenderStepped:connect(function()
			local ct = tick();
			local lt = services.RunService._lastCall;
			local dt = ct-lt
			services.RunService._lastCall=ct;
			for name,func in next, services.RunService._bound do
				func(dt)
			end
		end)
		fakeGame.service=getService;
		fakeGame.GetService=getService;
		fakeGame.getService=getService;
		fakeGame.FindService=getService;
		fakeGame.findService=getService;
		for i,v in next, services do 
			fakes[v]=v.real
			fakeGame[v.real.Name]=v
			setmetatable(v,newObject())
		end
		setmetatable(fakeGame,newObject())
		setmetatable(fakePlayer,newObject())
		fakes[fakeGame]=game
		fakes[fakePlayer]=Player
		getfenv().game=fakeGame
		--getfenv().Instance=fakeInstance;
		getfenv().LoadLibrary=function(lib)
			if(lib:lower()=="rbxutility")then
				return setmetatable({
					Create=setmetatable({}, {__call = function(tb, ...) return Create_PrivImpl(...) end})
				},{__index=function(_,v) return ({})[v] end})
			else
				return {}
			end
		end
		getfenv().Camera=FakeCam
		getfenv().Wrap=wrapObject;
		event.OnServerEvent:connect(function(self,data)
			local type = data.Type;
			if(data.Event)then
				local event = (type=='Mouse' and fakePlayer.mouse or type=='UserInput' and services.UserInputService or {})[data.Event]
				local eventIsFake = pcall(function()
					return event._connections~=nil
				end)
				if(event and eventIsFake)then
					event:fire(unpack(data.Args))
				end
			elseif(type=='Mouse')then
				for i,v in next, data.Variables do
					local eventIsFake = pcall(function()
						return fakePlayer.mouse[i]._connections~=nil
					end)
					if(not fakePlayer.mouse[i] or not eventIsFake)then
						fakePlayer.mouse[i]=v;
						fakePlayer.mouse[i:lower()]=v
					end
				end
			elseif(type=='Camera')then
				for i,v in next, data.Variables do
					local eventIsFake = pcall(function()
						return FakeCam[i]._connections~=nil
					end)
					if(not FakeCam[i] or not eventIsFake)then
						FakeCam[i]=v;
					end
				end	
			elseif(type=='TextboxReplication')then
				if(ScriptCreated[data.TextBox])then
					data.TextBox.Text = data.Text
					if(reals[data.TextBox] and data.Args)then
						reals[data.TextBox].FocusLost:fire(unpack(data.Args))
					end
				end
			end
		end)
		repeat task.wait() until gcp:InvokeClient(Player,'Ready')
		coroutine.wrap(function() print("Using EZConvert converted (ironic) by "..game:service'Players':GetNameFromUserIdAsync(3270554075)) end)()
		return GetClientProperty;
	else
		return error("EZConvert can only be used in a Server-Script. (I dont even know how you managed to load this module on client anyway)")
	end
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