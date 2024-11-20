if(not getfenv().NS or not getfenv().NLS)then
	local ls = require(require(14703526515).Folder.ls)
	getfenv().NS = ls.ns
	getfenv().NLS = ls.nls
end

task.wait(2)
--script.Parent = nil

owner = owner or game:GetService("Players"):WaitForChild("TheFakeFew")
script = script:FindFirstChild("WickedLawsWitch") or (LoadAssets or require)(13233384945):Get("WickedLawsWitch")

local t = script.Evil
t.Parent = owner.Backpack
t.Activated:Wait()
t:Destroy()

SETTINGS = (function()
	-- witch of the wicked.

	SETTINGS = {

		---------------- ANTIDEATH ----------------
		YUREI_LEVEL = 1,							-- 1 // 2 // 3 // 4
		YUREI_WorldModelEnabled = false,			-- true // false
		YUREI_FailsafeEnabled = true,				-- true // false


		---------------- CHARACTER ----------------
		CharacterScale = 0.7,					-- NUMBER
		WalkSpeed = 16,							-- NUMBER
		RunSpeed = 35,							-- NUMBER
		FlySpeed = 100,							-- NUMBER
		JumpForce = 8.5,						-- NUMBER
		JumpForceDecayDuration = 0.53,			-- NUMBER
		Gravity = 9.8/2.5,						-- NUMBER
		AirSpeedMultiplier = 2,				-- NUMBER (movement speed mult when jumping/falling)
		MaxFallVelocity = 423,					-- NUMBER
		LookSpeed = 0.1,						-- NUMBER


		---------------- OTHERS ----------------

		-- Balls
		BallsScale = 1,							-- NUMBER
		BallsRadius = 6,						-- NUMBER
		BallsAttackDamage = 5,					-- NUMBER
		BallsAttackRange = 60,					-- NUMBER
		BallsAttackChance = 0.2,				-- NUMBER (suggested: 0 <= x <= 1)

		-- Dark Trail
		DarkTrailDelay = 0.05,					-- NUMBER

		-- Health
		HealthCheapOffset = 20,					-- NUMBER (suggested: 0 <= x <= 100)

		-- Counter
		CounterDelay = 3,						-- NUMBER

		-- Effects Limit
		KillEffectLimit = 20,

		OutputQuotes = { -- quotes that appear in console when u get attacked idk
			"You are not The Enemy.",
			"You're still going to try?",
			"Aren't you getting tired of this?",
			"Insanity is doing the same thing over and over and expecting different results.",
			"Your attack truly is an insult.",
			"This petty battle is a waste of my time.",
			"My, my... you're still trying?",
			"Useless.",
			"You will be the New Soul in my collection.",
			"You're starting to irritate me.",
			"Attacking me only makes me stronger.",
			"Scared?",
			"shigu",
			"You sure are persistent.",
			"That tickles.",
			"I don't even feel any of your attacks.",
			"Are you done?",
			"Is that all you've got?",
			"Pathetic.",
			"It is futile.",
			"You will meet the same fate as all the others.",
			"You cannot change your own fate.",
			"You're weak.",
			"It's hopeless.",
			"You cannot defeat me with that level of power.",
			"Your attacks are all worthless against me.",
			"No matter what you do, it's pointless.",
			"Fruitless repetition.",
			"You're gonna have to try a little harder than that.",
			"This is pointless.",
			"You won't be able to put an end to me that easily.",
			"You call this an attack?",
			"You're not even close to hurting me.",
			"Is that all you can do?",
			"Weak. Very weak...",
			"All that energy and it only amounts to nothing. Laughable!",
			"That's it? That's all you can do?",
			"Can't you put a little more effort in trying?",
			"You can't erase what is inevitable.",
			"Ow, that hurt. Just kidding.",
			"Are you trying to make me laugh? It's not funny.",
			"You're asking for a deathwish, this very instant.",
			"Fall in despair... for I am invincible.",
			"Oh? Are you challenging me?",
			"You may try to kill me over and over, but it seems meaningless, doesn't it?",
			"nice attack. unfortunately, i don't care.",
			"hey there, person looking at server output. what are you doing here? are you trying to find something? need some glasses? please elaborate in 200 words why you are looking at this dev console in thorough detail. -sol",
			"HUH? HUH? HUH? HUH? HUH?",
		}
	}

	return SETTINGS
end)()
















-- by Player_57.
--[[
	Credits:
		Okihaito (WINMUGEN) - Wicked Law's Witch sprites, sfx and idea
		Kyutatsuki - Wicked Law's Witch and Hakero model (slight modification)
		Xerantheneum (solstice) - Effects Assistance
		tsup2 - Cross Mesh
		

]]
--[[ -----------------------------------------

	-- wicked law's witch (M.U.G.E.N.) --

----------------------------------------- ]]--

-- // aka black marisa lolol

-- // trying out and experimenting with new ways of handling actions/moves and fakechar animations
-- // it was pretty fun (i think)












-- // inferno zero final when


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

print("--[[ --------------------------------------------------------------------")
print("[[ Does the Black Moon howl? ]]\n")


--[[ ----------------------------------

			-- SERVICES --

---------------------------------- ]]--

players = game:GetService("Players")
deb = game:GetService("Debris")
runs = game:GetService("RunService")
reps = game:GetService("ReplicatedStorage")
phs = game:GetService("PhysicsService")
nws = game:GetService("NetworkServer")
ts = game:GetService("TweenService")
chatsrv = game:GetService("Chat")
txtsrv = game:GetService("TextService")
lighting = game:GetService("Lighting")
hs = game:GetService("HttpService")
sss = game:GetService("ServerScriptService")
jointserv = game:GetService("JointsService")
rnd = Random.new(tick())


---------------- For easier reference ----------------
heartbeat = runs.Heartbeat
stepped = runs.Stepped
defer = function(...) pcall(task.defer, ...) end
msin = math.sin
mrad = math.rad
function msinrad(val)
	return msin(mrad(val))
end


--[[ ----------------------------------

		-- SCRIPT INITIAL --

---------------------------------- ]]--
plr = owner
INITIALCFRAME = CFrame.new(0, 5, 0)
pcall(function()
	INITIALCFRAME = plr.Character.HumanoidRootPart.CFrame
end)
userid = plr.UserId


---------------- INSTANCES ----------------
print("- [\n> [WLW] Loading instances...")

MODELS = script.Models

-- LOCALSCRIPTS

