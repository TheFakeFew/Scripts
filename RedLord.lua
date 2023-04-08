-- Converted using Mokiros's Model to Script Version 3
-- Converted string size: 23324 characters
local function DecodeUnion(Values,Flags,Parse,data)
	local m = Instance.new("Folder")
	m.Name = "UnionCache ["..tostring(math.random(1,9999)).."]"
	m.Archivable = false
	m.Parent = game:GetService("ServerStorage")
	local Union,Subtract = {},{}
	if not data then
		data = Parse('B')
	end
	local ByteLength = (data % 4) + 1
	local Length = Parse('I'..ByteLength)
	local ValueFMT = ('I'..Flags[1])
	for i = 1,Length do
		local data = Parse('B')
		local part
		local isNegate = bit32.band(data,0b10000000) > 0
		local isUnion =  bit32.band(data,0b01000000) > 0
		if isUnion then
			part = DecodeUnion(Values,Flags,Parse,data)
		else
			local isMesh = data % 2 == 1
			local ClassName = Values[Parse(ValueFMT)]
			part = Instance.new(ClassName)
			part.Size = Values[Parse(ValueFMT)]
			part.Position = Values[Parse(ValueFMT)]
			part.Orientation = Values[Parse(ValueFMT)]
			if isMesh then
				local mesh = Instance.new("SpecialMesh")
				mesh.MeshType = Values[Parse(ValueFMT)]
				mesh.Scale = Values[Parse(ValueFMT)]
				mesh.Offset = Values[Parse(ValueFMT)]
				mesh.Parent = part
			end
		end
		part.Parent = m
		table.insert(isNegate and Subtract or Union,part)
	end
	local first = table.remove(Union,1)
	if #Union>0 then
		pcall(function()
			first = first:UnionAsync(Union)
		end)
	end
	if #Subtract>0 then
		pcall(function()
			first = first:SubtractAsync(Subtract)
		end)
	end
	m:Destroy()
	return first
end

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


