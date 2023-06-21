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
			elseif k == Create then
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

Create = setmetatable({}, {__call = function(tb, ...) return Create_PrivImpl(...) end})

CFuncs = {
	["Sound"] = {
		Create = function(id, par, vol, pit) 
			task.spawn(function()
				local S = Create("Sound"){
					Volume = vol,
					Name = "EffectSoundo",
					Pitch = pit or 1,
					SoundId = id,
					Parent = par or workspace,
				}
				task.wait() 
				S:play() 
				game:GetService("Debris"):AddItem(S, 10)
			end)
		end;
	};
	["EchoSound"] = {
		Create = function(id, par, vol, pit, timepos,delays,echodelay,fedb,dryl) 
			task.spawn(function()
				local Sas = Create("Sound"){
					Volume = vol,
					Name = "EffectSoundo",
					Pitch = pit or 1,
					SoundId = id,
					TimePosition = timepos,
					Parent = par or workspace,
				}
				local E = Create("EchoSoundEffect"){
					Delay = echodelay,
					Name = "Echo",
					Feedback = fedb,
					DryLevel = dryl,
					Parent = Sas,
				}
				task.wait() 
				Sas:play() 
				game:GetService("Debris"):AddItem(Sas, delays)
			end)
		end;
	};
}

function sphere2(bonuspeed,type,pos,scale,value,value2,value3,color)
	local type = type
	local rng = Instance.new("Part", workspace)
	rng.Anchored = true
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	rng.Color = color.Color
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Brick"
	rngm.Scale = scale
	local scaler2 = 1
	local scaler2b = 1
	local scaler2c = 1
	if type == "Add" then
		scaler2 = 1*value
		scaler2b = 1*value2
		scaler2c = 1*value3
	elseif type == "Divide" then
		scaler2 = 1/value
		scaler2b = 1/value2
		scaler2c = 1/value3
	end
	task.spawn(function()
		for i = 0,10/bonuspeed,0.1 do
			task.wait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
				scaler2b = scaler2b - 0.01*value/bonuspeed
				scaler2c = scaler2c - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
				scaler2b = scaler2b - 0.01/value*bonuspeed
				scaler2c = scaler2c - 0.01/value*bonuspeed
			end
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2b*bonuspeed, scaler2c*bonuspeed)
		end
		rng:Destroy()
	end)
end

function createBGCircle(size,parent,color)
	local bgui = Instance.new("BillboardGui",parent)
	bgui.Size = UDim2.new(size, 0, size, 0)
	local imgc = Instance.new("ImageLabel",bgui)
	imgc.BackgroundTransparency = 1
	imgc.ImageTransparency = 0
	imgc.Size = UDim2.new(1,0,1,0)
	imgc.Image = "rbxassetid://997291547" --997291547,521073910
	imgc.ImageColor3 = color
	return bgui,imgc
end

function symbolizeBlink(guipar,size,img,color,bonussize,vol,pit,soundid,spar,rotationenabled,rotsp,delay)
	local bgui,imgc = createBGCircle(size,guipar,color)
	bgui.AlwaysOnTop = true
	imgc.Image = "rbxassetid://" ..img
	local rrot = math.random(1,2)
	CFuncs["Sound"].Create("rbxassetid://" ..soundid, spar, vol,pit)
	task.spawn(function()
		for i = 0, 24*delay do
			task.wait()
			if rotationenabled == true then
				if rrot == 1 then
					imgc.Rotation = imgc.Rotation + rotsp
				elseif rrot == 2 then
					imgc.Rotation = imgc.Rotation - rotsp
				end
			end
			bgui.Size = bgui.Size + UDim2.new(1*bonussize/delay,0,1*bonussize/delay,0)
			imgc.ImageTransparency = imgc.ImageTransparency + 0.04/delay
		end
		bgui:Destroy()
	end)
end

function CreateParta(parent,transparency,reflectance,material,brickcolor)
	local p = Instance.new("Part")
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = parent
	p.Size = Vector3.new(0.1,0.1,0.1)
	p.Transparency = transparency
	p.Reflectance = reflectance
	p.CanCollide = false
	p.Locked = true
	p.BrickColor = brickcolor
	p.Material = material
	return p
end