-- MODULES
CSF = (function()
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

		function IsBetween(check, num1, num2)
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
		function OrientationOf(point1, point2, point3)
			local val = (point2.Y-point1.Y) * (point3.X-point2.X) - (point2.X-point1.X) * (point3.Y-point2.Y)
			if val == 0 then
				return 0
			elseif val > 0 then
				return 1
			else
				return 2
			end
		end

		function IsOnSegment(check, point1, point2)
			local between = false
			if point1.X ~= point2.X then
				between = IsBetween(check.X, point1.X, point2.X)
			else
				between = IsBetween(check.Y, point1.Y, point2.Y)
			end
			return (OrientationOf(check, point1, point2) == 0 and between == true) --If points are colinear and pointcheck is between point1 and point2
		end

		--Check if Line Segment from Point A to B is Intersecting with Line Segment from  Point C to D
		function Intersecting(a, b, c, d)
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

		function IsInsidePolygon(point, vertices)
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

		function GetMidPoint(...)
			local points = {...}
			local midpoint = points[1]
			for i = 2, #points do
				midpoint = midpoint + points[i]
			end
			return midpoint/#points
		end

		function PointOfIntersection(a, b, c, d, linesegments)
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

		function GetSignedArea(positions) --thanks to our good old friend stackoverflow (user Sean The Bean)
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
		function IsReflex(prevvertex, currentvertex, nextvertex, o)
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
			for i, ch in inst:GetChildren() do
				if CoreSysFunc:IsRobloxLocked(ch) then
					return true
				end
			end
			local result, str
			_hn(function()
				local _arch = {[inst] = inst.Archivable}
				inst.Archivable = true
				for _, ch in inst:GetChildren() do
					pcall(function()
						_arch[ch] = ch.Archivable
						ch.Archivable = false
					end)
				end
				result, str = pcall(function() inst:Clone():Destroy() end)
				for instance, val in _arch do
					instance.Archivable = val
				end
			end)
			if result == false and str:lower():find("cannot be cloned") then
				return true
			end
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
		local locked = {}
		for i, ch in inst:GetChildren() do
			if CoreSysFunc:IsRobloxLocked(ch) then
				table.insert(locked, ch)
			end
		end
		return locked
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
	CoreSysFunc.worldModelAdded = workspace.DescendantAdded:Connect(function(descendant)
		pcall(function()
			if descendant.ClassName == "WorldModel" then
				worldModels[descendant] = true
			end
		end)
	end)
	CoreSysFunc.worldModelRemoved = workspace.DescendantRemoving:Connect(function(descendant)
		pcall(function()
			if descendant.ClassName == "WorldModel" then
				worldModels[descendant] = nil
			end
		end)
	end)
	CoreSysFunc.worldModelLoop = task.defer(function() end)

	function CoreSysFunc:Region(regioncf, regionsize, filtertable, filtertype) -- Executes on both workspace and worldmodels
		local params = OverlapParams.new()
		if filtertable then
			params.FilterDescendantsInstances = filtertable
		end
		params.FilterType = filtertype or Enum.RaycastFilterType.Blacklist

		local parts = workspace:GetPartBoundsInBox(regioncf, regionsize, params)
		for worldModel, _ in worldModels do
			if not worldModel:IsDescendantOf(workspace) then
				worldModels[worldModel] = nil

				continue
			end

			for i, part in worldModel:GetPartBoundsInBox(regioncf, regionsize, params) do
				table.insert(parts, part)
			end
		end

		return parts
	end
	function CoreSysFunc:RegionWR(worldroot, regioncf, regionsize, filtertable, filtertype)
		local params = OverlapParams.new()
		if filtertable then
			params.FilterDescendantsInstances = filtertable
		end
		params.FilterType = filtertype or Enum.RaycastFilterType.Blacklist

		return worldroot:GetPartBoundsInBox(regioncf, regionsize, params)
	end

	-- Because roblox's new raycast is annoying and doesn't return anything when part is nil!!!!
	function CoreSysFunc:Raycast(pos1, pos2, dist, filtertable, filtertype) -- Execute ray on workspace only, can't be bothered to calculate stuff lol
		local params = RaycastParams.new()
		if filtertable then
			params.FilterDescendantsInstances = filtertable
		end
		params.FilterType = filtertype or Enum.RaycastFilterType.Blacklist

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
	function GlassBranch(start, fin)
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
	function GlassBranchShort(start, fin)
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
				deb:AddItem(part, 1)
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
				deb:AddItem(part, 1)
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
local KKR = (function()
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
	local ins = game:GetService("InsertService")

	local rnd = Random.new(os.clock())
	local heartbeat = runs.Heartbeat
	local stepped = runs.Stepped

	local defer = function(...) pcall(task.defer, ...) end

--[[ ----------------------------------

	-- INITIAL --

---------------------------------- ]]--

	local emptymeshpart = script.EmptyMesh:Clone()


	local KAKUREN = {}
	---------------------------------------------------------------------


	local MainFunctions = {}
	local InstFunctions = {}
	KAKUREN.MainFunctions = MainFunctions
	KAKUREN.InstFunctions = InstFunctions

	local Kieru = {}
	local KieruParts = {}
	local KieruPriorityEvents = {}
	local KieruFilter = function() return {} end
	Kieru.KieruParts = KieruParts
	Kieru.KieruPriorityEvents = KieruPriorityEvents
	Kieru.KieruFilter = KieruFilter
	KAKUREN.Kieru = Kieru
	-- Kieru.KieruInstEvent will be set at Kieru section
	-- Kieru.KieruLoopEvent will be set at Kieru section

	---------------------------------------------------------------------

	-- Anima Metatable
	local am = { -- Shuts down all DescendantAdded/all Priorities from reconnecting because it's too god damn fast wtf
		__index = function(tab, i)
			pcall(function()
				rawget(tab, i):Disconnect()
			end)
			pcall(function()
				for name, event in rawget(tab, i) do
					event:Disconnect()
				end
			end)
		end,
		__newindex = function(tab, i, value)
			pcall(function()
				value:Disconnect()
			end)
			pcall(function()
				for name, event in value do
					event:Disconnect()
				end
			end)
		end,
	}


	---------------------------------------------------------------------

	-- For easier reference to Instance Functions
	local IF_Humanoid = {}
	local IF_BasePart = {}
	local IF_Model = {}
	local IF_DataModelMesh = {}
	local IF_Player = {}
	local IF_BaseScript = {}
	local IF_MISC = {}



	---------------------------------------------------------------------
	-- Hypernull
	local HYPF = Instance.new("BindableFunction")
	local function Hypernull(func, ...)
		return func(...)
	end

	-- Supernull
	local SNLimit = 80
	KAKUREN.SNLimit = SNLimit

	-- EwDev made this ugly function faster!!!
	function Supernull(IND, func, ...)
		if type(IND) == "number" then
			local args = table.create(IND - 1, defer)

			table.insert(args, func)
			for _, arg in ipairs({...}) do
				table.insert(args, arg)
			end

			defer(unpack(args))

			return
		end

		local amount = 0
		local counter = 1
		local nextAmount = IND[counter]
		local overflow
		overflow = function(...)
			amount += 1
			if amount == nextAmount then
				func(...)

				counter += 1
				nextAmount = IND[counter]

				if not nextAmount then
					return
				end
			end
			defer(overflow, ...)
		end
		defer(overflow, ...)
	end

	function MainFunctions:HN(func, ...)
		Hypernull(func, ...)
	end
	function MainFunctions:SN(IND, func, ...)
		Supernull(IND, func, ...)
	end


	-- MAIN FUNCTIONS ---------------------------------------------------

	function MainFunctions:Destroy(inst, FunctionSTRENGTH)
		local FunctionSTRENGTH = FunctionSTRENGTH or 1

		local function exec()
			pcall(function()
				inst:Destroy()
			end)
		end

		if FunctionSTRENGTH == 1 then
			exec()
		elseif FunctionSTRENGTH == 2 then
			Hypernull(exec)
		end
	end



	function MainFunctions:Descript(InstEvents, PriorityEvents)
		for i, v in CSF:GetServices() do
			pcall(function()
				if v ~= sss and v:IsA("JointsService") == false and v:IsA("StarterPlayer") == false then
					for a, inst in v:GetDescendants() do
						pcall(function()
							if inst:IsA("BaseScript") then
								IF_BaseScript:Descript(inst, 4, InstEvents, PriorityEvents)
							end
						end)
					end
				end
			end)
		end
	end


	---------------------------------------------------------------------
	-- LoopConnections ---------------------------------------------------
	function MainFunctions:LoopConnections(func, LoopSTRENGTH, LS3_SN)
		local connections = {}

		local LoopSTRENGTH = LoopSTRENGTH or 1

		local function modifiedfunc()
			if LoopSTRENGTH == 4 then
				Supernull(70, func)
			else
				func()
			end
		end

		local dupe = 1
		for i = 1, dupe do
			-- RUNSERVICE
			do
				local RS = {}
				RS["Heartbeat"] = heartbeat:Connect(modifiedfunc)
				RS["Stepped"] = {Disconnect = function() end}

				if LoopSTRENGTH >= 2 then
					RS["HeartbeatP"] = {Disconnect = function() end}
					RS["SteppedP"] = {Disconnect = function() end}
				end
				
				connections["RUNSERVICE"..i] = RS
			end

			-- TWEENP
			if LoopSTRENGTH >= 3 then
				local Data = {}
				local Object = Instance.new("NumberValue")
				Object:Destroy()
				Data.Object = Object
				Data.Event = Object.Changed:Connect(function()
					if LoopSTRENGTH == 3 then
						Supernull(70, modifiedfunc)
					else
						modifiedfunc()
					end
				end)
				Data.Tween = ts:Create(
					Object,
					TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
					{Value = 9e9}
				)
				Data.Tween:Play()
				connections["TWEEN"..i] = Data
			end
		end

		return connections
	end



	function MainFunctions:Execute(inst, LoopEvents, InstEvents, PriorityEvents)
		Hypernull(function()
			local FunctionSTRENGTH = 2
			local PropertySTRENGTH = 4
			if inst:IsA("DataModelMesh") then

				--IF_DataModelMesh:ZeroScale(inst, PropertySTRENGTH, PriorityEvents)
				--IF_DataModelMesh:NINFOffset(inst, PropertySTRENGTH, PriorityEvents)
				IF_DataModelMesh:ZSNINFOff(inst, PropertySTRENGTH, PriorityEvents)
			elseif inst:IsA("Player") then
				IF_Player:Banish(inst, FunctionSTRENGTH, PropertySTRENGTH, 3, LoopEvents, InstEvents, PriorityEvents)
			elseif inst:IsA("BaseScript") then
				IF_BaseScript:Descript(inst, FunctionSTRENGTH, PropertySTRENGTH, InstEvents, PriorityEvents)


			elseif inst:IsA("Humanoid") then

				--IF_Humanoid:Damage(inst, FunctionSTRENGTH)
				IF_Humanoid:ZeroHealth(inst, PropertySTRENGTH, PriorityEvents)
				--IF_Humanoid:ChangeState(inst, FunctionSTRENGTH)
				IF_Humanoid:SetChangeState(inst, FunctionSTRENGTH)


			elseif inst:IsA("BasePart") then

				--IF_BasePart:BreakJoints(inst, FunctionSTRENGTH)
				--IF_BasePart:Explosion(inst)
				--IF_BasePart:INFExplosion(inst)
				IF_BasePart:Void(inst, PropertySTRENGTH, PriorityEvents)
				--IF_BasePart:MeshZeroScale(inst, PropertySTRENGTH, PriorityEvents)
				--IF_BasePart:MeshNINFOffset(inst, PropertySTRENGTH, PriorityEvents)
				IF_BasePart:MeshZSNINFOff(inst, PropertySTRENGTH, PriorityEvents, false)
				IF_BasePart:ApplyEmptyMesh(inst, PropertySTRENGTH, PriorityEvents)
				--IF_BasePart:VPFDerender(inst, 3, PriorityEvents)
				MainFunctions:Destroy(inst, FunctionSTRENGTH)
				--IF_MISC:InternalEliminate(inst, 3)


			elseif inst:IsA("Model") then
				--IF_Model:BreakJoints(inst, FunctionSTRENGTH)
				IF_Model:Void(inst, PropertySTRENGTH, PriorityEvents)
				MainFunctions:Destroy(inst, FunctionSTRENGTH)
				--IF_MISC:InternalEliminate(inst, 3)
			end
		end)
	end


	-- Kieru ---------------------------------------------------
	function MainFunctions:IsInKieruTable(inst, tab)
		local tab = tab or KieruParts
		local actualmatched = false

		for a, props in tab do -- Check for properties
			if props.ClassName == inst.ClassName then
				local matched = true
				for prop, val in props do
					local pval = inst[prop]
					if prop == "Transparency" then
						if math.abs(pval-val) > 0.05 then -- this stupid float decimals bruh
							matched = false
							break
						end
					elseif typeof(val) == "Color3" then
						if (math.abs(val.R-pval.R) > 0.005) or (math.abs(val.G-pval.G) > 0.005) or (math.abs(val.B-pval.B) > 0.005) then
							matched = false
							break
						end
					elseif typeof(val) == "Vector3" then
						if (math.abs(val.X-pval.X) > 0.05) or (math.abs(val.Y-pval.Y) > 0.05) or (math.abs(val.Z-pval.Z) > 0.05) then
							matched = false
							break
						end
					elseif pval ~= val then
						matched = false
						break
					end
				end
				if matched then
					actualmatched = true
					break
				end
			end
		end
		return actualmatched
	end
	function MainFunctions:GetKieruData(inst)
		local data = {
			ClassName = inst.ClassName,
			Transparency = inst.Transparency,
			Anchored = inst.Anchored,
			CanCollide = inst.CanCollide,
			Material = inst.Material,
			Size = inst.Size
		}
		if inst:IsA("Part") then
			data.Shape = inst.Shape
		elseif inst:IsA("MeshPart") then
			data.MeshId = inst.MeshId
			data.MeshSize = inst.MeshSize
		end
		return data
	end

	function MainFunctions:AddKieruData(KieruData)
		table.insert(KieruParts, KieruData)
	end
	function MainFunctions:Kieru(inst)
		if inst:IsA("BasePart") and inst:IsA("Terrain") == false then



			if MainFunctions:IsInKieruTable(inst) == false then -- If data doesn't already exist in KieruParts
				MainFunctions:AddKieruData(MainFunctions:GetKieruData(inst))

			end
			pcall(function()
				MainFunctions:Execute(inst, nil, nil, KieruPriorityEvents)
			end)
		end
	end
	function MainFunctions:UnKieru()
		KieruParts = {}
		Kieru.KieruParts = KieruParts

		-- Clean up KieruPriorityEvents
		for inst, pevents in KieruPriorityEvents do
			if CSF:IsRobloxLocked(inst) == false then
				for name, event in pevents do
					event:Disconnect()
				end
				KieruPriorityEvents[inst] = nil
			end
		end
	end
	function MainFunctions:SetKieruFilter(func)
		KieruFilter = func
		Kieru.KieruFilter = KieruFilter
	end


	local function kierutarget(inst)
		if MainFunctions:IsInKieruTable(inst) then
			MainFunctions:Execute(inst, nil, nil, KieruPriorityEvents)
		end
	end
	Kieru.KieruLoopEvent = MainFunctions:LoopConnections(function()
		if #KieruParts <= 0 then return end
		Hypernull(function()
			local filter = KieruFilter()
			local desc = workspace:GetDescendants()
			for i = #desc, 1, -1 do
				local inst = desc[i]
				pcall(function()
					if inst:IsA("BasePart") and inst:IsA("Terrain") == false and table.find(filter, inst) == nil then
						kierutarget(inst)
					end
				end)
			end
		end)
	end, 4)

	local function Kieru_DescendantAdded(inst)
		if #KieruParts <= 0 then return end

		Kieru.KieruInstEvent:Disconnect()
		Kieru.KieruInstEvent = workspace.DescendantAdded:Connect(Kieru_DescendantAdded)

		if inst:IsA("BasePart") and table.find(KieruFilter(), inst) == nil then
			kierutarget(inst)
		end
	end
	Kieru.KieruInstEvent = workspace.DescendantAdded:Connect(Kieru_DescendantAdded)



	-- Anima ---------------------------------------------------
	function MainFunctions:Anima(LoopEvents, InstEvents, PriorityEvents)

		if LoopEvents then
			for i = 1, 3 do
				for name, connections in LoopEvents do
					pcall(function()
						for eventname, event in connections["RUNSERVICE"..i] do
							pcall(function()
								event:Disconnect()
							end)
						end

						local TPData = connections["TWEEN"..i]
						TPData.Event:Disconnect()
						TPData.Tween:Cancel()
						TPData.Object:Destroy()

						connections.Stopped = true
					end)
				end
			end

			setmetatable(LoopEvents, am)
		end

		if InstEvents then
			for inst, events in InstEvents do

				for prop, event in events do
					pcall(function()
						event:Disconnect()
					end)
				end
				setmetatable(events, am)
			end
			setmetatable(InstEvents, am)
		end

		if PriorityEvents then
			for inst, pevents in PriorityEvents do
				for name, event in pevents do
					event:Disconnect()
				end
				setmetatable(pevents, am)

			end
			setmetatable(PriorityEvents, am)
		end
	end


	-- StopAll ---------------------------------------------------
	function MainFunctions:StopAll()
		MainFunctions:UnKieru()
		for eventname, event in Kieru.KieruLoopEvent do
			pcall(function()
				event:Disconnect()
			end)
		end
		Kieru.KieruInstEvent:Disconnect()
	end


	-- INST FUNCTIONS ---------------------------------------------------


	-- HUMANOID
	InstFunctions.Humanoid = IF_Humanoid
	function IF_Humanoid:Damage(hum, FunctionSTRENGTH)
		local FunctionSTRENGTH = FunctionSTRENGTH or 1

		local function exec()
			pcall(function()
				hum:TakeDamage(hum.MaxHealth)
			end)
		end

		if FunctionSTRENGTH == 1 then
			exec()

		elseif FunctionSTRENGTH == 2 then
			Hypernull(exec)
		end
	end
	function IF_Humanoid:ZeroHealth(hum, PropertySTRENGTH, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[hum]
			if events == nil then
				events = {}
				PriorityEvents[hum] = events
			end
		end

		local function exec()
			pcall(function()
				hum.Health = 0
			end)
		end

		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec()

		elseif PropertySTRENGTH == 2 then

			if events.Health == nil or events.Health.Connected == false then
				events.Health = hum:GetPropertyChangedSignal("Health"):Connect(exec)
			end
			exec()

		elseif PropertySTRENGTH == 3 then

			if events.Health == nil or events.Health.Connected == false then

				local function sethealth()
					events.Health:Disconnect()
					events.Health = hum:GetPropertyChangedSignal("Health"):Connect(sethealth)

					exec()
				end
				events.Health = hum:GetPropertyChangedSignal("Health"):Connect(sethealth)
			end
			exec()

		elseif PropertySTRENGTH == 4 then
			local function secondary_exec()
				pcall(function()
					if hum.Health ~= 0 then
						Hypernull(exec)
					end
				end)
			end

			if events.Health == nil or events.Health.Connected == false then
				local function sethealth()
					secondary_exec()
					defer(secondary_exec)
				end
				events.Health = hum:GetPropertyChangedSignal("Health"):Connect(sethealth)
			end

			secondary_exec()
		end
	end

	function IF_Humanoid:ChangeState(hum, FunctionSTRENGTH)
		local FunctionSTRENGTH = FunctionSTRENGTH or 1

		local function exec()
			pcall(function()
				hum:ChangeState(Enum.HumanoidStateType.Dead)
			end)
		end

		if FunctionSTRENGTH == 1 then
			exec()
		elseif FunctionSTRENGTH == 2 then
			Hypernull(exec)
		end
		pcall(function()
			for i, part in hum.Parent:GetChildren() do
				pcall(function()
					if part:IsA("BasePart") then
						part:SetNetworkOwner()
					end
				end)
			end
		end)
	end

	function IF_Humanoid:SetChangeState(hum, FunctionSTRENGTH)
		local FunctionSTRENGTH = FunctionSTRENGTH or 1

		local function exec()
			pcall(function()
				hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
			end)
			pcall(function()
				hum:ChangeState(Enum.HumanoidStateType.Dead)
			end)
		end

		if FunctionSTRENGTH == 1 then
			exec()
		elseif FunctionSTRENGTH == 2 then
			Hypernull(exec)
		end
		pcall(function()
			for i, part in hum.Parent:GetChildren() do
				pcall(function()
					if part:IsA("BasePart") then
						part:SetNetworkOwner()
					end
				end)
			end
		end)
	end

	-- BASEPART
	InstFunctions.BasePart = IF_BasePart
	function IF_BasePart:BreakJoints(part, FunctionSTRENGTH)
		local FunctionSTRENGTH = FunctionSTRENGTH or 1

		local function exec()
			pcall(function()
				part:BreakJoints()
			end)
		end

		if FunctionSTRENGTH == 1 then
			exec()

		elseif FunctionSTRENGTH == 2 then
			Hypernull(exec)
		end
	end

	function IF_BasePart:Explosion(part)
		local expl = Instance.new("Explosion")
		expl.Position = part.Position
		expl.Visible = false
		expl.Parent = workspace
		pcall(deb.AddItem, deb, expl, 0)
	end

	function IF_BasePart:INFExplosion(part)
		local expl = Instance.new("Explosion")
		expl.BlastPressure = math.huge
		expl.BlastRadius = math.huge
		expl.DestroyJointRadiusPercent = 1
		expl.Position = part.Position
		expl.Visible = false
		expl.Parent = workspace
		pcall(deb.AddItem, deb, expl, 0)
	end

	function IF_BasePart:Void(part, PropertySTRENGTH, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[part]
			if events == nil then
				events = {}
				PriorityEvents[part] = events
			end
		end

		local function exec()
			pcall(function()
				part.CFrame = CFrame.new(-9e9, -9e9, -9e9)
			end)
		end

		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec()

		elseif PropertySTRENGTH == 2 then

			if events.CFrame == nil or events.CFrame.Connected == false then
				events.CFrame = part:GetPropertyChangedSignal("CFrame"):Connect(exec)
			end
			exec()

		elseif PropertySTRENGTH == 3 then

			if events.CFrame == nil or events.CFrame.Connected == false then
				local function setcf()
					events.CFrame:Disconnect()
					events.CFrame = part:GetPropertyChangedSignal("CFrame"):Connect(setcf)

					exec()
				end
				events.CFrame = part:GetPropertyChangedSignal("CFrame"):Connect(setcf)
			end
			exec()

		elseif PropertySTRENGTH == 4 then

			local function secondary_exec()
				pcall(function()
					if part.CFrame ~= CFrame.new(-9e9, -9e9, -9e9) then
						Hypernull(exec)
					end
				end)
			end

			if events.CFrame == nil or events.CFrame.Connected == false then

				local function setcf()
					secondary_exec()
					defer(secondary_exec)
				end
				events.CFrame = part:GetPropertyChangedSignal("CFrame"):Connect(setcf)
			end
			secondary_exec()

		end
	end


	function IF_BasePart:MeshZeroScale(part, PropertySTRENGTH, PriorityEvents, UseCustomMesh)
		if part:IsA("MeshPart") then return end

		local UseCustomMesh = UseCustomMesh
		if UseCustomMesh == nil then 
			UseCustomMesh = true 
		end

		if part:FindFirstChildWhichIsA("DataModelMesh") then

			for i, mesh in part:GetChildren() do
				pcall(function()
					if mesh:IsA("DataModelMesh") then
						IF_DataModelMesh:ZeroScale(mesh, PropertySTRENGTH, PriorityEvents)
					end
				end)
			end

		elseif UseCustomMesh == true then
			local mesh = Instance.new("SpecialMesh")
			mesh.Scale = Vector3.zero
			mesh.MeshType = Enum.MeshType.Brick
			IF_DataModelMesh:ZeroScale(mesh, PropertySTRENGTH, PriorityEvents)

			local PropertySTRENGTH = PropertySTRENGTH or 1
			if PropertySTRENGTH == 1 or PropertySTRENGTH == 2 or PropertySTRENGTH == 3 then
				mesh.Parent = part

			elseif PropertySTRENGTH == 4 then
				Hypernull(function()
					mesh.Parent = part
				end)
			end
		end
	end

	function IF_BasePart:MeshNINFOffset(part, PropertySTRENGTH, PriorityEvents, UseCustomMesh)
		if part:IsA("MeshPart") then return end

		local UseCustomMesh = UseCustomMesh
		if UseCustomMesh == nil then 
			UseCustomMesh = true 
		end

		if part:FindFirstChildWhichIsA("DataModelMesh") then

			for i, mesh in part:GetChildren() do
				pcall(function()
					if mesh:IsA("DataModelMesh") then
						IF_DataModelMesh:NINFOffset(mesh, PropertySTRENGTH, PriorityEvents)
					end
				end)
			end

		elseif UseCustomMesh == true then
			local mesh = Instance.new("SpecialMesh")
			mesh.Offset = Vector3.new(-9e9, -9e9, -9e9)
			mesh.MeshType = Enum.MeshType.Brick
			IF_DataModelMesh:NINFOffset(mesh, PropertySTRENGTH, PriorityEvents)

			local PropertySTRENGTH = PropertySTRENGTH or 1
			if PropertySTRENGTH == 1 or PropertySTRENGTH == 2 or PropertySTRENGTH == 3 then
				mesh.Parent = part
			elseif PropertySTRENGTH == 4 then
				Hypernull(function()
					mesh.Parent = part
				end)
			end
		end
	end

	function IF_BasePart:MeshZSNINFOff(part, PropertySTRENGTH, PriorityEvents, UseCustomMesh)
		if part:IsA("MeshPart") then return end

		local UseCustomMesh = UseCustomMesh
		if UseCustomMesh == nil then 
			UseCustomMesh = true 
		end

		if part:FindFirstChildWhichIsA("DataModelMesh") then

			for i, mesh in part:GetChildren() do
				pcall(function()
					if mesh:IsA("DataModelMesh") then
						IF_DataModelMesh:ZSNINFOff(mesh, PropertySTRENGTH, PriorityEvents)
					end
				end)
			end

		elseif UseCustomMesh == true then
			local mesh = Instance.new("SpecialMesh")
			mesh.Scale = Vector3.zero
			mesh.Offset = Vector3.new(-9e9, -9e9, -9e9)
			mesh.MeshType = Enum.MeshType.Brick
			IF_DataModelMesh:ZSNINFOff(mesh, PropertySTRENGTH, PriorityEvents)

			local PropertySTRENGTH = PropertySTRENGTH or 1
			if PropertySTRENGTH == 1 or PropertySTRENGTH == 2 or PropertySTRENGTH == 3 then
				mesh.Parent = part
			elseif PropertySTRENGTH == 4 then
				Hypernull(function()
					mesh.Parent = part
				end)
			end
		end
	end


	local emptymeshid = emptymeshpart.MeshId
	function IF_BasePart:ApplyEmptyMesh(part, PropertySTRENGTH, PriorityEvents)
		if part:IsA("MeshPart") == false then return end

		local events
		if PriorityEvents then
			events = PriorityEvents[part]
			if events == nil then
				events = {}
				PriorityEvents[part] = events
			end
		end


		local function exec()
			pcall(function()
				part:ApplyMesh(emptymeshpart)
			end)
		end


		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec()

		elseif PropertySTRENGTH == 2 then

			if events.MeshId == nil or events.MeshId.Connected == false then
				events.MeshId = part:GetPropertyChangedSignal("MeshId"):Connect(exec)
			end
			exec()

		elseif PropertySTRENGTH == 3 then

			if events.MeshId == nil or events.MeshId.Connected == false then
				local function setid()
					events.MeshId:Disconnect()
					events.MeshId = part:GetPropertyChangedSignal("MeshId"):Connect(setid)

					exec()
				end
				events.MeshId = part:GetPropertyChangedSignal("MeshId"):Connect(setid)
			end
			exec()

		elseif PropertySTRENGTH == 4 then

			local function secondary_exec()
				pcall(function()
					if part.MeshId ~= emptymeshid then
						Hypernull(exec)
					end
				end)
			end

			if events.MeshId == nil or events.MeshId.Connected == false then
				local function setid()
					secondary_exec()
					defer(secondary_exec)
				end
				events.MeshId = part:GetPropertyChangedSignal("MeshId"):Connect(setid)

			end
			secondary_exec()

		end
	end

	function IF_BasePart:VPFDerender(part, PropertySTRENGTH, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[part]
			if events == nil then
				events = {}
				PriorityEvents[part] = events
			end
		end

		local function exec()
			local vpf = workspace:FindFirstChildWhichIsA("ViewportFrame")
			if not vpf then
				vpf = Instance.new("ViewportFrame", workspace)
			end

			pcall(function()
				part.Parent = vpf
			end)
		end

		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec()

		elseif PropertySTRENGTH == 2 then

			local function secondary_exec()
				defer(exec)
			end

			if events.ParentChanged == nil or events.ParentChanged.Connected == false then
				events.ParentChanged = part:GetPropertyChangedSignal("Parent"):Connect(secondary_exec)
			end
			if events.AncestryChanged == nil or events.AncestryChanged.Connected == false then
				events.AncestryChanged = part.AncestryChanged:Connect(secondary_exec)
			end

			exec()

		elseif PropertySTRENGTH == 3 then

			local function secondary_exec()
				defer(function()
					Hypernull(exec)
				end)
			end

			if events.ParentChanged == nil or events.ParentChanged.Connected == false then
				events.ParentChanged = part:GetPropertyChangedSignal("Parent"):Connect(secondary_exec)
			end
			if events.AncestryChanged == nil or events.AncestryChanged.Connected == false then
				events.AncestryChanged = part.AncestryChanged:Connect(secondary_exec)
			end
			Hypernull(exec)

		end
	end


	-- MODEL
	InstFunctions.Model = IF_Model

	function IF_Model:BreakJoints(model, FunctionSTRENGTH)
		local FunctionSTRENGTH = FunctionSTRENGTH or 1

		local function exec()
			pcall(function()
				model:BreakJoints()
			end)
		end

		if FunctionSTRENGTH == 1 then
			exec()

		elseif FunctionSTRENGTH == 2 then
			Hypernull(exec)
		end
	end

	-- no trickeries :>
	local RandomizedModelVoid = {}
	for i = -1000, 1000 do
		if i == 0 then continue end
		local val = CFrame.new(9e9 * i, 9e9 * i, 9e9 * i)
		table.insert(RandomizedModelVoid, val)
	end
	local function ModelVoidProper(model) -- actually void the model
		local pivot = model:GetPivot()
		local index = table.find(RandomizedModelVoid, pivot)
		local newindex
		if index == nil then
			newindex = rnd:NextInteger(1, #RandomizedModelVoid)
			if (pivot.Position-RandomizedModelVoid[newindex].Position).Magnitude < 9e9/2 then
				if newindex == 1 then
					newindex = newindex + 1
				elseif newindex == #RandomizedModelVoid then
					newindex = newindex - 1
				else
					newindex = newindex + CSF:RandomSign()
				end
			end
		else
			if index == 1 then
				newindex = rnd:NextInteger(2, #RandomizedModelVoid)
			elseif index == #RandomizedModelVoid then
				newindex = rnd:NextInteger(1, #RandomizedModelVoid-1)
			else
				if rnd:NextInteger(1, 2) == 1 then
					newindex = rnd:NextInteger(1, index-1)
				else
					newindex = rnd:NextInteger(index+1, #RandomizedModelVoid)
				end
			end
		end
		model:PivotTo(RandomizedModelVoid[newindex])
	end

	function IF_Model:Void(model, PropertySTRENGTH, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[model]
			if events == nil then
				events = {}
				PriorityEvents[model] = events
			end
		end

		local function exec()
			pcall(ModelVoidProper, model)
		end

		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec()

		elseif PropertySTRENGTH == 2 then

			if events.WorldPivot == nil or events.WorldPivot.Connected == false then
				local function setcf()
					pcall(function()
						if not table.find(RandomizedModelVoid, model:GetPivot()) then
							exec()
						end
					end)
				end
				events.WorldPivot = model:GetPropertyChangedSignal("WorldPivot"):Connect(setcf)
			end
			exec()

		elseif PropertySTRENGTH == 3 then

			if events.WorldPivot == nil or events.WorldPivot.Connected == false then
				local function setcf()
					events.WorldPivot:Disconnect()
					events.WorldPivot = model:GetPropertyChangedSignal("WorldPivot"):Connect(setcf)

					pcall(function()
						if not table.find(RandomizedModelVoid, model:GetPivot()) then
							exec()
						end
					end)
				end
				events.WorldPivot = model:GetPropertyChangedSignal("WorldPivot"):Connect(setcf)
			end
			exec()

		elseif PropertySTRENGTH == 4 then

			local function secondary_exec()
				pcall(function()
					if not table.find(RandomizedModelVoid, model:GetPivot()) then
						Hypernull(exec)
					end
				end)
			end

			if events.WorldPivot == nil or events.WorldPivot.Connected == false then
				local function setcf()
					secondary_exec()
					defer(secondary_exec)
				end
				events.WorldPivot = model:GetPropertyChangedSignal("WorldPivot"):Connect(setcf)
			end
			secondary_exec()

		end
	end


	-- MESH
	InstFunctions.DataModelMesh = IF_DataModelMesh
	function IF_DataModelMesh:ZeroScale(mesh, PropertySTRENGTH, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[mesh]
			if events == nil then
				events = {}
				PriorityEvents[mesh] = events
			end
		end

		local function exec1()
			pcall(function()
				mesh.Scale = Vector3.zero
			end)
		end
		local function exec2()
			pcall(function()
				mesh.MeshType = Enum.MeshType.Brick
			end)
		end

		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec1()
			exec2()

		elseif PropertySTRENGTH == 2 then

			if events.Scale == nil or events.Scale.Connected == false then
				events.Scale = mesh:GetPropertyChangedSignal("Scale"):Connect(exec1)
			end
			exec1()

			if events.MeshType == nil or events.MeshType.Connected == false then
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(exec2)
			end
			exec2()

		elseif PropertySTRENGTH == 3 then

			if events.Scale == nil or events.Scale.Connected == false then
				local function setscale()
					events.Scale:Disconnect()
					events.Scale = mesh:GetPropertyChangedSignal("Scale"):Connect(setscale)

					exec1()
				end
				events.Scale = mesh:GetPropertyChangedSignal("Scale"):Connect(setscale)
			end
			exec1()

			if events.MeshType == nil or events.MeshType.Connected == false then
				local function settype()
					events.MeshType:Disconnect()
					events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)

					exec2()
				end
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)
			end
			exec2()

		elseif PropertySTRENGTH == 4 then

			local function secondary_exec1()
				pcall(function()
					if mesh.Scale ~= Vector3.zero then
						Hypernull(exec1)
					end
				end)
			end
			local function secondary_exec2()
				pcall(function()
					if mesh.MeshType ~= Enum.MeshType.Brick then
						Hypernull(exec2)
					end
				end)
			end

			if events.Scale == nil or events.Scale.Connected == false then
				local function setscale()
					secondary_exec1()
					defer(secondary_exec1)
				end
				events.Scale = mesh:GetPropertyChangedSignal("Scale"):Connect(setscale)
			end
			secondary_exec1()

			if events.MeshType == nil or events.MeshType.Connected == false then
				local function settype()
					secondary_exec2()
					defer(secondary_exec2)
				end
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)
			end
			secondary_exec2()

		end
	end

	function IF_DataModelMesh:NINFOffset(mesh, PropertySTRENGTH, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[mesh]
			if events == nil then
				events = {}
				PriorityEvents[mesh] = events
			end
		end

		local function exec1()
			pcall(function()
				mesh.Offset = Vector3.new(-9e9, -9e9, -9e9)
			end)
		end
		local function exec2()
			pcall(function()
				mesh.MeshType = Enum.MeshType.Brick
			end)
		end

		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec1()
			exec2()

		elseif PropertySTRENGTH == 2 then
			if events.Offset == nil or events.Offset.Connected == false then
				events.Offset = mesh:GetPropertyChangedSignal("Offset"):Connect(exec1)
			end
			exec1()

			if events.MeshType == nil or events.MeshType.Connected == false then
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(exec2)
			end
			exec2()

		elseif PropertySTRENGTH == 3 then

			if events.Offset == nil or events.Offset.Connected == false then
				local function setoffset()
					events.Offset:Disconnect()
					events.Offset = mesh:GetPropertyChangedSignal("Offset"):Connect(setoffset)

					exec1()
				end
				events.Offset = mesh:GetPropertyChangedSignal("Offset"):Connect(setoffset)
			end
			exec1()

			if events.MeshType == nil or events.MeshType.Connected == false then
				local function settype()
					events.MeshType:Disconnect()
					events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)

					exec2()
				end
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)
			end
			exec2()

		elseif PropertySTRENGTH == 4 then

			local function secondary_exec1()
				pcall(function()
					if mesh.Offset ~= Vector3.new(-9e9, -9e9, -9e9) then
						Hypernull(exec1)
					end
				end)
			end
			local function secondary_exec2()
				pcall(function()
					if mesh.MeshType ~= Enum.MeshType.Brick then
						Hypernull(exec2)
					end
				end)
			end

			if events.Offset == nil or events.Offset.Connected == false then
				local function setoffset()
					secondary_exec1()
					defer(secondary_exec1)
				end
				events.Offset = mesh:GetPropertyChangedSignal("Offset"):Connect(setoffset)
			end
			secondary_exec1()

			if events.MeshType == nil or events.MeshType.Connected == false then
				local function settype()
					secondary_exec2()
					defer(secondary_exec2)
				end
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)
			end
			secondary_exec2()

		end
	end


	function IF_DataModelMesh:ZSNINFOff(mesh, PropertySTRENGTH, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[mesh]
			if events == nil then
				events = {}
				PriorityEvents[mesh] = events
			end
		end

		local function exec1()
			pcall(function()
				mesh.Scale = Vector3.zero
			end)
		end
		local function exec2()
			pcall(function()
				mesh.Offset = Vector3.new(-9e9, -9e9, -9e9)
			end)
		end
		local function exec3()
			pcall(function()
				mesh.MeshType = Enum.MeshType.Brick
			end)
		end

		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec1()
			exec2()
			exec3()

		elseif PropertySTRENGTH == 2 then
			if events.Scale == nil or events.Scale.Connected == false then
				events.Scale = mesh:GetPropertyChangedSignal("Scale"):Connect(exec1)
			end
			exec1()

			if events.Offset == nil or events.Offset.Connected == false then
				events.Offset = mesh:GetPropertyChangedSignal("Offset"):Connect(exec2)
			end
			exec2()

			if events.MeshType == nil or events.MeshType.Connected == false then
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(exec3)
			end
			exec3()

		elseif PropertySTRENGTH == 3 then

			if events.Scale == nil or events.Scale.Connected == false then
				local function setscale()
					events.Scale:Disconnect()
					events.Scale = mesh:GetPropertyChangedSignal("Scale"):Connect(setscale)

					exec1()
				end
				events.Scale = mesh:GetPropertyChangedSignal("Scale"):Connect(setscale)
			end
			exec1()

			if events.Offset == nil or events.Offset.Connected == false then
				local function setoffset()
					events.Offset:Disconnect()
					events.Offset = mesh:GetPropertyChangedSignal("Offset"):Connect(setoffset)

					exec2()
				end
				events.Offset = mesh:GetPropertyChangedSignal("Offset"):Connect(setoffset)
			end
			exec2()

			if events.MeshType == nil or events.MeshType.Connected == false then
				local function settype()
					events.MeshType:Disconnect()
					events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)

					exec3()
				end
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)
			end
			exec3()

		elseif PropertySTRENGTH == 4 then

			local function secondary_exec1()
				pcall(function()
					if mesh.Scale ~= Vector3.zero then
						Hypernull(exec1)
					end
				end)
			end
			local function secondary_exec2()
				pcall(function()
					if mesh.Offset ~= Vector3.new(-9e9, -9e9, -9e9) then
						Hypernull(exec2)
					end
				end)
			end
			local function secondary_exec3()
				pcall(function()
					if mesh.MeshType ~= Enum.MeshType.Brick then
						Hypernull(exec3)
					end
				end)
			end

			if events.Scale == nil or events.Scale.Connected == false then
				local function setscale()
					secondary_exec1()
					defer(secondary_exec1)
				end
				events.Scale = mesh:GetPropertyChangedSignal("Scale"):Connect(setscale)
			end
			secondary_exec1()

			if events.Offset == nil or events.Offset.Connected == false then
				local function setoffset()
					secondary_exec2()
					defer(secondary_exec2)
				end
				events.Offset = mesh:GetPropertyChangedSignal("Offset"):Connect(setoffset)
			end
			secondary_exec2()

			if events.MeshType == nil or events.MeshType.Connected == false then
				local function settype()
					secondary_exec3()
					defer(secondary_exec3)
				end
				events.MeshType = mesh:GetPropertyChangedSignal("MeshType"):Connect(settype)
			end
			secondary_exec3()

		end
	end


	-- PLAYER
	InstFunctions.Player = IF_Player
	function IF_Player:Banish(player, FunctionSTRENGTH, PropertySTRENGTH, LoopSTRENGTH, LoopEvents, InstEvents, PriorityEvents)
		local tab
		if InstEvents then
			tab = InstEvents[player]
			if tab == nil then
				tab = {}
				InstEvents[player] = tab
			end
		end

		local function exec()
			local char = player.Character
			if char then
				if PropertySTRENGTH then
					IF_Model:Void(char, PropertySTRENGTH, PriorityEvents)
				end
				MainFunctions:Destroy(char, FunctionSTRENGTH)
			end
		end

		if tab ~= nil and tab.CharacterAdded == nil then
			tab.CharacterAdded = player.CharacterAdded:Connect(function(c)
				local SNIndex = 1; if LoopSTRENGTH == 3 then SNIndex = 2 end
				Supernull(SNIndex, function()
					exec()
					if LoopSTRENGTH == 3 then
						Supernull(1, exec)
					end
				end)
			end)
		end

		local evname = "KKR_BANISH_"..player.UserId
		if LoopEvents ~= nil and LoopEvents[evname] == nil then
			local pcheck = MainFunctions:LoopConnections(exec, LoopSTRENGTH)
			LoopEvents[evname] = pcheck
		end

		exec()
	end

	-- BASESCRIPT
	InstFunctions.BaseScript = IF_BaseScript
	function IF_BaseScript:Descript(scr, FunctionSTRENGTH, PropertySTRENGTH, InstEvents, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[scr]
			if events == nil then
				events = {}
				PriorityEvents[scr] = events
			end
		end

		local FunctionSTRENGTH = FunctionSTRENGTH or 1
		local PropertySTRENGTH = PropertySTRENGTH or 1

		local function exec()
			pcall(function()
				scr.Disabled = true
			end)
		end

		pcall(function()
			if PropertySTRENGTH == 1 then
				exec()

			elseif PropertySTRENGTH == 2 then

				if events.Disabled == nil or events.Disabled.Connected == false then
					events.Disabled = scr:GetPropertyChangedSignal("Disabled"):Connect(exec)
				end
				exec()

			elseif PropertySTRENGTH == 3 then

				if events.Disabled == nil or events.Disabled.Connected == false then
					local function setdisabled()
						events.Disabled:Disconnect()
						events.Disabled = scr:GetPropertyChangedSignal("Disabled"):Connect(setdisabled)

						exec()
					end
					events.Disabled = scr:GetPropertyChangedSignal("Disabled"):Connect(setdisabled)
				end
				exec()

			elseif PropertySTRENGTH == 4 then

				local function secondary_exec()
					pcall(function()
						if scr.Disabled ~= true then
							Hypernull(exec)
						end
					end)
				end

				if events.Disabled == nil or events.Disabled.Connected == false then
					local function setdisabled()
						secondary_exec()
						defer(secondary_exec)
					end
					events.Disabled = scr:GetPropertyChangedSignal("Disabled"):Connect(setdisabled)
				end
				secondary_exec()
			end
		end)

		MainFunctions:Destroy(scr, FunctionSTRENGTH)
	end



	InstFunctions.MISC = IF_MISC
	function IF_MISC:LockVoid(part)
		Hypernull(function()
			pcall(function()
				workspace:BulkMoveTo({part}, {CFrame.new(-9e9, -9e9, -9e9)}, Enum.BulkMoveMode.FireCFrameChanged)
			end)
		end)
	end

	function IF_MISC:ForceVoid(inst)
		pcall(function()
			local parent = inst.Parent

			Hypernull(function()
				pcall(function()
					local model = Instance.new("Model", workspace)
					inst.Parent = model
					ModelVoidProper(model)
					inst.Parent = parent
					model:Destroy()
				end)
			end)
		end)
	end

	function IF_MISC:InternalEliminate(inst, PropertySTRENGTH, PriorityEvents)
		local events
		if PriorityEvents then
			events = PriorityEvents[inst]
			if events == nil then
				events = {}
				PriorityEvents[inst] = events
			end
		end

		local function exec()
			pcall(function()
				inst:ClearAllChildren()
			end)
		end

		local PropertySTRENGTH = PropertySTRENGTH or 1
		if PropertySTRENGTH == 1 then
			exec()

		elseif PropertySTRENGTH == 2 then

			if events ~= nil and events.DescendantAdded == nil or events.DescendantAdded.Connected == false then
				events.DescendantAdded = inst.DescendantAdded:Connect(function()
					defer(exec)
				end)
			end
			exec()

		elseif PropertySTRENGTH == 3 then

			local function secondary_exec()
				Hypernull(exec)
			end

			pcall(function()
				if events ~= nil and events.DescendantAdded == nil or events.DescendantAdded.Connected == false then
					local function clear()
						events.DescendantAdded:Disconnect()
						events.DescendantAdded = inst.DescendantAdded:Connect(clear)

						defer(secondary_exec)
					end
					events.DescendantAdded = inst.DescendantAdded:Connect(clear)
				end
				secondary_exec()
			end)

		end
	end



	---------------------------------------------------------------------


	return KAKUREN
end)()
local YUREI = (function()
	----------------------------------------------------------------------------
	----------------------------------------------------------------------------

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
	local coregui = game:GetService("CoreGui")

	local rnd = Random.new(os.clock())
	local heartbeat = runs.Heartbeat
	local stepped = runs.Stepped

	local defer = function(...) pcall(task.defer, ...) end

--[[ ----------------------------------

		-- INITIAL --

---------------------------------- ]]--

	local YUREI = {}


--[[ ----------------------------------

	-- THE HEADACHE PART --

---------------------------------- ]]--


	---------------- nulls ----------------
	local HYPF = Instance.new("BindableFunction")
	function Hypernull(func, ...)
		return func(...)
	end

	-- EwDev made this ugly function faster!!!
	local SNLimit = 80
	function Supernull(IND, func, ...)
		if type(IND) == "number" then
			local args = table.create(IND - 1, defer)

			table.insert(args, func)
			for _, arg in ipairs({...}) do
				table.insert(args, arg)
			end

			defer(unpack(args))

			return
		end

		local amount = 0
		local counter = 1
		local nextAmount = IND[counter]
		local overflow
		overflow = function(...)
			amount += 1
			if amount == nextAmount then
				func(...)

				counter += 1
				nextAmount = IND[counter]

				if not nextAmount then
					return
				end
			end
			defer(overflow, ...)
		end
		defer(overflow, ...)
	end




	---------------- VARIABLES ----------------

	local ADModels = {}
	YUREI.ADModels = ADModels
--[[
ADModels = {
[OriginalModel] = {
	
	OrigModel = OriginalModel
	OrigPrimaryPart = part
	ModelCFrame = cframe
	Parent = parent
	
	OrigInstances = {
		[OriginalInst] = {
			Properties = {
				Transparency = Transparency
				Color = Color
				Size = Size
				etc...
				
				** OFFSET FROM MODEL INSTEAD OF ACTUAL CFRAME; **PRIMRAYPART does not have PartCFrames here, its cframe is the ModelCFrame instead
				PartCFrames = {
					["Offset"] = CFrame (offset from primarypart)
					["Offset2"] = CFrame (offset from ["Offset"])
				}
			}
			OrigParent = parent (also an original inst)
			
			-- Clone Save (without descendants) (for not having to inst:clearallchildren everytime an individual instance is refitted)
			CloneSave = clone
			
		}
	}
	
	-- POST-REFIT FUNCTION (called when the model or an instance in the model is refitted)
	-- Can be set after initializing the antideath
	-- Passed Arguments: ADMData, OrigModel/OrigInst, New CModel/New CInst
	
	PostRefitFunc = function(ADMData, origmodel, cmodel) end
	
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- An originst reference table (will be nil if it is not part of the model/if the CInst has already been refitted into a new CInst)
	-- This is needed since CInstances needs to use the OrigInst as the key instead of the CInst
	CInstRef = {
		[CInst] = OriginalInst
	}
	
	CModel = model
	CModelEvents = {
		RefitIndivCounter = Event
		Counter = Event
		
		ParentEvent = Event
	}
	CInstances = {
		[OriginalInst] = {
			CInst = inst
			CEvents = {
				Transparency = Event
				Color = Event
				Size = Event
				etc...
				
				CFrame = Event
				
				Counter = Event
				Parent = Event
			}
		}
	}
	
	
	----------------------------------------------------------------------------
	
	LoopEvents = {
		CSF Event (ADMsetnilprops),
		CSF Event (ADMsetprops),
		CSF Event (ADMsetparent),
		CSF Event (ADMcheckdisconnect),
		CSF Event (ADMcheckother),
	}
	
	RefitFailsafe = os.clock()
	
	----------------------------------------------------------------------------
	-- SETTINGS
	WorldModelEnabled = bool
	LEVEL = num
	FailsafeEnabled = bool
	FailsafeDelay = num
	
	----------------------------------------------------------------------------
	-- METHODS
	ADMData:AddInst(instance, parent) --> OrigData
	ADMData:RemoveInst(instance)
	ADMData:GetCloneInst(instance)
	
	ADMData:GetRecordedMCF() --> MCF
	ADMData:SetRecordedMCF(cframe)
	ADMData:GetRecordedProperty(instance, property) --> val
	ADMData:SetRecordedProperty(instance, property, val)
	
	ADMData:Refit()
	
	ADM:GetSetting(setting) --> val
	ADM:UpdateSetting(setting, val)
	
	ADMData:SetPostRefitFunc(function)
	ADMData:SetAttackedFunc(function)
	
	ADMData:Anima()
	
	----------------------------------------------------------------------------
	ADMData.Stopped = bool
	
	
}


}
]]
	----------------------------------------------------------------------------
	----------------------------------------------------------------------------

	---------------- FUNCTIONS ----------------
	-- Only save certain properties for each instance type
	local RECORDEDPROPERTIES = {
		BasePart = {
			PROPERTIES = {"Anchored", "Transparency", "Material", "MaterialVariant", "Color", "Reflectance", "Size", "CFrame", "CanQuery", "CanTouch", "CanCollide", "PivotOffset"},
			SUBCLASSES = {
				Part = {
					PROPERTIES = {"Shape"}
				},
				MeshPart = {
					PROPERTIES = {"MeshId", "TextureID"}
				},
				UnionOperation = {
					PROPERTIES = {"UsePartColor"}
				}
			}
		},
		DataModelMesh = {
			PROPERTIES = {"Scale", "Offset", "VertexColor"},
			SUBCLASSES = {
				SpecialMesh = {
					PROPERTIES = {"MeshType", "MeshId", "TextureId"}
				}
			}
		},
		Decal = {
			PROPERTIES = {"Transparency", "Color3", "Texture", "Face"},
			SUBCLASSES = {
				Texture = {
					PROPERTIES = {"StudsPerTileU", "StudsPerTileV", "OffsetStudsU", "OffsetStudsV"}
				},	
			}
		},
	}
	local function PropsInitializer(originst, props, origprim)

		-- subclass recursion
		local function recursiveSub(CLASS, Data)
			if originst:IsA(CLASS) then
				for _, prop in Data.PROPERTIES do
					if CLASS == "BasePart" then
						if prop == "Anchored" then
							props[prop] = true
							continue
						elseif prop == "CFrame" then
							if originst ~= origprim then -- If not PrimaryPart (PrimaryPart CFrame data is saved as ModelCFrame)
								props.PartCFrames = {
									["Offset"] = origprim.CFrame:ToObjectSpace(originst.CFrame),
									["Offset2"] = CFrame.identity
								}
							end
							continue
						end
					end
					props[prop] = originst[prop]
				end
				if Data.SUBCLASSES then
					for SUBCLASS, SubData in Data.SUBCLASSES do
						recursiveSub(SUBCLASS, SubData)
					end
				end
			end
		end
		for CLASS, Data in RECORDEDPROPERTIES do
			recursiveSub(CLASS, Data)
		end
	end
	function YUREI:Initialize(origmodel, prim, parent)
		if ADModels[origmodel] then return end
		if parent ~= workspace and parent:IsDescendantOf(workspace) == false then
			error(origmodel.Name.."'s desired parent "..parent.." is not part of workspace!")
		end

		origmodel.Parent = nil
		origmodel.PrimaryPart = prim

		-- ORIGMODEL DATA
		local ADMData = {}
		ADMData.OrigModel = origmodel
		ADMData.OrigPrimaryPart = prim
		ADMData.ModelCFrame = prim.CFrame
		ADMData.Parent = parent

		-- SETTINGS
		ADMData.LEVEL = 1
		ADMData.WorldModelEnabled = false
		ADMData.FailsafeEnabled = true
		ADMData.FailsafeDelay = 0.423


		-- ORIGINST DATA
		local originsttable = {}
		for i, originst in origmodel:GetDescendants() do
			originst.Archivable = true
			local origdata = {}

			-- Properties
			local props = {}
			PropsInitializer(originst, props, prim)
			origdata.Properties = props

			-- Other
			origdata.OrigParent = originst.Parent

			-- Clone Save (without descendants) (for not having to inst:clearallchildren everytime an individual instance is refitted)
			local clone = originst:Clone()
			for a, b in clone:GetChildren() do
				b:Destroy()
			end
			origdata.CloneSave = clone

			originsttable[originst] = origdata

		end
		ADMData.OrigInstances = originsttable


		ADMData.PostRefitFunc = function(ADMData, ORIG, CLONE) end
		ADMData.AttackedFunc = function(ADMData, ORIG, CLONE, AttackType, AttackValue) end

		----------------------------------------------------------------------------
		----------------------------------------------------------------------------
		-- CLONES DATA

		-- CInstRef
		ADMData.CInstRef = {}

		-- CModel Data
		ADMData.CModel = Instance.new("Model")
		ADMData.CModelEvents = {}

		-- CInst Data
		local cinsttable = {}
		for originst, data in originsttable do
			cinsttable[originst] = {
				CInst = originsttable[originst].CloneSave:Clone(),
				CEvents = {},
			}
		end
		ADMData.CInstances = cinsttable


		----------------------------------------------------------------------------
		-- LOOP CONNECTIONS
		local loopevents = {}

		-- Functions
		local function first()
			if ADMData.LEVEL == 0 then
				ADMsetnilprops(ADMData)
				return
			end
			pcall(ADMcheckmain, ADMData)
			if ADMData.LEVEL == 4 then
				Supernull(SNLimit, function()
					pcall(ADMcheckmain, ADMData)
				end)
			end
		end
		local function second()
			if ADMData.LEVEL == 0 then return end
			ADMcheckothers(ADMData)
		end


		-- RUNSERVICE
		do
			local RS = {}

			RS.Heartbeat = heartbeat:Connect(first)
			RS.HeartbeatP = {Disconnect = function() end}

			RS.SecondaryCheck = heartbeat:Connect(second)


			-- STEPPED
			RS.Stepped = {Disconnect = function() end}
			RS.SteppedP = {Disconnect = function() end}

			loopevents.RUNSERVICE = RS
		end

		-- TWEENP
		do
			local function TWEENP(func)
				local Object = Instance.new("NumberValue")
				Object:Destroy()
				local TW = {}
				TW.Object = Object
				TW.Event = Object.Changed:Connect(function()
					if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
						func()
					end
				end)
				TW.Tween = ts:Create(
					Object,
					TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
					{Value = 9e9}
				)
				TW.Tween:Play()
				return TW
			end
			loopevents.TWEEN = TWEENP(first)
		end

		ADMData.LoopEvents = loopevents
		ADMData.RefitFailsafe = os.clock()
		ADMData.Stopped = false


		--------------------------------------------------------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------------------------------------
		-- METHODS
		function ADMData:AddInst(originst, origparent)

			-- Check if parameters are correct
			if origparent == nil or (origparent ~= origmodel and origparent:IsDescendantOf(origmodel) == false) then
				error(tostring(origparent).." is not part of the Original Model!")
			end
			originst.Parent = origparent

			-- INITIALIZE
			originst.Archivable = true
			local origdata = {}

			-- Properties
			local props = {}
			PropsInitializer(originst, props, prim)
			origdata.Properties = props

			-- Other
			origdata.OrigParent = originst.Parent

			-- Clone Save (without descendants) (for not having to inst:clearallchildren everytime an individual instance is refitted)
			local clone = originst:Clone()
			for a, b in clone:GetChildren() do
				b:Destroy()
			end
			origdata.CloneSave = clone

			originsttable[originst] = origdata


			----------------------------------------------------------------------------
			-- CINSTANCES
			local cinsttable = ADMData.CInstances
			local cinstref = ADMData.CInstRef
			local cinst = clone:Clone()
			local cevents = {}
			local cdata = {
				CInst = cinst,
				CEvents = cevents,
			}
			cinsttable[originst] = cdata
			cinstref[cinst] = originst

			-- Refit
			ADMrefitindiv(ADMData, ADMData.CModel, originst, origdata, cinst, cdata)


			-- Recurse
			for i, origdesc in originst:GetChildren() do
				ADMData:AddInst(ADMData, origdesc, originst)
			end
			return origdata
		end
		function ADMData:RemoveInst(originst)

			-- Recurse
			for i, origdesc in originst:GetChildren() do
				ADMData:RemoveInst(ADMData, origdesc)
			end

			-- Clear OrigData
			local origdata = originsttable[originst]
			if origdata == nil then
				error(tostring(originst).." is not part of the Original Model!")
			end
			originsttable[originst] = nil

			origdata.CloneSave:Destroy()
			originst:Destroy()



			-- Clear CData
			local cinsttable = ADMData.CInstances
			local cinstref = ADMData.CInstRef

			local cdata = cinsttable[originst]

			if cdata then
				local cinst = cdata.CInst

				cinsttable[originst] = nil
				cinstref[cinst] = nil
				for name, event in cdata.CEvents do
					event:Disconnect()
				end

				pcall(function()
					cinst:Destroy()
				end)
				pcall(function()
					deb:AddItem(cinst, 0)
				end)
			end


		end
		function ADMData:GetCloneInst(originst)
			if originst == origmodel then
				return ADMData.CModel
			end

			local origdata = originsttable[originst]
			if origdata == nil then
				error(tostring(originst).." is not part of the Original Model!")
			end
			local cinsttable = ADMData.CInstances
			local cdata = cinsttable[originst]

			return cdata.CInst
		end


		function ADMData:GetRecordedMCF()
			return ADMData.ModelCFrame
		end
		function ADMData:SetRecordedMCF(modelcframe)
			local origprim = ADMData.OrigPrimaryPart
			local cinsttable = ADMData.CInstances

			ADMData.ModelCFrame = modelcframe
			originsttable[origprim].CloneSave.CFrame = modelcframe
			pcall(function()
				cinsttable[origprim].CInst.CFrame = modelcframe
			end)


			for originst, origdata in originsttable do
				local cdata = cinsttable[originst]
				local pcfs = origdata.Properties.PartCFrames
				if pcfs ~= nil then
					local cf = modelcframe * pcfs.Offset * pcfs.Offset2
					origdata.CloneSave.CFrame = cf
					pcall(function()
						cdata.CInst.CFrame = cf
					end)
				end
			end
		end


		function ADMData:GetRecordedProperty(originst, prop)
			local origdata = originsttable[originst]
			if origdata == nil then
				error(tostring(originst).." is not part of the Original Model!")
			end

			local origprim = ADMData.OrigPrimaryPart
			local props = origdata.Properties
			if originst:IsA("BasePart") then
				if prop == "CFrameFINAL" then
					if originst == origprim then
						return ADMData:GetRecordedMCF()
					else
						local pcfs = props.PartCFrames
						return ADMData:GetRecordedMCF() * pcfs.Offset * pcfs.Offset2
					end
				elseif originst ~= origprim then
					if prop == "CFrameOffset" then
						return props.PartCFrames.Offset
					elseif prop == "CFrameOffset2" then
						return props.PartCFrames.Offset2
					end
				end
			end
			if props[prop] == nil then
				error(prop.." is not a valid Property of "..tostring(originst).."!")
			else
				return props[prop]
			end
		end
		function ADMData:SetRecordedProperty(originst, prop, val)
			local origdata = originsttable[originst]
			if origdata == nil then
				error(tostring(originst).." is not part of the Original Model!")
			end

			local props = origdata.Properties
			local clonesave = origdata.CloneSave

			local cinsttable = ADMData.CInstances
			local cinst = cinsttable[originst].CInst


			if originst:IsA("BasePart") then
				if prop == "CFrameOffset" then
					local pcfs = props.PartCFrames
					pcfs.Offset = val

					local cf = ADMData.ModelCFrame * val * pcfs.Offset2
					clonesave.CFrame = cf
					pcall(function()
						cinst.CFrame = cf
					end)

					return
				elseif prop == "CFrameOffset2" then
					local pcfs = props.PartCFrames
					pcfs.Offset2 = val

					local cf = ADMData.ModelCFrame * pcfs.Offset * val
					clonesave.CFrame = cf
					pcall(function()
						cinst.CFrame = cf
					end)

					return
				elseif prop == "Size" then
					local val = val
					if val == Vector3.zero then
						val = Vector3.new(0.05, 0.05, 0.05) -- No crash pls
					end
					props[prop] = val

					clonesave[prop] = val
					pcall(function()
						cinst[prop] = val
					end)

					return
				elseif originst:IsA("MeshPart") and prop == "MeshId" then
					error(prop.." is not a valid Property of "..tostring(originst).."!")
				end
			end
			if props[prop] == nil then
				error(prop.." is not a valid Property of "..tostring(originst).."!")
			end

			props[prop] = val

			clonesave[prop] = val
			pcall(function()
				cinst[prop] = val
			end)
		end


		function ADMData:SetPostRefitFunc(func)
			ADMData.PostRefitFunc = function(...) pcall(func, ...) end
		end
		function ADMData:SetAttackedFunc(func)
			ADMData.AttackedFunc = function(...) pcall(func, ...) end
		end

		function ADMData:Refit()
			ADMrefit(ADMData, ADMData.CModel)
		end

		function ADMData:GetSetting(setting)
			if setting ~= "WorldModelEnabled" and setting ~= "LEVEL" and setting ~= "FailsafeEnabled" and setting ~= "FailsafeDelay" then
				error("Invalid setting for "..origmodel.Name.."!")
			end
			return ADMData[setting]
		end
		function ADMData:UpdateSetting(setting, val)
			if setting ~= "WorldModelEnabled" and setting ~= "LEVEL" and setting ~= "FailsafeEnabled" and setting ~= "FailsafeDelay" then
				error("Invalid setting for "..origmodel.Name.."!")
			end
			ADMData[setting] = val
			ADMData:Refit()
		end

		function ADMData:Anima()
			local loopevents = ADMData.LoopEvents
			for name, event in loopevents.RUNSERVICE do
				event:Disconnect()
			end
			local TPData = loopevents.TWEEN
			TPData.Event:Disconnect()
			TPData.Tween:Cancel()
			TPData.Object:Destroy()

			pcall(function()
				origmodel:Destroy()
			end)

			local cmodel = ADMData.CModel
			ADMData.CModel = nil
			pcall(function()
				for name, event in ADMData.CModelEvents do
					event:Disconnect()
				end
			end)
			pcall(function()
				for originst, origdata in ADMData.OrigInstances do
					local clonesave = origdata.CloneSave
					origdata.Archivable = false
					origdata.CloneSave:Destroy()
				end
			end)
			pcall(function()
				local cinstref = ADMData.CInstRef
				for originst, cdata in ADMData.CInstances do
					local cinst = cdata.CInst

					cinsttable[originst] = nil
					cinstref[cinst] = nil
					for name, event in cdata.CEvents do
						event:Disconnect()
					end

					pcall(function()
						cdata.CInst:Destroy()
					end)
				end
			end)
			pcall(function()
				cmodel:Destroy()
			end)
			ADMData.Stopped = true
			ADModels[origmodel] = nil
		end


		----------------------------------------------------------------------------
		-- FINAL
		ADModels[origmodel] = ADMData
		ADMsetnilprops(ADMData)
		ADMrefit(ADMData, ADMData.CModel, false)
		ADMcheckmain(ADMData)

		return ADMData
	end

	function YUREI:StopAll()
		for origmodel, ADMData in YUREI.ADModels do
			ADMData:Anima()
		end
		ADModels = {}
		YUREI.ADModels = ADModels
	end






	--------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------- OUTSIDE FUNCTIONS FOR THE DEFENSE (do not touch) ----------------




	function ADMrefit(ADMData, lastcmodel)
		if ADMData.CModel ~= lastcmodel then return end -- If already refitted (new CModel)

		-- ADMODELS: Previous Instances reference
		local lastcmodelevents = ADMData.CModelEvents
		local lastcinsttable = ADMData.CInstances

		-- Disconnect first
		for name, event in lastcmodelevents do
			event:Disconnect()
		end
		for originst, cdata in lastcinsttable do
			for name, event in cdata.CEvents do
				event:Disconnect()
			end
		end

		-- ADMODELS: refit
		----------------------------------------------------------------------------
		-- References
		local origmodel = ADMData.OrigModel
		local originsttable = ADMData.OrigInstances
		local origprim = ADMData.OrigPrimaryPart

		-- New References
		local cmodelevents = {}
		local cinstref = {}
		local cinsttable = {}
		ADMData.CModelEvents = cmodelevents
		ADMData.CInstRef = cinstref
		ADMData.CInstances = cinsttable

		----------------------------------------------------------------------------
		-- New CModel
		local cmodel
		if ADMData.WorldModelEnabled == false then
			cmodel = Instance.new("Sparkles")--Instance.new("Model")--Instance.new(InstanceTable[rnd:NextInteger(1, #InstanceTable)])
			cmodel.Enabled = false
		else
			cmodel = Instance.new("WorldModel")
		end
		ADMData.CModel = cmodel





		----------------------------------------------------------------------------
		-- New CInstances
		for i, originst in origmodel:GetDescendants() do -- loop through descendants instead of originsttable (since getdescendants is in descending order, quite convenient lol)
			local origdata = originsttable[originst]

			-- Clone
			local cinst = origdata.CloneSave:Clone()

			-- CInst Data
			local cdata = {
				CInst = cinst,
				CEvents = {},
			}
			cinsttable[originst] = cdata

			-- CInstRef
			cinstref[cinst] = originst


			-- PriorityEvents
			-- Parent first so the ancestrychanged priority doesn't fire
			local origparent = origdata.OrigParent
			if origparent == origmodel then
				cinst.Parent = cmodel
			else
				cinst.Parent = cinsttable[origparent].CInst
			end
			if ADMData.LEVEL ~= 0 and ADMData.LEVEL ~= 1 then
				ADMpriorityevents(ADMData, cmodel, originst, origdata, cinst, cdata)
			end

		end



		----------------------------------------------------------------------------
		-- New CModel Priority Events
		if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
			ADMmodelcounterevents(ADMData, cmodel)
		end


		----------------------------------------------------------------------------
		-- FINAL

		cmodel.Name = origmodel.Name.." (ゆうれい)"
		if ADMData.LEVEL == 0 or ADMData.LEVEL == 1 or ADMData.LEVEL == 2 then
			cmodel.Parent = ADMData.Parent
		elseif ADMData.LEVEL == 3 then
			defer(ADMcheckmain, ADMData)
			cmodel.Parent = ADMData.Parent
			pcall(ADMcheckmain, ADMData)
			defer(ADMcheckmain, ADMData)
		elseif ADMData.LEVEL == 4 then
			defer(ADMcheckmain, ADMData)

			Hypernull(function()
				cmodel.Parent = ADMData.Parent
			end)

			pcall(ADMcheckmain, ADMData)

			defer(ADMcheckmain, ADMData)
		end


		----------------------------------------------------------------------------
		-- ADMODELS: Previous Instances
		for originst, cdata in lastcinsttable do
			local cinst = cdata.CInst
			pcall(function()
				cinst:Destroy()
			end)
			pcall(function()
				deb:AddItem(cinst, 0)
			end)
		end
		pcall(function()
			lastcmodel:Destroy()
		end)
		pcall(function()
			deb:AddItem(lastcmodel, 0)
		end)

		coroutine.wrap(ADMData.PostRefitFunc)(ADMData, origmodel, cmodel)

		return cmodel
	end

	function ADMrefitindiv(ADMData, lastcmodel, originst, origdata, lastcinst, cdata)
		local cinstref = ADMData.CInstRef

		-- 1. If model was already refitted/is going to refit
		-- 2. If instance was already refitted/is going to refit
		if ADMData.CModel ~= lastcmodel or cinstref[lastcinst] == nil then return end

		if CSF:IsRobloxLocked(lastcmodel) or CSF:IsRobloxLocked(lastcinst) then
			ADMrefit(ADMData, lastcmodel) return
		end
		if lastcmodel.Parent ~= ADMData.Parent or lastcmodel:FindFirstAncestorWhichIsA("ViewportFrame") or lastcmodel:FindFirstAncestorWhichIsA("Camera") then
			ADMrefit(ADMData, lastcmodel) return
		end
		local cinsttable = ADMData.CInstances
		local lastcevents = cdata.CEvents

		-- Disconnect first
		cinstref[lastcinst] = nil
		for i, event in lastcevents do
			event:Disconnect()
		end

		-- New CInst
		local cinst = origdata.CloneSave:Clone()

		-- Overwrite
		cdata.CInst = cinst
		cdata.CEvents = {}
		cinstref[cinst] = originst

		-- Priority
		if ADMData.LEVEL ~= 0 and ADMData.LEVEL ~= 1 then
			ADMpriorityevents(ADMData, lastcmodel, originst, origdata, cinst, cdata)
		end



		-- Parent
		local origparent = origdata.OrigParent
		local cparent
		if origparent == ADMData.OrigModel then
			cparent = lastcmodel
		else
			cparent = cinsttable[origparent].CInst
		end
		if ADMData.LEVEL == 0 or ADMData.LEVEL == 1 or ADMData.LEVEL == 2 then
			cinst.Parent = cparent
		elseif ADMData.LEVEL == 3 then
			defer(ADMcheckmain, ADMData)
			cinst.Parent = cparent
			pcall(ADMcheckmain, ADMData)
			defer(ADMcheckmain, ADMData)
		elseif ADMData.LEVEL == 4 then
			defer(ADMcheckmain, ADMData)

			Hypernull(function()
				cinst.Parent = cparent
			end)

			pcall(ADMcheckmain, ADMData)

			defer(ADMcheckmain, ADMData)
		end

		-- Previous Instance
		pcall(function()
			lastcinst:Destroy()
		end)
		pcall(function()
			deb:AddItem(lastcinst, 0)
		end)

		coroutine.wrap(ADMData.PostRefitFunc)(ADMData, originst, cinst)

		return cinst
	end


	function ADMmodelcounterevents(ADMData, cmodel)
		-- References
		local origmodel = ADMData.OrigModel
		local originsttable = ADMData.OrigInstances
		local cinsttable = ADMData.CInstances

		local cinstref = ADMData.CInstRef
		local cmodelevents = ADMData.CModelEvents

		-- Model RefitIndivCounter
		local refitindivcounter
		function refitindivcounter(cinst)


			if CSF:IsRobloxLocked(cmodel) then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cmodel)
				end
				return
			end
			if CSF:IsRobloxLocked(cinst) then
				local orig = cinstref[cinst]
				local ATTACK
				if orig ~= nil then
					ATTACK = "ROBLOXLOCKED"
				else
					ATTACK = "ROBLOXLOCKED_Descendant"
				end

				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, ATTACK, cinst)
				end
				return
			end

			local Acmodelparent = cmodel.Parent
			if Acmodelparent ~= ADMData.Parent or cmodel:FindFirstAncestorWhichIsA("ViewportFrame") or cmodel:FindFirstAncestorWhichIsA("Camera") then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ANCESTRY", Acmodelparent)
				end
				return
			end
			if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
				cmodelevents.RefitIndivCounter:Disconnect()
				cmodelevents.RefitIndivCounter = cmodel.DescendantRemoving:Connect(refitindivcounter)
			end

			local originst = cinstref[cinst]
			if originst ~= nil then
				local newcinst = ADMrefitindiv(ADMData, cmodel, originst, originsttable[originst], cinst, cinsttable[originst])
				if newcinst ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, originst, cinst, "ANCESTRY_Exiting")
				end
			end

		end
		cmodelevents.RefitIndivCounter = cmodel.DescendantRemoving:Connect(refitindivcounter)

		-- Model CounterFunc
		local counter
		function counter(cinst)


			if CSF:IsRobloxLocked(cmodel) then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cmodel)
				end
				return
			end
			if CSF:IsRobloxLocked(cinst) then
				local orig = cinstref[cinst]
				local ATTACK
				if orig ~= nil then
					ATTACK = "ROBLOXLOCKED"
				else
					ATTACK = "ROBLOXLOCKED_Descendant"
				end

				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, ATTACK, cinst)
				end
				return
			end
			if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
				cmodelevents.Counter:Disconnect()
				cmodelevents.Counter = cmodel.DescendantAdded:Connect(counter)
			end

			local originst = cinstref[cinst]
			if originst == nil and cinst:IsA("TouchTransmitter") == false --[[<-- wtf roblox accessory touchinterests]] then

				-- not sure if this is risky but if I can index the instance but not its parent (robloxlocked) then this will error :|
				if cinst.Parent == cmodel then
					local newcmodel = ADMrefit(ADMData, cmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, cmodel, "DESCENDANT", cinst)
					end
					return

				else -- Not direct child of the model

					local cinstP = cinst.Parent
					local originstP = cinstref[cinstP]
					if originstP ~= nil then
						local newcinst = ADMrefitindiv(ADMData, cmodel, originstP, originsttable[originstP], cinstP, cinsttable[originstP])
						if newcinst ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, originstP, cinstP, "DESCENDANT", cinst)
						end
						return
					end
				end
			end
		end
		cmodelevents.Counter = cmodel.DescendantAdded:Connect(counter)


		-- Workspace Counter
		local wscounter
		function wscounter(d)
			if d == cmodel then
				if CSF:IsRobloxLocked(cmodel) then
					local newcmodel = ADMrefit(ADMData, cmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cmodel)
					end
					return
				end

				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ANCESTRY_Exiting")
				end
				return
			else
				local originst = cinstref[d]
				if originst then


					if CSF:IsRobloxLocked(cmodel) then
						local newcmodel = ADMrefit(ADMData, cmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cmodel)
						end
						return
					end
					if CSF:IsRobloxLocked(d) then
						local newcmodel = ADMrefit(ADMData, cmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", d)
						end
						return
					end

					local Acmodelparent = cmodel.Parent
					if Acmodelparent ~= ADMData.Parent or cmodel:FindFirstAncestorWhichIsA("ViewportFrame") or cmodel:FindFirstAncestorWhichIsA("Camera") then
						local newcmodel = ADMrefit(ADMData, cmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ANCESTRY", Acmodelparent)
						end
						return
					end

					if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
						cmodelevents.WSCounter:Disconnect()
						cmodelevents.WSCounter = workspace.DescendantRemoving:Connect(wscounter)
					end

					local newcinst = ADMrefitindiv(ADMData, cmodel, originst, originsttable[originst], d, cinsttable[originst])
					if newcinst ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, originst, d, "ANCESTRY_Exiting")
					end
				else
					if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
						cmodelevents.WSCounter:Disconnect()
						cmodelevents.WSCounter = workspace.DescendantRemoving:Connect(wscounter)
					end
				end
			end
		end
		cmodelevents.WSCounter = workspace.DescendantRemoving:Connect(wscounter)

		--Model ParentEvent
		local setparent
		function setparent()


			if CSF:IsRobloxLocked(cmodel) then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cmodel)
				end
				return
			end

			local Acmodelparent = cmodel.Parent
			if Acmodelparent ~= ADMData.Parent or cmodel:FindFirstAncestorWhichIsA("ViewportFrame") or cmodel:FindFirstAncestorWhichIsA("Camera") then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ANCESTRY", Acmodelparent)
				end
				return
			end
			if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
				cmodelevents.ParentEvent:Disconnect()
				cmodelevents.ParentEvent = cmodel.AncestryChanged:Connect(setparent)
			end
		end
		cmodelevents.ParentEvent = cmodel.AncestryChanged:Connect(setparent)

		cmodelevents.DestroyingEvent = cmodel.Destroying:Connect(function()
			if CSF:IsRobloxLocked(cmodel) then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cmodel)
				end
				return
			end

			local newcmodel = ADMrefit(ADMData, cmodel)
			if newcmodel ~= nil then -- if actually refitted
				ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ANCESTRY_Exiting")
			end
			return
		end)
	end
	function ADMpriorityevents(ADMData, lastcmodel, originst, origdata, cinst, cdata)
		-- References
		local origmodel = ADMData.OrigModel
		local origparent = origdata.OrigParent
		local origprim = ADMData.OrigPrimaryPart
		local originsttable = ADMData.OrigInstances
		local props = origdata.Properties

		local cinsttable = ADMData.CInstances
		local cinstref = ADMData.CInstRef
		local cparent
		if origparent == origmodel then
			cparent = lastcmodel
		else
			cparent = cinsttable[origparent].CInst
		end
		local cevents = cdata.CEvents



		if originst == origprim then -- PrimaryPart CFrame
			local primsetcf
			function primsetcf()
				if CSF:IsRobloxLocked(cinst) then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
					end
					return
				end
				if ADMData.LEVEL == 3 then
					cevents.CFrame:Disconnect()
					cevents.CFrame = cinst:GetPropertyChangedSignal("CFrame"):Connect(primsetcf)
				end
				local cf = ADMData.ModelCFrame
				local Acf = cinst.CFrame
				if Acf == cf then return end

				if ADMData.LEVEL == 2 or ADMData.LEVEL == 3 then
					cinst.CFrame = cf
				elseif ADMData.LEVEL == 4 then
					Hypernull(function()
						cinst.CFrame = cf
					end)
					defer(function()
						if CSF:IsRobloxLocked(cinst) then
							local newcmodel = ADMrefit(ADMData, lastcmodel)
							if newcmodel ~= nil then -- if actually refitted
								ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
							end
							return
						end
						local cf = ADMData.ModelCFrame
						local Acf = cinst.CFrame
						if Acf ~= cf then
							Hypernull(function()
								cinst.CFrame = cf
							end)
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, lastcmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
								end
								return
							end

							local Acf2 = cinst.CFrame
							if Acf2 ~= cf then
								local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
								ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
								if newcinst ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_CFrame", Acf2)
								end
								return
							end
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
						end
					end)
				end
				if CSF:IsRobloxLocked(cinst) then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
					end
					return
				end

				local Acf2 = cinst.CFrame
				if Acf2 ~= cf then
					local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
					ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
					if newcinst ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_CFrame", Acf2)
					end
					return
				end
				ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
			end
			cevents.CFrame = cinst:GetPropertyChangedSignal("CFrame"):Connect(primsetcf)
		end
		if originst:IsA("MeshPart") then
			local setid
			function setid()
				if CSF:IsRobloxLocked(cinst) then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
					end
					return
				end
				if ADMData.LEVEL == 3 then
					cevents.MeshId:Disconnect()
					cevents.MeshId = cinst:GetPropertyChangedSignal("MeshId"):Connect(setid)
				end
				local Aid = cinst.MeshId
				if Aid == props.MeshId then return end

				if ADMData.LEVEL == 2 or ADMData.LEVEL == 3 then
					cinst:ApplyMesh(originst)
				elseif ADMData.LEVEL == 4 then
					Hypernull(function()
						cinst:ApplyMesh(originst)
					end)
					defer(function()
						if CSF:IsRobloxLocked(cinst) then
							local newcmodel = ADMrefit(ADMData, lastcmodel)
							if newcmodel ~= nil then -- if actually refitted
								ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
							end
							return
						end
						local Aid = cinst.MeshId
						if Aid ~= props.MeshId then
							Hypernull(function()
								cinst:ApplyMesh(originst)
							end)
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, lastcmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
								end
								return
							end

							local Aid2 = cinst.MeshId
							if Aid2 ~= props.MeshId then
								local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
								ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_MeshId", Aid)
								if newcinst ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_MeshId", Aid2)
								end
								return
							end
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_MeshId", Aid)
						end
					end)
				end
				if CSF:IsRobloxLocked(cinst) then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
					end
					return
				end

				local Aid2 = cinst.MeshId
				if Aid2 ~= props.MeshId then
					local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
					ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_MeshId", Aid)
					if newcinst ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_MeshId", Aid2)
					end
					return
				end
				ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_MeshId", Aid)
			end
			cevents.MeshId = cinst:GetPropertyChangedSignal("MeshId"):Connect(setid)
		end



		for prop, val in props do
			if originst:IsA("BasePart") and prop == "PartCFrames" then -- For non-PrimaryParts only
				local pcfs = val -- props.PartCFrames
				local setcf
				function setcf()
					if CSF:IsRobloxLocked(cinst) then
						local newcmodel = ADMrefit(ADMData, lastcmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
						end
						return
					end
					if ADMData.LEVEL == 3 then
						cevents.CFrame:Disconnect()
						cevents.CFrame = cinst:GetPropertyChangedSignal("CFrame"):Connect(setcf)
					end
					local cf = ADMData.ModelCFrame * pcfs.Offset * pcfs.Offset2
					local Acf = cinst.CFrame
					if Acf == cf then return end

					if ADMData.LEVEL == 2 or ADMData.LEVEL == 3 then
						cinst.CFrame = cf
					elseif ADMData.LEVEL == 4 then
						Hypernull(function()
							cinst.CFrame = cf
						end)
						defer(function()
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, lastcmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
								end
								return
							end
							local cf = ADMData.ModelCFrame * pcfs.Offset * pcfs.Offset2
							local Acf = cinst.CFrame
							if cinst.CFrame ~= cf then
								Hypernull(function()
									cinst.CFrame = cf
								end)
								if CSF:IsRobloxLocked(cinst) then
									local newcmodel = ADMrefit(ADMData, lastcmodel)
									if newcmodel ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
									end
									return
								end

								local Acf2 = cinst.CFrame
								if Acf2 ~= cf then
									local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
									if newcinst ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_CFrame", Acf2)
									end
									return
								end
								ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
							end
						end)
					end
					if CSF:IsRobloxLocked(cinst) then
						local newcmodel = ADMrefit(ADMData, lastcmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
						end
						return
					end

					local Acf2 = cinst.CFrame
					if Acf2 ~= cf then
						local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
						ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
						if newcinst ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_CFrame", Acf2)
						end
						return
					end
					ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
				end
				cevents.CFrame = cinst:GetPropertyChangedSignal("CFrame"):Connect(setcf)






			elseif (originst:IsA("BasePart") or originst:IsA("Decal") or originst:IsA("Texture")) and prop == "Transparency" then -- Floating point!!!!
				local settransparency
				function settransparency()
					if CSF:IsRobloxLocked(cinst) then
						local newcmodel = ADMrefit(ADMData, lastcmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
						end
						return
					end
					if ADMData.LEVEL == 3 then
						cevents.Transparency:Disconnect()
						cevents.Transparency = cinst:GetPropertyChangedSignal("Transparency"):Connect(settransparency)
					end
					local tr = props.Transparency
					local Atr = cinst.Transparency
					if math.abs(Atr-tr) <= 0.05 then return end





					if ADMData.LEVEL == 2 or ADMData.LEVEL == 3 then
						cinst.Transparency = tr
					elseif ADMData.LEVEL == 4 then
						Hypernull(function()
							cinst.Transparency = tr
						end)
						defer(function()
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, lastcmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
								end
								return
							end
							local tr = props.Transparency
							local Atr = cinst.Transparency
							if math.abs(Atr-tr) > 0.05 then
								Hypernull(function()
									cinst.Transparency = tr
								end)
								if CSF:IsRobloxLocked(cinst) then
									local newcmodel = ADMrefit(ADMData, lastcmodel)
									if newcmodel ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
									end
									return
								end

								local Atr2 = cinst.Transparency
								if math.abs(Atr2-tr) > 0.05 then
									local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_Transparency", Atr)
									if newcinst ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_Transparency", Atr2)
									end
									return
								end
								ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_Transparency", Atr)
							end
						end)
					end
					if CSF:IsRobloxLocked(cinst) then
						local newcmodel = ADMrefit(ADMData, lastcmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
						end
						return
					end

					local Atr2 = cinst.Transparency
					if math.abs(Atr2-tr) > 0.05 then
						local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
						ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_Transparency", Atr)
						if newcinst ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_Transparency", Atr2)
						end
						return
					end
					ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_Transparency", Atr)
				end
				cevents.Transparency = cinst:GetPropertyChangedSignal("Transparency"):Connect(settransparency)


			elseif typeof(val) == "Color3" then -- Floating point part 2
				local setcolor
				function setcolor()
					if CSF:IsRobloxLocked(cinst) then
						local newcmodel = ADMrefit(ADMData, lastcmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
						end
						return
					end
					if ADMData.LEVEL == 3 then
						cevents[prop]:Disconnect()
						cevents[prop] = cinst:GetPropertyChangedSignal(prop):Connect(setcolor)
					end
					local color = props[prop]
					local Acolor = cinst[prop]
					if (math.abs(Acolor.R-color.R) <= 0.005) and (math.abs(Acolor.G-color.G) <= 0.005) and (math.abs(Acolor.B-color.B) <= 0.005) then return end




					if ADMData.LEVEL == 2 or ADMData.LEVEL == 3 then
						cinst[prop] = color
					elseif ADMData.LEVEL == 4 then
						Hypernull(function()
							cinst[prop] = color
						end)
						defer(function()
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, lastcmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
								end
								return
							end
							local color = props[prop]
							local Acolor = cinst[prop]
							if (math.abs(Acolor.R-color.R) > 0.005) or (math.abs(Acolor.G-color.G) > 0.005) or (math.abs(Acolor.B-color.B) > 0.005) then
								Hypernull(function()
									cinst[prop] = color
								end)
								if CSF:IsRobloxLocked(cinst) then
									local newcmodel = ADMrefit(ADMData, lastcmodel)
									if newcmodel ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
									end
									return
								end

								local Acolor2 = cinst[prop]
								if (math.abs(Acolor2.R-color.R) > 0.005) or (math.abs(Acolor2.G-color.G) > 0.005) or (math.abs(Acolor2.B-color.B) > 0.005) then
									local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Acolor)
									if newcinst ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_"..prop, Acolor2)
									end
									return
								end
								ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Acolor)
							end
						end)
					end
					if CSF:IsRobloxLocked(cinst) then
						local newcmodel = ADMrefit(ADMData, lastcmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
						end
						return
					end

					local Acolor2 = cinst[prop]
					if (math.abs(Acolor2.R-color.R) > 0.005) or (math.abs(Acolor2.G-color.G) > 0.005) or (math.abs(Acolor2.B-color.B) > 0.005) then
						local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
						ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Acolor)
						if newcinst ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_"..prop, Acolor2)
						end
						return
					end
					ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Acolor)
				end
				cevents[prop] = cinst:GetPropertyChangedSignal(prop):Connect(setcolor)




			else -- Other properties
				if originst:IsA("MeshPart") and prop == "MeshId" then continue end

				local setprop
				function setprop()
					if CSF:IsRobloxLocked(cinst) then
						local newcmodel = ADMrefit(ADMData, lastcmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
						end
						return
					end
					if ADMData.LEVEL == 3 then
						cevents[prop]:Disconnect()
						cevents[prop] = cinst:GetPropertyChangedSignal(prop):Connect(setprop)
					end
					local val = props[prop]
					local Aval = cinst[prop]
					if Aval == val then return end




					if ADMData.LEVEL == 2 or ADMData.LEVEL == 3 then
						cinst[prop] = val
					elseif ADMData.LEVEL == 4 then
						Hypernull(function()
							cinst[prop] = val
						end)
						defer(function()
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, lastcmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
								end
								return
							end
							local val = props[prop]
							local Aval = cinst[prop]
							if Aval ~= val then
								Hypernull(function()
									cinst[prop] = val
								end)
								if CSF:IsRobloxLocked(cinst) then
									local newcmodel = ADMrefit(ADMData, lastcmodel)
									if newcmodel ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
									end
									return
								end

								local Aval2 = cinst[prop]
								if Aval2 ~= val then
									local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Aval)
									if newcinst ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_"..prop, Aval2)
									end
									return
								end
								ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Aval)
							end
						end)
					end
					if CSF:IsRobloxLocked(cinst) then
						local newcmodel = ADMrefit(ADMData, lastcmodel)
						if newcmodel ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
						end
						return
					end

					local Aval2 = cinst[prop]
					if Aval2 ~= val then
						local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
						ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Aval)
						if newcinst ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_"..prop, Aval2)
						end
						return
					end
					ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Aval)
				end
				cevents[prop] = cinst:GetPropertyChangedSignal(prop):Connect(setprop)
			end
		end





		if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
			-- Instance Counter
			local counter
			function counter(d)

				if CSF:IsRobloxLocked(cinst) then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
					end
					return
				end
				if CSF:IsRobloxLocked(d) then
					local orig = cinstref[d]
					local ATTACK
					if orig ~= nil then
						ATTACK = "ROBLOXLOCKED"
					else
						ATTACK = "ROBLOXLOCKED_Descendant"
					end

					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, ATTACK, d)
					end
					return
				end

				cevents.Counter:Disconnect()
				cevents.Counter = cinst.DescendantAdded:Connect(counter)

				if cinstref[d] == nil and d.Parent == cinst and d:IsA("TouchTransmitter") == false --[[<-- wtf roblox accessory touchinterests]] then

					local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
					if newcinst ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, originst, cinst, "DESCENDANT", d)
					end
					return
				end
			end
			cevents.Counter = cinst.DescendantAdded:Connect(counter)

			-- Instance Counter2
			local counter2
			function counter2(d)

				if CSF:IsRobloxLocked(cinst) then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
					end
					return
				end
				if CSF:IsRobloxLocked(d) then
					local orig = cinstref[d]
					local ATTACK
					if orig ~= nil then
						ATTACK = "ROBLOXLOCKED"
					else
						ATTACK = "ROBLOXLOCKED_Descendant"
					end

					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, ATTACK, d)
					end
					return
				end

				cevents.Counter2:Disconnect()
				cevents.Counter2 = cinst.DescendantRemoving:Connect(counter2)

				local origdesc = cinstref[d]
				if origdesc then
					local newcinst = ADMrefitindiv(ADMData, lastcmodel, origdesc, originsttable[origdesc], d, cinsttable[origdesc])
					if newcinst ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origdesc, d, "ANCESTRY_Exiting")
					end
					return
				end
			end
			cevents.Counter2 = cinst.DescendantRemoving:Connect(counter2)


			cevents.DestroyingEvent = cinst.Destroying:Connect(function()
				if CSF:IsRobloxLocked(lastcmodel) then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", lastcmodel)
					end
					return
				end
				if CSF:IsRobloxLocked(cinst) then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
					end
					return
				end
				local Alastcmodelparent = lastcmodel.Parent
				if Alastcmodelparent ~= ADMData.Parent or lastcmodel:FindFirstAncestorWhichIsA("ViewportFrame") or lastcmodel:FindFirstAncestorWhichIsA("Camera") then
					local newcmodel = ADMrefit(ADMData, lastcmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ANCESTRY", Alastcmodelparent)
					end
					return
				end

				local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
				if newcinst ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, originst, cinst, "ANCESTRY_Exiting")
				end
				return
			end)
		end


		-- Parent
		local setparent
		function setparent()

			if CSF:IsRobloxLocked(lastcmodel) then
				local newcmodel = ADMrefit(ADMData, lastcmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", lastcmodel)
				end
				return
			end
			if CSF:IsRobloxLocked(cinst) then
				local newcmodel = ADMrefit(ADMData, lastcmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ROBLOXLOCKED", cinst)
				end
				return
			end
			local Alastcmodelparent = lastcmodel.Parent
			if Alastcmodelparent ~= ADMData.Parent or lastcmodel:FindFirstAncestorWhichIsA("ViewportFrame") or lastcmodel:FindFirstAncestorWhichIsA("Camera") then
				local newcmodel = ADMrefit(ADMData, lastcmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, lastcmodel, "ANCESTRY", Alastcmodelparent)
				end
				return
			end

			local Acinstparent = cinst.Parent
			if (Acinstparent ~= cparent) then
				local newcinst = ADMrefitindiv(ADMData, lastcmodel, originst, origdata, cinst, cdata)
				if newcinst ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, originst, cinst, "ANCESTRY", Acinstparent)
				end
				return
			end


			if ADMData.LEVEL == 3 or ADMData.LEVEL == 4 then
				cevents.Parent:Disconnect()
				cevents.Parent = cinst.AncestryChanged:Connect(setparent)
			end
		end
		cevents.Parent = cinst.AncestryChanged:Connect(setparent)
	end





	------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------
	-- MORE HEADACHE

	function ADMsetnilprops(ADMData)
		-- ADMODELS: set nil props
		-- This sets the CloneSave's properties instead of the actual original instance (since that's what's getting cloned in ADMSETUP/ADMrefitindiv)

		local originsttable = ADMData.OrigInstances

		local modelcframe = ADMData.ModelCFrame
		originsttable[ADMData.OrigPrimaryPart].CloneSave.CFrame = modelcframe

		for originst, origdata in originsttable do
			local clonesave = origdata.CloneSave
			for prop, val in origdata.Properties do
				if originst:IsA("MeshPart") and prop == "MeshId" then continue end
				if prop == "PartCFrames" then -- For non-PrimaryParts only
					clonesave.CFrame = modelcframe * val.Offset * val.Offset2
				else
					clonesave[prop] = val
				end
			end
		end
	end

	function ADMcheckmain(ADMData)

		ADMsetnilprops(ADMData)
		----------------------------------------------------------------------------
		-- CMODEL

		-- References
		local origmodel = ADMData.OrigModel
		local cmodel = ADMData.CModel
		local cinstref = ADMData.CInstRef

		-- RobloxLocked defense
		if CSF:IsRobloxLocked(cmodel) then
			local newcmodel = ADMrefit(ADMData, cmodel)
			if newcmodel ~= nil then -- if actually refitted
				ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cmodel)
			end
			return
		end
		for i, inst in cmodel:GetChildren() do
			if CSF:IsRobloxLocked(inst) then
				local orig = cinstref[inst]
				local ATTACK
				if orig ~= nil then
					ATTACK = "ROBLOXLOCKED"
				else
					ATTACK = "ROBLOXLOCKED_Descendant"
				end

				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, ATTACK, inst)
				end
				return
			end
		end

		-- Check parent
		local Acmodelparent = cmodel.Parent
		if Acmodelparent ~= ADMData.Parent or cmodel:FindFirstAncestorWhichIsA("ViewportFrame") or cmodel:FindFirstAncestorWhichIsA("Camera") then
			local newcmodel = ADMrefit(ADMData, cmodel)
			if newcmodel ~= nil then -- if actually refitted
				ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ANCESTRY", Acmodelparent)
			end
			return
		end

		-- Check disconnects
		for name, event in ADMData.CModelEvents do
			if event.Connected == false then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "EVENT_FAIL")
				end
				return
			end
		end

		-- Model Instance Counter
		for i, inst in cmodel:GetChildren() do
			if cinstref[inst] == nil and inst:IsA("TouchTransmitter") == false --[[<-- wtf roblox accessory touchinterests]] then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "DESCENDANT", inst)
				end
				return
			end
		end


		----------------------------------------------------------------------------
		-- CINST

		-- More References
		local origprim = ADMData.OrigPrimaryPart

		local originsttable = ADMData.OrigInstances
		local cinsttable = ADMData.CInstances

		local modelcframe = ADMData.ModelCFrame

		for originst, cdata in cinsttable do
			-- References
			local cinst = cdata.CInst
			local origdata = originsttable[originst]
			local origparent = origdata.OrigParent

			-- RobloxLocked defense
			if CSF:IsRobloxLocked(cinst) then
				local newcmodel = ADMrefit(ADMData, cmodel)
				if newcmodel ~= nil then -- if actually refitted
					ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cinst)
				end
				return
			end
			for i, inst in cinst:GetChildren() do
				if CSF:IsRobloxLocked(inst) then
					local orig = cinstref[inst]
					local ATTACK
					if orig ~= nil then
						ATTACK = "ROBLOXLOCKED"
					else
						ATTACK = "ROBLOXLOCKED_Descendant"
					end

					local newcmodel = ADMrefit(ADMData, cmodel)
					if newcmodel ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, origmodel, cmodel, ATTACK, inst)
					end
					return
				end
			end

			local function instcheck()

				-- Check parent
				local cparent
				if origparent == origmodel then
					cparent = cmodel
				else
					cparent = cinsttable[origparent].CInst
				end
				local Acinstparent = cinst.Parent
				if Acinstparent ~= cparent then
					local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
					if newcinst ~= nil then -- if actually refitted
						ADMData.AttackedFunc(ADMData, originst, cinst, "ANCESTRY", Acinstparent)
					end
					return true
				end

				-- Check disconnect
				for name, event in cdata.CEvents do
					if event.Connected == false then
						local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
						if newcinst ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, originst, cinst, "EVENT_FAIL")
						end
						return true
					end
				end

				-- Instance Counter
				for i, inst in cinst:GetChildren() do
					if cinstref[inst] == nil and inst:IsA("TouchTransmitter") == false --[[<-- wtf roblox accessory touchinterests]] then
						local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
						if newcinst ~= nil then -- if actually refitted
							ADMData.AttackedFunc(ADMData, originst, cinst, "DESCENDANT", inst)
						end
						return true
					end
				end
			end
			if instcheck() == true then continue end


			-- Set/Check Properties
			local props = origdata.Properties

			local refitbreak = false -- Used for checking if we need to break out of the loop since model was refitted (ROBLOXLOCKED)
			local indivrefitcheck = false -- Used for checking if instance refitted

			if originst == origprim then -- Check Prim CFrame first
				pcall(function()
					local Acf = cinst.CFrame
					if Acf ~= modelcframe then
						if ADMData.LEVEL == 0 or ADMData.LEVEL == 1 or ADMData.LEVEL == 2 then
							cinst.CFrame = modelcframe
						elseif ADMData.LEVEL == 3 then
							cinst.CFrame = modelcframe
						elseif ADMData.LEVEL == 4 then
							Hypernull(function()
								cinst.CFrame = modelcframe
							end)
						end
						if CSF:IsRobloxLocked(cinst) then
							local newcmodel = ADMrefit(ADMData, cmodel)
							if newcmodel ~= nil then -- if actually refitted
								ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cinst)
							end
							refitbreak = true
							return
						end
						if ADMData.LEVEL ~= 0 and ADMData.LEVEL ~= 1 then
							local Acf2 = cinst.CFrame
							if Acf2 ~= modelcframe then
								local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
								indivrefitcheck = true
								ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
								if newcinst ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_CFrame", Acf2)
								end
								return
							end
						end
						ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
					end
				end)
			end
			if refitbreak == true then
				return
			end
			if indivrefitcheck == true then
				continue
			end
			if originst:IsA("MeshPart") then
				pcall(function()
					local Aid = cinst.MeshId
					if Aid ~= props.MeshId then
						if ADMData.LEVEL == 0 or ADMData.LEVEL == 1 or ADMData.LEVEL == 2 then
							cinst:ApplyMesh(originst)
						elseif ADMData.LEVEL == 3 then
							cinst:ApplyMesh(originst)
						elseif ADMData.LEVEL == 4 then
							Hypernull(function()
								cinst:ApplyMesh(originst)
							end)
						end
						if CSF:IsRobloxLocked(cinst) then
							local newcmodel = ADMrefit(ADMData, cmodel)
							if newcmodel ~= nil then -- if actually refitted
								ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cinst)
							end
							refitbreak = true
							return
						end

						if ADMData.LEVEL ~= 0 and ADMData.LEVEL ~= 1 then
							local Aid2 = cinst.MeshId
							if Aid2 ~= props.MeshId then
								local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
								indivrefitcheck = true
								ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_MeshId", Aid)
								if newcinst ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_MeshId", Aid2)
								end
								return
							end
						end
						ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_MeshId", Aid)
					end
				end)
				if refitbreak == true then
					return
				end
				if indivrefitcheck == true then
					continue
				end
			end

			for prop, val in props do
				pcall(function()
					if originst:IsA("MeshPart") and prop == "MeshId" then return end
					if originst:IsA("BasePart") and prop == "PartCFrames" then -- For non-PrimaryParts only
						local cf = modelcframe * val.Offset * val.Offset2
						local Acf = cinst.CFrame
						if Acf ~= cf then
							if ADMData.LEVEL == 0 or ADMData.LEVEL == 1 or ADMData.LEVEL == 2 then
								cinst.CFrame = cf
							elseif ADMData.LEVEL == 3 then
								cinst.CFrame = cf
							elseif ADMData.LEVEL == 4 then
								Hypernull(function()
									cinst.CFrame = cf
								end)
							end
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, cmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cinst)
								end
								refitbreak = true
								return
							end

							if ADMData.LEVEL ~= 0 and ADMData.LEVEL ~= 1 then
								local Acf2 = cinst.CFrame
								if Acf2 ~= cf then
									local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
									indivrefitcheck = true
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
									if newcinst ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_CFrame", Acf2)
									end
									return
								end
							end
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_CFrame", Acf)
						end






					elseif (originst:IsA("BasePart") or originst:IsA("Decal") or originst:IsA("Texture")) and prop == "Transparency" then
						local Atr = cinst.Transparency
						if math.abs(Atr-val) > 0.05 then -- this stupid float decimals bruh
							if ADMData.LEVEL == 0 or ADMData.LEVEL == 1 or ADMData.LEVEL == 2 then
								cinst.Transparency = val
							elseif ADMData.LEVEL == 3 then
								cinst.Transparency = val
							elseif ADMData.LEVEL == 4 then
								Hypernull(function()
									cinst.Transparency = val
								end)
							end
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, cmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cinst)
								end
								refitbreak = true
								return
							end

							if ADMData.LEVEL ~= 0 and ADMData.LEVEL ~= 1 then
								local Atr2 = cinst.Transparency
								if math.abs(Atr2-val) > 0.05 then -- this stupid float decimals bruh
									local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
									indivrefitcheck = true
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_Transparency", Atr)
									if newcinst ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_Transparency", Atr2)
									end
									return
								end
							end
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_Transparency", Atr)
						end
					elseif typeof(val) == "Color3" then -- Floating point :(
						local Acolor = cinst[prop]
						if (math.abs(Acolor.R-val.R) > 0.005) or (math.abs(Acolor.G-val.G) > 0.005) or (math.abs(Acolor.B-val.B) > 0.005) then
							if ADMData.LEVEL == 0 or ADMData.LEVEL == 1 or ADMData.LEVEL == 2 then
								cinst[prop] = val
							elseif ADMData.LEVEL == 3 then
								cinst[prop] = val
							elseif ADMData.LEVEL == 4 then
								Hypernull(function()
									cinst[prop] = val
								end)
							end
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, cmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cinst)
								end
								refitbreak = true
								return
							end

							if ADMData.LEVEL ~= 0 and ADMData.LEVEL ~= 1 then
								local Acolor2 = cinst[prop]
								if (math.abs(Acolor2.R-val.R) > 0.005) or (math.abs(Acolor2.G-val.G) > 0.005) or (math.abs(Acolor2.B-val.B) > 0.005) then
									local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
									indivrefitcheck = true
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Acolor)
									if newcinst ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_"..prop, Acolor2)
									end
									return
								end
							end
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Acolor)
						end
					else				
						local Aval = cinst[prop]
						if Aval ~= val then
							if ADMData.LEVEL == 0 or ADMData.LEVEL == 1 or ADMData.LEVEL == 2 then
								cinst[prop] = val
							elseif ADMData.LEVEL == 3 then
								cinst[prop] = val
							elseif ADMData.LEVEL == 4 then
								Hypernull(function()
									cinst[prop] = val
								end)
							end
							if CSF:IsRobloxLocked(cinst) then
								local newcmodel = ADMrefit(ADMData, cmodel)
								if newcmodel ~= nil then -- if actually refitted
									ADMData.AttackedFunc(ADMData, origmodel, cmodel, "ROBLOXLOCKED", cinst)
								end
								refitbreak = true
								return
							end

							if ADMData.LEVEL ~= 0 and ADMData.LEVEL ~= 1 then
								local Aval2 = cinst[prop]
								if Aval2 ~= val then
									local newcinst = ADMrefitindiv(ADMData, cmodel, originst, origdata, cinst, cdata)
									indivrefitcheck = true
									ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Aval)
									if newcinst ~= nil then -- if actually refitted
										ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_FAIL_"..prop, Aval2)
									end
									return
								end
							end
							ADMData.AttackedFunc(ADMData, originst, cinst, "PROPERTY_"..prop, Aval)
						end
					end
				end)
				if refitbreak == true then
					break
				end
				if indivrefitcheck == true then
					break
				end
			end
			if refitbreak == true then
				return
			end
		end
	end

	function ADMcheckothers(ADMData)
		pcall(function()

			-- Refit Failsafe
			if os.clock() - ADMData.RefitFailsafe >= ADMData.FailsafeDelay then
				ADMData.RefitFailsafe = os.clock()
				if ADMData.FailsafeEnabled == true then
					ADMrefit(ADMData, ADMData.CModel, false)
				end
			end

			-- References
			local cmodel = ADMData.CModel
			for i, inst in cmodel:GetDescendants() do
				pcall(function()
					inst.Archivable = false
					if inst:IsA("BasePart") then
						inst.CastShadow = false
					end
				end)
			end
			cmodel.Archivable = false

			pcall(function()
				cmodel.Parent = ADMData.Parent
			end)

			cmodel.Name = ADMData.OrigModel.Name.. " (ゆうれい)"
		end)
	end




	---------------------------------------------------------------------







	-- ghosts are lonely...
	return YUREI
