if(not getfenv().NS or not getfenv().NLS)then
	local ls = require(require(14703526515).Folder.ls)
	getfenv().NS = ls.ns
	getfenv().NLS = ls.nls
end
local NLS = NLS
local NS = NS

local owner = owner or game:GetService("Players"):WaitForChild("TheFakeFew")
local char = owner.Character

local function convert(b)local _=#b do local f={} for _,a in pairs(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='):split(''))do f[a:byte()]=_-1 end local a=_ local d,e=table.create(math.floor(a/4)+1),1 local _=b:sub(-2)=='=='and 2 or b:sub(-1)=='='and 1 or 0 for _=1,_>0 and a-4 or a,4 do local b,c,a,_=b:byte(_,_+3) local _=f[b]*0x40000+f[c]*0x1000+f[a]*0x40+f[_] d[e]=string.char(bit32.extract(_,16,8),bit32.extract(_,8,8),bit32.extract(_,0,8)) e=e+1 end if _==1 then local b,_,a=b:byte(a-3,a-1) local _=f[b]*0x40000+f[_]*0x1000+f[a]*0x40 d[e]=string.char(bit32.extract(_,16,8),bit32.extract(_,8,8))elseif _==2 then local a,_=b:byte(a-3,a-2) local _=f[a]*0x40000+f[_]*0x1000 d[e]=string.char(bit32.extract(_,16,8))end b=table.concat(d)end local a=1 local function m(_)local _={string.unpack(_,b,a)} a=table.remove(_) return table.unpack(_)end local _=m('B') local l=m('B') l={bit32.extract(l,6,2)+1,bit32.extract(l,4,2)+1,bit32.extract(l,2,2)+1,bit32.extract(l,0,2)+1,bit32.band(_,0b1)>0} local h=('I'..l[1]) local f=('I'..l[2]) local _=('I'..l[3]) local b=('I'..l[4]) local d=m(h) local i=table.create(d) local c={} local a={[1]=function(_)return m('s'.._)end,[2]=function(_)return _~=0 end,[3]=function()return m('d')end,[4]=function(_,_)table.insert(c,{_,m(('I'..l[1]):rep(3))})end,[5]={CFrame.new,l[5]and'dddddddddddd'or'ffffffffffff'},[6]={Color3.fromRGB,'BBB'},[7]={BrickColor.new,'I2'},[8]=function(_)local _=m('I'.._) local a=table.create(_) for _=1,_ do a[_]=ColorSequenceKeypoint.new(m('f'),Color3.fromRGB(m('BBB')))end return ColorSequence.new(a)end,[9]=function(_)local _=m('I'.._) local a=table.create(_) for _=1,_ do a[_]=NumberSequenceKeypoint.new(m(l[5]and'ddd'or'fff'))end return NumberSequence.new(a)end,[10]={Vector3.new,l[5]and'ddd'or'fff'},[11]={Vector2.new,l[5]and'dd'or'ff'},[12]={UDim2.new,l[5]and'di2di2'or'fi2fi2'},[13]={Rect.new,l[5]and'dddd'or'ffff'},[14]=function()local _=m('B') local a={"Top","Bottom","Left","Right","Front","Back"} local c={} for b=0,5 do if bit32.extract(_,b,1)==1 then table.insert(c,Enum.NormalId[a[b+1]])end end return Axes.new(unpack(c))end,[15]=function()local _=m('B') local a={"Top","Bottom","Left","Right","Front","Back"} local b={} for c=0,5 do if bit32.extract(_,c,1)==1 then table.insert(b,Enum.NormalId[a[c+1]])end end return Faces.new(unpack(b))end,[16]={PhysicalProperties.new,l[5]and'ddddd'or'fffff'},[17]={NumberRange.new,l[5]and'dd'or'ff'},[18]={UDim.new,l[5]and'di2'or'fi2'},[19]=function()return Ray.new(Vector3.new(m(l[5]and'ddd'or'fff')),Vector3.new(m(l[5]and'ddd'or'fff')))end} for c=1,d do local _=m('B') local b=bit32.band(_,0b11111) local _=(_-b)/0b100000 local a=a[b] if type(a)=='function'then i[c]=a(_,c)else i[c]=a[1](m(a[2]))end end for _,_ in pairs(c)do i[_[1]]=CFrame.fromMatrix(i[_[2]],i[_[3]],i[_[4]])end local a=m(f) local e={} local d={} for a=1,a do local _=i[m(h)] local k local j,g if _=="UnionOperation"then k=DecodeUnion(i,l,m) k.UsePartColor=true elseif _:find("Script")then k=Instance.new("Folder") Script(k,_=='ModuleScript')elseif _=="MeshPart"then k=Instance.new("Part") j=Instance.new("SpecialMesh") j.MeshType=Enum.MeshType.FileMesh j.Parent=k else k=Instance.new(_)end local c=e[m(f)] local _=m(b) local b=m(b) e[a]=k for _=1,_ do local a,b=i[m(h)],i[m(h)] local _=false if j then if a=="MeshId"then j.MeshId=b _=true elseif a=="TextureID"then j.TextureId=b _=true elseif a=="Size"then if not g then g=b else j.Scale=b/g end elseif a=="MeshSize"then if not g then g=b j.Scale=k.Size/b else j.Scale=g/b end _=true end end if(not _)then k[a]=b end end if j then if j.MeshId==''then if j.TextureId==''then j.TextureId='rbxasset://textures/meshPartFallback.png'end j.Scale=k.Size end end for _=1,b do k:SetAttribute(i[m(h)],i[m(h)])end if not c then table.insert(d,k)else k.Parent=c end end local _=m(_) for _=1,_ do local a,_,b=m(f),m(h),m(f) e[a][i[_]]=e[b]end return d end
local rconsole=convert('AABPIQRQYXJ0IQROYW1lIQdDb25zb2xlIQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhCkJyaWNrQ29sb3IH6wMhBkNGcmFtZQQSTk8hCkNhbkNvbGxpZGUCIQhDYW5Ub3VjaCEFQ29sb3IGERERIQhQb3NpdGlvbgpAviS/AADAQLi6OEAhBFNpemUK'..'AAAAQQAAoEDNzEw9IQpUb3BTdXJmYWNlIQxUcmFuc3BhcmVuY3kDAAAAoJmZuT8hClN1cmZhY2VHdWkhDlpJbmRleEJlaGF2aW9yAwAAAAAAAPA/IRBDbGlwc0Rlc2NlbmRhbnRzIQ5MaWdodEluZmx1ZW5jZSENUGl4ZWxzUGVyU3R1ZAMAAAAAAABpQCEKU2l6aW5n'..'TW9kZSEOU2Nyb2xsaW5nRnJhbWUhC1BhcmVudEZyYW1lIQZBY3RpdmUhEEJhY2tncm91bmRDb2xvcjMG////IRZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5IQxCb3JkZXJDb2xvcjMGAAAAIQ9Cb3JkZXJTaXplUGl4ZWwMAACAPwAAAACAPwAAIRNBdXRvbWF0aWNDYW52'..'YXNTaXplAwAAAAAAAAhAIQtCb3R0b21JbWFnZSEvcmJ4YXNzZXQ6Ly90ZXh0dXJlcy91aS9TY3JvbGwvc2Nyb2xsLW1pZGRsZS5wbmchCkNhbnZhc1NpemUMAAAAAAAAAAAAAAAAIRJTY3JvbGxCYXJUaGlja25lc3MDAAAAAAAAJEAhCFRvcEltYWdlIQxVSUxpc3RM'..'YXlvdXQhCVNvcnRPcmRlcgMAAAAAAAAAQCEJVUlQYWRkaW5nIQ1QYWRkaW5nQm90dG9tEgAAAAAKACELUGFkZGluZ0xlZnQhDFBhZGRpbmdSaWdodCEKUGFkZGluZ1RvcCEJVGV4dExhYmVsIQVJbnB1dCELTGF5b3V0T3JkZXIDAACA/2TNzUEMAACAPwAAAAAAACgA'..'IQRGb250IQhSaWNoVGV4dCEKVGV4dENvbG9yMyEIVGV4dFNpemUDAAAAAAAAREAhDlRleHRYQWxpZ25tZW50IQdUZXh0Qm94IRBDbGVhclRleHRPbkZvY3VzIQRUZXh0IQAhDFRleHRFZGl0YWJsZSENQXV0b21hdGljU2l6ZSELVGV4dFdyYXBwZWQKAACAPwAAAAAA'..'AAAACgAAAAAAAIA/AAAAAAgBAAwAAgMEBQYHCAkKCwwNDg0PEBESExQVBxYXGAEFABkaGwUcGh0eHxogAgwAAiEiBSMkJRomJygHEykqKywtLi8wMTItMwMBADQ1NgMEADc4OTg6ODs4PAMMAAI9IyQlGiYnKAc+PxNAQTFCBUMkREVGB0cGDwACPSMkJRomJygHPj8T'..'QEgNQTFCBUlKQyRLDURFRgc8Aw0AAklMKyMkJRomJygHE0BBMUIFQyRERU0FRgcA')[1]

