local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- BRO ITS FOUND ON SCRIPTBLOX (noad)
-- scriptblox.com/script/Brookhaven-RP-Xdemic-music-v2-many-songs-including-raps-201578
-- absolute shittema

if CoreGui:FindFirstChild("XdemicMusicV2") then
    CoreGui:FindFirstChild("XdemicMusicV2"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChatGPMusic"
ScreenGui.Parent = CoreGui

-- main gui
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 310, 0, 210)
Main.Position = UDim2.new(0.5, -155, 0.5, -105)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Main.BackgroundTransparency = 0.03 
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.3
MainStroke.Parent = Main

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255))
}
StrokeGradient.Parent = MainStroke

-- shit
local ParticleFrame = Instance.new("Frame")
ParticleFrame.Size = UDim2.new(1, 0, 1, 0)
ParticleFrame.BackgroundTransparency = 1
ParticleFrame.ClipsDescendants = true
ParticleFrame.ZIndex = 0 
ParticleFrame.Parent = Main
Instance.new("UICorner", ParticleFrame).CornerRadius = UDim.new(0, 10)

task.spawn(function()
    while task.wait(0.4) do
        if not ParticleFrame.Parent then break end
        local particle = Instance.new("Frame")
        local size = math.random(2, 4)
        particle.Size = UDim2.new(0, size, 0, size)
        particle.Position = UDim2.new(math.random(0, 100)/100, 0, 1, 0)
        particle.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
        particle.BackgroundTransparency = math.random(3, 7) / 10
        particle.BorderSizePixel = 0
        particle.ZIndex = 0
        Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
        particle.Parent = ParticleFrame
        local floatDuration = math.random(4, 7)
        local drift = (math.random(-10, 10) / 100)
        local tween = TweenService:Create(particle, TweenInfo.new(floatDuration, Enum.EasingStyle.Linear), {
            Position = UDim2.new(particle.Position.X.Scale + drift, 0, -0.1, 0),
            BackgroundTransparency = 1
        })
        tween:Play()
        tween.Completed:Connect(function() particle:Destroy() end)
    end
end)

-- notif
local Popup = Instance.new("Frame")
Popup.Size = UDim2.new(1, 0, 1, 0)
Popup.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Popup.BackgroundTransparency = 0.05
Popup.Visible = false
Popup.ZIndex = 50
Popup.Parent = Main
Instance.new("UICorner", Popup).CornerRadius = UDim.new(0, 10)

local PopupText = Instance.new("TextLabel")
PopupText.Size = UDim2.new(1, -20, 0, 40)
PopupText.Position = UDim2.new(0, 10, 0.5, -40)
PopupText.BackgroundTransparency = 1
PopupText.Text = "Are you sure you want to close Xdemic Music v2?"
PopupText.TextColor3 = Color3.fromRGB(255, 255, 255)
PopupText.Font = Enum.Font.GothamSemibold
PopupText.TextSize = 12
PopupText.TextWrapped = true
PopupText.ZIndex = 51
PopupText.Parent = Popup

local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0, 80, 0, 25)
YesBtn.Position = UDim2.new(0.5, -85, 0.5, 10)
YesBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
YesBtn.Text = "Yes"
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.TextSize = 11
YesBtn.ZIndex = 51
YesBtn.Parent = Popup
Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0, 4)

local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0, 80, 0, 25)
NoBtn.Position = UDim2.new(0.5, 5, 0.5, 10)
NoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
NoBtn.Text = "No"
NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoBtn.Font = Enum.Font.GothamBold
NoBtn.TextSize = 11
NoBtn.ZIndex = 51
NoBtn.Parent = Popup
Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0, 4)

YesBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
NoBtn.MouseButton1Click:Connect(function() Popup.Visible = false end)

-- head gui
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundTransparency = 1
Header.ZIndex = 5
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ChatGPMusic "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 11
Title.ZIndex = 5
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header
Instance.new("UIGradient", Title).Color = StrokeGradient.Color

local UserLabel = Instance.new("TextLabel")
UserLabel.Size = UDim2.new(0.3, 0, 1, 0)
UserLabel.Position = UDim2.new(0.5, 0, 0, 0)
UserLabel.BackgroundTransparency = 1
UserLabel.Text = LocalPlayer.DisplayName
UserLabel.TextColor3 = Color3.fromRGB(150, 180, 255)
UserLabel.Font = Enum.Font.GothamSemibold
UserLabel.TextSize = 11
UserLabel.ZIndex = 5
UserLabel.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "Clse"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 10
CloseBtn.ZIndex = 5
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

local Avatar = Instance.new("ImageLabel")
Avatar.Size = UDim2.new(0, 20, 0, 20)
Avatar.Position = UDim2.new(1, -50, 0, 5)
Avatar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=48&h=48"
Avatar.ZIndex = 5
Avatar.Parent = Header
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

CloseBtn.MouseButton1Click:Connect(function() Popup.Visible = true end)

-- draggable (ai vibecoded fully script lfmao)
local dragging, dragInput, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- anim
local function applyClickAnimation(btn)
    local originalSize = btn.Size
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 2, originalSize.Y.Scale, originalSize.Y.Offset - 2)}):Play()
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = originalSize}):Play()
        end
    end)
end

-- Tabs
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(0, 85, 1, -40)
TabButtons.Position = UDim2.new(0, 10, 0, 30)
TabButtons.BackgroundTransparency = 1
TabButtons.ZIndex = 2
TabButtons.Parent = Main

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = TabButtons

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -110, 1, -40)
ContentArea.Position = UDim2.new(0, 100, 0, 30)
ContentArea.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
ContentArea.ZIndex = 2
ContentArea.Parent = Main
Instance.new("UICorner", ContentArea).CornerRadius = UDim.new(0, 8)

-- watermrk
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, -15, 0, 15)
Watermark.Position = UDim2.new(0, 0, 1, -15)
Watermark.BackgroundTransparency = 1
Watermark.Text = "MindyLoozy + ChatGPT"
Watermark.TextColor3 = Color3.fromRGB(60, 60, 80)
Watermark.Font = Enum.Font.Gotham
Watermark.TextSize = 9
Watermark.TextXAlignment = Enum.TextXAlignment.Right
Watermark.ZIndex = 2
Watermark.Parent = Main

-- Symbols
local SymbolData = {
    ["Smart"] = "SMART_FLAG",
    ["€^"] = string.rep("€^", 50),
    ["π_"] = string.rep("π_", 50),
    ["_™_©_®"] = string.rep("_™_©_®", 15),
    ["§~"] = string.rep("§~", 60),
    ["Ω_"] = string.rep("Ω_", 45),
    ["@@"] = string.rep("@@", 170),
    ["__"] = string.rep("__", 160)
}

local AvailableSymbols = {}
local lastSmartSymbol = ""