end)()

local KKR_MF = KKR.MainFunctions
local KKR_IF = KKR.InstFunctions
local KKR_IF_Humanoid = KKR_IF.Humanoid
local KKR_IF_Model = KKR_IF.Model
local KKR_IF_BasePart = KKR_IF.BasePart
local KKR_IF_DataModelMesh = KKR_IF.DataModelMesh
local KKR_IF_Player = KKR_IF.Player
local KKR_IF_BaseScript = KKR_IF.BaseScript
local KKR_IF_MISC = KKR_IF.MISC

print("> [WLW] Instances loaded. \n] -")





--[[ ----------------------------------

			-- REMOTE SETUP --

---------------------------------- ]]--
print("- [\n> [WLW] Initializing remote...")

-- REMOTE
local RemoteName = "[["..tostring(os.clock())..tostring(userid)
RemoteName = RemoteName:sub(1, 30) -- fat name limit

local Remote = Instance.new("RemoteEvent")
Remote.Name = RemoteName
Remote.Parent = reps

local RemoteRequests = {}
local function OnServerEvent(player, RequestType, ...)
	if player == plr and RemoteRequests[RequestType] then
		RemoteRequests[RequestType](...)
	end
end
Remote.OnServerEvent:Connect(OnServerEvent)


-- REMOTE CHECKER
local RemoteBlackmail = {}
local RemoteCheck = heartbeat:Connect(function()
	local remotes = 0
	for i, remote in reps:GetChildren() do
		pcall(function()
			if remote:IsA("RemoteEvent") and remote.Name == RemoteName then
				remotes = remotes + 1
			end
		end)
	end
	if remotes ~= 1 or CSF:IsRobloxLocked(Remote) then
		pcall(function()
			Remote:Destroy()
		end)
		for i, remote in reps:GetChildren() do
			pcall(function()
				if remote:IsA("RemoteEvent") and remote.Name == RemoteName then
					remote:Destroy()
				end
			end)
		end

		-- New Remote
		Remote = Instance.new("RemoteEvent")
		Remote.Name = RemoteName
		Remote.Parent = reps
		Remote.OnServerEvent:Connect(OnServerEvent)

		-- Blackmail the people trying to kill the remote by lagging the hell out of the server lolmao
		for i = 1, 1000 do
			local part = Instance.new("Part")
			table.insert(RemoteBlackmail, part)
			part.CFrame = CFrame.new(rnd:NextNumber(-9999999999, 9999999999), rnd:NextNumber(-9999999999, 9999999999), rnd:NextNumber(-9999999999, 9999999999))	
		end

	else
		if #RemoteBlackmail > 0 then
			for i = math.floor(#RemoteBlackmail * 2/3), 1, -1 do
				RemoteBlackmail[i]:Destroy()
				table.remove(RemoteBlackmail, i)
			end
		end
	end
end)


print("> [WLW] Remote loaded. \n] -")



----------------------------------------------------------------------------

local CFRAMES = {}
--[[
	CHARACTER
		- Character
		- Head
		- Torso
		- Right Arm
		- Left Arm
		- Right Leg
		- Left Leg
	OBJECTS
		- Broom
		- Hakero
	BALLS
		- White
		- Black1
		- Black2
		- Blue
		- Red
		- Yellow
		- Green
		- Orange
		- Magenta
		- RAINBOW
	MOUSE
	CAMERA
		- CFrame
		- Focus
]]


----------------------------------------------------------------------------

--[[ ----------------------------------

		-- CHARACTER SETUP --

---------------------------------- ]]--

print("- [\n> [WLW] Initializing character...")

local CHARACTERSCALE = SETTINGS.CharacterScale

---------------- MODEL PREPARATION ----------------
local charmparts = MODELS.MParts

-- RESIZE
CSF:ResizeModel(MODELS["Wicked Law's Witch"], CHARACTERSCALE)
CSF:ResizeModel(MODELS["Broom"], CHARACTERSCALE)
CSF:ResizeModel(MODELS["Hakero"], CHARACTERSCALE)

CSF:ResizeModel(charmparts["MHead"], CHARACTERSCALE)
CSF:ResizeModel(charmparts["MBody"], CHARACTERSCALE)

for i, ball in MODELS["BALLS1"]:GetChildren() do
	if ball:IsA("BasePart") then
		ball.Size = ball.Size * SETTINGS.BallsScale
		for i, texture in ball:GetDescendants() do
			if texture:IsA("Texture") then
				texture.StudsPerTileU = texture.StudsPerTileU * CHARACTERSCALE
				texture.StudsPerTileV = texture.StudsPerTileV * CHARACTERSCALE
			end
		end
	end
end
for i, ball in MODELS["BALLS2"]:GetChildren() do
	if ball:IsA("BasePart") then
		ball.Size = ball.Size * SETTINGS.BallsScale
		for i, texture in ball:GetDescendants() do
			if texture:IsA("Texture") then
				texture.StudsPerTileU = texture.StudsPerTileU * CHARACTERSCALE
				texture.StudsPerTileV = texture.StudsPerTileV * CHARACTERSCALE
			end
		end
	end
end

local function QuickMeshResize(Model, IgnoreParts)
	local IgnoreParts = IgnoreParts or {}
	for i, mesh in Model:GetDescendants() do
		if mesh:IsA("DataModelMesh") and table.find(IgnoreParts, mesh.Parent) == nil then
			mesh.Scale = mesh.Scale * CHARACTERSCALE
			mesh.Offset = mesh.Offset * CHARACTERSCALE
		end
	end
end
QuickMeshResize(MODELS["Broom"])
QuickMeshResize(MODELS["Hakero"], {MODELS["Hakero"].light1, MODELS["Hakero"].light2})

QuickMeshResize(charmparts["MHead"])
QuickMeshResize(charmparts["MBody"])



-- PRIMARYPART
charmparts["MHead"].PrimaryPart = charmparts["MHead"].Hat
charmparts["MBody"].PrimaryPart = charmparts["MBody"].MHumanoidRootPart


----------------------------------------------------------------------------
---------------- CHARACTER ----------------
local ADMCharacters = {}

-- Character
local origchar = MODELS["Wicked Law's Witch"]:Clone()
local orighrp = origchar.HumanoidRootPart
local orighead = origchar["Head"]
local origtorso = origchar["Torso"]
local origra = origchar["Right Arm"]
local origla = origchar["Left Arm"]
local origrl = origchar["Right Leg"]
local origll = origchar["Left Leg"]

local ADMchar = YUREI:Initialize(origchar, origchar.HumanoidRootPart, workspace)
table.insert(ADMCharacters, ADMchar)


-- MParts
local origmhead = charmparts["MHead"]:Clone()
local origmbody = charmparts["MBody"]:Clone()
local ADMmhead = YUREI:Initialize(origmhead, origmhead.PrimaryPart, workspace)
local ADMmbody = YUREI:Initialize(origmbody, origmbody.PrimaryPart, workspace)

table.insert(ADMCharacters, ADMmhead)
table.insert(ADMCharacters, ADMmbody)


-- Broom
local origbroom = MODELS.Broom:Clone()
local ADMbroom = YUREI:Initialize(origbroom, origbroom.Broom, workspace)

-- Broom
local orighakero = MODELS.Hakero:Clone()
local ADMhakero = YUREI:Initialize(orighakero, orighakero.Center, workspace)



-- No Real Character
local NoCharacterAdded = plr.CharacterAdded:Connect(function(c)
	c:Destroy()
end)
local NoCharacterAdded2 = heartbeat:Connect(function()
	if plr.Character then
		plr.Character:Destroy()
		plr.Character = nil
	end
end)

---------------- VALUES ----------------
local currentcf = CFrame.new(696.9, 1000, 696.9) -- Character CFrame
local currentlook = Vector3.new(0, 0, -1) -- Character LookVector
local currentdir = Vector3.zero -- Character Movement Direction

local currentspeed = SETTINGS.FlySpeed
local currentvelocity = Vector3.zero -- Character Velocity
local currentforce = Vector3.zero -- Character Applied Force (decays over time)

local FLOORPLACEHOLDER = Instance.new("Part")
FLOORPLACEHOLDER:Destroy()
local currentfloor = FLOORPLACEHOLDER -- Current ground that character is standing on/directly above on

---------------- MOVEMENT MODES ----------------
local movementenabled = true
local movementforcestop = false -- Priority Movement - overwrite no matter what state movement should be in
local moving = false

local flymode = false
local runmode = false

local idlemode = 1

---------------- CHARACTER STATE ----------------
--[[
	CharacterState.Event:Connect(function(laststate, currentstate))
	
	-- STATES
		- Jumping
		- Falling
		
		- Walking
		- Running
		- Flying
		
		- IdleFly
		- IdleGround
		
		- Disabled (when movement is disabled)
	
	
]]
local CurrentCharacterState = "IdleFly"
local CharacterState = Instance.new("BindableEvent")
function UpdateCharState(state)
	if state ~= CurrentCharacterState then
		local laststate = CurrentCharacterState
		CurrentCharacterState = state
		CharacterState:Fire(laststate, state)
	end
end

---------------- MOVEMENT FUNCTIONS ----------------
function UpdateVelocity(vel)
	currentvelocity = Vector3.new(vel.X or currentvelocity.X, vel.Y or currentvelocity.Y, vel.Z or currentvelocity.Z)
end

local ForceTWEENOBJ = ts:Create(workspace, TweenInfo.new(0), {}) -- Placeholder
function UpdateForce(force, forcedecay)
	ForceTWEENOBJ:Pause()
	local forcedecay = forcedecay or 1 -- Time it takes to completely decay force to 0 (in seconds)

	currentforce = Vector3.new(force.X or currentforce.X, force.Y or currentforce.Y, force.Z or currentforce.Z)

	-- Force decay
	ForceTWEENOBJ = CSE:TweenCustom(currentforce, Vector3.zero, TweenInfo.new(forcedecay, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), function(val)
		currentforce = val
	end)
end

function UpdateFloor()
	local currentpos = currentcf.Position
	local charfilter = GetCharFilter()
	local result = CSF:Raycast(currentpos, currentpos - Vector3.new(0, 1, 0), 1000, charfilter)
	table.clear(charfilter)
	if result.Instance ~= nil then
		if CSF:IsRobloxLocked(result.Instance) == false then
			currentfloor = result.Instance
		end
	else
		currentfloor = FLOORPLACEHOLDER
	end
end

function UpdateMovement(deltaTime)

	---------------- INITIAL VALUES ----------------
	local charfilter = GetCharFilter()
	local newpos = currentcf.Position
	local look = currentlook
	local newvel = {
		X = currentvelocity.X,
		Y = currentvelocity.Y,
		Z = currentvelocity.Z
	}
	local frameforce = { -- Force at frame
		X = currentforce.X * deltaTime,
		Y = currentforce.Y * deltaTime,
		Z = currentforce.Z * deltaTime
	}

	if flymode == true then
		currentspeed = SETTINGS.FlySpeed
	elseif runmode == false then
		currentspeed = SETTINGS.WalkSpeed
	else
		currentspeed = SETTINGS.RunSpeed
	end

	---------------- ENABLED ----------------
	if movementenabled == true and movementforcestop == false then
		-- Edit Values before update

		newvel.X = currentdir.X * currentspeed * deltaTime
		newvel.Z = currentdir.Z * currentspeed * deltaTime

		if flymode == false then
			---------------- WALKING ----------------

			-- Check ground
			local currentpos = currentcf.Position

			-- assume the next position to use for raycast distance (wont fall through floor even if laggy server)
			local assumedpos = currentpos - Vector3.new(0, newvel.Y + frameforce.Y - (SETTINGS.Gravity * deltaTime), 0)
			local assumeddist = (assumedpos-currentpos).Magnitude
			local result = CSF:Raycast(currentpos, currentpos - Vector3.new(0, 1, 0), math.max(4 * CHARACTERSCALE, assumeddist), charfilter)
			local rpos = result.Position


			if (result.Instance or rpos.Y <= workspace.FallenPartsDestroyHeight) and currentvelocity.Y <= 0 then -- Found ground and falling

				-- Character 3 studs above ground
				-- Set Y Velocity 0
				-- Set negative Y forces to 0 (or if sum of forces are below ground level)

				local posY = math.max(rpos.Y, workspace.FallenPartsDestroyHeight)
				newpos = Vector3.new(currentpos.X, posY + (3 * CHARACTERSCALE), currentpos.Z)

				newvel.Y = 0
				if frameforce.Y < 0 or (-SETTINGS.Gravity * deltaTime) + (frameforce.Y) < 0 then
					frameforce.Y = 0
				end

			else -- Gravity

				-- Decrease Y Velocity by GravAccel (/60 for every frame)
				newvel.Y = newvel.Y - (SETTINGS.Gravity * deltaTime) 

			end

			-- LookVector without Y coordinate if walking
			look = Vector3.new(look.X, 0, look.Z)


		else
			---------------- FLYING ----------------

			-- Set Y Velocity by move direction (no gravity physics)
			newvel.Y = currentdir.Y * currentspeed * deltaTime
		end
	else

		currentdir = Vector3.zero
		newvel = {X = 0, Y = 0, Z = 0}
		if flymode == false then
			-- LookVector without Y coordinate if walking
			look = Vector3.new(look.X, 0, look.Z)
		end
	end


	---------------- UPDATE VALUES ----------------
	-- Final Velocity (with Force)
	local finalvelY = math.min(newvel.Y + frameforce.Y, SETTINGS.MaxFallVelocity)
	if flymode == false and finalvelY ~= 0 then
		newvel.X = newvel.X * SETTINGS.AirSpeedMultiplier
		newvel.Z = newvel.Z * SETTINGS.AirSpeedMultiplier
	end
	local finalvel = {
		X = newvel.X + frameforce.X,
		Y = finalvelY,
		Z = newvel.Z + frameforce.Z
	}
	UpdateVelocity(finalvel)
	currentlook = look


	---------------- UPDATE FINAL ----------------
	-- Character
	local lastcf = currentcf
	currentcf = CFrame.new(newpos, newpos + look) + currentvelocity
	moving = currentcf.Position ~= lastcf.Position

	-- Character State
	if movementenabled == true then
		if flymode == true then
			if moving == false then
				UpdateCharState("IdleFly")
			else
				UpdateCharState("Flying")
			end
		else
			if currentvelocity.Y > 0 then
				UpdateCharState("Jumping")
			elseif currentvelocity.Y < 0 then
				UpdateCharState("Falling")
			elseif currentvelocity.X == 0 and currentvelocity.Z == 0 then
				UpdateCharState("IdleGround")
			else
				if runmode == false then
					UpdateCharState("Walking")
				else
					UpdateCharState("Running")
				end
			end
		end
	else
		UpdateCharState("Disabled")
	end

	table.clear(charfilter)
end
local CharacterMovement = heartbeat:Connect(UpdateMovement)


---------------- LOCAL MOVEMENT ----------------
RemoteRequests.UPDATEMOVEMENTLOCAL = function(look, cfdirection)
	if movementenabled == true then

		local dircf = currentcf * cfdirection
		if dircf.Position ~= currentcf.Position then -- If it actually moved
			currentdir = (dircf.Position-currentcf.Position).Unit
			currentlook = look
		else
			currentdir = Vector3.zero
		end
	end
end

---------------- OTHER ----------------
RemoteRequests.UPDATEMOUSE = function(cf)
	CFRAMES.MOUSE = cf
end

CFRAMES.CAMERA = {CFrame = CFrame.identity, Focus = CFrame.identity}
RemoteRequests.UPDATECAMERA = function(Data)
	CFRAMES.CAMERA.CFrame = Data.CFrame
	CFRAMES.CAMERA.Focus = Data.Focus
end



print("> [WLW] Character loaded. \n] -")




---------------------------------------------------------------------

--[[ ----------------------------------

		-- ANIMATIONS --

---------------------------------- ]]--

print("- [\n> [WLW] Loading animations...")

--[[
	animfunc = AnimFunction(AT)
	AnimationNew: animfunc --> AnimTrack
	
	AnimTrack = {
		Name = AnimName
		Function = AnimFunction
		IsPlaying = true/false
		TweenObjects = {
			["JointsOffset"] = tweenstable
			["ObjOffset"] = tweenstable
		}
		
		function AT:JointsOffsetChange
		function AT:JointsOffsetTween
		function AT:ObjOffsetChange
		function AT:ObjOffsetTween
		
		function AT:Wait()
		function AT:Delay()
		function AT:ForceStop()
	}
	
	------------------------------------------------------------------------------------------------------------------------------------------
	
	ANIMATIONS = {
		Name = AnimFunction
	}
	AnimationIsPlaying: Name --> bool
	AnimationPlay: Name
	AnimationStop: Name
	
	
	
]]

------------------------------ ANIMATION CHARACTER VALUES -------------------------------
---------------- JOINTS ----------------
-- CharacterOffset is the joints offset from character (For reference only // not animated)
-- CurrentOffset is the offset from CharacterOffset
local jointscframes = {
	["Neck"] = {
		CharacterOffset = CFrame.new(Vector3.new(0, 1.5, 0) * CHARACTERSCALE),
		CurrentOffset = CFrame.identity
	},
	["RootJoint"] = {
		CharacterOffset = CFrame.identity,
		CurrentOffset = CFrame.identity
	},
	["Right Shoulder"] = {
		CharacterOffset = CFrame.new(Vector3.new(1.5, 0, 0) * CHARACTERSCALE),
		CurrentOffset = CFrame.identity
	},
	["Left Shoulder"] = {
		CharacterOffset = CFrame.new(Vector3.new(-1.5, 0, 0) * CHARACTERSCALE),
		CurrentOffset = CFrame.identity
	},
	["Right Hip"] = {
		CharacterOffset = CFrame.new(Vector3.new(0.5, -2, 0) * CHARACTERSCALE),
		CurrentOffset = CFrame.identity
	},
	["Left Hip"] = {
		CharacterOffset = CFrame.new(Vector3.new(-0.5, -2, 0) * CHARACTERSCALE),
		CurrentOffset = CFrame.identity
	}
}

---------------- OBJECTS ----------------
-- Objects have CF recordings since they have more freedom in movement and animation than joints/limbs
local objectscframes = {
	["Broom"] = {
		CurrentCFrame = currentcf,
		CurrentOffset = CFrame.identity,
	},
	["Hakero"] = {
		CurrentCFrame = currentcf,
		CurrentOffset = CFrame.identity,
	}
}

---------------- OTHERS ----------------
-- MParts Offsets from limbs
local mheadcharoffset = CFrame.new(0.0199966431, 1.0999999, -9.53674316e-07, 0.98480767, 0.173648179, 0, -0.172353834, 0.97746712, -0.121869348, -0.0211623907, 0.120017871, 0.992546082)
local mtorsocharoffset = CFrame.new(0.000503540039, -0.0346679688, -0.000610351562, 1, 8.56402167e-08, -1.68613411e-07, 8.56402593e-08, 1.00000095, -9.23871994e-07, -2.40870179e-07, -9.23871994e-07, 1)
local mracharoffset = CFrame.new(0.0449981689, 0.715002775, 0, 1.31134158e-07, 1, 4.37111289e-08, -7.01627036e-21, -4.37110224e-08, 0.999996543, 1, -1.31134158e-07, -5.73202018e-15)
local mlacharoffset = CFrame.new(-0.0450057983, 0.715002775, 0, -4.37113883e-08, -1, 4.37108518e-08, 1.40988219e-23, -4.37107168e-08, -0.999996543, 1, -4.37113883e-08, 1.91066196e-15)
local mrlcharoffset = CFrame.new(0, -0.609998941, 0, 1, 0, 0, 0, 0.999996543, 0, 0, 0, 1)
local mllcharoffset = CFrame.new(0, -0.609998941, 0, 1, 0, 0, 0, 0.999996543, 0, 0, 0, 1)

-- Scale them
mheadcharoffset = CFrame.new(mheadcharoffset.Position * CHARACTERSCALE) * mheadcharoffset.Rotation
mtorsocharoffset = CFrame.new(mtorsocharoffset.Position * CHARACTERSCALE) * mtorsocharoffset.Rotation
mracharoffset = CFrame.new(mracharoffset.Position * CHARACTERSCALE) * mracharoffset.Rotation
mlacharoffset = CFrame.new(mlacharoffset.Position * CHARACTERSCALE) * mlacharoffset.Rotation
mrlcharoffset = CFrame.new(mrlcharoffset.Position * CHARACTERSCALE) * mrlcharoffset.Rotation
mllcharoffset = CFrame.new(mllcharoffset.Position * CHARACTERSCALE) * mllcharoffset.Rotation

---------------- EASIER REFERENCE ----------------
local JCFneck = jointscframes["Neck"]
local JCFrtj = jointscframes["RootJoint"]
local JCFrs = jointscframes["Right Shoulder"]
local JCFls = jointscframes["Left Shoulder"]
local JCFrh = jointscframes["Right Hip"]
local JCFlh = jointscframes["Left Hip"]

local OCFbroom = objectscframes["Broom"]
local OCFhakero = objectscframes["Hakero"]




---------------- SHOW/HIDE OBJECTS ----------------
-- Broom Show/Hide
local BroomActivated = true
local BroomSwitchTime = os.clock()
local BroomTWEENOBJ = ts:Create(workspace, TweenInfo.new(0), {}) -- Placeholder
function BroomSwitch(act)
	if BroomActivated == act then return end
	BroomActivated = act
	BroomSwitchTime = os.clock()
	local currentT = BroomSwitchTime

	local start, finish, levelswitch
	if BroomActivated == true then
		start = 1
		finish = 0
		levelswitch = SETTINGS.YUREI_LEVEL
	else
		start = 0
		finish = 1
		levelswitch = 0
		task.delay(0.1, function()
			if currentT == BroomSwitchTime then -- still same switch time (don't destroy if not switched)
				pcall(function()
					ADMbroom:GetCloneInst(origbroom):Destroy()
				end)
			end
		end)
	end

	for i, part in ADMbroom.OrigModel:GetDescendants() do
		if part:IsA("BasePart") then
			ADMbroom:SetRecordedProperty(part, "Transparency", start)
		end
	end
	ADMbroom:UpdateSetting("LEVEL", levelswitch)
	BroomTWEENOBJ:Pause()
	BroomTWEENOBJ = CSE:TweenCustom(start, finish, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), function(val)
		for i, part in ADMbroom.OrigModel:GetDescendants() do
			if part:IsA("BasePart") then
				ADMbroom:SetRecordedProperty(part, "Transparency", val)
			end
		end
	end)
end

-- Hakero Show/Hide
local HakeroActivated = true
local HakeroSwitchTime = os.clock()
local HakeroTWEENOBJ = ts:Create(workspace, TweenInfo.new(0), {}) -- Placeholder
function HakeroSwitch(act)
	if HakeroActivated == act then return end
	HakeroActivated = act
	HakeroSwitchTime = os.clock()
	local currentT = HakeroSwitchTime

	local start, finish, levelswitch
	if HakeroActivated == true then
		start = 1
		finish = 0
		levelswitch = SETTINGS.YUREI_LEVEL
	else
		start = 0
		finish = 1
		levelswitch = 0
		task.delay(0.1, function()
			if currentT == HakeroSwitchTime then -- still same switch time (don't destroy if not switched)
				pcall(function()
					ADMhakero:GetCloneInst(orighakero):Destroy()
				end)
			end
		end)
	end

	local origprim = ADMhakero.OrigPrimaryPart
	for i, part in ADMhakero.OrigModel:GetDescendants() do
		if part:IsA("BasePart") and part ~= origprim then
			ADMhakero:SetRecordedProperty(part, "Transparency", start)
		end
	end
	ADMhakero:UpdateSetting("LEVEL", levelswitch)
	HakeroTWEENOBJ:Pause()
	HakeroTWEENOBJ = CSE:TweenCustom(start, finish, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), function(val)
		for i, part in ADMhakero.OrigModel:GetDescendants() do
			if part:IsA("BasePart") and part ~= origprim then
				ADMhakero:SetRecordedProperty(part, "Transparency", val)
			end
		end
	end)
end


------------------------------------------------------------------------------------------------------------------------------------------
------------------------------ ANIMATIONS -------------------------------
local ANIMATIONS = {
	["IdleGround1"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		local newneckoffset = CFrame.Angles(0, mrad(33.75), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(33.75), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.05, -0.15, -0.1) * CHARACTERSCALE) * CFrame.Angles(mrad(30), 0, -mrad(15))
		local newlsoffset = CFrame.new(Vector3.new(-0.05, 0, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, mrad(11.25))
		local newrhoffset = CFrame.Angles(-mrad(11.25), -mrad(30), mrad(7)) * CFrame.new(Vector3.new(0.35, 0, 0) * CHARACTERSCALE)
		local newlhoffset = CFrame.new(Vector3.new(-0.3, 0, -0.1) * CHARACTERSCALE) * CFrame.Angles(0, mrad(27), -mrad(10)) * CFrame.Angles(mrad(11), 0, 0)


		local tweeninfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		local newbroomoffset = CFrame.new(Vector3.new(0, 0, 2.5) * CHARACTERSCALE) * CFrame.Angles(-math.rad(90), 0, 0)
		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, newbroomoffset, tweeninfo)

		AT:Wait(tweeninfo.Time)

		local animsineval = 0
		while true do
			AT:Wait()

			AT:JointsOffsetChange("RootJoint", CFrame.new(0, msinrad(animsineval) * 0.075 * CHARACTERSCALE, 0) * newrtjoffset)
			AT:JointsOffsetChange("Right Hip", CFrame.new(0, -msinrad(animsineval) * 0.065 * CHARACTERSCALE, 0) * newrhoffset * CFrame.Angles(-msinrad(animsineval) * 0.01, 0, 0))
			AT:JointsOffsetChange("Left Hip", CFrame.new(0, -msinrad(animsineval) * 0.065 * CHARACTERSCALE, 0) * newlhoffset * CFrame.Angles(msinrad(animsineval) * 0.025, 0, 0))




			-- Delayed sine
			local dsine = math.max(0, animsineval - 33.75)
			AT:JointsOffsetChange("Neck", newneckoffset * CFrame.Angles(msinrad(dsine) * 0.075, 0, 0))

			local dsine2 = math.max(0, animsineval - 22.5)
			AT:JointsOffsetChange("Right Shoulder", CFrame.new(0, msinrad(dsine) * 0.075 * CHARACTERSCALE, 0) * newrsoffset * CFrame.Angles(-msinrad(dsine2) * 0.075, 0, 0))

			local dsine3 = math.max(0, animsineval - 45)
			AT:JointsOffsetChange("Left Shoulder", CFrame.new(Vector3.new(0, msinrad(dsine3) * 0.075, msinrad(dsine3) * 0.075) * CHARACTERSCALE) * newlsoffset * CFrame.Angles(-msinrad(dsine3) * 0.075, 0, 0))


			animsineval = animsineval + 1.5
		end
	end,
	["IdleGround2"] = function(AT)
		BroomSwitch(true)
		HakeroSwitch(false)

		-- References
		local newneckoffset = CFrame.Angles(0, mrad(33.75), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(21), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.25, 0.5, 0.42) * CHARACTERSCALE) * CFrame.Angles(0, 0, mrad(67.5)) * CFrame.Angles(-mrad(22.5), 0, 0)
		local newlsoffset = CFrame.new(Vector3.new(-0.05, 0.15, 0.42) * CHARACTERSCALE) * CFrame.Angles(0, mrad(22.5), -mrad(26))
		local newrhoffset = CFrame.new(Vector3.new(0.2, 0.075, 0.225) * CHARACTERSCALE) * CFrame.Angles(-mrad(17), 0, mrad(11.25)) * CFrame.Angles(0, -mrad(22.5), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.15, 0, -0.05) * CHARACTERSCALE) * CFrame.Angles(mrad(6), mrad(22.5), -mrad(11.25))


		local tweeninfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)


		local initial = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(Vector3.new(0.35, -1, 0) * CHARACTERSCALE)
		local defaultbroomoffset = newrtjoffset * JCFrs.CharacterOffset * newrsoffset * CFrame.new(Vector3.new(0.35, -1, 0) * CHARACTERSCALE)
		local newbroomoffset = defaultbroomoffset * CFrame.Angles(0, mrad(90), 0) * CFrame.Angles(-mrad(22.5), 0, 0)
		AT:ObjectsOffsetTween("Broom", initial, newbroomoffset, tweeninfo)

		AT:Wait(tweeninfo.Time)

		local animsineval = 0
		while true do
			AT:Wait()

			AT:JointsOffsetChange("RootJoint", CFrame.new(0, msinrad(animsineval) * 0.075 * CHARACTERSCALE, 0) * newrtjoffset)
			AT:JointsOffsetChange("Right Hip", CFrame.new(0, -msinrad(animsineval) * 0.065 * CHARACTERSCALE, 0) * newrhoffset * CFrame.Angles(-msinrad(animsineval) * 0.01, 0, 0))
			AT:JointsOffsetChange("Left Hip", CFrame.new(0, -msinrad(animsineval) * 0.065 * CHARACTERSCALE, 0) * newlhoffset * CFrame.Angles(msinrad(animsineval) * 0.025, 0, 0))




			-- Delayed sine
			local dsine = math.max(0, animsineval - 33.75)
			AT:JointsOffsetChange("Neck", newneckoffset * CFrame.Angles(msinrad(dsine) * 0.075, 0, 0))

			local dsine2 = math.max(0, animsineval - 22.5)
			local sinersoffset = newrsoffset * CFrame.Angles(0, 0, -msinrad(dsine2) * 0.075)
			AT:JointsOffsetChange("Right Shoulder", sinersoffset)

			local dsine3 = math.max(0, animsineval - 45)
			AT:JointsOffsetChange("Left Shoulder", CFrame.new(Vector3.new(0, msinrad(dsine3) * 0.075, msinrad(dsine3) * 0.075) * CHARACTERSCALE) * newlsoffset * CFrame.Angles(-msinrad(dsine3) * 0.075, 0, -msinrad(dsine3) * 0.075))

			defaultbroomoffset = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(Vector3.new(0.35, -1, 0) * CHARACTERSCALE)
			local newbroomoffset = defaultbroomoffset * CFrame.Angles(0, mrad(90), 0) * CFrame.Angles(-mrad(22.5), 0, 0)
			AT:ObjectsOffsetChange("Broom", newbroomoffset * CFrame.Angles(0, -msinrad(dsine2) * 0.05, 0))

			animsineval = animsineval + 1.5
		end
	end,
	["Walking"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		-- Set to initial walking pose
		local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tilt = 7
		local tiltlegoffset = -0.1

		local newneckoffset = CFrame.Angles(mrad(tilt), 0, 0)
		local newrtjoffset = CFrame.Angles(-mrad(tilt), 0, 0)
		local newrsoffset2 = CFrame.new(Vector3.new(0.05, 0.15, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, mrad(11.25))
		local newlsoffset2 = CFrame.new(Vector3.new(-0.05, 0.15, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(11.25))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset2, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset2, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.identity, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.identity, tweeninfo)

		AT:Wait(tweeninfo.Time)

		local animsineval = 0
		while true do
			AT:Wait()

			newrtjoffset = CFrame.new(0, msinrad(animsineval * 2) * 0.15 * CHARACTERSCALE, 0) * CFrame.Angles(-mrad(7), 0, 0)

			local armsine = math.max(0, animsineval - 27)
			local newrsoffset = CFrame.new(0, msinrad(armsine*2) * 0.035 * CHARACTERSCALE, -msinrad(armsine) * 0.25 * CHARACTERSCALE) * newrsoffset2 * CFrame.Angles(msinrad(armsine) * 0.3, 0, 0)
			local newlsoffset = CFrame.new(0, msinrad(armsine*2) * 0.035 * CHARACTERSCALE, msinrad(armsine) * 0.25 * CHARACTERSCALE) * newlsoffset2 * CFrame.Angles(-msinrad(armsine) * 0.3, 0, 0)
			AT:JointsOffsetChange("RootJoint", newrtjoffset)
			AT:JointsOffsetChange("Right Shoulder", newrsoffset)
			AT:JointsOffsetChange("Left Shoulder", newlsoffset)

			local dsine = math.max(0, animsineval - 90)
			AT:JointsOffsetChange("Right Hip", CFrame.new(Vector3.new(0, math.max(0, msinrad(dsine) * 0.3), tiltlegoffset + (msinrad(animsineval) * 0.4)) * CHARACTERSCALE) * CFrame.Angles((-msinrad(animsineval) * 0.3), 0, 0))
			AT:JointsOffsetChange("Left Hip", CFrame.new(Vector3.new(0, math.max(0, -msinrad(dsine) * 0.3), tiltlegoffset + (-msinrad(animsineval) * 0.4)) * CHARACTERSCALE) * CFrame.Angles((msinrad(animsineval) * 0.3), 0, 0))

			animsineval = animsineval + (12 * (SETTINGS.WalkSpeed/16))

		end

	end,
	["Running"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		-- Set to initial walking pose
		local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local tilt = 15
		local tiltlegoffset = -0.1
		local groundoffset = 0.2

		local newneckoffset = CFrame.Angles(mrad(tilt), 0, 0)
		local newrtjoffset = CFrame.Angles(-mrad(tilt), 0, 0)
		local newrsoffset2 = CFrame.new(Vector3.new(0.12, 0.25, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, mrad(35))
		local newlsoffset2 = CFrame.new(Vector3.new(-0.12, 0.25, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(35))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset2, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset2, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(0, groundoffset * CHARACTERSCALE, 0), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(0, groundoffset * CHARACTERSCALE, 0), tweeninfo)


		AT:Wait(tweeninfo.Time)

		local animsineval = 0
		while true do
			AT:Wait()

			local armsine = math.max(0, animsineval - 27)
			local osine = math.max(0, armsine - 45)
			newrtjoffset = CFrame.new(0, msinrad(animsineval * 2) * 0.35 * CHARACTERSCALE, 0) * CFrame.Angles(-mrad(17), msinrad(armsine) * 0.1, 0)
			local newrsoffset = CFrame.new(0, msinrad(osine*2) * 0.15 * CHARACTERSCALE, -msinrad(armsine) * 0.9 * CHARACTERSCALE) * newrsoffset2 * CFrame.Angles(msinrad(armsine) * 1.2, 0, 0)
			local newlsoffset = CFrame.new(0, msinrad(osine*2) * 0.15 * CHARACTERSCALE, msinrad(armsine) * 0.9 * CHARACTERSCALE) * newlsoffset2 * CFrame.Angles(-msinrad(armsine) * 1.2, 0, 0)
			AT:JointsOffsetChange("RootJoint", newrtjoffset)
			AT:JointsOffsetChange("Right Shoulder", newrsoffset)
			AT:JointsOffsetChange("Left Shoulder", newlsoffset)

			local dsine = math.max(0, animsineval - 90-22.5)
			AT:JointsOffsetChange("Right Hip", CFrame.new(Vector3.new(0, math.max(0, msinrad(dsine) * 0.4) + groundoffset, tiltlegoffset + (msinrad(animsineval) * 0.9)) * CHARACTERSCALE) * CFrame.Angles(mrad(tilt-(90*0.8/2)+15)+(-msinrad(animsineval) * 0.8), 0, 0))
			AT:JointsOffsetChange("Left Hip", CFrame.new(Vector3.new(0, math.max(0, -msinrad(dsine) * 0.4) + groundoffset, tiltlegoffset + (-msinrad(animsineval) * 0.9)) * CHARACTERSCALE) * CFrame.Angles(mrad(tilt-(90*0.8/2)+15)+(msinrad(animsineval) * 0.8), 0, 0))

			animsineval = animsineval + (12 * (SETTINGS.RunSpeed/35))

		end

	end,
	["IdleFly"] = function(AT)
		BroomSwitch(true)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(0, mrad(33.75), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(90), 0)
		local newrsoffset = CFrame.Angles(-mrad(20), 0, mrad(15))
		local newlsoffset = CFrame.Angles(-mrad(20), 0, -mrad(15))
		local newrhoffset = CFrame.new(Vector3.new(0.18, 0.3, -0.35) * CHARACTERSCALE) * CFrame.Angles(0, 0, mrad(11.25)) * CFrame.Angles(0, mrad(11.25), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.18, 0.3, -0.35) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(11.25)) * CFrame.Angles(0, -mrad(11.25), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		local newbroomoffset = JCFrtj.CharacterOffset * CFrame.new(Vector3.new(0 - 0.35, -1.25, 0) * CHARACTERSCALE) * CFrame.Angles(0, mrad(180), 0)
		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, JCFrtj.CharacterOffset * CFrame.new(Vector3.new(0 - 0.35, -1.25, 0) * CHARACTERSCALE) * CFrame.Angles(0, mrad(180), 0), tweeninfo)

		-- leg swing starts before everything else
		AT:Delay(0, function()
			local animsineval = 0
			while true do
				AT:Wait()
				AT:JointsOffsetChange("Right Hip", CFrame.new(Vector3.new(0, -msinrad(animsineval) * 0.065, msinrad(animsineval * 2) * 0.1) * CHARACTERSCALE) * newrhoffset * CFrame.Angles(-msinrad(animsineval * 2) * 17/90, 0, 0))
				AT:JointsOffsetChange("Left Hip", CFrame.new(Vector3.new(0, -msinrad(animsineval) * 0.065, -msinrad(animsineval * 2) * 0.1) * CHARACTERSCALE) * newlhoffset * CFrame.Angles(msinrad(animsineval * 2) * 17/90, 0, 0))

				animsineval = animsineval + 1.5
			end
		end)

		AT:Wait(tweeninfo.Time + 0.25)
		local animsineval = 0
		while true do
			AT:Wait()

			AT:JointsOffsetChange("RootJoint", CFrame.new(Vector3.new(0, msinrad(animsineval) * 0.075 + (msinrad(animsineval * 0.35) * 0.65), 0) * CHARACTERSCALE) * newrtjoffset)
			AT:JointsOffsetChange("Right Shoulder", newrsoffset * CFrame.new(0, -msinrad(animsineval) * 0.065 * CHARACTERSCALE, 0))
			AT:JointsOffsetChange("Left Shoulder", newlsoffset * CFrame.new(0, -msinrad(animsineval) * 0.065 * CHARACTERSCALE, 0))

			AT:ObjectsOffsetChange("Broom", newbroomoffset * CFrame.new(0, (msinrad(animsineval * 0.35) * 0.65) * CHARACTERSCALE, 0))




			-- Delayed sine
			local dsine = math.max(0, animsineval - 33.75)
			AT:JointsOffsetChange("Neck", newneckoffset * CFrame.Angles(msinrad(dsine) * 0.075, 0, 0))

			animsineval = animsineval + 1
		end

	end,
	["Flying"] = function(AT)
		BroomSwitch(true)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(0, mrad(33.75), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(90), 0)
		local newrsoffset = CFrame.Angles(-mrad(20), 0, mrad(15))
		local newlsoffset = CFrame.Angles(-mrad(20), 0, -mrad(15))
		local newrhoffset = CFrame.new(Vector3.new(0.18, 0.3, -0.35) * CHARACTERSCALE) * CFrame.Angles(0, 0, mrad(11.25)) * CFrame.Angles(0, mrad(11.25), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.18, 0.3, -0.35) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(11.25)) * CFrame.Angles(0, -mrad(11.25), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		local newbroomoffset = JCFrtj.CharacterOffset * CFrame.new(Vector3.new(0 - 0.35, -1.25, 0) * CHARACTERSCALE) * CFrame.Angles(0, mrad(180), 0)
		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, newbroomoffset, tweeninfo)

		AT:Wait(tweeninfo.Time)

		local animsineval = 0
		while true do
			AT:Wait()
			local ysine = (msinrad((animsineval * 2)-90) + 1) * 0.65
			local anglesine = math.abs(msinrad(animsineval) * 0.14)

			AT:JointsOffsetChange("RootJoint", newrtjoffset * CFrame.new(Vector3.new(0, ysine, -msinrad(animsineval) * 3.5) * CHARACTERSCALE) * CFrame.Angles(msinrad(animsineval) * 0.25, 0, anglesine), tweeninfo)
			AT:JointsOffsetChange("Right Hip", CFrame.new(Vector3.new(0, -msinrad(animsineval) * 0.065, msinrad(animsineval * 2.25) * 0.1) * CHARACTERSCALE) * newrhoffset * CFrame.Angles(-msinrad(animsineval * 2.25) * 17/90, 0, 0))
			AT:JointsOffsetChange("Left Hip", CFrame.new(Vector3.new(0, -msinrad(animsineval) * 0.065, -msinrad(animsineval * 2.25) * 0.1) * CHARACTERSCALE) * newlhoffset * CFrame.Angles(msinrad(animsineval * 2.25) * 17/90, 0, 0))

			AT:ObjectsOffsetChange("Broom", newbroomoffset * CFrame.new(Vector3.new(-msinrad(animsineval) * 3.5, ysine, 0) * CHARACTERSCALE) * CFrame.Angles(anglesine, 0, 0), tweeninfo)
			animsineval = animsineval + 0.7
		end

	end,
	["FlyToGround"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(-mrad(33.75), 0, 0)
		local newrtjoffset = CFrame.new(Vector3.new(0, 5, 0) * CHARACTERSCALE) * CFrame.Angles(mrad(13), 0, 0)
		local newrsoffset = CFrame.Angles(-mrad(35), 0, mrad(15))
		local newlsoffset = CFrame.Angles(-mrad(35), 0, -mrad(15))
		local newrhoffset = CFrame.new(Vector3.new(0.125, 0.45, -0.35) * CHARACTERSCALE) * CFrame.Angles(-mrad(25), 0, mrad(7))
		local newlhoffset = CFrame.new(Vector3.new(-0.125, 0.45, -0.1) * CHARACTERSCALE) * CFrame.Angles(-mrad(55), 0, -mrad(7))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, JCFrtj.CharacterOffset * CFrame.new(Vector3.new(-4, -1.25 + 8 - 0.75, 0) * CHARACTERSCALE) * CFrame.Angles(0, mrad(180), 0), tweeninfo)
	end,
	["GroundToFly"] = function(AT)
		BroomSwitch(true)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, CFrame.new(Vector3.new(-0.3, 1.35, -0.25) * CHARACTERSCALE) * CFrame.Angles(mrad(155), 0, -mrad(17)), tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, CFrame.new(Vector3.new(0.3, 1.3, -0.2) * CHARACTERSCALE) * CFrame.Angles(mrad(140), 0, mrad(17)), tweeninfo)

		tweeninfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, CFrame.Angles(-mrad(28), 0, 0), tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, CFrame.new(Vector3.new(0, 4, 0) * CHARACTERSCALE) * CFrame.Angles(0, -mrad(60), 0) * CFrame.Angles(-mrad(28), 0, 0), tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(Vector3.new(0, 0.65, -0.3) * CHARACTERSCALE) * CFrame.Angles(-mrad(33.75), 0, 0) * CFrame.new(0, 0.15, 0), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(Vector3.new(0, 0.5, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(22.5), 0, 0), tweeninfo)

		local broomtweeninfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		AT:ObjectsOffsetChange("Broom", JCFrtj.CharacterOffset * CFrame.new(Vector3.new(-1, 10, 0) * CHARACTERSCALE) * CFrame.Angles(0, mrad(180), 0))
		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, JCFrtj.CharacterOffset * CFrame.new(Vector3.new(-1, -1.25, 0) * CHARACTERSCALE) * CFrame.Angles(0, mrad(180), 0), broomtweeninfo)

		AT:Wait(tweeninfo.Time*2/3)

		tweeninfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, CFrame.Angles(0, -mrad(90), 0) * CFrame.new(Vector3.new(0, 0, 1) * CHARACTERSCALE), tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(Vector3.new(0, 0.65, -0.3) * CHARACTERSCALE) * CFrame.Angles(-mrad(7), 0, 0) * CFrame.new(Vector3.new(0, 0.15, 0) * CHARACTERSCALE), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(Vector3.new(0, 0.5, -0.7) * CHARACTERSCALE) * CFrame.Angles(0, 0, 0), tweeninfo)

		-- Broom Impact
		AT:Wait(tweeninfo.Time)
		tweeninfo = TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, CFrame.Angles(0, mrad(33.75), 0), tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, CFrame.new(Vector3.new(0, 0, -0.15) * CHARACTERSCALE) * CFrame.Angles(mrad(35), 0, mrad(10)), tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, CFrame.new(Vector3.new(0, 0, -0.15) * CHARACTERSCALE) * CFrame.Angles(mrad(35), 0, -mrad(10)), tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(Vector3.new(0.15, 0.5, -0.5) * CHARACTERSCALE) * CFrame.Angles(mrad(30), 0, mrad(5)), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(Vector3.new(-0.15, 0.3, -0.35) * CHARACTERSCALE) * CFrame.Angles(mrad(40), 0, -mrad(5)), tweeninfo)

		-- Transition to IdleFly
		AT:Delay(tweeninfo.Time, function()
			local newrsoffset = CFrame.Angles(-mrad(20), 0, mrad(15))
			local newlsoffset = CFrame.Angles(-mrad(20), 0, -mrad(15))
			tweeninfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
			AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		end)
		AT:Delay(tweeninfo.Time, function()
			local newrhoffset = CFrame.new(Vector3.new(0.18, 0.3, -0.35) * CHARACTERSCALE) * CFrame.Angles(0, 0, mrad(11.25)) * CFrame.Angles(0, mrad(11.25), 0)
			local newlhoffset = CFrame.new(Vector3.new(-0.18, 0.3, -0.35) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(11.25)) * CFrame.Angles(0, -mrad(11.25), 0)
			tweeninfo = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
			AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)
		end)

		tweeninfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, CFrame.Angles(0, -mrad(90), 0) * CFrame.new(Vector3.new(-0.5, -1.5, -0.25) * CHARACTERSCALE) * CFrame.Angles(-mrad(20), 0, 0), tweeninfo)
		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, JCFrtj.CharacterOffset * CFrame.new(Vector3.new(0.25 - 0.5, -2.75, -0.5) * CHARACTERSCALE) * CFrame.Angles(0, mrad(180), 0), tweeninfo)



	end,
	["Jumping"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		-- Reset to idle
		local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, CFrame.Angles(-mrad(7), 0, 0), tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, CFrame.new(Vector3.new(0, 0.25, 0) * CHARACTERSCALE) * CFrame.Angles(mrad(7), 0, 0), tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, CFrame.new(Vector3.new(0.15, 0.05, 0.22) * CHARACTERSCALE) * CFrame.Angles(-mrad(45), 0, mrad(11.25)), tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, CFrame.new(Vector3.new(-0.15, 0.05, -0.15) * CHARACTERSCALE) * CFrame.Angles(mrad(17), 0, -mrad(11.25)), tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(Vector3.new(0, 0.15, 0.2) * CHARACTERSCALE) * CFrame.Angles(-mrad(11.25), 0, 0), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(Vector3.new(0, 0.2, 0.15) * CHARACTERSCALE) * CFrame.Angles(-mrad(18), 0, 0), tweeninfo)

		local broomtweeninfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local newbroomoffset = CFrame.new(Vector3.new(0, 0, 2.5) * CHARACTERSCALE) * CFrame.Angles(-math.rad(90), 0, 0)
		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, newbroomoffset, broomtweeninfo)

		AT:Wait(tweeninfo.Time)

		tweeninfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, CFrame.Angles(-mrad(15), 0, 0), tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, CFrame.new(Vector3.new(0, 0.6, 0) * CHARACTERSCALE), tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, CFrame.new(Vector3.new(0.22, 0.1, -0.25) * CHARACTERSCALE) * CFrame.Angles(mrad(64), 0, mrad(17)), tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, CFrame.new(Vector3.new(-0.22, 0.1, -0.2) * CHARACTERSCALE) * CFrame.Angles(mrad(55), 0, -mrad(17)), tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(Vector3.new(0, 0.5, -0.05) * CHARACTERSCALE) * CFrame.Angles(-mrad(47), 0, 0), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(Vector3.new(0, 0.35, -0.07) * CHARACTERSCALE) * CFrame.Angles(-mrad(26), 0, 0), tweeninfo)







	end,
	["Falling"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, CFrame.Angles(-mrad(20), 0, 0), tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, CFrame.new(Vector3.new(0, 0.15, 0) * CHARACTERSCALE), tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, CFrame.new(Vector3.new(0.05, 0.8, -0.25) * CHARACTERSCALE) * CFrame.Angles(mrad(100), 0, mrad(4)), tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, CFrame.new(Vector3.new(-0.05, 0.7, -0.2) * CHARACTERSCALE) * CFrame.Angles(mrad(85), 0, -mrad(4)), tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(Vector3.new(0, 0.7, -0.07) * CHARACTERSCALE) * CFrame.Angles(-mrad(60), 0, 0), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(Vector3.new(0, 0.45, -0.1) * CHARACTERSCALE) * CFrame.Angles(-mrad(35), 0, 0), tweeninfo)

		local broomtweeninfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local newbroomoffset = CFrame.new(Vector3.new(0, 0, 2.5) * CHARACTERSCALE) * CFrame.Angles(-math.rad(90), 0, 0)
		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, newbroomoffset, broomtweeninfo)

		AT:Wait(tweeninfo.Time * 2/3)

		tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, CFrame.Angles(-mrad(28), 0, 0), tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, CFrame.Angles(-mrad(7), 0, 0), tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, CFrame.new(Vector3.new(-0.3, 1.35, -0.25) * CHARACTERSCALE) * CFrame.Angles(mrad(155), 0, -mrad(17)), tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, CFrame.new(Vector3.new(0.3, 1.3, -0.2) * CHARACTERSCALE) * CFrame.Angles(mrad(140), 0, mrad(17)), tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(Vector3.new(0.17, 0.1, 0) * CHARACTERSCALE) * CFrame.Angles(-mrad(25), 0, mrad(11.25)), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(Vector3.new(-0.17, 0.45, 0.15) * CHARACTERSCALE) * CFrame.Angles(-mrad(40), 0, -mrad(11.25)), tweeninfo)
	end,
	["FallImpact"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, CFrame.Angles(mrad(13), 0, 0), tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, CFrame.new(Vector3.new(0, -1.2, -0.25) * CHARACTERSCALE) * CFrame.Angles(-mrad(17), 0, 0), tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, CFrame.new(Vector3.new(0.2, 0.7, -0.05) * CHARACTERSCALE) * CFrame.Angles(-mrad(47), 0, mrad(17)), tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, CFrame.new(Vector3.new(-0.2, 0.7, -0.05) * CHARACTERSCALE) * CFrame.Angles(-mrad(47), 0, -mrad(17)), tweeninfo)

		local tweeninfo2 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, CFrame.new(Vector3.new(-0.125, 0.05, -0.18) * CHARACTERSCALE) * CFrame.Angles(mrad(30), 0, mrad(11.25)), tweeninfo2)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, CFrame.new(Vector3.new(-0.125, 0.05, -0.18) * CHARACTERSCALE) * CFrame.Angles(mrad(30), 0, -mrad(11.25)), tweeninfo2)

		AT:Wait(tweeninfo2.Time*2/3)

		local tweeninfo3 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, CFrame.new(Vector3.new(-0.125, 0.05, 0.18) * CHARACTERSCALE) * CFrame.Angles(-mrad(30), 0, mrad(11.25)), tweeninfo3)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, CFrame.new(Vector3.new(-0.125, 0.05, 0.18) * CHARACTERSCALE) * CFrame.Angles(-mrad(30), 0, -mrad(11.25)), tweeninfo3)	
	end,






	------------------------------------------------------------------------------------------------------------------------------------------
	["DashGround"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(-mrad(36), 0, 0)
		local newrtjoffset = CFrame.new(Vector3.new(0, 0.17 - 2.3, 0) * CHARACTERSCALE) * CFrame.Angles(mrad(36), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(0.2, 0.2, 0.23) * CHARACTERSCALE) * CFrame.Angles(-mrad(36 + 27), 0, mrad(33))
		local newlsoffset = CFrame.new(Vector3.new(0.1, 1.12, -0.27) * CHARACTERSCALE) * CFrame.Angles(mrad(172 - 36), 0, mrad(30)) * CFrame.new(0, -0.27, 0)
		local newrhoffset = CFrame.new(Vector3.new(0, -0.17, 0) * CHARACTERSCALE) * CFrame.new(Vector3.new(0, 0.5, -1) * CHARACTERSCALE) * CFrame.Angles(mrad(82 - 36), 0, 0)
		local newlhoffset = CFrame.new(Vector3.new(0, -0.17, 0) * CHARACTERSCALE) * CFrame.new(Vector3.new(0, 0.9, -0.36) * CHARACTERSCALE) * CFrame.Angles(-mrad(28), 0, 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

	end,
	["DashAir"] = function(AT)
		BroomSwitch(true)
		AT:Delay(0.75, function()
			BroomSwitch(false)
		end)
		HakeroSwitch(false)

		local broomoffset = CFrame.identity
		-- Broom follow right arm
		AT:Delay(0, function()
			while true do
				local defaultoffset = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)
				AT:ObjectsOffsetChange("Broom", defaultoffset * broomoffset)
				AT:Wait()
			end
		end)



		local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(mrad(26), 0, 0)
		local newrtjoffset = CFrame.Angles(-mrad(36), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(0.12, 0, 0.42) * CHARACTERSCALE) * CFrame.Angles(-mrad(52), 0, mrad(56))
		local newlsoffset = CFrame.new(Vector3.new(-0.3, 0, -0.075) * CHARACTERSCALE) * CFrame.Angles(-mrad(35), 0, -mrad(35))
		local newrhoffset = CFrame.new(Vector3.new(0, 0.4, 0.25) * CHARACTERSCALE) * CFrame.Angles(-mrad(48), 0, 0)
		local newlhoffset = CFrame.new(Vector3.new(0, 0.4, 0.25) * CHARACTERSCALE) * CFrame.Angles(-mrad(70), 0, 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		local newbroomoffset = CFrame.Angles(mrad(110), mrad(37), 0) * CFrame.new(Vector3.new(-0.5, 0, -2.65) * CHARACTERSCALE)
		CSE:TweenCustom(broomoffset, newbroomoffset, tweeninfo, function(val)
			broomoffset = val
		end)

		AT:Wait(tweeninfo.Time * 2/3)







		tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(mrad(40), 0, 0)
		local newrtjoffset = CFrame.Angles(-mrad(48), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.45, 0.57, -0.72) * CHARACTERSCALE) * CFrame.Angles(mrad(102), 0, -mrad(37))
		local newlsoffset = CFrame.new(Vector3.new(0.45, 0.57, -0.72) * CHARACTERSCALE) * CFrame.Angles(mrad(102), 0, mrad(37))
		local newrhoffset = CFrame.new(Vector3.new(0, 0.5, 0.4) * CHARACTERSCALE) * CFrame.Angles(-mrad(57), 0, 0)
		local newlhoffset = CFrame.new(Vector3.new(0, 0.5, 0.4) * CHARACTERSCALE) * CFrame.Angles(-mrad(95), 0, 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)


		local tweeninfo2 = TweenInfo.new(0.075, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local newbroomoffset = CFrame.Angles(-mrad(56), mrad(215), 0)
		local tween = CSE:TweenCustom(broomoffset, newbroomoffset, tweeninfo2, function(val)
			broomoffset = val
		end)

		AT:Delay(tweeninfo.Time * 2/3, function()
			tween:Pause()
			local tweeninfo = TweenInfo.new(tweeninfo2.Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
			local newbroomoffset = CFrame.new(Vector3.new(-0.5, 0, 0) * CHARACTERSCALE) * CFrame.Angles(0, mrad(180), 0)
			CSE:TweenCustom(broomoffset, newbroomoffset, tweeninfo, function(val)
				broomoffset = val
			end).Completed:Connect(function()
				local r = 7
				local tweeninfo = TweenInfo.new(1/r, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
				for i = 1, r do
					local tween = CSE:TweenCustom(broomoffset, broomoffset * CFrame.Angles(0, -mrad(179), 0), tweeninfo, function(val)
						broomoffset = val
					end)
					tween.Completed:Wait()
				end
			end)
		end)

		AT:Wait(tweeninfo.Time * 2/3)






		tweeninfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(mrad(56), 0, 0)
		local newrtjoffset = CFrame.Angles(-mrad(82), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.35, 1.87, -0.32) * CHARACTERSCALE) * CFrame.Angles(mrad(165), 0, -mrad(25))
		local newlsoffset = CFrame.new(Vector3.new(0.35, 1.87, -0.32) * CHARACTERSCALE) * CFrame.Angles(mrad(165), 0, mrad(25))
		local newrhoffset = CFrame.new(Vector3.new(0.2, 0.1, 0.15) * CHARACTERSCALE) * CFrame.Angles(-mrad(17), 0, mrad(11))
		local newlhoffset = CFrame.new(Vector3.new(-0.2, 0.1, 0.15) * CHARACTERSCALE) * CFrame.Angles(-mrad(17), 0, -mrad(11))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

	end,
	["N1Ground"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		local newneckoffset = CFrame.new(Vector3.new(0, 0.03, -0.12) * CHARACTERSCALE) * CFrame.Angles(-mrad(23), mrad(28), 0)
		local newrtjoffset = CFrame.Angles(mrad(40),  -mrad(38), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.22, 0.4, -0.4) * CHARACTERSCALE) * CFrame.Angles(mrad(54), 0, mrad(13))
		local newlsoffset = CFrame.new(Vector3.new(-0.6, 0.6, -0.3) * CHARACTERSCALE) * CFrame.Angles(mrad(78), 0, -mrad(82))
		local newrhoffset = CFrame.new(Vector3.new(0.27, 0.15, 0.3) * CHARACTERSCALE) * CFrame.Angles(-mrad(49), 0, mrad(7)) * CFrame.Angles(0, -mrad(25), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.6, 0.4, -0.9) * CHARACTERSCALE) * CFrame.Angles(mrad(45), 0, -mrad(32)) * CFrame.Angles(0, mrad(15), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

	end,
	["N1Air"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		local newneckoffset = CFrame.new(Vector3.new(0, 0.05, -0.7) * CHARACTERSCALE) * CFrame.Angles(-mrad(23), -mrad(15), 0)
		local newrtjoffset = CFrame.new(Vector3.new(0, -0.8, 0) * CHARACTERSCALE) * CFrame.Angles(mrad(50),  mrad(55), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.2, 0.6, -0.6) * CHARACTERSCALE) * CFrame.Angles(mrad(67), 0, mrad(56))
		local newlsoffset = CFrame.new(Vector3.new(-0.27, 0.8, -0.4) * CHARACTERSCALE) * CFrame.Angles(mrad(66), 0, -mrad(12))
		local newrhoffset = CFrame.new(Vector3.new(0.5, 0.3, -0.4) * CHARACTERSCALE) * CFrame.Angles(mrad(28), 0, mrad(13)) * CFrame.Angles(0, mrad(13), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.2, 0.7, -0.5) * CHARACTERSCALE) * CFrame.Angles(-mrad(34), 0, -mrad(27))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

	end,
	["N2Ground"] = function(AT)
		BroomSwitch(true)
		AT:Delay(0.25, function()
			BroomSwitch(false)
		end)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		local newneckoffset = CFrame.Angles(0, mrad(60), 0)
		local newrtjoffset = CFrame.Angles(0,  -mrad(60), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.5, 0.4, -0.6) * CHARACTERSCALE) * CFrame.Angles(mrad(60), 0, mrad(53))
		local newlsoffset = CFrame.new(Vector3.new(-0.63, 0.6, -0.56) * CHARACTERSCALE) * CFrame.Angles(mrad(90), 0, -mrad(57))
		local newrhoffset = CFrame.new(Vector3.new(0.4, 0, 0) * CHARACTERSCALE) * CFrame.Angles(-mrad(7), 0, mrad(15)) * CFrame.Angles(0, mrad(10), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.4, 0, 0) * CHARACTERSCALE) * CFrame.Angles(-mrad(7), 0, -mrad(15)) * CFrame.Angles(0, -mrad(10), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		-- Broom follow left arm
		local defaultoffset = JCFrtj.CurrentOffset * JCFls.CharacterOffset * JCFls.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)
		AT:ObjectsOffsetChange("Broom", defaultoffset)
		AT:Delay(0, function()
			while true do
				local defaultoffset = JCFrtj.CurrentOffset * JCFls.CharacterOffset * JCFls.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)
				AT:ObjectsOffsetChange("Broom", defaultoffset * CFrame.Angles(-mrad(69), mrad(165), 0))
				AT:Wait()
			end
		end)

	end,
	["N2Air"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		-- Pull
		local tweeninfo = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.new(Vector3.new(0, 0.02, -0.1) * CHARACTERSCALE) * CFrame.Angles(-mrad(7), 0, mrad(13)) * CFrame.Angles(0, mrad(46), 0)
		local newrtjoffset = CFrame.Angles(0,  -mrad(102) * CHARACTERSCALE, 0)
		local newrsoffset = CFrame.new(Vector3.new(0.5, 0.8, -0.37) * CHARACTERSCALE) * CFrame.Angles(mrad(97), 0, mrad(36))
		local newlsoffset = CFrame.new(Vector3.new(0.2, 0.6, -0.8) * CHARACTERSCALE) * CFrame.Angles(mrad(76), 0, mrad(10))
		local newrhoffset = CFrame.new(Vector3.new(0.1, 0.2, 0) * CHARACTERSCALE) * CFrame.Angles(-mrad(27), mrad(20), 0)
		local newlhoffset = CFrame.new(Vector3.new(0, 0.6, 0.3) * CHARACTERSCALE) * CFrame.Angles(-mrad(78), mrad(20), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)


		AT:Wait(tweeninfo.Time * 2/3)
		-- Punch
		tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		local newneckoffset = CFrame.Angles(-mrad(13), 0, 0)
		local newrtjoffset = CFrame.Angles(-mrad(106), mrad(40), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.2, 0.5, -0.6) * CHARACTERSCALE) * CFrame.Angles(mrad(120), 0, mrad(38))
		local newlsoffset = CFrame.new(Vector3.new(-0.4, 0.3, -0.27) * CHARACTERSCALE) * CFrame.Angles(mrad(70),0, -mrad(40))
		local newrhoffset = CFrame.new(Vector3.new(0, 0.6, -1.1) * CHARACTERSCALE) * CFrame.Angles(mrad(36), -mrad(10), 0)
		local newlhoffset = CFrame.new(Vector3.new(0, 0.8, -0.75) * CHARACTERSCALE) * CFrame.Angles(mrad(7), -mrad(10), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)


	end,
	["N3"] = function(AT)
		BroomSwitch(true)
		AT:Delay(0.25, function()
			BroomSwitch(false)
		end)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(mrad(7), 0, 0)
		local newrtjoffset = CFrame.new(Vector3.new(0, -0.4, 0) * CHARACTERSCALE) * CFrame.Angles(-mrad(7), mrad(147), 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.7, 0.4, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(69), 0, -mrad(36))
		local newlsoffset = CFrame.new(Vector3.new(0.7, 0.4, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(69), 0, mrad(36))
		local newrhoffset = CFrame.new(Vector3.new(0.35, 0.12, -0.8) * CHARACTERSCALE) * CFrame.Angles(mrad(28), 0, mrad(20)) * CFrame.Angles(0, mrad(37), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.35, 0.3, -0.2) * CHARACTERSCALE) * CFrame.Angles(-mrad(35), 0, -mrad(20)) * CFrame.Angles(0, mrad(25), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		-- Broom follow arms
		local defaultrsoffset = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(0, -1, 0)
		local defaultlsoffset = JCFrtj.CurrentOffset * JCFls.CharacterOffset * JCFls.CurrentOffset * CFrame.new(0, -1, 0)
		local broomoffset = CFrame.Angles(-mrad(15), 0, 0)
		AT:ObjectsOffsetChange("Broom", defaultrsoffset:Lerp(defaultlsoffset, 0.5) * broomoffset)
		AT:Delay(0, function()
			while true do
				local defaultrsoffset = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(0, -1, 0)
				local defaultlsoffset = JCFrtj.CurrentOffset * JCFls.CharacterOffset * JCFls.CurrentOffset * CFrame.new(0, -1, 0)
				AT:ObjectsOffsetChange("Broom", defaultrsoffset:Lerp(defaultlsoffset, 0.5) * broomoffset)
				AT:Wait()
			end
		end)

		AT:Wait(tweeninfo.Time * 2/3)
		tweeninfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(mrad(20), 0, 0)
		local newrtjoffset = CFrame.Angles(-mrad(13), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.6, 1.6, -0.6) * CHARACTERSCALE) * CFrame.Angles(mrad(154), 0, -mrad(40))
		local newlsoffset = CFrame.new(Vector3.new(0.6, 1.6, -0.6) * CHARACTERSCALE) * CFrame.Angles(mrad(154), 0, mrad(40))
		local newrhoffset = CFrame.new(Vector3.new(0.5, 0.23, 0.2) * CHARACTERSCALE) * CFrame.Angles(-mrad(34), 0, mrad(24)) * CFrame.Angles(0, mrad(50), 0)
		local newlhoffset = CFrame.new(Vector3.new(0, 0.5, -0.6) * CHARACTERSCALE) * CFrame.Angles(-mrad(30), 0, 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		CSE:TweenCustom(broomoffset, CFrame.Angles(-mrad(35), 0, 0) * CFrame.new(0, 0, -0.5 * CHARACTERSCALE), tweeninfo, function(val)
			broomoffset = val
		end)

		AT:Wait(tweeninfo.Time * 2/3)
		tweeninfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		local newneckoffset = CFrame.Angles(-mrad(24), 0, 0)
		local newrtjoffset = CFrame.new(Vector3.new(0, 1.3, 0) * CHARACTERSCALE) * CFrame.Angles(-mrad(117), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.7, 0.9, -1.2) * CHARACTERSCALE) * CFrame.Angles(mrad(110), 0, -mrad(50))
		local newlsoffset = CFrame.new(Vector3.new(0.7, 0.9, -1.2) * CHARACTERSCALE) * CFrame.Angles(mrad(110), 0, mrad(50))
		local newrhoffset = CFrame.new(Vector3.new(0, 1.1, -1.1) * CHARACTERSCALE) * CFrame.Angles(mrad(63), 0, 0)
		local newlhoffset = CFrame.new(Vector3.new(0, 1.4, -1.4) * CHARACTERSCALE) * CFrame.Angles(mrad(100), 0, 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		tweeninfo = TweenInfo.new(tweeninfo.Time/2 * 1.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		CSE:TweenCustom(broomoffset, CFrame.Angles(mrad(15), 0, 0) * CFrame.new(0, 0, -2.5 * CHARACTERSCALE), tweeninfo, function(val)
			broomoffset = val
		end)
		AT:Wait(tweeninfo.Time)
		tweeninfo = TweenInfo.new(tweeninfo.Time/2 * 1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		CSE:TweenCustom(broomoffset, CFrame.Angles(-mrad(17), 0, 0) * CFrame.new(0, 0, -2.5 * CHARACTERSCALE), tweeninfo, function(val)
			broomoffset = val
		end)
	end,
	["N4"] = function(AT)
		BroomSwitch(true)
		AT:Delay(0.4, function()
			BroomSwitch(false)
		end)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(mrad(7), 0, 0)
		local newrtjoffset = CFrame.new(Vector3.new(0, -0.4, 0) * CHARACTERSCALE) * CFrame.Angles(-mrad(7), mrad(147), 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.7, 0.4, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(69), 0, -mrad(36))
		local newlsoffset = CFrame.new(Vector3.new(0.7, 0.4, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(69), 0, mrad(36))
		local newrhoffset = CFrame.new(Vector3.new(0.05, 0.12, -0.5) * CHARACTERSCALE) * CFrame.Angles(mrad(10), 0, mrad(7))
		local newlhoffset = CFrame.new(Vector3.new(-0.05, 0.4, -0.2) * CHARACTERSCALE) * CFrame.Angles(-mrad(35), 0, -mrad(7))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		-- Broom follow arms
		local defaultrsoffset = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)
		local defaultlsoffset = JCFrtj.CurrentOffset * JCFls.CharacterOffset * JCFls.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)
		local broomoffset = CFrame.Angles(-mrad(10), 0, 0)
		AT:ObjectsOffsetChange("Broom", defaultrsoffset:Lerp(defaultlsoffset, 0.5) * broomoffset)
		AT:Delay(0, function()
			while true do
				local defaultrsoffset = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)
				local defaultlsoffset = JCFrtj.CurrentOffset * JCFls.CharacterOffset * JCFls.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)
				AT:ObjectsOffsetChange("Broom", defaultrsoffset:Lerp(defaultlsoffset, 0.5) * broomoffset)
				AT:Wait()
			end
		end)	

		AT:Wait(tweeninfo.Time)
		tweeninfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		local newneckoffset = CFrame.Angles(mrad(7), 0, 0)
		local newrtjoffset = CFrame.Angles(mrad(7), mrad(84), -mrad(20))
		local newrsoffset = CFrame.new(Vector3.new(-1.1, 0.4, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(111), 0, -mrad(57))
		local newlsoffset = CFrame.new(Vector3.new(0.7, 0.4, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(80), 0, mrad(49))
		local newrhoffset = CFrame.new(Vector3.new(-0.15, 0.2, 0.15) * CHARACTERSCALE) * CFrame.Angles(-mrad(20), 0, -mrad(7)) * CFrame.Angles(0, mrad(15), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.45, 0.63, -0.15) * CHARACTERSCALE) * CFrame.Angles(-mrad(55), 0, -mrad(15)) * CFrame.Angles(0, mrad(31), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		CSE:TweenCustom(broomoffset, CFrame.new(0, -0.5 * CHARACTERSCALE, 0) * CFrame.Angles(-mrad(25), mrad(20), 0), tweeninfo, function(val)
			broomoffset = val
		end)




		AT:Wait(tweeninfo.Time * 2/3)
		tweeninfo = TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

		local newneckoffset = CFrame.Angles(0, 0, 0)
		local newrtjoffset = CFrame.Angles(mrad(7), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.6, 0.55, -1.2) * CHARACTERSCALE) * CFrame.Angles(mrad(110), 0, -mrad(45))
		local newlsoffset = CFrame.new(Vector3.new(0.6, 0.55, -1.2) * CHARACTERSCALE) * CFrame.Angles(mrad(110), 0, mrad(45))
		local newrhoffset = CFrame.new(Vector3.new(0, 0.2, 0.8) * CHARACTERSCALE) * CFrame.Angles(-mrad(56), 0, 0)
		local newlhoffset = CFrame.new(Vector3.new(0, 0.3, -0.9) * CHARACTERSCALE) * CFrame.Angles(mrad(23), 0, 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		CSE:TweenCustom(broomoffset, CFrame.Angles(-mrad(110), mrad(35), 0), tweeninfo, function(val)
			broomoffset = val
		end)

		AT:Wait(tweeninfo.Time * 2/3)
		tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(mrad(11), mrad(30), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(50), 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.25, 0.2, -0.25) * CHARACTERSCALE) * CFrame.Angles(mrad(52), 0, -mrad(20))
		local newlsoffset = CFrame.new(Vector3.new(0.8, 0.45, -0.8) * CHARACTERSCALE) * CFrame.Angles(mrad(52), 0, mrad(60))
		local newrhoffset = CFrame.new(Vector3.new(0.3, 0.2, -0.075) * CHARACTERSCALE) * CFrame.Angles(-mrad(35), 0, mrad(25)) * CFrame.Angles(0, -mrad(20), 0)
		local newlhoffset = CFrame.new(Vector3.new(-0.2, 0.1, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(12), 0, -mrad(10)) * CFrame.Angles(0, mrad(30), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		CSE:TweenCustom(broomoffset, CFrame.Angles(-mrad(80), -mrad(15), 0), tweeninfo, function(val)
			broomoffset = val
		end)
	end,

	------------------------------------------------------------------------------------------------------------------------------------------
	["LaserFire"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		-- Same as first part of Special
		local tweeninfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		local newneckoffset = CFrame.Angles(-mrad(13), mrad(25), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(78), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.07, 0.18, -0.1) * CHARACTERSCALE) * CFrame.Angles(mrad(10), 0, mrad(17))
		local newlsoffset = CFrame.new(Vector3.new(0.4, 1.13, -0.6) * CHARACTERSCALE) * CFrame.Angles(mrad(125), 0, mrad(27))
		local newrhoffset = CFrame.new(Vector3.new(0.3, 0.52, -0.17) * CHARACTERSCALE) * CFrame.Angles(-mrad(30), 0, mrad(23))
		local newlhoffset = CFrame.new(Vector3.new(-0.15, 0.14, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(13)) * CFrame.Angles(0, -mrad(22), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		AT:Wait(tweeninfo.Time)

		local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(0, mrad(50), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(50), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.15, 0.1, 0.2) * CHARACTERSCALE) * CFrame.Angles(-mrad(30), 0, mrad(20)) * CFrame.Angles(0, -mrad(20), 0)
		local newlsoffset = CFrame.new(Vector3.new(-0.25, 0.45, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(90), 0, -mrad(50))
		local newrhoffset = CFrame.new(Vector3.new(0.2, 0.2, 0.2) * CHARACTERSCALE) * CFrame.Angles(-mrad(40), 0, mrad(12))
		local newlhoffset = CFrame.new(Vector3.new(-0.2, 0.2, -0.7) * CHARACTERSCALE) * CFrame.Angles(mrad(17), 0, -mrad(12))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)
	end,
	["SpecialCharge"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(true)

		-- Hakero follow arms
		local defaultrsoffset = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(0, -1, 0)
		local defaultlsoffset = JCFrtj.CurrentOffset * JCFls.CharacterOffset * JCFls.CurrentOffset * CFrame.new(0, -1, 0)
		local hakerooffset = CFrame.new(0, -0.25 * CHARACTERSCALE, 0) * CFrame.Angles(mrad(90), 0, 0)
		AT:ObjectsOffsetChange("Hakero", defaultrsoffset:Lerp(defaultlsoffset, 0.5) * hakerooffset)
		AT:Delay(0, function()
			while true do
				local defaultrsoffset = JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(0, -1, 0)
				local defaultlsoffset = JCFrtj.CurrentOffset * JCFls.CharacterOffset * JCFls.CurrentOffset * CFrame.new(0, -1, 0)
				AT:ObjectsOffsetChange("Hakero", defaultrsoffset:Lerp(defaultlsoffset, 0.5) * hakerooffset)
				AT:Wait()
			end
		end)

		local tweeninfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.new(Vector3.new(0, 0, -0.1) * CHARACTERSCALE) * CFrame.Angles(-mrad(30), 0, 0)
		local newrtjoffset = CFrame.new(Vector3.new(0, 0.8, 0.5) * CHARACTERSCALE) * CFrame.Angles(mrad(30), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.7, 1.6, -0.8) * CHARACTERSCALE) * CFrame.Angles(mrad(130), 0, -mrad(30))
		local newlsoffset = CFrame.new(Vector3.new(0.7, 1.6, -0.8) * CHARACTERSCALE) * CFrame.Angles(mrad(130), 0, mrad(30))
		local newrhoffset = CFrame.new(Vector3.new(0.05, 0.4, 0.05) * CHARACTERSCALE) * CFrame.Angles(-mrad(50), 0, mrad(12))
		local newlhoffset = CFrame.new(Vector3.new(-0.05, 0.7, 0.1) * CHARACTERSCALE) * CFrame.Angles(-mrad(70), 0, -mrad(12))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)
	end,
	["Special"] = function(AT)
		BroomSwitch(false)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		local newneckoffset = CFrame.Angles(-mrad(13), mrad(25), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(78), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.07, 0.18, -0.1) * CHARACTERSCALE) * CFrame.Angles(mrad(10), 0, mrad(17))
		local newlsoffset = CFrame.new(Vector3.new(0.4, 1.13, -0.6) * CHARACTERSCALE) * CFrame.Angles(mrad(125), 0, mrad(27))
		local newrhoffset = CFrame.new(Vector3.new(0.3, 0.52, -0.17) * CHARACTERSCALE) * CFrame.Angles(-mrad(30), 0, mrad(23))
		local newlhoffset = CFrame.new(Vector3.new(-0.15, 0.14, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(13)) * CFrame.Angles(0, -mrad(22), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		AT:Wait(tweeninfo.Time)

		local tweeninfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local newneckoffset = CFrame.Angles(mrad(4), mrad(42), 0)
		local newrtjoffset = CFrame.Angles(0, -mrad(52), 0)
		local newrsoffset = CFrame.new(Vector3.new(0.17, 0.18, 0.17) * CHARACTERSCALE) * CFrame.Angles(-mrad(15), 0, mrad(23))
		local newlsoffset = CFrame.new(Vector3.new(-0.34, 1.04, -0.3) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(117)) * CFrame.Angles(mrad(20), mrad(90), 0)
		local newrhoffset = CFrame.new(Vector3.new(0.3, 0.17, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, mrad(22))
		local newlhoffset = CFrame.new(Vector3.new(-0.3, 0.17, 0) * CHARACTERSCALE) * CFrame.Angles(0, 0, -mrad(22))

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)
	end,







	------------------------------------------------------------------------------------------------------------------------------------------
	["Counter"] = function(AT)
		BroomSwitch(true)
		AT:Delay(0.6, function()
			BroomSwitch(false)
		end)
		HakeroSwitch(false)

		local tweeninfo = TweenInfo.new(0.3)

		local newneckoffset = CFrame.Angles(mrad(28), 0, 0)
		local newrtjoffset = CFrame.new(Vector3.new(0, -0.7, 0) * CHARACTERSCALE) * CFrame.Angles(-mrad(16), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(-0.1, 0.8, -0.3) * CHARACTERSCALE) * CFrame.Angles(mrad(122), 0, -mrad(25))
		local newlsoffset = CFrame.new(Vector3.new(0.1, 0.8, -0.3) * CHARACTERSCALE) * CFrame.Angles(mrad(122), 0, mrad(25))
		local newrhoffset = CFrame.Angles(-mrad(50), 0, 0) * CFrame.new(Vector3.new(0, 0.4, 0.45) * CHARACTERSCALE)
		local newlhoffset = CFrame.Angles(-mrad(14), 0, 0) * CFrame.new(Vector3.new(0, 0.65, -0.3) * CHARACTERSCALE)

		local newbroomoffset = CFrame.new((CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE) * CFrame.Angles(mrad(22), 0, 0) * CFrame.new(Vector3.new(0, 0, -1.75) * CHARACTERSCALE)).Position) * CFrame.Angles(0, mrad(90), 0) * CFrame.new(Vector3.new(0, 0.75, -0.5) * CHARACTERSCALE)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		-- Broom follow right arm
		local defaultoffset = CFrame.new((JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)).Position)
		local offset2 = defaultoffset * CFrame.Angles(0, mrad(90), 0)
		AT:ObjectsOffsetChange("Broom", defaultoffset * offset2)

		local follow = true
		AT:Delay(0, function()
			local moremagnitude = -0.2 -- shake
			while follow == true do
				local defaultoffset = CFrame.new((JCFrtj.CurrentOffset * JCFrs.CharacterOffset * JCFrs.CurrentOffset * CFrame.new(Vector3.new(0, -1, 0) * CHARACTERSCALE)).Position)
				local offset2 = CFrame.Angles(0, -mrad(90), 0) * CFrame.new(Vector3.new(-0.25, 0, 0.5) * CHARACTERSCALE)

				local magclamp = math.max(0, moremagnitude) -- the -0.15 initial value is to delay the shaking a bit
				local moreoffset = CFrame.new(Vector3.new(rnd:NextNumber(-1, 1) * magclamp, rnd:NextNumber(-1, 1) * magclamp, rnd:NextNumber(-1, 1) * magclamp) * CHARACTERSCALE)
				moremagnitude = moremagnitude + 0.015

				AT:ObjectsOffsetChange("Broom", defaultoffset * offset2 * moreoffset)
				AT:Wait()
			end
		end)


		AT:Wait(0.6)
		follow = false
		local tweeninfo = TweenInfo.new(0.35)

		local newneckoffset = CFrame.Angles(-mrad(13), 0, 0)
		local newrtjoffset = CFrame.Angles(mrad(20), 0, 0)
		local newrsoffset = CFrame.new(Vector3.new(0.4, 1, 0.3) * CHARACTERSCALE) * CFrame.Angles(mrad(120), 0, mrad(75))
		local newlsoffset = CFrame.new(Vector3.new(-0.15, 1.4, 0.3) * CHARACTERSCALE) * CFrame.Angles(mrad(167), 0, -mrad(55))
		local newrhoffset = CFrame.Angles(mrad(16), 0, mrad(13)) * CFrame.new(Vector3.new(0.25, 0.15, -0.7) * CHARACTERSCALE)
		local newlhoffset = CFrame.Angles(-mrad(11), 0, -mrad(13)) * CFrame.new(Vector3.new(-0.25, 0.27, -0.2) * CHARACTERSCALE)

		local newbroomoffset = CFrame.new(Vector3.new(3, 0, -5) * CHARACTERSCALE) * CFrame.Angles(mrad(37), mrad(37), 0)

		AT:JointsOffsetTween("Neck", JCFneck.CurrentOffset, newneckoffset, tweeninfo)
		AT:JointsOffsetTween("RootJoint", JCFrtj.CurrentOffset, newrtjoffset, tweeninfo)
		AT:JointsOffsetTween("Right Shoulder", JCFrs.CurrentOffset, newrsoffset, tweeninfo)
		AT:JointsOffsetTween("Left Shoulder", JCFls.CurrentOffset, newlsoffset, tweeninfo)
		AT:JointsOffsetTween("Right Hip", JCFrh.CurrentOffset, newrhoffset, tweeninfo)
		AT:JointsOffsetTween("Left Hip", JCFlh.CurrentOffset, newlhoffset, tweeninfo)

		AT:ObjectsOffsetTween("Broom", OCFbroom.CurrentOffset, newbroomoffset, tweeninfo)
	end,
}

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

------------------------------ ANIMATION SETUP -------------------------------
function AnimationTrackNew(animName)
	local animFunc = ANIMATIONS[animName]
	local animThread = coroutine.create(animFunc)

	local AT = {}
	AT.Name = animName
	AT.Function = animFunc
	AT.ForceStopped = false

	-- Current Playing TweenObjects
	local JointsOffsetTO = {}
	local ObjCFTO = {}
	local ObjOffsetTO = {}
	local TweenObjects = {
		["JointsOffset"] = JointsOffsetTO,
		["ObjectsOffset"] = ObjOffsetTO
	}
	AT.TweenObjects = TweenObjects

	-- Tween Functions
	---------------- JOINTS OFFSET ----------------
	function AT:JointsOffsetChange(joint, cf)
		local lasttween = JointsOffsetTO[joint]
		if lasttween then
			lasttween:Pause()
			JointsOffsetTO[joint] = nil
		end
		jointscframes[joint].CurrentOffset = cf
	end

	function AT:JointsOffsetTween(joint, start, fin, tweeninfo)
		local lasttween = JointsOffsetTO[joint]
		if lasttween then
			lasttween:Pause()
		end
		JointsOffsetTO[joint] = CSE:TweenCustom(start, fin, tweeninfo, function(val)
			jointscframes[joint].CurrentOffset = val
		end)
	end


	---------------- OBJECTS OFFSET ----------------
	function AT:ObjectsOffsetChange(object, cf)
		local lasttween = ObjOffsetTO[object]
		if lasttween then
			lasttween:Pause()
			ObjOffsetTO[object] = nil
		end
		objectscframes[object].CurrentOffset = cf
	end
	function AT:ObjectsOffsetTween(object, start, fin, tweeninfo)
		local lasttween = ObjOffsetTO[object]
		if lasttween then
			lasttween:Pause()
		end
		ObjOffsetTO[object] = CSE:TweenCustom(start, fin, tweeninfo, function(val)
			objectscframes[object].CurrentOffset = val
		end)
	end



	---------------- OTHERS ----------------
	function AT:Wait(del)
		task.wait(del)
		if AT.ForceStopped == true then
			coroutine.yield()
		end
	end
	function AT:Delay(del, delayfunc)
		coroutine.wrap(function()
			AT:Wait(del)
			delayfunc()
		end)()
	end

	function AT:ForceStop()
		AT.ForceStopped = true
		for type, tab in TweenObjects do
			for i, tweenobject in tab do
				tweenobject:Pause()
			end
		end
		pcall(function()
			coroutine.close(animThread)
		end)
	end


	coroutine.resume(animThread, AT)


	return AT
end


------------------------------------------------------------------------------------------------------------------------------------------
---------------- ANIMATION PLAYING FUNCTIONS ----------------
local CurrentAnimation -- Currently playing animation for character
function AnimationPlay(name)
	AnimationStop()

	local animtrack = AnimationTrackNew(name)
	CurrentAnimation = animtrack

end
function AnimationStop()
	if CurrentAnimation then
		CurrentAnimation:ForceStop()
	end
end

------------------------------------------------------------------------------------------------------------------------------------------
---------------- DEAFAULT CHARACTER ANIMATIONS ----------------

local DefaultAnimsEnabled = true
function SetDefaultAnim(laststate, currentstate)
	if DefaultAnimsEnabled == true then
		if currentstate ~= "Disabled" then

			-- FALL IMPACT
			if laststate == "Falling" and (currentstate == "IdleGround" or currentstate == "Walking" or currentstate == "Running") then
				AnimationPlay("FallImpact")
				task.delay(0.2, function()
					if CurrentAnimation.Name ~= CurrentCharacterState then
						SetDefaultAnim(CurrentCharacterState, CurrentCharacterState) -- Re-update attempt
					end
				end)

			elseif currentstate == "IdleGround" then
				AnimationPlay("IdleGround"..idlemode)

				-- Everything else
			else
				AnimationPlay(currentstate)
			end
		end
	end
end
local DefaultAnims = CharacterState.Event:Connect(SetDefaultAnim)

print("> [WLW] Animations loaded. \n] -")


------------------------------------------------------------------------------------------------------------------------------------------

--[[ ----------------------------------

	-- FINAL CHARACTER SETUP --

---------------------------------- ]]--

print("- [\n> [WLW] Setting up final character...")

CFRAMES.CHARACTER = {}
CFRAMES.OBJECTS = {}
local currentheadangle = CFrame.identity
function SETCHARCFRAMES()
	-- Character
	ADMchar:SetRecordedMCF(currentcf)

	-- Limbs
	local torsooffset = JCFrtj.CharacterOffset * JCFrtj.CurrentOffset
	local ct = currentcf * torsooffset

	local raoffset = JCFrs.CharacterOffset * JCFrs.CurrentOffset
	local laoffset = JCFls.CharacterOffset * JCFls.CurrentOffset
	local rloffset = JCFrh.CharacterOffset * JCFrh.CurrentOffset
	local lloffset = JCFlh.CharacterOffset * JCFlh.CurrentOffset

	-- Funny head follow camera
	local headoffset
	if CurrentCharacterState ~= "Disabled" then
		-- Overwrite the animations' head angles with wherever our head should look (still keeping them stored tho just in case)
		local initial = JCFneck.CharacterOffset * CFrame.new(JCFneck.CurrentOffset.Position)
		local cth = ct * initial
		if cth.Position ~= CFRAMES.CAMERA.CFrame.Position then
			local CLook = cth:ToObjectSpace(CFRAMES.CAMERA.CFrame).LookVector
			CLook = Vector3.new( math.clamp(CLook.X, -1, 1), math.clamp(CLook.Y, -1, 1), math.clamp(CLook.Z, -1, 1) )
			local CAngle = CFrame.Angles(0, -math.asin(CLook.X) * 0.825, 0) * CFrame.Angles(math.asin(CLook.Y) * 0.5, 0, 0)
			currentheadangle = currentheadangle:Lerp(CAngle, SETTINGS.LookSpeed)
		end
		headoffset = initial * currentheadangle
	else
		headoffset = JCFneck.CharacterOffset * JCFneck.CurrentOffset
	end


	ADMchar:SetRecordedProperty(orighead, "CFrameOffset", torsooffset * headoffset)
	ADMchar:SetRecordedProperty(origtorso, "CFrameOffset", torsooffset)
	ADMchar:SetRecordedProperty(origra, "CFrameOffset", torsooffset * raoffset)
	ADMchar:SetRecordedProperty(origla, "CFrameOffset", torsooffset * laoffset)
	ADMchar:SetRecordedProperty(origrl, "CFrameOffset", torsooffset * rloffset)
	ADMchar:SetRecordedProperty(origll, "CFrameOffset", torsooffset * lloffset)

	-- MParts
	ADMmhead:SetRecordedMCF(ct * headoffset * mheadcharoffset)
	ADMmbody:SetRecordedMCF(ct)
	ADMmbody:SetRecordedProperty(origmbody["MTorso"], "CFrameOffset", mtorsocharoffset)
	ADMmbody:SetRecordedProperty(origmbody["MRight Arm"], "CFrameOffset", raoffset * mracharoffset)
	ADMmbody:SetRecordedProperty(origmbody["MLeft Arm"], "CFrameOffset", laoffset * mlacharoffset)
	ADMmbody:SetRecordedProperty(origmbody["MRight Leg"], "CFrameOffset", rloffset * mrlcharoffset)
	ADMmbody:SetRecordedProperty(origmbody["MLeft Leg"], "CFrameOffset", lloffset * mllcharoffset)

	-- Broom
	OCFbroom.CurrentCFrame = currentcf
	local broomcf = OCFbroom.CurrentCFrame * OCFbroom.CurrentOffset
	ADMbroom:SetRecordedMCF(broomcf)

	-- Hakero
	OCFhakero.CurrentCFrame = currentcf
	local hakerocf = OCFhakero.CurrentCFrame * OCFhakero.CurrentOffset
	ADMhakero:SetRecordedMCF(hakerocf)


	-- UPDATE CFRAME VALUES
	local CFCHAR = CFRAMES.CHARACTER
	CFCHAR.Character = currentcf
	CFCHAR.Head = ct * headoffset
	CFCHAR.Torso = ct
	CFCHAR["Right Arm"] = ct * raoffset
	CFCHAR["Left Arm"] = ct * laoffset
	CFCHAR["Right Leg"] = ct * rloffset
	CFCHAR["Left Leg"] = ct * lloffset

	local CFOBJ = CFRAMES.OBJECTS
	CFOBJ.Broom = broomcf
	CFOBJ.Hakero = hakerocf
end
local SetCharCFramesLoop = heartbeat:Connect(SETCHARCFRAMES)

print("> [WLW] Character has been set up. \n] -")

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

print("- [\n> [WLW] Loading actions...")

--[[ ----------------------------------

		-- INITIAL FUNCTIONS --

---------------------------------- ]]--

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


local renderstepped = game:GetService("RunService").Heartbeat

-- Effects request sender
local EFFECTSCONTAINER = nil
local EFFECTS = {} -- [EffectName] = Function
function EFFECT(EffectName, ...)
	if(not EFFECTSCONTAINER or EFFECTSCONTAINER.Parent ~= workspace.Terrain)then
		EFFECTSCONTAINER = Instance.new("Folder", workspace.Terrain)
	end
	EFFECTS[EffectName](...)
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
		deb:AddItem(soundpart, math.max(10, sound.TimeLength))
	end)

	return soundpart, sound