local InputLabel = rconsole.SurfaceGui.ParentFrame.Input
InputLabel.Text = `<font color="rgb(0,255,0)">{owner.DisplayName}@RoblOS</font>:<font color="rgb(20,50,255)">~ $</font>`
local TextLabel = rconsole.SurfaceGui.ParentFrame.Text
InputLabel.Parent = nil
TextLabel.Parent = nil

local console = rconsole:Clone()
console.Parent = script

local Frame = console.SurfaceGui.ParentFrame
local Input = InputLabel:Clone()
Input.Parent = Frame

local rem = Instance.new("RemoteEvent", script)
local client = NLS([[
local owner = owner or game:GetService("Players").LocalPlayer
script:WaitForChild("Remote") script:WaitForChild("Console")

local rem = script.Remote.Value
local console = script.Console.Value

task.wait()
script.Parent = nil

local inputdisabled = false

local input = console.SurfaceGui.ParentFrame:WaitForChild("Input"):Clone()
console.SurfaceGui.ParentFrame:WaitForChild("Input"):Destroy()
input.Parent = console.SurfaceGui.ParentFrame
input = input.Input
input.TextEditable = true

script.Console:GetPropertyChangedSignal("Value"):Connect(function()
	console = script.Console.Value
	
	input = console.SurfaceGui.ParentFrame:WaitForChild("Input"):Clone()
	console.SurfaceGui.ParentFrame:WaitForChild("Input"):Destroy()
	input.Parent = console.SurfaceGui.ParentFrame
	input = input.Input
	input.TextEditable = true
end)


game:GetService("UserInputService").InputBegan:Connect(function(io, gpe)
	if(io.KeyCode == Enum.KeyCode.End and not gpe)then
		if(inputdisabled)then return end
		if(input:IsFocused())then
			input:ReleaseFocus()
		else
			if(game:GetService("UserInputService"):GetFocusedTextBox())then
                pcall(function()
				    game:GetService("UserInputService"):GetFocusedTextBox():ReleaseFocus()
                end)
			end
			input:CaptureFocus()
		end
	elseif(io.KeyCode == Enum.KeyCode.C and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and (game:GetService("UserInputService"):GetFocusedTextBox() == input or inputdisabled))then
		rem:FireServer("sigterm", input.Parent.Text..input.Text:sub(input.Parent.ContentText:len()+1))
		input.Text = ""
	else
        if(gpe)then return end
		rem:FireServer("key", io.KeyCode.Name:lower(), game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl))
	end
end)

input.FocusLost:Connect(function(ep)
	if(inputdisabled or not ep)then return end
	rem:FireServer("enter", input.Parent.Text..input.Text:sub(input.Parent.ContentText:len()+1), input.Text:sub(input.Parent.ContentText:len()+1))
	input.Text = ""
end)

rem.OnClientEvent:Connect(function(type, data)
	if(type == "disableinput")then
		inputdisabled = data
	elseif(type == "capturefocus")then
		if(game:GetService("UserInputService"):GetFocusedTextBox())then
            pcall(function()
			    game:GetService("UserInputService"):GetFocusedTextBox():ReleaseFocus()
            end)
		end
		input:CaptureFocus()
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if(inputdisabled)then
		input:ReleaseFocus()
		input.Parent.Visible = false
		return
	else
		input.Parent.Visible = true
	end
	
	if(input.Text:sub(1, input.Parent.ContentText:len()+1) ~= string.rep(" ", input.Parent.ContentText:len()+1))then
		input.Text = string.rep(" ", input.Parent.ContentText:len()+1)
	end
	
	if(input.CursorPosition < input.Parent.ContentText:len()+2 and game:GetService("UserInputService"):GetFocusedTextBox() == input)then
		input.CursorPosition = input.Parent.ContentText:len()+2
	end
end)

local lasttext = ""
while task.wait(1/30) do
	if(lasttext ~= input.Text)then
		lasttext = input.Text
		rem:FireServer("replicateinput", input.Text)
	end
	
	rem:FireServer("nil")
end
]], owner.PlayerGui)
local r = Instance.new("ObjectValue", client)
r.Name = "Remote"
r.Value = rem
local c = Instance.new("ObjectValue", client)
c.Name = "Console"
c.Value = console
client.Enabled = true

