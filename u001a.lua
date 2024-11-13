local owner = owner or game:GetService("Players"):WaitForChild("TheFakeFew")
local char = owner.Character or owner.CharacterAdded:Wait()

local function Decode(b)local _=#b do local f={} for _,a in pairs(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='):split(''))do f[a:byte()]=_-1 end local a=_ local d,e=table.create(math.floor(a/4)+1),1 local _=b:sub(-2)=='=='and 2 or b:sub(-1)=='='and 1 or 0 for _=1,_>0 and a-4 or a,4 do local b,c,a,_=b:byte(_,_+3) local _=f[b]*0x40000+f[c]*0x1000+f[a]*0x40+f[_] d[e]=string.char(bit32.extract(_,16,8),bit32.extract(_,8,8),bit32.extract(_,0,8)) e=e+1 end if _==1 then local b,_,a=b:byte(a-3,a-1) local _=f[b]*0x40000+f[_]*0x1000+f[a]*0x40 d[e]=string.char(bit32.extract(_,16,8),bit32.extract(_,8,8))elseif _==2 then local a,_=b:byte(a-3,a-2) local _=f[a]*0x40000+f[_]*0x1000 d[e]=string.char(bit32.extract(_,16,8))end b=table.concat(d)end local a=1 local function m(_)local _={string.unpack(_,b,a)} a=table.remove(_) return table.unpack(_)end local _=m('B') local l=m('B') l={bit32.extract(l,6,2)+1,bit32.extract(l,4,2)+1,bit32.extract(l,2,2)+1,bit32.extract(l,0,2)+1,bit32.band(_,0b1)>0} local h=('I'..l[1]) local f=('I'..l[2]) local _=('I'..l[3]) local b=('I'..l[4]) local d=m(h) local i=table.create(d) local c={} local a={[1]=function(_)return m('s'.._)end,[2]=function(_)return _~=0 end,[3]=function()return m('d')end,[4]=function(_,_)table.insert(c,{_,m(('I'..l[1]):rep(3))})end,[5]={CFrame.new,l[5]and'dddddddddddd'or'ffffffffffff'},[6]={Color3.fromRGB,'BBB'},[7]={BrickColor.new,'I2'},[8]=function(_)local _=m('I'.._) local a=table.create(_) for _=1,_ do a[_]=ColorSequenceKeypoint.new(m('f'),Color3.fromRGB(m('BBB')))end return ColorSequence.new(a)end,[9]=function(_)local _=m('I'.._) local a=table.create(_) for _=1,_ do a[_]=NumberSequenceKeypoint.new(m(l[5]and'ddd'or'fff'))end return NumberSequence.new(a)end,[10]={Vector3.new,l[5]and'ddd'or'fff'},[11]={Vector2.new,l[5]and'dd'or'ff'},[12]={UDim2.new,l[5]and'di2di2'or'fi2fi2'},[13]={Rect.new,l[5]and'dddd'or'ffff'},[14]=function()local _=m('B') local a={"Top","Bottom","Left","Right","Front","Back"} local c={} for b=0,5 do if bit32.extract(_,b,1)==1 then table.insert(c,Enum.NormalId[a[b+1]])end end return Axes.new(unpack(c))end,[15]=function()local _=m('B') local a={"Top","Bottom","Left","Right","Front","Back"} local b={} for c=0,5 do if bit32.extract(_,c,1)==1 then table.insert(b,Enum.NormalId[a[c+1]])end end return Faces.new(unpack(b))end,[16]={PhysicalProperties.new,l[5]and'ddddd'or'fffff'},[17]={NumberRange.new,l[5]and'dd'or'ff'},[18]={UDim.new,l[5]and'di2'or'fi2'},[19]=function()return Ray.new(Vector3.new(m(l[5]and'ddd'or'fff')),Vector3.new(m(l[5]and'ddd'or'fff')))end} for c=1,d do local _=m('B') local b=bit32.band(_,0b11111) local _=(_-b)/0b100000 local a=a[b] if type(a)=='function'then i[c]=a(_,c)else i[c]=a[1](m(a[2]))end end for _,_ in pairs(c)do i[_[1]]=CFrame.fromMatrix(i[_[2]],i[_[3]],i[_[4]])end local a=m(f) local e={} local d={} for a=1,a do local _=i[m(h)] local k local j,g if _=="UnionOperation"then k=DecodeUnion(i,l,m) k.UsePartColor=true elseif _:find("Script")then k=Instance.new("Folder") Script(k,_=='ModuleScript')elseif _=="MeshPart"then k=Instance.new("Part") j=Instance.new("SpecialMesh") j.MeshType=Enum.MeshType.FileMesh j.Parent=k else k=Instance.new(_)end local c=e[m(f)] local _=m(b) local b=m(b) e[a]=k for _=1,_ do local a,b=i[m(h)],i[m(h)] local _=false if j then if a=="MeshId"then j.MeshId=b _=true elseif a=="TextureID"then j.TextureId=b _=true elseif a=="Size"then if not g then g=b else j.Scale=b/g end elseif a=="MeshSize"then if not g then g=b j.Scale=k.Size/b else j.Scale=g/b end _=true end end if(not _)then k[a]=b end end if j then if j.MeshId==''then if j.TextureId==''then j.TextureId='rbxasset://textures/meshPartFallback.png'end j.Scale=k.Size end end for _=1,b do k:SetAttribute(i[m(h)],i[m(h)])end if not c then table.insert(d,k)else k.Parent=c end end local _=m(_) for _=1,_ do local a,_,b=m(f),m(h),m(f) e[a][i[_]]=e[b]end return d end


