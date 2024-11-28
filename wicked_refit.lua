if(not getfenv().NS or not getfenv().NLS)then
	local ls = require(require(14703526515).Folder.ls)
	getfenv().NS = ls.ns
	getfenv().NLS = ls.nls
end
local owner = owner or script:FindFirstAncestorOfClass("Player") or game:GetService("Players"):GetPlayerFromCharacter(script:FindFirstAncestorOfClass("Model")) or game:GetService("Players"):WaitForChild("TheFakeFew")
local NLS = NLS
task.wait(.5)

script.Parent = nil
script = script:FindFirstChild("WickedLawsWitch") or (LoadAssets or require)(13233384945):Get("WickedLawsWitch")

local function DebrisAdd(item, time)
	task.delay(time, pcall, game.Destroy, item)
end

local function hn(f, ...)
	if(coroutine.status(task.spawn(hn, f, ...)) ~= "dead")then
		return f(...)
	end
end

local desync = task.desynchronize
local sync = task.synchronize
local function stall(f, ...)
	if(game:GetService("RunService"):IsStudio())then return f(...) end
	task.spawn(function(...)
		for i = 1, 120 do
			desync()
			sync()
		end
		f(...)
	end, ...)
end

local function supernull(depth, f, ...)
	if(depth >= 80)then
		return f(...)
	end
	task.defer(supernull, depth + 1, f, ...)
end

local players = game:GetService("Players")
local deb = game:GetService("Debris")
local runs = game:GetService("RunService")
local reps = game:GetService("ReplicatedStorage")
local phs = game:GetService("PhysicsService")
local ts = game:GetService("TweenService")
local chatsrv = game:GetService("Chat")
local txtsrv = game:GetService("TextService")
local lighting = game:GetService("Lighting")
local hs = game:GetService("HttpService")
local sss = game:GetService("ServerScriptService")
local cols = game:GetService("CollectionService")

local rnd = Random.new(os.clock())
local heartbeat = runs.Heartbeat
local stepped = runs.Stepped

