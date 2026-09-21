local Lighting = game:GetService('Lighting')
local Workspace = game:GetService('Workspace')
local Players = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')

local GUI_NAME = 'SwenzyLagGUI'
local DISCORD_LINK = 'https://discord.gg/S5n8Kvf7B'
local playerGui = Players.LocalPlayer:WaitForChild('PlayerGui')

-- Remove old copy if present (its cleanup restores the settings automatically)
for _, parent in ipairs({ game:GetService('CoreGui'), playerGui }) do
    local existingGui = parent:FindFirstChild(GUI_NAME)
    if existingGui then
        existingGui:Destroy()
    end
end

----------------------------------------------------------------------
-- STATE + ANTI LAG LOGIC
----------------------------------------------------------------------
local antiLagEnabled = false
local ultraEnabled = false
local effectsActive = false
local descendantConn = nil

local originals = setmetatable({}, { __mode = 'k' })   -- instance -> original properties
local hiddenParts = setmetatable({}, { __mode = 'k' }) -- accessory part -> original Transparency
local lightingOriginal = nil
local effectOriginals = {}
local connections = {}

local function isPostEffect(child)
    return child:IsA('BloomEffect') or child:IsA('BlurEffect') or child:IsA('SunRaysEffect')
end

local function applyLighting()
    if not lightingOriginal then
        lightingOriginal = {
            GlobalShadows = Lighting.GlobalShadows,
            FogEnd = Lighting.FogEnd,
            Brightness = Lighting.Brightness,
            EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
            EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
        }
        for _, child in ipairs(Lighting:GetChildren()) do
            if isPostEffect(child) then
                effectOriginals[child] = child.Enabled
            end
        end
    end

    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 1
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0

    for effect in pairs(effectOriginals) do
        effect.Enabled = false
    end
end

local function restoreLighting()
    if lightingOriginal then
        for prop, value in pairs(lightingOriginal) do
            pcall(function()
                Lighting[prop] = value
            end)
        end
        lightingOriginal = nil
    end
    for effect, enabled in pairs(effectOriginals) do
        pcall(function()
            effect.Enabled = enabled
        end)
    end
    effectOriginals = {}
end

local function applyAntiLag(instance)
    if originals[instance] then
        return
    end
    if instance:IsA('ParticleEmitter') then
        originals[instance] = { Enabled = instance.Enabled }
        instance.Enabled = false
    elseif instance:IsA('Decal') then
        originals[instance] = { Transparency = instance.Transparency }
        instance.Transparency = 1
    elseif instance:IsA('BasePart') then
        originals[instance] = {
            Material = instance.Material,
            Reflectance = instance.Reflectance,
            CastShadow = instance.CastShadow,
        }
        instance.Material = Enum.Material.Plastic
        instance.Reflectance = 0
        instance.CastShadow = false
    end
end

local function restoreParts()
    for instance, props in pairs(originals) do
        for prop, value in pairs(props) do
            pcall(function()
                instance[prop] = value
            end)
        end
    end
    originals = setmetatable({}, { __mode = 'k' })
end

-- Ultra mode hides accessories (reversible) instead of destroying them
local function hideAccessoryPart(instance)
    if instance:IsA('BasePart') and hiddenParts[instance] == nil
        and instance:FindFirstAncestorOfClass('Accessory') then
        hiddenParts[instance] = instance.Transparency
        instance.Transparency = 1
    end
end

local function restoreAccessories()
    for part, transparency in pairs(hiddenParts) do
        pcall(function()
            part.Transparency = transparency
        end)
    end
    hiddenParts = setmetatable({}, { __mode = 'k' })
end

local function onDescendantAdded(instance)
    if effectsActive then
        applyAntiLag(instance)
    end
    if ultraEnabled then
        hideAccessoryPart(instance)
    end
end

-- Apply the current ON/OFF state of both buttons
local function refresh()
    local shouldBeActive = antiLagEnabled or ultraEnabled

    if shouldBeActive and not effectsActive then
        effectsActive = true
        applyLighting()
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            applyAntiLag(descendant)
        end
        if not descendantConn then
            descendantConn = Workspace.DescendantAdded:Connect(onDescendantAdded)
        end
    elseif not shouldBeActive and effectsActive then
        effectsActive = false
        restoreLighting()
        restoreParts()
        if descendantConn then
            descendantConn:Disconnect()
            descendantConn = nil
        end
    end

    if ultraEnabled then
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            hideAccessoryPart(descendant)
        end
    else
        restoreAccessories()
    end
