-- Services
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService('Debris')
-- Instances

-- Modules
local GeneralUse = (function()
	-- Services
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local TweenService = game:GetService("TweenService")

	-- Instances

	local GeneralUse = {}

	-- Returns a value using the given ratio.
	function GeneralUse.basedValue(baseValue,scaleValue,currentValue) 
		--	print(z,y,x)
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
	function GeneralUse.GetFirstCollidable(startPos,angle,ignoreList,includeChars,debugMode):RaycastResult	 -- Raycasts from the startPos using the given angle (or Vector3.new(0,-100,0) if left nil) using the given ignore list. Returns the first collidable hit or nil if it hits nothing. If includeChars is true then it will include parts that are parented to characters
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
local StopwatchCreator = (function()
	local StopwatchCreator = {}

	-- Returns a new stopwatch
	function StopwatchCreator.new(startNil:boolean)
		local self = setmetatable({},StopwatchCreator)
		self.start = not startNil and tick() or nil
		self.freezeStart = nil
		self.freezeTimeSubtract = 0
		return self
	end

	-- Returns how much has elapsed since the given tick() point
	function StopwatchCreator.GetTimePassed(startTime:number):number
		return tick() - startTime
	end

	-- Resets the stopwatch
	function StopwatchCreator:Reset()
		self.start = tick()
		self.freezeStart = nil
		self.freezeTimeSubtract = 0
	end

	-- Updates how much times needs to be subtracted from the stopwatch to account for frozen time
	function StopwatchCreator:UpdateFreezeTimeSub():boolean
		local freezeStart = self.freezeStart
		if not freezeStart then
			return false
		end
		self.freezeTimeSubtract += StopwatchCreator.GetTimePassed(freezeStart)
		self.freezeStart = tick()
		return true
	end

	-- Pauses the stopwatch's time from passing
	function StopwatchCreator:Freeze()
		-- this func already resets the freeze start so we don't need to do it again
		if self:UpdateFreezeTimeSub() then
			return
		end
		self.freezeStart = tick()
	end

	-- Unpauses the stopwatch
	function StopwatchCreator:Unfreeze()
		self:UpdateFreezeTimeSub()
		self.freezeStart = nil
	end

	-- Checks if the stopwatch has passed a certain time and reset it if it has
	function StopwatchCreator:HasPassedTime(t,noReset):boolean
		if not self.start or self() >= t then
			if not noReset then
				self:Reset()
			end
			return true
		else
			return false
		end
	end

	-- Returns how much time has elapsed since the stopwatch was started
	function StopwatchCreator:GetStopwatchTime():number
		local currentTime = tick()
		self.start = self.start or currentTime
		self:UpdateFreezeTimeSub()

		local timePassed = StopwatchCreator.GetTimePassed(self.start) - self.freezeTimeSubtract
		return timePassed
	end

	function StopwatchCreator.newTimer(waitTime,onLoop)
		local stopwatch = StopwatchCreator.new()
		local deltaStopwatch = StopwatchCreator.new()
		while not stopwatch:HasPassedTime(waitTime,true) do
			local alpha = stopwatch()/waitTime
			if onLoop(alpha,stopwatch(),deltaStopwatch()) then
				break
			end
			deltaStopwatch:Reset()
			task.wait()
		end
	end

	StopwatchCreator.__index = StopwatchCreator
	StopwatchCreator.__call = function(self)
		return self:GetStopwatchTime()
	end

	return StopwatchCreator
end)()

local VFXHelp = {}

-- disables particles/trails and then deletes the part after all the paritcles dissappear
function VFXHelp.RemoveVFX(part,optSettings):number
	optSettings = optSettings or {}
	local noDisable=optSettings.noDisable
	local removeDelay=optSettings.removeDelay
	local ignoreBeams = optSettings.ignoreBeams
	if removeDelay then
		task.wait(removeDelay)
	end

	local highestTime = 0
	local function updateHighestLifetime(newTime)
		if newTime >= highestTime then
			highestTime=newTime
		end
	end
	if typeof(part) == 'Instance' then
		for _,object:(ParticleEmitter|Trail) in part:GetDescendants() do
			if object:IsA("ParticleEmitter")  then
				local maxLifetime = object.Lifetime.Max + (object:GetAttribute('EmitDelay') or 0) * (1/object.TimeScale)
				updateHighestLifetime(maxLifetime)
			elseif object:IsA('Trail') then
				updateHighestLifetime(object.Lifetime)
			end
		end
		if not noDisable then
			VFXHelp.DisableVFX(part,ignoreBeams)
		end
		Debris:AddItem(part,highestTime)
	else
		-- if the "part" variable is a table then we want to loop through the particles and remove them indivudally
		for _,object in part do
			if not noDisable then
				object.Enabled = false
			end
			local lifetime = object.Lifetime.Max
			updateHighestLifetime(lifetime)
			Debris:AddItem(object,lifetime)
		end
	end
	return highestTime
end

function VFXHelp.EmitFromModel(model,ignoreLight)
	local particleTab
	if type(model) == 'table' then
		particleTab=model
	else
		particleTab=model:GetDescendants()
	end
	for _,object in particleTab do
		if object:IsA("ParticleEmitter")  then
			local amount = object:GetAttribute("EmitCount") or object:GetAttribute("Amount")
			if amount then
				task.delay(object:GetAttribute('EmitDelay') or 0,function()
					object:Emit(amount)
				end)
			end
		elseif object:IsA("PointLight") and not ignoreLight then
			local goal = {}
			goal.Brightness = object.Brightness
			goal.Range = object.Range
			if object:FindFirstChild("ChangeBrightness") then
				goal.Brightness = object.ChangeBrightness.Value
			end
			local tweeninfo = TweenInfo.new(object.Timer.Value,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0)
			local tween = TweenService:Create(object,tweeninfo,goal)
			tween:Play()
		end
	end
end

function VFXHelp.SetSmokeColor(particlePart,optSettings)
	optSettings = optSettings or {}
	local raycastResult = optSettings.raycastResult
	local smokeBaseNames = optSettings.smokeBaseNames or {'Smoke'}
	local smokeParticles = {}

	for _,object in particlePart:GetDescendants() do
		if not object:IsA('ParticleEmitter') then
			continue
		end
		local isSmoke
		for _,baseName in smokeBaseNames do
			if not string.find(object.Name,baseName) then
				continue
			end

			isSmoke=true
			break
		end
		if not isSmoke then
			continue
		end
		table.insert(smokeParticles,object)
	end

	if #smokeParticles == 0 then
		return
	end

	if not raycastResult then
		raycastResult=GeneralUse.GetFirstCollidable(particlePart.Position,particlePart.CFrame.UpVector * -25)
	end

	if not raycastResult then
		return
	end

	for _,smokeParticle:ParticleEmitter in smokeParticles do
		smokeParticle.Color = ColorSequence.new(raycastResult.Instance.Color)
	end
	return raycastResult
end


function VFXHelp.ScaleParticle(baseNum,particle,givenNum,categories,baseParticle)
	categories = categories or {
		"Size";
		"Speed";
		"Acceleration";
	}

	for _,category in pairs(categories) do
		particle[category] = NumberHelper.ScaleValue(baseNum,(baseParticle or particle)[category],givenNum)
	end
	return particle
end

-- Scales the particle part and all the particles in it
function VFXHelp.ScaleParticlePart(particlePart:BasePart,scaleMut:number)
	if scaleMut == 1 then
		return
	end
	local function scalePart(part)
		part.Size*=scaleMut
	end
	local function scaleParticle(particle)
		VFXHelp.ScaleParticle(1,particle,scaleMut)
	end

	local scaleObjects = particlePart:GetDescendants()
	table.insert(scaleObjects,particlePart)
	for _,object in scaleObjects do
		if object:IsA('ParticleEmitter') then
			scaleParticle(object)
		elseif object:IsA('BasePart') then
			scalePart(object)
		end
	end
end

-- Emits particles and deletes them and the object part
function VFXHelp.EmitAndRemove(basePart:Instance|{ParticleEmitter},cf:CFrame?,optSettings:{}?)
	optSettings=optSettings or {}
	local dontClone = optSettings.dontClone
	local noAutoSmoke=optSettings.noAutoSmoke
	local maxFloorDist = optSettings.maxFloorDist
	local scaleMut = optSettings.scaleMut
	local raycastResult = optSettings.raycastResult
	if maxFloorDist then
		raycastResult = raycastResult or GeneralUse.GetFirstCollidable(cf.Position+Vector3.new(0,.1,0),Vector3.new(0,-maxFloorDist,0))
		if not raycastResult then
			return
		end
		cf = cf and (cf - cf.Position + raycastResult.Position)
	end

	local part
	if typeof(basePart) == 'Instance' then
		local parent = basePart.Parent
		if dontClone then
			part=basePart
		else
			part=basePart:Clone()
		end
		if cf then
			part.CFrame = cf
			part.Parent = parent
		end
		if not noAutoSmoke then
			raycastResult = VFXHelp.SetSmokeColor(part,{raycastResult=raycastResult})
		end	
	else
		part=basePart
	end
	if scaleMut then
		VFXHelp.ScaleParticlePart(part,scaleMut)
	end
	VFXHelp.EmitFromModel(part,true)
	VFXHelp.RemoveVFX(part,{noDisable=true})
	return part,raycastResult
end

-- Adds particles to a character's body parts
function VFXHelp.AddParticlesToBody(target:Model,baseParticle:ParticleEmitter|{ParticleEmitter},stayLength:number?,validBodyParts:{string}?)
	local allParticles = {}
	for _,bodyPart in target:GetChildren() do
		if not bodyPart:IsA('BasePart') or bodyPart == target.PrimaryPart then
			continue
		end
		if validBodyParts and not table.find(validBodyParts,bodyPart.Name) then
			continue
		end

		local function addParticle(particle)
			local cloneParticle = particle:Clone()
			cloneParticle.Parent = bodyPart


			table.insert(allParticles,cloneParticle)
		end

		-- incase they send a folder of a particles instead of just 1
		if type(baseParticle) == "table" then
			for _,particle in baseParticle do
				addParticle(particle)
			end
		else
			addParticle(baseParticle)
		end
	end

	local function removeParticles()
		VFXHelp.RemoveVFX(allParticles,{removeDelay=stayLength})
	end
	if stayLength then
		removeParticles()
	else
		return removeParticles,allParticles
	end
end

function VFXHelp.ToggleVFX(part:BasePart,bool,ignoreBeams:boolean)
	for _,object in pairs(part:GetDescendants()) do
		if object:IsA("ParticleEmitter") or object:IsA('Trail') or (object:IsA('Beam') and not ignoreBeams) then
			object.Enabled = bool
		end
	end
end

function VFXHelp.EnableVFX(part:BasePart,ignoreBeams:boolean)
	VFXHelp.ToggleVFX(part,true,ignoreBeams)
end
function VFXHelp.DisableVFX(part:BasePart,ignoreBeams:boolean)
	VFXHelp.ToggleVFX(part,false,ignoreBeams)
end

function VFXHelp.RotateSlashParticles(slashRot:number,slashParticles:Part,startCF:CFrame,radius:number,slashTime:number,weldPart:BasePart?)
	local rotStopwatch = StopwatchCreator.new()

	local baseCF = weldPart and weldPart.CFrame

	local function calcCFrame()
		local alpha = rotStopwatch()/slashTime
		local newCF = startCF * CFrame.Angles(0,math.rad((-(180 *slashRot/slashRot)+ slashRot)*alpha),0) * CFrame.new(radius,0,0)
		if not baseCF then
			return newCF
		end

		-- if there is an weld part then we need to put the cframe in terms of where the weld part currently is
		-- that way the slash particles will remain in the right position even if the weld part moves
		local offsetCF = baseCF:ToObjectSpace(newCF)
		local finalCF = weldPart.CFrame:ToWorldSpace(offsetCF)
		return finalCF
	end

	task.spawn(function()
		while not rotStopwatch:HasPassedTime(slashTime) do
			slashParticles.CFrame = calcCFrame()
			task.wait()
		end
		VFXHelp.RemoveVFX(slashParticles)
	end)
end

function VFXHelp.CreateParticleScaler(particleParts:{BasePart})
	local particleScaler = {}
	local scaleParticles = {}

	for _,part in particleParts do
		for _, particle:ParticleEmitter in part:GetDescendants() do
			if not particle:IsA('ParticleEmitter') then
				continue
			end

			scaleParticles[particle] = particle:Clone()
		end
	end

	function particleScaler:Scale(alpha)
		for particle:ParticleEmitter,scaleParticle:ParticleEmitter in scaleParticles do
			VFXHelp.ScaleParticle(1,particle,alpha,nil,scaleParticle)
		end
	end
	return particleScaler
end

function VFXHelp.CreateBeamScaler(beamParts:{BasePart})
	local beamScaler = {}
	local scaleBeams = {}

	for _,part in beamParts do
		for _, beam:Beam in part:GetDescendants() do
			if not beam:IsA('Beam') then
				continue
			end

			scaleBeams[beam] = {
				CurveSize0 = beam.CurveSize0;
				CurveSize1 = beam.CurveSize1;
				Width0 = beam.Width0;
				Width1 = beam.Width1;
			}
		end
	end

	function beamScaler:Scale(alpha:number)
		for beam:Beam,scaleValues in scaleBeams do
			for valueName:string,value:number in scaleValues do
				beam[valueName] = alpha * value
			end
		end
	end

	return beamScaler
end
function VFXHelp.FlashScreen(flashSequence:{{settings:string|any; stayTime:number?}})
	local flash = Instance.new("ColorCorrectionEffect")
	flash.Parent = Lighting
	task.spawn(function()
		for _:number,valueTab in flashSequence do
			for index,value in valueTab.settings do
				flash[index] = value
			end

			task.wait(valueTab.stayTime or .07)
		end

		flash:Destroy()
	end)
end

return VFXHelp