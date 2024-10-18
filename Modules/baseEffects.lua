
-- Services
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")


-- Modules
local GeneralUse = (function()
	-- Services
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local TweenService = game:GetService("TweenService")

	-- Instances

	local GeneralUse = {}

	-- Returns a value using the given ratio.
	function GeneralUse.basedValue(baseValue,scaleValue,currentValue) 
		--  print(z,y,x)
		local getBasedValueFuncs = {}

		local function multiplyScaleValue(value)
			return (currentValue*value)/baseValue
		end
		function getBasedValueFuncs.NumberSequence()
			local basedKeypoints = {}
			for i,keypoint in pairs(scaleValue.Keypoints) do
				basedKeypoints[i] = NumberSequenceKeypoint.new(keypoint.Time,multiplyScaleValue(keypoint.Value),multiplyScaleValue(keypoint.Envelope)) 
			end
			return NumberSequence.new(basedKeypoints)
		end

		function getBasedValueFuncs.NumberRange()
			return NumberRange.new(
				multiplyScaleValue(scaleValue.Min),
				multiplyScaleValue(scaleValue.Max)
			)
		end

		function getBasedValueFuncs.Default()
			return multiplyScaleValue(scaleValue)
		end

		return (getBasedValueFuncs[typeof(scaleValue)] or getBasedValueFuncs.Default)()
	end

	function GeneralUse.Round(number,decimalPlaces)
		local decimalPlaces = (decimalPlaces or 0)
		local newNum = math.round(number * 10^decimalPlaces) * 10^-decimalPlaces

		newNum=tonumber(string.format("%." .. (decimalPlaces) .. "f", newNum))
		return newNum
	end

	function GeneralUse.CalcWeldC0(cf0,cf1)
		return cf0:ToObjectSpace(cf1)
	end

	local function joinParts(name,p0,p1,c0,c1,parent)
		local joinObject = Instance.new(name)
		joinObject.Part0 = p0
		joinObject.Part1 = p1
		if name~="WeldConstraint" then

			joinObject.C0 = c0 or GeneralUse.CalcWeldC0(p0.CFrame,p1.CFrame)
			if c1 then
				joinObject.C1 = c1
			end
		end
		joinObject.Parent = parent or p0
		return joinObject
	end

	function GeneralUse.AddMotor6D(...):Motor6D
		return joinParts("Motor6D",...)
	end

	function GeneralUse.Weld(...):Weld
		return joinParts("Weld",...)
	end

	function GeneralUse.AddWeldConstraint(...):WeldConstraint
		return joinParts("WeldConstraint",...)
	end
	function GeneralUse.GetTargetFromHit(hit)
		local target
		if hit.Parent:FindFirstChild("Humanoid") then
			target = hit.Parent

		elseif hit.Parent.Parent:FindFirstChild("Humanoid") then
			target = hit.Parent.Parent
		end
		return target
	end
	function GeneralUse.GetFirstCollidable(startPos,angle,ignoreList,includeChars,debugMode):RaycastResult   -- Raycasts from the startPos using the given angle (or Vector3.new(0,-100,0) if left nil) using the given ignore list. Returns the first collidable hit or nil if it hits nothing. If includeChars is true then it will include parts that are parented to characters
		angle = angle or Vector3.new(0,-1000,0)
		ignoreList = ignoreList or {}
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = ignoreList
		--raycastParams.IgnoreWater = true
		local firstCollide
		while true do
			raycastParams.FilterDescendantsInstances = ignoreList
			local result = workspace:Raycast(startPos,angle, raycastParams)
			if debugMode then
				--print(result)
			end
			if result then
				local hit = result.Instance
				local canContinue = true

				local target = GeneralUse.GetTargetFromHit(hit)
				if target then
					if not includeChars then            
						canContinue = false
						table.insert(ignoreList,1,target)
					end
				else
					if not hit.CanCollide then
						canContinue = false
					end
				end


				if canContinue then
					firstCollide = result
					break
				else
					table.insert(ignoreList,1,hit)
				end
			else
				break
			end
		end
		return firstCollide,ignoreList
	end

	function GeneralUse.ScaleParticle(baseNum,particle,givenNum,categories,baseParticle)
		categories = categories or {
			"Size";
			"Speed";
			"Acceleration";
		}

		for _,category in pairs(categories) do
			particle[category] = GeneralUse.basedValue(baseNum,(baseParticle or particle)[category],givenNum)
		end
		return particle
	end
	function GeneralUse:GetShakeOffset(shakeStrength:number,shakeTime:number?,fadeOut:TweenInfo,doShakeFunc,optSettings)
		optSettings=optSettings or {}
		local shakeWait = optSettings.shakeWait or .04
		local fadeIn = optSettings.fadeIn

		local stopShake = false
		local shakeValue = Instance.new("NumberValue")
		shakeValue.Value = shakeStrength


		local shakeMut = Instance.new("NumberValue")
		shakeMut.Value = fadeIn and 0 or 1

		if fadeIn then
			TweenService:Create(shakeMut,fadeIn,{Value = 1}):Play()
		end
		task.spawn(function()
			repeat
				doShakeFunc(function(basePosition,epicenter,shakeDist,noRandomize)
					local strength = shakeValue.Value
					local newStrength

					if basePosition and epicenter and shakeDist then
						local distFromCenter = (basePosition - epicenter).Magnitude
						newStrength = math.clamp((shakeDist*strength)/distFromCenter,0,strength)
					else
						newStrength = strength
					end
					if not noRandomize then
						local randomObject = Random.new()
						newStrength = randomObject:NextNumber(-newStrength,newStrength)
					end
					return newStrength*shakeMut.Value
				end,shakeWait)
				task.wait(shakeWait)
			until stopShake
		end)

		task.wait(shakeTime)

		TweenService:Create(shakeValue,fadeOut,{Value = 0}):Play()
		task.wait(fadeOut.Time)
		stopShake = true
	end

	return GeneralUse
end)()
local NumberHelper = (function()
	local NumberHelper = {}

	-- Returns a random number between min and max (Default: .8 - 1.2)
	function NumberHelper.Random(min:number,max:number):number
		return Random.new():NextNumber(min or .8,max or 1.2)
	end

	-- Returns either 1 or -1 randomly
	function NumberHelper.RandomReverseMutlipler():number
		return (math.random(0,1) == 1 and 1 or -1)
	end

	-- Returns a random rotation from -360 to 360 in radians
	function NumberHelper.RandomRotation():number
		local fullRot = 2*math.pi
		return NumberHelper.Random(-fullRot,fullRot)
	end

	function NumberHelper.Round(number,decimalPlaces)
		decimalPlaces = (decimalPlaces or 0)
		local newNum = math.round(number * 10^decimalPlaces) * 10^-decimalPlaces

		newNum=tonumber(string.format("%." .. (decimalPlaces) .. "f", newNum))
		return newNum
	end

	function NumberHelper.NumberToVector3(num) -- Returns a Vector3 with the given number in every value
		return Vector3.new(num,num,num)
	end

	function NumberHelper.ScaleValue(baseValue,scaleValue,currentValue) 
		local getBasedValueFuncs = {}

		local function multiplyScaleValue(value)
			return (currentValue*value)/baseValue
		end
		function getBasedValueFuncs.NumberSequence()
			local basedKeypoints = {}
			for i,keypoint in pairs(scaleValue.Keypoints) do
				basedKeypoints[i] = NumberSequenceKeypoint.new(keypoint.Time,multiplyScaleValue(keypoint.Value),multiplyScaleValue(keypoint.Envelope)) 
			end
			return NumberSequence.new(basedKeypoints)
		end

		function getBasedValueFuncs.NumberRange()
			return NumberRange.new(
				multiplyScaleValue(scaleValue.Min),
				multiplyScaleValue(scaleValue.Max)
			)
		end

		function getBasedValueFuncs.Default()
			return multiplyScaleValue(scaleValue)
		end

		return (getBasedValueFuncs[typeof(scaleValue)] or getBasedValueFuncs.Default)()
	end

	function NumberHelper.GetRootScaleValues(rootSize)
		return Vector3.new(2,2,1).Magnitude,rootSize.Magnitude
	end

	function NumberHelper.GetLargestAxis(vector3:Vector3):(number,string)
		local largestVector = {size=vector3.X,name = 'X'}
		local function checkLargest(axis:string)
			local newSize:number = vector3[axis]
			if largestVector.size <= newSize then
				largestVector.size = newSize
				largestVector.name = axis
			end
		end
		checkLargest("Y")
		checkLargest("Z")
		return largestVector.size,largestVector.name
	end

	function NumberHelper.SineBetween(t:number,maxNumber:number,minNumber:number, frequency:number,phase:number)
		return ((maxNumber-minNumber)*math.sin(t*frequency +  phase) + maxNumber + minNumber)/2
	end
	return NumberHelper
end)()
local PartChache = (function()


--[[
    PartCache V4.0 by Xan the Dragon // Eti the Spirit -- RBX 18406183
    Update V4.0 has added Luau Strong Type Enforcement.
    
    Creating parts is laggy, especially if they are supposed to be there for a split second and/or need to be made frequently.
    This module aims to resolve this lag by pre-creating the parts and CFraming them to a location far away and out of sight.
    When necessary, the user can get one of these parts and CFrame it to where they need, then return it to the cache when they are done with it.
    
    According to someone instrumental in Roblox's backend technology, zeuxcg (https://devforum.roblox.com/u/zeuxcg/summary)...
        >> CFrame is currently the only "fast" property in that you can change it every frame without really heavy code kicking in. Everything else is expensive.
        
        - https://devforum.roblox.com/t/event-that-fires-when-rendering-finishes/32954/19
    
    This alone should ensure the speed granted by this module.
        
        
    HOW TO USE THIS MODULE:
    
    Look at the bottom of my thread for an API! https://devforum.roblox.com/t/partcache-for-all-your-quick-part-creation-needs/246641
--]]
	local table = (function()
		--^ It works. Just get the type checker to shut up so that people don't send bug reports :P

--[[
    To use: local table = require(this)
    (Yes, override table.)
 
    Written by EtiTheSpirit. Adds custom functions to the `table` value provided by roblox (in normal cases, this would simply modify `table`, but Roblox has disabled that so we need to use a proxy)
    
    CHANGES:
        3 December 2019 @ 11:07 PM CST:
            + Added table.join
            
            
        21 November 2019 @ 6:50 PM CST:
            + Added new method bodies to skip/take using Luau's new methods. Drastic speed increases achieved. CREDITS: Halalaluyafail3 (See https://devforum.roblox.com/t/sandboxed-table-system-add-custom-methods-to-table/391177/12?u=etithespirit)
            + Added table.retrieve as proposed by ^ under the name "table.range" as this name relays what it does a bit better, I think.
            + Added table.skipAndTake as an alias method.
 
--]]

		local RNG = Random.new()
		local Table = {}

		for index, value in pairs(table) do
			Table[index] = value
		end

		-- Returns true if the table contains the specified value.
		Table.contains = function (tbl, value)
			return Table.indexOf(tbl, value) ~= nil -- This is kind of cheatsy but it promises the best performance.
		end

		-- A combo of table.find and table.keyOf -- This first attempts to find the ordinal index of your value, then attempts to find the lookup key if it can't find an ordinal index.
		Table.indexOf = function (tbl, value)
			local fromFind = table.find(tbl, value)
			if fromFind then return fromFind end

			return Table.keyOf(tbl, value)
		end

		-- Returns the key of the specified value, or nil if it could not be found. Unlike IndexOf, this searches every key in the table, not just ordinal indices (arrays)
		-- This is inherently slower due to how lookups work, so if your table is structured like an array, use table.find
		Table.keyOf = function (tbl, value)
			for index, obj in pairs(tbl) do
				if obj == value then
					return index
				end
			end
			return nil
		end

		-- ONLY SUPPORTS ORDINAL TABLES (ARRAYS). Skips *n* objects in the table, and returns a new table that contains indices (n + 1) to (end of table)
		Table.skip = function (tbl, n)
			return table.move(tbl, n+1, #tbl, 1, table.create(#tbl-n))
		end

		-- ONLY SUPPORTS ORDINAL TABLES (ARRAYS). Takes *n* objects from a table and returns a new table only containing those objects.
		Table.take = function (tbl, n)
			return table.move(tbl, 1, n, 1, table.create(n))
		end

		-- ONLY SUPPORTS ORDINAL TABLES (ARRAYS). Takes the range of entries in this table in the range [start, finish] and returns that range as a table.
		Table.range = function (tbl, start, finish)
			return table.move(tbl, start, finish, 1, table.create(finish - start + 1))
		end

		-- ONLY SUPPORTS ORDINAL TABLES (ARRAYS). An alias that calls table.skip(skip), and then takes [take] entries from the resulting table.
		Table.skipAndTake = function (tbl, skip, take)
			return table.move(tbl, skip + 1, skip + take, 1, table.create(take))
		end

		-- ONLY SUPPORTS ORDINAL TABLES (ARRAYS). Selects a random object out of tbl
		Table.random = function (tbl)
			return tbl[RNG:NextInteger(1, #tbl)]
		end

		-- ONLY SUPPORTS ORDINAL TABLES (ARRAYS). Merges tbl0 and tbl1 together.
		Table.join = function (tbl0, tbl1)
			local nt = table.create(#tbl0 + #tbl1)
			--local t2 = table.move(tbl0, 1, #tbl0, 1, nt)
			return table.move(tbl1, 1, #tbl1, #tbl0 + 1, nt)
		end

		-- ONLY SUPPORTS ORDINAL TABLES (ARRAYS). Removes the specified object from this array.
		Table.removeObject = function (tbl, obj)
			local index = Table.indexOf(tbl, obj)
			if index then
				table.remove(tbl, index)
			end
		end

		-- ONLY SUPPORTS ORDINAL TABLES (ARRAYS). Allocates a new table by getting the length of the current table and increasing its capacity by the specified amount.
		-- This uses Roblox's table.create function.
		Table.expand = function (tbl, byAmount)
			if byAmount < 0 then
				error("Cannot expand a table by a negative amount of objects.")
			end

			local newtbl = table.create(#tbl + byAmount)
			for i = 1, #tbl do
				newtbl[i] = tbl[i]
			end
			return newtbl
		end

		return Table
	end)()

	-----------------------------------------------------------
	-------------------- MODULE DEFINITION --------------------
	-----------------------------------------------------------

	local PartCacheStatic = {}
	PartCacheStatic.__index = PartCacheStatic
	PartCacheStatic.__type = "PartCache" -- For compatibility with TypeMarshaller

	-- TYPE DEFINITION: Part Cache Instance
	export type PartCache = {
		Open: {[number]: BasePart},
		InUse: {[number]: BasePart},
		CurrentCacheParent: Instance,
		Template: BasePart,
		ExpansionSize: number
	}

	-----------------------------------------------------------
	----------------------- STATIC DATA -----------------------
	-----------------------------------------------------------                 

	-- A CFrame that's really far away. Ideally. You are free to change this as needed.
	local CF_REALLY_FAR_AWAY = CFrame.new(0, 10e8, 0)

	-- Format params: methodName, ctorName
	local ERR_NOT_INSTANCE = "Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"

	-- Format params: paramName, expectedType, actualType
	--local ERR_INVALID_TYPE = "Invalid type for parameter '%s' (Expected %s, got %s)"

	-----------------------------------------------------------
	------------------------ UTILITIES ------------------------
	-----------------------------------------------------------

	--Similar to assert but warns instead of errors.
	local function assertwarn(requirement: boolean, messageIfNotMet: string)
		if requirement == false then
			--warn(messageIfNotMet)
		end
	end

	--Dupes a part from the template.
	local function MakeFromTemplate(template: BasePart, currentCacheParent: Instance): BasePart
		local part: BasePart = template:Clone()
		-- ^ Ignore W000 type mismatch between Instance and BasePart. False alert.

		part.CFrame = CF_REALLY_FAR_AWAY
		part.Anchored = true
		part.Parent = currentCacheParent
		return part
	end

	function PartCacheStatic.new(template: BasePart, numPrecreatedParts: number?, currentCacheParent: Instance?): PartCache
		local newNumPrecreatedParts: number = numPrecreatedParts or 5
		local newCurrentCacheParent: Instance = currentCacheParent or workspace

		--PrecreatedParts value.
		--Same thing. Ensure it's a number, ensure it's not negative, warn if it's really huge or 0.
		assert(numPrecreatedParts > 0, "PrecreatedParts can not be negative!")
		assertwarn(numPrecreatedParts ~= 0, "PrecreatedParts is 0! This may have adverse effects when initially using the cache.")
		assertwarn(template.Archivable, "The template's Archivable property has been set to false, which prevents it from being cloned. It will temporarily be set to true.")

		local oldArchivable = template.Archivable
		template.Archivable = true
		local newTemplate: BasePart = template:Clone()
		-- ^ Ignore W000 type mismatch between Instance and BasePart. False alert.

		template.Archivable = oldArchivable
		template = newTemplate

		local object: PartCache = {
			Open = {},
			InUse = {},
			CurrentCacheParent = newCurrentCacheParent,
			Template = template,
			ExpansionSize = 10
		}
		setmetatable(object, PartCacheStatic)

		-- Below: Ignore type mismatch nil | number and the nil | Instance mismatch on the table.insert line.
		for _ = 1, newNumPrecreatedParts do
			table.insert(object.Open, MakeFromTemplate(template, object.CurrentCacheParent))
		end
		object.Template.Parent = nil

		return object
		-- ^ Ignore mismatch here too
	end

	-- Gets a part from the cache, or creates one if no more are available.
	function PartCacheStatic:GetPart(): BasePart
		assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("GetPart", "PartCache.new"))

		if #self.Open == 0 then
			--warn("No parts available in the cache! Creating [" .. self.ExpansionSize .. "] new part instance(s) - this amount can be edited by changing the ExpansionSize property of the PartCache instance... (This cache now contains a grand total of " .. tostring(#self.Open + #self.InUse + self.ExpansionSize) .. " parts.)")
			for _ = 1, self.ExpansionSize, 1 do
				table.insert(self.Open, MakeFromTemplate(self.Template, self.CurrentCacheParent))
			end
		end
		local part = self.Open[#self.Open]
		self.Open[#self.Open] = nil
		table.insert(self.InUse, part)
		return part
	end

	-- Returns a part to the cache.
	function PartCacheStatic:ReturnPart(part: BasePart)
		assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("ReturnPart", "PartCache.new"))

		local index = table.indexOf(self.InUse, part)
		if index ~= nil then
			table.remove(self.InUse, index)
			table.insert(self.Open, part)
			part.CFrame = CF_REALLY_FAR_AWAY
			part.Anchored = true
		else
			error("Attempted to return part \"" .. part.Name .. "\" (" .. part:GetFullName() .. ") to the cache, but it's not in-use! Did you call this on the wrong part?")
		end
	end

	-- Sets the parent of all cached parts.
	function PartCacheStatic:SetCacheParent(newParent: Instance)
		assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("SetCacheParent", "PartCache.new"))
		assert(newParent:IsDescendantOf(workspace) or newParent == workspace, "Cache parent is not a descendant of Workspace! Parts should be kept where they will remain in the visible world.")

		self.CurrentCacheParent = newParent
		for i = 1, #self.Open do
			self.Open[i].Parent = newParent
		end
		for i = 1, #self.InUse do
			self.InUse[i].Parent = newParent
		end
	end

	-- Adds numParts more parts to the cache.
	function PartCacheStatic:Expand(numParts: number): ()
		assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("Expand", "PartCache.new"))
		if numParts == nil then
			numParts = self.ExpansionSize
		end

		for _ = 1, numParts do
			table.insert(self.Open, MakeFromTemplate(self.Template, self.CurrentCacheParent))
		end
	end

	-- Destroys this cache entirely. Use this when you don't need this cache object anymore.
	function PartCacheStatic:Dispose()
		assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("Dispose", "PartCache.new"))
		for i = 1, #self.Open do
			self.Open[i]:Destroy()
		end
		for i = 1, #self.InUse do
			self.InUse[i]:Destroy()
		end
		self.Template:Destroy()
		self.Open = {}
		self.InUse = {}
		self.CurrentCacheParent = nil

		self.GetPart = nil
		self.ReturnPart = nil
		self.SetCacheParent = nil
		self.Expand = nil
		self.Dispose = nil
	end

	return PartCacheStatic
end)()

-- Variables
local baseRock = Instance.new("Part")
baseRock.Color = Color3.fromRGB(99, 95, 98)
baseRock.Material = Enum.Material.Slate
baseRock.CanCollide = false
baseRock.CanTouch = false
baseRock.CanQuery = false
baseRock.Anchored = true

local rockPartChache = PartChache.new(baseRock,100,workspace.Terrain)
local rockTopPartChache = PartChache.new(baseRock,100,workspace.Terrain)

local BaseEffects = {}

local function doSurfaceRaycast(surfaceCF:CFrame)
	return GeneralUse.GetFirstCollidable(surfaceCF.Position,surfaceCF.UpVector*-100)
end

--[[local function generateDebugPart(cf,size)
    local part = Instance.new("Part")
    part.Size = size
    part.CFrame = cf
    part.Anchored = true
    part.CanCollide = false
    part.Material = Enum.Material.Neon
    part.Parent = spawnedObjects
    Debris:AddItem(part,5)
end--]]
local function getSurfaceCF(baseCF:CFrame)
	baseCF = baseCF * CFrame.new(0,2,0)
	local function getRaycastPosition(cfChange:CFrame)
		local startCF = baseCF*cfChange

		local raycastDirecton = baseCF.UpVector*-10
		local result = GeneralUse.GetFirstCollidable(startCF.Position,raycastDirecton)
		local endPos = (result and result.Position) or (startCF*CFrame.new(0,-2,0)).Position

        --[[ local dist = (startCF.Position-endPos).Magnitude
        generateDebugPart(CFrame.new(startCF.Position,endPos)*CFrame.new(0,0,-dist/2),Vector3.new(.2*.1,.2*.1,dist))
        generateDebugPart(startCF,Vector3.new(.3,.3,.3)*.1)
        generateDebugPart(CFrame.new(endPos),Vector3.new(.5,.5,.5)*.1)--]]
		return endPos,result
	end

	local rightPos,leftPos = getRaycastPosition(CFrame.new(.1,0,0)),getRaycastPosition(CFrame.new(-.1,0,0))
	local upPos,downPos = getRaycastPosition(CFrame.new(0,0,-.1)),getRaycastPosition(CFrame.new(0,0,.1))
	local centerPos,centerResult = getRaycastPosition(CFrame.new(0,0,0))
	local rightVector = CFrame.new(leftPos,rightPos).LookVector
	local upVector = CFrame.new(downPos,upPos).LookVector

	local surfaceCF = CFrame.fromMatrix(centerPos,rightVector,upVector)
	return surfaceCF*CFrame.Angles(math.pi/2,0,0),centerResult
end

function BaseEffects.CreateRockLine(lineStartCF:CFrame,distance:number,totalRocks:number,baseRockSize:number,baseSideDistance:number,baseRotAngle:number,baseExpandTime)
	baseExpandTime = baseExpandTime or .3
	local function createFloorRocks(middleCF:CFrame,sideDistance:number,rotAngle:number,size:Vector3,expandTime)
		local startCF = middleCF - Vector3.new(0,size.Y/2,0)
		local result = GeneralUse.GetFirstCollidable(startCF.Position)
		if result then
			startCF = startCF-startCF.Position+result.Position
		end
		local destroyWait = 4*NumberHelper.Random()
		local destroyTime = .6*NumberHelper.Random()
		for _,mut in {1,-1} do

			local endCF:CFrame = startCF*CFrame.new(sideDistance*mut,0,0)*CFrame.Angles(0,0,rotAngle*mut)
			local inGroundCF:CFrame = endCF - Vector3.new(0,size.Magnitude,0)

			BaseEffects.CreateRock(result,size,startCF,endCF,inGroundCF,expandTime,destroyWait,destroyTime)
		end
	end

	for rockNum = 1,totalRocks do
		local middleCF = lineStartCF*CFrame.new(0,0,-distance*(rockNum/totalRocks) + distance*.05*NumberHelper.Random(-1,1))

		local rockSize = baseRockSize*Vector3.new(NumberHelper.Random(),NumberHelper.Random(),NumberHelper.Random())
		local sideDistance = baseSideDistance * NumberHelper.Random()
		createFloorRocks(middleCF,sideDistance,baseRotAngle*NumberHelper.Random(),rockSize,baseExpandTime*NumberHelper.Random())
	end
end
function BaseEffects.CreateRock(floorRaycast:RaycastResult,rockSize:Vector3,startCF:CFrame,endCF:CFrame,inGroundCF:CFrame,expandTime:number,destroyWait:number,destroyTime:number)
	local groundRock = rockPartChache:GetPart()
	groundRock.Size = rockSize*.1
	groundRock.CFrame = startCF

	local rockTop = rockTopPartChache:GetPart()
	if floorRaycast then
		local hitPart:BasePart = floorRaycast.Instance
		rockTop.Color = hitPart.Color
		rockTop.Material = hitPart.Material
	end

	local function updateRockTop()
		local groundRockSize = groundRock.Size
		rockTop.Size = Vector3.new(groundRockSize.X, groundRockSize.Y*.2, groundRockSize.Z)
		rockTop.CFrame = groundRock.CFrame + groundRock.CFrame.UpVector * (groundRockSize.Y/2 + rockTop.Size.Y/2)
	end
	updateRockTop()
	TweenService:Create(groundRock,TweenInfo.new(expandTime),{Size = rockSize,CFrame = endCF}):Play()
	local changed = groundRock.Changed:Connect(function()
		updateRockTop()
	end)
	task.delay(destroyWait,function()
		TweenService:Create(groundRock,TweenInfo.new(destroyTime,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Size = Vector3.new(0,0,0),CFrame = inGroundCF}):Play()

		task.wait(destroyTime)
		changed:Disconnect()
		rockPartChache:ReturnPart(groundRock)
		rockTopPartChache:ReturnPart(rockTop)
	end)
end

type GroundExpandV2Opts = {
	["baseLength"]:number;
	["baseHeight"]:number;
	['expandTime']:number;
	['baseDestroyWait']:number;
	['destroyTime']:number;
}
function BaseEffects.GroundExpandV2(circleCenter:CFrame,radius:number,rockCount:number,optSettings:GroundExpandV2Opts)
	optSettings = (optSettings or {})::GroundExpandV2Opts

	local baseWidth = (radius*2*math.pi)/rockCount
	local baseHeight = optSettings.baseHeight or  baseWidth*.4
	local baseLength = optSettings.baseLength or baseWidth
	local expandTime = optSettings.expandTime or .3
	local baseDestroyWait = optSettings.baseDestroyWait or 2
	local destroyTime = optSettings.destroyTime or .6

	local function random(min,max)
		return Random.new():NextNumber(min or .8,max or 1.2)
	end


	circleCenter = getSurfaceCF(circleCenter)
	for rockNum = 1,rockCount do
		local rotation = (360/rockCount * rockNum) + random(-20,20)
		local rockWidth =  baseWidth * random(1.5,2.5)
		local rockHeight = baseHeight * random(0.5,1)
		local rockLength = baseLength * random(1,2)
		local rockSize = Vector3.new(rockWidth,rockHeight,rockLength)

		local distMut = random(.8,1.5)
		local rotAmount = -random(20,40)

		local floorPos
		local function getRockCF(distFromCenter:number):CFrame
			local rockCF = (circleCenter* CFrame.Angles(0,math.rad(rotation),0) * CFrame.new(distFromCenter*distMut,0,0))
			rockCF = rockCF

			return rockCF* CFrame.Angles(0,math.pi/2,0) * CFrame.Angles(math.rad(rotAmount),0,0)
		end
		local function setToFloorPos(cf:CFrame):CFrame
			if floorPos then
				cf = cf-cf.Position + Vector3.new(cf.Position.X,floorPos.Y,cf.Position.Z) + circleCenter.UpVector*(-rockSize.Y*.3)
			end
			return cf
		end
		local finalCF = getRockCF(rockLength/2 + radius)

		local result = GeneralUse.GetFirstCollidable(finalCF.Position,circleCenter.UpVector*-100)
		if result then
			floorPos = result.Position
		end
		finalCF = setToFloorPos(finalCF)

		local startCF = setToFloorPos(getRockCF(.01))
		BaseEffects.CreateRock(
			result,
			rockSize,
			startCF,
			finalCF,
			finalCF + circleCenter.UpVector*-rockSize.Y,
			expandTime*random(),
			baseDestroyWait*random(),
			destroyTime
		)
	end
end

return BaseEffects