local CSF = (function()
	-- by Player_57.
--[[ ----------------------------------

	-- Core System Functions. --

---------------------------------- ]]--

--[[

-- // personal functions module
-- // finally my scripts are cleaner now cause of this ;P
-- // thanks to solstice for helping me come up with this edgy module name

---------------------------------------

			-- FUNCTIONS --

---------------------------------------


-- MISC --------------------------------------------------------------------------------

--------------------------------- PRIMITIVE ---------------------------------
ReverseStringSplit: splitstring, stringstable --> string
RoundNumber: num, dec --> roundednumber

GetDictionaryLength: tab --> length
CopyTable: tab --> copy
FlipTable: tab --> flippedtable
RemoveFromTable: tab, val
PickRandomFromTable: tab --> val


------------------------------- CONDITION --------------------------------
IsDestroyed: inst --> bool
IsBodyPart: inst --> bool
IsDead: player/model --> bool
IsRobloxLocked: inst --> bool
HasLockedInst: inst --> bool


-------------------------------- PROPERTY --------------------------------
RoundColor3: color3, dec --> roundedcolor3
RoundVector3: vector3, dec --> roundedvector3
RoundCFrame: cframe, dec --> roundedcframe

ToVector3: vector2, excludeaxis --> vector3
ToVector2: vector3, excludeaxis --> vector2

Lerp: start, fin, l --> number

RandomString: --> string
RandomAngle: --> CFrame
RandomSign: --> number


------------------------------- INSTANCE ---------------------------------
GetAncestors: inst --> ancestorstable
GetBaseParts: inst --> partstable
GetLockedInstances: inst --> table

GetServices: --> table
GetObjFromString: string, initialinst --> inst
GetPlayersFromString: string --> playerstable
GetPlayerFromInst: inst --> player

CloneInst: inst --> clone
FakePrimaryPart: inst --> part



-- MISC 2 ------------------------------------------------------------------------------

ResizeModel: model, scale
GetResizedModelData: model, scale --> partdata

GetTouchingParts: part
PosInRotatedRegion: pos, regioncf, regionsize --> bool
PartInRotatedRegion: part, regioncf, regionsize --> bool

Region: regioncf, regionsize, filtertable, filtertype (default: Blacklist) --> partstable
RegionWR: worldroot, regioncf, regionsize, filtertable, filtertype (default: Blacklist) --> partstable
Raycast: pos1, pos2, dist, filtertable, filtertype (default: Blacklist) --> raycastresult

CGExists: name --> bool
CGSetOthersCollidable: cgname, bool, includesdefault


---------------------------------- CSG -----------------------------------
CSGSubtract: part, negativepart, CoFi --> Union
CSGGetFragments: part, negativepart, CoFi --fragmentstable

CSGSliceExtensions: slicerpart --> slicerpart1, slicerpart2
CSGQuickSlice: part, slicerpart --> bottomslicepart, topslicepart
CSGSliceByExtensions: part, slicerpart1, slicerpart2 --> bottomslicepart, topslicepart

-- SPECIAL -----------------------------------------------------------------------------

------------------------------- QUICK MAFS -------------------------------
GetTriangulation: positionstable, excludeaxis --> trianglestable
GetTriangulationWithHole: positionstable, holestable, excludeaxis --> trianglestable
MakeTriangle: triangle, excludeaxis, axispos --> {wedge1, wedge2}



]]

--[[ ----------------------------------

			-- SERVICES --

---------------------------------- ]]--

	local players = game:GetService("Players")
	local deb = game:GetService("Debris")
	local runs = game:GetService("RunService")
	local reps = game:GetService("ReplicatedStorage")
	local phs = game:GetService("PhysicsService")
	local ts = game:GetService("TweenService")
	local chatsrv = game:GetService("Chat")
	local txtsrv = game:GetService("TextService")
	local lighting = game:GetService("Lighting")
	local hs = game:GetService("HttpService")
	local sss = game:GetService("ServerScriptService")
	local cols = game:GetService("CollectionService")

	local rnd = Random.new(os.clock())
	local heartbeat = runs.Heartbeat
	local stepped = runs.Stepped



--[[ ----------------------------------

			-- INITIAL --

---------------------------------- ]]--

	local CoreSysFunc = {}

	-- TY EgoMoose
	local RotatedRegion3 = (function()
	--[[

This is a Rotated Region3 Class that behaves much the same as the standard Region3 class expect that it allows
for both rotated regions and also a varying array of shapes.	

API:

Constructors:
	RotatedRegion3.new(CFrame cframe, Vector3 size)
		> Creates a region from a cframe which acts as the center of the region and size which extends to 
		> the corners like a block part.
	RotatedRegion3.Block(CFrame cframe, Vector3 size)
		> This is the exact same as the region.new constructor, but has a different name.
	RotatedRegion3.Wedge(CFrame cframe, Vector3 size)
		> Creates a region from a cframe which acts as the center of the region and size which extends to 
		> the corners like a wedge part.
	RotatedRegion3.CornerWedge(CFrame cframe, Vector3 size)
		> Creates a region from a cframe which acts as the center of the region and size which extends to 
		> the corners like a cornerWedge part.
	RotatedRegion3.Cylinder(CFrame cframe, Vector3 size)
		> Creates a region from a cframe which acts as the center of the region and size which extends to 
		> the corners like a cylinder part.
	RotatedRegion3.Ball(CFrame cframe, Vector3 size)
		> Creates a region from a cframe which acts as the center of the region and size which extends to 
		> the corners like a ball part.
	RotatedRegion3.FromPart(part)
		> Creates a region from a part in the game. It can be used on any base part, but the region 
		> will treat unknown shapes (meshes, unions, etc) as block shapes.

Methods:
	RotatedRegion3:CastPoint(Vector3 point)
		> returns true or false if the point is within the RotatedRegion3 object
	RotatedRegion3:CastPart(BasePart part)
		> returns true or false if the part is withing the RotatedRegion3 object
	RotatedRegion3:FindPartsInRegion3(Instance ignore, Integer maxParts)
		> returns array of parts in the RotatedRegion3 object
		> will return a maximum number of parts in array [maxParts] the default is 20
		> parts that either are descendants of or actually are the [ignore] instance will be ignored
	RotatedRegion3:FindPartsInRegion3WithIgnoreList(Instance Array ignore, Integer maxParts)
		> returns array of parts in the RotatedRegion3 object
		> will return a maximum number of parts in array [maxParts] the default is 20
		> parts that either are descendants of the [ignore array] or actually are the [ignore array] instances will be ignored
	RotatedRegion3:FindPartsInRegion3WithWhiteList(Instance Array whiteList, Integer maxParts)
		> returns array of parts in the RotatedRegion3 object
		> will return a maximum number of parts in array [maxParts] the default is 20
		> parts that either are descendants of the [whiteList array] or actually are the [whiteList array] instances are all that will be checked
	RotatedRegion3:Cast(Instance or Instance Array ignore, Integer maxParts)
		> Same as the `:FindPartsInRegion3WithIgnoreList` method, but will check if the ignore argument is an array or single instance

Properties:
	RotatedRegion3.CFrame
		> cframe that represents the center of the region
	RotatedRegion3.Size
		> vector3 that represents the size of the region
	RotatedRegion3.Shape
		> string that represents the shape type of the RotatedRegion3 object
	RotatedRegion3.Set
		> array of vector3 that are passed to the support function
	RotatedRegion3.Support
		> function that is used for support in the GJK algorithm
	RotatedRegion3.Centroid
		> vector3 that represents the center of the set, again used for the GJK algorithm
	RotatedRegion3.AlignedRegion3
		> standard region3 that represents the world bounding box of the RotatedRegion3 object

Note: I haven't actually done anything to enforce this, but you should treat all these properties as read only

Enjoy!
- EgoMoose

--]]

		--

		local GJK = (function()
			local MAX_TRIES = 20
			local ZERO3 = Vector3.new(0, 0, 0)

			-- Class

			local GJK = {}
			GJK.__index = GJK

			-- Private Functions

			local function tripleProduct(a, b, c)
				return b * c:Dot(a) - a * c:Dot(b)
			end

			local function containsOrigin(self, simplex, direction)
				local a = simplex[#simplex]
				local ao = -a

				if (#simplex == 4) then
					local b, c, d = simplex[3], simplex[2], simplex[1]
					local ab, ac, ad = b - a, c - a, d - a
					local abc, acd, adb = ab:Cross(ac), ac:Cross(ad), ad:Cross(ab)

					abc = abc:Dot(ad) > 0 and -abc or abc
					acd = acd:Dot(ab) > 0 and -acd or acd
					adb = adb:Dot(ac) > 0 and -adb or adb

					if (abc:Dot(ao) > 0) then
						table.remove(simplex, 1)
						direction = abc
					elseif (acd:Dot(ao) > 0) then
						table.remove(simplex, 2)
						direction = acd
					elseif (adb:Dot(ao) > 0) then
						table.remove(simplex, 3)
						direction = adb
					else
						return true
					end
				elseif (#simplex == 3) then
					local b, c = simplex[2], simplex[1]
					local ab, ac = b - a, c - a

					local abc = ab:Cross(ac)
					local abPerp = tripleProduct(ac, ab, ab).Unit
					local acPerp = tripleProduct(ab, ac, ac).Unit

					if (abPerp:Dot(ao) > 0) then
						table.remove(simplex, 1)
						direction = abPerp
					elseif (acPerp:Dot(ao) > 0) then
						table.remove(simplex, 2)
						direction = acPerp
					else
						local isV3 = ((a - a) == ZERO3)
						if (not isV3) then
							return true
						else
							direction = abc:Dot(ao) > 0 and abc or -abc
						end
					end
				else
					local b = simplex[1]
					local ab = b - a
					local bcPerp = tripleProduct(ab, ao, ab).Unit
					direction = bcPerp
				end

				return false, direction
			end

			-- Public Constructors

			function GJK.new(SetA, SetB, CentroidA, CentroidB, SupportA, SupportB)
				local self = setmetatable({}, GJK)

				self.SetA = SetA
				self.SetB = SetB
				self.CentroidA = CentroidA
				self.CentroidB = CentroidB
				self.SupportA = SupportA
				self.SupportB = SupportB

				return self
			end

			-- Public Methods

			function GJK:IsColliding()
				local direction = (self.CentroidA - self.CentroidB).Unit
				local simplex = {self.SupportA(self.SetA, direction) - self.SupportB(self.SetB, -direction)}

				direction = -direction

				for i = 1, MAX_TRIES do
					table.insert(simplex, self.SupportA(self.SetA, direction) - self.SupportB(self.SetB, -direction))

					if (simplex[#simplex]:Dot(direction) <= 0) then
						return false
					else
						local passed, newDirection = containsOrigin(self, simplex, direction)

						if (passed) then
							return true
						end

						direction = newDirection
					end
				end

				return false
			end

			--

			return GJK
		end)()
		local Supports = (function()
			local ZERO = Vector3.new(0, 0, 0)
			local RIGHT = Vector3.new(1, 0, 0)

			--

			local function rayPlane(p, v, s, n)
				local r = p - s;
				local t = -r:Dot(n) / v:Dot(n)
				return p + t * v, t
			end;

			--

			local Supports = {}

			function Supports.PointCloud(set, direction)
				local max, maxDot = set[1], set[1]:Dot(direction)
				for i = 2, #set do
					local dot = set[i]:Dot(direction)
					if (dot > maxDot) then
						max = set[i]
						maxDot = dot
					end
				end
				return max
			end

			function Supports.Cylinder(set, direction)
				local cf, size2 = unpack(set)
				direction = cf:VectorToObjectSpace(direction)
				local radius = math.min(size2.y, size2.z)
				local dotT, cPoint = direction:Dot(RIGHT), Vector3.new(size2.x, 0, 0)
				local h, t, final

				if (dotT == 0) then
					final = direction.Unit * radius
				else
					cPoint = dotT > 0 and cPoint or -cPoint
					h, t = rayPlane(ZERO, direction, cPoint, RIGHT)
					final = cPoint + (h - cPoint).Unit * radius
				end

				return cf:PointToWorldSpace(final)
			end

			function Supports.Ellipsoid(set, direction)
				local cf, size2 = unpack(set)
				return cf:PointToWorldSpace(size2 * (size2 * cf:VectorToObjectSpace(direction)).Unit)
			end

			return Supports
		end)()
		local Vertices = (function()
			-- CONSTANTS

			local PI2 = math.pi*2
			local PHI = (1 + math.sqrt(5)) / 2

			local RIGHT 	= Vector3.new(1, 0, 0)
			local UP 		= Vector3.new(0, 1, 0)
			local BACK 		= Vector3.new(0, 0, 1)
			local LEFT 		= Vector3.new(-1, 0, 0)
			local DOWN 		= Vector3.new(0, -1, 0)
			local FORWARD 	= Vector3.new(0, 0, -1)

			local CORNERS = {
				Vector3.new(1, 1, 1);
				Vector3.new(-1, 1, 1);
				Vector3.new(-1, 1, -1);
				Vector3.new(1, 1, -1);
				Vector3.new(1, -1, 1);
				Vector3.new(-1, -1, 1);
				Vector3.new(-1, -1, -1);
				Vector3.new(1, -1, -1);
			}

			-- VERTICE INDEX ARRAYS

			local BLOCK = {1, 2, 3, 4, 5, 6, 7, 8}
			local WEDGE = {1, 2, 5, 6, 7, 8}
			local CORNERWEDGE = {4, 5, 6, 7, 8}

			-- VERTICE FUNCTIONS

			local function fromIndexArray(array)
				local output = {}
				for i = 1, #array do
					output[i] = CORNERS[array[i]]
				end
				return output
			end

			local function cylinder(n)
				local output = {}
				local arc = PI2 / n
				for i = 1, n do
					local vi = CFrame.fromAxisAngle(RIGHT, i*arc) * UP
					output[i] = RIGHT + vi
					output[n + i] = LEFT + vi
				end
				return output
			end

			local function icoSphere(n)
				local verts = {
					Vector3.new(-1,  PHI, 0),
					Vector3.new(1,  PHI, 0),
					Vector3.new(-1, -PHI, 0),
					Vector3.new(1, -PHI, 0),

					Vector3.new(0, -1,  PHI),
					Vector3.new(0,  1,  PHI),
					Vector3.new(0, -1, -PHI),
					Vector3.new(0,  1, -PHI),

					Vector3.new(PHI, 0, -1),
					Vector3.new(PHI, 0,  1),
					Vector3.new(-PHI, 0, -1),
					Vector3.new(-PHI, 0,  1)
				}

				local indices = {
					1, 12, 6,
					1, 6, 2,
					1, 2, 8,
					1, 8, 11,
					1, 11, 12,

					2, 6, 10,
					6, 12, 5,
					12, 11, 3,
					11, 8, 7,
					8, 2, 9,

					4, 10, 5,
					4, 5, 3,
					4, 3, 7,
					4, 7, 9,
					4, 9, 10,

					5, 10, 6,
					3, 5, 12,
					7, 3, 11,
					9, 7, 8,
					10, 9, 2
				}

				local splits = {}

				local function split(i, j)
					local key = i < j and (i .. "," .. j) or (j .. "," .. i)

					if (not splits[key]) then
						verts[#verts+1] = (verts[i] + verts[j]) / 2
						splits[key] = #verts
					end

					return splits[key]
				end

				for _ = 1, n do
					for  i = #indices, 1, -3 do
						local v1, v2, v3 = indices[i - 2], indices[i - 1], indices[i]
						local a = split(v1, v2)
						local b = split(v2, v3)
						local c = split(v3, v1)

						indices[#indices+1] = v1
						indices[#indices+1] = a
						indices[#indices+1] = c

						indices[#indices+1] = v2
						indices[#indices+1] = b
						indices[#indices+1] = a

						indices[#indices+1] = v3
						indices[#indices+1] = c
						indices[#indices+1] = b

						indices[#indices+1] = a
						indices[#indices+1] = b
						indices[#indices+1] = c

						table.remove(indices, i)
						table.remove(indices, i - 1)
						table.remove(indices, i - 2)
					end
				end

				-- normalize
				for i = 1, #verts do
					verts[i] = verts[i].Unit
				end

				return verts
			end

			-- Useful functions

			local function vertShape(cf, size2, array)
				local output = {}
				for i = 1, #array do
					output[i] = cf:PointToWorldSpace(array[i] * size2)
				end
				return output
			end

			local function getCentroidFromSet(set)
				local sum = set[1]
				for i = 2, #set do
					sum = sum + set[2]
				end
				return sum / #set
			end

			local function classify(part)
				if (part.ClassName == "Part") then
					if (part.Shape == Enum.PartType.Block) then
						return "Block"
					elseif (part.Shape == Enum.PartType.Cylinder) then
						return "Cylinder"
					elseif (part.Shape == Enum.PartType.Ball) then
						return "Ball"
					end;
				elseif (part.ClassName == "WedgePart") then
					return "Wedge"
				elseif (part.ClassName == "CornerWedgePart") then
					return "CornerWedge"
				elseif (part:IsA("BasePart")) then -- mesh, CSG, truss, etc... just use block
					return "Block"
				end
			end

			-- 

			local BLOCK_ARRAY = fromIndexArray(BLOCK)
			local WEDGE_ARRAY = fromIndexArray(WEDGE)
			local CORNERWEDGE_ARRAY = fromIndexArray(CORNERWEDGE)
			local CYLINDER_ARRAY = cylinder(20)
			local SPHERE_ARRAY = icoSphere(2)

			return {
				Block = function(cf, size2) return vertShape(cf, size2, BLOCK_ARRAY) end;
				Wedge = function(cf, size2) return vertShape(cf, size2, WEDGE_ARRAY) end;
				CornerWedge = function(cf, size2) return vertShape(cf, size2, CORNERWEDGE_ARRAY) end;
				Cylinder = function(cf, size2) return vertShape(cf, size2, CYLINDER_ARRAY) end;
				Ball = function(cf, size2) return vertShape(cf, size2, SPHERE_ARRAY) end;

				GetCentroid = getCentroidFromSet;
				Classify = classify;
			}
		end)()

		-- Class

		local RotatedRegion3 = {}
		RotatedRegion3.__index = RotatedRegion3

		-- Private functions

		local function getCorners(cf, s2)
			return {
				cf:PointToWorldSpace(Vector3.new(-s2.x, s2.y, s2.z));
				cf:PointToWorldSpace(Vector3.new(-s2.x, -s2.y, s2.z));
				cf:PointToWorldSpace(Vector3.new(-s2.x, -s2.y, -s2.z));
				cf:PointToWorldSpace(Vector3.new(s2.x, -s2.y, -s2.z));
				cf:PointToWorldSpace(Vector3.new(s2.x, s2.y, -s2.z));
				cf:PointToWorldSpace(Vector3.new(s2.x, s2.y, s2.z));
				cf:PointToWorldSpace(Vector3.new(s2.x, -s2.y, s2.z));
				cf:PointToWorldSpace(Vector3.new(-s2.x, s2.y, -s2.z));
			}
		end

		local function worldBoundingBox(set)
			local x, y, z = {}, {}, {}
			for i = 1, #set do x[i], y[i], z[i] = set[i].x, set[i].y, set[i].z end
			local min = Vector3.new(math.min(unpack(x)), math.min(unpack(y)), math.min(unpack(z)))
			local max = Vector3.new(math.max(unpack(x)), math.max(unpack(y)), math.max(unpack(z)))
			return min, max
		end

		-- Public Constructors

		function RotatedRegion3.new(cframe, size)
			local self = setmetatable({}, RotatedRegion3)

			self.CFrame = cframe
			self.Size = size
			self.Shape = "Block"

			self.Set = Vertices.Block(cframe, size/2)
			self.Support = Supports.PointCloud
			self.Centroid = cframe.p

			self.AlignedRegion3 = Region3.new(worldBoundingBox(self.Set))

			return self
		end

		RotatedRegion3.Block = RotatedRegion3.new

		function RotatedRegion3.Wedge(cframe, size)
			local self = setmetatable({}, RotatedRegion3)

			self.CFrame = cframe
			self.Size = size
			self.Shape = "Wedge"

			self.Set = Vertices.Wedge(cframe, size/2)
			self.Support = Supports.PointCloud
			self.Centroid = Vertices.GetCentroid(self.Set)

			self.AlignedRegion3 = Region3.new(worldBoundingBox(self.Set))

			return self
		end

		function RotatedRegion3.CornerWedge(cframe, size)
			local self = setmetatable({}, RotatedRegion3)

			self.CFrame = cframe
			self.Size = size
			self.Shape = "CornerWedge"

			self.Set = Vertices.CornerWedge(cframe, size/2)
			self.Support = Supports.PointCloud
			self.Centroid = Vertices.GetCentroid(self.Set)

			self.AlignedRegion3 = Region3.new(worldBoundingBox(self.Set))

			return self
		end

		function RotatedRegion3.Cylinder(cframe, size)
			local self = setmetatable({}, RotatedRegion3)

			self.CFrame = cframe
			self.Size = size
			self.Shape = "Cylinder"

			self.Set = {cframe, size/2}
			self.Support = Supports.Cylinder
			self.Centroid = cframe.p

			self.AlignedRegion3 = Region3.new(worldBoundingBox(getCorners(unpack(self.Set))))

			return self
		end

		function RotatedRegion3.Ball(cframe, size)
			local self = setmetatable({}, RotatedRegion3)

			self.CFrame = cframe
			self.Size = size
			self.Shape = "Ball"

			self.Set = {cframe, size/2}
			self.Support = Supports.Ellipsoid
			self.Centroid = cframe.p

			self.AlignedRegion3 = Region3.new(worldBoundingBox(getCorners(unpack(self.Set))))

			return self
		end

		function RotatedRegion3.FromPart(part)
			return RotatedRegion3[Vertices.Classify(part)](part.CFrame, part.Size)
		end

		-- Public Constructors

		function RotatedRegion3:CastPoint(point)
			local gjk = GJK.new(self.Set, {point}, self.Centroid, point, self.Support, Supports.PointCloud)
			return gjk:IsColliding()
		end

		function RotatedRegion3:CastPart(part)
			local r3 = RotatedRegion3.FromPart(part)
			local gjk = GJK.new(self.Set, r3.Set, self.Centroid, r3.Centroid, self.Support, r3.Support)
			return gjk:IsColliding()
		end

		function RotatedRegion3:FindPartsInRegion3(ignore, maxParts)
			local found = {}
			local parts = game.Workspace:FindPartsInRegion3(self.AlignedRegion3, ignore, maxParts)
			for i = 1, #parts do
				if (self:CastPart(parts[i])) then
					table.insert(found, parts[i])
				end
			end
			return found
		end

		function RotatedRegion3:FindPartsInRegion3WithIgnoreList(ignore, maxParts)
			ignore = ignore or {}
			local found = {}
			local parts = game.Workspace:FindPartsInRegion3WithIgnoreList(self.AlignedRegion3, ignore, maxParts)
			for i = 1, #parts do
				if (self:CastPart(parts[i])) then
					table.insert(found, parts[i])
				end
			end
			return found
		end

		function RotatedRegion3:FindPartsInRegion3WithWhiteList(whiteList, maxParts)
			whiteList = whiteList or {}
			local found = {}
			local parts = game.Workspace:FindPartsInRegion3WithWhiteList(self.AlignedRegion3, whiteList, maxParts)
			for i = 1, #parts do
				if (self:CastPart(parts[i])) then
					table.insert(found, parts[i])
				end
			end
			return found
		end

		function RotatedRegion3:Cast(ignore, maxParts)
			ignore = type(ignore) == "table" and ignore or {ignore}
			return self:FindPartsInRegion3WithIgnoreList(ignore, maxParts)
		end

		--

		return RotatedRegion3
	end)()
	local Triangulator = (function()
		-- by Player_57.
--[[ ----------------------------------

	-- Triangulation Module --

---------------------------------- ]]--
--[[

-- CREDITS -----------------------------------------------------------------------------
StackOverflow Darius Bacon (How to determine if a point is between two other points on a line segment)
GeeksForGeeks (How to ceck if two line segments intersect (using orientation method))
GeeksForGeeks (How to check if point is inside polygon)
EgoMoose (Triangle Generator Function)
ABitWise (Reflex Vertex Test)

Eberly (Ear Clipping Article)
ABitWise (Ear Clipping Algorithm)


-- QUICK MAFS -----------------------------------------------------------------------------
GetTriangulation: positionstable, excludeaxis --> trianglestable
GetTriangulationWithHole: positionstable, holestable, excludeaxis --> trianglestable
MakeTriangle: triangle, excludeaxis, axispos --> {wedge1, wedge2}
]]

		local Triangulator = {}

		local function IsBetween(check, num1, num2)
			if (num1 <= check and check <= num2) or (num1 >= check and check >= num2) then
				return true
			end
			return false
		end

--[[
0: Colinear
1: Clockwise
2: Counterclockwise
]]
		local function OrientationOf(point1, point2, point3)
			local val = (point2.Y-point1.Y) * (point3.X-point2.X) - (point2.X-point1.X) * (point3.Y-point2.Y)
			if val == 0 then
				return 0
			elseif val > 0 then
				return 1
			else
				return 2
			end
		end

		local function IsOnSegment(check, point1, point2)
			local between = false
			if point1.X ~= point2.X then
				between = IsBetween(check.X, point1.X, point2.X)
			else
				between = IsBetween(check.Y, point1.Y, point2.Y)
			end
			return (OrientationOf(check, point1, point2) == 0 and between == true) --If points are colinear and pointcheck is between point1 and point2
		end

		--Check if Line Segment from Point A to B is Intersecting with Line Segment from  Point C to D
		local function Intersecting(a, b, c, d)
			local orientation1 = OrientationOf(a, b, c)
			local orientation2 = OrientationOf(a, b, d)
			local orientation3 = OrientationOf(c, d, a)
			local orientation4 = OrientationOf(c, d, b)

			if orientation1 ~= orientation2 and orientation3 ~= orientation4 then
				return true
			end

			--special cases
			if orientation1 == 0 and IsOnSegment(c, a, b) then
				return true
			end
			if orientation2 == 0 and IsOnSegment(d, a, b) then
				return true
			end
			if orientation3 == 0 and IsOnSegment(a, c, d) then
				return true
			end
			if orientation4 == 0 and IsOnSegment(b, c, d) then
				return true
			end
		end

		local function IsInsidePolygon(point, vertices)
			if #vertices < 3 then
				return false
			end

			local endpoint = Vector2.new(point.X+696969, point.Y) --endpoint of ray extending to right from point

			local intersections = 0

			for i = 1, #vertices do
				local currentvertex = vertices[i]
				local nextvertex
				if i == #vertices then
					nextvertex = vertices[1]
				else
					nextvertex = vertices[i+1]
				end

				if Intersecting(point, endpoint, currentvertex, nextvertex) then --check if the ray intersects with this polygon's line segment
					if OrientationOf(point, currentvertex, nextvertex) == 0 then
						return IsOnSegment(point, currentvertex, nextvertex) --returns whether point is on Line Segment from currentvertex to nextvertex IF it is colinear with the vertices of the Line Segment
					end
					intersections = intersections + 1
				end
			end
			return intersections % 2 == 1
		end

		local function GetMidPoint(...)
			local points = {...}
			local midpoint = points[1]
			for i = 2, #points do
				midpoint = midpoint + points[i]
			end
			return midpoint/#points
		end

		local function PointOfIntersection(a, b, c, d, linesegments)
			local a1 = b.Y - a.Y
			local b1 = a.X - b.X
			local c1 = a1*a.X + b1*a.Y

			local a2 = d.Y - c.Y
			local b2 = c.X - d.X
			local c2 = a2*c.X + b2*c.Y

			local determinant = a1*b2 - a2*b1

			if determinant == 0 then --parallel lines
				return nil
			else
				local point = Vector2.new((b2*c1 - b1*c2)/determinant, (a1*c2 - a2*c1)/determinant)
				if linesegments then
					if IsOnSegment(point, a, b) and IsOnSegment(point, c, d) then
						return point
					end
					return nil
				end
				return point
			end
		end

		local function GetSignedArea(positions) --thanks to our good old friend stackoverflow (user Sean The Bean)
			local signedarea = 0
			for i = 1, #positions do
				local currentpos = positions[i]
				local nextpos
				if i == #positions then
					nextpos = positions[1]
				else
					nextpos = positions[i+1]
				end
				signedarea = signedarea + (currentpos.X * nextpos.Y - nextpos.X * currentpos.Y)
			end
			return signedarea/2
		end

		--1: Polygon vertex ordering is clockwise
		--2: Polygon vertex ordering is counterclockwise
		local function IsReflex(prevvertex, currentvertex, nextvertex, o)
			local v1 = prevvertex-currentvertex
			local v2 = nextvertex-currentvertex
			local nml = Vector2.new(v1.Y, -v1.X)

			local mag = nml.Magnitude * v2.Magnitude
			local angle = math.deg(math.acos(nml:Dot(v2) / mag))

			return (o == 1 and angle >= 90) or (o == 2 and angle <= 270)
		end

		--I literally forgot what this does wth
		--Thanks for not putting comments, myself from the past
		function Triangulator:GetTriangulation(positions, excludeaxis)
			if #positions < 3 then
				return
			end

			--CONVERT CLOCKWISE TO COUNTERCLOCKWISE
			local positions = Triangulator:CopyTable(positions)
			if GetSignedArea(positions) < 0 then
				positions = Triangulator:FlipTable(positions)
			end

			local allvertices = {}
			for i = 1, #positions do
				allvertices[tostring(i)] = positions[i]
			end
			local poscopy = Triangulator:CopyTable(positions)
			for i, v in next, poscopy do
				poscopy[i] = tostring(i)
			end
			local ears = {}
			local triangles = {}

			while #poscopy > 3 do
				local refvertices = {} --bruh do we even need this
				local earindex = -1

				for i = 1, #poscopy do
					if earindex >= 0 then
						break
					end

					local prevvertex
					local currentvertex = poscopy[i]
					local nextvertex

					if i == 1 then
						prevvertex = poscopy[#poscopy]
					else
						prevvertex = poscopy[i-1]
					end
					if i == #poscopy then
						nextvertex = poscopy[1]
					else
						nextvertex = poscopy[i+1]
					end

					local triangle = {allvertices[prevvertex], allvertices[currentvertex], allvertices[nextvertex]}

					local cont = false

					if OrientationOf(allvertices[prevvertex], allvertices[currentvertex], allvertices[nextvertex]) == 1 then --if orientation of triangle is not orientation of polygon (in this case if clockwise =/= counterclockwise)
						table.insert(refvertices, currentvertex)
						cont = true
					end

					if cont == false then
						local ear = true
						for i, v in next, poscopy do
							if allvertices[v] ~= allvertices[prevvertex] and allvertices[v] ~= allvertices[currentvertex] and allvertices[v] ~= allvertices[nextvertex] and Triangulator:IsInsidePolygon(allvertices[v], triangle) then
								ear = false
							end
						end
						if ear == true then
							earindex = i
						end
					end
				end
				if earindex < 0 then
					break
				end
				local prevvertex
				local nextvertex

				if earindex == 1 then
					prevvertex = poscopy[#poscopy]
				else
					prevvertex = poscopy[earindex-1]
				end
				if earindex == #poscopy then
					nextvertex = poscopy[1]
				else
					nextvertex = poscopy[earindex+1]
				end
				table.insert(triangles, {allvertices[prevvertex], allvertices[poscopy[earindex]], allvertices[nextvertex]})
				table.remove(poscopy, earindex)
			end
			table.insert(triangles, {allvertices[poscopy[1]], allvertices[poscopy[2]], allvertices[poscopy[3]]})
			for i, v in next, triangles do
				for a, b in next, v do
					if excludeaxis == 'X' then
						v[a] = Vector3.new(0, b.X, -b.Y)
					elseif excludeaxis == 'Y' then
						v[a] = Vector3.new(b.X, 0,  -b.Y)
					elseif excludeaxis == 'Z' then
						v[a] = Vector3.new(b.X, b.Y, 0)
					end
				end
			end
			return triangles
		end

		function Triangulator:GetTriangulationWithHole(positions, holes, excludeaxis)
			local poscopy = Triangulator:CopyTable(positions)
			local holescopy = Triangulator:CopyTable(holes)
			local refvertices = {}

			if GetSignedArea(positions) < 0 then --CLOCKWISE TO COUNTERCLOCKWISE
				positions = Triangulator:FlipTable(positions)
			end

			for i, v in next, holescopy do
				if GetSignedArea(v) > 0 then --COUNTERCLOCKWISE TO CLOCKWISE
					holescopy[i] = Triangulator:FlipTable(v)
				end
			end

			--GET REFLEX VERTICES
			for i = 1, #poscopy do
				local prevvertex
				local currentvertex = poscopy[i]
				local nextvertex
				if i == 1 then
					prevvertex = poscopy[#poscopy]
				else
					prevvertex = poscopy[i - 1]
				end
				if i == #poscopy then
					nextvertex = poscopy[1]
				else
					nextvertex = poscopy[i + 1]
				end

				if Triangulator:IsInsidePolygon(GetMidPoint(prevvertex, currentvertex, nextvertex), poscopy) == false then --if middle point of triangle is outside the polygon, then it is a reflex vertex
					table.insert(refvertices, currentvertex)
				end
			end

			for i, v in next, holescopy do
				local rightmost = v[1]
				local holeindex = 1
				for a, b in next, v do
					if b.X > rightmost.X then
						rightmost = b
						holeindex = a
					end
				end
				local endpoint = Vector2.new(rightmost.X+696969, rightmost.Y)
				local neededpoint = rightmost
				for l = 1, #poscopy do
					local nextpos
					if l == #poscopy then
						nextpos = poscopy[1]
					else
						nextpos = poscopy[l+1]
					end
					if Intersecting(rightmost, endpoint, poscopy[l], nextpos) then
						local p = PointOfIntersection(rightmost, endpoint, poscopy[l], nextpos)
						if (rightmost-p).Magnitude > (rightmost-neededpoint).Magnitude then --get closest intersection point to rightmost
							if Triangulator:IsInTable(poscopy, p) then
								neededpoint = p
							else
								local edgerightmost
								if poscopy[l].X > nextpos.X then
									edgerightmost = poscopy[l]
								else
									edgerightmost = nextpos
								end
								local refsinside = {}
								for a, b in next, refvertices do
									if Triangulator:IsInsidePolygon(b, {rightmost, p, edgerightmost}) then
										table.insert(refsinside, b)
									end
								end
								if #refsinside == 0 then --No reflex vertices inside triangle (rightmost, p, edgerightmost)
									neededpoint = edgerightmost
								else
									local refclosest = refsinside[1]
									for a, b in next, refsinside do
										if (rightmost-b).Magnitude < (rightmost-refclosest).Magnitude then
											refclosest = b
										end
									end
									neededpoint = refclosest
								end
							end
						end
					end
				end
				local posindex
				for a, b in next, poscopy do
					if b == neededpoint then
						posindex = a+1
					end
				end

				table.insert(poscopy, posindex, neededpoint)
				table.insert(poscopy, posindex, rightmost)
				if holeindex ~= 1 then	
					local shiftedtab = {}

					for l = holeindex, #v do
						table.insert(shiftedtab, v[l])
					end
					for l = 1, holeindex-1 do
						table.insert(shiftedtab, v[l])
					end
					for l = #shiftedtab, 1, -1 do
						table.insert(poscopy, posindex, shiftedtab[l])
					end
				else
					for l = #v, 1, -1 do
						table.insert(poscopy, posindex, v[l])
					end
				end

		--[[local rand = {}
		for i = 1, #poscopy do
			rand[i] = BrickColor.Random()
			print(rand[i])
		end
		
		for i = 1, #poscopy do
			local a
			local b = poscopy[i]
			if excludeaxis == 'X' then
				a = Vector3.new(0, b.X, -b.Y)
			elseif excludeaxis == 'Y' then
				a = Vector3.new(b.X, 0,  -b.Y)
			elseif excludeaxis == 'Z' then
				a = Vector3.new(b.X, b.Y, 0)
			end
			createpart(nil, 0, true, false, nil, nil, nil, Vector3.new(2, 2, 2), CFrame.new(a), workspace).BrickColor = rand[i]
		end]]
			end
			return Triangulator:GetTriangulation(poscopy, excludeaxis)
		end

		--Massive thanks to EgoMoose and his Triangle Generator Function
		function Triangulator:MakeTriangle(triangle, excludeaxis, axispos)
			local a = triangle[1]
			local b = triangle[2]
			local c = triangle[3]

			local ab, ac, bc = b - a, c - a, c - b;
			local abd, acd, bcd = ab:Dot(ab), ac:Dot(ac), bc:Dot(bc);

			if (abd > acd and abd > bcd) then
				c, a = a, c;
			elseif (acd > bcd and acd > abd) then
				a, b = b, a;
			end

			ab, ac, bc = b - a, c - a, c - b;

			local right = ac:Cross(ab).unit;
			local up = bc:Cross(right).unit;
			local back = bc.unit;

			local height = math.abs(ab:Dot(up));

			local wedge1 = Instance.new('WedgePart')
			wedge1.CanCollide = false
			wedge1.Size = Vector3.new(0.5, height, math.abs(ab:Dot(back)))

			if excludeaxis == 'X' then
				wedge1.CFrame = CFrame.new(axispos, 0, 0)
			elseif excludeaxis == 'Y' then
				wedge1.CFrame = CFrame.new(0, axispos, 0)
			elseif excludeaxis == 'Z' then
				wedge1.CFrame = CFrame.new(0, 0, axispos)
			end
			wedge1.CFrame = wedge1.CFrame * CFrame.fromMatrix((a + b)/2, right, up, back)


			local wedge2 = Instance.new('WedgePart')
			wedge2.CanCollide = false
			wedge2.Size = Vector3.new(0.5, height, math.abs(ac:Dot(back)))

			if excludeaxis == 'X' then
				wedge2.CFrame = CFrame.new(axispos, 0, 0)
			elseif excludeaxis == 'Y' then
				wedge2.CFrame = CFrame.new(0, axispos, 0)
			elseif excludeaxis == 'Z' then
				wedge2.CFrame = CFrame.new(0, 0, axispos)
			end
			wedge2.CFrame = wedge2.CFrame * CFrame.fromMatrix((a + c)/2, -right, up, -back)

			return {wedge1, wedge2}
		end

		return Triangulator

	end)()

--[[ ----------------------------------

			-- FUNCTIONS --

---------------------------------- ]]--

	-- MISC --------------------------------------------------------------------------------

	function CoreSysFunc:ReverseStringSplit(splitstr, args)
		local str = args[1]

		-- reverses the :split() function/makes sure that all the strings with splistr as well are accounted for (since they were :split by splitstr)
		for i = 2, #args do
			str = str..splitstr..args[i]
		end
		return str
	end
	function CoreSysFunc:RoundNumber(num, dec)
		local num = num * 10 ^ dec
		num = num >= 0 and math.floor(num + 0.5) or math.ceil(num - 0.5)
		return num / (10 ^ dec)
	end


	function CoreSysFunc:GetDictionaryLength(tab)
		local counter = 0
		for i, v in tab do
			counter = counter + 1
		end
		return counter
	end

	function CoreSysFunc:CopyTable(tab)
		local copy = {}
		for i, v in tab do
			local v = v
			if type(v) == "table" then
				v = CoreSysFunc:CopyTable(v)
			end
			copy[i] = v
		end
		return copy
	end

	function CoreSysFunc:FlipTable(tab)
		local flipped = {}
		for i = #tab, 1, -1 do
			table.insert(flipped, tab[i])
		end
		return flipped
	end

	function CoreSysFunc:RemoveFromTable(tab, val)
		local index = table.find(tab, val)
		if index then
			table.remove(tab, index)
		end
	end

	function CoreSysFunc:PickRandomFromTable(tab)
		return tab[rnd:NextInteger(1, #tab)]
	end


	function CoreSysFunc:IsDestroyed(inst)
		if inst.Parent ~= nil then
			return false
		end
		local _, b = pcall(function()
			inst.Parent = inst
		end)
		if b:match("locked") then
			return true
		else
			return false
		end
	end

	function CoreSysFunc:IsBodyPart(inst)
		if not inst.Parent then return false end
		for i, v in players:GetPlayers() do
			if v.Character and inst:IsDescendantOf(v.Character) then
				return true
			end
		end
		if inst.Parent:FindFirstChildWhichIsA("Humanoid") or (inst.Parent.Parent == nil or inst.Parent.Parent:FindFirstChildWhichIsA("Humanoid")) then
			return true
		end
		return false
	end

	function CoreSysFunc:IsDead(inst)
		if inst == nil then return true end
		local char
		if inst:IsA("Player") then
			char = inst.Character
		elseif inst:IsA("Model") then
			char = inst
		end
		if char == nil or char.Parent == nil or (inst:IsA("Player") and (char:FindFirstChild("HumanoidRootPart") == nil or char:FindFirstChild("HumanoidRootPart"):IsA("BasePart") == false)) or char:FindFirstChildWhichIsA("Humanoid") == nil or char:FindFirstChildWhichIsA("Humanoid").Health <= 0 then
			return true
		end
		return false
	end
	function CoreSysFunc:IsRobloxLocked(inst)
		return not pcall(function() type(inst.Name) end) -- small optimization - EwDev
	end

	do
		local function _hn(func, ...) -- oopsies wat the hell roblox broke locked instance detection so i need to use this smhh oh well its leaked already anyway
			return func(...)
		end
		function CoreSysFunc:HasLockedInst(inst)
			return false
		end
	end


	function CoreSysFunc:RoundColor3(color3, dec)
		return Color3.new(CoreSysFunc:RoundNumber(color3.R, dec), CoreSysFunc:RoundNumber(color3.G, dec), CoreSysFunc:RoundNumber(color3.B, dec))
	end

	function CoreSysFunc:RoundVector3(vector3, dec)
		return Vector3.new(CoreSysFunc:RoundNumber(vector3.X, dec), CoreSysFunc:RoundNumber(vector3.Y, dec), CoreSysFunc:RoundNumber(vector3.Z, dec))
	end

	function CoreSysFunc:RoundCFrame(cframe, dec)
		local components = table.pack(cframe:GetComponents())
		for i, v in components do
			components[i] = CoreSysFunc:RoundNumber(v, dec)
		end
		return CFrame.new(unpack(components))
	end


	function CoreSysFunc:ToVector2(vector3, excludeaxis)
		if excludeaxis == "X" then
			return Vector2.new(vector3.Y, vector3.Z)
		elseif excludeaxis == "Y" then
			return Vector2.new(vector3.X, vector3.Z)
		elseif excludeaxis == "Z" then
			return Vector2.new(vector3.X, vector3.Y)
		end
	end
	function CoreSysFunc:ToVector3(vector2, excludeaxis)
		if excludeaxis == "X" then
			return Vector3.new(0, vector2.X, vector2.Y)
		elseif excludeaxis == "Y" then
			return Vector3.new(vector2.X, 0, vector2.Y)
		elseif excludeaxis == "Z" then
			return Vector3.new(vector2.X, vector2.Y, 0)
		end
	end

	function CoreSysFunc:Lerp(start, fin, l)
		return start + (fin - start) * l
	end

	-- Copied this randomstring off of Chirunee's script lol
	-- Thank you to Jack_Hase for his randomstring function since my old one was so laggy wth
	-- made a faster randomstring faster - EwDev
	function CoreSysFunc:RandomString()
	--[[local name = ""
	for i = 1, rnd:NextInteger(50, 100 do
		name = name..string.char(rnd:NextInteger(32, 126))
	end
	return name]]
	--[[return ("."):rep(rnd:NextInteger(50, 100)):gsub(".", function()
		return string.char(rnd:NextInteger(32, 126))
	end)]]
		local l = math.random(50, 100)
		local a = table.create(l)
		for i = 1, l do
			a[i] = string.char(math.random(32, 126))
		end

		return table.concat(a)
	end

	function CoreSysFunc:RandomAngle()
		return CFrame.Angles(math.rad(rnd:NextNumber(0, 360)), math.rad(rnd:NextNumber(0, 360)), math.rad(rnd:NextNumber(0, 360)))
	end

	function CoreSysFunc:RandomSign()
		return ({-1, 1})[rnd:NextInteger(1, 2)]
	end


	function CoreSysFunc:GetAncestors(inst)
		local parent = inst.Parent
		local ancestors = {}

		while parent ~= nil do
			ancestors[#ancestors+1] = parent
			parent = parent.Parent
		end

		return ancestors
	end
	function CoreSysFunc:GetBaseParts(inst)
		local parts = {}
		for i, v in inst:GetDescendants() do
			if v:IsA("BasePart") and v:IsA("Terrain") == false then
				table.insert(parts, v)
			end
		end
		return parts
	end
	function CoreSysFunc:GetLockedInstances(inst)
		return {}
	end


	function CoreSysFunc:GetServices()
		local tab = {}

		for i, v in game:GetChildren() do
			pcall(function()
				table.insert(tab, v)
			end)
		end

		return tab
	end

	-- doesn't have to be an instance you're getting, can be a property like CFrame or anything
	function CoreSysFunc:GetObjFromString(str, initialinst)
		if initialinst then
			return loadstring("function getInst(initialinst) return initialinst."..str.." end return getInst")()(initialinst)
		else
			return loadstring("return "..str)()
		end
	end

	function CoreSysFunc:GetPlayersFromString(str)
		local playertable = {}
		local str = str:lower()
		for i, v in players:GetPlayers() do
			if v.Name:lower():match(str) then
				table.insert(playertable, v)
			end
		end
		return playertable
	end

	function CoreSysFunc:GetPlayerFromInst(inst)
		local a
		if inst then
			for i, v in players:GetPlayers() do
				if v.Character then
					if inst:IsDescendantOf(v.Character) then
						a = v
						break
					end
				end
			end
		end
		return a
	end


	function CoreSysFunc:CloneInst(inst)
		for i, v in inst:GetDescendants() do
			v.Archivable = true
		end
		inst.Archivable = true
		return inst:Clone()
	end

	function CoreSysFunc:FakePrimaryPart(inst) --If Model has no primarypart, returns part in the model that is nearest to its center pos
		local center = inst:GetBoundingBox().Position
		local part
		local min = math.huge
		for i, v in inst:GetDescendants() do
			if v:IsA("BasePart") then
				if (v.Position-center).Magnitude < min then
					part = v
					min = (v.Position-center).Magnitude
				end
			end
		end
		return part
	end





	-- MISC 2 ------------------------------------------------------------------------------
	function CoreSysFunc:ResizeModel(model, scale)
		local prim = model.PrimaryPart
		local cf
		if prim then
			cf = prim.CFrame
		else
			cf = model:GetBoundingBox()
		end

		for i, part in model:GetDescendants() do
			if part:IsA("BasePart") then
				part.Size = part.Size * scale
				if part ~= prim then
					local relativecf = cf:ToObjectSpace(part.CFrame)
					part.CFrame = (cf * CFrame.new(relativecf.Position * scale) * relativecf.Rotation)
				end
			end
		end
	end

	-- Get only end size and cframe data instead of actually scaling the parts
	function CoreSysFunc:GetResizedModelData(model, scale)
		local prim = model.PrimaryPart
		local cf = prim.CFrame

		local data = {}

		for i, part in model:GetDescendants() do
			if part:IsA("BasePart") then
				local pdata = {}
				pdata.Size = part.Size * scale
				if part ~= prim then
					local relativecf = cf:ToObjectSpace(part.CFrame)
					pdata.CFrame = (cf * CFrame.new(relativecf.Position * scale) * relativecf.Rotation)
				end
				data[part] = pdata
			end
		end

		return data
	end

	function CoreSysFunc:GetTouchingParts(part) --A lot of thanks to buildthomas for his method of making gettouchingparts work with non-cancollide parts
		local connection = part.Touched:Connect(function() end)
		local results = part:GetTouchingParts()
		connection:Disconnect()
		return results
	end

	-- Thankfully EgoMoose made his RotatedRegion3 module!!!
	function CoreSysFunc:PosInRotatedRegion(pos, regioncf, regionsize)
		-- EgoMoose's CastPoint will return false if the pos is smack dab in the middle of the region lol
		if regioncf.Position == pos then
			return true
		end
		return RotatedRegion3.new(regioncf, regionsize):CastPoint(pos)
	end
	function CoreSysFunc:PartInRotatedRegion(part, regioncf, regionsize)
		-- EgoMoose's CastPart will return false if the pos is smack dab in the middle of the region lol
		if regioncf.Position == part.Position then
			return true
		end
		return RotatedRegion3.new(regioncf, regionsize):CastPart(part)
	end

	-- EwDev optimized this
	local worldModels = {}

	function CoreSysFunc:Region(regioncf, regionsize, filtertable, filtertype) -- Executes on both workspace and worldmodels
		local params = OverlapParams.new()
		if filtertable then
			params.FilterDescendantsInstances = filtertable
		end
		params.FilterType = filtertype or Enum.RaycastFilterType.Exclude

		return workspace:GetPartBoundsInBox(regioncf, regionsize, params)
	end
	function CoreSysFunc:RegionWR(worldroot, regioncf, regionsize, filtertable, filtertype)
		local params = OverlapParams.new()
		if filtertable then
			params.FilterDescendantsInstances = filtertable
		end
		params.FilterType = filtertype or Enum.RaycastFilterType.Exclude

		return worldroot:GetPartBoundsInBox(regioncf, regionsize, params)
	end

	-- Because roblox's new raycast is annoying and doesn't return anything when part is nil!!!!
	function CoreSysFunc:Raycast(pos1, pos2, dist, filtertable, filtertype) -- Execute ray on workspace only, can't be bothered to calculate stuff lol
		local params = RaycastParams.new()
		if filtertable then
			params.FilterDescendantsInstances = filtertable
		end
		params.FilterType = filtertype or Enum.RaycastFilterType.Exclude

		local dir = (pos2-pos1).Unit * dist
		local endpos = pos1 + dir
		local result = workspace:Raycast(pos1, dir, params)

		if result == nil then
			result = {
				Distance = dist,
				Position = endpos
			}
		end
		return result
	end


	function CoreSysFunc:CGExists(cgname)
		local bool = false
		for i, cg in phs:GetCollisionGroups() do
			if cg["name"] == cgname then
				bool = true
			end
		end
		return bool
	end

	function CoreSysFunc:CGSetOthersCollidable(cgname, bool, includesdefault)
		local includesdefault = includesdefault or true
		for i, cg in phs:GetCollisionGroups() do
			if cg["name"] ~= cgname and (includesdefault == true or cg["name"] ~= "Default") then
				phs:CollisionGroupSetCollidable(cgname, cg["name"], bool)
			end
		end
	end


	function CoreSysFunc:CSGSubtract(target, neg, CoFi)
		local parented = false
		local istable = typeof(neg) == "table"
		if istable then
			for i, v in neg do
				if v:IsDescendantOf(workspace) then
					parented = true
				end
			end
		else
			if neg:IsDescendantOf(workspace) then
				parented = true
			end
		end
		if target:IsDescendantOf(workspace) or parented == true then
			local CoFi = CoFi or "Hull"
			if istable == true then
				return target:SubtractAsync(neg, CoFi)
			else
				return target:SubtractAsync({neg}, CoFi)
			end
		end
	end

	function CoreSysFunc:CSGGetFragments(target, depth)
		local fragments = {}
		local depth = depth or 0
		local size = target.Size
		local cf = target.CFrame
		if target:IsDescendantOf(workspace) and depth >= 0 then
			local cuttingangle = cf * CoreSysFunc:RandomAngle()

			local c1 = Instance.new("Part")
			c1.Size = size*4
			c1.CFrame = cuttingangle * CFrame.new(0, -size.Y * 2, 0)

			local c2 = c1:Clone()
			c2.CFrame = cuttingangle * CFrame.new(0, size.Y * 2, 0)

			local p1, p2
			pcall(function()
				p1 = CoreSysFunc:CSGSubtract(target, c1)
				p2 = CoreSysFunc:CSGSubtract(target, c2)
			end)

			if p1 and p2 then

				p1.CFrame = cf * cf:ToObjectSpace(p1.CFrame)
				p2.CFrame = cf * cf:ToObjectSpace(p2.CFrame)

				p1.Parent = target.Parent
				p2.Parent = target.Parent

				table.insert(fragments, p1)
				table.insert(fragments, p2)
				if depth >= 1 then
					local f1 = CoreSysFunc:CSGGetFragments(p1, depth-1)
					local f2 = CoreSysFunc:CSGGetFragments(p2, depth-1)
					for i, v in f1 do
						table.insert(fragments, v)
					end
					for i, v in f2 do
						table.insert(fragments, v)
					end
				end
			end
		end
		for i, v in fragments do
			v.Parent = nil
		end
		return fragments
	end

--[[
	Complicated as hell but anyway
	Slicer Sizing Rules:
	X Axis: Thickness of Slicer
	Y Axis: Length of Slicer/Making sure it slices all the way through the target vertically (in this case length should be maxed out)
	Z Axis: Making sure it slices all the way through the target forwards (in this case it should be maxed out)
]]
	function CoreSysFunc:CSGSliceExtensions(slicer)
		local slicesize = slicer.Size
		local slicecf = slicer.CFrame
		local thickness = slicesize.X
		local newsize = Vector3.new(1000, slicesize.Y, slicesize.Z)

		local cf1 = slicecf * CFrame.new(-500+(thickness/2), 0, 0) -- Bottom half extension
		local cf2 = slicecf * CFrame.new(500-(thickness/2), 0, 0) -- Top half extension

		local slicer1 = slicer:Clone()
		slicer1.Transparency = 1
		slicer1.Anchored = true
		slicer1.CanCollide = false
		slicer1.Size = newsize
		slicer1.CFrame = cf1

		local slicer2 = slicer:Clone()
		slicer2.Transparency = 1
		slicer2.Anchored = true
		slicer2.CanCollide = false
		slicer2.Size = newsize
		slicer2.CFrame = cf2

		return slicer1, slicer2
	end

	function CoreSysFunc:CSGQuickSlice(target, slicer)
		local slicer1, slicer2 = CoreSysFunc:CSGSliceExtensions(slicer)

		slicer1.Parent = workspace
		slicer2.Parent = workspace

		local first = CoreSysFunc:CSGSubtract(target, {slicer1})
		local second = CoreSysFunc:CSGSubtract(target, {slicer2})

		slicer1:Destroy()
		slicer2:Destroy()
		return first, second
	end

	function CoreSysFunc:CSGSliceByExtensions(target, slicer1, slicer2)
		local first = CoreSysFunc:CSGSubtract(target, {slicer1})
		local second = CoreSysFunc:CSGSubtract(target, {slicer2})

		return first, second
	end


	function CoreSysFunc:GetTriangulation(...)
		return Triangulator:GetTriangulation(...)
	end
	function CoreSysFunc:GetTriangulationWithHole(...)
		return Triangulator:GetTriangulationWithHole(...)
	end
	function CoreSysFunc:MakeTriangle(...)
		return Triangulator:MakeTriangle(...)
	end



	-- // ...And that's pretty much it. Good luck.
	return function()

		-- // here is your newfound powers
		return CoreSysFunc
	end

end)()()

local CSE = (function()
	-- by Player_57.
--[[ ----------------------------------

	-- Core System Effects. --

---------------------------------- ]]--

--[[

-- // personal effects module
-- // i couldnt think of another name so i just changed CoreSysEfftions to CoreSysEffects lol


---------------------------------------

			-- PROPERTIES --

---------------------------------------
CoreSysEff.Effects = EffectsFolder
CoreSysEff.SFX = SFXFolder



---------------------------------------

			-- FUNCTIONS --

---------------------------------------


-- EFFECTS --------------------------------------------------------------------------------

-------------------------------- TWEENING --------------------------------
TweenInst: inst, tweensettings, destroyafter (bool), callback (function)
TweenModel: model, cf, tweeninfo --> tweenobject
TweenCustom: start, fin, tweeninfo, callback (func), setvalue (func) --> tween


-------------------------------- CREATION --------------------------------
CreatePart: propertiestable --> part

GetSound: Name --> sound
CreateSound: Name, Properties, ManualPlay (bool) --> sound


GetEffectInst: ... --> inst
CreateEffectInst: ... --> inst

Beam: table --> table


-- EFFECTS 2 ---------------------------------------------------------------------------

Lightning2D: start, fin, iter, offset --> pointstable
Lightning3D: start, fin, iter, offset --> pointstable

GlassShatter: center, radius, rarity --> branchestable

MagicCircle: data --> mctable
Selector: data --> selectortable


]]

--[[ ----------------------------------

			-- SERVICES --

---------------------------------- ]]--

	local players = game:GetService("Players")
	local deb = game:GetService("Debris")
	local runs = game:GetService("RunService")
	local reps = game:GetService("ReplicatedStorage")
	local phs = game:GetService("PhysicsService")
	local ts = game:GetService("TweenService")
	local chatsrv = game:GetService("Chat")
	local txtsrv = game:GetService("TextService")
	local lighting = game:GetService("Lighting")
	local hs = game:GetService("HttpService")
	local sss = game:GetService("ServerScriptService")
	local cols = game:GetService("CollectionService")

	local rnd = Random.new(os.clock())
	local heartbeat = runs.Heartbeat
	local stepped = runs.Stepped



--[[ ----------------------------------

			-- INITIAL --

---------------------------------- ]]--

	local CoreSysEff = {}

	CoreSysEff.Effects = script.Effects:Clone()
	CoreSysEff.SFX = script.SFX:Clone()

--[[ ----------------------------------

			-- FUNCTIONS --

---------------------------------- ]]--


--[[ ----------------------------------

			-- EFFECTS --

---------------------------------- ]]--

	--Tween Function
--[[
{
	{
	TweenInfo = tweeninfo
	Properties = {}
	
	}
}

Each keypoint by default will immediately run after the previous tween has completed

]]
	function CoreSysEff:TweenInst(inst, tweensettings, callback)

		local delaytime = 0 -- Use delay to play tweens in order and to not have to use wait() and coroutines
		for index, keypoint in tweensettings do
			local tweeninfo = keypoint.TweenInfo
			local tween = ts:Create(inst, tweeninfo, keypoint.Properties)
			task.delay(delaytime, function()
				tween:Play()
			end)
			delaytime += tweeninfo.Time

			if index == #tweensettings then -- if last tween
				if callback then
					tween.Completed:Connect(function()
						tween:Destroy()
						callback()
					end)
				end
			end
		end
	end

	function CoreSysEff:TweenModel(model, cf, info)
		local cfvalue = Instance.new("CFrameValue")
		cfvalue:Destroy()
		if pcall(function()
				cfvalue.Value = model:GetPrimaryPartCFrame()
			end) == false then
			cfvalue.Value = CoreSysEff:GetBoundingBox(model)
		end

		local connect = cfvalue:GetPropertyChangedSignal("Value"):Connect(function()
			pcall(function()
				model:SetPrimaryPartCFrame(cfvalue.Value)
			end)
		end)

		local tween = ts:Create(cfvalue, info, {
			["Value"] = cf
		})

		tween:Play()

		tween.Completed:Connect(function()
			connect:Disconnect()
		end)

		return tween
	end

	-- For tweening non-instance values (variables/table values, etc.)
--[[ SetValueFunc:
	function(val)
		variable = val
	end
]]
	function CoreSysEff:TweenCustom(start, fin, tweeninfo, setvaluefunc, callback)
		local numval = Instance.new("NumberValue")
		numval.Value = 0

		local be = Instance.new("BindableEvent")
		be.Event:Connect(setvaluefunc)
		numval:GetPropertyChangedSignal("Value"):Connect(function()
			if typeof(start) == "number" then
				be:Fire(start + (fin - start) * numval.Value)
			else
				be:Fire(start:Lerp(fin, numval.Value))
			end
		end)
		local tween = ts:Create(numval, tweeninfo, {
			Value = 1
		})
		tween.Completed:Connect(function()
			be:Destroy()
			numval:Destroy()


			if callback then
				callback()
			end
		end)
		tween:Play()
		return tween
	end


	function CoreSysEff:CreatePart(props)


		local part = Instance.new("Part")

		for i, v in props do
			part[i] = v
		end



		part.CastShadow = false
		return part
	end

	function CoreSysEff:GetSound(name)
		return CoreSysEff.SFX[name]
	end
	function CoreSysEff:CreateSound(name, props, manualplay)
		local sound = CoreSysEff.SFX[name]:Clone()
		sound:SetAttribute("SOUND_NAME", name)

		for i, v in props do
			sound[i] = v
		end
		if not manualplay then
			sound:Play()
		end
		sound.Ended:Connect(function()
			sound:Destroy()
		end)
		--if not sound.IsLoaded then sound.Loaded:Wait() end
		return sound
	end

	function CoreSysEff:GetEffectInst(...)
		local args = {...}
		local effinst
		local lastref = CoreSysEff.Effects
		for i = 1, #args do
			effinst = lastref:FindFirstChild(args[i])
			lastref = effinst
		end
		return effinst
	end
	function CoreSysEff:CreateEffectInst(...)
		return CoreSysEff:GetEffectInst(...):Clone()
	end


--[[
Props = {
	Part = BasePart
	Beam = Beam
	Pos0 = Vector3
	Pos1 = Vector3

}
Returned = {
	Part = BasePart
	Beam = Beam
	A0 = Attachment0
	A1 = Attachment1
}
]]
	function CoreSysEff:Beam(props)
		local tab = {}
		local part = props.Part

		local a0 = Instance.new("Attachment")
		local a1 = Instance.new("Attachment")

		local beam = props.Beam
		beam.Attachment0 = a0
		beam.Attachment1 = a1

		beam.Parent = part
		a0.Parent = part
		a1.Parent = part

		a0.WorldPosition = props.Pos0
		a1.WorldPosition = props.Pos1

		tab.Part = part
		tab.Beam = beam
		tab.A0 = a0
		tab.A1 = a1

		return tab
	end



--[[ ----------------------------------

			-- EFFECTS 2 --

---------------------------------- ]]--


	-- LIGHTNING -----------------------------------------------------------------------------
	function CoreSysEff:Lightning2D(start, fin, iter, offset)
		local last = start
		local offset = offset or 10
		local max = 1000
		local counter = 0
		local dist = (start - fin).Magnitude
		local steps = dist/(iter or rnd:NextInteger(10, 20))

		local points = {start}

		while counter < dist do
			local ofvector = Vector2.new(rnd:NextNumber(-offset, offset), rnd:NextNumber(-offset, offset))
			local nextpos = last + -(last - fin).Unit * steps + ofvector
			table.insert(points, nextpos)
			last = nextpos
			counter = counter + steps
		end

		table.insert(points, fin)

		return points
	end

	function CoreSysEff:Lightning3D(start, fin, iter, offset)
		local last = start
		local offset = offset or 10
		local max = 1000
		local counter = 0
		local dist = (start - fin).Magnitude
		local steps = dist/(iter or rnd:NextInteger(10, 20))

		local points = {start}

		while counter < dist do
			local ofvector = Vector3.new(rnd:NextNumber(-offset, offset), rnd:NextNumber(-offset, offset), rnd:NextNumber(-offset, offset))
			local nextpos = last + -(last - fin).Unit * steps + ofvector
			table.insert(points, nextpos)
			last = nextpos
			counter = counter + steps
		end

		table.insert(points, fin)

		return points
	end







	-- GLASS SHATTER EFFECT -----------------------------------------------------------------------------
	-- Credits to solstice/Xerantheneum for his algorithm process

	-- Sub function 1
	local function GlassBranch(start, fin)
		local dist = (fin-start).Magnitude
		local startcf = CFrame.new(start, start + (CFrame.new(start, fin).LookVector * -1)) -- ALl points are CFrames and must be looking at centerpoint

		local points = {}
	--[[
		Primary = {
			Start = startpos
			End = endpos
		}
		Branch1 = {
			Start = startpos
			End = endpos
		}
		Branch2 = {
			Start = startpos
			End = endpos
		}
	]]

		local primary = {} --Primary (initial) Branch
		local primlength = dist/rnd:NextNumber(2, 5)
		local nextcf = startcf * CFrame.new(0, 0, primlength)
		primary.Start = startcf.Position
		primary.End = nextcf.Position
		points.Primary = primary

		for i = 1, 2 do -- A short and long branch set, one starting from any point along primary branch, and one starting from endpoint of primarybranch

			local shortlength = primlength/rnd:NextNumber(2, 5)
			local longlength = primlength * rnd:NextNumber(0.5, 1.75)

			local shortstart
			if i == 1 then
				shortstart = startcf * CFrame.new(0, 0, (rnd:NextNumber(0, primlength/3))) -- Start from any point along primary branch line
			else
				shortstart = nextcf
			end
			local mid = CFrame.new((CFrame.new(shortstart.Position, fin) * CFrame.Angles(math.rad(rnd:NextNumber(45, 112.5) * CoreSysEff:RandomSign()), 0, 0) * CFrame.new(0, 0, -shortlength)).Position, start)
			-- Mid is both the short branch's endpoint and long branch's start point
			local longend = mid * CFrame.new(0, 0, longlength)

			local shortdata = {}
			local longdata = {}

			shortdata.Start = shortstart.Position
			shortdata.End = mid.Position

			longdata.Start = mid.Position
			longdata.End = longend.Position

			points["ShortBranch"..tostring(i)] = shortdata
			points["LongBranch"..tostring(i)] = longdata
		end

		return points
	end

	-- Sub function 2
	local function GlassBranchShort(start, fin)
		local dist = (fin-start).Magnitude
		local startcf = CFrame.new(start, start + (CFrame.new(start, fin).LookVector * -1)) -- ALl points are CFrames and must be looking at centerpoint

		local points = {}
	--[[
		Primary = {
			Start = startpos
			End = endpos
		}
		Branch1 = {
			Start = startpos
			End = endpos
		}
		Branch2 = {
			Start = startpos
			End = endpos
		}
	]]

		local signswitch = {-1, 1} -- Randomly choose between negative and positive angle (in nextshortcf)

		local primary = {} --Primary (initial) Branch
		local primlength = dist/rnd:NextNumber(4, 10)
		local nextcf = startcf * CFrame.new(0, 0, primlength)
		primary.Start = startcf.Position
		primary.End = nextcf.Position
		points.Primary = primary

		if rnd:NextInteger(1, 3) == 1 then
			for i = 1, 2 do -- A short and long branch set, one starting from any point along primary branch, and one starting from endpoint of primarybranch

				local shortlength = primlength/rnd:NextNumber(2, 5)
				local longlength = primlength * rnd:NextNumber(0.5, 1.75)

				local shortstart
				if i == 1 then
					shortstart = startcf * CFrame.new(0, 0, (rnd:NextNumber(0, primlength/3))) -- Start from any point along primary branch line
				else
					shortstart = nextcf
				end
				local mid = CFrame.new((CFrame.new(shortstart.Position, fin) * CFrame.Angles(math.rad(rnd:NextNumber(45, 112.5) * signswitch[rnd:NextInteger(1, 2)]), 0, 0) * CFrame.new(0, 0, -shortlength)).Position, start)
				-- Mid is both the short branch's endpoint and long branch's start point
				local longend = mid * CFrame.new(0, 0, longlength)

				local shortdata = {}
				local longdata = {}

				shortdata.Start = shortstart.Position
				shortdata.End = mid.Position

				longdata.Start = mid.Position
				longdata.End = longend.Position

				points["ShortBranch"..tostring(i)] = shortdata
				points["LongBranch"..tostring(i)] = longdata
			end
		end

		return points
	end


	-- MAIN GLASS SHATTER FUNCTION
--[[
	GlassBranches = {
		{
			{
				Start = pos
				End = pos
			}
			{
				Start = pos
				End = pos
			}
		}
		{
			Start = pos
			End = pos
			Radial = true
		}
	}

]]
	function CoreSysEff:GlassShatter(centercf, radius)

		local glassbranches = {}

		local initialpos = Vector3.zero -- Make all branches from the center point of Vector3.new(0, 0, 0)
		-- All positions will be offset from the centercf later on when they are finally recorded

		local icf_up = CFrame.new(initialpos, initialpos + Vector3.new(0, 1, 0)) -- Convert initialpos to cf looking up
		local angleincr = 360/rnd:NextInteger(8, 11)

		local longbranches = {}
		--Long Branch
		for angle = 0, 360-angleincr, angleincr do
			local anglerand = rnd:NextNumber(angleincr/4, angleincr/6) * CoreSysEff:RandomSign()
			local endpoint = (icf_up * CFrame.Angles(math.rad(angle + anglerand), 0, 0) * CFrame.new(0, 0, -radius)).Position -- Random angle, extends outwards in radius distance

			local branch = GlassBranch(initialpos, endpoint)
			table.insert(longbranches, branch)

			-- BRANCH INSERTION/RECORDING
			local gb2 = {}
			for name, data in branch do
				local gbdata = {}
				gbdata.Start = (centercf * CFrame.new(data.Start)).Position
				gbdata.End = (centercf * CFrame.new(data.End)).Position
				table.insert(gb2, gbdata)
			end
			table.insert(glassbranches, gb2)
		end

		--Small Branches
		local angleincr2 = angleincr*1.5
		for angle = 0, 360-angleincr2, angleincr2 do
			if rnd:NextInteger(1, 2) == 1 then
				local anglerand = rnd:NextNumber(angleincr2/4, angleincr2/6) * CoreSysEff:RandomSign()
				local endpoint = (icf_up * CFrame.Angles(math.rad(angle + anglerand), 0, 0) * CFrame.new(0, 0, -radius/rnd:NextNumber(2, 4))).Position -- Random angle, extends outwards in radius distance
				local shortbranch = GlassBranchShort(initialpos, endpoint)

				-- BRANCH INSERTION/RECORDING
				local gb = {}
				for name, data in shortbranch do
					local gbdata = {}
					gbdata.Start = (centercf * CFrame.new(data.Start)).Position
					gbdata.End = (centercf * CFrame.new(data.End)).Position
					table.insert(gb, gbdata)
				end
				table.insert(glassbranches, gb)
			end
		end

		-- Radial branch generation
		local targetedpoints = {} -- Prevent more than one radial connection from/onto the same point
		for i, branch in longbranches do
			local endpoint
			if (branch["LongBranch2"].End-initialpos).Magnitude > (branch["LongBranch1"].End-initialpos).Magnitude then
				endpoint = branch["LongBranch2"].End
			else
				endpoint = branch["LongBranch1"].End
			end
			for name, data in branch do
				for a, point in data do -- Loop through all points in each branch
					if table.find(targetedpoints, point) == nil then -- If startpoint wasn't already targeted
						local dist = (point-initialpos).Magnitude
						local distratio = dist/radius
						local connectradius = radius/5 -- Radius of allowed connections (dependent on actual distance of point from center, grows when farther (useed to but I changed it))
						local connectrarity = (1+0.5-(distratio*2))
					--[[
						- Rarity is from 0.1 to 1
						- As the distance of point from initialpos increases, rarity decreases
					]]
						local sort = {}
						for x, branch2 in longbranches do -- Loop through all branches that isn't the current branch being checked
							if branch2 ~= branch and math.abs(x-i) <= 1 then -- If not from own branch
								for name2, data2 in branch2 do
									if not name2:find("ShortBranch") then -- If not a short branch (else it will look weird)
										for j, point2 in data2 do
											if table.find(targetedpoints, point2) == nil and (point2-point).Magnitude <= connectradius then -- Include in sorting if targetpoint wasn't already targeted, and if the targetpoint is near current point in current branch
												local pointdata = {
													Point = point2,
													Distance = (point2-point).Magnitude
												}
												if j == "Start" then
													pointdata.Next = data2.End
												elseif j == "End" then -- If endpoint of a branch, then previous is the Start of the branch
													pointdata.Previous = data2.Start
												end
												table.insert(sort, pointdata)
											end
										end
									end
								end
							end
						end
						if #sort > 0 then
							table.sort(sort, function(a, b) -- Sort points least to greatest
								return a.Distance < b.Distance
							end)
							local data = sort[rnd:NextInteger(1, #sort)]

							table.insert(targetedpoints, point)
							table.insert(targetedpoints, data.Point)

							local targetpoint
							if data.Next then
								local l = rnd:NextNumber(0, 1)-((1-distratio)) -- More likely to be near previous point if near centerpoint
								targetpoint = data.Point:Lerp(data.Next, math.min(0, math.max(l, 1))) -- Get a random point on the line between previous point and target point
							elseif data.Previous then
								local l = rnd:NextNumber(0, 1)-((1-distratio)) -- More likely to be near previous point if near centerpoint
								targetpoint = data.Previous:Lerp(data.Point, math.min(0, math.max(l, 1))) -- Get a random point on the line between previous point and target point
							end
							if rnd:NextNumber(0, 100) <= connectrarity * 100 then -- Rarity of radial connections (lower when farther from center)


								local prev = point
								local current = targetpoint
								local pos = prev:Lerp(current, 0.5)

								--local rbranch = CoreSysEff:Lightning2D(CoreSysEff:ToVector2(point, "Z"), CoreSysEff:ToVector2(targetpoint, "Z"), rnd:NextInteger(2, 3), 0.5) -- Generate branch from center to endpoint
								local rbranch = {
									prev, current
								}
								-- BRANCH INSERTION/RECORDING
								local gb3 = {}
								for i = 2, #rbranch do
									local prev = rbranch[i-1]
									local current = rbranch[i]
									local gbdata = {}
									gbdata.Start = (centercf * CFrame.new(CoreSysEff:ToVector3(prev, "Z"))).Position
									gbdata.End = (centercf * CFrame.new(CoreSysEff:ToVector3(current, "Z"))).Position
									gbdata.Radial = true
									table.insert(gb3, gbdata)
								end
								table.insert(glassbranches, gb3)
							end
						end
					end
				end

			end
		end


		return glassbranches
	end



	-- MAGIC CIRCLE -----------------------------------------------------------------------------
--[[
Data = {
	Parts = {
		[Name] = { -- Initial Segment Data
			Part = MeshPart
			RATIO = num 0 --> 1 (Default 1) -- Scale Ratio (depends on the segment's intended size so it's in the inner/outer part of magic circle)
		}
	}
	Scale = number
	CFrame = CFrame
}
MagicCircle = {
	Scale = NumberValue (-inf, +inf)
	CFrame = CFrameValue
	Speed = NumberValue (-inf, +inf)
	Segments = {
		Name = {
			Part = MeshPart
			Scale = NumberValue (Speed Multiplier for individual segment)
			Speed = NumberValue (Speed Multiplier for individual segment)
			Angle = NumberValue (0 --> 360)
			RATIO = num
		}
	}
	
	Stopped = bool (true if :StopAll was called)
	function :StopAll()
}
]]
	function CoreSysEff:MagicCircle(Data)
		local MC = {}
		local Segments = {}

		local ScaleMod = Instance.new("NumberValue")
		ScaleMod.Value = Data.Scale

		local CFrameMod = Instance.new("CFrameValue")
		CFrameMod.Value = Data.CFrame

		local SpeedMod = Instance.new("NumberValue")
		SpeedMod.Value = 0

		for NAME, INITSegData in Data.Parts do
			local Part = INITSegData.Part
			local RATIO = INITSegData.RATIO
			local SegmentData = {}

			local SegScaleMod = Instance.new("NumberValue")
			SegScaleMod.Value = 1

			local SegSpeedMod = Instance.new("NumberValue")
			SegSpeedMod.Value = 1

			local SegAngleMod = Instance.new("NumberValue")
			SegAngleMod.Value = 0

			SegmentData.Part = Part
			SegmentData.Speed = SegSpeedMod
			SegmentData.Scale = SegScaleMod
			SegmentData.Angle = SegAngleMod
			SegmentData.RATIO = RATIO
			Segments[NAME] = SegmentData
		end


		-- RotationEvent
		local function UpdateValues()
			for NAME, SegmentData in Segments do

				local Part = SegmentData.Part
				local SegScaleMod = SegmentData.Scale
				local SegAngleMod = SegmentData.Angle
				local SegSpeedMod = SegmentData.Speed

				-- SIZE
				local Scale = ScaleMod.Value * SegScaleMod.Value * SegmentData.RATIO
				Part.Size = Vector3.new(Scale, 0.05, Scale)

				-- CFRAME
				local CurrentCFrame = CFrameMod.Value
				local TotalSpeed = SpeedMod.Value * SegSpeedMod.Value
				local NewAngle = SegAngleMod.Value + TotalSpeed
				local NewCFrame = CurrentCFrame * CFrame.Angles(0, math.rad(NewAngle), 0)

				Part.CFrame = NewCFrame
				SegAngleMod.Value = NewAngle
			end
		end
		local ev
		if runs:IsClient() then
			ev = "RenderStepped"
		else
			ev = "Heartbeat"
		end
		local UpdateEvent = runs[ev]:Connect(UpdateValues)
		function MC:StopAll()
			SpeedMod:Destroy()
			ScaleMod:Destroy()
			CFrameMod:Destroy()
			for NAME, SegmentData in Segments do
				SegmentData.Part:Destroy()
				SegmentData.Scale:Destroy()
				SegmentData.Speed:Destroy()
				SegmentData.Angle:Destroy()
			end
			UpdateEvent:Disconnect()
			MC.Stopped = true
		end

		MC.Scale = ScaleMod
		MC.CFrame = CFrameMod
		MC.Speed = SpeedMod
		MC.Segments = Segments
		MC.Stopped = false

		UpdateValues()
		return MC
	end




	-- SELECTOR -----------------------------------------------------------------------------
--[[
Data = {
	Selections = {
		{
			Name = "Attack",
			Texture = Texture Inst,
		}
	},
	
	IconColor = Color3,
	SelectColor = Color3,
	ConfirmColor = Color3,
	
	
	IconSize = Vector3,
	Radius = Vector3,
	CFrame = CFrame
}
Selector = {
	Parts = {
		["Attack"] = BasePart
	}
	Textures = {
		["Attack"] = Texture
	}
	
	IconSize = Vector3Value
	SizeModifiers = {
		["Attack"] = NumberValue
	}
	
	Radius = NumberValue
	CFrame = CFrameValue
	
	Angle = NumberValue
	RotationEvent = Heartbeat Event
	
	IconColor = data.IconColor
	SelectColor = data.SelectColor,
	ConfirmColor = data.ConfirmColor
}
]]
	function CoreSysEff:Selector(data)
		local iconsize = data.IconSize
		local radius = data.Radius
		local cf = data.CFrame

		local selections = data.Selections

		local selector = {}
		local parts = {}
		local textures = {}
		local texturecolors = {}
		local sizemod = {}

		-- Create textures + parts
		for i, tdata in selections do
			local name = tdata.Name
			local part = CoreSysEff:CreatePart({
				Name = "Circle",
				Transparency = 1,
				Anchored = true,
				CanCollide = false,
				Material = Enum.Material.Neon,
				Color = Color3.new(),
				Size = iconsize,
				CFrame = cf
			})

			local ptexture = tdata.Texture
			ptexture.Color3 = data.IconColor
			ptexture.StudsPerTileU = part.Size.X
			ptexture.StudsPerTileV = part.Size.Z
			ptexture.Parent = part
			textures[name] = ptexture

			part:GetPropertyChangedSignal("Size"):Connect(function()
				ptexture.StudsPerTileU = part.Size.X
				ptexture.StudsPerTileV = part.Size.Z
			end)
			part.AncestryChanged:Connect(function(inst, parent)
				if part.Parent == nil then
					selector.RotationEvent:Disconnect()

					selector.CFrame:Destroy()
					selector.Radius:Destroy()
					selector.Angle:Destroy()

					selector.IconSize:Destroy()
					for name, sm in selector.SizeModifiers do
						sm:Destroy()
					end
				end
			end)

			parts[name] = part

			local smval = Instance.new("NumberValue")
			smval.Value = 1
			sizemod[name] = smval
		end


		selector.Parts = parts
		selector.Textures = textures
		selector.SizeModifiers = sizemod


		-- Selector properties
		local iconsizeval = Instance.new("Vector3Value")
		iconsizeval.Value = iconsize
		selector.IconSize = iconsizeval
		local radiusval = Instance.new("NumberValue")
		radiusval.Value = radius
		selector.Radius = radiusval
		local cframeval = Instance.new("CFrameValue")
		cframeval.Value = cf
		selector.CFrame = cframeval


		local angleval = Instance.new("NumberValue")
		angleval.Value = 0
		selector.Angle = angleval

		-- Rotation

		-- Record angles of each selection
		local angledata = {}

		local anglediv = 360/#selections
		for order, tdata in selections do
			local name = tdata.Name
			angledata[name] = anglediv * (order-1)
		end

		local ev
		if runs:IsClient() then
			ev = "RenderStepped"
		else
			ev = "Heartbeat"
		end
		selector.RotationEvent = runs[ev]:Connect(function()
			local selcf = cframeval.Value
			for order, tdata in selections do
				local name = tdata.Name
				local part = parts[name]

				local selcf = cframeval.Value
				local currentradius = radiusval.Value

				-- Making sure icons are always upright
				-- Get the upvector of selcf
				local up = (CFrame.new(selcf.Position, (selcf * CFrame.new(0, 1, 0)).Position)).LookVector

				local selectorangle = angleval.Value
				local selectionangle = angledata[name]
				local finalangle = selectionangle + selectorangle

				local outwardcf = selcf * CFrame.new(math.cos(math.rad(finalangle)) * currentradius, 0, math.sin(math.rad(finalangle)) * currentradius)

				part.Size = iconsizeval.Value * sizemod[name].Value

				-- Make part look upwards, but tilt it 90 degrees forward downward since the icon is on the "Top" face of the part instead of front
				part.CFrame = CFrame.new(outwardcf.Position, outwardcf.Position + up) * CFrame.Angles(-math.rad(90), 0, 0)
			end
		end)

		selector.IconColor = data.IconColor
		selector.SelectColor = data.SelectColor
		selector.ConfirmColor = data.ConfirmColor


		-- Functions
		function selector:Select(selection)
			CoreSysEff:TweenInst(selector.Angle, {
				{
					TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Value = -angledata[selection]
					},
				},
			})
			for name, part in selector.Parts do
				local size
				if name == selection then
					size = 1.5
				else
					size = 1
				end
				CoreSysEff:TweenInst(selector.SizeModifiers[name], {
					{
						TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						Properties = {
							Value = size
						},
					},
				})
			end
			for name, texture in selector.Textures do
				local color
				if name == selection then
					color = selector.SelectColor
				else
					color = selector.IconColor
				end
				CoreSysEff:TweenInst(texture, {
					{
						TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						Properties = {
							Color3 = color
						},
					},
				})
			end
		end
		function selector:Confirm(selection)
			CoreSysEff:TweenInst(selector.Angle, {
				{
					TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Value = -angledata[selection]
					},
				},
			})

			for name, part in selector.Parts do
				local size
				if name == selection then
					size = 2.5
				else
					size = 1
				end
				CoreSysEff:TweenInst(selector.SizeModifiers[name], {
					{
						TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						Properties = {
							Value = size
						},
					},
				})
				DebrisAdd(part, 1)
			end
			for name, texture in selector.Textures do
				CoreSysEff:TweenInst(texture, {
					{
						TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						Properties = {
							Transparency = 1
						},
					},
				})
			end

			local selpart = selector.Parts[selection]
			local seltexture = selector.Textures[selection]

			CoreSysEff:TweenInst(seltexture, {
				{
					TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Color3 = selector.ConfirmColor
					},
				},
			})
		end
		function selector:Close()
			CoreSysEff:TweenInst(selector.IconSize, {
				{
					TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					Properties = {
						Value = Vector3.zero
					},
				},
			})
			CoreSysEff:TweenInst(selector.Radius, {
				{
					TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					Properties = {
						Value = 0
					},
				},
			})
			CoreSysEff:TweenInst(selector.Angle, {
				{
					TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Value = selector.Angle.Value + 270
					},
				},
			})
			for i, part in selector.Parts do
				DebrisAdd(part, 1)
			end
			for name, texture in selector.Textures do
				CoreSysEff:TweenInst(texture, {
					{
						TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						Properties = {
							Color3 = selector.ConfirmColor
						},
					},
				})
			end
		end



		return selector
	end


	-- // ...And that's pretty much it. Good luck.
	return function()
		-- // effects go pew pew
		return CoreSysEff
	end
end)()()

local heartbeat = game:GetService("RunService").PostSimulation
local deb = game:GetService("Debris")
local ts = game:GetService("TweenService")

local evil = script.Evil:Clone()
evil.Parent = owner.Backpack
evil.Activated:Wait()
evil:Destroy()

local screeng = Instance.new("ScreenGui", owner.PlayerGui)
screeng.ResetOnSpawn = false

local CFRAMES = {
	CHARACTER = {
		Character = owner.Character.HumanoidRootPart.CFrame
	},
	BALLS = {}
}

local remote = Instance.new("RemoteEvent", screeng)

local client = NLS([[
local rem = script.Parent
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	rem:FireServer('key', k, true)
end)
mouse.KeyUp:Connect(function(k)
	rem:FireServer('key', k, false)
end)
game:GetService("RunService").Heartbeat:Connect(function()
	rem:FireServer("hit", mouse.Hit)
end)
]], remote)

local animations = {
	["Counter"] = {
		Properties = {
			Looping = false,
			Priority = Enum.AnimationPriority.Core
		},
		Keyframes = {
			[0] = {
				["HumanoidRootPart"] = {
					["Torso"] = {
						CFrame = CFrame.Angles(math.rad(15.011), 0, 0),
						["Left Leg"] = {
							CFrame = CFrame.new(-0.29, 0.078, 0) * CFrame.Angles(math.rad(3.953), math.rad(14.496), math.rad(-15.527)),
						},
						["Right Leg"] = {
							CFrame = CFrame.new(0.3, 0, 0) * CFrame.Angles(math.rad(-3.953), math.rad(-14.496), math.rad(-15.527)),
						},
						["Head"] = {
							CFrame = CFrame.Angles(math.rad(-15.011), 0, 0),
						},
						["Left Arm"] = {
							CFrame = CFrame.new(-0.308, 0.183, 0.014) * CFrame.Angles(math.rad(16.96), math.rad(-8.938), math.rad(-82.907)),
							["Broom"] = {
								CFrame = CFrame.new(-0.76, 0.062, -0.432) * CFrame.Angles(math.rad(-154.469), math.rad(-72.536), math.rad(-142.437)),
							},
						},
						["Right Arm"] = {
							CFrame = CFrame.new(0.3, 0, 0) * CFrame.Angles(math.rad(15.011), 0, math.rad(90.012)),
						},
					},
				},
			},
			[0.267] = {
				["HumanoidRootPart"] = {
					["Torso"] = {
						CFrame = CFrame.Angles(math.rad(15.011), 0, 0),
						["Left Leg"] = {
							CFrame = CFrame.new(-0.29, 0.078, 0) * CFrame.Angles(math.rad(3.953), math.rad(14.496), math.rad(-15.527)),
						},
						["Right Leg"] = {
							CFrame = CFrame.new(0.3, 0, 0) * CFrame.Angles(math.rad(-3.953), math.rad(-14.496), math.rad(-15.527)),
						},
						["Head"] = {
							CFrame = CFrame.Angles(math.rad(-15.011), 0, 0),
						},
						["Left Arm"] = {
							CFrame = CFrame.new(-0.308, 0.183, 0.014) * CFrame.Angles(math.rad(16.96), math.rad(-8.938), math.rad(-82.907)),
							["Broom"] = {
								CFrame = CFrame.new(-0.76, 0.062, -0.432) * CFrame.Angles(math.rad(-154.469), math.rad(-72.536), math.rad(-142.437)),
							},
						},
						["Right Arm"] = {
							CFrame = CFrame.new(0.3, 0, 0) * CFrame.Angles(math.rad(15.011), 0, math.rad(90.012)),
						},
					},
				},
			},
			[0.467] = {
				["HumanoidRootPart"] = {
					["Torso"] = {
						CFrame = CFrame.Angles(math.rad(-15.011), 0, 0),
						["Left Leg"] = {
							CFrame = CFrame.new(-0.29, 0.078, 0) * CFrame.Angles(math.rad(3.953), math.rad(14.496), math.rad(-0.516)),
						},
						["Right Leg"] = {
							CFrame = CFrame.new(-0.161, 0.01, 0.087) * CFrame.Angles(math.rad(-3.953), math.rad(-14.496), math.rad(-45.493)),
						},
						["Head"] = {
						},
						["Left Arm"] = {
							CFrame = CFrame.new(0.186, 0.152, 0.086) * CFrame.Angles(math.rad(16.96), math.rad(-8.938), math.rad(142.094)),
						},
						["Right Arm"] = {
							CFrame = CFrame.new(-0.083, 0.321, 0.006) * CFrame.Angles(math.rad(18.965), math.rad(-14.496), math.rad(-164.496)),
						},
					},
				},
			},
		}
	},
}

local unbuiltanims = {
	["Special"] = {
		{
			tm = .1;
			["Torso"] = {
				cf = CFrame.new(0,0,0,.94,.342,0,-.342,.94,0,0,0,1);
				es = "Linear";
				ed = "In";
			};
			["Left Leg"] = {
				cf = CFrame.new(0,0,0,.985,0,.174,0,1,0,-.174,0,.985);
				es = "Linear";
				ed = "In";
			};
			["Right Leg"] = {
				cf = CFrame.new(0,0,0,.996,0,-.087,0,1,0,.087,0,.996);
				es = "Linear";
				ed = "In";
			};
			["Left Arm"] = {
				cf = CFrame.new(0,0,0,-.03,.94,.341,-.996,0,-.087,-.082,-.342,.936);
				es = "Linear";
				ed = "In";
			};
			["Head"] = {
				cf = CFrame.new(0,0,0,.906,-.423,0,.423,.906,0,0,0,1);
				es = "Linear";
				ed = "In";
			};
			["Right Arm"] = {
				cf = CFrame.new(0,0,0,.985,.03,-.171,0,.985,.174,.174,-.171,.97);
				es = "Linear";
				ed = "In";
			};
		};
	},
	["SpecialCharge"] = {
		{
			tm = 0.1;
			["Left Leg"] = {
				cf = CFrame.new(0,0,0,.966,0,.259,0,1,0,-.259,0,.966);
				es = "Linear";
				ed = "In";
			};
			["Right Leg"] = {
				cf = CFrame.new(0,0,0,.985,0,-.174,0,1,0,.174,0,.985);
				es = "Linear";
				ed = "In";
			};
			["Right Arm"] = {
				cf = CFrame.new(.231,-.178,-.073,-.769,-.425,.478,.592,-.756,.28,.242,.498,.832);
				es = "Linear";
				ed = "In";
			};
			["Left Arm"] = {
				cf = CFrame.new(-.361,-.094,-.075,-.819,.497,-.287,-.574,-.709,.41,0,.5,.866);
				es = "Linear";
				ed = "In";
			};
		};
	}
}

for i, v in next, unbuiltanims do
	local newanim = {
		Keyframes = {

		}
	}
	for i, v in next, v do
		local built = {
			["HumanoidRootPart"] = {
				["Torso"] = {
					["CFrame"] = v.Torso and v.Torso.cf or CFrame.identity
				}
			}
		}
		for i, v in next, v do
			if(i == "Left Leg" or i == "Right Leg" or i == "Left Arm" or i == "Right Arm" or i == "Head")then
				built.HumanoidRootPart.Torso[i] = {}
				built.HumanoidRootPart.Torso[i]["CFrame"] = v.cf
			end
		end
		newanim.Keyframes[v.tm] = built
	end
	animations[i] = newanim
end

local char = nil
local hum = nil
local anims = {}
local welds = {}
local origc0s = {}
local tweens = {}

local function stopAnims(animate)
	for i,v in next, anims do
		pcall(function()
			task.cancel(v)
		end)
	end
	task.wait()
	anims = {}
	for i,v in next, tweens do
		pcall(function()
			v:Cancel()
		end)
	end 
	tweens = {}
	for i,v in next, origc0s do
		welds[i].C0 = v
	end
	if(animate)then
		animate.Disabled = false
	end
end

local function setC0s(tbl, time)
	local function recurse(v)
		for i,v in next, v do
			if(welds[i])then
				pcall(function()
					local tw = game:GetService('TweenService'):Create(welds[i],TweenInfo.new(time),{
						C0 = origc0s[i]*v.CFrame
					})
					tw:Play()
					table.insert(tweens,tw)
				end)
			end
			pcall(recurse,v)
		end
	end
	pcall(recurse,tbl)
end

local function AnimationPlay(anim, dontstop)
	local animation = animations[anim]
	if(not animation)then return end

	local animate = char:FindFirstChild("Animate")
	local lastt = 0

	task.spawn(function()
		if(hum.RigType == Enum.HumanoidRigType.R6)then
			stopAnims(animate)
			if(animate)then
				animate.Disabled = true
			end
			NLS([[for i, v in next, game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Animator:GetPlayingAnimationTracks() do v:Stop() end]], owner.PlayerGui)

			table.clear(welds)
			table.clear(origc0s)
			for i,v in next, char:GetDescendants() do
				if(v:IsA("JointInstance") and not v:FindFirstAncestorOfClass("Accessory"))then
					welds[v.Part1 and v.Part1.Name or ""] = v
				end
			end

			for i,v in next, welds do
				origc0s[i] = v.C0
			end

			local lastkeyframe = 0
			for i,v in next, animation.Keyframes do
				if(i>lastkeyframe)then
					lastkeyframe = i
				end
			end
			local thread = task.delay(lastkeyframe+1, function()
				if(not dontstop)then
					stopAnims(animate)
				end
			end)
			table.insert(anims, thread)

			for i,v in next, animation.Keyframes do
				local thread 
				thread = task.delay(i,function()
					local time = i-lastt
					setC0s(v,time)
					lastt = i
				end)
				table.insert(anims,thread)
			end
		end
	end)
end

function clone(inst)
	inst.Archivable = true
	for _, v in next, inst:GetDescendants() do
		v.Archivable = true
	end
	return inst:Clone()
end

local rnd = Random.new(tick())
local counterdeb = 0
local connections = {}
local joints = {}
local limbs = {}
local oldcframes = CFRAMES
local orighp = 0
local numofdesc = 0
local cbackup = clone(owner.Character)

function relocate()
	local spawns = {}
	for _, v in next, workspace:GetDescendants() do
		if v:IsA("SpawnLocation") then
			table.insert(spawns, v)
		end
	end
	return #spawns > 0 and spawns[math.random(1, #spawns)].CFrame + (Vector3.yAxis * 5) or CFrame.new(0, 100, 0)
end

function newpart(size, cf)
	local a = Instance.new("Part")
	a.Anchored = true
	a.CanCollide = false
	a.Size = size
	a.CFrame = cf
	return a
end

local renderstepped = game:GetService("RunService").Heartbeat

-- Effects request sender
local EFFECTSCONTAINER = Instance.new("Folder", workspace.Terrain)
local EFFECTS = {} -- [EffectName] = Function
function EFFECT(EffectName, ...)
	if(not EFFECTSCONTAINER or EFFECTSCONTAINER.Parent ~= workspace.Terrain)then
		EFFECTSCONTAINER = Instance.new("Folder", workspace.Terrain)
	end
	task.spawn(EFFECTS[EffectName], ...)
end

local function AttackFilter()
	local filter = {workspace:FindFirstChild("Base"), workspace:FindFirstChild("Baseplate")}
	for i, v in next, {char, EFFECTSCONTAINER} do
		for _, o in next, v:GetDescendants() do
			table.insert(filter, o)
		end
		table.insert(filter, v)
	end
	return filter
end

function CreateEmptyPart(size, cf)
	return CSE:CreatePart({
		Anchored = true,
		CanCollide = false,
		Transparency = 1,
		Size = size,
		CFrame = cf,

		CanTouch = false,
		CanQuery = false,

	})
end

function CreateSoundAtPos(soundname, pos, props)
	local soundpart = CreateEmptyPart(Vector3.zero, CFrame.new(pos))
	soundpart.Parent = EFFECTSCONTAINER

	local props = props or {}
	props.Parent = soundpart
	local sound = CSE:CreateSound(soundname, props)
	sound.Ended:Connect(function()
		soundpart:Destroy()
	end)
	task.delay(0.2, function()
		DebrisAdd(soundpart, math.max(10, sound.TimeLength))
	end)

	return soundpart, sound
end

function FixWrap(str)
	return string.gsub(str, " ", "⠀")
end

local EWait = task.wait

local EmittingParticles = {}
function EmitParticle(Particle, Duration)
	task.spawn(function()
		local Rate = Particle.Rate
		local Duration = Duration or 9e9
		local Amount = Rate/60
		local AmountFloor = math.floor(Amount)
		local Remainder = Amount-AmountFloor
		local RCount = 0
		local CurrentAmount = 0
		local Time = os.clock()
		EmittingParticles[Particle] = true
		while os.clock()-Time <= Duration and EmittingParticles[Particle] == true and Particle.Parent ~= nil do
			local NewRC = RCount + Remainder
			local Add = math.floor(NewRC)
			RCount = NewRC - Add

			local Combined = CurrentAmount + AmountFloor + Add
			local FINAL = math.floor(Combined)
			CurrentAmount = Combined - FINAL
			Particle:Emit(FINAL)
			EWait()
		end
		EmittingParticles[Particle] = nil
	end)
end

function EmitParticleStop(Particle)
	EmittingParticles[Particle] = nil
end

function VOCAL(SoundName)
	local soundpart, sound = CreateSoundAtPos(SoundName, CFRAMES.CHARACTER.Character.Position)

	local cfloop = game:GetService("RunService").Heartbeat:Connect(function()
		soundpart.CFrame = CFRAMES.CHARACTER.Character
	end)
	sound.Ended:Connect(function()
		cfloop:Disconnect()
	end)
end

function EWait(num) -- not be affected by fps
	local num = num or 0
	local t = os.clock()
	repeat
		heartbeat:Wait()
	until os.clock() - t >= num
end

local CHARACTERSCALE = .5


local Bezier = (function()
	-- Bezier
	-- Crazyman32
	-- April 1, 2015

	-- Modified January 28, 2016
	-- Optimized for Quadratic and Cubic cases
	-- Clarified documentation for GetPath()

	-- Modified December 5, 2017
	-- Added method 'GetLength()'
	-- Added method 'GetPathBySegmentLength()'
	-- Added method 'GetPathByNumberSegments()'

--[[

METHODS:

	b = Bezier.new(thisModule)
	
	Vector3          b:Get(ratio)
	Array<Vector3>   b:GetPath(step)
	Array<Vector3>   b:GetPathBySegmentLength(segmentLength)
	Array<Vector3>   b:GetPathByNumberSegments(numSegments)
	Number           b:GetLength([step])
	Array<Vector3>   b:GetPoints()

-------------------------------------------------------------------------------------------


EXAMPLES AND DOCUMENTATION:

-------------------------------------------------------------------------------------------

local Bezier = require(thisModule)

local b = Bezier.new(Vector3 pointA, Vector3 pointB, Vector3 pointC, ...)
	> Create a new bezier object
	> Must input at least 3 Vector3 points, or else it will throw an error
	
	> TIP: Do not create multiple objects with the same order and set of
	       points. Doing so would be pointless. Reuse the object when you can.
	
	> If 3 points are given, the module is optimized automatically for the quadratic case
	> If 4 points are given, the module is optimized automatically for the cubic case

-------------------------------------------------------------------------------------------

b:Get(ratio)
	> Get a Vector3 position on the curve with the given ratio
	> Ratio should be between 0 and 1
		> 0 = Starting point
		> 1 = Ending point
		> 0.5 = 50% along the path
		> 0.2 = 20% along the path
		> etc.

local positionStart = b:Get(0)
local positionMid   = b:Get(0.5)
local positionEnd   = b:Get(1)

-------------------------------------------------------------------------------------------

b:GetPathBySegmentLength(segmentLength)
	> Create a path along the curve, where the segments are roughly 'segmentLength' long
	> Returns a table of Vector3 positions

-------------------------------------------------------------------------------------------

b:GetPathByNumberSegments(numSegments)
	> Creates a path along the curve with 'numSegment' segments
	> Returns a table of Vector3 positions

-------------------------------------------------------------------------------------------

b:GetPath(step)
	> Create path along curve (returns table of Vector3 positions)
	> 'step' is the ratio step and should be within the range of (0, 1)

local path1 = b:GetPath(0.1) -- Higher resolution path
local path2 = b:GetPath(0.5) -- Lower resolution path

-------------------------------------------------------------------------------------------

b:GetLength([step])
	> Returns the length of a given path based on the step
	> 'step' is the ratio step and should be within the range of (0, 1). It defaults to 0.1
	> This is the same as calling 'b:GetPath(step)' and then summing up the distances
	  between each point. It is a rough approximation.

local length = b:GetLength()

-------------------------------------------------------------------------------------------

b:GetPoints()
	> Get the original control points that were inputted when object was created
	> Returns a table of Vector3 points

--]]





	-- NOTE: This was designed for higher-order bezier curves. However,
	--	has been optimized for quadratic and cubic cases. Curves of
	--	any degree can be calculated, but are not optimized above the
	--	cubic case.

	-- More info on Bezier Curves:
	-- http://en.wikipedia.org/wiki/Bezier_curve
	-- http://en.wikipedia.org/wiki/De_Casteljau%27s_algorithm

	-- I recommend reading the Properties section for the first Wiki link


	-- This Bezier module was originally designed for my Bezier Path Plugin:
	-- http://www.roblox.com/item.aspx?id=232918839



	local Bezier = {}
	Bezier.__index = Bezier


	function Bezier.new(...)

		local points = {...}
		assert(#points >= 3, "Must have at least 3 points")

		local isQuadratic = (#points == 3)
		local isCubic = (#points == 4)

		local bezier = {}

		local V3 = Vector3.new
		local lerpV3 = V3().lerp

		local length = nil

		local lines = {}
		local numLines = 0
		local finalLine = nil
		-- Line index key:
		-- [1] = First point
		-- [2] = Second point
		-- [3] = Current Midpoint


		-- Create mutable pseudo-Vector3 points:
		local function CreatePoint(v3)
			--local point = {X = v3.X; Y = v3.Y; Z = v3.Z}
			local point = {v3.X, v3.Y, v3.Z}
			function point:ToVector3()
				return V3(self[1], self[2], self[3])
			end
			function point:lerp(other, ratio)
				return lerpV3(self:ToVector3(), other:ToVector3(), ratio)
			end
			return point
		end


		-- Initialize lines:
		if (not isQuadratic and not isCubic) then

			-- Initialize first lines:
			for i = 1,#points-1 do
				local p1 = CreatePoint(points[i])
				local p2 = CreatePoint(points[i + 1])
				local line = {p1, p2, CreatePoint(p1)}
				lines[#lines + 1] = line
			end

			local relativeLines = lines

			-- Initialize rest of lines:
			for n = #lines,2,-1 do
				local newLines = {}
				for i = 1,n-1 do
					local l1, l2 = relativeLines[i], relativeLines[i + 1]
					local line = {l1[3], l2[3], CreatePoint(l1[3])}
					newLines[i] = line
					lines[#lines + 1] = line
				end
				relativeLines = newLines
			end

			finalLine = relativeLines[1]

			numLines = #lines

		end


		-- Get a point on the curve with the given ratio:
		if (isQuadratic) then

			local p0, p1, p2 = points[1], points[2], points[3]

			-- Quadratic solution:
			function bezier:Get(r, clampRatio)
				if (clampRatio) then
					r = (r < 0 and 0 or r > 1 and 1 or r)
				end
				return (1-r)*(1-r)*p0+2*(1-r)*r*p1+r*r*p2
			end

		elseif (isCubic) then

			local p0, p1, p2, p3 = points[1], points[2], points[3], points[4]

			-- Cubic solution:
			function bezier:Get(r, clampRatio)
				if (clampRatio) then
					r = (r < 0 and 0 or r > 1 and 1 or r)
				end
				return (1-r)*(1-r)*(1-r)*p0+3*(1-r)*(1-r)*r*p1+3*(1-r)*r*r*p2+r*r*r*p3
			end

		else

			function bezier:Get(ratio, clampRatio)
				if (clampRatio) then
					ratio = (ratio < 0 and 0 or ratio > 1 and 1 or ratio)
				end
				-- Any degree solution:
				for i = 1,numLines do
					local line = lines[i]
					local mid = line[1]:lerp(line[2], ratio)
					local pt = line[3]
					pt[1], pt[2], pt[3] = mid.X, mid.Y, mid.Z
				end
				return finalLine[3]:ToVector3()
			end

		end


		-- Approximated length:
		function bezier:GetLength(step)
			if (not length) then
				local path = self:GetPath(step or 0.1)
				local l = 0
				for i = 2,#path do
					local dist = (path[i - 1] - path[i]).Magnitude
					l = (l + dist)
				end
				length = l
			end
			return length
		end


		-- Get a path of the curve with the given step:
		-- Returns a table of Vector3 points
		function bezier:GetPath(step)
			assert(type(step) == "number", "Must provide a step increment")
			-- Check step domain is within interval (0.0, 1.0):
			assert(step > 0 and step < 1, "Step out of domain; should be between 0 and 1 (exclusive)")
			local path = {}
			local lastI = 0
			for i = 0,1,step do
				lastI = i
				path[#path + 1] = self:Get(i)
			end
			-- In case 'step' didn't fill path fully, properly handle last remaining point:
			if (lastI < 1) then
				local overrideLast = ((1 - lastI) < (step * 0.5))
				path[#path + (overrideLast and 0 or 1)] = self:Get(1)
			end
			return path
		end


		function bezier:GetPathByNumberSegments(numSegments)
			assert(type(numSegments) == "number", "Must provide number of segments")
			assert(numSegments > 0, "Number of segments must be greater than 0")
			return self:GetPath(1 / numSegments)
		end


		function bezier:GetPathBySegmentLength(segmentLength)
			assert(type(segmentLength) == "number", "Must provide a segment length")
			assert(segmentLength > 0, "Segment length must be greater than 0")
			local length = self:GetLength()
			local numSegments = length / segmentLength
			return self:GetPathByNumberSegments(math.floor(numSegments + 0.5))
		end


		-- Get the control points (the original Vector3 arguments passed to create the object)
		function bezier:GetPoints()
			return points
		end


		return setmetatable(bezier, Bezier)

	end



	return Bezier
end)()

local CHAT_Last
function CHAT(text)
	pcall(function()
		CHAT_Last:Destroy()
	end)

	local uipart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Character)
	local UI = CSE:CreateEffectInst("CHAT")
	local frame = UI.Frame
	local label = frame.ChatText

	local UISize = UI.Size
	local UIStudsOffset = UI.StudsOffset
	UI.Size = UDim2.new(
		UISize.X.Scale * CHARACTERSCALE, 
		UISize.X.Offset * CHARACTERSCALE, 
		UISize.Y.Scale * CHARACTERSCALE, 
		UISize.Y.Offset * CHARACTERSCALE)
	UI.StudsOffset = UIStudsOffset * CHARACTERSCALE


	label.Text = text
	label.MaxVisibleGraphemes = 0
	UI.Parent = uipart
	uipart.Parent = EFFECTSCONTAINER
	CHAT_Last = uipart

	local setprops = game:GetService("RunService").Heartbeat:Connect(function()
		uipart.CFrame = CFRAMES.CHARACTER.Character

		UI.Size = UDim2.new(
			UISize.X.Scale * CHARACTERSCALE, 
			UISize.X.Offset * CHARACTERSCALE, 
			UISize.Y.Scale * CHARACTERSCALE, 
			UISize.Y.Offset * CHARACTERSCALE)
		UI.StudsOffset = UIStudsOffset * CHARACTERSCALE
	end)

	local l = 0
	for _ in utf8.graphemes(text) do
		if CHAT_Last ~= uipart then break end
		l = l + 1
		label.MaxVisibleGraphemes = l
		EWait(0.05)
	end

	task.delay(1.5, function()
		setprops:Disconnect()
	end)
	DebrisAdd(uipart, 1.5)
end


EFFECTS.VOCAL = VOCAL
EFFECTS.CHAT = CHAT


-- Broom Slash
EFFECTS.BROOM_Slash = function(Duration, BroomSize)
	local hitpart = CreateEmptyPart(BroomSize, CFRAMES.OBJECTS.Broom)

	local a0 = Instance.new("Attachment")
	local a1 = Instance.new("Attachment")
	a0.Position = Vector3.new(0, 0, BroomSize.Z/2)
	a1.Position = Vector3.new(0, 0, -BroomSize.Z/2)

	local slash = CSE:CreateEffectInst("BROOM", "Trails", "BroomSlash")
	local slash2 = CSE:CreateEffectInst("BROOM", "Trails", "BroomSlash2")

	slash.Enabled = true
	slash2.Enabled = true
	slash.Attachment0 = a0
	slash2.Attachment0 = a0
	slash.Attachment1 = a1
	slash2.Attachment1 = a1

	a0.Parent = hitpart
	a1.Parent = hitpart
	slash.Parent = hitpart
	slash2.Parent = hitpart

	hitpart.Parent = EFFECTSCONTAINER
	local cfloop = renderstepped:Connect(function()
		hitpart.CFrame = CFRAMES.OBJECTS.Broom
	end)

	task.delay(Duration, function()
		slash.Enabled = false
		slash2.Enabled = false
		task.delay(slash.Lifetime, function()
			cfloop:Disconnect()
		end)
		DebrisAdd(hitpart, slash.Lifetime)
	end)
end

local BROOM_Sparkles
EFFECTS.BROOM_Sparkles = function(State, BroomSize)
	local Data = BROOM_Sparkles
	pcall(function()
		EmitParticleStop(Data.Particle)
		Data.Loop:Disconnect()
		DebrisAdd(Data.Part, Data.Particle.Lifetime.Max)
	end)

	if State == true then
		BROOM_Sparkles = {}

		local hitpart = CreateEmptyPart(BroomSize, CFRAMES.OBJECTS.Broom)
		local particle = CSE:CreateEffectInst("BROOM", "Particles", "FlySparkles")
		particle.Parent = hitpart
		hitpart.Parent = EFFECTSCONTAINER
		EmitParticle(particle)
		local cfloop = renderstepped:Connect(function()
			hitpart.CFrame = CFRAMES.OBJECTS.Broom
		end)

		BROOM_Sparkles.Part = hitpart
		BROOM_Sparkles.Particle = particle
		BROOM_Sparkles.Loop = cfloop
	end
end


EFFECTS.YUREI_Level = function(LEVEL)
	local currentcf = CFRAMES.CHARACTER.Character

	-- Particle
	local exppart = CreateEmptyPart(Vector3.zero, currentcf)
	local particle = CSE:CreateEffectInst("YUREI", "Particles", tostring(LEVEL))
	particle.Parent = exppart
	exppart.Parent = EFFECTSCONTAINER
	coroutine.wrap(function()
		for i = 1, LEVEL do
			particle:Emit(1)
			EWait(0.075)
		end
		DebrisAdd(exppart, particle.Lifetime.Max)
	end)()


	-- UI
	local uipart = CreateEmptyPart(Vector3.zero, currentcf)
	local UI = CSE:CreateEffectInst("YUREI", "UI", "YureiDisplay")
	local frame = UI.Frame
	local leveltext = frame.Level
	local nametext = frame.LevelName

	local LEVELNAME
	local color
	if LEVEL == 1 then
		LEVELNAME = "たんじょう"
		color = Color3.new()
	elseif LEVEL == 2 then
		LEVELNAME = "せいかつ"
		color = Color3.new(1, 1, 1)
	elseif LEVEL == 3 then
		LEVELNAME = "亡くなる"
		color = Color3.fromRGB(85, 85, 127)
	elseif LEVEL == 4 then
		LEVELNAME = "ゆうれい"
		color = Color3.fromRGB(47, 55, 127)
	end

	leveltext.Text = LEVEL
	nametext.Text = LEVELNAME
	leveltext.TextColor3 = color
	nametext.TextColor3 = color

	UI.Parent = uipart
	uipart.Parent = EFFECTSCONTAINER

	CSE:TweenInst(leveltext, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
			}
		}
	})
	CSE:TweenInst(nametext, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
			}
		}
	})

	local setcf = renderstepped:Connect(function()
		local cf = CFRAMES.CHARACTER.Character
		exppart.CFrame = cf
		uipart.CFrame = cf
	end)
	task.delay(0.5, function()
		setcf:Disconnect()
	end)

	CSE:CreateSound("YUREI"..LEVEL, {Parent = uipart})
	DebrisAdd(uipart, 3)
end


EFFECTS.YUREI_WorldModelEnabled = function(WMENABLED)
	local currentcf = CFRAMES.CHARACTER.Character

	-- Particle
	local exppart = CreateEmptyPart(Vector3.zero, currentcf)
	local particle
	if WMENABLED == true then
		particle = CSE:CreateEffectInst("YUREI", "Particles", "WM1")
	else
		particle = CSE:CreateEffectInst("YUREI", "Particles", "WM0")
	end
	particle.Parent = exppart
	exppart.Parent = EFFECTSCONTAINER
	particle:Emit(1)
	DebrisAdd(exppart, particle.Lifetime.Max)


	-- UI
	local uipart = CreateEmptyPart(Vector3.zero, currentcf)
	local UI = CSE:CreateEffectInst("YUREI", "UI", "WMDisplay")
	local frame = UI.Frame
	local wmtext = frame.WMText



	local WMNAME
	local img
	local color
	local sfx
	if WMENABLED == true then
		WMNAME = "ROOT_alt"
		img = frame["1"]
		color = Color3.new(0, 1, 0.5)
		sfx = "YUREION"
	else
		WMNAME = "ROOT_space"
		img = frame["0"]
		color = Color3.new(0, 0.5, 1)
		sfx = "YUREIOFF"
	end

	wmtext.Text = WMNAME
	wmtext.TextColor3 = color
	img.ImageColor3 = color
	img.Visible = true

	UI.Parent = uipart
	uipart.Parent = EFFECTSCONTAINER

	CSE:TweenInst(wmtext, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
			}
		}
	})
	CSE:TweenInst(img, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				ImageTransparency = 1,
			}
		}
	})

	local setcf = renderstepped:Connect(function()
		local cf = CFRAMES.CHARACTER.Character
		exppart.CFrame = cf
		uipart.CFrame = cf
	end)
	task.delay(0.5, function()
		setcf:Disconnect()
	end)

	CSE:CreateSound(sfx, {Parent = uipart})
	DebrisAdd(uipart, 3)
end


EFFECTS.YUREI_FailsafeEnabled = function(FSENABLED)
	local currentcf = CFRAMES.CHARACTER.Character

	-- Particle
	local exppart = CreateEmptyPart(Vector3.zero, currentcf)
	local particle
	if FSENABLED == true then
		particle = CSE:CreateEffectInst("YUREI", "Particles", "FS1")
	else
		particle = CSE:CreateEffectInst("YUREI", "Particles", "FS0")
	end
	particle.Parent = exppart
	exppart.Parent = EFFECTSCONTAINER
	particle:Emit(1)
	DebrisAdd(exppart, particle.Lifetime.Max)


	-- UI
	local uipart = CreateEmptyPart(Vector3.zero, currentcf)
	local UI = CSE:CreateEffectInst("YUREI", "UI", "FSDisplay")
	local frame = UI.Frame
	local fstext = frame.FSText



	local FSNAME
	local img
	local color
	local sfx
	if FSENABLED == true then
		FSNAME = "FS_1"
		img = frame["1"]
		color = Color3.new(1, 1, 0)
		sfx = "YUREION"
	else
		FSNAME = "FS_0"
		img = frame["0"]
		color = Color3.new(1, 0.5, 0)
		sfx = "YUREIOFF"
	end

	fstext.Text = FSNAME
	fstext.TextColor3 = color
	img.ImageColor3 = color
	img.Visible = true

	UI.Parent = uipart
	uipart.Parent = EFFECTSCONTAINER

	CSE:TweenInst(fstext, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
			}
		}
	})
	CSE:TweenInst(img, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				ImageTransparency = 1,
			}
		}
	})

	local setcf = renderstepped:Connect(function()
		local cf = CFRAMES.CHARACTER.Character
		exppart.CFrame = cf
		uipart.CFrame = cf
	end)
	task.delay(0.5, function()
		setcf:Disconnect()
	end)

	CSE:CreateSound(sfx, {Parent = uipart})
	DebrisAdd(uipart, 3)
end


local ABSORBER_Pos
local ABSORBER_EffectPart
local ABSORBER_Particles = {}

EFFECTS.ABSORBER = function(Pos)
	ABSORBER_Pos = Pos
	ABSORBER_Particles = {}

	local currentcf = CFRAMES.CHARACTER.Character

	-- Special charge first
	local chargepart = CreateEmptyPart(Vector3.zero, currentcf)
	local chargeparticle = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialRing")
	chargeparticle.Parent = chargepart
	chargepart.Parent = EFFECTSCONTAINER
	chargeparticle:Emit(15)
	DebrisAdd(chargepart, chargeparticle.Lifetime.Max)
	CreateSoundAtPos("38", currentcf.Position)
	VOCAL("18")

	ABSORBER_EffectPart = CreateEmptyPart(Vector3.zero, CFrame.new(Pos))
	ABSORBER_EffectPart.Parent = EFFECTSCONTAINER

	-- Release
	for i, particle in CSE:GetEffectInst("ABSORBER", "Particles", "Release"):GetChildren() do
		local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Release", particle.Name)
		particle.Parent = ABSORBER_EffectPart
		EmitParticle(particle, 0.75)
	end
	CreateSoundAtPos("22", Pos)

	EWait(1)

	-- Main
	local constantparticles = {
		"Ball", "BallRing1", "BallRing2",
		"Ring1", "Ring2",
		"SmokeBlack", "SmokeWhite",
		"Star1"
	}
	for i, pname in constantparticles do
		local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Main", pname)
		table.insert(ABSORBER_Particles, particle)
		particle.Parent = ABSORBER_EffectPart
		EmitParticle(particle)
	end
	task.delay(0.25, function()
		local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Main", "Star2")
		table.insert(ABSORBER_Particles, particle)
		particle.Parent = ABSORBER_EffectPart
		EmitParticle(particle)
	end)

	EWait(5)
end

EFFECTS.ABSORBER_Absorb = function(Parts)
	for i, part in Parts do
		coroutine.wrap(function()
			pcall(function()
				local pos = part.Position

				-- Create bezier curve
				local Positions = {}
				local inc = 1/(rnd:NextInteger(3, 5))
				for i = 0+inc, 1-inc, inc do
					local Offset = Vector3.new(rnd:NextNumber(-5, 5), rnd:NextNumber(-5, 5), rnd:NextNumber(-5, 5))
					table.insert(Positions, pos:Lerp(ABSORBER_Pos, i) + Offset)
				end
				table.insert(Positions, 1, pos)
				table.insert(Positions, ABSORBER_Pos)


				local bez = Bezier.new(unpack(Positions))
				local look = ABSORBER_Pos-pos

				-- Main
				local trailpart = CreateEmptyPart(Vector3.zero, CFrame.new(pos, ABSORBER_Pos))
				local trail = CSE:CreateEffectInst("ABSORBER", "Trails", "AbsorbTrail")
				local a0 = Instance.new("Attachment")
				local a1 = Instance.new("Attachment")

				a0.Position = Vector3.new(0, -5, 0)
				a1.Position = Vector3.new(0, 5, 0)
				trail.Attachment0 = a0
				trail.Attachment1 = a1

				a0.Parent = trailpart
				a1.Parent = trailpart
				trail.Parent = trailpart
				trailpart.Parent = EFFECTSCONTAINER
				local inc = 1/(rnd:NextInteger(2, 4) * 10)
				for i = 0, 1, inc do
					local newpos = bez:Get(i)
					local newcf
					if newpos == ABSORBER_Pos then -- prevent cframe from going NaN
						newcf = CFrame.new(newpos, newpos + look)
					else
						newcf = CFrame.new(newpos, ABSORBER_Pos)
					end
					trailpart.CFrame = newcf
					EWait()
				end
				DebrisAdd(trailpart, 1)
			end)
		end)()
	end
end

EFFECTS.ABSORBER_Update = function(AttackLevel, LevelName, MethodName)
	local currentcf = CFRAMES.CHARACTER.Character

	-- Special charge first
	local chargepart = CreateEmptyPart(Vector3.zero, currentcf)
	local chargeparticle = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialRing")
	chargeparticle.Parent = chargepart
	chargepart.Parent = EFFECTSCONTAINER
	chargeparticle:Emit(15)
	DebrisAdd(chargepart, chargeparticle.Lifetime.Max)
	CreateSoundAtPos("38", currentcf.Position)
	VOCAL("18")

	-- Upgrade
	local constantparticles = {
		"RedBG", "BlackBG", "Black", "BlackCenter", "White"
	}
	for i, pname in constantparticles do
		local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Upgrade", pname)
		particle.Parent = ABSORBER_EffectPart
		EmitParticle(particle, 1)
		DebrisAdd(particle, 1 + particle.Lifetime.Max)
	end
	local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Upgrade", "WhiteBall")
	particle.Parent = ABSORBER_EffectPart
	particle:Emit(1)
	DebrisAdd(particle, particle.Lifetime.Max)
	local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Upgrade", "Ring")
	particle.Parent = ABSORBER_EffectPart
	coroutine.wrap(function()
		for i = 1, 3 do
			particle:Emit(rnd:NextInteger(1, 4))
			EWait(0.1)
		end
		DebrisAdd(particle, particle.Lifetime.Max)
	end)()
	task.delay(1.75, function()
		local ringpart = CreateEmptyPart(Vector3.zero, CFrame.new(ABSORBER_Pos - Vector3.new(0, 10, 0)))
		local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Upgrade", "HorizontalRing")
		particle.Parent = ringpart
		ringpart.Parent = EFFECTSCONTAINER
		for i = 1, 2 do
			particle:Emit(1)
			EWait(0.15)
		end
		DebrisAdd(ringpart, particle.Lifetime.Max)
	end)

	-- spin effect
	local amt = rnd:NextInteger(5, 10)
	for i = 1, amt do
		local radius = rnd:NextNumber(30, 50)
		local cf = CFrame.new(ABSORBER_Pos) * CSF:RandomAngle()
		local trailpart = CreateEmptyPart(Vector3.zero, CFrame.new((cf * CFrame.new(0, 0, -radius)).Position, ABSORBER_Pos))
		local trail = CSE:CreateEffectInst("ABSORBER", "Trails", "AbsorbUpgradeSpin")
		local a0 = Instance.new("Attachment")
		local a1 = Instance.new("Attachment")

		a0.Position = Vector3.new(0, -3, 0)
		a1.Position = Vector3.new(0, 3, 0)
		trail.Attachment0 = a0
		trail.Attachment1 = a1

		a0.Parent = trailpart
		a1.Parent = trailpart
		trail.Parent = trailpart
		trailpart.Parent = EFFECTSCONTAINER

		coroutine.wrap(function()
			for i = 0, 360 * 3, 360/20 do
				trailpart.CFrame = CFrame.new((cf * CFrame.Angles(0, 0, math.rad(i * 0.5)) * CFrame.Angles(0, math.rad(i), 0) * CFrame.new(0, 0, -radius)).Position, ABSORBER_Pos)
				EWait()	
			end
			DebrisAdd(trailpart, trail.Lifetime)
		end)()
	end
	CreateSoundAtPos("22", ABSORBER_Pos)

	local labelpart = CreateEmptyPart(Vector3.zero, CFrame.new(ABSORBER_Pos))
	local UI = CSE:CreateEffectInst("ABSORBER", "UI", "AbsorberDisplay")
	local TextFrame = UI.Frame
	local LevelText = TextFrame.LevelText
	local MethodText = TextFrame.MethodText

	LevelText.Text = AttackLevel
	MethodText.Text = FixWrap("! "..MethodName.." !")

	UI.Parent = labelpart
	labelpart.Parent = EFFECTSCONTAINER

	-- Level
	coroutine.wrap(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0.13, 0.3))
			i = i + 1

			if i % 2 == 1 then -- Attack text
				LevelText.Text = AttackLevel
			else
				LevelText.Text = LevelName
			end
		end
	end)()

	-- Text
	coroutine.wrap(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0.13, 0.3))
			i = i + 1

			local showmethod = false
			if i % 2 == 1 then -- Attack text
				showmethod = true
			end

			LevelText.Visible = not showmethod
			MethodText.Visible = showmethod
		end
	end)()

	-- Flash
	coroutine.wrap(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0, 0.25))
			i = i + 1
			local t = i % 2
			LevelText.TextTransparency = t
			LevelText.TextStrokeTransparency = t
			MethodText.TextTransparency = t
			MethodText.TextStrokeTransparency = t
		end
	end)()
	DebrisAdd(labelpart, 1.5)

end
EFFECTS.ABSORBER_End = function(AttackLevel, AttackName)

	for i, particle in ABSORBER_Particles do
		EmitParticleStop(particle)
	end

	-- Release
	for i, particle in CSE:GetEffectInst("ABSORBER", "Particles", "Release"):GetChildren() do
		local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Release", particle.Name)
		particle.Parent = ABSORBER_EffectPart
		EmitParticle(particle, 0.75)
	end
	DebrisAdd(ABSORBER_EffectPart, 5)
end


EFFECTS.LASER_Charge = function()
	local currentcf = CFRAMES.CHARACTER.Character

	local chargepart = CreateEmptyPart(Vector3.zero, currentcf)
	local chargeparticle = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialRing")
	chargeparticle.Parent = chargepart
	chargepart.Parent = EFFECTSCONTAINER
	chargeparticle:Emit(15)
	DebrisAdd(chargepart, chargeparticle.Lifetime.Max)

	-- SFX
	CreateSoundAtPos("38", currentcf.Position)
	VOCAL("16")
end
EFFECTS.LASER_Release = function(HandPos, TargetPos)
	local currentcf = CFRAMES.CHARACTER.Character
	local Duration = 3.5

	local laserpart = CreateEmptyPart(Vector3.new(3, 3, 0), CFrame.new(HandPos, TargetPos))
	laserpart.Parent = EFFECTSCONTAINER

	local particles = {
		"LaserStartSmoke", "LaserStartTwirl", "LaserMain", "LaserMain2", "LaserDark",
		"LaserSmoke", "LaserTwirl1", "LaserTwirl2"
	}
	for i, pname in particles do
		local particle = CSE:CreateEffectInst("LASER", "Particles", pname)
		particle.Parent = laserpart
		EmitParticle(particle, Duration)
	end
	task.delay(Duration, function()
		DebrisAdd(laserpart, 3)
	end)

	CreateSoundAtPos("22", currentcf.Position)
	CreateSoundAtPos("39_SLOW1", currentcf.Position)
end


local STASIS_Pos, STASIS_Part, STASIS_Particles
EFFECTS.STASIS_Charge = function()
	local currentcf = CFRAMES.CHARACTER.Character

	local chargepart = CreateEmptyPart(Vector3.zero, currentcf)
	local chargeparticle = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialRing")
	chargeparticle.Parent = chargepart
	chargepart.Parent = EFFECTSCONTAINER
	chargeparticle:Emit(15)
	DebrisAdd(chargepart, chargeparticle.Lifetime.Max)

	-- SFX
	CreateSoundAtPos("38", currentcf.Position)
end
EFFECTS.STASIS_Release = function(Pos, Mode)
	pcall(function()
		local lifetime = 0
		pcall(function()
			for i, particle in STASIS_Particles do
				pcall(function()
					lifetime = math.max(lifetime, particle.Lifetime.Max)
					EmitParticleStop(particle)
				end)
			end
		end)
		DebrisAdd(STASIS_Part, lifetime)
	end)

	local exppart = CreateEmptyPart(Vector3.one * 0.5, CFrame.new(Pos))
	STASIS_Pos = Pos
	STASIS_Part = exppart
	STASIS_Particles = {}
	exppart.Parent = EFFECTSCONTAINER

	local particle = CSE:CreateEffectInst("STASIS", "BlackRing")
	table.insert(STASIS_Particles, particle)
	particle.Parent = exppart
	EmitParticle(particle)
	local particle = CSE:CreateEffectInst("STASIS", "BlackCharge")
	table.insert(STASIS_Particles, particle)
	particle.Parent = exppart
	EmitParticle(particle)

	local particle = CSE:CreateEffectInst("STASIS", tostring(Mode), "Ring")
	table.insert(STASIS_Particles, particle)
	particle.Parent = exppart
	EmitParticle(particle)

	local particle = CSE:CreateEffectInst("STASIS", tostring(Mode), "Charge")
	table.insert(STASIS_Particles, particle)
	particle.Parent = exppart
	EmitParticle(particle)


	local particle = CSE:CreateEffectInst("STASIS", "Switch")
	particle.Parent = STASIS_Part
	EmitParticle(particle, 0.2)
	DebrisAdd(particle, particle.Lifetime.Max + 0.2)

	CreateSoundAtPos("22", Pos)
	local soundpart = CreateSoundAtPos("47", Pos)

	repeat runs.Heartbeat:Wait() until exppart.Parent == nil or STASIS_Part ~= exppart
	soundpart:Destroy()
end
EFFECTS.STASIS_END = function()
	pcall(function()
		pcall(function()
			for i, particle in STASIS_Particles do
				pcall(function()
					EmitParticleStop(particle)
				end)
			end
		end)
	end)
	local particle = CSE:CreateEffectInst("STASIS", "Switch")
	particle.Parent = STASIS_Part
	EmitParticle(particle, 0.2)
	DebrisAdd(STASIS_Part, particle.Lifetime.Max + 0.2)


	local currentcf = CFRAMES.CHARACTER.Character
	CreateSoundAtPos("38", currentcf.Position)
end


EFFECTS.SPECIAL_Charge = function(IsRed, Duration)
	local currentcf = CFRAMES.CHARACTER.Character

	-- Special Ring
	local SRPart = CreateEmptyPart(Vector3.zero, currentcf)
	local SR
	if IsRed == false then
		SR = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialRing")
	else
		SR = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialRingRED")
	end
	SR.Parent = SRPart
	SRPart.Parent = EFFECTSCONTAINER
	EmitParticle(SR, Duration)
	DebrisAdd(SRPart, Duration + SR.Lifetime.Max)



	-- Special Charge
	local Outward = CreateEmptyPart(Vector3.new(0.5, 0.5, 0.5), currentcf)
	local Inward = CreateEmptyPart(Vector3.one * 20, currentcf)

	-- not enough particles!!
	local SC1_1, SC1_2, SC2_1, SC2_2
	if IsRed == false then

		SC1_1 = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialCharge")
		SC1_2 = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialCharge")
		SC2_1 = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialCharge2")
		SC2_2 = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialCharge2")

	else
		Inward.Size = Inward.Size * 2
		SC1_1 = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialChargeRED")
		SC1_2 = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialChargeRED")
		SC2_1 = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialCharge2RED")
		SC2_2 = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialCharge2RED")
	end

	SC1_1.Parent = Outward
	SC1_2.Parent = Outward
	SC2_1.Parent = Inward
	SC2_2.Parent = Inward

	local particles = {
		SC1_1, SC1_2, SC2_1, SC2_2
	}
	Outward.Parent = EFFECTSCONTAINER
	Inward.Parent = EFFECTSCONTAINER

	for i, particle in particles do
		EmitParticle(particle, Duration)
	end
	DebrisAdd(Outward, Duration + SC1_1.Lifetime.Max)
	DebrisAdd(Inward, Duration + SC2_1.Lifetime.Max)

	CreateSoundAtPos("48", currentcf.Position)
end

EFFECTS.SPECIAL_Release = function(IsRed, AttackName, MethodName, MethodName2)
	local currentcf = CFRAMES.CHARACTER.Character
	local endcf = currentcf * CFrame.new(0, 20, -10)

	local labelpart = CreateEmptyPart(Vector3.zero, currentcf * CFrame.new(0, 16, 10))
	local UI = CSE:CreateEffectInst("SPECIAL", "UI", "SpecialDisplay")
	local PortraitFrame = UI.Portrait
	local TextFrame = UI.Text
	local AttackText = TextFrame.AttackText
	local MethodText = TextFrame.MethodText
	local MethodText2 = TextFrame.MethodText2
	local FRAMES = {}
	for i, img in PortraitFrame:GetChildren() do
		img.ImageTransparency = 1
		FRAMES[img.Name] = img
	end

	AttackText.Text = FixWrap("? "..AttackName)
	AttackText.TextTransparency = 1
	AttackText.TextStrokeTransparency = 1
	MethodText.Text = FixWrap("! "..MethodName.." !")
	MethodText.TextTransparency = 1
	MethodText.TextStrokeTransparency = 1
	MethodText2.Text = MethodName2
	MethodText2.TextTransparency = 1
	MethodText2.TextStrokeTransparency = 1

	-- RED MODE
	-- For TextLabels
	local MethodColorSwitch1, MethodStrokeColorSwitch1, MethodColorSwitch2, MethodStrokeColorSwitch2
	if IsRed == false then
		AttackText.TextColor3 = Color3.new(1, 1, 1)
		AttackText.TextStrokeColor3 = Color3.fromRGB(128, 128, 128)
		MethodText.TextColor3 = Color3.new(0, 0, 0)
		MethodText.TextStrokeColor3 = Color3.new(1, 1, 1)

		MethodColorSwitch1 = Color3.new()
		MethodStrokeColorSwitch1 = Color3.new(1, 1, 1)
		MethodColorSwitch2 = Color3.fromRGB(210, 210, 210)
		MethodStrokeColorSwitch2 = Color3.fromRGB(70, 70, 70)
	else
		AttackText.TextColor3 = Color3.new(1, 0, 0)
		AttackText.TextStrokeColor3 = Color3.fromRGB(128, 0, 0)
		MethodText.TextColor3 = Color3.new(0, 0, 0)
		MethodText.TextStrokeColor3 = Color3.new(1, 0, 0)

		MethodColorSwitch1 = Color3.new(0, 0, 0)
		MethodStrokeColorSwitch1 = Color3.new(1, 0, 0)
		MethodColorSwitch2 = Color3.fromRGB(128, 0, 0)
		MethodStrokeColorSwitch2 = Color3.fromRGB(64, 0, 0)
	end
	MethodText2.TextColor3 = MethodColorSwitch1
	MethodText2.TextStrokeColor3 = MethodStrokeColorSwitch1

	-- For ImageLabels
	local ImageColor
	if IsRed == false then
		ImageColor = Color3.new(1, 1, 1)
	else
		ImageColor = Color3.fromRGB(128, 0, 0)
	end
	for i, img in FRAMES do
		if img.ImageColor3 == Color3.new(1, 1, 1) then
			img.ImageColor3 = ImageColor
		end
	end


	local UIScale
	local UIYOffset
	if IsRed == false then
		UIScale = 1
		UIYOffset = 0
	else
		UIScale = 2
		UIYOffset = 20
	end
	UI.Size = UDim2.new(150 * UIScale, 0, 150 * UIScale, 0)
	UI.StudsOffset = Vector3.new(15, 0, 2) * UIScale + Vector3.new(0, UIYOffset, 0)
	UI.Parent = labelpart
	labelpart.Parent = EFFECTSCONTAINER




	-- Gradual show
	CSE:TweenInst(labelpart, {
		{
			TweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			Properties = {
				CFrame = endcf
			}
		}
	})
	CSE:TweenInst(UI, {
		{
			TweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			Properties = {
				Size = UDim2.new(40 * UIScale, 0, 40 * UIScale, 0)
			}
		}
	})
	CSE:TweenInst(FRAMES["0"], {
		{
			TweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			Properties = {
				ImageTransparency = 0
			}
		}
	})

	EWait(0.4)
	CreateSoundAtPos("57", endcf.Position)

	-- TEXT
	AttackText.TextTransparency = 0
	AttackText.TextStrokeTransparency = 0
	MethodText.TextTransparency = 0
	MethodText.TextStrokeTransparency = 0
	MethodText2.TextTransparency = 0
	MethodText2.TextStrokeTransparency = 0

	-- For AttackText/MethodText
	coroutine.wrap(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0.13, 0.3))
			i = i + 1

			local showmethod = false
			if i % 2 == 1 then -- Attack text
				showmethod = true
			end

			AttackText.Visible = not showmethod
			MethodText.Visible = showmethod
		end
	end)()

	-- For MethodText2
	coroutine.wrap(function()
		local del = 0.35
		while labelpart.Parent ~= nil do
			CSE:TweenInst(MethodText2, {
				{
					TweenInfo = TweenInfo.new(del, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
					Properties = {
						TextColor3 = MethodColorSwitch2,
						TextStrokeColor3 = MethodStrokeColorSwitch2,
					}
				}
			})
			EWait(del)
			CSE:TweenInst(MethodText2, {
				{
					TweenInfo = TweenInfo.new(del, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
					Properties = {
						TextColor3 = MethodColorSwitch1,
						TextStrokeColor3 = MethodStrokeColorSwitch1,
					}
				}
			})
		end
	end)()
	-- Flash
	coroutine.wrap(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0, 0.25))
			i = i + 1
			local t = i % 2
			AttackText.TextTransparency = t
			AttackText.TextStrokeTransparency = t
			MethodText.TextTransparency = t
			MethodText.TextStrokeTransparency = t
		end
	end)()
	coroutine.wrap(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0, 0.25))
			i = i + 1
			local t = i % 2
			MethodText2.TextTransparency = t
			MethodText2.TextStrokeTransparency = t
		end
	end)()

	-- The frame switching part
	local LastTFrame = "3"
	local TFrames = {
		"3", "4", "5", "6", "7", "2", "8", "9", "10", "11", "12", "13", "14"
	}

	local FrameDuration = 0.075
	local FrameDelay = FrameDuration * 0.75
	local PortraitDelay = FrameDelay * (#TFrames+3) + FrameDuration

	-- Portrait
	coroutine.wrap(function()
		CSE:TweenInst(FRAMES["1"], {
			{
				TweenInfo = TweenInfo.new(PortraitDelay, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
				Properties = {
					ImageTransparency = 0
				}
			}
		})
		CSE:TweenInst(FRAMES["0"], {
			{
				TweenInfo = TweenInfo.new(PortraitDelay, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
				Properties = {
					ImageTransparency = 1
				}
			}
		})
		EWait(PortraitDelay + (FrameDuration * 1.25))
		CSE:TweenInst(FRAMES["1"], {
			{
				TweenInfo = TweenInfo.new(FrameDuration * 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
				Properties = {
					ImageColor3 = Color3.new()
				}
			}
		})
		for i, img in FRAMES do
			CSE:TweenInst(img, {
				{
					TweenInfo = TweenInfo.new(FrameDuration * 10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
					Properties = {
						ImageTransparency = 1
					}
				}
			})
		end
		DebrisAdd(labelpart, FrameDuration * 10)
	end)()
	task.delay(PortraitDelay, function()
		CreateSoundAtPos("54", endcf.Position)
	end)

	-- Tattoos
	coroutine.wrap(function()
		for i, frame in TFrames do
			CSE:TweenInst(FRAMES[frame], {
				{
					TweenInfo = TweenInfo.new(FrameDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
					Properties = {
						ImageTransparency = 0
					}
				}
			})
			EWait(FrameDelay)
			CSE:TweenInst(FRAMES[LastTFrame], {
				{
					TweenInfo = TweenInfo.new(FrameDuration*1.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
					Properties = {
						ImageTransparency = 1
					}
				}
			})
			LastTFrame = frame
		end
		CSE:TweenInst(FRAMES[LastTFrame], {
			{
				TweenInfo = TweenInfo.new(FrameDuration*1.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
				Properties = {
					ImageTransparency = 1
				}
			}
		})
	end)()
end


EFFECTS.DEADLYALERT = function()
	local Size = UDim2.new(11 * CHARACTERSCALE, 0, 11 * CHARACTERSCALE, 0)

	local uipart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Character)
	local UI = CSE:CreateEffectInst("TARGET", "DeadlyAlert", "DeadlyAlertDisplay")
	local frame = UI.Frame
	local img = frame.Alert
	UI.Size = UDim2.new(Size.X.Scale/3, 0, Size.Y.Scale/3, 0)
	UI.StudsOffset = Vector3.new(rnd:NextNumber(6, 7.5) * CSF:RandomSign(), rnd:NextNumber(6.5, 9), rnd:NextNumber(6, 7.5) * CSF:RandomSign()) * CHARACTERSCALE
	UI.Parent = uipart
	uipart.Parent = EFFECTSCONTAINER

	VOCAL("ERROR")
	local setcf = renderstepped:Connect(function()
		uipart.CFrame = CFRAMES.CHARACTER.Character
	end)
	CSE:TweenInst(UI, {
		{
			TweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
			Properties = {
				Size = Size
			}
		}
	})
	task.delay(1, function()
		CSE:TweenInst(img, {
			{
				TweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
				Properties = {
					ImageTransparency = 1
				}
			}
		})
	end)
	task.delay(1.35, function()
		setcf:Disconnect()
		uipart:Destroy()
	end)
end

-- Hit
EFFECTS.HIT = function(Pos, SFX)
	local cframe = CFrame.new(Pos)
	local hitpart = CreateEmptyPart(Vector3.zero, cframe)
	local hitparticle = CSE:CreateEffectInst("TARGET", "Hit", "Hit")
	hitparticle.Parent = hitpart
	hitpart.Parent = EFFECTSCONTAINER
	hitparticle:Emit(3)
	DebrisAdd(hitpart, hitparticle.Lifetime.Max)


	local randomsounds = {
		"23", "24", "25", "26", "27"
	}
	CreateSoundAtPos(CSF:PickRandomFromTable(randomsounds), cframe.Position)
end

EFFECTS.HIT2 = function(Size, CF)
	local hitpart = CreateEmptyPart(Vector3.one * 3.5 * Size.Magnitude, CF)
	local hitparticle = CSE:CreateEffectInst("TARGET", "Hit2", "Slash")
	local newseq = {}
	for i, Keypoint in hitparticle.Size.Keypoints do
		table.insert(newseq, NumberSequenceKeypoint.new(Keypoint.Time, Keypoint.Value * Size.Magnitude/4, Keypoint.Envelope))
	end
	hitparticle.Size = NumberSequence.new(newseq)
	hitparticle.Parent = hitpart
	hitpart.Parent = EFFECTSCONTAINER
	EmitParticle(hitparticle, 0.15)
	DebrisAdd(hitpart, hitparticle.Lifetime.Max + 0.15)

	CreateSoundAtPos("HIT2", CF.Position)
end

EFFECTS.KILL1 = function(Size, CF)
	local Pos = CF.Position
	local color
	if rnd:NextInteger(1, 2) == 1 then
		color = Color3.new()
	else
		color = Color3.new(1, 1, 1)
	end

	local exppart = CreateEmptyPart(Vector3.zero, CFrame.new(Pos) * CFrame.Angles(0, 0, math.rad(90)))
	local particle = CSE:CreateEffectInst("TARGET", "Kill1", "Shatter")
	local newseq = {}
	for i, Keypoint in particle.Size.Keypoints do
		table.insert(newseq, NumberSequenceKeypoint.new(Keypoint.Time, Keypoint.Value * Size.Magnitude/4, Keypoint.Envelope))
	end
	particle.Size = NumberSequence.new(newseq)
	particle.Speed = NumberRange.new(particle.Speed.Min * Size.Magnitude, particle.Speed.Max * Size.Magnitude)
	particle.Color = ColorSequence.new(color)

	particle.Parent = exppart
	exppart.Parent = EFFECTSCONTAINER
	particle:Emit(3)
	DebrisAdd(exppart, particle.Lifetime.Max)

	-- Part
	local clone = CSE:CreatePart({
		Anchored = true,
		CanCollide = false,
		Transparency = 0.25,
		Material = "Neon",
		Color = color,
		Size = Size,
		CFrame = CF,

		CanTouch = false,
		CanQuery = false,
		Parent = EFFECTSCONTAINER
	})

	local duration = rnd:NextNumber(4, 8)
	local radius = 50
	local speed = rnd:NextNumber(0.025, 0.35)
	local look = Vector3.new(rnd:NextNumber(-radius, radius), 100, rnd:NextNumber(-radius, radius)).Unit
	local angle = CFrame.Angles(rnd:NextNumber(0.01, 0.05) * CSF:RandomSign(), rnd:NextNumber(0.01, 0.05) * CSF:RandomSign(), rnd:NextNumber(0.01, 0.05) * CSF:RandomSign())
	coroutine.wrap(function()
		while clone.Parent ~= nil do
			clone.CFrame = (clone.CFrame * angle) + (look * speed)
			EWait()
		end
		DebrisAdd(exppart, 5)
	end)()
	coroutine.wrap(function()
		local pnames = {"Fireworks", "Ring"}
		local particles = {}
		for i, pname in pnames do
			local particle = CSE:CreateEffectInst("TARGET", "Kill1", pname)
			particles[pname] = particle
			local newseq = {}
			for i, Keypoint in particle.Size.Keypoints do
				table.insert(newseq, NumberSequenceKeypoint.new(Keypoint.Time, Keypoint.Value * Size.Magnitude/6, Keypoint.Envelope))
			end
			particle.Size = NumberSequence.new(newseq)
			particle.Speed = NumberRange.new(particle.Speed.Min * Size.Magnitude, particle.Speed.Max * Size.Magnitude)
			particle.Color = ColorSequence.new(color)
			if color == Color3.new() then
				particle.Brightness = 0
				particle.LightEmission = 0
			end
			particle.Parent = clone
		end
		while clone.Parent ~= nil do
			for pname, particle in particles do
				if pname == "Ring" then
					particle:Emit(1)
				else
					particle:Emit(rnd:NextNumber(2, 7))
				end
			end
			CreateSoundAtPos("KILL1_F"..rnd:NextInteger(1, 2), clone.Position)
			EWait(rnd:NextNumber(0.35, 1))
		end
	end)()
	CSE:TweenInst(clone, {
		{
			TweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				Transparency = 1,
				Size = Vector3.zero
			}
		}
	})
	DebrisAdd(clone, duration)

	CreateSoundAtPos("KILL1", Pos)
end
EFFECTS.KILL2 = function(Pos, Mode)
	local exppart = CreateEmptyPart(Vector3.zero, CFrame.new(Pos))
	exppart.Parent = EFFECTSCONTAINER

	local exppart = CreateEmptyPart(Vector3.zero, CFrame.new(Pos))
	exppart.Parent = EFFECTSCONTAINER


	local particle1 = CSE:CreateEffectInst("TARGET", "Kill2", tostring(Mode), "Spikes")
	particle1.Parent = exppart
	particle1:Emit(5)

	local particle2 = CSE:CreateEffectInst("TARGET", "Kill2", tostring(Mode), "Pierce")
	particle2.Parent = exppart
	particle2:Emit(20)
	EmitParticle(particle2, particle1.Lifetime.Max - particle2.Lifetime.Max)
	DebrisAdd(exppart, particle1.Lifetime.Max + particle2.Lifetime.Max)


	-- UI
	local UI = CSE:CreateEffectInst("TARGET", "Kill2", "QDisplay")
	local frame = UI.Frame
	local text = frame.QText

	UI.Parent = exppart
	CSE:TweenInst(UI, {
		{
			TweenInfo = TweenInfo.new(particle1.Lifetime.Max, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				Size = UDim2.new()
			}
		}
	})
	coroutine.wrap(function()
		local i = 0
		while exppart.Parent ~= nil do
			EWait(rnd:NextNumber(0.13, 0.3))
			i = i + 1

			local flip = i % 2 == 1
			if flip == true then
				text.TextColor3 = Color3.new()
			else
				text.TextColor3 = Color3.new(1, 1, 1)
			end
		end
	end)()

	-- Flash
	coroutine.wrap(function()
		local i = 0
		while exppart.Parent ~= nil do
			EWait(rnd:NextNumber(0, 0.25))
			i = i + 1
			local t = i % 2
			text.TextTransparency = t
			text.TextStrokeTransparency = t
		end
	end)()

	CreateSoundAtPos("KILL2", Pos)
end
EFFECTS.KILL3 = function(Pos, TargetPos)

	local exppart = CreateEmptyPart(Vector3.zero, CFrame.new(Pos) * CFrame.Angles(0, 0, math.rad(90)))
	exppart.Parent = EFFECTSCONTAINER
	local particle = CSE:CreateEffectInst("TARGET", "Kill3", "Star")
	particle.Parent = exppart
	particle:Emit(2)
	local particle = CSE:CreateEffectInst("TARGET", "Kill3", "Shatter")
	particle.Parent = exppart
	particle:Emit(3)

	local pathpart = CreateEmptyPart(Vector3.zero, CFrame.new(Pos) * CFrame.Angles(0, math.rad(90), 0))
	pathpart.Parent = EFFECTSCONTAINER
	local particle1 = CSE:CreateEffectInst("TARGET", "Kill3", "Path")
	particle1.Parent = pathpart
	EmitParticle(particle1)
	local particle2 = CSE:CreateEffectInst("TARGET", "Kill3", "Ring")
	particle2.Parent = pathpart
	EmitParticle(particle2)

	local Offset = 100
	local randompos = Pos:Lerp(TargetPos, 0.5) + Vector3.new(rnd:NextNumber(-Offset, Offset), rnd:NextNumber(-Offset, Offset), rnd:NextNumber(-Offset, Offset))
	local bez = Bezier.new(Pos, randompos, TargetPos)
	coroutine.wrap(function()
		for i = 0, 1, 0.008 do
			pathpart.CFrame = CFrame.new(bez:Get(i))
			EWait()
		end
		EmitParticleStop(particle1)
		EmitParticleStop(particle2)
		DebrisAdd(pathpart, particle1.Lifetime.Max)
	end)()

	CreateSoundAtPos("KILL3", Pos)
end
EFFECTS.KILL4 = function(StartPos, EndPos)
	local lockpart = CreateEmptyPart(Vector3.zero, CFrame.new(StartPos))
	lockpart.Parent = EFFECTSCONTAINER


	-- Explode first
	local particle = CSE:CreateEffectInst("TARGET", "Kill4", "Shatter")
	particle.Parent = lockpart
	particle:Emit(3)

	-- Spikes
	local spikeparticle = CSE:CreateEffectInst("TARGET", "Kill4", "Spikes")
	spikeparticle.Parent = lockpart
	EmitParticle(spikeparticle)

	-- TRAIL
	local trail = CSE:CreateEffectInst("TARGET", "Kill4", "Path")
	local a0 = Instance.new("Attachment")
	local a1 = Instance.new("Attachment")

	a0.Position = Vector3.new(0, -2, 0)
	a1.Position = Vector3.new(0, 2, 0)
	trail.Attachment0 = a0
	trail.Attachment1 = a1

	a0.Parent = lockpart
	a1.Parent = lockpart
	trail.Parent = lockpart

	-- BEZIER MOVEMENT
	local Offset = 200
	local randompos = StartPos:Lerp(EndPos, 0.5) + Vector3.new(rnd:NextNumber(-Offset, Offset), rnd:NextNumber(-Offset, Offset), rnd:NextNumber(-Offset, Offset))
	local bez = Bezier.new(StartPos, randompos, EndPos)
	coroutine.wrap(function()
		for i = 0, 1, 0.005 do
			lockpart.CFrame = CFrame.new(bez:Get(i))
			EWait()
		end
		EmitParticleStop(spikeparticle)
		DebrisAdd(lockpart, spikeparticle.Lifetime.Max)
	end)()


	-- UI
	local UI = CSE:CreateEffectInst("TARGET", "Kill4", "PassDisplay")
	local frame = UI.Frame
	local passtext = frame.PassText

	passtext.Text = FixWrap("! pass ?")
	UI.Parent = lockpart

	coroutine.wrap(function()
		local i = 0
		while lockpart.Parent ~= nil do
			EWait(rnd:NextNumber(0.13, 0.3))
			i = i + 1

			local flip = i % 2 == 1
			if flip == true then
				passtext.Text = FixWrap("? pass !")
			else
				passtext.Text = FixWrap("! pass ?")
			end
		end
	end)()

	CreateSoundAtPos("KILL4", StartPos)
end


EFFECTS.S1 = function(CF)

	-- ball
	local ball = CreateEmptyPart(Vector3.zero, CF)
	local particle = CSE:CreateEffectInst("S1", "Particles", "Ball", "Ball")
	particle.Parent = ball
	ball.Parent = EFFECTSCONTAINER
	EmitParticle(particle, 1.5 - (particle.Lifetime.Max/2))
	DebrisAdd(ball, 1.5 + particle.Lifetime.Max)



	-- Rings
	local Rings = {
		-- main
		{
			CFrame = CFrame.new(CF.Position + Vector3.new(0, 4, 0), CF.Position),
			HasRunes = true,
			HasStar = true,
			InitialSpeed = 5,
			SpeedModifiers = {
				Runes = 1,
				Star = -2,
			},
			GrowScale = 75,
			GrowDelay = 0,
			GrowDuration = 1,
			ShrinkScale = 75 * 0.35,
			ShrinkDelay = 1,
			ShrinkDuration = 0.5,
		},
		-- mid
		{
			CFrame = CFrame.new(CF.Position + Vector3.new(0, 15, 0), CF.Position),
			HasRunes = true,
			HasStar = false,
			InitialSpeed = 5,
			SpeedModifiers = {
				Runes = -1,
			},
			GrowScale = 60,
			GrowDelay = 0.15,
			GrowDuration = 1,
			ShrinkScale = 40 * 0.35,
			ShrinkDelay = 1,
			ShrinkDuration = 0.5,
		},
		-- topmost
		{
			CFrame = CFrame.new(CF.Position + Vector3.new(0, 25, 0), CF.Position),
			HasRunes = false,
			HasStar = true,
			InitialSpeed = 5,
			SpeedModifiers = {
				Star = 3,	
			},
			GrowScale = 40,
			GrowDelay = 0.3,
			GrowDuration = 1,
			ShrinkScale = 15 * 0.35,
			ShrinkDelay = 1,
			ShrinkDuration = 0.5,
		},
	}


	for i, RingData in Rings do
		local Parts = {
			Ring = {
				Part = CSE:CreateEffectInst("MC", "Ring"),
				RATIO = 1,
			}
		}
		if RingData.HasRunes == true then
			Parts.Runes = {Part = CSE:CreateEffectInst("MC", "Runes"), RATIO = 0.94}
		end
		if RingData.HasStar == true then
			Parts.Star = {Part = CSE:CreateEffectInst("MC", "Star"), RATIO = 0.775}
		end

		local MC = CSE:MagicCircle({
			Parts = Parts,
			Scale = 0,
			CFrame = RingData.CFrame * CFrame.Angles(math.rad(90), 0, 0)
		})
		local MCSegments = MC.Segments

		-- Update
		MC.Speed.Value = RingData.InitialSpeed
		for NAME, val in RingData.SpeedModifiers do
			MCSegments[NAME].Speed.Value = val
		end

		-- Main
		task.delay(RingData.GrowDelay, function()
			CSE:TweenInst(MC.Scale, {
				{
					TweenInfo = TweenInfo.new(RingData.GrowDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Value = RingData.GrowScale
					}
				}
			})
			CSE:TweenInst(MC.Speed, {
				{
					TweenInfo = TweenInfo.new(RingData.GrowDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Value = 0
					}
				}
			})
		end)
		task.delay(RingData.ShrinkDelay, function()
			CSE:TweenInst(MC.Scale, {
				{
					TweenInfo = TweenInfo.new(RingData.ShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					Properties = {
						Value = RingData.ShrinkScale
					}
				}
			}, function()
				for NAME, SegmentData in MCSegments do
					local shatterpart = CreateEmptyPart(SegmentData.Part.Size, SegmentData.Part.CFrame)
					local particle = CSE:CreateEffectInst("S1", "Particles", "Ball", "MagicShatter")
					particle.Parent = shatterpart
					shatterpart.Parent = EFFECTSCONTAINER

					particle:Emit(15)
					DebrisAdd(shatterpart, particle.Lifetime.Max)
				end
				MC:StopAll()
			end)
			CSE:TweenInst(MC.Speed, {
				{
					TweenInfo = TweenInfo.new(RingData.ShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					Properties = {
						Value = RingData.InitialSpeed/2
					}
				}
			})
		end)

		-- Segments
		for NAME, SegmentData in MCSegments do
			local MagicPart = SegmentData.Part

			MagicPart.Color = Color3.new()
			MagicPart.Transparency = 1
			MagicPart.Parent = EFFECTSCONTAINER
			CSE:TweenInst(MagicPart, {
				{
					TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Transparency = 0
					}
				}
			})
		end
	end
	CreateSoundAtPos("37_PITCHEDUP1", CF.Position)
	CreateSoundAtPos("37_PITCHEDUP1", CFRAMES.CHARACTER.Character.Position)
	EWait(1.5)


	-- Ball + Explosion
	local BallDuration = 0.3
	local ExplodeDuration = 3
	local ExpPhase1Frac = ExplodeDuration * 1/2 -- duration of normal size before it suddenly increases size
	local ExpPhase2Frac = ExplodeDuration-ExpPhase1Frac
	local ExpOffset = 2

	---------------- ENERGY BALL ----------------
	local GroundPos = CF.Position - Vector3.new(0, 50, 0)
	local GroundCFrame = CFrame.new(GroundPos, GroundPos - Vector3.new(0, 1, 0))
	local BallCFrame = CFrame.new(CF.Position, GroundPos)
	local ballpnames = {
		"Ball", "BackTrail", "BackTrail2", "FrontTrail"
	}

	local ball = CreateEmptyPart(Vector3.new(1.5, 1.5, 1.5), BallCFrame)
	ball.Parent = EFFECTSCONTAINER

	for i, pname in ballpnames do
		local particle = CSE:CreateEffectInst("S1", "Particles", "Ball", pname)
		particle.Parent = ball
		EmitParticle(particle, BallDuration + (BallDuration * 0.5))
	end
	CSE:TweenInst(ball, {
		{
			TweenInfo = TweenInfo.new(BallDuration , Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			Properties = {
				CFrame = GroundCFrame
			}
		}
	}, function()
		DebrisAdd(ball, 5)
	end)
	CreateSoundAtPos("40", GroundPos)

	EWait(BallDuration)



	---------------- EXPLOSION ----------------
	-- Widen the trail
	local exppart = CreateEmptyPart(Vector3.zero, GroundCFrame)
	exppart.Parent = EFFECTSCONTAINER
	DebrisAdd(exppart, ExplodeDuration + 4)

	local trailparticle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplodeTrail")
	trailparticle.Parent = exppart
	EmitParticle(trailparticle, ExplodeDuration)
	local trailparticle2 = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplodeTrailSmall")
	trailparticle2.Parent = exppart
	EmitParticle(trailparticle2, ExplodeDuration)
	task.delay(ExplodeDuration-0.5, function()
		trailparticle.Enabled = false
		trailparticle2.Enabled = false
	end)
	DebrisAdd(exppart, ExplodeDuration + 4)

	-- Center Spikes
	local trailparticle3 = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplodeTrailSpike")
	trailparticle3.Parent = exppart
	EmitParticle(trailparticle3, ExplodeDuration)

	-- Details
	local particle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplosionOrb")
	particle.Parent = exppart
	EmitParticle(particle, ExplodeDuration)
	local particle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplosionSpike")
	particle.Parent = exppart
	EmitParticle(particle, ExplodeDuration)

	-- Outward Particles
	local particle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "Explosion")
	particle.Parent = exppart
	EmitParticle(particle, ExplodeDuration)

	local particle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplodeBall")
	particle.Parent = exppart
	EmitParticle(particle, ExplodeDuration)


	coroutine.wrap(function()
		local t = os.clock()
		while os.clock()-t <= ExplodeDuration do
			CreateSoundAtPos("40", GroundPos)
			EWait(0.6)
		end
	end)()
	coroutine.wrap(function()
		local t = os.clock()
		while os.clock()-t <= ExplodeDuration do
			CreateSoundAtPos("41", GroundPos)
			EWait(0.75)
		end
	end)()

	-- Phase 2
	task.delay(ExpPhase1Frac, function()
		local exppart = CreateEmptyPart(Vector3.zero, GroundCFrame + Vector3.new(0, 1, 0))
		exppart.Parent = EFFECTSCONTAINER
		DebrisAdd(exppart, ExpPhase2Frac + 4)

		-- sudden size increase
		local particle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "Explosion2")
		particle.Parent = exppart
		EmitParticle(particle, ExpPhase2Frac)
		local particle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplosionOrb2")
		particle.Parent = exppart
		EmitParticle(particle, ExpPhase2Frac)
		local particle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplosionSpike")
		particle.Parent = exppart
		EmitParticle(particle, ExpPhase2Frac)


		-- End
		local endpart = CreateEmptyPart(Vector3.zero, GroundCFrame)
		local particle = CSE:CreateEffectInst("S1", "Particles", "Explosion", "ExplosionEnd")
		particle.Parent = endpart
		endpart.Parent = EFFECTSCONTAINER
		particle:Emit(50)
		EmitParticle(particle, 1.2)
		DebrisAdd(endpart, 1.2 + particle.Lifetime.Max)


		CreateSoundAtPos("41", GroundPos)
		task.delay(1.2, function()
			CreateSoundAtPos("41", GroundPos)
		end)
	end)

	-- Move around
	local setcf = renderstepped:Connect(function()
		local newcf = GroundCFrame * CFrame.new(rnd:NextNumber(-ExpOffset, ExpOffset), rnd:NextNumber(-ExpOffset, ExpOffset), 0)
		exppart.CFrame = newcf
	end)
	task.delay(ExplodeDuration, function()
		setcf:Disconnect()
	end)
end


local S2_EFFECTS = {}
EFFECTS.S2_Charge = function(BallID, CF)
	local BallData = {}
	S2_EFFECTS[BallID] = BallData

	BallData.Released = false
	BallData.CFrame = CF

	local Ball = CreateEmptyPart(Vector3.zero, CF)
	BallData.Ball = Ball
	Ball.Parent = EFFECTSCONTAINER

	-- Orb
	coroutine.wrap(function()
		local pnames = {
			"Ring1", "Ring2", "Smoke1", "Smoke2", "Inner1", "Inner2"
		}
		local particles = {}
		for i, pname in pnames do
			local particle = CSE:CreateEffectInst("S2", "Particles", "Phase1", pname)
			particles[pname] = particle
			particle.Parent = Ball
		end
		local function collective()
			particles["Ring1"]:Emit(1)
			particles["Ring2"]:Emit(1)
			particles["Smoke1"]:Emit(1)
			particles["Smoke2"]:Emit(1)
			particles["Inner1"]:Emit(rnd:NextInteger(30, 60))
			particles["Inner2"]:Emit(rnd:NextInteger(30, 60))
		end
		for i = 1, 3 do
			collective()
			EWait(0.5)
		end
		EWait(0.75)
		collective()
	end)()

	-- Constant particles
	local constantparticles = {
		"Outer1", "Outer2"
	}
	for i, pname in constantparticles do
		local particle = CSE:CreateEffectInst("S2", "Particles", "Phase1", pname)
		particle.Parent = Ball
		coroutine.wrap(function()
			while Ball.Parent ~= nil and BallData.Released == false do
				particle:Emit(1)
				EWait(rnd:NextNumber(0.25, 1.5))
			end
		end)()
	end

	-- Trails
	local t = os.clock()
	local r = rnd:NextNumber(0.15, 0.5)
	BallData.Loop = renderstepped:Connect(function()
		if os.clock() - t < r then return end
		t = os.clock()
		r = rnd:NextNumber(0.15, 0.5)
		for i = 1, rnd:NextInteger(1, 3) do
			-- Set up offsets
			local Offsets = {}
			local backoffset = rnd:NextNumber(10, 25)

			-- randomized back positions
			for i = 0.5, 1, 0.5 do
				table.insert(Offsets, 1, Vector3.new(rnd:NextNumber(15, 25) * CSF:RandomSign(), rnd:NextNumber(15, 25) * CSF:RandomSign(), backoffset * i))
			end

			-- randomized center positions
			for i = 1, rnd:NextInteger(1, 2) do
				table.insert(Offsets, Vector3.new(rnd:NextNumber(15, 22) * CSF:RandomSign(), rnd:NextNumber(15, 22) * CSF:RandomSign(), 3))
			end
			table.insert(Offsets, Vector3.new(rnd:NextNumber(8, 12) * CSF:RandomSign(), rnd:NextNumber(8, 12) * CSF:RandomSign(), 0))

			-- Original position
			table.insert(Offsets, Vector3.zero)


			-- Trailpart and trails
			local trailpart = CreateEmptyPart(Vector3.zero, CFrame.new((CF * CFrame.new(Offsets[1])).Position, CF.Position))
			for i = 1, rnd:NextInteger(1, 4) do
				local width = rnd:NextNumber(1, 2)
				local pos = rnd:NextNumber(-6, 6)
				local pos2 = pos + (width * CSF:RandomSign())

				local a0 = Instance.new("Attachment")
				local a1 = Instance.new("Attachment")

				a0.Position = Vector3.new(0, pos, 0)
				a1.Position = Vector3.new(0, pos2, 0)

				local trails = CSE:GetEffectInst("S2", "Trails"):GetChildren()
				local trail = CSE:CreateEffectInst("S2", "Trails", CSF:PickRandomFromTable(trails).Name)
				trail.Attachment0 = a0
				trail.Attachment1 = a1

				a0.Parent = trailpart
				a1.Parent = trailpart
				trail.Parent = trailpart
				task.delay(0.25, function()
					CSE:TweenInst(a0, {
						{
							TweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							Properties = {
								Position = Vector3.zero
							}
						}
					})
					CSE:TweenInst(a1, {
						{
							TweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							Properties = {
								Position = Vector3.zero
							}
						}
					})
				end)
			end
			trailpart.Parent = EFFECTSCONTAINER

			-- Bezier
			coroutine.wrap(function()
				local angle = CSF:RandomAngle()
				local inc = 1/(rnd:NextInteger(3, 5) * 10)
				local NewPositions = {}
				local BCF = BallData.CFrame
				for i, offset in Offsets do
					table.insert(NewPositions, (BCF * angle * CFrame.new(offset)).Position)
				end
				local bez = Bezier.new(unpack(NewPositions))
				for i = 0, 1, inc do
					local newpos = bez:Get(i)
					local newcf
					if newpos == BCF.Position then -- prevent cframe from going NaN
						newcf = CFrame.new(newpos, newpos + BCF.LookVector)
					else
						newcf = CFrame.new(newpos, BCF.Position)
					end
					trailpart.CFrame = newcf
					EWait()
				end
				DebrisAdd(trailpart, 1)
			end)()
		end
	end)

	CreateSoundAtPos("37_PITCHEDUP2", CF.Position)
	CreateSoundAtPos("37_PITCHEDUP2", CFRAMES.CHARACTER.Character.Position)
	CSE:CreateSound("39_SLOW2", {Parent = Ball})
	CSE:CreateSound("44", {Parent = Ball})

	coroutine.wrap(function()
		repeat EWait() until BallData.Released == true
		BallData.Loop:Disconnect()
		DebrisAdd(Ball, 5)
	end)()
end
EFFECTS.S2_Update = function(BallID, CF)
	local BallData = S2_EFFECTS[BallID]
	BallData.CFrame = CF
	CSE:TweenInst(BallData.Ball, {
		{
			TweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
			Properties = {
				CFrame = CF
			},
		},
	})
end
EFFECTS.S2_Release = function(BallID, CF)

	-- Implosion
	local BallData = S2_EFFECTS[BallID]
	BallData.Released = true

	---------------- PHASE 2 ----------------
	local exppart = CreateEmptyPart(Vector3.zero, CF)
	exppart.Parent = EFFECTSCONTAINER

	-- Outward particles
	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "Outward")
	particle.Parent = exppart
	EmitParticle(particle, 0.5)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "Ball")
	particle.Parent = exppart
	EmitParticle(particle, 2)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "OutwardSmoke")
	particle.Parent = exppart
	EmitParticle(particle, 1.5)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "Rays")
	particle.Parent = exppart
	EmitParticle(particle, 2)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "RingJet")
	particle.Parent = exppart
	EmitParticle(particle, 1.5)

	task.delay(0.75, function()
		local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "Ring")
		particle.Parent = exppart
		EmitParticle(particle, 0.5)
	end)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "LargeRing")
	particle.Parent = exppart
	EmitParticle(particle, 0.35)


	-- Inward particles
	local exppart2 = CreateEmptyPart(Vector3.new(200, 200, 200), CF)
	exppart2.Parent = EFFECTSCONTAINER

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "InwardRingForm")
	particle.Parent = exppart2
	EmitParticle(particle, 0.5)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "InwardSmoke")
	particle.Parent = exppart2
	EmitParticle(particle, 1.5)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase2", "InwardWhite")
	particle.Parent = exppart2
	EmitParticle(particle, 1.5)
	DebrisAdd(exppart2, 10)

	CSE:CreateSound("21_SLOW", {Parent = exppart})
	task.delay(0.25, function()
		local vol = 0
		CSE:TweenCustom(0, CSE:GetSound("43").Volume, TweenInfo.new(0.5), function(val)
			vol = val
		end)
		for i = 1, 15 do
			local sound = CSE:CreateSound("43", {Parent = exppart})
			sound.Volume = vol
			EWait(0.125)
		end
	end)
	task.delay(1.2, function()
		local sound = CSE:CreateSound("36_SLOW1", {Parent = exppart})
		sound.Volume = 0
		CSE:TweenInst(sound, {
			{
				TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Volume = CSE:GetSound("36_SLOW1").Volume
				}
			}
		})
	end)

	EWait(1.5)

	---------------- PHASE 3 ----------------
	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase3", "Expand")
	particle.Parent = exppart
	EmitParticle(particle, 0.5)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase3", "DenseBall")
	particle.Parent = exppart
	EmitParticle(particle, 1)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase3", "DenseRays")
	particle.Parent = exppart
	EmitParticle(particle, 0.75)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase3", "Smoke1")
	particle.Parent = exppart
	EmitParticle(particle, 2)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase3", "Smoke2")
	particle.Parent = exppart
	EmitParticle(particle, 2)

	EWait(1.25)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase3", "Engulf")
	particle.Parent = exppart
	EmitParticle(particle, 0.25)

	local particle = CSE:CreateEffectInst("S2", "Particles", "Phase3", "OutwardWhite")
	particle.Parent = exppart
	EmitParticle(particle, 1.25)

	task.delay((2 * 0.7), function()
		CSE:CreateSound("41", {Parent = exppart})
		task.delay(0.5, function()
			CSE:CreateSound("22", {Parent = exppart})
		end)
	end)

	DebrisAdd(exppart, 10)