end

----------------------------------------------------------------------
-- GUI
----------------------------------------------------------------------
local screenGui = Instance.new('ScreenGui')
screenGui.Name = GUI_NAME
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- If the GUI is destroyed, turn everything off and restore the original settings
screenGui.Destroying:Connect(function()
    antiLagEnabled = false
    ultraEnabled = false
    refresh()
    for _, conn in ipairs(connections) do
        conn:Disconnect()
    end
end)

local mainFrame = Instance.new('Frame')
mainFrame.Draggable = true
mainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
mainFrame.Active = true
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black interior
mainFrame.Size = UDim2.new(0, 220, 0, 150)
mainFrame.Visible = false -- starts closed, only the logo is visible
mainFrame.Parent = screenGui

local frameCorner = Instance.new('UICorner')
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

-- Red outline
local stroke = Instance.new('UIStroke')
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Parent = mainFrame

local titleLabel = Instance.new('TextLabel')
titleLabel.Font = Enum.Font.LuckiestGuy
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = 'SWENZY LAG'
titleLabel.TextSize = 16
titleLabel.Size = UDim2.new(1, 0, 0, 26)
titleLabel.Parent = mainFrame

local antiLagButton = Instance.new('TextButton')
antiLagButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
antiLagButton.Font = Enum.Font.LuckiestGuy
antiLagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
antiLagButton.Position = UDim2.new(0.05, 0, 0, 32)
antiLagButton.Text = 'ANTI LAG: OFF'
antiLagButton.TextSize = 14
antiLagButton.Size = UDim2.new(0.9, 0, 0, 34)
antiLagButton.Parent = mainFrame

local antiLagCorner = Instance.new('UICorner')
antiLagCorner.CornerRadius = UDim.new(0, 8)
antiLagCorner.Parent = antiLagButton

local antiLagStroke = Instance.new('UIStroke')
antiLagStroke.Thickness = 1.5
antiLagStroke.Color = Color3.fromRGB(255, 0, 0)
antiLagStroke.Parent = antiLagButton

local ultraButton = Instance.new('TextButton')
ultraButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ultraButton.Font = Enum.Font.LuckiestGuy
ultraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ultraButton.Position = UDim2.new(0.05, 0, 0, 72)
ultraButton.Text = 'ULTRA MODE: OFF'
ultraButton.TextSize = 13
ultraButton.Size = UDim2.new(0.9, 0, 0, 30)
ultraButton.Parent = mainFrame

local ultraCorner = Instance.new('UICorner')
ultraCorner.CornerRadius = UDim.new(0, 8)
ultraCorner.Parent = ultraButton

local ultraStroke = Instance.new('UIStroke')
ultraStroke.Thickness = 1.5
ultraStroke.Color = Color3.fromRGB(255, 0, 0)
ultraStroke.Parent = ultraButton

-- Discord (click to copy the link)
local discordButton = Instance.new('TextButton')
discordButton.BackgroundTransparency = 1
discordButton.Font = Enum.Font.GothamBold
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.Position = UDim2.new(0.05, 0, 0, 110)
discordButton.Text = 'discord.gg/S5n8Kvf7B'
discordButton.TextSize = 13
discordButton.Size = UDim2.new(0.9, 0, 0, 28)
discordButton.Parent = mainFrame

discordButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        discordButton.Text = 'LINK COPIED!'
        task.wait(1.5)
        discordButton.Text = 'discord.gg/S5n8Kvf7B'
    end
end)

-- Logo button (your Swenzy Lag image, circular). Tap = open/close the menu.
-- You can also drag the logo anywhere on the screen.
local logoButton = Instance.new('TextButton')
logoButton.Name = 'SwenzyLogo'
logoButton.Active = true
logoButton.AutoButtonColor = false
logoButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logoButton.Font = Enum.Font.LuckiestGuy
logoButton.Text = 'S'
logoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
logoButton.TextSize = 28
logoButton.Position = UDim2.new(0.02, 0, 0.18, 0)
logoButton.Size = UDim2.new(0, 48, 0, 48)
logoButton.ZIndex = 10
logoButton.Parent = screenGui

local logoCorner = Instance.new('UICorner')
logoCorner.CornerRadius = UDim.new(1, 0) -- full circle
logoCorner.Parent = logoButton

