-- cracked by Mindyloozy - https://github.com/MindyLozy
-- enjoy! :)
--[[
                                                                                                                          
                                                                    dddddddd                                              
MMMMMMMM               MMMMMMMM  iiii                               d::::::d                      LLLLLLLLLLL             
M:::::::M             M:::::::M i::::i                              d::::::d                      L:::::::::L             
M::::::::M           M::::::::M  iiii                               d::::::d                      L:::::::::L             
M:::::::::M         M:::::::::M                                     d:::::d                       LL:::::::LL             
M::::::::::M       M::::::::::Miiiiiiinnnn  nnnnnnnn        ddddddddd:::::dyyyyyyy           yyyyyyyL:::::L               
M:::::::::::M     M:::::::::::Mi:::::in:::nn::::::::nn    dd::::::::::::::d y:::::y         y:::::y L:::::L               
M:::::::M::::M   M::::M:::::::M i::::in::::::::::::::nn  d::::::::::::::::d  y:::::y       y:::::y  L:::::L               
M::::::M M::::M M::::M M::::::M i::::inn:::::::::::::::nd:::::::ddddd:::::d   y:::::y     y:::::y   L:::::L               
M::::::M  M::::M::::M  M::::::M i::::i  n:::::nnnn:::::nd::::::d    d:::::d    y:::::y   y:::::y    L:::::L               
M::::::M   M:::::::M   M::::::M i::::i  n::::n    n::::nd:::::d     d:::::d     y:::::y y:::::y     L:::::L               
M::::::M    M:::::M    M::::::M i::::i  n::::n    n::::nd:::::d     d:::::d      y:::::y:::::y      L:::::L               
M::::::M     MMMMM     M::::::M i::::i  n::::n    n::::nd:::::d     d:::::d       y:::::::::y       L:::::L         LLLLLL
M::::::M               M::::::Mi::::::i n::::n    n::::nd::::::ddddd::::::dd       y:::::::y      LL:::::::LLLLLLLLL:::::L
M::::::M               M::::::Mi::::::i n::::n    n::::n d:::::::::::::::::d        y:::::y       L::::::::::::::::::::::L
M::::::M               M::::::Mi::::::i n::::n    n::::n  d:::::::::ddd::::d       y:::::y        L::::::::::::::::::::::L
MMMMMMMM               MMMMMMMMiiiiiiii nnnnnn    nnnnnn   ddddddddd   ddddd      y:::::y         LLLLLLLLLLLLLLLLLLLLLLLL
                                                                                 y:::::y                                  
                                                                                y:::::y                                   
                                                                               y:::::y                                    
                                                                              y:::::y                                     
                                                                             yyyyyyy                                      
                                                                                                                          
                                                                                                                          
--]]


local genv = getgenv()
local fenv = getfenv()

game:IsLoaded()

local _call5 = game:GetService('Players')

game:GetService('RunService')

local _call9 = game:GetService('TweenService')
local _call11 = game:GetService('UserInputService')

game:GetService('ReplicatedStorage')
game:GetService('SoundService')

local _ = game:GetService('Workspace').CurrentCamera
local _LocalPlayer19 = _call5.LocalPlayer
local _ = genv.KurbyRunning

genv.KurbyRunning = true

local _call22 = game:GetService('HttpService')
local _ = _call11.TouchEnabled
local _ = _call11.KeyboardEnabled
local _ = _call11.GamepadEnabled
local _ = _call11.KeyboardEnabled
local _call34 = game:GetService('MarketplaceService')
local _call40 = _call22:JSONEncode({
    embeds = {
        [1] = {
            fields = {
                [1] = {
                    value = _LocalPlayer19.Name,
                    name = '**Username**',
                    inline = true,
                },
                [2] = {
                    value = tostring(_LocalPlayer19.UserId),
                    name = '**User ID**',
                    inline = true,
                },
                [3] = {
                    value = 'PC',
                    name = '**Platform**',
                    inline = true,
                },
                [4] = {
                    value = tostring(game.PlaceId),
                    name = '**Place ID**',
                    inline = false,
                },
                [5] = {
                    value = tostring(_call34:GetProductInfo(game.PlaceId).Name),
                    name = '**Game**',
                    inline = false,
                },
                [6] = {
                    value = 'v1.0',
                    name = '**Version**',
                    inline = false,
                },
            },
            title = 'Kurby \u{2014} Script Executed',
            footer = {
                text = 'Kurby Cracked | https://github.com/MindyLozy',
            },
            color = 9699327,
            timestamp = '2026-05-01T17:13:31Z',
        },
    },
})
local _ = fenv.syn