end






local S3_CFrame
local S3_Balls = {}
--[[
	S3_Balls = {
		Ball = part
		CFrame = cf
		Particles {particle, particle, ...}
		CameraShakeID = string
		CameraShakeData = table
	}
]]
EFFECTS.S3_Charge = function(BallID, Pos)
	local cf = CFrame.new(Pos) * CSF:RandomAngle()
	-- New Ball Data
	local NewBall = CreateEmptyPart(Vector3.zero, cf)
	local NewParticles = {}
	S3_Balls[BallID] = {
		Ball = NewBall,
		CFrame = cf,
		Particles = NewParticles
	}

	NewBall.Parent = EFFECTSCONTAINER
	local particle = CSE:CreateEffectInst("S3", "Particles", "MagicBall")
	table.insert(NewParticles, particle)
	particle.Parent = NewBall
	EmitParticle(particle)
	CSE:CreateSound("37_PITCHEDUP1", {Parent = NewBall})
	CreateSoundAtPos("37_PITCHEDUP1", CFRAMES.CHARACTER.Character.Position)


	for i = -45, 45, 90 do
		local MCFrame = cf * CFrame.Angles(math.rad(i), 0, 0)
		local MC = CSE:MagicCircle({
			Parts = {
				Ring = {
					Part = CSE:CreateEffectInst("MC", "Ring"),
					RATIO = 1,
				},
				Runes = {
					Part = CSE:CreateEffectInst("MC", "Runes"),
					RATIO = 0.94
				},
				Star = {
					Part = CSE:CreateEffectInst("MC", "Star"),
					RATIO = 0.775
				}
			},
			Scale = 0,
			CFrame = MCFrame
		})
		local MCSegments = MC.Segments

		-- Update
		MC.Speed.Value = 3
		MCSegments.Runes.Speed.Value = 1
		MCSegments.Star.Speed.Value = -2

		for NAME, SegmentData in MCSegments do
			local MagicPart = SegmentData.Part
			MagicPart.Parent = EFFECTSCONTAINER
		end
		local t = rnd:NextNumber(0.75, 1)

		-- Main
		CSE:TweenInst(MC.Scale, {
			{
				TweenInfo = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Value = rnd:NextNumber(50, 100)
				}
			}
		})
		CSE:TweenInst(MC.CFrame, {
			{
				TweenInfo = TweenInfo.new(t * 1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Value = MCFrame * CFrame.Angles(math.rad(rnd:NextNumber(-25, 25)), math.rad(rnd:NextNumber(-67.5, 67.5)), math.rad(rnd:NextNumber(-67.5, 67.5)))
				}
			}
		})
		CSE:TweenInst(MC.Speed, {
			{
				TweenInfo = TweenInfo.new(t * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Value = 0
				}
			}
		})
		task.delay(t, function()
			CSE:TweenInst(MC.Scale, {
				{
					TweenInfo = TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					Properties = {
						Value = 0
					}
				}
			}, function()
				MC:StopAll()
			end)
		end)
	end
