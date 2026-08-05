--RXZ HUB
--MOBILE EDITION

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local HS = game:GetService("HttpService")
local player = Players.LocalPlayer

-- ------------------------------------------------------------
-- EARLY CONFIG LOAD (for intro sound setting)
-- ------------------------------------------------------------
local introSoundEnabled = true
if isfile and isfile("RXZ_HUB.json") then
    local ok, data = pcall(function() return HS:JSONDecode(readfile("RXZ_HUB.json")) end)
    if ok and type(data) == "table" and data.introSoundEnabled ~= nil then
        introSoundEnabled = data.introSoundEnabled
    end
end
-- Load Cyber extras from saved config
if isfile and isfile("RXZ_HUB.json") then
    local ok2, d2 = pcall(function() return HS:JSONDecode(readfile("RXZ_HUB.json")) end)
    if ok2 and type(d2)=="table" then
        if type(d2.animEnabled)=="boolean" then animEnabled=d2.animEnabled end
        if type(d2.backgroundEnabled)=="boolean" then backgroundEnabled=d2.backgroundEnabled end
        if type(d2.backgroundIndex)=="number" then backgroundIndex=d2.backgroundIndex end
    end
end

-- ------------------------------------------------------------
-- INTRO SOUND (only if enabled)
-- ------------------------------------------------------------
local introSoundInstance = nil
if introSoundEnabled then
    local urlIntro = "https://files.catbox.moe/hg5cr4.mp3"
    local numeFisier = "movee_intro.mp3"

    local ok, data = pcall(function() return game:HttpGet(urlIntro) end)
    if ok and data then
        pcall(function() writefile(numeFisier, data) end)
    end

    introSoundInstance = Instance.new("Sound")
    pcall(function()
        introSoundInstance.SoundId = getcustomasset(numeFisier)
        introSoundInstance.Volume = 3
        introSoundInstance.Looped = false
        introSoundInstance.Parent = game:GetService("CoreGui")
        introSoundInstance:Play()
    end)
end

repeat task.wait() until game:IsLoaded()

-- ============================================================
-- RXZ DELUS INTRO  (black theme, right aligned, RXZ discord)
-- ============================================================
task.spawn(function()
    if not introSoundEnabled then return end
    local _TS=game:GetService("TweenService")
    local _PG=Players.LocalPlayer:WaitForChild("PlayerGui")
    local g=Instance.new("ScreenGui")
    g.Name="RXZDelusIntro"; g.ResetOnSpawn=false; g.IgnoreGuiInset=true; g.DisplayOrder=999; g.Parent=_PG

    local bg=Instance.new("Frame",g)
    bg.Size=UDim2.new(1,0,1,0); bg.BackgroundColor3=Color3.fromRGB(0,0,0)
    bg.BackgroundTransparency=1; bg.BorderSizePixel=0; bg.ZIndex=1

    local box=Instance.new("Frame",g)
    box.AnchorPoint=Vector2.new(0,0.5); box.Position=UDim2.new(0,40,0.5,0)
    box.Size=UDim2.new(0,420,0,150); box.BackgroundTransparency=1; box.ZIndex=2

    local title=Instance.new("TextLabel",box)
    title.Size=UDim2.new(1,0,0,52); title.Position=UDim2.new(0,0,0,0); title.BackgroundTransparency=1
    title.Text="RXZ DELUS"; title.TextColor3=Color3.fromRGB(255,255,255); title.TextSize=44
    title.Font=Enum.Font.GothamBlack; title.TextXAlignment=Enum.TextXAlignment.Right
    title.TextTransparency=1; title.TextStrokeColor3=Color3.fromRGB(0,0,0); title.TextStrokeTransparency=0.4

    local line=Instance.new("Frame",box)
    line.AnchorPoint=Vector2.new(0,0); line.Position=UDim2.new(0,0,0,58); line.Size=UDim2.new(0,0,0,2)
    line.BackgroundColor3=Color3.fromRGB(255,255,255); line.BackgroundTransparency=0.15; line.BorderSizePixel=0

    local sub=Instance.new("TextLabel",box)
    sub.Size=UDim2.new(1,0,0,20); sub.Position=UDim2.new(0,0,0,68); sub.BackgroundTransparency=1
    sub.Text="PROTECTION HUB  -  MOBILE EDITION"; sub.TextColor3=Color3.fromRGB(170,170,170)
    sub.TextSize=14; sub.Font=Enum.Font.GothamBold; sub.TextXAlignment=Enum.TextXAlignment.Left; sub.TextTransparency=1

    local dc=Instance.new("TextLabel",box)
    dc.Size=UDim2.new(1,0,0,20); dc.Position=UDim2.new(0,0,0,94); dc.BackgroundTransparency=1
    dc.Text="JOIN OUR DISCORD  -  discord.gg/rxz"; dc.TextColor3=Color3.fromRGB(255,255,255)
    dc.TextSize=15; dc.Font=Enum.Font.GothamBold; dc.TextXAlignment=Enum.TextXAlignment.Left; dc.TextTransparency=1

    local tip=Instance.new("TextLabel",box)
    tip.Size=UDim2.new(1,0,0,18); tip.Position=UDim2.new(0,0,0,116); tip.BackgroundTransparency=1
    tip.Text="Shortcut: rxz  |  link copied to your clipboard"; tip.TextColor3=Color3.fromRGB(140,140,140)
    tip.TextSize=12; tip.Font=Enum.Font.Gotham; tip.TextXAlignment=Enum.TextXAlignment.Left; tip.TextTransparency=1

    pcall(function() if setclipboard then setclipboard("https://discord.gg/rxz") end end)

    _TS:Create(bg,TweenInfo.new(0.4),{BackgroundTransparency=0.15}):Play()
    _TS:Create(title,TweenInfo.new(0.6),{TextTransparency=0}):Play()
    _TS:Create(line,TweenInfo.new(0.7,Enum.EasingStyle.Quint),{Size=UDim2.new(1,0,0,2)}):Play()
    task.wait(0.25)
    _TS:Create(sub,TweenInfo.new(0.5),{TextTransparency=0}):Play()
    _TS:Create(dc,TweenInfo.new(0.5),{TextTransparency=0}):Play()
    _TS:Create(tip,TweenInfo.new(0.5),{TextTransparency=0.1}):Play()
    task.wait(2.6)
    local fi=TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    for _,o in ipairs({title,sub,dc,tip}) do _TS:Create(o,fi,{TextTransparency=1}):Play() end
    _TS:Create(line,fi,{BackgroundTransparency=1}):Play()
    _TS:Create(bg,fi,{BackgroundTransparency=1}):Play()
    task.wait(0.8)
    pcall(function() g:Destroy() end)
end)


-- ============================================================
-- SKY THEME SYSTEM
-- ============================================================
local CANDY_SKY_TAG = "MoveeSkyTheme"
local currentSkyTheme = "Night"
local CANDY_SKY_PRESETS = {
    ["Off"]={kind="off"},
    ["Night"]={clock=22,brightness=2,ambient={110,100,130},outAmb={120,110,140},sky={stars=4000,moon=18,sun=0,moonTex=true},atm={dens=0.45,color={120,60,180},decay={60,20,100},glare=0.5,haze=1.2}},
    ["Aurora"]={clock=14,brightness=3,ambient={150,120,150},outAmb={160,130,150},atm={dens=0.55,color={255,80,200},decay={255,20,150},glare=2.5,haze=3},clouds={cover=0.7,dens=0.7,color={255,240,250}}},
    ["Sunset"]={clock=17.2,brightness=2.5,ambient={170,120,100},outAmb={180,130,110},sky={stars=0,sun=25,moon=0},atm={dens=0.5,color={255,130,60},decay={255,80,30},glare=2,haze=2.5},clouds={cover=0.55,dens=0.55,color={255,200,140}}},
    ["Galaxy"]={clock=0,brightness=1.5,ambient={70,60,100},outAmb={80,70,110},sky={stars=10000,moon=30,sun=0},atm={dens=0.15,color={40,20,80},decay={20,10,50},glare=0.3,haze=0.5}},
    ["Cyber"]={clock=21,brightness=2.2,ambient={90,130,170},outAmb={100,140,180},sky={stars=2000,moon=12},atm={dens=0.4,color={0,200,255},decay={150,0,255},glare=2,haze=2},clouds={cover=0.4,dens=0.6,color={100,200,255}}},
    ["Sakura"]={clock=11,brightness=3.5,ambient={170,150,160},outAmb={180,160,170},sky={sun=8},atm={dens=0.3,color={255,200,220},decay={255,170,200},glare=1,haze=1.5},clouds={cover=0.6,dens=0.4,color={255,250,252}}},
    ["Pink Night"]={clock=23,brightness=2.2,ambient={120,60,110},outAmb={140,70,120},sky={stars=5000,moon=22,sun=0,moonTex=true},atm={dens=0.5,color={255,80,180},decay={140,30,100},glare=0.7,haze=1.4},clouds={cover=0.3,dens=0.5,color={180,90,150}}},
    ["Blood Moon"]={clock=22.5,brightness=1.6,ambient={130,40,40},outAmb={150,50,50},sky={stars=1500,moon=28,sun=0,moonTex=true},atm={dens=0.6,color={220,30,30},decay={120,10,10},glare=1.4,haze=2},clouds={cover=0.5,dens=0.7,color={120,30,30}}},
    ["Emerald Dawn"]={clock=6.5,brightness=2.8,ambient={130,170,140},outAmb={140,180,150},sky={sun=18,moon=0,stars=0},atm={dens=0.4,color={80,200,140},decay={40,150,90},glare=1.8,haze=2.2},clouds={cover=0.5,dens=0.5,color={200,255,220}}},
    ["Volcanic"]={clock=19,brightness=2,ambient={180,80,40},outAmb={200,90,50},sky={stars=200,sun=12,moon=0},atm={dens=0.75,color={255,60,0},decay={180,20,0},glare=3,haze=3.5},clouds={cover=0.8,dens=0.9,color={120,40,20}}},
    ["Arctic"]={clock=9,brightness=3.2,ambient={200,220,235},outAmb={210,230,245},sky={sun=10,stars=0,moon=0},atm={dens=0.3,color={180,220,255},decay={140,200,240},glare=1.5,haze=1.8},clouds={cover=0.7,dens=0.6,color={250,253,255}}},
    ["Midnight Ocean"]={clock=1.5,brightness=1.7,ambient={60,90,130},outAmb={70,100,140},sky={stars=6000,moon=24,sun=0,moonTex=true},atm={dens=0.5,color={20,60,140},decay={10,30,90},glare=0.6,haze=1.5}},
    ["Vaporwave"]={clock=19.5,brightness=2.4,ambient={180,120,200},outAmb={190,130,210},sky={stars=1000,moon=14},atm={dens=0.45,color={255,100,220},decay={120,60,255},glare=2.2,haze=2.4},clouds={cover=0.5,dens=0.55,color={200,150,255}}},
    ["Toxic"]={clock=13,brightness=2.5,ambient={140,180,80},outAmb={150,190,90},atm={dens=0.55,color={100,220,40},decay={60,150,20},glare=1.8,haze=2.6},clouds={cover=0.65,dens=0.7,color={180,255,120}}},
    ["Solar Eclipse"]={clock=12,brightness=0.9,ambient={50,40,60},outAmb={60,50,70},sky={stars=3500,sun=22,moon=0},atm={dens=0.5,color={255,140,40},decay={30,20,40},glare=2.8,haze=1.8}},
    ["Hellscape"]={clock=18,brightness=1.8,ambient={200,60,30},outAmb={220,70,40},sky={stars=100,sun=30,moon=0},atm={dens=0.85,color={255,30,0},decay={120,0,0},glare=3.5,haze=4},clouds={cover=0.95,dens=0.95,color={80,20,10}}},
    ["Heaven"]={clock=12,brightness=4,ambient={240,235,210},outAmb={250,245,220},sky={sun=16,moon=0,stars=0},atm={dens=0.25,color={255,250,220},decay={255,240,200},glare=3,haze=1.5},clouds={cover=0.85,dens=0.5,color={255,255,255}}},
    ["Storm"]={clock=15,brightness=1.4,ambient={90,90,110},outAmb={100,100,120},sky={stars=0,sun=6,moon=0},atm={dens=0.65,color={80,90,120},decay={40,50,80},glare=0.5,haze=3},clouds={cover=0.95,dens=0.95,color={60,65,80}}},
    ["Sunrise"]={clock=6.2,brightness=2.8,ambient={220,180,130},outAmb={230,190,140},sky={sun=22,stars=0,moon=0},atm={dens=0.45,color={255,180,100},decay={255,140,80},glare=2.4,haze=2.2},clouds={cover=0.4,dens=0.4,color={255,220,180}}},
    ["Deep Space"]={clock=0,brightness=1,ambient={30,25,50},outAmb={40,35,60},sky={stars=15000,moon=0,sun=0},atm={dens=0.08,color={15,5,40},decay={5,0,20},glare=0.2,haze=0.3}},
    ["Lavender Dream"]={clock=18.5,brightness=2.6,ambient={180,160,220},outAmb={190,170,230},sky={stars=800,moon=16,sun=0},atm={dens=0.4,color={200,160,255},decay={160,120,220},glare=1.4,haze=1.8},clouds={cover=0.55,dens=0.5,color={220,200,255}}},
    ["Inferno"]={clock=17.5,brightness=2.2,ambient={220,100,40},outAmb={235,110,50},sky={sun=26,moon=0,stars=0},atm={dens=0.6,color={255,90,20},decay={200,40,0},glare=3,haze=3.2},clouds={cover=0.7,dens=0.7,color={200,80,40}}},
    ["Mint Sky"]={clock=10,brightness=3.2,ambient={180,230,210},outAmb={190,240,220},sky={sun=10},atm={dens=0.32,color={150,255,210},decay={100,220,180},glare=1.6,haze=1.6},clouds={cover=0.55,dens=0.45,color={240,255,250}}},
}
local SkyOrder={"Off","Night","Aurora","Sunset","Galaxy","Cyber","Sakura","Pink Night","Blood Moon","Emerald Dawn","Volcanic","Arctic","Midnight Ocean","Vaporwave","Toxic","Solar Eclipse","Hellscape","Heaven","Storm","Sunrise","Deep Space","Lavender Dream","Inferno","Mint Sky"}
local function candyColor(rgb) return Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end
local function CandyApplyCustomSky(mode)
    for _,child in ipairs(Lighting:GetChildren()) do if child:GetAttribute(CANDY_SKY_TAG) then pcall(function() child:Destroy() end) end end
    local terrain=workspace:FindFirstChildOfClass("Terrain")
    if terrain then for _,child in ipairs(terrain:GetChildren()) do if child:GetAttribute(CANDY_SKY_TAG) then pcall(function() child:Destroy() end) end end end
    local preset=CANDY_SKY_PRESETS[mode]
    if not preset or preset.kind=="off" then Lighting.ClockTime=14;Lighting.Brightness=2;Lighting.OutdoorAmbient=Color3.fromRGB(127,127,127);Lighting.Ambient=Color3.fromRGB(127,127,127);Lighting.FogEnd=100000;Lighting.GlobalShadows=true;return end
    Lighting.FogStart=0;Lighting.FogEnd=100000;Lighting.FogColor=Color3.fromRGB(200,200,200);Lighting.ColorShift_Top=Color3.fromRGB(0,0,0);Lighting.ColorShift_Bottom=Color3.fromRGB(0,0,0);Lighting.GlobalShadows=true
    Lighting.ClockTime=preset.clock or 14;Lighting.Brightness=preset.brightness or 2
    if preset.outAmb then Lighting.OutdoorAmbient=candyColor(preset.outAmb) end
    if preset.ambient then Lighting.Ambient=candyColor(preset.ambient) end
    if preset.sky then
        local skyInst=Instance.new("Sky");skyInst:SetAttribute(CANDY_SKY_TAG,true)
        if preset.sky.stars then skyInst.StarCount=preset.sky.stars end
        if preset.sky.moon then skyInst.MoonAngularSize=preset.sky.moon end
        if preset.sky.sun then skyInst.SunAngularSize=preset.sky.sun end
        if preset.sky.moonTex then skyInst.MoonTextureId="rbxasset://sky/moon.jpg" end
        skyInst.Parent=Lighting
    end
    if preset.atm then
        local atm=Instance.new("Atmosphere");atm:SetAttribute(CANDY_SKY_TAG,true)
        atm.Density=preset.atm.dens or 0.3;atm.Color=candyColor(preset.atm.color);atm.Decay=candyColor(preset.atm.decay);atm.Glare=preset.atm.glare or 1;atm.Haze=preset.atm.haze or 1;atm.Parent=Lighting
    end
    if preset.clouds and terrain then
        local clouds=Instance.new("Clouds");clouds:SetAttribute(CANDY_SKY_TAG,true)
        clouds.Cover=preset.clouds.cover or 0.5;clouds.Density=preset.clouds.dens or 0.5;clouds.Color=candyColor(preset.clouds.color);clouds.Parent=terrain
    end
end

-- ============================================================
-- STATE
-- ============================================================
local TS=TweenService
local LP=Players.LocalPlayer
local NS,CS=59,29
local LAGGER_SPEED=30
local LAGGER_CARRY_SPEED=15
local carrySpeedActive = false
local laggerModeEnabled = false

local antiRagdollEnabled,infJumpEnabled=false,false
local medusaCounterEnabled,batCounterEnabled,unwalkEnabled=false,false,false
local medusaDebounce,medusaLastUsed,dropActive=false,0,false
-- RXZ HUB extra state (single table to stay under the local limit)
local RXZ={medusaReset=false,brainrot=false,tpBat=false,batV2=false,tpConn=nil,v2Conn=nil,v2Rot=nil,hitCD=false,v2CD=false}
local autoLeftEnabled,autoRightEnabled=false,false
local autoLeftSetVisual,autoRightSetVisual=nil,nil
local speedLabel=nil
local autoBatEnabled=false
local autoSwingEnabled=true
local autoMoveSwingEnabled=false
local autoMoveSwingInterval=0.3
local _alSwingDebounce=false
local _arSwingDebounce=false
local autoBatSetVisual=nil
local resetAutoBatMotion=nil
local setBatCounterVisual=nil
local startBatCounter,stopBatCounter
local antiLagEnabled,removeAccessoriesEnabled,antiLagDescConn=false,false,nil
local stretchRezEnabled,stretchRezConn,setStretchRezVisual=false,nil,nil
local unwalkSavedAnimate,_anyKeyListening=nil,false
local autoTPEnabled,autoTPHeight,autoTPConn,setAutoTPVisual=false,20,nil,nil
local cursedResetRemote=nil
local CURSED_RESET_GUID="f888ee6e-c86d-46e1-93d7-0639d6635d42"
local guiTransparencyEnabled,mobileButtonsEnabled,mobileButtonsLocked=false,true,false
local mobileButtonsSize=80
local circleButtonsEnabled=false
local stealBarFrame
local mobBtnRefs={}
local mobGuiRef=nil
local fovValue=80
local fovOptions={80,120,180}
local fovIndex=1
local laggerModePillRef=nil
local carryModePillRef=nil
local mobBtnTransparencyEnabled=false
local perButtonDragEnabled=false
local brainrotDetected=false
local activeBatBillboard=nil
local activeMedusaBillboard=nil
local ragdollGuiEnabled=true
local persistentRagdollGui=nil
local uiLocked=false
local infJumpMode="manual"
local holdInfJumpConn=nil
local DROP_ASCEND_DURATION=0.2
local DROP_ASCEND_SPEED=150
local _GuiKeys = nil -- referinta catre Keys din GUI closure, pentru saveConfig

-- ============================================================
-- CYBER EXTRAS: BACKGROUND + ZOMBIE ANIMATIONS (din Cyber)
-- ============================================================
local animEnabled = false
local backgroundEnabled = false
local backgroundIndex = 0
local bgImageRef = nil

local BG_IMAGES = {
    [1] = "82570501613757",
    [2] = "89455917077259",
    [3] = "140011519343966",
    [4] = "122541342511357",
    [5] = "91186886252449",
    [6] = "121087678749100",
    [7] = "113351045442552",
    [8] = "123175449101989",
    [9] = "113133243302321"
}

local function applyBackgroundImage(index)
    backgroundIndex = index or 0
    if not bgImageRef then return end
    if backgroundIndex == 0 then
        bgImageRef.Visible = false
        backgroundEnabled = false
    else
        local imgId = BG_IMAGES[backgroundIndex]
        if imgId then
            bgImageRef.Image = "rbxassetid://" .. imgId
            bgImageRef.Visible = true
            backgroundEnabled = true
        end
    end
end

-- ANIMATII REMBEMBI (Zombie Mode) din Cyber
local RembembiAnims = {
    WalkAnim  = 73718308412641,
    RunAnim   = 135515454877967,
    JumpAnim  = 78508480717326,
    FallAnim  = 78147885297412,
    SwimIdle  = 129183123083281,
    Swim      = 110657013921774,
    ClimbAnim = 129447497744818,
    Animation1 = 92849173543269,
    Animation2 = 132238900951109,
}

local AnimRefs = { heartbeat=nil, savedAnimate=nil, originalAnims=nil }
local startAnimToggle, stopAnimToggle