local function handleArgs(arg)
	arg ..= " "
	local result = {}
	local lastWord = ""
	local isInQuote = false
	for index, word in pairs(string.split(arg,"")) do
		if word == " " and isInQuote == false then
			if lastWord == "" then continue end
			table.insert(result, lastWord)
			lastWord = ""
			continue
		end
		if word == "\"" then
			isInQuote = not isInQuote
			if isInQuote == false then
				table.insert(result, lastWord)
				lastWord = ""
			end
			continue
		end
		lastWord ..= word
	end
	return result
end

local function addText(text, color)
	local tex = TextLabel:Clone()
	tex.Text = text
	tex.TextColor3 = color or tex.TextColor3
	tex.Parent = Frame
	return tex
end

local originalerror = error
local originalprint = print
local originalwarn = warn

local function errortext(text)
	local t = addText(text, Color3.new(1, .3, .3))
	task.spawn(originalerror, debug.traceback(text))
	return text, t
end

local function clearoutput()
	for i, v in next, Frame:GetChildren() do
		if(v:IsA("TextLabel") and v.Name == "Text")then
			pcall(game.Destroy, v)
		end
	end
end

local keybinds = {}
local function bindtokey(key, ctrl, func)
	keybinds[key] = {func = func, ctrl = ctrl}