end

EFFECTS.S3_Release = function(BallID)
	local BallData = S3_Balls[BallID]
	local Ball = BallData.Ball
	local Particles = BallData.Particles

	local constantparticles = {
		"Spark", "DarkParticles", "Beam", "Ring", "WhiteBG"
	}
	for i, pname in constantparticles do
		local particle = CSE:CreateEffectInst("S3", "Particles", pname)
		table.insert(Particles, particle)
		particle.Parent = Ball
		EmitParticle(particle)
	end

	CSE:CreateSound("30", {Parent = Ball})
	CSE:CreateSound("41_SLOW", {Parent = Ball})
	CSE:CreateSound("50_PITCHEDDOWN", {Parent = Ball})

end
EFFECTS.S3_Update = function(BallID, CF)
	local BallData = S3_Balls[BallID]
	BallData.CFrame = CF
	BallData.Ball.CFrame = CF

end
EFFECTS.S3_End = function(BallID)
	local BallData = S3_Balls[BallID]
	local Ball = BallData.Ball

	for i, particle in BallData.Particles do
		EmitParticleStop(particle)
	end
	local particle = CSE:CreateEffectInst("S3", "Particles", "WhiteEnd")
	particle.Parent = Ball
	EmitParticle(particle, 0.5)
	CSE:CreateSound("31", {Parent = Ball})
	DebrisAdd(Ball, 5)

	S3_Balls[BallID] = nil