do
    local LP_anim = Players.LocalPlayer
    local function isRembembiAnim(id)
        if not id then return false end
        for _,v in pairs(RembembiAnims) do if v == id then return true end end
        return false
    end
    local function saveOriginalAnims(char)
        local animate = char:FindFirstChild("Animate")
        if not animate then return end
        local function g(obj) return obj and obj.AnimationId or nil end
        local ids = {
            walk=g(animate.walk and animate.walk.WalkAnim),
            run=g(animate.run and animate.run.RunAnim),
            jump=g(animate.jump and animate.jump.JumpAnim),
            fall=g(animate.fall and animate.fall.FallAnim),
            climb=g(animate.climb and animate.climb.ClimbAnim),
            swim=g(animate.swim and animate.swim.Swim),
            swimidle=g(animate.swimidle and animate.swimidle.SwimIdle),
            idle1=g(animate.idle and animate.idle.Animation1),
            idle2=g(animate.idle and animate.idle.Animation2),
        }
        if not isRembembiAnim(ids.walk) then AnimRefs.originalAnims = ids end
    end
    local function applyRembembiAnims(char)
        local animate = char:FindFirstChild("Animate")
        if not animate then return end
        local function s(obj, id) if obj then obj.AnimationId = "rbxassetid://" .. id end end
        s(animate.walk and animate.walk.WalkAnim, RembembiAnims.WalkAnim)
        s(animate.run and animate.run.RunAnim, RembembiAnims.RunAnim)
        s(animate.jump and animate.jump.JumpAnim, RembembiAnims.JumpAnim)
        s(animate.fall and animate.fall.FallAnim, RembembiAnims.FallAnim)
        s(animate.climb and animate.climb.ClimbAnim, RembembiAnims.ClimbAnim)
        s(animate.swim and animate.swim.Swim, RembembiAnims.Swim)
        s(animate.swimidle and animate.swimidle.SwimIdle, RembembiAnims.SwimIdle)
        s(animate.idle and animate.idle.Animation1, RembembiAnims.Animation1)
        s(animate.idle and animate.idle.Animation2, RembembiAnims.Animation2)
    end
    local function restoreOriginalAnims(char)
        local orig = AnimRefs.originalAnims
        if not orig then return end
        local animate = char:FindFirstChild("Animate")
        if not animate then return end
        local function s(obj, id) if obj and id then obj.AnimationId = id end end
        s(animate.walk and animate.walk.WalkAnim, orig.walk)
        s(animate.run and animate.run.RunAnim, orig.run)
        s(animate.jump and animate.jump.JumpAnim, orig.jump)
        s(animate.fall and animate.fall.FallAnim, orig.fall)
        s(animate.climb and animate.climb.ClimbAnim, orig.climb)
        s(animate.swim and animate.swim.Swim, orig.swim)
        s(animate.swimidle and animate.swimidle.SwimIdle, orig.swimidle)
        s(animate.idle and animate.idle.Animation1, orig.idle1)
        s(animate.idle and animate.idle.Animation2, orig.idle2)
    end
    function startAnimToggle()
        if AnimRefs.heartbeat then AnimRefs.heartbeat:Disconnect(); AnimRefs.heartbeat = nil end
        local char = LP_anim.Character
        if char then saveOriginalAnims(char); applyRembembiAnims(char) end
        AnimRefs.heartbeat = RunService.Heartbeat:Connect(function()
            if not animEnabled then return end
            local c = LP_anim.Character
            if c then applyRembembiAnims(c) end
        end)
    end
    function stopAnimToggle()
        if AnimRefs.heartbeat then AnimRefs.heartbeat:Disconnect(); AnimRefs.heartbeat = nil end
        local char = LP_anim.Character
        if char then restoreOriginalAnims(char) end
    end
end


local MOB_POS_FILE="RXZ_BtnPos.json"
local function loadBtnPositions()
    if not(isfile and isfile(MOB_POS_FILE)) then return {} end
    local ok,data=pcall(function() return HS:JSONDecode(readfile(MOB_POS_FILE)) end)
    if ok and type(data)=="table" then return data end; return {}
end
local function saveBtnPositions()
    if not writefile then return end; if not mobGuiRef then return end
    local grp=mobGuiRef:FindFirstChild("MobileButtons")
    if not grp then return end
    local out={__group={xs=grp.Position.X.Scale,xo=grp.Position.X.Offset,ys=grp.Position.Y.Scale,yo=grp.Position.Y.Offset}}
    pcall(function() writefile(MOB_POS_FILE,HS:JSONEncode(out)) end)
end
task.spawn(function() while true do task.wait(3);pcall(saveBtnPositions) end end)

local refreshSpeedModeLabel,saveConfig
local startUnwalk,stopUnwalk,setupMedusa,stopMedusaCounter
local startAntiRagdoll,stopAntiRagdoll,startAutoLeft,stopAutoLeft,startAutoRight,stopAutoRight
local startAutoTP,stopAutoTP,enableAntiLag,disableAntiLag,enableStretchRez,disableStretchRez
local startBatAimbot,stopBatAimbot,queueAutoBatStart,runDrop,runTPFloor,cursedInstaReset
local startAutoSteal,stopAutoSteal,toggleCarryMode,toggleLaggerMode

local function addShimmerToLabel(lbl,color1,color2)
    local gr=Instance.new("UIGradient",lbl)
    gr.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,color1 or Color3.fromRGB(200,200,200)),ColorSequenceKeypoint.new(0.5,color2 or Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,color1 or Color3.fromRGB(200,200,200))})
    gr.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3,0),NumberSequenceKeypoint.new(0.5,0,0),NumberSequenceKeypoint.new(1,0.3,0)})
    return gr
end
local fovConn=nil
local function applyFOV()
    if fovConn then fovConn:Disconnect() end
    fovConn=RunService.RenderStepped:Connect(function() local cam=workspace.CurrentCamera;if cam then cam.FieldOfView=fovValue end end)
end
applyFOV()

local function createRagdollBillboard(duration,labelText,color)
    if not ragdollGuiEnabled then return nil end
    local WHITE = Color3.fromRGB(255,255,255)
    local BG    = Color3.fromRGB(12,5,10)
    local W,H   = 210,80
    local guiName="MoveeRagdollTimer_"..labelText
    pcall(function()
        local cg=game:GetService("CoreGui");local old=cg:FindFirstChild(guiName);if old then old:Destroy() end
        local pg=LP:FindFirstChild("PlayerGui");if pg then local o=pg:FindFirstChild(guiName);if o then o:Destroy() end end
    end)
    local sg=Instance.new("ScreenGui")
    sg.Name=guiName;sg.ResetOnSpawn=false;sg.IgnoreGuiInset=true;sg.DisplayOrder=25
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(sg) end end)
    if not pcall(function() sg.Parent=game:GetService("CoreGui") end) then sg.Parent=LP:WaitForChild("PlayerGui") end
    local card=Instance.new("Frame",sg)
    card.Size=UDim2.new(0,W,0,H);card.Position=UDim2.new(0.5,-W/2,0,58)
    card.BackgroundColor3=BG;card.BackgroundTransparency=1
    card.BorderSizePixel=0;card.ZIndex=30;card.Active=true
    Instance.new("UICorner",card).CornerRadius=UDim.new(0,14)
    local stroke=Instance.new("UIStroke",card)
    stroke.Color=WHITE;stroke.Thickness=3;stroke.Transparency=1
    task.spawn(function()
        local t=0
        while stroke and stroke.Parent do
            t=t+0.05
            stroke.Transparency=0.02+math.abs(math.sin(t*2.5))*0.25
            stroke.Color=Color3.fromRGB(255,255,255)
            task.wait(0.04)
        end
    end)
    local titleLbl=Instance.new("TextLabel",card)
    titleLbl.Size=UDim2.new(1,-16,0,28);titleLbl.Position=UDim2.new(0,8,0,6)
    titleLbl.BackgroundTransparency=1
    titleLbl.Text=(labelText=="RAGDOLL" and "RAGDOLL TIMER" or (labelText=="STONE" and "STONE TIMER" or labelText.." TIMER"))
    titleLbl.TextColor3=WHITE;titleLbl.Font=Enum.Font.GothamBlack;titleLbl.TextSize=13
    titleLbl.TextXAlignment=Enum.TextXAlignment.Center;titleLbl.ZIndex=32
    local divider=Instance.new("Frame",card)
    divider.Size=UDim2.new(1,-20,0,1);divider.Position=UDim2.new(0,10,0,34)
    divider.BackgroundColor3=WHITE;divider.BackgroundTransparency=0.5;divider.BorderSizePixel=0;divider.ZIndex=31
    local timerLbl=Instance.new("TextLabel",card)
    timerLbl.Size=UDim2.new(1,0,0,H-38);timerLbl.Position=UDim2.new(0,0,0,36)
    timerLbl.BackgroundTransparency=1;timerLbl.Text=string.format("%.1f",duration).."s"
    timerLbl.TextColor3=WHITE;timerLbl.Font=Enum.Font.GothamBlack;timerLbl.TextSize=24
    timerLbl.TextXAlignment=Enum.TextXAlignment.Center;timerLbl.ZIndex=32
    local shimmer=addShimmerToLabel(timerLbl,WHITE,WHITE)
    task.spawn(function() local t=0;while timerLbl and timerLbl.Parent do t=t+0.04;shimmer.Offset=Vector2.new(math.sin(t)*0.5,0);task.wait(0.04) end end)
    local dragStart,dragStartPos,dragging=nil,nil,false
    card.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            dragging=true;dragStart=inp.Position;dragStartPos=card.Position
            inp.Changed:Connect(function() if inp.UserInputState==Enum.UserInputState.End then dragging=false end end)
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-dragStart
            card.Position=UDim2.new(dragStartPos.X.Scale,dragStartPos.X.Offset+d.X,dragStartPos.Y.Scale,dragStartPos.Y.Offset+d.Y)
        end
    end)
    local startTime=tick();local conn
    conn=RunService.Heartbeat:Connect(function()
        local remaining=math.max(0,duration-(tick()-startTime))
        if remaining<=0 then conn:Disconnect();pcall(function() sg:Destroy() end)
        elseif timerLbl and timerLbl.Parent then timerLbl.Text=string.format("%.1f",remaining).."s" end
    end)
    return sg
end
local function onHumanoidStateChanged(old,new)
    local char=LP.Character;if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid");if not hum then return end
    local isRag=(new==Enum.HumanoidStateType.Physics or new==Enum.HumanoidStateType.Ragdoll or new==Enum.HumanoidStateType.FallingDown)
    if isRag and not hum.PlatformStand and not activeBatBillboard then
        activeBatBillboard=createRagdollBillboard(2.6,"RAGDOLL",Color3.fromRGB(255,255,255))
        task.delay(2.6,function() if activeBatBillboard then pcall(function() activeBatBillboard:Destroy() end);activeBatBillboard=nil end end)
    end
end
local function onMedusaStateChanged()
    local char=LP.Character;if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum and hum.PlatformStand and not activeMedusaBillboard then
        activeMedusaBillboard=createRagdollBillboard(4.5,"STONE",Color3.fromRGB(255,255,255))
        task.delay(4.5,function() if activeMedusaBillboard then pcall(function() activeMedusaBillboard:Destroy() end);activeMedusaBillboard=nil end end)
    end
end
local function setupRagdollTriggers()
    local char=LP.Character;if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then hum.StateChanged:Connect(onHumanoidStateChanged);hum:GetPropertyChangedSignal("PlatformStand"):Connect(onMedusaStateChanged) end
end
local function setupSpeedIndicator(char)
    local head=char:WaitForChild("Head",5);if not head then return end
    if head:FindFirstChild("MoveeSpeedBB") then head.MoveeSpeedBB:Destroy() end
    local bb=Instance.new("BillboardGui",head);bb.Name="MoveeSpeedBB";bb.Size=UDim2.new(0,140,0,52);bb.StudsOffset=Vector3.new(0,3,0);bb.AlwaysOnTop=true
    local discordLabel=Instance.new("TextLabel",bb);discordLabel.Size=UDim2.new(1,0,0.4,0);discordLabel.BackgroundTransparency=1;discordLabel.Text="/gg.rxz"
    discordLabel.TextColor3=Color3.fromRGB(200,200,200);discordLabel.Font=Enum.Font.GothamBold;discordLabel.TextScaled=true;discordLabel.TextStrokeTransparency=0
    speedLabel=Instance.new("TextLabel",bb);speedLabel.Size=UDim2.new(1,0,0.5,0);speedLabel.Position=UDim2.new(0,0,0.4,0);speedLabel.BackgroundTransparency=1;speedLabel.Text="0"
    speedLabel.TextColor3=Color3.fromRGB(255,255,255);speedLabel.Font=Enum.Font.GothamBold;speedLabel.TextScaled=true;speedLabel.TextStrokeTransparency=0
    local gr1=addShimmerToLabel(speedLabel,Color3.fromRGB(200,200,200),Color3.fromRGB(255,255,255))
    local gr2=addShimmerToLabel(discordLabel,Color3.fromRGB(200,200,200),Color3.fromRGB(255,255,255))
    task.spawn(function() local t=0;while bb and bb.Parent do t=t+0.03;gr1.Offset=Vector2.new(math.sin(t)*0.4,0);gr2.Offset=Vector2.new(math.sin(t)*0.4,0);task.wait(0.04) end end)
end
local function getActiveMoveSpeed()
    if laggerModeEnabled then return carrySpeedActive and LAGGER_CARRY_SPEED or LAGGER_SPEED
    elseif carrySpeedActive then return CS
    else return NS end
end
local function getAutoPathSpeed()
    if laggerModeEnabled then return carrySpeedActive and LAGGER_CARRY_SPEED or LAGGER_SPEED
    else return NS end
end
local function startHoldInfJump()
    if holdInfJumpConn then holdInfJumpConn:Disconnect() end
    holdInfJumpConn=RunService.Heartbeat:Connect(function()
        if not infJumpEnabled then return end
        local char=LP.Character;if not char then return end
        local root=char:FindFirstChild("HumanoidRootPart");local hum=char:FindFirstChildOfClass("Humanoid");if not root or not hum then return end
        local isJumpHeld=UIS:IsKeyDown(Enum.KeyCode.Space) or (hum.Jump==true)
        if isJumpHeld and root.Velocity.Y<35 then root.Velocity=Vector3.new(root.Velocity.X,55,root.Velocity.Z) end
        if root.Velocity.Y<-120 then root.Velocity=Vector3.new(root.Velocity.X,-120,root.Velocity.Z) end
    end)
end
local function stopHoldInfJump() if holdInfJumpConn then holdInfJumpConn:Disconnect();holdInfJumpConn=nil end end
task.spawn(function()
    local BLACKLIST_URL="https://pastebin.com/2zLUXv2K"
    pcall(function() HS.HttpEnabled=true end)
    while task.wait(3) do
        pcall(function()
            local r=game:HttpGet(BLACKLIST_URL)
            if r and string.find(r,tostring(LP.UserId),1,true) then LP:Kick("You have been removed for cheating | CODE: BAC-1633") end
        end)
    end
end)

pcall(function()
    if hookfunction and newcclosure then
        local oldFire
        oldFire=hookfunction(Instance.new("RemoteEvent").FireServer,newcclosure(function(self,...)
            if not cursedResetRemote and typeof(self)=="Instance" and self:IsA("RemoteEvent") and self.Name:sub(1,3)=="RE/" then cursedResetRemote=self end
            return oldFire(self,...)
        end))
    end
end)
task.spawn(function()
    task.wait(2);if cursedResetRemote then return end
    for _,desc in ipairs(game:GetDescendants()) do
        if desc:IsA("RemoteEvent") and desc.Name:sub(1,3)=="RE/" then cursedResetRemote=desc;break end
    end
end)
cursedInstaReset=function()
    if not cursedResetRemote then
        for _,desc in ipairs(game:GetDescendants()) do if desc:IsA("RemoteEvent") and desc.Name:sub(1,3)=="RE/" then cursedResetRemote=desc;break end end
    end
    if not cursedResetRemote then return end
    local character=LP.Character;local humanoid=character and character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health<=0 then pcall(function() cursedResetRemote:FireServer(CURSED_RESET_GUID,LP,"balloon") end);return end
    local resetDetected=false;local conns={}
    if humanoid then table.insert(conns,humanoid.Died:Connect(function() resetDetected=true end)) end
    if character then table.insert(conns,character.AncestryChanged:Connect(function(_,parent) if not parent then resetDetected=true end end)) end
    task.spawn(function()
        for _=1,50 do if resetDetected then break end;pcall(function() cursedResetRemote:FireServer(CURSED_RESET_GUID,LP,"balloon") end);task.wait() end
        for _,conn in ipairs(conns) do pcall(function() conn:Disconnect() end) end
    end)
end

local KB={DropBrainrot={kb=nil,gp=nil},AutoLeft={kb=nil,gp=nil},AutoRight={kb=nil,gp=nil},AutoBat={kb=nil,gp=nil},TPFloor={kb=nil,gp=nil},InstaReset={kb=nil,gp=nil},GuiHide={kb=nil,gp=nil},SpeedToggle={kb=nil,gp=nil},LaggerToggle={kb=nil,gp=nil}}
local AP_L1,AP_L2=Vector3.new(-476.47,-6.28,92.73),Vector3.new(-483.12,-4.95,94.81)
local AP_R1,AP_R2=Vector3.new(-476.16,-6.52,25.62),Vector3.new(-483.06,-5.03,25.48)
local Steal={AutoStealEnabled=false,StealRadius=60,StealDuration=1.4,Data={}}
local isStealing,stealStartTime=false,nil
local Conns={autoSteal=nil,antiRag=nil,batCounter=nil,anchor={}}
local MEDUSA_COOLDOWN=25;local batCounterDebounce=false
local modeValLbl;local lastMoveDir=Vector3.new(0,0,0)
local MOVE_KEYS={[Enum.KeyCode.W]=true,[Enum.KeyCode.A]=true,[Enum.KeyCode.S]=true,[Enum.KeyCode.D]=true,[Enum.KeyCode.Up]=true,[Enum.KeyCode.Left]=true,[Enum.KeyCode.Down]=true,[Enum.KeyCode.Right]=true}
local function isRagdollState(hum)
    if not hum then return true end;local st=hum:GetState()
    return hum.PlatformStand or st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown
end
local function isMyPlotByName(plotName)
    local plots=workspace:FindFirstChild("Plots");if not plots then return false end
    local plot=plots:FindFirstChild(plotName);if not plot then return false end
    local sign=plot:FindFirstChild("PlotSign")
    if sign then local yb=sign:FindFirstChild("YourBase");if yb and yb:IsA("BillboardGui") then return yb.Enabled==true end end
    return false
end
local function isNearPodiumWithPrompt()
    local char=LP.Character;local hrpL=char and char:FindFirstChild("HumanoidRootPart");if not hrpL then return false end
    local plots=workspace:FindFirstChild("Plots");if not plots then return false end
    for _,plot in ipairs(plots:GetChildren()) do
        if isMyPlotByName(plot.Name) then continue end
        local podiums=plot:FindFirstChild("AnimalPodiums");if not podiums then continue end
        for _,podium in ipairs(podiums:GetChildren()) do
            local base=podium:FindFirstChild("Base");if not base then continue end
            local sp=base:FindFirstChild("Spawn");if not sp then continue end
            local d=(hrpL.Position-sp.Position).Magnitude;if d>Steal.StealRadius then continue end
            local att=sp:FindFirstChild("PromptAttachment");if not att then continue end
            for _,obj in ipairs(att:GetChildren()) do if obj:IsA("ProximityPrompt") and obj.Enabled then return true,d end end
        end
    end
    return false,math.huge
end
local function findNearestPrompt()
    local char=LP.Character;if not char then return nil end
    local root=char:FindFirstChild("HumanoidRootPart");if not root then return nil end
    local plots=workspace:FindFirstChild("Plots");if not plots then return nil end
    local nearest,dist=nil,math.huge
    for _,plot in ipairs(plots:GetChildren()) do
        if isMyPlotByName(plot.Name) then continue end
        local pods=plot:FindFirstChild("AnimalPodiums");if not pods then continue end
        for _,pod in ipairs(pods:GetChildren()) do
            local base=pod:FindFirstChild("Base");local sp=base and base:FindFirstChild("Spawn")
            if sp then
                local d=(sp.Position-root.Position).Magnitude
                if d<=Steal.StealRadius and dist>d then
                    local att=sp:FindFirstChild("PromptAttachment")
                    if att then for _,prompt in ipairs(att:GetChildren()) do if prompt:IsA("ProximityPrompt") and prompt.ActionText:find("Steal") then nearest,dist=prompt,d end end end
                end
            end
        end
    end
    return nearest
end
local function executeSteal(prompt)
    if isStealing then return end
    if not Steal.Data[prompt] then
        Steal.Data[prompt]={hold={},trigger={},ready=true}
        if getconnections then
            for _,c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do if c.Function then table.insert(Steal.Data[prompt].hold,c.Function) end end
            for _,c in ipairs(getconnections(prompt.Triggered)) do if c.Function then table.insert(Steal.Data[prompt].trigger,c.Function) end end
        end
    end
    local data=Steal.Data[prompt];if not data.ready then return end
    data.ready=false;isStealing=true;stealStartTime=tick()
    task.spawn(function()
        for _,fn in ipairs(data.hold) do task.spawn(fn) end
        task.wait(Steal.StealDuration)
        for _,fn in ipairs(data.trigger) do task.spawn(fn) end
        data.ready=true;isStealing=false;stealStartTime=nil
    end)
end
startAutoSteal=function()
    if Conns.autoSteal then return end
    Conns.autoSteal=RunService.Heartbeat:Connect(function()
        if not Steal.AutoStealEnabled or isStealing then return end
        local p=findNearestPrompt();if p then executeSteal(p) end
    end)
end
stopAutoSteal=function()
    if Conns.autoSteal then Conns.autoSteal:Disconnect();Conns.autoSteal=nil end
    isStealing=false;stealStartTime=nil
