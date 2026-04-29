-- cracked key system 
loadstring('function LPH_NO_VIRTUALIZE(f) return f end;\n')()
local cloneRef = cloneref or function(obj) return obj end
local TweenService      = cloneRef(game:GetService('TweenService'))
local UserInputService  = cloneRef(game:GetService('UserInputService'))
local Players           = cloneRef(game:GetService('Players'))
local CoreGui           = cloneRef(game:GetService('CoreGui'))
local setClipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
local getEnv       = getgenv or function() return shared end
local discordInvite  = 'discord.gg/luminhub'
local keyUrl         = 'https://luminon.top/getkey'
local sdk            = loadstring(game:HttpGet('https://sdkapi-public.luarmor.net/library.lua'))()
local gameKeyMapping = {
    [8316902627] = '4d7df29859ef379950f122bf3fea94ab',
    [7671049560] = '6f9e8a4664c53863bafc2e0c13e69e47',
    [7436755782] = '7bf1f03799aa9d3196c456d9aeaa110b',
    [7709344486] = '76188791d560b8c6c0b7c105b04dd68b',
    [7750955984] = 'fca0388338f00cccce61c6a475c750f8',
    [9266873836] = 'aaf50c436feb7aaf18162f8ec557c3e5',
    [9363735110] = 'eaf4ce2555854d313325d85b8261f851',
    [6035872082] = 'b998b1e96517e83bd304425337d38e2b',
    [9344307274] = 'ce85ccc31a76cc59e91bf8856bb5b008',
    [9570888371] = 'f6c00892c741e2b9ffd3395997b76c8b',
    [9649298941] = 'fa2592e7a31d24bd23204fc999172cc5',
    [9679625425] = '9dfd4278428457b5e30b838549f53010',
    [9509842868] = 'a276fa539188a61718431eeb505435f3',
    [9186719164] = '03d177b251c89ee11c9b6b0e0c435294',
}
local fallbackKey = 'ed58a7c08024fcb2909098cc898418c1'
local scriptId    = gameKeyMapping[game.GameId] or fallbackKey
local keyFileName = 'LuminHub_Key.txt'
local function getSavedKey()
    if not isfile then return nil end
    local success, content = pcall(function()
        if isfile(keyFileName) then return readfile(keyFileName) end
        return nil
    end)
    if success and content and #content > 5 then return content end
    return nil
end
local function saveKey(key)
    if not writefile then return end
    pcall(function() writefile(keyFileName, key) end)
end
local function deleteSavedKey()
    if not delfile then return end
    pcall(function()
        if isfile and isfile(keyFileName) then delfile(keyFileName) end
    end)
end
local function tryAutoAuth()
    return false