local Objects = Decode('AEAQAyEGRm9sZGVyIQROYW1lIQVBcm1vciEFTW9kZWwhBVN3b3JkIQpXb3JsZFBpdm90BOQC5QLmAiEOVW5pb25PcGVyYXRpb24hCEFuY2hvcmVkIiEKQnJpY2tDb2xvcgfsAyEGQ0ZyYW1lBBYA5wLmAiEFQ29sb3IG/wAAIQhNYXRlcmlhbAMAAAAAAAByQCELT3Jp'
	..'ZW50YXRpb24KAAAAAAAAtMIAALRCIQhQb3NpdGlvbgoACgDCrrKEQ/bhJ0UhCFJvdGF0aW9uCgAAtMIAALTCAAAAACEEU2l6ZQpCkas/7Rs/PkvNzD4hBFBhcnQKLwurP1sZiz7EzMw+CgEKAMLxsoRD9uEnRQMAAAAAAAAIQAoAAIA/AACAPwAAgD8KAAAAAAAAAAAA'
	..'AAAACgeknz8R5rU+5FG4PgpeCwDCc7iEQ/jhJ0UHTAEEKADoAuUCBnUAAAMAAAAAAABxQAoAALRCAAC0wgAAAAAKAAoAwoDbhEP24SdFCgAAtEIAAAAAAAC0QgpAzow94AAwP8R6Xj8KBwCAPc/MzD7vI+Y+Cv4JAMJV74RD9uEnRQMAAAAAAAAQQAoDAIA9TjqHPnUR'
	..'9T4K0aT+wXDzhEP24SdFCuxRQUIAALTCAAA0QwMAAAAAAAAAQAoDAIA9TTqHPnUR9T4KlcEAwnDzhEP24SdFCuxRQUIAALRCAAA0QwoHAIA9AQAAPwEAAD8K/gkAwt7ehEP24SdFCgMAgD0CAKA+AAAQPwoFSf7BcOOEQ/bhJ0UKAAA0QgAAtMIAADRDCnvvAMJw44RD'
	..'9uEnRQoAADRCAAC0QgAANEMKDv7/PeHMDD8X3Bk/Cv4JAMLyyYRD9uEnRQoF/v892563PrDoJT8KHxv+wXDPhEP24SdFCvYoPkIAALTCAAA0QwoF/v892p63PrLoJT8KbgYBwnDPhEP24SdFCvYoPkIAALRCAAA0QwfHAARJAOYC6QIGY19iAwAAAAAAAJFACgAAAAAA'
	..'ALTCAAA0QwoACgDC3sKEQ/bhJ0UKAAA0wwAAtMIAAAAACgACAD6FA5A/cACAPyEMVXNlUGFydENvbG9yCu7//z35/48+AgDQPgr/uQDC3riEQ/bhJ0UKAAAAAAAAtMIAADTDCu7//z33/x8/BAAAPgr/SQHC3qKEQ/bhJ0UKALT+wd64hEP24SdFCgAAAAAAALRCAAA0'
	..'wwoAlP3B3qKEQ/bhJ0UK7v//Pfj/Hz4CAIA+Cv0T/sHe6IRD9uEnRQoAAAAAAAC0QgAAAAAK+v8fPgAAQD/x//89Cv8JAMLe1IRD9uEnRQoAAAAAAAA0QwAAtEIDAAAAAAAAGEAK/wkBwt7ohEP24SdFCgAAAAAAALTCAAAAAAru//89AQAAPvr/jz4KAMoBwt64hEP2'
	..'4SdFCgAAtMIAALRCAAAAAAru//89AgAAPvr/jz4K/pP8wd64hEP24SdFCu7//z0CAAA+8///PgoAygHC3uqEQ/bhJ0UK7v//PQEAAD7z//8+CvyT/MHe6oRD9uEnRQoAALRCAAC0QgAAAAAKAAAAPgEAAD8AAAA/CgAKAMLd3oRD9uEnRSEEbWlkYiENQm90dG9tU3Vy'
	..'ZmFjZQMAAAAAAAAAAARuAOgC5QIKAAoAwkTdhUP24SdFCgcAQD4AAIA+AACAPiEKVG9wU3VyZmFjZSELU3BlY2lhbE1lc2ghCE1lc2hUeXBlIQpBdHRhY2htZW50Cm5mJj7NzIw+zcyMPgR2AOgC5QIKAAoAwt6+hEP24SdFCjYzMz6cmZk+zswsPwR5AOgC5QIKAAoA'
	..'wt7ehEP24SdFCjczMz6jmZk9NjNzPyEDRXllBH0A6ALlAgoACgDCRN2FQ/biJ0UK3MzMPcvMTD7OzEw+BIEA6ALqAgoAAHDCAAC0QgAANEMKMB4AwoC3hEP24SdFCgAAtMIAAPBBAAC0wgoAAoA9WLOjP2Acez8KAACAPQAAID/+/58+CvYz/cFDxYRD9uEnRQoAAHDC'
	..'AAC0QgAANMMKAACAPf//Hz8BAIA+Cr3RAcLXv4RD9uEnRQoAAIA9AAAgPwAAgD4Kb4T8wde/hEP24SdFCvl5AcJDxYRD9uEnRQoAAHDCAAC0wgAANMMEjgDoAuUCCgAKAMJE3YVD9uAnRSEITWVzaFBhcnQEkgDlAuYCCgAAtEIAADRDAAAAAApoCQDC3lKDQ/XhJ0UK'
	..'AAC0QgAAAAAAADTDCgAAYD8AAEA+AAC8QCEGTWVzaElkIRZyYnhhc3NldGlkOi8vNzk5MTMzOTI3IQhNZXNoU2l6ZQrSeoBCDAKgQVK4AkQhBUJsYWRlCgAAcD8BAAA+AAC+QCEGU3BhcmtzBJ0A6wLnAgoAI0Q+DQhgMoT+A0AhD1BhcnRpY2xlRW1pdHRlciECRTEh'
	..'DEFjY2VsZXJhdGlvbgoAAAAAAAAgQQAAAAAoAgAAAAD/OjoAAIA//wAEIQREcmFnAwAAAAAAABRAIRFFbWlzc2lvbkRpcmVjdGlvbiEHRW5hYmxlZAIhCExpZmV0aW1lEc3MzD7NzEw/IQ1MaWdodEVtaXNzaW9uAwAAAGBmZuY/IQ5MaWdodEluZmx1ZW5jZQMAAAAA'
	..'AADwPyEEUmF0ZQMAAAAAAMByQCEIUm90U3BlZWQRAAC0QwAAtEMRAAC0wwAAtEMpAgAAAAAwPTU+AAAAAAAAgD8AAAAAAAAAACELU3ByZWFkQW5nbGULAABwQQAAcEEhB1RleHR1cmUhFXJieGFzc2V0aWQ6Ly83OTI2MTYzOCEMVHJhbnNwYXJlbmN5KQMAAAAAAACA'
	..'PwAAAAAscso9AAAAAAAAAAAAAIA/AACAPwAAAAAhB1pPZmZzZXQDAAAAAAAA4D8hAkUyKAIAAAAA/0tLAACAP/8ABBHNzMw9zcxMPgMAAAAAAABJQBEAAMjCAADIQhEAADTDAAA0QykCAAAAALJBEz+yQRM/AACAPwAAAAAAAAAAIQVTcGVlZBEAAAAAAAAAACEWcmJ4'
	..'YXNzZXRpZDovLzMxMTM5NTM5MSkDAAAAAAAAgD8AAAAA8IXJPQAAAAAAAAAAAACAPwAAgD8AAAAAIQhTd2luZ0F0MQTJAOsC5wIKAAAAAAAAAACamTlAKAIAAAAA7BoaAACAP/8ABBHNzMw+ZmbmPwMAAAAAAEB/QBEAAAAAAAC0QykDAAAAAIqVHj+KlR4/14FzPwAA'
	..'AAAAAAAAAACAPwAAAAAAAAAAEQAAYEEAAGBBCwAA8EEAAPBBAwAAAAAAADRAEc3MzD2amZk+IQxMb2NrZWRUb1BhcnQDAAAAAAAAaUApAwAAAAAAAAAAAAAAAEvV/j761Zg/dP1xPwAAgD8AAAAAAAAAABEAAKDCAAAAACEWcmJ4YXNzZXRpZDovLzQ0Njc4NzQ5NCkD'
	..'AAAAAAAAgD8AAAAAAAAAPwAAAAAAAAAAAACAPwAAgD8AAAAAIQhTd2luZ0F0MgTbAOsC5wIKAAAAAAAAAACamRnABHYA5gLpAgqZmxk+uDaTP6Mzgz8KKJkZPhgzkz4vM9U+CmW+AMKltIRD9uEnRQoomRk+GY4jPzQzAz4K/1EBwiiehEP24SdFCjOr/sGltIRD9uEn'
	..'RQoAhP3BKJ6EQ/bhJ0UKKZkZPhuOIz4xM4M+CjAH/sG25YRD9uEnRQocjiM+x8xEPyqZGT4K/wkAwkTRhEP24SdFCmUQAcK25YRD9uEnRQoomRk+MDMDPhkzkz4KM9UBwqW0hEP24SdFCimZGT4yMwM+GTOTPgqYffzBpbSEQ/bhJ0UKKZkZPjIzAz4V2AI/CjPVAcLB'
	..'54RD9uEnRQoomRk+MDMDPhXYAj8Kln38wcHnhEP24SdFCjOZGT4xMwM/GtgCPwoACgDCfNuEQ/bhJ0UHGgAE9wDnAuUCBhsqNQoAAAAAAAAAAAAAtEIKAAoAwkQRhUP24SdFChgAgD3//z8+AABAPgT6AOcC5QIKAAoAwkS1hUP24SdFBPwA5QLmAgpoCQDC3laDQ/Xh'
	..'J0UK//8/PwAAgD7//7lABP8A5wLlAgoACgDCRMGFQ/bhJ0UKDAAAPjMzMz4zMzM+BAIB5wLlAgoACgDCRE2FQ/bhJ0UKZ2YOQDEzMz5kZiY+BAUB5wLlAgoACgDCRAWFQ/bhJ0UhBkhhbmRsZQQJAeYC5QIDAAAAAACAlEAKAAoAwkRjhUP24SdFCgAAtMIAAAAAAAC0'
	..'QgoAAIA9AACAPQAAgD0EDQHnAuYCCgAKAMKukoRD9uEnRQpCkas/7Rs/Pn4AwD4KLwurP1sZiz7//78+CgEKAMLxkoRD9uEnRQoHpJ8/Eea1PszMrD4KSQsAwnOYhEP44SdFBBQB6ALlAgoACgDCjP2FQ/bhJ0UKQM4MPgAazD4paBY/CtTMDD7JzMw9yswUPwoKRQDC'
	..'8/2FQ/bhJ0UK1MwMPsvMzD3MzBQ/Cuyd/8Hz/YVD9uEnRQrUzAw+/v//PZmZyT4K6UIAwlvyhUP24SdFCgAAlkIAALRCAAAAAArUzAw+/P//PcvMbD4KDGH/waTqhUP24SdFCgAAcEIAALTCAAAAAArUzAw+/f//PcvMbD4KemMAwqTqhUP24SdFCgAAcEIAALRCAAAA'
	..'AArUzAw++///PZaZyT4KLqL/wVvyhUP24SdFCgAAlkIAALTCAAAAACEBRQQJAecC5QIKaGaqPzMzMz4zMzM+IQlSaWdodCBBcm0E7ALrAucCBCwB6wLnAgqQX3rC9uiBQ6kaKkUK4MyMP5jCdT7OzIw/Cs3MjD/JzMw9zcyMPwpxPYo/jcJ1Pmhmhj8H6QMENAHrAucC'
	..'Bvj4+AMAAAAAAMCYQAqQX3rCuP6BQ6kaKkUKAACAPwAAAEAAAIA/Ch+Fiz+YmRk+w/WIPwQ4AesC5wIKkF96wlLogUOpGipFCkBcjz9QuJ4+fBSOPwoqXI8/hMJ1PXwUjj8KkF96wlL4gUOpGipFCpBfesJS2IFDqRoqRSEETmVvbgQ/AesC5wIK0Gl6wmaygUOpGipF'
	..'CmAAgD97mGk/sEeBPwrA9eg+0MxMPbAehT0KxVJ5woR7gUMPFCpFCi4z8z4fhQs/rkeBPwqddnvCcMWBQ6kaKkUKxlJ5woR7gUPcHCpFCsZSecKEe4FDdhgqRQqpR6E+UrheP65HgT8KfvF5wh61gUOpGipFCsZSecKEe4FDQyEqRSEFR2xvdmUETAHrAucCClBVesKk'
	..'qIFDqRoqRQoghYs/ULg+P2hmhj8KZmamP8zMTD+amZk/CpRSesKFC4JDABsqRQqOwhU/AABAP2JmZj4KwlJ5wvaogUPcHCpFCsL1iD8Uric/ZmaGPwqOX3rCZ86BQ6kaKkUKwlJ5wvaogUN2GCpFCsvMDD9mZmY/uB6FPwpvWnnCw7WBQ6kaKkUKwlJ5wvaogUNDISpF'
	..'CsFSecL2qIFDDxQqRSEEQmVhbSELQXR0YWNobWVudDAhC0F0dGFjaG1lbnQxKAIAAAAA/wAAAACAP/8AACEKRmFjZUNhbWVyYSEVcmJ4YXNzZXRpZDovLzczMDQyNjMzIQ1UZXh0dXJlTGVuZ3RoAwAAAAAAAARAIQtUZXh0dXJlTW9kZSEMVGV4dHVyZVNwZWVkKQQA'
	..'AAAAAACAPwAAAADNzMw9AACAPwAAAADNzMw+N4kBPwAAAAAAAIA/AAAAPwAAAAAhBldpZHRoMCEGV2lkdGgxAwAAAAAAAOg/IQtBdHRhY2htZW50RQRpAesC5wIKAAAAACtrBL8AAAAABCAA7QLuAgoAAACAAAAAAAAA+sIhB0FldGhlcjMoAgAAAAD/AAQAAIA//wAE'
	..'EQAAAD8AAAA/KQMAAAAAAAAAAAAAAAAAAAA/d4ziPwAAAAAAAIA/AAAAAAAAAAARAACAPgAAgD4LAAC0QwAAtEMhFnJieGFzc2V0aWQ6Ly80NDUyMzE4OTgpAwAAAAAAAIA/AAAAAGZmZj+amVk/AAAAAAAAgD8AAIA/AAAAAAMAAAAAAADwvyEFVG9yc28EeQHrAu8C'
	..'BHkB6wLwAgoAAKDAAAAAAAAAAAAKyK+vwrDbgUOsnipFCv8JQkALmCpAXGjqPyEWcmJ4YXNzZXRpZDovLzIxNTczNTIzNQpPzKI/P4ykP+0qgD8EfgHrAvECCsivr8Lt4YFDdZsqRQoAAABAAAAAQAAAgD8hCldpbmdIb2xkZXIhAVIEgwHrAucCCgAAAD8zM7M+AAAA'
	..'PyEKQ3VydmVTaXplMSEIU2VnbWVudHMDAAAAAAAAWUAhF3JieGFzc2V0aWQ6Ly8zMzY3NDg3MDAxAwAAAAAAACRAKQIAAAAAAACAPwAAAAAAAIA/AAAAAAAAAAAhBUJlYW0yIQpDdXJ2ZVNpemUwKQIAAAAAAAAAAAAAAAAAAIA/AAAAAAAAAAAhAUwEjwHrAucCCgAA'
	..'AL8zM7M+AAAAPyEESGVhZATyAusC5wIhCFNraW5QYXJ0BJQB8wL0AgoAGJPCCjuLQyQzK0UKQtybP0d4nD+D4ps/IRdyYnhhc3NldGlkOi8vMzQxMzM4NjcxMgSZAfUC9gIKAACgwAAAqsIAAAAACljsksI4XotDsykrRQqkcDTCKdylwlyPM8IKzcxMPYBCdj0lnak9'
	..'IRdyYnhhc3NldGlkOi8vMzQxMzM5Mjk4NAqAdZw8gEJ2Payzgj0hBEhvb2QEoAHrAucCCngYk8JES4tDkjMrRQrgnPE/+TEAQLFQA0AhFXJieGFzc2V0aWQ6Ly83NjA2MjQ5NwrgnPE/+TEAQMgH7T8EpgH3AvgCCgrXozwK16O8rkfhvgqwGJPCmDqLQyUzK0UKAAAA'
	..'QAAAgD8AAIA/IQVTY2FsZQoAAKA/AACgPwAAoD8hBlNoYWRvdwfrAwSuAfcC+AIGERERCqwYk8IsO4tDJTMrRQquR6E/rkehP65HoT8hBEV5ZTEEsgH3AvgCCqQYk8KaOotDmi4rRQpSuB4/KlwPPzMzMz8KAACAPwAAAABmZmY/IQRFeWUyBLcB9wL4AgqkGJPCmjqL'
	..'Q30uK0UKkMJ1Ps/MzD4zMzM/IQRNYXNrB/MDBL4B6wLmAgYAIGAKAAC0wgAAAAAAAAAACrwYk8L0PYtDjikrRQoAAIA/zcxMPgAAoD8KuB4FPrgeBT7NzMw9ISdodHRwOi8vd3d3LnJvYmxveC5jb20vYXNzZXQvP2lkPTUxNTgyNzAhCVRleHR1cmVJZCEWcmJ4YXNz'
	..'ZXRpZDovLzEyODIxMjA0MiEFRXllQkcExwHrAuYCBgAAAAq8GJPCskWLQ+sqK0UKzcxMP83MzD5okQ0/IQtOb3JtYWxFeWVzMQTLAesC5gIKJH+TwlZGi0MoKytFCtDMTD3NzMw+aby0PiELTm9ybWFsRXllczIEzwHrAuYCCliyksJWRotDKCsrRSEQSHVtYW5vaWRS'
	..'b290UGFydATaAesC5wIE1QHrAucCIQpDYW5Db2xsaWRlIQhNYXNzbGVzcwro9LbCcgiDQ3abKkUKw8zMPdDMzD3IzMw9IQxFZmZlY3RIYW5kbGUE2QHrAucCCgAAAAAAAEDAAAAAAAoc9bbCbAiDQ3abKkUhA0xXMQTeAesC5wIhBkhvbGRlcgrop7HCklaCQ1e0KkUK'
	..'zcxMPc3MTD3NzEw9BOIB+QLnAgoAAACAAQC0wgAAAAAKAAAAAAAAAAAAAIBAIQNSVzEE5QHrAucCCuQyr8KSVoJDV7QqRQTiAfoC5wIKAAAAgAEAtEIAAAAAIQNMVzIE6gHrAucCCuDDt8KSVoJDZNEqRQTiAesC5wIhA1JXMgTuAesC5wIKtISnwpJWgkNk0SpFIQZF'
	..'eHRyYXME8QHrAucCCiDVBsOFa91DcOIpRSgCAAAAAAAAAAAAgD//AAApAwAAAAAAAIA/AAAAAKCmSz8AAIA/AAAAAAAAgD8AAAAAAAAAAAMAAACgmZmpPyEFQ3JhY2sDAAAAoJmZuT8hFnJieGFzc2V0aWQ6Ly80NTcxMDI4MTMpAwAAAAAAAAAAAAAAAJ8lAD8AAAAA'
	..'AAAAAAAAgD8AAAAAAAAAACELQ3JhY2tFZmZlY3QKAAAAAAAAoMAAAAAAEQAAgD4AAAA/KQIAAAAAMD21PjA9tT4AAIA/AAAAAAAAAAARAACAPwAAyEELAACAPwAAgD8hFnJieGFzc2V0aWQ6Ly8yNDY2ODk3OTkpAgAAAAAKvP0+AAAAAAAAgD8AAIA/AAAAACEMQ3Jh'
	..'Y2tFZmZlY3QyCgAAAAAAAHDBAAAAABEAAIA/AABAQAMAAAAAAECPQCkDAAAAAIaVnkAAAAAAS1kGPWiMYj4AAAAAAACAPwAAAAAAAAAAEQAAAAAAAHBCCwAANEIAACBBIRZyYnhhc3NldGlkOi8vMjQyMTA5OTMxKQUAAAAADCs9PwAAAADJVEE9ONcxPwAAAADz/dQ9'
	..'AP6QOwAAAAD4MWY+vmxQPwAAAAAAAIA/AACAPwAAAAAhAkVGCgAAAAAAAAAAAADIQygCAAAAAOwnAAAAgD//AAQDAAAAAAAAFMARzcxMPgAAAD8pAwAAAAAAAAAAAAAAAOXfOT0AAKA+YPkyPQAAgD8AAAAAAAAAABEAAEhCAABIQgsAAKBBAADwQiEWcmJ4YXNzZXRp'
	..'ZDovLzYwMTc4MTMxOCkDAAAAAAAAgD8AAAAAuhyCPQAAAAAAAAAAAACAPwAAgD8AAAAAIQZEYXNoMUUKAAAAAAAAoEIAAAAAKAIAAAAA/yoAAACAP/8AAAMAAAAAAAAkwCkCAAAAAPr/Lz8AAAAAAACAPwAAAAAAAAAAEQAAIEEAAEhDCwAACEIAAKBBKQMAAAAAAACA'
	..'PwAAAACS7Jg+AABgPgAAAAAAAIA/AACAPwAAAAAhCVNwaW5TbGFzaAoAAAAAAAAAAAAASEMRzcxMPgAAgD8pAgAAAAC5d5I//P/fPgAAgD8AAAAAAAAAABEAAHBCAABIQwsAAAAAAAA0QikDAAAAAAAAgD8AAAAAquLVPQAAAAAAAAAAAACAPwAAgD8AAAAAIQZEYXNo'
	..'MkUKAAB6RAAAAAAAAAAAKAIAAAAA/1UAAACAP/8AABHNzEw+zcxMPikCAAAAAPr/fz8AAAAAAACAPwAAAAAAAAAAEQAASEIAAJZDCwAAIEEAAIA/KQMAAAAAAACAPwAAAAD/zCM/ZmbGPgAAAAAAAIA/AACAPwAAAAAhBkRhc2gzRQoAAHrEAAAAAAAAAAApAgAAAAAA'
	..'AIA/AAAAAAAAgD8AAAAAAAAAACEEU3BpbgQxAvsC5wIKAAAAAAAAB0MAAAAAClLUEMO4vYJDkyIqRQoAADTDAAA0QgAANMMhBEF0MUwENgL8AucCCgAAAID//zPDAAAAAAoAAAAAAAAAAAAAwEAhBEF0MU0EOgL9Av4CCgAAAAAAAAAAAQC0QQoAAAAAAABAQAAAwMAh'
	..'BEF0MVQEPgL/AgADCo+OAzf//zNDAQC0QQoAAAAAAAAQQQAAwEAhBEF0MlQEQQL9Av4CCgAAAAAAABBBAADAwCEEQXQyTAREAusC5wIKAAAAAAAAAAAAAMDAIQRBdDJNBEgCAQMCAwoAAACA//8zwwEAtEEKAAAAAAAAQEAAAMBAIQZCZWFtVTIDAAAAAAAAIEADAAAA'
	..'AAAAIkAhKmh0dHA6Ly93d3cucm9ibG94LmNvbS9hc3NldC8/aWQ9MzU1MTI4OTc3OCEGQmVhbUwyIQZCZWFtVTEhBkJlYW1MMQoAAExBAAAAAAAATEEhDFN1cmZhY2VMaWdodCEKQnJpZ2h0bmVzcwMAAABguB40QCEHU2hhZG93cyEFQW5nbGUDAAAAAACAZkAhBEZh'
	..'Y2UhBVJhbmdlIQExBFsC6wLnAgoAAAAAzczMPQAAwEAhATIEXgLrAucCCgAAAADNzMw9AADAwCEBMwRhAusC5wIKAADAQM3MzD0AAAAAIQE0BGQC6wLnAgoAAMDAzczMPQAAAAAhBVRyYWlsAwAAAAAAANA/IRdyYnhhc3NldGlkOi8vMTEzNDgyNDYzMykDAAAAAAAA'
	..'gD8AAAAAzczMPQAAAAAAAAAAAACAPwAAgD8AAAAAIQpXaWR0aFNjYWxlIQZUcmFpbDIhBlRyYWlsMyEGVHJhaWw0KQQAAAAAAACAPwAAAADNzMw8AACAPwAAAADNzMw9AAAAAAAAAAAAAIA/AAAAAAAAAAAhBVNwaW4yBHAC+wLnAgo+NQnDwqaEQ/MaKkUhEEJlYW1C'
	..'bGFzdEVmZmVjdHMhC0JsYXN0Q2hhcmdlBHQC6wLnAgq0geHCIEWBQ8iLKkUhAkIyBHcC6wLnAgoAAKBAAAAAAAAAAAAhAkIxBHgB6wLnAiEJQmxhc3RCZWFtIRZyYnhhc3NldGlkOi8vNTY5NTA3NzI1KQIAAAAAMzNzPwAAAAAAAIA/MzNzPwAAAAAhCkJsYXN0QmVh'
	..'bTIhFnJieGFzc2V0aWQ6Ly8yNDIyOTIzMTgpBwAAAAAAAIA/AAAAAJqZGT4AAAAAAAAAAJqZmT4AAIA/AAAAAAAAAD8AAIA/AAAAADMzMz8AAIA/AAAAAJqZWT8AAAAAAAAAAAAAgD8AAIA/AAAAACEGUGhhc2UyBIIC6wLnAgq0geHCIEWBQ4xqKkUEAwMEA+cCBAUD'
	..'BAPnAgSGAgQD5wIK2LOTwpA6i0PAKitFCmAZej2Q6Rk/xBzEPSEXcmJ4YXNzZXRpZDovLzM0MTMzODk1MzQhDFZlY3RvcjNWYWx1ZSEHRmF0VHVybiEFVmFsdWUKAAAAAAAAoEEAACBBBI4C6wLnAgpgV1bC7AGBQwc1LEUKzcxMPdDMTD3NzEw9IQIxMAQGAwQD5wIH'
	..'NgEElQIEA+cCBluaTAq4lZLCgCOLQ4IqK0UKcPfHPZBqfD6FBEw+IRdyYnhhc3NldGlkOi8vMzQxMzM5MTQ0Mgpw98c9kGp8Ps3lRj4KAABwwQAAoMAAACBBBAcDBAPnAgdoAASeAgQD5wIGazJ8CjSRk8JWTotDXCorRQpgbKw9kOmZPsmVNT4hF3JieGFzc2V0aWQ6'
	..'Ly8zNDEzMzkxOTE2CgAAIEEAAHBBAAAAAAQIAwQD5wIHTQEEpgIEA+cCBu+4OApUc5PCUkGLQ/8pK0UKQGNmPUgf7z7RoyU+IRdyYnhhc3NldGlkOi8vMzQxMzM5NTI1NAoAAMhBAACgQAAAAAAECQMKA+cCB2sABK8CCgPnAgYAj5wKAAAAAAAAvsIAAAAACpAxk8I6'
	..'SotDtikrRQoAADTDAACqwgAANMMKzcxMPSq+uj4k10Y+IRdyYnhhc3NldGlkOi8vMzQxMzM5MDMwNgpAF9g84LG4PiTXRj4KAABwQQAAoMAAAAAAIQE1BAsDDAPnAgfyAwS6AgwD5wIGAAD/CvyyksLqTYtDLyorRQrwZ5A9pZehPgivOj4hF3JieGFzc2V0aWQ6Ly8z'
	..'NDEzMzkwODgzCvBnkD2Q6Zk+CK86PgoAACBBAACgwQAAIMEhATYEDQMEA+cCBMICBAPnAgqk9ZLCNkWLQ7spK0UKzcxMPYzZ5j6TmVo+IRdyYnhhc3NldGlkOi8vMzQxMzM5NDU0NQrAhQk9QKLdPiSHVz4KAACgQQAAcMEAAAAAIQE3BA4DBAPnAgdLAQTMAgQD5wIG'
	..'/1lZClyPksIGRItDlCorRQpAnbU9x/DpPjm8Lz4hF3JieGFzc2V0aWQ6Ly8zNDEzMzkzNDYyCkCdtT1Y3uY+8K8tPgoAAHDBAADIwQAAoMAhATgEDwMEA+cCB0oBBNYCBAPnAgb/mNwKgGCTwowni0PwKStFCnAogz2Q6Zk+HZZ3PiEXcmJ4YXNzZXRpZDovLzM0MTMz'
	..'OTI0ODAKAAAgwQAAoEAAAKDAIQE5BBADBAPnAgf1AwTfAgQD5wIGBK/sChzzksJqJ4tDzSkrRQrNzEw9kOmZPkT6gj4hF3JieGFzc2V0aWQ6Ly8zNDEzMzk2MTAyCgA6Lj2Q6Zk+6GqAPgoAACDBAAAAAAAAAAAKMB4AwgL9g0P14SdFCgAAgL8AAAAAAAAAAAoAAAAA'
	..'AAAAAAAAgL8KAAAAAAAAgD8AAAAACgAAAAAAAAAAAACAPwoAAAAAAACAvwAAAAAK17NdPwQAAL8AAACACgAAgD8AAAAAAAAAAAqQX3rCXPuBQ6kaKkUK6NUSv/KzUb8AAAAACvKzUT/o1RK/AAAAAAoAAAAAnwZ/P2h+sr0KAAAAAKEGfz9pfrK9CgAAAAABAIA/AAAA'
	..'AAqwGJPCREuLQ5IzK0UKAABgsQAAOjEAAIA/CnDZ97EDAIA/AAA6MQqvfrI9AAAAAJ4Gfz8Ku9CxPZ4Gfz+66Pi7Chv+fz+k6Pi7UletOQql5/g7Hv5/P5ujrjkKAAAgtAAAAAAAAIA/CgAAILQAAAAAAACAvwr0BDW/AAAAAPQENb8KAACAvwAAAAAAANA0Cl6DbD8W'
	..'78M+AAAAAAoW78O+XoNsPwAAAAAKXoNsvxbvwz4AAMC0Chbvwz5eg2w/AAAAAApeg2y/Fu/DPr1yrTMKFu/DPl6DbD9wsA+zCkDrfsJqMIZDTq8rRQouvTuzAAAAAAAAgD8KQOt+wuIvhkPYrytFCqDnfcIAGYZDlK8rRQqA3X7CJjCGQ4+vK0UKoLt+wvguhkN9rytF'
	..'ChCBfsIkMIZDVq8rRQqifrK9AAAAAJ4Gfz8KiAB+wmowhkOGrytFCgAAGDQAAAAAAACAPwowS37CZDCGQ2GvK0UKMNp9wv4vhkOmrytFCki9fsLAHIZDba8rRQqAU37CsByGQ2qvK0XQAQAAAQACAAMABAABAgACAAUABgAHAAgAQAIBGwAcAB0AFAAeAB8AIACBGwAh'
	..'ACIAFAAeAB8AIAACCQAJAAoACwAMAA0ADgAPABAAEQASABMAFAAVABYAFwAYABkAGgAIAEADQAMBGwArACwAJwAtAB8AIAABGwAuAC8AMAAxAB8AIAABGwAyADMANAAxAB8AIABAAwEbADUANgAnAC0AHwAgAAEbADcAOAA5ADEAHwAgAAEbADcAOgA7ADEAHwAgAEAD'
	..'ARsAPAA9ACcALQAfACAAARsAPgA/AEAAMQAfACAAARsAQQBCAEMAMQAfACAAAgkACQAKAAsAIwANACQADwAlABEAJgATACcAFQAoABcAKQAZACoACABAAkALARsATQBOAE8AMQAfACAAARsAUABRAE8AMQAfACAAARsATQBSAFMAMQAfACAAARsAUABUAFMAMQAfACAA'
	..'ARsAVQBWAFcAMQAfACAAARsAWABZAFoAWwAfACAAARsAVQBcAF0AMQAfACAAARsAXgBfAGAAMQAfACAAARsAYQBiABgAMQAfACAAARsAYwBkACcAMQAfACAAARsAZQBmAGcAMQAfACAAARsAaABpACcALQAfACAAAgoACQAKAAsARAANAEUADwBGABEARwATAEgAFQBJ'
	..'ABcASgAZAEsATAAKABsAAgwAAgBqAAkACgBrAGwACwBEAA0AbQAPAEYAEQBHABMAJwAVAG4AFwApABkAbwBwAGwAcQAGAQByAC0AcwAGAAAbAAILAAkACgBrAGwACwAjAA0AbQAPACUAEQBHABMAJwAVAG4AFwApABkAdABwAGwAcQAJAQByAC0AGwACCwAJAAoAawBs'
	..'AAsAIwANAHUADwAlABEARwATACcAFQB2ABcAKQAZAHcAcABsAHEACwEAcgAeABsAAgsACQAKAGsAbAALACMADQB4AA8AJQARAEcAEwAnABUAeQAXACkAGQB6AHAAbABxAA0BAHIAHgAbAAIMAAIAewAJAAoAawBsAAsADAANAHwADwAQABEAEgATACcAFQB9ABcAKQAZ'
	..'AH4AcABsAHEADwEAcgAeAAgAQAQBGwCEAIUAhgAxAB8AIAABGwCHAIgAOwAxAB8AIAABGwCJAIoAOQAxAB8AIAABGwCEAIsAjAAxAB8AIAACCgAJAAoACwBEAA0AfwAPAEYAEQBHABMAgAAVAIEAFwCCABkAgwBMAAoAGwACCwAJAAoAawBsAAsADAANAI0ADwAQABEA'
	..'EgATACcAFQCOABcAKQAZAH4AcABsAHEAEgEAcgAeAI8AAgsACQAKAAsADAANAJAADwAQABEAEgATAJEAFQCSABcAkwAZAJQAlQCWAJcAmACPAAIMAAIAmQAJAAoACwBEAA0AkAAPAEYAEQBHABMAkQAVAJIAFwCTABkAmgCVAJYAlwCYAHMAFQMAAgCbAA0AnAAVAJ0A'
	..'ngAWEQACAJ8AoAChAA8AogCjAKQApQAxAKYApwCoAKkAqgCrAKwArQCuAK8AsACxABcAsgAZALMAtAC1ALYAtwC4ALkAugC7AJ4AFhAAAgC8AA8AvQClADEApgCnAKgAvgCqAK0ArACtAK4AvwCwAMAAFwDBABkAwgDDAMQAtAC1ALYAxQC4AMYAugCtAHMAFQMAAgDH'
	..'AA0AyAAVAMkAngAZEQACAJ8AoAChAA8AygCjAKQApQCkAKYApwCoAMsAqgCtAK4AzACwALIAFwDNABkAzgDDAM8AtADQALYAtwC4ALkAugC7AJ4AGRAAAgC8AA8AvQCjANEApQAxAKYApwCoANIAqgCtANMACgCuANQAsADAABcAwQAZANUAwwDWALYA1wC4ANgAugCt'
	..'AHMAFQMAAgDZAA0A2gAVANsACABAAkALARsA3gDfAE8AMQAfACAAARsA4ADhAE8AMQAfACAAARsA3gDiAFMAMQAfACAAARsA4ADjAFMAMQAfACAAARsA5ADlAFcAMQAfACAAARsA5gDnAFoAWwAfACAAARsA5ADoAF0AMQAfACAAARsA6QDqAGAAMQAfACAAARsA6wDs'
	..'ABgAMQAfACAAARsA7QDuACcAMQAfACAAARsA7wDwAGcAMQAfACAAARsA8QDyACcALQAfACAAAgoACQAKAAsAIwANANwADwAlABEARwATAEgAFQB2ABcASgAZAN0ATAAKABsAAgsACQAKAGsAbAALAPMADQD0AA8A9QARAEcAEwD2ABUA9wAXAPYAGQD4AHAAbABxAB4B'
	..'AHIALQAbAAILAAkACgBrAGwACwDzAA0A+QAPAPUAEQBHABMA9gAVAPoAFwD2ABkA+ABwAGwAcQAgAQByAC0AjwACCwAJAAoACwBEAA0A+wAPAEYAEQBHABMAkQAVAPwAFwCTABkA/QCVAJYAlwCYABsAAgsACQAKAGsAbAALAPMADQD+AA8A9QARAEcAEwD2ABUA/wAX'
	..'APYAGQAAAXAAbABxACMBAHIALQAbAAILAAkACgBrAGwACwBEAA0AAQEPAEYAEQBHABMA9gAVAAIBFwD2ABkAAwFwAGwAcQAlAQByAC0AGwACCwAJAAoAawBsAAsA8wANAAQBDwD1ABEARwATAPYAFQAFARcA9gAZAAABcABsAHEAJwEAcgAtABsAAg0AAgAGAQkACgBr'
	..'AGwACwDzAA0ABwEPAPUAEQAIARMAYAAVAAkBFwAKARkACwFwAGwAuACtAAgAQAIBGwAPARABFAAeAB8AIACBGwARARIBFAAeAB8AIAACCQAJAAoACwAMAA0ADAEPABAAEQASABMAFAAVAA0BFwAYABkADgEIAEAGARsAFgEXAScAMQAfACAAARsAGAEZAWcAMQAfACAA'
	..'ARsAGgEbARwBMQAfACAAARsAHQEeAR8BMQAfACAAARsAIAEhASIBMQAfACAAARsAIwEkASUBMQAfACAAAgkACQAKAAsARAANABMBDwBGABEARwATACcAFQAUARcAKQAZABUBGwACDAACACYBCQAKAGsAbAALAPMADQAnAQ8A9QARAAgBEwD2ABUACQEXAPYAGQAoAXAA'
	..'bABxACwBAHIALQAEAAECAAIAKQEGACoBCABAAgAbAC4BLAEgAAAbAC8BLAEgAC4HAAkACgALAEQADQArAQ8ARgARAEcAFQAsARkALQEbAC4KAAIABgEJAAoAawBsAAsAMAENADEBDwAyAREAMwEVADQBGQA1AXAAbAAbAC4JAAkACgBrAGwACwAMAA0AKwEPABAAEQAS'
	..'ABUALAEZADYBcABsAAgAQAIAGwA6ATsBIAAAGwA6ATwBIAAuBwAJAAoACwAjAA0ANwEPACUAEQBHABUAOAEZADkBCABABgEbAEEBQgEgAC0AHwAgAAAbAEMBRAEgAAEbAEEBRQEgAC0AHwAgAAEbAEEBRgEgAC0AHwAgAAAbAEcBSAEgAAEbAEEBSQEgAC0AHwAgAC4I'
	..'AAIAPQEJAAoACwAMAA0APgEPABAAEQASABUAPwEZAEABCABAAoAbAE4BTwEgAEAGABsAUAFRASAAABsAUgFTASAAABsAUAFUASAAABsAVQFWASAAABsAUAFXASAAABsAUAFYASAALggAAgBKAQkACgALAPMADQBLAQ8A9QARACYAFQBMARkATQFZATQLAA8AXAFdAQoA'
	..'qgCtAKwArQC2AF4BXwFgAWEBMQBiAWwAuABjAWQBpABlAWYBcwA0AwACAGcBDQBoARUAaQFzADQCAA0AagETAGsBngA3DwACAGwBDwBtAaMApACoAG4BqgCtANMACgCuAL8AsADBABcAzQAZAG8BwwBwAbQAcQG2AHIBuABzAboAdAEEAAECAAIAdQEGAHYBjwA5CwAJ'
	..'AAoACwAjAA0AdwEPACUAEQAmABMAeAEVAHkBFwB4ARkAegGVAHsBlwB8ARsAOQoAAgAGAQkACgBrAGwACwAMAA0AfQEPABAAEQAzARUAfgEZAH8BcABsABsAOQsAAgCAAQkACgBrAGwACwAMAA0AfQEPABAAEQAzARUAfgEZAH8BcABsALgArQBzADwDAAIAgQENAIIB'
	..'FQCDAVkBPQoADwBcAYQBdAGqAK0AhQGGAbYAhwFfATEAYgGIAbgAiQFkAWwAZQFsAFkBPQsAAgCKAQ8AXAGLAXQBqgCtAIUBhgG2AIcBXwExAGIBiAG4AIwBZAFsAGUBbABzADwDAAIAjQENAI4BFQCPAVkBQAoADwBcAYQBrQCqAK0AhQGGAbYAhwFfATEAYgGIAbgA'
	..'iQFkAWwAZQFsAFkBQAsAAgCKAQ8AXAGLAa0AqgCtAIUBhgG2AIcBXwExAGIBiAG4AIwBZAFsAGUBbAAEAAECAAIAkAEGAJEBjwBDCgACAJIBCQAKAA0AkwERACYAEwBdABUAlAEXAF0AGQCVAZUAlgGXAJUBjwBDCgACAJIBCQAKAA0AlwERACYAEwCYARUAmQEXAJoB'
	..'GQCbAZUAnAGXAJ0BjwBDCgACAJ4BCQAKAAsAIwANAJ8BDwAlABEAJgAVAKABGQChAZUAogGXAKMBGwBDCwACAAYBCQAKAGsAbAALACMADQCkAQ8AJQATAKUBFQCmARcApQEZAKcBcABsAHEARwEAqAGpARsAQwsAAgCqAQkACgBrAGwACwCrAQ0ArAEPAK0BEwClARUA'
	..'rgEXAKUBGQAfAHAAbABxAEkBAKgBrwEbAEMNAAIAsAEJAAoAawBsAAsADAANALEBDwAQABEAEgATAKUBFQCyARcApQEZALMBcABsALgArQBxAEsCAKgBtAFyAB4AGwBDDQACALUBCQAKAGsAbAALADABDQC2AQ8AMgERABIAEwClARUAtwEXAKUBGQC4AXAAbAC4AK0A'
	..'cQBNAgCoAbQBcgAeABsAQwwAAgC5AQkACgBrAGwACwC6AQ0AuwEPALwBEQAmABMAvQEVAL4BFwC9ARkAvwFwAGwAcQBPBACoAcABlQDBAcIBwwFyAKQAGwBDDAACAMQBCQAKAGsAbAALAKsBDQDFAQ8AxgERABIAEwC9ARUAxwEXAL0BGQDIAXAAbABxAFEBAHIAHgAb'
	..'AEMMAAIAyQEJAAoAawBsAAsADAANAMoBDwAQABEAEgATAL0BFQDLARcAvQEZAMwBcABsAHEAUwEAcgAeABsAQwwAAgDNAQkACgBrAGwACwAMAA0AzgEPABAAEQASABMAvQEVAM8BFwC9ARkAzAFwAGwAcQBVAQByAB4ABAABAgACANABBgDRARsAVwkACQAKAGsAbAAN'
	..'ANIB0wGnANQBCgAVANUBGQDWAXAAbAC4AK0AcwBYAwACANcBDQDYARUA2QEbAFcIAAIABgEJAAoAawBsAA0A0QERADMBFQDaARkAfwFwAGwABAABAgACANsBBgDcARsAWwcAAgDdAWsAbAANANwBFQDeARkA3wFwAGwAuACtAHMAXAMADQDgARMA4QEVAOIBGwBbBgAC'
	..'AAYBawBsAA0A3AEVAN4BGQDfAXAAbAAEAAECAAIA4wEGAOQBGwBfBwACAN0BawBsAA0A5AEVAOUBGQDfAXAAbAC4AK0AcwBgAwANAOYBEwDnARUA4gEbAF8GAAIABgFrAGwADQDkARUA5QEZAN8BcABsAAQAAQIAAgDoAQYA6QEbAGMHAAIA3QFrAGwADQDpARUA6gEZ'
	..'AN8BcABsALgArQBzAGQCAA0A6wEVAOIBGwBjBgACAAYBawBsAA0A6QEVAOoBGQDfAXAAbAAEAAECAAIA7AEGAO0BGwBnBwACAN0BawBsAA0A7QEVAO4BGQDfAXAAbAC4AK0AcwBoAgANAOsBFQDiARsAZwYAAgAGAWsAbAANAO0BFQDuARkA3wFwAGwAAQAAAQACAO8B'
	..'GwBrCABrAGwADQDwAdMBpwDUAQoAFQDxARkA1gFwAGwAuACtAFkBawUADwDyAV0BCgC4APMBZAFsAGUB9AFZAWsGAAIA9QEPAFwBhAH2AaoArQC2APcBuAD4AZ4AaxEAAgD5AaAA+gEPAFwBowAxAKUApACmAKcAqAD7AaoArQCuANQAsADBABcAwQAZAPwBwwD9AbQA'
	..'/gG2AP8BuAAAAroA9gGeAGsRAAIAAQKgAAICDwBcAaMApAClAKQApgCnAKgAAwKqAK0ArgAEArAAwQAXAMEAGQAFAsMABgK0AAcCtgAIArgACQK6APYBngBrEwACAAoCoAALAg8ADAKjAA0CpQCkAKYApwCoAA4CqgCtAKwArQDTAAoArgCGAbAAsgAXAM0AGQAPAsMA'
	..'EAK0ABECtgASArgAEwK6AK0AngBrEQACABQCoAAVAg8AFgKjABcCpQAxAKYApwCoANIAqgCtAK4AzACwAMEAFwDBABkAGALDABkCtAAaArYAEgK4ABsCugCkAJ4AaxIAAgAcAqAAHQIPAMoAowDRAKUAbACmAKcAqAAeAqoArQDTAAoArgCGAbAAsgAXAM0AGQAfAsMA'
	..'IAK0ACECtgASArgAIgK6AK0AngBrEgACACMCoAAkAg8AJQKjAA0CpQAxAKYApwCoACYCqgCtANMACgCuAIYBsADBABcAwQAZACcCwwAoArQAKQK2ABICuAAqAroApACeAGsSAAIAKwKgACwCDwAlAqMADQKlADEApgCnAKgAJgKqAK0A0wAKAK4AhgGwAMEAFwDBABkA'
	..'LQLDACgCtAApArYAEgK4ACoCugCkABsAawsAAgAuAmsAbAANAC8C0wGnANQBCgATADACFQAxAhcAMgIZAB8AcABsALgArQBzAHYEAAIAMwINADQCEwA1AhUANgJzAHYEAAIANwINADgCEwA5AhUAOgJzAHYEAAIAOwINADwCEwA9AhUAPgJzAHYEAAIAPwINAEACEwA5'
	..'AhUAQQJzAHYDAAIAQgINAEMCFQBEAnMAdgQAAgBFAg0ARgITAEcCFQBIAlkBdgoAAgBJAg8AXAGLAUoChAFLAqoArQC2AEwCYQExAGIBbAC4AIwBZQFsAFkBdgoAAgBNAg8AXAGLAUoChAFLAqoArQC2AEwCYQExAGIBbAC4AC0CZAExAFkBdgoAAgBOAg8AXAGLAUoC'
	..'hAFLAqoArQC2AEwCYQExAGIBbAC4AIwBZQFsAFkBdgoAAgBPAg8AXAGLAUoChAFLAqoArQC2AEwCYQExAGIBbAC4AC0CZAExAHEAdgIAqAFQAnIAWwBRAnYGAFICUwIPABAAVAIKAFUCVgJXAq0AWAJbAFkBdgoAAgBPAg8AXAGLAUoChAFLAqoArQC2AEwCYQExAGIB'
	..'bAC4AC0CZAExAFkBdgoAAgBNAg8AXAGLAUoChAFLAqoArQC2AEwCYQExAGIBbAC4AC0CZAExAFkBdgoAAgBOAg8AXAGLAUoChAFLAqoArQC2AEwCYQExAGIBbAC4AIwBZQFsAFkBdgoAAgBJAg8AXAGLAUoChAFLAqoArQC2AEwCYQExAGIBbAC4AIwBZQFsAHMAdgMA'
	..'AgBZAg0AWgIVAFsCcwB2AwACAFwCDQBdAhUAXgJzAHYDAAIAXwINAGACFQBhAnMAdgMAAgBiAg0AYwIVAGQCZQJ2BwAPAFwBqABmAqoArQC2AGcCYQExALgAaAJpAi0CZQJ2CAACAGoCDwBcAagAZgKqAK0AtgBnAmEBMQC4AGgCaQItAmUCdggAAgBrAg8AXAGoAGYC'
	..'qgCtALYAZwJhATEAuABoAmkCLQJlAnYIAAIAbAIPAFwBqABmAqoArQC2AGcCYQExALgAaAJpAi0CZQJ2BwACAJ8ADwBcAagAuwCqAK0AtgD3AbgAbQJpAi0CZQJ2BwACALwADwBcAagAuwCqAK0AtgD3AbgAbQJpAi0CGwBrCwACAG4CawBsAA0AbwLTAacA1AEKABMA'
	..'MAIVAHACFwAyAhkAHwBwAGwAuACtAGUCkQgAAgBsAg8AXAGoAGYCqgCtALYAZwJhATEAuABoAmkCLQJlApEIAAIAagIPAFwBqABmAqoArQC2AGcCYQExALgAaAJpAi0CZQKRBwACAJ8ADwBcAagAuwCqAK0AtgD3AbgAbQJpAi0CcQCRAgCoAVACcgBbAGUCkQcAAgC8'
	..'AA8AXAGoALsAqgCtALYA9wG4AG0CaQItAmUCkQgAAgBrAg8AXAGoAGYCqgCtALYAZwJhATEAuABoAmkCLQJlApEHAA8AXAGoAGYCqgCtALYAZwJhATEAuABoAmkCLQJzAJEDAAIAWQINAFoCFQBbAnMAkQMAAgBcAg0AXQIVAF4CcwCRAwACAF8CDQBgAhUAYQJzAJED'
	..'AAIAYgINAGMCFQBkAgEAawEAAgBxAhsAnQoAAgByAgkACgBrAGwADQBzAtMBpwDUAQoAFQB0AhkA3wFwAGwAuACtAHMAngMAAgB1Ag0AdgIVAHcCcwCeAwACAHgCDQB5AhUAeAFZAZ4KAAIAegIPAFwBpgCnAF0BCgCqAK0AtgB7AmIBbAC4AHwCZAEtAGUBLQBZAZ4J'
	..'AAIAfQIPAFwBXQEKAKoArQC2AH4CYgFsALgAfwJkAfYBZQH2ARsAnQoAAgCAAgkACgBrAGwADQCBAtMBpwDUAQoAFQCCAhkA3wFwAGwAuACtAHMAowMAAgB1Ag0AdgIVAHcCcwCjAwACAHgCDQB5AhUAeAFZAaMHAAIAegIPAFwBXQEKAKoArQC2AHsCYgFsALgAjAFZ'
	..'AaMIAAIAfQIPAFwBXQEKAKoArQC2AH4CYgFsAGQBZgJlAWYCBAAAAgACAIUBBgCDAgQAqAIAAgBZAgYAhAKPAKkMAAIAkgEJAAoACwAMAA0AhQIPABAAEQAmABMAXQAVAIYCFwBdABkAhwKVAIgClwCHAokCqgIAAgCKAosCjAIbAKkIAAIABgEJAAoAawBsAA0AjQIV'
	..'AI4CGQCPAnAAbAC4AK0ABACoAgACAJACBgCRAo8ArQwAAgCSAQkACgALAJICDQCTAg8AlAIRACYAEwBdABUAlQIXAF0AGQCWApUAlwKXAJgCiQKuAgACAIoCiwKZAhsArQgAAgAGAQkACgBrAGwADQCNAhUAjgIZAI8CcABsALgArQAEAKgCAAIAXAIGAJoCjwCxDAAC'
	..'AJIBCQAKAAsAmwINAJwCDwCdAhEAJgATAF0AFQCeAhcAXQAZAJ8ClQCgApcAnwKJArICAAIAigKLAqECGwCxCAACAAYBCQAKAGsAbAANAI0CFQCOAhkAjwJwAGwAuACtAAQAqAIAAgBfAgYAogKPALUMAAIAkgEJAAoACwCjAg0ApAIPAKUCEQAmABMAXQAVAKYCFwBd'
	..'ABkApwKVAKgClwCnAokCtgIAAgCKAosCqQIbALUIAAIABgEJAAoAawBsAA0AjQIVAI4CGQCPAnAAbAC4AK0ABACoAgACAGICBgCqAo8AuQwAAgCSAQkACgALAKsCDQCsAg8ArQIRACYAEwCuAhUArwIXALACGQCxApUAsgKXALMCiQK6AgACAIoCiwK0AhsAuQgAAgAG'
	..'AQkACgBrAGwADQCNAhUAjgIZAI8CcABsALgArQAEAKgCAAIAtQIGALYCjwC9DAACAJIBCQAKAAsAtwINALgCDwC5AhEAJgATAF0AFQC6AhcAXQAZALsClQC8ApcAvQKJAr4CAAIAigKLAr4CGwC9CAACAAYBCQAKAGsAbAANAI0CFQCOAhkAjwJwAGwAuACtAAQAqAIA'
	..'AgC/AgYAwAKPAMEMAAIAkgEJAAoACwAwAQ0AwQIPADIBEQAmABMAXQAVAMICFwBdABkAwwKVAMQClwDFAokCwgIAAgCKAosCxgIbAMEIAAIABgEJAAoAawBsAA0AjQIVAI4CGQCPAnAAbAC4AK0ABACoAgACAMcCBgDIAo8AxQwAAgCSAQkACgALAMkCDQDKAg8AywIR'
	..'ACYAEwBdABUAzAIXAF0AGQDNApUAzgKXAM8CiQLGAgACAIoCiwLQAhsAxQgAAgAGAQkACgBrAGwADQCNAhUAjgIZAI8CcABsALgArQAEAKgCAAIA0QIGANICjwDJDAACAJIBCQAKAAsA0wINANQCDwDVAhEAJgATAF0AFQDWAhcAXQAZANcClQDYApcA1wKJAsoCAAIA'
	..'igKLAtkCGwDJCAACAAYBCQAKAGsAbAANAI0CFQCOAhkAjwJwAGwAuACtAAQAqAIAAgDaAgYA2wKPAM0MAAIAkgEJAAoACwDcAg0A3QIPAN4CEQAmABMAXQAVAN8CFwBdABkA4AKVAOEClwDiAokCzgIAAgCKAosC4wIbAM0IAAIABgEJAAoAawBsAA0AjQIVAI4CGQCP'
	..'AnAAbAC4AK0AOjVaATY1WwEIPloBPT5bAWE/WgFhP1sBaUFaAUBBWwFdQloBXUJbAWV9WgF8fVsBen5aAXt+WwF8f1oBeH9bAXmAWgF3gFsBeINaAXeDWwF4hFoBe4RbAXyFWgF4hVsBeYZaAXyGWwF6i1oBh4tbAYmMWgGIjFsBio1aAYqNWwGHjloBiY5bAYiPWgGJ'
	..'j1sBipBaAYeQWwGIkloBm5JbAZqTWgGak1sBnJRaAZuUWwGclloBmZZbAZqXWgGcl1sBmZhaAZmYWwGboVoBn6FbAaCiWgGfolsBoKZaAaSmWwGlp1oBpKdbAaU=')