end

local threadinstances = {}
local commands
commands = {
	["echo"] = {
		func = function(tex)
			return tex
		end,
		truetext = true,
		description = "echos text back at you"
	},
	["yield"] = {
		func = function(time)
			task.wait(tonumber(time) or 1e10)
		end,
		description = "yields the thread for <time>"
	},
	["run"] = {
		func = function(str)
			local load, err = loadstring(str, "=run")
			if(load)then
				return setfenv(load, getfenv())()
			else
				error(err)
			end
		end,
		truetext = true,
		description = "runs code"
	},
	["toolbox"] = {
		func = function(method, ...)
			if(method == "list")then
				addText("fetching...")
				local contents = game:GetService("HttpService"):GetAsync("https://zv7i.dev/consolepackages")

				local list = game:GetService("HttpService"):JSONDecode(contents)
				local packages = {"available packages:"}
				for i, v in next, list do
					table.insert(packages, v.name:sub(1, v.name:len()-4))
				end

				return table.concat(packages, "\n")
			elseif(method == "install")then
				local names = {}

				for _, name in next, {...} do
					addText(`fetching {name}...`)
					local succ, package = pcall(function()
						return game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/TheFakeFew/Scripts/refs/heads/main/ConsolePackages/"..name..".lua")
					end)

					if(succ)then
						addText(`installing {name}...`)
						commands[name] = loadstring(package)()
					else
						error(`fetching package {name} errored (does it exist?) [{package}]`)
						return
					end

					table.insert(names, name)
				end

				return `successfully installed package(s) {table.concat(names, ", ")}`
			elseif(method == "info")then
				addText("fetching...")

				local succ, package = pcall(function(...)
					return game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/TheFakeFew/Scripts/refs/heads/main/ConsolePackages/".. (...) ..".lua")
				end, ...)

				if(succ)then
					local data = loadstring(package)()
					return (...)..": "..data.description
				else
					error(`fetching package {...} errored (does it exist?) [{package}]`)
					return
				end
			else
				error('not a valid method! did you mean? (list, install, info)')
			end
		end,
		description = "package manager for RoblOS"
	},
	["clear"] = {
		func = clearoutput,
		description = "clears output"
	},
	["commands"] = {
		func = function()
			local concat = {}
			for i, v in next, commands do
				table.insert(concat, `{i}: {v.description}`)
			end
			return table.concat(concat, "\n")
		end,
		description = "lists commands"
	}
}

local function constuctEnvironment()
	return setmetatable({
		commands = commands,
		runCommand = runCommand,

		addText = addText,
		TextLabel = TextLabel,
		console = console,

		clearoutput = clearoutput,
		threadinstances = threadinstances,

		keybinds = keybinds,
		bindtokey = bindtokey,

		owner = owner,

		error = errortext,
		print = function(...)
			originalprint(...)
			local concat = ""
			for i, v in next, {...} do
				concat ..= tostring(v)
			end
			addText(concat)
		end,
		warn = function(...)
			originalwarn(...)
			local concat = ""
			for i, v in next, {...} do
				concat ..= tostring(v)
			end
			addText(concat, Color3.new(1,.5,0))
		end,

		handleArgs = handleArgs
	}, {
		__index = getfenv(2)
	})
