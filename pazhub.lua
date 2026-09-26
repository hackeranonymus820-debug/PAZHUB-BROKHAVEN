--[[
    PAZHUB - ZAMSTUDIO
    Map   : Brookhaven RP
    Exec  : Delta
    Made by ZamStudio
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")
local TweenService      = game:GetService("TweenService")
local StarterGui        = game:GetService("StarterGui")
local Lighting          = game:GetService("Lighting")

local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("PAZHUB_ZamStudio") then
    CoreGui.PAZHUB_ZamStudio:Destroy()
end

-- WARNA
local GOLD      = Color3.fromRGB(212, 175, 55)
local GOLD2     = Color3.fromRGB(255, 215, 0)
local BLACK     = Color3.fromRGB(10, 10, 10)
local PANEL     = Color3.fromRGB(22, 22, 22)
local WHITE     = Color3.fromRGB(240, 240, 240)
local HOVER     = Color3.fromRGB(45, 40, 20)

------------------------------------------------------------
-- SCREEN GUI
------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PAZHUB_ZamStudio"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LP:WaitForChild("PlayerGui") end

------------------------------------------------------------
-- ROBOT TOGGLE BUTTON (bundar, draggable)
------------------------------------------------------------
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 54, 0, 54)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -27)
ToggleBtn.BackgroundColor3 = BLACK
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = ""
ToggleBtn.AutoButtonColor = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local tCorner = Instance.new("UICorner", ToggleBtn)
tCorner.CornerRadius = UDim.new(1, 0)

local tStroke = Instance.new("UIStroke", ToggleBtn)
tStroke.Color = GOLD
tStroke.Thickness = 2
tStroke.Transparency = 0.1

-- Logo robot pakai karakter unicode (bukan emoji)
local robotLogo = Instance.new("TextLabel", ToggleBtn)
robotLogo.Size = UDim2.new(1, 0, 1, 0)
robotLogo.BackgroundTransparency = 1
robotLogo.Text = "⌬"  -- simbol robot-like, bukan emoji
robotLogo.TextColor3 = GOLD
robotLogo.Font = Enum.Font.GothamBlack
robotLogo.TextSize = 30

------------------------------------------------------------
-- MAIN FRAME (kecil)
------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
MainFrame.BackgroundColor3 = BLACK
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local mCorner = Instance.new("UICorner", MainFrame)
mCorner.CornerRadius = UDim.new(0, 12)

local mStroke = Instance.new("UIStroke", MainFrame)
mStroke.Color = GOLD
mStroke.Thickness = 2
mStroke.Transparency = 0.15

------------------------------------------------------------
-- TITLE BAR
------------------------------------------------------------
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
TitleBar.BorderSizePixel = 0

local tbCorner = Instance.new("UICorner", TitleBar)
tbCorner.CornerRadius = UDim.new(0, 12)

local tbFix = Instance.new("Frame", TitleBar)
tbFix.Size = UDim2.new(1, 0, 0, 20)
tbFix.Position = UDim2.new(0, 0, 1, -20)
tbFix.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
tbFix.BorderSizePixel = 0

local titleLbl = Instance.new("TextLabel", TitleBar)
titleLbl.Size = UDim2.new(1, -20, 1, 0)
titleLbl.Position = UDim2.new(0, 15, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "PAZHUB - ZAMSTUDIO"
titleLbl.TextColor3 = GOLD
titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextSize = 15
titleLbl.TextXAlignment = Enum.TextXAlignment.Left

local line = Instance.new("Frame", TitleBar)
line.Size = UDim2.new(1, -20, 0, 1)
line.Position = UDim2.new(0, 10, 1, -2)
line.BackgroundColor3 = GOLD
line.BorderSizePixel = 0
line.BackgroundTransparency = 0.4

------------------------------------------------------------
-- SCROLL
------------------------------------------------------------
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -20, 1, -70)
Scroll.Position = UDim2.new(0, 10, 0, 48)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = GOLD
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local sLayout = Instance.new("UIListLayout", Scroll)
sLayout.Padding = UDim.new(0, 8)
sLayout.SortOrder = Enum.SortOrder.LayoutOrder