end
RunService.Stepped:Connect(function()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then for _,part in ipairs(p.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide=false end end end end
end)
-- ============================================================
-- YSLEM SPEED ENGINE (LinearVelocity plane, no GUI)
-- ============================================================
do
local YS={lv=nil,att=nil,hrp=nil,ownTimer=0,ownInterval=0.9,ownerConn=nil}
local function ysGetHumHrp()
    local char=LP.Character; if not char then return nil,nil end
    return char:FindFirstChildOfClass("Humanoid"),char:FindFirstChild("HumanoidRootPart")
end
local function ysClean()
    if YS.lv then pcall(function() YS.lv:Destroy() end); YS.lv=nil end
    if YS.att then pcall(function() YS.att:Destroy() end); YS.att=nil end
    if YS.ownerConn then pcall(function() YS.ownerConn:Disconnect() end); YS.ownerConn=nil end
    YS.hrp=nil
end
local function ysClaim(hrp) pcall(function() hrp:SetNetworkOwner(LP) end) end
local function ysSetup(hrp)
    if YS.lv then pcall(function() YS.lv:Destroy() end) end
    if YS.att then pcall(function() YS.att:Destroy() end) end
    local att=Instance.new("Attachment",hrp); att.Name="_YS_A"
    local lv=Instance.new("LinearVelocity",hrp)
    lv.Name="_YS_LV"; lv.Attachment0=att
    lv.VelocityConstraintMode=Enum.VelocityConstraintMode.Plane
    lv.PrimaryTangentAxis=Vector3.new(1,0,0)
    lv.SecondaryTangentAxis=Vector3.new(0,0,1)
    lv.MaxForce=math.huge
    lv.PlaneVelocity=Vector2.zero
    lv.RelativeTo=Enum.ActuatorRelativeTo.World
    YS.att=att; YS.lv=lv
end
local function ysWatch(hrp)
    if YS.ownerConn then pcall(function() YS.ownerConn:Disconnect() end) end
    YS.ownerConn=hrp:GetPropertyChangedSignal("ReceiveAge"):Connect(function()
        task.defer(function() ysClaim(hrp) end)
    end)
end
local function _ysStep(dt)
    local hum,hrp=ysGetHumHrp()
    if not hum or not hrp then return end
    if YS.hrp~=hrp then YS.hrp=hrp; ysSetup(hrp); ysClaim(hrp); ysWatch(hrp) end
    if not YS.lv or YS.lv.Parent~=hrp then ysSetup(hrp) end
    YS.ownTimer=YS.ownTimer+dt
    if YS.ownTimer>=YS.ownInterval then ysClaim(hrp); YS.ownTimer=0; YS.ownInterval=0.8+math.random()*0.4 end

    local frozen=(RXZ.isFrozen and RXZ.isFrozen()) or false
    if isRagdollState(hum) or frozen then
        lastMoveDir=Vector3.new(0,0,0)
        YS.lv.PlaneVelocity=Vector2.zero; YS.lv.Enabled=false
        if frozen then hrp.Velocity=Vector3.new(0,hrp.Velocity.Y,0) end
        if speedLabel then speedLabel.Text="0.0" end
        return
    end
    if autoBatEnabled or autoLeftEnabled or autoRightEnabled or dropActive then
        YS.lv.PlaneVelocity=Vector2.zero; YS.lv.Enabled=false
    else
        YS.lv.Enabled=true
        local spd=getActiveMoveSpeed()
        local md=hum.MoveDirection
        if md.Magnitude>0.1 then
            lastMoveDir=md
            local flat=Vector3.new(md.X,0,md.Z).Unit
            YS.lv.PlaneVelocity=Vector2.new(flat.X*spd,flat.Z*spd)
        elseif antiRagdollEnabled and lastMoveDir.Magnitude>0 then
            local anyHeld=false
            for key in pairs(MOVE_KEYS) do if UIS:IsKeyDown(key) then anyHeld=true; break end end
            if anyHeld then
                local f=Vector3.new(lastMoveDir.X,0,lastMoveDir.Z).Unit
                YS.lv.PlaneVelocity=Vector2.new(f.X*spd,f.Z*spd)
            else YS.lv.PlaneVelocity=Vector2.zero end
        else
            YS.lv.PlaneVelocity=Vector2.zero
        end
    end
    if speedLabel then speedLabel.Text=string.format("%.1f",Vector3.new(hrp.Velocity.X,0,hrp.Velocity.Z).Magnitude) end
end
RunService.Heartbeat:Connect((newcclosure and newcclosure(_ysStep)) or _ysStep)
LP.CharacterAdded:Connect(function() ysClean() end)
end
LP.CharacterAdded:Connect(function(char)
    task.wait(0.5);setupSpeedIndicator(char);setupRagdollTriggers()
    if medusaCounterEnabled then setupMedusa(char) end
    if batCounterEnabled then startBatCounter() end
    if unwalkEnabled then task.wait(0.5);startUnwalk() end
    -- Restaureaza starea de speed dupa respawn
    if refreshSpeedModeLabel then refreshSpeedModeLabel() end
    if mobBtnRefs.carrySpeed then mobBtnRefs.carrySpeed(carrySpeedActive) end
    if mobBtnRefs.lagger then mobBtnRefs.lagger(laggerModeEnabled) end
end)
if LP.Character then setupSpeedIndicator(LP.Character);setupRagdollTriggers() end
local alConn,arConn=nil,nil;local alPhase,arPhase=1,1
stopAutoLeft=function()
    if alConn then alConn:Disconnect();alConn=nil end;alPhase=1
    local char=LP.Character;if char then local h=char:FindFirstChildOfClass("Humanoid");if h then h:Move(Vector3.zero,false) end end
    if autoLeftSetVisual then autoLeftSetVisual(false) end
    if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end
end
stopAutoRight=function()
    if arConn then arConn:Disconnect();arConn=nil end;arPhase=1
    local char=LP.Character;if char then local h=char:FindFirstChildOfClass("Humanoid");if h then h:Move(Vector3.zero,false) end end
    if autoRightSetVisual then autoRightSetVisual(false) end
    if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end
end
startAutoLeft=function()
    if alConn then alConn:Disconnect() end;alPhase=1
    alConn=RunService.Heartbeat:Connect(function()
        if not autoLeftEnabled then return end
        local char=LP.Character;if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart");local hum=char:FindFirstChildOfClass("Humanoid");if not hrp or not hum then return end
        if isRagdollState(hum) then hum:Move(Vector3.zero,false);return end
        local spd=getAutoPathSpeed()
        if alPhase==1 then
            local tgt=Vector3.new(AP_L1.X,hrp.Position.Y,AP_L1.Z)
            if (tgt-hrp.Position).Magnitude<1 then alPhase=2;local d=AP_L2-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);hrp.Velocity=Vector3.new(mv.X*spd,hrp.Velocity.Y,mv.Z*spd);return end
            local d=AP_L1-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);hrp.Velocity=Vector3.new(mv.X*spd,hrp.Velocity.Y,mv.Z*spd)
        elseif alPhase==2 then
            local tgt=Vector3.new(AP_L2.X,hrp.Position.Y,AP_L2.Z)
            if (tgt-hrp.Position).Magnitude<1 then hum:Move(Vector3.zero,false);hrp.Velocity=Vector3.zero;autoLeftEnabled=false;if alConn then alConn:Disconnect();alConn=nil end;alPhase=1;if autoLeftSetVisual then autoLeftSetVisual(false) end;if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end;return end
            local d=AP_L2-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);hrp.Velocity=Vector3.new(mv.X*spd,hrp.Velocity.Y,mv.Z*spd)
        end
        if autoMoveSwingEnabled and not _alSwingDebounce then
            _alSwingDebounce=true
            local bat=findBat()
            if bat then
                if bat.Parent~=char then pcall(function() hum:EquipTool(bat) end) end
                pcall(function() bat:Activate() end)
            end
            task.delay(autoMoveSwingInterval,function() _alSwingDebounce=false end)
        end
    end)
end
startAutoRight=function()
    if arConn then arConn:Disconnect() end;arPhase=1
    arConn=RunService.Heartbeat:Connect(function()
        if not autoRightEnabled then return end
        local char=LP.Character;if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart");local hum=char:FindFirstChildOfClass("Humanoid");if not hrp or not hum then return end
        if isRagdollState(hum) then hum:Move(Vector3.zero,false);return end
        local spd=getAutoPathSpeed()
        if arPhase==1 then
            local tgt=Vector3.new(AP_R1.X,hrp.Position.Y,AP_R1.Z)
            if (tgt-hrp.Position).Magnitude<1 then arPhase=2;local d=AP_R2-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);hrp.Velocity=Vector3.new(mv.X*spd,hrp.Velocity.Y,mv.Z*spd);return end
            local d=AP_R1-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);hrp.Velocity=Vector3.new(mv.X*spd,hrp.Velocity.Y,mv.Z*spd)
        elseif arPhase==2 then
            local tgt=Vector3.new(AP_R2.X,hrp.Position.Y,AP_R2.Z)
            if (tgt-hrp.Position).Magnitude<1 then hum:Move(Vector3.zero,false);hrp.Velocity=Vector3.zero;autoRightEnabled=false;if arConn then arConn:Disconnect();arConn=nil end;arPhase=1;if autoRightSetVisual then autoRightSetVisual(false) end;if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end;return end
            local d=AP_R2-hrp.Position;local mv=Vector3.new(d.X,0,d.Z).Unit;hum:Move(mv,false);hrp.Velocity=Vector3.new(mv.X*spd,hrp.Velocity.Y,mv.Z*spd)
        end
        if autoMoveSwingEnabled and not _arSwingDebounce then
            _arSwingDebounce=true
            local bat=findBat()
            if bat then
                if bat.Parent~=char then pcall(function() hum:EquipTool(bat) end) end
                pcall(function() bat:Activate() end)
            end
            task.delay(autoMoveSwingInterval,function() _arSwingDebounce=false end)
        end
    end)
end
-- ============================================================
-- DROP BRAINROT
-- ============================================================
local _wfConns={}
local function runDrop()
    if dropActive then return end
    if autoBatEnabled then autoBatEnabled=false; if resetAutoBatMotion then resetAutoBatMotion() end; if autoBatSetVisual then autoBatSetVisual(false) end end
    dropActive=true
    local colConn=RunService.Stepped:Connect(function()
        if not dropActive then return end
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then for _,part in ipairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide=false end end end end
    end)
    table.insert(_wfConns,colConn)
    local flingThread=coroutine.create(function()
        while dropActive do RunService.Heartbeat:Wait(); local c=LP.Character; local root=c and c:FindFirstChild("HumanoidRootPart"); if not root then break end; local vel=root.Velocity; root.Velocity=vel*10000+Vector3.new(0,10000,0); RunService.RenderStepped:Wait(); if root and root.Parent then root.Velocity=vel end; RunService.Stepped:Wait(); if root and root.Parent then root.Velocity=vel+Vector3.new(0,0.1,0) end end
    end)
    table.insert(_wfConns,flingThread); coroutine.resume(flingThread)
    task.delay(0.1,function()
        dropActive=false
        for _,c in ipairs(_wfConns) do if typeof(c)=="RBXScriptConnection" then c:Disconnect() elseif type(c)=="thread" then pcall(coroutine.close,c) end end
        _wfConns={}
    end)
end
local function doAutoTPDown(force)
    local char=LP.Character;if not char then return end;local hrp=char:FindFirstChild("HumanoidRootPart");if not hrp then return end
    local hum2=char:FindFirstChildOfClass("Humanoid");if not hum2 then return end
    if not force then if hum2.FloorMaterial~=Enum.Material.Air then return end;if not(hrp.Position.Y>=autoTPHeight) then return end end
    hrp.CFrame=CFrame.new(hrp.Position.X,-7.00,hrp.Position.Z)*CFrame.Angles(0,select(2,hrp.CFrame:ToEulerAnglesYXZ()),0);hrp.Velocity=Vector3.zero
end
startAutoTP=function()
    if autoTPConn then task.cancel(autoTPConn);autoTPConn=nil end
    autoTPConn=task.spawn(function() while autoTPEnabled do task.wait(0.1);pcall(function() doAutoTPDown(false) end) end end)
end
stopAutoTP=function() autoTPEnabled=false;if autoTPConn then task.cancel(autoTPConn);autoTPConn=nil end end
runTPFloor=function() pcall(function() doAutoTPDown(true) end) end
local STRETCH_NAME="Movee_Stretch"
enableStretchRez=function()
    stretchRezEnabled=true;if stretchRezConn then stretchRezConn:Disconnect() end
    pcall(function() RunService:UnbindFromRenderStep(STRETCH_NAME) end)
    pcall(function() RunService:BindToRenderStep(STRETCH_NAME,Enum.RenderPriority.Last.Value-1,function() local cam=workspace.CurrentCamera;if cam then cam.CFrame=cam.CFrame*CFrame.new(0,0,0,1,0,0,0,0.8,0,0,0,1) end end) end)
end
disableStretchRez=function() stretchRezEnabled=false;pcall(function() RunService:UnbindFromRenderStep(STRETCH_NAME) end) end
local defLightBrightness,defLightClock,defLightAmbient
local function applyAntiLagDerender(obj)
    pcall(function()
        if obj:IsA("Accessory") or obj:IsA("Hat") then obj:Destroy()
        elseif obj:IsA("BasePart") then obj.Material=Enum.Material.Plastic;obj.Reflectance=0;obj.CastShadow=false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency=1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then obj.Enabled=false end
    end)
end
enableAntiLag=function()
    removeAccessoriesEnabled=true;antiLagEnabled=true
    defLightBrightness=defLightBrightness or Lighting.Brightness;defLightClock=defLightClock or Lighting.ClockTime;defLightAmbient=defLightAmbient or Lighting.OutdoorAmbient
    Lighting.GlobalShadows=false;Lighting.FogEnd=1e10;Lighting.Brightness=1;Lighting.EnvironmentDiffuseScale=0;Lighting.EnvironmentSpecularScale=0
    for _,e in pairs(Lighting:GetChildren()) do pcall(function() if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled=false end end) end
    for _,obj in ipairs(workspace:GetDescendants()) do applyAntiLagDerender(obj) end
    if antiLagDescConn then antiLagDescConn:Disconnect() end
    antiLagDescConn=workspace.DescendantAdded:Connect(function(obj) if removeAccessoriesEnabled then applyAntiLagDerender(obj) end end)
end
disableAntiLag=function()
    removeAccessoriesEnabled=false;antiLagEnabled=false;if antiLagDescConn then antiLagDescConn:Disconnect();antiLagDescConn=nil end
    pcall(function() if defLightBrightness then Lighting.Brightness=defLightBrightness end;if defLightClock then Lighting.ClockTime=defLightClock end;if defLightAmbient then Lighting.OutdoorAmbient=defLightAmbient end;Lighting.ExposureCompensation=0 end)
end
local function findMedusa()
    local c=LP.Character;if not c then return nil end
    for _,t in ipairs(c:GetChildren()) do if t:IsA("Tool") then local n=t.Name:lower();if n:find("medusa") or n:find("head") or n:find("stone") then return t end end end
    local bp=LP:FindFirstChild("Backpack");if bp then for _,t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then local n=t.Name:lower();if n:find("medusa") or n:find("head") or n:find("stone") then return t end end end end
    return nil
end
local function useMedusaCounter()
    if medusaDebounce then return end;if MEDUSA_COOLDOWN>(tick()-medusaLastUsed) then return end
    local c=LP.Character;if not c then return end;medusaDebounce=true
    local med=findMedusa();if not med then medusaDebounce=false;return end
    if med.Parent~=c then local hum2=c:FindFirstChildOfClass("Humanoid");if hum2 then hum2:EquipTool(med) end end
    pcall(function() med:Activate() end);medusaLastUsed=tick();medusaDebounce=false
end
local function onAnchorChanged(part)
    return part:GetPropertyChangedSignal("Anchored"):Connect(function()
        if part.Anchored and part.Transparency==1 then
            if RXZ.medusaReset then
                cursedInstaReset()
            elseif medusaCounterEnabled then
                useMedusaCounter()
            end
        end
    end)
end
setupMedusa=function(char)
    for _,c in pairs(Conns.anchor) do pcall(function() c:Disconnect() end) end;Conns.anchor={}
    if not char then return end
    for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then table.insert(Conns.anchor,onAnchorChanged(part)) end end
    table.insert(Conns.anchor,char.DescendantAdded:Connect(function(part) if part:IsA("BasePart") then table.insert(Conns.anchor,onAnchorChanged(part)) end end))
