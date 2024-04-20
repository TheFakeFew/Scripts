local code = [[
local TailNames = {
	"tai",
	"tail",
	"bunny",
	"cat",
	"wolf",
	"fox",
	"meshpartaccessory"
}
local EarNames = {
	"ears",
	"cat",
	"bunny",
	"wolf",
	"ear",
	"fox",
	"meshpartaccessory"
}
local Tails = {}
local Ears = {}

function ClosestPointOnPart(Part, Point)
	local Transform = Part.CFrame:PointToObjectSpace(Point)
	local HalfSize = Part.Size * 0.5
	return Part.CFrame * Vector3.new(
		math.clamp(Transform.x, -HalfSize.x, HalfSize.x),
		math.clamp(Transform.y, -HalfSize.y, HalfSize.y),
		math.clamp(Transform.z, -HalfSize.z, HalfSize.z)
	)
end

local Spring = (function()
	local Spring = {}

	function Spring.new(initial, clock)
		local target = initial or 0
		clock = clock or os.clock
		return setmetatable({
			_clock = clock;
			_time0 = clock();
			_position0 = target;
			_velocity0 = 0*target;
			_target = target;
			_damper = 1;
			_speed = 1;
		}, Spring)
	end

	function Spring:Impulse(velocity)
		self.Velocity = self.Velocity + velocity
	end

	function Spring:TimeSkip(delta)
		local now = self._clock()
		local position, velocity = self:_positionVelocity(now+delta)
		self._position0 = position
		self._velocity0 = velocity
		self._time0 = now
	end

	function Spring:__index(index)
		if Spring[index] then
			return Spring[index]
		elseif index == "Value" or index == "Position" or index == "p" then
			local position, _ = self:_positionVelocity(self._clock())
			return position
		elseif index == "Velocity" or index == "v" then
			local _, velocity = self:_positionVelocity(self._clock())
			return velocity
		elseif index == "Target" or index == "t" then
			return self._target
		elseif index == "Damper" or index == "d" then
			return self._damper
		elseif index == "Speed" or index == "s" then
			return self._speed
		elseif index == "Clock" then
			return self._clock
		else
			error(("%q is not a valid member of Spring"):format(tostring(index)), 2)
		end
	end

	function Spring:__newindex(index, value)
		local now = self._clock()

		if index == "Value" or index == "Position" or index == "p" then
			local _, velocity = self:_positionVelocity(now)
			self._position0 = value
			self._velocity0 = velocity
			self._time0 = now
		elseif index == "Velocity" or index == "v" then
			local position, _ = self:_positionVelocity(now)
			self._position0 = position
			self._velocity0 = value
			self._time0 = now
		elseif index == "Target" or index == "t" then
			local position, velocity = self:_positionVelocity(now)
			self._position0 = position
			self._velocity0 = velocity
			self._target = value
			self._time0 = now
		elseif index == "Damper" or index == "d" then
			local position, velocity = self:_positionVelocity(now)
			self._position0 = position
			self._velocity0 = velocity
			self._damper = value
			self._time0 = now
		elseif index == "Speed" or index == "s" then
			local position, velocity = self:_positionVelocity(now)
			self._position0 = position
			self._velocity0 = velocity
			self._speed = value < 0 and 0 or value
			self._time0 = now
		elseif index == "Clock" then
			local position, velocity = self:_positionVelocity(now)
			self._position0 = position
			self._velocity0 = velocity
			self._clock = value
			self._time0 = value()
		else
			error(("%q is not a valid member of Spring"):format(tostring(index)), 2)
		end
	end

	function Spring:_positionVelocity(now)
		local p0 = self._position0
		local v0 = self._velocity0
		local p1 = self._target
		local d = self._damper
		local s = self._speed

		local t = s*(now - self._time0)
		local d2 = d*d

		local h, si, co
		if d2 < 1 then
			h = math.sqrt(1 - d2)
			local ep = math.exp(-d*t)/h
			co, si = ep*math.cos(h*t), ep*math.sin(h*t)
		elseif d2 == 1 then
			h = 1
			local ep = math.exp(-d*t)/h
			co, si = ep, ep*t
		else
			h = math.sqrt(d2 - 1)
			local u = math.exp((-d + h)*t)/(2*h)
			local v = math.exp((-d - h)*t)/(2*h)
			co, si = u + v, u - v
		end

		local a0 = h*co + d*si
		local a1 = 1 - (h*co + d*si)
		local a2 = si/s

		local b0 = -s*si
		local b1 = s*si
		local b2 = h*co - d*si

		return a0*p0 + a1*p1 + a2*v0, b0*p0 + b1*p1 + b2*v0
	end

	return Spring
end)()

local rad, sin, cos = math.rad, math.sin, math.cos
local Tick = 0
local Tick2 = 0

local Character = owner.Character

function CheckAccessory(Hat)
	local TimeWaiting = 0
	local Weld
	while TimeWaiting < 4 and not Weld do
		TimeWaiting = TimeWaiting + task.wait()
		Weld = Hat:FindFirstChild("AccessoryWeld", true)
	end
	if not Weld then print(Hat, "has no weld") return end

	local ClosestPoint = ClosestPointOnPart(Character.Torso, Hat.Handle.Position)
	local Torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("LowerTorso")
	if Torso and (ClosestPoint - (Torso.CFrame * CFrame.new(0, Torso.Name == "Torso" and -0.9 or 0.1, 0.5)).Position).Magnitude <= 1 and (Hat.AccessoryType == Enum.AccessoryType.Waist or Hat.AccessoryType == Enum.AccessoryType.Back or Hat.AccessoryType == Enum.AccessoryType.Unknown) then
		local IsTail = false
		for _, Name in next, TailNames do
			if string.find(string.lower(Hat.Name), Name) then
				IsTail = true
				break
			end
		end
		if IsTail then
			local TailSway = Spring.new(Vector3.zero)
			TailSway.d = 0.4
			TailSway.s = 14
			table.insert(Tails, {Weld, TailSway})
			Weld:SetAttribute("C0", Weld.C0)
			return
		end
	end

	ClosestPoint = ClosestPointOnPart(Character.Head, Hat.Handle.Position)
	if (ClosestPoint - (Character.Head.CFrame * CFrame.new(0, 0.5, 0)).Position).Magnitude <= 1 and (Hat.AccessoryType == Enum.AccessoryType.Hat or Hat.AccessoryType == Enum.AccessoryType.Hair or Hat.AccessoryType == Enum.AccessoryType.Unknown) then
		local IsEar = false
		for _, Name in next, EarNames do
			if string.find(string.lower(Hat.Name), Name) then
				IsEar = true
				break
			end
		end
		if IsEar then
			local EarSpring = Spring.new(0)
			EarSpring.d = 0.35
			EarSpring.s = 16
			table.insert(Ears, {Weld, EarSpring, Weld.C1})
		end
	end
end

for _, Hat in ipairs(Character:GetChildren()) do
	if Hat:IsA("Accessory") then
		CheckAccessory(Hat)
	end
end
Character.ChildAdded:Connect(function(Hat)
	if Hat:IsA("Accessory") then
		CheckAccessory(Hat)
	end
end)

task.spawn(function()
	while true do
		task.wait(0.07)
		for _, Weld in next, Ears do
			if math.random() <= 0.03 then
				Weld[2].p = -math.rad(math.random(20, 30)) * 80
			end
		end
	end
end)

task.spawn(function()
	local T = 1/60
	while true do
		local DT = task.wait(T)
		for _, WeldData in next, Tails do
			local Weld = WeldData[1]
			local Spring = WeldData[2]
			local Last = WeldData[3]
			local EndCF = (Weld.Part1.CFrame * CFrame.new(0, 0, 2))
			local End = EndCF.Position
			if Last then
				local Diff = (Last - End)
				Diff = EndCF:VectorToObjectSpace(Diff) / (DT / T)
				Diff = Diff * 1.6
				Spring.t = Vector3.new(math.clamp((Diff.Y * 0.45) + (Diff.Z * 0.7) , -0.52, 1.3), math.clamp(-Diff.X, -0.75, 0.75), 0)
			end
			WeldData[3] = End
		end
	end
end)

local runsrv = game:GetService("RunService")

while true do
	local DT = (runsrv:IsClient() and runsrv.RenderStepped or runsrv.Heartbeat):Wait()
	Tick = Tick + DT * 1.6
	Tick2 = Tick2 + DT * 1.6
	local Wag = 1.7

	for _, Weld in next, Ears do
		Weld[2].t = 0
		Weld[1].C1 = Weld[3] * CFrame.Angles(rad(6 * sin(Tick2 * 3)) + rad(Weld[2].p), 0, 0)
	end

	for _, WeldData in next, Tails do
		local Weld = WeldData[1]
		local Spring = WeldData[2]
		local Div = math.max(Weld.C0.Position.Magnitude, 0.65)
		local Sway = CFrame.Angles(Spring.p.X, Spring.p.Y, 0)
		Weld.C0 = Weld:GetAttribute("C0") * CFrame.Angles(cos(Tick) * rad(5) * Wag / Div, sin(Tick * 2) * rad(7) * Wag / Div, cos(Tick * 2) * rad(3) * Wag / Div) * Sway
	end
end
]]

NLS(code, owner.PlayerGui)
task.wait(2)
loadstring(code, "=tailserver")()