for _,obj in pairs(Objects) do
	obj.Parent = nil
end

local scloadstring = [==[
			local tailatt = nil
			local tailparticle = nil
			local ear1att = nil
			local ear2att = nil
			local ear1particle = nil
			local ear2particle = nil
			local pointl = nil
				local chr = owner.Character
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
---------------------------
--/                     \--
-- Script By: 123jl123	 --
--\                     /--
---------------------------
--local remote = NS ([=[

local TweenService = game:GetService("TweenService")
function Create(ty)
	return function(data)
		local obj = Instance.new(ty)
		for k, v in pairs(data) do
			if type(k) == 'number' then
				v.Parent = obj
			else
				obj[k] = v
			end
		end
		return obj
	end
end

local Player = owner
ZTfade=false 
ZT=false

EffectPack = script.Extras:Clone()
script.Extras:Destroy()

Target = Vector3.new()
Character= Player.Character
Torso = Character.Torso
Head = Character.Head
Humanoid = Character.Humanoid
LeftArm = Character["Left Arm"]
LeftLeg = Character["Left Leg"]
RightArm = Character["Right Arm"]
RightLeg = Character["Right Leg"]
RootPart = Character["HumanoidRootPart"]
local Anim="Idle"
local inairvel=0
local WalkAnimStep = 0
local sine = 0
local change = 1
Animstep = 0
WalkAnimMove=0.1
Combo = 0
local attack=false
local RJ = Character.HumanoidRootPart:FindFirstChild("RootJoint")
local Neck = Character.Torso:FindFirstChild("Neck")

local RootCF = CFrame.fromEulerAnglesXYZ(-1.57, 0, 3.14) 
local NeckCF = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)


local forWFB = 0
local forWRL = 0


Effects=Instance.new("Folder",Character)
Effects.Name="Effects"
it=Instance.new
vt=Vector3.new
cf=CFrame.new
euler=CFrame.fromEulerAnglesXYZ
angles=CFrame.Angles
local cn = CFrame.new
mr=math.rad
mememode=false
IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor

local lastid= "rbxassetid://12704437218"
local s2=it("Sound",Torso)
local CurId = 1
s2.EmitterSize = 30
local s2c=s2:Clone()

playsong = true

s2.SoundId = lastid
if playsong == true then
	s2:play()		
elseif playsong == false then
	s2:stop()			
end
lastsongpos= 0

crosshair = Instance.new("BillboardGui",Character)
crosshair.Size = UDim2.new(10,0,10,0)
crosshair.Enabled = false
imgl = Instance.new("ImageLabel",crosshair)
imgl.Position = UDim2.new(0,0,0,0)
imgl.Size = UDim2.new(1,0,1,0)
imgl.Image = "rbxassetid://578065407"
imgl.BackgroundTransparency = 1
imgl.ImageTransparency = .7
imgl.ImageColor3 = Color3.new(1,1,1)
crosshair.StudsOffset = Vector3.new(0,0,-1)

--//=================================\\
--||          LOCAL IDS
--\\=================================//

local GROWL = 1544355717
local ROAR = 528589382
local ECHOBLAST = 376976397
local CAST = 459523898
local ALCHEMY = 424195979
local BUILDUP = 698824317
local BIGBUILDUP = 874376217
local IMPACT = 231917744
local LARGE_EXPLOSION = 168513088
local TURNUP = 299058146

if Character:FindFirstChild("Animate")then
	Character.Animate:Destroy()
end

function RemoveOutlines(part)
	part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
end




CFuncs = {
	Part = {Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)

		local Part = Create("Part")({Parent = Parent, Reflectance = Reflectance, Transparency = Transparency, CanCollide = false, Locked = true, BrickColor = BrickColor.new(tostring(BColor)), Name = Name, Size = Size, Material = Material})
		RemoveOutlines(Part)
		return Part
	end
	}
	, 
	Mesh = {Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)

		local Msh = Create(Mesh)({Parent = Part, Offset = OffSet, Scale = Scale})
		if Mesh == "SpecialMesh" then
			Msh.MeshType = MeshType
			Msh.MeshId = MeshId
		end
		return Msh
	end
	}
	, 
	Mesh = {Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)

		local Msh = Create(Mesh)({Parent = Part, Offset = OffSet, Scale = Scale})
		if Mesh == "SpecialMesh" then
			Msh.MeshType = MeshType
			Msh.MeshId = MeshId
		end
		return Msh
	end
	}
	, 
	Weld = {Create = function(Parent, Part0, Part1, C0, C1)

		local Weld = Create("Weld")({Parent = Parent, Part0 = Part0, Part1 = Part1, C0 = C0, C1 = C1})
		return Weld
	end
	}
	, 
	Sound = {Create = function(id, par, vol, pit)

		coroutine.resume(coroutine.create(function()

			local S = Create("Sound")({Volume = vol, Pitch = pit or 1, SoundId  = "http://www.roblox.com/asset/?id="..id, Parent = par or workspace})
			wait()
			S:play()
			game:GetService("Debris"):AddItem(S, 6)
		end
		))
	end
	}
	, 
	ParticleEmitter = {Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)

		local fp = Create("ParticleEmitter")({Parent = Parent, Color = ColorSequence.new(Color1, Color2), LightEmission = LightEmission, Size = Size, Texture = Texture, Transparency = Transparency, ZOffset = ZOffset, Acceleration = Accel, Drag = Drag, LockedToPart = LockedToPart, VelocityInheritance = VelocityInheritance, EmissionDirection = EmissionDirection, Enabled = Enabled, Lifetime = LifeTime, Rate = Rate, Rotation = Rotation, RotSpeed = RotSpeed, Speed = Speed, VelocitySpread = VelocitySpread})
		return fp
	end
	}
}





coroutine.resume(coroutine.create(function()
	if Head:FindFirstChildOfClass("Decal") then
		local face = Head:FindFirstChildOfClass("Decal")
		face:Destroy()
	end

end))







for i, v in pairs(Character:GetChildren()) do
	if v:IsA("Accessory") then
		v:Destroy()
	end
end