local sPad = Instance.new("UIPadding", Scroll)
sPad.PaddingTop = UDim.new(0, 4)
sPad.PaddingBottom = UDim.new(0, 4)

------------------------------------------------------------
-- HELPER: ROW DENGAN SWITCH
------------------------------------------------------------
local function makeSwitchRow(labelText, defaultState, callback)
    local row = Instance.new("Frame", Scroll)
    row.Size = UDim2.new(1, 0, 0, 38)
    row.BackgroundColor3 = PANEL
    row.BorderSizePixel = 0
    local rc = Instance.new("UICorner", row); rc.CornerRadius = UDim.new(0, 8)
    local rs = Instance.new("UIStroke", row); rs.Color = GOLD; rs.Thickness = 1; rs.Transparency = 0.7

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = WHITE
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local switchBg = Instance.new("Frame", row)
    switchBg.Size = UDim2.new(0, 48, 0, 24)
    switchBg.Position = UDim2.new(1, -58, 0.5, -12)
    switchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    switchBg.BorderSizePixel = 0
    local sbCorner = Instance.new("UICorner", switchBg); sbCorner.CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", switchBg)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = WHITE
    knob.BorderSizePixel = 0
    local kCorner = Instance.new("UICorner", knob); kCorner.CornerRadius = UDim.new(1, 0)

    local state = defaultState or false

    local function refresh()
        if state then
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = GOLD}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 27, 0.5, -9)}):Play()
        else
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -9)}):Play()
        end
    end

    refresh()

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 5

    btn.MouseButton1Click:Connect(function()
        state = not state
        refresh()
        if callback then task.spawn(function() callback(state) end) end
    end)

    return row
end

------------------------------------------------------------
-- HELPER: BUTTON BIASA
------------------------------------------------------------
local function makeButton(text, color, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = color or PANEL
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = WHITE
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner", btn); c.CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", btn); s.Color = GOLD; s.Thickness = 1; s.Transparency = 0.6

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = HOVER}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = color or PANEL}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        task.spawn(function() if callback then callback() end end)
    end)
    return btn
end

------------------------------------------------------------
-- ESP (nama + highlight biru)
------------------------------------------------------------
local espFolder = Instance.new("Folder", ScreenGui)
espFolder.Name = "ESP"

local function attachESP(plr)
    if plr == LP then return end
    local char = plr.Character
    if not char then return end
    if espFolder:FindFirstChild(tostring(plr.UserId)) then return end

    local hl = Instance.new("Highlight")
    hl.Name = tostring(plr.UserId)
    hl.FillColor = Color3.fromRGB(0, 120, 255)
    hl.OutlineColor = Color3.fromRGB(0, 200, 255)
    hl.FillTransparency = 0.6
    hl.OutlineTransparency = 0
    hl.Adornee = char
    hl.Parent = espFolder

    local bill = Instance.new("BillboardGui")
    bill.Name = "bill"
    bill.Size = UDim2.new(0, 140, 0, 24)
    bill.StudsOffset = Vector3.new(0, 3, 0)
    bill.AlwaysOnTop = true
    bill.Adornee = char
    bill.Parent = hl

    local txt = Instance.new("TextLabel", bill)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Text = plr.Name
    txt.TextColor3 = Color3.fromRGB(0, 200, 255)
    txt.TextStrokeTransparency = 0
    txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 12
end

local function detachAllESP()
    espFolder:ClearAllChildren()
end

local espOn = false

makeSwitchRow("ESP", false, function(state)
    espOn = state
    if state then
        for _, p in ipairs(Players:GetPlayers()) do
            pcall(attachESP, p)
        end
    else
        detachAllESP()
    end
end)