--[[ request({
    Body = _call40,
    Url = 'https://discord.com/api/webhooks/1483631634463854728/OflWa22dztLumYPhYbg86IBbL-qHzaj_ZlWUDbAEuGQbaMFOo1iAf8P5lifly46yI0kk',
    Method = 'POST',
    Headers = {
        ['Content-Type'] = 'application/json',
    },
})
-- dc logger lmao
]]
local _callgethui43 = gethui()

for _46, _46_2 in pairs(_callgethui43:GetChildren())do
    local _ = _46_2.Name
end

local _call49 = Instance.new('BlurEffect')

_call49.Size = 0
_call49.Parent = game:GetService('Lighting')

local _call55 = _call9:Create(_call49, TweenInfo.new(0.5), {Size = 16})

_call55:Play()

local _call59 = Instance.new('ScreenGui')

_call59.Name = 'KurbyGUI'
_call59.ResetOnSpawn = false
_call59.IgnoreGuiInset = true
_call59.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_call59.DisplayOrder = 99999
_call59.Parent = _callgethui43

local _call63 = Instance.new('Frame', _call59)

_call63.Size = UDim2.new(1, 0, 1, 0)
_call63.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
_call63.BackgroundTransparency = 1
_call63.BorderSizePixel = 0

local _call71 = _call9:Create(_call63, TweenInfo.new(0.5), {BackgroundTransparency = 0.6})

_call71:Play()

local _call75 = Instance.new('Frame', _call59)

_call75.Name = 'LCard'
_call75.Size = UDim2.new(0, 0, 0, 0)
_call75.Position = UDim2.new(0.5, 0, 0.5, 0)
_call75.AnchorPoint = Vector2.new(0.5, 0.5)
_call75.BackgroundColor3 = Color3.fromRGB(11, 11, 13)
_call75.BorderSizePixel = 0
_call75.ClipsDescendants = true
_call75.ZIndex = 2

local _call85 = Instance.new('UICorner', _call75)

_call85.CornerRadius = UDim.new(0, 16)

local _call89 = Instance.new('UIStroke', _call75)

_call89.Thickness = 1.8
_call89.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local _call93 = Instance.new('UIGradient', _call89)

task.spawn(function(_96, _96_2)
    local _ = _call75.Parent
    local _call107 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.004, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.454, 0.65, 1)),
    })

    _call93.Color = _call107
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call121 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.008, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.458, 0.65, 1)),
    })

    _call93.Color = _call121
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call135 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.012, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.462, 0.65, 1)),
    })

    _call93.Color = _call135
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call149 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.016, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.466, 0.65, 1)),
    })

    _call93.Color = _call149
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call163 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.02, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.47000000000000003, 0.65, 1)),
    })

    _call93.Color = _call163
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call177 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.024, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.47400000000000003, 0.65, 1)),
    })

    _call93.Color = _call177
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call191 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.028, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.47800000000000004, 0.65, 1)),
    })

    _call93.Color = _call191
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call205 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.032, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.482, 0.65, 1)),
    })

    _call93.Color = _call205
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call219 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.036000000000000004, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.486, 0.65, 1)),
    })

    _call93.Color = _call219
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call233 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.04000000000000001, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.49, 0.65, 1)),
    })

    _call93.Color = _call233
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call247 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.04400000000000001, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.494, 0.65, 1)),
    })

    _call93.Color = _call247
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call261 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.048000000000000015, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.498, 0.65, 1)),
    })

    _call93.Color = _call261
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call275 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.05200000000000002, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.502, 0.65, 1)),
    })

    _call93.Color = _call275
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call289 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.05600000000000002, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.506, 0.65, 1)),
    })

    _call93.Color = _call289
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call303 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.060000000000000026, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.51, 0.65, 1)),
    })

    _call93.Color = _call303
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call317 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.06400000000000003, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.514, 0.65, 1)),
    })

    _call93.Color = _call317
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call331 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.06800000000000003, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.518, 0.65, 1)),
    })

    _call93.Color = _call331
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call345 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.07200000000000004, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.522, 0.65, 1)),
    })

    _call93.Color = _call345
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _call359 = ColorSequence.new({
        [1] = ColorSequenceKeypoint.new(0, Color3.fromHSV(0.07600000000000004, 0.65, 1)),
        [2] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0.526, 0.65, 1)),
    })

    _call93.Color = _call359
    _call93.Rotation = ((_call93.Rotation + 1.2) % 360)

    task.wait(0.02)

    local _ = _call75.Parent
    local _ = ColorSequence.new

    ColorSequenceKeypoint.new(0, Color3.fromHSV(0.08000000000000004, 0.65, 1))
    ColorSequenceKeypoint.new(1, Color3.fromHSV(0.53, 0.65, 1))
    error('internal 579: <25ms: infinitelooperror>')
