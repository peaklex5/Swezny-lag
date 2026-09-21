-- Swenzy Hub | Steal An Egg
-- Educational purposes

for _, obj in getgc(true) do
    if typeof(obj) ~= "table" or getrawmetatable(obj) then continue end
    local mainrun = false
    for _, v in obj do
        if v == obj then mainrun = true break end
    end
    if not mainrun then continue end
    for _, v in obj do
        if typeof(v) == "number" and v >= 1 and v <= 3 and obj[v] == nil then
            setmetatable(obj, {__newindex = function() end})
            break
        end
    end
end
local _chk_Players = game:GetService("Players")
local _chk_TweenService = game:GetService("TweenService")
local _chk_CoreGui = game:GetService("CoreGui")
local _chk_player = _chk_Players.LocalPlayer

local REQUIRED_FUNCS = {
    { Name = "loadstring", Test = function() return type(loadstring) == "function" end },
    { Name = "HTTP", Test = function()
        if type(game.HttpGet) == "function" then return true end
        if type(request) == "function" or type(http_request) == "function" then return true end
        if type(syn) == "table" and type(syn.request) == "function" then return true end
        return false
    end },
}

local missing = {}
for _, item in ipairs(REQUIRED_FUNCS) do
    local ok = pcall(item.Test)
    if not ok then
        table.insert(missing, item.Name)
    end
end

local function showWarning(msg)
    local sg = Instance.new("ScreenGui")
    sg.Name = "ExecutorCompatWarning"
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() sg.Parent = _chk_CoreGui end)
    if not sg.Parent then sg.Parent = _chk_player:WaitForChild("PlayerGui") end

    local blur = Instance.new("Frame")
    blur.Size = UDim2.new(1, 0, 1, 0)
    blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blur.BackgroundTransparency = 0.35
    blur.BorderSizePixel = 0
    blur.ZIndex = 100
    blur.Parent = sg

    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 340, 0, 160)
    card.Position = UDim2.new(0.5, -170, 0.5, -80)
    card.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    card.BorderSizePixel = 0
    card.ZIndex = 101
    card.Parent = sg

    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)

    local stroke = Instance.new("UIStroke", card)
    stroke.Color = Color3.fromRGB(255, 80, 80)
    stroke.Thickness = 2

    local icon = Instance.new("TextLabel", card)
    icon.Size = UDim2.new(1, 0, 0, 40)
    icon.Position = UDim2.new(0, 0, 0, 14)
    icon.BackgroundTransparency = 1
    icon.Text = "⚠️"
    icon.TextSize = 32
    icon.Font = Enum.Font.GothamBold
    icon.TextColor3 = Color3.fromRGB(255, 80, 80)
    icon.ZIndex = 102

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1, -24, 0, 24)
    title.Position = UDim2.new(0, 12, 0, 56)
    title.BackgroundTransparency = 1
    title.Text = "Executor Not Supported"
    title.TextSize = 17
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.ZIndex = 102

    local body = Instance.new("TextLabel", card)
    body.Size = UDim2.new(1, -24, 0, 50)
    body.Position = UDim2.new(0, 12, 0, 84)
    body.BackgroundTransparency = 1
    body.Text = msg
    body.TextSize = 12
    body.Font = Enum.Font.Gotham
    body.TextColor3 = Color3.fromRGB(200, 200, 210)
    body.TextWrapped = true
    body.ZIndex = 102
end

local function showSuccessPopup()
    local sg = Instance.new("ScreenGui")
    sg.Name = "ExecutorCompatSuccess"
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() sg.Parent = _chk_CoreGui end)
    if not sg.Parent then sg.Parent = _chk_player:WaitForChild("PlayerGui") end

    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 260, 0, 44)
    card.Position = UDim2.new(0.5, -130, 0, -60)
    card.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    card.BorderSizePixel = 0
    card.ZIndex = 101
    card.Parent = sg

    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", card)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.5

    local icon = Instance.new("TextLabel", card)
    icon.Size = UDim2.new(0, 30, 1, 0)
    icon.Position = UDim2.new(0, 10, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = "✅"
    icon.TextSize = 18
    icon.Font = Enum.Font.GothamBold
    icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    icon.ZIndex = 102

    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.Position = UDim2.new(0, 40, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Executor Supported"
    lbl.TextSize = 14
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.ZIndex = 102

    _chk_TweenService:Create(card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -130, 0, 24)
    }):Play()

    task.delay(2.5, function()
        local out = _chk_TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -130, 0, -60)
        })
        out:Play()
        out.Completed:Wait()
        sg:Destroy()
    end)
end

if #missing > 0 then
    showWarning("Your executor is missing required functions:\n" .. table.concat(missing, ", ") .. "\n\nThis script requires a full Roblox executor.")
    return
else
    showSuccessPopup()
end

local WindUILoadOk, WindUILoadResult = pcall(function()
    local body = game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")
    return loadstring(body)()
end)

if not WindUILoadOk or not WindUILoadResult then
    warn("[Swenzy Hub] WindUI failed to load: " .. tostring(WindUILoadResult))
    return
end

local WindUI = WindUILoadResult

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local Memory = getgenv().MergedUtilityMemory
if not Memory then
    Memory = {
        SpeedEnabled = true,
        DesiredSpeed = 500,
        SpeedBypassMethod = "Humanoid Clone",
        AntiKnockbackEnabled = false,
        AntiRagdollEnabled = false,
        InstantAccelerationEnabled = false,
        AntiRejoinEnabled = false,
        FlyEnabled = false,
        FlySpeed = 50,
        EggEspEnabled = false,
        EggAutoStealEnabled = false,
        EggRarityFilter = "All",
        EggBigOnly = false,
        AntiTrapEnabled = false,
        AutoSellEnabled = false,
        AutoSellRarities = {"Common", "Uncommon", "Rare", "Epic"},
        AutoPlaceAll = false,
        AutoHatch = false,
        AutoEnterAbyss = false,
        AutoClaim = false,
        AutoUpgradeBase = false,
        AutoUpgradeTreadmill = false,
        AutoBuyTrail = false,
    }
    getgenv().MergedUtilityMemory = Memory
end

local DesiredSpeed = Memory.DesiredSpeed or 500
local SpeedEnabled = Memory.SpeedEnabled or false
local SpeedBypassMethod = Memory.SpeedBypassMethod or "Humanoid Clone"

local AntiKnockbackEnabled = Memory.AntiKnockbackEnabled or false
local AntiRagdollEnabled = Memory.AntiRagdollEnabled or false
local InstantAccelerationEnabled = Memory.InstantAccelerationEnabled or false
local AntiRejoinEnabled = Memory.AntiRejoinEnabled or false
local FlyEnabled = Memory.FlyEnabled or false
local FlySpeed = Memory.FlySpeed or 50
local AntiTrapEnabled = Memory.AntiTrapEnabled or false
local AutoSellEnabled = Memory.AutoSellEnabled or false
local AutoSellRarities = Memory.AutoSellRarities or {"Common", "Uncommon", "Rare", "Epic"}

local FlyBodyVelocity = nil
local FlyBodyGyro = nil
local FlyConnection = nil
local CurrentHumanoid = nil
local ragdollConnection = nil
local joints = {}

local DEFAULT_THEME = "SwenzyHub Dark"

local function Gradient(colors, rotation)
    local points = {}
    for position, color in pairs(colors) do
        if type(color) == "table" then
            points[position] = {
                Color = Color3.fromHex(color.Color),
                Transparency = color.Transparency or 0,
            }
        else
            points[position] = {
                Color = Color3.fromHex(color),
                Transparency = 0,
            }
        end
    end
    return WindUI:Gradient(points, { Rotation = rotation or 45 })
end

-- Siyah ve yüksek kontrastlı (kolay okunabilir) tema ayarı
WindUI:AddTheme({
    Name = DEFAULT_THEME,
    Accent = Gradient({ ["0"] = "#FFFFFF", ["50"] = "#D4D4D4", ["100"] = "#888888" }, 45),
    Background = Gradient({
        ["0"] = { Color = "#000000", Transparency = 0.02 },
        ["25"] = { Color = "#0A0A0A", Transparency = 0.04 },
        ["50"] = { Color = "#121212", Transparency = 0.06 },
        ["75"] = { Color = "#0A0A0A", Transparency = 0.04 },
        ["100"] = { Color = "#000000", Transparency = 0.02 },
    }, 135),
    Outline = Gradient({
        ["0"] = { Color = "#2E2E2E", Transparency = 0.3 },
        ["50"] = { Color = "#555555", Transparency = 0.1 },
        ["100"] = { Color = "#2E2E2E", Transparency = 0.3 },
    }, 90),
    Button = Gradient({
        ["0"] = { Color = "#141414", Transparency = 0.5 },
        ["50"] = { Color = "#242424", Transparency = 0.4 },
        ["100"] = { Color = "#141414", Transparency = 0.5 },
    }, 90),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#CCCCCC"),
    Icon = Color3.fromHex("#FFFFFF"),
})

WindUI:SetTheme(DEFAULT_THEME)

local Window = WindUI:CreateWindow({
    Title = "Swenzy Hub",
    Icon = "rbxassetid://103200565052007",
    Author = "Swenzy",
    Folder = "SwenzyHub",
    Size = UDim2.fromOffset(520, 420),
    MinSize = Vector2.new(420, 320),
    ToggleKey = Enum.KeyCode.K,
    Transparent = true,
    Theme = DEFAULT_THEME,
    Resizable = true,
    SideBarWidth = 160,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    ShadowTransparency = 0.22,
    Radius = 14,
    ElementsRadius = 10,
    Acrylic = true,
    NewElements = true,
    HidePanelBackground = true,
    Topbar = { Height = 44, ButtonsType = "Mac" },
    OpenButton = {
        Title = "Open Swenzy Hub",
        Icon = "rbxassetid://103200565052007",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 1,
        Draggable = true,
        Enabled = true,
        OnlyMobile = false,
        Scale = 0.92,
        Color = ColorSequence.new(Color3.fromHex("#1F1F1F"), Color3.fromHex("#383838")),
    },
    User = {
        Enabled = true,
        Anonymous = false,
        Image = "rbxassetid://103200565052007",
        Callback = function()
            WindUI:Notify({
                Title = "Swenzy Hub",
                Content = player.Name,
                Icon = "user",
                Duration = 3,
            })
        end,
    },
})

Window:SetBackgroundTransparency(0.5)

local MainTab = Window:Tab({ Title = "Main", Icon = "layout-dashboard" })
local EggTab = Window:Tab({ Title = "Egg Steal", Icon = "egg" })
local AutoSellTab = Window:Tab({ Title = "Auto Sell", Icon = "tag" })
local AutomationTab = Window:Tab({ Title = "Automation", Icon = "bot" })

local DISCORD_LINK = "https://discord.gg/PEsmsDCHdf"

local function copyDiscordLink()
    local funcs = {
        function() return setclipboard(DISCORD_LINK) end,
        function() return toclipboard(DISCORD_LINK) end,
        function() return set_clipboard(DISCORD_LINK) end,
    }

    for _, fn in ipairs(funcs) do
        local ok = pcall(fn)
        if ok then
            return true
        end
    end

    return false
end

local function showDiscordPopup()
    local existing = _chk_CoreGui:FindFirstChild("DiscordPopupGui")
    if not existing and LocalPlayer then
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        existing = playerGui and playerGui:FindFirstChild("DiscordPopupGui")
    end

    if existing then
        existing:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DiscordPopupGui"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 1000

    pcall(function()
        screenGui.Parent = game:GetService("CoreGui")
    end)

    if not screenGui.Parent then
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 150)
    frame.Position = UDim2.new(0.5, -160, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(88, 101, 242)
    stroke.Thickness = 2
    stroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.BackgroundTransparency = 1
    title.Text = "Join our discord for more scripts!"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, 120, 0, 40)
    copyBtn.Position = UDim2.new(0, 30, 0, 80)
    copyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    copyBtn.Text = "Copy Link"
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.Font = Enum.Font.GothamSemibold
    copyBtn.TextSize = 14
    copyBtn.Parent = frame

    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 6)
    copyCorner.Parent = copyBtn

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 120, 0, 40)
    closeBtn.Position = UDim2.new(0, 170, 0, 80)
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    closeBtn.Text = "Close"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamSemibold
    closeBtn.TextSize = 14
    closeBtn.Parent = frame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    copyBtn.Activated:Connect(function()
        if copyDiscordLink() then
            copyBtn.Text = "Copied!"
        else
            copyBtn.Text = "Clipboard unavailable"
        end

        task.delay(1.5, function()
            if copyBtn and copyBtn.Parent then
                copyBtn.Text = "Copy Link"
            end
        end)
    end)

    closeBtn.Activated:Connect(function()
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end)
end