function slash(bonuspeed,rotspeed,rotatingop,typeofshape,type,typeoftrans,pos,scale,value,color)
	local type = type
	local rotenable = rotatingop
	local rng = Instance.new("Part", workspace)
	rng.Anchored = true
	rng.BrickColor = color
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	if typeoftrans == "In" then
		rng.Transparency = 1
	end
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	rng.Color = color.Color
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "FileMesh"
	if typeofshape == "Normal" then
		rngm.MeshId = "rbxassetid://662586858"
	elseif typeofshape == "Round" then
		rngm.MeshId = "rbxassetid://662585058"
	end
	rngm.Scale = scale
	local scaler2 = 1/10
	if type == "Add" then
		scaler2 = 1*value/10
	elseif type == "Divide" then
		scaler2 = 1/value/10
	end
	local randomrot = math.random(1,2)
	task.spawn(function()
		for i = 0,10/bonuspeed,0.1 do
			task.wait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed/10
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed/10
			end
			if rotenable == true then
				if randomrot == 1 then
					rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(rotspeed*bonuspeed/2),0)
				elseif randomrot == 2 then
					rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(-rotspeed*bonuspeed/2),0)
				end
			end
			if typeoftrans == "Out" then
				rng.Transparency = rng.Transparency + 0.01*bonuspeed
			elseif typeoftrans == "In" then
				rng.Transparency = rng.Transparency - 0.01*bonuspeed
			end
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed/10, 0, scaler2*bonuspeed/10)
		end
		rng:Destroy()
	end)
end