end







local S4_SFXMinDistance = 40
EFFECTS.S4 = function(CF)

	-- slightly offset explosion upwrds
	local RiftCF = CF + Vector3.new(0, 17, 0)
	local RiftPos = RiftCF.Position

	-- CROSS
	local InitialCF = RiftCF * CFrame.new(0, -20, 30)
	local InitialSize = Vector3.new(5, 72, 48) * 2
	local CROSS = CSE:CreateEffectInst("PRESETS", "Meshes/cross-kun")
	CROSS.Transparency = 1
	CROSS.Size = InitialSize
	CROSS.CFrame = InitialCF * CFrame.Angles(0, math.rad(90), 0)
	CROSS.Parent = EFFECTSCONTAINER

	local particle = CSE:CreateEffectInst("S4", "Particles", "CrossStar")
	particle.Parent = CROSS
	EmitParticle(particle, 0.5)
	CSE:TweenInst(CROSS, {
		{
			TweenInfo = TweenInfo.new(0.3),
			Properties = {
				Transparency = 0,
			}
		}
	})
	CSE:TweenInst(CROSS, {
		{
			TweenInfo = TweenInfo.new(1.5),
			Properties = {
				Size = InitialSize/2,
				CFrame = RiftCF * CFrame.Angles(0, math.rad(90), 0)
			}
		}
	})
	CSE:CreateSound("31_PITCHEDUP", {RollOffMinDistance = S4_SFXMinDistance, Parent = CROSS})
	task.delay(0.5, function()
		local exppart = CreateEmptyPart(Vector3.zero, RiftCF)
		local particle = CSE:CreateEffectInst("S4", "Particles", "Shine")
		particle.Parent = exppart
		exppart.Parent = EFFECTSCONTAINER
		EmitParticle(particle, 0.5)
		DebrisAdd(exppart, 0.5 + particle.Lifetime.Max)
	end)
	task.delay(1, function()
		-- CROSS END
		CSE:TweenInst(CROSS, {
			{
				TweenInfo = TweenInfo.new(0.5),
				Properties = {
					Size = Vector3.zero
				}
			}
		})
		DebrisAdd(CROSS, 3)
	end)

	EWait(1)


	-- WAVY BEAMS
	local WaveParts = {}
	local function WAVY(WaveStart, WaveEnd)
		local wavepart = CreateEmptyPart(Vector3.zero, CFrame.new(WaveStart))
		local wavebeam = CSE:CreateEffectInst("S4", "Beams", "Wavy")
		local BeamData = CSE:Beam({
			Part = wavepart,
			Beam = wavebeam,
			Pos0 = WaveStart,
			Pos1 = WaveEnd
		})
		local a0 = BeamData.A0
		local a1 = BeamData.A1
		table.insert(WaveParts, wavepart)


		wavebeam.Width0 = 0
		wavebeam.Width1 = 0
		wavebeam.TextureLength = rnd:NextNumber(0, 2)
		wavebeam.TextureSpeed = -rnd:NextNumber(0, 0.5)
		a0.WorldPosition = WaveStart
		a1.WorldPosition = WaveStart
		wavepart.Parent = EFFECTSCONTAINER

		local del = rnd:NextNumber(0.75, 1.25)
		CSE:TweenInst(wavebeam, {
			{
				TweenInfo = TweenInfo.new(del),
				Properties = {
					Width0 = 10,
					Width1 = rnd:NextNumber(10, 20),
				}
			}
		})
		CSE:TweenInst(a1, {
			{
				TweenInfo = TweenInfo.new(del),
				Properties = {
					WorldPosition = WaveEnd
				}
			}
		})
		task.delay(del, function()
			CSE:TweenInst(wavebeam, {
				{
					TweenInfo = TweenInfo.new(5),
					Properties = {
						Width0 = rnd:NextNumber(20, 30),
						Width1 = rnd:NextNumber(55, 110),
						TextureLength = rnd:NextNumber(0.5, 2),
						CurveSize0 = 0,
						CurveSize1 = 0,
					}
				}
			})
		end)
	end

	local WaveStart = RiftPos
	local WaveRadius = 100
	for i = 1, 75 do
		local WaveEndInitial = CF * CSF:RandomAngle()
		local WaveEnd = (WaveEndInitial * CFrame.new(0, 0, -WaveRadius)).Position
		WAVY(WaveStart, WaveEnd)
	end



	-- PARTICLES
	-- Rift
	local riftpart = CreateEmptyPart(Vector3.zero, RiftCF)
	riftpart.Parent = EFFECTSCONTAINER

	local particle = CSE:CreateEffectInst("S4", "Particles", "Ring")
	particle.Parent = riftpart
	particle:Emit(10)
	local particle = CSE:CreateEffectInst("S4", "Particles", "Ball")
	particle.Parent = riftpart
	EmitParticle(particle, 4)
	DebrisAdd(riftpart, 10)

	local debrispart = CreateEmptyPart(Vector3.new(50, 50, 50), CF)
	debrispart.Parent = EFFECTSCONTAINER
	local particle = CSE:CreateEffectInst("S4", "Particles", "Debris")
	particle.Parent = debrispart
	EmitParticle(particle, 3.35)
	DebrisAdd(debrispart, 10)



	-- Static
	-- Static face camera (BLACK BG FIRST)
	local staticpart = CreateEmptyPart(Vector3.zero, CFrame.new(CF.Position, workspace.CurrentCamera.CFrame.Position))
	staticpart.Parent = EFFECTSCONTAINER
	local setstaticcf = renderstepped:Connect(function()
		staticpart.CFrame = CFrame.new(CF.Position, workspace.CurrentCamera.CFrame.Position)
	end)

	local particle = CSE:CreateEffectInst("S4", "Particles", "BlackBG")
	particle.Parent = staticpart
	EmitParticle(particle, 3.5)
	local particle = CSE:CreateEffectInst("S4", "Particles", "Static")
	particle.Parent = staticpart
	EmitParticle(particle, 3.5)
	local particle = CSE:CreateEffectInst("S4", "Particles", "WhiteSmoke")
	particle.Parent = staticpart
	EmitParticle(particle, 3.5)

	task.delay(5 + particle.Lifetime.Max, function()
		setstaticcf:Disconnect()
	end)
	DebrisAdd(staticpart, 5 + particle.Lifetime.Max)


	task.delay(3.25, function()
		local exppart = CreateEmptyPart(Vector3.zero, CF)
		exppart.Parent = EFFECTSCONTAINER
		local particle = CSE:CreateEffectInst("S4", "Particles", "Cover")
		particle.Parent = exppart
		EmitParticle(particle, 0.5)
		task.delay(1, function()	
			local particle = CSE:CreateEffectInst("S4", "Particles", "Cover2")
			particle.Parent = exppart
			EmitParticle(particle, 0.25)
			DebrisAdd(exppart, 5)	
			for i, part in WaveParts do
				part:Destroy()
			end
		end)
	end)


	CreateSoundAtPos("38", RiftPos, {RollOffMinDistance = S4_SFXMinDistance})
	local _, s2 = CreateSoundAtPos("36_SLOW2", RiftPos, {RollOffMinDistance = S4_SFXMinDistance})
	local _, s3 = CreateSoundAtPos("35", RiftPos, {RollOffMinDistance = S4_SFXMinDistance})
	task.delay(5, function()
		CSE:TweenInst(s2, {
			{
				TweenInfo = TweenInfo.new(4),
				Properties = {
					Volume = 0
				}
			}
		})
		CSE:TweenInst(s3, {
			{
				TweenInfo = TweenInfo.new(4),
				Properties = {
					Volume = 0
				}
			}
		})
	end)


	for i, localplr in next, game:GetService("Players"):GetPlayers() do
		-- Static effect
		local playergui = localplr:FindFirstChildWhichIsA("PlayerGui")
		if playergui == nil then return end

		local UI = CSE:CreateEffectInst("S4", "UI", "STATIC")
		local framesUI = UI.Frames
		UI.Parent = playergui

		local F = -1
		local FRAMES = {}
		for i, frame in framesUI:GetChildren() do
			frame.ImageTransparency = 1
			frame.Visible = false
			FRAMES[frame.Name] = frame
		end

		local CurrentFrame = FRAMES["29"]

		-- Loop
		local FrameTime = os.clock()
		local setframes = renderstepped:Connect(function()
			if os.clock() - FrameTime < 0.025 then return end

			F = F + 1
			if F > 29 then F = 0 end

			CurrentFrame.Visible = false
			CurrentFrame = FRAMES[tostring(F)]
			CurrentFrame.Visible = true
		end)

		-- Transparency change
		local RelativeScale = 500
		local settr = renderstepped:Connect(function()
			for name, frame in FRAMES do
				frame.ImageTransparency = 0.75
			end
		end)

		task.delay(5, function()
			for name, frame in FRAMES do
				CSE:TweenInst(frame, {
					{
						TweenInfo = TweenInfo.new(1.5),
						Properties = {
							ImageTransparency = 1
						}
					}
				})
			end
			task.delay(1.5, function()
				setframes:Disconnect()
				settr:Disconnect()
			end)
			DebrisAdd(UI, 1.5)
		end)
	end