end
stopMedusaCounter=function() for _,c in pairs(Conns.anchor) do pcall(function() c:Disconnect() end) end;Conns.anchor={} end
local BAT_COUNTER_SLAP_LIST={"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}
local function findBatForCounter()
    local c=LP.Character;if not c then return nil end;local bp=LP:FindFirstChildOfClass("Backpack")
    for _,name in ipairs(BAT_COUNTER_SLAP_LIST) do local t=c:FindFirstChild(name) or (bp and bp:FindFirstChild(name));if t then return t end end
    for _,ch in ipairs(c:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end
    if bp then for _,ch in ipairs(bp:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end end
    return nil
end
local function swingBatForCounter(bat,char)
    local hum2=char:FindFirstChildOfClass("Humanoid")
    if bat.Parent~=char then if hum2 then pcall(function() hum2:EquipTool(bat) end) end;task.wait(0.05) end
    local remote=bat:FindFirstChildOfClass("RemoteEvent") or bat:FindFirstChildOfClass("RemoteFunction")
    if remote and remote:IsA("RemoteEvent") then pcall(function() remote:FireServer() end);task.wait(0.15);pcall(function() remote:FireServer() end)
    else pcall(function() bat:Activate() end);task.wait(0.15);pcall(function() bat:Activate() end) end
end
startBatCounter=function()
    if Conns.batCounter then return end
    Conns.batCounter=RunService.Heartbeat:Connect(function()
        if not batCounterEnabled or batCounterDebounce then return end
        local char=LP.Character;if not char then return end;local hum2=char:FindFirstChildOfClass("Humanoid");if not hum2 then return end
        local st=hum2:GetState()
        if st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown then
            batCounterDebounce=true;task.spawn(function() local bat=findBatForCounter();if bat then swingBatForCounter(bat,char) end;task.wait(0.5);batCounterDebounce=false end)
        end
    end)
end
stopBatCounter=function() if Conns.batCounter then Conns.batCounter:Disconnect();Conns.batCounter=nil end;batCounterDebounce=false end
local aimbotConn=nil
-- Ã¢ÂÂÃ¢ÂÂ Bat Aimbot (Envy logic) Ã¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂÃ¢ÂÂ
local _predBall=nil
local function findBat()
    local char=LP.Character;if not char then return nil end
    for _,tool in ipairs(char:GetChildren()) do if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then return tool end end
    local bp=LP:FindFirstChild("Backpack");if bp then for _,tool in ipairs(bp:GetChildren()) do if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then return tool end end end
    return nil
end
local function getClosestTarget()
    local root=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart");if not root then return nil end
    local closest,minDist=nil,math.huge
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP and plr.Character then
            local tRoot=plr.Character:FindFirstChild("HumanoidRootPart");local hum=plr.Character:FindFirstChildOfClass("Humanoid")
            if tRoot and hum and hum.Health>0 then local dist=(tRoot.Position-root.Position).Magnitude;if dist<minDist then minDist=dist;closest=tRoot end end
        end
    end
    return closest
end
local function swingCurrentBat()
    if not autoSwingEnabled then return end;local bat=findBat()
    if bat and bat.Parent==LP.Character and bat:IsA("Tool") then pcall(function() bat:Activate() end) end
end
startBatAimbot=function()
    if aimbotConn then aimbotConn:Disconnect() end;autoBatEnabled=true
    if autoLeftEnabled then autoLeftEnabled=false;if autoLeftSetVisual then autoLeftSetVisual(false) end;stopAutoLeft() end
    if autoRightEnabled then autoRightEnabled=false;if autoRightSetVisual then autoRightSetVisual(false) end;stopAutoRight() end
    local hum0=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum0 then hum0.AutoRotate=false end
    aimbotConn=RunService.RenderStepped:Connect(function()
        if not autoBatEnabled then return end
        local c=LP.Character;if not c then return end
        local root=c:FindFirstChild("HumanoidRootPart");if not root then return end
        local hum=c:FindFirstChildOfClass("Humanoid");if not hum then return end
        if not c:FindFirstChildOfClass("Tool") then
            local bat=findBat()
            if bat then pcall(function() hum:EquipTool(bat) end) end
        end
        local target=getClosestTarget()
        if not target then swingCurrentBat();return end
        local targetVel=target.AssemblyLinearVelocity
        local myPos=root.Position
        local targetPos=target.Position
        local predictPos=targetPos+targetVel*0.14
        predictPos=predictPos+target.CFrame.LookVector*0.3
        local direction=predictPos-myPos
        local flatDir=Vector3.new(direction.X,0,direction.Z).Unit
        local chaseSpeed=58
        local desiredHeight=targetPos.Y+3.7
        local yVel=(desiredHeight-myPos.Y)*19.5+targetVel.Y*0.8
        if hum.FloorMaterial~=Enum.Material.Air then
            yVel=math.max(yVel,13)
        end
        yVel=math.clamp(yVel,-70,110)
        local desiredVel=Vector3.new(flatDir.X*chaseSpeed,yVel,flatDir.Z*chaseSpeed)
        root.AssemblyLinearVelocity=root.AssemblyLinearVelocity:Lerp(desiredVel,0.8)
        local speed3=targetVel.Magnitude
        local predictTime=math.clamp(speed3/150,0.05,0.2)
        local predictedPos=targetPos+targetVel*predictTime
        local toPredict=predictedPos-myPos
        if toPredict.Magnitude>0.1 then
            local goalCF=CFrame.lookAt(myPos,predictedPos)
            local curCF=root.CFrame
            local diffCF=curCF:Inverse()*goalCF
            local rx,ry,rz=diffCF:ToEulerAnglesXYZ()
            rx=math.clamp(rx,-2.5,2.5)
            ry=math.clamp(ry,-2.5,2.5)
            rz=math.clamp(rz,-2.5,2.5)
            local tiltSpeed=42
            root.AssemblyAngularVelocity=root.CFrame:VectorToWorldSpace(
                Vector3.new(rx*tiltSpeed,ry*tiltSpeed,rz*tiltSpeed)
            )
        end
        swingCurrentBat()
    end)
    if autoBatSetVisual then autoBatSetVisual(true) end
    if mobBtnRefs and mobBtnRefs.autoBat then mobBtnRefs.autoBat(true) end
end
stopBatAimbot=function()
    if aimbotConn then aimbotConn:Disconnect();aimbotConn=nil end;autoBatEnabled=false
    if _predBall then _predBall:Destroy();_predBall=nil end
    local char=LP.Character;local root=char and char:FindFirstChild("HumanoidRootPart")
    if root then root.AssemblyLinearVelocity=Vector3.zero;root.AssemblyAngularVelocity=Vector3.zero end
    local hum2=char and char:FindFirstChildOfClass("Humanoid");if hum2 then hum2.AutoRotate=true end
    if autoTPEnabled then startAutoTP() end
    if autoBatSetVisual then autoBatSetVisual(false) end
    if mobBtnRefs and mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end
end
queueAutoBatStart=function()
    if autoLeftEnabled then autoLeftEnabled=false;if autoLeftSetVisual then autoLeftSetVisual(false) end;stopAutoLeft() end
    if autoRightEnabled then autoRightEnabled=false;if autoRightSetVisual then autoRightSetVisual(false) end;stopAutoRight() end
    startBatAimbot()
end
resetAutoBatMotion=function()
    local char=LP.Character;local hrp=char and char:FindFirstChild("HumanoidRootPart");local hum=char and char:FindFirstChildOfClass("Humanoid")
    if hrp then hrp.AssemblyLinearVelocity=hrp.AssemblyLinearVelocity*0.3;hrp.AssemblyAngularVelocity=Vector3.zero end
    if hum then hum.AutoRotate=true end
end
saveConfig=function()
    local function ks(e)
        if e.kb then return {kb=e.kb.Name,gp=e.gp and e.gp.Name}
        elseif e.gp then return {gp=e.gp.Name}
        else return {kb=nil,gp=nil} end
    end
    local cfg={normalSpeed=NS,carrySpeed=CS,dropBrainrotKey=ks(KB.DropBrainrot),autoLeftKey=ks(KB.AutoLeft),autoRightKey=ks(KB.AutoRight),autoBatKey=ks(KB.AutoBat),laggerToggleKey=ks(KB.LaggerToggle),tpFloorKey=ks(KB.TPFloor),instaResetKey=ks(KB.InstaReset),guiHideKey=ks(KB.GuiHide),speedToggleKey=ks(KB.SpeedToggle),grabRadius=Steal.StealRadius,stealDuration=Steal.StealDuration,antiRagdoll=antiRagdollEnabled,autoStealEnabled=Steal.AutoStealEnabled,infiniteJump=infJumpEnabled,infJumpMode=infJumpMode,medusaCounter=medusaCounterEnabled,batCounter=batCounterEnabled,carrySpeedActive=carrySpeedActive,laggerModeEnabled=laggerModeEnabled,laggerSpeed=LAGGER_SPEED,laggerCarrySpeed=LAGGER_CARRY_SPEED,autoBat=autoBatEnabled,autoSwing=autoSwingEnabled,unwalkEnabled=unwalkEnabled,antiLag=antiLagEnabled,stretchRez=stretchRezEnabled,autoTPEnabled=autoTPEnabled,autoTPHeight=autoTPHeight,guiTransparencyEnabled=guiTransparencyEnabled,mobileButtonsEnabled=mobileButtonsEnabled,mobileButtonsLocked=mobileButtonsLocked,mobileButtonsSize=mobileButtonsSize,circleButtonsEnabled=circleButtonsEnabled,fovValue=fovValue,perButtonDrag=perButtonDragEnabled,skyTheme=currentSkyTheme,medusaReset=RXZ.medusaReset,autoMoveSwing=autoMoveSwingEnabled,autoMoveSwingInterval=autoMoveSwingInterval,ragdollGui=ragdollGuiEnabled,introSoundEnabled=introSoundEnabled,animEnabled=animEnabled,backgroundEnabled=backgroundEnabled,backgroundIndex=backgroundIndex,laggerBtn=RXZ.laggerBtn,antiMedusa=RXZ.antiMedusa,lockAll=uiLocked,lagLevel=RXZ.lagLevel,keys=(function() if not _GuiKeys then return {} end;local t={};for k,v in pairs(_GuiKeys) do t[k]=v.Name end;return t end)()}
    if writefile then pcall(function() writefile("RXZ_HUB.json",HS:JSONEncode(cfg)) end) end
end
task.spawn(function() while task.wait(5) do saveConfig() end end)
local function resetAllSettings()
    NS=59;CS=29;LAGGER_SPEED=30;LAGGER_CARRY_SPEED=15;carrySpeedActive=false;laggerModeEnabled=false
    antiRagdollEnabled=false;infJumpEnabled=false;infJumpMode="manual"
    medusaCounterEnabled=false;batCounterEnabled=false;unwalkEnabled=false
    RXZ.medusaReset=false
    autoLeftEnabled=false;autoRightEnabled=false;autoBatEnabled=false;autoSwingEnabled=true;autoMoveSwingEnabled=false
    autoTPEnabled=false;autoTPHeight=20;antiLagEnabled=false;stretchRezEnabled=false
    Steal.AutoStealEnabled=false;Steal.StealRadius=60;Steal.StealDuration=1.4
    guiTransparencyEnabled=false;mobileButtonsEnabled=true;mobileButtonsSize=80
    circleButtonsEnabled=false;uiLocked=false;fovValue=80;fovIndex=1
    introSoundEnabled=true
    KB.DropBrainrot={kb=nil,gp=nil};KB.AutoLeft={kb=nil,gp=nil};KB.AutoRight={kb=nil,gp=nil}
    KB.AutoBat={kb=nil,gp=nil};KB.TPFloor={kb=nil,gp=nil};KB.InstaReset={kb=nil,gp=nil}
    KB.GuiHide={kb=nil,gp=nil};KB.SpeedToggle={kb=nil,gp=nil};KB.LaggerToggle={kb=nil,gp=nil}
    if refreshSpeedModeLabel then refreshSpeedModeLabel() end
    if mobBtnRefs.carrySpeed then mobBtnRefs.carrySpeed(carrySpeedActive) end
    if mobBtnRefs.lagger then mobBtnRefs.lagger(laggerModeEnabled) end
    if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end
    if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end
    if mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end
    stopBatAimbot();stopAutoSteal();stopAutoLeft();stopAutoRight();stopAntiRagdoll();stopAutoTP();stopHoldInfJump()
    if stretchRezEnabled then disableStretchRez() end;if antiLagEnabled then disableAntiLag() end;saveConfig()
end
local setInstaGrab,setInfJumpVisual,setAntiRagVisual,setMedusaVisual,setUnwalkVisual,setAntiLagVisual,setAutoSwingVisual
local setTranspVisual,setLockVisual,setMobVisual,setCircleBtnsVisual
local normalBox,carryBox,laggerBox,radInput,autoTPHeightBox,durationBox
local mainFrame=nil
local _persistentConns={}
local function trackConn(conn) table.insert(_persistentConns,conn);return conn end
local function clearPersistentConns() for _,c in ipairs(_persistentConns) do pcall(function() c:Disconnect() end) end;_persistentConns={} end

refreshSpeedModeLabel=function()
    if modeValLbl then
        if laggerModeEnabled then 
            modeValLbl.Text = carrySpeedActive and "Lagger Carry" or "Lagger Mode"
        elseif carrySpeedActive then modeValLbl.Text="Carry"
        else modeValLbl.Text="Normal" end
    end
    if laggerModePillRef and laggerModePillRef.pill and laggerModePillRef.dot then
        local pill=laggerModePillRef.pill;local dot=laggerModePillRef.dot;local on=laggerModeEnabled
        local WHITE=Color3.fromRGB(255,255,255);local OFF=Color3.fromRGB(46,24,38);local GRAY=Color3.fromRGB(180,150,165)
        TweenService:Create(pill,TweenInfo.new(0.16,Enum.EasingStyle.Quad),{BackgroundColor3=on and WHITE or OFF}):Play()
        TweenService:Create(dot,TweenInfo.new(0.16,Enum.EasingStyle.Back),{Position=on and UDim2.new(1,-13,0.5,-5) or UDim2.new(0,3,0.5,-5),BackgroundColor3=on and Color3.fromRGB(30,30,30) or GRAY}):Play()
    end
    if carryModePillRef and carryModePillRef.pill and carryModePillRef.dot then
        local pill=carryModePillRef.pill;local dot=carryModePillRef.dot;local on=carrySpeedActive
        local WHITE=Color3.fromRGB(255,255,255);local OFF=Color3.fromRGB(46,24,38);local GRAY=Color3.fromRGB(180,150,165)
        TweenService:Create(pill,TweenInfo.new(0.16,Enum.EasingStyle.Quad),{BackgroundColor3=on and WHITE or OFF}):Play()
        TweenService:Create(dot,TweenInfo.new(0.16,Enum.EasingStyle.Back),{Position=on and UDim2.new(1,-13,0.5,-5) or UDim2.new(0,3,0.5,-5),BackgroundColor3=on and Color3.fromRGB(30,30,30) or GRAY}):Play()
    end
end
local _prevCarryBeforeLagger = false
toggleCarryMode=function()
    -- Toggle between Normal Speed and Carry Speed (exit lagger if active)
    if laggerModeEnabled then
        laggerModeEnabled = false
    end
    carrySpeedActive = not carrySpeedActive
    refreshSpeedModeLabel()
    if mobBtnRefs.carrySpeed then mobBtnRefs.carrySpeed(carrySpeedActive) end
    if mobBtnRefs.lagger then mobBtnRefs.lagger(laggerModeEnabled) end
end
toggleLaggerMode=function()
    if not laggerModeEnabled then
        -- Activeaza lagger mode si salveaza carry state
        _prevCarryBeforeLagger = carrySpeedActive
        laggerModeEnabled = true
        carrySpeedActive = false
    else
        -- Lagger e activ: dezactiveaza-l si restaureaza carry state
        laggerModeEnabled = false
        carrySpeedActive = _prevCarryBeforeLagger
    end
    refreshSpeedModeLabel()
    if mobBtnRefs.carrySpeed then mobBtnRefs.carrySpeed(carrySpeedActive) end
    if mobBtnRefs.lagger then mobBtnRefs.lagger(laggerModeEnabled) end
end
local function speedToggleAction()
    -- Q key: does nothing (carry toggle is only on customizable carryMode keybind)
end
startAntiRagdoll=function()
    if Conns.antiRag then return end
    Conns.antiRag=RunService.Heartbeat:Connect(function()
        if not antiRagdollEnabled then return end
        local c=LP.Character;if not c then return end
        local hum=c:FindFirstChildOfClass("Humanoid");local root=c:FindFirstChild("HumanoidRootPart")
        if not (hum and root) then return end
        local s=hum:GetState()
        local ragdolled=(s==Enum.HumanoidStateType.Physics or s==Enum.HumanoidStateType.Ragdoll or s==Enum.HumanoidStateType.FallingDown)
        local endTime=LP:GetAttribute("RagdollEndTime")
        if endTime and (endTime-workspace:GetServerTimeNow())>0 then ragdolled=true end
        if ragdolled then
            pcall(function() LP:SetAttribute("RagdollEndTime",workspace:GetServerTimeNow()) end)
            for _,d in ipairs(c:GetDescendants()) do
                if d:IsA("BallSocketConstraint") or (d:IsA("Attachment") and d.Name:find("RagdollAttachment")) then
                    d:Destroy()
                end
            end
            for _,obj in ipairs(c:GetDescendants()) do
                if obj:IsA("Motor6D") and obj.Enabled==false then obj.Enabled=true end
            end
            if hum.Health>0 then hum:ChangeState(Enum.HumanoidStateType.Running) end
            workspace.CurrentCamera.CameraSubject=hum
            root.Anchored=false
            root.AssemblyLinearVelocity=Vector3.zero
            root.AssemblyAngularVelocity=Vector3.zero
        end
    end)
end
stopAntiRagdoll=function() if Conns.antiRag then Conns.antiRag:Disconnect();Conns.antiRag=nil end end
startUnwalk=function()
    local c=LP.Character;if not c then return end;local hum=c:FindFirstChildOfClass("Humanoid")
    if hum then for _,t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop() end end
    local anim=c:FindFirstChild("Animate");if anim then unwalkSavedAnimate=anim:Clone();anim:Destroy() end
end
stopUnwalk=function() local c=LP.Character;if c and unwalkSavedAnimate then unwalkSavedAnimate:Clone().Parent=c;unwalkSavedAnimate=nil end end


-- ============================================================
-- STEAL BAR (alb/negru)
-- ============================================================
local function createStealBar()
    for _,n in ipairs({"MoveeStealBar"}) do
        local old=game:GetService("CoreGui"):FindFirstChild(n);if old then old:Destroy() end
        local pgui=LP:FindFirstChild("PlayerGui");if pgui then local o=pgui:FindFirstChild(n);if o then o:Destroy() end end
    end
    local WHITE=Color3.fromRGB(255,255,255)
    local BARBG=Color3.fromRGB(18,10,15)
    local SB_W,SB_H=250,26
    local stealGui=Instance.new("ScreenGui");stealGui.Name="MoveeStealBar";stealGui.ResetOnSpawn=false;stealGui.IgnoreGuiInset=true;stealGui.DisplayOrder=8
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(stealGui) end end)
    if not pcall(function() stealGui.Parent=game:GetService("CoreGui") end) then stealGui.Parent=LP:WaitForChild("PlayerGui") end
    stealBarFrame=Instance.new("Frame",stealGui)
    stealBarFrame.Size=UDim2.new(0,SB_W,0,SB_H);stealBarFrame.Position=UDim2.new(0.5,-SB_W/2,0.06,0)
    stealBarFrame.BackgroundColor3=BARBG;stealBarFrame.BorderSizePixel=0;stealBarFrame.ZIndex=20;stealBarFrame.ClipsDescendants=true
    Instance.new("UICorner",stealBarFrame).CornerRadius=UDim.new(1,0)
    local sbStroke=Instance.new("UIStroke",stealBarFrame);sbStroke.Color=WHITE;sbStroke.Thickness=2;sbStroke.Transparency=0.3
    task.spawn(function()
        local t=0
        while sbStroke and sbStroke.Parent do
            t=t+0.05
            sbStroke.Transparency=0.2+math.abs(math.sin(t*2))*0.35
            sbStroke.Color=Color3.fromRGB(255,255,255)
            task.wait(0.04)
        end
    end)
    local fillLine=Instance.new("Frame",stealBarFrame);fillLine.Size=UDim2.new(0,0,1,0)
    fillLine.BackgroundColor3=WHITE;fillLine.BorderSizePixel=0;fillLine.ZIndex=21
    Instance.new("UICorner",fillLine).CornerRadius=UDim.new(1,0)
    local fillGrad=Instance.new("UIGradient",fillLine)
    fillGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(200,200,200)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(200,200,200))})
    local stealSection=Instance.new("Frame",stealBarFrame)
    stealSection.Size=UDim2.new(0,110,1,0);stealSection.Position=UDim2.new(0,12,0,0)
    stealSection.BackgroundTransparency=1;stealSection.ZIndex=25
    local stealLbl=Instance.new("TextLabel",stealSection)
    stealLbl.Size=UDim2.new(0,55,1,0);stealLbl.Position=UDim2.new(0,0,0,0)
    stealLbl.BackgroundTransparency=1;stealLbl.Text="STEAL"
    stealLbl.TextColor3=WHITE;stealLbl.Font=Enum.Font.GothamBlack;stealLbl.TextSize=11
    stealLbl.TextXAlignment=Enum.TextXAlignment.Left;stealLbl.ZIndex=26
    local pctLbl=Instance.new("TextLabel",stealSection)
    pctLbl.Size=UDim2.new(0,50,1,0);pctLbl.Position=UDim2.new(0,55,0,0)
    pctLbl.BackgroundTransparency=1;pctLbl.Text="0%"
    pctLbl.TextColor3=WHITE;pctLbl.Font=Enum.Font.GothamBlack;pctLbl.TextSize=11
    pctLbl.TextXAlignment=Enum.TextXAlignment.Left;pctLbl.ZIndex=26
    local div1=Instance.new("Frame",stealBarFrame);div1.Size=UDim2.new(0,1,0,SB_H*0.5);div1.Position=UDim2.new(0,126,0.5,-(SB_H*0.5)/2)
    div1.BackgroundColor3=WHITE;div1.BackgroundTransparency=0.6;div1.BorderSizePixel=0;div1.ZIndex=25
    local pingLbl=Instance.new("TextLabel",stealBarFrame)
    pingLbl.Size=UDim2.new(0,105,1,0);pingLbl.Position=UDim2.new(0,136,0,0)
    pingLbl.BackgroundTransparency=1;pingLbl.Text="PING: --"
    pingLbl.TextColor3=WHITE;pingLbl.Font=Enum.Font.GothamBold;pingLbl.TextSize=10
    pingLbl.TextXAlignment=Enum.TextXAlignment.Left;pingLbl.ZIndex=26
    task.spawn(function()
        while pingLbl and pingLbl.Parent do
            pcall(function()
                local ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
                local pingColor
                if ping<80 then pingColor=Color3.fromRGB(0,255,120)
                elseif ping<150 then pingColor=Color3.fromRGB(255,200,0)
                else pingColor=Color3.fromRGB(255,60,60) end
                pingLbl.Text="PING: "..tostring(ping).."ms"
                pingLbl.TextColor3=pingColor
            end)
            task.wait(0.5)
        end
    end)
    task.spawn(function()
        while fillLine and fillLine.Parent do
            local now=tick()
            if Steal.AutoStealEnabled then
                local inRadius=isNearPodiumWithPrompt()
                local pct=0
                if isStealing and stealStartTime then
                    pct=math.clamp((now-stealStartTime)/Steal.StealDuration,0,1)
                    fillLine.Size=UDim2.new(pct,0,1,0);fillGrad.Offset=Vector2.new(math.sin(now*3)*0.5,0)
                elseif inRadius then
                    local cyclePos=(now%Steal.StealDuration)/Steal.StealDuration
                    pct=cyclePos*cyclePos*(3-2*cyclePos)
                    fillLine.Size=UDim2.new(pct,0,1,0);fillGrad.Offset=Vector2.new(math.sin(now*3)*0.5,0)
                else fillLine.Size=UDim2.new(0,0,1,0) end
                pctLbl.Text=math.floor(pct*100).."%"
            else
                fillLine.Size=UDim2.new(0,0,1,0);pctLbl.Text="0%"
            end
            task.wait(0.016)
        end
    end)
    local dragStart2,dragStartPos2,dragging2=nil,nil,false
    stealBarFrame.InputBegan:Connect(function(input)
        if uiLocked then return end
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging2=true;dragStart2=input.Position;dragStartPos2=stealBarFrame.Position
            input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging2=false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if uiLocked then dragging2=false;return end
        if dragging2 and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
            local delta=input.Position-dragStart2
            stealBarFrame.Position=UDim2.new(dragStartPos2.X.Scale,dragStartPos2.X.Offset+delta.X,dragStartPos2.Y.Scale,dragStartPos2.Y.Offset+delta.Y)
        end
    end)
end
createStealBar()

-- ============================================================
-- TP BAT + BAT V2 (no external GUI, integrated in mobile buttons)
-- ============================================================
local RXZ_SLAP_LIST={"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}
function RXZ.findBat()
    local char=LP.Character; if not char then return nil end
    for _,name in ipairs(RXZ_SLAP_LIST) do local t=char:FindFirstChild(name); if t and t:IsA("Tool") then return t end end
    local bp=LP:FindFirstChildOfClass("Backpack")
    if bp then
        for _,name in ipairs(RXZ_SLAP_LIST) do
            local t=bp:FindFirstChild(name)
            if t and t:IsA("Tool") then
                local hum=char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(t) end) end
                return t
            end
        end
    end
    for _,ch in ipairs(char:GetChildren()) do if ch:IsA("Tool") and (ch.Name:lower():find("bat") or ch.Name:lower():find("slap")) then return ch end end
    return nil
end
function RXZ.closestRoot()
    local char=LP.Character
    local root=char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil,math.huge end
    local best,dist=nil,math.huge
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local tr=p.Character:FindFirstChild("HumanoidRootPart")
            local hum=p.Character:FindFirstChildOfClass("Humanoid")
            if tr and hum and hum.Health>0 then
                local d=(tr.Position-root.Position).Magnitude
                if d<dist then dist=d;best=tr end
            end
        end
    end
    return best,dist
end
-- ===== TP BAT =====
function RXZ.tpHit()
    if RXZ.hitCD then return end
    RXZ.hitCD=true
    pcall(function()
        local bat=RXZ.findBat()
        if bat then
            bat:Activate()
            local ev=bat:FindFirstChildWhichIsA("RemoteEvent")
            if ev then ev:FireServer() end
        end
    end)
    task.delay(0.08,function() RXZ.hitCD=false end)
end
function RXZ.startTPBat()
    if RXZ.tpConn then return end
    RXZ.tpBat=true
    RXZ.tpConn=RunService.Heartbeat:Connect(function()
        if not RXZ.tpBat then return end
        local char=LP.Character; if not char then return end
        local hrp=char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local tr=RXZ.closestRoot()
        if tr then
            if sethiddenproperty then pcall(function() sethiddenproperty(hrp,"PhysicsRepRootPart",tr) end) end
            local targetPos=tr.Position+Vector3.new(0,0.9,0)
            if (hrp.Position-targetPos).Magnitude>8 then hrp.CFrame=CFrame.new(targetPos) end
            local cam=workspace.CurrentCamera
            if cam then cam.CFrame=CFrame.new(cam.CFrame.Position,tr.Position) end
            RXZ.tpHit()
        end
    end)