function bosschatfunc(text,color,watval)
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		task.spawn(function()
			if v.PlayerGui:FindFirstChild("Dialog")~= nil then
				v.PlayerGui:FindFirstChild("Dialog"):destroy()
			end
			local scrg = Instance.new("ScreenGui",v.PlayerGui)
			CFuncs["EchoSound"].Create("rbxassetid://525200869", scrg, 0.5, 1,0,10,0.1,0.25,1)
			scrg.Name = "Dialog"
			local txtlb = Instance.new("TextLabel",scrg)
			txtlb.Text = ""
			txtlb.Font = "Arcade"
			txtlb.TextColor3 = Color3.new(0,0,0)
			txtlb.TextStrokeTransparency = 0
			txtlb.BackgroundTransparency = 0.75
			txtlb.BackgroundColor3 = Color3.new(0,0,0)
			txtlb.TextStrokeColor3 = color
			txtlb.TextScaled = true
			txtlb.Size = UDim2.new(1,0,0.25,0)
			txtlb.TextXAlignment = "Left"
			txtlb.Position = UDim2.new(0,0,0.75 + 1,0)
			local txtlb2 = Instance.new("TextLabel",scrg)
			txtlb2.Text = "EL RATTUS:"
			txtlb2.Font = "Arcade"
			txtlb2.TextColor3 = Color3.new(0,0,0)
			txtlb2.TextStrokeTransparency = 0
			txtlb2.BackgroundTransparency = 1
			txtlb2.TextStrokeColor3 = color
			txtlb2.TextSize = 40
			txtlb2.Size = UDim2.new(1,0,0.25,0)
			txtlb2.TextXAlignment = "Left"
			txtlb2.Position = UDim2.new(0,0,1,0)
			local fvalen = 0.55
			local fval = -0.49
			task.spawn(function()
				while true do
					task.wait()
					txtlb.Rotation = math.random(-1,1)
					txtlb2.Rotation = math.random(-1,1)
					txtlb.Position = txtlb.Position + UDim2.new(0,math.random(-1,1)/5,0,math.random(-1,1)/5)
					txtlb2.Position = txtlb2.Position + UDim2.new(0,math.random(-1,1)/5,0,math.random(-1,1)/5)
					txtlb.TextStrokeColor3 = (math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color
					txtlb2.TextStrokeColor3 = (math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color
				end
			end)
			task.spawn(function()
				while true do
					task.wait()
					if scrg.Parent ~= nil then
						fvalen = fvalen - 0.0001
					elseif scrg.Parent == nil then
						break
					end
				end
			end)
			local flol = 1.75
			local flil = 1.6
			task.spawn(function()
				for i = 0, 9 do
					task.wait()
					fval = fval + 0.05
					flol = flol - 0.1
					flil = flil - 0.1
					txtlb.Text = ""
					txtlb.Position = UDim2.new(0,0,flol,0)
					txtlb2.Position = UDim2.new(0,0,flil,0)
				end
				txtlb.Text = text
				task.wait(watval)
				local valinc = 0
				for i = 0, 99 do
					task.wait()
					valinc = valinc + 0.0001
					flol = flol + valinc
					flil = flil + valinc
					txtlb.Rotation = txtlb.Rotation + valinc*20
					txtlb2.Rotation = txtlb2.Rotation - valinc*50
					txtlb.Position = UDim2.new(0,0,flol,0)
					txtlb2.Position = UDim2.new(0,0,flil,0)
					txtlb.TextStrokeTransparency = txtlb.TextStrokeTransparency + 0.01
					txtlb.TextTransparency = txtlb.TextTransparency + 0.01
					txtlb2.TextStrokeTransparency = txtlb2.TextStrokeTransparency + 0.01
					txtlb2.TextTransparency = txtlb2.TextTransparency + 0.01
					txtlb.BackgroundTransparency = txtlb.BackgroundTransparency + 0.0025
				end
				scrg:Destroy()
			end)
		end)
	end
end

local loaded = LoadAssets(13233384945)
local assets = loaded:Get("RattusAssets")

local rat = assets.stuffs.Rat
rat.Parent = nil

CFuncs["EchoSound"].Create("rbxassetid://7616700381", workspace, 2, 1, 0, 10, 0.15, 0.5, 1)
bosschatfunc("im come you.", (math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color, 2)

task.wait(8)

local p = Instance.new("Part", workspace)
p.Anchored = true
p.CanCollide = false
p.Transparency = 1
p.Position = Vector3.new(0,2,0)
CFuncs["Sound"].Create("rbxassetid://1368598393", workspace, 2.5, 0.5)
CFuncs["Sound"].Create("rbxassetid://1368598393", workspace, 5, 0.5)
CFuncs["EchoSound"].Create("rbxassetid://1718412034", workspace, 10, 1,0,10,0.15,0.5,1)
bosschatfunc("SHATTER!",(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color,2)
local keptcolor = (math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black"))
for i = 0,8,0.1 do
	task.wait()
end
for i = 0, 99 do
	local dis = CreateParta(p,1,1,"Neon",(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")))
	dis.CFrame = p.CFrame*CFrame.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
	local at1 = Instance.new("Attachment",dis)
	at1.Position = Vector3.new(-25000,0,0)
	local at2 = Instance.new("Attachment",dis)
	at2.Position = Vector3.new(25000,0,0)
	local trl = Instance.new('Trail',dis)
	trl.Attachment0 = at1
	trl.FaceCamera = true
	trl.Attachment1 = at2
	trl.Texture = "rbxassetid://1049219073"
	trl.LightEmission = 1
	trl.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
	trl.Color = ColorSequence.new((math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color)
	trl.Lifetime = 5
	local bv = Instance.new("BodyVelocity")
	bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
	bv.velocity = dis.CFrame.lookVector*math.random(500,2500)
	bv.Parent = dis
	game:GetService("Debris"):AddItem(dis, 5)
end
symbolizeBlink(p,0,2109052855,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color,125,0,0,0,p,false,0,1)
symbolizeBlink(p,0,2109052855,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color,125,0,0,0,p,false,0,1.5)
symbolizeBlink(p,0,2109052855,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color,125,0,0,0,p,false,0,3)
sphere2(2,"Add",p.CFrame,Vector3.new(1,1,1),1,1,1,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")),(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color)
sphere2(2,"Add",p.CFrame,Vector3.new(1,1,1),2,2,2,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")),(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color)
sphere2(2,"Add",p.CFrame,Vector3.new(1,1,1),4,4,4,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")),(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color)
sphere2(2,"Add",p.CFrame,Vector3.new(1,1,1),8,8,8,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")),(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color)
CFuncs["Sound"].Create("rbxassetid://1841058541", p, 10,1)
CFuncs["Sound"].Create("rbxassetid://2095993595", p, 5,0.8)
CFuncs["Sound"].Create("rbxassetid://1841058541", p, 5,1)
for i = 0, 24 do
	slash(math.random(10,30)/10,5,true,"Round","Add","Out",p.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),Vector3.new(0.01,0.01,0.01),math.random(500,1500)/250,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")))
end
local distam = 0
for i = 0, 50 do
	task.wait()
	distam = distam + 1
	local xa = CreateParta(p,1,1,"SmoothPlastic",(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")))
	xa.Anchored = true
	xa.CFrame = p.CFrame*CFrame.new(math.random(-distam,distam),math.random(-distam,distam),math.random(-distam,distam))*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
	game:GetService("Debris"):AddItem(xa, 5)
	for i = 0, 4 do
		slash(math.random(25,50)/10,5,true,"Round","Add","Out",xa.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),Vector3.new(0.01,0.01,0.01),math.random(200,500)/250,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")))
	end
	task.spawn(function()
		local eff = Instance.new("ParticleEmitter",xa)
		eff.Texture = "rbxassetid://2344870656"
		eff.LightEmission = 1
		eff.Color = ColorSequence.new(xa.Color)
		eff.Rate = 1000
		eff.Enabled = true
		eff.Lifetime = NumberRange.new(2.5)
		eff.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,75,0),NumberSequenceKeypoint.new(0.1,20,0),NumberSequenceKeypoint.new(0.8,40,0),NumberSequenceKeypoint.new(1,60,0)})
		eff.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.8,0),NumberSequenceKeypoint.new(0.5,0,0),NumberSequenceKeypoint.new(1,1,0)})
		eff.Speed = NumberRange.new(200)
		eff.Drag = 5
		eff.Rotation = NumberRange.new(-500,500)
		eff.SpreadAngle = Vector2.new(0,900)
		eff.RotSpeed = NumberRange.new(-500,500)
		task.wait(0.2)
		eff.Enabled = false
	end)
	task.spawn(function()
		local eff = Instance.new("ParticleEmitter",xa)
		eff.Texture = "rbxassetid://2273224484"
		eff.LightEmission = 1
		eff.Color = ColorSequence.new((math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color)
		eff.Rate = 5000
		eff.Lifetime = NumberRange.new(1,3)
		eff.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,30,0),NumberSequenceKeypoint.new(0.2,5,0),NumberSequenceKeypoint.new(0.8,5,0),NumberSequenceKeypoint.new(1,0,0)})
		eff.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.1,0,0),NumberSequenceKeypoint.new(0.8,0,0),NumberSequenceKeypoint.new(1,1,0)})
		eff.Speed = NumberRange.new(50,500)
		eff.Drag = 5
		eff.Rotation = NumberRange.new(-500,500)
		eff.VelocitySpread = 9000
		eff.RotSpeed = NumberRange.new(-50,50)
		task.wait(0.25)
		eff.Enabled = false
	end)
	CFuncs["Sound"].Create("rbxassetid://675172759", xa, 7,math.random(100,200)/200)
	sphere2(5,"Add",xa.CFrame,Vector3.new(1,1,1),.5,.5,.5,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")),(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color)
	sphere2(5,"Add",xa.CFrame,Vector3.new(1,1,1),1,1,1,(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")),(math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color)
end

rat.Parent = workspace
rat:MoveTo(p.Position)

local ai = NS([=[
script:WaitForChild("ELRATTUS")

function region3touchedreq()
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

local SearchDistance = 200000
local ZombieDamage = 10
local canWander = true
local WanderX, WanderZ = 30, 30

getfenv().wait = task.wait

local zombie = script.Parent
zombie.Body.Music.SoundId = "rbxassetid://"..1843322216
local human = zombie:FindFirstChildOfClass("Humanoid")
local hroot = zombie.HumanoidRootPart
local zspeed = hroot.Velocity.magnitude
local regiontouched = region3touchedreq()

local pfs = game:GetService("PathfindingService")

function GetPlayersBodyParts(t)
	local torso = t
	if torso then
		local figure = torso.Parent
		for _, v in next, figure:GetChildren() do
			if v:IsA'Part' then
				return v.Name
			end
		end
	else
		return "HumanoidRootPart"
	end
end

function GetNearestPlayer(minimumDistance)
	local closestMagnitude = minimumDistance or math.huge
	local closestPlayer
	for i,v in next, game:GetService("Players"):GetPlayers() do
		local Character = v.Character
		if (Character) then
			local humanoid = Character.Humanoid
			local HRP = Character.HumanoidRootPart
			if (humanoid.Health > 0) and HRP then
				local mag = (hroot.Position - HRP.Position).Magnitude
				if (mag <= closestMagnitude) then
					closestPlayer = v
					closestMagnitude = mag
				end
			end
		end
	end
	return closestPlayer
end

function GetTorso(part)
	local chars = workspace:GetChildren()
	local torso = nil
	local plr = GetNearestPlayer(SearchDistance)
	if plr then
		torso = plr.Character.HumanoidRootPart
	end
	return torso
end

function DamageFunc(p)
	if p and p:FindFirstAncestorOfClass("Model") and game:GetService('Players'):GetPlayerFromCharacter(p:FindFirstAncestorOfClass("Model")) and not p:IsDescendantOf(zombie) then
		local enemy = p:FindFirstAncestorOfClass("Model")
		local enemyhuman = enemy:FindFirstChildOfClass("Humanoid")
		enemyhuman:TakeDamage(math.random(ZombieDamage/2,ZombieDamage))
		if(enemyhuman.Health>0)then
			local snd = Instance.new("Sound", p)
			snd.SoundId = "rbxassetid://1471213022"
			snd.Volume = 6
			snd.PlayOnRemove = true
			snd:Destroy()
		else
			local snd = Instance.new("Sound", p)
			snd.SoundId = "rbxassetid://347611423"
			snd.Volume = 10
			snd.Pitch = math.random(90,110)/100
			snd.PlayOnRemove = true
			snd:Destroy()
		end
	end
end

for i,v in next, zombie:GetDescendants() do
	if(v:IsA("BasePart"))then
		local t = regiontouched:Parse(v)
		t.Touched:Connect(DamageFunc)
	end
end

local path
local waypoint
local oldpoints
local isWandering = 0

if canWander then
	task.spawn(function()
		while isWandering == 0 do
			isWandering = 1
			local desgx, desgz = hroot.Position.x + math.random(-WanderX, WanderX), hroot.Position.z + math.random(-WanderZ, WanderZ)
			human:MoveTo(Vector3.new(desgx, 0, desgz))
			wait(math.random(4, 6))
			isWandering = 0
		end
	end)
end
local sounds = {}
script.Parent.Humanoid:LoadAnimation(script.Parent.Animation):Play()
for i,v in next, script.Parent.HumanoidRootPart:GetChildren() do
	if v:IsA("Sound") then
		table.insert(sounds,v)
	end
end
local spikeupd = 0
function Lightning(Part0, Part1, Times, Offset, Color, Thickness, Trans, randm)
	local Tabl = {}
	local magz = (Part0 - Part1).magnitude
	local curpos = Part0
	local lightningparts = {}
	local trz = {
		-Offset,
		Offset
	}
	Times = (Part0 - Part1).Magnitude/5
	if Times > 5 then
		local sp = Instance.new('Part', zombie)
		sp.Position = Part0
		sp.Anchored = true
		sp.Transparency = 1
		sp.CanCollide = false
		local sn = Instance.new('Sound',sp)
		sn.SoundId = "rbxassetid://"..821439273
		sn.Volume = Times/6
		sn.Pitch = math.random(50,150)/100
		sn.PlayOnRemove = true
		sn:Play()
		sn:Destroy()
		game:GetService('Debris'):AddItem(sp, 0.01)
	end
	if Times >= 20 then
		local sp = Instance.new('Part',zombie)
		sp.Position = Part1
		sp.Anchored = true
		sp.Transparency = 1
		sp.CanCollide = false
		local sn = Instance.new('Sound',sp)
		sn.SoundId = "rbxassetid://"..821439273
		sn.Volume = Times/6
		sn.Pitch = math.random(50,150)/100
		sn.PlayOnRemove = true
		sn:Play()
		sn:Destroy()
		game:GetService('Debris'):AddItem(sp, 0.01)
	end
	for i = 1, Times do
		local li = Instance.new("Part", zombie)
		li.Name = "Lightning"
		li.TopSurface = 0
		li.Material = "Neon"
		li.BottomSurface = 0
		li.Anchored = true
		li.Locked = true
		li.Transparency = 1
		li.Color = Color
		li.formFactor = "Custom"
		li.CanCollide = false
		li.Size = Vector3.new(Thickness, Thickness, magz / Times)
		local Offzet = Vector3.new(trz[math.random(1, 2)], trz[math.random(1, 2)], trz[math.random(1, 2)])
		local trolpos = CFrame.new(curpos, Part1) * CFrame.new(0, 0, magz / Times).Position + Offzet
		if Times == i then
			local magz2 = (curpos - Part1).magnitude
			li.Size = Vector3.new(Thickness, Thickness, magz2)
			li.CFrame = CFrame.new(curpos, Part1) * CFrame.new(0, 0, -magz2 / 2)
		else
			li.CFrame = CFrame.new(curpos, trolpos) * CFrame.new(0, 0, magz / Times / 2)
		end
		curpos = li.CFrame * CFrame.new(0, 0, magz / Times / 2).Position
		game:GetService('Debris'):AddItem(li, 0.01)
		local prt = Instance.new('Part', zombie)
		prt.Material = Enum.Material.Neon
		prt.Reflectance = 0
		prt.Transparency = 1
		prt.Color = Color
		prt.Name = "Effect"
		prt.Size = Vector3.new(0.05,0.05,0.05)
		prt.Anchored = true
		prt.CFrame = li.CFrame
		prt.Anchored = true
		prt.CanCollide = false
		local Msh = Instance.new("BlockMesh")
		Msh.Parent = prt
		Msh.Offset = Vector3.new(0, 0, 0)
		Msh.Scale = Vector3.new(0,0,li.Size.Z * 20)
		if(math.random(1,5) == 5) then
			coroutine.wrap(function()
				Lightning(li.Position,li.Position+Vector3.new(math.random(-5,5),math.random(-5,5),math.random(-5,5)),Times,Offset,Color,Thickness,Trans,randm)
			end)()
		end
		if randm then
			prt.Color = Color3.new(math.random(),math.random(),math.random())
		end
		coroutine.wrap(function()
			local tw = game:GetService('TweenService'):Create(Msh,TweenInfo.new(1),{
				Scale = Vector3.new(li.Size.X * 20,li.Size.Y * 20, li.Size.Z * 20)
			})
			game:GetService('TweenService'):Create(prt,TweenInfo.new(1),{
				Transparency = 0
			}):Play()
			tw:Play()
			tw.Completed:wait()
			game:GetService('TweenService'):Create(Msh,TweenInfo.new(1),{
				Scale = Vector3.new(0,0,Msh.Scale.Z)
			}):Play()
			game:GetService('TweenService'):Create(prt,TweenInfo.new(1),{
				Transparency = 1,
				Position = prt.Position+(Vector3.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))*Thickness)
			}):Play()
			wait(1)
			prt:Destroy()
		end)()
		wait()
	end
end

game:GetService("RunService").Heartbeat:Connect(function()
	for i, v in next, game:GetService("Players"):GetPlayers() do
		if(not v.PlayerGui:FindFirstChild("ELRATTUS"))then
			local a = script.ELRATTUS:Clone()
			a.Parent = v:FindFirstChildOfClass("PlayerGui")
		end
		local r = v.PlayerGui:FindFirstChild("ELRATTUS")
		r.Frame.hp.name.TextColor3 = Color3.new(math.random(), 0, 0)
		r.Frame.hp.name.TextStrokeColor3 = Color3.new(math.random(), 0, 0)
		r.Frame.hp.name.Font = Enum.Font:GetEnumItems()[math.random(1, #Enum.Font:GetEnumItems())]
		r.Frame.hp.BackgroundColor3 = Color3.new(math.random(), 0, 0)
		
		r.Frame.hp.name.Rotation = math.random(-1,1)
		r.Frame.hp.Rotation = math.random(-1,1)
		r.Frame.Rotation = math.random(-1,1)
	end

	zombie.Highlight.OutlineColor = Color3.new(math.random(),0,0)
	zombie.BillboardGui.TextLabel.TextColor3 = Color3.new(math.random(),0,0)
	zombie.BillboardGui.TextLabel.TextStrokeColor3 = Color3.new(math.random(),0,0)
	zombie.BillboardGui.TextLabel.Rotation = math.random(-5,5)

	zombie.Spin.Weld.C1 *= CFrame.Angles(0,math.rad(5),0)

	if math.random(1,200) == 1 then
		sounds[math.random(1,#sounds)]:Play()
	end
	if math.random(1,80) == 1 then
		task.spawn(function()
			Lightning(hroot.Position + Vector3.new(math.random(-30,30),math.random(0,10),math.random(-30,30)), hroot.Position + Vector3.new(math.random(-30,30),math.random(0,10),math.random(-30,30)),1,2,Color3.new(1,0,0),.2,0,false)
		end)
	end
	
	local enemytorso = GetTorso(hroot.Position)
	
	if enemytorso ~= nil then
		isWandering = 1
		if (hroot.Position - enemytorso.Position).Magnitude < 100 then
			spikeupd += 1
			if spikeupd == 100 then
				spikeupd = 0
				local params = RaycastParams.new()
				params.FilterType = Enum.RaycastFilterType.Blacklist
				params.FilterDescendantsInstances = {enemytorso.Parent}
				local rayc = workspace:Raycast(enemytorso.Position,Vector3.new(0,-20,0),params)
				if rayc then
					local cyl = Instance.new("Part",zombie)
					cyl.Anchored = true
					cyl.CanCollide = false
					cyl.Shape = "Cylinder"
					cyl.Position = rayc.Position
					cyl.Orientation = Vector3.new(0,0,90)
					cyl.Size = Vector3.new(.1,5,5)
					cyl.Material = Enum.Material.Neon
					cyl.Color = Color3.new(1,0,0)
					cyl.Transparency = 1
					coroutine.wrap(function()
						local tw = game:GetService('TweenService'):Create(cyl,TweenInfo.new(.6),{
							Transparency = 0
						})
						tw:Play()
						tw.Completed:Wait()
						local sp = script.Spike:Clone()
						sp.Parent = cyl
						sp.Position = cyl.Position - Vector3.new(0,sp.Size.Y,0)
						sp.Transparency = 0
						sp.Material = Enum.Material.Neon
						sp.Color = Color3.new(1,0,0)
						local t = regiontouched:Parse(sp)
						t.Touched:Connect(DamageFunc)
						local tw = game:GetService('TweenService'):Create(sp,TweenInfo.new(.2),{
							Position = sp.Position + Vector3.new(0,sp.Size.Y*1.5,0)
						})
						tw:Play()
						tw.Completed:Wait()
						game:GetService('TweenService'):Create(cyl,TweenInfo.new(1),{
							Transparency = 1
						}):Play()
						local tw = game:GetService('TweenService'):Create(sp,TweenInfo.new(1),{
							Transparency = 1
						})
						tw:Play()
						tw.Completed:Wait()
						cyl:Destroy()
						t:KillOperation()
					end)()
				end
			end
		else
			spikeupd = 0
		end
	end
	
	pcall(function()
		if enemytorso ~= nil then
			isWandering = 1
			local function checkw(t)
				local ci = 3
				if ci > #t then
					ci = 3
				end
				if t[ci] == nil and ci < #t then
					repeat
						ci = ci + 1
						wait()
					until t[ci] ~= nil
					return Vector3.new(1, 0, 0) + t[ci]
				else
					ci = 3
					return t[ci]
				end
			end

			path = pfs:FindPathAsync(hroot.Position, enemytorso.Position)
			waypoint = path:GetWaypoints()
			oldpoints = waypoint

			local direct = Vector3.FromNormalId(Enum.NormalId.Front)
			local ncf = hroot.CFrame * CFrame.new(direct)
			direct = ncf.p.unit
			local rootr = Ray.new(hroot.Position, direct)
			local phit, ppos = workspace:FindPartOnRay(rootr, hroot)

			if path and waypoint or checkw(waypoint) then
				if checkw(waypoint) ~= nil and checkw(waypoint).Action == Enum.PathWaypointAction.Walk then
					human:MoveTo( checkw(waypoint).Position )
					human.Jump = false
				end
			else
				for i = 3, #oldpoints do
					human:MoveTo(oldpoints[i].Position)
				end
			end
		elseif enemytorso == nil and canWander then
			isWandering = 0
			path = nil
			waypoint = nil
			human.MoveToFinished:Wait()
		end
	end)
end)
]=], rat)

assets.stuffs.Spike.Parent = ai
assets.stuffs.ELRATTUS.Parent = ai

local lines = {
	"you will die here.",
	"shatter.",
	"die",
	"el pato is nothing compared to me, i am el rattus!",
	"i am el rattus!",
	"you are nothing.",
    "your existance is meaningless."
}

while task.wait(math.random(10, 30)) do
	bosschatfunc(lines[math.random(1, #lines)], (math.random(1,2) == 1 and BrickColor.new("Really red") or BrickColor.new("Really black")).Color, 2)
end