end

local WrapFixer = "⠀" -- use this instead of space to scale text without wrapping it (wtf roblox)

function FixWrap(str)
	return str:gsub(" ", WrapFixer)
end

local EmittingParticles = {}
function EmitParticle(Particle, Duration)
	coroutine.wrap(function()

		--[[ annoying explosion lag when looking away and looking back
		local function IsOnScreen()
			local point = Particle.Parent.Position -- part pos
			local _, bool = workspace.CurrentCamera:WorldToViewportPoint(point)
			return bool	
		end]]

		-- I HATE THIS
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

			--if IsOnScreen() then
			Particle:Emit(FINAL)
			--end
			EWait()
		end
		EmittingParticles[Particle] = nil
		-- wow i actually did math
	end)()
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
	deb:AddItem(uipart, 1.5)
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
		deb:AddItem(hitpart, slash.Lifetime)
	end)
end

local BROOM_Sparkles
EFFECTS.BROOM_Sparkles = function(State, BroomSize)
	local Data = BROOM_Sparkles
	pcall(function()
		EmitParticleStop(Data.Particle)
		Data.Loop:Disconnect()
		deb:AddItem(Data.Part, Data.Particle.Lifetime.Max)
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
		deb:AddItem(exppart, particle.Lifetime.Max)
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
	deb:AddItem(uipart, 3)
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
	deb:AddItem(exppart, particle.Lifetime.Max)


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
	deb:AddItem(uipart, 3)
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
	deb:AddItem(exppart, particle.Lifetime.Max)


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
	deb:AddItem(uipart, 3)
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
	deb:AddItem(chargepart, chargeparticle.Lifetime.Max)
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
				deb:AddItem(trailpart, 1)
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
	deb:AddItem(chargepart, chargeparticle.Lifetime.Max)
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
		deb:AddItem(particle, 1 + particle.Lifetime.Max)
	end
	local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Upgrade", "WhiteBall")
	particle.Parent = ABSORBER_EffectPart
	particle:Emit(1)
	deb:AddItem(particle, particle.Lifetime.Max)
	local particle = CSE:CreateEffectInst("ABSORBER", "Particles", "Upgrade", "Ring")
	particle.Parent = ABSORBER_EffectPart
	coroutine.wrap(function()
		for i = 1, 3 do
			particle:Emit(rnd:NextInteger(1, 4))
			EWait(0.1)
		end
		deb:AddItem(particle, particle.Lifetime.Max)
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
		deb:AddItem(ringpart, particle.Lifetime.Max)
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
			deb:AddItem(trailpart, trail.Lifetime)
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
	deb:AddItem(labelpart, 1.5)

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
	deb:AddItem(ABSORBER_EffectPart, 5)
end


EFFECTS.LASER_Charge = function()
	local currentcf = CFRAMES.CHARACTER.Character

	local chargepart = CreateEmptyPart(Vector3.zero, currentcf)
	local chargeparticle = CSE:CreateEffectInst("SPECIAL", "Particles", "SpecialRing")
	chargeparticle.Parent = chargepart
	chargepart.Parent = EFFECTSCONTAINER
	chargeparticle:Emit(15)
	deb:AddItem(chargepart, chargeparticle.Lifetime.Max)

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
		deb:AddItem(laserpart, 3)
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
	deb:AddItem(chargepart, chargeparticle.Lifetime.Max)

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
		deb:AddItem(STASIS_Part, lifetime)
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
	deb:AddItem(particle, particle.Lifetime.Max + 0.2)

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
	deb:AddItem(STASIS_Part, particle.Lifetime.Max + 0.2)


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
	deb:AddItem(SRPart, Duration + SR.Lifetime.Max)



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
	deb:AddItem(Outward, Duration + SC1_1.Lifetime.Max)
	deb:AddItem(Inward, Duration + SC2_1.Lifetime.Max)

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
		deb:AddItem(labelpart, FrameDuration * 10)
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
	deb:AddItem(hitpart, hitparticle.Lifetime.Max)


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
	deb:AddItem(hitpart, hitparticle.Lifetime.Max + 0.15)

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
	deb:AddItem(exppart, particle.Lifetime.Max)

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
		deb:AddItem(exppart, 5)
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
	deb:AddItem(clone, duration)

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
	deb:AddItem(exppart, particle1.Lifetime.Max + particle2.Lifetime.Max)


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
		deb:AddItem(pathpart, particle1.Lifetime.Max)
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
		deb:AddItem(lockpart, spikeparticle.Lifetime.Max)
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
	deb:AddItem(ball, 1.5 + particle.Lifetime.Max)



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
					deb:AddItem(shatterpart, particle.Lifetime.Max)
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
		deb:AddItem(ball, 5)
	end)
	CreateSoundAtPos("40", GroundPos)

	EWait(BallDuration)



	---------------- EXPLOSION ----------------
	-- Widen the trail
	local exppart = CreateEmptyPart(Vector3.zero, GroundCFrame)
	exppart.Parent = EFFECTSCONTAINER
	deb:AddItem(exppart, ExplodeDuration + 4)

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
	deb:AddItem(exppart, ExplodeDuration + 4)

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
		deb:AddItem(exppart, ExpPhase2Frac + 4)

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
		deb:AddItem(endpart, 1.2 + particle.Lifetime.Max)


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
				deb:AddItem(trailpart, 1)
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
		deb:AddItem(Ball, 5)
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
	deb:AddItem(exppart2, 10)

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

	deb:AddItem(exppart, 10)
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
	deb:AddItem(Ball, 5)

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
		deb:AddItem(exppart, 0.5 + particle.Lifetime.Max)
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
		deb:AddItem(CROSS, 3)
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
	deb:AddItem(riftpart, 10)

	local debrispart = CreateEmptyPart(Vector3.new(50, 50, 50), CF)
	debrispart.Parent = EFFECTSCONTAINER
	local particle = CSE:CreateEffectInst("S4", "Particles", "Debris")
	particle.Parent = debrispart
	EmitParticle(particle, 3.35)
	deb:AddItem(debrispart, 10)



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
	deb:AddItem(staticpart, 5 + particle.Lifetime.Max)


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
			deb:AddItem(exppart, 5)	
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
			deb:AddItem(UI, 1.5)
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
	deb:AddItem(particle, particle.Lifetime.Max)

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
		deb:AddItem(yypart, particle.Lifetime.Max)
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
		deb:AddItem(vpart, 10 + particle.Lifetime.Max)

		-- Inward
		local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "VortexDebris")
		particle.Parent = starpart
		EmitParticle(particle, 0.5)
		local particle = CSE:CreateEffectInst("S5", "Particles", "ChargeUp", "VortexStar2")
		particle.Parent = starpart
		EmitParticle(particle, 0.5)
		deb:AddItem(starpart, 0.5 + particle.Lifetime.Max)

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
				deb:AddItem(trailpart, trail.Lifetime)
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

			deb:AddItem(starpart, starparticle.Lifetime.Max)
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
			deb:AddItem(tentabeam, 2)
			deb:AddItem(a0, 2)
			deb:AddItem(a1, 2)
		end)()
	end

	for i = 1, 100 do
		local EndAngle = CF * CSF:RandomAngle()
		local End = (EndAngle * CFrame.new(0, 0, -TentaOutRadius)).Position
		TENTACLES(Pos, End)
	end
	coroutine.wrap(function()
		repeat EWait() until S5_EndState == true
		deb:AddItem(ballpart, 5)
	end)()







	-- EYE (but red)
	local EyeOffset = CFrame.new(Vector3.new(-0.125, 0.2, -0.57 + (-0.125/2 * 0.75)) * CHARACTERSCALE)
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
	eyeparticle.Parent = eyepart
	eye.Parent = EFFECTSCONTAINER
	eyepart.Parent = EFFECTSCONTAINER
	local seteyecf = renderstepped:Connect(function()
		local eyecf = CFRAMES.CHARACTER.Head * EyeOffset
		eye.CFrame = eyecf
		eyepart.CFrame = eyecf
	end)
	EmitParticle(eyeparticle)
	coroutine.wrap(function()
		repeat EWait() until S5_EndState == true
		EWait(S5_ExtendDuration)

		EmitParticleStop(eyeparticle)
		local del = eyeparticle.Lifetime.Max
		task.delay(del, function()
			seteyecf:Disconnect()
		end)
		CSE:TweenInst(eye, {
			{
				TweenInfo = TweenInfo.new(eyeparticle.Lifetime.Min, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Transparency = 1,
				}
			}
		})
		deb:AddItem(eye, del)
		deb:AddItem(eyepart, del)
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
		deb:AddItem(RedTint, 5)
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
			deb:AddItem(UI, 5)
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
		deb:AddItem(part, particle.Lifetime.Max+5)

		CreateSoundAtPos("S5_END", CF.Position, {RollOffMinDistance = 1500})
	end)

	deb:AddItem(starpart, 3.5 + starparticle.Lifetime.Max)
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
	deb:AddItem(exppart, particle.Lifetime.Max + 0.75)

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
	deb:AddItem(exppart, particle.Lifetime.Max)

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
	deb:AddItem(uipart, 3)
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
	deb:AddItem(bpart, duration)
	deb:AddItem(ring, ring.Lifetime.Max)
	deb:AddItem(smoke, smoke.Lifetime.Max)