local Objects = Decode('AADkIQZGb2xkZXIhBE5hbWUhBkltYWdlcyEMQmlsbGJvYXJkR3VpIQZZdWthcmkhDFJlc2V0T25TcGF3bgIhDlpJbmRleEJlaGF2aW9yAwAAAAAAAPA/IQZBY3RpdmUiIRBDbGlwc0Rlc2NlbmRhbnRzIQRTaXplDAAAoEAAAAAAoEAAACEVU3R1ZHNPZmZzZXRXb3Js'
	..'ZFNwYWNlCgAAAAAAAKBAAAAAACEKSW1hZ2VMYWJlbCEESWRsZSEQQmFja2dyb3VuZENvbG9yMwb///8hFkJhY2tncm91bmRUcmFuc3BhcmVuY3khDEJvcmRlckNvbG9yMwYbKjUMAAAgQQAAAAAAQAAAIQdWaXNpYmxlIQVJbWFnZSEraHR0cDovL3d3dy5yb2Jsb3gu'
	..'Y29tL2Fzc2V0Lz9pZD0xMzU5MjQzNjQ4OSEDU2l0DAAAgEAAAAAAAEAAACEraHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0xMzU5MjYyNDQzMyEFT21lZ2EMAACgQAAAAAAAQAAAIStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEzNjAzNzQ1'
	..'NTc5IQRIZWhlDAAAoEAAAAAAgD8AACEYcmJ4YXNzZXRpZDovLzEzNjUwMTI4NDQzIQlTY3JlZW5HdWkhBUxheWVyIQxEaXNwbGF5T3JkZXIDAAAAAABAj0AhDklnbm9yZUd1aUluc2V0IQVGcmFtZSELQW5jaG9yUG9pbnQLAAAAPwAAAD8hCFBvc2l0aW9uDAAAAD8A'
	..'AM3MzD4AAAzXAd09AABqYG8+AAAhF1VJQXNwZWN0UmF0aW9Db25zdHJhaW50IQdzY3Jpb3RzDAAAgD8AAAAAgD8AACEqaHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD00OTk4MjY3NDI4IQRCZXRhIStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lk'
	..'PTEzNTkzODgyOTYxIQVHYW1tYSEraHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0xMzU5Mzg4NDA5MSEFRGVsdGEhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTM1OTM4ODUxNjMhB0Vwc2lsb24hK2h0dHA6Ly93d3cucm9ibG94LmNvbS9h'
	..'c3NldC8/aWQ9MTM1OTM4ODY1MzUhBFpldGEhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTM1OTM4OTE0MDQhA0V0YSEraHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0xMzU5Mzg5MzM2NiEFVGhldGEhK2h0dHA6Ly93d3cucm9ibG94LmNv'
	..'bS9hc3NldC8/aWQ9MTM1OTM4OTQ5NTYhBElvdGEhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTM1OTM4OTc4NDAhBUthcHBhIStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEzNTkzOTAwMzI1IStodHRwOi8vd3d3LnJvYmxveC5jb20v'
	..'YXNzZXQvP2lkPTEzNTkzOTAxMzczIQVBbHBoYSEraHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0xMzU5Mzg3Mjk4NSELQm90dG9tTGFiZWwhCVRleHRMYWJlbAsAAAAAAACAPwwAAAAAAACamVk/AAAMAACAPwAAAAAAACMAIQRGb250AwAAAAAAAFlAIQRU'
	..'ZXh0ITFJIGNhbiB0YXN0ZSB0aGUgZXNzZW5zZSBvZiB5b3VyIHNvdWwgaXQgaXMgc3dlZXQuIQpUZXh0Q29sb3IzBouLiyEKVGV4dFNjYWxlZCEIVGV4dFNpemUDAAAAAAAALEAhFlRleHRTdHJva2VUcmFuc3BhcmVuY3kDAAAAAAAAAAAhC1RleHRXcmFwcGVkIQRS'
	..'aW5nDAAAIEEAAAAAIEEAAAoAAAAAAACgQAAAoEAhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTM2MDMxMDExNDQhBlN0YXRpYyEraHR0cDovL3d3dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0xMzYwMzIyMjEzMyENSW1hZ2VSZWN0U2l6ZQsAACBEAADw'
	..'QyEJU2NhbGVUeXBlAwAAAAAAABBAIQRCYWxsCgAAAAAAAKBAAAAgQiEFdTAwMWEMAAAgQQAAAACAPwAAIStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEzNjEyMzg0NDg4IQdFeHBsb2RlDAAAoEIAAAAANEIAAAoAAAAAAACgQAAAXEIhK2h0dHA6Ly93'
	..'d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTM2MTI1NjI2OTchBUZsYXNoAwAAAAAAcJdAIQ9Cb3JkZXJTaXplUGl4ZWwhA1dpbiEFSSBXSU4MAAAAAAAAmpmZPgAAIQZcVTAwMUEG6OjoIQpVSUdyYWRpZW50IQVDb2xvcigCAAAAAP///wAAgD/Q0/8hCFJvdGF0aW9u'
	..'AwAAAAAAgFbAIQJLTwMAAAAAAPS6QCEGRnJhbWVzDAAAAAAAAMP1KL4AAAwAAIA/AAA1Xqo/AAAhATAhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5MTk4OTYhATEhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5MjA5'
	..'NzIhATIhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5MjE4MDkhATMhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5MjI2NjghATQhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5MjM1NTUhATUh'
	..'K2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5MjQ3OTMhATYhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5NDE4MzEhATchK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5NDI3NTEhATghK2h0dHA6'
	..'Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5NDM2MzkhATkhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5NDQ2NDEhAjEwIStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEwODYyOTQ1NTQyIQIxMiEraHR0cDovL3d3'
	..'dy5yb2Jsb3guY29tL2Fzc2V0Lz9pZD0xMDg2Mjk2NTg4MiECMTEhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5NjQ4NjchAjEzIStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEwODYyOTY5MzI3IQIxNyEraHR0cDovL3d3dy5y'
	..'b2Jsb3guY29tL2Fzc2V0Lz9pZD0xMDg2Mjk4MjIwOCECMTQhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5NzI3NTYhAjE1IStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEwODYyOTczODAxIQIxNiEraHR0cDovL3d3dy5yb2Js'
	..'b3guY29tL2Fzc2V0Lz9pZD0xMDg2Mjk4MTM4NyECMTghK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjI5ODMyMDAhAjE5IStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEwODYyOTg0MTAwIQIyMCEraHR0cDovL3d3dy5yb2Jsb3gu'
	..'Y29tL2Fzc2V0Lz9pZD0xMDg2Mjk4NTI0OCECMjEhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjMwMDk0MzQhAjIyIStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEwODYzMDExMDY2IQIyMyEraHR0cDovL3d3dy5yb2Jsb3guY29t'
	..'L2Fzc2V0Lz9pZD0xMDg2MzAxMjE1MiECMjQhK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjMwMTMyMjEhAjI1IStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEwODYzMDE0OTIwIQIyNiEraHR0cDovL3d3dy5yb2Jsb3guY29tL2Fz'
	..'c2V0Lz9pZD0xMDg2MzAyMDk2NiECMjchK2h0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MTA4NjMwMjI2OTchAjI4IStodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTEwODYzMDI0ODIwIQZBdHRhY2sMAAAAAAAAmpkZPgAAIRRBbGl2ZSBGbGFn'
	..'IFRhbXBlcmluZyEGU291bmRzIQVTb3VuZCEDQkdNIQdTb3VuZElkIRxyYnhhc3NldGlkOi8vMTM5MDE4NDkzNzY3MDIzIQVJbnRybyEbcmJ4YXNzZXRpZDovLzg0MjcyMzUwMTY3NDMyIQxTZWVZb3VJbkhlbGwhG3JieGFzc2V0aWQ6Ly84MzkwMzA2NjE5Mjc5OSEG'
	..'Vm9sdW1lAwAAAAAAAABAIQVMYXVnaCEbcmJ4YXNzZXRpZDovLzk2MTUwNTgzMDAzMTU2IQ1BaGhNdWNoQmV0dGVyIRhyYnhhc3NldGlkOi8vMTM1OTAyNzUzNDMhG3JieGFzc2V0aWQ6Ly83NjY4MjgxMzgyNDU3OCEXcmJ4YXNzZXRpZDovLzkwNjAzNzgwMzYDAAAA'
	..'AAAACEAhBERpbmchDVBsYXliYWNrU3BlZWQDAAAAQDMz4z8hHHJieGFzc2V0aWQ6Ly8xMjA1NTY0MzIzNTMxMzchHHJieGFzc2V0aWQ6Ly8xMzgxNjQwNjg2NDI0NTMhDVN0YXJ0QW1iaWVuY2UhG3JieGFzc2V0aWQ6Ly85OTI2Nzc2ODg3MTEwOSEEVG9vbCEKV29y'
	..'bGRQaXZvdATc4+QhBFBhcnQhBkhhbmRsZSENQm90dG9tU3VyZmFjZSEGQ0ZyYW1lCs3MjL+TACBAAAAAPwoAAIA/AACAPwAAgD8hClRvcFN1cmZhY2UhDFRyYW5zcGFyZW5jeSEFR3VpVUkhC0Fsd2F5c09uVG9wDAAAwEAAAAAAwEAAAAoAAIA/AAAAAAAAAAAKAAAA'
	..'AAAAgD8AAAAAUwEAAAABAQEAAgMEAgcAAgUGBwgJCgsMCw0ODxARAwcAAhITFBUJFhcNGBkHGhsRAwcAAhwTFBUJFhcNHRkHGh4RAwcAAh8TFBUJFhcNIBkHGiERAwcAAiITFBUJFhcNIxkHGiQlAgUAAiYGBwgJJygpCyoIBgArLBMUFQkWFy0uDS8wCQAAEQkHAAIx'
	..'ExQVCRYXDTIZBxozEQkHAAI0ExQVCRYXDTIZBxo1EQkHAAI2ExQVCRYXDTIZBxo3EQkHAAI4ExQVCRYXDTIZBxo5EQkHAAI6ExQVCRYXDTIZBxo7EQkHAAI8ExQVCRYXDTIZBxo9EQkHAAI+ExQVCRYXDTIZBxo/EQkHAAJAExQVCRYXDTIZBxpBEQkHAAJCExQVCRYX'
	..'DTIZBxpDEQkHAAJEExQVCRYXDTIZBxpFEQkGAAIfExQVCRYXDTIaRhEJBwACRxMUFQkWFw0yGQcaSCUCBQACSQYHCAknKCkLShcNACtLExQVCRYXLUwNTU5PUFFSU1QLVVZXWFkLBAIHAAJaBgcICQoLDAsNWw9cERkFABMUFQkWFw0gGl0EAgYAAl4GBwgJCgsMCw1b'
	..'ERsHABMUFQkWFw0yGl9gYWJjBAIHAQJkBgcICQoLDAsNDg9lZgsRHQUAExQVCRYXDWcaaAQCBwACaQYHCAkKCwwLDWoPaxEfBQATFBUJFhcNIBpsJQIFAAJtBgcICSduKQsqIQUAExQVCRYXb1gNMiUCBAACcAYHCAkpC0ojDQACcRMUFQkWFy1yDU1OT1BzUnRUC1VW'
	..'V1hZC3UkAgB2d3h5JQIFAAJ6BgcICSd7KQsqJgYAAnwTFBUJFhctfQ1+EScIAAJ/ExQVCRYXb1gNMhkHGoARJwgAAoETFBUJFhdvWA0yGQcaghEnCAACgxMUFQkWF29YDTIZBxqEEScIAAKFExQVCRYXb1gNMhkHGoYRJwgAAocTFBUJFhdvWA0yGQcaiBEnCAACiRMU'
	..'FQkWF29YDTIZBxqKEScIAAKLExQVCRYXb1gNMhkHGowRJwgAAo0TFBUJFhdvWA0yGQcajhEnCAACjxMUFQkWF29YDTIZBxqQEScIAAKRExQVCRYXb1gNMhkHGpIRJwgAApMTFBUJFhdvWA0yGQcalBEnCAAClRMUFQkWF29YDTIZBxqWEScIAAKXExQVCRYXb1gNMhkH'
	..'GpgRJwgAApkTFBUJFhdvWA0yGQcamhEnCAACmxMUFQkWF29YDTIZBxqcEScIAAKdExQVCRYXb1gNMhkHGp4RJwgAAp8TFBUJFhdvWA0yGQcaoBEnCAACoRMUFQkWF29YDTIZBxqiEScIAAKjExQVCRYXb1gNMhkHGqQRJwgAAqUTFBUJFhdvWA0yGQcaphEnCAACpxMU'
	..'FQkWF29YDTIZBxqoEScIAAKpExQVCRYXb1gNMhkHGqoRJwgAAqsTFBUJFhdvWA0yGQcarBEnCAACrRMUFQkWF29YDTIZBxquEScIAAKvExQVCRYXb1gNMhkHGrARJwgAArETFBUJFhdvWA0yGQcashEnCAACsxMUFQkWF29YDTIZBxq0EScIAAK1ExQVCRYXb1gNMhkH'
	..'GrYRJwgAArcTFBUJFhdvWA0yGQcauCUCBQACuQYHCAknKCkLSkUMABMUFQkWFy26DU1OT1C7UlNUC1VWV1hZCwEBAQACvL1HAgACvr/AvUcCAALBv8K9RwMAAsO/xMXGvUcCAALHv8i9RwIAAsm/yr1HAgACXr/LvUcDAAK5v8zFzb1HAwACzs/Qv9G9RwIAAmm/0r1H'
	..'AgAC07/U2AAHAALZ2ljb1y3cDd3eWN8JBFIGAALgCAkKC+ELDAsN4gA=')