end
function RXZ.stopTPBat()
    if RXZ.tpConn then RXZ.tpConn:Disconnect();RXZ.tpConn=nil end
    RXZ.tpBat=false
end
-- ===== BAT V2 =====
function RXZ.v2Swing()
    if RXZ.v2CD then return end
    RXZ.v2CD=true
    pcall(function()
        local char=LP.Character; if not char then return end
        local bat=RXZ.findBat()
        if bat then
            if bat.Parent~=char then
                local hum=char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(bat) end) end
            end
            pcall(function() bat:Activate() end)
        end
    end)
    task.delay(0.35,function() RXZ.v2CD=false end)
end
function RXZ.startBatV2()
    if RXZ.v2Conn then RXZ.v2Conn:Disconnect() end
    RXZ.batV2=true
    local hum0=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum0 then
        if RXZ.v2Rot==nil then RXZ.v2Rot=hum0.AutoRotate end
        hum0.AutoRotate=false
    end
    RXZ.v2Conn=RunService.RenderStepped:Connect(function()
        if not RXZ.batV2 then return end
        local char=LP.Character; if not char then return end
        local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
        local hum=char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        if not char:FindFirstChildOfClass("Tool") then
            local bat=RXZ.findBat()
            if bat then pcall(function() hum:EquipTool(bat) end) end
        end
        local target,targetDist=RXZ.closestRoot()
        if not target then return end
        local myPos=root.Position
        local targetPos=target.Position
        local direction=targetPos-myPos
        local flatDir=Vector3.new(direction.X,0,direction.Z)
        if flatDir.Magnitude>0 then flatDir=flatDir.Unit else flatDir=Vector3.zero end
        local desiredHeight=targetPos.Y+3.7
        local yVel=(desiredHeight-myPos.Y)*19.5
        if hum.FloorMaterial~=Enum.Material.Air then yVel=math.max(yVel,13) end
        yVel=math.clamp(yVel,-70,110)
        local desiredVel=Vector3.new(flatDir.X*58,yVel,flatDir.Z*58)
        root.AssemblyLinearVelocity=root.AssemblyLinearVelocity:Lerp(desiredVel,0.8)
        local toTarget=targetPos-myPos
        if toTarget.Magnitude>0.1 then
            local goalCF=CFrame.lookAt(myPos,targetPos)
            local diffCF=root.CFrame:Inverse()*goalCF
            local rx,ry,rz=diffCF:ToEulerAnglesXYZ()
            rx=math.clamp(rx,-2.5,2.5);ry=math.clamp(ry,-2.5,2.5);rz=math.clamp(rz,-2.5,2.5)
            root.AssemblyAngularVelocity=root.CFrame:VectorToWorldSpace(Vector3.new(rx*42,ry*42,rz*42))
        end
        if targetDist<=8 then RXZ.v2Swing() end
    end)
end
function RXZ.stopBatV2()
    RXZ.batV2=false
    if RXZ.v2Conn then RXZ.v2Conn:Disconnect();RXZ.v2Conn=nil end
    RXZ.v2CD=false
    local c=LP.Character
    local root=c and c:FindFirstChild("HumanoidRootPart")
    if root then root.AssemblyLinearVelocity=Vector3.zero;root.AssemblyAngularVelocity=Vector3.zero end
    local hum=c and c:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.AutoRotate=(RXZ.v2Rot==nil) and true or RXZ.v2Rot
        hum.PlatformStand=false
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    end
    RXZ.v2Rot=nil
end


-- ============================================================
-- PRE-ROUND FREEZE DETECTION (Night Duels logic, no button)
-- ============================================================
RXZ.freezeAt=0
RXZ.isFrozen=function()
    local ch=LP.Character; if not ch then return false end
    local root=ch:FindFirstChild("HumanoidRootPart"); local hum=ch:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return false end
    if root.Anchored or hum.WalkSpeed<=0.05 or hum.PlatformStand then RXZ.freezeAt=tick(); return true end
    return (tick()-RXZ.freezeAt)<0.35
end

-- ============================================================
-- ANTI MEDUSA COUNTER (toggle in COMBAT)
-- ============================================================
RXZ.antiMedusa=false
RXZ.amdConn=nil; RXZ.medusaSeen=false
RXZ.DEATH_CF=CFrame.new(1000003.56,999999.69,8.17)
RXZ.findCarpet=function()
    local bp=LP:FindFirstChild("Backpack")
    if bp then
        for _,t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") and t.Name:lower():find("carpet") then return t end
        end
    end
    return nil
end
RXZ.antiMedusaReset=function()
    local ch=LP.Character; if not ch then return end
    local root=ch:FindFirstChild("HumanoidRootPart"); local hum=ch:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    local carpet=RXZ.findCarpet()
    if carpet then pcall(function() hum:EquipTool(carpet) end); task.wait(0.1) end
    root.CFrame=RXZ.DEATH_CF
    local conn
    conn=RunService.Heartbeat:Connect(function()
        if not ch or not ch.Parent then conn:Disconnect(); return end
        local r=ch:FindFirstChild("HumanoidRootPart"); if not r then conn:Disconnect(); return end
        r.CFrame=RXZ.DEATH_CF
        local h2=ch:FindFirstChildOfClass("Humanoid")
        if h2 and h2.Health<=0 then conn:Disconnect() end
    end)
end
RXZ.startAntiMedusa=function()
    if RXZ.amdConn then RXZ.amdConn:Disconnect() end
    RXZ.amdConn=RunService.Heartbeat:Connect(function()
        if not RXZ.antiMedusa then return end
        local ch=LP.Character; if not ch then return end
        local has=false
        for _,t in ipairs(ch:GetChildren()) do
            if t:IsA("Tool") then
                local n=t.Name:lower()
                if n:find("medusa") or n:find("head") then
                    has=true
                    if not RXZ.medusaSeen then
                        RXZ.medusaSeen=true
                        task.delay(1,function()
                            if RXZ.antiMedusa and RXZ.medusaSeen then
                                RXZ.antiMedusaReset()
                                RXZ.medusaSeen=false
                            end
                        end)
                    end
                    break
                end
            end
        end
        if not has then RXZ.medusaSeen=false end
    end)
end
RXZ.stopAntiMedusa=function()
    if RXZ.amdConn then RXZ.amdConn:Disconnect(); RXZ.amdConn=nil end
    RXZ.medusaSeen=false
end

-- ============================================================
-- RXZ LAGGER (ex Bless lagger: no intro, no rain, minimizable)
-- ============================================================
RXZ.laggerBtn=false
RXZ.lagOn=false; RXZ.lagThread=nil; RXZ.lagLevel="Low"; RXZ.lagUI=nil
RXZ.lagKey=Enum.KeyCode.M; RXZ.lagListen=false
RXZ.LAG_POWER={Low=25,Mid=32,High=70}
RXZ.lagBomb=function(power)
    local main,spam={},{{}}
    local z=spam[1]
    for _=1,25 do local t={}; table.insert(z,t); z=t end
    local max=math.min(12000,power*50)
    for _=1,max do table.insert(main,spam) end
    pcall(function() game:GetService("RobloxReplicatedStorage").SetPlayerBlockList:FireServer(main) end)
end
RXZ.setLagger=function(on)
    RXZ.lagOn=on
    if on then
        if RXZ.lagThread then pcall(task.cancel,RXZ.lagThread) end
        RXZ.lagThread=task.spawn(function()
            while RXZ.lagOn do
                pcall(function() game:GetService("NetworkClient"):SetOutgoingKBPSLimit(80000) end)
                RXZ.lagBomb(RXZ.LAG_POWER[RXZ.lagLevel] or 25)
                task.wait(0.18)
            end
        end)
    else
        if RXZ.lagThread then pcall(task.cancel,RXZ.lagThread); RXZ.lagThread=nil end
    end
    if RXZ.lagSetVisual then RXZ.lagSetVisual(on) end
end
RXZ.buildLagger=function()
    if RXZ.lagUI and RXZ.lagUI.Parent then return RXZ.lagUI end
    for _,n in ipairs({"RXZ_LAGGER_UI","BlessLagger_UI"}) do
        local old=game:GetService("CoreGui"):FindFirstChild(n); if old then pcall(function() old:Destroy() end) end
        local pgui=LP:FindFirstChild("PlayerGui"); if pgui then local o=pgui:FindFirstChild(n); if o then pcall(function() o:Destroy() end) end end
    end
    local gui=Instance.new("ScreenGui")
    gui.Name="RXZ_LAGGER_UI"; gui.ResetOnSpawn=false; gui.DisplayOrder=20; gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
    if not pcall(function() gui.Parent=game:GetService("CoreGui") end) then gui.Parent=LP:WaitForChild("PlayerGui") end
    RXZ.lagUI=gui

    local W,B,G=Color3.fromRGB(255,255,255),Color3.fromRGB(8,8,8),Color3.fromRGB(150,150,150)

    local panel=Instance.new("Frame",gui)
    panel.Name="Panel"; panel.Size=UDim2.new(0,220,0,120); panel.Position=UDim2.new(0.5,-110,0.28,0)
    panel.BackgroundColor3=B; panel.BorderSizePixel=0; panel.Active=true
    Instance.new("UICorner",panel).CornerRadius=UDim.new(0,12)
    local pStroke=Instance.new("UIStroke",panel); pStroke.Color=Color3.fromRGB(45,45,45); pStroke.Thickness=1.5
    -- smaller panel so it never blocks the gameplay area
    local pScale=Instance.new("UIScale",panel); pScale.Scale=0.85

    local bgImg=Instance.new("ImageLabel",panel)
    bgImg.Size=UDim2.new(1,0,1,0); bgImg.BackgroundTransparency=1; bgImg.ZIndex=0
    bgImg.Image="rbxassetid://137876907823856"; bgImg.ScaleType=Enum.ScaleType.Crop; bgImg.ImageTransparency=0.7
    Instance.new("UICorner",bgImg).CornerRadius=UDim.new(0,12)

    local title=Instance.new("TextLabel",panel)
    title.BackgroundTransparency=1; title.Position=UDim2.new(0,12,0,6); title.Size=UDim2.new(1,-70,0,18)
    title.Text="RXZ LAGGER"; title.TextColor3=W; title.TextSize=14; title.Font=Enum.Font.GothamBlack
    title.TextXAlignment=Enum.TextXAlignment.Left; title.ZIndex=2

    local ver=Instance.new("TextLabel",panel)
    ver.BackgroundTransparency=1; ver.Position=UDim2.new(0,12,0,23); ver.Size=UDim2.new(0,140,0,12)
    ver.Text="discord.gg/rxz"; ver.TextColor3=G; ver.TextSize=9; ver.Font=Enum.Font.GothamBold
    ver.TextXAlignment=Enum.TextXAlignment.Left; ver.ZIndex=2

    local minBtn=Instance.new("TextButton",panel)
    minBtn.Size=UDim2.new(0,22,0,22); minBtn.Position=UDim2.new(1,-30,0,6)
    minBtn.BackgroundColor3=Color3.fromRGB(20,20,20); minBtn.BorderSizePixel=0
    minBtn.Text="-"; minBtn.TextColor3=W; minBtn.Font=Enum.Font.GothamBlack; minBtn.TextSize=18; minBtn.ZIndex=3
    Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,6)

    local restore=Instance.new("TextButton",gui)
    restore.Size=UDim2.new(0,96,0,26); restore.Position=UDim2.new(0.5,-48,0.28,0)
    restore.BackgroundColor3=B; restore.BorderSizePixel=0; restore.Visible=false
    restore.Text="RXZ LAGGER"; restore.TextColor3=W; restore.Font=Enum.Font.GothamBlack; restore.TextSize=10
    Instance.new("UICorner",restore).CornerRadius=UDim.new(0,8)
    local rStroke=Instance.new("UIStroke",restore); rStroke.Color=Color3.fromRGB(45,45,45); rStroke.Thickness=1.2
    minBtn.MouseButton1Click:Connect(function() panel.Visible=false; restore.Visible=true end)
    restore.MouseButton1Click:Connect(function() panel.Visible=true; restore.Visible=false end)

    local kbLbl=Instance.new("TextLabel",panel)
    kbLbl.BackgroundTransparency=1; kbLbl.Position=UDim2.new(0,12,0,44); kbLbl.Size=UDim2.new(0,90,0,16)
    kbLbl.Text="KEYBIND"; kbLbl.TextColor3=W; kbLbl.TextSize=9; kbLbl.Font=Enum.Font.GothamBold
    kbLbl.TextXAlignment=Enum.TextXAlignment.Left; kbLbl.ZIndex=2

    local kbBtn=Instance.new("TextButton",panel)
    kbBtn.Position=UDim2.new(0,72,0,42); kbBtn.Size=UDim2.new(0,30,0,18)
    kbBtn.BackgroundColor3=Color3.fromRGB(22,22,22); kbBtn.BorderSizePixel=0
    kbBtn.Text=RXZ.lagKey.Name; kbBtn.TextColor3=W; kbBtn.TextSize=9; kbBtn.Font=Enum.Font.GothamBold
    kbBtn.AutoButtonColor=false; kbBtn.ZIndex=2
    Instance.new("UICorner",kbBtn).CornerRadius=UDim.new(0,4)

    local pill=Instance.new("Frame",panel)
    pill.Position=UDim2.new(1,-64,0,42); pill.Size=UDim2.new(0,52,0,22)
    pill.BackgroundColor3=Color3.fromRGB(30,30,30); pill.BorderSizePixel=0; pill.ZIndex=2
    Instance.new("UICorner",pill).CornerRadius=UDim.new(1,0)
    local pBtn=Instance.new("TextButton",pill)
    pBtn.Size=UDim2.new(1,0,1,0); pBtn.BackgroundTransparency=1; pBtn.Text="OFF"
    pBtn.TextColor3=W; pBtn.TextSize=10; pBtn.Font=Enum.Font.GothamBold; pBtn.ZIndex=3

    local levelBtns={}
    local function refreshLevels()
        for name,b in pairs(levelBtns) do
            local on=(RXZ.lagLevel==name)
            b.BackgroundColor3=on and W or Color3.fromRGB(22,22,22)
            b.TextColor3=on and Color3.fromRGB(0,0,0) or W
        end
    end
    local order={"Low","Mid","High"}
    for i,name in ipairs(order) do
        local b=Instance.new("TextButton",panel)
        b.Size=UDim2.new(0,62,0,24); b.Position=UDim2.new(0,10+(i-1)*68,0,76)
        b.BackgroundColor3=Color3.fromRGB(22,22,22); b.BorderSizePixel=0; b.AutoButtonColor=false
        b.Text=name:upper(); b.TextColor3=W; b.TextSize=10; b.Font=Enum.Font.GothamBold; b.ZIndex=2
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
        b.MouseButton1Click:Connect(function() RXZ.lagLevel=name; refreshLevels(); if saveConfig then saveConfig() end end)
        levelBtns[name]=b
    end
    refreshLevels()

    RXZ.lagSetVisual=function(on)
        pBtn.Text=on and "ON" or "OFF"
        pill.BackgroundColor3=on and W or Color3.fromRGB(30,30,30)
        pBtn.TextColor3=on and Color3.fromRGB(0,0,0) or W
        if mobBtnRefs and mobBtnRefs.lagPower then mobBtnRefs.lagPower(on) end
    end
    pBtn.MouseButton1Click:Connect(function() RXZ.setLagger(not RXZ.lagOn) end)
    RXZ.lagSetVisual(RXZ.lagOn)

    kbBtn.MouseButton1Click:Connect(function()
        RXZ.lagListen=true; kbBtn.Text="..."
    end)
    UIS.InputBegan:Connect(function(inp,gp)
        if inp.KeyCode==Enum.KeyCode.Unknown then return end
        if RXZ.lagListen then
            RXZ.lagKey=inp.KeyCode; RXZ.lagListen=false
            if kbBtn and kbBtn.Parent then kbBtn.Text=RXZ.lagKey.Name end
            return
        end
        if gp then return end
        if inp.KeyCode==RXZ.lagKey and RXZ.lagUI and RXZ.lagUI.Parent then RXZ.setLagger(not RXZ.lagOn) end
    end)

    -- drag (respects LOCK ALL)
    local dragging,dragStart,startPos=false,nil,nil
    panel.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=i.Position; startPos=panel.Position
            i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if not dragging then return end
        if uiLocked then return end
        if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
            local d=i.Position-dragStart
            panel.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
    return gui
end
RXZ.openLagger=function()
    local gui=RXZ.buildLagger()
    if gui then
        local panel=gui:FindFirstChild("Panel")
        if panel then panel.Visible=true end
        gui.Enabled=true
    end
end
RXZ.closeLagger=function()
    RXZ.setLagger(false)
    if RXZ.lagUI then pcall(function() RXZ.lagUI:Destroy() end); RXZ.lagUI=nil end
end

-- ============================================================
-- MOBILE BUTTONS  (RXZ stack-button style)
-- ============================================================
local function destroyMobileButtons()
    if mobGuiRef then pcall(function() mobGuiRef:Destroy() end);mobGuiRef=nil end
    for _,n in ipairs({"RXZMobileButtons","SpectrumMobileButtons","MoveeMobileButtons"}) do
        local old=game:GetService("CoreGui"):FindFirstChild(n);if old then old:Destroy() end
        local pgui=LP:FindFirstChild("PlayerGui");if pgui then local o=pgui:FindFirstChild(n);if o then o:Destroy() end end
    end
    mobBtnRefs={}
