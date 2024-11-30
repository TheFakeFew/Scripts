local mouse, Mouse, Client, MouseEventConnections, Camera = nil, nil, nil, nil, nil
    local Player = owner
    if(not Player)then
        return
    end
        MouseEventConnections = {}
        Client = NLS([[
            local Player = game:GetService('Players').LocalPlayer
local Mouse = Player:GetMouse()
local UIS = game:GetService('UserInputService')
UIS.InputBegan:Connect(function(io, gpe)
    if(not gpe)then
        if(string.lower(io.KeyCode.Name) == "unknown")and(io.UserInputType ~= Enum.UserInputType.MouseButton1)then return end
        script.Remote.Value:FireServer("KeyEvent", {
            Key = ((io.UserInputType == Enum.UserInputType.MouseButton1)and("mouse1")or(string.lower(io.KeyCode.Name))),
            Hit = Mouse.Hit,
            Target = Mouse.Target,
            Up = false
        })
    end
end)
UIS.InputEnded:Connect(function(io, gpe)
    if(not gpe)then
        if(string.lower(io.KeyCode.Name) == "unknown")and(io.UserInputType ~= Enum.UserInputType.MouseButton1)then return end
        script.Remote.Value:FireServer("KeyEvent", {
            Key = ((io.UserInputType == Enum.UserInputType.MouseButton1)and("mouse1")or(string.lower(io.KeyCode.Name))),
            Hit = Mouse.Hit,
            Target = Mouse.Target,
            Up = true
        })
    end
end)
game:GetService('RunService').RenderStepped:Connect(function()
    script.Remote.Value:FireServer("MouseUpdate", {
        Hit = Mouse.Hit,
        Target = Mouse.Target,
		CamCFrame = workspace.CurrentCamera.CFrame
    })
end)
            ]], Player:FindFirstChildOfClass("PlayerGui"))
        local r = Instance.new("ObjectValue", Client)
        r.Name = "Remote"
        local Event = Instance.new("RemoteEvent", Player.Character)
        Event.Name = "_MouseEvent"
        Client.Remote.Value = Event
        Client.Disabled = false
        local fakemouse = {}
        fakemouse.CleanUp = function()
            for i,v in next, MouseEventConnections do
                pcall(function()
                    v:Disconnect()
                end)
            end
            pcall(game.Destroy, Event)
            pcall(function()
                Client.Disabled = true
                Client:Destroy()
            end)
        end
        fakemouse.KeyDown = {}
        fakemouse.KeyUp = {}
        fakemouse.Button1Down = {}
        fakemouse.Button1Up = {}
		local lastcamcf = CFrame.identity
        local function setfakemouseenv(data)
            fakemouse.Hit = data.Hit or CFrame.identity
            fakemouse.Target = data.Target or nil
			if(data.CamCFrame)then
				lastcamcf = data.CamCFrame
			end
			Camera = {CFrame = lastcamcf or CFrame.identity, FieldOfView = 70}
        end
        setfakemouseenv({})
        function fakemouse.KeyDown:Connect(func)
            local returned = {}
            local ev = Event.OnServerEvent:Connect(function(Plr, type, data)
                if(Plr ~= Player)then return end
                if(type == "KeyEvent")and(data.Key ~= "mouse1")then
                    if(not data.Up)then
                        setfakemouseenv(data)
                        func(data.Key)
                    end
                end
            end)
            table.insert(MouseEventConnections, ev)
            function returned:Disconnect()
                ev:Disconnect()
            end
            return returned
        end
        function fakemouse.KeyUp:Connect(func)
            local returned = {}
            local ev = Event.OnServerEvent:Connect(function(Plr, type, data)
                if(Plr ~= Player)then return end
                if(type == "KeyEvent")and(data.Key ~= "mouse1")then
                    if(data.Up)then
                        setfakemouseenv(data)
                        func(data.Key)
                    end
                end
            end)
            table.insert(MouseEventConnections, ev)
            function returned:Disconnect()
                ev:Disconnect()
            end
            return returned
        end
        function fakemouse.Button1Down:Connect(func)
            local returned = {}
            local ev = Event.OnServerEvent:Connect(function(Plr, type, data)
                if(Plr ~= Player)then return end
                if(type == "KeyEvent")then
                    if(not data.Up)and(data.Key == "mouse1")then
                        setfakemouseenv(data)
                        func()
                    end
                end
            end)
            table.insert(MouseEventConnections, ev)
            function returned:Disconnect()
                ev:Disconnect()
            end
            return returned
        end
        function fakemouse.Button1Up:Connect(func)
            local returned = {}
            local ev = Event.OnServerEvent:Connect(function(Plr, type, data)
                if(Plr ~= Player)then return end
                if(type == "KeyEvent")then
                    if(data.Up)and(data.Key == "mouse1")then
                        setfakemouseenv(data)
                        func()
                    end
                end
            end)
            table.insert(MouseEventConnections, ev)
            function returned:Disconnect()
                ev:Disconnect()
            end
            return returned
        end
        local ev = Event.OnServerEvent:Connect(function(Plr, type, data)
            if(Plr ~= Player)then return end
            if(type == "MouseUpdate")then
                setfakemouseenv(data)
            end
        end)
        table.insert(MouseEventConnections, ev)
    mouse, Mouse = fakemouse, fakemouse