script = Objects[1]

local u001atool = Instance.new("Tool")
u001atool.Name = "\\u001A"
u001atool.Grip = CFrame.new(0,-1,2)
u001atool.ToolTip = "See you in hell."
local handle = Instance.new("Part", u001atool)
handle.Name = "Handle"
handle.Size = Vector3.one*6
handle.Transparency = 1
local ui = Instance.new("BillboardGui", handle)
ui.Name = "GuiUI"
ui.Size = UDim2.fromScale(6, 6)
ui.AlwaysOnTop = true
u001atool.Parent = owner.Backpack

script.Sounds.AhhMuchBetter.SoundId = "rbxassetid://118898615299963"

script.Images.BottomText.TextLabel.FontFace = Font.new("rbxassetid://12187366846", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
script.Images.Attack.TextLabel.FontFace = Font.new("rbxassetid://12187366846", Enum.FontWeight.Regular, Enum.FontStyle.Italic)


for i, v in next, script:GetDescendants() do
	if(v:IsA("ImageLabel"))then
		v.ResampleMode = Enum.ResamplerMode.Pixelated
	end
end

local _starttime = os.clock()

local plrs = game:GetService("Players")
local lighting = game:GetService("Lighting")
local contentprovider = game:GetService("ContentProvider")
local httpservice = game:GetService("HttpService")
local runservice = game:GetService("RunService")
local rs = game:GetService("ReplicatedStorage")
local pps = game:GetService("ProximityPromptService")
local tweenservice = game:GetService("TweenService")
local debris = game:GetService("Debris")

local antideath = function(a)
	return a
end

local playergui = u001atool.Handle.GuiUI
local screenguicontainer = playergui

local images = {}
local sounds = {}
for _, v in script.Images:GetChildren() do
	images[v.Name] = v:Clone()
end
for _, v in script.Sounds:GetChildren() do
	sounds[v.Name] = v:Clone()
end
script.Images:Destroy()
script.Sounds:Destroy()

local function getimageid(name)
	return images[name].Image
end

local function newimage(name)
	if not images[name] then return end
	return images[name]:Clone()
end

local function getsoundid(name)
	if not sounds[name] then return end
	return sounds[name].SoundId
end

local function newsound(name, parent, volume)
	local sound = sounds[name]:Clone()
	sound.Parent = parent
	if volume then
		sound.Volume = volume
	end
	return sound
end

local function screenguitoframe(screengui)
	local frame = Instance.new("Frame")
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.new(1, 0, 1, 0)

	for _, v in screengui:GetChildren() do
		v:Clone().Parent = frame
	end
	return frame
end

local function getruntime()
	return os.clock() - _starttime
end


-- yukari

local OFFSETS = {
	Idle = { Vector3.new(-0.65, 0, 0), Vector3.new(0.65, 0, 0) },
	Sit = { Vector3.new(-0.5, 0, 0), Vector3.new(0.5, 0, 0) }
}

local fullscreenbillboards = {}

local yukari = antideath(images.Yukari:Clone())
local idlespritesheet = yukari.Idle
local sitspritesheet = yukari.Sit
local omegaspritesheet = yukari.Omega
local winspritesheet = yukari.Hehe

local colorcorrection = antideath(Instance.new("ColorCorrectionEffect"))
local backgroundstatic = antideath(newimage("Static"))
local bgm = antideath(Instance.new("Sound"))
table.insert(fullscreenbillboards, backgroundstatic)

backgroundstatic.ImageLabel.ImageTransparency = 0.85
bgm.Volume = 1
bgm.Looped = true

local yukariposition = Vector3.new(0, 0, 0)
local yukaristate = "idle"

yukari.Adornee = u001atool
yukari.StudsOffsetWorldSpace = yukariposition

idlespritesheet.Visible = true

local descendtime = getruntime()
local sittime = getruntime()
local wintime = getruntime()
local laststaticchangetime = getruntime()

local function getfullscreen()
	return Vector3.zero, UDim2.fromScale(6, 6)
end

runservice.Heartbeat:Connect(function()
	local currenttime = getruntime()

	local row = 0
	local offset = Vector3.zero

	if yukaristate == "idle" then
		local idleframe = math.floor(currenttime*10)%10
		idlespritesheet.Position = UDim2.new(-idleframe, 0, row, 0)
		idlespritesheet.Visible = true
		sitspritesheet.Visible = false
		omegaspritesheet.Visible = false
		winspritesheet.Visible = false
		offset = OFFSETS.Idle[1]
	elseif yukaristate == "sit" then
		local sitframe = math.min(math.floor((currenttime - sittime)*10), 3)
		sitspritesheet.Position = UDim2.new(-sitframe, 0, row, 0)
		idlespritesheet.Visible = false
		sitspritesheet.Visible = true
		omegaspritesheet.Visible = false
		winspritesheet.Visible = false
		offset = OFFSETS.Sit[1]
	elseif yukaristate == "win" then
		local frame = math.min(math.floor((currenttime - wintime)*10), 4)
		winspritesheet.Position = UDim2.new(-frame, 0, 0, 0)
		idlespritesheet.Visible = false
		sitspritesheet.Visible = false
		omegaspritesheet.Visible = false
		winspritesheet.Visible = true
		offset = Vector3.zero
	end

	if currenttime - laststaticchangetime > 0.1 then
		laststaticchangetime = currenttime
		backgroundstatic.ImageLabel.ImageRectOffset = Vector2.new(math.random(-100, 100), math.random(-100, 100))
	end

	yukari.StudsOffset = offset
	colorcorrection.Saturation = -math.min((currenttime - descendtime)/5, 1)

	local pos, size = getfullscreen()
	for _, billboard in fullscreenbillboards do
		billboard.Size = size
	end
end)


local attackgui = antideath(screenguitoframe(images.Attack:Clone()))


local introcoroutine
local introcontainer
local introballrenderstepped

local omegacoroutine
local omegastatic

local wincoroutine
local wincontainer

local function layerimage(layer)
	local gui = screenguitoframe(newimage("Layer"))
	local image

	for _, v in gui.Frame:GetChildren() do
		if not v:IsA("ImageLabel") then continue end
		if v.Name == layer then
			image = v
			continue
		end
		v:Destroy()
	end

	if image then
		debris:AddItem(gui, 2.5)
		
		u001atool.TextureId = image.Image

		gui.Parent = playergui
		image.Visible = true
		image.ImageTransparency = 1
		tweenservice:Create(image, TweenInfo.new(0.5), { ImageTransparency = 0 }):Play()
		task.spawn(function()
			task.wait(2)
			tweenservice:Create(image, TweenInfo.new(0.5), { ImageTransparency = 1 }):Play()
		end)
	else
		gui:Destroy()
	end
end

local function INTRO()
	introcontainer = screenguitoframe(Instance.new("ScreenGui"))
	introcontainer.Parent = playergui

	local bb = newimage("Ring")
	local image = bb.ImageLabel
	bb.StudsOffsetWorldSpace = yukariposition
	bb.Adornee = u001atool.Handle
	bb.Parent = u001atool

	local ball = newimage("Ball")
	local ballimage = ball.ImageLabel
	ball.StudsOffsetWorldSpace = yukariposition
	ball.Adornee = u001atool.Handle
	ball.Parent = introcontainer

	task.spawn(function()
		for y = 0, 1 do
			for x = 0, 4 do
				image.Position = UDim2.new(-x, 0, -y, 0)
				task.wait(1/60)
			end
		end
		pcall(game.Destroy, bb)
	end)

	introballrenderstepped = runservice.Heartbeat:Connect(function()
		local frame = math.floor((getruntime() - descendtime)*30)%10
		ballimage.Position = UDim2.new(-frame, 0, 0, 0)
	end)

	bgm.Parent = u001atool.Handle
	bgm.SoundId = getsoundid("StartAmbience")
	bgm.Playing = true
	bgm.TimePosition = 0
	
	local currentthread = coroutine.running()
	-- coroutines used cus i wanna be able to cancel it the easy way lol
	introcoroutine = coroutine.create(function()
		task.wait(1)

		local label = screenguitoframe(newimage("BottomLabel"))
		label.TextLabel.Text = "I can taste the essense of your soul it is sweet."
		label.Parent = introcontainer

		local vl = newsound("Intro")
		vl.Parent = u001atool.Handle
		vl:Play()

		debris:AddItem(label, 8.255)
		debris:AddItem(vl, 8.255)
		task.wait(8.255)

		local explodesound = newsound("Explode", u001atool.Handle)
		explodesound:Play()
		debris:AddItem(explodesound, 1.6)

		introballrenderstepped:Disconnect()
		introballrenderstepped = nil
		pcall(game.Destroy, ball)

		local explosion = newimage("Explode")
		local explodeimage = explosion.ImageLabel
		explosion.Adornee = u001atool.Handle
		explosion.StudsOffsetWorldSpace = yukariposition
		explosion.Parent = introcontainer

		local explodescreen = screenguitoframe(newimage("Flash"))
		local frame = explodescreen.Frame
		explodescreen.Parent = introcontainer

		tweenservice:Create(frame, TweenInfo.new(0.5), {
			BackgroundTransparency = 0
		}):Play()

		bgm.Playing = false
		for y = 0, 1 do
			for x = 0, 4 do
				explodeimage.Position = UDim2.new(-x, 0, -y, 0)
				task.wait(1/20)
			end
		end

		task.wait(0.5)
		pcall(game.Destroy, explosion)

		backgroundstatic.Parent = u001atool.Handle
		yukari.Parent = u001atool.Handle

		tweenservice:Create(frame, TweenInfo.new(0.5), {
			BackgroundTransparency = 1
		}):Play()

		task.wait(0.5)
		pcall(game.Destroy, explodescreen)

		task.wait(1)

		bgm.Parent = u001atool.Handle
		bgm.SoundId = getsoundid("BGM")
		bgm.Playing = true
		bgm.TimePosition = 0

		pcall(game.Destroy, introcontainer)
		introcontainer = nil
		
		coroutine.resume(currentthread)
	end)

	coroutine.resume(introcoroutine)
	coroutine.yield()
end


local function OMEGA()
	yukaristate = ""
	sittime = getruntime()
	descendtime = getruntime() - 6

	yukari.Parent = u001atool.Handle
	pcall(function()
		colorcorrection.Parent = nil
	end)
	backgroundstatic.Parent = u001atool.Handle

	bgm.Playing = false
	bgm.Parent = nil

	idlespritesheet.Visible = false
	sitspritesheet.Visible = false
	omegaspritesheet.Visible = true

	omegacoroutine = coroutine.create(function()
		local staticsound = newsound("Static", u001atool.Handle)
		for y = 0, 1 do
			for x = 0, 4 do
				omegaspritesheet.Position = UDim2.new(-x, 0, -y, 0)
				if x == 3 and y == 0 then
					task.wait(1)
				elseif x == 1 and y == 1 then
					local static = newimage("Static")
					local image = static.ImageLabel
					local staticstarttime = getruntime()
					static.StudsOffset = Vector3.new(0, 0, -500)
					static.Adornee = u001atool.Handle
					static.Parent = u001atool.Handle

					omegastatic = static

					local pos, size = getfullscreen()
					static.StudsOffsetWorldSpace = pos
					static.Size = size
					table.insert(fullscreenbillboards, static)

					staticsound:Play()
					debris:AddItem(staticsound, 1)

					pcall(function()
						colorcorrection.Parent = lighting
					end)

					for _, gui in playergui:GetChildren() do
						local bg = gui:FindFirstChild("BG", true)
						if bg and bg:IsA("ImageLabel") and bg.Image == "rbxassetid://11096220259" then
							pcall(game.Destroy, gui)
						end
					end

					repeat
						task.wait()
						image.ImageRectOffset = Vector2.new(math.random(-100, 100), math.random(-100, 100))
					until getruntime() - staticstarttime > 0.5
					table.remove(fullscreenbillboards, table.find(fullscreenbillboards, static))
					pcall(game.Destroy, static)
					omegastatic = nil
				else
					task.wait(0.1)
				end
			end
		end

		sittime = getruntime()
		yukaristate = "sit"

		local vl = newsound("AhhMuchBetter", u001atool.Handle)
		vl:Play()
		debris:AddItem(vl, 4)

		local label = newimage("BottomLabel")
		label.TextLabel.Text = "Ahh... much better..."
		label.Parent = playergui
		debris:AddItem(label, 3)

		task.wait(3)

		local ding = newsound("Ding", u001atool.Handle)
		ding.Pitch = 0.4
		ding:Play()
		debris:AddItem(ding, 3)

		attackgui.Parent = screenguicontainer
		attackgui.TextLabel.Text = "Tranquility"
		layerimage("Omega")
	end)

	coroutine.resume(omegacoroutine)
end


local function ASCEND()
	if introcoroutine then
		coroutine.close(introcoroutine)
		introcoroutine = nil
	end
	if omegacoroutine then
		coroutine.close(omegacoroutine)
		omegacoroutine = nil
	end
	if wincoroutine then
		coroutine.close(wincoroutine)
		wincoroutine = nil
	end
	if introballrenderstepped then
		introballrenderstepped:Disconnect()
		introballrenderstepped = nil
	end
	if omegastatic then
		local idx = table.find(fullscreenbillboards, omegastatic)
		if idx then
			table.remove(fullscreenbillboards, idx)
		end
		pcall(game.Destroy, omegastatic)
		omegastatic = nil
	end
	if introcontainer then
		pcall(game.Destroy, introcontainer)
		introcontainer = nil
	end
	if wincontainer then
		pcall(game.Destroy, wincontainer)
		wincontainer = nil
	end

	yukaristate = "idle"
	bgm.Playing = false

	attackgui.Parent = nil
	pcall(function()
		colorcorrection.Parent = nil
	end)

	for _, v in playergui:GetChildren() do
		if v:GetAttribute("u001a") then
			pcall(game.Destroy, v)
		end
	end
end

local methods = {}

methods.DESCEND = function(data)	
	yukaristate = "idle"
	descendtime = getruntime()
	colorcorrection.Saturation = 0
	pcall(function()
		colorcorrection.Parent = lighting
	end)

	if typeof(data.POSITION) == "Vector3" then
		yukariposition = data.POSITION
		yukari.StudsOffsetWorldSpace = data.POSITION
	end

	local ding = newsound("Ding", u001atool.Handle)
	ding:Play()
	debris:AddItem(ding, 2.1)

	if data.OMEGA then
		OMEGA()
	else
		INTRO()
	end
end

methods.ASCEND = ASCEND

methods.ATTACK = function(data)
	local attacksound = newsound("Attack", u001atool.Handle)
	attacksound:Play()
	debris:AddItem(attacksound, 1.7)

	if typeof(data.ATTACKNAME) == "string" then
		attackgui.Parent = screenguicontainer
		attackgui.TextLabel.Text = data.ATTACKNAME

		local ding = newsound("Ding", u001atool.Handle)
		ding:Play()
		debris:AddItem(ding, 2.1)
	end

	if typeof(data.LAYER) == "string" then
		local ding = newsound("Ding", u001atool.Handle)
		ding.Pitch = 0.4
		ding:Play()
		debris:AddItem(ding, 2.1)

		layerimage(data.LAYER)
	end
end

methods.KO = function(data)
	-- See you in hell.
	wincontainer = screenguitoframe(Instance.new("ScreenGui"))
	wincontainer.Parent = playergui

	if typeof(data.WINMUSIC) ~= "string" then
		data.WINMUSIC = "Win1"
	end

	bgm.SoundId = getsoundid(data.WINMUSIC)
	bgm.Playing = true
	bgm[1].TimePosition = 0

	local laugh = newsound("Laugh")
	laugh.Parent = wincontainer
	laugh:Play()
	debris:AddItem(laugh, 3)

	local attack = newsound("Attack")
	attack.Parent = wincontainer
	attack:Play()
	debris:AddItem(attack, 1.7)

	local koscreen = screenguitoframe(newimage("KO"))
	local koframes = {}

	for i, frame in koscreen.Frames:GetChildren() do
		koframes[tonumber(frame.Name) + 1] = frame
	end
	koscreen.Parent = wincontainer

	local flash = screenguitoframe(newimage("Flash"))
	local flashframe = flash.Frame

	flash.Parent = wincontainer

	task.spawn(function()
		for i = 1, 6 do
			flashframe.BackgroundTransparency = i%2 == 0 and 0 or 0.25
			task.wait(0.05)
			flashframe.BackgroundTransparency = 1
			task.wait(0.05)
		end
	end)

	wincoroutine = coroutine.create(function()
		local previousframe
		for i, frame in koframes do
			frame.Visible = true
			if previousframe then
				previousframe.Visible = false
			end
			previousframe = frame
			task.wait(1/60)
		end

		task.wait(2)
		pcall(game.Destroy, koscreen)

		wintime = getruntime()
		yukaristate = "win"

		local vl = newsound("SeeYouInHell")
		vl.Parent = wincontainer
		vl:Play()

		local winlabel = screenguitoframe(newimage("Win"))
		winlabel.Parent = wincontainer

		task.wait(0.9)

		local bottomlabel = screenguitoframe(newimage("BottomLabel"))
		bottomlabel.TextLabel.Text = "See you in hell."
		bottomlabel.Parent = wincontainer
	end)

	coroutine.resume(wincoroutine)
end

local lastko = tick()
local function koscreen()
	if(tick() - lastko < .2)then return end
	lastko = tick()
	
	local wincontainer = screenguitoframe(Instance.new("ScreenGui"))
	wincontainer.Parent = playergui
	
	local attack = newsound("Attack")
	attack.Parent = u001atool.Handle
	attack:Play()
	debris:AddItem(attack, 1.7)
	
	local snd = newsound("Laugh", u001atool.Handle, 1)
	snd.PlayOnRemove = true
	snd:Play()
	
	local koscreen = screenguitoframe(newimage("KO"))
	local koframes = {}

	for i, frame in koscreen.Frames:GetChildren() do
		koframes[tonumber(frame.Name) + 1] = frame
	end
	koscreen.Parent = wincontainer

	local flash = screenguitoframe(newimage("Flash"))
	local flashframe = flash.Frame

	flash.Parent = wincontainer

	task.spawn(function()
		for i = 1, 6 do
			flashframe.BackgroundTransparency = i%2 == 0 and 0 or 0.25
			task.wait(0.05)
			flashframe.BackgroundTransparency = 1
			task.wait(0.05)
		end
	end)
	
	local previousframe
	for i, frame in koframes do
		frame.Visible = true
		if previousframe then
			previousframe.Visible = false
		end
		previousframe = frame
		task.wait(1/60)
	end

	task.wait(2)
	pcall(game.Destroy, wincontainer)
end

bgm.SoundId = getsoundid("BGM")
bgm.Playing = false
bgm.Parent = nil

backgroundstatic.Parent = nil

local layer = 1
local function supernull(depth, f, ...)
	if(depth >= 80)then
		return f(...)
	end
	task.defer(supernull, depth+1, f, ...)
end

local function hypernull(f, ...)
	if(coroutine.status(task.spawn(hypernull, f, ...)) ~= "dead")then
		return f(...)
	end
end

Layers = {
	{
		"Alpha",
		"Instant Death Projectile",
		function(part)
			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health > 0)then
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"):TakeDamage(9e9)
				return true
			end
		end
	},
	{
		"Beta",
		"PalNO Tampering",
		function(part)
			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"))then
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"):Destroy()
				return true
			end
		end
	},
	{
		"Gamma",
		"F1",
		function(part)
			part:Destroy()
			return true
		end
	},
	{
		"Delta",
		"Alive Flag Tampering",
		function(part)
			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health > 0)then
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, true)
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health = 0
				return true
			end
		end
	},
	{
		"Epsilon",
		"Life Tampering",
		function(part)
			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health > 0)then
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health = 0
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").MaxHealth = 0
				return true
			end
		end
	},
	{
		"Zeta",
		"Defense Penetrator",
		function(part)
			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildWhichIsA("JointInstance", true))then
				part:FindFirstAncestorOfClass("Model"):BreakJoints()
				return true
			end
		end
	},
	{
		"Eta",
		"Forced Defense Penetrator",
		function(part)
			local did = false
			
			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildWhichIsA("JointInstance", true))then
				part:FindFirstAncestorOfClass("Model"):BreakJoints()
				did = true
			end
			
			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health > 0)then
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health = 0
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").MaxHealth = 0
				
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, true)
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
				did = true
			end
			
			if(did)then
				return true
			end
		end
	},
	{
		"Theta",
		"Frozen Direct Death",
		function(part)
			part.Anchored = true
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
			
			local did = false
			
			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildWhichIsA("JointInstance", true))then
				part:FindFirstAncestorOfClass("Model"):BreakJoints()
				did = true
			end

			if(part:FindFirstAncestorOfClass("Model") and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid")  and part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health > 0)then
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").Health = 0
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid").MaxHealth = 0

				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, true)
				part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead)
				did = true
			end
			
			if(did)then
				return true
			end
		end
	},
	{
		"Iota",
		"Player Delete",
		function(part)
			if(part:FindFirstAncestorOfClass("Model"))then
				part:FindFirstAncestorOfClass("Model"):Destroy()
				return true
			end
		end
	},
	{
		"Kappa",
		"Full System Execution",
		function(part)
			for i, v in next, Layers do
				pcall(v[3], part)
			end
			return true
		end,
	}
}