end
if tryAutoAuth() then return end
local function randomName(length)
    length = length or 12
    local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local name  = ''
    for _ = 1, length do
        local pos = math.random(1, #chars)
        name = name .. chars:sub(pos, pos)
    end
    return name
end
local logoAssetName = 'A7.png'
local logoImage = nil
if writefile and isfile and getcustomasset then
    pcall(function()
        if not isfile(logoAssetName) then
            writefile(logoAssetName, game:HttpGet('http://luminon.top/A7.png'))
        end
        logoImage = getcustomasset(logoAssetName)
    end)
end
local screenGui = Instance.new('ScreenGui')
screenGui.Name           = randomName(16)
if protect_gui then protect_gui(screenGui) end
screenGui.Parent         = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn   = false
local mainFrame = Instance.new('Frame')
mainFrame.Name               = randomName(12)
mainFrame.Parent             = screenGui
mainFrame.AnchorPoint        = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3   = Color3.fromRGB(16, 16, 22)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Position           = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size               = UDim2.new(0, 400, 0, 240)
Instance.new('UICorner', mainFrame).CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new('UIStroke')
mainStroke.Color        = Color3.fromRGB(70, 50, 120)
mainStroke.Thickness    = 1.5
mainStroke.Transparency = 0.5
mainStroke.Parent       = mainFrame
local backgroundDecor = Instance.new('Frame')
backgroundDecor.Name                 = randomName(8)
backgroundDecor.Parent               = mainFrame
backgroundDecor.BackgroundTransparency = 1
backgroundDecor.Size                 = UDim2.new(1, 0, 1, 0)
backgroundDecor.ZIndex               = 0
for i = 1, 3 do
    local decorFrame = Instance.new('Frame')
    decorFrame.Name               = randomName(6)
    decorFrame.Parent             = backgroundDecor
    decorFrame.AnchorPoint        = Vector2.new(0.5, 0.5)
    decorFrame.BackgroundColor3   = Color3.fromRGB(0, 0, 0)
    decorFrame.BackgroundTransparency = 0.88 + (i * 0.03)
    decorFrame.Position           = UDim2.new(0.5, 0, 0.5, i * 2)
    decorFrame.Size               = UDim2.new(1, i * 4, 1, i * 4)
    decorFrame.ZIndex             = 0
    Instance.new('UICorner', decorFrame).CornerRadius = UDim.new(0, 12 + i)
end
local logo = Instance.new('ImageLabel')
logo.Name                   = randomName(8)
logo.Parent                 = mainFrame
logo.BackgroundTransparency = 1
logo.Position               = UDim2.new(0, 18, 0, 11)
logo.Size                   = UDim2.new(0, 32, 0, 32)
logo.Image                  = logoImage or ''
logo.ScaleType              = Enum.ScaleType.Fit
local titleLabel = Instance.new('TextLabel')
titleLabel.Name                   = randomName(8)
titleLabel.Parent                 = mainFrame
titleLabel.BackgroundTransparency = 1
titleLabel.Position               = UDim2.new(0, 56, 0, 14)
titleLabel.Size                   = UDim2.new(0, 200, 0, 26)
titleLabel.Font                   = Enum.Font.GothamBlack
titleLabel.Text                   = 'Lumin Hub'
titleLabel.TextColor3             = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize               = 20
titleLabel.TextXAlignment         = Enum.TextXAlignment.Left
local closeButton = Instance.new('TextButton')
closeButton.Name                   = randomName(8)
closeButton.Parent                 = mainFrame
closeButton.BackgroundTransparency = 1
closeButton.Position               = UDim2.new(1, -32, 0, 10)
closeButton.Size                   = UDim2.new(0, 20, 0, 20)
closeButton.Font                   = Enum.Font.GothamBold
closeButton.Text                   = 'X'
closeButton.TextColor3             = Color3.fromRGB(120, 120, 140)
closeButton.TextSize               = 14
closeButton.AutoButtonColor        = false
local infoLabel = Instance.new('TextLabel')
infoLabel.Name                   = randomName(8)
infoLabel.Parent                 = mainFrame
infoLabel.BackgroundTransparency = 1
infoLabel.Position               = UDim2.new(0, 20, 0, 48)
infoLabel.Size                   = UDim2.new(1, -40, 0, 26)
infoLabel.Font                   = Enum.Font.Gotham
infoLabel.Text                   = 'Having trouble getting a key or checking your key?\nJoin our Discord server for assistance!'
infoLabel.TextColor3             = Color3.fromRGB(120, 120, 140)
infoLabel.TextSize               = 11
infoLabel.TextWrapped            = true
infoLabel.TextXAlignment         = Enum.TextXAlignment.Left
infoLabel.TextYAlignment         = Enum.TextYAlignment.Top
infoLabel.LineHeight             = 1.2
local keyInputFrame = Instance.new('Frame')
keyInputFrame.Name               = randomName(8)
keyInputFrame.Parent             = mainFrame
keyInputFrame.BackgroundColor3   = Color3.fromRGB(26, 26, 34)
keyInputFrame.Position           = UDim2.new(0, 20, 0, 76)
keyInputFrame.Size               = UDim2.new(1, -40, 0, 38)
Instance.new('UICorner', keyInputFrame).CornerRadius = UDim.new(0, 8)
local keyInputStroke = Instance.new('UIStroke')
keyInputStroke.Color  = Color3.fromRGB(50, 50, 65)
keyInputStroke.Parent = keyInputFrame
local keyTextBox = Instance.new('TextBox')
keyTextBox.Name                   = randomName(8)
keyTextBox.Parent                 = keyInputFrame
keyTextBox.BackgroundTransparency = 1
keyTextBox.Position               = UDim2.new(0, 12, 0, 0)
keyTextBox.Size                   = UDim2.new(1, -24, 1, 0)
keyTextBox.Font                   = Enum.Font.Gotham
keyTextBox.PlaceholderColor3      = Color3.fromRGB(85, 85, 105)
keyTextBox.PlaceholderText        = 'Enter your key here...'
keyTextBox.Text                   = ''
keyTextBox.TextColor3             = Color3.fromRGB(255, 255, 255)
keyTextBox.TextSize               = 13
keyTextBox.TextXAlignment         = Enum.TextXAlignment.Left
local checkButton = Instance.new('TextButton')
checkButton.Name                   = randomName(8)
checkButton.Parent                 = mainFrame
checkButton.BackgroundColor3       = Color3.fromRGB(80, 60, 140)
checkButton.BackgroundTransparency = 0.4
checkButton.Position               = UDim2.new(0, 20, 0, 122)
checkButton.Size                   = UDim2.new(1, -40, 0, 36)
checkButton.Font                   = Enum.Font.GothamBold
checkButton.Text                   = 'Check Key'
checkButton.TextColor3             = Color3.fromRGB(255, 255, 255)
checkButton.TextSize               = 13
checkButton.AutoButtonColor        = false
Instance.new('UICorner', checkButton).CornerRadius = UDim.new(0, 8)
local checkButtonStroke = Instance.new('UIStroke')
checkButtonStroke.Color        = Color3.fromRGB(140, 100, 220)
checkButtonStroke.Transparency = 0.3
checkButtonStroke.Parent       = checkButton
local statusLabel = Instance.new('TextLabel')
statusLabel.Name                   = randomName(8)
statusLabel.Parent                 = mainFrame
statusLabel.BackgroundTransparency = 1
statusLabel.Position               = UDim2.new(0, 0, 0, 160)
statusLabel.Size                   = UDim2.new(1, 0, 0, 14)
statusLabel.Font                   = Enum.Font.GothamMedium
statusLabel.Text                   = ''
statusLabel.TextColor3             = Color3.fromRGB(255, 100, 100)
statusLabel.TextSize               = 10
local supportButton = Instance.new('TextButton')
supportButton.Name                   = randomName(8)
supportButton.Parent                 = mainFrame
supportButton.BackgroundColor3       = Color3.fromRGB(80, 60, 140)
supportButton.BackgroundTransparency = 0.4
supportButton.Position               = UDim2.new(0, 20, 0, 178)
supportButton.Size                   = UDim2.new(0.5, -24, 0, 36)
supportButton.Font                   = Enum.Font.GothamBold
supportButton.Text                   = 'Support'
supportButton.TextColor3             = Color3.fromRGB(255, 255, 255)
supportButton.TextSize               = 12
supportButton.AutoButtonColor        = false
Instance.new('UICorner', supportButton).CornerRadius = UDim.new(0, 8)
local supportButtonStroke = Instance.new('UIStroke')
supportButtonStroke.Color        = Color3.fromRGB(140, 100, 220)
supportButtonStroke.Transparency = 0.3
supportButtonStroke.Parent       = supportButton
local getKeyButton = Instance.new('TextButton')
getKeyButton.Name                   = randomName(8)
getKeyButton.Parent                 = mainFrame
getKeyButton.BackgroundColor3       = Color3.fromRGB(80, 60, 140)
getKeyButton.BackgroundTransparency = 0.4
getKeyButton.Position               = UDim2.new(0.5, 4, 0, 178)
getKeyButton.Size                   = UDim2.new(0.5, -24, 0, 36)
getKeyButton.Font                   = Enum.Font.GothamBold
getKeyButton.Text                   = 'Get Key'
getKeyButton.TextColor3             = Color3.fromRGB(255, 255, 255)
getKeyButton.TextSize               = 12
getKeyButton.AutoButtonColor        = false
Instance.new('UICorner', getKeyButton).CornerRadius = UDim.new(0, 8)
local getKeyButtonStroke = Instance.new('UIStroke')
getKeyButtonStroke.Color        = Color3.fromRGB(140, 100, 220)
getKeyButtonStroke.Transparency = 0.3
getKeyButtonStroke.Parent       = getKeyButton
local function tween(object, properties, duration)
    TweenService:Create(
        object,
        TweenInfo.new(duration or 0.15, Enum.EasingStyle.Quad),
        properties
    ):Play()
end
local isDragging = false
local dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart  = input.Position
        startPos   = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end)
mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and isDragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
closeButton.MouseEnter:Connect(function()
    tween(closeButton, {TextColor3 = Color3.fromRGB(255, 70, 70)})
end)
closeButton.MouseLeave:Connect(function()
    tween(closeButton, {TextColor3 = Color3.fromRGB(120, 120, 140)})
end)
checkButton.MouseEnter:Connect(function()
    tween(checkButton, {BackgroundTransparency = 0.2})
    tween(checkButtonStroke, {Transparency = 0})
end)
checkButton.MouseLeave:Connect(function()
    tween(checkButton, {BackgroundTransparency = 0.4})
    tween(checkButtonStroke, {Transparency = 0.3})
end)
supportButton.MouseEnter:Connect(function()
    tween(supportButton, {BackgroundTransparency = 0.2})
    tween(supportButtonStroke, {Transparency = 0})
end)
supportButton.MouseLeave:Connect(function()
    tween(supportButton, {BackgroundTransparency = 0.4})
    tween(supportButtonStroke, {Transparency = 0.3})
end)
getKeyButton.MouseEnter:Connect(function()
    tween(getKeyButton, {BackgroundTransparency = 0.2})
    tween(getKeyButtonStroke, {Transparency = 0})
end)
getKeyButton.MouseLeave:Connect(function()
    tween(getKeyButton, {BackgroundTransparency = 0.4})
    tween(getKeyButtonStroke, {Transparency = 0.3})
end)
keyTextBox.Focused:Connect(function()
    tween(keyInputStroke, {Color = Color3.fromRGB(139, 92, 246)})
    tween(keyInputFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 42)})