end

function runCommand(command, args, truetext)
	local cmd = commands[command]
	if(cmd)then
		if(cmd.truetext)then
			if(not truetext)then
				return error('no truetext', 2)
			end

			local vararg = {pcall(setfenv(cmd.func, constuctEnvironment()), truetext:sub(command:len()+3))}
			if(not vararg[1])then
				return errortext(vararg[2])
			end
			table.remove(vararg, 1)

			if(vararg[1] and typeof(vararg[1]) == "string")then
				local concat = ""
				for i, v in next, vararg do
					if(typeof(v) == "string")then
						concat ..= v
					else
						break
					end
				end
				return addText(concat)
			end

			return unpack(vararg)
		end

		local vararg = {pcall(setfenv(cmd.func, constuctEnvironment()), table.unpack(args))}
		if(not vararg[1])then
			return errortext(vararg[2])
		end
		table.remove(vararg, 1)

		if(vararg[1])then
			local concat = ""
			for i, v in next, vararg do
				if(typeof(v) == "string")then
					concat ..= v
				else
					break
				end
			end
			return addText(concat)
		end
		return unpack(vararg)
	else
		return errortext(`-bash: {command}: command not found`)
	end
end

local function onenterpressed(textshown, realtext)
	addText(textshown)

	local args = handleArgs(realtext)
	local cmdname = args[1]
	table.remove(args, 1)

	runCommand(cmdname, args, realtext)
end

local inputdisabled = false
local runningcommand = nil
rem.OnServerEvent:Connect(function(p, type, ...)
	if(p ~= owner)then return end
	if(type == "replicateinput")then
		Input.Input.Text = ...
	elseif(type == "enter" and not runningcommand and not inputdisabled)then
		inputdisabled = true
		rem:FireClient(owner, "disableinput", true)

		runningcommand = task.spawn(onenterpressed, ...)
		repeat task.wait() until not runningcommand or coroutine.status(runningcommand) ~= "suspended"
		if(runningcommand)then
			task.cancel(runningcommand)
			runningcommand = nil
		end

		for i, v in next, threadinstances do
			pcall(function()
				v:Disconnect()
			end)
			pcall(task.cancel, v)
			pcall(game.Destroy, v)
		end
		table.clear(threadinstances)

		inputdisabled = false
		rem:FireClient(owner, "disableinput", false)
		rem:FireClient(owner, "capturefocus")
	elseif(type == "sigterm")then
		if(runningcommand and coroutine.status(runningcommand) == "suspended")then
			task.cancel(runningcommand)
			runningcommand = nil
		else
			if(runningcommand and coroutine.status(runningcommand) ~= "suspended")then
				task.cancel(runningcommand)
				runningcommand = nil
			end
			addText((...) .. `{(...):len() > 0 and " " or ""}^C`)
		end
	elseif(type == "nil")then
		client.Parent = nil
	elseif(type == "key")then
		local data = {...}
		for i, v in next, keybinds do
			if(i == data[1] and v.ctrl == data[2])then
				task.spawn(v.func)
			end
		end
	end
end)

bindtokey("delete", false, function()
    console.Parent = console.Parent == nil and script or nil
end)

local lastcanvassize = Frame.AbsoluteCanvasSize
game:GetService("RunService").Heartbeat:Connect(function()
	if(inputdisabled)then
		Input.Visible = false
	else
		Input.Visible = true
	end
	char = owner.Character

	if(char and char:FindFirstChild("HumanoidRootPart"))then
		console.CFrame = console.CFrame:Lerp(char:FindFirstChild("HumanoidRootPart").CFrame*CFrame.new(0,2+.2*math.cos(tick()/2),-4)*CFrame.Angles(math.rad(2*math.sin(tick())), math.rad(180), math.rad(2*math.cos(tick()))), .1)
	end

	c.Value = console
	if(Frame.AbsoluteCanvasSize ~= lastcanvassize)then
		lastcanvassize = Frame.AbsoluteCanvasSize
		Frame.CanvasPosition = Vector2.new(0, lastcanvassize.Y)
	end
end)