Players.PlayerAdded:Connect(function(p)
    if espOn then
        p.CharacterAdded:Connect(function()
            task.wait(1)
            if espOn then pcall(attachESP, p) end
        end)
    end
end)

------------------------------------------------------------
-- FLY (70 speed)
------------------------------------------------------------
local flyOn = false
local flyBV, flyBG, flyConn

local function startFly()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyBV.Velocity = Vector3.new(0, 0, 0)
    flyBV.Parent = hrp

    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyBG.P = 1000
    flyBG.D = 50
    flyBG.Parent = hrp

    flyConn = RunService.RenderStepped:Connect(function()
        if not flyOn then return end
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        if moveDir.Magnitude > 0 then moveDir = moveDir.Unit end
        flyBV.Velocity = moveDir * 70
        flyBG.CFrame = cam.CFrame
    end)
end

local function stopFly()
    if flyConn then flyConn:Disconnect() end
    if flyBV then flyBV:Destroy() end
    if flyBG then flyBG:Destroy() end
end

makeSwitchRow("FLY - 70 SPEED", false, function(state)
    flyOn = state
    if state then startFly() else stopFly() end
end)

LP.CharacterAdded:Connect(function()
    if flyOn then
        task.wait(1)
        startFly()
    end
end)

------------------------------------------------------------
-- NOCLIP
------------------------------------------------------------
local noclipOn = false
local noclipConn

local function startNoclip()
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipOn then return end
        local char = LP.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)
end

makeSwitchRow("NOCLIP", false, function(state)
    noclipOn = state
    if state then
        startNoclip()
    else
        if noclipConn then noclipConn:Disconnect() end
        local char = LP.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end)

------------------------------------------------------------
-- PERETASAN - SECTION
------------------------------------------------------------
local perkF = Instance.new("Frame", Scroll)
perkF.Size = UDim2.new(1, 0, 0, 24)
perkF.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
perkF.BorderSizePixel = 0
local pfc = Instance.new("UICorner", perkF); pfc.CornerRadius = UDim.new(0, 6)
local pfl = Instance.new("TextLabel", perkF)
pfl.Size = UDim2.new(1, -20, 1, 0); pfl.Position = UDim2.new(0, 10, 0, 0)
pfl.BackgroundTransparency = 1
pfl.Text = "PERETASAN"
pfl.TextColor3 = GOLD
pfl.Font = Enum.Font.GothamBlack
pfl.TextSize = 13
pfl.TextXAlignment = Enum.TextXAlignment.Left

------------------------------------------------------------
-- KILL (dropdown player -> fling)
------------------------------------------------------------
local killRow = Instance.new("Frame", Scroll)
killRow.Size = UDim2.new(1, 0, 0, 38)
killRow.BackgroundColor3 = PANEL
killRow.BorderSizePixel = 0
local krc = Instance.new("UICorner", killRow); krc.CornerRadius = UDim.new(0, 8)
local krs = Instance.new("UIStroke", killRow); krs.Color = GOLD; krs.Thickness = 1; krs.Transparency = 0.7

local killLbl = Instance.new("TextLabel", killRow)
killLbl.Size = UDim2.new(1, -120, 1, 0)
killLbl.Position = UDim2.new(0, 12, 0, 0)
killLbl.BackgroundTransparency = 1
killLbl.Text = "KILL"
killLbl.TextColor3 = WHITE
killLbl.Font = Enum.Font.GothamBold
killLbl.TextSize = 13
killLbl.TextXAlignment = Enum.TextXAlignment.Left

local killBtn = Instance.new("TextButton", killRow)
killBtn.Size = UDim2.new(0, 100, 0, 26)
killBtn.Position = UDim2.new(1, -108, 0.5, -13)
killBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 0)
killBtn.BorderSizePixel = 0
killBtn.Text = "PILIH USER"
killBtn.TextColor3 = GOLD
killBtn.Font = Enum.Font.GothamBold
killBtn.TextSize = 11
killBtn.AutoButtonColor = false
local kbc = Instance.new("UICorner", killBtn); kbc.CornerRadius = UDim.new(0, 6)
local kbs = Instance.new("UIStroke", killBtn); kbs.Color = GOLD; kbs.Thickness = 1; kbs.Transparency = 0.4