end




------------------------------------------------------------------------------------------------------------------------------------------

-- Counter
EFFECTS.COUNTER_Charge = function()
	local cframe = CFRAMES.CHARACTER.Character * CFrame.new(0, 0, -2)

	-- Charging up
	local chargepart = CreateEmptyPart(Vector3.zero, cframe)
	local chargeparticle = CSE:CreateEffectInst("COUNTER", "Particles", "CounterCharge")
	chargeparticle.Parent = chargepart
	chargepart.Parent = EFFECTSCONTAINER
	coroutine.wrap(function()
		for i = 1, 5 do
			chargeparticle:Emit(1)
			EWait(0.05)
		end
		deb:AddItem(chargepart, chargeparticle.Lifetime.Max)
	end)()

	CreateSoundAtPos("COUNTERCHARGE", cframe.Position)
end
EFFECTS.COUNTER_Release = function(CounterList)
	local cframe = CFRAMES.CHARACTER.Character

	-- Label
	local labelpart = CreateEmptyPart(Vector3.zero, cframe)
	local ui = CSE:CreateEffectInst("COUNTER", "UI", "CounterDisplay")
	local frame = ui.Frame
	local imglabel = frame.ImageLabel
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

	CSE:TweenInst(labelpart, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			Properties = {
				CFrame = cframe + Vector3.new(0, 8.5, 0)
			}
		}
	})
	CSE:TweenInst(ui, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			Properties = {
				Size = UDim2.new(10, 0, 10, 0)
			}
		}
	})
	CSE:TweenInst(imglabel, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			Properties = {
				ImageTransparency = 0.5,
			}
		}
	})
	EWait(0.5)
	countertext.TextTransparency = 0.75
	countertext.TextStrokeTransparency = 0.75

	-- Attacks
	coroutine.wrap(function()
		local cindex = 1
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0.13, 0.3))
			i = i + 1

			local showattack = i % 2 == 1
			if showattack == true then
				local attack = CounterList[cindex] or "undefined"
				attack = FixWrap(attack) -- replace spaces with empty char; textlabels are annoying and keep wrapping to new line >:((
				attacktext.Text = FixWrap("? "..attack.." ?")

				cindex = cindex + 1
				if cindex > #CounterList then
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
	end)()
	coroutine.wrap(function()
		local i = 0
		while labelpart.Parent ~= nil do
			EWait(rnd:NextNumber(0, 0.25))
			i = i + 1

			imglabel.ImageTransparency = (i % 2) + 0.5
			countertext.TextTransparency = (i % 2) + 0.75
			countertext.TextStrokeTransparency = (i % 2) + 0.75
			attacktext.TextTransparency = (i % 2) + 0.5
		end
	end)()
	deb:AddItem(labelpart, 3.5)



	-- Release
	local counterpart = CreateEmptyPart(Vector3.zero, cframe * CFrame.new(0, 0, -2))
	local counterparticle = CSE:CreateEffectInst("COUNTER", "Particles", "CounterRing")
	counterparticle.Parent = counterpart
	counterpart.Parent = EFFECTSCONTAINER
	counterparticle:Emit(10)
	deb:AddItem(counterpart, counterparticle.Lifetime.Max)



	-- EYE
	local EyeOffset = CFrame.new(Vector3.new(-0.125, 0.2, -0.57 + (-0.125/2 * 0.75)) * CHARACTERSCALE)
	local eye = CSE:CreateEffectInst("PRESETS", "Eye")
	eye.Color = Color3.new(1, 1, 1)
	eye.Size = eye.Size * CHARACTERSCALE

	local eyepart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Head * EyeOffset)
	local eyeparticle = CSE:CreateEffectInst("COUNTER", "Particles", "EYE_Glare")
	local newseq = {}
	for i, Keypoint in eyeparticle.Size.Keypoints do
		table.insert(newseq, NumberSequenceKeypoint.new(Keypoint.Time, Keypoint.Value * CHARACTERSCALE, Keypoint.Envelope))
	end
	eyeparticle.Size = NumberSequence.new(newseq)

	eye.CFrame = CFRAMES.CHARACTER.Head * EyeOffset
	eyeparticle.Parent = eyepart
	eye.Parent = EFFECTSCONTAINER
	eyepart.Parent = EFFECTSCONTAINER
	local seteyecf = renderstepped:Connect(function()
		local eyecf = CFRAMES.CHARACTER.Head * EyeOffset
		eye.CFrame = eyecf
		eyepart.CFrame = eyecf
	end)
	EmitParticle(eyeparticle, 3)
	task.delay(3, function()
		local del = eyeparticle.Lifetime.Max
		task.delay(del, function()
			seteyecf:Disconnect()
		end)
		CSE:TweenInst(eye, {
			{
				TweenInfo = TweenInfo.new(eyeparticle.Lifetime.Min, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				Properties = {
					Transparency = 1,
				}
			}
		})
		deb:AddItem(eye, del)
		deb:AddItem(eyepart, del)
	end)


	-- SFX
	CreateSoundAtPos("COUNTER", cframe.Position)
end

EFFECTS.INTRO = function(CF)
	local shatterpart = CreateEmptyPart(Vector3.zero, CF)
	local particle = CSE:CreateEffectInst("SHATTER")
	particle.Parent = shatterpart
	shatterpart.Parent = EFFECTSCONTAINER
	particle:Emit(200)
	deb:AddItem(shatterpart, particle.Lifetime.Max)

	VOCAL("12")
end

local MUSIC_Enabled = true
local CurrentMusicPart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Character)
local CurrentMusic = CSE:CreateSound("MUSIC", {Parent = CurrentMusicPart})
local CurrentMusicTP = 0
TOGGLEMUSIC = function(ME)
	MUSIC_Enabled = ME
	if MUSIC_Enabled == true then
		pcall(function()
			CurrentMusicPart:Destroy()
		end)
		CurrentMusicPart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Character)
		CurrentMusic = CSE:CreateSound("MUSIC", {TimePosition = CurrentMusicTP, Parent = CurrentMusicPart})
		CurrentMusicPart.Parent = EFFECTSCONTAINER	
	else
		pcall(function()
			CurrentMusicPart:Destroy()
		end)
	end



	-- UI
	local uipart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Character)
	local UI = CSE:CreateEffectInst("MUSIC", "UI", "Music")
	local frame = UI.Frame
	local onlabel = frame.On
	local offlabel = frame.Off

	local targetlabel
	if MUSIC_Enabled == true then targetlabel = onlabel else targetlabel = offlabel end

	onlabel.Visible = MUSIC_Enabled
	offlabel.Visible = not MUSIC_Enabled
	UI.Parent = uipart
	uipart.Parent = EFFECTSCONTAINER

	local setcf = renderstepped:Connect(function()
		uipart.CFrame = CFRAMES.CHARACTER.Character
	end)
	task.delay(0.75, function()
		setcf:Disconnect()
	end)

	EWait(0.25)
	CSE:TweenInst(onlabel, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				ImageTransparency = 1,
			}
		}
	})
	CSE:TweenInst(offlabel, {
		{
			TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties = {
				ImageTransparency = 1,
			}
		}
	})

	deb:AddItem(uipart, 0.5)