local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

task.defer(function()
    pcall(showDiscordPopup)
end)

local function safeRequire(parent, ...)
    local current = parent
    for _, name in ipairs({...}) do
        local child = current:FindFirstChild(name)
        if not child then
            local success, result = pcall(function() return current:WaitForChild(name, 5) end)
            if success and result then child = result else return nil end
        end
        current = child
    end
    if not current:IsA("ModuleScript") then return nil end
    local success, result = pcall(require, current)
    return success and result or nil
end

local EggState = safeRequire(ReplicatedStorage, "Client", "EggState")
local Assets = safeRequire(ReplicatedStorage, "Data", "Assets")
local WorkspaceEggVisibility = nil
pcall(function()
    WorkspaceEggVisibility = require(LocalPlayer.PlayerScripts.Game.AreaEggs.WorkspaceEggVisibility)
end)

if not EggState or not Assets then
    warn("Axur Steal: Critical modules missing.")
end

local RarityColors = {
    Common = Color3.fromRGB(150,150,150), Uncommon = Color3.fromRGB(100,200,100),
    Rare = Color3.fromRGB(100,150,255), SuperRare = Color3.fromRGB(80,120,255),
    Epic = Color3.fromRGB(180,80,255), Legendary = Color3.fromRGB(255,200,50),
    Mythic = Color3.fromRGB(255,100,200), Mythical = Color3.fromRGB(255,100,200),
    Divine = Color3.fromRGB(255,50,50), Secret = Color3.fromRGB(255,30,30),
    BrainrotGod = Color3.fromRGB(255,0,0), God = Color3.fromRGB(255,0,0),
    Exclusive = Color3.fromRGB(255,100,50), Limited = Color3.fromRGB(255,150,50),
    Prismatic = Color3.fromRGB(255,100,255), Transcendent = Color3.fromRGB(200,50,255),
    Eternal = Color3.fromRGB(100,255,255), Exotic = Color3.fromRGB(255,200,100),
    Rainbow = Color3.fromRGB(255,100,255), Superior = Color3.fromRGB(255,80,80),
    Titan = Color3.fromRGB(255,120,50), Celestial = Color3.fromRGB(100,200,255),
    Cosmic = Color3.fromRGB(150,100,255), Admin = Color3.fromRGB(255,0,0),
}

local espEnabled = Memory.EggEspEnabled or false
local autoStealEnabled = Memory.EggAutoStealEnabled or false
local eggRarityFilter = Memory.EggRarityFilter or "All"
local eggBigOnly = Memory.EggBigOnly or false
local trackedEggs = {}
local bestEggUid = nil
local espBeam = nil
local espPlayerAttach = nil
local espEggAttach = nil
local modelCache = {}
local promptCache = {}
local espLoopRunning = false
local autoLoopRunning = false
local bigOnlyAutoStealEnabled = false
local bigOnlyLoopRunning = false

local function findEggModel(uid)
    local cached = modelCache[uid]
    if cached and cached.Parent then return cached end

    if WorkspaceEggVisibility and WorkspaceEggVisibility.ResolveModel then
        local s, r = pcall(function() return WorkspaceEggVisibility.ResolveModel(uid) end)
        if s and r and r:IsA("Model") then
            modelCache[uid] = r
            return r
        end
    end

    local m = Workspace:FindFirstChild(uid)
    if m and m:IsA("Model") then
        modelCache[uid] = m
        return m
    end

    local aesc = Workspace:FindFirstChild("AreaEggSlotsClient")
    if aesc then
        m = aesc:FindFirstChild(uid)
        if m and m:IsA("Model") then
            modelCache[uid] = m
            return m
        end
    end

    return nil
end

local function getModelBasePart(model)
    if not model then return nil end
    if model.PrimaryPart then return model.PrimaryPart end
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("BasePart") then return d end
    end
    return nil
end

local function getModelPrompt(model)
    if not model then return nil end
    local cached = promptCache[model]
    if cached and cached.Parent then return cached end
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("ProximityPrompt") and d.Name == "CarryAreaEgg" then
            promptCache[model] = d
            return d
        end
    end
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
            promptCache[model] = d
            return d
        end
    end
    return nil
end

local function isEggCarriedByOtherPlayer(uid)
    local data = trackedEggs[uid]
    if not data then return false end
    local model = data.model
    if not model then return false end

    local parent = model.Parent
    if parent then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and parent:IsDescendantOf(plr.Character) then
                return true, plr
            end
        end
    end

    local record = data.record
    local eggName = nil
    if record and record.AssetCategory then
        eggName = tostring(record.AssetCategory):lower()
    end
    local modelName = model.Name:lower()

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            if char then
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        local tName = tool.Name:lower()
                        if tName:find("area egg") or tName:find("carryareaegg") or
                           tName == "egg" or tName:find("^egg_") or tName:find("_egg$") then
                            if eggName and (tName:find(eggName) or modelName:find(tName) or tName:find(modelName)) then
                                return true, plr
                            elseif not eggName then
                                return true, plr
                            end
                        end
                    end
                end
            end
            local backpack = plr:FindFirstChild("Backpack")
            if backpack then
                for _, tool in ipairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        local tName = tool.Name:lower()
                        if tName:find("area egg") or tName:find("carryareaegg") or
                           tName == "egg" or tName:find("^egg_") or tName:find("_egg$") then
                            if eggName and (tName:find(eggName) or modelName:find(tName) or tName:find(modelName)) then
                                return true, plr
                            elseif not eggName then
                                return true, plr
                            end
                        end
                    end
                end
            end
        end
    end

    local prompt = getModelPrompt(model)
    if prompt and prompt.Enabled == false then
        return true, nil
    end

    local carrierAttr = model:GetAttribute("Carrier")
    if carrierAttr and carrierAttr ~= LocalPlayer.UserId then
        return true, Players:GetPlayerByUserId(carrierAttr)
    end

    return false, nil
end

local carriedEggsCache = {}
local lastCarryCheckTime = 0

local function refreshCarriedEggsCache()
    local now = tick()
    if now - lastCarryCheckTime < 0.3 then return end
    lastCarryCheckTime = now
    carriedEggsCache = {}
    for uid in pairs(trackedEggs) do
        local carried, carrier = isEggCarriedByOtherPlayer(uid)
        if carried then
            carriedEggsCache[uid] = carrier
        end
    end
end

local function findPromptNearPosition(position, maxDist)
    maxDist = maxDist or 25
    local bestPrompt, bestDist = nil, maxDist
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.Name == "CarryAreaEgg" and obj.Enabled then
            local parent = obj.Parent
            if parent and parent:IsA("BasePart") then
                local dist = (parent.Position - position).Magnitude
                if dist < bestDist then
                    bestDist = dist
                    bestPrompt = obj
                end
            end
        end
    end
    return bestPrompt
end

local function getRarityColor(category)
    local info = Assets and Assets.Directory and Assets.Directory[category]
    local r = info and info.Rarity
    if not r or not r.Name then return Color3.fromRGB(150,150,150) end
    return RarityColors[tostring(r.Name)] or Color3.fromRGB(150,150,150)
end

local rarityNameCache = {}
local function getEggRarityName(record)
    if not record then return "Unknown" end
    local cat = record.AssetCategory
    if not cat then return "Unknown" end
    local cached = rarityNameCache[cat]
    if cached then return cached end
    local info = Assets and Assets.Directory and Assets.Directory[cat]
    local r = info and info.Rarity
    if not r then
        rarityNameCache[cat] = "Unknown"
        return "Unknown"
    end
    local name = "Unknown"
    if r.Name ~= nil then
        name = tostring(r.Name)
    elseif type(r) == "string" then
        name = r
    end
    rarityNameCache[cat] = name
    return name
end

local RarityPriority = {
    ["admin"] = 100, ["secret"] = 99, ["brainrotgod"] = 98,
    ["divine"] = 97, ["god"] = 96,
    ["eternal"] = 90, ["transcendent"] = 89, ["prismatic"] = 88,
    ["celestial"] = 87, ["cosmic"] = 86, ["titan"] = 85,
    ["mythical"] = 80, ["mythic"] = 79, ["superior"] = 78,
    ["exclusive"] = 77, ["limited"] = 76,
    ["legendary"] = 60,
    ["epic"] = 50, ["exotic"] = 49, ["rainbow"] = 48,
    ["superrare"] = 30, ["rare"] = 20, ["uncommon"] = 10, ["common"] = 1,
}

local function getModelSizeScore(model)
    if not model or not model.Parent then return 0 end
    local success, size = pcall(function()
        return model:GetExtentsSize()
    end)
    if success and size then
        local maxDim = math.max(size.X, size.Y, size.Z)
        return math.floor(maxDim * 100)
    end
    return 0
end

local function getEggRarityPriority(record)
    local info = Assets and Assets.Directory and Assets.Directory[record.AssetCategory]
    local r = info and info.Rarity
    if not r then return 0 end
    local name = r.Name and tostring(r.Name):lower() or ""
    local priority = RarityPriority[name] or 0
    if priority == 0 and record.AssetCategory then
        local catName = tostring(record.AssetCategory):lower()
        for rarityName, p in pairs(RarityPriority) do
            if catName:find(rarityName) then
                priority = p
                break
            end
        end
    end
    return priority
end

local function scoreEgg(data)
    local record = data.record
    local sizeScore = getModelSizeScore(data.model)
    if eggBigOnly then
        return sizeScore
    end
    local priority = getEggRarityPriority(record)
    local info = Assets and Assets.Directory and Assets.Directory[record.AssetCategory]
    local r = info and info.Rarity
    local rarityNumber = (r and r.RarityNumber) or 0

    if eggRarityFilter ~= "All" then
        return (sizeScore * 100000000) + rarityNumber
    end

    return (priority * 100000000) + (rarityNumber * 10000) + sizeScore
end

local function findBestEgg()
    local bestUid, bestScore = nil, -1
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local playerPos = hrp and hrp.Position or nil

    refreshCarriedEggsCache()

    for uid, data in pairs(trackedEggs) do
        if data.model and data.model.Parent then
            if carriedEggsCache[uid] then continue end

            local passesFilter = true
            if eggRarityFilter ~= "All" then
                local rarityName = getEggRarityName(data.record)
                if rarityName:lower() ~= eggRarityFilter:lower() then
                    passesFilter = false
                end
            end
            if not passesFilter then continue end

            local s = scoreEgg(data)
            local isBetter = false
            if s > bestScore then
                isBetter = true
            elseif s == bestScore and playerPos then
                local bp = data.basePart or getModelBasePart(data.model)
                if bp then
                    local dist = (playerPos - bp.Position).Magnitude
                    local bestData = bestUid and trackedEggs[bestUid]
                    local bestBp = bestData and (bestData.basePart or getModelBasePart(bestData.model))
                    local bestDist = bestBp and (playerPos - bestBp.Position).Magnitude or math.huge
                    if dist < bestDist then
                        isBetter = true
                    end
                end
            end
            if isBetter then
                bestScore = s
                bestUid = uid
            end
        end
    end
    return bestUid, bestScore
end