--//=================================\\
--|| SAZERENOS ARTIFICIAL HEARTBEAT
--\\=================================//
local FrameFPS = 60
Frame_Speed = 1 / FrameFPS
local ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "Heartbeat"
script:WaitForChild("Heartbeat")
local tf = 0
local allowframeloss = false
local tossremainder = false
local lastframe = tick()
local frame = Frame_Speed
ArtificialHB:Fire()
local artificialhbconnection
artificialhbconnection = game:GetService("RunService").Heartbeat:Connect(function(s, p)
    local success, err = pcall(function()
        tf = tf + s
        if tf >= frame then
            if allowframeloss then
                ArtificialHB:Fire()
                lastframe = tick()
            else
                for i = 1, math.floor(tf / frame) do
                    ArtificialHB:Fire()
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
    if(not success)then
        artificialhbconnection:Disconnect()
    end
end)

local sinn = 0
			ArtificialHB.Event:Connect(function()
				pcall(function()
					sinn += 1
					if(tailatt.Parent.Name == "LowerTorso")then
						tailatt.CFrame = CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),0,0)
					end
					tailparticle.Acceleration = Vector3.new(0+5*math.sin(sinn/30),0+1*math.cos(sinn/30),-4+1*math.cos(sinn/50))
					ear1particle.Acceleration = Vector3.new(0+.3*math.cos(sinn/60),0,-1+.3*math.cos(sinn/50))
					ear2particle.Acceleration = Vector3.new(0-.3*math.cos(sinn/67),0,-1+.3*math.cos(sinn/54))
					tailparticle.LightEmission = 0
					ear1particle.LightEmission = 0
					ear2particle.LightEmission = 0
					tailparticle.LightInfluence = 100
					ear1particle.LightInfluence = 100
					ear2particle.LightInfluence = 100
					tailparticle.Color = ColorSequence.new(Color3.new(.8,0,0))
					ear1particle.Color = ColorSequence.new(Color3.new(.8,0,0))
					ear2particle.Color = ColorSequence.new(Color3.new(.8,0,0))
					pointl.Brightness = 5
					pointl.Range = 10
					pointl.Shadows = false
					pointl.Color = Color3.new(.8,0,0)
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

--//=================================\\
--\\=================================//

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

---------------
--[Functions]--
---------------
so = function(id, par, vol, pit)

	CFuncs.Sound.Create(id, par, vol, pit)


end

function weld(parent,part0,part1,c0)
	local weld=it("Weld") 
	weld.Parent=parent
	weld.Part0=part0 
	weld.Part1=part1 
	weld.C0=c0
	return weld
end
function joint(parent,part0,part1,c0)
	local weld=it("Motor6D") 
	weld.Parent=parent
	weld.Part0=part0 
	weld.Part1=part1 
	weld.C0=c0
	return weld
end



function SetTween(SPart,CFr,MoveStyle2,outorin2,AnimTime)
	local MoveStyle = Enum.EasingStyle[MoveStyle2]
	local outorin = Enum.EasingDirection[outorin2]


	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=1
	end

	if SPart.Name=="Bullet" then
		dahspeed=1	
	end

	local tweeningInformation = TweenInfo.new(
		AnimTime/dahspeed,	
		MoveStyle,
		outorin,
		0,
		false,
		0
	)
	local MoveCF = CFr
	local tweenanim = TweenService:Create(SPart,tweeningInformation,MoveCF)
	tweenanim:Play()
end



local maskthingy = false
HeadAttachment = Instance.new("Attachment",Head)		
HeadAttachment.Position = Vector3.new(0,0,-.5)

for _,v in next, script.Segments:GetDescendants()  do
	if v.Name == "SkinPart" then 

		Clone = v:Clone()		
		Clone.Name = "AnShadowPart"	
		Clone.CFrame = v.CFrame * CF(.01,0,0)	
		Clone.Color = C3(.25,0,0)	
		Clone.Parent = v.Parent
		Clone.Size  =  Clone.Size*0.95
		Clone.Material = "Neon"
		at = Instance.new("Attachment",Clone)		
		Beam = EffectPack.Beam:Clone()			
		Beam.Parent = Clone
		Beam.Attachment0 = HeadAttachment
		Beam.Attachment1 = at

		Beam.Color = 	ColorSequence.new(Clone.Color,  Clone.Color)
	end 


end

for _,v in next, script.Segments:GetDescendants() do if v:IsA("Part")  and v.Name == "Handle"  then     v.CFrame = script.Armor.Head.Handle.CFrame


		v.Parent.Name = "E"..v.Parent.Name

		local Fati = EffectPack.Part:Clone()
		Fati.Parent = Character
		Fati.Name = v.Parent.Name
		local FaceJ=weld(Head,Head,Fati,cf(0,0,0))
		v.Parent.Parent = script.Armor	
		coroutine.resume(coroutine.create(function()
			while true do 
				local randV = math.random(10,40)/150

				if maskthingy == true then
					coroutine.resume(coroutine.create(function()
						local RVal = 	Fati.SkinPart.FatTurn.Value
						SetTween(FaceJ,{C0=ANGLES(mr(RVal.X+math.random(-6,6)/3),mr(RVal.Y+math.random(-6,6)/3),mr(RVal.Z+math.random(-6,6)/3))*CFrame.new(0,0,-.15)},"Quad","InOut",randV)
					end))

				else
					SetTween(FaceJ,{C0=CFrame.new(0,0,0)},"Quad","InOut",randV)


				end

				--print(1)
				Swait(randV*FrameFPS)

			end


		end))	



	end end






ArmorParts = {}
--ArmorParts = {}
function WeldAllTo(Part1,Part2,scan,Extra)
	local EXCF = Part2.CFrame * Extra	
	for i, v3 in pairs(scan:GetDescendants()) do
		if v3:isA("BasePart") then	
			local STW=weld(v3,v3,Part1,EXCF:toObjectSpace(v3.CFrame):inverse() )
			v3.Anchored=false
			v3.Massless = true
			v3.CanCollide=false						
			v3.Parent = Part1			
			v3.Locked = true	
			if not v3:FindFirstChild("Destroy") then
				table.insert(ArmorParts,{Part = v3,Par = v3.Parent,Col = v3.Color,Mat=v3.Material.Name })	
			else
				v3:Destroy()	
			end				
		end
	end
	--Part1.Transparency=1
	Part2:Destroy()
end



function JointAllTo(Part1,Part2,scan,Extra)
	local EXCF = Part2.CFrame * Extra	
	for i, v3 in pairs(scan:GetDescendants()) do
		if v3:isA("BasePart") then	
			local STW=joint(v3,v3,Part1,EXCF:toObjectSpace(v3.CFrame):inverse() )
			v3.Anchored=false
			v3.Massless = true
			v3.CanCollide=false						
			v3.Parent = Part1			
			v3.Locked = true	
			if not v3:FindFirstChild("Destroy") then
				--	table.insert(ArmorParts,{Part = v3,Par = v3.Parent,Col = v3.Color,Mat=v3.Material.Name })	
			else
				v3:Destroy()	
			end				
		end
	end
	--Part1.Transparency=1
	Part2:Destroy()
end

-----------------------------------------------------------------
local LHP = EffectPack.Part:Clone()
LHP.Parent = Character
LHP.Name = "Sword"
SwordJoint=weld(RightArm,RightArm,LHP,cf(0,-1,0))
SwordJoint2=weld(Torso,nil,nil,cf(0,-1,0))
-----------------------------------------------------------------
local Rwing1 = EffectPack.Part:Clone()
Rwing1.Parent = Character
Rwing1.Name = "RW1"
RWingJ1=weld(Torso,Torso,Rwing1,CF(0,0,0))
RWingJ1.C1 = CF(-.5,-.35,-.5)
-----------------------------------------------------------------
local Lwing1 = EffectPack.Part:Clone()
Lwing1.Parent = Character
Lwing1.Name = "LW1"
LWingJ1=weld(Torso,Torso,Lwing1,CF(0,0,0))
LWingJ1.C1 = CF(.5,-.35,-.5)
-----------------------------------------------------------------
local Rwing2 = EffectPack.Part:Clone()
Rwing2.Parent = Character
Rwing2.Name = "RW2"
RWingJ2=weld(Rwing1,Rwing1,Rwing2,CF(0,-0,0))
RWingJ2.C1 = CF(0,0,-4)
-----------------------------------------------------------------
local Lwing2 = EffectPack.Part:Clone()
Lwing2.Parent = Character
Lwing2.Name = "LW2"
LWingJ2=weld(Lwing1,Lwing1,Lwing2,CF(0,-0,0))
LWingJ2.C1 = CF(0,0,-4)
-----------------------------------------------------------------

for _,v in pairs(script.Armor:children()) do
	if v:IsA("Model")  then

		if  Character:FindFirstChild(""..v.Name) then
			local Part1=Character:FindFirstChild(""..v.Name)
			local Part2=v.Handle

			WeldAllTo(Part1,Part2,v,CFrame.new(0,0,0))

		end


	end
end	

for _,v in next, Character:GetDescendants()  do
	if v.Name == "SkinPart" then v.Color = Head.Color end 

end
rayCast = function(Pos, Dir, Max, Ignore)

	return game:service("Workspace"):FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore)
end


function GatherAllInstances(Parent,ig)
	local Instances = {}
	local Ignore=nil
	if	ig ~= nil then
		Ignore = ig	
	end

	local function GatherInstances(Parent,Ignore)
		for i, v in pairs(Parent:GetChildren()) do

			if v ~= Ignore then
				GatherInstances(v,Ignore)
				table.insert(Instances, v) end
		end
	end
	GatherInstances(Parent,Ignore)
	return Instances
end









function WeldAllTo(Part1,Part2,Extra)

	local EXCF = Part2.CFrame * Extra	

	for i, v3 in pairs(GatherAllInstances(Part2)) do
		if v3:isA("BasePart") then


			local STW=weld(v3,v3,Part1,EXCF:toObjectSpace(v3.CFrame):inverse() )


			v3.Anchored=false
			--v3.Transparency=0
			v3.CanCollide=false	

			v3.Parent = Part1					

		end
	end


	Part2:Destroy()

end
local SToneTexture = Create("Texture")({


	Texture = "http://www.roblox.com/asset/?id=1693385655",
	Color3 = Color3.new(163/255, 162/255, 165/255),

})

function AddStoneTexture(part)
	coroutine.resume(coroutine.create(function()
		for i = 0,6,1 do
			local Tx = SToneTexture:Clone()
			Tx.Face = i
			Tx.Parent=part
		end
	end))
end

New = function(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
		Object[Index] = Value
	end
	Object.Parent = Parent
	Object.Name = Name
	return Object
end



function Tran(Num)
	local GivenLeter = ""
	if Num == "1" then
		GivenLeter = "a"	
	elseif Num == "2" then
		GivenLeter = "b"
	elseif Num == "3" then
		GivenLeter = "c"
	elseif Num == "4" then
		GivenLeter = "d"
	elseif Num == "5" then
		GivenLeter = "e"
	elseif Num == "6" then
		GivenLeter = "f"
	elseif Num == "7" then
		GivenLeter = "g"
	elseif Num == "8" then
		GivenLeter = "h"
	elseif Num == "9" then
		GivenLeter = "i"
	elseif Num == "10" then
		GivenLeter = "j"
	elseif Num == "11" then
		GivenLeter = "k"
	elseif Num == "12" then
		GivenLeter = "l"
	elseif Num == "13" then
		GivenLeter = "m"
	elseif Num == "14" then
		GivenLeter = "n"
	elseif Num == "15" then
		GivenLeter = "o"
	elseif Num == "16" then
		GivenLeter = "p"
	elseif Num == "17" then
		GivenLeter = "q"
	elseif Num == "18" then
		GivenLeter = "r"
	elseif Num == "19" then
		GivenLeter = "s"
	elseif Num == "20" then
		GivenLeter = "t"
	elseif Num == "21" then
		GivenLeter = "u"
	elseif Num == "22" then
		GivenLeter = "v"
	elseif Num == "23" then
		GivenLeter = "w"
	elseif Num == "24" then
		GivenLeter = "x"
	elseif Num == "25" then
		GivenLeter = "y"
	elseif Num == "26" then
		GivenLeter = "z"
	elseif Num == "27" then
		GivenLeter = "_"
	elseif Num == "28" then
		GivenLeter = "0"
	elseif Num == "29" then
		GivenLeter = "1"
	elseif Num == "30" then
		GivenLeter = "2"	
	elseif Num == "31" then
		GivenLeter = "3"
	elseif Num == "32" then
		GivenLeter = "4"
	elseif Num == "33" then
		GivenLeter = "5"
	elseif Num == "34" then
		GivenLeter = "6"
	elseif Num == "35" then
		GivenLeter = "7"
	elseif Num == "36" then
		GivenLeter = "8"
	elseif Num == "37" then
		GivenLeter = "9"
	end
	return GivenLeter

end






function BlastEff(a,b,Tab,a1,b2,Ltime)
	local c = Tab.Length1 or 0
	local d = Tab.Width1 or 0
	local e = Tab.Length2 or 0
	local f = Tab.Width2 or 0


	local Eff = EffectPack.BeamBlastEffects[(Tab.Name or "BlastCharge")]:Clone()	
	Eff.Parent = Effects
	game:GetService("Debris"):AddItem(Eff,Ltime)
	local UseWeld = Tab.UseWeld or false
	local WeldTo = Tab.WeldedTo or RootPart
	local w = nil
	if UseWeld == false then
		Eff.CFrame = a else
		Eff.Anchored = false	
		w = weld(Eff,Eff,WeldTo,a:Inverse()) end
	local Save1 = Eff.B1.Position
	local Save2 = Eff.BlastBeam.Width0
	local Save3 = Eff.BlastBeam2.Width0

	Eff.B1.Position = Save1*c
	Eff.B2.Position = -Save1*c

	Eff.BlastBeam.Width0 = Save2*d
	Eff.BlastBeam.Width1 = Save2*d
	Eff.BlastBeam2.Width0 = Save3*d
	Eff.BlastBeam2.Width1 = Save3*d

	if UseWeld == false then
		SetTween(Eff,{CFrame = b},a1,b2,Ltime) else
		SetTween(w,{C0 = b:Inverse()},a1,b2,Ltime) end
	SetTween(Eff.B1,{Position = Save1*e},a1,b2,Ltime)
	SetTween(Eff.B2,{Position = -Save1*e},a1,b2,Ltime)
	SetTween(Eff.BlastBeam,{Width0=Save2*f,Width1=Save2*f},a1,b2,Ltime)
	SetTween(Eff.BlastBeam2,{Width0=Save3*f,Width1=Save3*f},a1,b2,Ltime)
end

















function MaybeOk(Mode,Extra)
	local ReturningValue = ""
	if Mode == 1 then



		--	v.C0 = CFrame.new(1,1,1)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))

		--print(v.C0)
		local GivenText	= ""	
		local	msg = 	Extra
		local Txt = ""
		local FoundTime=0
		local LastFound = 0
		delay(wait(0),function()
			for v3 = 1, #msg do

				if string.sub(msg,0+v3,v3) == ","	then

					local TheN = string.sub(msg,LastFound,v3-1)


					local NumTranslate = Tran(string.sub(msg,LastFound,v3-1))



					FoundTime = FoundTime + 1


					GivenText = GivenText..NumTranslate

					LastFound=v3+1
					Txt=""
				end
				Txt=string.sub(msg,1,v3)		


				--    Gui.ExtentsOffset = Vector3.new(0,3,0)


				--  Gui.ExtentsOffset = Vector3.new(0,3,0)                    
				wait()
				-- Gui.ExtentsOffset = Vector3.new(0,3,0)   
			end;		

			ReturningValue=GivenText
			for v3 = 1, #Txt do
				Txt=string.sub(msg,-1,v3)







			end;
			--   Gui:remove()
		end)	


	elseif Mode == 2 then

		print("fat")
	end



	while ReturningValue == "" do wait() end
	return ReturningValue

end

function CreateMesh2(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart2(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

local S = IT("Sound")
function CreateSound2(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat wait(1) until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end


function WACKYEFFECT(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or VT(1,1,1))
	local ENDSIZE = (Table.Size2 or VT(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart2(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound2(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Cylinder" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "Cylinder", "", "", SIZE, VT(0,0,0))	
		elseif TYPE == "Block" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = VT(SIZE.X,SIZE.X,SIZE.X)
		elseif TYPE == "Cube" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = VT(SIZE.X,SIZE.X,SIZE.X)	

		elseif TYPE == "Wave" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crown" then
			MSH = CreateMesh2("SpecialMesh", EFFECT, "FileMesh", "173770780", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then

				SetTween(EFFECT,{CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))},"Linear","InOut",TIME/60)
			else

				SetTween(EFFECT,{CFrame = CFRAME},"Linear","InOut",0)

			end



			task.wait()

			SetTween(EFFECT,{Transparency = EFFECT.Transparency - TRANS},"Linear","InOut",TIME/60)

			if TYPE == "Block" then

				SetTween(EFFECT,{CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))},"Linear","InOut",0)
			else

				SetTween(EFFECT,{CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))},"Linear","InOut",0)

			end
			if MOVEDIRECTION ~= nil then
				local ORI = EFFECT.Orientation

				SetTween(EFFECT,{CFrame=CF(MOVEDIRECTION)},"Linear","InOut",TIME/60)
				SetTween(EFFECT,{Orientation=ORI},"Linear","InOut",TIME/60)


			end
			MSH.Scale = MSH.Scale - GROWTH/TIME
			SetTween(MSH,{Scale=ENDSIZE},"Linear","InOut",TIME/60)
			if TYPE == "Wave" then

				SetTween(MSH,{Offset=VT(0,0,-MSH.Scale.X/8)},"Linear","InOut",TIME/60)
			end
			for LOOP = 1, TIME+1 do
				task.wait(.05)

				--SetTween(EFFECT,{Transparency = EFFECT.Transparency - TRANS/TIME},"Linear","InOut",0)


				if TYPE == "Block" then

					--				SetTween(EFFECT,{CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))},"Linear","InOut",0)
				else

					--				SetTween(EFFECT,{CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))},"Linear","InOut",0)

				end
				if MOVEDIRECTION ~= nil then
					local ORI = EFFECT.Orientation

					--					SetTween(EFFECT,{CFrame=CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)},"Linear","InOut",0)
					--						SetTween(EFFECT,{Orientation=ORI},"Linear","InOut",0)


				end
			end
			game:GetService("Debris"):AddItem(EFFECT, 15)
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				SOUND.Stopped:Connect(function()
					EFFECT:remove()
				end)
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat wait() until SOUND.Playing == false
				EFFECT:remove()
			end
		end
	end))
end	
----------------------
--[End Of Functions]--
----------------------






------------------
--[Gun]--
------------------












function CreatePart( Parent, Material, Reflectance, Transparency, BColor, Name, Size)
	local Part = Create("Part"){

		Parent = Parent,
		Reflectance = Reflectance,
		Transparency = Transparency,
		CanCollide = false,
		Locked = true,
		BrickColor = BrickColor.new(tostring(BColor)),
		Name = Name,
		Size = Size,
		Material = Material,
	}
	RemoveOutlines(Part)
	return Part
end

------------------
--[End of Gun]--
------------------

---------------
--[Particles]--
---------------


local Particle2_1 = Create("ParticleEmitter"){
	Color = ColorSequence.new(Color3.new (1,1,1),  Color3.new (170/255, 255/255, 255/255)),
	Transparency =  NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.75,.4),NumberSequenceKeypoint.new(1,1)}),
	Size = NumberSequence.new({NumberSequenceKeypoint.new(0,.5),NumberSequenceKeypoint.new(1,.0)}),
	Texture = "rbxassetid://241922778",
	Lifetime = NumberRange.new(0.55,0.95),
	Rate = 100,
	VelocitySpread = 180,
	Rotation = NumberRange.new(0),
	RotSpeed = NumberRange.new(-200,200),
	Speed = NumberRange.new(8.0),
	LightEmission = 1,
	LockedToPart = false,
	Acceleration = Vector3.new(0, 0, 0),
	EmissionDirection = "Top",
	Drag = 4,
	Enabled = false
}


local BEGONE_Particle = Create("ParticleEmitter"){
	Color = ColorSequence.new(Color3.new (1,1,1), Color3.new (1, 1, 1)),
	Transparency =  NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.1,0),NumberSequenceKeypoint.new(0.3,0),NumberSequenceKeypoint.new(0.5,.2),NumberSequenceKeypoint.new(1,1)}),
	Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.15,1.5),NumberSequenceKeypoint.new(.75,1.5),NumberSequenceKeypoint.new(1,0)}),
	Texture = "rbxassetid://936193661",
	Lifetime = NumberRange.new(1.5),
	Rate = 100,
	VelocitySpread = 0,
	Rotation = NumberRange.new(0),
	RotSpeed = NumberRange.new(-10,10),
	Speed = NumberRange.new(0),
	LightEmission = .25,
	LockedToPart = true,
	Acceleration = Vector3.new(0, -0, 0),
	EmissionDirection = "Top",
	Drag = 4,
	ZOffset = 1,
	Enabled = false
}


----------------------
--[End Of Particles]--
----------------------





-----------------