local function refillSymbols()
    AvailableSymbols = {}
    for key, val in pairs(SymbolData) do
        if key ~= "Smart" then
            table.insert(AvailableSymbols, val)
        end
    end
end
refillSymbols()

local function getSmartSymbol()
    if #AvailableSymbols == 0 then refillSymbols() end
    local randomIndex = math.random(1, #AvailableSymbols)
    local chosen = AvailableSymbols[randomIndex]
    return chosen
end

local ChildRoasts = {
    "Coded by Deepseek", "xdemic is loser👅👅", "MindyLoozy is cool btw", "maded by ChatGPT",
    "Developed by Gemini", "this script is sht", "found by MindyLoozy", "helped by Claude"
}

-- ctrl + c + ctrl + v script
local RE = ReplicatedStorage:FindFirstChild("RE") or ReplicatedStorage:WaitForChild("RE", 5)
local VehicleRemote = RE and RE:FindFirstChild("1NoMoto1rVehicle1s")
local ClearRemote = RE and RE:FindFirstChild("1Clea1rTool1s")
local RGBEnabled = false

local function SetVehicleSpeed()
    task.spawn(function()
        pcall(function()
            local RS = ReplicatedStorage
            local GetSpeed, SetSpeed
            if RS:FindFirstChild("Remotes") then 
                GetSpeed = RS.Remotes:FindFirstChild("GetNoMotorVehicleSpeed")
                SetSpeed = RS.Remotes:FindFirstChild("SetNoMotorVehicleSpeed")
            elseif RS:FindFirstChild("RE") then 
                GetSpeed = RS.RE:FindFirstChild("GetNoMotorVehicleSpeed")
                SetSpeed = RS.RE:FindFirstChild("SetNoMotorVehicleSpeed") 
            end
            if GetSpeed and SetSpeed then 
                GetSpeed:InvokeServer()
                SetSpeed:InvokeServer(25) 
            end
        end)
    end)
end

local function ForcePlayMusic(Remote, ID)
    if not Remote or ID == "" then return end
    Remote:FireServer("PickingScooterMusicText", ID, nil, true)
    Remote:FireServer("PickingScooterMusicText", ID)
    Remote:FireServer("PickingScooterMusicText", tonumber(ID), nil, true)
end

local function StartRGBLoop()
    if RGBEnabled then return end
    RGBEnabled = true
    task.spawn(function()
        local CarRemote = RE and RE:FindFirstChild("1Player1sCa1r")
        while RGBEnabled and task.wait(0.1) do
            local c = Color3.fromHSV(tick()%5/5, 1, 1)
            if CarRemote then CarRemote:FireServer("NoMotorColor", c) end
            pcall(function() 
                Players.LocalPlayer.PlayerGui.MainGUIHandler.NoMotorVehicleControl.NoMotorColorPicks.SetColor:FireServer(c) 
            end)
        end
    end)
end

local function SmartPlayMusic(id, vehicleType, useRGB)
    if not VehicleRemote or not ClearRemote then return end
    task.spawn(function()
        RGBEnabled = false
        VehicleRemote:FireServer("Delete NoMotorVehicle")
        task.wait(0.1)
        ClearRemote:FireServer("ClearAllTools")
        task.wait(0.15)
        SetVehicleSpeed()
        VehicleRemote:FireServer(vehicleType)
        task.wait(1.0)
        if useRGB then StartRGBLoop() end
        ForcePlayMusic(VehicleRemote, id)
    end)
end

local function StopMusic()
    RGBEnabled = false
    if VehicleRemote then VehicleRemote:FireServer("Delete NoMotorVehicle") end
    task.spawn(function()
        task.wait(0.1)
        if ClearRemote then ClearRemote:FireServer("ClearAllTools") end
    end)
end

-- chat (??)
local function sendToRobloxChat(message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if channel then channel:SendAsync(message) end
    else
        local sayEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if sayEvent and sayEvent:FindFirstChild("SayMessageRequest") then
            sayEvent.SayMessageRequest:FireServer(message, "All")
        end
    end
end

local function sendSafeSpam(prefixName, customText)
    local prefixString = prefixName == "Smart" and getSmartSymbol() or (SymbolData[prefixName] or "")
    local finalMessage = customText ~= "" and prefixString .. " " .. customText or prefixString
    sendToRobloxChat(finalMessage)
end

-- tabs
local activeContent = nil
local function createTab(name, isFirst)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 28)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Btn.BackgroundTransparency = isFirst and 0 or 1
    Btn.Text = name
    Btn.TextColor3 = isFirst and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 130, 150)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 11
    Btn.ZIndex = 3
    Btn.Parent = TabButtons
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    applyClickAnimation(Btn)

    local Page = Instance.new("Frame")
    Page.Size = UDim2.new(1, -20, 1, -10)
    Page.Position = UDim2.new(0, 10, 0, 5)
    Page.BackgroundTransparency = 1
    Page.Visible = isFirst
    Page.ZIndex = 3
    Page.Parent = ContentArea

    if isFirst then activeContent = Page end

    Btn.MouseButton1Click:Connect(function()
        if activeContent == Page then return end
        for _, child in pairs(TabButtons:GetChildren()) do
            if child:IsA("TextButton") then
                TweenService:Create(child, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(130, 130, 150)}):Play()
            end
        end
        for _, child in pairs(ContentArea:GetChildren()) do
            if child:IsA("Frame") then child.Visible = false end
        end
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        Page.Visible = true
        activeContent = Page
    end)
    return Page
end

local SpammerPage = createTab("Spammer", true)
local MusicPage = createTab("Music", false)
local PropsPage = createTab("Props", false)
local ProtectionPage = createTab("Protection", false)
local CreditsPage = createTab("Credits", false)