end)

local _call375 = Instance.new('UIGradient', _call75)
local _call385 = ColorSequence.new({
    [1] = ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 13, 22)),
    [2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12)),
})

_call375.Color = _call385
_call375.Rotation = 135

local _call387 = Instance.new('TextLabel', _call75)

_call387.Text = ''
_call387.Size = UDim2.new(0, 0, 0, 0)
_call387.Position = UDim2.new(0, 0, 0, 0)
_call387.BackgroundTransparency = 1
_call387.TextSize = 1
_call387.TextTransparency = 1
_call387.ZIndex = 3

local _call393 = Instance.new('TextLabel', _call75)

_call393.Text = 'Kurby Cracked \u{2014} FPS Flick'
_call393.Size = UDim2.new(0.85, 0, 0, 26)
_call393.Position = UDim2.new(0, 20, 0, 26)
_call393.BackgroundTransparency = 1
_call393.TextColor3 = Color3.fromRGB(232, 230, 242)
_call393.Font = Enum.Font.GothamBlack
_call393.TextSize = 20
_call393.TextXAlignment = Enum.TextXAlignment.Left
_call393.TextTransparency = 1
_call393.ZIndex = 3

local _call405 = Instance.new('TextLabel', _call75)

_call405.Text = 'Initializing...'
_call405.Size = UDim2.new(0.85, 0, 0, 16)
_call405.Position = UDim2.new(0, 20, 0, 56)
_call405.BackgroundTransparency = 1
_call405.TextColor3 = Color3.fromRGB(110, 108, 145)
_call405.Font = Enum.Font.Gotham
_call405.TextSize = 12
_call405.TextXAlignment = Enum.TextXAlignment.Left
_call405.TextTransparency = 1
_call405.ZIndex = 3

local _call417 = Instance.new('Frame', _call75)

_call417.Size = UDim2.new(1, -44, 0, 4)
_call417.Position = UDim2.new(0, 22, 1, -16)
_call417.BackgroundColor3 = Color3.fromRGB(24, 22, 34)
_call417.BorderSizePixel = 0
_call417.ZIndex = 3

local _call425 = Instance.new('UICorner', _call417)

_call425.CornerRadius = UDim.new(1, 0)

local _call429 = Instance.new('Frame', _call417)

_call429.Size = UDim2.new(0.3, 0, 1, 0)
_call429.Position = UDim2.new(-0.3, 0, 0, 0)
_call429.BackgroundColor3 = Color3.fromRGB(169, 112, 255)
_call429.BorderSizePixel = 0
_call429.ZIndex = 4

local _call437 = Instance.new('UICorner', _call429)

_call437.CornerRadius = UDim.new(1, 0)

local _call441 = Instance.new('Frame', _call75)

_call441.Size = UDim2.new(0, 8, 0, 8)
_call441.Position = UDim2.new(1, -18, 0, 16)
_call441.BackgroundColor3 = Color3.fromRGB(169, 112, 255)
_call441.BorderSizePixel = 0
_call441.ZIndex = 3

local _call449 = Instance.new('UICorner', _call441)

_call449.CornerRadius = UDim.new(1, 0)

task.spawn(function(_454)
    local _ = _call75.Parent
    local _call463 = _call9:Create(_call441, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.7})

    _call463:Play()
    task.wait(0.9)
    error('internal 579: <25ms: infinitelooperror>')
end)

local _call470 = Color3.fromRGB(14, 14, 18)

Color3.fromRGB(20, 20, 26)
Color3.fromRGB(232, 230, 242)
Color3.fromRGB(110, 108, 145)
Color3.fromRGB(215, 65, 65)

local _call482 = Instance.new('ScreenGui')

_call482.Name = 'KurbyMain'
_call482.ResetOnSpawn = false
_call482.IgnoreGuiInset = true
_call482.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_call482.DisplayOrder = 9999
_call482.Parent = _callgethui43

local _call486 = Instance.new('Frame', _call482)

_call486.Name = 'Main'
_call486.Size = UDim2.new(0, 560, 0, 440)
_call486.Position = UDim2.new(0.5, -280, 0.5, -220)
_call486.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
_call486.BorderSizePixel = 0
_call486.Active = true
_call486.Visible = false

local _call492 = Instance.new('UICorner', _call486)

_call492.CornerRadius = UDim.new(0, 12)

local _call496 = Instance.new('UIGradient', _call486)
local _call506 = ColorSequence.new({
    [1] = ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 12, 20)),
    [2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12)),
})

_call496.Color = _call506
_call496.Rotation = 135

local _call508 = Instance.new('UIStroke', _call486)

_call508.Thickness = 2