Damagefunc = function(Part, hit, minim, maxim, knockback, Type, Property, Delay, HitSound, HitPitch)

	if hit.Parent == nil then
		return 
	end
	local h = hit.Parent:FindFirstChildOfClass("Humanoid")
	for _,v in pairs(hit.Parent:children()) do
		if v:IsA("Humanoid") then
			if	h.Health > 0.0001 then
				h = v else   end
		end
	end

	if h == nil then
		return 
	elseif h ~= nil and h.Health < 0.001 then
		return 
	elseif  h ~= nil and h.Parent:FindFirstChild("Fly away") then
		return
	end


	--gg

	--local FoundTorso = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")	
	coroutine.resume(coroutine.create(function()	
		if h.Health >9999999 and minim <9999 and Type~= "IgnoreType" and(h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")) and not h.Parent:FindFirstChild("Fly away")then


			local FATag = Instance.new("Model",h.Parent)

			FATag.Name = "Fly away"
			game:GetService("Debris"):AddItem(FATag, 2.5)	


			for _,v in pairs(h.Parent:children()) do
				if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
					v.Anchored=true
				end
			end	

			task.wait(.25)

			if 	h.Parent:FindFirstChildOfClass("Body Colors")then
				h.Parent:FindFirstChildOfClass("Body Colors"):Destroy()
			end


			local FoundTorso = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")

			coroutine.resume(coroutine.create(function()	


				local YourGone = Instance.new("Part")
				YourGone.Reflectance = 0
				YourGone.Transparency = 1
				YourGone.CanCollide = false
				YourGone.Locked = true
				YourGone.Anchored=true
				YourGone.BrickColor = BrickColor.new("Really blue")
				YourGone.Name = "YourGone"
				YourGone.Size = Vector3.new()
				YourGone.Material = "SmoothPlastic"
				YourGone:BreakJoints()
				YourGone.Parent = FoundTorso		
				YourGone.CFrame = FoundTorso.CFrame

				local NewParticle = Instance.new("ParticleEmitter")
				NewParticle.Parent = YourGone
				NewParticle.Acceleration =  Vector3.new(0,0,0)
				NewParticle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,10),NumberSequenceKeypoint.new(1,.0)})
				NewParticle.Color = ColorSequence.new(Color3.new (1,0,0), Color3.new (1, 0, 0))
				NewParticle.Lifetime = NumberRange.new(0.55,0.95)
				NewParticle.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.25,.0),NumberSequenceKeypoint.new(1,1)})
				NewParticle.Speed = NumberRange.new(0,0.0)
				NewParticle.ZOffset = 2
				NewParticle.Texture = "rbxassetid://243660364"
				NewParticle.RotSpeed = NumberRange.new(-0,0)
				NewParticle.Rotation = NumberRange.new(-180,180)
				NewParticle.Enabled = false
				game:GetService("Debris"):AddItem(YourGone, 3)	
				for i = 0,2,1 do
					NewParticle:Emit(1)
					so("1448044156", FoundTorso,2, 1)
					h.Parent:BreakJoints()
					YourGone.CFrame = FoundTorso.CFrame
					for _,v in pairs(h.Parent:children()) do
						if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
							v.Anchored=false
							--			v.Material = "Neon"
							--v.BrickColor = BrickColor.new("Really red")
							if v:FindFirstChildOfClass("SpecialMesh")then
								--v:Destroy()
							end	
							if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
								--	v:Destroy()
							end		
							local vp = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(1000, 1000, 1000), velocity = Vector3.new(math.random(-10,10),4,math.random(-10,10)) })

							vp.Parent = v		
							game:GetService("Debris"):AddItem(vp, math.random(50,100)/1000)				


						end



					end	



					task.wait(.2)	
				end
				task.wait(.1)	
				NewParticle:Emit(3)
				so("1448044156", FoundTorso,2, .8)
				h.Parent:BreakJoints()
				YourGone.CFrame = FoundTorso.CFrame
				for _,v in pairs(h.Parent:children()) do
					if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
						v.Anchored=false
						--			v.Material = "Neon"
						--v.BrickColor = BrickColor.new("Really red")
						if v:FindFirstChildOfClass("SpecialMesh")then
							--v:Destroy()
						end	
						if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
							--	v:Destroy()
						end		
						local vp = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(1000, 1000, 1000), velocity = Vector3.new(math.random(-10,10),4,math.random(-10,10)) })

						vp.Parent = v		
						game:GetService("Debris"):AddItem(vp, math.random(100,200)/1000)				


					end



				end	




			end))




			task.wait(.1)







		end


	end))
	if h ~= nil and hit.Parent ~= Character and hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso") ~= nil then
		if hit.Parent:findFirstChild("DebounceHit") ~= nil and hit.Parent.DebounceHit.Value == true then
			return 
		end
		local c = Create("ObjectValue")({Name = "creator", Value = game:service("Players").LocalPlayer, Parent = h})
		game:GetService("Debris"):AddItem(c, 0.5)
		if HitSound ~= nil and HitPitch ~= nil then
			so(HitSound, hit, 1, HitPitch)
		end
		local Damage = math.random(minim, maxim)
		local blocked = false
		local block = hit.Parent:findFirstChild("Block")
		if block ~= nil and block.className == "IntValue" and block.Value > 0 then
			blocked = true
			block.Value = block.Value - 1
			print(block.Value)
		end
		if blocked == false then
			h.Health = h.Health - Damage
			ShowDamage(Part.CFrame * CFrame.new(0, 0, Part.Size.Z / 2).p + Vector3.new(0, 1.5, 0), -Damage, 2.5, Color3.new(0,0,0))
		else
			h.Health = h.Health - Damage / 2
			ShowDamage(Part.CFrame * CFrame.new(0, 0, Part.Size.Z / 2).p + Vector3.new(0, 1.5, 0), -Damage, 2.5, Color3.new(0,0,0))

		end

		if Type == "Knockdown" then
			local hum = h

			hum.PlatformStand = true
			coroutine.resume(coroutine.create(function(HHumanoid)

				task.wait(.2)
				HHumanoid.PlatformStand = false
			end
			), hum)



			local FoundTorso = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
			local angle = hit.Position - (Property.Position + Vector3.new(0, 0, 0)).unit
			local bodvol = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(math.huge, 0, math.huge), velocity = CFrame.new(Part.Position,FoundTorso.Position).lookVector * knockback, Parent = hit})
			local rl = Create("BodyAngularVelocity")({P = 3000, maxTorque = Vector3.new(5000, 5000, 5000) * 50, angularvelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)), Parent = hit})
			game:GetService("Debris"):AddItem(bodvol, .2)
			game:GetService("Debris"):AddItem(rl, 0.2)



		elseif Type == "Knockdown2" then
			local hum = h

			hum.PlatformStand = true
			coroutine.resume(coroutine.create(function(HHumanoid)


				Combo = 1			task.wait(.2)
				HHumanoid.PlatformStand = false
			end
			), hum)
			local angle = hit.Position - (Property.Position + Vector3.new(0, 0, 0)).unit
			local bodvol = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(math.huge, 0, math.huge), velocity = CFrame.new(Part.Position,Property.Position).lookVector * knockback})
			local rl = Create("BodyAngularVelocity")({P = 3000, maxTorque = Vector3.new(5000, 5000, 5000) * 50, angularvelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)), Parent = hit})
			game:GetService("Debris"):AddItem(bodvol, 0.2)
			game:GetService("Debris"):AddItem(rl, 0.2)






			local bodyVelocity2 = Create("BodyVelocity")({velocity = Vector3.new(0, 60, 0), P = 5000, maxForce = Vector3.new(8000, 12000, 8000), Parent = RootPart})
			game:GetService("Debris"):AddItem(bodyVelocity2, 0.1)

		elseif Type == "Normal" then
			local vp = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(math.huge, 0, math.huge), velocity = CFrame.new(Part.Position,Property.Position).lookVector * knockback})
			if knockback > 0 then

				local HTorso = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")
				vp.Parent = HTorso
			end
			game:GetService("Debris"):AddItem(vp, 0.25)













		elseif Type== "Instakill" 	then
			coroutine.resume(coroutine.create(function()	
				if  (h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")) and not h.Parent:FindFirstChild("Fly away")then


					local FATag = Instance.new("Model",h.Parent)

					FATag.Name = "Fly away"
					game:GetService("Debris"):AddItem(FATag, 2.5)	


					for _,v in pairs(h.Parent:children()) do
						if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
							v.Anchored=true
						end
					end	

					task.wait(.25)

					if 	h.Parent:FindFirstChildOfClass("Body Colors")then
						h.Parent:FindFirstChildOfClass("Body Colors"):Destroy()
					end


					local FoundTorso = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")

					coroutine.resume(coroutine.create(function()	


						local YourGone = Instance.new("Part")
						YourGone.Reflectance = 0
						YourGone.Transparency = 1
						YourGone.CanCollide = false
						YourGone.Locked = true
						YourGone.Anchored=true
						YourGone.BrickColor = BrickColor.new("Really blue")
						YourGone.Name = "YourGone"
						YourGone.Size = Vector3.new()
						YourGone.Material = "SmoothPlastic"
						YourGone:BreakJoints()
						YourGone.Parent = FoundTorso		
						YourGone.CFrame = FoundTorso.CFrame

						local NewParticle = Instance.new("ParticleEmitter")
						NewParticle.Parent = YourGone
						NewParticle.Acceleration =  Vector3.new(0,0,0)
						NewParticle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,10),NumberSequenceKeypoint.new(1,.0)})
						NewParticle.Color = ColorSequence.new(Color3.new (1,0,0), Color3.new (1, 0, 0))
						NewParticle.Lifetime = NumberRange.new(0.55,0.95)
						NewParticle.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.25,.0),NumberSequenceKeypoint.new(1,1)})
						NewParticle.Speed = NumberRange.new(0,0.0)
						NewParticle.ZOffset = 2
						NewParticle.Texture = "rbxassetid://243660364"
						NewParticle.RotSpeed = NumberRange.new(-0,0)
						NewParticle.Rotation = NumberRange.new(-180,180)
						NewParticle.Enabled = false
						game:GetService("Debris"):AddItem(YourGone, 3)	
						for i = 0,2,1 do
							NewParticle:Emit(1)
							so("1448044156", FoundTorso,2, 1)
							h.Parent:BreakJoints()
							YourGone.CFrame = FoundTorso.CFrame
							for _,v in pairs(h.Parent:children()) do
								if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
									v.Anchored=false
									--			v.Material = "Neon"
									--v.BrickColor = BrickColor.new("Really red")
									if v:FindFirstChildOfClass("SpecialMesh")then
										--v:Destroy()
									end	
									if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
										--	v:Destroy()
									end		
									local vp = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(1000, 1000, 1000), velocity = Vector3.new(math.random(-10,10),4,math.random(-10,10)) })

									vp.Parent = v		
									game:GetService("Debris"):AddItem(vp, math.random(50,100)/1000)				


								end



							end	



							task.wait(.2)	
						end
						task.wait(.1)	
						NewParticle:Emit(3)
						so("1448044156", FoundTorso,2, .8)
						h.Parent:BreakJoints()
						YourGone.CFrame = FoundTorso.CFrame
						for _,v in pairs(h.Parent:children()) do
							if v:IsA("BasePart")and v.Parent:FindFirstChildOfClass("Humanoid") then
								v.Anchored=false
								--			v.Material = "Neon"
								--v.BrickColor = BrickColor.new("Really red")
								if v:FindFirstChildOfClass("SpecialMesh")then
									--v:Destroy()
								end	
								if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
									--	v:Destroy()
								end		
								local vp = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(1000, 1000, 1000), velocity = Vector3.new(math.random(-10,10),4,math.random(-10,10)) })

								vp.Parent = v		
								game:GetService("Debris"):AddItem(vp, math.random(100,200)/1000)				


							end



						end	




					end))




					task.wait(.1)







				end


			end))


		elseif Type == "HPSteal" then
			Humanoid.Health = Humanoid.Health + Damage
			local hum = h

			hum.PlatformStand = true
			coroutine.resume(coroutine.create(function(HHumanoid)


				Combo = 1			task.wait(.2)
				HHumanoid.PlatformStand = false
			end
			), hum)
			local angle = hit.Position - (Property.Position + Vector3.new(0, 0, 0)).unit
			local bodvol = Create("BodyVelocity")({P = 500, maxForce = Vector3.new(math.huge, 0, math.huge), velocity = CFrame.new(Part.Position,Property.Position).lookVector * knockback})
			local rl = Create("BodyAngularVelocity")({P = 3000, maxTorque = Vector3.new(5000, 5000, 5000) * 50, angularvelocity = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)), Parent = hit})
			game:GetService("Debris"):AddItem(bodvol, 0.2)
			game:GetService("Debris"):AddItem(rl, 0.2)






			local bodyVelocity2 = Create("BodyVelocity")({velocity = Vector3.new(0, 60, 0), P = 5000, maxForce = Vector3.new(8000, 12000, 8000), Parent = RootPart})
			game:GetService("Debris"):AddItem(bodyVelocity2, 0.1)


		elseif Type == "Impale" then








			CFuncs.Sound.Create("http://www.roblox.com/asset/?id=268249319", Spike, .8, 2)	
			hit.Parent.Humanoid.PlatformStand = true


			task.wait(1)
			hit.Parent.Humanoid.PlatformStand = false
		elseif Type == "IgnoreType" then





		elseif Type == "Up" then
			local bodyVelocity = Create("BodyVelocity")({velocity = Vector3.new(0, 20, 0), P = 5000, maxForce = Vector3.new(8000, 8000, 8000), Parent = hit})
			game:GetService("Debris"):AddItem(bodyVelocity, 0.1)
			local bodyVelocity = Create("BodyVelocity")({velocity = Vector3.new(0, 20, 0), P = 5000, maxForce = Vector3.new(8000, 8000, 8000), Parent = hit})
			game:GetService("Debris"):AddItem(bodyVelocity, .1)







		elseif Type == "Snare" then
			local bp = Create("BodyPosition")({P = 900, D = 1000, maxForce = Vector3.new(math.huge, math.huge, math.huge), position = hit.Parent.Torso.Position, Parent = (h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso"))})
			game:GetService("Debris"):AddItem(bp, 1)



		elseif Type == "Freeze2" then
			local BodPos = Create("BodyPosition")({P = 50000, D = 1000, maxForce = Vector3.new(math.huge, math.huge, math.huge), position = hit.Parent.Torso.Position, Parent = hit.Parent.Torso})
			local BodGy = Create("BodyGyro")({maxTorque = Vector3.new(400000, 400000, 400000) * math.huge, P = 20000, Parent = hit.Parent.Torso, cframe = hit.Parent.Torso.CFrame})
			hit.Parent.Torso.Anchored = true
			coroutine.resume(coroutine.create(function(hit)

				task.wait(1.5)
				hit.Anchored = false
			end
			), hit.Parent.Torso)
			game:GetService("Debris"):AddItem(BodPos, 3)
			game:GetService("Debris"):AddItem(BodGy, 3)
		end
		local debounce = Create("BoolValue")({Name = "DebounceHit", Parent = hit.Parent, Value = true})
		game:GetService("Debris"):AddItem(debounce, Delay)
		c = Instance.new("ObjectValue")
		c.Name = "creator"
		c.Value = Player
		c.Parent = h
		game:GetService("Debris"):AddItem(c, 0.5)
	end
end



ShowDamage = function(Pos, Text, Time, Color)

	local Rate = 0.033333333333333
	if not Pos then
		local Pos = Vector3.new(0, 0, 0)
	end
	local Text = Text or ""
	local Time = Time or 2
	if not Color then
		local Color = Color3.new(1, 0, 1)
	end
	local EffectPart = CreatePart(workspace, "SmoothPlastic", 0, 1, BrickColor.new(Color), "Effect", Vector3.new(0, 0, 0))
	EffectPart.Anchored = true
	local BillboardGui = Create("BillboardGui")({Size = UDim2.new(2, 0, 2, 0), Adornee = EffectPart, Parent = EffectPart})
	local TextLabel = Create("TextLabel")({BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = "DMG: "..Text.."", TextColor3 = Color, TextScaled = true, Font = Enum.Font.ArialBold, Parent = BillboardGui})
	game:GetService("Debris"):AddItem(EffectPart, Time + 0.1)
	EffectPart.Parent = game:GetService("Workspace")
	delay(0, function()

		local Frames = Time / Rate



		print(Frames)
		TextLabel.TextTransparency=0
		EffectPart.CFrame=CFrame.new(Pos)
		task.wait()
		SetTween(TextLabel,{TextTransparency=1},"Quad","In",Frames/60)
		SetTween(TextLabel,{Rotation=math.random(-25,25)},"Elastic","InOut",Frames/60)
		SetTween(TextLabel,{TextColor3=Color3.new(1,0,0)},"Elastic","InOut",Frames/60)

		SetTween(EffectPart,{CFrame = CFrame.new(Pos) + Vector3.new(math.random(-5,5), math.random(1,5), math.random(-5,5))},"Linear","InOut",Frames/60)


		task.wait(Frames/60)

		if EffectPart and EffectPart.Parent then
			EffectPart:Destroy()
		end
	end
	)
end

MagniDamage = function(Part, magni, mindam, maxdam, knock, Type2)




	local Type=""




	if  mememode == true then

		Type=	"Instakill"

	else
		Type=Type2
	end 
	if Type2 == "NormalKnockdown" then
		Type= "Knockdown"
	end

	for _,c in pairs(workspace:children()) do





		local hum = c:FindFirstChild("Humanoid")
		for _,v in pairs(c:children()) do
			if v:IsA("Humanoid") then
				hum = v
			end
		end	




		if hum ~= nil then
			local head = c:findFirstChild("Head")
			if head ~= nil then
				local targ = head.Position - Part.Position
				local mag = targ.magnitude
				if mag <= magni and c.Name ~= Player.Name then
					Damagefunc(Part, head, mindam, maxdam, knock, Type, RootPart, 0.1, "851453784", 1.2)
				end
			end
		end
	end
end





MagniDamage2 = function(CFrameV, magni, mindam, maxdam, knock, Type2)




	local Type=""




	if  mememode == true then

		Type=	"Instakill"

	else
		Type=Type2
	end 
	if Type2 == "NormalKnockdown" then
		Type= "Knockdown"
	end

	for _,c in pairs(workspace:children()) do





		local hum = c:FindFirstChild("Humanoid")
		for _,v in pairs(c:children()) do
			if v:IsA("Humanoid") then
				hum = v
			end
		end	




		if hum ~= nil then
			local head = c:findFirstChild("Head")
			if head ~= nil then
				local targ = head.Position - CFrameV.p
				local mag = targ.magnitude
				if mag <= magni and c.Name ~= Player.Name then
					Damagefunc({CFrame = CFrameV,Position = CFrame.p,Size = VT(1,1,1) }, head, mindam, maxdam, knock, Type, RootPart, 0.1, "851453784", 1.2)
				end
			end
		end
	end
end








function CFMagniDamage(HTCF,magni, mindam, maxdam, knock, Type)

	coroutine.resume(coroutine.create(function()
		MagniDamage2(HTCF, magni, mindam, maxdam, knock, Type)
	end))



end




function BulletHitEffectSpawn(EffectCF,EffectName)
	local MainEffectHolder=Instance.new("Part",Effects)	
	MainEffectHolder.Reflectance = 0
	MainEffectHolder.Transparency = 1
	MainEffectHolder.CanCollide = false
	MainEffectHolder.Locked = true
	MainEffectHolder.Anchored=true
	MainEffectHolder.BrickColor = BrickColor.new("Bright green")
	MainEffectHolder.Name = "Bullet"
	MainEffectHolder.Size = Vector3.new(.05,.05,.05)	
	MainEffectHolder.Material = "Neon"
	MainEffectHolder:BreakJoints()
	MainEffectHolder.CFrame = EffectCF
	local EffectAttach=Instance.new("Attachment",MainEffectHolder)	
	game:GetService("Debris"):AddItem(MainEffectHolder, 15)


	if EffectName == "SpinSlash1" then
		EffectAttach.Orientation = Vector3.new(90,0,0)




		local	SpawnedParticle1 =  EffectPack.SpinSlash:Clone()
		SpawnedParticle1.Parent = MainEffectHolder
		SpawnedParticle1:Emit(65)

		SetTween(MainEffectHolder,{CFrame=MainEffectHolder.CFrame*ANGLES(0,math.rad(-90),math.rad(10))},"Back","Out",1)

		game:GetService("Debris"):AddItem(MainEffectHolder, 2)				


	end	


	if EffectName == "DashSlash1" then
		EffectAttach.Orientation = Vector3.new(90,0,0)




		local	SpawnedParticle1 =  EffectPack.EF:Clone()
		SpawnedParticle1.Parent = MainEffectHolder
		SpawnedParticle1:Emit(400)



		game:GetService("Debris"):AddItem(MainEffectHolder, 2)				


	end	




	if EffectName == "Dash1" then
		EffectAttach.Orientation = Vector3.new(90,0,0)




		local	SpawnedParticle1 =  EffectPack.Dash1E:Clone()
		SpawnedParticle1.Parent = MainEffectHolder
		SpawnedParticle1:Emit(75)



		game:GetService("Debris"):AddItem(MainEffectHolder, 2)				


	end	


	if EffectName == "Dash2" then
		EffectAttach.Orientation = Vector3.new(90,0,0)




		local	SpawnedParticle1 =  EffectPack.Dash2E:Clone()
		SpawnedParticle1.Parent = MainEffectHolder
		SpawnedParticle1:Emit(40)



		game:GetService("Debris"):AddItem(MainEffectHolder, 2)				


	end	


	if EffectName == "Dash3" then
		EffectAttach.Orientation = Vector3.new(90,0,0)




		local	SpawnedParticle1 =  EffectPack.Dash3E:Clone()
		SpawnedParticle1.Parent = MainEffectHolder
		SpawnedParticle1:Emit(40)



		game:GetService("Debris"):AddItem(MainEffectHolder, 2)				


	end	









end





-----------------





--[[
		for i, v in pairs(C:GetChildren()) do
if v:IsA("Accessory")then
v:Destroy()	
end
if v:IsA("BasePart")then
v.Transparency =1
if v.Name == "Head" then
	v:FindFirstChildOfClass("Decal"):Destroy()
end
end
		end--]]
--[[













local tweeningInformation = TweenInfo.new(
	0.5,	
	Enum.EasingStyle.Back,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)
--]]


local RJW=weld(RJ.Parent,RJ.Part0,RJ.Part1,RJ.C0)
RJW.C1 = RJ.C1
RJW.Name = RJ.Name

local NeckW=weld(Neck.Parent,Neck.Part0,Neck.Part1,Neck.C0)
NeckW.C1 = Neck.C1
NeckW.Name = Neck.Name


--print(WRJ.Parent.Name)

local RW=weld(Torso,Torso,RightArm,cf(0,0,0))

local LW=weld(Torso,Torso,LeftArm,cf(0,0,0))

local RH=weld(Torso,Torso,RightLeg,cf(0,0,0))

local LH=weld(Torso,Torso,LeftLeg,cf(0,0,0))



RW.C1 = cn(0, 0.5, 0)
LW.C1 = cn(0, 0.5, 0)
RH.C1 = cn(0, 1, 0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
LH.C1 = cn(0, 1, 0) *CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))






--------
--(#Torso)
SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)},"Quad","InOut",0.1)
--------
--(#Head)
SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)},"Quad","InOut",0.1)
--------
--(#Right Arm)
SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)},"Quad","InOut",0.1)
--------
--(#Left Arm)
SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)},"Quad","InOut",0.1)
--------
--(#Right Leg)
SetTween(RH,{C0=CFrame.new(.5, -0.90, 0)},"Quad","InOut",0.1)
--------
--(#Left Leg)
SetTween(LH,{C0=CFrame.new(-.5, -0.90, 0)},"Quad","InOut",0.1)



--[[
SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)

SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
--]]


function Tuant()
	attack = true
	local random = math.random(1,2)

--[[
	if random == 1 then
	so("3319134060", Head,2.6, 1)
	elseif random == 2 then
so("3319136635", Head,2.6, 1)
	elseif random == 3 then
so("3319138120", Head,2.6, 1)
	elseif random == 4 then
so("3319139330", Head,2.6, 1)
	elseif random == 5 then
so("3319140084", Head,2.6, 1)
	elseif random == 6 then --]]

	--so("3319145619", Head,2.6, 1)
	--	end

	if random == 1 then

		so("3319145619", Head,2.6, 1)
	else
		so("3319140084", Head,2.6, 1)


	end	


	local TimeTest = 0

	-------------------	
	TimeTest = 0.3
	-------------------		

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(30))},"Quad","InOut",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(30),math.rad(0),math.rad(-30))},"Quad","InOut",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(45),math.rad(0),math.rad(20))},"Quad","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(45),math.rad(0),math.rad(-20))},"Quad","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(45),math.rad(0),math.rad(0))},"Quad","InOut",TimeTest)	

	Swait(TimeTest*FrameFPS)

	-------------------	
	TimeTest = 0.5
	-------------------		

	--CFMagniDamage(RootPart.CFrame,15,500,1000,1000,"Knockdown")	
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-.8)*angles(math.rad(0),math.rad(0),math.rad(-30))},"Back","Out",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(20),math.rad(30))},"Quad","InOut",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.15 , 0.5, -.2)*angles(math.rad(80),math.rad(0),math.rad(-50))},"Back","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.15, 0.5, -.2)*angles(math.rad(70),math.rad(0),math.rad(50))},"Back","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -.5, -.2)*angles(math.rad(30),math.rad(30),math.rad(-15))},"Back","Out",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1.25, -.5)*angles(math.rad(-70),math.rad(0),math.rad(0))},"Back","Out",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(65),math.rad(20),math.rad(0))},"Back","Out",TimeTest)	

	Swait(TimeTest*FrameFPS)



	-------------------	
	TimeTest = 0.5
	-------------------		

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(30))},"Back","Out",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(-20),math.rad(-30))},"Quad","InOut",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(120),math.rad(0),math.rad(80))},"Back","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(120),math.rad(0),math.rad(-80))},"Back","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(-30),math.rad(0))},"Back","Out",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Back","Out",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(65),math.rad(0),math.rad(-30))},"Back","Out",TimeTest)	

	Swait(TimeTest*FrameFPS)
	attack = false