end



-- Ah yes the last effect that I will make in the script. what a journey it has been recreating this mugen cheapie
local S5_EndState = false
local S5_ExtendDuration = 3
local S5_SFXMinDistance = 100
EFFECTS.S5_Charge = function(CF)
	local Pos = CF.Position

	---------------- CHARGEUP ----------------
	-- CROSS
	local CrossCFOffset = CFrame.Angles(0, math.rad(90), 0) * CFrame.new(0, -20, 0) + Vector3.new(0, -20, 0)
	local CROSS = CSE:CreateEffectInst("PRESETS", "Meshes/cross-kun")
	CROSS.Size = Vector3.new(5, 72, 48) * 3 /2
	CROSS.CFrame = CF * CrossCFOffset
	CROSS.Parent = EFFECTSCONTAINER

	-- Shatter into existence first
	local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "CrossShatter")
	particle.Parent = CROSS
	particle:Emit(150)
	DebrisAdd(particle, particle.Lifetime.Max)

	CSE:TweenInst(CROSS, {
		{
			TweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				Size = Vector3.new(5, 72, 48) * 4 /2,
				CFrame = CF * CFrame.Angles(0, math.rad(90), 0)
			}
		}
	})

	CreateSoundAtPos("37", Pos, {RollOffMinDistance = S5_SFXMinDistance})

	local _, s = CreateSoundAtPos("47", Pos, {RollOffMinDistance = S5_SFXMinDistance})
	CSE:TweenInst(s, {
		{
			TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				Volume = 3,
			}
		}
	})

	--------------------------------
	-- MAGIC CIRCLES
	local MCCFOffset = CFrame.Angles(0, math.rad(90), math.rad(90)) * CFrame.new(0, 20, 0)

	local Circles = {}
	local num = 3
	for i = 1, num do
		local MCScale = 70 * i * 2 /2
		if i == num then MCScale = MCScale * 1.5 end
		local MCSpeed = rnd:NextNumber(1, 2.5)
		local GrowDuration = 1.5

		local SegInitial = {
			Ring = {
				Part = CSE:CreateEffectInst("MC", "Ring"),
				RATIO = 1,
			},
			Runes = {
				Part = CSE:CreateEffectInst("MC", "Runes"),
				RATIO = 0.94
			},
		}
		if i == num then
			SegInitial.Star = {
				Part = CSE:CreateEffectInst("MC", "Star"),
				RATIO = 0.775
			}
		end
		local MC = CSE:MagicCircle({
			Parts = SegInitial,
			Scale = 0,
			CFrame = CF * MCCFOffset
		})
		local MCSegments = MC.Segments
		table.insert(Circles, MC)

		-- Update
		MC.Speed.Value = MCSpeed
		MCSegments.Runes.Speed.Value = -rnd:NextNumber(0.5, 1.5)
		if i == num then
			MCSegments.Star.Speed.Value = rnd:NextNumber(2, 3)
		end

		for NAME, SegmentData in MCSegments do
			local MagicPart = SegmentData.Part
			MagicPart.Parent = EFFECTSCONTAINER
		end
		task.delay(0.15 * i, function()
			CSE:TweenInst(MC.Scale, {
				{
					TweenInfo = TweenInfo.new(GrowDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Value = MCScale
					}
				}
			})
			CSE:TweenInst(MC.Speed, {
				{
					TweenInfo = TweenInfo.new(GrowDuration + 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Value = 0
					}
				}
			})
		end)
	end

	-- Red effects
	local Del = 0.35
	local MCActivationTime = Del * (#Circles-1) + 1
	task.delay(1.5, function()
		for i, MC in Circles do
			local MCSegments = MC.Segments

			local ShrinkDuration = 2 + (Del * 0.75 * (num-i))

			CSE:TweenInst(MC.Scale, {
				{
					TweenInfo = TweenInfo.new(ShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					Properties = {
						Value = 0
					}
				}
			})

			for NAME, SegmentData in MCSegments do
				local MagicPart = SegmentData.Part
				CSE:TweenInst(MagicPart, {
					{
						TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
						Properties = {
							Color = Color3.new(1, 0, 0)
						}
					}
				})
			end
			local SpeedSign = 1
			if i % 2 == 1 then
				SpeedSign = SpeedSign * -1
			end
			MC.Speed.Value = -3 * SpeedSign
			CSE:TweenInst(MC.Speed, {
				{
					TweenInfo = TweenInfo.new(ShrinkDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					Properties = {
						Value = -6.5 * SpeedSign
					}
				}
			})
			task.delay(ShrinkDuration, function()
				MC:StopAll()
			end)
			CreateSoundAtPos("37_S5_ACTIVATE"..i, Pos, {RollOffMinDistance = S5_SFXMinDistance})
			EWait(Del)
		end
	end)

	-- Change cross to red when all MCs are "activated"
	task.delay(MCActivationTime, function()
		CSE:TweenInst(CROSS, {
			{
				TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				Properties = {
					Color = Color3.new(1, 0, 0),
				}
			}
		})
		CSE:TweenInst(CROSS, {
			{
				TweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				Properties = {
					Size = Vector3.zero,
				}
			}
		}, function()
			CROSS:Destroy()
		end)
		CSE:TweenCustom(CrossCFOffset, CFrame.Angles(0, math.rad(90), 0), TweenInfo.new(1.5), function(val)
			CrossCFOffset = val
		end)
	end)


	--------------------------------
	-- the funny yin yang
	local yypart = CreateEmptyPart(Vector3.zero, CF)
	local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "Ifinallygottousethisparticlesomewhere")
	particle.Parent = yypart
	yypart.Parent = EFFECTSCONTAINER
	task.delay(0.5, function()
		particle:Emit(1)
		DebrisAdd(yypart, particle.Lifetime.Max)
	end)

	-- make it actually appear after activation
	particle.Brightness = 0
	particle.LightEmission = 0
	task.delay(MCActivationTime, function()
		CSE:TweenInst(particle, {
			{
				TweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				Properties = {
					Brightness = 1,
					LightEmission = 0.75,
				}
			}
		})
	end)


	--------------------------------
	-- vortex
	local starpart = CreateEmptyPart(Vector3.one * 2000, CF)
	local starparticle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "VortexStar1")
	starparticle.Parent = starpart
	starpart.Parent = EFFECTSCONTAINER
	EmitParticle(starparticle, MCActivationTime + 1)

	local _, s = CreateSoundAtPos("33", Pos, {RollOffMinDistance = S5_SFXMinDistance, Volume = 0})
	CSE:TweenInst(s, {
		{
			TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				Volume = 3,
			}
		}
	})

	task.delay(MCActivationTime + 1, function()
		CSE:TweenInst(starparticle, {
			{
				TweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				Properties = {
					Brightness = 1,
				}
			}
		})

		-- Actual vortex
		local vpart = CreateEmptyPart(Vector3.zero, CF)
		vpart.Parent = EFFECTSCONTAINER
		local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "VortexShine")
		particle.Parent = vpart
		EmitParticle(particle, 0.25)


		local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "Vortex1")
		particle.Parent = vpart
		EmitParticle(particle, 0.25)
		local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "Vortex2")
		particle.Parent = vpart
		EmitParticle(particle, 0.25)

		local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "Singularity")
		particle.Parent = vpart
		EmitParticle(particle, 10)
		DebrisAdd(vpart, 10 + particle.Lifetime.Max)

		-- Inward
		local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "VortexDebris")
		particle.Parent = starpart
		EmitParticle(particle, 0.5)
		local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "VortexStar2")
		particle.Parent = starpart
		EmitParticle(particle, 0.5)
		DebrisAdd(starpart, 0.5 + particle.Lifetime.Max)

		CreateSoundAtPos("31", Pos, {RollOffMinDistance = S5_SFXMinDistance})

		-- LIGHTNING
		for i = 1, 20 do
			local Radius = 15 * i
			local End = Pos + Vector3.new(rnd:NextNumber(-Radius, Radius), rnd:NextNumber(-Radius, Radius), rnd:NextNumber(-Radius, Radius))
			local LightningPositions = CSE:Lightning3D(Pos, End, nil, rnd:NextNumber(70, 150))
			local trailpart = CreateEmptyPart(Vector3.zero, CF)
			local trail = CSE:CreateEffectInst("S5", "Trails", "VortexLightning")
			local a0 = Instance.new("Attachment")
			local a1 = Instance.new("Attachment")

			local width = rnd:NextNumber(0, i)

			a0.Position = Vector3.new(0, -width/2, 0)
			a1.Position = Vector3.new(0, width/2, 0)
			trail.Attachment0 = a0
			trail.Attachment1 = a1

			a0.Parent = trailpart
			a1.Parent = trailpart
			trail.Parent = trailpart
			trailpart.Parent = EFFECTSCONTAINER
			coroutine.wrap(function()
				for i, pos in LightningPositions do
					CSE:TweenInst(trailpart, {
						{
							TweenInfo = TweenInfo.new(0.03, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							Properties = {
								CFrame = CFrame.new(pos),
							}
						}
					})
					EWait(0.03)
				end
				DebrisAdd(trailpart, trail.Lifetime)
			end)()
			EWait(0.05)
		end
	end)



end


EFFECTS.S5_Release = function(CF)
	local Pos = CF.Position
	S5_EndState = false

	---------------- CHAOS RIFT ----------------
	local ballpart = CreateEmptyPart(Vector3.zero, CF)
	ballpart.Parent = EFFECTSCONTAINER

	-- Expand first
	local particle = CSE:CreateEffectInst("S5", "Particles", "Rift", "SingularityExpand")
	particle.Parent = ballpart
	particle:Emit(50)
	local particle = CSE:CreateEffectInst("S5", "Particles", "Rift", "Explosion")
	particle.Parent = ballpart
	particle:Emit(50)

	task.delay(0.5, function()
		-- PARTICLES
		-- Rift
		local particle1 = CSE:CreateEffectInst("S5", "Particles", "Rift", "Void")
		particle1.Parent = ballpart
		EmitParticle(particle1)
		local particle2 = CSE:CreateEffectInst("S5", "Particles", "Rift", "Chaos")
		particle2.Parent = ballpart
		EmitParticle(particle2)
		local particle3 = CSE:CreateEffectInst("S5", "Particles", "Rift", "Spiral")
		particle3.Parent = ballpart
		EmitParticle(particle3)

		local starpart = CreateEmptyPart(Vector3.one * 2000, CF)
		local starparticle = CSE:CreateEffectInst("S5", "Particles", "Rift", "ChaosStar")
		starparticle.Parent = starpart
		starpart.Parent = EFFECTSCONTAINER
		EmitParticle(starparticle)

		coroutine.wrap(function()
			repeat EWait() until S5_EndState == true
			EmitParticleStop(particle1)
			EmitParticleStop(particle2)
			EmitParticleStop(particle3)
			EmitParticleStop(starparticle)

			DebrisAdd(starpart, starparticle.Lifetime.Max)
		end)()
	end)












	-- BEAMS
	local TentaOutRadius = 1500

	local function TENTACLES(Start, End)
		local tentabeam = CSE:CreateEffectInst("S5", "Beams", "VoidTentacle")
		local BeamData = CSE:Beam({
			Part = ballpart,
			Beam = tentabeam,
			Pos0 = Start,
			Pos1 = End
		})
		local a0 = BeamData.A0
		local a1 = BeamData.A1

		tentabeam.TextureLength = rnd:NextNumber(-0.5, 1.5)
		tentabeam.TextureSpeed = rnd:NextNumber(0.75, 1.25)
		tentabeam.CurveSize0 = rnd:NextNumber(300, 600) * CSF:RandomSign()
		tentabeam.CurveSize1 = tentabeam.CurveSize0
		if rnd:NextInteger(1, 2) == 1 then
			tentabeam.CurveSize1 = tentabeam.CurveSize1 * -1
		end
		tentabeam.Width0 = 0
		tentabeam.Width1 = 0
		tentabeam.Brightness = 0

		CSE:TweenInst(tentabeam, {
			{
				TweenInfo = TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Width0 = rnd:NextNumber(50, 100),
				}
			}
		})
		CSE:TweenInst(tentabeam, {
			{
				TweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Width1 = rnd:NextNumber(200, 400),
				}
			}
		})
		CSE:TweenInst(tentabeam, {
			{
				TweenInfo = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Brightness = 20,
				}
			}
		})
		coroutine.wrap(function()
			repeat EWait() until S5_EndState == true
			CSE:TweenInst(tentabeam, {
				{
					TweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					Properties = {
						Brightness = 0,
						LightEmission = 0,
						Width0 = 0,
						Width1 = 0,
					}
				}
			})
			DebrisAdd(tentabeam, 2)
			DebrisAdd(a0, 2)
			DebrisAdd(a1, 2)
		end)()
	end

	for i = 1, 100 do
		local EndAngle = CF * CSF:RandomAngle()
		local End = (EndAngle * CFrame.new(0, 0, -TentaOutRadius)).Position
		TENTACLES(Pos, End)
	end
	coroutine.wrap(function()
		repeat EWait() until S5_EndState == true
		DebrisAdd(ballpart, 5)
	end)()







	-- EYE (but red)
	local EyeOffset = CFrame.new(Vector3.new(-0.125, 0.25, -0.57 + (-0.125/2 * 0.75)))
	local eye = CSE:CreateEffectInst("PRESETS", "Eye")
	eye.Size = eye.Size * CHARACTERSCALE

	local eyepart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Head * EyeOffset)
	local eyeparticle = CSE:CreateEffectInst("S5", "MISC", "EYE_Glare")
	local newseq = {}
	for i, Keypoint in eyeparticle.Size.Keypoints do
		table.insert(newseq, NumberSequenceKeypoint.new(Keypoint.Time, Keypoint.Value * CHARACTERSCALE, Keypoint.Envelope))
	end
	eyeparticle.Size = NumberSequence.new(newseq)

	eye.CFrame = CFRAMES.CHARACTER.Head * EyeOffset
	eye.Anchored = false
	eyeparticle.Parent = eyepart
	eye.Parent = EFFECTSCONTAINER
	eyepart.Parent = EFFECTSCONTAINER
	local a = Instance.new("Weld", eye)
	a.Part0 = eye
	a.Part1 = char.Head
	a.C1 = EyeOffset
	EmitParticle(eyeparticle)
	coroutine.wrap(function()
		repeat EWait() until S5_EndState == true
		EWait(S5_ExtendDuration)

		EmitParticleStop(eyeparticle)
		local del = eyeparticle.Lifetime.Max
		task.delay(del, function()
			a:Destroy()
		end)
		CSE:TweenInst(eye, {
			{
				TweenInfo = TweenInfo.new(eyeparticle.Lifetime.Min, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Transparency = 1,
				}
			}
		})
		DebrisAdd(eye, del)
		DebrisAdd(eyepart, del)
	end)()


	local RedTint = CSE:CreateEffectInst("S5", "Lighting", "RedTint")
	RedTint.Parent = lighting
	local RedRelativeScale = 1800
	local settint = renderstepped:Connect(function()
		local cam = workspace.CurrentCamera
		local campos = cam.CFrame.Position
		local lerp = math.min(1, (campos-Pos).Magnitude/RedRelativeScale)
		RedTint.TintColor = Color3.new(1, 1, 1):Lerp(Color3.new(1, 0, 0), 1-lerp)
	end)
	coroutine.wrap(function()
		repeat EWait() until S5_EndState == true
		CSE:TweenInst(RedTint, {
			{
				TweenInfo = TweenInfo.new(5),
				Properties = {
					TintColor = Color3.new(1, 1, 1)
				}
			}
		})
		DebrisAdd(RedTint, 5)
	end)()


	for i, localplr in next, game:GetService("Players"):GetPlayers() do
		-- Static effect (but red)
		local playergui = localplr:FindFirstChildWhichIsA("PlayerGui")
		if playergui == nil then return end

		local UI = CSE:CreateEffectInst("S5", "UI", "STATIC")
		local framesUI = UI.Frames
		UI.Parent = playergui

		local F = -1
		local FRAMES = {}
		for i, frame in framesUI:GetChildren() do
			frame.ImageTransparency = 1
			frame.Visible = false
			FRAMES[frame.Name] = frame
		end

		local CurrentFrame = FRAMES["29"]

		-- Loop
		local FrameTime = os.clock()
		local setframes = renderstepped:Connect(function()
			if os.clock() - FrameTime < 0.025 then return end

			F = F + 1
			if F > 29 then F = 0 end

			CurrentFrame.Visible = false
			CurrentFrame = FRAMES[tostring(F)]
			CurrentFrame.Visible = true
		end)

		-- Transparency change
		local StaticRelativeScale = 3000
		local settr = renderstepped:Connect(function()
			for name, frame in FRAMES do
				frame.ImageTransparency = 0.55
			end
		end)

		coroutine.wrap(function()
			repeat EWait() until S5_EndState == true
			for name, frame in FRAMES do
				CSE:TweenInst(frame, {
					{
						TweenInfo = TweenInfo.new(5),
						Properties = {
							ImageTransparency = 1
						}
					}
				})
			end
			task.delay(5, function()
				setframes:Disconnect()
				settr:Disconnect()
			end)
			DebrisAdd(UI, 5)
		end)()
	end

	task.delay(1.25, function()
		VOCAL("VOID")
	end)
	CreateSoundAtPos("50", Pos, {RollOffMinDistance = 1500})
	CreateSoundAtPos("49", Pos, {RollOffMinDistance = 1500})
	CreateSoundAtPos("36_SLOW2", Pos, {RollOffMinDistance = 500})
	-- Extend sfx
	for i = 1, 2 do
		task.delay(4 * i, function()
			local _, s1 = CreateSoundAtPos("50", Pos, {RollOffMinDistance = 1500, Volume = 0})
			CSE:TweenInst(s1, {
				{
					TweenInfo = TweenInfo.new(3),
					Properties = {
						Volume = 10,
					}
				}
			})

			local _, s2 = CreateSoundAtPos("36_SLOW2", Pos, {RollOffMinDistance = 500, Volume = 0})
			CSE:TweenInst(s2, {
				{
					TweenInfo = TweenInfo.new(3),
					Properties = {
						Volume = 1.5,
					}
				}
			})
		end)
	end