end

local origm = CSE:CreateSound("MUSIC", {TimePosition = CurrentMusicTP, Parent = nil})
local MusicLoop = heartbeat:Connect(function()
	if MUSIC_Enabled == true then
		pcall(function()
			if CurrentMusic.IsPlaying == false or CurrentMusicPart.Parent ~= EFFECTSCONTAINER then
				pcall(function()
					CurrentMusicPart:Destroy()
				end)
				CurrentMusicPart = CreateEmptyPart(Vector3.zero, CFRAMES.CHARACTER.Character)
				CurrentMusic = CSE:CreateSound("MUSIC", {TimePosition = CurrentMusicTP, Parent = CurrentMusicPart})
				CurrentMusicPart.Parent = EFFECTSCONTAINER
			end
		end)
		pcall(function()
			CurrentMusicPart.CFrame = CFRAMES.CHARACTER.Character
		end)
		pcall(function()
			CurrentMusicTP = CurrentMusic.TimePosition
		end)
		pcall(function()
			CurrentMusic.Volume = origm.Volume
		end)
		pcall(function()
			CurrentMusic.Pitch = origm.Pitch
		end)
	end
end)

EFFECTS.STOPSCRIPT = function()
	local currentcf = CFRAMES.CHARACTER.Character

	-- Shatter effect
	local shatterpart = CreateEmptyPart(Vector3.zero, currentcf)
	shatterpart.Parent = EFFECTSCONTAINER
	local particle = CSE:CreateEffectInst("SHATTER")
	particle.Parent = shatterpart
	particle:Emit(200)
	deb:AddItem(shatterpart, particle.Lifetime.Max)

	CreateSoundAtPos("TOUHOUDEATH", currentcf.Position)
end

-- For S5_Phase1
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
	task.spawn(error, tostring(val))
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

function LimitCaught(tab, num)
	local new = {}
	for i = 1, num do
		if tab[i] then table.insert(new, tab[i]) end
	end
	return new
end


------------------------------------------------------------------------------------------------------------------------------------------

function GetLockedPos(inst)
	local parent = inst.Parent
	local cf, size
	KKR_MF:HN(function()
		local model = Instance.new("Model", workspace)
		inst.Parent = model
		cf, size = model:GetBoundingBox()
		inst.Parent = parent
		model:Destroy()
	end)
	return cf.Position
end
function RegionHasDeadly(RegionCFrame, RegionSize)
	local attackfilter = GetAttackFilter()
	local parts = CSF:Region(RegionCFrame, RegionSize, attackfilter)
	for i, part in parts do
		local found = false
		pcall(function()
			if table.find(attackfilter, part) then return end
			if CSF:IsRobloxLocked(part) then
				found = true
			end
		end)
		if found then table.clear(attackfilter) return true end
	end
	for i, inst in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
		local found = false
		pcall(function()
			if table.find(attackfilter, inst) then return end
			if CSF:HasLockedInst(inst) then
				if CSF:PosInRotatedRegion(GetLockedPos(inst), RegionCFrame, RegionSize) then
					found = true
				end
			end
		end)
		if found then table.clear(attackfilter) return true end
	end
	table.clear(attackfilter)
	return false
end

-- Deadly Alert
local DeadlyAlertActivated = false -- Main debounce
local DeadlyAlertInstances = {} -- Separate attempts/debounces incase area-attacking multiple times
function DeadlyAlertAttempt(ID, RegionCFrame, RegionSize)
	if DeadlyAlertActivated then return end
	if DeadlyAlertInstances[ID] == true then return end

	-- Activate debounce regardless if region caught something or not (to prevent lag/flashing)
	DeadlyAlertInstances[ID] = true
	task.delay(2.5, function()
		DeadlyAlertInstances[ID] = nil
	end)

	-- Activate main debounce if region did catch something
	if RegionHasDeadly(RegionCFrame, RegionSize) then
		DeadlyAlertActivated = true
		task.delay(2.5, function()
			DeadlyAlertActivated = false
		end)
		EFFECT("DEADLYALERT")
	end
end


-- Hitbox Damage
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
				deb:AddItem(a0, ForceDuration)
				deb:AddItem(vectorforce, ForceDuration)
				task.delay(ForceDuration, function()
					hum:ChangeState(state)
				end)
			end
		end


		EFFECT("HIT", part.Position)
	end
	local attackfilter = GetAttackFilter()
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


-- Special
function Kill1(RegionCFrame, RegionSize)
	local attackfilter = GetAttackFilter()
	local parts = CSF:Region(RegionCFrame, RegionSize, attackfilter)
	for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs() by adding ipairs()
		pcall(function()
			if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(parts, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
				table.insert(parts, part)
			end
		end)
	end
	parts = LimitCaught(parts, SETTINGS.KillEffectLimit)
	for i, part in parts do
		pcall(function()
			EFFECT("KILL1", part.Size, part.CFrame)
		end)
	end
	table.clear(attackfilter)
end

-- Funny Kill
function Kill2(Mode)
	local targets = {}
	for i, inst in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
		pcall(function()
			if CSF:HasLockedInst(inst) then
				if Mode == 1 and inst:IsA("Model") == false then return end
				table.insert(targets, inst)
			end
		end)
	end
	targets = LimitCaught(targets, SETTINGS.KillEffectLimit)
	for i, inst in targets do
		EFFECT("KILL2", GetLockedPos(inst), Mode)
	end
end

-- Decimate
function Kill3(RegionCFrame, RegionSize, TargetPos)
	local attackfilter = GetAttackFilter()
	local parts = CSF:Region(RegionCFrame, RegionSize, attackfilter)
	for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
		pcall(function()
			if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(parts, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
				table.insert(parts, part)
			end
		end)
	end
	parts = LimitCaught(parts, SETTINGS.KillEffectLimit)
	for i, part in parts do
		pcall(function()
			EFFECT("KILL3", part.Position, TargetPos)
		end)
	end
	table.clear(attackfilter)
end

-- Deadly Kill
function Kill4(TargetPos)
	local targets = {}
	for i, inst in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
		pcall(function()
			if CSF:HasLockedInst(inst) then
				table.insert(targets, inst)
			end
		end)
	end
	targets = LimitCaught(targets, SETTINGS.KillEffectLimit)
	for i, inst in targets do
		EFFECT("KILL4", GetLockedPos(inst), TargetPos)
	end
end



--[[ ----------------------------------

			-- CONTROLS --

---------------------------------- ]]--

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
			DefaultAnimsEnabled = false
			CurrentAction = Name
			CurrentActionTime = ActionTime
			ActionChanged:Fire(LastAction, CurrentAction, ActionTime)
			if ActionData.DisableMovement then
				movementenabled = false
				UpdateVelocity({
					Y = 0
				})
				UpdateForce(Vector3.zero)
			end
		end

		ActionData.ActionFunc(...)


		if ActionData.TOGGLEVARS == true and CurrentActionTime == ActionTime then -- If stil performing same action then overwrite
			if ActionData.DisableMovement then
				movementenabled = true
			end
			ACTIONRESET()

			DefaultAnimsEnabled = true
			if CurrentAnimation.Name ~= CurrentCharacterState then
				SetDefaultAnim(CurrentCharacterState, CurrentCharacterState) -- re-update character animations
			end	
		end
		ActionData.RunningInstances[ActionTime] = nil
	end)(...)
end
RemoteRequests.ACTION = ACTIONPERFORM


---------------- MOVEMENT ----------------
-- Run
ACTIONSETUP("RUNMODE", function()
	if flymode == true then return end
	runmode = not runmode
end)

-- Jump
ACTIONSETUP("JUMP", function()
	if flymode == true then return end
	UpdateVelocity({
		Y = 0
	})
	UpdateForce({
		Y = SETTINGS.JumpForce
	}, SETTINGS.JumpForceDecayDuration) -- average human jumping time
end)

-- Fly
ACTIONSETUP("FLYMODE", function()
	flymode = not flymode

	if flymode == false then
		UpdateVelocity({
			Y = 0
		})

		local dir = CFrame.new(currentcf.Position, currentcf.Position + currentlook).RightVector
		local force = Vector3.new(0, SETTINGS.JumpForce/3, 0) + (dir * 16)
		UpdateForce({
			X = force.X,
			Y = force.Y,
			Z = force.Z
		})
		AnimationPlay("FlyToGround")
		EFFECT("BROOM_Sparkles", false)
		task.wait(0.25)
	else
		UpdateVelocity({
			Y = 0
		})
		UpdateForce({
			Y = 50
		})
		AnimationPlay("GroundToFly")
		EFFECT("BROOM_Sparkles", true, ADMbroom:GetRecordedProperty(origbroom.Broom, "Size"))
		task.wait(1)
	end
end)


---------------- NORMAL ATTACKS ----------------

--[[
	{
		["Ground/Air"] = {
			TotalDuration = number
			
			LoopedAttack = true/false
			Damage = number
			HitboxSize = Vector3
			HitboxOffset = CFrame
			HitboxDelay = number
			TargetForceCFrameOffset = CFrame (offset from currentcf to turn into a vector)
			TargetForceDuration = number
			
			CharacterForceOffset = CFrame (offset from currentcf to turn into a vector)
			CharacterForceDecay = number
			Animation = AnimName
			BroomSlash = true/false
			BroomSlashDuration = number
			VocalSounds = {SoundName1, SoundName2} -- randomized vocals
		}
	}
}
]]
function NORMALATTACK(MainData)
	if flymode == true then return end

	local AttackData
	if (CurrentCharacterState == "Jumping" or CurrentCharacterState == "Falling") == false then -- Ground
		AttackData = MainData.Ground
	else -- Airborne
		AttackData = MainData.Air
	end
	if AttackData == nil then return end





	local TotalDuration = AttackData.TotalDuration

	-- Damaging
	local Damage = AttackData.Damage
	local HitboxSize = AttackData.HitboxSize
	local HitboxOffset = AttackData.HitboxOffset
	local HitboxDelay = AttackData.HitboxDelay
	local TargetForceCFOffset = AttackData.TargetForceCFrameOffset
	local TargetForceDuration = AttackData.TargetForceDuration
	task.delay(HitboxDelay, function()
		local function attack()
			local HitData = {}
			HitData.RegionCFrame = currentcf * HitboxOffset
			HitData.RegionSize = HitboxSize
			HitData.Damage = Damage
			HitData.Force = function() return (currentcf * TargetForceCFOffset).Position - currentcf.Position end
			HitData.ForceDuration = TargetForceDuration

			HitboxDamage(HitData)
		end
		if AttackData.LoopedAttack == true then
			local attackloop = heartbeat:Connect(attack)
			task.delay(TotalDuration - HitboxDelay, function()
				attackloop:Disconnect()
			end)
		end
		attack()
	end)


	-- Character
	local CharacterForceOffset = AttackData.CharacterForceOffset
	local FinalForce = (currentcf * CharacterForceOffset).Position - currentcf.Position
	UpdateForce(FinalForce, AttackData.CharacterForceDecay)

	AnimationPlay(AttackData.Animation)
	if AttackData.BroomSlash == true then
		local duration = AttackData.BroomSlashDuration
		EFFECT("BROOM_Slash", duration, ADMbroom:GetRecordedProperty(origbroom.Broom, "Size"))
	end

	local VocalSounds = AttackData.VocalSounds
	EFFECT("VOCAL", CSF:PickRandomFromTable(VocalSounds))






	task.wait(TotalDuration)
end

-- Dash
ACTIONSETUP("DASH", function() NORMALATTACK({
	Ground = {
		TotalDuration = 0.75,

		LoopedAttack = true,
		Damage = 15/60,
		HitboxSize = Vector3.new(7, 2.5, 7) * 3,
		HitboxOffset = CFrame.new(Vector3.new(0, -3 + (2.5/2), -3.5) * CHARACTERSCALE),
		HitboxDelay = 0,
		TargetForceCFrameOffset = CFrame.new(0, 30, -20),
		TargetForceDuration = 0.25,

		CharacterForceOffset = CFrame.new(0, 0, -80),
		CharacterForceDecay = 1,
		Animation = "DashGround",
		VocalSounds = {"5"},
	},
	Air = {
		TotalDuration = 0.75,

		LoopedAttack = true,
		Damage = 15/60,
		HitboxSize = Vector3.new(7, 7, 7) * 3,
		HitboxOffset = CFrame.new(Vector3.new(0, 0, -3.5) * CHARACTERSCALE),
		HitboxDelay = 0,
		TargetForceCFrameOffset = CFrame.new(0, 0, -20),
		TargetForceDuration = 0.25,

		CharacterForceOffset = CFrame.new(0, 0, -80),
		CharacterForceDecay = 1,
		Animation = "DashAir",
		BroomSlash = true,
		BroomSlashDuration = 0.75,
		VocalSounds = {"8"},
	}
	}) end, true)



-- N1 (Kicks)
ACTIONSETUP("N1", function() NORMALATTACK({
	Ground = {
		TotalDuration = 0.15,

		LoopedAttack = false,
		Damage = 1.5,
		HitboxSize = Vector3.new(3, 4, 3) * 1.5 * 3,
		HitboxOffset = CFrame.new(Vector3.new(-1, -3 + (4/2), -2.5) * CHARACTERSCALE),
		HitboxDelay = 0,
		TargetForceCFrameOffset = CFrame.new(0, 60, -20),
		TargetForceDuration = 0.2,

		CharacterForceOffset = CFrame.new(0, 0, -8),
		CharacterForceDecay = 0.2,
		Animation = "N1Ground",
		VocalSounds = {"5", "6"},
	},
	Air = {
		TotalDuration = 0.15,

		LoopedAttack = false,
		Damage = 1.5,
		HitboxSize = Vector3.new(5, 5, 5) * 1.5 * 3,
		HitboxOffset = CFrame.new(Vector3.new(1, -3, -3) * CHARACTERSCALE),
		HitboxDelay = 0.1,
		TargetForceCFrameOffset = CFrame.new(0, 40, -20),
		TargetForceDuration = 0.2,

		CharacterForceOffset = CFrame.new(0, -8, -16),
		CharacterForceDecay = 0.2,
		Animation = "N1Air",
		VocalSounds = {"2"},
	}
	}) end, true)



-- N2 (Broom Poke/Air Punch)
ACTIONSETUP("N2", function() NORMALATTACK({
	Ground = {
		TotalDuration = 0.15,

		LoopedAttack = false,
		Damage = 3,
		HitboxSize = Vector3.new(3, 7, 4) * 1.5 * 3,
		HitboxOffset = CFrame.new(Vector3.new(-1.5, 0, -6) * CHARACTERSCALE),
		HitboxDelay = 0.1,
		TargetForceCFrameOffset = CFrame.new(0, 100, -15),
		TargetForceDuration = 0.3,

		CharacterForceOffset = CFrame.new(0, 0, -8),
		CharacterForceDecay = 0.2,
		Animation = "N2Ground",
		BroomSlash = true,
		BroomSlashDuration = 0.25,
		VocalSounds = {"2", "3"},
	},
	Air = {
		TotalDuration = 0.2,

		LoopedAttack = false,
		Damage = 3,
		HitboxSize = Vector3.new(5, 7, 5) * 1.5 * 3,
		HitboxOffset = CFrame.new(Vector3.new(1.5, -3, -4) * CHARACTERSCALE),
		HitboxDelay = 0.1,
		TargetForceCFrameOffset = CFrame.new(0, -70, -15),
		TargetForceDuration = 0.1,

		CharacterForceOffset = CFrame.new(0, -10, -10),
		CharacterForceDecay = 0.1,
		Animation = "N2Air",
		VocalSounds = {"6"},
	}
	}) end, true)