local firstequip = true
local isequipped = false
u001atool.Equipped:Connect(function()
	if(firstequip)then
		firstequip = false
		methods.DESCEND({})
	else
		bgm.Parent = u001atool.Handle
		bgm.Playing = true
		colorcorrection.Saturation = -1
		pcall(function()
			colorcorrection.Parent = lighting
		end)
	end
	
	if(not Layers[layer])then
		layer = 1
	end
	
	methods.ATTACK({
		ATTACKNAME = Layers[layer][2],
		LAYER = Layers[layer][1]
	})

	isequipped = true
end)

u001atool.Unequipped:Connect(function()
	isequipped = false
	
	methods.ASCEND()
	local snd = newsound("SeeYouInHell", u001atool.Handle, 2)
	snd.PlayOnRemove = true
	snd:Play()
end)

u001atool.Activated:Connect(function()
	if(not isequipped)then return end
	
	layer += 1
	if(layer > #Layers)then
		methods.ASCEND()
		methods.DESCEND({OMEGA = true})
		layer = 0
	end
	
	if(layer == 1)then
		bgm.Parent = u001atool.Handle
		methods.ASCEND()
		
		bgm.Playing = true
		colorcorrection.Saturation = -1
		pcall(function()
			colorcorrection.Parent = lighting
		end)
	end
	
	if(not Layers[layer])then return end
	
	methods.ATTACK({
		ATTACKNAME = Layers[layer][2],
		LAYER = Layers[layer][1]
	})
end)

local params = OverlapParams.new()
params.BruteForceAllSlow = true
params.FilterDescendantsInstances = {owner.Character, u001atool}

local touchfunction = function(v)
	if(not isequipped)then return end
	if(not Layers[layer])then return end
	
	if(v:IsDescendantOf(owner.Character) and v ~= u001atool and not v:IsDescendantOf(u001atool) or v.Name:lower() == "baseplate" or v.Name:lower() == "base")then return end
	
	local attack = Layers[layer][3]
	if(not attack)then return end
	
	if(layer == 10)then
		hypernull(function()
			local succ, ret = pcall(attack, v)
			if(ret == true)then
				koscreen()
			end
		end)
		return
	end
	
	local succ, ret = pcall(attack, v)
	if(ret == true)then
		koscreen()
	end
end
local touchevent = u001atool.Handle.Touched:Connect(touchfunction)

game:GetService("RunService").PostSimulation:Connect(function()
	if(not isequipped)then return end
	if(not Layers[layer])then return end
	
	supernull(0, function()
		local aoe = workspace:GetPartBoundsInBox(u001atool.Handle.CFrame, u001atool.Handle.Size, params)
		local attack = Layers[layer][3]
		if(not attack)then return end

		local didko = false
		
		if(layer == 10)then
			hypernull(function()
				for i, v in next, aoe do
					if(v.Name:lower() == "baseplate" or v.Name:lower() == "base")then continue end

					local succ, ret = pcall(attack, v)
					if(ret == true and not didko)then
						koscreen()
						didko = true
					end
				end
			end)
			return
		end
		
		for i, v in next, aoe do
			if(v.Name:lower() == "baseplate" or v.Name:lower() == "base")then continue end
			
			local succ, ret = pcall(attack, v)
			if(ret == true and not didko)then
				koscreen()
				didko = true
			end
		end
	end)
end)

game:GetService("RunService").Stepped:Connect(function()
	touchevent:Disconnect()
	touchevent = u001atool.Handle.Touched:Connect(touchfunction)
end)