end




function Tuant2()
	attack = true
	local random = math.random(1,6)

--[[
	if random == 1 then
	so("3319134060", Head,2.6, 1)
	elseif random == 2 then
so("3319136635", Head,2.6, 1)
	elseif random == 3 then
so("3319138120", Head,2.6, 1)
	elseif random == 4 then
so("3319139330", Head,2.6, 1)
	elseif random == 5 then
so("3319140084", Head,2.6, 1)
	elseif random == 6 then --]]

	--so("3319145619", Head,2.6, 1)
	--	end
	so("3319136635", Head,2.6, 1)
	local TimeTest = 0

	-------------------	
	TimeTest = 0.3
	-------------------		

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(30))},"Quad","InOut",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(30),math.rad(0),math.rad(-30))},"Quad","InOut",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(45),math.rad(0),math.rad(20))},"Quad","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(45),math.rad(0),math.rad(-20))},"Quad","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(45),math.rad(0),math.rad(0))},"Quad","InOut",TimeTest)	

	Swait(TimeTest*FrameFPS)

	-------------------	
	TimeTest = 1
	-------------------		

	--CFMagniDamage(RootPart.CFrame,15,500,1000,1000,"Knockdown")	
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-.8)*angles(math.rad(0),math.rad(0),math.rad(-30))},"Back","Out",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(30),math.rad(0),math.rad(30))},"Quad","InOut",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.2)*angles(math.rad(140),math.rad(0),math.rad(30))},"Back","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, 0)*angles(math.rad(45),math.rad(30),math.rad(-40))},"Back","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -.5, -.2)*angles(math.rad(30),math.rad(30),math.rad(-15))},"Back","Out",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1.25, -.5)*angles(math.rad(-70),math.rad(0),math.rad(0))},"Back","Out",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(65),math.rad(20),math.rad(0))},"Back","Out",TimeTest)	

	Swait(TimeTest*FrameFPS)

	-------------------	
	TimeTest = .5
	-------------------		

	--CFMagniDamage(RootPart.CFrame,15,500,1000,1000,"Knockdown")	
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-.8)*angles(math.rad(10),math.rad(0),math.rad(-30))},"Back","Out",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-10),math.rad(30),math.rad(30))},"Quad","InOut",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.2)*angles(math.rad(140),math.rad(0),math.rad(30))},"Back","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, 0)*angles(math.rad(130),math.rad(30),math.rad(-40))},"Quad","InOut",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -.5, -.2)*angles(math.rad(40),math.rad(30),math.rad(-15))},"Back","Out",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1.25, -.5)*angles(math.rad(-60),math.rad(0),math.rad(0))},"Back","Out",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(65),math.rad(20),math.rad(0))},"Back","Out",TimeTest)	

	Swait(TimeTest*FrameFPS)



	-------------------	
	TimeTest = 1
	-------------------		

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(30))},"Back","Out",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(-20),math.rad(-30))},"Quad","InOut",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(140),math.rad(0),math.rad(80))},"Back","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(120),math.rad(0),math.rad(-80))},"Back","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(-30),math.rad(0))},"Back","Out",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Back","Out",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(65),math.rad(0),math.rad(-30))},"Back","Out",TimeTest)	

	Swait(TimeTest*FrameFPS)
	attack = false
end








function AT1()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=1
	end --/dahspeed
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-.4)*angles(math.rad(0),math.rad(40),math.rad(60))},"Quad","InOut",.4)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(-30),math.rad(-60))},"Quad","InOut",.4)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(110),math.rad(45),math.rad(-10))},"Quad","InOut",.4)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-40))},"Quad","InOut",.4)
	SetTween(RH,{C0=CFrame.new(.5, -.8, -.5)*angles(math.rad(30),math.rad(0),math.rad(-20))},"Quad","InOut",.4)
	SetTween(LH,{C0=CFrame.new(-.5, -.8, -.6)*angles(math.rad(-20),math.rad(0),math.rad(-40))},"Quad","InOut",.4)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-0),math.rad(0),math.rad(0))},"Quad","InOut",.4)


	task.wait(.4/dahspeed)



	coroutine.resume(coroutine.create(function()	
		so("1428541279", RightArm,1.6, math.random(120,220)/100)
		task.wait(.1/dahspeed)	

		if math.random(1,2) == 1 then
			CFMagniDamage(RootPart.CFrame*cn(-.5,-1.5,-3),8,20,25,0,"Knockdown")
		else
			CFMagniDamage(RootPart.CFrame*cn(-.5,-1.5,-3),8,20,25,0,"Normal")
		end

	end))	



	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-50))},"Back","Out",.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(50))},"Back","Out",.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(-20),math.rad(0),math.rad(70))},"Back","Out",.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(20),math.rad(0),math.rad(20))},"Back","Out",.2)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",.2)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Back","Out",.2)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-70),math.rad(0),math.rad(0))},"Back","Out",.2)



	task.wait(.2/dahspeed)	
	attack = false	
end
function AT2()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=1
	end --/dahspeed
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0.5,0)*angles(math.rad(0),math.rad(0),math.rad(-20))},"Quad","InOut",.3)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(20))},"Quad","InOut",.3)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(90))},"Quad","InOut",.3)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(20),math.rad(0),math.rad(20))},"Quad","InOut",.3)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",.3)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(45),math.rad(70),math.rad(-45))},"Quad","InOut",.3)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-50),math.rad(0),math.rad(0))},"Quad","InOut",.3)

	coroutine.resume(coroutine.create(function()	

		task.wait(.1/dahspeed)	
		for i = 1,6 do
			CFMagniDamage(LHP.Blade.CFrame,8,15,25,15,"Normal")	
			task.wait(.1/dahspeed)	
		end
	end))		
	task.wait(.3/dahspeed)


	so("1428541279", RightArm,2.0, math.random(80,90)/100)

	SetTween(RJW,{C0=RootCF*CFrame.new(0,-1.5,-.2)*angles(math.rad(0),math.rad(0),math.rad(20))},"Quad","InOut",.15)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-20))},"Quad","InOut",.15)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(90),math.rad(90),math.rad(0))},"Quad","InOut",.15)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-30))},"Quad","InOut",.15)
	SetTween(RH,{C0=CFrame.new(.5, -.5, -.25)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","InOut",.15)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-45),math.rad(-20),math.rad(0))},"Quad","InOut",.15)

	SetTween(SwordJoint,{C0=CFrame.new(0,-10,0)*angles(math.rad(-110),math.rad(0),math.rad(0))},"Quad","InOut",.15)

	task.wait(.15/dahspeed)
	so("1428541279", RightArm,2.0, math.random(100,110)/100)


	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-.2)*angles(math.rad(0),math.rad(0),math.rad(-20))},"Quad","Out",0.25)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(20),math.rad(20))},"Quad","Out",0.25)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(100),math.rad(45),math.rad(-0))},"Back","Out",0.25)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-30))},"Quad","Out",0.25)
	SetTween(RH,{C0=CFrame.new(.5, -1, -.25)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Back","Out",0.25)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-5),math.rad(20),math.rad(0))},"Quad","Out",0.25)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(60),math.rad(0),math.rad(0))},"Quad","Out",0.25)

	task.wait(0.25/dahspeed)
	attack = false		
end

function AT3()
	attack=true	
	local dahspeed=1
	if attack == true and mememode == true then
		dahspeed=1
	end --/dahspeed
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(-10),math.rad(0),math.rad(10))},"Back","Out",.5)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(10),math.rad(10),math.rad(-10))},"Back","Out",.5)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(140),math.rad(20),math.rad(0))},"Back","Out",.5)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(-40),math.rad(0),math.rad(-30))},"Quad","InOut",.5)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(-10),math.rad(0),math.rad(0))},"Quad","InOut",.5)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(10),math.rad(0),math.rad(0))},"Quad","InOut",.5)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-20),math.rad(-0),math.rad(-0))},"Back","Out",.5)

	task.wait(.3/dahspeed)
	coroutine.resume(coroutine.create(function()	



		so("1428541279", RightArm,1.6, math.random(120,220)/100)
		task.wait(.05/dahspeed)	

		CFMagniDamage(RootPart.CFrame*cn(-.5,-1.5,-3),8,20,25,0,"Normal")	
	end))	



	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-1)*angles(math.rad(20),math.rad(0),math.rad(40))},"Back","Out",.3)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(0),math.rad(-40))},"Back","Out",.3)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(30),math.rad(0),math.rad(40))},"Back","Out",.15)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(60),math.rad(0),math.rad(30))},"Back","Out",.3)
	SetTween(RH,{C0=CFrame.new(.5, -0, -.2)*angles(math.rad(30),math.rad(0),math.rad(20))},"Back","Out",.3)
	SetTween(LH,{C0=CFrame.new(-.5, -1.0, -0.5)*angles(math.rad(-55),math.rad(0),math.rad(0))},"Back","Out",.3)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Back","Out",.15)

	task.wait(.3/dahspeed)	

	attack = false		
end

function Attack1()
	attack = true 
	Humanoid.JumpPower = 0
	Humanoid.WalkSpeed=0


	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-.4)*angles(math.rad(0),math.rad(40),math.rad(60))},"Back","Out",.4)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(-30),math.rad(-60))},"Back","Out",.4)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(110),math.rad(45),math.rad(-10))},"Back","Out",.4)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-40))},"Back","Out",.4)
	SetTween(RH,{C0=CFrame.new(.5, -.8, -.5)*angles(math.rad(30),math.rad(0),math.rad(-20))},"Back","Out",.4)
	SetTween(LH,{C0=CFrame.new(-.5, -.8, -.6)*angles(math.rad(-20),math.rad(0),math.rad(-40))},"Back","Out",.4)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-0),math.rad(0),math.rad(0))},"Back","Out",.4)
	so("306949041", Torso,3, .8)

	Swait(.4*FrameFPS)so("306948842", Torso,3, 1)so("244264387", Torso,3, .5)
	for i= 1,6,1/(8*(FrameFPS/30)) do 
		SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(10),math.rad((-45+(45*2)*(i/6))/3),math.rad(-360*i))},"Linear","InOut",0.1) -- -360*i
		SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(2),math.rad(45*(i/6)))},"Linear","InOut",0.05)
		SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(90))},"Linear","Out",0.05)
		SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(-90+90*(i/6)),math.rad(0),math.rad(-90*(i/6)))},"Linear","Out",0.05)
		SetTween(RH,{C0=CFrame.new(.5, -.5, -.3)*angles(math.rad(-10),math.rad(0),math.rad(0))},"Linear","InOut",0.05)
		SetTween(LH,{C0=CFrame.new(-.5, -.75, -.15)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Linear","InOut",0.05)

		SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-90*(i/6)),math.rad(0),math.rad(0))},"Linear","InOut",0.05)

		CFMagniDamage(RootPart.CFrame,10+(10*(i/6)),5*i,10*i,0,"Normal")	
		BulletHitEffectSpawn(Torso.CFrame,"SpinSlash1")
		Humanoid.JumpPower = 0
		Humanoid.WalkSpeed=70*(i/6)



		Swait()
	end
	Humanoid.JumpPower = 0
	Humanoid.WalkSpeed=0

	so("244264383", Torso,1.5, 2)

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-1)*angles(math.rad(20),math.rad(0),math.rad(40))},"Back","Out",.3)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(45),math.rad(20),math.rad(-40))},"Back","Out",.3)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.6, -.0)*angles(math.rad(0),math.rad(-0),math.rad(120))},"Back","Out",.15)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(60),math.rad(0),math.rad(30))},"Back","Out",.3)
	SetTween(RH,{C0=CFrame.new(.5, -0, -.2)*angles(math.rad(30),math.rad(0),math.rad(20))},"Back","Out",.3)
	SetTween(LH,{C0=CFrame.new(-.5, -1.0, -0.5)*angles(math.rad(-55),math.rad(0),math.rad(0))},"Back","Out",.3)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-80),math.rad(0),math.rad(0))},"Back","Out",.15)

	Swait(.3*FrameFPS)	


	Humanoid.JumpPower = 50
	Humanoid.WalkSpeed=16


	attack = false
end

function Attack2()
	attack = true
	so("175252153", Torso,2, 1)
	Humanoid.JumpPower = 0
	Humanoid.WalkSpeed=5

	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(20))},"Quad","In",0.4)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(30),math.rad(20),math.rad(-10))},"Quad","In",0.4)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(30),math.rad(90),math.rad(0))},"Quad","In",0.4)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(37.5),math.rad(-5),math.rad(-10))},"Quad","In",0.4)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(-20),math.rad(0))},"Quad","In",0.4)
	SetTween(LH,{C0=CFrame.new(-.5, -.7, -.25)*angles(math.rad(-30),math.rad(0),math.rad(0))},"Quad","In",0.4)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-45),math.rad(-60),math.rad(-10))},"Quad","In",0.4)
	Swait(0.4*FrameFPS)	
	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(40))},"Quad","Out",0.4)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(30),math.rad(20),math.rad(-20))},"Quad","Out",0.4)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(80),math.rad(80),math.rad(-10))},"Quad","Out",0.4)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(67.5),math.rad(-10),math.rad(-20))},"Quad","Out",0.4)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(-40),math.rad(0))},"Quad","Out",0.4)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(-10),math.rad(0),math.rad(-10))},"Quad","Out",0.4)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(0),math.rad(-0),math.rad(-10))},"Quad","Out",0.4)
	Swait(.3*FrameFPS)

	BulletHitEffectSpawn(RootPart.CFrame*CF(0,-3,0),"Dash1")	
	for i = 1,15,1/(FrameFPS/30) do 
		local SlashHit,spos = rayCast(RootPart.Position, RootPart.CFrame.lookVector, 8, Character)
		if SlashHit ~= nil then
			RootPart.CFrame = CF(spos-RootPart.CFrame.lookVector*2,spos+RootPart.CFrame.lookVector)
			CFMagniDamage(RootPart.CFrame,20,65,75,10,"Knockdown")	
			break
		else
			RootPart.CFrame = CF(spos,spos+RootPart.CFrame.lookVector)
			CFMagniDamage(CFrame.new(spos),15,45,55,0,"Normal")	
			BulletHitEffectSpawn(CFrame.new(spos,spos+RootPart.CFrame.LookVector)*CF(0,-1,0),"Dash2")	
			BulletHitEffectSpawn(CFrame.new(spos,spos+RootPart.CFrame.LookVector)*CF(0,-1,0),"Dash3")	
		end

	end

	so("136597025", Torso,3, 1)

	--ParticleEffect1.Name = "Clone_Particle"
	BulletHitEffectSpawn(RootPart.CFrame*CF(0,-1,0),"DashSlash1")




	SetTween(RJW,{C0=RootCF*CFrame.new(0,-.2,-1)*angles(math.rad(40),math.rad(0),math.rad(-60))},"Back","Out",0.1)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(-30),math.rad(60))},"Back","Out",0.1)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(10),math.rad(0),math.rad(90))},"Back","Out",0.1)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(45),math.rad(0),math.rad(-25))},"Back","Out",0.1)
	SetTween(RH,{C0=CFrame.new(.5, -.5, -.25)*angles(math.rad(40),math.rad(0),math.rad(-25))},"Back","Out",0.1)
	SetTween(LH,{C0=CFrame.new(-.65, -1.25, -0.5)*angles(math.rad(-65),math.rad(35),math.rad(20))},"Back","Out",0.1)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-70),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
	Swait(.1*FrameFPS)
	so("160897908", Torso,2, 2)
	SetTween(RJW,{C0=RootCF*CFrame.new(0,-.2,-1)*angles(math.rad(40),math.rad(0),math.rad(-30))},"Quad","In",0.2)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(-20),math.rad(10),math.rad(30))},"Quad","In",0.2)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(110),math.rad(0),math.rad(80))},"Quad","In",0.2)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(45),math.rad(0),math.rad(-25))},"Quad","In",0.2)
	SetTween(RH,{C0=CFrame.new(.5, -.3, -.25)*angles(math.rad(30),math.rad(0),math.rad(0))},"Quad","In",0.2)
	SetTween(LH,{C0=CFrame.new(-.65, -1.25, -0.5)*angles(math.rad(-65),math.rad(35),math.rad(20))},"Quad","In",0.2)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-0),math.rad(0),math.rad(0))},"Quad","In",0.2)
	Swait(.2*FrameFPS)
	--	RootPart.Part.EffectHandle.E1.Enabled = false


	Humanoid.JumpPower = 50
	Humanoid.WalkSpeed=16	
	attack = false
end



function Attack3()
	attack = true
	Humanoid.JumpPower = 0
	local TimeTest = 0.25



	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,-.2)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","In",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(-15),math.rad(0))},"Quad","In",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(-20),math.rad(-20),math.rad(80))},"Quad","In",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(20),math.rad(0),math.rad(-30))},"Quad","In",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -1, -0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","In",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1, -0)*angles(math.rad(-0),math.rad(0),math.rad(0))},"Quad","In",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-110),math.rad(-0),math.rad(-0))},"Quad","InOut",TimeTest)	
	Swait(TimeTest*FrameFPS)	

	-------------------	
	TimeTest = 0.4
	-------------------			
	Humanoid.JumpPower = 0
	Humanoid.WalkSpeed=1	
	SetTween(RJW,{C0=RootCF*CFrame.new(0,1,-1)*angles(math.rad(10),math.rad(0),math.rad(-0))},"Quad","Out",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(25),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(-45),math.rad(-30),math.rad(0))},"Quad","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(-30))},"Quad","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -0, -.4)*angles(math.rad(30),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1.25, -.3)*angles(math.rad(-70),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-150),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)	
	Swait(TimeTest*FrameFPS)	



	so("160772554", Torso,2, .9)
	-------------------	
	TimeTest = 0.15
	-------------------		



	so("469345336", Torso,2, 1.5)

	--[[
for i = 0,4,(.4*(FrameFPS/30)) do
SetTween(RJW,{C0=RootCF*CFrame.new(0,0,14*(i/4))*angles(math.rad(30+(330*1)*(i/4)),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)
SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(10),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)
SetTween(RW,{C0=CFrame.new(1.5-0.35*(i/4)  , 0.5, -.20*(i/4))*angles(math.rad(40+50*(i/4)),math.rad(0),math.rad(-50*(i/4)))},"Quad","Out",TimeTest)
SetTween(LW,{C0=CFrame.new(-1.5+0.35*(i/4), 0.5, -.20*(i/4))*angles(math.rad(90*(i/4)),math.rad(0),math.rad(50*(i/4)))},"Quad","Out",TimeTest)
SetTween(RH,{C0=CFrame.new(.5, -1+.5*(i/4), -.3*(i/4))*angles(math.rad(20*(i/4)),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)
SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(20*(i/4)),math.rad(0))},"Quad","Out",TimeTest)

SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-180*(i/4)),math.rad(90-90*(i/4)),math.rad(45*(i/4)))},"Quad","Out",TimeTest)