local logoStroke = Instance.new('UIStroke')
logoStroke.Thickness = 2
logoStroke.Color = Color3.fromRGB(255, 0, 0)
logoStroke.Parent = logoButton

-- Logo image: it is embedded in this script (see the bottom), so no upload is needed.
-- Optional: to use a Roblox image instead, put its id here, e.g. 'rbxassetid://123456789'
local LOGO_ASSET_ID = ''
local LOGO_B64 -- filled in at the bottom of the file

local B64_CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local function decodeBase64(data)
    local lookup = {}
    for i = 1, #B64_CHARS do
        lookup[B64_CHARS:byte(i)] = i - 1
    end
    data = data:gsub('[^%w%+/=]', '')
    local out = {}
    for i = 1, #data, 4 do
        local a, b, c, d = data:byte(i, i + 3)
        local n = lookup[a] * 262144 + lookup[b] * 4096 + (lookup[c] or 0) * 64 + (lookup[d] or 0)
        local b1 = math.floor(n / 65536)
        local b2 = math.floor(n / 256) % 256
        local b3 = n % 256
        if not c or c == 61 then
            out[#out + 1] = string.char(b1)
        elseif not d or d == 61 then
            out[#out + 1] = string.char(b1, b2)
        else
            out[#out + 1] = string.char(b1, b2, b3)
        end
    end
    return table.concat(out)
end

-- If the executor cannot load the image, the white "S" stays as the logo
local function setLogoImage()
    local imageId = nil

    if LOGO_ASSET_ID ~= '' then
        imageId = LOGO_ASSET_ID
    elseif writefile and (getcustomasset or getsynasset) then
        local ok, result = pcall(function()
            local fileName = 'swenzy_lag_logo_v1.jpg'
            if not (isfile and isfile(fileName)) then
                writefile(fileName, decodeBase64(LOGO_B64))
            end
            return (getcustomasset or getsynasset)(fileName)
        end)
        if ok and result then
            imageId = result
        end
    end

    if not imageId then
        return
    end

    local image = Instance.new('ImageLabel')
    image.Name = 'LogoImage'
    image.BackgroundTransparency = 1
    image.Size = UDim2.new(1, 0, 1, 0)
    image.Image = imageId
    image.ScaleType = Enum.ScaleType.Crop
    image.ZIndex = 11
    image.Parent = logoButton

    local imageCorner = Instance.new('UICorner')
    imageCorner.CornerRadius = UDim.new(1, 0)
    imageCorner.Parent = image
end

-- Drag the logo (it can never leave the screen); a simple tap opens/closes the menu
do
    local dragInput = nil
    local dragStart = nil
    local startOffset = nil
    local moved = false

    logoButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
            dragStart = input.Position
            startOffset = logoButton.AbsolutePosition - screenGui.AbsolutePosition
            moved = false
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End and dragInput == input then
                    dragInput = nil
                    if not moved then
                        mainFrame.Visible = not mainFrame.Visible
                    end
                end
            end)
        end
    end)

    table.insert(connections, UserInputService.InputChanged:Connect(function(input)
        if not dragInput then
            return
        end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement
            and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        local delta = input.Position - dragStart
        if not moved and delta.Magnitude < 8 then
            return
        end
        moved = true
        local screenSize = screenGui.AbsoluteSize
        local size = logoButton.AbsoluteSize
        local x = math.clamp(startOffset.X + delta.X, 0, math.max(0, screenSize.X - size.X))
        local y = math.clamp(startOffset.Y + delta.Y, 0, math.max(0, screenSize.Y - size.Y))
        logoButton.Position = UDim2.fromOffset(x, y)
    end))
end

----------------------------------------------------------------------
-- BUTTONS
----------------------------------------------------------------------
antiLagButton.MouseButton1Click:Connect(function()
    antiLagEnabled = not antiLagEnabled
    antiLagButton.Text = antiLagEnabled and 'ANTI LAG: ON' or 'ANTI LAG: OFF'
    refresh()
end)

ultraButton.MouseButton1Click:Connect(function()
    ultraEnabled = not ultraEnabled
    ultraButton.Text = ultraEnabled and 'ULTRA MODE: ON' or 'ULTRA MODE: OFF'
    refresh()
end)

----------------------------------------------------------------------
-- LOGO IMAGE DATA (JPEG, base64) - do not edit
----------------------------------------------------------------------
LOGO_B64 = [==[
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
]==]
pcall(setLogoImage)

print('SWENZY LAG LOADED')