------------------------------------------------------------
-- DROPDOWN LIST
------------------------------------------------------------
local dropFrame = Instance.new("Frame", Scroll)
dropFrame.Size = UDim2.new(1, 0, 0, 0)
dropFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
dropFrame.BorderSizePixel = 0
dropFrame.ClipsDescendants = true
dropFrame.Visible = false
local dfc = Instance.new("UICorner", dropFrame); dfc.CornerRadius = UDim.new(0, 8)
local dfs = Instance.new("UIStroke", dropFrame); dfs.Color = GOLD; dfs.Thickness = 1; dfs.Transparency = 0.5

local dropLayout = Instance.new("UIListLayout", dropFrame)
dropLayout.Padding = UDim.new(0, 2)
dropLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function refreshDropdown()
    for _, c in ipairs(dropFrame:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local b = Instance.new("TextButton", dropFrame)
            b.Size = UDim2.new(1, -8, 0, 30)
            b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            b.BorderSizePixel = 0
            b.Text = p.Name
            b.TextColor3 = WHITE
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.AutoButtonColor = false
            local bc = Instance.new("UICorner", b); bc.CornerRadius = UDim.new(0, 6)
            b.MouseEnter:Connect(function()
                TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = HOVER}):Play()
            end)
            b.MouseLeave:Connect(function()
                TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            end)
            b.MouseButton1Click:Connect(function()
                local target = p
                task.spawn(function()
                    local char = target.Character
                    if not char then return end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    -- fling sekali
                    local vel = Instance.new("BodyAngularVelocity", hrp)
                    vel.AngularVelocity = Vector3.new(99999, 99999, 99999)
                    vel.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                    vel.P = 10000
                    local bv = Instance.new("BodyVelocity", hrp)
                    bv.Velocity = Vector3.new(0, 500, 0)
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    task.wait(0.4)
                    vel:Destroy()
                    bv:Destroy()
                end)
            end)
        end
    end
    local count = math.max(1, #Players:GetPlayers() - 1)
    dropFrame.Size = UDim2.new(1, 0, 0, math.min(count, 8) * 32 + 4)
end

killBtn.MouseButton1Click:Connect(function()
    if dropFrame.Visible then
        dropFrame.Visible = false
    else
        refreshDropdown()
        dropFrame.Visible = true
    end
end)

Players.PlayerAdded:Connect(function() if dropFrame.Visible then refreshDropdown() end end)
Players.PlayerRemoving:Connect(function() if dropFrame.Visible then refreshDropdown() end end)

------------------------------------------------------------
-- RAINBOW NAME (smooth)
------------------------------------------------------------
local rainbowOn = false
local rainbowConn
local hue = 0

local function setRainbow(plr, on)
    local char = plr.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    local bill = head:FindFirstChild("RainbowName")
    if on then
        if not bill then
            bill = Instance.new("BillboardGui")
            bill.Name = "RainbowName"
            bill.Size = UDim2.new(0, 200, 0, 26)
            bill.StudsOffset = Vector3.new(0, 3.5, 0)
            bill.AlwaysOnTop = true
            bill.Adornee = head
            bill.Parent = head

            local txt = Instance.new("TextLabel", bill)
            txt.Name = "txt"
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Text = plr.Name
            txt.TextColor3 = Color3.fromRGB(255, 0, 0)
            txt.TextStrokeTransparency = 0
            txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            txt.Font = Enum.Font.GothamBlack
            txt.TextSize = 15
        end
    else
        if bill then bill:Destroy() end
    end
end

makeSwitchRow("RAINBOW NAME", false, function(state)
    rainbowOn = state
    if state then
        setRainbow(LP, true)
        rainbowConn = RunService.RenderStepped:Con