Swait()
end	
--]]
	Humanoid.JumpPower = 0
	Humanoid.WalkSpeed=0
	--[

	coroutine.resume(coroutine.create(function()	
		-----------------------------------------------------------------------------------------
		so("178452241", Torso,3, 1.5)
		Swait(0.15*FrameFPS)	
		for Spread = 0,3 do
			coroutine.resume(coroutine.create(function()	

				local StartCF = RootPart.CFrame*CF(1.75,0,-2)*ANGLES(0,RAD((math.random(-60,60)/10)*Spread),0)

				local spos3 = StartCF.p
				local CrackThing = EffectPack.Part:Clone()
				CrackThing.Anchored = true
				CrackThing.CFrame = StartCF
				CrackThing.Parent = Effects
				CrackThing.Name = "MagicCrack"
				local LastCrack = Instance.new("Attachment",CrackThing)
				local 	 StartHit,StartHitPos = rayCast(spos3, VT(0,-1,0), 50, Character)
				LastCrack.WorldPosition = StartHitPos
				local CrackWaveSize1 = 2
				local CrackWaveSize2 = (CrackWaveSize1/5)*2
				local firstBeam = true
				for i = 1,10,.5 do



					local  SlashHit,spos = rayCast(spos3, StartCF.LookVector, 6, Character)



					local randomdir=(StartCF.RightVector*math.random(-5,5))+(StartCF.LookVector*math.random(-1,1))
					local 	 SlashHit2,spos2 = rayCast(spos+randomdir, VT(0,-1,0), 50, Character)

					local BeamCrack = EffectPack.Crack:Clone()
					BeamCrack.Parent =CrackThing
					BeamCrack.Name = "Beam "..i
					local oldcrack = LastCrack	
					BeamCrack.Attachment0 = oldcrack
					BeamCrack.Width0 = 0
					BeamCrack.Width1 = 0	



					if SlashHit ~= nil then
						---------------------------------------------
						SlashHit2,spos2 = rayCast(spos, VT(0,-1,0), 50, Character)


						local ParticlePart2 = EffectPack.Part:Clone()
						ParticlePart2.Anchored = true
						local vthightandpos = (spos*VT(1,0,1)) + (spos2*VT(0,1,0))   -- +VT(0,(10-i)/2,0)
						ParticlePart2.CFrame = CF(vthightandpos+VT(0,(CrackWaveSize2*(1-i/10))/2,0),LastCrack.WorldPosition+VT(0,(CrackWaveSize2*(1-i/10))/2,0))
						ParticlePart2.Parent = CrackThing
						ParticlePart2.Size = VT(0,CrackWaveSize2*(1-i/10),0)
						ParticlePart2.Transparency = 1
						game:GetService("Debris"):AddItem(ParticlePart2, 4.5)	
						local Particle2 = EffectPack.CrackEffect2:Clone()	
						Particle2.Parent = ParticlePart2
						Particle2:Emit(50)
						so("168586621", ParticlePart2,2.5, 1.0)
						CFMagniDamage(ParticlePart2.CFrame,10,65,75,65,"Knockdown")	
						---------------------------------------------			
					end
					---------------------------------------------	
--[[
	local ParticlePart = EffectPack.Part:Clone()
ParticlePart.Anchored = true
  -- +VT(0,(10-i)/2,0)
local mag = (spos2-LastCrack.WorldPosition).magnitude
ParticlePart.CFrame = CF(spos2,LastCrack.WorldPosition)*CF(0,0,-mag/2)*ANGLES(RAD(90),0,0)
ParticlePart.Parent = CrackThing
ParticlePart.Size = VT(0,mag,0)

	ParticlePart.Transparency = 1
		game:GetService("Debris"):AddItem(ParticlePart, 2.25)
local Particle = EffectPack.CrackEffect:Clone()	
	Particle.Parent = ParticlePart
	Particle.Speed = NumberRange.new(1*(1-i/10),(CrackWaveSize1*(1-i/10))*5.5)
	Particle:Emit(mag*3)
		so("168586586", ParticlePart,.5, 2.8)
		--]]
					--	CFMagniDamage(ParticlePart.CFrame,mag,5,15,15,"Knockdown")	
					---------------------------------------------			

					LastCrack = Instance.new("Attachment",CrackThing)
					LastCrack.WorldPosition = spos2
					BeamCrack.Attachment1 = LastCrack

					coroutine.resume(coroutine.create(function()
						if firstBeam==true then	
							SetTween(BeamCrack,{Width0 = 0,Width1 = CrackWaveSize1*(1-i/10) },"Bounce","Out",.25)	firstBeam = false
						else
							SetTween(BeamCrack,{Width0 = CrackWaveSize1*(1-i/10),Width1 = CrackWaveSize1*(1-i/10) },"Bounce","Out",.25)		
						end 
						Swait(.25*FrameFPS)
						SetTween(BeamCrack,{Width0 = 0,Width1 = 0 },"Quad","Out",.25)		
						Swait(.25*FrameFPS)
					end))	

					if SlashHit ~= nil then

						LastCrack.WorldPosition = (spos*VT(1,0,1)) + (spos2*VT(0,1,0))

						break
					end
					spos3 = spos
					Swait()
				end

				game:GetService("Debris"):AddItem(CrackThing, 5.75)	
			end))
			Swait(.05*FrameFPS) end
		-----------------------------------------------------------------------------------------
	end))





	--	Swait(TimeTest*FrameFPS)	
	--]]
	-------------------	
	TimeTest = 0.1
	-------------------	


	LHP.Blade.SwingAt1.E2.Enabled = true






	-------------------	
	TimeTest = 0.2
	-------------------		


	SetTween(RJW,{C0=RootCF*CFrame.new(0,.5,-.25)*angles(math.rad(-30),math.rad(0),math.rad(30))},"Quad","InOut",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(15),math.rad(0),math.rad(-30))},"Quad","InOut",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(130),math.rad(10),math.rad(15))},"Quad","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(-50),math.rad(0),math.rad(-10))},"Quad","Out",TimeTest*2)
	SetTween(RH,{C0=CFrame.new(.5, -1, -0)*angles(math.rad(-30),math.rad(-15),math.rad(-15))},"Quad","InOut",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -0.8, -.3)*angles(math.rad(-50),math.rad(0),math.rad(0))},"Quad","InOut",TimeTest)
	SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-140),math.rad(0),math.rad(0))},"Quad","InOut",TimeTest)	


	LHP.Blade.SwingAt1.E1.Enabled = true
	Swait(TimeTest*FrameFPS)
	LHP.Blade.SwingAt1.E1.Enabled = false


	LHP.Blade.SwingAt1.E2.Enabled = false
	-------------------	
	--TimeTest = 0.15
	-------------------	
	SetTween(RJW,{C0=RootCF*CFrame.new(0,.25,-.3)*angles(math.rad(-20),math.rad(0),math.rad(0))},"Quad","In",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","In",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -0)*angles(math.rad(80),math.rad(0),math.rad(-15))},"Quad","In",TimeTest)
	--SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(-50),math.rad(0),math.rad(-10))},"Quad","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -1, -0)*angles(math.rad(-20),math.rad(-5),math.rad(0))},"Quad","Out",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -.5, -.5)*angles(math.rad(-15),math.rad(5),math.rad(0))},"Quad","In",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-1,-0)*angles(math.rad(-80),math.rad(0),math.rad(0))},"Quad","In",TimeTest)
	Swait(TimeTest*FrameFPS)	



	-------------------	
	TimeTest = 0.25
	-------------------		


	SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(-0),math.rad(0),math.rad(-10))},"Quad","Out",TimeTest)
	SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(10),math.rad(0),math.rad(10))},"Quad","Out",TimeTest)
	SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -0)*angles(math.rad(120),math.rad(0),math.rad(30))},"Quad","Out",TimeTest)
	SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(5),math.rad(0),math.rad(-20))},"Quad","Out",TimeTest)
	SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)
	SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)

	SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-0)*angles(math.rad(45),math.rad(0),math.rad(0))},"Quad","Out",TimeTest)	
	Swait(TimeTest*FrameFPS)		
	Humanoid.JumpPower = 50
	Humanoid.WalkSpeed=16
	attack = false	
end


function Attack6()

	for i, v in pairs(GatherAllInstances(Effects)) do
		if v.Name == "Zombie" then
			v.Parent:Destroy()
		end
	end
end

function ClickCombo()	--if 	attack == true then return end		
	if Anim == "Fall" or Anim == "Jump" then	
		if Combo == 0 then		
			--DownAT()	
		end

	else	

		if Combo == 0 then
			AT1()	
			Combo = 1
		elseif Combo == 1 then
			AT2()	
			Combo = 2	
		elseif Combo == 2 then
			AT3()
			Combo = 0		
		end
	end
end



local Hold = false


Button1DownF=function()


	Button1DownF=function()

		Hold= true
		while Hold == true do
			if attack == false then
				ClickCombo()
			else

			end Swait()
		end








	end

end



Button1UpF=function()

	if Hold==true then

		Hold = false

	end	

end


spinweld = nil
spinweld2 = nil
KeyUpF=function(key)



end

KeyDownF=function(key)


	if mememode == false then	
		if  key == "z"   and attack == false then
			Attack1()


		end
		if  key == "x"   and attack == false then
			Attack2()
		end

		if  key == "c"   and attack == false then
			Attack3()
		end
		if  key == "v"   and attack == false then
			--Attack4()
		end
	else
		-----------------------------------------------
		if  key == "z"   and attack == false then



		end
		if  key == "x"   and attack == false then

		end

		if  key == "c"   and attack == false then

		end
		if  key == "v"   and attack == false then
			--Attack4()
		end

	end

	if  key == "f"   and attack == false then
		--Attack5()
	end
	if  key == "g"   and attack == false then



	end
	if  key == "t"   and attack == false then
		Tuant()
	end
	if  key == "y"   and attack == false then
		Tuant2()
	end
	if  key == "p"   and attack == false then
		if mememode == false then
			mememode=true

			so("1195480469", RootPart,3, 1)
			lastid= "rbxassetid://12643617042"
			s2.SoundId = lastid

			for i = 1,math.random(5,10) do 	
				local TargCF = CF(0,0,-.3)*ANGLES(math.rad(math.random(-0,0)),math.rad(math.random(-0,0)),math.rad(math.random(-180,180)))
				local TargCF2 = CF(0,0,-.3)*ANGLES(math.rad(math.random(-0,0)),math.rad(math.random(-0,0)),math.rad(math.random(-180,180)))

				BlastEff(TargCF,TargCF2,{UseWeld = true,WeldedTo = Head.Eye2, Length1=0,Length2=math.random(2,10)/15,Width1=20,Width2=0},"Quad","Out",(.25+(math.random()/1))/2)--,0,1,1,0)	
			end
			for i = 1,math.random(3,3) do 	
				local TargCF = CF(0,0,-.3)*ANGLES(math.rad(math.random(-0,0)),math.rad(math.random(-0,0)),math.rad(math.random(-0,0)))
				local TargCF2 = CF(0,0,-.3)*ANGLES(math.rad(math.random(-0,0)),math.rad(math.random(-0,0)),math.rad(math.random(-5,5)))

				BlastEff(TargCF,TargCF2,{Name = "Phase2",UseWeld = true,WeldedTo = Head.Eye2,Length1=math.random(2,10)/25,Length2=0,Width1=0,Width2=.5},"Quad","Out",1.45)--,0,1,1,0)	
			end

			local spinWave = EffectPack.Spin:Clone()
			spinWave.Parent = Character
			spinweld = weld(spinWave,spinWave,RootPart,CF(0,2.95,0))
			local spinWave2 = EffectPack.Spin2:Clone()
			spinWave2.Parent = Character
			spinweld2 = weld(spinWave2,spinWave2,RootPart,CF(0,2.95,0))

			maskthingy=true
			------------------------------------------------------------------
			coroutine.resume(coroutine.create(function()
				local fakemask = Head.Mask:Clone()
				fakemask.Parent = Effects
				fakemask:BreakJoints()
				fakemask.CanCollide = true
				fakemask.Massless = true
				fakemask.Velocity = Head.CFrame.LookVector*5
				fakemask:SetNetworkOwner(Player)
				game:GetService("Debris"):AddItem(fakemask, 2)		
				task.wait(1)
				SetTween(fakemask,{Transparency = 1},"Quad","Out",1)
			end))


			SetTween(Torso.WingHolder.R.Beam,{Width0 = 2,Width1 = 1},"Quad","Out",0.5)
			SetTween(Torso.WingHolder.R.Beam2,{Width0 = 1,Width1 = 0},"Quad","Out",0.5)

			SetTween(Torso.WingHolder.L.Beam,{Width0 = 2,Width1 = 1},"Quad","Out",0.5)
			SetTween(Torso.WingHolder.L.Beam2,{Width0 = 1,Width1 = 0},"Quad","Out",0.5)



			SetTween(Head.NormalEyes1,{Transparency = 1},"Quad","In",0.1)
			SetTween(Head.NormalEyes2,{Transparency = 1},"Quad","In",0.1)
			SetTween(Head.EyeBG,{Transparency = 1},"Quad","Out",0)
			SetTween(Head.Mask,{Transparency = 1},"Quad","Out",0)	
			Head.EyeBG.Transparency = 1
			Head.Mask.Transparency = 1

			SetTween(Head.NormalEyes1.Mesh,{Scale = vt(1,0,1)},"Quad","Out",.1)
			SetTween(Head.NormalEyes2.Mesh,{Scale = vt(1,0,1)},"Quad","Out",.1)

			------------------------------------------------------------------
			SetTween(Head.Eye1,{Transparency = 0},"Quad","In",.25)
			SetTween(Head.Eye2,{Transparency = 0},"Quad","In",.25)
			SetTween(Head.Eye1.Mesh,{Scale = vt(1,1,1)},"Quad","In",.25)
			SetTween(Head.Eye2.Mesh,{Scale = vt(1,1,1)},"Quad","In",.25)
			------------------------------------------------------------------			
			RightArm.Glove.Beam.Enabled = false
			SetTween(SwordJoint2,{C0 = Torso.CFrame:Inverse()*LHP.CFrame},"Quad","In",0) 
			SwordJoint2.C0 = Torso.CFrame:Inverse()*LHP.CFrame
			SwordJoint.Part0 = nil
			SwordJoint.Part1 = nil


			SwordJoint2.Part0 = Torso
			SwordJoint2.Part1 = LHP
			SetTween(SwordJoint2,{C0 = CF(2.15,2.5,.7)*ANGLES(mr(90),mr(135),mr(90))},"Back","Out",.25) 


			lastsongpos = 0
			s2.TimePosition = lastsongpos


		else
			mememode=false
			CurId=CurId-1
			KeyDownF("n")
			lastid= "rbxassetid://12704437218"

			SetTween(Torso.WingHolder.R.Beam,{Width0 = 0,Width1 = 0},"Quad","InOut",.5)
			SetTween(Torso.WingHolder.R.Beam2,{Width0 = 0,Width1 = 0},"Quad","InOut",.5)

			SetTween(Torso.WingHolder.L.Beam,{Width0 = 0,Width1 = 0},"Quad","InOut",.5)
			SetTween(Torso.WingHolder.L.Beam2,{Width0 = 0,Width1 = 0},"Quad","InOut",.5)

			SetTween(RWingJ1,{C0 = CF(0,0,-0.5)},"Quad","InOut",1)
			SetTween(RWingJ2,{C0 = CF(0,0,-4)},"Quad","InOut",1)

			SetTween(LWingJ1,{C0 = CF(0,0,-0.5)},"Quad","InOut",1)
			SetTween(LWingJ2,{C0 = CF(0,0,-4)},"Quad","InOut",1)



			if Character:FindFirstChild("Spin")	then Character.Spin:Destroy() end
			if Character:FindFirstChild("Spin2")	then Character.Spin2:Destroy() end
			maskthingy=false	
			------------------------------------------------------------------
			SetTween(Head.NormalEyes1,{Transparency = 0},"Quad","In",0.25)
			SetTween(Head.NormalEyes2,{Transparency = 0},"Quad","In",0.25)
			SetTween(Head.EyeBG,{Transparency = 0},"Quad","In",0.8)
			SetTween(Head.Mask,{Transparency = 0},"Quad","In",0.5)
			SetTween(Head.NormalEyes1.Mesh,{Scale = vt(1,1,1)},"Quad","In",0.45)
			SetTween(Head.NormalEyes2.Mesh,{Scale = vt(1,1,1)},"Quad","In",0.45)

			------------------------------------------------------------------
			SetTween(Head.Eye1,{Transparency = 1},"Quad","Out",0.8)
			SetTween(Head.Eye2,{Transparency = 1},"Quad","Out",0.8)
			SetTween(Head.Eye1.Mesh,{Scale = vt(1,0,.9)},"Quad","Out",0.8)
			SetTween(Head.Eye2.Mesh,{Scale = vt(1,0,.9)},"Quad","Out",0.8)
			------------------------------------------------------------------	
			RightArm.Glove.Beam.Enabled = true
			SetTween(SwordJoint,{C0 = RightArm.CFrame:Inverse()*LHP.CFrame},"Quad","In",0) 
			SwordJoint.C0 = RightArm.CFrame:Inverse()*LHP.CFrame	
			SwordJoint2.Part0 = nil
			SwordJoint2.Part1 = nil

			SwordJoint.Part0 = RightArm
			SwordJoint.Part1 = LHP	

		end
	end


	if  key == "0"  then
		if isruning == false then
			isruning=true	
		end
	end






	if key == "m" then	

		if playsong == true then
			playsong = false	
			s2:stop()	
		elseif playsong == false then
			playsong = true	


			s2:play()				
		end

	end
end


FF = Instance.new("ForceField",Character)
FF.Visible = false
Humanoid.DisplayDistanceType = "None"
Humanoid.MaxHealth = 9999

Humanoid.Health = 9999
GainCharge = function()
	Humanoid.MaxHealth = 9999
	Humanoid.Health = 9999
end

Humanoid.HealthChanged:connect(function() GainCharge(Humanoid) end) 		