local function clearAll()
    for uid, data in pairs(trackedEggs) do
        pcall(function() if data.highlight then data.highlight:Destroy() end end)
    end
    trackedEggs = {}
    modelCache = {}
    promptCache = {}
    bestEggUid = nil
    pcall(function() if espBeam then espBeam:Destroy() end end)
    pcall(function() if espPlayerAttach then espPlayerAttach:Destroy() end end)
    pcall(function() if espEggAttach then espEggAttach:Destroy() end end)
    espBeam = nil
    espPlayerAttach = nil
    espEggAttach = nil
end

local function ensureHighlight(uid)
    local data = trackedEggs[uid]
    if not data then return end
    local model = data.model
    if not model or not model.Parent then return end
    if data.highlight and data.highlight.Parent then
        pcall(function()
            local color = getRarityColor(data.record.AssetCategory)
            data.highlight.FillColor = color
            data.highlight.OutlineColor = color
        end)
        return
    end
    pcall(function()
        local color = getRarityColor(data.record.AssetCategory)
        local hl = Instance.new("Highlight")
        hl.Name = "AxurEggESP"
        hl.Adornee = model
        hl.FillTransparency = 0.7
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.FillColor = color
        hl.OutlineColor = color
        hl.Parent = model
        data.highlight = hl
    end)
end

local function updateBeam()
    if not espEnabled or not bestEggUid then return end
    local data = trackedEggs[bestEggUid]
    if not data then return end
    local model = data.model
    if not model or not model.Parent then return end
    local basePart = data.basePart
    if not basePart or not basePart.Parent then
        basePart = getModelBasePart(model)
        data.basePart = basePart
        if not basePart then return end
    end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if not espPlayerAttach or espPlayerAttach.Parent ~= hrp then
        pcall(function() if espPlayerAttach then espPlayerAttach:Destroy() end end)
        espPlayerAttach = Instance.new("Attachment")
        espPlayerAttach.Name = "BestEggESP_PlayerAttachment"
        espPlayerAttach.Parent = hrp
        if espBeam then espBeam.Attachment0 = espPlayerAttach end
    end
    if not espEggAttach or espEggAttach.Parent ~= basePart then
        pcall(function() if espEggAttach then espEggAttach:Destroy() end end)
        espEggAttach = Instance.new("Attachment")
        espEggAttach.Name = "BestEggESP_EggAttachment"
        espEggAttach.Parent = basePart
        if espBeam then espBeam.Attachment1 = espEggAttach end
    end
    if not espBeam or espBeam.Parent == nil then
        espBeam = Instance.new("Beam")
        espBeam.Name = "BestEggESP_Tracer"
        espBeam.FaceCamera = true
        espBeam.LightEmission = 1
        espBeam.LightInfluence = 0
        espBeam.Width0 = 0.18
        espBeam.Width1 = 0.18
        espBeam.Transparency = NumberSequence.new(0)
        espBeam.Segments = 12
        espBeam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        espBeam.Parent = hrp
        espBeam.Attachment0 = espPlayerAttach
        espBeam.Attachment1 = espEggAttach
    end
end

local function syncEggs()
    if not EggState or not EggState.ReadFieldEggs then return end
    lastSyncTime = tick()
    local success, snapshot = pcall(EggState.ReadFieldEggs, EggState)
    if not success or not snapshot or not snapshot.Records then
        clearAll()
        return
    end

    local currentUids = {}
    for _, record in ipairs(snapshot.Records) do
        currentUids[record.Uid] = true
        if not trackedEggs[record.Uid] then
            trackedEggs[record.Uid] = {record = record, highlight = nil, model = nil, basePart = nil}
        else
            trackedEggs[record.Uid].record = record
        end
    end

    for uid in pairs(trackedEggs) do
        if not currentUids[uid] then
            pcall(function() if trackedEggs[uid].highlight then trackedEggs[uid].highlight:Destroy() end end)
            trackedEggs[uid] = nil
            modelCache[uid] = nil
            if bestEggUid == uid then bestEggUid = nil end
        end
    end

    for uid, data in pairs(trackedEggs) do
        if not data.model or not data.model.Parent then
            local model = findEggModel(uid)
            if model then
                data.model = model
                data.basePart = getModelBasePart(model)
            end
        end
        if data.model and data.model.Parent then
            local passesFilter = true
            if eggRarityFilter ~= "All" then
                local rarityName = getEggRarityName(data.record)
                if rarityName:lower() ~= eggRarityFilter:lower() then
                    passesFilter = false
                end
            end
            if passesFilter then
                ensureHighlight(uid)
            else
                pcall(function()
                    if data.highlight then
                        data.highlight:Destroy()
                        data.highlight = nil
                    end
                end)
            end
        end
    end

    local newBest = findBestEgg()
    if newBest ~= bestEggUid then
        bestEggUid = newBest
        pcall(function() if espEggAttach then espEggAttach:Destroy() end end)
        espEggAttach = nil
    end
end

EggTab:Section({ Title = "Auto Steal", Icon = "egg", Opened = true })

local EggEspToggle = EggTab:Toggle({
    Title = "Best Egg ESP",
    Desc = "Esp's best egg currently at the game.",
    Icon = "eye",
    Type = "Toggle",
    Value = espEnabled,
    Callback = function(value)
        espEnabled = value
        Memory.EggEspEnabled = value
        if espEnabled then
            syncEggs()
            if not espLoopRunning then
                espLoopRunning = true
                task.spawn(function()
                    while espEnabled do
                        syncEggs()
                        task.wait(0.5)
                    end
                    espLoopRunning = false
                end)
            end
        else
            clearAll()
        end
    end,
})

local StealState = {
    IDLE = "IDLE",
    MOVING_TO_EGG = "MOVING_TO_EGG",
    COLLECTING = "COLLECTING",
    RETURNING = "RETURNING",
    DEPOSITING = "DEPOSITING",
    WAITING_RESET = "WAITING_RESET",
    WAITING = "WAITING",
    RAGDOLLED_RUSH = "RAGDOLLED_RUSH",
    MOVING_TO_BEST = "MOVING_TO_BEST",
    COLLECTING_BEST = "COLLECTING_BEST",
}

local currentStealState = StealState.IDLE
local activeTween = nil
local targetEggUid = nil
local safePosition = Vector3.new(536.423340, 70.333313, -364.236969)
local antiTrapPosition = Vector3.new(806, 167, -407)
local tweenSpeed = 600
local isCarryingEgg = false

local function getReturnPosition()
    if AntiTrapEnabled then
        return Vector3.new(safePosition.X, antiTrapPosition.Y, safePosition.Z)
    end
    return safePosition
end

local virtualAnchor = Instance.new("Part")
virtualAnchor.Anchored = true
virtualAnchor.CanCollide = false
virtualAnchor.Transparency = 1
virtualAnchor.Size = Vector3.new(1, 1, 1)
virtualAnchor.Parent = workspace.Terrain

local currentConnection = nil
local tweenCancelled = false

local AreaEggResetWall = safeRequire(ReplicatedStorage, "Client", "AreaEggResetWall")
local EggStateModule = safeRequire(ReplicatedStorage, "Client", "EggState")

local rawCarryState = false
if EggStateModule and EggStateModule.CarryChanged then
    pcall(function()
        EggStateModule.CarryChanged:Connect(function(carryData)
            rawCarryState = carryData and carryData.IsCarrying == true
        end)
    end)
end

local function cancelActiveTween()
    tweenCancelled = true
    if activeTween then
        pcall(function() activeTween:Cancel() end)
        activeTween = nil
    end
    if currentConnection then
        pcall(function() currentConnection:Disconnect() end)
        currentConnection = nil
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end
end

local function tweenCharacterTo(targetPos, speed)
    cancelActiveTween()
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local dist = (hrp.Position - targetPos).Magnitude
    if dist < 3 then return true end

    tweenCancelled = false
    virtualAnchor.CFrame = hrp.CFrame

    local duration = math.max(dist / speed, 0.03)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local targetCFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0)) * CFrame.Angles(0, math.atan2(
        targetPos.X - hrp.Position.X,
        targetPos.Z - hrp.Position.Z
    ), 0)

    activeTween = TweenService:Create(virtualAnchor, tweenInfo, {CFrame = targetCFrame})

    local completed = false
    currentConnection = RunService.Heartbeat:Connect(function()
        if not completed and not tweenCancelled and hrp and hrp.Parent and virtualAnchor and virtualAnchor.Parent then
            hrp.CFrame = virtualAnchor.CFrame
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
    end)

    activeTween.Completed:Connect(function()
        completed = true
        if currentConnection then
            pcall(function() currentConnection:Disconnect() end)
            currentConnection = nil
        end
        if hrp and hrp.Parent and not tweenCancelled then
            hrp.CFrame = targetCFrame
        end
        activeTween = nil
    end)

    activeTween:Play()
    return true
end

local function isAtPosition(pos, threshold)
    threshold = threshold or 5
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return (hrp.Position - pos).Magnitude <= threshold
end

local carryConfirmations = 0
local CARRY_CONFIRM_THRESHOLD = 1
local lastVerifiedCarry = false

local function checkCarryingEgg()
    local detected = false

    if EggStateModule then
        local ok, carrying = pcall(function()
            if type(EggStateModule.IsCarrying) == "function" then
                return EggStateModule:IsCarrying()
            elseif EggStateModule.CarryData then
                return EggStateModule.CarryData.IsCarrying == true
            end
            return rawCarryState
        end)
        if ok and carrying then detected = true end
    elseif rawCarryState then
        detected = true
    end

    if not detected then
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            for _, tool in ipairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = tool.Name:lower()
                    if (name:find("area egg") or name:find("carryareaegg") or 
                        name == "egg" or name:find("^egg_") or name:find("_egg$")) then
                        detected = true
                        break
                    end
                end
            end
        end
    end

    if not detected then
        local char = LocalPlayer.Character
        if char then
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = tool.Name:lower()
                    if (name:find("area egg") or name:find("carryareaegg") or 
                        name == "egg" or name:find("^egg_") or name:find("_egg$")) then
                        detected = true
                        break
                    end
                end
            end
        end
    end

    if detected then
        carryConfirmations = carryConfirmations + 1
    else
        carryConfirmations = 0
    end

    local verified = carryConfirmations >= CARRY_CONFIRM_THRESHOLD

    if verified ~= lastVerifiedCarry then
        lastVerifiedCarry = verified
    end

    return verified
end

local function resetCarryDetection()
    carryConfirmations = 0
    lastVerifiedCarry = false
end

local function instantFirePrompt(prompt)
    if not prompt or not prompt.Parent then return end
    pcall(function()
        local originalHold = prompt.HoldDuration
        prompt.HoldDuration = 0
        if fireproximityprompt then
            fireproximityprompt(prompt)
        else
            prompt:InputHoldBegin()
            task.wait(0.05)
            prompt:InputHoldEnd()
        end
        prompt.HoldDuration = originalHold
    end)
end

local function isAreaSealed()
    if AreaEggResetWall and AreaEggResetWall.IsSealed ~= nil then
        if type(AreaEggResetWall.IsSealed) == "function" then
            local ok, sealed = pcall(function() return AreaEggResetWall:IsSealed() end)
            if ok then return sealed end
        else
            return AreaEggResetWall.IsSealed
        end
    end
    return false
end

local function findBiggestEgg()
    refreshCarriedEggsCache()
    local biggestUid, biggestSize = nil, -1
    for uid, data in pairs(trackedEggs) do
        if data.model and data.model.Parent then
            if carriedEggsCache[uid] then continue end
            local size = getModelSizeScore(data.model)
            if size > biggestSize then
                biggestSize = size
                biggestUid = uid
            end
        end
    end
    return biggestUid, biggestSize
end