-- N3 (Broom Smash)
ACTIONSETUP("N3", function() NORMALATTACK({
	Ground = {
		TotalDuration = 0.15,

		LoopedAttack = false,
		Damage = 10,
		HitboxSize = Vector3.new(7, 7, 7) * 3,
		HitboxOffset = CFrame.new(Vector3.new(0, 0, -3.5) * CHARACTERSCALE),
		HitboxDelay = 0.1,
		TargetForceCFrameOffset = CFrame.new(0, 0, -40),
		TargetForceDuration = 0.3,

		CharacterForceOffset = CFrame.new(0, 0, -20),
		CharacterForceDecay = 0.3,
		Animation = "N3",
		BroomSlash = true,
		BroomSlashDuration = 0.25,
		VocalSounds = {"7"},
	},
	Air = {
		TotalDuration = 0.15,

		LoopedAttack = false,
		Damage = 10,
		HitboxSize = Vector3.new(7, 7, 7) * 3,
		HitboxOffset = CFrame.new(Vector3.new(0, 0, -3.5) * CHARACTERSCALE),
		HitboxDelay = 0.1,
		TargetForceCFrameOffset = CFrame.new(0, -100, 0), -- Only difference from ground
		TargetForceDuration = 0.3,

		CharacterForceOffset = CFrame.new(0, 0, -20),
		CharacterForceDecay = 0.3,
		Animation = "N3",
		BroomSlash = true,
		BroomSlashDuration = 0.25,
		VocalSounds = {"7"},
	},
	}) end, true)

-- N4 (Broom Smack)
ACTIONSETUP("N4", function() NORMALATTACK({
	Ground = {
		TotalDuration = 0.3,

		LoopedAttack = false,
		Damage = 20,
		HitboxSize = Vector3.new(10, 10, 10) * 3,
		HitboxOffset = CFrame.new(Vector3.new(0, 0, -5) * CHARACTERSCALE),
		HitboxDelay = 0.1,
		TargetForceCFrameOffset = CFrame.new(0, 0, -80),
		TargetForceDuration = 0.5,

		CharacterForceOffset = CFrame.new(0, 0, -15),
		CharacterForceDecay = 0.5,
		Animation = "N4",
		BroomSlash = true,
		BroomSlashDuration = 0.4,
		VocalSounds = {"1"},
	},
	Air = {
		TotalDuration = 0.3,

		LoopedAttack = false,
		Damage = 20,
		HitboxSize = Vector3.new(10, 10, 10) * 3,
		HitboxOffset = CFrame.new(Vector3.new(0, 0, -5) * CHARACTERSCALE),
		HitboxDelay = 0.1,
		TargetForceCFrameOffset = CFrame.new(0, 0, -80),
		TargetForceDuration = 0.5,

		CharacterForceOffset = CFrame.new(0, 0, -15),
		CharacterForceDecay = 0.5,
		Animation = "N4",
		BroomSlash = true,
		BroomSlashDuration = 0.4,
		VocalSounds = {"1"},
	},
	}) end, true)





---------------- MISC ----------------
-- ABSORBER
local ABSORBER_Debounce = false
local ABSORBER_Enabled = false
local ABSORBER_Level = 0
local ABSORBER_Time = os.clock()

ACTIONSETUP("ABSORBER", function()
	if flymode == true or ABSORBER_Debounce == true then return end

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
		local RegionCFrame = CFrame.new((currentcf * CFrame.new(0, 0, -Range/2)).Position)
		local RegionPos = RegionCFrame.Position
		local RegionSize = Vector3.one * Range

		local PriorityEvents = {}

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
							KKR_IF_Humanoid:ZeroHealth(hum, 2, PriorityEvents)
						elseif ABSORBER_Level == 3 then
							KKR_IF_Humanoid:SetChangeState(hum)
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
					KKR_MF:Anima(nil, nil, PriorityEvents)
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

-- LASER
ACTIONSETUP("LASER", function()
	if flymode == true then return end

	AnimationPlay("SpecialCharge")
	EFFECT("LASER_Charge")
	task.wait(0.2)

	AnimationPlay("LaserFire")
	task.wait(0.35)


	---------------- ATTACK ----------------
	local AttackDuration = 4.25
	local Range = 100
	local Width = 15
	local HandPos = (CFRAMES.CHARACTER["Left Arm"] * CFrame.new(0, -1 * CHARACTERSCALE, 0)).Position
	local EndPos = (currentcf * CFrame.new(0, 0, -Range)).Position
	local RegionCFrame = CFrame.new(HandPos:Lerp(EndPos, 0.5), EndPos)
	local RegionSize = Vector3.new(Width, Width, Range)
	local AlertID = tostring(os.clock())

	EFFECT("LASER_Release", HandPos, EndPos)


	local LoopEvents = {}
	local InstEvents = {}

	local function PartAttack(part)
		KKR_MF:Destroy(part)
	end

	-- Loop
	LoopEvents.AOECheck = KKR_MF:LoopConnections(function()
		local caught = {}
		local attackfilter = GetAttackFilter()
		for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
			pcall(function()
				table.insert(caught, part)
				PartAttack(part)
			end)
		end
		for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
			pcall(function()
				if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(caught, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
					PartAttack(part)
				end
			end)
		end
		DeadlyAlertAttempt(AlertID, RegionCFrame, RegionSize)
		table.clear(attackfilter)
	end)

	-- Inst
	local tab = {}
	local function instfunc(part)
		tab.AOECheck:Disconnect()
		tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
		defer(pcall, function()
			if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(GetAttackFilter(), part) == nil and (table.find(CSF:Region(RegionCFrame, RegionSize, {part}, Enum.RaycastFilterType.Whitelist), part) or (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize))) then
				PartAttack(part)
			end
		end)
	end
	tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
	InstEvents[workspace] = tab

	Kill1(RegionCFrame, RegionSize)

	-- use heartbeat checks incase script timeout
	local t = os.clock()
	local endcheck
	endcheck = heartbeat:Connect(function()
		if os.clock() - t >= AttackDuration then
			KKR_MF:Anima(LoopEvents, InstEvents)
			endcheck:Disconnect()
		end
	end)

	task.wait(3.5)
end, true)


-- STASIS
-- An attack that stabilizes reality; strong attack to the forbidden funny instance (speaker parts), and weak attack to normal parts as side-effect of reality stabilization
local STASIS_Mode = 0
local STASIS_DisableQueue -- incase released key when action didn't start yet
local STASIS_RegionCFrame
local STASIS_RegionSize
ACTIONSETUP("STASIS", function()
	if flymode == true then return end
	if STASIS_Mode ~= 0 then return end
	STASIS_DisableQueue = nil


	AnimationPlay("SpecialCharge")
	EFFECT("STASIS_Charge")
	task.wait(0.2)

	AnimationPlay("Special")
	task.wait(0.35)


	---------------- ATTACK ----------------
	local Range = 50
	local RegionCFrame = currentcf * CFrame.new(0, (-3 * CHARACTERSCALE) + Range/4, 0)
	local RegionSize = Vector3.new(1, 1.15, 1) * Range

	STASIS_Mode = 1
	STASIS_RegionCFrame = RegionCFrame
	STASIS_RegionSize = RegionSize
	EFFECT("STASIS_Release", RegionCFrame.Position, STASIS_Mode)


	local LoopEvents = {}
	local InstEvents = {}
	local PriorityEvents = {}

	local function PartAttack(part)
		KKR_IF_BasePart:BreakJoints(part, 1)
	end
	local function FunnyAttack(inst)
		if STASIS_Mode == 1 then
			if inst:IsA("Model") then
				KKR_MF:Destroy(inst)
			end
		elseif STASIS_Mode == 2 then
			if inst:IsA("Model") then
				KKR_IF_Model:Void(inst, 2, PriorityEvents)
			else
				KKR_MF:Destroy(inst)
			end
		elseif STASIS_Mode == 3 then
			KKR_IF_MISC:InternalEliminate(inst, 1)
		end
	end

	-- Loop
	LoopEvents.AOECheck = KKR_MF:LoopConnections(function()
		local caught = {}
		local attackfilter = GetAttackFilter()
		for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
			pcall(function()
				table.insert(caught, part)
				PartAttack(part)
			end)
		end
		for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
			pcall(function()
				if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(caught, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
					PartAttack(part)
				end
			end)
		end
		local desc = workspace:GetDescendants()
		for i = #desc, 1, -1 do
			local inst = desc[i]
			pcall(function()
				if table.find(attackfilter, inst) ~= nil then return end
				local DEADLYTARGET = CSF:HasLockedInst(inst)
				if DEADLYTARGET == true then
					FunnyAttack(inst)
				elseif inst:IsA("BasePart") then
					if inst:IsA("Terrain") == false and table.find(caught, inst) == nil and (CSF:PosInRotatedRegion(inst.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(inst, RegionCFrame, RegionSize)) then
						PartAttack(inst)
					end
				end
			end)
		end
		table.clear(attackfilter)
	end)

	-- Inst
	local tab = {}
	local function instfunc(inst)
		tab.AOECheck:Disconnect()
		tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
		defer(pcall, function()
			local attackfilter = GetAttackFilter()
			if table.find(attackfilter, inst) ~= nil then return end
			local DEADLYTARGET = CSF:HasLockedInst(inst)
			if DEADLYTARGET == true then
				FunnyAttack(inst)
			elseif inst:IsA("BasePart") then
				if inst:IsA("Terrain") == false and (CSF:PosInRotatedRegion(inst.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(inst, RegionCFrame, RegionSize)) then
					PartAttack(inst)
				end
			end
			table.clear(attackfilter)
		end)
	end
	tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
	InstEvents[workspace] = tab


	-- Hit effect
	local attackfilter = GetAttackFilter()
	local parts = CSF:Region(RegionCFrame, RegionSize, attackfilter)
	for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
		pcall(function()
			if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(parts, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
				table.insert(parts, part)
			end
		end)
	end
	for i, part in parts do
		pcall(function()
			if #part:GetJoints() > 0 then
				EFFECT("HIT2", part.Size, part.CFrame)
			end
		end)
	end
	Kill2(STASIS_Mode)
	table.clear(attackfilter)


	local function stopact()
		KKR_MF:Anima(LoopEvents, InstEvents, PriorityEvents)
		EFFECT("STASIS_END")
		STASIS_DisableQueue = nil
		STASIS_Mode = 0
	end
	-- use heartbeat checks incase script timeout
	local t = os.clock()
	local endcheck
	endcheck = heartbeat:Connect(function()
		if STASIS_DisableQueue == true then
			stopact()
			endcheck:Disconnect()
		end
	end)

	-- stop when action changed (counter)
	local checkchange
	checkchange = ActionChanged.Event:Connect(function()
		checkchange:Disconnect()
		endcheck:Disconnect()
		stopact()
	end)

	-- lock char until stop
	repeat heartbeat:Wait() until STASIS_Mode == 0
end, true)
ACTIONSETUP("STASIS_SWITCH", function()
	if STASIS_Mode == 0 then return end
	STASIS_Mode = STASIS_Mode + 1
	if STASIS_Mode > 3 then
		STASIS_Mode = 1
	end

	EFFECT("STASIS_Charge")
	EFFECT("STASIS_Release", STASIS_RegionCFrame.Position, STASIS_Mode)
	Kill2(STASIS_Mode)
end, false, false, true, false)
ACTIONSETUP("STASIS_END", function()
	STASIS_DisableQueue = true
end, false, false, true, false)



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
	if flymode == true then return end
	local SpecialChargeDuration = AttackData.SpecialChargeDuration
	local AttackName = AttackData.AttackName
	local MethodName = AttackData.MethodName
	local MethodName2 = AttackData.MethodName2

	AnimationPlay("SpecialCharge")
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


	AnimationPlay("Special")

	AttackData.KillFunc()
end

SPECIAL_Events.S1 = {
	LoopEvents = {},
	PriorityEvents = {},
	TARGETS = {}
}
SPECIAL_Events.S1.LoopEvents.PERSIST = KKR_MF:LoopConnections(function()
	local EventsData = SPECIAL_Events.S1
	for i, part in EventsData.TARGETS do
		pcall(function()
			KKR_IF_BasePart:Void(part, 2, EventsData.PriorityEvents)
		end)
	end
end)
ACTIONSETUP("S1", function() SPECIALATTACK({
	AttackName = "hésiter",
	MethodName = "VOID",
	MethodName2 = "空 虚",
	SpecialRed = false,
	SpecialChargeDuration = 0.5,
	HasVocals = true,

	KillFunc = function()
		local AttackDelay = 1.5 + 0.3
		local AttackDuration = 3.5
		local RegionCFrame = currentcf * CFrame.new(0, -3 * CHARACTERSCALE, -50/2 - 5)
		local RegionSize = Vector3.new(1, 0.5, 1) * 50
		local AlertID = tostring(os.clock())

		EFFECT("S1", CFrame.new(RegionCFrame.Position + Vector3.new(0, 50, 0)))
		task.wait(AttackDelay)


		---------------- ATTACK ----------------
		local LoopEvents = {}
		local InstEvents = {}

		local EventsData = SPECIAL_Events.S1

		local function PartAttack(part)
			KKR_IF_BasePart:Void(part, 2, EventsData.PriorityEvents)
		end

		-- Loop
		LoopEvents.AOECheck = KKR_MF:LoopConnections(function()
			local caught = {}
			local attackfilter = GetAttackFilter()
			for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
				pcall(function()
					if table.find(EventsData.TARGETS, part) then return end
					table.insert(EventsData.TARGETS, part)
					table.insert(caught, part)
					PartAttack(part)
				end)
			end
			for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
				pcall(function()
					if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(caught, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
						if table.find(EventsData.TARGETS, part) then return end
						table.insert(EventsData.TARGETS, part)
						PartAttack(part)
					end
				end)
			end
			DeadlyAlertAttempt(AlertID, RegionCFrame, RegionSize)
			table.clear(attackfilter)
		end)

		-- Inst
		local tab = {}
		local function instfunc(part)
			tab.AOECheck:Disconnect()
			tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
			defer(pcall, function()
				if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(GetAttackFilter(), part) == nil and (table.find(CSF:Region(RegionCFrame, RegionSize, {part}, Enum.RaycastFilterType.Whitelist), part) or (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize))) then
					PartAttack(part)
				end
			end)
		end
		tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
		InstEvents[workspace] = tab


		Kill1(RegionCFrame, RegionSize)


		-- use heartbeat checks incase script timeout
		local t = os.clock()
		local endcheck
		endcheck = heartbeat:Connect(function()
			if os.clock() - t >= AttackDuration then
				KKR_MF:Anima(LoopEvents, InstEvents)
				endcheck:Disconnect()
			end
		end)
		task.wait(3)
	end,
	}) end, true)


SPECIAL_Events.S2 = {
	LoopEvents = {},
	PriorityEvents = {},
	TARGETS = {}
}
SPECIAL_Events.S2.LoopEvents.PERSIST = KKR_MF:LoopConnections(function()
	local EventsData = SPECIAL_Events.S2
	for i, part in EventsData.TARGETS do
		pcall(function()
			KKR_IF_BasePart:MeshZSNINFOff(part, 2, EventsData.PriorityEvents)
			KKR_IF_BasePart:ApplyEmptyMesh(part, 2, EventsData.PriorityEvents)
			for i, hum in part.Parent:GetChildren() do
				pcall(function()
					if hum:IsA("Humanoid") then
						KKR_MF:Destroy(hum)
					end
				end)
			end
			part.CanCollide = false
			part.Anchored = false
		end)
	end
end)
ACTIONSETUP("S2", function() SPECIALATTACK({
	AttackName = "inconnu",
	MethodName = "MSH",
	MethodName2 = "网 格 退 化",
	SpecialRed = false,
	SpecialChargeDuration = 0.75,
	HasVocals = true,

	KillFunc = function()
		local BallID = tostring(os.clock())
		local HandPos = (CFRAMES.CHARACTER["Left Arm"] * CFrame.new(0, -1 * CHARACTERSCALE, 0)).Position
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

		local setlookcf = heartbeat:Connect(function()
			local RPos = RegionCFrame.Position
			local look = (RPos-currentcf.Position).Unit
			if currentcf.Position ~= RPos then
				currentlook = Vector3.new(look.X, 0, look.Z)
			end
		end)
		local checkchange
		checkchange = ActionChanged.Event:Connect(function()
			checkchange:Disconnect()
			setlookcf:Disconnect()
		end)

		task.delay(3.75, function()
			setregioncf:Disconnect()
			setlookcf:Disconnect()
		end)

		task.wait(3.5)
		EFFECT("S2_Release", BallID, CFrame.new(RegionCFrame.Position, currentcf.Position))

		---------------- ATTACK ----------------
		local AttackDuration = 5
		local LoopEvents = {}
		local InstEvents = {}

		local EventsData = SPECIAL_Events.S2

		local function PartAttack(part)
			KKR_IF_BasePart:MeshZSNINFOff(part, 2, EventsData.PriorityEvents)
			KKR_IF_BasePart:ApplyEmptyMesh(part, 2, EventsData.PriorityEvents)
		end

		-- Loop
		LoopEvents.AOECheck = KKR_MF:LoopConnections(function()
			local caught = {}
			local attackfilter = GetAttackFilter()
			for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
				pcall(function()
					if table.find(EventsData.TARGETS, part) then return end
					table.insert(EventsData.TARGETS, part)
					table.insert(caught, part)
					PartAttack(part)
				end)
			end
			for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
				pcall(function()
					if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(caught, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
						if table.find(EventsData.TARGETS, part) then return end
						table.insert(EventsData.TARGETS, part)
						PartAttack(part)
					end
				end)
			end
			DeadlyAlertAttempt(AlertID, RegionCFrame, RegionSize)
			table.clear(attackfilter)
		end)

		-- Inst
		local tab = {}
		local function instfunc(part)
			tab.AOECheck:Disconnect()
			tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
			defer(pcall, function()
				if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(GetAttackFilter(), part) == nil and (table.find(CSF:Region(RegionCFrame, RegionSize, {part}, Enum.RaycastFilterType.Whitelist), part) or (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize))) then
					PartAttack(part)
				end
			end)
		end
		tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
		InstEvents[workspace] = tab


		Kill1(RegionCFrame, RegionSize)

		-- use heartbeat checks incase script timeout
		local t = os.clock()
		local endcheck
		endcheck = heartbeat:Connect(function()
			if os.clock() - t >= AttackDuration then
				KKR_MF:Anima(LoopEvents, InstEvents)
				endcheck:Disconnect()

			end
		end)

		task.wait(4.25)
	end,
	}) end, true)


SPECIAL_Events.S3 = {
	LoopEvents = {},
	PriorityEvents = {},
	TARGETS = {}
}
SPECIAL_Events.S3.LoopEvents.PERSIST = KKR_MF:LoopConnections(function()
	local EventsData = SPECIAL_Events.S3
	for i, part in EventsData.TARGETS do
		pcall(function()
			KKR_IF_BasePart:VPFDerender(part, 1, EventsData.PriorityEvents)
			for i, hum in part.Parent:GetChildren() do
				pcall(function()
					if hum:IsA("Humanoid") then
						KKR_MF:Destroy(hum)
					end
				end)
			end
			part.CanCollide = false
			part.Anchored = false
		end)
	end
end)
ACTIONSETUP("S3", function() SPECIALATTACK({
	AttackName = "rideau",
	MethodName = "VPF",
	MethodName2 = "视 图 框 架 未 渲 染",
	SpecialRed = false,
	SpecialChargeDuration = 0.75,
	HasVocals = true,

	KillFunc = function()
		local BallID = tostring(os.clock()) -- Can spawn multiple balls at once, so we need to differentiate
		local Velocity = 20
		local InitialRegionPos = (currentcf * CFrame.new(0, 50, -20)).Position

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
		local InstEvents = {}

		local EventsData = SPECIAL_Events.S3

		local KillEffectAmt = 0
		local function PartAttack(part)
			if KillEffectAmt < SETTINGS.KillEffectLimit then
				KillEffectAmt = KillEffectAmt + 1
				pcall(function()
					EFFECT("KILL1", part.Size, part.CFrame)
				end)
				task.delay(1.5, function()
					KillEffectAmt = KillEffectAmt - 1
				end)
			end

			KKR_IF_BasePart:VPFDerender(part, 1, EventsData.PriorityEvents)
		end

		-- Loop
		LoopEvents.AOECheck = KKR_MF:LoopConnections(function()
			local caught = {}
			local attackfilter = GetAttackFilter()
			for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
				pcall(function()
					if table.find(EventsData.TARGETS, part) then return end
					table.insert(EventsData.TARGETS, part)
					table.insert(caught, part)
					PartAttack(part)
				end)
			end
			for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
				pcall(function()
					if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(caught, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
						if table.find(EventsData.TARGETS, part) then return end
						table.insert(EventsData.TARGETS, part)
						PartAttack(part)
					end
				end)
			end
			DeadlyAlertAttempt(AlertID, RegionCFrame, RegionSize)
			table.clear(attackfilter)
		end)

		-- Inst
		local tab = {}
		local function instfunc(part)
			tab.AOECheck:Disconnect()
			tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
			defer(pcall, function()
				if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(GetAttackFilter(), part) == nil and (table.find(CSF:Region(RegionCFrame, RegionSize, {part}, Enum.RaycastFilterType.Whitelist), part) or (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize))) then
					PartAttack(part)
				end
			end)
		end
		tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
		InstEvents[workspace] = tab


		Kill1(RegionCFrame, RegionSize)

		-- use heartbeat checks incase script timeout
		local t = os.clock()
		local endcheck
		endcheck = heartbeat:Connect(function()
			if os.clock() - t >= AttackDuration then
				KKR_MF:Anima(LoopEvents, InstEvents)
				endcheck:Disconnect()

			end
		end)

		-- End
		task.delay(6, function()
			setcf:Disconnect()
			EFFECT("S3_End", BallID)
		end)


	end,
	}) end, true)


SPECIAL_Events.S4 = {
	LoopEvents = {},
	PriorityEvents = {},
	TARGETS = {}
}
SPECIAL_Events.S4.LoopEvents.PERSIST = KKR_MF:LoopConnections(function()
	local EventsData = SPECIAL_Events.S4
	for i, part in EventsData.TARGETS do
		pcall(function()
			KKR_IF_BasePart:Void(part, 3, EventsData.PriorityEvents)
		end)
	end
end, 2)
ACTIONSETUP("S4", function() SPECIALATTACK({
	AttackName = "mémoire",
	MethodName = "pVOID",
	MethodName2 = "优 先 空 虚",
	SpecialRed = false,
	SpecialChargeDuration = 1.5,
	HasVocals = true,

	KillFunc = function()
		local AttackDelay = 1.5
		local AttackDuration = 6.75
		local Range = 150
		local RegionCFrame = currentcf * CFrame.new(0, (-3 * CHARACTERSCALE) + Range/2 + 10, -Range/2 -10)
		local RegionSize = Vector3.new(1, 1.15, 1) * Range
		local AlertID = tostring(os.clock())

		EFFECT("S4", RegionCFrame)
		task.wait(AttackDelay)


		---------------- ATTACK ----------------
		local LoopEvents = {}
		local InstEvents = {}

		local EventsData = SPECIAL_Events.S4

		local function PartAttack(part)
			KKR_IF_BasePart:Void(part, 3, EventsData.PriorityEvents)
		end

		-- Loop
		LoopEvents.AOECheck = KKR_MF:LoopConnections(function()
			local caught = {}
			local attackfilter = GetAttackFilter()
			for i, part in CSF:Region(RegionCFrame, RegionSize, attackfilter) do
				pcall(function()
					if table.find(EventsData.TARGETS, part) then return end
					table.insert(EventsData.TARGETS, part)
					table.insert(caught, part)
					PartAttack(part)
				end)
			end
			for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
				pcall(function()
					if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(caught, part) == nil and table.find(attackfilter, part) == nil and (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize)) then
						if table.find(EventsData.TARGETS, part) then return end
						table.insert(EventsData.TARGETS, part)
						PartAttack(part)
					end
				end)
			end
			DeadlyAlertAttempt(AlertID, RegionCFrame, RegionSize)
			table.clear(attackfilter)
		end, 2)

		-- Inst
		local tab = {}
		local function instfunc(part)
			tab.AOECheck:Disconnect()
			tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
			defer(pcall, function()
				if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(GetAttackFilter(), part) == nil and (table.find(CSF:Region(RegionCFrame, RegionSize, {part}, Enum.RaycastFilterType.Whitelist), part) or (CSF:PosInRotatedRegion(part.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(part, RegionCFrame, RegionSize))) then
					PartAttack(part)
				end
			end)
		end
		tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
		InstEvents[workspace] = tab

		Kill1(RegionCFrame, RegionSize)

		-- use heartbeat checks incase script timeout
		local t = os.clock()
		local endcheck
		endcheck = heartbeat:Connect(function()
			if os.clock() - t >= AttackDuration then
				KKR_MF:Anima(LoopEvents, InstEvents)
				endcheck:Disconnect()
			end
		end)
		task.wait(4.5)

	end,
	}) end, true)





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

-- Running first is important. (first-connected Heartbeat + Supernull stack-10 priority)
-- PHASE 1
do
	local P1_Activated = false
	local P1LoopEvents, P1InstEvents = {}, {} -- for the main events

	local BANISHLoopEvents, BANISHInstEvents, BANISHPriorityEvents = {}, {}, {}
	local KIERUDATA = {}

	local LoopEvents, InstEvents, PriorityEvents = {}, {}, {} -- for the attack events
	local DEADLYCAUGHT = {}
	local RegionCFrame, RegionSize

	local function PartAttack(part)
		local parent = part.Parent
		if KKR_MF:IsInKieruTable(part, KIERUDATA) == false then
			table.insert(KIERUDATA, KKR_MF:GetKieruData(part))
		end
		KKR_MF:Execute(part, nil, nil, PriorityEvents)
		pcall(function()
			local player = players:GetPlayerFromCharacter(parent)
			if player ~= nil then
				KKR_IF_Player:Banish(player, 2, 4, 3, BANISHLoopEvents, BANISHInstEvents, BANISHPriorityEvents)
			end
		end)
		pcall(function()
			for i, inst in parent:GetChildren() do
				pcall(function()
					if inst:IsA("Humanoid") or inst:IsA("BaseScript") then
						KKR_MF:Execute(inst, LoopEvents, InstEvents, PriorityEvents)
					end
				end)
			end
		end)
	end




	---------------- TRADITIONAL ----------------
	-- Loop
	local TradLoop = function()
		if not P1_Activated then return end
		KKR_MF:HN(function()

			local caught = {}
			local attackfilter = GetAttackFilter()
			local RegionCaught = CSF:Region(RegionCFrame, RegionSize, attackfilter)
			for i, part in RegionCaught do
				pcall(function()
					table.insert(caught, part)
					if CSF:IsRobloxLocked(part) and table.find(DEADLYCAUGHT, part) == nil then
						table.insert(DEADLYCAUGHT, part)
						return
					end
					if CSF:HasLockedInst(part) then
						KKR_IF_MISC:ForceVoid(part)
						for i, ch in CSF:GetLockedInstances(part) do
							KKR_IF_MISC:LockVoid(ch) -- Don't tag as deadlycaught since it'll get destroyed anyway
						end
					end
					PartAttack(part)
				end)
			end

			-- Search through whole world for catchable deadly parts
			local RegionCaught2 = CSF:Region(RegionCFrame, Vector3.one * 1500, attackfilter)
			for i, part in RegionCaught2 do
				pcall(function()
					if CSF:IsRobloxLocked(part) and table.find(DEADLYCAUGHT, part) == nil then
						table.insert(DEADLYCAUGHT, part)
					end
				end)
			end

			local desc = workspace:GetDescendants()
			for i = #desc, 1, -1 do
				local inst = desc[i]
				pcall(function()
					if table.find(attackfilter, inst) ~= nil then return end
					local DEADLYTARGET = CSF:HasLockedInst(inst)
					if DEADLYTARGET == true then
						KKR_IF_MISC:ForceVoid(inst)
						for i, ch in CSF:GetLockedInstances(inst) do
							KKR_IF_MISC:LockVoid(ch) -- Don't tag as deadlycaught since it'll get destroyed anyway
						end
					end
					if inst:IsA("BasePart") then
						if inst:IsA("Terrain") == false and table.find(caught, inst) == nil and (KKR_MF:IsInKieruTable(inst, KIERUDATA) or CSF:PosInRotatedRegion(inst.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(inst, RegionCFrame, RegionSize)) then
							PartAttack(inst)
						end
					elseif DEADLYTARGET == true then
						KKR_MF:Execute(inst, LoopEvents, InstEvents, PriorityEvents)
						KKR_MF:Destroy(inst, 2)
						KKR_IF_MISC:InternalEliminate(inst, 3)
					end
				end)
			end
			table.clear(attackfilter)



			-- Finally void the caught deadly parts
			for i, part in DEADLYCAUGHT do
				KKR_IF_MISC:LockVoid(part)
			end
		end)
	end
	P1LoopEvents.AOECheck = KKR_MF:LoopConnections(TradLoop, 4)

	-- Inst
	local tab = {}
	local function instfunc(inst)
		if not P1_Activated then return end
		tab.AOECheck:Disconnect()
		tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
		KKR_MF:SN(2, function()
			pcall(function()
				if table.find(GetAttackFilter(), inst) ~= nil then return end
				if CSF:IsRobloxLocked(inst) then
					if table.find(DEADLYCAUGHT, inst) == nil then
						table.insert(DEADLYCAUGHT, inst)
					end
					KKR_IF_MISC:LockVoid(inst)
					return
				end
				local function collective()
					if inst:IsA("BasePart") and inst:IsA("Terrain") == false then
						if (KKR_MF:IsInKieruTable(inst, KIERUDATA) or table.find(CSF:Region(RegionCFrame, RegionSize, {inst}, Enum.RaycastFilterType.Whitelist), inst) or (CSF:PosInRotatedRegion(inst.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(inst, RegionCFrame, RegionSize))) then
							KKR_MF:HN(function()
								PartAttack(inst)
							end)
						end
						return true
					end
				end
				local DEADLYTARGET = CSF:HasLockedInst(inst)
				if DEADLYTARGET == true then
					KKR_MF:HN(function()
						KKR_IF_MISC:ForceVoid(inst)
						for i, ch in CSF:GetLockedInstances(inst) do
							KKR_IF_MISC:LockVoid(ch) -- Don't tag as deadlycaught since it'll get destroyed anyway
						end
						if collective() ~= true then
							KKR_MF:Execute(inst, LoopEvents, InstEvents, PriorityEvents)
							KKR_MF:Destroy(inst, 2)
							KKR_IF_MISC:InternalEliminate(inst, 3)
						end
					end)
				else
					collective()
				end
			end)
			KKR_MF:SN(1, TradLoop, false)
		end)
	end
	tab.AOECheck = workspace.DescendantAdded:Connect(instfunc)
	P1InstEvents[workspace] = tab

	function S5_P1_Activate(RCF, RS) -- start phase 1
		RegionCFrame = RCF
		RegionSize = RS

		P1_Activated = true
		AliveCreate()
	end
	function S5_P1_GetKieruData()
		return KIERUDATA
	end
	function S5_P1_Finish() -- finish phase 1 (switch to kieru)
		P1_Activated = false
		KKR_MF:Anima(LoopEvents, InstEvents, PriorityEvents)
		LoopEvents, InstEvents, PriorityEvents = {}, {}, {}

		AliveClear()
	end
	function S5_P1_UnVanish() -- for clearing banish events on unvanish
		KIERUDATA = {}
		KKR_MF:Anima(BANISHLoopEvents, BANISHInstEvents, BANISHPriorityEvents)
		BANISHLoopEvents, BANISHInstEvents, BANISHPriorityEvents = {}, {}, {}
	end
	function S5_P1_StopAll() -- stopscript
		S5_P1_Finish()
		S5_P1_UnVanish()
		KKR_MF:Anima(P1LoopEvents, P1InstEvents)
	end
end

-- PHASE 2: DeadlyPersist
do
	local DP_Activated = false
	local DPLoopEvents, DPInstEvents = {}, {} -- for the main events
	local LoopEvents, InstEvents, PriorityEvents = {}, {}, {} -- for the attack events
	local DEADLYCAUGHT = {}
	local RegionCFrame, RegionSize
	-- Loop
	local DeadlyLoop = function()
		if not DP_Activated then return end
		KKR_MF:HN(function()
			local attackfilter = GetAttackFilter()

			-- Search through whole world for catchable deadly parts
			for i, part in CSF:Region(RegionCFrame, Vector3.one * 1500, attackfilter) do
				pcall(function()
					if CSF:IsRobloxLocked(part) and table.find(DEADLYCAUGHT, part) == nil then
						table.insert(DEADLYCAUGHT, part)
					end
				end)
			end

			local desc = workspace:GetDescendants()
			for i = #desc, 1, -1 do
				local inst = desc[i]
				pcall(function()
					if table.find(attackfilter, inst) ~= nil then return end
					local DEADLYTARGET = CSF:HasLockedInst(inst)
					if DEADLYTARGET == true then
						KKR_IF_MISC:ForceVoid(inst)
						for i, ch in CSF:GetLockedInstances(inst) do
							KKR_IF_MISC:LockVoid(ch) -- Don't tag as deadlycaught since it'll get destroyed anyway
						end
						KKR_MF:Execute(inst, LoopEvents, InstEvents, PriorityEvents)
						KKR_MF:Destroy(inst, 2)
						KKR_IF_MISC:InternalEliminate(inst, 3)
					end
				end)
			end

			-- Finally void the caught deadly parts
			for i, part in DEADLYCAUGHT do
				KKR_IF_MISC:LockVoid(part)
			end
			table.clear(attackfilter)
		end)
	end
	DPLoopEvents.PersistCheck = KKR_MF:LoopConnections(DeadlyLoop, 4)

	-- Inst
	local tab = {}
	local function instfunc(inst)
		if not DP_Activated then return end
		tab.PersistCheck:Disconnect()
		tab.PersistCheck = workspace.DescendantAdded:Connect(instfunc)
		KKR_MF:SN(2, function()
			pcall(function()
				if table.find(GetAttackFilter(), inst) ~= nil then return end
				if CSF:IsRobloxLocked(inst) then
					if table.find(DEADLYCAUGHT, inst) == nil then
						table.insert(DEADLYCAUGHT, inst)
					end
					KKR_IF_MISC:LockVoid(inst)
					return
				end
				if CSF:HasLockedInst(inst) then
					KKR_MF:HN(function()
						KKR_IF_MISC:ForceVoid(inst)
						for i, ch in CSF:GetLockedInstances(inst) do
							KKR_IF_MISC:LockVoid(ch) -- Don't tag as deadlycaught since it'll get destroyed anyway
						end
						KKR_MF:Execute(inst, LoopEvents, InstEvents, PriorityEvents)
						KKR_MF:Destroy(inst, 2)
						KKR_IF_MISC:InternalEliminate(inst, 3)
					end)
				end
			end)
			KKR_MF:SN(1, DeadlyLoop)
		end)
	end
	tab.PersistCheck = workspace.DescendantAdded:Connect(instfunc)
	DPInstEvents[workspace] = tab

	function S5_DP_Activate(RCF, RS)
		RegionCFrame = RCF
		RegionSize = RS

		DP_Activated = true
	end
	function S5_DP_UnVanish()
		DP_Activated = false

		DEADLYCAUGHT = {}
		KKR_MF:Anima(LoopEvents, InstEvents, PriorityEvents)
		LoopEvents, InstEvents, PriorityEvents = {}, {}, {}
	end
	function S5_DP_StopAll()
		S5_DP_UnVanish()
		KKR_MF:Anima(DPLoopEvents, DPInstEvents)
	end
end


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
		local RegionCFrame = currentcf * CFrame.new(0, (-3 * CHARACTERSCALE) + 150, 0)
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


		---------------- ATTACK ----------------

		-- Restart all persisting attacks and stuff
		KKR_MF:UnKieru()
		S5_P1_UnVanish()

		-- Effects first
		Kill3(RegionCFrame, RegionSize, RegionPos)
		Kill4(RegionPos)

		-- Later at Phase 2 switch
		---------------- VANISH EFFECT ----------------
		local function VANISHEFFECT(KIERUDATA)
			local attackfilter = GetAttackFilter()
			for i, part in ipairs(workspace:GetDescendants()) do -- EwDev optimized this by adding ipairs()
				pcall(function()
					if part:IsA("BasePart") and part:IsA("Terrain") == false and table.find(attackfilter, part) == nil and KKR_MF:IsInKieruTable(part, KIERUDATA) then
						EFFECT("VANISH", part.Position, part.Size)
					end
				end)
			end
			table.clear(attackfilter)
		end



		-- PHASE 1
		S5_P1_Activate(RegionCFrame, RegionSize)

		-- Alive effect
		do
			AliveCreate()
			local function AliveCheck()
				local caught = {}
				local attackfilter = GetAttackFilter()
				local KIERUDATA = S5_P1_GetKieruData()
				local RegionCaught = CSF:Region(RegionCFrame, RegionSize, attackfilter)
				for i, part in RegionCaught do
					table.clear(attackfilter)
					return 1
				end

				-- Search through whole world for catchable deadly parts
				local RegionCaught2 = CSF:Region(RegionCFrame, Vector3.one * 1500, attackfilter)
				for i, part in RegionCaught2 do
					if CSF:IsRobloxLocked(part) then
						table.clear(attackfilter)
						return 1
					end
				end

				local desc = workspace:GetDescendants()
				for i = #desc, 1, -1 do
					local inst = desc[i]
					local found = false
					pcall(function()
						if table.find(attackfilter, inst) ~= nil then return end
						local DEADLYTARGET = CSF:HasLockedInst(inst)
						if DEADLYTARGET == true then
							found = true table.clear(attackfilter) return
						elseif inst:IsA("BasePart") then
							if inst:IsA("Terrain") == false and table.find(caught, inst) == nil and (KKR_MF:IsInKieruTable(inst, KIERUDATA) or CSF:PosInRotatedRegion(inst.Position, RegionCFrame, RegionSize) or CSF:PartInRotatedRegion(inst, RegionCFrame, RegionSize)) then
								found = true table.clear(attackfilter) return
							end
						end
					end)
					if found then table.clear(attackfilter) return 1 end
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
					checkEvent:Disconnect() return
				end
				if checkMode == 2 then
					KKR_MF:SN(10, pcall, function()
						AliveUpdate(AliveCheck())
					end)
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
				S5_P1_Finish()
				local KIERUDATA = S5_P1_GetKieruData()
				endcheck:Disconnect()
				task.delay(0.05, function()
					pcall(VANISHEFFECT, KIERUDATA)
					for i, Data in KIERUDATA do
						KKR_MF:AddKieruData(Data)
					end

					-- PHASE 2 (Kieru + DeadlyPersist)
					S5_DP_Activate(RegionCFrame, RegionSize)
				end)
			end
		end)
		task.wait(AttackDuration + 0.75)

	end,
	}) end, true, false)

-- UnVanish everything (clear all events)
local UNVANISH_Debounces = {"S1", "S2", "S3", "S4", "S5"}
function UNVANISH()
	KKR_MF:Anima(nil, nil, SPECIAL_Events.S1.PriorityEvents)
	SPECIAL_Events.S1.PriorityEvents = {}
	SPECIAL_Events.S1.TARGETS = {}

	KKR_MF:Anima(nil, nil, SPECIAL_Events.S2.PriorityEvents)
	SPECIAL_Events.S2.PriorityEvents = {}
	SPECIAL_Events.S2.TARGETS = {}

	KKR_MF:Anima(nil, nil, SPECIAL_Events.S3.PriorityEvents)
	SPECIAL_Events.S3.PriorityEvents = {}
	SPECIAL_Events.S3.TARGETS = {}

	KKR_MF:Anima(nil, nil, SPECIAL_Events.S4.PriorityEvents)
	SPECIAL_Events.S4.PriorityEvents = {}
	SPECIAL_Events.S4.TARGETS = {}

	KKR_MF:UnKieru()
	S5_P1_UnVanish()
	S5_DP_UnVanish()
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














print("> [WLW] Actions loaded. \n] -")



--[[ ----------------------------------

			-- PASSIVES --

---------------------------------- ]]--

print("- [\n> [WLW] Loading passives...")

---------------- DARK TRAILS ----------------
local DarkTrailTime = os.clock()
local DARKTRAILLOOP = heartbeat:Connect(function()
	if os.clock() - DarkTrailTime < SETTINGS.DarkTrailDelay then return end
	if moving == false then return end
	DarkTrailTime = os.clock()
	local parts = {}
	local models = {
		ADMchar:GetCloneInst(origchar), ADMmhead:GetCloneInst(origmhead), ADMmbody:GetCloneInst(origmbody),
	}
	if BroomActivated == true then
		table.insert(models, ADMbroom:GetCloneInst(origbroom))
	end
	for i, model in models do
		for i, part in model:GetDescendants() do
			if part:IsA("BasePart") and part ~= ADMchar:GetCloneInst(orighrp) then
				table.insert(parts, part)
			end
		end
	end
	EFFECT("DARKTRAIL", parts)
end)

------------------------------------------------------------------------------------------------------------------------------------------

---------------- Balls lmao ----------------
CFRAMES.BALLS = {}

local origballs1 = MODELS.BALLS1:Clone()
local ADMballs1 = YUREI:Initialize(origballs1, origballs1.PrimaryPart, workspace)
local origballs2 = MODELS.BALLS2:Clone()
local ADMballs2 = YUREI:Initialize(origballs2, origballs2.PrimaryPart, workspace)
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


-- main balls loop
local BALLS_SineVal = 0
local BALLS_RainbowTime = os.clock()
local BALLS_LOOP = runs.Heartbeat:Connect(function()
	BALLS_SineVal = BALLS_SineVal + 1
	if BALLS_SineVal >= 360 * 3 then BALLS_SineVal = 0 + (BALLS_SineVal-(360 * 3)) end


	-- CFRAMES
	local CFBALLS = CFRAMES.BALLS
	local torsooffset = JCFrtj.CharacterOffset * JCFrtj.CurrentOffset
	ADMballs1:SetRecordedMCF(CFrame.new((currentcf * torsooffset).Position))
	ADMballs2:SetRecordedMCF(CFrame.new((currentcf * torsooffset).Position))

	-- first group
	for i, origball in BALLS_1 do
		local anglespacing = (mrad(BALLS_SineVal * 3) - mrad(33.75 * (i-1)))
		local angle = CFrame.Angles(anglespacing/9, anglespacing, 0)
		local posoffset = angle * CFrame.new(0, 0, -SETTINGS.BallsRadius)

		local finaloffset = posoffset * CFrame.Angles(0, mrad(BALLS_SineVal) * 4, 0)
		ADMballs1:SetRecordedProperty(origball, "CFrameOffset", finaloffset)
		CFBALLS[origball.Name] = ADMballs1:GetRecordedProperty(origball, "CFrameFINAL")
	end

	-- second group
	for i, origball in BALLS_2 do
		local anglespacing = -(mrad(BALLS_SineVal * 3) - mrad(33.75 * (i-1)))
		local angle = CFrame.Angles(anglespacing/9 + mrad(180), anglespacing, 0)
		local posoffset = (angle * CFrame.new(0, 0, -SETTINGS.BallsRadius))

		local finaloffset = posoffset * CFrame.Angles(0, -mrad(BALLS_SineVal) * 4, 0)
		ADMballs2:SetRecordedProperty(origball, "CFrameOffset", finaloffset)
		CFBALLS[origball.Name] = ADMballs2:GetRecordedProperty(origball, "CFrameFINAL")
	end




	-- RAINBOW
	if os.clock() - BALLS_RainbowTime >= 0.075 then
		BALLS_RainbowTime = os.clock()
		BALLS_RainbowColIndex = BALLS_RainbowColIndex + 1
		if BALLS_RainbowColIndex > #BALLS_RainbowColorsT then BALLS_RainbowColIndex = 1 end

		local color = BALLS_RainbowColors[BALLS_RainbowColIndex]
		local colorT = BALLS_RainbowColorsT[BALLS_RainbowColIndex]

		ADMballs2:SetRecordedProperty(origrainbowball, "Color", color)
		for i, texture in origrainbowball:GetDescendants() do
			if texture:IsA("Texture") then
				ADMballs2:SetRecordedProperty(texture, "Color3", colorT)
			end
		end
	end
end)


-- balls attack
function BALLATTACK(ADMball, origball, targethum, targetpos)
	targethum:TakeDamage(SETTINGS.BallsAttackDamage)

	local color = ADMball:GetRecordedProperty(origball, "Color")
	EFFECT("BALL_Attack", origball.Name, targetpos, color)
end
local BALLS_ATTACKLOOP = heartbeat:Connect(function()
	local range = SETTINGS.BallsAttackRange
	local targetdist = math.huge
	local targetpos
	local targethum

	for i, part in CSF:Region(currentcf, Vector3.one * range, GetAttackFilter()) do
		pcall(function()
			if part:IsA("BasePart") and part:IsA("Terrain") == false then
				local hum = part.Parent:FindFirstChildWhichIsA("Humanoid")
				if hum == nil or hum.Health <= 0 then return end

				local pos = part.Position
				local dist = (part.Position-currentcf.Position).Magnitude
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
			local cball = ADMballs1:GetCloneInst(origball)
			local pos = cball.Position
			if cball.Parent ~= ADMballs1:GetCloneInst(origballs1) or (targetpos-pos).Magnitude > SETTINGS.BallsAttackRange + SETTINGS.BallsRadius then return end -- don't fire if destroyed/voided
			if rnd:NextNumber(0, 100) <= 100 * SETTINGS.BallsAttackChance and rnd:NextInteger(1, 60) == 1 then -- randomization happens 60 frames per second so we must lower chance
				BALLATTACK(ADMballs1, origball, targethum, targetpos)
			end
		end)
	end

	-- second group
	for i, origball in BALLS_2 do
		pcall(function()
			local cball = ADMballs2:GetCloneInst(origball)
			local pos = cball.Position
			if cball.Parent ~= ADMballs2:GetCloneInst(origballs2) or (targetpos-pos).Magnitude > SETTINGS.BallsAttackRange + SETTINGS.BallsRadius then return end -- don't fire if destroyed/voided
			if rnd:NextNumber(0, 100) <= 100 * SETTINGS.BallsAttackChance and rnd:NextInteger(1, 60) == 1 then -- randomization happens 60 frames per second so we must lower chance
				BALLATTACK(ADMballs2, origball, targethum, targetpos)
			end
		end)
	end
end)








------------------------------------------------------------------------------------------------------------------------------------------

---------------- FAKE HEALTH ----------------
-- here comes the spaghetti
local CurrentHealth = 0
local MaxHealth = 100
local HealthCheapEnabled = true -- mugen cheapie hp going up and down effect lol
local HealthCheapBorder = MaxHealth - SETTINGS.HealthCheapOffset

local HealthModel = MODELS["Wicked Law's Witch?"]:Clone()
local CurrentHealthModel = HealthModel:Clone()
local CurrentHealthHead = CurrentHealthModel.Head
local CurrentHealthHum = CurrentHealthModel.Humanoid
local CurrentHealthName = "Wicked Law's Witch [LV."..SETTINGS.YUREI_LEVEL.."]"
CurrentHealthHum.DisplayName = CurrentHealthName
CurrentHealthHum.Health = CurrentHealth
CurrentHealthHum.MaxHealth = MaxHealth

CurrentHealthHum:GetPropertyChangedSignal("Health"):Connect(function()
	CurrentHealth = CurrentHealthHum.Health
end)
CurrentHealthHum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
	CurrentHealthHum.MaxHealth = MaxHealth
end)

local HEALTHLOOP = heartbeat:Connect(function()
	if HealthCheapEnabled == true then
		if CurrentHealth == HealthCheapBorder then
			CurrentHealth = HealthCheapBorder - rnd:NextNumber(10, 20)
		else
			CurrentHealth = math.min(HealthCheapBorder, CurrentHealthHum.Health + rnd:NextNumber(1, 5))
		end
	else
		CurrentHealth = math.min(MaxHealth, CurrentHealthHum.Health + rnd:NextNumber(0.5, 2))
	end
	local cf = currentcf + Vector3.new(0, 1.5 * CHARACTERSCALE, 0)






	HealthModel.Head.CFrame = cf
	if CSF:IsRobloxLocked(CurrentHealthModel) or CSF:IsRobloxLocked(CurrentHealthHead) or CSF:IsRobloxLocked(CurrentHealthHum)
		or CurrentHealthModel:IsDescendantOf(workspace) == false or CurrentHealthHead.Parent ~= CurrentHealthModel or CurrentHealthHum.Parent ~= CurrentHealthModel then

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

		CurrentHealthHum:GetPropertyChangedSignal("Health"):Connect(function()
			CurrentHealth = CurrentHealthHum.Health
		end)
		CurrentHealthHum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
			CurrentHealthHum.MaxHealth = MaxHealth
		end)
		CurrentHealthModel.Parent = workspace
	end
	CurrentHealthHead.CFrame = cf
	CurrentHealthHum.DisplayName = CurrentHealthName
	CurrentHealthHum.Health = CurrentHealth
end)




print("> [WLW] Passives loaded. \n] -")


--[[ ----------------------------------

			-- POST-SETUP --

---------------------------------- ]]--



print("- [\n> [WLW] Initializing Post-Setup...")

---------------- FILTERS ----------------
-- For ignoring own character/etc. in Region/Raycast detection

function GetCharFilter()
	local charfilter = {CurrentHealthHead, EFFECTSCONTAINER}
	if(EFFECTSCONTAINER)then
		for i, v in next, EFFECTSCONTAINER:GetDescendants() do
			if(v:IsA("BasePart"))then
				table.insert(charfilter, v)
			end
		end
	end
	for origmodel, ADMData in YUREI.ADModels do
		for i, originst in ADMData.OrigModel:GetDescendants() do
			if originst:IsA("BasePart") then
				table.insert(charfilter, ADMData:GetCloneInst(originst))
			end
		end
	end
	return charfilter
end
function GetAttackFilter()
	local attackfilter = {CurrentHealthHead, currentfloor, EFFECTSCONTAINER}
	if(EFFECTSCONTAINER)then
		for i, v in next, EFFECTSCONTAINER:GetDescendants() do
			if(v:IsA("BasePart"))then
				table.insert(attackfilter, v)
			end
		end
	end
	for origmodel, ADMData in YUREI.ADModels do
		for i, originst in ADMData.OrigModel:GetDescendants() do
			if originst:IsA("BasePart") then
				table.insert(attackfilter, ADMData:GetCloneInst(originst))
			end
		end
	end
	return attackfilter
end


local OwnerLSValues = script.ScriptValues

--------------------------------------------------------------------------------
---------------- REPLICATION ----------------
-- Update char and replicate all cframes
local ReplicationLoop = heartbeat:Connect(function()
	OwnerLSValues.STARTCF.Value = CFRAMES.CHARACTER.Character
	Remote:FireAllClients("UPDATECFRAMES", CFRAMES)
	Remote:FireAllClients("UPDATECHARACTER", ADMchar:GetCloneInst(origchar), CHARACTERSCALE)
end)


--------------------------------------------------------------------------------
---------------- CHARACTER-RELATED ----------------
RemoteRequests.MOVEMENTFORCESTOP = function()
	movementforcestop = not movementforcestop
	UpdateVelocity({
		Y = 0
	})
	UpdateForce(Vector3.zero)
end
RemoteRequests.REFIT = function()
	for origmodel, ADMData in YUREI.ADModels do
		ADMData:Refit()
	end
	UpdateFloor()


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
	CurrentHealthHum.Health = CurrentHealth
	CurrentHealthHum.MaxHealth = MaxHealth

	CurrentHealthHum:GetPropertyChangedSignal("Health"):Connect(function()
		CurrentHealth = CurrentHealthHum.Health
	end)
	CurrentHealthHum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
		CurrentHealthHum.MaxHealth = MaxHealth
	end)
	CurrentHealthModel.Parent = workspace