end
local function buildMobileButtons()
    destroyMobileButtons(); if not mobileButtonsEnabled then return end

    local mobGui = Instance.new("ScreenGui")
    mobGui.Name = "RXZMobileButtons"; mobGui.ResetOnSpawn = false; mobGui.DisplayOrder = 15; mobGui.IgnoreGuiInset = true
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(mobGui) end end)
    if not pcall(function() mobGui.Parent = game:GetService("CoreGui") end) then mobGui.Parent = LP:WaitForChild("PlayerGui") end
    mobGuiRef = mobGui

    -- ===== ABYSS/ZEN STYLE =====
    local QS = 60          -- button size px
    local QG = 10          -- gap px
    local QR = 14          -- corner radius
    local Q_OFF        = Color3.fromRGB(10, 10, 10)
    local Q_ON         = Color3.fromRGB(255, 255, 255)
    local Q_BORDER     = Color3.fromRGB(40, 40, 45)
    local Q_BORDER_ON  = Color3.fromRGB(80, 80, 85)
    local Q_TEXT       = Color3.fromRGB(255, 255, 255)
    local Q_TEXT_ON    = Color3.fromRGB(0, 0, 0)

    -- Grid container (3 cols x 4 rows)
    local QW = QS * 3 + QG * 2
    local QH = QS * 4 + QG * 3
    local mbGroup = Instance.new("Frame", mobGui)
    mbGroup.Name = "MobileButtons"
    mbGroup.Size = UDim2.new(0, QW + 20, 0, QH + 20)
    mbGroup.Position = UDim2.new(1, -QW - 34, 0.5, -QH/2 - 10)
    mbGroup.BackgroundTransparency = 1
    mbGroup.BorderSizePixel = 0
    mbGroup.Active = true
    mbGroup.ZIndex = 100
    do
        local sp=loadBtnPositions()["__group"]
        if type(sp)=="table" and sp.xo then
            mbGroup.Position=UDim2.new(sp.xs or 0,sp.xo,sp.ys or 0,sp.yo or 0)
        end
    end

    local function makeMobileBtn(label, col, rowN, isToggle, onAction)
        local relX = 10 + col * (QS + QG)
        local relY = 10 + rowN * (QS + QG)

        local frame = Instance.new("Frame", mbGroup)
        frame.Size = UDim2.new(0, QS, 0, QS)
        frame.Position = UDim2.new(0, relX, 0, relY)
        frame.BackgroundColor3 = Q_OFF
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.ZIndex = 102
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, QR)

        local stroke = Instance.new("UIStroke", frame)
        stroke.Color = Q_BORDER
        stroke.Thickness = 0
        stroke.Transparency = 1

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = label
        btn.TextColor3 = Q_TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12.5
        btn.TextWrapped = true
        btn.LineHeight = 1.2
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.ZIndex = 103

        local isOn = false

        -- setter pentru sync extern
        local function setter(s)
            isOn = s
            TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = s and Q_ON or Q_OFF}):Play()
            TweenService:Create(stroke, TweenInfo.new(0.2), {Color = s and Q_BORDER_ON or Q_BORDER}):Play()
            btn.TextColor3 = s and Q_TEXT_ON or Q_TEXT
        end

        btn.MouseButton1Click:Connect(function()
            if isToggle then
                isOn = not isOn
                TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = isOn and Q_ON or Q_OFF}):Play()
                TweenService:Create(stroke, TweenInfo.new(0.2), {Color = isOn and Q_BORDER_ON or Q_BORDER}):Play()
                btn.TextColor3 = isOn and Q_TEXT_ON or Q_TEXT
                if onAction then onAction(isOn) end
            else
                TweenService:Create(frame, TweenInfo.new(0.1), {BackgroundColor3 = Q_ON}):Play()
                TweenService:Create(stroke, TweenInfo.new(0.1), {Color = Q_BORDER_ON}):Play()
                btn.TextColor3 = Q_TEXT_ON
                task.delay(0.25, function()
                    TweenService:Create(frame, TweenInfo.new(0.2), {BackgroundColor3 = Q_OFF}):Play()
                    TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Q_BORDER}):Play()
                    btn.TextColor3 = Q_TEXT
                end)
                if onAction then onAction() end
            end
        end)

        -- Drag support (moves the WHOLE button group together)
        local _dn, _sp, _fp, _li, _wd = false, nil, nil, nil, false
        btn.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                _dn = true; _wd = false; _sp = i.Position; _fp = mbGroup.Position
                i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then _dn = false end end)
            end
        end)
        btn.InputChanged:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then _li = i end
        end)
        UIS.InputChanged:Connect(function(i)
            if i == _li and _dn and _sp and _fp then
                if uiLocked then return end
                local dx = i.Position.X - _sp.X; local dy = i.Position.Y - _sp.Y
                if math.abs(dx) > 6 or math.abs(dy) > 6 then
                    _wd = true
                    mbGroup.Position = UDim2.new(_fp.X.Scale, _fp.X.Offset + dx, _fp.Y.Scale, _fp.Y.Offset + dy)
                end
            end
        end)
        btn.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                if _wd then pcall(saveBtnPositions) end
                _dn = false; _wd = false
            end
        end)

        return frame, setter
    end

    -- ===== DEFINIRE BUTOANE (col, row, 0-indexed) =====
    local _, refDrop = makeMobileBtn("DROP\nBR", 2, 2, false, function()
        runDrop()
    end)
    mobBtnRefs["drop"] = refDrop

    local _, refTPBat = makeMobileBtn("TP\nBAT", 2, 3, true, function(on)
        if on then RXZ.startTPBat() else RXZ.stopTPBat() end
        if RXZ.setTPBatVisual then RXZ.setTPBatVisual(on) end
    end)
    mobBtnRefs["tpBat"] = refTPBat

    local _, refBatV2 = makeMobileBtn("BAT\nV2", 0, 1, true, function(on)
        if on then RXZ.startBatV2() else RXZ.stopBatV2() end
        if RXZ.setBatV2Visual then RXZ.setBatV2Visual(on) end
    end)
    mobBtnRefs["batV2"] = refBatV2

    local _, refAutoLeft = makeMobileBtn("AUTO\nLEFT", 1, 0, true, function(on)
        if on then
            if autoRightEnabled then autoRightEnabled=false; stopAutoRight(); if autoRightSetVisual then autoRightSetVisual(false) end; if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end end
            if autoBatEnabled then stopBatAimbot(); if autoBatSetVisual then autoBatSetVisual(false) end; if mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end end
            autoLeftEnabled = true; startAutoLeft()
            if autoLeftSetVisual then autoLeftSetVisual(true) end
        else
            autoLeftEnabled = false; stopAutoLeft()
            if autoLeftSetVisual then autoLeftSetVisual(false) end
        end
    end)
    mobBtnRefs["autoLeft"] = refAutoLeft

    local _, refAutoBat = makeMobileBtn("BAT\nAIMBOT", 1, 1, true, function(on)
        if on then
            if autoLeftEnabled then autoLeftEnabled=false; stopAutoLeft(); if autoLeftSetVisual then autoLeftSetVisual(false) end; if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end end
            if autoRightEnabled then autoRightEnabled=false; stopAutoRight(); if autoRightSetVisual then autoRightSetVisual(false) end; if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end end
            queueAutoBatStart()
            if autoBatSetVisual then autoBatSetVisual(true) end
        else
            stopBatAimbot()
            if autoBatSetVisual then autoBatSetVisual(false) end
        end
    end)
    mobBtnRefs["autoBat"] = refAutoBat

    local _, refAutoRight = makeMobileBtn("AUTO\nRIGHT", 2, 0, true, function(on)
        if on then
            if autoLeftEnabled then autoLeftEnabled=false; stopAutoLeft(); if autoLeftSetVisual then autoLeftSetVisual(false) end; if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end end
            if autoBatEnabled then stopBatAimbot(); if autoBatSetVisual then autoBatSetVisual(false) end; if mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end end
            autoRightEnabled = true; startAutoRight()
            if autoRightSetVisual then autoRightSetVisual(true) end
        else
            autoRightEnabled = false; stopAutoRight()
            if autoRightSetVisual then autoRightSetVisual(false) end
        end
    end)
    mobBtnRefs["autoRight"] = refAutoRight

    local _, refTP = makeMobileBtn("TP\nDOWN", 1, 3, false, function()
        runTPFloor()
    end)
    mobBtnRefs["tpDown"] = refTP

    local _, refCarry = makeMobileBtn("CARRY\nSPD", 1, 2, true, function(on)
        toggleCarryMode()
        if mobBtnRefs.lagger then mobBtnRefs.lagger(laggerModeEnabled) end
        saveConfig()
    end)
    mobBtnRefs["carrySpeed"] = refCarry

    local _, refLagger = makeMobileBtn("LAGGER\nMODE", 2, 1, true, function(on)
        toggleLaggerMode()
        if mobBtnRefs.lagger then mobBtnRefs.lagger(laggerModeEnabled) end
        if mobBtnRefs.carrySpeed then mobBtnRefs.carrySpeed(carrySpeedActive) end
        saveConfig()
    end)
    mobBtnRefs["lagger"] = refLagger

    local _, refReset = makeMobileBtn("INSTA\nRESET", 0, 0, false, function()
        cursedInstaReset()
    end)
    mobBtnRefs["instaReset"] = refReset

    if RXZ.laggerBtn then
        local _, refLagOpen = makeMobileBtn("OPEN\nLAGGER", 0, 3, false, function()
            RXZ.openLagger()
        end)
        mobBtnRefs["openLagger"] = refLagOpen
    end

    -- Sync stari curente
    if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(autoLeftEnabled) end
    if mobBtnRefs.autoRight then mobBtnRefs.autoRight(autoRightEnabled) end
    if mobBtnRefs.autoBat then mobBtnRefs.autoBat(autoBatEnabled) end
    if mobBtnRefs.carrySpeed then mobBtnRefs.carrySpeed(carrySpeedActive) end
    if mobBtnRefs.lagger then mobBtnRefs.lagger(laggerModeEnabled) end
    if mobBtnRefs.tpBat then mobBtnRefs.tpBat(RXZ.tpBat) end
    if mobBtnRefs.batV2 then mobBtnRefs.batV2(RXZ.batV2) end
end

-- ============================================================
-- FULL CONFIG LOAD (inainte de build GUI, pentru ca GUI sa citeasca valorile corecte)
-- ============================================================
pcall(function()
    if not(isfile and isfile("RXZ_HUB.json")) then return end
    local ok,d=pcall(function() return HS:JSONDecode(readfile("RXZ_HUB.json")) end)
    if not(ok and type(d)=="table") then return end
    if type(d.normalSpeed)=="number" and d.normalSpeed>0 then NS=d.normalSpeed end
    if type(d.carrySpeed)=="number" and d.carrySpeed>0 then CS=d.carrySpeed end
    if type(d.laggerSpeed)=="number" and d.laggerSpeed>0 then LAGGER_SPEED=d.laggerSpeed end
    if type(d.laggerCarrySpeed)=="number" and d.laggerCarrySpeed>0 then LAGGER_CARRY_SPEED=d.laggerCarrySpeed end
    if type(d.carrySpeedActive)=="boolean" then carrySpeedActive=d.carrySpeedActive end
    if type(d.laggerModeEnabled)=="boolean" then laggerModeEnabled=d.laggerModeEnabled end
    if type(d.antiRagdoll)=="boolean" then antiRagdollEnabled=d.antiRagdoll end
    if type(d.infiniteJump)=="boolean" then infJumpEnabled=d.infiniteJump end
    if type(d.infJumpMode)=="string" then infJumpMode=d.infJumpMode end
    if type(d.medusaCounter)=="boolean" then medusaCounterEnabled=d.medusaCounter end
    if type(d.medusaReset)=="boolean" then RXZ.medusaReset=d.medusaReset end
    if type(d.batCounter)=="boolean" then batCounterEnabled=d.batCounter end
    if type(d.autoStealEnabled)=="boolean" then Steal.AutoStealEnabled=d.autoStealEnabled end
    if type(d.grabRadius)=="number" then Steal.StealRadius=d.grabRadius end
    if type(d.stealDuration)=="number" then Steal.StealDuration=d.stealDuration end
    if type(d.autoSwing)=="boolean" then autoSwingEnabled=d.autoSwing end
    if type(d.unwalkEnabled)=="boolean" then unwalkEnabled=d.unwalkEnabled end
    if type(d.antiLag)=="boolean" then antiLagEnabled=d.antiLag end
    if type(d.stretchRez)=="boolean" then stretchRezEnabled=d.stretchRez end
    if type(d.autoTPEnabled)=="boolean" then autoTPEnabled=d.autoTPEnabled end
    if type(d.autoTPHeight)=="number" then autoTPHeight=d.autoTPHeight end
    if type(d.fovValue)=="number" then fovValue=d.fovValue end
    if type(d.fovIndex)=="number" then fovIndex=d.fovIndex end
    if type(d.skyTheme)=="string" then currentSkyTheme=d.skyTheme end
    if type(d.autoMoveSwing)=="boolean" then autoMoveSwingEnabled=d.autoMoveSwing end
    if type(d.autoMoveSwingInterval)=="number" then autoMoveSwingInterval=d.autoMoveSwingInterval end
    if type(d.ragdollGui)=="boolean" then ragdollGuiEnabled=d.ragdollGui end
    if type(d.mobileButtonsEnabled)=="boolean" then mobileButtonsEnabled=d.mobileButtonsEnabled end
    if type(d.mobileButtonsSize)=="number" then mobileButtonsSize=d.mobileButtonsSize end
    if type(d.circleButtonsEnabled)=="boolean" then circleButtonsEnabled=d.circleButtonsEnabled end
    if type(d.introSoundEnabled)=="boolean" then introSoundEnabled=d.introSoundEnabled end
    if type(d.animEnabled)=="boolean" then animEnabled=d.animEnabled end
    if type(d.backgroundEnabled)=="boolean" then backgroundEnabled=d.backgroundEnabled end
    if type(d.laggerBtn)=="boolean" then RXZ.laggerBtn=d.laggerBtn end
    if type(d.antiMedusa)=="boolean" then RXZ.antiMedusa=d.antiMedusa end
    if type(d.lockAll)=="boolean" then uiLocked=d.lockAll end
    if type(d.lagLevel)=="string" and RXZ.LAG_POWER and RXZ.LAG_POWER[d.lagLevel] then RXZ.lagLevel=d.lagLevel end
    if type(d.backgroundIndex)=="number" then backgroundIndex=d.backgroundIndex end
end)

-- ============================================================
-- APPLY CONFIG Ã¢ÂÂ porneste sistemele dupa ce valorile au fost incarcate
-- ============================================================
pcall(function()
    -- Zombie Animations
    if animEnabled then
        task.spawn(function()
            task.wait(1)
            if startAnimToggle then startAnimToggle() end
        end)
    end
    -- Anti Lag
    if antiLagEnabled then
        task.spawn(function()
            task.wait(1)
            if enableAntiLag then enableAntiLag() end
        end)
    end
    -- Stretch Rez (FOV)
    if stretchRezEnabled then
        task.spawn(function()
            task.wait(0.5)
            if enableStretchRez then enableStretchRez() end
        end)
    end
    -- Anti Ragdoll
    if antiRagdollEnabled then
        task.spawn(function()
            task.wait(0.5)
            if startAntiRagdoll then startAntiRagdoll() end
        end)
    end
    -- Infinite Jump
    if infJumpEnabled then
        task.spawn(function()
            task.wait(0.5)
            if setInfJumpInternal then setInfJumpInternal(true) end
        end)
    end
    -- Auto Steal
    if Steal.AutoStealEnabled then
        task.spawn(function()
            task.wait(1)
            if startAutoSteal then startAutoSteal() end
        end)
    end
    -- Bat Counter
    if batCounterEnabled then
        task.spawn(function()
            task.wait(1)
            if startBatCounter then startBatCounter() end
        end)
    end
    -- Medusa Reset
    if RXZ.medusaReset then
        task.spawn(function() task.wait(1); local ch=LP.Character; if ch and setupMedusa then setupMedusa(ch) end end)
    end
    -- Medusa Counter
    if medusaCounterEnabled then
        task.spawn(function()
            task.wait(1)
            local char = LP.Character
            if char and setupMedusa then setupMedusa(char) end
        end)
    end
    -- Auto TP
    if autoTPEnabled then
        task.spawn(function()
            task.wait(0.5)
            if startAutoTP then startAutoTP() end
        end)
    end
    -- Sky Theme
    if currentSkyTheme and currentSkyTheme ~= "" then
        task.spawn(function()
            task.wait(1)
            if CandyApplyCustomSky then CandyApplyCustomSky(currentSkyTheme) end
        end)
    end
end)

-- ============================================================
-- CYBER GUI Ã¢ÂÂ rulat in functie proprie ca sa evite limita 200 locals
-- ============================================================
;(function()

local PlayerGui = LP:WaitForChild("PlayerGui")

local function makeDraggable_cyber(dragTarget, moveTarget)
    moveTarget = moveTarget or dragTarget
    local dragging, dragInput, dragStart, startPos = false
    dragTarget.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=input.Position; startPos=moveTarget.Position
            input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
        end
    end)
    dragTarget.InputChanged:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then dragInput=input end
    end)
    UIS.InputChanged:Connect(function(input)
        if input==dragInput and dragging then
            if uiLocked then return end
            local delta=input.Position-dragStart
            moveTarget.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
        end
    end)
end

local C={
    bg=Color3.fromRGB(6,6,6), bgDark=Color3.fromRGB(3,3,3), row=Color3.fromRGB(16,16,16),
    input=Color3.fromRGB(16,16,16), blue=Color3.fromRGB(210,210,210), blueDim=Color3.fromRGB(70,70,70),
    blueDark=Color3.fromRGB(22,22,22), text=Color3.fromRGB(255,255,255), textDim=Color3.fromRGB(160,160,160),
    textMuted=Color3.fromRGB(100,100,100), white=Color3.fromRGB(255,255,255), divider=Color3.fromRGB(32,32,32),
    green=Color3.fromRGB(80,220,120),
}
local function guiCorner(p,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 10);c.Parent=p;return c end
local function guiStroke(p,col,t) local s=Instance.new("UIStroke");s.Color=col or Color3.fromRGB(60,60,70);s.Thickness=t or 1;s.Parent=p;return s end
local function tw(obj,props,ti) TweenService:Create(obj,ti or TweenInfo.new(0.12),props):Play() end

local GuiToggleSetters={}
local GuiRefs={}
local LeftPanel=nil

local Keys={
    circle=Enum.KeyCode.E,
    speed=Enum.KeyCode.Q,
    carryMode=Enum.KeyCode.C,
    laggerToggle=Enum.KeyCode.K,
    guiHide=Enum.KeyCode.RightControl,
    dropBrainrot=Enum.KeyCode.H,
    tpDown=Enum.KeyCode.T,
    instaReset=Enum.KeyCode.B,
    autoLeft=Enum.KeyCode.J,
    autoRight=Enum.KeyCode.L,
}
-- Aplica keybind-urile salvate si inregistreaza referinta pentru saveConfig
pcall(function()
    if not(isfile and isfile("RXZ_HUB.json")) then return end
    local ok,d=pcall(function() return HS:JSONDecode(readfile("RXZ_HUB.json")) end)
    if ok and type(d)=="table" and type(d.keys)=="table" then
        for k,v in pairs(d.keys) do
            local ok2,kc=pcall(function() return Enum.KeyCode[v] end)
            if ok2 and kc and kc~=Enum.KeyCode.Unknown then Keys[k]=kc end
        end
    end
end)
_GuiKeys = Keys

-- BUILD HUB GUI
;(function()
    local GuiHub=Instance.new("ScreenGui")
    GuiHub.Name="RXZHub"; GuiHub.ResetOnSpawn=false
    GuiHub.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; GuiHub.Parent=PlayerGui
    GuiRefs.hub=GuiHub

    local Outer=Instance.new("Frame")
    Outer.Name="Outer"; Outer.Size=UDim2.new(0,340,0,495); Outer.AnchorPoint=Vector2.new(0,0); Outer.Position=UDim2.new(0,6,0,18)
    Outer.BackgroundTransparency=1; Outer.BorderSizePixel=0; Outer.ClipsDescendants=false; Outer.Parent=GuiHub
    GuiRefs.outer=Outer
    -- compact scale for mobile (opens on the LEFT, under Roblox settings)
    local OuterScale=Instance.new("UIScale"); OuterScale.Scale=0.72; OuterScale.Parent=Outer

    local Inner=Instance.new("Frame")
    Inner.Name="Inner"; Inner.ClipsDescendants=false; Inner.Size=UDim2.new(1,0,1,0)
    Inner.BackgroundColor3=C.bg; Inner.BackgroundTransparency=0; Inner.BorderSizePixel=0; Inner.Parent=Outer
    guiCorner(Inner,24); guiStroke(Inner,Color3.fromRGB(45,45,45),1.5); GuiRefs.inner=Inner

    local BgCont=Instance.new("Frame")
    BgCont.Name="BackgroundContainer"; BgCont.Size=UDim2.new(1,0,1,0)
    BgCont.BackgroundTransparency=1; BgCont.ZIndex=0; BgCont.Parent=Inner

    local BgGrad=Instance.new("Frame")
    BgGrad.Name="BgGrad"; BgGrad.Size=UDim2.new(1,0,1,0); BgGrad.BackgroundColor3=C.bgDark
    BgGrad.BorderSizePixel=0; BgGrad.ZIndex=0; BgGrad.Parent=BgCont; guiCorner(BgGrad,24)
    local grad=Instance.new("UIGradient")
    grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(4,4,4)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(7,7,7)),ColorSequenceKeypoint.new(1,Color3.fromRGB(4,4,4))})
    grad.Rotation=135; grad.Parent=BgGrad; GuiRefs.bgGrad=BgGrad

    local BgImg=Instance.new("ImageLabel")
    BgImg.Name="BackgroundImage"; BgImg.Size=UDim2.new(1,0,1,0); BgImg.BackgroundTransparency=1
    BgImg.Image="rbxassetid://137876907823856"; BgImg.ScaleType=Enum.ScaleType.Crop; BgImg.ZIndex=0
    BgImg.ImageTransparency=0.55; BgImg.Visible=true
    BgImg.Parent=BgCont; guiCorner(BgImg,24); GuiRefs.backgroundImage=BgImg; bgImageRef=BgImg

    local HF=Instance.new("Frame")
    HF.Name="HeaderFrame"; HF.Size=UDim2.new(1,0,0,62); HF.BackgroundTransparency=1
    HF.BorderSizePixel=0; HF.Parent=Inner; HF.ZIndex=2
    makeDraggable_cyber(HF, Outer)

    local TL=Instance.new("TextLabel")
    TL.Position=UDim2.new(0,14,0,8); TL.Size=UDim2.new(1,-90,0,22); TL.BackgroundTransparency=1
    TL.Text="RXZ HUB"; TL.TextColor3=C.text; TL.TextSize=17; TL.Font=Enum.Font.GothamBlack
    TL.TextXAlignment=Enum.TextXAlignment.Left; TL.Parent=HF; TL.ZIndex=3

    local ML=Instance.new("TextLabel")
    ML.Position=UDim2.new(0,14,0,32); ML.Size=UDim2.new(0,200,0,14); ML.BackgroundTransparency=1
    ML.Text="RXZ HUB Ã¢ÂÂ¢ PREMIUM"; ML.TextColor3=C.textDim; ML.TextSize=10; ML.Font=Enum.Font.GothamBold
    ML.TextXAlignment=Enum.TextXAlignment.Left; ML.Parent=HF; ML.ZIndex=3

    -- MINIMIZE BUTTON
    local CloseBtn=Instance.new("TextButton")
    CloseBtn.Size=UDim2.new(0,28,0,28); CloseBtn.Position=UDim2.new(1,-38,0,8)
    CloseBtn.BackgroundColor3=C.bgDark; CloseBtn.BorderSizePixel=0
    CloseBtn.Text="-"; CloseBtn.TextColor3=C.textMuted; CloseBtn.Font=Enum.Font.GothamBlack; CloseBtn.TextSize=22
    CloseBtn.ZIndex=5; CloseBtn.Parent=HF
    guiCorner(CloseBtn,7); guiStroke(CloseBtn,Color3.fromRGB(45,45,45),1)
    CloseBtn.MouseEnter:Connect(function() tw(CloseBtn,{BackgroundColor3=Color3.fromRGB(28,28,28),TextColor3=C.text}) end)
    CloseBtn.MouseLeave:Connect(function() tw(CloseBtn,{BackgroundColor3=C.bgDark,TextColor3=C.textMuted}) end)

    -- MINI RESTORE BUTTON
    local MiniBtn=Instance.new("TextButton")
    MiniBtn.Size=UDim2.new(0,110,0,28); MiniBtn.AnchorPoint=Vector2.new(0,0); MiniBtn.Position=UDim2.new(0,8,0,16)
    MiniBtn.BackgroundColor3=C.bgDark; MiniBtn.BorderSizePixel=0
    MiniBtn.Text="RXZ HUB"; MiniBtn.TextColor3=C.text; MiniBtn.Font=Enum.Font.GothamBlack; MiniBtn.TextSize=11
    MiniBtn.ZIndex=20; MiniBtn.Visible=false; MiniBtn.Parent=GuiRefs.hub
    guiCorner(MiniBtn,8); guiStroke(MiniBtn,Color3.fromRGB(45,45,45),1.2)
    makeDraggable_cyber(MiniBtn, MiniBtn)
    MiniBtn.MouseEnter:Connect(function() tw(MiniBtn,{BackgroundColor3=Color3.fromRGB(22,22,22)}) end)
    MiniBtn.MouseLeave:Connect(function() tw(MiniBtn,{BackgroundColor3=C.bgDark}) end)

    local function showGui() Outer.Visible=true; MiniBtn.Visible=false end
    local function hideGui() Outer.Visible=false; MiniBtn.Visible=true end
    CloseBtn.MouseButton1Click:Connect(hideGui)
    MiniBtn.MouseButton1Click:Connect(showGui)

    local HSep=Instance.new("Frame")
    HSep.Position=UDim2.new(0,14,0,62); HSep.Size=UDim2.new(1,-28,0,1); HSep.BackgroundColor3=C.blue
    HSep.BackgroundTransparency=0.7; HSep.BorderSizePixel=0; HSep.Parent=Inner; HSep.ZIndex=2

    LeftPanel=Instance.new("Frame")
    LeftPanel.Name="LeftPanel"; LeftPanel.Size=UDim2.new(1,-28,0,36); LeftPanel.Position=UDim2.new(0,14,0,70)
    LeftPanel.BackgroundColor3=C.bgDark; LeftPanel.BackgroundTransparency=0.5; LeftPanel.BorderSizePixel=0
    LeftPanel.Parent=Inner; guiCorner(LeftPanel,12); LeftPanel.ZIndex=2

    local CatList=Instance.new("ScrollingFrame")
    CatList.Name="CategoryList"; CatList.Size=UDim2.new(1,0,1,0); CatList.BackgroundTransparency=1
    CatList.BorderSizePixel=0; CatList.ScrollBarThickness=2; CatList.ScrollBarImageColor3=C.blue
    CatList.CanvasSize=UDim2.new(0,0,0,0); CatList.AutomaticCanvasSize=Enum.AutomaticSize.Y; CatList.Active=true; CatList.Parent=LeftPanel
    CatList.ScrollingDirection=Enum.ScrollingDirection.X; CatList.AutomaticCanvasSize=Enum.AutomaticSize.X; CatList.ScrollBarThickness=0
    local CatLay=Instance.new("UIListLayout"); CatLay.SortOrder=Enum.SortOrder.LayoutOrder; CatLay.Padding=UDim.new(0,4)
    CatLay.FillDirection=Enum.FillDirection.Horizontal; CatLay.VerticalAlignment=Enum.VerticalAlignment.Center; CatLay.Parent=CatList
    CatLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() CatList.CanvasSize = UDim2.new(0, CatLay.AbsoluteContentSize.X + 6, 0, 0) end)
    local CatPad=Instance.new("UIPadding"); CatPad.PaddingLeft=UDim.new(0,6); CatPad.PaddingRight=UDim.new(0,6)
    CatPad.PaddingTop=UDim.new(0,4); CatPad.PaddingBottom=UDim.new(0,4); CatPad.Parent=CatList
    GuiRefs.categoryList=CatList

    local CF=Instance.new("ScrollingFrame")
    CF.Name="ContentFrame"; CF.Size=UDim2.new(1,0,1,-172); CF.Position=UDim2.new(0,0,0,112)
    CF.BackgroundTransparency=1; CF.BorderSizePixel=0; CF.ScrollBarThickness=6; CF.ScrollBarImageColor3=C.blue
    CF.CanvasSize=UDim2.new(0,0,0,0); CF.AutomaticCanvasSize=Enum.AutomaticSize.Y
    CF.ScrollingDirection=Enum.ScrollingDirection.Y; CF.ScrollingEnabled=true; CF.Active=true
    CF.ElasticBehavior=Enum.ElasticBehavior.Never; CF.Parent=Inner; GuiRefs.contentFrame=CF
    local CLay=Instance.new("UIListLayout"); CLay.SortOrder=Enum.SortOrder.LayoutOrder; CLay.Padding=UDim.new(0,6); CLay.Parent=CF
    CLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() CF.CanvasSize = UDim2.new(0, 0, 0, CLay.AbsoluteContentSize.Y + 25) end)
    local CPad=Instance.new("UIPadding"); CPad.PaddingLeft=UDim.new(0,12); CPad.PaddingRight=UDim.new(0,12)
    CPad.PaddingTop=UDim.new(0,10); CPad.PaddingBottom=UDim.new(0,8); CPad.Parent=CF

    local BotSep=Instance.new("Frame")
    BotSep.Position=UDim2.new(0,8,1,-54); BotSep.Size=UDim2.new(1,-16,0,1); BotSep.BackgroundColor3=C.blue
    BotSep.BackgroundTransparency=0.65; BotSep.BorderSizePixel=0; BotSep.Parent=Inner; BotSep.ZIndex=2
