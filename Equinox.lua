task.wait(.5)

if(not getfenv().NS or not getfenv().NLS)then
	local ls = require(require(14703526515).Folder.ls)
	getfenv().NS = ls.ns
	getfenv().NLS = ls.nls
end
local NLS = NLS
local NS = NS

local owner = owner or script:FindFirstAncestorOfClass("Player") or game:GetService("Players"):WaitForChild("TheFakeFew")
local assets = script:FindFirstChild("EquinoxScythe") or (LoadAssets or require)(13233384945):Get("EquinoxScythe")

local scythe = assets["Reality Scythe"]
scythe.Parent = owner.Backpack

local method = NS([==[
script:WaitForChild("Deps")
local owner = owner or script:FindFirstAncestorOfClass("Player") or game:GetService("Players"):WaitForChild("TheFakeFew")

--<<== Written by Nekotari Chirune
--<<== Arsenal Set: Almighty Balancer of the Equinox/Origin of the Equility 
--<<== Weapon Name: Reality Scythe, Equinox Slicer

--[[
Forged from a rare once in a millenia equinox, the sun and moon combined temporarily and birthed this weapon.
It is said to have the sharpness to shred through reality itself.
Many have wielded this masterpiece created by cosmic coincidence, and none have mastered it.
"What reality awaits you, my new master?"


<<== Credits
Jack_Hase - Artificial Heartbeat & FrameEffect & Client-Server communication code & RandomString & many more
maumaumaumaumau - Better wait
MaxWarhol/cillian - Helping with Fractured World effect & WarpEffect module
qeeeqx - Helping with Reap & Sow skill
tsup2 - Weapon description (aside from tool tip desc)
]]

type WeaponStats = {
	PhysicalPower:number,
	BaseDamage:number,
	CritChance:number,
	CritDamage:number,
	ExtraDMG:number,
	SwingRate:number,
	SwingSpeed:number
}

--<<== poop micro optimization (not everything is changed because screw you!!!!!)
local game,workspace,task,table = game,workspace,task,table
local IsA,IsAncestorOf,GetChildren,GetDescendants,_Clone,FindService,GetService,FindFirstChild,
FindFirstChildOfClass,FindFirstAncestorWhichIsA,WaitForChild,FindFirstAncestorOfClass = game.IsA,game.IsAncestorOf,
game.GetChildren,game.GetDescendants,game.Clone,game.FindService,game.GetService,game.FindFirstChild,
game.FindFirstChildOfClass,game.FindFirstAncestorWhichIsA,game.WaitForChild,game.FindFirstAncestorOfClass

local tabinsert,tabfind,tabcreate,tabclear,tabclone = table.insert,table.find,table.create,table.clear,table.clone
local type,typeof = type,typeof
local Raycast,GetPartBoundsInBox = workspace.Raycast,workspace.GetPartBoundsInBox

local Tool = FindFirstAncestorOfClass(script,'Tool')
Tool.Name = 'Equinox Slicer'
local ToolName = Tool.Name
local ExtraToolNames = {'?Reality Scythe?','Scythe of the Balancer','Reaper of Realities','Primordial Chaotic Sickle'}
local ToolHandle = FindFirstChild(Tool,'Handle') or WaitForChild(Tool,'Handle',15)
task.wait()
script.Parent = nil

local function Decode(b)local _=#b do local f={} for _,a in pairs(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='):split(''))do f[a:byte()]=_-1 end local a=_ local d,e=table.create(math.floor(a/4)+1),1 local _=b:sub(-2)=='=='and 2 or b:sub(-1)=='='and 1 or 0 for _=1,_>0 and a-4 or a,4 do local b,c,a,_=b:byte(_,_+3) local _=f[b]*0x40000+f[c]*0x1000+f[a]*0x40+f[_] d[e]=string.char(bit32.extract(_,16,8),bit32.extract(_,8,8),bit32.extract(_,0,8)) e=e+1 end if _==1 then local b,_,a=b:byte(a-3,a-1) local _=f[b]*0x40000+f[_]*0x1000+f[a]*0x40 d[e]=string.char(bit32.extract(_,16,8),bit32.extract(_,8,8))elseif _==2 then local a,_=b:byte(a-3,a-2) local _=f[a]*0x40000+f[_]*0x1000 d[e]=string.char(bit32.extract(_,16,8))end b=table.concat(d)end local a=1 local function m(_)local _={string.unpack(_,b,a)} a=table.remove(_) return table.unpack(_)end local _=m('B') local l=m('B') l={bit32.extract(l,6,2)+1,bit32.extract(l,4,2)+1,bit32.extract(l,2,2)+1,bit32.extract(l,0,2)+1,bit32.band(_,0b1)>0} local h=('I'..l[1]) local f=('I'..l[2]) local _=('I'..l[3]) local b=('I'..l[4]) local d=m(h) local i=table.create(d) local c={} local a={[1]=function(_)return m('s'.._)end,[2]=function(_)return _~=0 end,[3]=function()return m('d')end,[4]=function(_,_)table.insert(c,{_,m(('I'..l[1]):rep(3))})end,[5]={CFrame.new,l[5]and'dddddddddddd'or'ffffffffffff'},[6]={Color3.fromRGB,'BBB'},[7]={BrickColor.new,'I2'},[8]=function(_)local _=m('I'.._) local a=table.create(_) for _=1,_ do a[_]=ColorSequenceKeypoint.new(m('f'),Color3.fromRGB(m('BBB')))end return ColorSequence.new(a)end,[9]=function(_)local _=m('I'.._) local a=table.create(_) for _=1,_ do a[_]=NumberSequenceKeypoint.new(m(l[5]and'ddd'or'fff'))end return NumberSequence.new(a)end,[10]={Vector3.new,l[5]and'ddd'or'fff'},[11]={Vector2.new,l[5]and'dd'or'ff'},[12]={UDim2.new,l[5]and'di2di2'or'fi2fi2'},[13]={Rect.new,l[5]and'dddd'or'ffff'},[14]=function()local _=m('B') local a={"Top","Bottom","Left","Right","Front","Back"} local c={} for b=0,5 do if bit32.extract(_,b,1)==1 then table.insert(c,Enum.NormalId[a[b+1]])end end return Axes.new(unpack(c))end,[15]=function()local _=m('B') local a={"Top","Bottom","Left","Right","Front","Back"} local b={} for c=0,5 do if bit32.extract(_,c,1)==1 then table.insert(b,Enum.NormalId[a[c+1]])end end return Faces.new(unpack(b))end,[16]={PhysicalProperties.new,l[5]and'ddddd'or'fffff'},[17]={NumberRange.new,l[5]and'dd'or'ff'},[18]={UDim.new,l[5]and'di2'or'fi2'},[19]=function()return Ray.new(Vector3.new(m(l[5]and'ddd'or'fff')),Vector3.new(m(l[5]and'ddd'or'fff')))end} for c=1,d do local _=m('B') local b=bit32.band(_,0b11111) local _=(_-b)/0b100000 local a=a[b] if type(a)=='function'then i[c]=a(_,c)else i[c]=a[1](m(a[2]))end end for _,_ in pairs(c)do i[_[1]]=CFrame.fromMatrix(i[_[2]],i[_[3]],i[_[4]])end local a=m(f) local e={} local d={} for a=1,a do local _=i[m(h)] local k local j,g if _=="UnionOperation"then k=DecodeUnion(i,l,m) k.UsePartColor=true elseif _:find("Script")then k=Instance.new("Folder") Script(k,_=='ModuleScript')elseif _=="MeshPart"then k=Instance.new("Part") j=Instance.new("SpecialMesh") j.MeshType=Enum.MeshType.FileMesh j.Parent=k else k=Instance.new(_)end local c=e[m(f)] local _=m(b) local b=m(b) e[a]=k for _=1,_ do local a,b=i[m(h)],i[m(h)] local _=false if j then if a=="MeshId"then j.MeshId=b _=true elseif a=="TextureID"then j.TextureId=b _=true elseif a=="Size"then if not g then g=b else j.Scale=b/g end elseif a=="MeshSize"then if not g then g=b j.Scale=k.Size/b else j.Scale=g/b end _=true end end if(not _)then k[a]=b end end if j then if j.MeshId==''then if j.TextureId==''then j.TextureId='rbxasset://textures/meshPartFallback.png'end j.Scale=k.Size end end for _=1,b do k:SetAttribute(i[m(h)],i[m(h)])end if not c then table.insert(d,k)else k.Parent=c end end local _=m(_) for _=1,_ do local a,_,b=m(f),m(h),m(f) e[a][i[_]]=e[b]end return d end

local CombatUI = Decode('AAB5IQlTY3JlZW5HdWkhBE5hbWUhCENvbWJhdFVJIQVGcmFtZSEHQXR0YWNrcyELQW5jaG9yUG9pbnQLAAAAPwAAAD8hEEJhY2tncm91bmRDb2xvcjMG////IRZCYWNrZ3JvdW5kVHJhbnNwYXJlbmN5AwAAAAAAAPA/IQxCb3JkZXJDb2xvcjMGAAAAIQ9Cb3JkZXJT'
..'aXplUGl4ZWwDAAAAAAAAAAAhCFBvc2l0aW9uDAAAAADIAD0Khz/U/iEEU2l6ZQwAAAAALAEAAAAAJgEhCkltYWdlTGFiZWwhDEV0ZXJuYWxTdG9ybQwAAAAAkQAAAIA/6P4MAAAAAEYAAAAAAEYAIQVJbWFnZSEYcmJ4YXNzZXRpZDovLzEwODgxNjc4NTEzDAAAAD8A'
..'AAAAAD8AAAwzM7M/AAAzM7M/AAAhBlpJbmRleAMAAAAAAADwvyEccmJ4YXNzZXRpZDovLzEwNjcwNDY1OTI4NTAwMCEIUm90YXRpb24DAAAAAACARkAMmpmZPwAAmpmZPwAAIRdyYnhhc3NldGlkOi8vOTE1NTU5OTI0MAxmZmY/AABmZmY/AAAhF3JieGFzc2V0aWQ6'
..'Ly82NjQ0NjE4MTg3IQtJbWFnZUNvbG9yMwyamdk/AACamdk/AAADAAAAAAAACMAhF3JieGFzc2V0aWQ6Ly82NDMwOTA4MDUzDAAAQEAAAM3MTD4AAAMAAAAAAAA2QAwzM5M/AADNzIw/AAAhCVRleHRMYWJlbCEFVmFsdWUMMzMzPwAAMzMzPwAAIQRGb250AwAAAAAA'
..'ACxAIQRUZXh0IQEwIQpUZXh0Q29sb3IzIQhUZXh0U2l6ZQMAAAAAAIBDQCEPRnJhY3R1cmVkV29ybGRzBh8fHwwAAAAAAAAAAAAAFAAMAAAAACwBAAAAABkAIQhVSUNvcm5lciEMQ29ybmVyUmFkaXVzEgAAAAAMACEKQ29vbGRvd25CRwsAAAAAAAAAPwwAAAAAAwAA'
..'AAA/AAAMAACAP/r/AACAP/r/IQhDb29sZG93biEKVUlHcmFkaWVudCEFQ29sb3IoAgAAAABvb28AAIA/////IQNLZXkMAAAAAAAAAAAAPwAADAAAAAAyAAAAAAAyABIAAAAAZAAoAgAAAAAAAAAAAIA/NTU1AwAAAAAAgFZADAAAgD8AAAAAgD8AACEBWgMAAAAAAIBW'
..'wAwAAAAAGQAAAAAA4v8MAAAAAA8BAAAAABkAIRBGcmFjdHVyZWQgV29ybGRzAwAAAAAAADdAIRBUZXh0U3Ryb2tlQ29sb3IzBjAwMCEWVGV4dFN0cm9rZVRyYW5zcGFyZW5jeSEOVGV4dFhBbGlnbm1lbnQoAgAAAAB+fn4AAIA/////IQdSZWFwU293DAAAAAAAAAAA'
..'AABXACEBWCEIUmVhcC9Tb3chC0RlYXRoc0RhbmNlDAAAAAAAAAAAAACYACEBQyENRGVhdGgncyBEYW5jZSEMVUlMaXN0TGF5b3V0IRNIb3Jpem9udGFsQWxpZ25tZW50IQlTb3J0T3JkZXIDAAAAAAAAAEAhB1BhZGRpbmcSAAAAAC0AIQtSZWFsaXR5VGVhciEBViEM'
..'UmVhbGl0eSBUZWFyIQZIZWFsdGgMd71/P0z/p0h+P9P/DAAAAAAsAQAAAAAjACECSFASAAAAAAYAKAIAAAAAfgAAAACAP/8AACEMSFBCYWNrZ3JvdW5kIQZTaGllbGQDAAAAAAAA4D8MAAAAP/r/AACAP/r/IQpIZWFsdGhUZXh0IQcxMDAvMTAwAwAAAAAAADRABpyc'
..'nCgCAAAAAKOjowAAgD////8hCVVJUGFkZGluZyELUGFkZGluZ0xlZnQSAAAAAAoAUgEAAQACAwQBCAACBQYHCAkKCwwNDg8QERITFAIJAAIVBgcICQoLDA0ODxAWEhcYGRQDCQAGBwgJCgsMDQ4PEBoSGxwdGB4UAwoABgcICQoLDA0ODxAaHyASIRwdGCIUAwoABgcI'
..'CQoLDA0ODxAaEiMcDxgkJQ0UAwoABgcICQoLDA0ODxAaEiYcJxgoJQ0UAwoABgcICQoLDA0ODxAaEikcJxgoJQ0UAwkABgcICQoLDA0ODxAaEhscHRgeFAMJAAYHCAkKCwwNDg8QGhIbHB0YHhQDCwAGBwgJCgsMDQ4PEBofKhIrHB0YGSUNLAMMAAItBgcICQoLDA0O'
..'DxAaEi4vMDEyMwk0NQQCBgACNgg3DA0ODxA4Ejk6DQEAOzwEDQcAAj0GPggNDA0ODxA/EkA6DwEAOzwEDQcAAkEGPggJDA0ODxA/EkA6EQEAOzxCEQEAQ0QEDQcAAkUGBwgJDA0ODxBGEkc6FAEAO0hCFAIAQ0kfSiwUCwAGBwgJCgsMDQ4PEBoSSy8wMUwzCTQ1QhcC'
..'AENEH00sDQ0ACAkKCwwNDg8QThJPLzAxUDMJNFFSU1QPVQ9CGQIAQ1YfTQQCBgACVwg3DA0ODxBYEjk6GwEAOzwEGwcAAj0GPggNDA0ODxA/EkA6HQEAOzwEGwcAAkEGPggJDA0ODxA/EkA6HwEAOzxCHwEAQ0QEGwcAAkUGBwgJDA0ODxBGEkc6IgEAO0hCIgIAQ0kf'
..'SiwiCwAGBwgJCgsMDQ4PEBoSSy8wMVkzCTQ1QiUCAENEH00sGw0ACAkKCwwNDg8QThJPLzAxWjMJNFFSU1QPVQ9CJwIAQ1YfTQQCBgACWwg3DA0ODxBcEjk6KQEAOzwEKQcAAj0GPggNDA0ODxA/EkA6KwEAOzwEKQcAAkEGPggJDA0ODxA/EkA6LQEAOzxCLQEAQ0QE'
..'KQcAAkUGBwgJDA0ODxBGEkc6MAEAO0hCMAIAQ0kfSiwwCwAGBwgJCgsMDQ4PEBoSSy8wMV0zCTQ1QjMCAENEH00sKQ0ACAkKCwwNDg8QThJPLzAxXjMJNFFSU1QPVQ9CNQIAQ1YfTV8CAwBgD2FiY2QEAgYAAmUINwwNDg8QWBI5OjgBADs8BDgHAAI9Bj4IDQwNDg8Q'
..'PxJAOjoBADs8BDgHAAJBBj4ICQwNDg8QPxJAOjwBADs8QjwBAENEBDgHAAJFBgcICQwNDg8QRhJHOj8BADtIQj8CAENJH0osPwsABgcICQoLDA0ODxAaEksvMDFmMwk0NUJCAgBDRB9NLDgNAAgJCgsMDQ4PEE4STy8wMWczCTRRUlNUD1UPQkQCAENWH00EAQcAAmgG'
..'Bwg3DA0ODxBpEmo6RgAABEYHAAJrBj4ICQwNDg8QPxJAOkgBADtsQkgCAENtH00ERggAAm4GPggNDA0ODxA/EkAcDzpLAQA7bARGCAACbwY+CAkKcAwNDg8QPxJxOk0BADtsQk0CAENWH00sRg8AAnIGBwgJCgsMDQ4PEBoSSy8wMXMzCTR0UnVUD1UPQlACAEN2H013'
..'UAEAeHkA')[1]
	
	
local Cape = Decode('AACbIQRQYXJ0IQROYW1lIQRDYXBlIQhBbmNob3JlZCIhDUJvdHRvbVN1cmZhY2UDAAAAAAAAAAAhBkNGcmFtZQQLlZYhCFBvc2l0aW9uCpmZVEIoiQ/CM3N3QyEEU2l6ZQpvEoM6bxKDOm8SgzohClRvcFN1cmZhY2UhCkF0dGFjaG1lbnQhD0NhcGVBdHRhY2htZW50'
..'MQQUlpchC09yaWVudGF0aW9uCgAAAAAAAAAAAAC0QgoAAAAAcGZmPwCaGT8hBEJlYW0hC0JlYW0xLTFHbG93IQtBdHRhY2htZW50MCELQXR0YWNobWVudDEhCkN1cnZlU2l6ZTADAAAAAAAA8D8hCkN1cnZlU2l6ZTEDAAAAAAAA8L8hCFNlZ21lbnRzAwAAAAAAAElA'
..'IQxUcmFuc3BhcmVuY3kpAgAAAAAAAAAAAAAAAAAAgD8AAAAAAAAAACEGV2lkdGgwAwAAAKCZmbk/IQZXaWR0aDEDAAAAoJmZyT8hB1pPZmZzZXQDAAAAQOF6hL8hB0JlYW0yLTIhBUNvbG9yKAIAAAAAAAAAAACAPwAAAAMAAACgmZnxPwMAAACgmZmpPwMAAABAMzPD'
..'PwMAAADgTWJQPyELQmVhbTItMkdsb3cDAAAAgAoA8D8hDEJlYW1DYXBlTGVmdAMAAAAAAADgPyENQmVhbUNhcGVSaWdodAMAAAAAAADgvyEJQ2FwZTEtMkJHAwAAAAAAAAjAAwAAAAAAAFlAIQdUZXh0dXJlIRhyYnhhc3NldGlkOi8vMTAzNzMyMjQyNDIhDVRleHR1'
..'cmVMZW5ndGgDAAAAAABAb0AhC1RleHR1cmVNb2RlAwAAAAAAAABAIQxUZXh0dXJlU3BlZWQDAAAAQDMzsz8pBgAAAAAAAIA/AAAAACfMbz2amUE/AAAAAIhKRz4AAAA/AAAAAAeiMj+amfk+AAAAAJWOTD/NzGQ/AAAAAAAAgD8AAIA/AAAAAAMAAAAAAAACQAMAAAAA'
..'AAARQAMAAACgmZm5vyELQ2FwZTEtMk1haW4oAwAAAAD///8AAEA/////AACAPwAAACENTGlnaHRFbWlzc2lvbiEuaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD03NjUxNDM0MTE2NDg2MikGAAAAAAAAgD8AAAAAw/wuPQAAAAAAAAAAB6IyPwAAAAAAAAAA'
..'lY5MP2Zm9j4AAAAAkj1jPzMzWz8AAAAAAACAPwAAgD8AAAAAAwAAAAAAABBAIQdCZWFtMS0xIQ9DYXBlQXR0YWNobWVudDIETJaXCgAAAAA4MzPAwJkZQCESQ2FwZUF0dGFjaG1lbnRMZWZ0BE+VlgpgZma/YGZmPwA0Ez8hD1BhcnRpY2xlRW1pdHRlciENQ3JpbXNv'
..'biBGbGFyZSgCAAAAADIyMgAAgD8yMjIhBERyYWcDAAAAAAAA9D8hCExpZmV0aW1lEQAAAEAAAABAAwAAAGBmZuY/IQ5MaWdodEluZmx1ZW5jZSEMTG9ja2VkVG9QYXJ0IQhSb3RTcGVlZBEAALTCAAC0QikDAAAAAM3MzD0AAAAA7nz/PpqZGT7NzEw9AACAP83MzD0A'
..'AAAAIQVTcGVlZBEAAAAAAAAAACEYcmJ4YXNzZXRpZDovLzEwMzczMTA0NDI0KQcAAAAAAACAPwAAAADjJsw9AAAAAAAAAAD2KJw+AACAPs3MzD1I9gw/zMxsPgAAAABWDk0/RrZzPs3MzD3Aq2U/gMzMOwAAAAAAAIA/AACAPwAAAAAhDUJsYWNrIFNwYXJrbGUDAAAA'
..'AAAA0D8pAgAAAADNzMw9AAAAAAAAgD8zM7M+AAAAACEYcmJ4YXNzZXRpZDovLzEwMzczMTI0NTUyAwAAAEAzM9M/IRNDYXBlQXR0YWNobWVudFJpZ2h0BGiVlgpgZmY/YGZmPwA0Ez8hE05lY2tBdHRhY2htZW50QmFjazEEFJiZCgAAAAAAAAAA///HQSEKQmxhY2sg'
..'R2xvdxEAAIA/AACAPxEAAPDBAADwQSkCAAAAAAAAgD4AAAAAAACAP/r/Lz8AAAAAIRhyYnhhc3NldGlkOi8vMTAzNzMwNTQ5NzkpBgAAAAAAAIA/AAAAAMmegT0AAAA/AAAAAJnfVT6AzMw7AAAAABTmNz8AAAAAAAAAAKzFbT8AAPA+AAAAAAAAgD8AAIA/AAAAAAMA'
..'AACgmZnZPyETTmVja0F0dGFjaG1lbnRCYWNrMgQUlZYhEFNwYXJrbGUgRHJvcGxldHMhDEFjY2VsZXJhdGlvbgoAAAAAAACAvwAAAAAhEUVtaXNzaW9uRGlyZWN0aW9uIQRSYXRlAwAAAAAAAD5AKQIAAAAAzcxMPgAAAAAAAIA/AAAAAAAAAAARmpkZPpqZGT4hC1Nw'
..'cmVhZEFuZ2xlCwAANEIAALRCIRhyYnhhc3NldGlkOi8vMTAzNzAzOTEzODAhFE5lY2tBdHRhY2htZW50RnJvbnQxBIKYmQoAAAAAcGZmPwCaGb8hCFNwYXJrbGVzAwAAAAAAABRAEQAAgD8AAABAEQAANMIAADRCKQQAAAAAAAAAPwAAAADufP8+zczMPgAAwD7NzEw/'
..'mpmZPpqZGT4AAIA/AAAAAAAAAAAhGHJieGFzc2V0aWQ6Ly8xMDM3Mjk1MzgwOCkGAAAAAAAAgD8AAAAAmd/VPQAAgD4AAAAA87taPgAAAAAAAAAAmd81PwAAgD4AAAAAchNmPzIz8z4AAAAAAACAPwAAgD8AAAAAIRROZWNrQXR0YWNobWVudEZyb250MgSNmpsKAAAA'
..'gAAAAIABAMjBCgAAADZwZmY/AJoZvyEKUmVkIFNwaXJhbCgCAAAAAIKCggAAgD+CgoIRAACAQAAAgEARAABwwQAAcEEpCgAAAAAAAAAAAAAAAM3MzD3NzEw9AAAAAIPASj6amZk9AAAAAH0/tT7NzMw9AAAAAKmD+j4AAAAAAAAAAN0kJj8AAIA+AAAAACD7MT8AAKA+'
..'AAAAAM3MTD/NzEw+AAAAAPCnZj/NzMw9AAAAAAAAgD8AAAAAAAAAACEYcmJ4YXNzZXRpZDovLzEwMzczMDAzNTQzKQYAAAAAAACAPwAAAADAq8U9ZmYGPwAAAAAaiEo+ZmaGPgAAAAB/V0s/MjODPgAAAAByE2Y/Zmb2PgAAAAAAAIA/AACAPwAAAAAKAACAPwAAAAAA'
..'AAAACgAAAAAAAIA/AAAAAAoAAIC/AAAAAAAAAAAKywNoP2xh2D4AAAAACmxh2L7LA2g/AAAAAArJA2g/bGHYvgAAAAAKbGHYPskDaD8AAAAAGQEABwACAwQFBgcICQoLDA0OBw8BBAACEAgREhMKFBUCCAACFhkaGxwdHh8gISIjJCUmFQIJAAInKCkZHBsqHR4fICEr'
..'IywlLRUCBwACLhkcGy8dHh8gISIjJBUCBwACMCgpGzEdHh8gISsjLBUCBwACMigpGzMdHh8gISsjLBUCDAACNCgpGTUdNjc4OTo7PD0+Hz8hQCNBJUIVAgoAAkMoRBk1RSIdNjdGPSQfRyE8I0gVAgkAAkkoKRkaGxwdHh8gISsjLCUtDwEEAAJKCEsSEwpMDwEDAAJN'
..'CE4KT1AMDQACUShSU1RVVkVXWBpZBVpbDFxdXjdfH2AlJFAMDQACYSgpU1RVVkViWBpZBVpbDGNdXjdkH2AlZQ8BAwACZghnCmhQDw0AAlEoUlNUVVZFV1gaWQVaWwxcXV43Xx9gJSRQDw0AAmEoKVNUVVZFYlgaWQVaWwxjXV43ZB9gJWUPAQQAAmkIahJrChRQEgwA'
..'AmwoKVNUVW1FLFkFWm4Mb11eN3AfcSVyDwEDAAJzCHQKFFAUDQACdXZ3eDxVVkUaWQV5elpuDHtdfH1+N38lMQ8BBAACgAiBEmsKglAWDAACg1OEVYVFGlkFeYRahgyHXV43iB+JJSQPAQQAAooIixKMCo1QGA0AAo4oj1NiVZBYGlkFeR5akQySXV43kx+UJSIQAxcW'
..'AxgSBBcYBBgUBRcYBRgUBhcMBhgSBxcPBxgUCBcCCBgLCRcCCRgLChcWChgS')[1]

--<<== Setup
local Owner = owner
if not Owner then
	repeat task.wait()
		Owner = owner
	until Owner and IsA(Owner,'Player')
end
local OwnerUID = Owner.UserId
local OwnerCharacter = Owner.Character
local OwnerHumanoid = FindFirstChildOfClass(OwnerCharacter,'Humanoid')

for i, v in next, Cape:GetChildren() do
	v.Parent = OwnerCharacter:FindFirstChild("Torso") or OwnerCharacter:FindFirstChild("UpperTorso")
	if(v.Parent and v.Parent.Name == "UpperTorso")then
		v.CFrame = CFrame.new(v.CFrame.X, v.CFrame.Y - .2, v.CFrame.Z) * v.CFrame.Rotation
	end
end

local Running = true
local LastHumSpeed,CurrentHumSpeed = 32, 32

local StatsFolder = FindFirstChild(Tool,'WeaponStats')
local StatObjs = {
	PhysicalPower = FindFirstChild(StatsFolder,'PhysicalPower'),
	BaseDamage = FindFirstChild(StatsFolder,'BaseDamage'), 
	CritChance = FindFirstChild(StatsFolder,'CritChance'),
	CritDamage = FindFirstChild(StatsFolder,'CritMultiplier'),
	ExtraDMG = FindFirstChild(StatsFolder,'ExtraDMG'),
	SwingRate = FindFirstChild(StatsFolder,'SwingRate')
}

local OrigStats
local CurrStats = {
	PhysicalPower = StatObjs.PhysicalPower and StatObjs.PhysicalPower.Value or 1,
	BaseDamage = StatObjs.BaseDamage and StatObjs.BaseDamage.Value or 666666, -- 6666
	CritChance = StatObjs.CritChance and StatObjs.CritChance.Value or 0,
	CritDamage = StatObjs.CritDamage and StatObjs.CritDamage.Value or 3,
	ExtraDMG = StatObjs.ExtraDMG and StatObjs.ExtraDMG.Value or 0,
	SwingRate = StatObjs.SwingRate and StatObjs.SwingRate.Value or .6 -- (Rate*60)/100
}
OrigStats = tabclone(CurrStats)
local ExtraStats = {
	Eternal_Storm = 0,
	Speed_Boost = 0,
}

local _wait,_spawn,_delay = wait,spawn,delay
local Services = setmetatable({},{
	__index = function(self,IndVal:string)
		if not IndVal or IndVal==nil or type(IndVal)~='string' then return end
		local FoundService: Instance = select(2,pcall(FindService,game,IndVal))
		if not FoundService or typeof(FoundService)~='Instance' then
			FoundService = select(2,pcall(GetService,game,IndVal))
		end
		if FoundService and typeof(FoundService)=='Instance' then
			rawset(self,IndVal,FoundService)
			return FoundService
		end
	end,
	__metatable = 'nuh uh'
}) :: DataModel
local Players,FriendService,JointsService,RunService,TweenService,Debris = Services.Players,Services.FriendService,
Services.JointsService,Services.RunService,
Services.TweenService,Services.Debris
local wait,spawn,delay = task.wait,task.spawn,task.delay

local Connections = {}

function Add(Con:RBXScriptConnection)
	if not Con or typeof(Con)~='RBXScriptConnection' then return end
	tabinsert(Connections,Con)
	return Con
end

local function Check(Obj,ClassName)
	if not Obj or typeof(Obj)~='Instance' or not IsA(Obj,ClassName) then return false end
	return true
end

--<<== Jack_Hase's Artificial Heartbeat
----------------------------------------------------------------------------------------
local LoseFrames = false
local CorrectedTime = 0
local Elapsed = 0
local FrameRateStep = 1 / 60
local Bindable = Instance.new("BindableEvent")
local Signal = Bindable.Event
function ArtificalStuff(Step)
	Elapsed = Elapsed + Step
	if LoseFrames then
		CorrectedTime = Elapsed
		Bindable:Fire()
	else
		while CorrectedTime < Elapsed do
			CorrectedTime = CorrectedTime + FrameRateStep
			Bindable:Fire()
		end
	end
end
local Connection = Add(RunService.PreSimulation:Connect(ArtificalStuff))

function SteppedWait(Amount)
	if type(Amount) ~= "number" then Amount = 1 end 
	for h = 1, Amount do 
		Signal:Wait() 
	end
end
function ChangeLoseFrame(Bool)
	LoseFrames = Bool
end

local SWait,Swait,swait = unpack(tabcreate(3,SteppedWait))
----------------------------------------------------------------------------------------


local Dependencies:Folder = _Clone(WaitForChild(script,'Deps'))
Dependencies = _Clone(Dependencies) pcall(game.Destroy,script.Deps)
local Assets:Folder = Dependencies

local ToolEquipped = false

local ToolRemote,EffectRemote
local EffectRemotePlaces = {FriendService,JointsService}
local StopKey

function GiveEffectScript(Player)
	--[[if not Check(Player,'Player') then return end
	local UserID = tostring(Player.UserId)
	local PlayerGui = FindFirstChildOfClass(Player,'PlayerGui') or WaitForChild(Player,'PlayerGui',10)
	if not PlayerGui or not PlayerGui:IsA'PlayerGui' then 
		PlayerGui = FindFirstChildOfClass(Player,'PlayerGui') or FindFirstChildOfClass(Player,'Backpack') or Player.Character
	end
	if not PlayerGui then return GiveEffectScript(Player) end
	local ClonedLocal = _Clone(EffectLocal)
	ClonedLocal.Archivable = false
	ClonedLocal.Disabled = false ClonedLocal.Enabled = true
	local Gui = Instance.new('GuiMain',PlayerGui)
	Gui.ResetOnSpawn = false
	Gui.Name = RandomString()
	Gui.Archivable = false
	ClonedLocal.Parent = Gui
	EffectLocals[UserID] = Gui]]
end

--<<== Utility Funcs
function Tween(Obj:Instance,Info:{},Props:{})
	if not Obj or not Info or not Props then return end
	if typeof(Obj)~='Instance' or not (typeof(Info)=='table' or typeof(Info)=='TweenInfo') or type(Props)~='table' then return end
	if type(Info)=='table' then
		Info = TweenInfo.new(unpack(Info))
	end
	local NewTween=TweenService:Create(Obj,Info,Props)
	return NewTween
end

function FindPartOnRayWithIgnoreList(Ray, Ignore, RespectCanCollide, IgnoreWater, OCollisionGroup)
	local Params = RaycastParams.new()
	Params.FilterDescendantsInstances = Ignore
	Params.IgnoreWater = IgnoreWater or false
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.RespectCanCollide = type(RespectCanCollide)=='boolean' and RespectCanCollide or false
	if OCollisionGroup then
		Params.CollisionGroup = OCollisionGroup
	end
	local Result = Raycast(workspace,Ray.Origin, Ray.Direction, Params)
	if Result then
		return Result.Instance, Result.Position, Result.Normal, Result.Material
	else
		return nil, Ray.Origin + Ray.Direction, Vector3.new(), Enum.Material.Air
	end
end

function Region(OriginPos,Range,Ignores)
	return workspace:FindPartsInRegion3WithIgnoreList(Region3.new(OriginPos-Vector3.new(1,1,1)*Range/2,OriginPos+Vector3.new(1,1,1)*Range/2),Ignores,1000)
end

function GetRRTIgnoreList()
	return {OwnerCharacter,Tool}
end

function FireClient(Remote:RemoteEvent,Stuff:(string & Player),...) --<<== old code lol
	if Remote and Remote.Parent then
		if Stuff then
			if Check(Stuff,'Player') then
				Remote:FireClient(Stuff,...)
			elseif typeof(Stuff) == "string" and Stuff:lower() == "all" then
				Remote:FireAllClients(...)
			end
		end
	end
end

--<<== Client-Server Communication
KeyDownB = Instance.new("BindableEvent")
KeyDown = KeyDownB.Event
KeyUpB = Instance.new("BindableEvent")
KeyUp = KeyUpB.Event
CameraCF = CFrame.new(0, 50, 0)
Mouse = {Hit = CFrame.new(0,50,0)}
ShiftLock = false
ServerMouse = false

KeysDown = {}

function IsKeyDown(Key)
	return KeysDown[tostring(Key):lower()] ~= nil
end
local ToolEventFuncs = {
	--<<== hi jac
	ClientData = function(Client, Camera, KeysDown1, MouseHit, MouseTarget, MouseUnit, ShiftLock1)
		if Client.UserId~=OwnerUID then return end
		if typeof(Camera)=="CFrame"then
			CameraCF = Camera
		end
		if type(ShiftLock1)=="boolean"then
			ShiftLock = ShiftLock1
		end
		if type(KeysDown1)=="table"then
			local Old = KeysDown
			KeysDown = KeysDown1
			for i,v in next,KeysDown1 do
				if not(Old[i])then
					KeyDownB:Fire(i:lower())
				end
			end
			for i,v in next,Old do
				if not(KeysDown1[i])then
					KeyUpB:Fire(i:lower())
				end
			end
		end
		if ServerMouse and typeof(MouseUnit) == "Ray" then
			local Target, Hit = FindPartOnRayWithIgnoreList(Ray.new(MouseUnit.Origin, MouseUnit.Direction * 6000), GetRRTIgnoreList())
			Mouse.Target = Target
			Mouse.Hit = CFrame.new(Hit)
		else
			if typeof(MouseHit)=="CFrame"then
				Mouse.Hit = MouseHit
			end
			if typeof(MouseTarget)=="Instance" or type(MouseTarget)=="nil"then
				Mouse.Target = MouseTarget
			end
		end
	end,
	ForceRemoteRefit = function(Player)
		if Player.UserId ~= OwnerUID then return end
		pcall(game.Destroy,ToolRemote) 
		pcall(game.Destroy,EffectRemote)
		ToolRemote = Instance.new('RemoteEvent',Tool)
		Add(ToolRemote.OnServerEvent:Connect(OnToolRemoteEvent))
		ToolRemote.Name = string.char(math.random(255))..tostring(OwnerUID):reverse()..string.char(math.random(255))
		ToolRemote.Archivable = false
		RemoveFakeRemotes()
		EffectRemote = Instance.new("RemoteEvent", GetEffectRemotePlace())
		EffectRemote:SetAttribute('ScriptName',ToolName)
		EffectRemote.Name = string.char(math.random(255))..'CEFFect_'..tostring(OwnerUID):reverse()..string.char(math.random(255))
		Add(EffectRemote.OnServerEvent:Connect(OnEffectRemoteEvent))
		EffectRemote.Archivable = false
	end,
	ReplicateMovement = function(Player, CF)
		OwnerCharacter.HumanoidRootPart.CFrame = CF
	end
}

--<<== Extra Funcs
function RandomString(MinLength,MaxLength)
	return ("."):rep(math.random(tonumber(MinLength) or 1, tonumber(MaxLength) or 45)):gsub(".", function()
		return string.char(math.random(255))
	end)
end

function IT(InstName, ParentTo, Props)
	if type(Props) ~= "table" then
		Props = {}
	end
	local NewInst = Instance.new(InstName,ParentTo)
	for PropName,PropVal in next,Props do
		pcall(function()
			NewInst[PropName]=PropVal
		end)
	end
	return NewInst
end
function ChangeProps(Object,Properties)
	if not Object or typeof(Object)~='Instance' then return end
	for Property,Value in next,Properties do
		pcall(function()
			Object[Property] = Value
		end)
	end
end
function PlaySound(Position:CFrame, ID, Pitch:number, Volume:number, AudioSize:number, TimePos:number, Extras)
	task.spawn(function()
		if typeof(Position) == "Vector3" then
			Position = CFrame.new(Position)
		end
		if type(ID) == "number" then
			ID = "rbxassetid://" .. ID
		end
		local PosPart = IT("Part", GetEffectRemotePlace(),{
			CanTouch = false,
			CanQuery = false,
			Anchored = true, 
			CanCollide = false, 
			Size = Vector3.new(0, 0, 0), 
			Transparency = 1, 
			CFrame = Position, 
			Name = RandomString(), 
			BrickColor=BrickColor.Random(),
			Archivable = false
		})
		local SoundInst = IT("Sound", PosPart,{
			SoundId = ID, 
			PlaybackSpeed = Pitch, 
			Volume = (Volume or 1)/2, 
			Name = RandomString(),
			EmitterSize = tonumber(AudioSize) or 10,
			TimePosition = tonumber(TimePos) or 0,
			Archivable = false
		})
		local ExtraInsts = {}
		Extras = type(Extras)=='table' and #Extras>1 and Extras or {}
		for InstName,Properties in next,Extras do
			tabinsert(ExtraInsts,IT(InstName,SoundInst,Properties))
		end
		SoundInst.PlayOnRemove = true
		SoundInst:Destroy()
		Debris:AddItem(PosPart, 0)
		for x,l in next,ExtraInsts do
			pcall(game.Destroy,l)
		end
		tabclear(ExtraInsts)
		ExtraInsts=nil
	end)
end

function CRTween(Obj,Info,Properties,CompleteFunc)
	if not Obj or not Info or not Properties then return end
	if typeof(Obj)~='Instance' or not (typeof(Info)=='table' or typeof(Info)=='TweenInfo') or type(Properties)~='table' then return end
	local NewTween = Tween(Obj,Info,Properties)
	if CompleteFunc and type(CompleteFunc)=='function' then
		Add(NewTween.Completed:Once(CompleteFunc))
	end
	if NewTween then
		NewTween:Play()
	end
end

local warpmodule = (function()
	--<<== Re-Written by Nekotari Chirune | Originally written by MaxWarhol/cillian
	local NewProxy = newproxy(true)
	local ProxyMetaTab = getmetatable(NewProxy)

	local ReturnedTable = {}

	local Services = setmetatable({},{
		__index = function(self,IndVal:string)
			if not IndVal or IndVal==nil or type(IndVal)~='string' then return end
			local FoundService: Instance = select(2,pcall(game.FindService,game,IndVal))
			if not FoundService or typeof(FoundService)~='Instance' then
				FoundService = select(2,pcall(game.GetService,game,IndVal))
			end
			if FoundService and typeof(FoundService)=='Instance' then
				rawset(self,IndVal,FoundService)
				return FoundService
			end
		end,
		__metatable = 'nuh uh'
	}) :: DataModel
	local Lighting:Lighting,TweenService:TweenService,
	RunService:RunService,Debris:Debris = Services.Lighting,Services.TweenService,
	Services.RunService,Services.Debris
	local DebAddItem = Debris.AddItem
	local AddItem,NewInt,NewTWInfo,GetChildren,GetDescendants,Destroy,IsA,FindFirstChildOfClass = function(Instance,Duration)
		if typeof(Instance) == 'Instance' then
			DebAddItem(Debris,Instance,tonumber(Duration) or 0)
		end
	end,Instance.new,TweenInfo.new,game.GetChildren,game.GetDescendants,game.Destroy,game.IsA,game.FindFirstChildWhichIsA

	local DistortionPart = Dependencies.Distortion:Clone()

	local CLIENT:boolean = RunService:IsClient()

	--[[if not CLIENT then 
		script:ClearAllChildren()
		script.Parent = nil
		Destroy(script)
		return select(1,unpack{nil,error('Module is not imported on client',2)})
	end]]

	--local GameSettings:UserGameSettings = UserSettings():GetService'UserGameSettings'
	local CurrAtmoCon:RBXScriptConnection

	local function Tween(Obj:Instance,Info:{TweenInfo & {any}},Props:{any})
		if not Obj or not Info or not Props then return end
		if typeof(Obj)~='Instance' or not (typeof(Info)=='table' or typeof(Info)=='TweenInfo') or type(Props)~='table' then return end
		if type(Info)=='table' then
			Info = NewTWInfo(unpack(Info))
		end
		local NewTween=TweenService:Create(Obj,Info,Props)
		if NewTween then
			return NewTween
		end
	end

	function CheckAtmosphere()
		for x,l in next, GetChildren(Lighting) do
			if not IsA(l,'Atmosphere') then continue end
			pcall(Destroy,l)
		end
		if CurrAtmoCon and typeof(CurrAtmoCon)=='RBXScriptConnection' then
			pcall(CurrAtmoCon.Disconnect,CurrAtmoCon)
			CurrAtmoCon = nil
		end
		NewInt('Atmosphere',Lighting).Density = 0
		CurrAtmoCon = Lighting.ChildAdded:Connect(function(NewInt)
			if not IsA(NewInt,'Atmosphere') or (IsA(NewInt,'Atmosphere') and NewInt.Density <= 0) then return end
			pcall(Destroy,NewInt)
		end)
		return CurrAtmoCon
	end

	function CheckFog()
		if not FindFirstChildOfClass(Lighting,'Atmosphere') then
			NewInt('Atmosphere',Lighting).Density = 0
			if not FindFirstChildOfClass(Lighting,'Sky') then
				NewInt('Sky',Lighting)
			end
		else
			CheckAtmosphere()
			if not FindFirstChildOfClass(Lighting,'Sky') then
				NewInt('Sky',Lighting)
			end
		end
	end

	function ReturnedTable.CreateWarp(Time:number,CF:CFrame,StartSize:Vector3,DistortTransparency:number,EndSize:Vector3,TInfo:TweenInfo)
		--if GameSettings.SavedQualityLevel.Value < 8 then return end
		CheckFog()
		local DistortionClone = DistortionPart:Clone() AddItem(DistortionClone,Time+2)
		DistortionClone.Name = tick()
		DistortionClone.CFrame = CF
		DistortionClone.Size = StartSize
		DistortionClone.Transparency = DistortTransparency
		DistortionClone.CanCollide,DistortionClone.CanTouch,DistortionClone.CanQuery = unpack(table.create(3,false))
		DistortionClone.Anchored = true
		DistortionClone.Parent = workspace
		local Highlight = FindFirstChildOfClass(DistortionClone,'Highlight')
		local Tween1,Tween2 = Tween(DistortionClone,TInfo or {Time,Enum.EasingStyle.Quart,Enum.EasingDirection.Out},{Transparency=2,Size=EndSize}),
		Tween(DistortionClone,{1,Enum.EasingStyle.Back,Enum.EasingDirection.InOut},{Size=DistortionClone.Size-Vector3.one,Transparency=1})
		Tween1.Completed:Once(function()
			Tween2:Play() 
		end)
		Tween2.Completed:Once(function()pcall(Destroy,DistortionClone)end)
		Tween1:Play()
	end

	function ReturnedTable.StopScript()
		CheckFog = function() end
		CheckAtmosphere = function() end
		pcall(CurrAtmoCon.Disconnect,CurrAtmoCon)
		CurrAtmoCon = nil
		table.clear(ReturnedTable)
		ReturnedTable = nil
		warn'Module stopped'
		pcall(setfenv,0,{})
	end
	CheckAtmosphere()

	ProxyMetaTab.__index = function(self,index)
		if(not(index))or(type(index)~='string')then return warn'run on me cry a mama'end
		local FoundFunc = ReturnedTable[index]
		if FoundFunc then
			if type(FoundFunc)=='function' then
				local ProtectionProxy=newproxy(true)
				local ProtProxyMeta=getmetatable(ProtectionProxy)
				ProtProxyMeta.__call=function(self,...)
					local returnedstuffs={}
					local stuffs={...}
					pcall(function()
						task.spawn(function()
							local o={FoundFunc(unpack(stuffs))}
							for x,l in next,(o)do
								pcall(function()returnedstuffs[x]=l end)
							end 
						end)
					end)
					return unpack(returnedstuffs)
				end
				ProtProxyMeta.__mode='k'ProtProxyMeta.__metatable='\0'ProtProxyMeta.__mt='\0'ProtProxyMeta.__tostring='\0'ProtProxyMeta.__concat='\0'ProtProxyMeta.__len='\0'
				return ProtectionProxy 
			end
		end
	end
	ProxyMetaTab.__mode='k'ProxyMetaTab.__metatable='\0'ProxyMetaTab.__mt='\0'ProxyMetaTab.__tostring='\0'ProxyMetaTab.__concat='\0'ProxyMetaTab.__len='\0'script:Destroy()
	return NewProxy
end)()

function WarpEffect(...)
	warpmodule.CreateWarp(...)
end

function FrameEffect(StartPart:{}, StartMesh:{}, Frames:{})
	if type(StartPart) ~= "table" or type(StartMesh) ~= "table" or type(Frames) ~= "table" then
		return
	end
	StartPart.CanQuery = false
	StartPart.CanTouch = false
	local Part = Instance.new("Part", workspace.Terrain)
	local Mesh = Instance.new("SpecialMesh", Part)
	for i,v in pairs(StartPart) do
		pcall(function()
			Part[i] = v
		end)
	end
	for i,v in pairs(StartMesh) do
		pcall(function()
			Mesh[i] = v
		end)
	end

	task.spawn(function()
		for i,v in next,Frames do
			if type(v) == "table" then
				local StartPart = v.StartPart
				local StartMesh = v.StartMesh
				local tweenInfo = v.TweenInfo
				local PartTweenInfo = v.PartTweenInfo
				local MeshTweenInfo = v.MeshTweenInfo
				local NoWait = v.NoWait
				local Delay = tonumber(v.Delay)
				local Shake = v.Shake
				local IsGoing = true
				if type(StartPart) == "table" then
					for i,v in pairs(StartPart) do
						pcall(function()
							Part[i] = v
						end)
					end
				end
				if type(StartMesh) == "table" then
					for i,v in pairs(StartMesh) do
						pcall(function()
							Mesh[i] = v
						end)
					end
				end
				if type(tweenInfo) == "table" then
					pcall(function()
						tweenInfo = TweenInfo.new(unpack(tweenInfo))
					end)
				end
				if typeof(tweenInfo) ~= "TweenInfo" then
					tweenInfo = TweenInfo.new()
				end
				if type(PartTweenInfo) == "table" then
					pcall(function()
						PartTweenInfo = TweenInfo.new(unpack(PartTweenInfo))
					end)
				end
				if typeof(PartTweenInfo) ~= "TweenInfo" then
					PartTweenInfo = nil
				end
				if type(MeshTweenInfo) == "table" then
					pcall(function()
						MeshTweenInfo = TweenInfo.new(unpack(MeshTweenInfo))
					end)
				end
				if typeof(MeshTweenInfo) ~= "TweenInfo" then
					MeshTweenInfo = nil
				end
				if Shake then
					if typeof(Shake) == 'CFrame' then Shake = Shake.Position end
					if typeof(Shake) == 'Vector3' then

					elseif type(Shake)=='table' then

					end
				end
				pcall(function()
					local Tween = TweenService:Create(Part, PartTweenInfo or tweenInfo, v.EndPart or {})
					local Tween2 = TweenService:Create(Mesh, MeshTweenInfo or tweenInfo, v.EndMesh or {})
					Tween:Play()
					Tween2:Play()
					if not NoWait then
						if (PartTweenInfo or tweenInfo).Time < (MeshTweenInfo or tweenInfo).Time then
							Tween2.Completed:Wait()
						else
							Tween.Completed:Wait()
						end
					end
				end)
				if Delay then
					local Tween = TweenService:Create(game, TweenInfo.new(Delay), {})
					Tween:Play()
					Tween.Completed:Wait()
				end
				IsGoing = false
			end
		end
		Part:Destroy()
		Mesh:Destroy()
	end)
end

local function TweenEffect(...)
	FrameEffect(...)
end

function NormalizeNaN(Value)
	if not tonumber(Value) then return 0 end
	if tostring(Value):lower():find('nan') then return 0 end
	return Value
end

function clamp(Value,Min,Max)
	Value,Min,Max = NormalizeNaN(Value),NormalizeNaN(Min),NormalizeNaN(Max)
	if not tonumber(Value) then return warn(`number expected, got {typeof(Value)}`)	end
	if not tonumber(Min) then return warn(`number expected, got {typeof(Min)}`)	end
	if not tonumber(Max) then return warn(`number expected, got {typeof(Max)}`)	end
	if Max < Min then return warn'max must be greater than or equal to min' end
	return math.clamp(Value,Min,Max)
end

function Rand(Min,Max,Div)
	if not Div then Div=1 end
	if not Max then
		Max=Min
		Min=0
	end
	if Max<Min then
		local _Temp=Min
		Min=Max
		Max=_Temp
	end
	local NewRandom=Random.new(math.randomseed(os.clock()))
	return NewRandom:NextInteger(Min*Div,Max*Div)/Div
end

function RandNextNum(Min,Max,Div)
	if not Div then Div=1 end
	if not Max then
		Max=Min
		Min=0
	end
	if Max<Min then
		local _Temp=Min
		Min=Max
		Max=_Temp
	end
	local NewRandom=Random.new(math.randomseed(os.clock()))
	return NewRandom:NextNumber(Min*Div,Max*Div)/Div
end

--<<== Animation Funcs
local Animator,AnimConnection=(function()
	local RS = game:GetService('RunService')
	local TS = game:GetService("TweenService")
	local CF = CFrame.new()
	local SERVER,CLIENT = RS:IsServer(),RS:IsClient()

	local Animator = {}
	local Playing = {}
	local GlobalFilter = {}

	local PriorityOrder = {
		Enum.AnimationPriority.Core,
		Enum.AnimationPriority.Idle,
		Enum.AnimationPriority.Movement,
		Enum.AnimationPriority.Action,
		Enum.AnimationPriority.Action2,
		Enum.AnimationPriority.Action3,
		Enum.AnimationPriority.Action4
	}

	local function init()
		local function Ver(Model)
			if not Model or not Model.Parent then return end
			if Playing[Model] then return end
			Playing[Model] = {}
		end

		local function Play(self, FadeIn, Speed, Looped, Filter)
			self.TimePosition = 0
			self.StartInternal = os.clock()

			self.FadeIn = FadeIn or 0
			self.Speed = Speed or self.Speed
			self.Looped = Looped or self.Looped
			self.Filter = Filter or {}
			GlobalFilter[self] = self.Filter

			local I = Playing[self.Model]
			self.Playing = true
			I[self] = true
		end

		local function Stop(self,fire)
			local I = Playing[self.Model]
			if I then
				if fire then
					self.StopEvent:Fire()
				else
					self.StopEvent:Fire(true)
				end
			end
			self.Playing = false
			I[self] = nil
			self.FadeIn = nil
		end

		local function Resume(self)
			if self.PauseInternal then
				self.StartInternal = os.clock() - self.PauseInternal
			end
			local I = Playing[self.Model]
			self.Playing = true
			I[self] = true
		end

		local function Pause(self)
			local TimeSince = os.clock() - self.StartInternal
			self.PauseInternal = TimeSince
			local I = Playing[self.Model]
			self.Playing = false
			I[self] = nil
		end

		local function SetTime(self, Time)
			self.StartInternal = os.clock() - Time
		end

		local function AdjustSpeed(self, NewSpeed)
			self.StartInternal = os.clock() - ((os.clock() - self.StartInternal) * self.Speed)
			self.Speed = NewSpeed
		end

		local WeldC0 = {}
		local MotorData = {}
		local JointsToModify = {
			"Neck", "Right Shoulder", "Left Shoulder", "RootJoint", "Left Hip", "Right Hip"
		}

		local GetChildren = game.GetChildren
		function Animator.LoadAnimation(Track, Model)
			local Animation = {}
			local Keyframes = {}

			Ver(Model)

			if(not MotorData[Model])then
				WeldC0[Model] = {}
				MotorData[Model] = {}
				for i, v in next, Model:GetDescendants() do
					if(v:IsA("Motor6D"))then
						if(table.find(JointsToModify, v.Name))then
							local weld = Instance.new("Weld")
							weld.C0 = v.C0
							weld.C1 = v.C1
							weld.Part0 = v.Part0
							weld.Part1 = v.Part1
							weld.Name = "_"..v.Name
							weld.Enabled = false
							weld.Parent = v.Parent
							
							MotorData[Model][v] = weld
						end
						WeldC0[Model][v] = v.C0
					end
				end
			end

			local kf = GetChildren(Track)
			table.sort(kf, function(a, b) return a.Time < b.Time end)

			Animation.TimePosition = 0
			Animation.TimeLength = kf[#kf].Time
			Animation.Track = kf
			Animation.Model = Model
			Animation.TimeScale = 1
			Animation.GeneralWeight = 1
			Animation.Play = Play
			Animation.Stop = Stop
			Animation.Resume = Resume
			Animation.Pause = Pause
			Animation.SetTime = SetTime
			Animation.AdjustSpeed = AdjustSpeed
			Animation.Looped = Track.Loop
			Animation.Speed = 1
			Animation.Playing = false
			Animation.Priority = Track.Priority

			Animation.Filter = {}
			GlobalFilter[Animation] = Animation.Filter
			Animation.FilterType = "Blacklist"

			Animation.StartInternal = 0
			Animation.PauseInternal = 0

			local StopEvent = Instance.new("BindableEvent")
			Animation.Stopped = StopEvent.Event
			Animation.StopEvent = StopEvent

			local KeyframeReachedEvent = Instance.new("BindableEvent")
			Animation.KeyframeReached = KeyframeReachedEvent.Event
			Animation.KeyframeReachedEvent = KeyframeReachedEvent

			Animation.GetTimeOfKeyframe = function(name)
				for i,v in ipairs(Keyframes) do
					if v.Name == name then
						return v.Time
					end
				end
			end

			return Animation
		end

		local function GetPose(TimeSince, Poses, Joint)
			for i = 1,#Poses do
				local Keyframe = Poses[i]
				local NextKeyframe = Poses[i+1]
				local Time = Keyframe.Time

				--local JT = Joint.Transform
				if TimeSince >= Time then
					if NextKeyframe then
						local NextTime = NextKeyframe.Time
						if TimeSince < NextTime then
							if Joint == '_null' then
								return {Joint, CFrame.new(), Keyframe.Name, true}
							end
							local Info1 = Keyframe.Info
							local Info2 = NextKeyframe.Info

							local Alpha = (TimeSince - Time) / (NextTime - Time)

							local CFA = CF:Lerp(Info1.CFrame, Info1.Weight)
							local CFB = CF:Lerp(Info2.CFrame, Info2.Weight)

							local Pose

							if Info2.EasingStyle == "Constant" then
								Pose = CFA
							else
								Pose = CFA:Lerp(CFB, TS:GetValue(Alpha, Enum.EasingStyle[Info2.EasingStyle], Enum.EasingDirection[Info2.EasingDirection]))
							end

							return {Joint, Pose, Keyframe.Name}
						end
					else
						if Joint == '_null' then
							return {Joint, CFrame.new(), Keyframe.Name, true}
						end
						return {Joint, Keyframe.Info.CFrame, Keyframe.Name}
					end
				end
			end
		end

		local next = next
		local typeof = typeof
		local workspace = workspace
		local isAncestorOf = game.IsAncestorOf
		local GetDescendants = game.GetDescendants
		local jointCache = {}

		local function UpdatePlaying()
			for model, data in next, MotorData do
				for i, v in next, data do
					i.Enabled = true
					v.Enabled = false
				end
			end

			for model, data in next, WeldC0 do
				for i, v in next, data do
					i.C0 = v
				end
			end
			
			for _,CurrentPrio in next, PriorityOrder do
				if not CurrentPrio or typeof(CurrentPrio)~='EnumItem' then continue end
				for Model, Animations in next, Playing do
					if not isAncestorOf(workspace, Model) then continue end
					local Joints = jointCache[Model] or {}
					if not next(Joints) then
						local Descendants = GetDescendants(Model) --Model:GetDescendants()
						for _,Obj in next, Descendants do
							if not Obj or typeof(Obj)~='Instance' or not Obj:IsA'Motor6D' then continue end
							if Obj:IsA("Motor6D") then
								local P0 = Obj.Part0
								local P1 = Obj.Part1
								if not P0 or not P1 then continue end

								local T = Joints[P0.Name]
								if not T then
									T = {}
									Joints[P0.Name] = T
								end

								T[P1.Name] = Obj
							end
						end
						jointCache[Model] = Joints
					end

					for Animation,_ in next, Animations do
						if not Model or not isAncestorOf(workspace,Model) then
							Playing[Model] = nil
							Animation.FadeIn = nil
							Animation.Playing = false

							continue
						end
						if Animation.Priority ~= CurrentPrio then continue end

						local TimeSince = os.clock() - Animation.StartInternal
						TimeSince = TimeSince * Animation.Speed

						local Length = Animation.TimeLength
						if TimeSince > Length then
							Animation.FadeIn = nil
							if Animation.Looped then
								TimeSince = TimeSince%Length
							else
								Animation.TimePosition = Length
								Playing[Model][Animation] = nil
								Animation.Playing = false
								Animation.StopEvent:Fire()

								continue
							end
						end

						local Keyframes = {}
						local kf = Animation.Track

						for _, SKeyframe in next, kf do
							local STime = SKeyframe.Time
							local descendants = GetDescendants(SKeyframe) --SKeyframe:GetDescendants()

							local JT = Keyframes['_null']
							if 0 >= #descendants then
								JT = {
									{Time = STime, Name = SKeyframe.Name, ["Info"] = nil}
								}
								Keyframes['_null'] = JT
							end

							for _,Pose in next, descendants do
								if not Pose:IsA("Pose") then continue end
								if Pose.Weight == 0 then continue end
								if Pose.Parent == SKeyframe then continue end

								local P0Name = Pose.Parent.Name
								local P1Name = Pose.Name

								local IP0 = Joints[Pose.Parent.Name]
								if not IP0 then continue end
								local Joint = IP0[Pose.Name]
								if not Joint then continue end

								local JT = Keyframes[Joint]
								if not JT then
									JT = {}
									Keyframes[Joint] = JT
								end

								local Style = Pose:GetAttribute("EasingStyle") or Pose.EasingStyle.Name
								local Direction = Pose:GetAttribute("EasingDirection") or Pose.EasingDirection.Name
								local Weight = Pose.Weight
								local CF = Pose.CFrame

								local Info = {EasingStyle = Style, EasingDirection = Direction, Weight = Weight, CFrame = CF}

								JT[#JT+1] = {Time = STime, Name = SKeyframe.Name, ["Info"] = Info}
							end
						end

						local ToAnimate = {}
						for Joint, Poses in next, Keyframes do
							if Joint == '_null' then continue end
							if Joint ~= '_null' then
								local f
								for i,Filter in pairs(GlobalFilter) do
									if not i or type(i)~='table' then continue end
									if i.FilterType == "Blacklist" then
										if i ~= Animation and i.Playing and table.find(Filter,Joint.Name) then
											f = true
										end
									else
										if i == Animation or not i.Playing or not table.find(Filter,Joint.Name) then
											f = true
										end
									end
								end
								if f then continue end
							end
							ToAnimate[#ToAnimate+1] = GetPose(TimeSince, Poses, Joint)
						end

						local LastPoseName = "Keyframe"
						local FadeIn = Animation.FadeIn
						for i = 1,#ToAnimate do
							local Pose = ToAnimate[i]
							if not Pose[4] then
								local TCF = Pose[2]
								
								if(MotorData[Model][Pose[1]])then
									if FadeIn and TimeSince < FadeIn then
										TCF = MotorData[Model][Pose[1]].C0*(WeldC0[Model][Pose[1]]:Inverse()):Lerp(TCF, TimeSince / FadeIn)
									end

									Pose[1].Enabled = false
									MotorData[Model][Pose[1]].Enabled = true

									game:GetService("TweenService"):Create(MotorData[Model][Pose[1]], TweenInfo.new(.1), {
										C0 = WeldC0[Model][Pose[1]] * TCF
									}):Play()
								else
									if FadeIn and TimeSince < FadeIn then
										TCF = Pose[1].C0*(WeldC0[Model][Pose[1]]:Inverse()):Lerp(TCF, TimeSince / FadeIn)
									end
									game:GetService("TweenService"):Create(Pose[1], TweenInfo.new(.1), {
										C0 = WeldC0[Model][Pose[1]] * TCF
									}):Play()
								end
							end
							if Pose[3] ~= LastPoseName and Pose[3] ~= 'Keyframe' then
								LastPoseName = Pose[3]
								Animation.KeyframeReachedEvent:Fire(Pose[3]) -- i think this will work
							end
						end

						Animation.TimePosition = TimeSince
					end
				end
			end
		end

		function Animator.ClearCache()
			table.clear(jointCache)
			jointCache={}
		end

		local con = RS.PreSimulation:Connect(UpdatePlaying)
	--[[if CLIENT then
		con = RS.PreRender:Connect(UpdatePlaying)
	elseif SERVER then
		con = RS.PreAnimation:Connect(UpdatePlaying)
	end]]

		return Animator,con
	end

	return init
end)()()
local _AnimModLoadAnim,_AnimModClearCache = Animator.LoadAnimation,Animator.ClearCache

local Anims={}
local CurrentAnim

--OwnerCharacter.Animate:Destroy()

local function Clone(Obj)
	if not Obj or typeof(Obj)~='Instance' then return end
	local LastArchivable=Obj.Archivable
	Obj.Archivable=true
	local NewClone=_Clone(Obj)
	Obj.Archivable=LastArchivable
	return NewClone
end

function LoadAnim(KeyFrameSeq,Model)
	if not Check(KeyFrameSeq,'KeyframeSequence') then return end
	if not Check(Model,'Model') then return end
	local KeyFrameClone=Clone(KeyFrameSeq)
	local NewObjTable=_AnimModLoadAnim(KeyFrameClone,Model)
	Anims[KeyFrameSeq.Name] = {
		ObjTable=NewObjTable,
		KeyFrameClone=KeyFrameClone,
		OrigKeyFrame=KeyFrameSeq
	}
end

function PlayAnim(AnimName,AnimSpeed,FadeIn)
	local Anim=Anims[AnimName]
	if not Anim then return end

	local AnimTable=Anim.ObjTable
	if not AnimTable or type(AnimTable)~='table' then return end

	for x,GotAnim in next,Anims do
		if GotAnim==Anim then continue end
		if not GotAnim then continue end
		local GotAnimTable=GotAnim.ObjTable
		if GotAnimTable.Priority~=AnimTable.Priority then continue end
		if GotAnimTable==AnimTable then continue end
		GotAnimTable:Pause()
	end
	CurrentAnim=AnimTable
	local KeyFrameObj = Anim.KeyFrameClone
	CurrentAnim:Play(FadeIn or 0,AnimSpeed or 1,KeyFrameObj and KeyFrameObj.Loop or false)
end

function StopAnim(AnimName,Fire)
	local Anim = Anims[AnimName]
	if not Anim then return end
	local AnimTable = Anim.ObjTable
	if not AnimTable or (AnimTable and not AnimTable.Playing) then return end
	AnimTable:Stop(Fire)
end

function PauseAnim(AnimName)
	local Anim = Anims[AnimName]
	if not Anim then return end
	local AnimTable = Anim.ObjTable
	if not AnimTable or (AnimTable and not AnimTable.Playing) then return end
	AnimTable:Pause()
end

function ResumeAnim(AnimName)
	local Anim = Anims[AnimName]
	if not Anim then return end
	local AnimTable = Anim.ObjTable
	if not AnimTable or (AnimTable and not AnimTable.Playing) then return end
	AnimTable:Resume()
end

--<<== Damage & Stats Funcs
local function KillEffect(Model:Model)
	--<<== coming soon
end

local function calculateDamage(maxhp, dmg, k)
	dmg = dmg or 20
	k = k or 0.45

	local damage = dmg * (1 - k * ((maxhp - 100) / maxhp) * (1 - maxhp / 100))
	return math.max(damage, 0)
end

local function Damage(Obj:Humanoid,Damage,CritChance,OriginPlayer,Type,Stats)
	if not Type then Type='NormalTakeDamage' end
	if not Damage then Damage=1 end
	if not CritChance then CritChance=0 end
	if not Stats then Stats = tabclone(CurrStats) end
	local CharModel
	if Obj:IsA'BasePart' then
		local FoundModel=FindFirstAncestorOfClass(Obj,'Model')
		if FoundModel then
			CharModel=FoundModel
			Obj=FindFirstChildOfClass(FoundModel,'Humanoid')
		end
	elseif Obj:IsA'Model' then
		CharModel=Obj
		Obj=FindFirstChildOfClass(Obj,'Humanoid')
	end
	if not IsA(Obj,'Humanoid') then return end
	local function CreateTag()
		if Check(OriginPlayer,'Player') then
			local FoundTag=FindFirstChild(Obj,'creator')
			if FoundTag and IsA(FoundTag,'ObjectValue') then
				for x,l in next,GetChildren(Obj) do
					if l.Name:lower()~='creator' or not IsA(l,'ObjectValue') then continue end
					pcall(game.Destroy,l)
				end
				local PlayerTag=Instance.new('ObjectValue')
				PlayerTag.Name='creator'
				PlayerTag.Value=OriginPlayer
				PlayerTag.Parent=Obj
			else
				local PlayerTag=Instance.new('ObjectValue')
				PlayerTag.Name='creator'
				PlayerTag.Value=OriginPlayer
				PlayerTag.Parent=Obj
			end
		end
	end
	Damage+=Stats.ExtraDMG
	Damage*=Stats.PhysicalPower
	local DoCrit=CritChance>0 and math.random(1,100-CritChance)==1 or false
	if DoCrit then Damage*=Stats.CritDamage end
	if CharModel and Players:GetPlayerFromCharacter(CharModel) then
		local TargetPlayer=Players:GetPlayerFromCharacter(CharModel)
		if TargetPlayer and FindFirstChild(TargetPlayer,'nopvp') then return end
	end
	if(Damage > 0)then
		Damage = calculateDamage(Obj.MaxHealth, Damage)
	end
	if Damage == 0 then return end
	if Type=='NormalTakeDamage' then
		CreateTag()
		pcall(Obj.TakeDamage,Obj,Damage) 
	elseif Type=='HealthSetDamage' then
		CreateTag()
		pcall(function()
			Obj.Health-=Damage
		end)
	end
	if Damage>0 then
		if Obj.Health==math.huge or Obj.MaxHealth==math.huge
			or tostring(Obj.Health):lower():find('nan') or tostring(Obj.MaxHealth):lower():find('nan')
			or Obj.Health < 0 or Obj.MaxHealth < 0
		then
			pcall(function()
				Obj.Health = 0
				Obj.MaxHealth = 0
				Obj:SetStateEnabled(Enum.HumanoidStateType.Dead,true)
				Obj:ChangeState(Enum.HumanoidStateType.Dead)
			end)
		end
		--[[ --<<== will be uncommented when kill effect is added
		swait()
		if Obj:GetState() == Enum.HumanoidStateType.Dead then
			spawn(KillEffect,CharModel)
		end
		]]
	end
end

OwnerHumanoid.MaxHealth = 2650
OwnerHumanoid.Health = OwnerHumanoid.MaxHealth

local truehp = OwnerHumanoid.Health
local function DoStuff(Target:Model,OriginPlayer:Player,ShieldBreak:boolean,Stats:{any},PlayHitSound:boolean,LifeSteal:{any},Type:string)
	if IsA(Target,'BasePart') then
		Target=FindFirstAncestorOfClass(Target,'Model')
	end
	if not Target or not FindFirstChildOfClass(Target,'Humanoid') then return end
	if Target and Players:GetPlayerFromCharacter(Target) then
		local TargetPlayer=Players:GetPlayerFromCharacter(Target)
		if TargetPlayer and FindFirstChild(TargetPlayer,'nopvp') then return end
	end
	local Hum=FindFirstChildOfClass(Target,'Humanoid')
	local RootPart=Hum.RootPart
	local ShieldAmount=0
	if PlayHitSound and Hum:GetState()~=Enum.HumanoidStateType.Dead then
		PlaySound(RootPart and RootPart.CFrame or Target:GetPivot(),7742895970,1,3)
	end
	if FindFirstChild(Target,'AlliedSummon') then return end

	if ShieldBreak then
		local ShieldAmount=0
		if FindFirstChild(Target,'ShieldForceField') then
			for x,l in next,GetChildren(Target) do
				if not l or not IsA(l,'ForceField') or l.Name~='ShieldForceField' then continue end
				pcall(game.Destroy,l)
				ShieldAmount+=1
			end
		end
		Stats.ExtraDMG*=ShieldAmount
	end
	Damage(Hum,Stats.BaseDamage,Stats.CritChance,OriginPlayer,Type or 'NormalTakeDamage',Stats)
	if LifeSteal and type(LifeSteal)=='table' and LifeSteal.Amount then
		local HealAmount = LifeSteal.Amount
		if HealAmount > 0 then
			HealAmount = -HealAmount
		end
		truehp -= HealAmount
		Damage(OwnerHumanoid,HealAmount,0,nil,'HealthSetDamage',{ExtraDMG=0,PhysicalPower=1,CritDamage=1})
	end
end

local lasthp = truehp
local lasthit = tick()

local shield = game:GetService("InsertService"):CreateMeshPartAsync("rbxassetid://4643937797", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
shield.Material = Enum.Material.ForceField
shield.Size = Vector3.one*8
shield.CanCollide = false
shield.CanQuery = false
shield.Massless = true
shield.Color = Color3.new(1,1,1)
shield.CastShadow = false

local s = Instance.new("Sound", shield)
s.Volume = 1
s.SoundId = "rbxassetid://1462066094"
s.Looped = true
s.Playing = true

local w = Instance.new("Weld", shield)
w.Part0 = shield
w.Part1 = OwnerCharacter.HumanoidRootPart

OwnerHumanoid.HealthChanged:Connect(function()
	task.defer(function()
		local damagetaken = lasthp - OwnerHumanoid.Health
		if(damagetaken <= 0)then
			lasthp = OwnerHumanoid.Health
			return
		end
		
		if(truehp > OwnerHumanoid.MaxHealth and damagetaken > (truehp - OwnerHumanoid.MaxHealth))then
			damagetaken = (truehp - OwnerHumanoid.MaxHealth)
		end
	
		truehp -= damagetaken
		OwnerHumanoid.Health = math.clamp(truehp, 0, OwnerHumanoid.MaxHealth)
		
		if(truehp > OwnerHumanoid.MaxHealth and tick() - lasthit >= .6)then
			local s = Instance.new("Sound", shield)
			s.Volume = 2
			s.SoundId = "rbxassetid://6276706377"
			s.PlayOnRemove = true
			s.Pitch = math.random(80, 120)/100
			s:Destroy()
			
			game:GetService("TweenService"):Create(shield, TweenInfo.new(.1, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0, true), {
				Color = Color3.new()
			}):Play()
			
			lasthit = tick()
		end
	
		lasthp = OwnerHumanoid.Health
	end)
end)


local shieldsizeadd = 0

local function comma_value(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)","%1,%2")
		if(k==0)then
			break
		end
	end
	return formatted
end

local animatingshield = false
local lastshieldstate = shield.Parent ~= nil
game:GetService("RunService").Heartbeat:Connect(function()
	truehp = math.clamp(truehp, 0, OwnerHumanoid.MaxHealth+1000)

	CombatUI.Health.HP.Size = UDim2.new(math.min(OwnerHumanoid.Health/OwnerHumanoid.MaxHealth, 1), -6*math.min(OwnerHumanoid.Health/OwnerHumanoid.MaxHealth, 1), 1, -6)
	CombatUI.Health.Shield.Size = UDim2.new(math.clamp((truehp - OwnerHumanoid.MaxHealth)/OwnerHumanoid.MaxHealth, 0, 1), -6 * (math.clamp((truehp - OwnerHumanoid.MaxHealth)/OwnerHumanoid.MaxHealth, 0, 1)), 1, -6)
	
	shield.Size = (Vector3.one*(8-.5*math.cos(tick()))) + (Vector3.one*shieldsizeadd)
	w.C0 = CFrame.Angles(math.rad((tick()*20)%360), math.rad((tick()*10)%360), math.rad((tick()*30)%360))
	
	if(truehp > OwnerHumanoid.MaxHealth)then
		CombatUI.Health.HealthText.Text = "("..comma_value(tostring(math.floor(truehp - OwnerHumanoid.MaxHealth)))..") "..comma_value(math.floor(OwnerHumanoid.Health)).." / "..comma_value(math.floor(OwnerHumanoid.MaxHealth))
		shield.Parent = OwnerCharacter
		
		if(not lastshieldstate)then
			animatingshield = true
			lastshieldstate = true
		
			shield.Transparency = 1
			game:GetService("TweenService"):Create(shield, TweenInfo.new(1, Enum.EasingStyle.Quint), {
				Transparency = 0
			}):Play()
			
			local va = Instance.new("NumberValue")
			va.Value = 2
			shieldsizeadd = va.Value
			va.Changed:Connect(function()
				shieldsizeadd = va.Value
			end)
			local tw = game:GetService("TweenService"):Create(va, TweenInfo.new(1, Enum.EasingStyle.Quint), {
				Value = 0
			})
			tw:Play()
			tw.Completed:Once(function()
				va:Destroy()
				animatingshield = false
			end)
		
			local s = Instance.new("Sound", shield)
			s.Volume = 2
			s.SoundId = "rbxassetid://4507963667"
			s.PlayOnRemove = true
			s:Destroy()
		end
	else
		CombatUI.Health.HealthText.Text = comma_value(math.floor(OwnerHumanoid.Health)).." / "..comma_value(math.floor(OwnerHumanoid.MaxHealth))
		
		if(lastshieldstate)then
			animatingshield = true
			lastshieldstate = false
			shield.Parent = OwnerCharacter
			
			shield.Transparency = 0
			game:GetService("TweenService"):Create(shield, TweenInfo.new(1, Enum.EasingStyle.Quint), {
				Transparency = 1
			}):Play()
			
			local va = Instance.new("NumberValue")
			va.Value = 0
			shieldsizeadd = va.Value
			va.Changed:Connect(function()
				shieldsizeadd = va.Value
			end)
			local tw = game:GetService("TweenService"):Create(va, TweenInfo.new(1, Enum.EasingStyle.Quint), {
				Value = 2
			})
			tw:Play()
			tw.Completed:Once(function()
				va:Destroy()
				animatingshield = false
				shield.Parent = nil
			end)
			
			local s = Instance.new("Sound", shield)
			s.Volume = 1
			s.TimePosition = .15
			s.SoundId = "rbxassetid://5927430998"
			s.PlayOnRemove = true
			s:Destroy()
		end
	end
	
	if(not animatingshield)then
		lastshieldstate = shield.Parent ~= nil
	end

	OwnerHumanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	OwnerHumanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
end)

local function Hitbox(CF:CFrame,Size:Vector3,MaxParts:number,IgnoreList:{Instance},Func:void)
	if typeof(CF)=='Vector3' then CF=CFrame.new(CF) end
	if typeof(CF)~='CFrame' then return error(`Expected CFrame got {typeof(CF)} at argument 1`) end
	if typeof(Size)~='Vector3' then return error(`Expected Vector3 got {typeof(Size)} at argument 1\2`) end
	local NewOverlap = OverlapParams.new()
	NewOverlap.FilterType = Enum.RaycastFilterType.Exclude
	NewOverlap.MaxParts = tonumber(MaxParts) or 250
	NewOverlap.RespectCanCollide = false
	NewOverlap.FilterDescendantsInstances = {unpack(IgnoreList),unpack(GetRRTIgnoreList())}
	local GotParts = GetPartBoundsInBox(workspace,CF,Size,NewOverlap)
	for x,Part in next,GotParts do
		local GotModel = FindFirstAncestorOfClass(Part,'Model')
		if not GotModel then continue end
		if GotModel == OwnerCharacter then continue end
		local GotHumanoid = FindFirstChildOfClass(GotModel,'Humanoid')
		if not GotHumanoid then continue end

		if Func and type(Func)=='function' then
			Func(GotModel,GotHumanoid)
		end
	end
end

local function UpdateStats() --<<== garbage code
	if not Running then return end
	local Power,Damage,CritChance,CritDmgMult,ExtraDMG,SwingRate =
		StatObjs.PhysicalPower,StatObjs.BaseDamage,StatObjs.CritChance,StatObjs.CritDamage,StatObjs.ExtraDMG,StatObjs.SwingRate
	local function ChangeStat(StatName,Value)
		if not OrigStats[StatName] or not CurrStats[StatName] then return end
		if not Value or not tonumber(Value) then Value = 0 end
		if tonumber(Value) and tonumber(Value) > OrigStats[StatName] then
			CurrStats[StatName] = tonumber(Value)
		else
			CurrStats[StatName] = OrigStats[StatName]
		end
	end
	ChangeStat('PhysicalPower',Power and Power.Value)
	ChangeStat('BaseDamage',Damage and Damage.Value)
	ChangeStat('CritChance',CritChance and CritChance.Value)
	ChangeStat('CritDamage',CritDmgMult and CritDmgMult.Value)
	ChangeStat('ExtraDMG',ExtraDMG and ExtraDMG.Value)
	ChangeStat('SwingRate',SwingRate and SwingRate.Value)
end

--<<== Stat Updating Funcs
local LightningParticle = Tool.Model.Lightning.Lightning
local function ChangeEternalStorm(Amount)
	if not tonumber(Amount) then Amount = 0 end
	ExtraStats.Eternal_Storm = clamp(ExtraStats.Eternal_Storm+Amount,0,math.huge)
	if ExtraStats.Eternal_Storm > 0 then
		LightningParticle.Enabled = true
	else
		LightningParticle.Enabled = false
	end
	
	CombatUI.Attacks.EternalStorm.Value.Text = ExtraStats.Eternal_Storm
end

local function AddSpeedBoost(Amount)
	if not tonumber(Amount) then Amount = 0 end
	local TempAmount = Amount
	ExtraStats.Speed_Boost = clamp(ExtraStats.Speed_Boost+Amount,0,1e6)
	local Clock = os.clock()
	local TempCon
	TempCon = Add(RunService.PreSimulation:Connect(function()
		if TempAmount <= 0 then pcall(TempCon.Disconnect,TempCon) TempCon=nil return end
		if os.clock() - Clock < .65 then return end
		Clock = os.clock()
		TempAmount -= 2
		ExtraStats.Speed_Boost = clamp(ExtraStats.Speed_Boost-2,0,1e6)
	end))
end

--<<== Slash Utilities & KeyFrameSequences
local SlashFlipbook = {
	Core={},
	Contrast = {
		"rbxassetid://14960930926",
		"rbxassetid://14960930836",
		"rbxassetid://14960930707",
		"rbxassetid://14960930600",
		"rbxassetid://14960930484",
		"rbxassetid://14960930341",
		"rbxassetid://14960930228",
		"rbxassetid://14960930009",
		"rbxassetid://14960929870",
		"rbxassetid://14960929784",
		"rbxassetid://14960929661",
		"rbxassetid://14960929511",
		"rbxassetid://14960929425",
		"rbxassetid://14960929294"
	},
	Contrast2 = {
		"rbxassetid://14960824401",
		"rbxassetid://14960831000",
		"rbxassetid://14960830883",
		"rbxassetid://14960830725",
		"rbxassetid://14960830595",
		"rbxassetid://14960830439",
		"rbxassetid://14960830326",
		"rbxassetid://14960830231",
		"rbxassetid://14960830159",
	}
}
local FlipbookFolder = Dependencies.Flipbook
for x=1,#GetChildren(FlipbookFolder) do
	SlashFlipbook.Core[x] = FlipbookFolder[tostring(x)].Texture
end

function Glowify(Color,Func)
	local New = Color3.fromRGB((Color.R*65)^2,(Color.G*65)^2,(Color.B*65)^2)
	return (Func or Color3.new)(New.R,New.G,New.B)
end

local SlashBase = IT('Part',nil,{Name='Slash',CastShadow=false,Transparency=1,Locked=true,Size=Vector3.zero,Anchored=true,CanCollide=false,CanTouch=false,CanQuery=false})
IT('SpecialMesh',SlashBase,{Name='SlashMesh',MeshType=Enum.MeshType.FileMesh,Scale=Vector3.new(7,3,7),MeshId='rbxassetid://6582567291'})
IT('Decal',SlashBase,{Name='Slash1',Color3=Color3.new(1,1,1),Transparency=0,ZIndex=2})
IT('Decal',SlashBase,{Name='Slash2',Color3=Color3.new(1,1,1),Transparency=0,ZIndex=1})
SlashBase = _Clone(SlashBase)

function PlayDecalFlipbook(Decal:Decal,FlipbookTable:{string},Duration:number)
	task.spawn(function()
		local ImageAmount = #FlipbookTable
		local Duration = Duration or .4
		if Duration < 0 then
			Duration = -Duration
		end

		local TValue = Instance.new('IntConstrainedValue')
		TValue.MinValue = 1
		TValue.MaxValue = ImageAmount
		TValue.Value = 1
		local NewTween = Tween(TValue,{Duration,Enum.EasingStyle.Circular,Enum.EasingDirection.Out},{Value=ImageAmount})
		local TempCon TempCon = Add(RunService.Heartbeat:Connect(function(Delta)
			if not IsAncestorOf(workspace,Decal) then 
				pcall(TempCon.Disconnect,TempCon)
				TempCon = nil
				return
			end
			if FlipbookTable[math.floor(TValue.Value)] then
				Decal.Texture = FlipbookTable[math.floor(TValue.Value)]
			end
		end))

		NewTween.Completed:Once(function()
			if TempCon then
				pcall(TempCon.Disconnect,TempCon)
				TempCon = nil
			end
			Decal.Texture = ''
		end)
		NewTween:Play()
	end)
end

function Slash(CF:CFrame,Rotate:CFrame,Duration:number,Scale:Vector3,Color:(Color3 & {Color3}),Transparency:(number & {number}),Flipbooks:({string} & FlipbookArg))
	assert(CF,'Missing argument 1')
	if typeof(CF)=='Vector3' then CF=CFrame.new(CF) end
	assert(typeof(CF)=='CFrame',`Expected CFrame got {typeof(CF)} at argument 1`)
	if type(Rotate)~='number' then Rotate=180 end
	if type(Duration)~='number' then Duration=.6 end
	if typeof(Scale)~='Vector3' then Scale=Vector3.new(7,7,7) end
	if type(Flipbooks)~='table' then Flipbooks=SlashFlipbook.Core end
	if Duration < 0 then
		Duration = -Duration
	end

	local Color1,Color2 = (type(Color)=='table' and Color.Color1~=nil and typeof(Color.Color1)=='Color3' and Color.Color1) or Color or Glowify(Color3.fromRGB(255,255,255)),
		(type(Color)=='table' and Color.Color2~=nil and typeof(Color.Color2)=='Color3' and Color.Color2) or Color or Glowify(Color3.fromRGB(255,255,255))
	local Transparency1,Transparency2 = (type(Transparency)=='table' and Transparency.Trans1~=nil and tonumber(Transparency.Trans1)) or Transparency or 0,
		(type(Transparency)=='table' and Transparency.Trans2~=nil and tonumber(Transparency.Trans2)) or Transparency or 0
	local FlipbookMain,FlipbookSub = (type(Flipbooks.Main)=='table' and Flipbooks.Main) or Flipbooks,
		(type(Flipbooks.Sub)=='table' and Flipbooks.Main) or Flipbooks

	local SlashPart = _Clone(SlashBase) --IT('Part',Effects(),{CastShadow=false,Transparency=1,Locked=true,Size=Vector3.zero,Anchored=true,CanCollide=false,CanTouch=false,CanQuery=false,CFrame=CF})
	local SlashMesh = SlashPart.SlashMesh--IT('SpecialMesh',SlashPart,{MeshType=Enum.MeshType.FileMesh,Scale=Scale,MeshId='rbxassetid://6582567291'})
	local SlashDecal1 = SlashPart.Slash1 --IT('Decal',SlashPart,{Color3=Color1,Transparency=Transparency1,ZIndex=2})
	local SlashDecal2 = SlashPart.Slash2 --IT('Decal',SlashPart,{Color3=Color2,Transparency=Transparency2,ZIndex=1})

	SlashPart.CFrame = CF
	SlashMesh.Scale = Scale
	SlashDecal1.Color3 = Color1
	SlashDecal1.Transparency =  Transparency1
	SlashDecal2.Color3 = Color2
	SlashDecal2.Transparency =  Transparency2
	SlashPart.Parent = workspace.Terrain

	local TValue = Instance.new('NumberValue')
	local NewTween = Tween(TValue,{Duration,Enum.EasingStyle.Circular,Enum.EasingDirection.Out},{Value=Rotate})
	local Diff = 0
	local TempCon TempCon = Add(RunService.Heartbeat:Connect(function(Delta)
		if not IsAncestorOf(workspace,SlashPart) then pcall(TempCon.Disconnect,TempCon)TempCon=nil return end
		local CFAngle = CFrame.Angles(0,math.rad(TValue.Value-Diff),0)
		SlashPart.CFrame = SlashPart.CFrame:Lerp(SlashPart.CFrame*(CFAngle-CFAngle.Position),1-(2e-16^Delta))
		Diff = TValue.Value
	end))
	local FlipbookSpeed = .125/(Rotate*Duration)*60
	if FlipbookSpeed < 0 then
		FlipbookSpeed = -FlipbookSpeed
	end
	--warn(`\n|FlipbookSpeed:{tostring(FlipbookSpeed)}\n|DefaultDelay:{tostring(DefaultDelay)}\n|Rotate:{tostring(Rotate)}\n|Duration:{tostring(Duration)}`)
	PlayDecalFlipbook(SlashDecal1,FlipbookMain,(FlipbookSpeed*#FlipbookMain)*Duration/1.375)
	PlayDecalFlipbook(SlashDecal2,FlipbookSub,(FlipbookSpeed*#FlipbookSub)*Duration/1.375)
	--warn(`\n|FlipbookSpeed*#FlipbookMain:{FlipbookSpeed*#FlipbookMain}\n|FlipbookSpeed*#FlipbookSub:{FlipbookSpeed*#FlipbookSub}`)
	NewTween.Completed:Once(function()
		if TempCon then
			pcall(TempCon.Disconnect,TempCon)
			TempCon=nil
		end
		Debris:AddItem(SlashPart,1+Duration)
		Debris:AddItem(TValue,1+Duration)
	end)
	NewTween:Play()
	Debris:AddItem(SlashPart,10)
	Debris:AddItem(TValue,10)
end

local IdleKF,Atk1KF,Atk2KF,SlamKF,
SpinKF,ReapKF,SowKF,SowFinishKF = Tool.HeavyMeleeIdle,Tool.Attack1,Tool.Attack2,
	Tool.RealityScytheSlam,Tool.RealityScytheSpin,
	Tool.RealityReap,Tool.RealitySowGlide,Tool.RealitySowGlideFinish

local Scale = Vector3.new(25,20,25)
local Combo = 1
local Combos = {
	--[1]
	{
		Rotation=260,
		Duration=.36,
		Anim='Attack1'
	},
	--[2]
	{
		Rotation=-320,
		Duration=.36,
		Anim='Attack2'
	}
}

--<<== Cooldowns
local M1Attacking,SkillAttacking = unpack(table.create(2,false))
local Cooldowns = {
	Fractured_World = {LastUseTime=0,CooldownTime=18},
	Reap_N_Sow = {LastUseTime=0,CooldownTime=15},
	Dance_of_Death = {LastUseTime=0,CooldownTime=6},
	RealityTear = {LastUseTime=0,CooldownTime=60}
}

game:GetService("RunService").Heartbeat:Connect(function()
	CombatUI.Attacks.DeathsDance.Cooldown.Size = UDim2.new(math.min(os.clock() - Cooldowns.Dance_of_Death.LastUseTime, Cooldowns.Dance_of_Death.CooldownTime)/Cooldowns.Dance_of_Death.CooldownTime, -6, 1, -6)
	CombatUI.Attacks.FracturedWorlds.Cooldown.Size = UDim2.new(math.min(os.clock() - Cooldowns.Fractured_World.LastUseTime, Cooldowns.Fractured_World.CooldownTime)/Cooldowns.Fractured_World.CooldownTime, -6, 1, -6)
	CombatUI.Attacks.ReapSow.Cooldown.Size = UDim2.new(math.min(os.clock() - Cooldowns.Reap_N_Sow.LastUseTime, Cooldowns.Reap_N_Sow.CooldownTime)/Cooldowns.Reap_N_Sow.CooldownTime, -6, 1, -6)
	CombatUI.Attacks.RealityTear.Cooldown.Size = UDim2.new(math.min(os.clock() - Cooldowns.RealityTear.LastUseTime, Cooldowns.RealityTear.CooldownTime)/Cooldowns.RealityTear.CooldownTime, -6, 1, -6)
end)

local BindedKeys = {}

--<<== Special Debuff Funcs
local function RealityFreeze(Target,Duration)
	if not Target or typeof(Target)~='Instance' then return end
	if type(Duration)~='number' or Duration <= 0 then Duration=4 end
	local Finished = false
	local TempCons,Tags,Frozen = {},{},{}
	local GotHumanoid

	local function Freeze(Obj)
		if not IsA(Obj,'BasePart') then return end
		local OriginCF = Obj.CFrame
		local LastAnchorProp = Obj.Anchored
		local freezecon
		local function evil(jjjj)if Finished or not IsAncestorOf(game,Obj) then return end if jjjj~='CFrame' and jjjj~='Position' and jjjj~='Rotation' and jjjj~='Orientation' and jjjj~='Anchored' then return end pcall(freezecon.Disconnect,freezecon)freezecon=nil Obj.CFrame=OriginCF Obj.Anchored=true freezecon=Add(Obj.Changed:Connect(evil))tabinsert(TempCons,freezecon)end
		Obj.Anchored = true
		freezecon=Add(Obj.Changed:Connect(evil))
		tabinsert(TempCons,freezecon)
		tabinsert(Frozen,{Object=Obj,LastAnchor=LastAnchorProp})
	end

	if IsA(Target,'Model') then
		GotHumanoid = FindFirstChildOfClass(Target,'Humanoid')
	end
	for x,l in next,GetDescendants(Target) do
		if not IsA(l,'BasePart') then continue end
		spawn(Freeze,l)
	end
	if GotHumanoid then
		local TSTag=Instance.new('BoolValue')
		TSTag.Name='TimeStopped'TSTag.Value=true TSTag.Parent=Target
		tabinsert(Tags,TSTag)
		local RDTag=Instance.new('BoolValue')
		RDTag.Name='RealityDissociation'RDTag.Value=true RDTag.Parent=Target
		tabinsert(Tags,RDTag)
	end 
	local StartTime = os.clock()
	repeat swait() until os.clock() - StartTime >= Duration
	Finished = true
	spawn(function()
		for x,l in next,TempCons do pcall(l.Disconnect,l)end
		for x,l in next,Tags do pcall(game.Destroy,l)end
		for x,l in next,Frozen do pcall(function()l.Object.Anchored=l.LastAnchor end)end
		tabclear(Frozen)
		Frozen = nil
	end)
end

--<<== Skill Funcs
local ParticleAtt = Tool.Model.Neon.Particles
function Fractured_World()
	if not OwnerHumanoid or not OwnerHumanoid.RootPart then return end
	local Cooldown = Cooldowns.Fractured_World
	if os.clock()-Cooldown.LastUseTime<Cooldown.CooldownTime then return end
	if SkillAttacking then return end
	SkillAttacking = true
	Cooldown.LastUseTime = os.clock()
	local StatsClone:WeaponStats = tabclone(CurrStats)
	StatsClone.BaseDamage = math.floor(StatsClone.BaseDamage*4.2) --2.6253 --17500
	local OwnerRoot = OwnerHumanoid.RootPart
	local RootPos = OwnerRoot.Position
	PlaySound(RootPos,15629641334,.75,6,40) --<<== bcw fractured world sfx
	PlaySound(RootPos,3744393124,1,4.5,80)
	PlaySound(RootPos,1837829231,1,3,50)
	PlaySound(RootPos,1146693387,.7,3,50)
	PlaySound(RootPos,1837829551,1.2,3,50)
	PlaySound(RootPos,3848675626,.8,10,60)
	PlaySound(RootPos,1837829764,.8,3,50)
	PlaySound(RootPos,6614332950,.8,7,50)
	PlaySound(RootPos,5862482798,.8,7,50)
	PlayAnim('RealityScytheSlam',.93)
	spawn(function()
		local ChargeDrainVFX,ChargeAuraVFX = _Clone(Assets.Drain),_Clone(Assets.Aura)
		ChargeDrainVFX.Parent,ChargeAuraVFX.Parent = unpack(tabcreate(2,ParticleAtt))
		ChargeDrainVFX.Enabled,ChargeAuraVFX.Enabled = unpack(tabcreate(2,true))
		ChargeDrainVFX:Emit(5)ChargeAuraVFX:Emit(5)
		swait(1.112*60)
		ChargeDrainVFX.Enabled,ChargeAuraVFX.Enabled = unpack(tabcreate(2,false))
		Debris:AddItem(ChargeDrainVFX,4)Debris:AddItem(ChargeAuraVFX,4)
	end)
	--wait(1.3228)
	swait(1.3228*60)
	local RootCF = OwnerRoot.CFrame
	local RootPos = RootCF.Position
	PlaySound(RootPos,1577567682,1,10,125)
	PlaySound(RootPos,7626312849,RandNextNum(.4,.8),10,100)
	PlaySound(RootPos,9040327184,1,6,50)
	PlaySound(RootPos,4299587893,RandNextNum(.7,1),6,50)
	PlaySound(RootPos,1837829764,RandNextNum(.5,6),6,50)
	PlaySound(RootPos,5540424854,.8,8,50)
	PlaySound(RootPos,1837829387,1,5,50)
	PlaySound(RootPos,282061033,.95,5,50)
	PlaySound(RootPos,2770705979,.85,3,50)
	PlaySound(RootPos,1835331582,.85,5,50)
	PlaySound(RootPos,1837829467,1.1,5,50)
	PlaySound(RootPos,1837829473,1.1,5,50)
	PlaySound(RootPos,1837829443,1.1,5,70)
	PlaySound(RootPos,1843492075,1,5,50,1)
	PlaySound(RootPos,4655402979,.875,4,50,14.339)
	--game:GetService("RunService").Stepped:Wait()
	--PlaySound(testpart.CFrame,1837829843,.8,10,60)
	spawn(function()
		for x=0,60,1 do
			local FromCF = CFrame.new(RootPos-Vector3.new(0,-2.85,0))
			local RandAngle1,RandAngle2,RandAngle3=math.random(-360,360),math.random(-360,360),math.random(-360,360)
			local RandSize=math.random(10)/50
			TweenEffect({Anchored=true,CanCollide=false,CanQuery=false,CanTouch=false,Size=Vector3.new(),CFrame=FromCF*CFrame.Angles(math.rad(RandAngle1),math.rad(RandAngle2),math.rad(RandAngle3)),Transparency=.011,Material='Glass',CastShadow=false},
			{MeshType='FileMesh',MeshId='rbxassetid://643098245',TextureId='rbxassetid://643064975',Scale=Vector3.new(0,0,0),VertexColor=Vector3.new(10,10,10)},
			{ --<<== Tween Frames
				{ --<<== Frame 1
					EndPart={ --<<== Tween End Part Properties 
						CFrame=FromCF*CFrame.Angles(math.rad(RandAngle3),math.rad(RandAngle2),math.rad(RandAngle1)),
						Transparency=1
					}, 
					EndMesh={--<<== Tween End Mesh Properties
						Scale=Vector3.new(5+RandSize,0,5+RandSize)
					},
					MeshTweenInfo=TweenInfo.new(1.8,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0),
					PartTweenInfo=TweenInfo.new(1.3,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut,0,false,0),
					Shake={Origin=FromCF.Position,MaxDist=3072,Amount=15,Power=3.5}
				},
			}
			)
			TweenEffect({Anchored=true,CanCollide=false,CanQuery=false,CanTouch=false,Size=Vector3.new(),CFrame=FromCF*CFrame.Angles(math.rad(RandAngle1),math.rad(RandAngle2),math.rad(RandAngle3)),Transparency=.011,Material='Glass',CastShadow=false},
			{MeshType='FileMesh',MeshId='rbxassetid://643098245',TextureId='rbxassetid://9573351641',Scale=Vector3.new(0,0,0),VertexColor=Vector3.new(10,10,10)},
			{ --<<== Tween Frames
				{ --<<== Frame 1
					EndPart={ --<<== Tween End Part Properties 
						CFrame=FromCF*CFrame.Angles(math.rad(RandAngle3),math.rad(RandAngle2),math.rad(RandAngle1)),
						Transparency=1
					}, 
					EndMesh={--<<== Tween End Mesh Properties
						Scale=Vector3.new(2.5+RandSize,0,2.5+RandSize)
					},
					MeshTweenInfo=TweenInfo.new(1.8,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0),
					PartTweenInfo=TweenInfo.new(1.3,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut,0,false,0),
				},
			}
			)
		end
	end)
	spawn(function()
		for x=1,25 do
			local RandSize=math.random(20)/50
			TweenEffect({Anchored=true,CanCollide=false,CanQuery=false,CanTouch=false,Size=Vector3.new(),CFrame=CFrame.new(RootPos-Vector3.new(0,-2.85,0))*CFrame.Angles(math.rad(math.random(-25,25)),math.rad(math.random(-360,360)),math.rad(math.random(-25,25))),Transparency=.4,Material='Glass',CastShadow=false},
			{MeshType='FileMesh',MeshId='rbxassetid://643098245',TextureId='rbxassetid://643064975',Scale=Vector3.new(0,0,0),VertexColor=Vector3.new(1,1,1)},
			{ --<<== Tween Frames
				{ --<<== Frame 1
					EndPart={ --<<== Tween End Part Properties 
						Transparency=1
					}, 
					EndMesh={--<<== Tween End Mesh Properties
						Scale=Vector3.new(12.5+RandSize,0,12.5+RandSize)
					},
					MeshTweenInfo=TweenInfo.new(3,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0),
					PartTweenInfo=TweenInfo.new(1.4,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut,0,false,0),
				},
			}
			)
		end
	end)
	WarpEffect(1,CFrame.new(RootPos),Vector3.new(80,0,80),900,Vector3.new(600,1048,600)*2.5,{1.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut})
	local FracturedWorldDomain:WorldModel = _Clone(Assets.EquinoxSlicerDomain)
	local OuterShell,InnerShell = FracturedWorldDomain.Black,FracturedWorldDomain.Effect
	local Floor,FloorBlack = _Clone(Assets.floor),_Clone(OuterShell)
	local Ring = _Clone(Assets.RingMesh)
	local Wave,WindSwirl,WindSwirl2 = _Clone(Assets.Wave2),_Clone(Assets.Swirl),_Clone(Assets.Winds)
	local DarkVFX,FlashVFX,SmokeVFX = _Clone(Assets.darkness),_Clone(Assets.Flash),_Clone(Assets.Smoke)
	FracturedWorldDomain:PivotTo(CFrame.new(RootPos))
	FracturedWorldDomain.Name = `FracturedWorld_{Owner.Name}`
	OuterShell.CanCollide,OuterShell.CanTouch,OuterShell.CanQuery,OuterShell.Anchored,OuterShell.Locked=false,false,false,true,true
	InnerShell.CanCollide,InnerShell.CanTouch,InnerShell.CanQuery,InnerShell.Anchored,InnerShell.Locked=false,false,false,true,true
	OuterShell.Size = Vector3.new(25, 105, 25)
	InnerShell.Size = OuterShell.Size-Vector3.new(1,1,1)
	Floor.CFrame = CFrame.new(RootPos)*CFrame.new(0,-2.85,0)
	Floor.Size = OuterShell.Size*Vector3.new(1,0,1)
	Floor.Parent = FracturedWorldDomain
	FloorBlack.CFrame = Floor.CFrame*CFrame.new(0,-0.001,0)
	FloorBlack.Size = Floor.Size
	FloorBlack.Parent = FracturedWorldDomain

	InnerShell.Color = Color3.new(0,0,0)
	OuterShell.Color = Color3.new(1,1,1)
	Floor.Color = Color3.new(0,0,0)
	FloorBlack.Color = Color3.new(1,1,1)

	Ring.CFrame = CFrame.new(RootPos)*CFrame.Angles(math.rad(90),0,0)
	Ring.Size = Vector3.new(OuterShell.Size.X*1.4,OuterShell.Size.Z*1.4,OuterShell.Size.Y/4.2)
	Ring.Parent = FracturedWorldDomain

	FracturedWorldDomain.Parent = workspace.Terrain
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	spawn(function()
		for x=1,5 do
			spawn(function()
				local Size = 15*x
				local WaveClone = _Clone(Wave) 
				ChangeProps(WaveClone,{Size=Vector3.zero,CFrame=RootCF*CFrame.new(0,30,0),Color=Color3.new(1,1,1),Parent=FracturedWorldDomain})
				Debris:AddItem(WaveClone,5)
				CRTween(WaveClone,{.075,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut},{Size=Vector3.new(8,10,8)*Size,CFrame=RootCF*CFrame.new(0,30,0)*CFrame.new(0,(10*Size)/2,0)},function()
					for x2,l in next,GetChildren(WaveClone) do
						if not l:IsA'Decal' then continue end
						pcall(function()
							CRTween(l,{3,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out},{Transparency=1}):Play()
						end)
					end
					CRTween(WaveClone,{3,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out},{Size=Vector3.new(35,1,35)*Size,CFrame=WaveClone.CFrame*CFrame.new(0,-WaveClone.Size.y/2,0)*CFrame.fromOrientation(0,math.rad(Rand(-180,180)),0),Color=Color3.new(0.972549, 0.972549, 0.972549)},function()
						pcall(game.Destroy,WaveClone)
					end)
				end)
			end)
		end
	end)
	local TempParticlePart = IT('Part',FracturedWorldDomain,{Size=Vector3.new(2048,0,2048),Anchored=true,CanCollide=false,CanTouch=false,CanQuery=false,Transparency=1,CFrame=CFrame.new(RootPos)*CFrame.new(0,-2.85,0)})
	local DarkAtt = IT('Attachment',workspace.Terrain,{WorldCFrame=TempParticlePart.CFrame})
	local DarkClone1 = _Clone(DarkVFX) ChangeProps(DarkClone1,{Lifetime=NumberRange.new(.3,.55),Parent=DarkAtt})
	local DarkClone2,FlashClone = _Clone(DarkVFX),_Clone(FlashVFX) DarkClone2.Parent,FlashClone.Parent = unpack(tabcreate(2,DarkAtt))
	DarkClone1:Emit(90) DarkClone2:Emit(50) FlashClone:Emit(50)
	Debris:AddItem(DarkAtt,2) Debris:AddItem(TempParticlePart,2)
	spawn(function()
		local GotPart,GotCF,NormalCF = FindPartOnRayWithIgnoreList(Ray.new((RootCF*CFrame.new(0,1,-1).Position),Vector3.new(0,-10,0)),{unpack(GetRRTIgnoreList()),FracturedWorldDomain},'evil',true)
		if GotPart then
			local GroudCrack = IT('Part',FracturedWorldDomain,{Size=Vector3.new(400,0,400),Anchored=true,CanCollide=false,CanTouch=false,CanQuery=false,Transparency=1})
			Debris:AddItem(GroudCrack,25)
			local SmokeClone1,SmokeClone2 = _Clone(SmokeVFX),_Clone(SmokeVFX)
			SmokeClone1.Enabled,SmokeClone2.Enabled = unpack(tabcreate(2,true))
			delay(6,function()SmokeClone1.Enabled,SmokeClone2.Enabled = unpack(tabcreate(2,false))end)
			GroudCrack.CFrame=CFrame.new(GotCF)*CFrame.Angles(0,Rand(-180,180),0)
			local Decal1 = IT('Decal',GroudCrack,{Texture='rbxassetid://9544311121',Face=Enum.NormalId.Top,Color3=Color3.fromRGB(2599,2599,2599)})
			local Decal2 = IT('Decal',GroudCrack,{Texture='rbxassetid://12363856104',Face=Enum.NormalId.Top,Color3=Color3.fromRGB(2550,2550,2550),ZIndex=2})
			local Decal3 = IT('Decal',GroudCrack,{Texture='rbxassetid://11189079998',Face=Enum.NormalId.Top,Color3=Color3.fromRGB(460,460,460),ZIndex=3})
			for x,l in next,{Decal1,Decal2,Decal3} do
				spawn(function()
					CRTween(l,{.6,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut},{Transparency=-2,Color3=(l==Decal3 and l.Color3) or Color3.new()},function()
						CRTween(l,{4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,5},{Transparency=1},function()
							Debris:AddItem(GroudCrack,12)
						end)
					end)
				end)
			end
		end
	end)
	spawn(function()
		ChangeProps(WindSwirl,{Transparency=-2,Size=Vector3.new(1225,0,1225),CFrame=RootCF*CFrame.new(0,400,0),Parent=FracturedWorldDomain})
		Debris:AddItem(WindSwirl,8)
		for x,l in next,GetChildren(WindSwirl) do
			if not l:IsA'Decal' then continue end
			pcall(function()
				CRTween(l,{4,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out},{Transparency=1})
			end)
		end
		local CFAngle = CFrame.Angles(0,math.rad(-Rand(560,1260)),0)
		CRTween(WindSwirl,{5,Enum.EasingStyle.Quart,Enum.EasingDirection.Out},{Size=Vector3.new(325,2048,325),Transparency=1,CFrame=(WindSwirl.CFrame*CFrame.new(0,200,0))*(CFAngle-CFAngle.Position)},function()
			Debris:AddItem(WindSwirl,5)
		end)
	end)
	for x=1,4 do
		spawn(function()
			local WindSwirl2Clone = _Clone(WindSwirl2)
			ChangeProps(WindSwirl2Clone,{Anchored=true,CFrame=(RootCF*CFrame.new(0,100,0)),Size=Vector3.new(800, 750, 800),Parent=FracturedWorldDomain})
			Debris:AddItem(WindSwirl2Clone,8)
			for x,l in next,GetChildren(WindSwirl2Clone) do
				if not l:IsA'Decal' then continue end
				pcall(function()
					CRTween(l,{4,Enum.EasingStyle.Circular,Enum.EasingDirection.Out},{Transparency=1})
				end)
			end
			local CFAngle = CFrame.Angles(0,math.rad(Rand(160,860)),0)
			CRTween(WindSwirl2Clone,{4,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out},{Size=Vector3.new(1600,2048,1600),CFrame=(WindSwirl2Clone.CFrame*CFrame.new(0,300,0))*(CFAngle-CFAngle.Position)},function()
				Debris:AddItem(WindSwirl2Clone,5)
			end)
		end)
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local Ang = CFrame.Angles(0,math.rad(-190),0)
	local AlreadyHit = {}
	local TempCon TempCon = Add(OuterShell:GetPropertyChangedSignal('Size'):Connect(function()
		spawn(function()
			Hitbox(OuterShell.CFrame,OuterShell.Size,750,{FracturedWorldDomain},function(GotModel,GotHumanoid)
				if not GotModel or tabfind(AlreadyHit,GotModel) then return end
				local StatsClone2:WeaponStats = tabclone(StatsClone)
				local TargMaxHP,TargCurrHP = GotHumanoid.MaxHealth,GotHumanoid.Health
				--<<== (BaseValue-CurrValue)/BaseValue
				local MissingPercent = clamp((TargMaxHP-TargCurrHP)/TargMaxHP,.333333333333333333,1)
				StatsClone2.ExtraDMG = (StatsClone2.BaseDamage*2)*(3*MissingPercent)

				tabinsert(AlreadyHit,GotModel)
				if GotHumanoid:GetState()~=Enum.HumanoidStateType.Dead then
					spawn(DoStuff,GotModel,Owner,true,StatsClone2,false,nil,'HealthSetDamage')
					spawn(RealityFreeze,GotModel,4)
				end
			end)
		end)
	end))
	local TempCon2 TempCon2 = Add(Ring:GetPropertyChangedSignal('Size'):Connect(function()
		spawn(function()
			Hitbox(Ring.CFrame,Ring.Size,750,{FracturedWorldDomain},function(GotModel,GotHumanoid)
				if not GotModel or tabfind(AlreadyHit,GotModel) then return end
				local StatsClone2:WeaponStats = tabclone(StatsClone)
				local TargMaxHP,TargCurrHP = GotHumanoid.MaxHealth,GotHumanoid.Health
				--<<== (BaseValue-CurrValue)/BaseValue
				local MissingPercent = clamp((TargMaxHP-TargCurrHP)/TargMaxHP,.333333333333333333,1)
				StatsClone2.ExtraDMG = (StatsClone2.BaseDamage*1.5)*(3*MissingPercent)

				tabinsert(AlreadyHit,GotModel)
				if GotHumanoid:GetState()~=Enum.HumanoidStateType.Dead then
					spawn(DoStuff,GotModel,Owner,true,StatsClone2,false,nil,'HealthSetDamage')
					spawn(RealityFreeze,GotModel,4)
				end
			end)
		end)
	end))
	CRTween(OuterShell,{1.463,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out},{Size=OuterShell.Size*25},function()
		pcall(TempCon.Disconnect,TempCon)
		TempCon=nil
	end)
	CRTween(InnerShell,{1.463,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out},{Size=InnerShell.Size*25})
	CRTween(Floor,{1.663,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out},{Size=(Floor.Size*25)*Vector3.new(1,0,1)})
	CRTween(FloorBlack,{1.663,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out},{Size=(FloorBlack.Size*25)*Vector3.new(1,0,1)})
	CRTween(Ring,{.877,Enum.EasingStyle.Quart,Enum.EasingDirection.Out},{Size=Ring.Size*Vector3.new(35,35,20)},function()
		pcall(TempCon2.Disconnect,TempCon2)
		TempCon2=nil
	end)
	CRTween(OuterShell,{3.7,Enum.EasingStyle.Circular,Enum.EasingDirection.Out},{CFrame=OuterShell.CFrame*(Ang-Ang.Position)})
	CRTween(InnerShell,{3.7,Enum.EasingStyle.Circular,Enum.EasingDirection.Out},{CFrame=InnerShell.CFrame*(Ang-Ang.Position)})
	CRTween(Floor,{3.7,Enum.EasingStyle.Circular,Enum.EasingDirection.Out},{CFrame=Floor.CFrame*(Ang-Ang.Position)})
	CRTween(OuterShell,{3.452,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,.8},{Transparency=1})
	CRTween(InnerShell,{3.452,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,.8},{Transparency=1})
	CRTween(Floor,{3.452,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,.8},{Transparency=1})
	CRTween(FloorBlack,{3.452,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,.8},{Transparency=1})
	CRTween(Ring,{1.138,Enum.EasingStyle.Quart,Enum.EasingDirection.Out,0,false,.165},{Transparency=1})

	CRTween(InnerShell,{4.8,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,1.3},{Color=Color3.new(1,1,1)})
	CRTween(OuterShell,{4.8,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,1.3},{Color=Color3.new(0,0,0)})
	CRTween(Floor,{4.8,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,1.3},{Color=Color3.new(1,1,1)})
	CRTween(FloorBlack,{4.8,Enum.EasingStyle.Circular,Enum.EasingDirection.Out,0,false,1.3},{Color=Color3.new(0,0,0)})
	ChangeEternalStorm(6)
	Debris:AddItem(FracturedWorldDomain,20)
	SkillAttacking = false
end

local ReapSowTable = {Target=nil,Highlight=nil}
local HighlightBase = IT('Highlight',nil,{FillColor=Color3.new(0,0,0),OutlineColor=Color3.new(1,1,1),Name='EquinoxSowMark'})
local RingParticle = Tool.Model.Neon.Particles.Ring
function Reap_N_Sow()
	if not OwnerHumanoid or not OwnerHumanoid.RootPart then return end
	local Cooldown = Cooldowns.Reap_N_Sow
	if os.clock()-Cooldown.LastUseTime<Cooldown.CooldownTime and not ReapSowTable.Target then return end
	if SkillAttacking then return end
	SkillAttacking = true
	if not ReapSowTable.Target then
		Cooldown.LastUseTime = os.clock()
	end

	local function Reap()
		PlayAnim('RealityReap')
		swait(.55*60)
		PlaySound(OwnerCharacter and OwnerCharacter:GetPivot() or FindFirstChild(Tool,'Handle') and Tool.Handle.CFrame,5989945551,1,2,15)
		PlaySound(OwnerCharacter and OwnerCharacter:GetPivot() or FindFirstChild(Tool,'Handle') and Tool.Handle.CFrame,231917758,.6,2,15)
		ChangeEternalStorm(3)
		local StatsClone:WeaponStats = tabclone(CurrStats)
		StatsClone.BaseDamage = math.floor(StatsClone.BaseDamage/2.222)

		local MouseHitPos = Mouse.Hit.Position
		local OwnerRoot = OwnerHumanoid.RootPart
		local RootPos = OwnerRoot.CFrame
		local FromCF = CFrame.lookAt(RootPos.Position,MouseHitPos)*CFrame.new(0,0,-3)*CFrame.Angles(math.rad(90),0,0)
		spawn(function()
			for x=1,6 do
				local RandSize=math.random(10)/50
				TweenEffect({Anchored=true,CanCollide=false,CanQuery=false,CanTouch=false,Size=Vector3.new(),CFrame=FromCF,Transparency=.011,Material='Glass',CastShadow=false},
				{MeshType='FileMesh',MeshId='rbxassetid://643098245',TextureId='rbxassetid://643064975',Scale=Vector3.new(.2,0,.2),VertexColor=Vector3.new(10,10,10)},
				{ --<<== Tween Frames
					{ --<<== Frame 1
						EndPart={ --<<== Tween End Part Properties 
							CFrame=FromCF*CFrame.Angles(0,math.rad(RandNextNum(-180,180)),0),
							Transparency=1
						}, 
						EndMesh={--<<== Tween End Mesh Properties
							Scale=Vector3.new(RandNextNum(.1,.4,10)+RandSize,.7,RandNextNum(.1,.4,10)+RandSize),
							VertexColor=Vector3.zero
						},
						MeshTweenInfo=TweenInfo.new(math.random(40,160)/30,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0),
						PartTweenInfo=TweenInfo.new(math.random(40,160)/50,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut,0,false,0),
						Shake=FromCF.Position
					},
				}
				)
			end
		end)

		local SlashClone = _Clone(Assets.ForwardSlash)
		SlashClone.Name = `ForwardSlash_{Owner.Name}`
		SlashClone.CFrame = OwnerCharacter:GetPivot()
		SlashClone.CFrame = CFrame.lookAt(SlashClone.Position,MouseHitPos)
		SlashClone.Anchored = true
		SlashClone.Parent = OwnerCharacter

		local ParticleAtt:Attachment = FindFirstChildOfClass(SlashClone,'Attachment')
		local Particle:Particle = FindFirstChildOfClass(ParticleAtt,'ParticleEmitter')

		local UnitDir = (MouseHitPos - SlashClone.Position).Unit
		local ProjVel = UnitDir*6
		local ProjPos = SlashClone.Position

		local BreakLoop = false

		local AlreadyHit = {}
		task.spawn(function()repeat swait() --<<== screw delta time
				ProjPos += ProjVel
				SlashClone.CFrame = CFrame.lookAt(ProjPos,ProjPos+ProjVel)
				if BreakLoop then 
					if Particle then Particle.Enabled = false end 
					ProjPos += ProjVel
					SlashClone.CFrame = CFrame.lookAt(ProjPos,ProjPos+ProjVel)
					break
				end
				task.spawn(Hitbox,SlashClone.CFrame,SlashClone.Size,325,{SlashClone},function(GotModel,GotHumanoid)
					task.spawn(function()
						if ReapSowTable.Target and IsAncestorOf(workspace,ReapSowTable.Target) then BreakLoop=true return end
						if tabfind(AlreadyHit,GotModel) then return end

						local TargetDead = false
						tabinsert(AlreadyHit,GotModel)
						DoStuff(GotModel,Owner,false,StatsClone,false)
						swait(15)
						for x=0,3 do
							if GotHumanoid:GetState() == Enum.HumanoidStateType.Dead then TargetDead=true return end
						end	
						if TargetDead then return end
						if not ReapSowTable.Target or not IsAncestorOf(workspace,ReapSowTable.Target) then
							ReapSowTable.Target = GotModel

							local MarkHighlight = _Clone(HighlightBase)
							MarkHighlight.Name = `EquinoxSowMark_{Owner.Name}`	
							MarkHighlight.FillTransparency = 0
							MarkHighlight.Adornee = GotModel
							ReapSowTable.Highlight = MarkHighlight
							MarkHighlight.Parent = workspace.Terrain
							CRTween(MarkHighlight,{.98332},{FillTransparency=.5})
							Debris:AddItem(MarkHighlight,20)	
							if Particle then Particle.Enabled = false end
							Debris:AddItem(SlashClone,2)
							BreakLoop = true
							swait(12)
							if type(AlreadyHit)=='table' then tabclear(AlreadyHit) end
							AlreadyHit = nil
						end			
					end)
				end)
			until BreakLoop or (ReapSowTable.Target and IsAncestorOf(workspace,ReapSowTable.Target))end)

		delay(30,function()
			if Particle and Particle.Enabled then
				Particle.Enabled = false
			end
			Debris:AddItem(SlashClone,2)
			BreakLoop = true
		end)

		Debris:AddItem(SlashClone,35)
	end

	local function Sow()
		PlayAnim('RealitySowGlide')
		local StatsClone:WeaponStats = tabclone(CurrStats)
		StatsClone.BaseDamage = math.floor(StatsClone.BaseDamage*3.7503751)

		local Target = ReapSowTable.Target
		local TargetRoot = FindFirstChild(Target,'Torso') or FindFirstChild(Target,'Head') or FindFirstChild(Target,'HumanoidRootPart')
		local TargetHumanoid = FindFirstChildOfClass(Target,'Humanoid')

		if not TargetHumanoid or not TargetRoot then
			if ReapSowTable.Target then
				ReapSowTable.Target = nil
			end
			pcall(game.Destroy,ReapSowTable.Highlight)
			ReapSowTable.Highlight = nil
			return
		end

		local SavedTransparency={}
		local OwnerRoot=OwnerHumanoid.RootPart
		local RootPos=OwnerRoot.CFrame
		for x,l in next,GetDescendants(OwnerCharacter)do
			if not IsA(l,'BasePart') and not IsA(l,'Decal') then continue end
			if l.Transparency >= 1 then continue end
			tabinsert(SavedTransparency,{Part=l,LastTransparency=l.Transparency})
		end
		PlaySound(RootPos,289315275,1,10,25)
		local function Warp(Pos)
			local Shock1,Shock2=_Clone(Assets.Shock1),_Clone(Assets.Shock2)
			local Whirlwind=_Clone(Assets.whirlwind)
			Shock1.Size,Shock2.Size=Vector3.new(14.363,.716,15.393),Vector3.new(25.131,1.407,26.965)
			Whirlwind.Size=Vector3.new(12.23,10.845,11.42)
			Shock1.Locked,Shock2.Locked,Whirlwind.Locked=true,true,true
			Shock1.CFrame=CFrame.new(Pos.Position)*CFrame.new(0,-2.05,0)
			Shock2.CFrame=Shock1.CFrame
			Whirlwind.CFrame=CFrame.new(Pos.Position)*CFrame.new(0,2.25,0)
			Shock1.Parent,Shock2.Parent,Whirlwind.Parent=unpack(tabcreate(3,workspace.Terrain))
			local Ang1,Ang2,Ang3=CFrame.Angles(0,math.rad(-180),0),CFrame.Angles(0,math.rad(180),0),CFrame.Angles(0,math.rad(220),0)
			CRTween(Shock1,{1.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Size=Shock1.Size*2})
			CRTween(Shock2,{1.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Size=Shock2.Size*2})
			CRTween(Shock1,{.9,Enum.EasingStyle.Quint,Enum.EasingDirection.Out},{CFrame=Shock1.CFrame*(Ang1-Ang1.Position)})
			CRTween(Shock2,{.9,Enum.EasingStyle.Quint,Enum.EasingDirection.Out},{CFrame=Shock2.CFrame*(Ang2-Ang2.Position)})
			CRTween(Shock1,{.7,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Transparency=1})
			CRTween(Shock2,{.7,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Transparency=1})
			CRTween(Whirlwind,{1.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Size=Whirlwind.Size*Vector3.new(0.5,3,0.5)})
			CRTween(Whirlwind,{2,Enum.EasingStyle.Quint,Enum.EasingDirection.Out},{CFrame=Whirlwind.CFrame*(Ang3-Ang3.Position)})
			CRTween(Whirlwind,{.7,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Transparency=1})
		end
		OwnerRoot.Anchored = true
		OwnerRoot.Velocity = Vector3.zero
		PlayAnim('RealitySowGlide')
		swait(.35*60)
		Warp(RootPos)
		PlaySound(RootPos,6290067239,2,3,25,0,{ChorusSoundEffect={}})
		for x,l in next,SavedTransparency do
			l.Part.Transparency=1
		end
		swait(.45*60)
		OwnerCharacter:PivotTo(Target:GetPivot()*CFrame.new(0,2.45,2.45))
		OwnerRoot.CFrame = CFrame.lookAt(OwnerRoot.Position,TargetRoot.Position)
		ToolRemote:FireClient(owner, "UpdatePosition", OwnerRoot.CFrame)
		Warp(RootPos)
		PlaySound(RootPos,6290067239,2,3,25,0,{ChorusSoundEffect={}})
		for x,l in next,SavedTransparency do
			l.Part.Transparency=l.LastTransparency
		end
		tabclear(SavedTransparency)
		SavedTransparency = nil
		swait(.25*60)
		StopAnim('RealitySowGlide')

		local TargMaxHP,TargCurrHP = TargetHumanoid.MaxHealth,TargetHumanoid.Health
		--<<== (BaseValue-CurrValue)/BaseValue
		local MissingPercent = clamp((TargMaxHP-TargCurrHP)/TargMaxHP,0,1)
		StatsClone.ExtraDMG = StatsClone.BaseDamage*(5*MissingPercent)
		PlayAnim('RealitySowGlideFinish')
		Slash(OwnerRoot.CFrame,-320,.36,Scale,{Color1=Color3.new(0,0,0),Color2=Color3.fromRGB(5000,5000,5000)},{Trans1=.2,Trans2=-5000000}, {Main=SlashFlipbook.Contrast,Sub=SlashFlipbook.Contrast2})
		DoStuff(Target,Owner,true,StatsClone,false,nil,'HealthSetDamage')
		ReapSowTable.Target = nil
		if ReapSowTable.Highlight then
			local ok = ReapSowTable.Highlight
			ReapSowTable.Highlight = nil
			CRTween(ok,{1.6},{FillTransparency=1,OutlineTransparency=1},function()
				ok.Enabled = false
				ok.Adornee = nil
				ok.Parent = nil
				Debris:AddItem(ok,0)
			end)
		end
		RingParticle:Emit(1)

		local FromCF = TargetRoot.CFrame
		local TargetDied = false

		for x=0,2 do
			if TargetHumanoid:GetState() == Enum.HumanoidStateType.Dead then TargetDied=true break end
		end

		PlaySound(FromCF,1837079122,1,8,40)
		PlaySound(FromCF,1837829133,1,8,40)
		PlaySound(FromCF,1837829368,1,8,40)
		if TargetDied then
			PlaySound(FromCF,3401386083,1,5,40)
			PlaySound(FromCF,1843035179,1,8,40)
		end
		spawn(function()
			for x=0,6 do
				local RandAngle1,RandAngle2,RandAngle3=math.random(-360,360),math.random(-360,360),math.random(-360,360)
				local RandSize=math.random(10)/50
				TweenEffect({Anchored=true,CanCollide=false,CanQuery=false,CanTouch=false,Size=Vector3.new(),CFrame=FromCF*CFrame.Angles(math.rad(RandAngle1),math.rad(RandAngle2),math.rad(RandAngle3)),Transparency=.011,Material='Glass',CastShadow=false},
				{MeshType='FileMesh',MeshId='rbxassetid://643098245',TextureId='rbxassetid://643064975',Scale=Vector3.new(0,0,0),VertexColor=Vector3.new(10,10,10)},
				{ --<<== Tween Frames
					{ --<<== Frame 1
						EndPart={ --<<== Tween End Part Properties 
							CFrame=FromCF*CFrame.Angles(math.rad(RandAngle3),math.rad(RandAngle2),math.rad(RandAngle1)),
							Transparency=1
						}, 
						EndMesh={--<<== Tween End Mesh Properties
							Scale=Vector3.new(2+RandSize,0,2+RandSize)
						},
						MeshTweenInfo=TweenInfo.new(math.random(40,160)/30,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0),
						PartTweenInfo=TweenInfo.new(math.random(40,160)/50,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut,0,false,0),
						Shake={Origin=FromCF.Position,MaxDist=1024,Amount=10,Power=6}
					},
				}
				)
			end
		end)
		OwnerRoot.Anchored = false
		OwnerRoot.Velocity = Vector3.zero
		ChangeEternalStorm(3)
	end
	if ReapSowTable.Highlight and not IsAncestorOf(workspace,ReapSowTable.Highlight) then
		if ReapSowTable.Target then
			ReapSowTable.Target = nil
		end
		pcall(game.Destroy,ReapSowTable.Highlight)
		ReapSowTable.Highlight = nil
	end
	if ReapSowTable.Target and IsAncestorOf(workspace,ReapSowTable.Target) and IsAncestorOf(workspace,ReapSowTable.Highlight) then
		Sow()
	else
		Reap()
	end
	SkillAttacking = false
end

function Dance_of_Death()
	if not OwnerHumanoid or not OwnerHumanoid.RootPart then return end
	local Cooldown = Cooldowns.Dance_of_Death
	if os.clock()-Cooldown.LastUseTime<Cooldown.CooldownTime then return end
	if SkillAttacking then return end
	SkillAttacking = true
	Cooldown.LastUseTime = os.clock()
	local StatsClone:WeaponStats = tabclone(CurrStats)
	StatsClone.BaseDamage = math.floor(StatsClone.BaseDamage*1.5)
	PlayAnim('RealityScytheSpin',1.25)
	local VFXModel=IT('WorldModel',workspace.Terrain,{Name=`{Owner.Name}sDeathDance`})
	local function Warp(Pos)
		local Shock1,Shock2=_Clone(Assets.Shock1),_Clone(Assets.Shock2)
		local Whirlwind=_Clone(Assets.whirlwind)
		Shock1.Size,Shock2.Size=Vector3.new(14.363,.716,15.393),Vector3.new(25.131,1.407,26.965)
		Whirlwind.Size=Vector3.new(12.23,10.845,11.42)
		Shock1.Locked,Shock2.Locked,Whirlwind.Locked=true,true,true
		Shock1.CFrame=CFrame.new(Pos.Position)*CFrame.new(0,-2.05,0)
		Shock2.CFrame=Shock1.CFrame
		Whirlwind.CFrame=CFrame.new(Pos.Position)*CFrame.new(0,2.25,0)
		Shock1.Parent,Shock2.Parent,Whirlwind.Parent=unpack(tabcreate(3,VFXModel))
		local Ang1,Ang2,Ang3=CFrame.Angles(0,math.rad(-180),0),CFrame.Angles(0,math.rad(180),0),CFrame.Angles(0,math.rad(220),0)
		CRTween(Shock1,{1.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Size=Shock1.Size*2})
		CRTween(Shock2,{1.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Size=Shock2.Size*2})
		CRTween(Shock1,{.9,Enum.EasingStyle.Quint,Enum.EasingDirection.Out},{CFrame=Shock1.CFrame*(Ang1-Ang1.Position)})
		CRTween(Shock2,{.9,Enum.EasingStyle.Quint,Enum.EasingDirection.Out},{CFrame=Shock2.CFrame*(Ang2-Ang2.Position)})
		CRTween(Shock1,{.7,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Transparency=1})
		CRTween(Shock2,{.7,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Transparency=1})
		CRTween(Whirlwind,{1.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Size=Whirlwind.Size*Vector3.new(0.5,3,0.5)})
		CRTween(Whirlwind,{2,Enum.EasingStyle.Quint,Enum.EasingDirection.Out},{CFrame=Whirlwind.CFrame*(Ang3-Ang3.Position)})
		CRTween(Whirlwind,{.7,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Transparency=1})
	end
	local function CloneChar(Char)
		local LastArchiv=Char.Archivable
		Char.Archivable=true
		shield.Parent = nil
		local CharClone=_Clone(Char)
		Char.Archivable=LastArchiv
		CharClone.Name=`CharClone{Owner.DisplayName}`
		pcall(game.Destroy,select(2,pcall(FindFirstChildOfClass,CharClone.Head,'Decal')))
		pcall(game.Destroy,select(2,pcall(FindFirstChildOfClass,CharClone,'Humanoid')))
		for x,l in next,GetChildren(CharClone) do
			if IsA(l,'BasePart') then 
				l.Material='Neon'l.Anchored=true l.Color=Color3.new(1,1,1)
				l.CanTouch=false l.CanCollide=false l.CanQuery=false
				pcall(l.BreakJoints,l)
				spawn(function()
					for x2,l2 in next,GetChildren(l) do
						if IsA(l2,'DataModelMesh') then continue end
						pcall(game.Destroy,l2)
					end
				end)
				continue 
			end
			pcall(game.Destroy,l)
		end
		CharClone.Parent=workspace.Terrain
		for x,l in next,GetChildren(CharClone) do
			if not IsA(l,'BasePart') then continue end 
			l.Material='Neon'l.Anchored=true l.Color=Color3.new(1,1,1)
			l.CanTouch=false l.CanCollide=false l.CanQuery=false
			if l.Name ~= 'HumanoidRootPart' then
				l.Transparency = 0
				CRTween(l,{1.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out},{Transparency=1})
			end
		end
		Debris:AddItem(CharClone,3)
	end
	local function DashHitbox(CF)
		spawn(function()
			local AlreadyHit = {}
			Hitbox(CF,Vector3.new(12,12,8),650,{},function(GotModel,GotHumanoid)
				if not GotModel or table.find(AlreadyHit,GotModel) then return end
				tabinsert(AlreadyHit,GotModel)
				spawn(DoStuff,GotModel,Owner,false,StatsClone,false,nil,'HealthSetDamage')
			end)
		end)
	end
	local SavedTransparency={}
	local OwnerRoot=OwnerHumanoid.RootPart
	local RootPos=OwnerRoot.CFrame
	for x,l in next,GetDescendants(OwnerCharacter)do
		if not IsA(l,'BasePart') and not IsA(l,'Decal') then continue end
		if l.Transparency >= 1 then continue end
		tabinsert(SavedTransparency,{Part=l,LastTransparency=l.Transparency})
	end
	ChangeEternalStorm(4)
	Warp(RootPos)
	PlaySound(RootPos,6290067239,2,3,25,0,{ChorusSoundEffect={}})
	for x,l in next,SavedTransparency do
		l.Part.Transparency=1
	end
	local OldVector = Vector3.zero
	local Vector = Vector3.zero
	--<<== skidded off from jack's stuff
	if ShiftLock or OwnerHumanoid.Sit then 
		if IsKeyDown('w') then
			if IsKeyDown("a") then
				Vector=(OwnerRoot.CFrame*CFrame.Angles(0,math.rad(45),0)).LookVector
			elseif IsKeyDown("d") then
				Vector=(OwnerRoot.CFrame*CFrame.Angles(0,math.rad(-45),0)).LookVector
			else
				Vector=OwnerRoot.CFrame.LookVector
			end
		elseif IsKeyDown('s') then
			if IsKeyDown("d") then
				Vector=-(OwnerRoot.CFrame*CFrame.Angles(0,math.rad(45),0)).LookVector
			elseif IsKeyDown("a") then
				Vector=-(OwnerRoot.CFrame*CFrame.Angles(0,math.rad(-45),0)).LookVector
			else
				Vector=-OwnerRoot.CFrame.LookVector
			end
		elseif IsKeyDown('a') then
			if IsKeyDown("d") then
				Vector=OwnerRoot.CFrame.LookVector
			else
				Vector=-OwnerRoot.CFrame.RightVector
			end
		elseif IsKeyDown('d') then
			Vector=OwnerRoot.CFrame.RightVector
		else
			Vector=OwnerRoot.CFrame.LookVector
		end	
	else
		Vector=OwnerRoot.CFrame.LookVector
	end
	--<<== skidded off from joel/123jl123's redlord 2
	for x=1,6 do
		if x<=1 then OldVector = Vector end
		if x>1 then Vector = OwnerRoot.CFrame.LookVector end
		local HitPart,HitPos,Normal=FindPartOnRayWithIgnoreList(Ray.new(OwnerRoot.Position,Vector.Unit*8),{unpack(GetRRTIgnoreList())},true,true)
		if HitPart then
			OwnerRoot.CFrame = CFrame.new(HitPos-Vector*2,HitPos+Vector)
			ToolRemote:FireClient(owner, "UpdatePosition", OwnerRoot.CFrame)
			DashHitbox(OwnerRoot.CFrame)
			CloneChar(OwnerCharacter)
			break
		else
			OwnerRoot.CFrame = CFrame.new(HitPos,HitPos+Vector)
			ToolRemote:FireClient(owner, "UpdatePosition", OwnerRoot.CFrame)
			DashHitbox(OwnerRoot.CFrame)
			CloneChar(OwnerCharacter)
		end
	end
	--wait(.2)
	swait(.25*60)
	local Cuts=_Clone(Assets.cut)
	Cuts.Size=Vector3.new(13.454,33.637,12.945)
	Cuts.Locked=true
	local _Ang=CFrame.Angles(math.rad(90),0,0)
	Cuts.CFrame=CFrame.lookAt(RootPos.Position,OwnerRoot.Position)*CFrame.new(0,2.95,-20.232)*(_Ang-_Ang.Position)
	Cuts.Parent=VFXModel
	local CutsAng=CFrame.Angles(0,math.rad(90),0)
	CRTween(Cuts,{1.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Size=Cuts.Size*Vector3.new(1.25,2,1.25)})
	CRTween(Cuts,{2,Enum.EasingStyle.Quint,Enum.EasingDirection.Out},{CFrame=Cuts.CFrame*(CutsAng-CutsAng.Position)})
	CRTween(Cuts,{.7,Enum.EasingStyle.Quad,Enum.EasingDirection.Out},{Transparency=1})

	local RootPos=OwnerRoot.CFrame
	Warp(RootPos)
	PlaySound(RootPos,6290067239,2,3,25,0,{ChorusSoundEffect={}})
	for x,l in next,SavedTransparency do
		l.Part.Transparency=l.LastTransparency
	end
	Debris:AddItem(IT('ForceField',OwnerCharacter,{Visible=false}),.5)
	--wait(.25)
	swait(.25*60)
	tabclear(SavedTransparency)
	SavedTransparency=nil
	local RandAngs = {
		--[1]
		{AngCF=CFrame.Angles(math.rad(Rand(4,7,1e8)),0,math.rad(Rand(1,2,1e8))),},
		--[2]
		{AngCF=CFrame.Angles(math.rad(-(Rand(4,7,1e8))),0,math.rad(-(Rand(1,2.5,1e8)))),}
	}
	local DefaultScale = Vector3.new(25,20,25)
	local asd = {
		Inner = {Rot=1,Size=DefaultScale/1.5},
		Outer = {Rot=2,Size=DefaultScale*1.5}
	}
	local TempSfx = IT('Sound',OwnerHumanoid.RootPart,{Pitch=2,Volume=3,EmitterSize=25,Name='DeathDanceSFX',SoundId=`rbxassetid://{6310837681}`})
	IT('PitchShiftSoundEffect',TempSfx,{Octave=.5})
	for x=1,3 do
		RootPos = (OwnerRoot and OwnerRoot.CFrame) or RootPos
		spawn(function()
			for x2,l in next,asd do
				local RandAng=RandAngs[l.Rot].AngCF
				local SlashScale=l.Size
				Slash(RootPos*RandAng,({720,-720})[l.Rot],.8,l.Size,{Color1=Color3.new(0,0,0),Color2=Glowify(Color3.new(1,1,1))},{Trans1=0,Trans2=-2.5}, {Main=SlashFlipbook.Contrast,Sub=SlashFlipbook.Contrast2})
				local HitboxCF = RootPos*RandAng
				local HitboxSize = Vector3.new(SlashScale.X*2,SlashScale.Y/5,SlashScale.Z*2)
				spawn(function()
					local AlreadyHit = {}
					Hitbox(HitboxCF,HitboxSize,650,{},function(GotModel,GotHumanoid)
						if not GotModel or tabfind(AlreadyHit,GotModel) then return end
						if tostring(x2)=='Inner' then
							if tabfind(AlreadyHit,GotModel) then return end
							tabinsert(AlreadyHit,GotModel)
							local StatsClone2:WeaponStats = tabclone(CurrStats)
							StatsClone2.BaseDamage = math.floor(StatsClone2.BaseDamage/2.25)

							local TargMaxHP,TargCurrHP = GotHumanoid.MaxHealth,GotHumanoid.Health
							--<<== (BaseValue-CurrValue)/BaseValue
							local MissingPercent = clamp((TargMaxHP-TargCurrHP)/TargMaxHP,.333333333333333333,1)
							StatsClone2.BaseDamage = math.floor((StatsClone2.BaseDamage)*(3*MissingPercent))

							local LifestealHPPercent = 1
							local stat = {
								Amount = ((LifestealHPPercent/100)*OwnerHumanoid.MaxHealth)*StatsClone2.BaseDamage
							}
							spawn(DoStuff,GotModel,Owner,false,StatsClone2,false,stat)
						else 
							if tabfind(AlreadyHit,GotModel) then return end
							tabinsert(AlreadyHit,GotModel)
							local StatsClone2:WeaponStats = tabclone(CurrStats)
							StatsClone2.BaseDamage = math.floor(StatsClone2.BaseDamage/3)
							spawn(DoStuff,GotModel,Owner,false,StatsClone2,false)
						end
					end)
				end)
			end
		end)
		--PlaySound(RootPos,6310837681,2,3,25,0,{PitchShiftSoundEffect={Octave=.5}})
		TempSfx:Play()
		--wait(.125)
		swait(.125*60)
	end
	Debris:AddItem(TempSfx,5)
	Debris:AddItem(VFXModel,5)
	swait(.86*60)
	SkillAttacking = false
end

--<<== Key Binds
BindedKeys.mousebutton1 = function()
	if M1Attacking then return end
	--if not (OwnerHumanoid and OwnerHumanoid:GetState()~=Enum.HumanoidStateType.Dead) then return end
	M1Attacking=true
	local StatsClone = tabclone(CurrStats)
	StatsClone.SwingSpeed = (StatsClone.SwingRate*60)/100
	local StormAttack = false
	repeat 
		if not ToolEquipped then break end
		--wait(StatsClone.SwingSpeed)
		if ExtraStats.Eternal_Storm > 0 then
			StatsClone.SwingSpeed = ((StatsClone.SwingRate/2)*60)/100
			StormAttack = true
		else
			StatsClone.SwingSpeed = (StatsClone.SwingRate*60)/100
			StormAttack = false
		end
		
		local StatsCloneOrig = StatsClone
		StatsClone = tabclone(CurrStats)
		if StormAttack then
			StatsClone.BaseDamage = math.floor(StatsClone.BaseDamage/2)
			ChangeEternalStorm(-1)
			spawn(AddSpeedBoost,8)
		end
		local RandAngs = {
			--[1]
			{AngCF=CFrame.Angles(math.rad(math.random(4*1e8,7*1e8)/1e8),math.rad(-45),math.rad(math.random(2*1e8)/1e8)),},
			--[2]
			{AngCF=CFrame.Angles(math.rad(-(math.random(4*1e8,7*1e8)/1e8)),math.rad(-45),math.rad(-(math.random(2.5*1e8)/1e8))),}
		}
		local HitboxCF = OwnerHumanoid.RootPart.CFrame*RandAngs[Combo].AngCF
		local HitboxSize = Vector3.new(Scale.X*2,Scale.Y/5,Scale.Z*2)

		local AnimName = Combos[Combo].Anim
		PlayAnim(AnimName,1.44)

		PlaySound(HitboxCF,6241709963,.5,5,12)
		PlaySound(HitboxCF,154965962,RandNextNum(.85,1.05),1,13)
		if StormAttack then
			PlaySound(HitboxCF,8089211478,RandNextNum(.7,1),5,20)
			PlaySound(HitboxCF,9116276961,RandNextNum(.8,1.3),.3,20)
		end
		Slash(
			--<<== Part CFrame
			HitboxCF, --CFrame.Angles(math.rad(math.random(-3,3)),math.rad(90),math.rad(math.random(-3,3)))
			--<<== Rotate
			Combos[Combo].Rotation,
			--<<== Duration
			Combos[Combo].Duration,
			--<<== Scale
			Scale,
			--<<== Color
			{
				Color1=Color3.new(0,0,0),
				Color2=Color3.fromRGB(5000,5000,5000)
			},
			--<<== Transparency
			{
				Trans1=.2, --0
				Trans2=-5000000 -- -5
			},
			--<<== Flipbooks
			{
				Main=SlashFlipbook.Contrast,
				Sub=SlashFlipbook.Contrast2
			}
		)
		spawn(function()
			local AlreadyHit = {}
			Hitbox(HitboxCF,HitboxSize,500,{},function(GotModel,GotHumanoid)
				if not GotModel or table.find(AlreadyHit,GotModel) then return end
				tabinsert(AlreadyHit,GotModel)
				local LifestealHPPercent = .6 -- 2%
				local stat = {
					Amount = (LifestealHPPercent/100)*OwnerHumanoid.MaxHealth
				}
				spawn(DoStuff,GotModel,Owner,false,StatsClone,true,stat)
				Cooldowns.Dance_of_Death.LastUseTime -= .065
			end)
		end)
		Combo=(Combo==1 and 2) or (Combo==2 and 1)
		
		swait(StatsCloneOrig.SwingSpeed*60)
	until not IsKeyDown('mousebutton1')
	M1Attacking=false
end
BindedKeys.z = Fractured_World
BindedKeys.x = Reap_N_Sow
BindedKeys.c = Dance_of_Death
BindedKeys.v = function()
	local Cooldown = Cooldowns.RealityTear
	if os.clock()-Cooldown.LastUseTime<Cooldown.CooldownTime then return end
	if SkillAttacking then return end
	SkillAttacking = true
	Cooldown.LastUseTime = os.clock()
	
	PlayAnim("RealityReap")
	task.wait(.5)

	pcall(function()
		ToolRemote:FireClient(owner, "TearReality")
	
		local TweenService,RunService,Debris = game:GetService'TweenService',game:GetService'RunService',game:GetService'Debris'

		local ColorCorrection = Instance.new("ColorCorrectionEffect")
		ColorCorrection.Parent = game:GetService("Lighting")
		Debris:AddItem(ColorCorrection,30)
		
		TweenService:Create(ColorCorrection,TweenInfo.new(.9,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{
			Brightness=-.3,
			Contrast=1
		}):Play()
	
		local s = Instance.new("Sound", workspace)
		s.Volume = 4
		s.SoundId = "rbxassetid://11060067"
		s.PlayOnRemove = true
		s:Destroy()
	
		local s = Instance.new("Sound", workspace)
		s.Volume = 2
		s.PlaybackSpeed = 1.5
		s.SoundId = "rbxassetid://7390331288"
		s.PlayOnRemove = true
		s:Destroy()
	
		task.delay(0.45, function()
			local s = Instance.new("Sound", workspace)
			s.Volume = 1.25
			s.PlaybackSpeed = .2
			s.SoundId = "rbxassetid://5989945551"
			s.PlayOnRemove = true
			s:Destroy()
		end)
	
		for i = 1, 16 do
			task.wait()
		end
		
		task.wait(.37)
		
		local HitboxCF = OwnerHumanoid.RootPart.CFrame
		local HitboxSize = Vector3.one*2048
		
		local StatsClone = tabclone(CurrStats)
		StatsClone.BaseDamage *= 6
		
		ChangeEternalStorm(6)
		
		local AlreadyHit = {}
		Hitbox(HitboxCF,HitboxSize,math.huge,{},function(GotModel,GotHumanoid)
			if not GotModel or table.find(AlreadyHit,GotModel) then return end
			tabinsert(AlreadyHit,GotModel)
			local LifestealHPPercent = .6 -- 2%
			local stat = {
				Amount = (LifestealHPPercent/100)*OwnerHumanoid.MaxHealth
			}
			spawn(DoStuff,GotModel,Owner,false,StatsClone,false,stat)
			Cooldowns.Dance_of_Death.LastUseTime -= .065
		end)
	
		local s = Instance.new("Sound", workspace)
		s.Volume = 1.6
		s.PlaybackSpeed = .6
		s.SoundId = "rbxassetid://5149987460"
		s.PlayOnRemove = true
		s:Destroy()
	
		local s = Instance.new("Sound", workspace)
		s.Volume = 2
		s.PlaybackSpeed = 1
		s.SoundId = "rbxassetid://4965926555"
		s.TimePosition = .45
		s.PlayOnRemove = true
		s:Destroy()
	
		local s = Instance.new("Sound", workspace)
		s.Volume = 3
		s.PlaybackSpeed = 1
		s.SoundId = "rbxassetid://9112078011"
		s.PlayOnRemove = true
		s:Destroy()
	
		TweenService:Create(ColorCorrection,TweenInfo.new(.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{
			Brightness=0,
			Contrast=0
		}):Play()
		task.wait(.5)
		ColorCorrection.Enabled = false
	end)
	
	SkillAttacking = false
end
Add(KeyDown:Connect(function(Key)
	if not Running then return end
	if not ToolEquipped then return end
	if not (OwnerHumanoid and OwnerHumanoid:GetState()~=Enum.HumanoidStateType.Dead) then return end
	--print(Key)
	local Found = BindedKeys[Key]
	if Found then
		Found()
		--warn'func called'
	end
end))

--<<== Remote Funcs & Core Funcs
local EffectEventFuncs = {
	Refit = function()
		pcall(game.Destroy,EffectRemote)
		EffectRemote = Instance.new("RemoteEvent", GetEffectRemotePlace())
		EffectRemote:SetAttribute('ScriptName',ToolName)
		EffectRemote.Name = string.char(math.random(255))..'CEFFect_'..tostring(OwnerUID):reverse()..string.char(math.random(255))
		Add(EffectRemote.OnServerEvent:Connect(OnEffectRemoteEvent))
		EffectRemote.Archivable = false
	end,
}

function StopScript()
	Running = false
	for x,l in next,Connections do pcall(l.Disconnect,l)end 
	--for x,l in next,EffectLocals do pcall(game.Destroy,l)end
	for x,l in next,ToolEventFuncs do pcall(setfenv,select(2,pcall(getfenv,l)),{})end
	for x,l in next,EffectEventFuncs do pcall(setfenv,select(2,pcall(getfenv,l)),{})end
	pcall(AnimConnection.Disconnect,AnimConnection)
	spawn(_AnimModClearCache)
	--FireClient(EffectRemote,'All','ClearJointCache')
	FireClient(ToolRemote,'All','StopScript',StopKey)
	FireClient(EffectRemote,'All','StopScript',StopKey)
	pcall(game.Destroy,ToolRemote)pcall(game.Destroy,EffectRemote)pcall(game.Destroy,Tool)
	ToolRemote,EffectRemote = nil,nil
	EffectRemotePlaces = {}
	if OwnerHumanoid then
		OwnerHumanoid.WalkSpeed = math.floor(CurrentHumSpeed)
	end
	pcall(setfenv,0,{})
end

function OnToolRemoteEvent(Player,FuncName,...)
	if not Running then
		OnToolRemoteEvent = function() end
		if ToolRemote then
			pcall(game.Destroy,ToolRemote)
		end	
		return
	end
	if Player~=Owner then return end
	if type(FuncName)~='string' then return end
	local FoundFunc = ToolEventFuncs[FuncName]
	if FoundFunc and type(FoundFunc)=='function' then
		local Success,Returned = pcall(FoundFunc,Player,...)
		if not Success then
			Services.TestService:Message('ServerToolRemote: '..tostring(Returned))
		end
	end
end

function OnEffectRemoteEvent(Player,FuncName,...)
	if not Running then
		OnEffectRemoteEvent = function() end
		if EffectRemote then
			pcall(game.Destroy,EffectRemote)
		end	
		return
	end
	local FoundFunc = EffectEventFuncs[FuncName]
	if FoundFunc and type(FoundFunc)=='function' then
		local Success,Returned = pcall(FoundFunc,Player,...)
		if not Success then
			Services.TestService:Message('ServerEffectRemote: '..tostring(Returned))
		end
	else
		local PlayerUID = tostring(Player.UserId)
		--[[local FoundLocal = EffectLocals[PlayerUID]
		if FoundLocal and typeof(FoundLocal)=='Instance' then
			pcall(game.Destroy,FoundLocal)
			if StopKey~='' or StopKey~=nil or StopKey~=' ' then
				FireClient(EffectRemote,Player,'NewKey',StopKey)
				for x,l in next,{IdleKF,Atk1KF,Atk2KF,SlamKF,SpinKF,ReapKF,SowKF,SowFinishKF} do
					wait(.125)
					LoadAnim(l, OwnerCharacter)
				end
			end
		end]]
		if PlayerUID == tostring(OwnerUID) and Player == Owner then
			if not StopKey or StopKey=='' or StopKey==nil or StopKey==' ' then
				StopKey = FuncName
				--FireClient(EffectRemote,'All','NewKey',StopKey)
				FireClient(ToolRemote,'All','NewKey',StopKey)
			end
		end
	end
end

function IsEffectRemotePlace(IN)
	for x,Service in next,EffectRemotePlaces do
		if Service == IN then
			return true
		end
	end
	return false
end

function GetEffectRemotePlace()
	return EffectRemotePlaces[math.random(1, #EffectRemotePlaces)]
end

function RemoveFakeRemotes()
	for x,Inst in next,GetChildren(Tool) do
		if Inst:IsA('RemoteEvent') then
			if Inst.Name:sub(2,Inst.Name:len()-1)==tostring(OwnerUID) then
				if Inst~=ToolRemote then
					Debris:AddItem(Inst,0)
				end
			end
		end
	end
end

function NewRemotes()
	if not Running then
		NewRemotes = function() end
		pcall(game.Destroy,ToolRemote)
		pcall(game.Destroy,EffectRemote)
		return
	end
	if ToolRemote then
		if not game:IsAncestorOf(ToolRemote) then
			ToolRemote = Instance.new('RemoteEvent',Tool)
			ToolRemote.Name = string.char(math.random(255))..tostring(OwnerUID):reverse()..string.char(math.random(255))
			Add(ToolRemote.OnServerEvent:Connect(OnToolRemoteEvent))
		end
	else
		ToolRemote = Instance.new('RemoteEvent',Tool)
		ToolRemote.Name = string.char(math.random(255))..tostring(OwnerUID):reverse()..string.char(math.random(255))
		Add(ToolRemote.OnServerEvent:Connect(OnToolRemoteEvent))
	end
	if ToolRemote.Parent~=Tool then
		local Success,Returned = pcall(function()ToolRemote.Parent=Tool end)
		if not Success then 
			pcall(game.Destroy,ToolRemote) 
			ToolRemote = Instance.new('RemoteEvent',Tool)
			ToolRemote.Name = string.char(math.random(255))..tostring(OwnerUID):reverse()..string.char(math.random(255))
			Add(ToolRemote.OnServerEvent:Connect(OnToolRemoteEvent))
		end
	end
	if ToolRemote.Name:sub(2,ToolRemote.Name:len()-1)~=tostring(OwnerUID):reverse() then
		ToolRemote.Name = string.char(math.random(255))..tostring(OwnerUID):reverse()..string.char(math.random(255))
	end
	ToolRemote.Archivable = false
	RemoveFakeRemotes()
	--ToolRemote.RobloxLocked = true
	if EffectRemote then
		if not IsAncestorOf(game,EffectRemote) then
			EffectRemote = Instance.new('RemoteEvent',GetEffectRemotePlace())
			EffectRemote:SetAttribute('ScriptName',ToolName)
			EffectRemote.Name = string.char(math.random(255))..'CEFFect_'..tostring(OwnerUID):reverse()..string.char(math.random(255))
			Add(EffectRemote.OnServerEvent:Connect(OnEffectRemoteEvent))
		end
	else
		EffectRemote = Instance.new('RemoteEvent',GetEffectRemotePlace())
		EffectRemote:SetAttribute('ScriptName',ToolName)
		EffectRemote.Name = string.char(math.random(255))..'CEFFect_'..tostring(OwnerUID):reverse()..string.char(math.random(255))
		Add(EffectRemote.OnServerEvent:Connect(OnEffectRemoteEvent))
	end
	if not IsEffectRemotePlace(EffectRemote.Parent) then
		local Success,Returned = pcall(function()EffectRemote.Parent=GetEffectRemotePlace() end)
		if not Success then 
			pcall(game.Destroy,ToolRemote) 
			EffectRemote = Instance.new('RemoteEvent',GetEffectRemotePlace())
			EffectRemote:SetAttribute('ScriptName',ToolName)
			EffectRemote.Name = string.char(math.random(255))..'CEFFect_'..tostring(OwnerUID):reverse()..string.char(math.random(255))
			Add(EffectRemote.OnServerEvent:Connect(OnEffectRemoteEvent))
		end
	end
	if EffectRemote.Name:sub(2,EffectRemote.Name:len()-1)~='CEffect_'..tostring(OwnerUID):reverse() then
		EffectRemote.Name = string.char(math.random(255))..'CEFFect_'..tostring(OwnerUID):reverse()..string.char(math.random(255))
	end
	if not EffectRemote:GetAttribute('ScriptName') or EffectRemote:GetAttribute('ScriptName')~=ToolName then
		EffectRemote:SetAttribute('ScriptName',ToolName)
	end
	EffectRemote.Archivable = false
end

--<<== Connections & Initialize
Add(Tool.Equipped:Connect(function()
	ToolEquipped = true
	CombatUI.Parent = owner.PlayerGui
	OwnerCharacter = Owner.Character
	OwnerHumanoid = FindFirstChildOfClass(OwnerCharacter,'Humanoid')
	LastHumSpeed = OwnerHumanoid.WalkSpeed
	LoadAnim(IdleKF,OwnerCharacter)
	spawn(function()
		for x,l in next,{Atk1KF,Atk2KF,SlamKF,SpinKF,ReapKF,SowKF,SowFinishKF} do
			LoadAnim(l,OwnerCharacter)
		end
	end)
	PlaySound(OwnerCharacter and OwnerCharacter:GetPivot() or FindFirstChild(Tool,'Handle') and Tool.Handle.CFrame,12222225,1,1)
	PlayAnim('HeavyMeleeIdle')
	--warn'equipped'
end))
Add(Tool.Unequipped:Connect(function()
	ToolEquipped = false
	CombatUI.Parent = nil
	StopAnim('HeavyMeleeIdle')
	spawn(_AnimModClearCache)
	--FireClient(EffectRemote,'All','ClearJointCache')
	--warn'unequipped'
end))
print'Tool Connections Connected'
for x,l in next,Players:GetPlayers() do
	pcall(GiveEffectScript,l)
end
print'CR Effect script given to players'
Add(Players.PlayerAdded:Connect(GiveEffectScript))
Add(Players.PlayerRemoving:Connect(function(LeavingPlayer)
	if LeavingPlayer == Owner or LeavingPlayer.UserId == OwnerUID then
		StopScript()
	end
end))
Add(RunService.Stepped:Connect(function(Time,Delta)
	if not Running then
		StopScript()
		return
	end
	if not IsAncestorOf(game,Tool) then
		StopScript()
		return
	end
	if Tool.Parent~=Owner.Character and Tool.Parent~=FindFirstChildOfClass(Owner,'Backpack') then
		local Success,Returned = pcall(function()Tool.Parent = FindFirstChildOfClass(Owner,'Backpack') end)
		if not Success then
			StopScript()
			return
		end
	end
	if OwnerHumanoid then
		--[[if tostring(OwnerHumanoid.MaxHealth):lower():find('nan') then
			OwnerHumanoid.MaxHealth = 666666666666
		elseif tostring(OwnerHumanoid.Health):lower():find('nan') then
			OwnerHumanoid.Health = OwnerHumanoid.MaxHealth
		end]]
		OwnerHumanoid.WalkSpeed = math.floor(clamp(CurrentHumSpeed+ExtraStats.Speed_Boost,CurrentHumSpeed,1e6))
	end
	if ToolEquipped and ExtraStats.Speed_Boost <= 0 then
		if OwnerHumanoid and LastHumSpeed < OwnerHumanoid.WalkSpeed then LastHumSpeed = OwnerHumanoid.WalkSpeed end
		CurrentHumSpeed = LastHumSpeed
	end
	if math.random(16)==1 then
		Tool.Name = `{ExtraToolNames[Rand(1,#ExtraToolNames)]}`
	else
		Tool.Name = ToolName
	end
	Tool.ToolTip = `Base Damage: {CurrStats.BaseDamage} | Crit Multiplier: {CurrStats.CritDamage} | Crit Chance: {CurrStats.CritChance}% | Swing Cooldown: {(CurrStats.SwingRate*60)/100} seconds\n\n\n\n\n"A powerful reality ripping scythe that was forged from the countless realities with the power of darkness and light... Can you shoulder the weight of the fate before seeing the end of the world?"` --ToolDesc
	spawn(NewRemotes)
	pcall(RemoveFakeRemotes)
	--FireClient(EffectRemote,'All','NewKey',StopKey)
end))
Add(RunService.Heartbeat:Connect(NewRemotes))
Add(RunService.Heartbeat:Connect(RemoveFakeRemotes))
Add(RunService.Heartbeat:Connect(UpdateStats))
]==], scythe)
assets.Deps.Parent = method

local client = NLS([=[
--<<== Written by Nekotari Chirune
local Tool = script.Parent
task.wait()

local _wait,_spawn,_delay = wait,spawn,delay
local Services = setmetatable({},{
	__index = function(self,IndVal)
		if not IndVal or IndVal==nil or type(IndVal)~='string' then return end
		local FoundService = select(2,pcall(game.FindService,game,IndVal))
		if not FoundService or typeof(FoundService)~='Instance' then
			FoundService = select(2,pcall(game.GetService,game,IndVal))
		end
		if FoundService and typeof(FoundService)=='Instance' then
			rawset(self,IndVal,FoundService)
			return FoundService
		end
	end,
	__metatable = 'nuh uh'
})
local Players,UserInputService,RunService,TweenService,Debris,StarterGui = Services.Players,Services.UserInputService,
Services.RunService,Services.TweenService,
Services.Debris,Services.StarterGui
local wait,spawn,delay = task.wait,task.spawn,task.delay

local User = Players.LocalPlayer
local UserId = User.UserId
local Mouse = User:GetMouse()

local Remote

local Stopped = false
local Connections = {}

function Disconnect()
	Stopped = true
	for x,l in next,Connections do
		pcall(l.Disconnect,l)
	end
	warn('Script ended. | Controller')
	pcall(setfenv,0,{})
end

function FireServer(...)
	if(not Remote or not Remote.Parent)then
		while not(Remote and Remote.Parent)do
			RunService.RenderStepped:Wait()
		end
	end
	Remote:FireServer(...)
end

local function realitytear()
	local Camera = workspace.CurrentCamera
	local TweenService,RunService,Debris = game:GetService'TweenService',game:GetService'RunService',game:GetService'Debris'
	local TearModel = script.Tear:Clone()
	local SlicesFolder = TearModel.Slices
	local Center,Glass1,Glass2,Star = TearModel.Center,TearModel.Glass1, TearModel.Glass2, TearModel.Star

	Debris:AddItem(TearModel,30)

	for x,l in next,Camera:GetChildren() do
		if l:IsA'Model' and l.Name=='tear' then
			pcall(game.Destroy,l)
		elseif l:IsA'ColorCorrectionEffect' and l.Name=='RealityCorrection' then
			pcall(game.Destroy,l)
		end
	end

	local function Create(ClassName)
		local Exist,NewInst = pcall(Instance.new,ClassName)
		if Exist and NewInst then
			return function(Properties)
				for x,l in next,Properties do
					pcall(function()
						NewInst[x]=l
					end)
				end
				return NewInst
			end
		else
			return nil
		end
	end

	local SetCFrameCon = RunService.RenderStepped:Connect(function(Delta)
		task.spawn(function()
			local Pos = (Camera.CFrame*CFrame.new(0,0,-.154)).Position
			Center.CFrame = CFrame.lookAt(Pos,Camera.CFrame.Position)
		end)
	end)

	local function Slash()
		local SlashPart = Create'Part'{Material=Enum.Material.Neon,Color=Color3.new(1,1,1),CastShadow=false,CanQuery=false,CanTouch=false,CanCollide=false,CFrame=Center.CFrame,Size=Vector3.new(1,.1,1),Parent=SlicesFolder}
		local SlashSound = Center:WaitForChild'Slash' SlashSound.PlayOnRemove=true SlashSound.Parent=SlashPart pcall(game.Destroy,SlashSound)
		local Weld = Create'Weld'{Part0=Center,Part1=SlashPart,C0=CFrame.new()*CFrame.Angles(math.rad(math.random(-3,3))+math.rad(math.random(-15,15)),math.rad(math.random(-10,10))+math.rad(math.random(-90,90)),math.rad(math.random(-10,10))+math.rad(math.random(-90,90))),Parent=SlashPart}
		local BlockMesh = Create'BlockMesh'{Scale=Vector3.new(3,.1,3),Parent=SlashPart}
		local ScaleTween = TweenService:Create(BlockMesh,TweenInfo.new(.075,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{
			Scale=Vector3.new(.005,10000,.005)
		}) ScaleTween:Play()
	end
	
	Glass1.Transparency = .65
	Glass2.Transparency = .65
	TearModel.Parent = Camera
	
	task.spawn(function()
		for x,l in next,Glass1:GetDescendants() do
			if l:IsA'JointInstance' then pcall(game.Destroy,l) end
		end
		for x,l in next,Glass2:GetDescendants() do
			if l:IsA'JointInstance' then pcall(game.Destroy,l) end
		end
	end)
	
	task.spawn(function()
		task.wait(.045)
		Slash()
	end)

	local GlassPrimWeld,GlassSecWeld = Center.GlassPrimary,Center.GlassSecondary
	local RandAng1,RandAng2 = CFrame.Angles(math.rad(math.random(-20,20))+math.rad(math.random(-5,5)),math.rad(math.random(-20,20))+math.rad(math.random(-5,5)),math.rad(math.random(-20,20))+math.rad(math.random(-5,5))),CFrame.Angles(math.rad(math.random(-20,20))+math.rad(math.random(-5,5)),math.rad(math.random(-20,20))+math.rad(math.random(-5,5)),math.rad(math.random(-20,20))+math.rad(math.random(-5,5)))
	for x=1,16 do
		local DT = task.wait()
		GlassPrimWeld.C0 = GlassPrimWeld.C0:Lerp(RandAng1,1-(2e-6^DT))
		GlassSecWeld.C0 = GlassSecWeld.C0:Lerp(RandAng2,1-(2e-6^DT))
	end
	task.wait(.37)
	local StarScale = TweenService:Create(Star,TweenInfo.new(.4,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{
		Size=Vector3.new(15,15,0)
	})
	StarScale:Play() StarScale.Completed:Wait()
	for x,l in next,SlicesFolder:GetChildren() do
		pcall(game.Destroy,l)
	end
	
	TweenService:Create(Star,TweenInfo.new(3.2,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0),{
		Transparency=1
	}):Play()
	
	Glass1.Transparency = 1
	Glass2.Transparency = 1
	Glass1.Glass.Enabled=true
	Glass2.Glass.Enabled=true
	task.spawn(function()
		for x=1,32 do
			task.wait()
			Glass1.Glass:Emit(24)
			Glass2.Glass:Emit(24)
			Glass1.Glass.TimeScale = x
			Glass2.Glass.TimeScale = x
		end
		Glass1.Glass.Enabled=false
		Glass2.Glass.Enabled=false
	end)
end

local lastcf = User.Character.HumanoidRootPart.CFrame
local EndKey
local ClientEventFuncs = {
	Notify = function(Data)
		StarterGui:SetCore("SendNotification", Data)
	end,
	StopScript = function(Key)
		if Stopped then return end
		if Key and type(Key)=='string' and Key==EndKey and (EndKey~='' or EndKey~=nil) then
			Disconnect()
		end
	end,
	NewKey = function(Key)
		if Stopped then return end
		if Key and type(Key)=='string' and (not EndKey or EndKey==nil or EndKey=='') then
			EndKey=Key
		end
	end,
	UpdatePosition = function(CF)
		User.Character.HumanoidRootPart.CFrame = CF
		lastcf = CF
	end,
	TearReality = realitytear
}

function Add(Con)
	if Stopped then return end
	if not Con or typeof(Con)~='RBXScriptConnection' then return end
	table.insert(Connections,Con)
	return Con
end

function OnClientEvent(EffectName,...)
	if Stopped then return end
	if not EffectName or type(EffectName)~='string' then return end
	local FoundFunc = ClientEventFuncs[EffectName]
	if not FoundFunc or type(FoundFunc)~='function' then return end
	local Success,Returned = pcall(task.spawn,FoundFunc,...)
	if not Success then Services.TestService:Message("ClientEffect!"..tostring(Returned)) end
end

function FindRemote()
	if Stopped then return end
	if not game:IsAncestorOf(Tool) then
		Disconnect()
		return
	end
	for x,Remote in next,Tool:GetChildren() do
		if Remote:IsA'RemoteEvent' then
			if Remote and typeof(Remote)=='Instance' and game:IsAncestorOf(Remote) and Remote:IsA'RemoteEvent' then
				if Remote.Name:sub(2,Remote.Name:len()-1)==tostring(UserId):reverse() then
					return Remote
				end
			end
		end
	end
end

KeysDown = {}
Add(UserInputService.InputBegan:Connect(function(Input, d)
	if not d then
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			KeysDown[Input.KeyCode.Name:lower()] = true
		elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
			KeysDown["mousebutton1"] = true
		end
	end
	
	coroutine.wrap(FireServer)("ClientData",workspace.CurrentCamera.CFrame,KeysDown,Mouse.Hit,Mouse.Target,Mouse.UnitRay,UserInputService.MouseBehavior==Enum.MouseBehavior.LockCenter)
end))
Add(UserInputService.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.Keyboard then
		KeysDown[Input.KeyCode.Name:lower()] = nil
	elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
		KeysDown["mousebutton1"] = nil
	end
	
	coroutine.wrap(FireServer)("ClientData",workspace.CurrentCamera.CFrame,KeysDown,Mouse.Hit,Mouse.Target,Mouse.UnitRay,UserInputService.MouseBehavior==Enum.MouseBehavior.LockCenter)
end))

local dt = 0
Add(RunService.Stepped:Connect(function()
	User.Character.HumanoidRootPart.CFrame = lastcf
end))
Add(RunService.RenderStepped:Connect(function(Delta)
	if Stopped then
		Disconnect()
		return
	end
	dt = dt + Delta
	lastcf = User.Character.HumanoidRootPart.CFrame
	coroutine.wrap(FireServer)("ReplicateMovement", User.Character.HumanoidRootPart.CFrame)

	if(dt < 1/30)then return end
	dt = 0

	if not(Remote and Remote.Parent and game:IsAncestorOf(Remote))then
		Remote = FindRemote()
		if Remote and Remote.Parent then
			Add(Remote.OnClientEvent:Connect(OnClientEvent))
			local OnDestroying
			OnDestroying = Add(Remote.Destroying:Connect(function()
				pcall(Remote.FireServer,Remote,'ForceRemoteRefit')
				pcall(OnDestroying.Disconnect,OnDestroying)
			end))
		end
	end

	coroutine.wrap(FireServer)("ClientData",workspace.CurrentCamera.CFrame,KeysDown,Mouse.Hit,Mouse.Target,Mouse.UnitRay,UserInputService.MouseBehavior==Enum.MouseBehavior.LockCenter)
end))
]=], scythe)

local function Decode(b)local _=#b do local f={} for _,a in pairs(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='):split(''))do f[a:byte()]=_-1 end local a=_ local d,e=table.create(math.floor(a/4)+1),1 local _=b:sub(-2)=='=='and 2 or b:sub(-1)=='='and 1 or 0 for _=1,_>0 and a-4 or a,4 do local b,c,a,_=b:byte(_,_+3) local _=f[b]*0x40000+f[c]*0x1000+f[a]*0x40+f[_] d[e]=string.char(bit32.extract(_,16,8),bit32.extract(_,8,8),bit32.extract(_,0,8)) e=e+1 end if _==1 then local b,_,a=b:byte(a-3,a-1) local _=f[b]*0x40000+f[_]*0x1000+f[a]*0x40 d[e]=string.char(bit32.extract(_,16,8),bit32.extract(_,8,8))elseif _==2 then local a,_=b:byte(a-3,a-2) local _=f[a]*0x40000+f[_]*0x1000 d[e]=string.char(bit32.extract(_,16,8))end b=table.concat(d)end local a=1 local function m(_)local _={string.unpack(_,b,a)} a=table.remove(_) return table.unpack(_)end local _=m('B') local l=m('B') l={bit32.extract(l,6,2)+1,bit32.extract(l,4,2)+1,bit32.extract(l,2,2)+1,bit32.extract(l,0,2)+1,bit32.band(_,0b1)>0} local h=('I'..l[1]) local f=('I'..l[2]) local _=('I'..l[3]) local b=('I'..l[4]) local d=m(h) local i=table.create(d) local c={} local a={[1]=function(_)return m('s'.._)end,[2]=function(_)return _~=0 end,[3]=function()return m('d')end,[4]=function(_,_)table.insert(c,{_,m(('I'..l[1]):rep(3))})end,[5]={CFrame.new,l[5]and'dddddddddddd'or'ffffffffffff'},[6]={Color3.fromRGB,'BBB'},[7]={BrickColor.new,'I2'},[8]=function(_)local _=m('I'.._) local a=table.create(_) for _=1,_ do a[_]=ColorSequenceKeypoint.new(m('f'),Color3.fromRGB(m('BBB')))end return ColorSequence.new(a)end,[9]=function(_)local _=m('I'.._) local a=table.create(_) for _=1,_ do a[_]=NumberSequenceKeypoint.new(m(l[5]and'ddd'or'fff'))end return NumberSequence.new(a)end,[10]={Vector3.new,l[5]and'ddd'or'fff'},[11]={Vector2.new,l[5]and'dd'or'ff'},[12]={UDim2.new,l[5]and'di2di2'or'fi2fi2'},[13]={Rect.new,l[5]and'dddd'or'ffff'},[14]=function()local _=m('B') local a={"Top","Bottom","Left","Right","Front","Back"} local c={} for b=0,5 do if bit32.extract(_,b,1)==1 then table.insert(c,Enum.NormalId[a[b+1]])end end return Axes.new(unpack(c))end,[15]=function()local _=m('B') local a={"Top","Bottom","Left","Right","Front","Back"} local b={} for c=0,5 do if bit32.extract(_,c,1)==1 then table.insert(b,Enum.NormalId[a[c+1]])end end return Faces.new(unpack(b))end,[16]={PhysicalProperties.new,l[5]and'ddddd'or'fffff'},[17]={NumberRange.new,l[5]and'dd'or'ff'},[18]={UDim.new,l[5]and'di2'or'fi2'},[19]=function()return Ray.new(Vector3.new(m(l[5]and'ddd'or'fff')),Vector3.new(m(l[5]and'ddd'or'fff')))end} for c=1,d do local _=m('B') local b=bit32.band(_,0b11111) local _=(_-b)/0b100000 local a=a[b] if type(a)=='function'then i[c]=a(_,c)else i[c]=a[1](m(a[2]))end end for _,_ in pairs(c)do i[_[1]]=CFrame.fromMatrix(i[_[2]],i[_[3]],i[_[4]])end local a=m(f) local e={} local d={} for a=1,a do local _=i[m(h)] local k local j,g if _=="UnionOperation"then k=DecodeUnion(i,l,m) k.UsePartColor=true elseif _:find("Script")then k=Instance.new("Folder") Script(k,_=='ModuleScript')elseif _=="MeshPart"then k=Instance.new("Part") j=Instance.new("SpecialMesh") j.MeshType=Enum.MeshType.FileMesh j.Parent=k else k=Instance.new(_)end local c=e[m(f)] local _=m(b) local b=m(b) e[a]=k for _=1,_ do local a,b=i[m(h)],i[m(h)] local _=false if j then if a=="MeshId"then j.MeshId=b _=true elseif a=="TextureID"then j.TextureId=b _=true elseif a=="Size"then if not g then g=b else j.Scale=b/g end elseif a=="MeshSize"then if not g then g=b j.Scale=k.Size/b else j.Scale=g/b end _=true end end if(not _)then k[a]=b end end if j then if j.MeshId==''then if j.TextureId==''then j.TextureId='rbxasset://textures/meshPartFallback.png'end j.Scale=k.Size end end for _=1,b do k:SetAttribute(i[m(h)],i[m(h)])end if not c then table.insert(d,k)else k.Parent=c end end local _=m(_) for _=1,_ do local a,_,b=m(f),m(h),m(f) e[a][i[_]]=e[b]end return d end

local tearmodel = Decode('AABlIQVNb2RlbCEETmFtZSEEdGVhciEKV29ybGRQaXZvdARiY2QhBkZvbGRlciEGU2xpY2VzIQRQYXJ0IQZDZW50ZXIhCEFuY2hvcmVkIiENQm90dG9tU3VyZmFjZQMAAAAAAAAAACEKQnJpY2tDb2xvcgfpAyEGQ0ZyYW1lBB1jZCEKQ2FuQ29sbGlkZQIhCENhblRv'
	..'dWNoIQpDYXN0U2hhZG93IQVDb2xvcgb///8hBkxvY2tlZCEITWFzc2xlc3MhCE1hdGVyaWFsAwAAAAAAgJhAIQhQb3NpdGlvbgoAAAAAAAAkQgA0s70hC1JlZmxlY3RhbmNlAwAAAAAAAPA/IQRTaXplCm8SgzpvEoM6bxKDOiEKVG9wU3VyZmFjZSEMVHJhbnNwYXJl'
	..'bmN5IQVTb3VuZCEGUGF1c2UyIQ1QbGF5YmFja1NwZWVkAwAAAAAAAPg/IQdTb3VuZElkIRdyYnhhc3NldGlkOi8vNzM5MDMzMTI4OCEGVm9sdW1lAwAAAAAAAABAIQVTbGFzaAMAAAAAAAD0PyEXcmJ4YXNzZXRpZDovLzU5ODk5NDU1NTEDAAAAoJmZyT8hBVBhdXNl'
	..'IRVyYnhhc3NldGlkOi8vMTEwNjAwNjcDAAAAAAAAEEAhCFNoYXR0ZXIzIRdyYnhhc3NldGlkOi8vOTExMjA3ODAxMQMAAAAAAAAIQCEIU2hhdHRlcjIhF3JieGFzc2V0aWQ6Ly80OTY1OTI2NTU1IQxUaW1lUG9zaXRpb24DzczMzMzM3D8hB1NoYXR0ZXIDAAAAQDMz'
	..'4z8hF3JieGFzc2V0aWQ6Ly81MTQ5OTg3NDYwAwAAAKCZmfk/IQRXZWxkIQZCVFdlbGQhAkMwBGVjZCEFUGFydDAhDkdsYXNzU2Vjb25kYXJ5IQVQYXJ0MSEMR2xhc3NQcmltYXJ5IQZHbGFzczIhC0JhY2tTdXJmYWNlAwAAAAAAACRAIQxGcm9udFN1cmZhY2UhC0xl'
	..'ZnRTdXJmYWNlIQxSaWdodFN1cmZhY2UKAADIQgAAoELNzMw9IQ9QYXJ0aWNsZUVtaXR0ZXIhBUdsYXNzIQdFbmFibGVkIQhMaWZldGltZREAAIA/AABAQCENTGlnaHRFbWlzc2lvbiEMTG9ja2VkVG9QYXJ0IQhSb3RTcGVlZBEAAJbDAACWQyEIUm90YXRpb24RAAAA'
	..'AAAAtEMpAgAAAAA6UX8+gjL6PgAAgD8AAAAAAAAAACEFU3BlZWQRAADIQQAAyEEhC1NwcmVhZEFuZ2xlCwAAtEMAALRDIQdUZXh0dXJlIRdyYnhhc3NldGlkOi8vNDI5Mjk3MDY0MiEHWk9mZnNldAMAAAAAAADwvyEGR2xhc3MxCgAAAAAAACRCADyMvQoAAIA/AAAA'
	..'AAAAAAAKAAAAAAAAgD8AAAAACgAAAAAAAAAAzcxMPhABAAIAAgMEBQYBAQACBwgBEQACCQoLDA0ODxAREhMUExUTFhcYCxkLGhscHR4fICEiDSMfJAMEAAIlJicoKSorJAMEAAIsJi0oLiovJAMDAAIwKDEqMiQDAwACMyg0KjUkAwQAAjYoNzg5KiskAwQAAjomOyg8'
	..'Kj0+AwIAAj9AQT4DAQACQz4DAQACRQgBFAACRkdIDEgODxAREhMUExUTFhdJSEpIGAsZCxobHB0eH0tIIEwiSCMfTQ0MAAJOTxNQUVIfUwtUVVZXIFhZWltcXV5fYAgBFAACYUdIDEgODxAREhMUExUTFhdJSEpIGAsZCxobHB0eH0tIIEwiSCMfTQ8MAAJOTxNQUVIf'
	..'UwtUVVZXIFhZWltcXV5fYAUKQgMLQgMLRA0MQgMMRA8=')[1]
local starmesh = game:GetService("InsertService"):CreateMeshPartAsync("rbxassetid://4886514859", Enum.CollisionFidelity.Box, Enum.RenderFidelity.Precise)
starmesh.Size = Vector3.zero
starmesh.CastShadow = false
starmesh.CanCollide = false
starmesh.CanQuery = false
starmesh.CanTouch = false
starmesh.Anchored = false
starmesh.Massless = true
starmesh.Material = Enum.Material.Neon
starmesh.Color = Color3.fromRGB(248, 248, 248)
starmesh.CFrame = CFrame.new(0, 41, 0.112)
starmesh.Name = "Star"
starmesh.Parent = tearmodel
tearmodel.Center.BTWeld.Part1 = starmesh

tearmodel.Name = "Tear"
tearmodel.Parent = client