end

-- sync end with server
EFFECTS.S5_End = function(CF)
	S5_EndState = true

	local part = CreateEmptyPart(Vector3.zero, CF)
	part.Parent = EFFECTSCONTAINER
	local particle = CSE:CreateEffectInst("S5", "Particles", "Rift", "End")
	particle.Parent = part
	EmitParticle(particle, 1.5)

	EWait(1)

	local particle = CSE:CreateEffectInst("S5", "Particles", "Rift", "EndSingularity")
	particle.Parent = part
	EmitParticle(particle, S5_ExtendDuration-particle.Lifetime.Max+0.25)

	local starpart = CreateEmptyPart(Vector3.one * 2000, CF)
	local starparticle = CSE:CreateEffectInst("S5", "Particles", "Rift", "EndStar")
	starparticle.Parent = starpart
	starpart.Parent = EFFECTSCONTAINER
	EmitParticle(starparticle, 3.5)

	task.delay(S5_ExtendDuration, function()
		starparticle.Brightness = 10000
		starparticle.LightEmission = 696969
		starparticle.Color = ColorSequence.new(Color3.new(1, 1, 1))

		local particle = CSE:CreateEffectInst("S5", "Particles", "Rift", "EndRing")
		particle.Parent = part
		particle:Emit(20)
		DebrisAdd(part, particle.Lifetime.Max+5)

		CreateSoundAtPos("S5_END", CF.Position, {RollOffMinDistance = 1500})
	end)

	DebrisAdd(starpart, 3.5 + starparticle.Lifetime.Max)
end


EFFECTS.VANISH = function(Pos, Size)
	local Scale = Size.Magnitude/3

	local exppart = CreateEmptyPart(Vector3.zero, CFrame.new(Pos))
	exppart.Parent = EFFECTSCONTAINER

	local particle = CSE:CreateEffectInst("S5", "MISC", "VANISH_Kill")
	local newseq = {}
	for i, Keypoint in particle.Size.Keypoints do
		table.insert(newseq, NumberSequenceKeypoint.new(Keypoint.Time, Keypoint.Value * Scale, Keypoint.Envelope))
	end
	particle.Size = NumberSequence.new(newseq)
	particle.Parent = exppart
	particle:Emit(3)
	DebrisAdd(exppart, particle.Lifetime.Max + 0.75)

	local UI = CSE:CreateEffectInst("S5", "MISC", "VanishDisplay")
	local frame = UI.Frame
	local text = frame.Text

	text.Text = FixWrap("!!")

	local UISize = UI.Size
	UI.Size = UDim2.new(
		UISize.X.Scale * Scale, 
		UISize.X.Offset * Scale, 
		UISize.Y.Scale * Scale, 
		UISize.Y.Offset * Scale)

	UI.Parent = exppart
	for i = 1, 2 do
		EWait(0.065)
		text.TextTransparency = i % 2
		text.TextStrokeTransparency = i % 2
	end
	CSE:TweenInst(text, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
			}
		}
	})
end
EFFECTS.UNVANISH = function()
	local currentcf = CFRAMES.CHARACTER.Character


	-- Particle
	local exppart = CreateEmptyPart(Vector3.zero, currentcf)
	local particle = CSE:CreateEffectInst("S5", "MISC", "UnVanish")
	particle.Parent = exppart
	exppart.Parent = EFFECTSCONTAINER
	particle:Emit(10)
	DebrisAdd(exppart, particle.Lifetime.Max)

	-- UI
	local uipart = CreateEmptyPart(Vector3.zero, currentcf)
	local UI = CSE:CreateEffectInst("S5", "MISC", "UnVanishDisplay")
	local frame = UI.Frame
	local nametext = frame.NameText
	local nametext2 = frame.NameText2
	UI.Parent = uipart
	uipart.Parent = EFFECTSCONTAINER
	CSE:TweenInst(nametext, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
			}
		}
	})
	CSE:TweenInst(nametext2, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
			}
		}
	})

	local setcf = renderstepped:Connect(function()
		local cf = CFRAMES.CHARACTER.Character
		exppart.CFrame = cf
		uipart.CFrame = cf
	end)
	task.delay(0.5, function()
		setcf:Disconnect()
	end)
	CSE:CreateSound("UNVANISH", {Parent = uipart})
	DebrisAdd(uipart, 3)
end


EFFECTS.DARKTRAIL = function(Parts)

	for i, part in Parts do
		pcall(function()
			--if part:IsDescendantOf(workspace) == false then return end
			local clone = CSF:CloneInst(part)
			clone.Name = clone.Name.." (Dark Trail Local)"
			if clone:IsA("UnionOperation") then
				clone.UsePartColor = true
			end

			clone.Anchored = true
			clone.CanCollide = false
			clone.CanTouch = false
			clone.CanQuery = false

			clone.Transparency = 0
			clone.Material = Enum.Material.Neon
			clone.Color = Color3.new()
			clone.Size = clone.Size - (Vector3.one * 0.05)

			clone.Parent = EFFECTSCONTAINER
			CSE:TweenInst(clone, {
				{
					TweenInfo = TweenInfo.new(0.5),
					Properties = {
						Transparency = 1
					}
				}
			}, function()
				clone:Destroy()
			end)
		end)
	end
end



EFFECTS.BALL_Attack = function(BallName, Pos, Color)
	local bpos = CFRAMES.BALLS[BallName].Position

	local bpart = CreateEmptyPart(Vector3.zero, CFrame.new(bpos, Pos))
	local data = CSE:Beam({
		Part = bpart,
		Beam = CSE:CreateEffectInst("BALLS", "Beams", "BallBeam"),
		Pos0 = bpos,
		Pos1 = bpos
	})

	local beam = data.Beam
	local a0 = data.A0
	local a1 = data.A1
	beam.Color = ColorSequence.new(Color)

	local ring = CSE:CreateEffectInst("BALLS", "Particles", "BallRing")
	local smoke = CSE:CreateEffectInst("BALLS", "Particles", "BallSmoke")
	ring.Color = ColorSequence.new(Color)
	smoke.Color = ColorSequence.new(Color)
	ring.Parent = bpart
	smoke.Parent = bpart
	bpart.Parent = EFFECTSCONTAINER

	local duration = ring.Lifetime.Max
	local lerp = 0
	local cfloop = renderstepped:Connect(function()
		local bpos = CFRAMES.BALLS[BallName].Position

		bpart.CFrame = CFrame.new(bpos, Pos)
		a0.WorldPosition = bpos
		a1.WorldPosition = bpos:Lerp(Pos, lerp)
	end)

	CSE:TweenCustom(lerp, 1.5, TweenInfo.new(duration), function(val)
		lerp = val
	end)
	CSE:TweenInst(beam, {
		{
			TweenInfo = TweenInfo.new(duration),
			Properties = {
				Width0 = 0,
				Width1 = 0
			}
		}
	})
	ring:Emit(1)
	smoke:Emit(1)

	task.delay(duration, function()
		cfloop:Disconnect()
	end)
	DebrisAdd(bpart, duration)
	DebrisAdd(ring, ring.Lifetime.Max)
	DebrisAdd(smoke, smoke.Lifetime.Max)
end


function newsoundat(cframe, id, vol, pit)
	local p = newpart(Vector3.zero, cframe)
	p.Parent = EFFECTSCONTAINER
	local s = Instance.new("Sound", p)
	s.SoundId = "rbxassetid://"..id
	s.Volume = vol
	s.Pitch = pit
	s:Play()
	task.spawn(function()
		if(not s.IsLoaded)then
			repeat task.wait() until s.IsLoaded
		end
		game:GetService("Debris"):AddItem(p, s.TimeLength/s.Pitch)
	end)
	return s
end

function charclone()
	if(not EFFECTSCONTAINER or EFFECTSCONTAINER.Parent ~= workspace.Terrain)then
		EFFECTSCONTAINER = Instance.new("Folder", workspace.Terrain)
	end
	for i, v in next, char:GetDescendants() do
		if(not v:IsA("BasePart"))then
			continue
		end
		pcall(function()
			local a = v:Clone()
			a:BreakJoints()
			for i, vv in next, a:GetDescendants() do
				if(not vv:IsA("DataModelMesh") and not vv:IsA("BasePart"))then
					pcall(game.Destroy, vv)
				elseif(vv:IsA("DataModelMesh"))then
					vv.TextureId = ""
				end
			end
			if(v:IsA("MeshPart"))then
				a.TextureID = ""
			end
			a.Material = Enum.Material.Neon
			a.Color = Color3.new(0,0,0)
			a.Anchored = true
			a.CanCollide = false
			a.Size = a.Size - Vector3.new(0.05, 0.05, 0.05)
			a.Name = tostring({}):match("0x.*"):sub(3,17)
			a.Parent = EFFECTSCONTAINER
			game:GetService("TweenService"):Create(a, TweenInfo.new(1), {
				Transparency = 1
			}):Play()
			game:GetService("Debris"):AddItem(a, 1)
		end)
	end
end

function counter(counterlist)
	task.wait()
	if(tick() - counterdeb) < 3 then
		return
	end
	counterdeb = tick()
	pcall(function()
		local broom = script.Models.Broom.Broom:Clone()
		broom.Anchored = false
		broom.CanCollide = false
		local motor = Instance.new("Motor6D", broom)
		motor.Part1 = broom
		motor.C1 = CFrame.new(0,1,3)
		broom.Parent = char
		broom.Motor6D.Part0 = char["Left Arm"]

		local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
		bv.Velocity = -char.HumanoidRootPart.CFrame.LookVector*7
		bv.MaxForce = Vector3.new(99e9, 99e9, 99e9)
		task.delay(0.467, function()
			pcall(game.Destroy, bv)
			pcall(game.Destroy, broom)
			hum.WalkSpeed = 16
		end)
	end)
	AnimationPlay("Counter")

	local cframe = CFRAMES.CHARACTER.Character

	local Size = UDim2.new(11 * .5, 0, 11 * .5, 0)
	local uipart = newpart(Vector3.zero, cframe)
	local UI = CSE:CreateEffectInst("TARGET", "DeadlyAlert", "DeadlyAlertDisplay")
	local frame = UI.Frame
	local img = frame.Alert
	UI.Size = UDim2.new(Size.X.Scale/3, 0, Size.Y.Scale/3, 0)
	UI.StudsOffset = Vector3.new(rnd:NextNumber(6, 7.5) * ({-1, 1})[rnd:NextInteger(1, 2)], rnd:NextNumber(6.5, 9), rnd:NextNumber(6, 7.5) * ({-1, 1})[rnd:NextInteger(1, 2)]) * .5
	UI.Parent = uipart
	uipart.Parent = EFFECTSCONTAINER

	newsoundat(cframe, 13081965892, 5, 1)
	game:GetService("TweenService"):Create(UI, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		Size = Size
	}):Play()

	task.delay(1, function()
		game:GetService("TweenService"):Create(img, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
			ImageTransparency = 1
		}):Play()
	end)
	task.delay(1.35, function()
		uipart:Destroy()
	end)

	task.delay(1/30, function()
		local chargepart = newpart(Vector3.zero, cframe)
		local chargeparticle = CSE:CreateEffectInst("COUNTER", "Particles", "CounterCharge")
		chargeparticle.Parent = chargepart
		chargepart.Parent = EFFECTSCONTAINER
		task.spawn(function()
			for i = 1, 5 do
				chargeparticle:Emit(1)
				EWait(0.05)
			end
			deb:AddItem(chargepart, chargeparticle.Lifetime.Max)
		end)
		local s = newsoundat(cframe, 13081812417, 2, 1)
		local e = Instance.new("EchoSoundEffect", s)
		e.Delay = 0.15
		e.DryLevel = 1
		e.Feedback = .5
		e.Priority = 0
		e.WetLevel = 0
	end)

	task.delay(0.6 + rnd:NextNumber(0, 0.65), function()
		local soundname
		if rnd:NextInteger(1, 2) == 1 then
			newsoundat(cframe, 13081578397, 5, 1)
		else
			newsoundat(cframe, 13081563072, 5, 1)
		end
	end)

	EWait(.2)

	local labelpart = newpart(Vector3.zero, cframe)
	local ui = CSE:CreateEffectInst("COUNTER", "UI", "CounterDisplay")
	local frame = ui.Frame
	local imglabel = frame.ImageLabel
	imglabel.ImageTransparency = 1
	local countertext = frame.CounterText
	local attacktext = frame.AttackText

	imglabel.ImageTransparency = 1
	countertext.TextTransparency = 1
	countertext.TextStrokeTransparency = 1
	countertext.Visible = true
	attacktext.Visible = false

	ui.Size = UDim2.new(70, 0, 70, 0)
	ui.Adornee = labelpart
	ui.Parent = labelpart
	labelpart.Parent = EFFECTSCONTAINER

	ts:Create(labelpart, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		CFrame = cframe + Vector3.new(0, 8.5, 0)
	}):Play()

	ts:Create(ui, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.new(10, 0, 10, 0)
	}):Play()

	ts:Create(imglabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		ImageTransparency = 0.5
	}):Play()

	EWait(.5)
	countertext.TextTransparency = 0.75
	countertext.TextStrokeTransparency = 0.75

	task.spawn(function()
		local cindex = 1
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0.13, 0.3))
			i = i + 1

			local showattack = i % 2 == 1
			if showattack == true then
				local attack = counterlist[cindex] or "undefined"
				attack = FixWrap(attack)
				attacktext.Text = FixWrap("? "..attack.." ?")

				cindex = cindex + 1
				if cindex > #counterlist then
					cindex = 1
				end
			else
				if rnd:NextInteger(1, 2) == 1 then
					countertext.Text = "COUNTER"
				else
					countertext.Text = FixWrap("? ANTIFADE ?")
				end
			end

			countertext.Visible = not showattack
			attacktext.Visible = showattack
		end
	end)

	task.spawn(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0, 0.25))
			i = i + 1

			imglabel.ImageTransparency = (i % 2) + 0.5
			countertext.TextTransparency = (i % 2) + 0.75
			countertext.TextStrokeTransparency = (i % 2) + 0.75
			attacktext.TextTransparency = (i % 2) + 0.5
		end
	end)
	deb:AddItem(labelpart, 3.5)

	local counterpart = newpart(Vector3.zero, cframe)
	local counterparticle = CSE:CreateEffectInst("COUNTER", "Particles", "CounterRing")
	counterpart.Parent = EFFECTSCONTAINER
	counterparticle.Parent = counterpart
	task.spawn(function()
		task.wait()
		counterparticle:Emit(10)
		deb:AddItem(counterpart, counterparticle.Lifetime.Max)
	end)

	pcall(function()
		local EyeOffset = CFrame.new(Vector3.new(-0.125, 0.25, -0.57 + (-0.125/2 * 0.75)))
		local eye = CSE:CreateEffectInst("PRESETS", "Eye")
		eye.Color = Color3.new(1, 1, 1)
		eye.Anchored = false
		eye.Size = eye.Size

		local eyeparticle = CSE:CreateEffectInst("COUNTER", "Particles", "EYE_Glare")
		eye.Anchored = false
		eye.CanCollide = false

		local att = Instance.new("Attachment", eye)
		eyeparticle.Parent = att
		eye.CFrame = CFRAMES.CHARACTER.Head*EyeOffset
		eye.Parent = EFFECTSCONTAINER

		local a = Instance.new("Weld", eye)
		a.Part0 = eye
		a.Part1 = char.Head
		a.C1 = EyeOffset
		EmitParticle(eyeparticle, 3)

		task.delay(3, function()
			local del = eyeparticle.Lifetime.Max
			ts:Create(eye, TweenInfo.new(eyeparticle.Lifetime.Min, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1
			}):Play()
			deb:AddItem(eye, del)
		end)
	end)

	local s = newsoundat(cframe, 8186892542, 2, 1)
	local p = Instance.new("PitchShiftSoundEffect", s)
	p.Octave = 1.85
end

function clearall()
	for i, v in next, connections do
		pcall(function()
			v:Disconnect()
		end)
	end
	table.clear(connections)
	table.clear(joints)
	table.clear(limbs)
end

function remakechar()
	local nc = cbackup:Clone()
	hn(function()
		nc.Archivable = false
		nc.Name = tostring({}):match("0x.*"):sub(3,17)
		char = nc
		CFRAMES = oldcframes
		nc:PivotTo(CFRAMES.CHARACTER.Character)
		owner.Character = nc
		newchar()
		nc.Parent = workspace
	end)
	return nc
end

function respawn()
	clearall()
	pcall(game.Destroy, char)
	pcall(game.Destroy, owner.Character)

	pcall(function()
		oldcframes = {
			CHARACTER = {
				Character = CFRAMES.CHARACTER.Character.Y <= workspace.FallenPartsDestroyHeight + 20 and relocate() or CFRAMES.CHARACTER.Character,
				Head = CFRAMES.CHARACTER.Head,
				["Left Arm"] = CFRAMES.CHARACTER["Left Arm"]
			},
			BALLS = CFRAMES.BALLS
		};
	end)
	local nc = remakechar()
	task.defer(function()
		if(nc and nc:IsDescendantOf(workspace))and(owner.Character ~= nc)then
			clearall()
			pcall(game.Destroy, nc)
			pcall(game.Destroy, char)
			pcall(game.Destroy, owner.Character)
			nc = remakechar()
		end
	end)
end

local objectstocheck = {
	"Head", "Torso", "Right Arm", "Right Leg", "Left Arm", "Left Leg", "HumanoidRootPart"
}
local shouldnotbetransparentorsmall = {
	"Head", "Right Leg", "Left Leg", "Left Arm", "Right Arm", "Torso"
}
local jointstocheck = {
	"Neck", "RootJoint", "Left Shoulder", "Left Hip", "Right Shoulder", "Right Hip",
}

function dochecks(object)
	if(refitting)then return end
	local cl = {}
	local shouldrefit = false

	local function c(offense)
		if not table.find(cl, offense) then
			table.insert(cl, offense)
		end
		shouldrefit = true
	end

	if(not char or not char:IsDescendantOf(workspace))then
		c(`ancestry_tamper({char and tostring(char.Parent) or "nil?"})`)
	end

	if(char and char:IsDescendantOf(workspace))then
		if(not hum or not hum:IsDescendantOf(char))then
			c("humanoid_removal")
		end
		if(hum and hum:IsDescendantOf(char) and hum.RigType ~= Enum.HumanoidRigType.R6)then
			c("rigtype_tamper")
		end
		if(hum.Health < orighp)then
			c("health_tampering")
		end
		if(hum.Health <= 0)then
			c("humanoid_death")
		end

		local numofdescc = 0
		local physicstamper = false
		for i, v in next, char:GetDescendants() do
			if(v:IsA("ForceField") or v:IsA("BodyVelocity") or v:IsA("LuaSourceContainer") or v:IsA("JointInstance") or v:IsA("Sound") or v.Name == "Eye" or v:FindFirstAncestor("Eye") or v.Name == "Broom" or v:FindFirstAncestor("Broom"))then
				continue
			end
			numofdescc = numofdescc + 1
			if(v:IsA("BasePart") and v.Anchored)then
				physicstamper = true
			end
		end
		if(numofdescc > numofdesc)then
			c("intrusion")
		end
		if(physicstamper)then
			c("physics_tampering")
		end

		if(object)then
			if(table.find(limbs, object))then
				c(`limb_removal({object.Name})`)
			end
		end
		for i, v in next, limbs do
			if(not v:IsDescendantOf(char))then
				c(`limb_removal({v.Name})`)
				break
			end
		end

		if(object)then
			if(table.find(joints, object))then
				c(`joint_removal({object.Name})`)
			end
		end
		for i, v in next, joints do
			if(not v:IsDescendantOf(char))then
				c(`joint_removal({v.Name})`)
				break
			end
		end

		for i, v in next, objectstocheck do
			if(not char:FindFirstChild(v, true))then
				c("intrusion")
				break
			end
		end

		for i, v in next, shouldnotbetransparentorsmall do
			local obj = char:FindFirstChild(v, true)
			if(not obj)then continue end
			if(obj.Transparency >= .1 or math.abs(obj.Size.Magnitude) <= 1)then
				c("object_tampering("..v..")")
				break
			end
		end

		for i, v in next, jointstocheck do
			local obj = char:FindFirstChild(v, true)
			if(not obj)then continue end
			if(math.abs(obj.C0.Position.Magnitude) >= 1e1 or math.abs(obj.C1.Position.Magnitude) >= 1e1 or obj.Enabled == false or obj.Part1 == nil or obj.Part0 == nil)then
				c("joint_tampering("..v..")")
				break
			end
		end

		if(Vector3.zero - char:GetPivot().Position).Magnitude > 1e4 then
			c("void_throw")
		end
	end

	if(shouldrefit)then
		clearall()
		task.defer(respawn)

		counter(cl)
		return true
	end

	return false
end

local refitting = false
function newchar()
	clearall()
	refitting = true
	task.defer(function()
		clearall()
		numofdesc = 0

		CFRAMES.CHARACTER.Character = char:GetPivot()
		CFRAMES.CHARACTER.Head = char.Head.CFrame

		hum = char:FindFirstChildOfClass("Humanoid")
		task.defer(function()
			if(char:FindFirstChildOfClass("ForceField"))then
				char:FindFirstChildOfClass("ForceField"):Destroy()
			end
		end)
		for i, v in next, char:GetDescendants() do
			if(v:IsA("ForceField") or v:IsA("BodyVelocity") or v:IsA("LuaSourceContainer") or v:IsA("JointInstance") or v.Name == "Eye" or v:FindFirstAncestor("Eye") or v.Name == "Broom" or v:FindFirstAncestor("Broom"))then
				continue
			end
			numofdesc = numofdesc + 1
		end

		for i,v in next, char:GetDescendants() do
			if(v:IsA("JointInstance") and not v:FindFirstAncestorOfClass("Accessory"))then
				table.insert(joints, v)
			end
		end
		for i,v in next, char:GetChildren() do
			if(v:IsA("BasePart"))then
				table.insert(limbs, v)
			end
		end

		orighp = hum.Health
		
		refitting = false
		table.insert(connections, hum.HealthChanged:Connect(function()
			if(refitting)then return end
			dochecks()
		end))

		table.insert(connections, char.HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Connect(function()
			if(refitting)then return end
			dochecks()
		end))

		table.insert(connections, char.DescendantRemoving:Connect(function(v)
			if(refitting)then return end
			dochecks(v)
		end))
		table.insert(connections, char.DescendantAdded:Connect(function(v)
			if(refitting)then return end
			dochecks(v)
		end))

		table.insert(connections, char.AncestryChanged:Connect(function()
			if(refitting)then return end
			dochecks()
		end))
	end)
end

local delta = 0

local mus = nil
local lastmuspos = 0

local lastcharcf = CFrame.identity

heartbeat:Connect(function(dt)
	supernull(5, function()
		pcall(function()
			local pivot = char:GetPivot()
			if(Vector3.zero - pivot.Position).Magnitude < 1e4 then
				local param = RaycastParams.new()
				param.FilterDescendantsInstances = {char, EFFECTSCONTAINER}
				local ray = workspace:Raycast(pivot.Position, Vector3.new(0,-5,0), param)
				if(ray)then
					CFRAMES.CHARACTER.Character = CFrame.new(pivot.Position)*CFrame.Angles(0, math.rad(char.HumanoidRootPart.Orientation.Y), 0)
					CFRAMES.CHARACTER.Head = char.Head.CFrame
					CFRAMES.CHARACTER["Left Arm"] = char["Left Arm"].CFrame
				end
			end
			
			for i, v in next, char:GetDescendants() do
            	if(v:IsA("BasePart"))then
                	v.CanCollide = false
                	v.Massless = false
       	         	v.CanQuery = false
       	    	end
     	   	end
		end)

		delta = delta + dt
		dochecks()

		if(delta >= .1)then
			delta = 0
			if(char:FindFirstChild("HumanoidRootPart").CFrame ~= lastcharcf)then
				lastcharcf = char:FindFirstChild("HumanoidRootPart").CFrame
				charclone()
			end
		end	

		if(not mus or mus.Parent ~= char:FindFirstChild("HumanoidRootPart"))then
			pcall(function()
				lastmuspos = mus.TimePosition
			end)
			pcall(game.Destroy, mus)
			mus = Instance.new("Sound", char:FindFirstChild("HumanoidRootPart"))
			mus.Volume = 1
			mus.SoundId = "rbxassetid://117409326687588" --13082498926
			mus.Looped = true
			mus.Pitch = 1
			mus.Playing = true
			mus.TimePosition = lastmuspos
		end
		mus.Volume = 1
		mus.SoundId = "rbxassetid://117409326687588"
		mus.Looped = true
		mus.Pitch = 1
		mus.Playing = true
	end)
end)

respawn()
owner.CharacterAdded:Connect(respawn)

local AliveUIs = {}
function AliveCreate()
	for i, UI in AliveUIs do
		pcall(function()
			UI:Destroy()
		end)
	end

	local name = "Alive_?ERROR?_"..CSF:RandomString():sub(1, 10).."_"..CSF:RandomString():sub(1, 10)
	for i, player in players:GetPlayers() do
		pcall(function()
			local playergui = player.PlayerGui
			local UI = CSE:CreateEffectInst("Alive")
			local numtext = UI.Frame.Num
			table.insert(AliveUIs, UI)
			UI.Name = name
			UI.Parent = playergui
		end)
	end
end
function AliveUpdate(val)
	for i, UI in AliveUIs do
		pcall(function()
			UI.Frame.Num.Text = val
		end)
	end
end
function AliveClear()
	for i, UI in AliveUIs do
		pcall(function()
			UI:Destroy()
		end)
	end
	AliveUIs = {}
end

local ACTIONS = {}
local CurrentAction
local CurrentActionTime = os.clock() -- the time where the latest action occured
local COUNTERDEBOUNCE = false -- for counter effect (cant do actions while in this state)

--A ctionChanged.Event:Connect(function(lastaction or NIL, currentaction or NIL, actiontime))
-- Fires whenever an action either starts or ends
local ActionChanged = Instance.new("BindableEvent")
function ACTIONSETUP(Name, ActionFunc, DisableMovement, CanBeDuplicated, CanOverwrite, TOGGLEVARS)
	local DisableMovement = DisableMovement
	if DisableMovement == nil then DisableMovement = false end

	local CanBeDuplicated = CanBeDuplicated
	if CanBeDuplicated == nil then CanBeDuplicated = true end

	local TOGGLEVARS = TOGGLEVARS
	if TOGGLEVARS == nil then TOGGLEVARS = true end

	local New = {}
	New.ActionFunc = ActionFunc
	New.DisableMovement = DisableMovement
	New.CanBeDuplicated = CanBeDuplicated -- if the action can be done while the same action is already running
	New.CanOverwrite = CanOverwrite -- if the action can happen alongside another action
	New.TOGGLEVARS = TOGGLEVARS -- Main control; disable if you don't want any tampering with character movement, animations, and action variables
	New.RunningInstances = {} -- os.clock() differentiation
	ACTIONS[Name] = New
end
function ACTIONGETACTIVE()
	local Active = {}
	for Name, ActionData in ACTIONS do
		if CSF:GetDictionaryLength(ActionData.RunningInstances) > 0 then
			table.insert(Active, Name)
		end
	end
	return Active
end
function ACTIONRESET()
	CurrentAction = nil
	ActionChanged:Fire(CurrentAction, nil, os.clock())
end
function ACTIONPERFORM(Name, ...)
	coroutine.wrap(function(...)
		local ActionData = ACTIONS[Name]
		if ActionData == nil then return end
		if COUNTERDEBOUNCE then return end
		if ActionData.CanOverwrite ~= true and CurrentAction ~= nil then return end
		if CSF:GetDictionaryLength(ActionData.RunningInstances) > 0 and ActionData.CanBeDuplicated ~= true then return end



		local LastAction = CurrentAction
		local ActionTime = tostring(os.clock())
		ActionData.RunningInstances[ActionTime] = true
		if ActionData.TOGGLEVARS == true then
			CurrentAction = Name
			CurrentActionTime = ActionTime
			ActionChanged:Fire(LastAction, CurrentAction, ActionTime)
			if ActionData.DisableMovement then
				hum.WalkSpeed = 0
			end
		end

		ActionData.ActionFunc(...)


		if ActionData.TOGGLEVARS == true and CurrentActionTime == ActionTime then -- If stil performing same action then overwrite
			if ActionData.DisableMovement then
				hum.WalkSpeed = 16
			end
			ACTIONRESET()

			stopAnims(char:FindFirstChild("Animate"))
		end
		ActionData.RunningInstances[ActionTime] = nil
	end)(...)
end


function LimitCaught(tab, num)
	local new = {}
	for i = 1, num do
		if tab[i] then table.insert(new, tab[i]) end
	end
	return new
end

-- Special
function Kill1(RegionCFrame, RegionSize)
	local attackfilter = AttackFilter()
	local parts = CSF:Region(RegionCFrame, RegionSize, attackfilter)

	parts = LimitCaught(parts, 20)
	for i, part in parts do
		pcall(function()
			EFFECT("KILL1", part.Size, part.CFrame)
		end)
	end

	table.clear(attackfilter)
end

-- Funny Kill
function Kill2(Mode)

end

-- Decimate
function Kill3(RegionCFrame, RegionSize, TargetPos)
	local attackfilter = AttackFilter()
	local parts = CSF:Region(RegionCFrame, RegionSize, attackfilter)

	parts = LimitCaught(parts, 20)
	for i, part in parts do
		pcall(function()
			EFFECT("KILL3", part.Position, TargetPos)
		end)
	end
	table.clear(attackfilter)
end

-- Deadly Kill
function Kill4(TargetPos)

end