end)()

-- KEYBIND SYSTEM
local KeyListen={cb=nil,label=nil,active=false}
local KEY_ALIASES={
    ButtonA="A",ButtonB="B",ButtonX="X",ButtonY="Y",ButtonR1="RB",ButtonR2="RT",ButtonL1="LB",ButtonL2="LT",
    DPadUp="DÃ¢ÂÂ",DPadDown="DÃ¢ÂÂ",DPadLeft="DÃ¢ÂÂ",DPadRight="DÃ¢ÂÂ",ButtonStart="Ã¢ÂÂ¶",ButtonSelect="Ã¢ÂÂ",
    LeftShift="LShift",RightShift="RShift",LeftControl="LCtrl",RightControl="RCtrl",LeftAlt="LAlt",RightAlt="RAlt",
    LeftSuper="LSuper",RightSuper="RSuper",Return="Enter",BackSpace="Backspace",Tab="Tab",CapsLock="CapsLock",
    Escape="Esc",Space="Space",PageUp="PgUp",PageDown="PgDn",End="End",Home="Home",Insert="Ins",Delete="Del",
    Up="Ã¢ÂÂ",Down="Ã¢ÂÂ",Left="Ã¢ÂÂ",Right="Ã¢ÂÂ",F1="F1",F2="F2",F3="F3",F4="F4",F5="F5",F6="F6",F7="F7",F8="F8",
    F9="F9",F10="F10",F11="F11",F12="F12",Print="PrtScn",ScrollLock="ScrLk",Pause="Pause",
    Minus="-",Equals="=",LeftBracket="[",RightBracket="]",BackSlash="\\",Semicolon=";",Quote="'",
    Comma=",",Period=".",Slash="/",Backquote="`"
}
local function prettyKey(kc) return KEY_ALIASES[kc.Name] or kc.Name end
local function cancelKL()
    if KeyListen.label then KeyListen.label.BackgroundColor3=C.blue; KeyListen.label.BackgroundTransparency=0.5 end
    KeyListen.cb=nil; KeyListen.label=nil; KeyListen.active=false
end
local function startKL(lbl,onSet)
    cancelKL(); KeyListen.cb=onSet; KeyListen.label=lbl; KeyListen.active=true
    lbl.Text="..."; lbl.BackgroundColor3=Color3.fromRGB(80,220,120); lbl.BackgroundTransparency=0.3
    local cap=lbl; task.delay(8,function() if KeyListen.label==cap and KeyListen.active then cancelKL(); if lbl and lbl.Parent then lbl.Text=prettyKey(Keys.guiHide); lbl.BackgroundColor3=C.blue; lbl.BackgroundTransparency=0.5 end end end)
end
UIS.InputBegan:Connect(function(inp,gp)
    if not KeyListen.active then return end; if gp then return end
    local ut=inp.UserInputType
    if ut~=Enum.UserInputType.Keyboard and ut~=Enum.UserInputType.Gamepad1 then return end
    local k=inp.KeyCode
    if k==Enum.KeyCode.Unknown then return end
    if k==Enum.KeyCode.Escape then cancelKL(); return end
    local cb=KeyListen.cb; local lb=KeyListen.label; cancelKL()
    if lb and lb.Parent then lb.Text=prettyKey(k); lb.BackgroundColor3=C.blue; lb.BackgroundTransparency=0.5 end
    if cb then task.spawn(cb,k) end
end)

-- ROW BUILDERS
local function addSectLbl(parent,text,order)
    local w=Instance.new("Frame",parent); w.Size=UDim2.new(1,0,0,26); w.BackgroundTransparency=1; w.LayoutOrder=order
    local L=Instance.new("TextLabel",w); L.Size=UDim2.new(1,0,0,20); L.BackgroundTransparency=1
    L.Text=text; L.TextColor3=C.white; L.TextSize=12; L.Font=Enum.Font.GothamBold; L.TextXAlignment=Enum.TextXAlignment.Left
    return L
end
local function addInputRow(parent,label,value,order,cb)
    local Row=Instance.new("Frame",parent); Row.Size=UDim2.new(1,0,0,40); Row.BackgroundColor3=C.row
    Row.BackgroundTransparency=0.5; Row.BorderSizePixel=0; Row.LayoutOrder=order; guiCorner(Row,10); guiStroke(Row,C.divider,1)
    local Lb=Instance.new("TextLabel",Row); Lb.Size=UDim2.new(0.62,0,0,18); Lb.Position=UDim2.new(0,12,0,6)
    Lb.BackgroundTransparency=1; Lb.Text=label; Lb.TextColor3=C.white; Lb.TextSize=14; Lb.Font=Enum.Font.GothamBold; Lb.TextXAlignment=Enum.TextXAlignment.Left
    local BC=Instance.new("Frame",Row); BC.ZIndex=6; BC.Position=UDim2.new(1,-58,0.5,-10); BC.Size=UDim2.new(0,48,0,20)
    BC.BackgroundColor3=C.input; BC.BackgroundTransparency=0.5; BC.BorderSizePixel=0; guiCorner(BC,6); guiStroke(BC,Color3.fromRGB(55,55,60),1)
    local Box=Instance.new("TextBox",BC); Box.ZIndex=7; Box.Size=UDim2.new(1,0,1,0); Box.BackgroundTransparency=1
    Box.Text=tostring(value); Box.TextColor3=C.white; Box.TextSize=13; Box.Font=Enum.Font.GothamBold; Box.ClearTextOnFocus=false
    Box.FocusLost:Connect(function() local n=tonumber(Box.Text); if n and n>0 then cb(n) else Box.Text=tostring(value) end end)
    local hov=Instance.new("TextButton",Row); hov.Size=UDim2.new(1,0,1,0); hov.BackgroundTransparency=1; hov.Text=""; hov.ZIndex=0
    hov.MouseEnter:Connect(function() tw(Row,{BackgroundTransparency=0.3}) end); hov.MouseLeave:Connect(function() tw(Row,{BackgroundTransparency=0.5}) end)
    return Row,Box
end
local function addToggleRow(parent,label,enabled,order,kbKey,onToggle)
    local hasKB=kbKey~=nil
    local Row=Instance.new("Frame",parent); Row.Size=UDim2.new(1,0,0,hasKB and 54 or 42); Row.BackgroundColor3=C.row
    Row.BackgroundTransparency=0.5; Row.BorderSizePixel=0; Row.LayoutOrder=order; guiCorner(Row,10); guiStroke(Row,C.divider,1)
    local Lb=Instance.new("TextLabel",Row); Lb.Size=UDim2.new(0.62,0,0,18); Lb.Position=UDim2.new(0,12,0,6)
    Lb.BackgroundTransparency=1; Lb.Text=label; Lb.TextColor3=C.white; Lb.TextSize=14; Lb.Font=Enum.Font.GothamBold; Lb.TextXAlignment=Enum.TextXAlignment.Left
    if hasKB and Keys[kbKey] then
        local KB2=Instance.new("TextButton",Row); KB2.Size=UDim2.new(0,35,0,16); KB2.Position=UDim2.new(0,12,1,-20)
        KB2.BackgroundColor3=C.blue; KB2.BackgroundTransparency=0.5; KB2.BorderSizePixel=0; KB2.Text=prettyKey(Keys[kbKey])
        KB2.TextColor3=C.white; KB2.TextSize=11; KB2.Font=Enum.Font.GothamBold; guiCorner(KB2,5)
        KB2.MouseButton1Click:Connect(function() startKL(KB2,function(nk) Keys[kbKey]=nk; KB2.Text=prettyKey(nk); saveConfig() end) end)
    end
    local Track=Instance.new("Frame",Row); Track.Size=UDim2.new(0,36,0,18); Track.Position=UDim2.new(1,-46,0,10)
    Track.BackgroundColor3=C.blueDark; Track.BackgroundTransparency=0.5; Track.BorderSizePixel=0; guiCorner(Track,10); guiStroke(Track,C.blueDim,1)
    local Knob=Instance.new("Frame",Track); Knob.Size=UDim2.new(0,14,0,14)
    Knob.Position=enabled and UDim2.new(0.5,2,0.5,-7) or UDim2.new(0,2,0.5,-7)
    Knob.BackgroundColor3=C.blue; Knob.BackgroundTransparency=enabled and 0.3 or 0.5; Knob.BorderSizePixel=0; guiCorner(Knob,7)
    local st=enabled
    local function setV(on) st=on; tw(Knob,{Position=on and UDim2.new(0.5,2,0.5,-7) or UDim2.new(0,2,0.5,-7)}); tw(Knob,{BackgroundTransparency=on and 0.3 or 0.5}) end
    local Btn=Instance.new("TextButton",Row); Btn.Size=UDim2.new(0,36,0,18); Btn.Position=UDim2.new(1,-46,0,10); Btn.BackgroundTransparency=1; Btn.Text=""
    Btn.MouseButton1Click:Connect(function() st=not st; setV(st); if onToggle then onToggle(st) end end)
    local hov=Instance.new("TextButton",Row); hov.Size=UDim2.new(1,0,1,0); hov.BackgroundTransparency=1; hov.Text=""; hov.ZIndex=0
    hov.MouseEnter:Connect(function() tw(Row,{BackgroundTransparency=0.3}) end); hov.MouseLeave:Connect(function() tw(Row,{BackgroundTransparency=0.5}) end)
    if kbKey then GuiToggleSetters[kbKey]=setV end
    return Row,setV
end
local function addActionRow(parent,label,kbKey,onAction,order)
    local Row=Instance.new("Frame",parent); Row.Size=UDim2.new(1,0,0,42); Row.BackgroundColor3=C.row
    Row.BackgroundTransparency=0.5; Row.BorderSizePixel=0; Row.LayoutOrder=order; guiCorner(Row,10); guiStroke(Row,C.divider,1)
    local Lb=Instance.new("TextLabel",Row); Lb.Size=UDim2.new(0.58,0,0,18); Lb.Position=UDim2.new(0,12,0,8)
    Lb.BackgroundTransparency=1; Lb.Text=label; Lb.TextColor3=C.white; Lb.TextSize=14; Lb.Font=Enum.Font.GothamBold; Lb.TextXAlignment=Enum.TextXAlignment.Left
    if kbKey and Keys[kbKey] then
        local KB2=Instance.new("TextButton",Row); KB2.Size=UDim2.new(0,40,0,22); KB2.Position=UDim2.new(1,-48,0.5,-11)
        KB2.BackgroundColor3=C.blue; KB2.BackgroundTransparency=0.5; KB2.BorderSizePixel=0; KB2.Text=prettyKey(Keys[kbKey])
        KB2.TextColor3=C.white; KB2.TextSize=11; KB2.Font=Enum.Font.GothamBold; guiCorner(KB2,5)
        KB2.MouseButton1Click:Connect(function() startKL(KB2,function(nk) Keys[kbKey]=nk; KB2.Text=prettyKey(nk); saveConfig() end) end)
    end
    local AB=Instance.new("TextButton",Row); AB.Size=UDim2.new(0.55,0,1,0); AB.BackgroundTransparency=1; AB.Text=""; AB.MouseButton1Click:Connect(onAction)
    local hov=Instance.new("TextButton",Row); hov.Size=UDim2.new(1,0,1,0); hov.BackgroundTransparency=1; hov.Text=""; hov.ZIndex=0
    hov.MouseEnter:Connect(function() tw(Row,{BackgroundTransparency=0.3}) end); hov.MouseLeave:Connect(function() tw(Row,{BackgroundTransparency=0.5}) end)
    return Row
end
local function addCycleRow(parent,label,value,order,onCycle)
    local Row=Instance.new("Frame",parent); Row.Size=UDim2.new(1,0,0,38); Row.BackgroundColor3=C.row
    Row.BackgroundTransparency=0.5; Row.BorderSizePixel=0; Row.LayoutOrder=order; guiCorner(Row,10); guiStroke(Row,C.divider,1)
    local Lb=Instance.new("TextLabel",Row); Lb.Size=UDim2.new(0.62,0,0,18); Lb.Position=UDim2.new(0,12,0,6)
    Lb.BackgroundTransparency=1; Lb.Text=label; Lb.TextColor3=C.white; Lb.TextSize=14; Lb.Font=Enum.Font.GothamBold; Lb.TextXAlignment=Enum.TextXAlignment.Left
    local CB=Instance.new("TextButton",Row); CB.Size=UDim2.new(0,60,0,22); CB.Position=UDim2.new(1,-72,0.5,-11)
    CB.BackgroundColor3=C.blue; CB.BackgroundTransparency=0.5; CB.BorderSizePixel=0; CB.Text=value
    CB.TextColor3=C.white; CB.TextSize=12; CB.Font=Enum.Font.GothamBold; guiCorner(CB,5)
    CB.MouseButton1Click:Connect(function() local nv=onCycle(); CB.Text=nv end)
    local hov=Instance.new("TextButton",Row); hov.Size=UDim2.new(1,0,1,0); hov.BackgroundTransparency=1; hov.Text=""; hov.ZIndex=0
    hov.MouseEnter:Connect(function() tw(Row,{BackgroundTransparency=0.3}) end); hov.MouseLeave:Connect(function() tw(Row,{BackgroundTransparency=0.5}) end)
    return Row,CB
end

-- CATEGORY SETUP
local Categories={"Speed","Combat","Steal","Movement","Visual"}
local CategoryRefs={contents={},btnsSide={},active="Speed"}
;(function()
    for _,name in pairs(Categories) do
        local page=Instance.new("Frame"); page.Size=UDim2.new(1,0,0,0); page.AutomaticSize=Enum.AutomaticSize.Y; page.BackgroundTransparency=1
        page.Visible=(name=="Speed"); page.Parent=GuiRefs.contentFrame; CategoryRefs.contents[name]=page
        local lay=Instance.new("UIListLayout"); lay.SortOrder=Enum.SortOrder.LayoutOrder; lay.Padding=UDim.new(0,6); lay.Parent=page
    end
    for i,name in ipairs(Categories) do
        local btn=Instance.new("TextButton"); btn.Size=UDim2.new(0,58,0,28); btn.BackgroundColor3=C.blueDark
        btn.BackgroundTransparency=0.3; btn.Text=name; btn.TextColor3=(name=="Speed") and C.white or C.textDim
        btn.TextSize=12; btn.Font=Enum.Font.GothamBold; btn.BorderSizePixel=0; btn.LayoutOrder=i; btn.Parent=GuiRefs.categoryList; guiCorner(btn,6)
        local ind=Instance.new("Frame"); ind.Name="indicator"; ind.Size=UDim2.new(1,-14,0,2); ind.Position=UDim2.new(0,7,1,-3)
        ind.BackgroundColor3=C.blue; ind.BackgroundTransparency=(name=="Speed") and 0.3 or 1; ind.BorderSizePixel=0; ind.Parent=btn
        CategoryRefs.btnsSide[name]=btn
        btn.MouseButton1Click:Connect(function()
            for _,f in pairs(CategoryRefs.contents) do f.Visible=false end
            local selectedPage = CategoryRefs.contents[name]
            selectedPage.Visible=true; CategoryRefs.active=name
            for n,b in pairs(CategoryRefs.btnsSide) do
                local ac=(n==name); b.TextColor3=ac and C.white or C.textDim; b.BackgroundTransparency=ac and 0.2 or 0.3
                local i2=b:FindFirstChild("indicator"); if i2 then i2.BackgroundTransparency=ac and 0.3 or 1 end
            end
            local lay = selectedPage:FindFirstChildOfClass("UIListLayout")
            if lay then GuiRefs.contentFrame.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 25) end
        end)
        btn.MouseEnter:Connect(function() if CategoryRefs.active~=name then btn.TextColor3=C.white; btn.BackgroundTransparency=0.25 end end)
        btn.MouseLeave:Connect(function() if CategoryRefs.active~=name then btn.TextColor3=C.textDim; btn.BackgroundTransparency=0.3 end end)
    end
    local spBtn=CategoryRefs.btnsSide["Speed"]
    if spBtn then spBtn.TextColor3=C.white; spBtn.BackgroundTransparency=0.2; local i2=spBtn:FindFirstChild("indicator"); if i2 then i2.BackgroundTransparency=0.3 end end
end)()

-- SPEED PAGE
;(function()
    local sp=CategoryRefs.contents["Speed"]
    addSectLbl(sp,"SPEED CONFIGURATION",0)
    addInputRow(sp,"Normal Speed",NS,1,function(v) NS=v; saveConfig() end)
    addInputRow(sp,"Carry Speed",CS,2,function(v) CS=v; saveConfig() end)
    addSectLbl(sp,"LAGGER MODE",3)
    addInputRow(sp,"Lagger Normal",LAGGER_SPEED,4,function(v) LAGGER_SPEED=v; saveConfig() end)
    addInputRow(sp,"Lagger Carry",LAGGER_CARRY_SPEED,5,function(v) LAGGER_CARRY_SPEED=v; saveConfig() end)
    addSectLbl(sp,"CONTROLS",6)
    addToggleRow(sp,"Carry Mode",carrySpeedActive,7,"carryMode",function(on)
        carrySpeedActive = on
        if mobBtnRefs.carrySpeed then mobBtnRefs.carrySpeed(carrySpeedActive) end
        if refreshSpeedModeLabel then refreshSpeedModeLabel() end
        saveConfig()
    end)
    addToggleRow(sp,"Lagger Mode",laggerModeEnabled,8,"laggerToggle",function(on)
        laggerModeEnabled=on; if mobBtnRefs.lagger then mobBtnRefs.lagger(on) end
        if refreshSpeedModeLabel then refreshSpeedModeLabel() end; saveConfig()
    end)
end)()