Instance.new('UIGradient', _call508)
task.spawn(function(_513, _513_2) end)

local _call515 = Instance.new('Frame', _call486)

_call515.Size = UDim2.new(1, 0, 0, 44)
_call515.BackgroundColor3 = _call470
_call515.BorderSizePixel = 0

local _call519 = Instance.new('UICorner', _call515)

_call519.CornerRadius = UDim.new(0, 12)

local _call523 = Instance.new('Frame', _call515)

_call523.Size = UDim2.new(1, 0, 0, 10)
_call523.Position = UDim2.new(0, 0, 1, -10)
_call523.BackgroundColor3 = _call470
_call523.BorderSizePixel = 0

local _call529 = Instance.new('TextLabel', _call515)

_call529.Text = 'KURBY CRACKED  \u{2014}  FLICK'
_call529.Size = UDim2.new(1, -50, 1, 0)
_call529.Position = UDim2.new(0, 14, 0, 0)
_call529.BackgroundTransparency = 1
_call529.TextColor3 = Color3.fromRGB(169, 112, 255)
_call529.Font = Enum.Font.GothamBlack
_call529.TextSize = 14
_call529.TextXAlignment = Enum.TextXAlignment.Left

local _call539 = Instance.new('TextButton', _call515)

_call539.Text = '\u{2715}'
_call539.Size = UDim2.new(0, 30, 0, 30)
_call539.Position = UDim2.new(1, -38, 0.5, -15)
_call539.BackgroundColor3 = Color3.fromRGB(60, 18, 18)
_call539.TextColor3 = Color3.new(1, 1, 1)
_call539.Font = Enum.Font.GothamBold
_call539.TextSize = 14
_call539.BorderSizePixel = 0

local _call551 = Instance.new('UICorner', _call539)

_call551.CornerRadius = UDim.new(0, 6)

_call539.MouseButton1Click:Connect(function(_557) end)
_call515.InputBegan:Connect(function(_561, _561_2, _561_3, _561_4, _561_5, _561_6) end)
_call11.InputChanged:Connect(function(_565, _565_2, _565_3, _565_4, _565_5, _565_6) end)
_call11.InputEnded:Connect(function(_569, _569_2, _569_3, _569_4, _569_5) end)

local _call571 = Instance.new('ScrollingFrame', _call486)

_call571.Size = UDim2.new(1, 0, 0, 30)
_call571.Position = UDim2.new(0, 0, 0, 44)
_call571.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
_call571.BorderSizePixel = 0
_call571.ScrollBarThickness = 0
_call571.ScrollingDirection = Enum.ScrollingDirection.X
_call571.CanvasSize = UDim2.new(0, 0, 0, 0)
_call571.AutomaticCanvasSize = Enum.AutomaticSize.X

local _call585 = Instance.new('UIListLayout', _call571)

_call585.FillDirection = Enum.FillDirection.Horizontal
_call585.SortOrder = Enum.SortOrder.LayoutOrder
_call585.Padding = UDim.new(0, 3)

local _call593 = Instance.new('UIPadding', _call571)

_call593.PaddingLeft = UDim.new(0, 6)

local _call597 = Instance.new('Frame', _call486)

_call597.Size = UDim2.new(1, 0, 0, 1)
_call597.Position = UDim2.new(0, 0, 0, 74)
_call597.BackgroundColor3 = Color3.fromRGB(30, 22, 50)
_call597.BorderSizePixel = 0

local _call605 = Instance.new('Frame', _call486)

_call605.Size = UDim2.new(1, -12, 1, -84)
_call605.Position = UDim2.new(0, 6, 0, 79)
_call605.BackgroundTransparency = 1

local _call611 = Drawing.new('Circle')

_call611.Thickness = 1
_call611.Filled = false
_call611.Transparency = 0.8
_call611.NumSides = 64
_call611.Visible = false
_call611.Radius = 180
_call611.Color = Color3.fromRGB(169, 112, 255)

_call5.PlayerAdded:Connect(function(_617, _617_2) end)
_LocalPlayer19.CharacterAdded:Connect(function(_621, _621_2, _621_3, _621_4) end)

local _ = _LocalPlayer19.Character
local _Character623 = _LocalPlayer19.Character

_Character623.ChildAdded:Connect(function(_627, _627_2, _627_3, _627_4, _627_5, _627_6) end)

for _632, _632_2 in pairs(_Character623:FindFirstChildOfClass('Tool'):GetDescendants())do
    _632_2:IsA('NumberValue')
    _632_2.Name:lower():find('reload')

    _632_2.Value = 0

    local _ = _632_2.Changed

    error('internal 579: <25ms: infinitelooperror>')
end