local function findNearestBigEgg()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local playerPos = hrp.Position
    local nearestUid, nearestDist = nil, math.huge

    refreshCarriedEggsCache()

    for uid, data in pairs(trackedEggs) do
        if data.model and data.model.Parent then
            if carriedEggsCache[uid] then continue end
            local bp = data.basePart or getModelBasePart(data.model)
            if bp then
                local dist = (playerPos - bp.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearestUid = uid
                end
            end
        end
    end
    return nearestUid, nearestDist
end

local isPlayerRagdolled

local function runBigOnlyAutoSteal()
    local bigTargetUid = nil
    local bigTargetScore = nil
    local bigCollectionAttempts = 0
    local bigMaxCollectionAttempts = 20
    local bigLastPromptFire = 0
    local bigPromptFireInterval = 0.08
    local bigRushMode = false
    local bigCurrentState = StealState.IDLE

    while bigOnlyAutoStealEnabled do
        local waitTime = 0.03

        syncEggs()

        local carrying = checkCarryingEgg()
        local ragdolled = isPlayerRagdolled()

        if isAreaSealed() then
            if bigCurrentState ~= StealState.WAITING_RESET then
                bigCurrentState = StealState.WAITING_RESET
                cancelActiveTween()
            end
            waitTime = 0.3
        elseif bigCurrentState == StealState.WAITING_RESET then
            bigCurrentState = StealState.IDLE
            waitTime = 0.5
        else
            if bigCurrentState == StealState.IDLE then
                local nearestUid = findNearestBigEgg()
                if nearestUid and trackedEggs[nearestUid] then
                    local data = trackedEggs[nearestUid]
                    local bp = data.basePart or getModelBasePart(data.model)
                    data.basePart = bp
                    if bp then
                        bigTargetUid = nearestUid
                        bigTargetScore = nil
                        bigCollectionAttempts = 0
                        bigCurrentState = StealState.MOVING_TO_EGG
                        tweenCharacterTo(bp.Position, 240)
                    end
                else
                    waitTime = 0.2
                end

            elseif bigCurrentState == StealState.MOVING_TO_EGG then
                if carrying then
                    bigCurrentState = StealState.WAITING
                    cancelActiveTween()
                    bigRushMode = false
                elseif not bigTargetUid or not trackedEggs[bigTargetUid] then
                    bigCurrentState = StealState.IDLE
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                elseif carriedEggsCache[bigTargetUid] then
                    bigCurrentState = StealState.IDLE
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                    waitTime = 0.1
                else
                    local data = trackedEggs[bigTargetUid]
                    local bp = data.basePart
                    if bp and bp.Parent and isAtPosition(bp.Position, 8) then
                        cancelActiveTween()
                        bigCollectionAttempts = 0
                        bigCurrentState = StealState.COLLECTING
                    end
                end

            elseif bigCurrentState == StealState.COLLECTING then
                if carrying then
                    bigCollectionAttempts = 0
                    bigCurrentState = StealState.WAITING
                    cancelActiveTween()
                    bigRushMode = false
                elseif not bigTargetUid or not trackedEggs[bigTargetUid] then
                    bigCurrentState = StealState.IDLE
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                else
                    local data = trackedEggs[bigTargetUid]
                    local model = data.model
                    local prompt = nil
                    local promptPos = nil

                    if model and model.Parent then
                        prompt = getModelPrompt(model)
                    end
                    if not prompt then
                        local bp = data.basePart or getModelBasePart(model)
                        if bp then
                            prompt = findPromptNearPosition(bp.Position, 30)
                            if prompt and prompt.Parent then
                                promptPos = prompt.Parent.Position
                            end
                        end
                    elseif prompt and prompt.Parent then
                        promptPos = prompt.Parent.Position
                    end

                    if prompt then
                        bigCollectionAttempts = bigCollectionAttempts + 1
                        if bigCollectionAttempts <= bigMaxCollectionAttempts then
                            local char = LocalPlayer.Character
                            local hrp = char and char:FindFirstChild("HumanoidRootPart")
                            local canFire = true
                            if hrp and promptPos then
                                local dist = (hrp.Position - promptPos).Magnitude
                                canFire = dist <= (prompt.MaxActivationDistance + 5)
                            end

                            if canFire then
                                local now = tick()
                                if now - bigLastPromptFire >= bigPromptFireInterval then
                                    instantFirePrompt(prompt)
                                    bigLastPromptFire = now
                                end
                            end
                            waitTime = 0.08
                        else
                            bigCurrentState = StealState.IDLE
                            cancelActiveTween()
                            bigTargetUid = nil
                            bigTargetScore = nil
                            bigCollectionAttempts = 0
                        end
                    else
                        bigCurrentState = StealState.IDLE
                        cancelActiveTween()
                        bigTargetUid = nil
                        bigTargetScore = nil
                        bigCollectionAttempts = 0
                    end
                end

            elseif bigCurrentState == StealState.WAITING then
                if ragdolled or not carrying then
                    bigRushMode = true
                    bigCurrentState = StealState.RAGDOLLED_RUSH
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                end

            elseif bigCurrentState == StealState.RAGDOLLED_RUSH then
                if bigRushMode and carrying then
                    bigRushMode = false
                    bigCurrentState = StealState.RETURNING
                    tweenCharacterTo(getReturnPosition(), 1000)
                elseif bigRushMode then
                    refreshCarriedEggsCache()
                    local bestUid = findBiggestEgg()
                    if bestUid and trackedEggs[bestUid] then
                        if bestUid ~= bigTargetUid then
                            bigTargetUid = bestUid
                            bigCollectionAttempts = 0
                            local data = trackedEggs[bestUid]
                            local bp = data.basePart or getModelBasePart(data.model)
                            data.basePart = bp
                            if bp then
                                tweenCharacterTo(bp.Position, 5000)
                            end
                        else
                            local data = trackedEggs[bigTargetUid]
                            local bp = data.basePart or getModelBasePart(data.model)
                            data.basePart = bp
                            if bp and bp.Parent and isAtPosition(bp.Position, 8) then
                                cancelActiveTween()
                                bigCollectionAttempts = 0
                                bigCurrentState = StealState.COLLECTING_BEST
                            elseif not data.model or not data.model.Parent then
                                bigTargetUid = nil
                                bigCollectionAttempts = 0
                            end
                        end
                    else
                        waitTime = 0.05
                    end
                elseif not ragdolled and carrying then
                    bigCurrentState = StealState.RETURNING
                    tweenCharacterTo(getReturnPosition(), 1000)
                elseif not ragdolled then
                    bigCurrentState = StealState.MOVING_TO_BEST
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                elseif carrying then
                    bigCurrentState = StealState.RETURNING
                    tweenCharacterTo(getReturnPosition(), 1000)
                else
                    refreshCarriedEggsCache()
                    local bestUid = findBiggestEgg()
                    if bestUid and trackedEggs[bestUid] then
                        if bestUid ~= bigTargetUid then
                            bigTargetUid = bestUid
                            bigCollectionAttempts = 0
                            local data = trackedEggs[bestUid]
                            local bp = data.basePart or getModelBasePart(data.model)
                            data.basePart = bp
                            if bp then
                                tweenCharacterTo(bp.Position, 5000)
                            end
                        else
                            local data = trackedEggs[bigTargetUid]
                            local bp = data.basePart or getModelBasePart(data.model)
                            data.basePart = bp
                            if bp and bp.Parent and isAtPosition(bp.Position, 8) then
                                cancelActiveTween()
                                bigCollectionAttempts = 0
                                bigCurrentState = StealState.COLLECTING_BEST
                            elseif not data.model or not data.model.Parent then
                                bigTargetUid = nil
                                bigCollectionAttempts = 0
                            end
                        end
                    else
                        waitTime = 0.05
                    end
                end

            elseif bigCurrentState == StealState.MOVING_TO_BEST then
                if ragdolled then
                    bigRushMode = false
                    bigCurrentState = StealState.RAGDOLLED_RUSH
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                elseif carrying then
                    bigRushMode = false
                    bigCurrentState = StealState.RETURNING
                    tweenCharacterTo(getReturnPosition(), 1000)
                elseif not bigTargetUid or not trackedEggs[bigTargetUid] then
                    local bestUid = findBiggestEgg()
                    if bestUid and trackedEggs[bestUid] then
                        bigTargetUid = bestUid
                        local data = trackedEggs[bestUid]
                        local bp = data.basePart or getModelBasePart(data.model)
                        data.basePart = bp
                        if bp then
                            tweenCharacterTo(bp.Position, 240)
                        end
                    else
                        bigCurrentState = StealState.IDLE
                        cancelActiveTween()
                        bigTargetUid = nil
                        bigTargetScore = nil
                        bigCollectionAttempts = 0
                    end
                elseif carriedEggsCache[bigTargetUid] then
                    bigCurrentState = StealState.IDLE
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                else
                    local data = trackedEggs[bigTargetUid]
                    local bp = data.basePart
                    if bp and bp.Parent and isAtPosition(bp.Position, 8) then
                        cancelActiveTween()
                        bigCollectionAttempts = 0
                        bigCurrentState = StealState.COLLECTING_BEST
                    end
                end

            elseif bigCurrentState == StealState.COLLECTING_BEST then
                if ragdolled then
                    bigCurrentState = StealState.RAGDOLLED_RUSH
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                elseif carrying then
                    bigCollectionAttempts = 0
                    bigRushMode = false
                    bigCurrentState = StealState.RETURNING
                    tweenCharacterTo(getReturnPosition(), 1000)
                elseif not bigTargetUid or not trackedEggs[bigTargetUid] then
                    bigCurrentState = StealState.IDLE
                    cancelActiveTween()
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                else
                    local data = trackedEggs[bigTargetUid]
                    local model = data.model
                    local prompt = nil
                    local promptPos = nil

                    if model and model.Parent then
                        prompt = getModelPrompt(model)
                    end
                    if not prompt then
                        local bp = data.basePart or getModelBasePart(model)
                        if bp then
                            prompt = findPromptNearPosition(bp.Position, 30)
                            if prompt and prompt.Parent then
                                promptPos = prompt.Parent.Position
                            end
                        end
                    elseif prompt and prompt.Parent then
                        promptPos = prompt.Parent.Position
                    end

                    if prompt then
                        bigCollectionAttempts = bigCollectionAttempts + 1
                        if bigCollectionAttempts <= bigMaxCollectionAttempts then
                            local char = LocalPlayer.Character
                            local hrp = char and char:FindFirstChild("HumanoidRootPart")
                            local canFire = true
                            if hrp and promptPos then
                                local dist = (hrp.Position - promptPos).Magnitude
                                canFire = dist <= (prompt.MaxActivationDistance + 5)
                            end

                            if canFire then
                                local now = tick()
                                if now - bigLastPromptFire >= bigPromptFireInterval then
                                    instantFirePrompt(prompt)
                                    bigLastPromptFire = now
                                end
                            end
                            waitTime = 0.08
                        else
                            bigCurrentState = StealState.IDLE
                            cancelActiveTween()
                            bigTargetUid = nil
                            bigTargetScore = nil
                            bigCollectionAttempts = 0
                        end
                    else
                        bigCurrentState = StealState.IDLE
                        cancelActiveTween()
                        bigTargetUid = nil
                        bigTargetScore = nil
                        bigCollectionAttempts = 0
                    end
                end

            elseif bigCurrentState == StealState.RETURNING then
                if not carrying then
                    cancelActiveTween()
                    bigCurrentState = StealState.IDLE
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                    resetCarryDetection()
                    bigRushMode = false
                elseif isAtPosition(getReturnPosition(), 12) then
                    cancelActiveTween()
                    bigCurrentState = StealState.DEPOSITING
                end

            elseif bigCurrentState == StealState.DEPOSITING then
                if not carrying then
                    bigCurrentState = StealState.IDLE
                    bigTargetUid = nil
                    bigTargetScore = nil
                    bigCollectionAttempts = 0
                    resetCarryDetection()
                    bigRushMode = false
                end
            end
        end

        task.wait(waitTime)
    end

    bigOnlyLoopRunning = false
    cancelActiveTween()
    bigCurrentState = StealState.IDLE
    bigTargetUid = nil
    bigTargetScore = nil
    bigCollectionAttempts = 0
    resetCarryDetection()
    bigRushMode = false
end

local EggBigOnlyToggle = EggTab:Toggle({
    Title = "Big Eggs Only",
    Desc = "Steals the biggiest balls in the current eggs.",
    Icon = "maximize",
    Type = "Toggle",
    Value = eggBigOnly,
    Callback = function(value)
        eggBigOnly = value
        Memory.EggBigOnly = value

        if value then
            if autoStealEnabled then
                autoStealEnabled = false
                Memory.EggAutoStealEnabled = false
                autoLoopRunning = false
                pcall(function()
                    if EggStealToggle and EggStealToggle.Set then
                        EggStealToggle:Set(false)
                    elseif EggStealToggle and EggStealToggle.SetValue then
                        EggStealToggle:SetValue(false)
                    end
                end)
                cancelActiveTween()
                currentStealState = StealState.IDLE
                targetEggUid = nil
                targetEggScore = nil
                collectionAttempts = 0
                resetCarryDetection()
            end
            bigOnlyAutoStealEnabled = true
            if not bigOnlyLoopRunning then
                bigOnlyLoopRunning = true
                task.spawn(runBigOnlyAutoSteal)
            end
        else
            bigOnlyAutoStealEnabled = false
            cancelActiveTween()
            resetCarryDetection()
            bigCurrentState = StealState.IDLE
            bigTargetUid = nil
            bigTargetScore = nil
            bigCollectionAttempts = 0
            bigRushMode = false
        end

        syncEggs()
    end,
})

isPlayerRagdolled = function()
    local char = LocalPlayer.Character
    if not char then return true end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return true end

    if hum.PlatformStand then return true end

    local state = hum:GetState()
    if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.FallingDown then
        return true
    end

    if char:GetAttribute("Ragdolled") == true then return true end
    if hum:GetAttribute("Ragdolled") == true then return true end
    if char:GetAttribute("Ragdoll") == true then return true end
    if hum:GetAttribute("Ragdoll") == true then return true end

    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BallSocketConstraint") then
            return true
        end
    end

    local hasMotor6D = false
    local hasConstraint = false
    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("Motor6D") then
            hasMotor6D = true
        elseif v:IsA("Constraint") then
            hasConstraint = true
        end
    end
    if hasConstraint and not hasMotor6D then
        return true
    end

    return false
end

local function findNearestEgg()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local playerPos = hrp.Position
    local nearestUid, nearestDist = nil, math.huge

    refreshCarriedEggsCache()

    for uid, data in pairs(trackedEggs) do
        if data.model and data.model.Parent then
            if carriedEggsCache[uid] then continue end
            local bp = data.basePart or getModelBasePart(data.model)
            if bp then
                local dist = (playerPos - bp.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearestUid = uid
                end
            end
        end
    end
    return nearestUid, nearestDist
end

local EggStealToggle = EggTab:Toggle({
    Title = "Auto Steal Best",
    Desc = "Steals best egg currently on the game",
    Icon = "mouse-pointer-click",
    Type = "Toggle",
    Value = autoStealEnabled,
    Callback = function(value)
        autoStealEnabled = value
        Memory.EggAutoStealEnabled = value

        if value then
            if bigOnlyAutoStealEnabled then
                bigOnlyAutoStealEnabled = false
                Memory.EggBigOnly = false
                eggBigOnly = false
                bigOnlyLoopRunning = false
                pcall(function()
                    if EggBigOnlyToggle and EggBigOnlyToggle.Set then
                        EggBigOnlyToggle:Set(false)
                    elseif EggBigOnlyToggle and EggBigOnlyToggle.SetValue then
                        EggBigOnlyToggle:SetValue(false)
                    end
                end)
                cancelActiveTween()
                resetCarryDetection()
            end
        end

        if not autoStealEnabled then
            cancelActiveTween()
            currentStealState = StealState.IDLE
            targetEggUid = nil
            targetEggScore = nil
            collectionAttempts = 0
            resetCarryDetection()
            return
        end

        if autoLoopRunning then return end
        autoLoopRunning = true

        local targetEggScore = nil
        local collectionAttempts = 0
        local maxCollectionAttempts = 20
        local lastPromptFire = 0
        local promptFireInterval = 0.08
        local wasRagdolled = false
        local rushMode = false

        task.spawn(function()
            while autoStealEnabled do
                local waitTime = 0.03

                syncEggs()

                local carrying = checkCarryingEgg()
                local ragdolled = isPlayerRagdolled()

                if isAreaSealed() then
                    if currentStealState ~= StealState.WAITING_RESET then
                        currentStealState = StealState.WAITING_RESET
                        cancelActiveTween()
                    end
                    waitTime = 0.3
                elseif currentStealState == StealState.WAITING_RESET then
                    currentStealState = StealState.IDLE
                    waitTime = 0.5
                else
                    if currentStealState == StealState.IDLE then
                        local nearestUid = findNearestEgg()
                        if nearestUid and trackedEggs[nearestUid] then
                            local data = trackedEggs[nearestUid]
                            local bp = data.basePart or getModelBasePart(data.model)
                            data.basePart = bp
                            if bp then
                                targetEggUid = nearestUid
                                targetEggScore = nil
                                collectionAttempts = 0
                                currentStealState = StealState.MOVING_TO_EGG
                                tweenCharacterTo(bp.Position, 240)
                            end
                        else
                            waitTime = 0.2
                        end

                    elseif currentStealState == StealState.MOVING_TO_EGG then
                        if carrying then
                            currentStealState = StealState.WAITING
                            cancelActiveTween()
                            wasRagdolled = false
                        elseif not targetEggUid or not trackedEggs[targetEggUid] then
                            currentStealState = StealState.IDLE
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                        elseif carriedEggsCache[targetEggUid] then
                            currentStealState = StealState.IDLE
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                            waitTime = 0.1
                        else
                            local data = trackedEggs[targetEggUid]
                            local bp = data.basePart
                            if bp and bp.Parent and isAtPosition(bp.Position, 8) then
                                cancelActiveTween()
                                collectionAttempts = 0
                                currentStealState = StealState.COLLECTING
                            end
                        end

                    elseif currentStealState == StealState.COLLECTING then
                        if carrying then
                            collectionAttempts = 0
                            currentStealState = StealState.WAITING
                            cancelActiveTween()
                            wasRagdolled = false
                        elseif not targetEggUid or not trackedEggs[targetEggUid] then
                            currentStealState = StealState.IDLE
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                        else
                            local data = trackedEggs[targetEggUid]
                            local model = data.model
                            local prompt = nil
                            local promptPos = nil

                            if model and model.Parent then
                                prompt = getModelPrompt(model)
                            end
                            if not prompt then
                                local bp = data.basePart or getModelBasePart(model)
                                if bp then
                                    prompt = findPromptNearPosition(bp.Position, 30)
                                    if prompt and prompt.Parent then
                                        promptPos = prompt.Parent.Position
                                    end
                                end
                            elseif prompt and prompt.Parent then
                                promptPos = prompt.Parent.Position
                            end

                            if prompt then
                                collectionAttempts = collectionAttempts + 1
                                if collectionAttempts <= maxCollectionAttempts then
                                    local char = LocalPlayer.Character
                                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                                    local canFire = true
                                    if hrp and promptPos then
                                        local dist = (hrp.Position - promptPos).Magnitude
                                        canFire = dist <= (prompt.MaxActivationDistance + 5)
                                    end

                                    if canFire then
                                        local now = tick()
                                        if now - lastPromptFire >= promptFireInterval then
                                            instantFirePrompt(prompt)
                                            lastPromptFire = now
                                        end
                                    end
                                    waitTime = 0.08
                                else
                                    currentStealState = StealState.IDLE
                                    cancelActiveTween()
                                    targetEggUid = nil
                                    targetEggScore = nil
                                    collectionAttempts = 0
                                end
                            else
                                currentStealState = StealState.IDLE
                                cancelActiveTween()
                                targetEggUid = nil
                                targetEggScore = nil
                                collectionAttempts = 0
                            end
                        end

                    elseif currentStealState == StealState.WAITING then
                        if ragdolled or not carrying then
                            wasRagdolled = true
                            rushMode = true
                            currentStealState = StealState.RAGDOLLED_RUSH
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                        end

                    elseif currentStealState == StealState.RAGDOLLED_RUSH then
                        if rushMode and carrying then
                            rushMode = false
                            currentStealState = StealState.RETURNING
                            tweenCharacterTo(getReturnPosition(), 1000)
                        elseif rushMode then
                            refreshCarriedEggsCache()
                            local bestUid = findBestEgg()
                            if bestUid and trackedEggs[bestUid] then
                                if bestUid ~= targetEggUid then
                                    targetEggUid = bestUid
                                    collectionAttempts = 0
                                    local data = trackedEggs[bestUid]
                                    local bp = data.basePart or getModelBasePart(data.model)
                                    data.basePart = bp
                                    if bp then
                                        tweenCharacterTo(bp.Position, 5000)
                                    end
                                else
                                    local data = trackedEggs[targetEggUid]
                                    local bp = data.basePart or getModelBasePart(data.model)
                                    data.basePart = bp
                                    if bp and bp.Parent and isAtPosition(bp.Position, 8) then
                                        cancelActiveTween()
                                        collectionAttempts = 0
                                        currentStealState = StealState.COLLECTING_BEST
                                    elseif not data.model or not data.model.Parent then
                                        targetEggUid = nil
                                        collectionAttempts = 0
                                    end
                                end
                            else
                                waitTime = 0.05
                            end
                        elseif not ragdolled and carrying then
                            currentStealState = StealState.RETURNING
                            tweenCharacterTo(getReturnPosition(), 1000)
                        elseif not ragdolled then
                            currentStealState = StealState.MOVING_TO_BEST
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                        elseif carrying then
                            currentStealState = StealState.RETURNING
                            tweenCharacterTo(getReturnPosition(), 1000)
                        else
                            refreshCarriedEggsCache()
                            local bestUid = findBestEgg()
                            if bestUid and trackedEggs[bestUid] then
                                if bestUid ~= targetEggUid then
                                    targetEggUid = bestUid
                                    collectionAttempts = 0
                                    local data = trackedEggs[bestUid]
                                    local bp = data.basePart or getModelBasePart(data.model)
                                    data.basePart = bp
                                    if bp then
                                        tweenCharacterTo(bp.Position, 5000)
                                    end
                                else
                                    local data = trackedEggs[targetEggUid]
                                    local bp = data.basePart or getModelBasePart(data.model)
                                    data.basePart = bp
                                    if bp and bp.Parent and isAtPosition(bp.Position, 8) then
                                        cancelActiveTween()
                                        collectionAttempts = 0
                                        currentStealState = StealState.COLLECTING_BEST
                                    elseif not data.model or not data.model.Parent then
                                        targetEggUid = nil
                                        collectionAttempts = 0
                                    end
                                end
                            else
                                waitTime = 0.05
                            end
                        end

                    elseif currentStealState == StealState.MOVING_TO_BEST then
                        if ragdolled then
                            rushMode = false
                            currentStealState = StealState.RAGDOLLED_RUSH
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                        elseif carrying then
                            rushMode = false
                            currentStealState = StealState.RETURNING
                            tweenCharacterTo(getReturnPosition(), 1000)
                        elseif not targetEggUid or not trackedEggs[targetEggUid] then
                            local bestUid = findBestEgg()
                            if bestUid and trackedEggs[bestUid] then
                                targetEggUid = bestUid
                                local data = trackedEggs[bestUid]
                                local bp = data.basePart or getModelBasePart(data.model)
                                data.basePart = bp
                                if bp then
                                    tweenCharacterTo(bp.Position, 240)
                                end
                            else
                                currentStealState = StealState.IDLE
                                cancelActiveTween()
                                targetEggUid = nil
                                targetEggScore = nil
                                collectionAttempts = 0
                            end
                        elseif carriedEggsCache[targetEggUid] then
                            currentStealState = StealState.IDLE
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                        else
                            local data = trackedEggs[targetEggUid]
                            local bp = data.basePart
                            if bp and bp.Parent and isAtPosition(bp.Position, 8) then
                                cancelActiveTween()
                                collectionAttempts = 0
                                currentStealState = StealState.COLLECTING_BEST
                            end
                        end

                    elseif currentStealState == StealState.COLLECTING_BEST then
                        if ragdolled then
                            currentStealState = StealState.RAGDOLLED_RUSH
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                        elseif carrying then
                            collectionAttempts = 0
                            rushMode = false
                            currentStealState = StealState.RETURNING
                            tweenCharacterTo(getReturnPosition(), 1000)
                        elseif not targetEggUid or not trackedEggs[targetEggUid] then
                            currentStealState = StealState.IDLE
                            cancelActiveTween()
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                        else
                            local data = trackedEggs[targetEggUid]
                            local model = data.model
                            local prompt = nil
                            local promptPos = nil

                            if model and model.Parent then
                                prompt = getModelPrompt(model)
                            end
                            if not prompt then
                                local bp = data.basePart or getModelBasePart(model)
                                if bp then
                                    prompt = findPromptNearPosition(bp.Position, 30)
                                    if prompt and prompt.Parent then
                                        promptPos = prompt.Parent.Position
                                    end
                                end
                            elseif prompt and prompt.Parent then
                                promptPos = prompt.Parent.Position
                            end

                            if prompt then
                                collectionAttempts = collectionAttempts + 1
                                if collectionAttempts <= maxCollectionAttempts then
                                    local char = LocalPlayer.Character
                                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                                    local canFire = true
                                    if hrp and promptPos then
                                        local dist = (hrp.Position - promptPos).Magnitude
                                        canFire = dist <= (prompt.MaxActivationDistance + 5)
                                    end

                                    if canFire then
                                        local now = tick()
                                        if now - lastPromptFire >= promptFireInterval then
                                            instantFirePrompt(prompt)
                                            lastPromptFire = now
                                        end
                                    end
                                    waitTime = 0.08
                                else
                                    currentStealState = StealState.IDLE
                                    cancelActiveTween()
                                    targetEggUid = nil
                                    targetEggScore = nil
                                    collectionAttempts = 0
                                end
                            else
                                currentStealState = StealState.IDLE
                                cancelActiveTween()
                                targetEggUid = nil
                                targetEggScore = nil
                                collectionAttempts = 0
                            end
                        end

                    elseif currentStealState == StealState.RETURNING then
                        if not carrying then
                            cancelActiveTween()
                            currentStealState = StealState.IDLE
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                            resetCarryDetection()
                            wasRagdolled = false
                            rushMode = false
                        elseif isAtPosition(getReturnPosition(), 12) then
                            cancelActiveTween()
                            currentStealState = StealState.DEPOSITING
                        end

                    elseif currentStealState == StealState.DEPOSITING then
                        if not carrying then
                            currentStealState = StealState.IDLE
                            targetEggUid = nil
                            targetEggScore = nil
                            collectionAttempts = 0
                            resetCarryDetection()
                            wasRagdolled = false
                            rushMode = false
                        end
                    end
                end

                task.wait(waitTime)
            end

            autoLoopRunning = false
            cancelActiveTween()
            currentStealState = StealState.IDLE
            targetEggUid = nil
            targetEggScore = nil
            collectionAttempts = 0
            resetCarryDetection()
            wasRagdolled = false
            rushMode = false
        end)
    end,
})

if espEnabled then updateBeam() end

LocalPlayer.CharacterAdded:Connect(function()
    if espEnabled then
        task.wait(0.5)
        pcall(function()
            if espBeam then espBeam.Attachment0 = nil end
            if espPlayerAttach then espPlayerAttach:Destroy(); espPlayerAttach = nil end
        end)
    end
    if autoStealEnabled then
        cancelActiveTween()
        currentStealState = StealState.IDLE
        targetEggUid = nil
        targetEggScore = nil
        collectionAttempts = 0
        isCarryingEgg = false
        rushMode = false
    end
    if bigOnlyAutoStealEnabled then
        cancelActiveTween()
        bigCurrentState = StealState.IDLE
        bigTargetUid = nil
        bigTargetScore = nil
        bigCollectionAttempts = 0
        bigRushMode = false
    end
end)

local CRZAutomation = {
    Remotes = nil,
    Save = nil,
    EggState = nil,
    Assets = nil,
    Trails = nil,
    PlotState = nil,
    Treadmills = nil,
    initialized = false,
    loops = {},
    autoPlaceAll = false,
    autoHatch = false,
    autoClaim = false,
    autoBaseUpgrade = false,
    autoTreadmillUpgrade = false,
    autoBuyTrail = false,
    autoAbyss = false,
}

local function CRZAutoRequire(parent, childName)
    local child = parent and parent:FindFirstChild(childName)
    if not child or not child:IsA("ModuleScript") then return nil end
    local ok, result = pcall(require, child)
    return ok and result or nil
end

local function CRZInitAutomation()
    local shared = ReplicatedStorage:FindFirstChild("Shared")
    local client = ReplicatedStorage:FindFirstChild("Client")
    local data = ReplicatedStorage:FindFirstChild("Data")
    if not shared or not client or not data then
        return false
    end

    CRZAutomation.Remotes = CRZAutoRequire(shared, "Remotes")
    CRZAutomation.Save = CRZAutoRequire(shared, "Save")
    CRZAutomation.EggState = CRZAutoRequire(client, "EggState")
    CRZAutomation.Assets = CRZAutoRequire(data, "Assets")
    CRZAutomation.Trails = CRZAutoRequire(data, "Trails")
    CRZAutomation.PlotState = CRZAutoRequire(client, "PlotState")
    CRZAutomation.Treadmills = CRZAutoRequire(data, "Treadmills")
    CRZAutomation.initialized =
        CRZAutomation.Remotes ~= nil and
        CRZAutomation.Save ~= nil and
        CRZAutomation.EggState ~= nil
    return CRZAutomation.initialized
end

local function CRZEnsureAutomation()
    if CRZAutomation.initialized then return true end
    return CRZInitAutomation()
end

local function CRZInvokeAutomation(remote, ...)
    if not remote then return false, nil end
    local args = table.pack(...)
    local ok, a, b, c = pcall(function()
        return remote:InvokeServer(table.unpack(args, 1, args.n))
    end)
    return ok, a, b, c
end

local function CRZFireAutomation(remote, ...)
    if not remote then return false end
    local args = table.pack(...)
    local ok = pcall(function()
        remote:FireServer(table.unpack(args, 1, args.n))
    end)
    return ok
end

local function CRZAutomationSave()
    if not CRZEnsureAutomation() or not CRZAutomation.Save then return nil end
    local ok, save = pcall(CRZAutomation.Save.Get, player)
    return ok and save or nil
end

local function CRZAutomationNotify(title, content, icon)
    pcall(function()
        WindUI:Notify({
            Title = title,
            Content = content,
            Icon = icon or "check",
            Duration = 3,
        })
    end)
end

local function CRZResolveAutomationSlot()
    if not CRZEnsureAutomation() then return nil end
    local r = CRZAutomation.Remotes
    if not (r and r.Homestead and r.Homestead.AskState) then return nil end
    local ok, state = CRZInvokeAutomation(r.Homestead.AskState)
    if not ok or type(state) ~= "table" or type(state.OwnersBySlot) ~= "table" then
        return nil
    end
    for slot, userId in pairs(state.OwnersBySlot) do
        if tostring(userId) == tostring(player.UserId) then
            return tostring(slot)
        end
    end
    return nil
end

local function CRZGetAutomationPlacementFrames()
    if not CRZEnsureAutomation() or not CRZAutomation.PlotState then return {} end
    local ok, plot = pcall(CRZAutomation.PlotState.ResolvePlot)
    if not ok or type(plot) ~= "table" or not plot.PetArea or not plot.CenterPoint then
        return {}
    end
    local petArea, center = plot.PetArea, plot.CenterPoint
    if not petArea.Size or not center.CFrame then return {} end
    local frames = {}
    for x = -petArea.Size.X * 0.5 + 5, petArea.Size.X * 0.5 - 5, 7 do
        for z = -petArea.Size.Z * 0.5 + 5, petArea.Size.Z * 0.5 - 5, 7 do
            local world = petArea.CFrame:PointToWorldSpace(Vector3.new(x, 1, z))
            table.insert(frames, center.CFrame:ToObjectSpace(CFrame.new(world)))
        end
    end
    return frames
end

local function CRZGetAutomationEggs()
    local save = CRZAutomationSave()
    local inventory = save and save.EggInventory
    local result = {}
    if type(inventory) ~= "table" then return result end
    for uid, egg in pairs(inventory) do
        if type(uid) == "string" and type(egg) == "table" and egg.Placement == nil then
            table.insert(result, uid)
        end
    end
    return result
end

local automationPlaceIndex = 1
local function CRZRunAutomationPlaceAll()
    if not CRZEnsureAutomation() or not CRZAutomation.EggState then return 0 end
    local eggs = CRZGetAutomationEggs()
    local frames = CRZGetAutomationPlacementFrames()
    if #eggs == 0 or #frames == 0 then return 0 end

    local placed = 0
    for _, uid in ipairs(eggs) do
        pcall(function()
            if CRZAutomation.EggState.WearEggTool then
                CRZAutomation.EggState.WearEggTool(uid)
            end
        end)
        task.wait(0.12)

        local didPlace = false
        for offset = 0, #frames - 1 do
            local index = ((automationPlaceIndex + offset - 1) % #frames) + 1
            local ok, result = pcall(function()
                return CRZAutomation.EggState.PlantEgg(uid, frames[index])
            end)
            if ok and result == true then
                automationPlaceIndex = index + 1
                didPlace = true
                placed = placed + 1
                task.wait(0.2)
                break
            end
        end

        if not didPlace then
            break
        end
    end
    return placed
end

local function CRZRunAutomationHatch()
    if not CRZEnsureAutomation() or not CRZAutomation.EggState then return 0 end
    local save = CRZAutomationSave()
    if not save then return 0 end

    local done = 0
    for uid, egg in pairs(save.EggInventory or {}) do
        if type(uid) == "string" and type(egg) == "table" then
            local ready = true
            if egg.Placement == nil and CRZAutomation.EggState.PlantEgg then
                local slot = CRZResolveAutomationSlot()
                local plots = Workspace:FindFirstChild("Plots")
                local center = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local pos = center and center.Position or Vector3.zero
                if plots and slot and plots:FindFirstChild(slot) then
                    local plot = plots[slot]
                    local point = plot:FindFirstChild("CenterPoint") or plot:FindFirstChild("PlotSign")
                    if point and point:IsA("BasePart") then
                        pos = point.Position
                    end
                end
                pcall(CRZAutomation.EggState.PlantEgg, uid, CFrame.new(pos + Vector3.new(math.random(-6, 6), 0, math.random(-6, 6))))
                task.wait(0.15)
            elseif CRZAutomation.EggState.IsReadyToHatch then
                local okReady, resultReady = pcall(CRZAutomation.EggState.IsReadyToHatch, uid)
                ready = okReady and resultReady == true
            end

            if ready and CRZAutomation.EggState.BeginHatch then
                local okHatch, started = pcall(CRZAutomation.EggState.BeginHatch, uid)
                if okHatch and started == true then
                    if CRZAutomation.EggState.FinishHatch then
                        pcall(CRZAutomation.EggState.FinishHatch, uid)
                    end
                    done = done + 1
                    task.wait(0.2)
                end
            end
        end
    end
    return done
end

local function CRZRunAutomationClaim()
    if not CRZEnsureAutomation() then return 0 end
    local r, claimed = CRZAutomation.Remotes, 0

    if r.Codex and r.Codex.AskRedeemAll then
        local ok, result = CRZInvokeAutomation(r.Codex.AskRedeemAll)
        if ok and result == true then claimed = claimed + 1 end
    end
    if r.Codex and r.Codex.AskRedeemLimitedEgg then
        local ok, result = CRZInvokeAutomation(r.Codex.AskRedeemLimitedEgg)
        if ok and result == true then claimed = claimed + 1 end
    end
    if r.GroupPerk and r.GroupPerk.RedeemPerk then
        local ok, result = CRZInvokeAutomation(r.GroupPerk.RedeemPerk)
        if ok and result == true then claimed = claimed + 1 end
    end
    if r.AwayEarnings and r.AwayEarnings.FetchSummary and r.AwayEarnings.AskCollect then
        local okSummary, summary = CRZInvokeAutomation(r.AwayEarnings.FetchSummary)
        if okSummary and type(summary) == "table" and (tonumber(summary.ClaimableAmount) or 0) > 0 then
            local okCollect = CRZInvokeAutomation(r.AwayEarnings.AskCollect)
            if okCollect then claimed = claimed + 1 end
        end
    end
    return claimed
end

local function CRZRunAutomationBaseUpgrade()
    if not CRZEnsureAutomation() then return false end
    local r = CRZAutomation.Remotes
    return r and r.Homestead and r.Homestead.AskBaseTierRaise
        and CRZFireAutomation(r.Homestead.AskBaseTierRaise) or false
end

local function CRZRunAutomationTreadmillUpgrade()
    if not CRZEnsureAutomation() then return false end
    local r, tm = CRZAutomation.Remotes, CRZAutomation.Treadmills
    if not (r and r.Treadmill and r.Treadmill.AskTierRaise and tm and type(tm.GetByUpgradeLevel) == "function") then
        return false
    end
    local save = CRZAutomationSave()
    if not save then return false end

    local level = tonumber(save.TreadmillUpgradeLevel) or 0
    local okCfg, nextCfg = pcall(tm.GetByUpgradeLevel, level + 1)
    if not okCfg or type(nextCfg) ~= "table" or not nextCfg._id then return false end
    if (tonumber(save.Money) or 0) < (tonumber(nextCfg.Price) or math.huge) then return false end

    local ok, result = CRZInvokeAutomation(r.Treadmill.AskTierRaise, nextCfg._id)
    return ok and result == true
end

local CRZ_TRAIL_VALUES_WIND = {}
local CRZ_TRAIL_ID_WIND = {}
local CRZ_TRAIL_PRICE_WIND = {}
local function CRZRefreshAutomationTrails()
    table.clear(CRZ_TRAIL_VALUES_WIND)
    table.clear(CRZ_TRAIL_ID_WIND)
    table.clear(CRZ_TRAIL_PRICE_WIND)
    local trails = CRZAutomation.Trails
    local directory = trails and (trails.Directory or trails.Trails or trails)
    local ordered = {}
    if type(directory) == "table" then
        for id, data in pairs(directory) do
            if type(data) == "table" and type(data.DisplayName) == "string" then
                table.insert(ordered, {
                    id = id,
                    name = data.DisplayName,
                    price = tonumber(data.Price) or 0,
                })
            end
        end
    end
    table.sort(ordered, function(a, b) return a.price < b.price end)
    for _, entry in ipairs(ordered) do
        table.insert(CRZ_TRAIL_VALUES_WIND, entry.name)
        CRZ_TRAIL_ID_WIND[entry.name] = entry.id
        CRZ_TRAIL_PRICE_WIND[entry.name] = entry.price
    end
end

local function CRZRunAutomationBuyTrail(selected)
    if not CRZEnsureAutomation() then return 0 end
    local save = CRZAutomationSave()
    local r = CRZAutomation.Remotes
    local buyRemote = r and r.Trailwear and r.Trailwear.AskPurchase
    if not save or not buyRemote or type(selected) ~= "table" then return 0 end

    local inventory = save.TrailInventory or {}
    local bought = 0
    for _, name in ipairs(CRZ_TRAIL_VALUES_WIND) do
        if selected[name] then
            local id = CRZ_TRAIL_ID_WIND[name]
            local price = CRZ_TRAIL_PRICE_WIND[name] or 0
            if id and not inventory[id] and (tonumber(save.Money) or 0) >= price then
                local ok, result = CRZInvokeAutomation(buyRemote, id)
                if ok and result ~= false then
                    bought = bought + 1
                end
                task.wait(0.3)
                save = CRZAutomationSave() or save
                inventory = save.TrailInventory or inventory
            end
        end
    end
    return bought
end

local function CRZAutomationEnterAbyss()
    local net = ReplicatedStorage:FindFirstChild("Packages")
        and ReplicatedStorage.Packages:FindFirstChild("Networking")
    local remote = net and net:FindFirstChild("RF/BossEvent/AskEnter")
    if not remote then
        return false, "Abyss entry remote not found"
    end

    local ok, accepted, msg = pcall(function()
        return remote:InvokeServer()
    end)
    if not ok then return false, tostring(accepted) end
    if accepted == true then return true, "Entering the Abyss World" end
    return false, tostring(msg or "Boss entry refused")
end

local AutomationTrailSelection = Memory.AutoBuyTrailSelection or {}
local AutomationTrailDropdown = nil

CRZEnsureAutomation()
CRZRefreshAutomationTrails()

AutomationTab:Section({ Title = "Automation", Icon = "bot", Opened = true })

AutomationTab:Toggle({
    Title = "Auto Place All",
    Desc = "Automatically places all unplaced eggs in your plot.",
    Icon = "layers",
    Type = "Toggle",
    Value = Memory.AutoPlaceAll or false,
    Callback = function(value)
        CRZAutomation.autoPlaceAll = value
        Memory.AutoPlaceAll = value
        if value and not CRZAutomation.loops.place then
            CRZAutomation.loops.place = true
            task.spawn(function()
                while CRZAutomation.autoPlaceAll do
                    local count = 0
                    pcall(function() count = CRZRunAutomationPlaceAll() end)
                    task.wait(count > 0 and 0.8 or 1.5)
                end
                CRZAutomation.loops.place = false
            end)
        end
    end,
})

AutomationTab:Toggle({
    Title = "Auto Hatch",
    Desc = "Automatically hatches eggs when possible.",
    Icon = "egg",
    Type = "Toggle",
    Value = Memory.AutoHatch or false,
    Callback = function(value)
        CRZAutomation.autoHatch = value
        Memory.AutoHatch = value
        if value and not CRZAutomation.loops.hatch then
            CRZAutomation.loops.hatch = true
            task.spawn(function()
                while CRZAutomation.autoHatch do
                    pcall(CRZRunAutomationHatch)
                    task.wait(1.2)
                end
                CRZAutomation.loops.hatch = false
            end)
        end
    end,
})

AutomationTab:Divider()

AutomationTab:Button({
    Title = "Enter Abyss World Now",
    Desc = "Enter the Abyss World immediately.",
    Icon = "door-open",
    Callback = function()
        local ok, msg = CRZAutomationEnterAbyss()
        CRZAutomationNotify("Abyss World", msg, ok and "check" or "circle-alert")
    end,
})

AutomationTab:Toggle({
    Title = "Auto Enter Abyss World",
    Desc = "Automatically enters the Abyss World when the event is open.",
    Icon = "rocket",
    Type = "Toggle",
    Value = Memory.AutoEnterAbyss or false,
    Callback = function(value)
        CRZAutomation.autoAbyss = value
        Memory.AutoEnterAbyss = value
        if value and not CRZAutomation.loops.abyss then
            CRZAutomation.loops.abyss = true
            task.spawn(function()
                while CRZAutomation.autoAbyss do
                    pcall(function()
                        if player:GetAttribute("InBossArena") ~= true then
                            local net = ReplicatedStorage:FindFirstChild("Packages")
                                and ReplicatedStorage.Packages:FindFirstChild("Networking")
                            local snapshotRemote = net and net:FindFirstChild("RF/BossEvent/AskSnapshot")
                            local shouldEnter = true
                            if snapshotRemote then
                                local okSnap, snap = pcall(snapshotRemote.InvokeServer, snapshotRemote)
                                if okSnap and type(snap) == "table" and snap.Open ~= nil then
                                    shouldEnter = snap.Open == true
                                end
                            end
                            if shouldEnter then
                                CRZAutomationEnterAbyss()
                            end
                        end
                    end)
                    task.wait(2)
                end
                CRZAutomation.loops.abyss = false
            end)
        end
    end,
})

AutomationTab:Divider()

AutomationTab:Button({
    Title = "Claim Index now",
    Desc = "Claims available rewards now.",
    Icon = "gift",
    Callback = function()
        local count = 0
        pcall(function() count = CRZRunAutomationClaim() end)
        CRZAutomationNotify("Claim Rewards", count > 0 and ("Claimed " .. count .. " reward(s).") or "No claimable rewards.", count > 0 and "check" or "info")
    end,
})

AutomationTab:Toggle({
    Title = "Auto Index",
    Desc = "Automatically claims available Index.",
    Icon = "badge-check",
    Type = "Toggle",
    Value = Memory.AutoClaim or false,
    Callback = function(value)
        CRZAutomation.autoClaim = value
        Memory.AutoClaim = value
        if value and not CRZAutomation.loops.claim then
            CRZAutomation.loops.claim = true
            task.spawn(function()
                while CRZAutomation.autoClaim do
                    pcall(CRZRunAutomationClaim)
                    task.wait(30)
                end
                CRZAutomation.loops.claim = false
            end)
        end
    end,
})

AutomationTab:Divider()

AutomationTab:Toggle({
    Title = "Auto Upgrade Base",
    Desc = "Automatically upgrades your base when affordable.",
    Icon = "castle",
    Type = "Toggle",
    Value = Memory.AutoUpgradeBase or false,
    Callback = function(value)
        CRZAutomation.autoBaseUpgrade = value
        Memory.AutoUpgradeBase = value
        if value and not CRZAutomation.loops.base then
            CRZAutomation.loops.base = true
            task.spawn(function()
                while CRZAutomation.autoBaseUpgrade do
                    pcall(CRZRunAutomationBaseUpgrade)
                    task.wait(15)
                end
                CRZAutomation.loops.base = false
            end)
        end
    end,
})

AutomationTab:Toggle({
    Title = "Auto Upgrade Treadmill",
    Desc = "Automatically upgrades the treadmill when affordable.",
    Icon = "gauge",
    Type = "Toggle",
    Value = Memory.AutoUpgradeTreadmill or false,
    Callback = function(value)
        CRZAutomation.autoTreadmillUpgrade = value
        Memory.AutoUpgradeTreadmill = value
        if value and not CRZAutomation.loops.treadmill then
            CRZAutomation.loops.treadmill = true
            task.spawn(function()
                while CRZAutomation.autoTreadmillUpgrade do
                    pcall(CRZRunAutomationTreadmillUpgrade)
                    task.wait(15)
                end
                CRZAutomation.loops.treadmill = false
            end)
        end
    end,
})

AutomationTab:Divider()

AutomationTrailDropdown = AutomationTab:Dropdown({
    Title = "Trail Selection",
    Desc = "Choose trails for Auto Buy Trail.",
    Icon = "footprints",
    Values = CRZ_TRAIL_VALUES_WIND,
    Multi = true,
    Value = {},
    AllowNull = true,
    Callback = function(value)
        AutomationTrailSelection = value
        Memory.AutoBuyTrailSelection = value
    end,
})

AutomationTab:Toggle({
    Title = "Auto Buy Trail",
    Desc = "Automatically buys selected trails you can afford.",
    Icon = "shopping-cart",
    Type = "Toggle",
    Value = Memory.AutoBuyTrail or false,
    Callback = function(value)
        CRZAutomation.autoBuyTrail = value
        Memory.AutoBuyTrail = value
        if value and not CRZAutomation.loops.trail then
            CRZAutomation.loops.trail = true
            task.spawn(function()
                while CRZAutomation.autoBuyTrail do
                    pcall(function()
                        CRZRunAutomationBuyTrail(AutomationTrailSelection)
                    end)
                    task.wait(6)
                end
                CRZAutomation.loops.trail = false
            end)
        end
    end,
})

AutomationTab:Divider()

task.spawn(function()
    task.wait(1)
    pcall(CRZEnsureAutomation)
    pcall(CRZRefreshAutomationTrails)
end)

MainTab:Section({ Title = "Movement", Icon = "move", Opened = true })

local SpeedInput = MainTab:Input({
    Title = "Walk Speed",
    Desc = "Set your desired movement speed.",
    InputIcon = "gauge",
    Value = tostring(DesiredSpeed),
    Placeholder = "16",
    Callback = function(value)
        local num = tonumber(value)
        if num then
            DesiredSpeed = num
            Memory.DesiredSpeed = num
            if SpeedEnabled and CurrentHumanoid then
                pcall(function() CurrentHumanoid.WalkSpeed = DesiredSpeed end)
            end
        end
    end,
})

local SpeedBypassDropdown = MainTab:Dropdown({
    Title = "Speed Bypass Method",
    Desc = "Choose which bypass method to use for speed.",
    Icon = "settings-2",
    Values = {"Humanoid Clone", "GC Hook Bypass"},
    Value = SpeedBypassMethod,
    Callback = function(value)
        SpeedBypassMethod = value
        Memory.SpeedBypassMethod = value
        if SpeedEnabled then
            stopNewBypass()
            task.wait(0.1)
            startNewBypass()
        end
    end,
})

local SpeedToggle = MainTab:Toggle({
    Title = "Speed Hack",
    Desc = "Enable custom walk speed.",
    Icon = "zap",
    Type = "Toggle",
    Value = SpeedEnabled,
    Callback = function(value)
        SpeedEnabled = value
        Memory.SpeedEnabled = value

        if SpeedEnabled then
            startNewBypass()
        else
            stopNewBypass()
            if CurrentHumanoid then
                pcall(function() CurrentHumanoid.WalkSpeed = 16 end)
            end
        end
    end,
})

local FlyInput = MainTab:Input({
    Title = "Fly Speed",
    Desc = "Set your flight speed.",
    InputIcon = "plane",
    Value = tostring(FlySpeed),
    Placeholder = "50",
    Callback = function(value)
        local num = tonumber(value)
        if num then
            FlySpeed = num
            Memory.FlySpeed = num
        end
    end,
})

local FlyToggle = MainTab:Toggle({
    Title = "Fly",
    Desc = "Enable noclip flight.",
    Icon = "plane",
    Type = "Toggle",
    Value = FlyEnabled,
    Callback = function(value)
        FlyEnabled = value
        Memory.FlyEnabled = value
        if FlyEnabled then
            startFly()
        else
            stopFly()
        end
    end,
})

MainTab:Divider()

MainTab:Section({ Title = "Combat", Icon = "shield", Opened = true })

local AntiKnockbackToggle = MainTab:Toggle({
    Title = "Anti Knockback",
    Desc = "Prevents being flung.",
    Icon = "anchor",
    Type = "Toggle",
    Value = AntiKnockbackEnabled,
    Callback = function(value)
        AntiKnockbackEnabled = value
        Memory.AntiKnockbackEnabled = value
    end,
})

local AntiRagdollToggle = MainTab:Toggle({
    Title = "Anti Ragdoll",
    Desc = "Prevents ragdoll by either gaurd or player.",
    Icon = "user-x",
    Type = "Toggle",
    Value = AntiRagdollEnabled,
    Callback = function(value)
        AntiRagdollEnabled = value
        Memory.AntiRagdollEnabled = value
    end,
})

local InstantAccelToggle = MainTab:Toggle({
    Title = "Smooth movement",
    Desc = "Instantly reach max velocity when moving Dork.",
    Icon = "fast-forward",
    Type = "Toggle",
    Value = InstantAccelerationEnabled,
    Callback = function(value)
        InstantAccelerationEnabled = value
        Memory.InstantAccelerationEnabled = value
    end,
})

local AntiRejoinToggle = MainTab:Toggle({
    Title = "Anti Rejoin / Kick",
    Desc = "Blocks Kick and Teleport attempts.",
    Icon = "ban",
    Type = "Toggle",
    Value = AntiRejoinEnabled,
    Callback = function(value)
        AntiRejoinEnabled = value
        Memory.AntiRejoinEnabled = value
    end,
})

local AntiTrapToggle = EggTab:Toggle({
    Title = "Anti Trap",
    Desc = "Anti trap while stealing",
    Icon = "shield",
    Type = "Toggle",
    Value = AntiTrapEnabled,
    Callback = function(value)
        AntiTrapEnabled = value
        Memory.AntiTrapEnabled = value
    end,
})

MainTab:Divider()

MainTab:Section({ Title = "Avatar", Icon = "user", Opened = true })

MainTab:Button({
    Title = "R6",
    Desc = "Execute R6 avatar script.",
    Icon = "person-standing",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Methions/Thingsomething/refs/heads/main/R6"))()
        end)
        if not success then
            warn("[R6] Failed to execute: " .. tostring(err))
        end
    end,
})

AutoSellTab:Section({ Title = "Auto Sell", Icon = "tag", Opened = true })

local RarityOptions = {
    "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic",
    "Cosmic", "Secret", "Prismatic", "Eternal", "Transcendent",
    "Divine", "Celestial", "Titan"
}

local SellRarityDropdown = AutoSellTab:Dropdown({
    Title = "Sell Rarities",
    Desc = "Select which egg rarities to auto sell.",
    Icon = "filter",
    Multi = true,
    Values = RarityOptions,
    Value = AutoSellRarities,
    Callback = function(selected)
        AutoSellRarities = selected
        Memory.AutoSellRarities = selected
    end,
})

AutoSellTab:Toggle({
    Title = "Auto Sell Eggs",
    Desc = "Automatically sell eggs of selected rarities.",
    Icon = "tag",
    Type = "Toggle",
    Value = AutoSellEnabled,
    Callback = function(value)
        AutoSellEnabled = value
        Memory.AutoSellEnabled = value
    end,
})

SettingsTab:Section({ Title = "Window", Icon = "panel-top", Opened = true })

SettingsTab:Button({
    Title = "Open Window",
    Desc = "Open Swenzy Hub immediately.",
    Icon = "panel-top-open",
    Callback = function()
        Window:Open()
    end,
})

SettingsTab:Button({
    Title = "Close Window",
    Desc = "Close Swenzy Hub UI.",
    Icon = "x",
    Callback = function()
        Window:Close()
    end,
})

SettingsTab:Keybind({
    Title = "UI Keybind",
    Desc = "Key to open/close the Swenzy Hub UI.",
    Icon = "keyboard",
    Value = "K",
    CanChange = true,
    Callback = function(key)
        Window:SetToggleKey(Enum.KeyCode[key])
    end,
})

SettingsTab:Section({ Title = "Community", Icon = "message-circle", Opened = true })

SettingsTab:Button({
    Title = "Join Discord",
    Desc = "Copy the Swenzy Hub Discord invite link.",
    Icon = "message-circle",
    Callback = function()
        local copied = copyDiscordLink()
        showDiscordPopup()

        local popup = _chk_CoreGui:FindFirstChild("DiscordPopupGui")
        if not popup then
            local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
            popup = playerGui and playerGui:FindFirstChild("DiscordPopupGui")
        end

        local copyBtn = popup and popup:FindFirstChild("Frame") and popup.Frame:FindFirstChildWhichIsA("TextButton")
        if copyBtn then
            copyBtn.Text = copied and "Copied!" or "Clipboard unavailable"
            task.delay(1.5, function()
                if copyBtn and copyBtn.Parent then
                    copyBtn.Text = "Copy Link"
                end
            end)
        end
    end,
})

local newBypassConnections = {}
local newBypassCharConnection = nil

local GCHookBypass = {
    RunService = RunService,
    Players = Players,
    speedconn = nil,
    hookedfunc3 = nil,
}

function GCHookBypass:collectgarbage()
    local s, r = pcall(function(...)
        return getgc()
    end)
    if s and r then
        return r    
    end
    return warn("failed to get garbage: "..tostring(r))
end

function GCHookBypass:safehook(f, c)
    local s, r = pcall(function(...)
        return hookfunction(f, newlclosure(c))
    end)
    if s and r then
        return r    
    end
    return warn("failed to hook function: "..tostring(r))
end

function GCHookBypass:findfunction(nups, linedefined)
    local s, r = pcall(function(...)
        for _, f in next, self:collectgarbage() do
            if typeof(f) == 'function' and islclosure(f) then
                local upvs = debug.getupvalues(f)
                local line = debug.info(f, "l")

                if upvs and #upvs == nups and line == linedefined then
                    if nups == 10 then
                        local t = debug.getupvalue(f, 3)
                        if typeof(t) == "table" and rawget(t, "Humanoid") then
                            return f
                        end
                    else
                        return f
                    end
                end
            end
        end
        return nil
    end)
    if s and r then
        return r
    end
    return nil
end

function GCHookBypass:init()
    self.LocalPlayer = self.Players.LocalPlayer
    if not self.LocalPlayer then
        return warn("failed to get localplayer")
    end

    if not getgc then
        self.LocalPlayer:Kick("UNSUPPORT EXECUTOR MISSING getgc")
    end

    if not hookfunction then
        self.LocalPlayer:Kick("UNSUPPORT EXECUTOR MISSING hookfunction")
    end

    if not islclosure then
        self.LocalPlayer:Kick("UNSUPPORT EXECUTOR MISSING islclosure")
    end

    local func3 = self:findfunction(19, 3)
    if not func3 then
        return warn("failed to get function 3")
    end

    local v7 = debug.getupvalue(func3, 2)
    if not v7 then
        return warn("failed to get v7")
    end

    self.hookedfunc3 = self:safehook(v7, function(p1, p2)
        if p2 and typeof(p2) == "table" then
            setmetatable(p2, {})
        end
        return self.hookedfunc3(p1,p2)
    end)

    self.speedconn = self.RunService.Heartbeat:Connect(function()
        local char = self.LocalPlayer.Character
        if not char then 
            return
        end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then 
            return
        end
        hum.WalkSpeed = DesiredSpeed
    end)

    warn("[GC Hook Bypass] Initialized")
    return true
end

function GCHookBypass:stop()
    if self.speedconn then
        pcall(function() self.speedconn:Disconnect() end)
        self.speedconn = nil
    end
    warn("[GC Hook Bypass] Stopped")
end

local function startGCHookBypass()
    GCHookBypass:init()
end

local function stopGCHookBypass()
    GCHookBypass:stop()
end

local function forceWalkSpeedNewBypass(humanoid)
    if newBypassConnections[humanoid] then
        pcall(function() newBypassConnections[humanoid]:Disconnect() end)
    end
    newBypassConnections[humanoid] = RunService.Heartbeat:Connect(function()
        if humanoid and humanoid.Parent then
            if humanoid.WalkSpeed ~= DesiredSpeed then
                humanoid.WalkSpeed = DesiredSpeed
            end
        else
            if newBypassConnections[humanoid] then
                newBypassConnections[humanoid]:Disconnect()
                newBypassConnections[humanoid] = nil
            end
        end
    end)
end

local function applyNewBypass(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local camera = workspace.CurrentCamera
    local animateScript = character:FindFirstChild("Animate")
    local jumpPower = humanoid.JumpPower
    local jumpHeight = humanoid.JumpHeight
    local health = humanoid.Health
    local maxHealth = humanoid.MaxHealth

    if animateScript and animateScript:IsA("LocalScript") then
        animateScript.Disabled = true
    end

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        animator:Destroy()
    end

    CurrentHumanoid = humanoid
    forceWalkSpeedNewBypass(humanoid)
end

local function startNewBypass()
    if SpeedBypassMethod == "GC Hook Bypass" then
        startGCHookBypass()
    else
        if player.Character then
            applyNewBypass(player.Character)
        end
        newBypassCharConnection = player.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            applyNewBypass(char)
        end)
    end
end

local function stopNewBypass()
    if SpeedBypassMethod == "GC Hook Bypass" then
        stopGCHookBypass()
    end
    if newBypassCharConnection then
        newBypassCharConnection:Disconnect()
        newBypassCharConnection = nil
    end
    for hum, conn in pairs(newBypassConnections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(newBypassConnections)
end