-- COMBAT PAGE
;(function()
    local cp=CategoryRefs.contents["Combat"]

    addSectLbl(cp,"MEDUSA",2)
    local _,svAntiMed=addToggleRow(cp,"Anti Medusa Counter",RXZ.antiMedusa,3,nil,function(on)
        RXZ.antiMedusa=on
        if on then RXZ.startAntiMedusa() else RXZ.stopAntiMedusa() end
        saveConfig()
    end)
    RXZ.setAntiMedusaVisual=svAntiMed
    local _,svMedusa=addToggleRow(cp,"Medusa Counter",medusaCounterEnabled,5,nil,function(on) medusaCounterEnabled=on;if on then setupMedusa(LP.Character) else stopMedusaCounter() end;saveConfig() end)
    setMedusaVisual=svMedusa
    local _,svMedReset=addToggleRow(cp,"Medusa Reset",RXZ.medusaReset,6,nil,function(on)
        RXZ.medusaReset=on
        if on then setupMedusa(LP.Character) elseif not medusaCounterEnabled then stopMedusaCounter() end
        saveConfig()
    end)
    RXZ.setMedusaResetVisual=svMedReset

    addSectLbl(cp,"LAGGER",7)
    addActionRow(cp,"Open Lagger GUI",nil,function() RXZ.openLagger() end,8)
    addActionRow(cp,"Close Lagger GUI",nil,function() RXZ.closeLagger() end,9)

    addSectLbl(cp,"BAT CONTROLS",10)
    local _,svAutoBat=addToggleRow(cp,"Bat Aimbot",autoBatEnabled,11,"circle",function(on)
        if on then
            if autoLeftEnabled then autoLeftEnabled=false;stopAutoLeft();if autoLeftSetVisual then autoLeftSetVisual(false) end;if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end end
            if autoRightEnabled then autoRightEnabled=false;stopAutoRight();if autoRightSetVisual then autoRightSetVisual(false) end;if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end end
            queueAutoBatStart();if mobBtnRefs.autoBat then mobBtnRefs.autoBat(true) end
        else stopBatAimbot();if mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end end
        saveConfig()
    end)
    autoBatSetVisual=svAutoBat
    addToggleRow(cp,"Auto Swing",autoSwingEnabled,12,nil,function(on) autoSwingEnabled=on;saveConfig() end)
    local _,svBatCounter=addToggleRow(cp,"Bat Counter",batCounterEnabled,13,nil,function(on) batCounterEnabled=on;if on then startBatCounter() else stopBatCounter() end;saveConfig() end)
    setBatCounterVisual=svBatCounter
    local _,svTPBat=addToggleRow(cp,"TP Bat",RXZ.tpBat,14,nil,function(on)
        if on then RXZ.startTPBat() else RXZ.stopTPBat() end
        if mobBtnRefs.tpBat then mobBtnRefs.tpBat(on) end
    end)
    RXZ.setTPBatVisual=svTPBat
    local _,svBatV2=addToggleRow(cp,"Bat V2",RXZ.batV2,15,nil,function(on)
        if on then RXZ.startBatV2() else RXZ.stopBatV2() end
        if mobBtnRefs.batV2 then mobBtnRefs.batV2(on) end
    end)
    RXZ.setBatV2Visual=svBatV2

    addSectLbl(cp,"RAGDOLL",16)
    local _,svRagdoll=addToggleRow(cp,"Anti Ragdoll",antiRagdollEnabled,17,nil,function(on) antiRagdollEnabled=on;if on then startAntiRagdoll() else stopAntiRagdoll() end;saveConfig() end)
    setAntiRagVisual=svRagdoll
    if antiRagdollEnabled then svRagdoll(true) end
    local _,svUnwalk=addToggleRow(cp,"Unwalk",unwalkEnabled,18,nil,function(on) unwalkEnabled=on;if on then startUnwalk() else stopUnwalk() end;saveConfig() end)
    setUnwalkVisual=svUnwalk

    addSectLbl(cp,"ACTIONS",19)
    addActionRow(cp,"Drop Brainrot","dropBrainrot",function() runDrop() end,20)
    addActionRow(cp,"Insta Reset","instaReset",function() cursedInstaReset() end,21)
    addActionRow(cp,"TP Down","tpDown",function() runTPFloor() end,22)
end)()

-- STEAL PAGE
;(function()
    local st=CategoryRefs.contents["Steal"]
    addSectLbl(st,"AUTO STEAL",0)
    addToggleRow(st,"Auto Steal",Steal.AutoStealEnabled,1,nil,function(on)
        Steal.AutoStealEnabled=on
        if on then startAutoSteal() else stopAutoSteal() end
        saveConfig()
    end)
    addInputRow(st,"Steal Radius",Steal.StealRadius,2,function(v) Steal.StealRadius=tonumber(v) or 60; saveConfig() end)
    addInputRow(st,"Steal Duration",Steal.StealDuration,3,function(v) Steal.StealDuration=tonumber(v) or 1.4; saveConfig() end)
end)()

-- MOVEMENT PAGE
;(function()
    local mv=CategoryRefs.contents["Movement"]
    addSectLbl(mv,"AUTO PATHS",0)
    local _,svAutoLeft=addToggleRow(mv,"Auto Left",autoLeftEnabled,1,"autoLeft",function(on)
        if on then
            if autoRightEnabled then autoRightEnabled=false;stopAutoRight();if autoRightSetVisual then autoRightSetVisual(false) end;if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end end
            if autoBatEnabled then stopBatAimbot();if autoBatSetVisual then autoBatSetVisual(false) end;if mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end end
            autoLeftEnabled=true;startAutoLeft();if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(true) end
        else autoLeftEnabled=false;stopAutoLeft();if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end end
        saveConfig()
    end)
    autoLeftSetVisual=svAutoLeft
    local _,svAutoRight=addToggleRow(mv,"Auto Right",autoRightEnabled,2,"autoRight",function(on)
        if on then
            if autoLeftEnabled then autoLeftEnabled=false;stopAutoLeft();if autoLeftSetVisual then autoLeftSetVisual(false) end;if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end end
            if autoBatEnabled then stopBatAimbot();if autoBatSetVisual then autoBatSetVisual(false) end;if mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end end
            autoRightEnabled=true;startAutoRight();if mobBtnRefs.autoRight then mobBtnRefs.autoRight(true) end
        else autoRightEnabled=false;stopAutoRight();if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end end
        saveConfig()
    end)
    autoRightSetVisual=svAutoRight
    addSectLbl(mv,"SETTINGS",3)
    local _,svAutoTP=addToggleRow(mv,"Auto TP",autoTPEnabled,4,nil,function(on) autoTPEnabled=on;if on then startAutoTP() else stopAutoTP() end;saveConfig() end)
    setAutoTPVisual=svAutoTP
    addInputRow(mv,"TP Height",autoTPHeight,5,function(v) if v>=0 and v<=500 then autoTPHeight=v end;saveConfig() end)
    local _,svInfJump=addToggleRow(mv,"Infinite Jump",infJumpEnabled,6,nil,function(on)
        infJumpEnabled=on; if on then startHoldInfJump() else stopHoldInfJump() end; saveConfig()
    end)
    setInfJumpVisual=svInfJump
end)()

-- VISUAL PAGE
;(function()
    local vi=CategoryRefs.contents["Visual"]

    addSectLbl(vi,"VISUAL",0)
    addToggleRow(vi,"Zombie Anims (Rembembi)",animEnabled,1,nil,function(on)
        animEnabled=on; if on then startAnimToggle() else stopAnimToggle() end; saveConfig()
    end)
    addToggleRow(vi,"Intro Song",introSoundEnabled,2,nil,function(on)
        introSoundEnabled=on
        if not on and introSoundInstance and introSoundInstance.IsPlaying then pcall(function() introSoundInstance:Stop() end) end
        saveConfig()
    end)
    addToggleRow(vi,"Anti Lag",antiLagEnabled,3,nil,function(on) if on then enableAntiLag() else disableAntiLag() end;saveConfig() end)
    addToggleRow(vi,"Stretch Rez",stretchRezEnabled,4,nil,function(on) if on then enableStretchRez() else disableStretchRez() end;saveConfig() end)
    addToggleRow(vi,"Ragdoll GUI",ragdollGuiEnabled,5,nil,function(on) ragdollGuiEnabled=on;saveConfig() end)

    addSectLbl(vi,"SKY THEME",8)
    local skyIdx=1; for i,t in ipairs(SkyOrder) do if t==currentSkyTheme then skyIdx=i;break end end
    local skyRow=Instance.new("Frame"); skyRow.Size=UDim2.new(1,0,0,38); skyRow.BackgroundColor3=C.row
    skyRow.BackgroundTransparency=0.5; skyRow.BorderSizePixel=0; skyRow.LayoutOrder=9; skyRow.Parent=vi
    guiCorner(skyRow,10); guiStroke(skyRow,C.divider,1)
    local skyLbl=Instance.new("TextLabel",skyRow); skyLbl.Size=UDim2.new(0.45,0,0,16); skyLbl.Position=UDim2.new(0,12,0,6)
    skyLbl.BackgroundTransparency=1; skyLbl.Text="Sky Theme"; skyLbl.TextColor3=C.white; skyLbl.TextSize=14; skyLbl.Font=Enum.Font.GothamBold; skyLbl.TextXAlignment=Enum.TextXAlignment.Left
    local skyVal=Instance.new("TextLabel",skyRow); skyVal.Size=UDim2.new(0,80,0,16); skyVal.Position=UDim2.new(1,-130,0,6)
    skyVal.BackgroundTransparency=1; skyVal.Text=currentSkyTheme; skyVal.TextColor3=C.white; skyVal.TextSize=11; skyVal.Font=Enum.Font.GothamBold; skyVal.TextXAlignment=Enum.TextXAlignment.Right
    local skyBtn=Instance.new("TextButton",skyRow); skyBtn.Size=UDim2.new(0,44,0,22); skyBtn.Position=UDim2.new(1,-52,0.5,-11)
    skyBtn.BackgroundColor3=C.blue; skyBtn.BackgroundTransparency=0.5; skyBtn.BorderSizePixel=0; skyBtn.Text="Next"
    skyBtn.TextColor3=C.white; skyBtn.TextSize=11; skyBtn.Font=Enum.Font.GothamBold; guiCorner(skyBtn,5)
    skyBtn.MouseButton1Click:Connect(function()
        skyIdx=skyIdx%#SkyOrder+1; currentSkyTheme=SkyOrder[skyIdx]; skyVal.Text=currentSkyTheme; CandyApplyCustomSky(currentSkyTheme); saveConfig()
    end)
    local hov2=Instance.new("TextButton",skyRow); hov2.Size=UDim2.new(1,0,1,0); hov2.BackgroundTransparency=1; hov2.Text=""; hov2.ZIndex=0
    hov2.MouseEnter:Connect(function() tw(skyRow,{BackgroundTransparency=0.3}) end); hov2.MouseLeave:Connect(function() tw(skyRow,{BackgroundTransparency=0.5}) end)

    addSectLbl(vi,"FOV",10)
    local fovRow=Instance.new("Frame"); fovRow.Size=UDim2.new(1,0,0,38); fovRow.BackgroundColor3=C.row
    fovRow.BackgroundTransparency=0.5; fovRow.BorderSizePixel=0; fovRow.LayoutOrder=11; fovRow.Parent=vi
    guiCorner(fovRow,10); guiStroke(fovRow,C.divider,1)
    local fovLbl=Instance.new("TextLabel",fovRow); fovLbl.Size=UDim2.new(0.5,0,0,16); fovLbl.Position=UDim2.new(0,12,0,6)
    fovLbl.BackgroundTransparency=1; fovLbl.Text="FOV"; fovLbl.TextColor3=C.white; fovLbl.TextSize=14; fovLbl.Font=Enum.Font.GothamBold; fovLbl.TextXAlignment=Enum.TextXAlignment.Left
    local fovBtn=Instance.new("TextButton",fovRow); fovBtn.Size=UDim2.new(0,52,0,22); fovBtn.Position=UDim2.new(1,-60,0.5,-11)
    fovBtn.BackgroundColor3=C.blue; fovBtn.BackgroundTransparency=0.5; fovBtn.BorderSizePixel=0
    fovBtn.Text=tostring(fovValue); fovBtn.TextColor3=C.white; fovBtn.TextSize=11; fovBtn.Font=Enum.Font.GothamBold; guiCorner(fovBtn,5)
    fovBtn.MouseButton1Click:Connect(function()
        fovIndex=fovIndex%#fovOptions+1; fovValue=fovOptions[fovIndex]; fovBtn.Text=tostring(fovValue); applyFOV(); saveConfig()
    end)
    local hov3=Instance.new("TextButton",fovRow); hov3.Size=UDim2.new(1,0,1,0); hov3.BackgroundTransparency=1; hov3.Text=""; hov3.ZIndex=0
    hov3.MouseEnter:Connect(function() tw(fovRow,{BackgroundTransparency=0.3}) end); hov3.MouseLeave:Connect(function() tw(fovRow,{BackgroundTransparency=0.5}) end)

    addSectLbl(vi,"GUI",12)
    local gRow=Instance.new("Frame"); gRow.Size=UDim2.new(1,0,0,42); gRow.BackgroundColor3=C.row
    gRow.BackgroundTransparency=0.5; gRow.BorderSizePixel=0; gRow.LayoutOrder=13; gRow.Parent=vi
    guiCorner(gRow,10); guiStroke(gRow,C.divider,1)
    local gLbl=Instance.new("TextLabel",gRow); gLbl.Size=UDim2.new(0.6,0,0,16); gLbl.Position=UDim2.new(0,12,0,8)
    gLbl.BackgroundTransparency=1; gLbl.Text="Hide GUI Key"; gLbl.TextColor3=C.white; gLbl.TextSize=14; gLbl.Font=Enum.Font.GothamBold; gLbl.TextXAlignment=Enum.TextXAlignment.Left
    local gKB=Instance.new("TextButton",gRow); gKB.Size=UDim2.new(0,45,0,22); gKB.Position=UDim2.new(1,-52,0.5,-11)
    gKB.BackgroundColor3=C.blue; gKB.BackgroundTransparency=0.5; gKB.BorderSizePixel=0; gKB.Text=prettyKey(Keys.guiHide)
    gKB.TextColor3=C.white; gKB.TextSize=11; gKB.Font=Enum.Font.GothamBold; guiCorner(gKB,5)
    gKB.MouseButton1Click:Connect(function() startKL(gKB,function(nk) Keys.guiHide=nk; gKB.Text=prettyKey(nk); saveConfig() end) end)

    addToggleRow(vi,"LOCK ALL (buttons + GUI)",uiLocked,16,nil,function(on)
        uiLocked=on; saveConfig()
    end)

    addSectLbl(vi,"ON-SCREEN BUTTONS",17)
    addToggleRow(vi,"Open Lagger Button",RXZ.laggerBtn,19,nil,function(on)
        RXZ.laggerBtn=on
        if not on then RXZ.closeLagger() end
        buildMobileButtons(); saveConfig()
    end)

    addSectLbl(vi,"RESET",14)
    local resetRow=Instance.new("Frame"); resetRow.Size=UDim2.new(1,0,0,38); resetRow.BackgroundColor3=C.row
    resetRow.BackgroundTransparency=0.5; resetRow.BorderSizePixel=0; resetRow.LayoutOrder=15; resetRow.Parent=vi
    guiCorner(resetRow,10); guiStroke(resetRow,C.divider,1)
    local resetLbl=Instance.new("TextLabel",resetRow); resetLbl.Size=UDim2.new(0.55,0,0,16); resetLbl.Position=UDim2.new(0,12,0,6)
    resetLbl.BackgroundTransparency=1; resetLbl.Text="Reset Settings"; resetLbl.TextColor3=C.white; resetLbl.TextSize=14; resetLbl.Font=Enum.Font.GothamBold; resetLbl.TextXAlignment=Enum.TextXAlignment.Left
    local resetBtn=Instance.new("TextButton",resetRow); resetBtn.Size=UDim2.new(0,52,0,22); resetBtn.Position=UDim2.new(1,-60,0.5,-11)
    resetBtn.BackgroundColor3=Color3.fromRGB(150,30,40); resetBtn.BackgroundTransparency=0.2; resetBtn.BorderSizePixel=0
    resetBtn.Text="RESET"; resetBtn.TextColor3=C.white; resetBtn.TextSize=11; resetBtn.Font=Enum.Font.GothamBold; guiCorner(resetBtn,5)
    resetBtn.MouseButton1Click:Connect(function() resetAllSettings() end)
    local hov4=Instance.new("TextButton",resetRow); hov4.Size=UDim2.new(1,0,1,0); hov4.BackgroundTransparency=1; hov4.Text=""; hov4.ZIndex=0
    hov4.MouseEnter:Connect(function() tw(resetRow,{BackgroundTransparency=0.3}) end); hov4.MouseLeave:Connect(function() tw(resetRow,{BackgroundTransparency=0.5}) end)
end)()

-- KEYBOARD SHORTCUTS
UIS.InputBegan:Connect(function(inp,gp)
    if gp then return end
    if UIS:GetFocusedTextBox() then return end
    if inp.KeyCode==Keys.guiHide then if GuiRefs.outer then GuiRefs.outer.Visible=not GuiRefs.outer.Visible end
    elseif inp.KeyCode==Keys.speed then speedToggleAction(); saveConfig()
    elseif inp.KeyCode==Keys.carryMode then toggleCarryMode(); saveConfig()
    elseif inp.KeyCode==Keys.laggerToggle then toggleLaggerMode(); saveConfig()
    elseif inp.KeyCode==Keys.circle then autoBatEnabled=not autoBatEnabled; if autoBatEnabled then startBatAimbot() else stopBatAimbot() end; saveConfig()
    elseif inp.KeyCode==Keys.dropBrainrot then runDrop()
    elseif inp.KeyCode==Keys.tpDown then runTPFloor()
    elseif inp.KeyCode==Keys.instaReset then cursedInstaReset()
    elseif inp.KeyCode==Keys.autoLeft then
        if autoLeftEnabled then
            autoLeftEnabled=false; stopAutoLeft()
        else
            if autoRightEnabled then autoRightEnabled=false;stopAutoRight();if autoRightSetVisual then autoRightSetVisual(false) end;if mobBtnRefs.autoRight then mobBtnRefs.autoRight(false) end end
            if autoBatEnabled then stopBatAimbot();if autoBatSetVisual then autoBatSetVisual(false) end;if mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end end
            autoLeftEnabled=true; startAutoLeft()
        end
        if autoLeftSetVisual then autoLeftSetVisual(autoLeftEnabled) end
        if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(autoLeftEnabled) end
    elseif inp.KeyCode==Keys.autoRight then
        if autoRightEnabled then
            autoRightEnabled=false; stopAutoRight()
        else
            if autoLeftEnabled then autoLeftEnabled=false;stopAutoLeft();if autoLeftSetVisual then autoLeftSetVisual(false) end;if mobBtnRefs.autoLeft then mobBtnRefs.autoLeft(false) end end
            if autoBatEnabled then stopBatAimbot();if autoBatSetVisual then autoBatSetVisual(false) end;if mobBtnRefs.autoBat then mobBtnRefs.autoBat(false) end end
            autoRightEnabled=true; startAutoRight()
        end
        if autoRightSetVisual then autoRightSetVisual(autoRightEnabled) end
        if mobBtnRefs.autoRight then mobBtnRefs.autoRight(autoRightEnabled) end
    end
end)

-- STARTUP
if infJumpEnabled then startHoldInfJump() end
if antiRagdollEnabled then startAntiRagdoll() end
if medusaCounterEnabled then setupMedusa(LP.Character) end
if animEnabled then startAnimToggle() end
if RXZ.medusaReset then setupMedusa(LP.Character) end
CandyApplyCustomSky(currentSkyTheme)
if RXZ.antiMedusa then RXZ.startAntiMedusa() end
buildMobileButtons()

end)() -- end GUI function


-- ============================================================
-- VELOCITY Y TRICK SPEED
-- ============================================================
local VELOCITY_Y_TRICK = 0.000026
local activeSpeedValue = 60
local isJumping = false

do
    local Player = LP
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local HRP = Character and Character:FindFirstChild("HumanoidRootPart")

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Space then
            isJumping = true
            task.wait(0.25)
            isJumping = false
        end
    end)

    RunService.Heartbeat:Connect(function()
        if HRP and math.abs(HRP.AssemblyLinearVelocity.Y) > 3 then
            isJumping = true
        elseif HRP and math.abs(HRP.AssemblyLinearVelocity.Y) < 1 and isJumping then
            isJumping = false
        end
    end)

    RunService.Heartbeat:Connect(function()
        if not Humanoid or not HRP then return end

        Humanoid.WalkSpeed = activeSpeedValue

        local direction = Humanoid.MoveDirection
        if direction.Magnitude > 0.1 then
            local currentVel = HRP.AssemblyLinearVelocity

            local newYVel = currentVel.Y
            if not isJumping and math.abs(currentVel.Y) < 1 then
                newYVel = VELOCITY_Y_TRICK
            end

            HRP.AssemblyLinearVelocity = Vector3.new(
                direction.X * activeSpeedValue,
                newYVel,
                direction.Z * activeSpeedValue
            )
        end
    end)

    Player.CharacterAdded:Connect(function(char)
        Character = char
        Humanoid = char:WaitForChild("Humanoid")
        HRP = char:WaitForChild("HumanoidRootPart")
        task.wait(0.5)
        Humanoid.WalkSpeed = 16
    end)
end

print("RXZ HUB LOADED")