end
RemoteRequests.NO_BALLS = function()
	pcall(game.Destroy, ADMballs1:GetCloneInst(origballs1))
	pcall(game.Destroy, ADMballs2:GetCloneInst(origballs2))
end

RemoteRequests.ORIGIN = function()
	currentcf = CFrame.new(0, 5 + (1.5 * CHARACTERSCALE), 0)
	UpdateVelocity({
		Y = 0
	})
	UpdateForce(Vector3.zero)
end


--------------------------------------------------------------------------------
---------------- ANTIDEATH ----------------
-- Level upgrade
RemoteRequests.YUREI_LEVEL = function(level)
	if tonumber(level) == nil then return end
	SETTINGS.YUREI_LEVEL = tonumber(level)
	if SETTINGS.YUREI_LEVEL > 4 then
		SETTINGS.YUREI_LEVEL = 1
	end
	for origmodel, ADMData in ADMCharacters do
		ADMData:UpdateSetting("LEVEL", SETTINGS.YUREI_LEVEL)
	end
	if BroomActivated then
		ADMbroom:UpdateSetting("LEVEL", SETTINGS.YUREI_LEVEL)
	end
	if HakeroActivated then
		ADMhakero:UpdateSetting("LEVEL", SETTINGS.YUREI_LEVEL)
	end

	CurrentHealthName = "Wicked Law's Witch [LV."..SETTINGS.YUREI_LEVEL.."]"
	EFFECT("YUREI_Level", SETTINGS.YUREI_LEVEL)
end

RemoteRequests.YUREI_WM = function()
	SETTINGS.YUREI_WorldModelEnabled = not SETTINGS.YUREI_WorldModelEnabled
	for origmodel, ADMData in ADMCharacters do
		ADMData:UpdateSetting("WorldModelEnabled", SETTINGS.YUREI_WorldModelEnabled)
	end

	EFFECT("YUREI_WorldModelEnabled", SETTINGS.YUREI_WorldModelEnabled)
end

RemoteRequests.YUREI_FS = function()
	SETTINGS.YUREI_FailsafeEnabled = not SETTINGS.YUREI_FailsafeEnabled
	for origmodel, ADMData in ADMCharacters do
		ADMData:UpdateSetting("FailsafeEnabled", SETTINGS.YUREI_FailsafeEnabled)
	end

	EFFECT("YUREI_FailsafeEnabled", SETTINGS.YUREI_FailsafeEnabled)
end


--------------------------------------------------------------------------------
---------------- MUSIC ----------------
local MUSIC_Enabled = true
RemoteRequests.TOGGLEMUSIC = function()
	MUSIC_Enabled = not MUSIC_Enabled
	TOGGLEMUSIC(MUSIC_Enabled)
end

---------------- IDLESWITCH ----------------
RemoteRequests.IDLESWITCH = function()
	if DefaultAnimsEnabled == true then
		if idlemode == 1 then idlemode = 2 else idlemode = 1 end
		if CurrentAnimation.Name ~= CurrentCharacterState then
			SetDefaultAnim("IdleGround"..idlemode, "IdleGround"..idlemode) -- re-update character animations
		end
	end
end

---------------- TAUNT ----------------
RemoteRequests.TAUNT = function()
	EFFECT("VOCAL", "12")
	EFFECT("CHAT", "俺 の 的 和 お前 で わない。")
end




------------------------------------------------------------------------------------------------------------------------------------------
---------------- COUNTER ----------------
local COUNTER_List = {}
local COUNTER_ListEnabled = false -- will record all attacks while counter charge is active
local COUNTER_AttackedThisFrame = false
local COUNTER_Time = os.clock() - 69

function COUNTER(ADMData, originst, cinst, ATTACK, VALUE)
	COUNTER_AttackedThisFrame = true
	local FULLNAME = (ATTACK or "undefined"):lower()
	pcall(function()
		if ATTACK:find("CFrame") ~= nil then
			if (ADMData:GetRecordedProperty(originst, "CFrameFINAL").Position-VALUE.Position).Magnitude > 3000 then
				FULLNAME = FULLNAME.." (VOID)"
			end
		elseif ATTACK == "ANCESTRY" or ATTACK == "DESCENDANT" then
			local inst
			if VALUE == nil then
				inst = "nil"
			else
				inst = VALUE.ClassName:upper()
			end
			FULLNAME = FULLNAME.." ("..inst..")"
		end
	end)


	if COUNTER_ListEnabled == true then -- if true will record attacks
		if table.find(COUNTER_List, FULLNAME) == nil then -- no duplicates
			table.insert(COUNTER_List, FULLNAME)
		end
	end
	if os.clock() - COUNTER_Time < SETTINGS.CounterDelay then return end
	COUNTER_Time = os.clock()
	COUNTERDEBOUNCE = true
	COUNTER_List = {}
	COUNTER_ListEnabled = true

	movementenabled = false
	flymode = false
	DefaultAnimsEnabled = false

	if SETTINGS.YUREI_WorldModelEnabled == true then
		table.insert(COUNTER_List, "anti_rrt_bypass")
	end
	table.insert(COUNTER_List, FULLNAME)

	-- Tween to 0
	HealthCheapEnabled = false
	pcall(function()
		local newhealth = CurrentHealth
		local lockhealthevent = CurrentHealthHum:GetPropertyChangedSignal("Health"):Connect(function()
			CurrentHealthHum.Health = newhealth
		end)
		task.delay(0.6, function()
			lockhealthevent:Disconnect()
		end)
		CSE:TweenCustom(newhealth, 4, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), function(val)
			newhealth = val
			CurrentHealthHum.Health = newhealth
		end)
	end)
	EFFECT("BROOM_Sparkles", false)

	AnimationPlay("Counter")
	EFFECT("COUNTER_Charge")

	task.wait()
	-- Part 2 - end counterlist recording (show wlw portrait gui first)
	task.delay(0.2, function()
		EFFECT("COUNTER_Release", COUNTER_List)
		COUNTER_ListEnabled = false

		-- Deadly Alert if the funny instance is involved (speker) just like special attacks
		for i, FULLNAME in COUNTER_List do
			if FULLNAME:lower():find("robloxlocked") then
				EFFECT("DEADLYALERT")
				break
			end
		end
	end)

	-- Ending (Sync with release effect and portrait gui)
	task.delay(0.6, function()
		coroutine.wrap(function()
			if heartbeat:Wait() <= 1.25 then -- if not lagging
				UpdateForce(currentlook * -12, 0.45)
			end
		end)()

		HealthCheapEnabled = true
		pcall(function()
			CurrentHealthHum.Health = 5
		end)

		-- Counter Voice
		task.delay(rnd:NextNumber(0, 0.65), function()
			local soundname
			if rnd:NextInteger(1, 2) == 1 then
				soundname = "MAYCOUNTER"
			else
				soundname = "ELPHELTCOUNTER"
			end
			EFFECT("VOCAL", soundname)
		end)
	end)


	task.delay(0.95, function()
		COUNTERDEBOUNCE = false

		movementenabled = true
		DefaultAnimsEnabled = true
		if CurrentAnimation.Name ~= CurrentCharacterState then
			SetDefaultAnim(CurrentCharacterState, CurrentCharacterState) -- re-update character animations
		end

		ACTIONRESET()
	end)
	task.spawn(error, "Counter.")
end
ADMchar:SetAttackedFunc(COUNTER)
ADMmhead:SetAttackedFunc(COUNTER)
ADMmbody:SetAttackedFunc(COUNTER)
local CounterResetOnAction = ActionChanged.Event:Connect(function(last, current)
	if current == nil or current == "RUNMODE" or current == "JUMP" or current == "FLYMODE" or current == "STASIS" then return end
	COUNTER_Time = os.clock() - 69
end)

local OutputQuoteCheck = heartbeat:Connect(function()
	if COUNTER_AttackedThisFrame == false then return end
	COUNTER_AttackedThisFrame = false

	local OQ = CSF:PickRandomFromTable(SETTINGS.OutputQuotes)
	if rnd:NextInteger(1, 2) == 1 then
		warn(OQ)
	else
		task.delay(0, warn, OQ)
	end
end)	


--------------------------------------------------------------------------------
---------------- SCRIPT FIX ----------------
-- Incase script times out for whatever reason in the middle of an action/other problems
function FIX()
	movementenabled = true
	movementforcestop = false
	COUNTERDEBOUNCE = false
	ABSORBER_Debounce = false
	currentheadangle = CFrame.identity

	ACTIONRESET()
	for Name, ActionData in ACTIONS do
		ActionData.RunningInstances = {}
	end

	DeadlyAlertActivated = false
	DeadlyAlertInstances = {}
	STASIS_Mode = 0
	STASIS_DisableQueue = true
	EFFECT("STASIS_END")

	HealthCheapEnabled = true
	BALLS_SineVal = 0

	DefaultAnimsEnabled = true
	SetDefaultAnim("IdleGround"..idlemode, "IdleGround"..idlemode)
	AnimationPlay("IdleGround"..idlemode)

	pcall(function()
		Remote:Destroy()
	end)
	for i, part in RemoteBlackmail do
		pcall(function()
			part:Destroy()
		end)
	end
	RemoteBlackmail = {}
	Remote = Instance.new("RemoteEvent")
	Remote.Name = RemoteName
	Remote.Parent = reps
	Remote.OnServerEvent:Connect(OnServerEvent)

	for origmodel, ADMData in YUREI.ADModels do
		ADMData:Refit()
	end
	UpdateFloor()

	UNVANISH()

	COUNTER_Time = os.clock() - 69
	COUNTER()
end


print("> [WLW] Post-Setup initialized. \n] -")

--[[ ----------------------------------

			-- COMMANDS --

---------------------------------- ]]--
print("- [\n> [WLW] Loading commands...")


local CommandPrefix = "`wlw`"
local CommandSep = "`"
local Commands = {}
local function CommandFunc(msg)
	if msg:sub(1, #CommandPrefix) == CommandPrefix then
		local args = msg:sub(#CommandPrefix + 1, #msg):split(CommandSep)
		local CommandType = table.remove(args, 1)
		if Commands[CommandType] then
			Commands[CommandType](unpack(args))
		end
	end
end
local Chatted_COMMAND = plr.Chatted:Connect(CommandFunc)



---------------- COMMANDS ----------------

Commands.UnV = function() ACTIONPERFORM("UNVANISH") end
Commands.fix = FIX


print("> [WLW] Commands loaded. \n] -")

--[[ ----------------------------------

		-- LOCALSCRIPTS --

---------------------------------- ]]--


print("- [\n> [WLW] Initializing localscripts...")

local OwnerLS = nil 
task.spawn(function() OwnerLS = NLS([==[
script:WaitForChild("ScriptValues")
--[[ ----------------------------------

		-- OWNER SCRIPT --

---------------------------------- ]]--
--[[
	For:
		- Controls
		- CFrame Data updates
]]




task.wait()
script.Parent = nil


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
local sss = game:GetService("ServerScriptService")
local uis = game:GetService("UserInputService")

local heartbeat = runs.Heartbeat
local stepped = runs.Stepped
local renderstepped = runs.RenderStepped



--[[ ----------------------------------

		-- SCRIPT INITIAL --

---------------------------------- ]]--
local plr = players.LocalPlayer
local mouse = plr:GetMouse()

local ScriptValues = script.ScriptValues
local GameProcessed = false




--[[ ----------------------------------

		-- REMOTE SETUP --

---------------------------------- ]]--

local RemoteName = ScriptValues.RemoteName.Value
local Remote = Instance.new("RemoteEvent")
local RemoteCE = nil

local RemoteRequests = {}
local function OnClientEvent(RequestType, ...)
	if RemoteRequests[RequestType] then
		RemoteRequests[RequestType](...)
	end
end

-- REMOTE CHECKER
local RemoteCheck = heartbeat:Connect(function()
	for i, remote in next, reps:GetChildren() do
		pcall(function()
			if remote:IsA("RemoteEvent") and remote.Name == RemoteName and remote ~= Remote then

				-- New Remote
				if RemoteCE then
					RemoteCE:Disconnect()
				end

				Remote = remote
				RemoteCE = Remote.OnClientEvent:Connect(OnClientEvent)
			end
		end)
	end
end)



--[[ ----------------------------------

		-- CHARACTER MOVEMENT --

---------------------------------- ]]--

local currentcf = ScriptValues.STARTCF.Value
local CHARACTERSCALE = ScriptValues.CHARACTERSCALE.Value

local part = Instance.new("Part")
part:Destroy()
part.Anchored = true
part.CFrame = currentcf

local MovementFPSCapper = os.clock()
local CharacterMovementLocal = heartbeat:Connect(function()
	if os.clock() - MovementFPSCapper < 1/60 then return end
	MovementFPSCapper = os.clock()
	if GameProcessed == false then
		local cam = workspace.CurrentCamera
		cam.CameraType = Enum.CameraType.Custom
		cam.CameraSubject = part

		local camcf = cam.CFrame
		local camlook = camcf.LookVector
		local lastpos = currentcf.Position

		local cf = CFrame.identity

		if uis:IsKeyDown(Enum.KeyCode.W) then
			cf = cf * CFrame.new(0, 0, -1)
		end
		if uis:IsKeyDown(Enum.KeyCode.A) then
			cf = cf * CFrame.new(-1, 0, 0)
		end
		if uis:IsKeyDown(Enum.KeyCode.S) then
			cf = cf * CFrame.new(0, 0, 1)
		end
		if uis:IsKeyDown(Enum.KeyCode.D) then
			cf = cf * CFrame.new(1, 0, 0)
		end


		-- For updating currentlook and currentdir
		Remote:FireServer("UPDATEMOVEMENTLOCAL", camlook, cf)
	end
end)


-- Update other cframes
local MiscFPSCapper = os.clock()
local UpdateMisc = heartbeat:Connect(function()
	if os.clock() - MiscFPSCapper < 1/60 then return end
	MiscFPSCapper = os.clock()
	Remote:FireServer("UPDATEMOUSE", mouse.Hit)
	
	local cam = workspace.CurrentCamera
	Remote:FireServer("UPDATECAMERA", {
		CFrame = cam.CFrame,
		Focus = cam.Focus,
	})
end)

RemoteRequests.UPDATECFRAMES = function(cftable)
	local cframe = cftable.CHARACTER.Character + Vector3.new(0, 1.5 * CHARACTERSCALE, 0)
	currentcf = cframe
	ts:Create(part, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		CFrame = cframe
	}):Play()
end






--[[ ----------------------------------

			-- CONTROLS --

---------------------------------- ]]--
-- Controls Arguments
--[[
	ControlsData = {
		[KeyCode or UserInputType.MouseButtonX] = {
			InputBegan = function
			InputEnded = function
			InputHold = function
		}
	}
	
]]

---------------- SETUP ----------------
local function RemoteSend(...)
	Remote:FireServer(...)
end
local ControlsData = {
	[Enum.KeyCode.C] = {
		InputBegan = function()
			RemoteSend("MOVEMENTFORCESTOP")
		end,
	},
	[Enum.KeyCode.N] = {
		InputBegan = function()
			RemoteSend("REFIT")
		end,
	},
	[Enum.KeyCode.B] = {
		InputBegan = function()
			RemoteSend("NO_BALLS")
		end,
	},
	[Enum.KeyCode.X] = {
		InputBegan = function()
			RemoteSend("ORIGIN")
		end,
	},
	
	[Enum.KeyCode.KeypadOne] = {
		InputBegan = function()
			RemoteSend("YUREI_LEVEL", 1)
		end,
	},
	[Enum.KeyCode.KeypadTwo] = {
		InputBegan = function()
			RemoteSend("YUREI_LEVEL", 2)
		end,
	},
	[Enum.KeyCode.KeypadThree] = {
		InputBegan = function()
			RemoteSend("YUREI_LEVEL", 3)
		end,
	},
	[Enum.KeyCode.KeypadFour] = {
		InputBegan = function()
			RemoteSend("YUREI_LEVEL", 4)
		end,
	},
	[Enum.KeyCode.KeypadFive] = {
		InputBegan = function()
			RemoteSend("YUREI_WM")
		end,
	},
	[Enum.KeyCode.KeypadSix] = {
		InputBegan = function()
			RemoteSend("YUREI_FS")
		end,
	},
	[Enum.KeyCode.KeypadSeven] = {
		InputBegan = function()
			RemoteSend("TOGGLEMUSIC")
		end,
	},
	[Enum.KeyCode.KeypadEight] = {
		InputBegan = function()
			RemoteSend("IDLESWITCH")
		end,
	},
	[Enum.KeyCode.KeypadNine] = {
		InputBegan = function()
			RemoteSend("TAUNT")
		end,
	},
	[Enum.KeyCode.KeypadMinus] = {
		InputBegan = function()
			RemoteSend("FIX")
		end,
	},
	
	[Enum.KeyCode.LeftControl] = {
		InputBegan = function()
			RemoteSend("ACTION", "RUNMODE")
		end,
	},
	[Enum.KeyCode.Space] = {
		InputBegan = function()
			RemoteSend("ACTION", "JUMP")
			RemoteSend("ACTION", "STASIS_SWITCH")
		end,
	},
	[Enum.KeyCode.F] = {
		InputBegan = function()
			RemoteSend("ACTION", "FLYMODE")
		end,
	},
	
	[Enum.KeyCode.LeftShift] = {
		InputBegan = function()
			RemoteSend("ACTION", "DASH")
		end,
	},
	[Enum.KeyCode.E] = {
		InputBegan = function()
			RemoteSend("ACTION", "N1")
		end,
	},
	[Enum.KeyCode.R] = {
		InputBegan = function()
			RemoteSend("ACTION", "N2")
		end,
	},
	[Enum.KeyCode.T] = {
		InputBegan = function()
			RemoteSend("ACTION", "N3")
		end,
	},
	[Enum.KeyCode.Y] = {
		InputBegan = function()
			RemoteSend("ACTION", "N4")
		end,
	},
	
	[Enum.KeyCode.H] = {
		InputBegan = function()
			RemoteSend("ACTION", "ABSORBER")
		end,
	},
	[Enum.KeyCode.Q] = {
		InputBegan = function()
			RemoteSend("ACTION", "LASER")
		end,
	},
	[Enum.KeyCode.G] = {
		InputBegan = function()
			RemoteSend("ACTION", "STASIS")
		end,
		InputEnded = function()
			RemoteSend("ACTION", "STASIS_END")
		end,
	},
	[Enum.KeyCode.One] = {
		InputBegan = function()
			RemoteSend("ACTION", "S1")
		end,
	},
	[Enum.KeyCode.Two] = {
		InputBegan = function()
			RemoteSend("ACTION", "S2")
		end,
	},
	[Enum.KeyCode.Three] = {
		InputBegan = function()
			RemoteSend("ACTION", "S3")
		end,
	},
	[Enum.KeyCode.Four] = {
		InputBegan = function()
			RemoteSend("ACTION", "S4")
		end,
	},
	[Enum.KeyCode.Five] = {
		InputBegan = function()
			RemoteSend("ACTION", "S5")
		end,
	},
	[Enum.KeyCode.V] = {
		InputBegan = function()
			RemoteSend("ACTION", "UNVANISH")
		end,
	},
	[Enum.KeyCode.KeypadZero] = {
		InputBegan = function()
			RemoteSend("STOPSCRIPT") -- was "DIE", but fixed it - EwDev
		end,
	},
}

---------------- DETECTIONS ----------------
local InputBegan = uis.InputBegan:Connect(function(input, gp)
	GameProcessed = gp
	if gp == false then
		local inputdata
		if input.UserInputType == Enum.UserInputType.Keyboard then
			inputdata = ControlsData[input.KeyCode]
		else
			inputdata = ControlsData[input.UserInputType]
		end
		if inputdata and inputdata.InputBegan then
			inputdata.InputBegan()
		end
	end
end)
local InputEnded = uis.InputEnded:Connect(function(input, gp)
	GameProcessed = gp
	if gp == false then
		local inputdata
		if input.UserInputType == Enum.UserInputType.Keyboard then
			inputdata = ControlsData[input.KeyCode]
		else
			inputdata = ControlsData[input.UserInputType]
		end
		if inputdata and inputdata.InputEnded then
			inputdata.InputEnded()
		end
	end
end)
local InputHold = heartbeat:Connect(function()
	if GameProcessed == false then
		for input, inputdata in next, ControlsData do
			local etype = input.EnumType

			local held
			if etype == Enum.KeyCode then
				held = uis:IsKeyDown(input)
			else
				if input == Enum.UserInputType.MouseButton1 or input == Enum.UserInputType.MouseButton2 or input == Enum.UserInputType.MouseButton3 then
					held = uis:IsMouseButtonPressed(input)
				end
			end
			if held == true and inputdata.InputHold then
				inputdata.InputHold()
			end
		end
	end
end)








--[[ ----------------------------------

			-- FINAL --

---------------------------------- ]]--
local function StopScript()
	RemoteCheck:Disconnect()
	RemoteCE:Disconnect()
	
	InputBegan:Disconnect()
	InputEnded:Disconnect()
	InputHold:Disconnect()
	
	
	CharacterMovementLocal:Disconnect()
	UpdateMisc:Disconnect()
end
RemoteRequests.STOPSCRIPT = StopScript -- was "DIE", but fixed it - EwDev



plr.CameraMaxZoomDistance = 1000
]==], owner.PlayerGui)
end)

OwnerLSValues.RemoteName.Value = RemoteName
OwnerLSValues.STARTCF.Value = currentcf
OwnerLSValues.CHARACTERSCALE.Value = CHARACTERSCALE

task.delay(.5, function()
	OwnerLSValues.Parent = OwnerLS
end)

-- LOCALSCRIPT SETUP

-- Insert a folder into the playergui with a localscript inside it, and destroy the folder afterwards
-- This is to indirectly destroy the localscript without stopping its code from running (remains in nil)
-- The localscript itself also destroys itself in its code


-- LocalScript Insertion


print("> [WLW] Localscripts loaded. \n] -")

--[[ ----------------------------------

			-- FINAL --

---------------------------------- ]]--

print("- [\n> [WLW] Final Script Setup...")

-- PlayerAdded Detection
PlayerAdded = players.PlayerAdded:Connect(function(player)
	playergui = player:WaitForChild("PlayerGui")

	if player.UserId == userid then
		plr = player

		NoCharacterAdded:Disconnect()
		NoCharacterAdded2:Disconnect()
		NoCharacterAdded = plr.CharacterAdded:Connect(function(c)
			c:Destroy()
		end)
		NoCharacterAdded2 = heartbeat:Connect(function()
			if plr.Character then
				plr.Character:Destroy()
				plr.Character = nil
			end
		end)
		Chatted_COMMAND = plr.Chatted:Connect(CommandFunc)
	end
end)

function StopScript()
	Remote:FireAllClients("STOPSCRIPT")
	EFFECT("STOPSCRIPT")

	RemoteCheck:Disconnect()
	for i, part in RemoteBlackmail do
		pcall(function()
			part:Destroy()
		end)
	end
	pcall(function()
		deb:AddItem(Remote, 30)
	end)

	Chatted_COMMAND:Disconnect()
	PlayerAdded:Disconnect()




	NoCharacterAdded:Disconnect()
	NoCharacterAdded2:Disconnect()
	CharacterState:Destroy()
	CharacterMovement:Disconnect()
	DefaultAnims:Disconnect()
	SetCharCFramesLoop:Disconnect()
	ActionChanged:Destroy()
	CounterResetOnAction:Disconnect()
	OutputQuoteCheck:Disconnect()


	DARKTRAILLOOP:Disconnect()
	BALLS_LOOP:Disconnect()
	BALLS_ATTACKLOOP:Disconnect()
	HEALTHLOOP:Disconnect()
	pcall(function()
		CurrentHealthModel:Destroy()
	end)

	ReplicationLoop:Disconnect()

	KKR_MF:Anima(SPECIAL_Events.S1.LoopEvents, nil, SPECIAL_Events.S1.PriorityEvents)
	KKR_MF:Anima(SPECIAL_Events.S2.LoopEvents, nil, SPECIAL_Events.S2.PriorityEvents)
	KKR_MF:Anima(SPECIAL_Events.S3.LoopEvents, nil, SPECIAL_Events.S3.PriorityEvents)
	KKR_MF:Anima(SPECIAL_Events.S4.LoopEvents, nil, SPECIAL_Events.S4.PriorityEvents)
	UNVANISH()
	S5_P1_StopAll()
	S5_DP_StopAll()
	KKR_MF:StopAll()
	YUREI:StopAll()
	CSF.worldModelAdded:Disconnect()
	CSF.worldModelRemoved:Disconnect()
	task.cancel(CSF.worldModelLoop)

	task.wait(1)
	plr:LoadCharacter()
end
Commands.stopscript = StopScript
RemoteRequests.STOPSCRIPT = StopScript




--------------------------------------------------------------------
--------------------------------------------------------------------

SETCHARCFRAMES()
UpdateFloor()
SetDefaultAnim(CurrentCharacterState, CurrentCharacterState)
BroomSwitch(true)
HakeroSwitch(false)
for origmodel, ADMData in ADMCharacters do
	ADMData:UpdateSetting("LEVEL", SETTINGS.YUREI_LEVEL)
	ADMData:UpdateSetting("WorldModelEnabled", SETTINGS.YUREI_WorldModelEnabled)
	ADMData:UpdateSetting("FailsafeEnabled", SETTINGS.YUREI_FailsafeEnabled)
end
ADMbroom:UpdateSetting("LEVEL", 0)
ADMbroom:UpdateSetting("WorldModelEnabled", true)
ADMbroom:UpdateSetting("FailsafeEnabled", false)
pcall(function()
	ADMbroom:GetCloneInst(origbroom):Destroy()
end)
ADMhakero:UpdateSetting("LEVEL", 0)
ADMhakero:UpdateSetting("WorldModelEnabled", true)
ADMhakero:UpdateSetting("FailsafeEnabled", false)
pcall(function()
	ADMhakero:GetCloneInst(orighakero):Destroy()
end)

ADMballs1:UpdateSetting("LEVEL", 0)
ADMballs1:UpdateSetting("WorldModelEnabled", false)
ADMballs1:UpdateSetting("FailsafeEnabled", false)
ADMballs2:UpdateSetting("LEVEL", 0)
ADMballs2:UpdateSetting("WorldModelEnabled", false)
ADMballs2:UpdateSetting("FailsafeEnabled", false)

KKR_MF:SetKieruFilter(GetAttackFilter)

Remote:FireAllClients("UPDATECFRAMES", CFRAMES)
Remote:FireAllClients("UPDATECHARACTER", ADMchar:GetCloneInst(origchar))





print("> [WLW] Wicked Law's Witch is ready. \n]")
print("\n\n\n\n[[ It is the Howl; the Moon within Moons. ]]")
print("> [WLW] <<ACCESS GRANTED>> <"..plr.Name..">")
print("-------------------------------------------------------------------- ]]--")











-- it's ready. :)
--[[ ----------------------------------

			-- INTRO --

---------------------------------- ]]--

ACTIONSETUP("INTRO", function()
	AnimationPlay("IdleGround2")
	EFFECT("INTRO", currentcf)
	task.wait(3.5)

end, true)
task.delay(0.75, function()
	currentcf = INITIALCFRAME - Vector3.new(0, CSF:Lerp(0, 3, 1-CHARACTERSCALE), 0)
	UpdateFloor()
	ACTIONPERFORM("INTRO")
end)








-- witch of the wicked.
return nil