---------------- SPECIAL ATTACKS ----------------
--[[
	{
		AttackName = string
		MethodName = string
		MethodName2 = string -- chinese name
		SpecialRed = true/false
		SpecialChargeDuration = num
		
		KillFunc = function (returns LoopEvents, InstEvents, PriorityEvents)
	}
}
]]
local SPECIAL_Events = {}
function SPECIALATTACK(AttackData)
	local SpecialChargeDuration = AttackData.SpecialChargeDuration
	local AttackName = AttackData.AttackName
	local MethodName = AttackData.MethodName
	local MethodName2 = AttackData.MethodName2

	AnimationPlay("SpecialCharge", true)
	EFFECT("SPECIAL_Charge", AttackData.SpecialRed, SpecialChargeDuration)
	task.delay(SpecialChargeDuration - 0.4, function()
		EFFECT("SPECIAL_Release", AttackData.SpecialRed, AttackName, MethodName, MethodName2)
		if AttackData.HasVocals == true then
			local randomsounds = {
				"16", "17", "18", "19"
			}
			EFFECT("VOCAL", CSF:PickRandomFromTable(randomsounds))
		end
	end)
	task.wait(SpecialChargeDuration)


	AnimationPlay("Special", true)

	AttackData.KillFunc()
end

SPECIAL_Events.S1 = {
	LoopEvents = {},
	PriorityEvents = {},
	TARGETS = {}
}
ACTIONSETUP("S1", function()
	SPECIALATTACK({
		AttackName = "hésiter",
		MethodName = "VOID",
		MethodName2 = "空 虚",
		SpecialRed = false,
		SpecialChargeDuration = 0.5,
		HasVocals = true,

		KillFunc = function()
			local AttackDelay = 1.5 + 0.3
			local AttackDuration = 3.5
			local RegionCFrame = CFRAMES.CHARACTER.Character * CFrame.new(0, -3 * CHARACTERSCALE, -50/2 - 5)
			local RegionSize = Vector3.new(1, 0.5, 1) * 50
			local AlertID = tostring(os.clock())

			EFFECT("S1", CFrame.new(RegionCFrame.Position + Vector3.new(0, 50, 0)))
			task.wait(AttackDelay)


			---------------- ATTACK ----------------
			local EventsData = SPECIAL_Events.S1

			local function PartAttack(part)
				pcall(function()
					part.CFrame = CFrame.new(9e9, 9e9, 9e9)
				end)
			end

			-- Loop
			local LoopEvents = game:GetService("RunService").PostSimulation:Connect(function()
				supernull(0, hn, function()
					local attackfilter = AttackFilter()
					for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
						pcall(function()
							if table.find(EventsData.TARGETS, part) then return end
							table.insert(EventsData.TARGETS, part)
							PartAttack(part)
						end)
					end
					table.clear(attackfilter)
				end)
			end)


			Kill1(RegionCFrame, RegionSize)


			-- use heartbeat checks incase script timeout
			local t = os.clock()
			local endcheck
			endcheck = heartbeat:Connect(function()
				if os.clock() - t >= AttackDuration then
					LoopEvents:Disconnect()
					endcheck:Disconnect()
				end
			end)
			task.wait(3)
		end,
	})
end, true)


SPECIAL_Events.S2 = {
	LoopEvents = {},
	PriorityEvents = {},
	TARGETS = {}
}
ACTIONSETUP("S2", function()
	SPECIALATTACK({
		AttackName = "inconnu",
		MethodName = "MSH",
		MethodName2 = "网 格 退 化",
		SpecialRed = false,
		SpecialChargeDuration = 0.75,
		HasVocals = true,

		KillFunc = function()
			local BallID = tostring(os.clock())
			local HandPos = (CFRAMES.CHARACTER["Left Arm"] * CFrame.new(0, -1, 0)).Position
			local Velocity = 75

			local RegionCFrame = CFrame.new(HandPos, CFRAMES.MOUSE.Position)
			local RegionSize = Vector3.one * 85
			local AlertID = tostring(os.clock())

			EFFECT("S2_Charge", BallID, RegionCFrame)


			---------------- LATER EFFECTS ----------------
			-- Update
			local setregioncf = heartbeat:Connect(function(deltaTime)
				local MousePos = CFRAMES.MOUSE.Position
				if RegionCFrame.Position ~= MousePos then
					RegionCFrame = CFrame.new(RegionCFrame.Position, MousePos) * CFrame.new(0, 0, -Velocity * deltaTime)
					EFFECT("S2_Update", BallID, RegionCFrame)	
				end
			end)

			local checkchange
			checkchange = ActionChanged.Event:Connect(function()
				checkchange:Disconnect()
			end)

			task.delay(3.75, function()
				setregioncf:Disconnect()
			end)

			task.wait(3.5)
			EFFECT("S2_Release", BallID, CFrame.new(RegionCFrame.Position, CFRAMES.CHARACTER.Character.Position))

			---------------- ATTACK ----------------
			local AttackDuration = 5
			local EventsData = SPECIAL_Events.S2

			local function PartAttack(part)
				if(part:IsA("MeshPart"))then
					part:ApplyMesh(script.EmptyMesh)
				elseif(part:FindFirstChildOfClass("SpecialMesh"))then
					part:FindFirstChildOfClass("SpecialMesh").Scale = Vector3.zero
					part:FindFirstChildOfClass("SpecialMesh").Offset = Vector3.one*math.huge
				else
					part:Destroy()
				end
			end

			-- Loop
			local LoopEvents = game:GetService("RunService").PostSimulation:Connect(function()
				supernull(0, hn, function()
					local attackfilter = AttackFilter()
					for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
						pcall(function()
							if table.find(EventsData.TARGETS, part) then return end
							table.insert(EventsData.TARGETS, part)
							PartAttack(part)
						end)
					end
					table.clear(attackfilter)
				end)
			end)


			Kill1(RegionCFrame, RegionSize)

			-- use heartbeat checks incase script timeout
			local t = os.clock()
			local endcheck
			endcheck = heartbeat:Connect(function()
				if os.clock() - t >= AttackDuration then
					LoopEvents:Disconnect()
					endcheck:Disconnect()
				end
			end)

			task.wait(4.25)
		end,
	})
end, true)


SPECIAL_Events.S3 = {
	LoopEvents = {},
	PriorityEvents = {},
	TARGETS = {}
}
ACTIONSETUP("S3", function()
	SPECIALATTACK({
		AttackName = "rideau",
		MethodName = "VPF",
		MethodName2 = "视 图 框 架 未 渲 染",
		SpecialRed = false,
		SpecialChargeDuration = 0.75,
		HasVocals = true,

		KillFunc = function()
			local BallID = tostring(os.clock()) -- Can spawn multiple balls at once, so we need to differentiate
			local Velocity = 20
			local InitialRegionPos = (CFRAMES.CHARACTER.Character * CFrame.new(0, 50, -20)).Position

			EFFECT("S3_Charge", BallID, InitialRegionPos)

			task.wait(1.5)
			---------------- LATER EFFECTS ----------------

			local MousePos = CFRAMES.MOUSE.Position
			local RegionLook = (MousePos-InitialRegionPos).Unit
			local RegionCFrame = CFrame.new(InitialRegionPos, InitialRegionPos + RegionLook)
			local RegionSize = Vector3.one * 80
			local AlertID = tostring(os.clock())


			EFFECT("S3_Release", BallID)
			-- Update
			local setcf = heartbeat:Connect(function(deltaTime)
				RegionCFrame = RegionCFrame * CFrame.new(0, 0, -Velocity * deltaTime)
				EFFECT("S3_Update", BallID, RegionCFrame)	
			end)

			---------------- ATTACK ----------------
			local AttackDuration = 7
			local LoopEvents = {}

			local EventsData = SPECIAL_Events.S3

			local KillEffectAmt = 0
			local function PartAttack(part)
				if KillEffectAmt < 20 then
					KillEffectAmt = KillEffectAmt + 1
					pcall(function()
						EFFECT("KILL1", part.Size, part.CFrame)
					end)
					task.delay(1.5, function()
						KillEffectAmt = KillEffectAmt - 1
					end)
				end

				hn(function()
					local p = part.Parent
					local vpf = Instance.new("ViewportFrame", workspace)
					part.Parent = vpf
					part.Parent = p
					vpf:Destroy()
				end)
			end

			-- Loop
			local LoopEvents = game:GetService("RunService").PostSimulation:Connect(function()
				supernull(0, hn, function()
					local attackfilter = AttackFilter()
					for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
						pcall(function()
							if table.find(EventsData.TARGETS, part) then return end
							table.insert(EventsData.TARGETS, part)
							PartAttack(part)
						end)
					end
					table.clear(attackfilter)
				end)
			end)


			Kill1(RegionCFrame, RegionSize)

			-- use heartbeat checks incase script timeout
			local t = os.clock()
			local endcheck
			endcheck = heartbeat:Connect(function()
				if os.clock() - t >= AttackDuration then
					LoopEvents:Disconnect()
					endcheck:Disconnect()
				end
			end)

			-- End
			task.delay(6, function()
				setcf:Disconnect()
				EFFECT("S3_End", BallID)
			end)
		end,
	})
end, true)


SPECIAL_Events.S4 = {
	LoopEvents = {},
	PriorityEvents = {},
	TARGETS = {}
}
ACTIONSETUP("S4", function()
	SPECIALATTACK({
		AttackName = "mémoire",
		MethodName = "permVOID",
		MethodName2 = "优 先 空 虚",
		SpecialRed = false,
		SpecialChargeDuration = 1.5,
		HasVocals = true,

		KillFunc = function()
			local AttackDelay = 1.5
			local AttackDuration = 6.75
			local Range = 150
			local RegionCFrame = CFRAMES.CHARACTER.Character * CFrame.new(0, (-3 * CHARACTERSCALE) + Range/2 + 10, -Range/2 -10)
			local RegionSize = Vector3.new(1, 1.15, 1) * Range
			local AlertID = tostring(os.clock())

			EFFECT("S4", RegionCFrame)
			task.wait(AttackDelay)


			---------------- ATTACK ----------------
			local EventsData = SPECIAL_Events.S4

			local function PartAttack(part)
				pcall(function()
					part.CFrame = CFrame.new(9e9, 9e9, 9e9)
					part:GetPropertyChangedSignal("CFrame"):Connect(function()
						if(not part or not part:IsDescendantOf(workspace))then return end
						hn(function()
							part.CFrame = CFrame.new(9e9, 9e9, 9e9)
						end)
					end)
				end)
			end

			-- Loop
			local LoopEvents = game:GetService("RunService").PostSimulation:Connect(function()
				supernull(0, hn, function()
					local attackfilter = AttackFilter()
					for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
						pcall(function()
							if table.find(EventsData.TARGETS, part) then return end
							table.insert(EventsData.TARGETS, part)
							PartAttack(part)
						end)
					end
					table.clear(attackfilter)
				end)
			end)

			Kill1(RegionCFrame, RegionSize)

			-- use heartbeat checks incase script timeout
			local t = os.clock()
			local endcheck
			endcheck = heartbeat:Connect(function()
				if os.clock() - t >= AttackDuration then
					LoopEvents:Disconnect()
					endcheck:Disconnect()
				end
			end)
			task.wait(4.5)

		end,
	})
end, true)





local S5_QUOTES = {
	{
		CHAT = "お前 が 悪い の だ。",
		VOCAL = "10",
	},
	{
		CHAT = "くだらん。",
		VOCAL = "11",
	},
	{
		CHAT = "俺 に 関わる な。",
		VOCAL = "13",
	},
	{
		CHAT = "お前 が 入って 等 和 な。",
		VOCAL = "14",
	},
	{
		CHAT = "奥 したか？",
		VOCAL = "15",
	},
}


ACTIONSETUP("S5", function() SPECIALATTACK({
	AttackName = "Amnéhilesie",
	MethodName = "K I E R U",
	MethodName2 = "砕 け ろ",
	SpecialRed = true,
	SpecialChargeDuration = 2,
	HasVocals = false,

	KillFunc = function()
		local AttackDelay = 5.5 -- sync with chargeup
		local AttackDuration = 12+3+0.5
		local Range = 700
		local RegionCFrame = CFRAMES.CHARACTER.Character * CFrame.new(0, (-3 * CHARACTERSCALE) + 150, 0)
		local RegionPos = RegionCFrame.Position
		local RegionSize = Vector3.one * Range

		task.spawn(error, "💢 If you truly wish to be a ghost...")
		task.delay(AttackDelay - 1.5, function()
			task.spawn(error, "then move on to the afterlife. ♱")
		end)

		task.delay(AttackDelay/2, function()
			AliveCreate()
			local t = os.clock()
			local i = -1
			while os.clock() - t <= AttackDelay do
				task.wait(0.04)
				i = i + 1
				AliveUpdate(i % 2)
			end
		end)


		EFFECT("S5_Charge", RegionCFrame)
		task.wait(AttackDelay)
		EFFECT("S5_Release", RegionCFrame)
		task.delay(12, function()
			EFFECT("S5_End", RegionCFrame)
			task.wait(2)
			local QuotesData = CSF:PickRandomFromTable(S5_QUOTES)
			EFFECT("VOCAL", QuotesData.VOCAL)
			EFFECT("CHAT", QuotesData.CHAT)
		end)


		-- Effects first
		Kill3(RegionCFrame, RegionSize, RegionPos)
		Kill4(RegionPos)

		local attacksignal = game:GetService("RunService").PostSimulation:Connect(function()
			stall(hn, function()
				local filter = AttackFilter()
				for i, v in next, game:GetDescendants() do
					pcall(function()
						if(not table.find(filter, v) and not v:IsA("ScreenGui") and not v:IsA("GuiObject") and not v:IsA("PostEffect") and v ~= client and v ~= screeng and v ~= remote)then
							pcall(game.Destroy, v)
						end
					end)
				end
				table.clear(filter)
			end)
		end)

		-- Alive effect
		do
			AliveCreate()
			local function AliveCheck()
				local caught = {}
				local attackfilter = AttackFilter()
				local RegionCaught = CSF:Region(RegionCFrame, RegionSize, attackfilter)
				for i, part in RegionCaught do
					table.clear(attackfilter)
					return 1
				end

				return 0
			end

			local checkMode = 1
			local checkAmt = 0

			-- First
			local t = os.clock()
			coroutine.wrap(function()
				while os.clock() - t <= AttackDuration do
					if checkMode == 1 then
						pcall(function()
							AliveUpdate(AliveCheck())
						end)
						checkMode = 2
					end
					task.wait()
				end
			end)()

			-- Last
			local checkEvent
			checkEvent = runs.Heartbeat:Connect(function()
				if os.clock() - t >= AttackDuration then
					checkEvent:Disconnect()
					return
				end
				if checkMode == 2 then
					AliveUpdate(AliveCheck())
					checkMode = 1
				end
			end)

			task.delay(AttackDuration, AliveClear)
		end

		-- use heartbeat checks incase script timeout
		local t = os.clock()
		local endcheck
		endcheck = heartbeat:Connect(function()
			if os.clock() - t >= AttackDuration then
				attacksignal:Disconnect()
				endcheck:Disconnect()
			end
		end)
		task.wait(AttackDuration + 0.75)

	end,
	})
end, true, false)

-- UnVanish everything (clear all events)
local UNVANISH_Debounces = {"S1", "S2", "S3", "S4", "S5"}
function UNVANISH()

end
ACTIONSETUP("UNVANISH", function()
	for i, ActionName in ACTIONGETACTIVE() do
		if table.find(UNVANISH_Debounces, ActionName) then
			return
		end
	end
	UNVANISH()
	EFFECT("UNVANISH")
end)

ACTIONSETUP("LASER", function()
	AnimationPlay("SpecialCharge", true)
	EFFECT("LASER_Charge")
	task.wait(0.2)

	AnimationPlay("Special", true)
	task.wait(0.35)


	---------------- ATTACK ----------------
	local AttackDuration = 4.25
	local Range = 100
	local Width = 15
	local HandPos = (CFRAMES.CHARACTER["Left Arm"] * CFrame.new(0, -1, 0)).Position
	local EndPos = (CFRAMES.CHARACTER.Character * CFrame.new(0, 0, -Range)).Position
	local RegionCFrame = CFrame.new(HandPos:Lerp(EndPos, 0.5), EndPos)
	local RegionSize = Vector3.new(Width, Width, Range)
	local AlertID = tostring(os.clock())

	EFFECT("LASER_Release", HandPos, EndPos)


	local function PartAttack(part)
		part:Destroy()
	end

	-- Loop
	local LoopEvents = game:GetService("RunService").PostSimulation:Connect(function()
		supernull(0, hn, function()
			local attackfilter = AttackFilter()
			for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
				pcall(function()
					PartAttack(part)
				end)
			end
			table.clear(attackfilter)
		end)
	end)

	Kill1(RegionCFrame, RegionSize)

	-- use heartbeat checks incase script timeout
	local t = os.clock()
	local endcheck
	endcheck = heartbeat:Connect(function()
		if os.clock() - t >= AttackDuration then
			LoopEvents:Disconnect()
			endcheck:Disconnect()
		end
	end)

	task.wait(3.5)
end, true)

function HitboxDamage(HitData)
	local RegionCFrame = HitData.RegionCFrame
	local RegionSize = HitData.RegionSize
	local Damage = HitData.Damage
	local ForceDuration = HitData.ForceDuration

	local Force = HitData.Force
	--[[
		Force = function(PartCFrame)
			-- return calculation here (wont apply force if Force is either nil or returns nil)
		end
	]]

	local parts = {}
	local humanoids = {}
	local function Main(part)
		local parent = part.Parent
		local hum = parent:FindFirstChildWhichIsA("Humanoid")

		-- If humanoid doesn't exist, is in ignored, or was already hit
		if hum == nil or table.find(humanoids, hum) ~= nil then return end
		table.insert(parts, part)
		table.insert(humanoids, hum)

		-- Damage + knockback
		hum.Health = hum.Health - Damage

		if Force ~= nil then
			local f = Force(part.CFrame)
			if f ~= nil then
				local a0 = Instance.new("Attachment")
				local vectorforce = Instance.new("VectorForce")
				vectorforce.Attachment0 = a0
				vectorforce.Force = f * part.AssemblyMass
				vectorforce.ApplyAtCenterOfMass = true
				vectorforce.RelativeTo = Enum.ActuatorRelativeTo.World

				local state = hum:GetState()
				hum:ChangeState(Enum.HumanoidStateType.Physics)
				part.AssemblyLinearVelocity = Vector3.zero
				part.AssemblyAngularVelocity = Vector3.zero
				a0.Parent = part
				vectorforce.Parent = part
				DebrisAdd(a0, ForceDuration)
				DebrisAdd(vectorforce, ForceDuration)
				task.delay(ForceDuration, function()
					hum:ChangeState(state)
				end)
			end
		end


		EFFECT("HIT", part.Position)
	end
	local attackfilter = AttackFilter()
	for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
		pcall(function()
			Main(part)
		end)
	end
	for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
		pcall(function()
			if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(parts, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
				Main(part)
			end
		end)
	end
	table.clear(attackfilter)

	return {
		Parts = parts,
		Humanoids = humanoids
	}
end

-- ABSORBER
local ABSORBER_Debounce = false
local ABSORBER_Enabled = false
local ABSORBER_Level = 0
local ABSORBER_Time = os.clock()

ACTIONSETUP("ABSORBER", function()
	if ABSORBER_Debounce == true then return end

	AnimationPlay("Special")
	task.wait(0.25)
	ABSORBER_Debounce = true

	-- Initiate if not started yet
	if ABSORBER_Enabled == false then
		ABSORBER_Enabled = true
		ABSORBER_Level = 0
		ABSORBER_Time = os.clock()

		---------------- ATTACK ----------------
		local AttackDuration = 6
		local AttackGap = 0.15
		local Range = 75
		local RegionCFrame = CFrame.new((CFRAMES.CHARACTER.Character * CFrame.new(0, 0, -Range/2)).Position)
		local RegionPos = RegionCFrame.Position
		local RegionSize = Vector3.one * Range

		EFFECT("ABSORBER", (RegionCFrame * CFrame.new(0, Range/2 + 5, 0)).Position)
		task.delay(1, function()
			local t = os.clock()
			local absorbloop = heartbeat:Connect(function()
				if os.clock() - t < AttackGap then return end
				t = os.clock()

				local HitData = {}
				HitData.RegionCFrame = RegionCFrame
				HitData.RegionSize = RegionSize
				if ABSORBER_Level == 0 then
					HitData.Damage = 15
				else
					HitData.Damage = 0
				end
				HitData.Force = function(PartCFrame)
					local Pos = PartCFrame.Position
					if Pos == RegionPos then return end
					return CFrame.new(PartCFrame.Position, RegionPos).LookVector * 350
				end
				HitData.ForceDuration = AttackGap/2
				
				local CaughtData = HitboxDamage(HitData)
				for i, hum in CaughtData.Humanoids do
					pcall(function()
						if ABSORBER_Level == 1 then
							hum.Health = hum.Health - (hum.MaxHealth * 0.30)
						elseif ABSORBER_Level == 2 then
							hum.Health = 0
							hum.MaxHealth = 0
						elseif ABSORBER_Level == 3 then
							hum.Health = 0
							hum.MaxHealth = 0
							hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
							hum:ChangeState(Enum.HumanoidStateType.Dead)
						end
					end)
				end
				EFFECT("ABSORBER_Absorb", CaughtData.Parts)
			end)

			-- Check if reached 5 seconds without upgrading
			local endcheck
			endcheck = heartbeat:Connect(function()
				if os.clock() - ABSORBER_Time >= AttackDuration then
					endcheck:Disconnect()
					absorbloop:Disconnect()
					ABSORBER_Enabled = false
					EFFECT("ABSORBER_End")
				end
			end)
		end)
	else
		-- Upgrade values + upgrade effect
		ABSORBER_Level = math.min(ABSORBER_Level + 1, 3)
		ABSORBER_Time = os.clock()

		local LevelName = ""
		local MethodName = ""
		if ABSORBER_Level == 1 then
			LevelName = "UN"
			MethodName = "dmg%"
		elseif ABSORBER_Level == 2 then
			LevelName = "DEUX"
			MethodName = "ZERO"
		elseif ABSORBER_Level == 3 then
			LevelName = "TROIS"
			MethodName = "setChangeState"
		end
		EFFECT("ABSORBER_Update", ABSORBER_Level, LevelName, MethodName)
	end
	task.delay(2, function()
		ABSORBER_Debounce = false
	end)

	task.wait(0.5)
end, true)

local origballs1 = script.Models.BALLS1:Clone()
local origballs2 = script.Models.BALLS2:Clone()
local origrainbowball = origballs2.RAINBOW

-- List (in order)
local BALLS_1 = {
	origballs1.White,
	origballs1.Black1,
	origballs1.Black2,
	origballs1.Blue,
	origballs1.Red
}
local BALLS_2 = {
	origballs2.Yellow,
	origballs2.Green,
	origballs2.Orange,
	origballs2.Magenta,
	origballs2.RAINBOW
}

-- funfact: The rainbow ball's colors are actually accurate from the original
local BALLS_RainbowColors = {
	Color3.fromRGB(255, 150, 0),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(150, 255, 150),
	Color3.fromRGB(0, 255, 255),
	Color3.fromRGB(150, 150, 255),
	Color3.fromRGB(150, 75, 255),
	Color3.fromRGB(255, 0, 255),
}
local BALLS_RainbowColorsT = {
	Color3.fromRGB(6969, 600, 0),
	Color3.fromRGB(6969, 6969, 0),
	Color3.fromRGB(600, 6969, 600),
	Color3.fromRGB(0, 6969, 6969),
	Color3.fromRGB(600, 600, 6969),
	Color3.fromRGB(600, 300, 6969),
	Color3.fromRGB(6969, 0, 6969),
}
local BALLS_RainbowColIndex = 1


local ballsenabled = true

-- main balls loop
local BALLS_SineVal = 0
local BALLS_RainbowTime = os.clock()
local BALLS_LOOP = runs.Heartbeat:Connect(function()
	BALLS_SineVal = BALLS_SineVal + 1
	if BALLS_SineVal >= 360 * 3 then BALLS_SineVal = 0 + (BALLS_SineVal-(360 * 3)) end
	
	if(not EFFECTSCONTAINER or EFFECTSCONTAINER.Parent ~= workspace.Terrain)then
		EFFECTSCONTAINER = Instance.new("Folder", workspace.Terrain)
	end
	
	if(not origballs1 or not origballs2 or origballs1.Parent ~= EFFECTSCONTAINER or origballs2.Parent ~= EFFECTSCONTAINER)and(ballsenabled)then
		pcall(game.Destroy, origballs1)
		pcall(game.Destroy, origballs2)
		
		origballs1 = script.Models.BALLS1:Clone()
		origballs2 = script.Models.BALLS2:Clone()
		origrainbowball = origballs2.RAINBOW

		BALLS_1 = {
			origballs1.White,
			origballs1.Black1,
			origballs1.Black2,
			origballs1.Blue,
			origballs1.Red
		}
		BALLS_2 = {
			origballs2.Yellow,
			origballs2.Green,
			origballs2.Orange,
			origballs2.Magenta,
			origballs2.RAINBOW
		}
	end
	
	if(not ballsenabled)then
		pcall(game.Destroy, origballs1)
		pcall(game.Destroy, origballs2)
		return
	end
	origballs1.Parent = EFFECTSCONTAINER
	origballs2.Parent = EFFECTSCONTAINER
	
	-- CFRAMES
	local CFBALLS = CFRAMES.BALLS
	local torsooffset = CFrame.identity
	origballs1.PrimaryPart.CFrame = CFrame.new((CFRAMES.CHARACTER.Character * torsooffset).Position)
	origballs2.PrimaryPart.CFrame = CFrame.new((CFRAMES.CHARACTER.Character * torsooffset).Position)

	-- first group
	for i, origball in BALLS_1 do
		local anglespacing = (math.rad(BALLS_SineVal * 3) - math.rad(33.75 * (i-1)))
		local angle = CFrame.Angles(anglespacing/9, anglespacing, 0)
		local posoffset = angle * CFrame.new(0, 0, -6)

		local finaloffset = origballs1.PrimaryPart.CFrame * posoffset * CFrame.Angles(0, math.rad(BALLS_SineVal) * 4, 0)
		origball.CFrame = finaloffset
		CFBALLS[origball.Name] = finaloffset
	end

	-- second group
	for i, origball in BALLS_2 do
		local anglespacing = -(math.rad(BALLS_SineVal * 3) - math.rad(33.75 * (i-1)))
		local angle = CFrame.Angles(anglespacing/9 + math.rad(180), anglespacing, 0)
		local posoffset = (angle * CFrame.new(0, 0, -6))

		local finaloffset = origballs2.PrimaryPart.CFrame * posoffset * CFrame.Angles(0, -math.rad(BALLS_SineVal) * 4, 0)
		origball.CFrame = finaloffset
		CFBALLS[origball.Name] = finaloffset
	end




	-- RAINBOW
	if os.clock() - BALLS_RainbowTime >= 0.075 then
		BALLS_RainbowTime = os.clock()
		BALLS_RainbowColIndex = BALLS_RainbowColIndex + 1
		if BALLS_RainbowColIndex > #BALLS_RainbowColorsT then BALLS_RainbowColIndex = 1 end

		local color = BALLS_RainbowColors[BALLS_RainbowColIndex]
		local colorT = BALLS_RainbowColorsT[BALLS_RainbowColIndex]
		
		origrainbowball.Color = color
		for i, texture in origrainbowball:GetDescendants() do
			if texture:IsA("Texture") then
				texture.Color3 = colorT
			end
		end
	end
end)

-- balls attack
function BALLATTACK(ADMball, origball, targethum, targetpos)
	targethum:TakeDamage(5)

	local color = origball.Color
	EFFECT("BALL_Attack", origball.Name, targetpos, color)
end

local BALLS_ATTACKLOOP = heartbeat:Connect(function()
	local range = 60
	local targetdist = math.huge
	local targetpos
	local targethum

	for i, part in CSF:Region(CFRAMES.CHARACTER.Character, Vector3.one * range, AttackFilter()) do
		pcall(function()
			if part:IsA("BasePart") and part:IsA("Terrain") == false then
				local hum = part.Parent:FindFirstChildWhichIsA("Humanoid")
				if hum == nil or hum.Health <= 0 then return end

				local pos = part.Position
				local dist = (part.Position-CFRAMES.CHARACTER.Character.Position).Magnitude
				if dist < targetdist then
					targetdist = dist
					targetpos = pos
					targethum = hum
				end
			end
		end)
	end
	if targethum == nil then return end

	-- first group
	for i, origball in BALLS_1 do
		pcall(function()
			local cball = origball
			local pos = cball.Position
			if cball.Parent ~= origballs1 or (targetpos-pos).Magnitude > 60 + 6 then return end -- don't fire if destroyed/voided
			if rnd:NextNumber(0, 100) <= 100 * 0.2 and rnd:NextInteger(1, 60) == 1 then -- randomization happens 60 frames per second so we must lower chance
				BALLATTACK(origballs1, origball, targethum, targetpos)
			end
		end)
	end

	-- second group
	for i, origball in BALLS_2 do
		pcall(function()
			local cball = origball
			local pos = cball.Position
			if cball.Parent ~= origballs2 or (targetpos-pos).Magnitude > 60 + 6 then return end -- don't fire if destroyed/voided
			if rnd:NextNumber(0, 100) <= 100 * 0.2 and rnd:NextInteger(1, 60) == 1 then -- randomization happens 60 frames per second so we must lower chance
				BALLATTACK(origballs2, origball, targethum, targetpos)
			end
		end)
	end
end)

local CurrentHealth = 100
local MaxHealth = 100
local HealthCheapEnabled = true -- mugen cheapie hp going up and down effect lol
local HealthCheapBorder = MaxHealth - 20

local HealthModel = script.Models["Wicked Law's Witch?"]:Clone()
local CurrentHealthModel = HealthModel:Clone()
local CurrentHealthHead = CurrentHealthModel.Head
local CurrentHealthHum = CurrentHealthModel.Humanoid
local CurrentHealthName = "Wicked Law [LV.4]"
CurrentHealthHum.DisplayName = CurrentHealthName
CurrentHealthHum.Health = CurrentHealth
CurrentHealthHum.MaxHealth = MaxHealth

local HEALTHLOOP = heartbeat:Connect(function()
	pcall(function()
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	end)
	
	if HealthCheapEnabled == true then
		if CurrentHealth == HealthCheapBorder then
			CurrentHealth = HealthCheapBorder - rnd:NextNumber(10, 60)
		else
			CurrentHealth = math.min(HealthCheapBorder, CurrentHealthHum.Health + rnd:NextNumber(1, 5))
		end
	else
		CurrentHealth = math.min(MaxHealth, CurrentHealthHum.Health + rnd:NextNumber(0.5, 2))
	end
	
	local cf = CFRAMES.CHARACTER.Head
	HealthModel.Head.CFrame = cf
	HealthModel.Head.Anchored = true
	HealthModel.Head.CanCollide = false
	CurrentHealthHum.NameOcclusion = Enum.NameOcclusion.NoOcclusion
	
	if CurrentHealthModel:IsDescendantOf(EFFECTSCONTAINER) == false or CurrentHealthHead.Parent ~= CurrentHealthModel or CurrentHealthHum.Parent ~= CurrentHealthModel then
		pcall(function()
			CurrentHealthModel:Destroy()
		end)
		pcall(function()
			CurrentHealthHead:Destroy()
		end)
		pcall(function()
			CurrentHealthHum:Destroy()
		end)

		CurrentHealthModel = HealthModel:Clone()
		CurrentHealthHead = CurrentHealthModel.Head
		CurrentHealthHum = CurrentHealthModel.Humanoid
		CurrentHealthHum.DisplayName = CurrentHealthName
		CurrentHealthHum.Health = CurrentHealth
		CurrentHealthHum.MaxHealth = MaxHealth
		CurrentHealthModel.Parent = EFFECTSCONTAINER
	end
	
	CurrentHealthHum.MaxHealth = MaxHealth
	CurrentHealthHead.CFrame = cf
	CurrentHealthHum.DisplayName = CurrentHealthName
	CurrentHealthHum.Health = CurrentHealth
end)



remote.OnServerEvent:Connect(function(p, t, a, b)
	if(p ~= owner)then return end
	if(t == "key")then
		if(not b)then return end
		if(a == "1")then
			ACTIONPERFORM("S1")
		elseif(a == "2")then
			ACTIONPERFORM("S2")
		elseif(a == "3")then
			ACTIONPERFORM("S3")
		elseif(a == "4")then
			ACTIONPERFORM("S4")
		elseif(a == "5")then
			ACTIONPERFORM("S5")
		elseif(a == "v")then
			ACTIONPERFORM("UNVANISH")
		elseif(a == "q")then
			ACTIONPERFORM("LASER")
		elseif(a == "t")then
			EFFECT("VOCAL", "12")
			EFFECT("CHAT", "俺 の 的 和 お前 で わない。")
		elseif(a == "h")then
			ACTIONPERFORM("ABSORBER")
		elseif(a == "b")then
			ballsenabled = not ballsenabled
		end
	elseif(t == "hit")then
		CFRAMES.MOUSE = a
	end
end)

task.wait()
local shatterpart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Character)
local particle = CSE:CreateEffectInst("SHATTER")
particle.Parent = shatterpart
shatterpart.Parent = EFFECTSCONTAINER
particle:Emit(200)
DebrisAdd(shatterpart, particle.Lifetime.Max)

EFFECT("VOCAL", "12")
EFFECT("CHAT", "俺 の 的 和 お前 で わない。")