end)
keyTextBox.FocusLost:Connect(function()
    tween(keyInputStroke, {Color = Color3.fromRGB(50, 50, 65)})
    tween(keyInputFrame, {BackgroundColor3 = Color3.fromRGB(26, 26, 34)})
end)
closeButton.MouseButton1Click:Connect(function()
    tween(mainFrame, {
        Size                   = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }, 0.2)
    task.wait(0.2)
    screenGui:Destroy()
end)
supportButton.MouseButton1Click:Connect(function()
    if setClipboard then setClipboard('https://' .. discordInvite) end
    statusLabel.TextColor3 = Color3.fromRGB(87, 242, 135)
    statusLabel.Text       = 'Discord link copied!'
    task.delay(2, function() statusLabel.Text = '' end)
end)
getKeyButton.MouseButton1Click:Connect(function()
    if setClipboard then setClipboard(keyUrl) end
    statusLabel.TextColor3 = Color3.fromRGB(87, 242, 135)
    statusLabel.Text       = 'Key link copied!'
    task.delay(2, function() statusLabel.Text = '' end)
end)

-- ===================== КРЯК КЕЙ СИСТЕМЫ (ЖОСКО) =====================
checkButton.MouseButton1Click:Connect(function()
    local enteredKey = keyTextBox.Text
    if enteredKey == '' then
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        statusLabel.Text       = 'Please enter a key!'
        return
    end

    statusLabel.TextColor3 = Color3.fromRGB(87, 242, 135)
    statusLabel.Text       = 'Key valid! Loading script...'

    -- 1. script_id для библиотеки
    sdk.script_id = scriptId

    -- 2. Сохраняем ключ во все возможные глобальные переменные, чтобы основной скрипт нашёл
    local fakeKey = enteredKey
    getEnv().script_key = fakeKey
    _G.script_key = fakeKey
    shared.script_key = fakeKey
    _G['%USER_KEY%'] = fakeKey
    _G.LuarmorKey = fakeKey
    _G.luarmor_key = fakeKey

    -- 3. Сохраняем в файл, на всякий случай
    saveKey(fakeKey)

    -- 4. Подменяем саму функцию проверки, чтобы load_script не брыкался
    sdk.check_key = function()
        return { code = 'KEY_VALID' }
    end

    -- 5. Закрываем меню и запускаем основной скрипт
    task.wait(0.5)
    tween(mainFrame, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }, 0.2)
    task.wait(0.2)
    screenGui:Destroy()
    sdk.load_script()
end)

-- Анимация появления окна
mainFrame.Size                   = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1
tween(mainFrame, {
    Size                   = UDim2.new(0, 400, 0, 240),
    BackgroundTransparency = 0.05
}, 0.3)
