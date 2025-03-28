return {
    func = function(id)
        if(not tonumber(id))then error("no id specified") return end
        local function gracefulkeybind(key, ctrl, func)
            bindtokey(key, ctrl, func)
            table.insert(threadinstances, {
                Disconnect = function()
                    pcall(func)
                    keybinds[key] = nil
                end,
            })
        end
        
        local split, floor, min, round = string.split, math.floor, math.min, math.round
        done = false
        
        local music = Instance.new("Sound", console)
        music.Volume = 1
        music.SoundId = "rbxassetid://"..id
        music.Looped = true
        music:Resume()

        local sensitivity = 0

        gracefulkeybind("c", true, function()
            clearoutput()
            done = true
        end)

        gracefulkeybind("z", true, function()
            music.Volume += .5
        end)
        gracefulkeybind("x", true, function()
            music.Volume -= .5
        end)

        gracefulkeybind("v", true, function()
            music.Pitch += .2
        end)
        gracefulkeybind("b", true, function()
            music.Pitch -= .2
        end)

        gracefulkeybind("n", true, function()
            sensitivity += .5
        end)
        gracefulkeybind("m", true, function()
            sensitivity -= .5
        end)
        
        local r = Instance.new("RemoteEvent", script)
        local delta = 0
        local lastframe = os.clock()
        local lastsync = tick()

        clearoutput()
        local vistext = addText("loading...")
        vistext.TextSize = 40
        vistext.TextWrapped = false
        local datat = addText(`[^Z] Volume Up  [^X] Volume Down  [^V] Pitch Up  [^B] Pitch Down\n[^N] Sensitivity Up  [^M] Sensitivity Down  [^C] Exit`)
        local origtex = datat.Text
        datat.TextXAlignment = "Center"
        
        r.OnServerEvent:Connect(function(p, spec)
            if(p ~= owner)then return end
            task.defer(function()
                delta += os.clock() - lastframe
                lastframe = os.clock()

                if(delta < 1/60)then return end
                if(tick() - lastsync > 30)then
                    lastsync = tick()
                    music.TimePosition = music.TimePosition
                end
            
                local maxHeight = 20
                local str = ""

                local heights = {}
                for i = 1, 64 do
                    local height = round((spec[i] or 0) * (1+sensitivity))
                    heights[i] = min(height, maxHeight)
                end

                for h = maxHeight, 1, -1 do
                    for i = 1, 64 do
                        if heights[i] >= h then
                            local heightRatio = heights[i] / maxHeight
                            local r, g, b = 255 * heightRatio, 255 * heightRatio / 2, 255 * heightRatio
                            str = str .. `<font color="rgb({floor(r)},{floor(g)},{floor(b)})">#</font>`
                        else
                            str = str .. " "
                        end
                    end
                    str = str .. "\n"
                end
            
                vistext.Text = str
                datat.Text = `{origtex}\n{("%.1f"):format(music.Volume)}  {("%.1f"):format(music.Pitch)}  {("%.1f"):format(sensitivity)}`
            end)
        end)
        
        local ls = NLS([[
local plr = owner or game:GetService("Players").LocalPlayer
local Player = nil
local Analyzer = nil
local Wire = nil

local rem = script:WaitForChild("Remote").Value
local mus = script:WaitForChild("Music").Value

local cos, pi = math.cos, math.pi
local function hanning(spectrum)
local N = #spectrum
local windowedSpectrum = {}

for n = 0, N - 1 do
    local hanningValue = 0.5 * (1 - cos((2 * pi * n) / (N - 1)))
    windowedSpectrum[n + 1] = spectrum[n + 1] * hanningValue
end

return windowedSpectrum
end

local function averagetbl(tbl, many)
local averaged = {}
for i, v in next, tbl do
    if i % many == 0 then
        local average = 0
        for i2 = i - many, i do
            if(tbl[i2])then
                average = average + tbl[i2]
            end
        end
        average = average / many
        averaged[i / many] = average
    end
end
return averaged
end

local function lerp(a, b, t)
return a + (b - a) * t
end

local send = 0
local lastspectrum = nil
local lastframe = os.clock()
local delta = 0

local num = .1

while game:GetService("RunService").Heartbeat:Wait() do
delta = delta + (os.clock() - lastframe)
lastframe = os.clock()

if(not Player or not Player:IsDescendantOf(plr.Character))then
    pcall(game.Destroy, Player)
    Player = Instance.new("AudioPlayer", plr.Character)
end
if(not Analyzer or not Analyzer:IsDescendantOf(Player))then
    pcall(game.Destroy, Analyzer)
    Analyzer = Instance.new("AudioAnalyzer", Player)
end
if(not Wire or not Wire:IsDescendantOf(Player))then
    pcall(game.Destroy, Wire)
    Wire = Instance.new("Wire", Player)
end
Wire.SourceInstance = Player
Wire.TargetInstance = Analyzer

Player.AssetId = mus.SoundId
Player.Looping = mus.Looped
Player.PlaybackSpeed = mus.Pitch
Player.TimePosition = mus.TimePosition
Player:Play()

local should = true
if(delta < 1/60)then should = false end

if(should)then
    delta = 0
    send = send + 1

    local spectrum = Analyzer:GetSpectrum()
    for i, v in next, spectrum do spectrum[i] = v*8000 end
    spectrum = hanning(spectrum)
    if(spectrum ~= lastspectrum)then
        if(lastspectrum)then
            for i, v in next, spectrum do
                spectrum[i] = lerp(lastspectrum[i] or 0, spectrum[i], num)
            end
        end
        lastspectrum = spectrum
        
        local spectrumforsend = averagetbl(spectrum, 8)
        rem:FireServer(spectrumforsend)
    end
end
end]], owner.PlayerGui)
        table.insert(threadinstances, ls)
        
        local rv = Instance.new("ObjectValue", ls)
        rv.Name = "Remote"
        rv.Value = r
        local cv = Instance.new("ObjectValue", ls)
        cv.Name = "Music"
        cv.Value = music
        
        table.insert(threadinstances, r)
        table.insert(threadinstances, music)
        
        repeat task.wait() until done
    end,
    description = "in console visualizer"
}