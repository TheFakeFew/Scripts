local toggled = false
local fullrgb = false

getfenv().wait = task.wait

function reconnect()
	coroutine.wrap(function()
		do
			local function IsATail(obj)
				if obj and obj:IsA("Accessory") and obj.Name:lower():match("tail") and obj:FindFirstChild("Handle") ~= nil then
					return true
				else
					return false
				end
			end
			local function ConnectTail(v)
				if(toggled)then
					return
				end
				if IsATail(v) and v:IsDescendantOf(owner.Character) then
					wait()
					pcall(function()
						local handle = v['Handle']
						local attach = handle:FindFirstChildOfClass("Attachment")
						local normal = attach.CFrame
						local ts, ti = game:GetService("TweenService"), TweenInfo.new(.4, Enum.EasingStyle.Back)
						local s = 0
						coroutine.wrap(function()
							while wait() do
								s += 1
								local sin = math.sin(s/16)/(1.1 + .1)
								pcall(function()
									ts:Create(attach, ti, {
										CFrame = normal * CFrame.new(sin/6,0,0) * CFrame.Angles(sin/7.3,sin/5.3,sin/5)
									}):Play()
								end)
							end
						end)()
					end)
				end
			end
			pcall(function()
				for i,v in next, owner.Character:GetDescendants() do
					ConnectTail(v)
				end
			end)
			owner.CharacterAdded:Connect(function(c)
				wait(0.3)
				pcall(function()
					for i,v in next, c:GetDescendants() do
						ConnectTail(v)
					end
				end)
			end)
		end
		do
			local function chatfunc(msg)
				if(toggled)then
					return
				end
				coroutine.wrap(function()
					local amountsofchats = 0
					for i,v in pairs(workspace:GetChildren()) do
						if v.Name == "DestroyerChatLabelIUFH"..owner.Name then
							amountsofchats += 1
						end
					end
					if amountsofchats >= 5 then
						workspace:FindFirstChild("DestroyerChatLabelIUFH"..owner.Name):Destroy()
						return
					end
					for i,v in pairs(workspace:GetChildren()) do
						if v.Name == "DestroyerChatLabelIUFH"..owner.Name then
							v.StudsOffset += Vector3.new(0,2,0)
						end
					end
					local bil = Instance.new('BillboardGui')
					bil.Name = "DestroyerChatLabelIUFH"..owner.Name
					bil.Parent = workspace
					pcall(function()
						bil.Adornee = owner.Character.Head
					end)
					bil.LightInfluence = 0
					bil.Size = UDim2.new(1000,0,1,0)
					bil.StudsOffset = Vector3.new(-0.7,3,0)
					local numoftext = 0
					local letters = #msg:sub(1)
					local children = 0
					local texts = {}
					local textdebris = {}
					for i = 1,#msg:sub(1) do
						children += .05
						local a,txt=pcall(Instance.new,"TextBox",nil)
						coroutine.wrap(function()
							txt.Parent=bil
							txt.Size=UDim2.new(0.001,0,1,0)
							txt.TextScaled=true
							txt.TextWrapped=true
							txt.Font=Enum.Font.GrenzeGotisch
							txt.BackgroundTransparency=1
							txt.TextColor3=Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1)
							txt.TextStrokeTransparency=0
							txt.TextStrokeColor3=Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,.5,.5)
							txt.Position=UDim2.new(0.5-(letters*(0.001/2)),0,0.5,0)
							txt.Text=msg:sub(i,i)
							txt.ZIndex = 2
							bil.StudsOffset-=Vector3.new(0.25,0,0)
							letters-=1
							table.insert(texts,txt)
							numoftext+=1
							coroutine.wrap(function()
								pcall(function()
									wait(5.5+children)
									local tw = game:GetService('TweenService'):Create(txt,TweenInfo.new(.5),{
										TextTransparency = 1,
										TextStrokeTransparency = 1
									})
									tw:Play()
									tw.Completed:wait()
									txt:Destroy()
									children -= .1
								end)
							end)()
						end)()
						wait()
					end
					game:GetService("Debris"):AddItem(bil,6+children)
					coroutine.wrap(function()
						repeat
							pcall(function()
								wait()
								if #bil:GetChildren() <= 0 then
									bil:Destroy()
								end
								bil.Adornee = owner.Character.Head
								bil.Parent = workspace
								for i,v in next, texts do
									v.TextColor3=Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1)
									v.TextStrokeColor3=Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,.5,.5)
								end
								for i,v in next, textdebris do
									v.TextColor3=Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1)
									v.TextStrokeColor3=Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,.5,.5)
								end
							end)
						until not bil:IsDescendantOf(workspace)
					end)()
					coroutine.wrap(function()
						repeat
							pcall(function()
								wait()
								for i,v in next, texts do
									if(i ~= #texts)then
										coroutine.wrap(function()
											local tw = game:GetService('TweenService'):Create(v,TweenInfo.new(.5),{
												Position = UDim2.new(0.5-(-i*(0.001/2)), 0+math.random(-2,2), 0.5, 0+math.random(-2,2)),
												Rotation = math.random(-10,10)
											})
											tw:Play()
										end)()
									else
										local tw = game:GetService('TweenService'):Create(v,TweenInfo.new(.5),{
											Position = UDim2.new(0.5-(-i*(0.001/2)), 0+math.random(-2,2), 0.5, 0+math.random(-2,2)),
											Rotation = math.random(-10,10)
										})
										tw:Play()
										tw.Completed:Wait()
									end
								end
							end)
						until not bil:IsDescendantOf(workspace)
					end)()
					coroutine.wrap(function()
						repeat
							pcall(function()
								wait()
								for i,v in next, texts do
									if math.random(1,10) == 1 then
										local tx = v:Clone()
										tx.Parent = bil
										tx.TextColor3 = Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1)
										tx.TextStrokeColor3 = Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,.5,.5)
										tx.ZIndex = 1
										table.insert(textdebris,tx)
										local tw = game:GetService('TweenService'):Create(tx,TweenInfo.new(1),{
											Position = UDim2.new(0.5-(-i*(0.001/2)), 0+math.random(-30,30), 0.5, 0+math.random(-30,30)),
											TextTransparency = 1,
											TextStrokeTransparency = 1,
											Size = UDim2.new(0,0,0),
											TextColor3 = Color3.new(0,0,0)
										})
										tw:Play()
									end
								end
								wait(math.random())
							end)
						until not bil:IsDescendantOf(workspace)
					end)()
				end)()
			end

			owner.Chatted:Connect(chatfunc)
		end
		do
			local function apply()
				if(toggled)then
					return
				end
				pcall(function()
					if(owner.Character:FindFirstChildOfClass("Humanoid").RigType ~= Enum.HumanoidRigType.R15)then
						return
					end
					local hd = owner.Character:FindFirstChildOfClass("Humanoid"):GetAppliedDescription()
					hd.ClimbAnimation = 619509955
					hd.FallAnimation = 619511417
					hd.IdleAnimation = 619511648
					hd.RunAnimation = 619512153
					hd.SwimAnimation = 619512450
					hd.WalkAnimation = 619512767
					hd.JumpAnimation = 619511974
					owner.Character:FindFirstChildOfClass("Humanoid"):ApplyDescription(hd)
				end)
			end
			apply()
			owner.CharacterAdded:Connect(function() wait() apply() end)
		end
		do
			function applyhp(c)
				if(toggled)then
					return
				end
				pcall(function()
					c:FindFirstChildOfClass("Humanoid").HealthChanged:Connect(function()
						c:FindFirstChildOfClass("Humanoid").Health = c:FindFirstChildOfClass("Humanoid").MaxHealth
					end)
				end)
			end
			applyhp(owner.Character)
			owner.CharacterAdded:Connect(applyhp)
		end
		do
			local h = nil
			local ch = nil
			local function add(c)
				if(toggled)then
					return
				end
				pcall(function()
					h:Destroy()
				end)
				ch = c
				h = Instance.new("Highlight",c)
				h.OutlineColor = Color3.new(1,1,1)
				h.FillTransparency = 1
				h.DepthMode = "Occluded"
				h.Adornee = c
			end
			add(owner.Character)
			owner.CharacterAdded:Connect(add)
			game:GetService("RunService").Heartbeat:Connect(function()
				pcall(function()
					h.Parent = ch
					h.Adornee = ch
					h.OutlineColor = Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1)
				end)
			end)
		end
		do
			owner.Chatted:Connect(function(msg)
				local message = msg
				if(message:sub(1,3)) == "/e "then
					message = msg:sub(4)
				end
				if(string.lower(message) == "!charpack")then
					toggled = not toggled
					print(tostring(toggled))
				end
				if(string.lower(message) == "!fullrgb")then
					fullrgb = not fullrgb
					print(tostring(fullrgb))
				end
			end)
		end
		do
			local neonsandstuff = {}
			local types = {
				["BasePart"] = function(v) return v.Material == Enum.Material.Neon end,
				["ParticleEmitter"] = function(v) return true end,
				["Trail"] = function(v) return true end,
				["Beam"] = function(v) return true end
			}
			local function check(v)
				for index,key in next, types do
					if(v:IsA(index))then
						if(key(v))then
							table.insert(neonsandstuff, v)
						end
					end
				end
			end
			function scanthrough()
				neonsandstuff = {}
				if(not owner.Character)then return end
				for i,v in next, owner.Character:GetDescendants() do
					check(v)
				end
				owner.Character.DescendantAdded:Connect(function(v)
					task.defer(check,v)
				end)
				owner.Character.DescendantRemoving:Connect(function(v)
					if(table.find(neonsandstuff,v))then
						table.remove(neonsandstuff, table.find(neonsandstuff,v))
					end
				end)
			end
			scanthrough()
			owner.CharacterAdded:Connect(scanthrough)
			game:GetService("RunService").Heartbeat:Connect(function()
				if(fullrgb)then
					if(owner.Character)then
						for i,v in next, neonsandstuff do
							pcall(function()
								v.Color = ColorSequence.new(Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1))
							end)
							pcall(function()
								v.Color = Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1)
							end)
						end
					end
				end
			end)
		end
		do
			local tailatt = nil
			local tailparticle = nil
			local ear1att = nil
			local ear2att = nil
			local ear1particle = nil
			local ear2particle = nil
			local pointl = nil
			local function addparticleearsandtail(c)
				if(toggled)then
					return
				end
				local chr = c
				local foundsomething = false
				for i,v in next, chr:GetChildren() do
					if(v.Name:lower():find("tail"))then
						foundsomething = true
					end
				end
				if(foundsomething)then
					return
				end
				local genv={}
				Decode =  function(str,t,props,classes,values,ICList,Model,CurPar,LastIns,split,RemoveAndSplit,InstanceList)
					local tonum,table_remove,inst,parnt,comma,table_foreach = tonumber,table.remove,Instance.new,"Parent",",",
					function(t,f)
						for a,b in pairs(t) do
							f(a,b)
						end
					end
					local Types = {
						Color3 = Color3.new,
						Vector3 = Vector3.new,
						Vector2 = Vector2.new,
						UDim = UDim.new,
						UDim2 = UDim2.new,
						CFrame = CFrame.new,
						Rect = Rect.new,
						NumberRange = NumberRange.new,
						BrickColor = BrickColor.new,
						PhysicalProperties = PhysicalProperties.new,
						NumberSequence = function(...)
							local a = {...}
							local t = {}
							repeat
								t[#t+1] = NumberSequenceKeypoint.new(table_remove(a,1),table_remove(a,1),table_remove(a,1))
							until #a==0
							return NumberSequence.new(t)
						end,
						ColorSequence = function(...)
							local a = {...}
							local t = {}
							repeat
								t[#t+1] = ColorSequenceKeypoint.new(table_remove(a,1),Color3.new(table_remove(a,1),table_remove(a,1),table_remove(a,1)))
							until #a==0
							return ColorSequence.new(t)
						end,
						number = tonumber,
						boolean = function(a)
							return a=="1"
						end
					}
					split = function(str,sep)
						if not str then return end
						local fields = {}
						local ConcatNext = false
						str:gsub(("([^%s]+)"):format(sep),function(c)
							if ConcatNext == true then
								fields[#fields] = fields[#fields]..sep..c
								ConcatNext = false
							else
								fields[#fields+1] = c
							end
							if c:sub(#c)=="\\" then
								c = fields[#fields]
								fields[#fields] = c:sub(1,#c-1)
								ConcatNext = true
							end
						end)
						return fields
					end
					RemoveAndSplit = function(t)
						return split(table_remove(t,1),comma)
					end
					t = split(str,";")
					props = RemoveAndSplit(t)
					classes = RemoveAndSplit(t)
					values = split(table_remove(t,1),'|')
					ICList = RemoveAndSplit(t)
					InstanceList = {}
					Model = inst"Model"
					CurPar = Model
					table_foreach(t,function(ct,c)
						if c=="n" or c=="p" then
							CurPar = c=="n" and LastIns or CurPar[parnt]
						else
							ct = split(c,"|")
							local class = classes[tonum(table_remove(ct,1))]
							if class=="UnionOperation" then
								LastIns = {UsePartColor="1"}
							else
								LastIns = inst(class)
								if LastIns:IsA"Script" then
									s(LastIns)
								elseif LastIns:IsA("ModuleScript") then
									ms(LastIns)
								end
							end

							local function SetProperty(LastIns,p,str,s)
								s = Types[typeof(LastIns[p])]
								if p=="CustomPhysicalProperties" then
									s = PhysicalProperties.new
								end
								if s then
									LastIns[p] = s(unpack(split(str,comma)))
								else
									LastIns[p] = str
								end
							end

							local UnionData
							table_foreach(ct,function(s,p,a,str)
								a = p:find":"
								p,str = props[tonum(p:sub(1,a-1))],values[tonum(p:sub(a+1))]
								if p=="UnionData" then
									UnionData = split(str," ")
									return
								end
								if class=="UnionOperation" then
									LastIns[p] = str
									return
								end
								SetProperty(LastIns,p,str)
							end)

							if UnionData then
								local LI_Data = LastIns
								LastIns = DecodeUnion(UnionData)
								table_foreach(LI_Data,function(p,str)
									SetProperty(LastIns,p,str)
								end)
							end
							table.insert(InstanceList,LastIns)
							LastIns[parnt] = CurPar
						end
					end)
					table_remove(ICList,1)
					table_foreach(ICList,function(a,b)
						b = split(b,">")
						InstanceList[tonum(b[1])][props[tonum(b[2])]] = InstanceList[tonum(b[3])]
					end)

					return Model:GetChildren()
				end

				local Objects = Decode('Name,Position,Size,BottomSurface,TopSurface,Orientation,Rotation,CFrame,Color,Transparency,Texture,LightInfluence,Speed,LightEmission,Acceleration,Lifetime,LockedToPart,Rate,RotSpeed;Part,Attachment,P'
					..'articleEmitter;Part|-16.05,0.5,18.9499|4,1,2|0|Ear2|-0.5,0.5,0|0,0,20|-0.5,0.5,0,0.9396,-0.3421,0,0.342,0.9396,-0,0,0,1|0,0,1,0.9333,1,0,1,0.9333|0,0,0,1,1,0|0,0.3749,0,1,0,0|rbxassetid://6793543531|1'
					..'|1,1|0,0,-1|1283718905856|-90,90|-360,360|Ear1|0.5,0.5,0|-0,-0,-20|0.5,0.5,0,0.9396,0.342,-0,-0.3421,0.9396,0,0,0,1|TailAttachment|0,-0.5,0|90,0,0|90,0,-0|0,-0.5,0,1,0,0,0,-0.0001,-1,0,1,-0.0001|0,0.5'
					..'624,0,1,0,0|0,0,-5;0;1|2:2|3:3|4:4|5:4;n;2|1:5|2:6|6:7|7:7|8:8;n;3|9:9|10:10|3:11|11:12|12:13|9:9|13:14|14:13|15:15|9:9|16:14|17:13|18:16|19:17|7:18;p;2|1:19|2:20|6:21|7:21|8:22;n;3|9:9|10:10|3:11|11:'
					..'12|12:13|9:9|13:14|14:13|15:15|9:9|16:14|17:13|18:16|19:17|7:18;p;2|1:23|2:24|6:25|7:26|8:27;n;3|9:9|10:10|3:28|11:12|12:13|9:9|14:13|15:29|9:9|16:14|17:13|18:16|19:17|7:18;p;p;')
				local part = Objects[1]
				tailatt = part.TailAttachment
				tailparticle = tailatt.ParticleEmitter
				ear1att = part.Ear1
				ear2att = part.Ear2
				ear1particle = ear1att.ParticleEmitter
				ear2particle = ear2att.ParticleEmitter
				pointl = Instance.new("PointLight",(chr:FindFirstChild("Torso") or chr:FindFirstChild("LowerTorso")))
				pointl.Brightness = 5
				pointl.Range = 10
				pointl.Shadows = false
				part.Ear1.Parent = chr.Head
				part.Ear2.Parent = chr.Head
				part.TailAttachment.Parent = (chr:FindFirstChild("Torso") or chr:FindFirstChild("LowerTorso"))
			end
			coroutine.wrap(function()
				wait(.6)
				addparticleearsandtail(owner.Character)
				owner.CharacterAdded:Connect(function(c)
					wait(.6)
					addparticleearsandtail(c)
				end)
			end)()
			local sin = 0
			game:GetService('RunService').Heartbeat:Connect(function()
				pcall(function()
					sin += 1
					if(tailatt.Parent.Name == "LowerTorso")then
						tailatt.CFrame = CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),0,0)
					end
					tailparticle.Acceleration = Vector3.new(0+5*math.sin(sin/30),0+1*math.cos(sin/30),-4+1*math.cos(sin/50))
					ear1particle.Acceleration = Vector3.new(0+.3*math.cos(sin/60),0,-1+.3*math.cos(sin/50))
					ear2particle.Acceleration = Vector3.new(0-.3*math.cos(sin/67),0,-1+.3*math.cos(sin/54))
					tailparticle.LightEmission = 0
					ear1particle.LightEmission = 0
					ear2particle.LightEmission = 0
					tailparticle.LightInfluence = 100
					ear1particle.LightInfluence = 100
					ear2particle.LightInfluence = 100
					tailparticle.Color = ColorSequence.new(Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1))
					ear1particle.Color = ColorSequence.new(Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1))
					ear2particle.Color = ColorSequence.new(Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1))
					pointl.Brightness = 5
					pointl.Range = 10
					pointl.Shadows = false
					pointl.Color = Color3.fromHSV(math.acos(math.cos((tick()/10)*math.pi))/math.pi,1,1)
					if(math.random(1,200)==1)then
						game:GetService('TweenService'):Create(ear1att,TweenInfo.new(.1),{
							CFrame = CFrame.new(0.5,0.5,0)*CFrame.Angles(0,math.rad(10),math.rad(-40))
						}):Play()
					else
						game:GetService('TweenService'):Create(ear1att,TweenInfo.new(.1),{
							CFrame = CFrame.new(0.5,0.5,0)*CFrame.Angles(0,0,math.rad(-20))
						}):Play()
					end
					if(math.random(1,200)==1)then
						game:GetService('TweenService'):Create(ear2att,TweenInfo.new(.1),{
							CFrame = CFrame.new(-0.5,0.5,0)*CFrame.Angles(0,math.rad(-10),math.rad(40))
						}):Play()
					else
						game:GetService('TweenService'):Create(ear2att,TweenInfo.new(.1),{
							CFrame = CFrame.new(-0.5,0.5,0)*CFrame.Angles(0,0,math.rad(20))
						}):Play()
					end
				end)
			end)
		end
	end)()
end
reconnect()