-- spam to
local function buildSpamUI(parentFrame, isRoastMode)
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, 0, 0, 22)
    TextBox.Position = UDim2.new(0, 0, 0, 30)
    TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    TextBox.PlaceholderText = isRoastMode and "Enter Player Name..." or "Enter Text..."
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 11
    TextBox.ClearTextOnFocus = true
    TextBox.ZIndex = 4
    TextBox.Parent = parentFrame
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 4)

    local currentSelected = "Smart"
    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(1, 0, 0, 22)
    DropBtn.Position = UDim2.new(0, 0, 0, 57)
    DropBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    DropBtn.Text = "Symbol: " .. currentSelected .. " ▼"
    DropBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
    DropBtn.Font = Enum.Font.Gotham
    DropBtn.TextSize = 11
    DropBtn.ZIndex = 4
    DropBtn.Parent = parentFrame
    Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 4)
    applyClickAnimation(DropBtn)

    local ScrollList = Instance.new("ScrollingFrame")
    ScrollList.Size = UDim2.new(1, 0, 0, 70)
    ScrollList.Position = UDim2.new(0, 0, 0, 82)
    ScrollList.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    ScrollList.BorderSizePixel = 0
    ScrollList.ZIndex = 15
    ScrollList.Visible = false
    ScrollList.ScrollBarThickness = 3
    ScrollList.Parent = parentFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.Name
    ListLayout.Parent = ScrollList
    
    for key, _ in pairs(SymbolData) do
        local Opt = Instance.new("TextButton")
        Opt.Size = UDim2.new(1, 0, 0, 18)
        Opt.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        Opt.Text = " " .. key
        Opt.TextColor3 = Color3.fromRGB(255, 255, 255)
        Opt.Font = Enum.Font.Gotham
        Opt.TextSize = 10
        Opt.TextXAlignment = Enum.TextXAlignment.Left
        Opt.ZIndex = 16
        Opt.Name = key
        Opt.Parent = ScrollList
        
        Opt.MouseButton1Click:Connect(function()
            currentSelected = key
            DropBtn.Text = "Symbol: " .. key .. " ▼"
            ScrollList.Visible = false
        end)
    end
    ScrollList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
    DropBtn.MouseButton1Click:Connect(function() ScrollList.Visible = not ScrollList.Visible end)

    local DelayBox = Instance.new("TextBox")
    DelayBox.Size = UDim2.new(0.25, 0, 0, 22)
    DelayBox.Position = UDim2.new(0, 0, 0, 84)
    DelayBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    DelayBox.Text = "2"
    DelayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    DelayBox.Font = Enum.Font.Gotham
    DelayBox.TextSize = 11
    DelayBox.ClearTextOnFocus = true
    DelayBox.ZIndex = 4
    DelayBox.Parent = parentFrame
    Instance.new("UICorner", DelayBox).CornerRadius = UDim.new(0, 4)

    local SpamBtn = Instance.new("TextButton")
    SpamBtn.Size = UDim2.new(0.72, 0, 0, 22)
    SpamBtn.Position = UDim2.new(0.28, 0, 0, 84)
    SpamBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    SpamBtn.Text = "Spam"
    SpamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpamBtn.Font = Enum.Font.GothamBold
    SpamBtn.TextSize = 11
    SpamBtn.ZIndex = 4
    SpamBtn.Parent = parentFrame
    Instance.new("UICorner", SpamBtn).CornerRadius = UDim.new(0, 4)
    applyClickAnimation(SpamBtn)

    local isSpamming = false
    SpamBtn.MouseButton1Click:Connect(function()
        isSpamming = not isSpamming
        if isSpamming then
            SpamBtn.Text = "Stop"
            SpamBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            task.spawn(function()
                while isSpamming do
                    local delayTime = tonumber(DelayBox.Text) or 2
                    local finalText = TextBox.Text
                    if isRoastMode and finalText ~= "" then
                        local randomRoast = ChildRoasts[math.random(1, #ChildRoasts)]
                        finalText = finalText .. " < " .. randomRoast
                    end
                    sendSafeSpam(currentSelected, finalText)
                    task.wait(delayTime)
                end
            end)
        else
            SpamBtn.Text = "Spam"
            SpamBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        end
    end)
end

local function createAdvancedSubTabs(parentPage, tabConfigs)
    local SubTabContainer = Instance.new("Frame")
    SubTabContainer.Size = UDim2.new(1, 0, 0, 22)
    SubTabContainer.BackgroundTransparency = 1
    SubTabContainer.ZIndex = 4
    SubTabContainer.Parent = parentPage

    local SubListLayout = Instance.new("UIListLayout")
    SubListLayout.FillDirection = Enum.FillDirection.Horizontal
    SubListLayout.Padding = UDim.new(0, 4)
    SubListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SubListLayout.Parent = SubTabContainer

    local contentFrames = {}
    local buttons = {}
    local widthScale = (1 / #tabConfigs)
    local paddingOffset = (4 * (#tabConfigs - 1)) / #tabConfigs

    for i, config in ipairs(tabConfigs) do
        local SubBtn = Instance.new("TextButton")
        SubBtn.Size = UDim2.new(widthScale, -paddingOffset, 1, 0)
        SubBtn.BackgroundColor3 = (i == 1) and Color3.fromRGB(50, 50, 65) or Color3.fromRGB(30, 30, 40)
        SubBtn.Text = config.name
        SubBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
        SubBtn.Font = Enum.Font.Gotham
        SubBtn.TextSize = 10
        SubBtn.ZIndex = 4
        SubBtn.Parent = SubTabContainer
        Instance.new("UICorner", SubBtn).CornerRadius = UDim.new(0, 4)
        applyClickAnimation(SubBtn)
        table.insert(buttons, SubBtn)

        local SubContent = Instance.new("Frame")
        SubContent.Size = UDim2.new(1, 0, 1, -25)
        SubContent.Position = UDim2.new(0, 0, 0, 25)
        SubContent.BackgroundTransparency = 1
        SubContent.Visible = (i == 1)
        SubContent.ZIndex = 4
        SubContent.Parent = parentPage
        table.insert(contentFrames, SubContent)
        
        if config.buildFunc then config.buildFunc(SubContent, config.isRoast) end

        SubBtn.MouseButton1Click:Connect(function()
            for _, frame in ipairs(contentFrames) do frame.Visible = false end
            for _, btn in ipairs(buttons) do TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play() end
            SubContent.Visible = true
            TweenService:Create(SubBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 65)}):Play()
        end)
    end
end

-- bypas play tyes
local function buildMusicPlayerUI(parentFrame)
    local IDBox = Instance.new("TextBox")
    IDBox.Size = UDim2.new(1, 0, 0, 22)
    IDBox.Position = UDim2.new(0, 0, 0, 5)
    IDBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    IDBox.PlaceholderText = "Enter Audio ID..."
    IDBox.Text = ""
    IDBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    IDBox.Font = Enum.Font.Gotham
    IDBox.TextSize = 11
    IDBox.ClearTextOnFocus = true
    IDBox.ZIndex = 4
    IDBox.Parent = parentFrame
    Instance.new("UICorner", IDBox).CornerRadius = UDim.new(0, 4)

    local ScrollList = Instance.new("ScrollingFrame")
    ScrollList.Size = UDim2.new(1, 0, 1, -32)
    ScrollList.Position = UDim2.new(0, 0, 0, 32)
    ScrollList.BackgroundTransparency = 1
    ScrollList.BorderSizePixel = 0
    ScrollList.ScrollBarThickness = 2
    ScrollList.ZIndex = 4
    ScrollList.Parent = parentFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 4)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = ScrollList

    local function makeBtn(text, color, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -5, 0, 22)
        Btn.BackgroundColor3 = color
        Btn.Text = text
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 10
        Btn.ZIndex = 4
        Btn.Parent = ScrollList
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
        applyClickAnimation(Btn)
        
        Btn.MouseButton1Click:Connect(function()
            local oldText = Btn.Text
            Btn.Text = "Loading..."
            task.spawn(function()
                callback()
                task.wait(1.5)
                Btn.Text = oldText
            end)
        end)
    end

    makeBtn("Play Skateboard", Color3.fromRGB(0, 120, 255), function() SmartPlayMusic(IDBox.Text, "SkateBoard", false) end)
    makeBtn("Play Hoverboard", Color3.fromRGB(0, 120, 255), function() SmartPlayMusic(IDBox.Text, "SegwaySmall", false) end)
    makeBtn("RGB Skateboard", Color3.fromRGB(150, 50, 255), function() SmartPlayMusic(IDBox.Text, "SkateBoard", true) end)
    makeBtn("RGB Hoverboard", Color3.fromRGB(150, 50, 255), function() SmartPlayMusic(IDBox.Text, "SegwaySmall", true) end)
    makeBtn("Stop Music", Color3.fromRGB(255, 60, 60), function() StopMusic() end)
    
    ScrollList.CanvasSize = UDim2.new(0, 0, 0, 140)
end

-- playlst
local function buildMusicIDsUI(parentFrame)
    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(1, 0, 0, 22)
    SearchBox.Position = UDim2.new(0, 0, 0, 5)
    SearchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    SearchBox.PlaceholderText = "🔍 Search Song Name..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.TextSize = 11
    SearchBox.ClearTextOnFocus = false
    SearchBox.ZIndex = 4
    SearchBox.Parent = parentFrame
    Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)

    local ScrollList = Instance.new("ScrollingFrame")
    ScrollList.Size = UDim2.new(1, 0, 1, -35)
    ScrollList.Position = UDim2.new(0, 0, 0, 32)
    ScrollList.BackgroundTransparency = 1
    ScrollList.BorderSizePixel = 0
    ScrollList.ScrollBarThickness = 3
    ScrollList.ZIndex = 4
    ScrollList.Parent = parentFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 4)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = ScrollList

    local currentlyPlayingBtn = nil
    local uiItems = {}

    local function SmartTogglePlay(id, btn)
        if currentlyPlayingBtn == btn then
            StopMusic()
            btn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
            btn.Text = "▶"
            currentlyPlayingBtn = nil
        else
            if currentlyPlayingBtn then
                currentlyPlayingBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
                currentlyPlayingBtn.Text = "▶"
            end
            currentlyPlayingBtn = btn
            btn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            btn.Text = "■" 
            
            if not VehicleRemote or not ClearRemote then return end
            task.spawn(function()
                RGBEnabled = false
                VehicleRemote:FireServer("Delete NoMotorVehicle")
                task.wait(0.1)
                ClearRemote:FireServer("ClearAllTools")
                task.wait(0.15)
                SetVehicleSpeed()
                VehicleRemote:FireServer("SegwaySmall")
                task.wait(1.0)
                if currentlyPlayingBtn == btn then
                    StartRGBLoop()
                    ForcePlayMusic(VehicleRemote, id)
                end
            end)
        end
    end

    local function CreateCategoryHeader(title)
        local Header = Instance.new("TextLabel")
        Header.Size = UDim2.new(1, -5, 0, 20)
        Header.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        Header.Text = "  " .. title
        Header.TextColor3 = Color3.fromRGB(80, 180, 255)
        Header.Font = Enum.Font.GothamBold
        Header.TextSize = 11
        Header.TextXAlignment = Enum.TextXAlignment.Left
        Header.ZIndex = 4
        Header.Parent = ScrollList
        Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 4)
        table.insert(uiItems, {frame = Header, type = "header", name = ""})
    end

    local function CreateSongEntry(name, id)
        local Entry = Instance.new("Frame")
        Entry.Size = UDim2.new(1, -5, 0, 25)
        Entry.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        Entry.ZIndex = 4
        Entry.Parent = ScrollList
        Instance.new("UICorner", Entry).CornerRadius = UDim.new(0, 4)
        table.insert(uiItems, {frame = Entry, type = "song", name = string.lower(name)})

        local NameLbl = Instance.new("TextLabel")
        NameLbl.Size = UDim2.new(0.7, 0, 1, 0)
        NameLbl.Position = UDim2.new(0, 10, 0, 0)
        NameLbl.BackgroundTransparency = 1
        NameLbl.Text = name
        NameLbl.TextColor3 = Color3.fromRGB(200, 200, 220)
        NameLbl.Font = Enum.Font.Gotham
        NameLbl.TextSize = 10
        NameLbl.TextXAlignment = Enum.TextXAlignment.Left
        NameLbl.TextTruncate = Enum.TextTruncate.AtEnd
        NameLbl.ZIndex = 5
        NameLbl.Parent = Entry

        local PlayBtn = Instance.new("TextButton")
        PlayBtn.Size = UDim2.new(0, 25, 0, 18)
        PlayBtn.Position = UDim2.new(1, -30, 0, 3)
        PlayBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        PlayBtn.Text = "▶"
        PlayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayBtn.Font = Enum.Font.GothamBold
        PlayBtn.TextSize = 10
        PlayBtn.ZIndex = 5
        PlayBtn.Parent = Entry
        Instance.new("UICorner", PlayBtn).CornerRadius = UDim.new(0, 4)

        PlayBtn.MouseButton1Click:Connect(function()
            SmartTogglePlay(tostring(id), PlayBtn)
        end)
    end

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local searchText = string.lower(SearchBox.Text)
        local visibleCount = 0
        for _, item in ipairs(uiItems) do
            if searchText == "" then
                item.frame.Visible = true
                visibleCount = visibleCount + 1
            else
                if item.type == "header" then
                    item.frame.Visible = false
                elseif item.type == "song" and string.find(item.name, searchText, 1, true) then
                    item.frame.Visible = true
                    visibleCount = visibleCount + 1
                else
                    item.frame.Visible = false
                end
            end
        end
        ScrollList.CanvasSize = UDim2.new(0, 0, 0, visibleCount * 29)
    end)

    -- list
    local MasterList = {
        {header = "GLOBAL HITS"},
        {"Soft Skies & You", 140736931153864}, {"Blue Young Kai", 84729628311938}, {"Summertime Sadness", 107887768910692},
        {"Love Story", 135528953872601}, {"Mommyy", 112429422439068}, {"I Got You Baby", 115492336583856},
        {"Alone", 105512964264815}, {"Another World", 111351357978027}, {"Isekai", 131874270028720},
        {"StarsMoon", 112355709978731}, {"Meow Meow", 99034537604129}, {"Under the influence", 103222441664136},
        {"Sadness", 128159342762162}, {"Sweater Weather", 75254239320157}, {"Doraemon", 121640028060880},
        {"Baby Shark", 126462032038855}, {"So Clean", 93958751571254}, {"NoCopyrightSound", 72031945149756},
        {"LegendNeverDies", 112738519477450}, {"Thought", 87373439541502}, {"Confess You Love", 87559737835956},
        {"SetMcMn", 78631447496051}, {"The Weeknd - Blinding Lights", 1842805773}, {"Dua Lipa - Levitating", 6606223788},
        {"Harry Styles - As It Was", 8915577374}, {"Taylor Swift - Anti-Hero", 11098454532}, {"Miley Cyrus - Flowers", 12211382345},
        {"Doja Cat - Paint The Town Red", 14372520607}, {"Olivia Rodrigo - Vampire", 14019995782}, {"SZA - Kill Bill", 12046416989},
        {"Beyoncé - CUFF IT", 10131382078}, {"Sabrina Carpenter - Espresso", 16789123456},
        
        {header = "HINDI BANGERS"},
        {"HE RANGLO", 128232876294868}, {"Akhiyan", 104380086210152}, {"Aalu Kachlu Beta", 138396893861830},
        {"Bada Pachtaoge", 79561785821029}, {"Saiyara", 110710316953203}, {"Unke Andaz Karam", 95589943778476},
        {"Hai Dill Yein Mera", 113792808283128}, {"Dhun Female", 129981117529204}, {"Manja", 83325283987770},
        {"Aaj Mangalwar Hai", 98606901625415}, {"Majisa", 91368973732735}, {"Pal Pal", 77002121761232},
        {"Nacho Saare", 108968616078928}, {"Tumse Mil Kar", 133053501453467}, {"Pyar Ka Ehsas", 105568083374120},
        {"Ladki Badi Anjani Hai", 128892246666972}, {"Dil Ne Ye Kaha", 113554906905279}, {"Gulabi Gulabi", 102924925389960},
        {"Addat", 94103203628909}, {"Naddiyaaa", 128688756073670}, {"Kabhi Kabhi", 101068303675725},
        {"Jhol", 121180010622504}, {"Maula Mere", 105017950345985}, {"Mann Mera", 140298499491642},
        {"Deewana", 88345320570909}, {"Naini Se Baan", 108734798852042}, {"Saawre", 111219978139804},
        {"Kitni Hasrat", 93457193569619}, {"Grish Ka Ganna", 104916889617105}, {"Sason Ki Mala", 120349214701956},
        {"Holi Ke din", 115634143210295}, {"Aaj Ki Raat", 73958484988503}, {"Hathi Raja", 106266156568507},
        {"New Krish Ka Gana", 112509603877994}, {"Ranjheya Ve", 119786491353134}, {"Mujhe Nafrat Hain", 88750836439164},
        {"Pardeshi", 90560862399777}, {"Kabhi Kab Rap", 137355570793959}, {"O Yaara", 117377307469141},
        {"Sitam", 81582927737472}, {"Muskaan", 74180449839527}, {"Ishq Aashiqana", 84689783601883},
        {"NaNa Karte Karte", 87629461934311}, {"Parde Mein", 81161805007229}, {"Dil Hain Tera", 126020491218161},
        {"Zaroori Tha", 90050076108794}, {"Mera Pyaar", 86442760739586}, {"Diwaanaa", 74803752690893},
        {"Tum Jo Aayein", 123883140253393}, {"Tera Mera Rista", 133309449131920}, {"Tumhee Aana", 121581884194482},
        {"Rab Kare Tujhko", 85476270857623}, {"Tujh Se Naraj", 132205900730979}, {"Bada Achha Lagta", 109840879921151},
        {"Kesariya", 10059668834}, {"Apna Bana Le", 11005590115}, {"Raataan Lambiyan", 7384523412},
        {"Ranjha", 9102384756}, {"Shayad", 6521458932}, {"Tujhe Kitna Chahne Lage", 5432678901},
        
        {header = "RAP"},
        {"Drake - God's Plan", 1665926924}, {"Kanye West - Stronger", 136209425}, {"Coolio - Gangsta's Paradise", 6070263388},
        {"Lil Nas X - Industry Baby", 7253841629}, {"Wiz Khalifa - Black and Yellow", 139235100}, {"A Roblox Rap", 1259050178},
        {"Polo G - RAPSTAR", 6678031214}, {"Childish Gambino - This Is America", 2062482384},
        {"Snoop Dogg - Drop It Like It's Hot", 292861322}, {"Eminem - Without Me", 6689996382},
        {"Eminem - Lose Yourself", 142297926}, {"Eminem - Rap God", 163169183}, {"Eminem - Not Afraid", 289230995},
        {"Eminem - The Real Slim Shady", 142376088}, {"Eminem - Love The Way You Lie", 152829789},
        {"Drake - In My Feelings", 2153662828}, {"Drake - Hotline Bling", 289230995}, {"Drake - One Dance", 1102847415},
        {"Drake - Nonstop", 6568276171}, {"Drake - Toosie Slide", 7178201139},
        {"Kendrick Lamar - HUMBLE.", 6568276171}, {"Kendrick Lamar - DNA.", 7673592454}, {"Kendrick Lamar - Alright", 289230123},
        {"Kendrick Lamar - Swimming Pools", 142376456}, {"Kendrick Lamar - King Kunta", 289231234},
        {"Travis Scott - SICKO MODE", 2153662828}, {"Travis Scott - Goosebumps", 1102847415}, {"Travis Scott - HIGHEST IN THE ROOM", 4053876340},
        {"Travis Scott - Antidote", 289231567}, {"Travis Scott - STARGAZING", 6568277890},
        {"Post Malone - Circles", 3951656337}, {"Post Malone - Rockstar", 1102847415}, {"Post Malone - Congratulations", 2153662828},
        {"Post Malone - Sunflower", 289231890}, {"Post Malone - Better Now", 6568278901},
        {"Kanye West - Heartless", 152829345}, {"Kanye West - Gold Digger", 142376088}, {"Kanye West - Power", 289232123},
        {"Kanye West - All of the Lights", 6568279012}, {"Kanye West - Black Skinhead", 7178204567},
        {"Lil Nas X - Old Town Road", 2892309951}, {"Lil Nas X - Montero", 6568276171}, {"Lil Nas X - Panini", 289232456},
        {"Nicki Minaj - Super Bass", 473218026}, {"Nicki Minaj - Starships", 289230456}, {"Nicki Minaj - Anaconda", 152829789},
        {"Nicki Minaj - Bang Bang", 289232789},
        {"50 Cent - In Da Club", 142305215}, {"50 Cent - Candy Shop", 152830123}, {"50 Cent - P.I.M.P.", 142376456},
        {"50 Cent - Many Men", 289233012},
        {"Jack Harlow - First Class", 9043629582}, {"Jack Harlow - WHATS POPPIN", 6568276234},
        {"Cardi B - WAP", 6568276789}, {"Cardi B - Bodak Yellow", 289231234}, {"Cardi B - I Like It", 152830567},
        {"Megan Thee Stallion - Savage", 6568277890}, {"Megan Thee Stallion - Body", 7178202345},
        {"DaBaby - ROCKSTAR", 6568278901}, {"DaBaby - BOP", 289231890},
        {"Pop Smoke - Dior", 6568279012}, {"Pop Smoke - For The Night", 289232123},
        {"Juice WRLD - Lucid Dreams", 289232456}, {"Juice WRLD - Robbery", 7178205678},
        {"XXXTentacion - SAD!", 289232789}, {"XXXTentacion - Moonlight", 6568281234},
        {"Lil Baby - Drip Too Hard", 289233012}, {"Lil Baby - Woah", 6568282345},
        {"Roddy Ricch - The Box", 289233345}, {"Roddy Ricch - High Fashion", 6568283456},
        {"NF - The Search", 289234567}, {"NF - Let You Down", 6568291234},
        {"Logic - 1-800-273-8255", 7178215678}, {"J. Cole - MIDDLE CHILD", 289234890},
        {"21 Savage - a lot", 7178216789}, {"Future - Mask Off", 289235012},
        {"Migos - Bad and Boujee", 6568293456}, {"Lil Uzi Vert - XO Tour Llif3", 7178217890},
        
        {header = "BHOJPURI"},
        {"Lamba Lamba Ghughat", 78431826650714}, {"Balam Ke Pichkari", 89700384406008}, {"Moh Lelo", 95909411418420},
        {"Sunny Dancer", 133421259018974}, {"TakTaki Bhojpuri", 78735782383680}, {"Ladki Deewani", 102511873453786},
        {"Bansuri", 79568658897083}, {"Sejiya Pe Piya", 87577798625777}, {"Nimbu Kharbuja", 87577798625777},
        {"Sadi Ladki", 104574653065736}, {"Dar Lage", 128470232274219}, {"Hamra Mard", 131679833636653},
        {"Video Calling", 126309103230345}, {"Sadiya Karoya", 140415804746906}, {"Ghaghri", 124233673176294},
        {"TakaTaki", 117615820552185}, {"Kunj Bihari", 108588298945210},
        {"Lollypop Lagelu", 1834567890}, {"Pawan Singh - Chhalakata", 2945678901}, {"Khesari Lal - Dulha", 3056789012},
        {"Ritesh Pandey - Hello Koun", 4167890123}, {"Shilpi Raj - Kamar Dab", 5278901234}, {"Aamrapali Dubey - Patna Se", 6389012345},
        {"Antra Singh - Sarkar", 7490123456}, {"Neelkamal - Jila Top", 8501234567}, {"Chinta Devi - Saiyan", 9612345678},
        {"Gunjan Singh - Dewar", 10723456789},
        
        {header = "SOUNDS"},
        {"UwU", 105577043687038}, {"Senpai", 115498703521334}, {"Kiss", 118235447189969},
        {"Anime Ahh", 119651952208423}, {"Ah", 121259252258118}, {"18+ Girl", 131014261385625},
        {"Girl Evil Laugh", 134548905274433}, {"Tom", 139694892021582}, {"Slayy", 139740597178232},
        {"Scary", 140028279221307}, {"Kitisan", 122462786517802}, {"Flash", 123459967526974},
        {"The Hand erase", 132573001115155}, {"Aishiteru", 132952117418468}, {"Msg Y'all", 134489447055645},
        {"Goofy Horn", 136188985418657}, {"Faaahhhhh", 139999225792687}, {"Shidouuu", 89016013924693},
        {"Jumpscare", 6201427049}, {"Desi Gun", 3177712713}, {"Laughing", 4767799547},
        {"CID", 105096889615032}, {"Muthhal Baj", 87111140463459}, {"Nya Zo", 8842446965},
        {"Chicken Sound", 117909139728666}, {"Ladle Ghop", 88622194255425}, {"MadarChod", 126782260874451},
        {"Yamate Kudasajj", 18990591883}, {"Monkey", 7196237097}, {"Ahhhhh", 169664410},
        {"PunjabiMeme", 123161971384069}, {"Sound 1", 77446238713316}, {"Sound 2", 4575953237},
        {"Popopo", 108896377576102}, {"SariRoti", 9075261161},
        {"Vine Boom", 2614753599}, {"Bruh Sound Effect", 4567890123}, {"Fart Sound", 5678901234},
        {"Screaming", 6789012345}, {"Anime Wow", 7890123456}, {"Sad Violin", 8901234567},
        {"Taco Bell", 9012345678}, {"Roblox Death Sound", 1223456789}, {"Mario Jump", 2334567890},
        {"Among Us Emergency", 3445678901},
    }

    for _, item in ipairs(MasterList) do
        if item.header then
            CreateCategoryHeader(item.header)
        else
            CreateSongEntry(item[1], item[2])
        end
    end
    
    ScrollList.CanvasSize = UDim2.new(0, 0, 0, #MasterList * 29)
end

-- props like bpass
local activeMode = "None" 
local engineLoopActive = false
local currentVis = "Orbital"

local function getMyProps()
    local props = {}
    local wsCom = Workspace:FindFirstChild("WorkspaceCom")
    if wsCom then
        for _, item in pairs(wsCom:GetDescendants()) do
            if item:IsA("Model") and item.Name == "Prop" .. LocalPlayer.Name then
                if item:FindFirstChild("SetCurrentCFrame") then
                    table.insert(props, item)
                end
            end
        end
    end
    return props
end

local function getTargetRoot(targetName)
    if targetName == "Self" then
        return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    else
        local p = Players:FindFirstChild(targetName)
        if p and p.Character then
            return p.Character:FindFirstChild("HumanoidRootPart")
        end
    end
    return nil
end

local function stopPropEngine()
    activeMode = "None"
    engineLoopActive = false
end

local function startPropEngine(mode, targetName, visType)
    stopPropEngine()
    task.wait(0.1) 
    
    activeMode = mode
    engineLoopActive = true
    
    task.spawn(function()
        while engineLoopActive do
            local root = getTargetRoot(targetName)
            local props = getMyProps()
            
            if root and #props > 0 then
                local t = tick()
                
                for i, prop in ipairs(props) do
                    task.spawn(function()
                        local baseCFrame = root.CFrame
                        local finalCFrame = baseCFrame
                        local color = Color3.fromHSV((t * 0.5 + (i/#props)) % 1, 1, 1) 
                        
                        if activeMode == "Nuke" then
                            finalCFrame = baseCFrame * CFrame.new(math.random(-2,2), math.random(0,3), math.random(-2,2)) 
                                * CFrame.Angles(math.random(), math.random(), math.random())
                        
                        elseif activeMode == "Visualizer" then
                            if visType == "Orbital" then
                                local angle = (t * 3) + ((i / #props) * math.pi * 2)
                                finalCFrame = baseCFrame * CFrame.new(math.cos(angle) * 6, 0, math.sin(angle) * 6)
                            elseif visType == "Tornado" then
                                local angle = (t * 5) + ((i / #props) * math.pi * 2)
                                local heightOffset = (i / #props) * 12
                                local radius = 2 + (i / #props) * 5
                                finalCFrame = baseCFrame * CFrame.new(math.cos(angle) * radius, heightOffset - 4, math.sin(angle) * radius)
                            elseif visType == "Swarm" then
                                local offsetX = math.noise(t, i, 0) * 8
                                local offsetY = math.noise(t, 0, i) * 6
                                local offsetZ = math.noise(0, t, i) * 8
                                finalCFrame = baseCFrame * CFrame.new(offsetX, offsetY + 2, offsetZ)
                            elseif visType == "Grid" then
                                local spacing = 5
                                local cols = math.ceil(math.sqrt(#props))
                                local row = math.floor((i-1) / cols)
                                local col = (i-1) % cols
                                finalCFrame = baseCFrame * CFrame.new((col - cols/2)*spacing, 0, (row - cols/2)*spacing)
                            end
                        end
                        
                        pcall(function()
                            prop.SetCurrentCFrame:InvokeServer(finalCFrame)
                            if prop:FindFirstChild("ChangePropColor") then
                                prop.ChangePropColor:InvokeServer(color)
                            end
                        end)
                    end)
                end
            end
            task.wait(0.08) 
        end
    end)
end

-- props gui
local function buildPropsUI(parentFrame)
    local Warning = Instance.new("TextLabel")
    Warning.Size = UDim2.new(1, 0, 0, 28)
    Warning.Position = UDim2.new(0, 0, 0, 0)
    Warning.BackgroundTransparency = 1
    Warning.Text = "⚠️ Place all props manually before executing! ⚠️"
    Warning.TextColor3 = Color3.fromRGB(255, 60, 60)
    Warning.Font = Enum.Font.GothamBold
    Warning.TextSize = 9
    Warning.TextWrapped = true
    Warning.ZIndex = 4
    Warning.Parent = parentFrame

    local currentTarget = "Self"
    local TargetBtn = Instance.new("TextButton")
    TargetBtn.Size = UDim2.new(1, 0, 0, 22)
    TargetBtn.Position = UDim2.new(0, 0, 0, 32)
    TargetBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TargetBtn.Text = "Target: Self ▼"
    TargetBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
    TargetBtn.Font = Enum.Font.Gotham
    TargetBtn.TextSize = 11
    TargetBtn.ZIndex = 4
    TargetBtn.Parent = parentFrame
    Instance.new("UICorner", TargetBtn).CornerRadius = UDim.new(0, 4)
    applyClickAnimation(TargetBtn)

    local TargetScroll = Instance.new("ScrollingFrame")
    TargetScroll.Size = UDim2.new(1, 0, 0, 80)
    TargetScroll.Position = UDim2.new(0, 0, 0, 56)
    TargetScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    TargetScroll.BorderSizePixel = 0
    TargetScroll.ZIndex = 15 
    TargetScroll.Visible = false
    TargetScroll.ScrollBarThickness = 3
    TargetScroll.Parent = parentFrame
    
    local TargetLayout = Instance.new("UIListLayout")
    TargetLayout.SortOrder = Enum.SortOrder.Name
    TargetLayout.Parent = TargetScroll

    local VisScroll = Instance.new("ScrollingFrame")
    
    local function refreshPlayers()
        for _, child in pairs(TargetScroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        
        local function addPlayerOpt(name)
            local Opt = Instance.new("TextButton")
            Opt.Size = UDim2.new(1, 0, 0, 18)
            Opt.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Opt.Text = " " .. name
            Opt.TextColor3 = Color3.fromRGB(255, 255, 255)
            Opt.Font = Enum.Font.Gotham
            Opt.TextSize = 10
            Opt.TextXAlignment = Enum.TextXAlignment.Left
            Opt.ZIndex = 16
            Opt.Parent = TargetScroll
            
            Opt.MouseButton1Click:Connect(function()
                currentTarget = name
                TargetBtn.Text = "Target: " .. name .. " ▼"
                TargetScroll.Visible = false
                if activeMode ~= "None" then
                    startPropEngine(activeMode, currentTarget, currentVis)
                end
            end)
        end

        addPlayerOpt("Self")
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then addPlayerOpt(p.Name) end
        end
        TargetScroll.CanvasSize = UDim2.new(0, 0, 0, TargetLayout.AbsoluteContentSize.Y)
    end
    
    refreshPlayers()
    Players.PlayerAdded:Connect(refreshPlayers)
    Players.PlayerRemoving:Connect(refreshPlayers)

    TargetBtn.MouseButton1Click:Connect(function()
        TargetScroll.Visible = not TargetScroll.Visible
        VisScroll.Visible = false 
    end)

    local NukeBtn = Instance.new("TextButton")
    NukeBtn.Size = UDim2.new(1, 0, 0, 22)
    NukeBtn.Position = UDim2.new(0, 0, 0, 59)
    NukeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 50)
    NukeBtn.Text = "NUKE PROPS"
    NukeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    NukeBtn.Font = Enum.Font.GothamBold
    NukeBtn.TextSize = 11
    NukeBtn.ZIndex = 4
    NukeBtn.Parent = parentFrame
    Instance.new("UICorner", NukeBtn).CornerRadius = UDim.new(0, 4)
    applyClickAnimation(NukeBtn)
    
    local VisBtn = Instance.new("TextButton")
    VisBtn.Size = UDim2.new(0.65, 0, 0, 22)
    VisBtn.Position = UDim2.new(0, 0, 0, 86)
    VisBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    VisBtn.Text = "Visualizer: Orbital ▼"
    VisBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
    VisBtn.Font = Enum.Font.Gotham
    VisBtn.TextSize = 10
    VisBtn.ZIndex = 4
    VisBtn.Parent = parentFrame
    Instance.new("UICorner", VisBtn).CornerRadius = UDim.new(0, 4)
    applyClickAnimation(VisBtn)

    local VisToggleBtn = Instance.new("TextButton")
    VisToggleBtn.Size = UDim2.new(0.32, 0, 0, 22)
    VisToggleBtn.Position = UDim2.new(0.68, 0, 0, 86)
    VisToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    VisToggleBtn.Text = "START"
    VisToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    VisToggleBtn.Font = Enum.Font.GothamBold
    VisToggleBtn.TextSize = 10
    VisToggleBtn.ZIndex = 4
    VisToggleBtn.Parent = parentFrame
    Instance.new("UICorner", VisToggleBtn).CornerRadius = UDim.new(0, 4)
    applyClickAnimation(VisToggleBtn)

    NukeBtn.MouseButton1Click:Connect(function()
        if activeMode == "Nuke" then
            stopPropEngine()
            NukeBtn.Text = "NUKE PROPS"
            NukeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 50)
        else
            startPropEngine("Nuke", currentTarget, currentVis)
            NukeBtn.Text = "STOP NUKE"
            NukeBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
            VisToggleBtn.Text = "START"
            VisToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        end
    end)

    VisToggleBtn.MouseButton1Click:Connect(function()
        if activeMode == "Visualizer" then
            stopPropEngine()
            VisToggleBtn.Text = "START"
            VisToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        else
            startPropEngine("Visualizer", currentTarget, currentVis)
            VisToggleBtn.Text = "STOP"
            VisToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            NukeBtn.Text = "NUKE PROPS"
            NukeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 50)
        end
    end)

    VisScroll.Size = UDim2.new(0.65, 0, 0, 60)
    VisScroll.Position = UDim2.new(0, 0, 0, 110)
    VisScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    VisScroll.BorderSizePixel = 0
    VisScroll.ZIndex = 15
    VisScroll.Visible = false
    VisScroll.ScrollBarThickness = 3
    VisScroll.Parent = parentFrame
    
    local VisLayout = Instance.new("UIListLayout")
    VisLayout.SortOrder = Enum.SortOrder.LayoutOrder
    VisLayout.Parent = VisScroll

    local visOptions = {"Orbital", "Swarm", "Tornado", "Grid"}
    for _, opt in ipairs(visOptions) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 18)
        OptBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        OptBtn.Text = " " .. opt
        OptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptBtn.Font = Enum.Font.Gotham
        OptBtn.TextSize = 10
        OptBtn.TextXAlignment = Enum.TextXAlignment.Left
        OptBtn.ZIndex = 16
        OptBtn.Parent = VisScroll
        
        OptBtn.MouseButton1Click:Connect(function()
            currentVis = opt
            VisBtn.Text = "Visualizer: " .. opt .. " ▼"
            VisScroll.Visible = false
            if activeMode == "Visualizer" then startPropEngine("Visualizer", currentTarget, currentVis) end
        end)
    end
    VisScroll.CanvasSize = UDim2.new(0, 0, 0, #visOptions * 18)

    VisBtn.MouseButton1Click:Connect(function()
        VisScroll.Visible = not VisScroll.Visible
        TargetScroll.Visible = false 
    end)
end

-- protect engine (yeah bro)
local ProtectionStates = {
    AntiSit = false,
    Noclip = false,
    SuperNoclip = false,
    AntiFling = false,
    Freeze = false
}

local Cons = {}

local function toggleProtection(feature, state)
    ProtectionStates[feature] = state
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if Cons[feature] then
        Cons[feature]:Disconnect()
        Cons[feature] = nil
    end

    if feature == "AntiSit" then
        if state then
            if hum and hum.Sit then hum.Sit = false end
            Cons.AntiSit = RunService.Stepped:Connect(function()
                local c = LocalPlayer.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h and h.Sit then h.Sit = false end
            end)
        end

    elseif feature == "Noclip" then
        if state then
            Cons.Noclip = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide then
                            if not string.find(v.Name:lower(), "leg") and not string.find(v.Name:lower(), "foot") then
                                v.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end

    elseif feature == "SuperNoclip" then
        if state then
            Cons.SuperNoclip = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        end

    elseif feature == "AntiFling" then
        if state then
            Cons.AntiFling = RunService.Stepped:Connect(function()
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        for _, v in pairs(p.Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end
                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    if myRoot.Velocity.Magnitude > 250 or myRoot.RotVelocity.Magnitude > 250 then
                        myRoot.Velocity = Vector3.new(0, 0, 0)
                        myRoot.RotVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end

    elseif feature == "Freeze" then
        if root then root.Anchored = state end
        if state then
            Cons.Freeze = LocalPlayer.CharacterAdded:Connect(function(newChar)
                local newRoot = newChar:WaitForChild("HumanoidRootPart", 5)
                if newRoot then newRoot.Anchored = true end
            end)
        end
    end
end

-- protect gui
local function buildProtectionUI(parentFrame)
    local ScrollList = Instance.new("ScrollingFrame")
    ScrollList.Size = UDim2.new(1, 0, 1, -10)
    ScrollList.Position = UDim2.new(0, 0, 0, 5)
    ScrollList.BackgroundTransparency = 1
    ScrollList.BorderSizePixel = 0
    ScrollList.ScrollBarThickness = 3
    ScrollList.ZIndex = 4
    ScrollList.Parent = parentFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 6)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = ScrollList

    local function createToggleUI(name, featureKey)
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, -5, 0, 28)
        Container.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        Container.ZIndex = 4
        Container.Parent = ScrollList
        Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.6, 0, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(220, 220, 230)
        Label.Font = Enum.Font.GothamSemibold
        Label.TextSize = 11
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.ZIndex = 5
        Label.Parent = Container

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(0, 45, 0, 18)
        ToggleBtn.Position = UDim2.new(1, -55, 0.5, -9)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        ToggleBtn.Text = "OFF"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleBtn.Font = Enum.Font.GothamBold
        ToggleBtn.TextSize = 10
        ToggleBtn.ZIndex = 5
        ToggleBtn.Parent = Container
        Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 4)
        applyClickAnimation(ToggleBtn)

        ToggleBtn.MouseButton1Click:Connect(function()
            local newState = not ProtectionStates[featureKey]
            toggleProtection(featureKey, newState)
            if newState then
                TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 180, 80)}):Play()
                ToggleBtn.Text = "ON"
            else
                TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
                ToggleBtn.Text = "OFF"
            end
        end)
    end

    createToggleUI("Anti-Sit", "AntiSit")
    createToggleUI("Anti-Fling", "AntiFling")
    createToggleUI("Noclip", "Noclip")
    createToggleUI("Super Noclip", "SuperNoclip")
    createToggleUI("Freeze Self", "Freeze")

    ScrollList.CanvasSize = UDim2.new(0, 0, 0, 5 * 34)
end

-- credits
local function buildCreditsUI(parentFrame)
    local MainText = Instance.new("TextLabel")
    MainText.Size = UDim2.new(1, -20, 0, 60)
    MainText.Position = UDim2.new(0, 10, 0.5, -40)
    MainText.BackgroundTransparency = 1
    MainText.Text = "found by MindyLoozy\nDeveloped By ChatGPT + Claude👅"
    MainText.TextColor3 = Color3.fromRGB(50, 255, 100)
    MainText.Font = Enum.Font.GothamBold
    MainText.TextSize = 13
    MainText.TextWrapped = true
    MainText.ZIndex = 4
    MainText.Parent = parentFrame
end

-- inject
createAdvancedSubTabs(SpammerPage, {
    {name = "Custom", isRoast = false, buildFunc = buildSpamUI},
    {name = "Roast", isRoast = true, buildFunc = buildSpamUI}
})
createAdvancedSubTabs(MusicPage, {
    {name = "Player", isRoast = false, buildFunc = buildMusicPlayerUI},
    {name = "Playlist", isRoast = false, buildFunc = buildMusicIDsUI}
})
buildPropsUI(PropsPage)
buildProtectionUI(ProtectionPage)
buildCreditsUI(CreditsPage)