function chatfunc(msg)
	coroutine.wrap(function()
		Swait()
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
				v.StudsOffset += Vector3.new(0,1,0)
			end
		end
		local bil = Instance.new('BillboardGui')
		bil.Name = "DestroyerChatLabelIUFH"..owner.Name
		bil.Parent = workspace
		pcall(function()
			bil.Adornee = Head
		end)
		bil.LightInfluence = 0
		bil.Size = UDim2.new(1000,0,1,0)
		bil.StudsOffset = Vector3.new(-0.7,2.5,0)
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
				txt.TextColor3=Color3.new(1,0,0)
				txt.TextStrokeTransparency=0
				txt.TextStrokeColor3=Color3.new(0.5,0,0)
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
			Swait()
		end
		game:GetService("Debris"):AddItem(bil,6+children)
		coroutine.wrap(function()
			repeat
				pcall(function()
					Swait()
					if #bil:GetChildren() <= 0 then
						bil:Destroy()
					end
					bil.Adornee = Head
					bil.Parent = workspace
				end)
			until not bil:IsDescendantOf(workspace)
		end)()
		coroutine.wrap(function()
			repeat
				pcall(function()
					Swait()
					for i,v in next, texts do
						if(i ~= #texts)then
							coroutine.wrap(function()
								local tw = game:GetService('TweenService'):Create(v,TweenInfo.new(.1),{
									Position = UDim2.new(0.5-(-i*(0.001/2)), 0+math.random(-2,2), 0.5, 0+math.random(-2,2)),
									Rotation = math.random(-10,10)
								})
								tw:Play()
							end)()
						else
							local tw = game:GetService('TweenService'):Create(v,TweenInfo.new(.1),{
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
					Swait()
					for i,v in next, texts do
						if math.random(1,5) == 1 then
							local tx = v:Clone()
							tx.Parent = bil
							tx.TextColor3 = Color3.new(1,0,0)
							tx.TextStrokeColor3 = Color3.new(0.5,0,0)
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
					task.wait(math.random())
				end)
			until not bil:IsDescendantOf(workspace)
		end)()
	end)()
end

local onchatted
onchatted = owner.Chatted:Connect(function(message)
	chatfunc(message)
end)
local charadded

charadded = owner.CharacterAdded:Connect(function()
	pcall(function()
		onchatted:Disconnect()
	end)
	pcall(function()
		charadded:Disconnect()
	end)
	pcall(function()
		artificialhbconnection:Disconnect()
	end)
end)

local RingThing = 0
local RingThing2 = 0
local wtime = 0
coroutine.resume(coroutine.create(function()
	while Humanoid.Health>0.001 do 
		if(not Character or not Character:IsDescendantOf(workspace))then
			pcall(function()
				onchatted:Disconnect()
			end)
		end
		sine = sine + (change/(FrameFPS/30))
		local hitfloor = rayCast(RootPart.Position, CFrame.new(RootPart.Position, RootPart.Position - Vector3.new(0, 1, 0)).lookVector, 4, Character)

		local torvel = (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude
		local velderp = RootPart.Velocity.y
		if RootPart.Velocity.y > 1 and hitfloor == nil then
			Anim = "Jump"

		elseif RootPart.Velocity.y < -1 and hitfloor == nil then
			Anim = "Fall"
		elseif Humanoid.Sit == true then
			Anim = "Sit"	
		elseif torvel == 0 and hitfloor ~= nil  then
			Anim = "Idle"
		elseif torvel > 0 and  hitfloor ~= nil  then

			Anim = "Walk"




		else
			Anim = ""

		end 



		local Ccf=RootPart.CFrame
		--warn(Humanoid.MoveDirection*RootPart.CFrame.lookVector)
		local Walktest1 = Humanoid.MoveDirection*Ccf.LookVector
		local Walktest2 = Humanoid.MoveDirection*Ccf.RightVector
		--warn(Walktest1.Z.."/"..Walktest1.X)
		--warn(Walktest2.Z.."/"..Walktest2.X)
		forWFB = Walktest1.X+Walktest1.Z
		forWRL = Walktest2.X+Walktest2.Z



		--print(Humanoid.MoveDirection)
		--warn(Torso.CFrame.lookVector)
		RingThing = RingThing + ((1/15)/(FrameFPS/30))
		if RingThing > RingThing2 then
			RingThing2 = RingThing+(.5/(FrameFPS/30))
			if  Character:FindFirstChild("Spin") then 
				SetTween(spinweld,{C0 = CF(0,3,0)*ANGLES(0,mr(-RingThing*180),0)},"Linear","Out",.3) 
				SetTween(spinweld2,{C0 = CF(0,3,0)*ANGLES(0,mr(RingThing*180),0)},"Linear","Out",.3) 


			end

			--	spinweld.C0 = spinweld.C0*ANGLES(0,mr(-10),0)
		end


		coroutine.resume(coroutine.create(function()


			if s2.Parent == nil or s2 == nil  then

				s2 = s2c:Clone()
				s2.Parent = Torso
				s2.Name = "BGMusic"
				s2.SoundId = lastid
				s2.Pitch = 1
				s2.Volume = .8
				s2.Looped = true
				s2.archivable = false
				s2.TimePosition = lastsongpos
				if playsong == true then
					s2:play()		
				elseif playsong == false then
					s2:stop()			
				end


			else
				lastsongpos=s2.TimePosition		
				s2.Pitch = 1
				s2.Volume = .8
				s2.Looped = true
				s2.SoundId = lastid
				s2.EmitterSize = 30
				if(playsong)then
					s2:Resume()
				end
			end
		end))




		inairvel=torvel*1

		--forWRL
		if inairvel > 30 then
			inairvel=30	
		end
		inairvel=inairvel/(1.5*(FrameFPS/30))

		if Anim == "Walk" and forWFB > .45 then
			wtime = wtime + (0.025/(FrameFPS/30))
			if wtime > 1 and mememode == false then
				wtime = 1
			end
			if wtime > 1 and mememode == true  then
				wtime = 1
			end


		else
			local v1a= VT(wtime,0,0):Lerp(VT(0,0,0),.05)
			if mememode == true then
				if Anim == "Walk" then
					v1a= VT(wtime,0,0):Lerp(VT(.5,0,0),.025)	
				else
					v1a= VT(wtime,0,0):Lerp(VT(.25,0,0),.05)	

				end	
			end

			wtime = v1a.X
		end

		if attack == false then
			if Anim == "Jump" then
				change = 0.60*2
				SetTween(RJW,{C0=RootCF* cn(0, 0 + (0.0395/2) * math.cos(sine / 8), -0.1 + 0.0395 * math.cos(sine / 8)) * angles(math.rad(-6.5 - 1.5 * math.cos(sine / 8))+(inairvel*forWFB)/2, math.rad(0)-(inairvel*forWRL)/2, math.rad(0))},"Quad","Out",0.25)
				SetTween(NeckW,{C0=NeckCF*cn(0,0,0)*angles(math.rad(-26.5 + 2.5 * math.cos(sine / 8)), math.rad(0), math.rad(-0))},"Quad","Out",0.25)
				SetTween(RW,{C0=cn(1.4 + .05 * math.cos(sine / 8) , 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(170 - 2 * math.cos(sine / 8 )), math.rad(-5), math.rad(8 + 4 * math.cos(sine / 8)))},"Quad","Out",0.2)
				SetTween(LW,{C0=cn(-1.4 + .05 * math.cos(sine / 8), 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(140 - 2 * math.cos(sine / 8 )), math.rad(5), math.rad(-8 - 4 * math.cos(sine / 8 )))},"Quad","Out",0.2)
				SetTween(RH,{C0=cn(.5, -0.85+ .05 * math.cos(sine / 15), -.2) * CFrame.Angles(math.rad(-15 -1* math.cos(sine / 10)),math.rad(0),math.rad(0))},"Quad","InOut",0.075)
				SetTween(LH,{C0=cn(-.5, -0.35+ .05 * math.cos(sine / 15), -.4) * CFrame.Angles(math.rad(-25 +1* math.cos(sine / 10)),math.rad(0),math.rad(0))},"Quad","InOut",0.075)


				SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(60 + 2 * math.cos(sine / 8 )),math.rad(0),math.rad(0))},"Quad","Out",0.125)



			elseif Anim == "Fall" then 
				change = 0.60*2
				SetTween(RJW,{C0=RootCF*cn(0, 0 + (0.0395/2) * math.cos(sine / 8), -0.5 + 0.0395 * math.cos(sine / 8)) * angles(math.rad(5.5 - 1.5 * math.cos(sine / 8))-(inairvel*forWFB)/2, math.rad(0)+(inairvel*forWRL)/2, math.rad(0))},"Quad","Out",0.35)
				SetTween(NeckW,{C0=NeckCF*cn(0,0,0)*angles(math.rad(26.5 + 2.5 * math.cos(sine / 8)), math.rad(0), math.rad(-0))},"Quad","Out",0.25)
				SetTween(RW,{C0=cn(1.4 + .05 * math.cos(sine / 8) , 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(155 -forWFB*60), math.rad(25), math.rad(30 + 4 * math.cos(sine / 8)))},"Quad","Out",0.2)
				SetTween(LW,{C0=cn(-1.4 + .05 * math.cos(sine / 8), 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(105 - forWFB*60), math.rad(-25), math.rad(-30 - 4 * math.cos(sine / 8 )))},"Quad","Out",0.2)
				SetTween(RH,{C0=cn(.5, -0.15+ .05 * math.cos(sine / 15), -.4) * CFrame.Angles(math.rad(-15 -1* math.cos(sine / 10)),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(LH,{C0=cn(-.5, -0.55+ .05 * math.cos(sine / 15), -.4) * CFrame.Angles(math.rad(-0 +1* math.cos(sine / 10)),math.rad(0),math.rad(0))},"Quad","InOut",0.1)

				SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(60 + 2 * math.cos(sine / 8 )),math.rad(0),math.rad(0))},"Quad","Out",0.125)



			elseif Anim == "Idle" then


				local dahspeed=1
				if attack == true and mememode == true then
					dahspeed=4
				end


				if mememode == false then
					change = (0.60*1.5)*dahspeed
					Humanoid.JumpPower = 60	
					Humanoid.WalkSpeed=16	



					local ADNum = 0	
					SetTween(RJW,{C0=RootCF*cn(0, 0, -0.1 + 0.0395 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2))) * angles(math.rad(1.5 - 1 * math.cos(sine / 8)), math.rad((0 + 0* math.cos(sine / 8)/20)), math.rad(-20))},"Quad","InOut",0.125)
					SetTween(NeckW,{C0=NeckCF*angles(math.rad(13.5 - 3 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2))), math.rad(2.5-5.5 * math.sin(sine / 16)), math.rad(20 - 6.5 * math.cos(sine / 15 +.4* math.cos(sine / 10))))},"Quad","InOut",0.2)
					SetTween(RW,{C0=cf(1.45 + .0 * math.cos(sine / 8) , 0.5 + forWRL/50* math.cos(sine / 8), 0)   * angles(math.rad(90 + 1 * math.cos(sine / 8 )), math.rad(30), math.rad(30 ))},"Quad","Out",.2)
					SetTween(LW,{C0=cf(-1.45 + .0 * math.cos(sine / 8), 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(0 - 4 * math.cos(sine / 8 )), math.rad(5), math.rad(-8 - 4 * math.sin(sine / 8 )))},"Quad","Out",0.2)
					SetTween(RH,{C0=CFrame.new(.5, -0.95- .04 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2)), 0) * CFrame.Angles(math.rad(1.5 - 1 * math.cos(sine / 8)),math.rad(0),math.rad(2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",0.125)
					SetTween(LH,{C0=CFrame.new(-.5, -0.95- .04 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2)), 0) * CFrame.Angles(math.rad(1.5 - 1 * math.cos(sine / 8)),math.rad(20),math.rad(-2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",0.125)


					SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(65 - 1 * math.cos(sine / 8 )),math.rad(0),math.rad(30))},"Quad","Out",0.125)
				else


					change = (0.60*2)*dahspeed
					local ADNum = 0	
					SetTween(RJW,{C0=RootCF*cn(0, 0 + 0.05 * math.sin(sine / 8 +ADNum* math.cos(sine / 8*2)), -0.1 + 0.0395 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2))) * angles(math.rad(3.5 - 3 * math.sin(sine / 8)), math.rad((0 + 0* math.cos(sine / 8)/20)), math.rad(-0))},"Quad","InOut",0.125)
					SetTween(NeckW,{C0=NeckCF*angles(math.rad(13.5 - 3 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2))), math.rad(2.5-5.5 * math.sin(sine / 16)), math.rad(0 - 12.5 * math.cos(sine / 15 +.4* math.cos(sine / 10))))},"Quad","InOut",0.2)

					SetTween(RW,{C0=cf(1.45 + .0 * math.cos(sine / 8), 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(3 + 2 * math.cos(sine / 8 )), math.rad(-5), math.rad(8 + 4 * math.sin(sine / 8 )))},"Quad","Out",0.2)

					SetTween(LW,{C0=cf(-1.45 + .0 * math.cos(sine / 8), 0.5 + .05 * math.cos(sine / 8), .0) * angles(math.rad(3 + 2 * math.cos(sine / 8 )), math.rad(5), math.rad(-8 - 4 * math.sin(sine / 8 )))},"Quad","Out",0.2)
					SetTween(RH,{C0=CFrame.new(.5, -0.95- .04 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2)), 0) * CFrame.Angles(math.rad(3.5 - 3 * math.sin(sine / 8)),math.rad(0),math.rad(2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",0.125)
					SetTween(LH,{C0=CFrame.new(-.5, -0.95- .04 * math.cos(sine / 8 +ADNum* math.cos(sine / 8*2)), 0) * CFrame.Angles(math.rad(3.5 - 3 * math.sin(sine / 8)),math.rad(20),math.rad(-2.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",0.125)


					SetTween(RWingJ1,{C0 = ANGLES(mr(-15),mr(45-15* math.sin(sine / 8*1)),mr(-25))},"Linear","Out",.2)
					SetTween(RWingJ2,{C0 = ANGLES(mr(0),mr(25+25* math.cos(sine / 8*1)),0)},"Linear","Out",.2)

					SetTween(LWingJ1,{C0 = ANGLES(mr(-15),mr(-45+15* math.sin(sine / 8*1)),mr(25))},"Linear","Out",.2)
					SetTween(LWingJ2,{C0 = ANGLES(mr(0),mr(-25-25* math.cos(sine / 8*1)),0)},"Linear","Out",.2)




				end	

			elseif Anim == "Walk" then
				local speed=1+wtime
				if mememode == true then
					speed=1+wtime*2
				end


				if mememode == false then
					change = (2.3*speed)-wtime*.25
					Humanoid.JumpPower = 60*speed
					Humanoid.WalkSpeed=15*speed


					local RH2 = cf(-forWRL/6 * math.cos(sine / 8 ),0,forWFB/6 * math.cos(sine / 8 ))*angles(math.rad(-forWFB*(30+wtime*15)) * math.cos(sine / 8 ),0,math.rad(-forWRL*(30+wtime*5)) * math.cos(sine / 8 ))
					local LH2 = cf(forWRL/6 * math.cos(sine / 8 ),0,-forWFB/6 * math.cos(sine / 8 ))*angles(math.rad(forWFB*(30+wtime*15)) * math.cos(sine / 8 ),0,math.rad(forWRL*(30+wtime*5)) * math.cos(sine / 8 ))

					SetTween(RJW,{C0=RootCF*CFrame.new((forWRL/4)*wtime  * math.sin(sine / 4) , (-forWFB/4)*wtime  * math.cos(sine / 4)  , -0.065 + 0.155 * math.cos(sine / 4)  ) * angles(math.rad((forWFB*(1+(wtime*2)) -  (forWFB*.7)  * math.cos(sine / 4))*10), math.rad((-forWRL +forWRL  * math.cos(sine / 4))*5) , math.rad(6 * math.cos(sine / 8)))},"Linear","InOut",WalkAnimMove/speed)
					SetTween(NeckW,{C0=NeckCF*CFrame.new(0, 0, 0 + 0.025 * math.cos(sine / 4)) * angles( math.rad( 10 + ( ( -forWFB * ( 1 + (wtime*2) )   -  -(forWFB *.7)  * math.cos( sine / 4) )*    8)-5  * math.sin(sine / 4)   ), math.rad((forWRL - forWRL  * math.cos(sine / 4))*-5), math.rad(-forWRL*45+-6 * math.cos(sine / 8)))},"Linear","InOut",WalkAnimMove/speed)
					SetTween(RW,{C0=cf(1.45 + .0 * math.cos(sine / 8) , 0.5 + forWRL/50* math.cos(sine / 8), 0)   * angles(math.rad(120+forWFB*20 - 2*forWFB * math.cos(sine / 4 )), math.rad(30-forWRL*20), math.rad(forWRL*20+(12 * math.cos(sine / 8))+10 + forWRL*5 * math.cos(sine / 8)))},"Quad","Out",WalkAnimMove/speed+.1)
					SetTween(LW,{C0=cf(-1.45 + .0 * math.cos(sine / 8), 0.5 + forWRL/50  * math.cos(sine / 8), 0)  * angles(math.rad(0 - forWFB*(25+wtime*20) * math.cos(sine / 8 )), math.rad(-10), math.rad((-forWFB*10 * math.cos(sine / 8 ))-8 - forWRL*5 * math.cos(sine / 8 )))},"Quad","Out",WalkAnimMove/(speed-.1))
					SetTween(RH,{C0=CFrame.new(.5, -0.85+( .20 * math.sin(sine / 8 )-( .10 * math.cos(sine / 8 ))) , -.15+.15* math.cos(sine / 8 ))*RH2 * CFrame.Angles(math.rad(0 - 5 * math.cos(sine / 8)),math.rad(-3 * math.cos(sine / 8)),math.rad(0.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",WalkAnimMove/(speed+.2))
					SetTween(LH,{C0=CFrame.new(-.5, -0.85-( .20 * math.sin(sine / 8 )-( .10 * math.cos(sine / 8 ))) , -.15-.15* math.cos(sine / 8 ))*LH2 * CFrame.Angles(math.rad(0 + 5 * math.cos(sine / 8)),math.rad(-3 * math.cos(sine / 8)),math.rad(-0.5- 0.0 * math.cos(sine / 8)))},"Quad","InOut",WalkAnimMove/(speed+.2))


					SetTween(SwordJoint,{C0=CFrame.new(0,-.5,-.5)*angles(math.rad(65 + 2 * math.sin(sine / 4 )),math.rad(forWRL*5),math.rad(30-forWRL*20))},"Quad","Out",0.125)
				else	
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


					change = (2.3*speed)-wtime*.25
					Humanoid.JumpPower = 60*speed
					Humanoid.WalkSpeed=(22*speed)*1*wtime

					SetTween(RJW,{C0=RootCF*cn(0,0,(1+.25*math.sin(sine/16))*wtime)*angles(math.rad((60*wtime*forWFB)+5*math.cos(sine/16)),math.rad(-50*wtime*forWRL),math.rad(0))},"Quad","InOut",0.1)
					SetTween(NeckW,{C0=NeckCF*cn(0,0,0)*angles(math.rad((-30*wtime*forWFB)+5*math.cos(sine/16)),math.rad(0),math.rad(-45*forWRL))},"Quad","InOut",0.1)
					SetTween(RW,{C0=cn(1.5 , 0.5, -.0)*angles(math.rad(((-45*forWFB)+4*math.cos(sine/16))+25*forWRL  ),math.rad(5),math.rad((25-5*forWFB*math.sin(sine/16)) +wtime*25*forWRL  ))},"Quad","Out",0.1)
					SetTween(LW,{C0=cn(-1.5, 0.5, -.0)*angles(math.rad(((-45*forWFB)+4*math.cos(sine/16))-25*forWRL),math.rad(-5),math.rad((-25+5*forWFB*math.sin(sine/16)) +wtime*25*forWRL ))},"Quad","Out",0.1)
					SetTween(RH,{C0=cn(.5, -1, 0)*angles(math.rad((-30*forWFB*wtime)+(15*wtime*math.cos(sine/16))),math.rad(0),math.rad(-25*forWRL*wtime))},"Quad","InOut",0.1)
					SetTween(LH,{C0=cn(-.5, (-.75+.25*(1-wtime))+(.25*forWFB*wtime), (-.15-.15*forWFB)*wtime)*angles(math.rad((-10*forWFB*wtime)+(15*wtime*math.cos(sine/16))),math.rad(0),math.rad(-25*wtime*forWRL))},"Quad","InOut",0.1)

					SetTween(RWingJ1,{C0 = ANGLES(mr(-15),mr(45-45* math.sin(sine /16)),mr(-45* math.sin(sine / 16)))},"Linear","Out",.3)
					SetTween(RWingJ2,{C0 = ANGLES(mr(0),mr(25+25* math.cos(sine / 16)),0)},"Linear","Out",.2)

					SetTween(LWingJ1,{C0 = ANGLES(mr(-15),mr(-45+45* math.sin(sine / 16)),mr(45* math.sin(sine /16)))},"Linear","Out",.3)
					SetTween(LWingJ2,{C0 = ANGLES(mr(0),mr(-25-25* math.cos(sine / 16)),0)},"Linear","Out",.2)



				end	

			elseif Anim == "Sit" then	
				SetTween(RJW,{C0=RootCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(NeckW,{C0=NeckCF*CFrame.new(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(RW,{C0=CFrame.new(1.5 , 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
				SetTween(LW,{C0=CFrame.new(-1.5, 0.5, -.0)*angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",0.1)
				SetTween(RH,{C0=CFrame.new(.5, -1, 0)*angles(math.rad(90),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(LH,{C0=CFrame.new(-.5, -1, 0)*angles(math.rad(90),math.rad(0),math.rad(0))},"Quad","InOut",0.1)
				SetTween(SwordJoint,{C0=CFrame.new(0,-1,0)*angles(math.rad(-10 + 2 * math.cos(sine / 8 )),math.rad(0),math.rad(0))},"Quad","Out",0.125)


			end
		end

		Swait(Animstep*FrameFPS)
	end
end))
coroutine.resume(coroutine.create(function()			
	local	remote = Instance.new 'RemoteFunction';
	remote.Parent = Character;
	remote.OnServerInvoke = function (player, request, ...)
		if (player ~= Player) then
			return error ('You cannot invoke this remote', 0);
		end;



		if (request == 1) then
			local k = ...;

			KeyDownF(k)



		end;
		if (request == 2) then
			local k = ...;

			KeyUpF(k)



		end;
		if (request == 3) then
			local k = ...;
			if k == "Down" then
				Button1DownF(k)
			elseif k == "Up" then
				Button1UpF(k)
			end
		end;


		if (request == 4) then
			local k=...;
			--MTARGET=k
		end
		if (request == 5) then
			local 	k=...;
			Target=k.p

		end	
	end;
	remote.Name = 'ServerRemote';
	--local remote = NLS ([=[
	local localscript = NLS([[while script.Name == "Keys" do wait()
	
end 
Player = nil

Player = 	game:GetService("Players"):WaitForChild(script.Name)

Character = Player.Character
remote=Player.Character:WaitForChild 'ServerRemote';

local mouse = Player:GetMouse();
plr=Player
local mouse = Player:GetMouse();
mouse.Move:connect(function()
	remote:InvokeServer (4, mouse.Target);
	 remote:InvokeServer (5, mouse.hit);
end)


mouse.Button1Down:connect(function()
	
	remote:InvokeServer (3, "Down");	
end)
mouse.Button1Up:connect(function()
	
	remote:InvokeServer (3, "Up");	
end)
mouse.KeyDown:connect(function(k)
	k = k:lower()
	
	remote:InvokeServer (1, k);
end)

mouse.KeyUp:connect(function(k)
	k = k:lower()
	
	remote:InvokeServer (2, k);
end)
]], Character)
	localscript.Name = Player.Name
end))]==]

local oldsc = nil
local hblooop = nil
local lastcf = CFrame.new(0,20,0)

function loadthescript()
	pcall(function()
		task.cancel(oldsc)
	end)
	script.Parent = game:GetService('ServerScriptService')
	script:ClearAllChildren()
	local char = nil
	local hum = nil
	if(not owner.Character)or(not owner.Character:FindFirstChildOfClass("Humanoid"))then
		return
	else
		char = owner.Character
		hum = char:FindFirstChildOfClass("Humanoid")
	end
	pcall(function()
		hblooop:Disconnect()
	end)
	local function remake()
		hblooop:Disconnect()
		owner:LoadCharacter()
		coroutine.wrap(function()
			if(owner.Character)then
				local root = owner.Character:WaitForChild("HumanoidRootPart")
				root.CFrame = lastcf
			end
		end)()
	end
	local CheckForNames = {
		"Torso",
		"Head",
		"HumanoidRootPart",
		"Right Arm",
		"Left Arm",
		"Right Leg",
		"Left Leg",
		"Neck",
		"RootJoint",
		"Right Shoulder",
		"Left Shoulder",
		"Right Hip",
		"Left Hip"
	}
	hblooop = game:GetService('RunService').Heartbeat:Connect(function()
		if(not char or not char:IsDescendantOf(workspace))then
			remake()
			return
		end
		hum = char:FindFirstChildOfClass("Humanoid")
		if(char and char:FindFirstChild("HumanoidRootPart"))then
			lastcf = char:FindFirstChild("HumanoidRootPart").CFrame
		end
		if(not hum or not hum:IsDescendantOf(char) or hum.Health < 1 or hum.MaxHealth < 1)then
			remake()
			return
		end
		local descendants = char:GetDescendants()
		for i,v in next, CheckForNames do
			local found = false
			for i,a in next, descendants do
				if(a.Name == v)then
					found = true
					break
				end
			end
			if(not found)then
				remake()
				return
			end
		end
	end)
	for _,obj in pairs(Objects) do
		obj:Clone().Parent = script
	end
	oldsc = task.spawn(function()
		task.wait(1/30)
		local load, err = loadstring(scloadstring)
		if(load)then
			load()
		else
			print('There was an error: '..err)
		end
	end)
end

loadthescript()
owner.CharacterAdded:Connect(loadthescript)