local Player = owner
local char = Player.Character

local characters = {}
local function ischaracter(model)
	if(not model)then return end
	if(model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") and model:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator") and model:FindFirstChild("HumanoidRootPart"))then
		return true
	end
	return false
end

for i, v in next, workspace:GetChildren() do
	if(ischaracter(v) and v ~= char)then
		table.insert(characters, v)
	end
end

workspace.ChildAdded:Connect(function(v)
	if(ischaracter(v))then
		table.insert(characters, v)
	end
end)

workspace.ChildRemoved:Connect(function(v)
	if(table.find(characters, v))then
		table.remove(characters, table.find(characters, v))
	end
end)

function soundeff(par, id, vol, pit)
	local a = Instance.new("Sound", par)
	a.SoundId = "rbxassetid://"..id
	a.Volume = vol
	a.Pitch = pit
	a.PlayOnRemove = true
	a:Destroy()
end

local infinity = false
mouse.KeyDown:Connect(function(k)
	if(k == "f")then
		infinity = not infinity
		if(infinity)then
			soundeff(char.HumanoidRootPart, 1843027392, 1, .9)
		else
			for i, v in next, characters do
				local distance = (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude*3
				if(distance < 54)then
					v.InRange.Value = false
					v:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
					v.AnimSpeed.Value = 1
				end
			end
		end
	end
end)

game:GetService("RunService").Stepped:Connect(function()
	for i, v in next, characters do
		if(not v:IsDescendantOf(workspace) or not v:FindFirstChildOfClass("Humanoid") or not v:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator") or not v:FindFirstChild("HumanoidRootPart"))then
			characters[i] = nil
			continue
		end
		if(not v:FindFirstChild("AnimSpeed"))then
			Instance.new("NumberValue", v).Name = "AnimSpeed"
		end
		if(not v:FindFirstChild("InRange"))then
			Instance.new("BoolValue", v).Name = "InRange"
		end
	end
	if(infinity)then
		for i, v in next, characters do
			local distance = (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude*2
			if(distance < 54)then
				v.InRange.Value = true
				local speed = math.clamp(distance - 16, 0, 16)
				v:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
				v.AnimSpeed.Value = math.clamp(speed/16, .1, 1)
			else
				v.InRange.Value = false
				v.AnimSpeed.Value = 1
			end
		end
		
		for i, v in next, workspace:GetPartBoundsInBox(char.HumanoidRootPart.CFrame, Vector3.one*50) do
			if(not v.Anchored and not ischaracter(v:FindFirstAncestorOfClass("Model")))then
				local distance = (v.Position - char.HumanoidRootPart.Position).Magnitude
				local factor = math.clamp(distance/30, 0, 1)
				
				if(distance < 6)then
					factor = -2
				end
				
				v.AssemblyLinearVelocity *= factor
				v.AssemblyAngularVelocity *= math.clamp(factor, 0, 1)
                v:SetNetworkOwner(nil)
			end
		end
	end

	for i, v in next, characters do
		if(v.InRange.Value)then
			for _, anim in next, v:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks() do
				anim:AdjustSpeed(anim.Speed*v.AnimSpeed.Value)
			end
		end
	end
end)