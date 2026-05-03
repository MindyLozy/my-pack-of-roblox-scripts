local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
if not player then
	repeat task.wait() until Players.LocalPlayer
	player = Players.LocalPlayer
end
local camera = Workspace.CurrentCamera
local playerGui = player:WaitForChild("PlayerGui")
local CONFIG = {
	WALL_DETECT_DIST = 3.5,
	PIXELSURF_SPEED = 32,
	BHOP_SPEED = 28,
	JUMPBUG_EXTRA_Y = 6,
	COUNTER_GRAVITY = true,
	EDGE_DETECTION_RANGE = 12,
	MIN_FALL_SPEED = 5,
	FORWARD_SPEED = 24,
	SLIDE_SPEED = 34,
	EDGE_OFFSET = 0.3,
	CAMERA_TURN_SPEED = 0.08,
	CORRECTION_THRESHOLD = 2,
	OVERSHOOT_THRESHOLD = 1,
	SPEED_BOOST = 1.4,
	SPEED_REDUCE = 0.6,
	POSITION_CORRECTION = 0.3,
	ANGLE_TOLERANCE = 5,
	MAX_TURN_RATE = 3,
	HANG_TIME_DURATION = 0.2,
	HANG_TIME_GRAVITY = 15,
	EDGEBUG_SOUND_ID = "rbxassetid://18651763090",
	KEYSTROKE_SOUND_ID = "rbxassetid://96591611478915",
	NOTIFICATION_SOUND_ID = "rbxassetid://131390520971848",
	WALLHOP_RAY_DISTANCE = 4,
	WALLHOP_COOLDOWN = 0.18,
	WALLHOP_NUM_RAYS = 12,
	WALLHOP_FLICK_ANGLE = math.rad(45),
	WALLHOP_FLICK_DURATION = 0.05,
	WALLHOP_JUMP_DELAY = 0.02,
	KEYSTROKE_POOL_SIZE = 6,
	GRAPH_WIDTH = 450,
	GRAPH_HEIGHT = 60,
	SCROLL_SPEED = 2.2,
	HEIGHT_MULTIPLIER = 3.5,
	SMOOTH_FACTOR = 0.12,
	NOTIF_HEIGHT = 44,
	NOTIF_GAP = 6,
	NOTIF_WIDTH = 280,
	NOTIF_LIFETIME = 3.0,
	MAX_NOTIFICATIONS = 6,
	NOTIF_BOTTOM_OFFSET = 70,
	FLASH_DEFAULT_COOLDOWN = 5,
	FLASH_HOLD_TIME = 0.4,
	FLASH_FADE_OUT_TIME = 1.5,
	FLASH_SOUND_ID = "rbxassetid://124814608612205",
	FLASH_CATALOG_IDS = {
		120466102356693, 108549752946999, 90670896369023,
		127844451914866, 105063616762169, 92114902190154,
		134105998236597, 96774285956470, 99980873895043,
		118455698664728, 109387271443200, 78653413694926,
		15247365168, 128162709052302,
	},
}
-- Keybinds table - change these to rebind
local keybinds = {
	pixelSurf = Enum.KeyCode.LeftShift,
	bhop = Enum.KeyCode.Space,
	jumpBug = Enum.KeyCode.E,
	edgebug = Enum.KeyCode.LeftControl,
	autoWallhop = Enum.KeyCode.R,
}
-- Which keybind is currently being rebound (nil = none)
local rebindingKey = nil
local rebindButtons = {}
local THEME = {
	primary = Color3.fromRGB(0, 255, 0),
	primaryDark = Color3.fromRGB(0, 150, 0),
	primaryLight = Color3.fromRGB(180, 255, 180),
	accent = Color3.fromRGB(0, 255, 0),
	text = Color3.fromRGB(255, 255, 255),
	textDim = Color3.fromRGB(156, 163, 175),
	textMuted = Color3.fromRGB(107, 114, 128),
	background = Color3.fromRGB(12, 12, 16),
	backgroundLight = Color3.fromRGB(18, 18, 24),
	backgroundLighter = Color3.fromRGB(26, 26, 32),
	border = Color3.fromRGB(40, 40, 50),
	success = Color3.fromRGB(34, 197, 94),
	danger = Color3.fromRGB(239, 68, 68),
	graphFill = Color3.fromRGB(0, 40, 0),
}
local features = {
	pixelSurf = false, bhop = false, jumpBug = false,
	edgebug = false, autoWallhop = false,
	velocityDisplay = false, velocityGraph = false,
	esp = false, fullbright = false, snow = true,
	keystrokes = false, hitmarker = false, chams = false,
	fovChanger = false, worldModulation = false,
	worldTransparency = false, fogControl = false,
	ambientColor = false, miniKeyboard = false, femboyFlash = false,
}
local chamsSettings = {
	fillColor = Color3.fromRGB(0, 255, 0),
	outlineColor = Color3.fromRGB(255, 255, 255),
	fillTransparency = 0.6, outlineTransparency = 0,
	chamHue = 0.33, chamSat = 1.0, chamVal = 1.0,
	outlineHue = 0, outlineSat = 0, outlineVal = 1,
	pearlescentEnabled = true, pearlescentSpeed = 1.0,
}
local espSettings = {
	boxColor = Color3.fromRGB(0, 255, 0),
	boxHue = 0.33, boxSat = 1.0, boxVal = 1.0,
}
local worldSettings = {
	brightness = 1.0, fogDensity = 0.0,
	fogColor = Color3.fromRGB(128, 128, 128),
	fogHue = 0, fogSat = 0, fogVal = 0.5,
	ambientR = 0.5, ambientG = 0.5, ambientB = 0.5,
	clockTime = 14, transparency = 0.0,
}
local state = {
	char = nil, hum = nil, root = nil,
	keys = {W=false, A=false, S=false, D=false, Jump=false, Surf=false, JumpBug=false},
	jumpBugApplied = false, takeoffVelocity = 0, lastOnGround = true,
	autoEdgebugEnabled = false, isGuiding = false, isSliding = false,
	edgeLanded = false, isHangTime = false, lastEdge = nil,
	menuOpen = false, currentTab = "Movement",
	lastSpeed = 16, graphSpeed = 16, soundLoaded = false,
	wallhopHolding = false, lastWallhopTime = 0, isWallhopFlicking = false,
	edgebugVolume = 0.5, keystrokeVolume = 0.5,
	fovValue = 70, originalFieldOfView = nil,
	flashCurrentCooldown = CONFIG.FLASH_DEFAULT_COOLDOWN,
	flashOnCooldown = false, flashRunning = false, flashImagesReady = false,
	pearlescentTime = 0, discordModalOpen = false,
	activeDragSlider = nil, draggingMenu = false,
	dragOffset = Vector2.new(0, 0),
	keystrokeSoundIndex = 1,
	themeHue = 0.33, themeSat = 1.0, themeVal = 1.0,
}
local refs = {
	screenGui = nil, velocityLabel = nil, graphContainer = nil,
	menuFrame = nil, edgebugSound = nil, snowContainer = nil,
	hitmarkerContainer = nil, keystrokeDisplay = nil,
	notifContainer = nil, discordModalGui = nil,
	flashImage = nil, flashBoomSound = nil,
}
local segments = {}
local snowParticles = {}
local keystrokeSounds = {}
local themedElements = {}
local hitmarkerLines = {}
local keystrokeLabels = {}
local activeKeys = {}
local chamsHighlights = {}
local espData = {}
local hitmarkerConnections = {}
local notificationStack = {}
local tabButtons = {}
local tabContents = {}
local resolvedImageIds = {}
local originalTransparencies = {}
local originalLighting = {
	Brightness = Lighting.Brightness,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	FogEnd = Lighting.FogEnd,
	FogStart = Lighting.FogStart,
	GlobalShadows = Lighting.GlobalShadows,
	ClockTime = Lighting.ClockTime,
	FogColor = Lighting.FogColor,
}
local function trackTheme(obj, prop, themeKey)
	table.insert(themedElements, {obj = obj, prop = prop, themeKey = themeKey})
end
local function updateThemeColors()
	local h, s, v = state.themeHue, state.themeSat, state.themeVal
	THEME.primary = Color3.fromHSV(h, s, v)
	THEME.primaryDark = Color3.fromHSV(h, math.min(s + 0.07, 1), math.max(v - 0.16, 0))
	THEME.primaryLight = Color3.fromHSV(h, math.max(s - 0.35, 0), math.min(v + 0.03, 1))
	THEME.accent = Color3.fromHSV(h, math.max(s - 0.13, 0), math.max(v - 0.01, 0))
	THEME.graphFill = Color3.fromHSV(h, math.max(s - 0.01, 0), math.max(v - 0.05, 0))
	for _, entry in ipairs(themedElements) do
		if entry.obj and entry.obj.Parent then
			pcall(function() entry.obj[entry.prop] = THEME[entry.themeKey] end)
		end
	end
	if refs.velocityLabel then refs.velocityLabel.TextColor3 = THEME.primary end
end
-- Helper to get a short display name for a keycode
local function getKeyName(keyCode)
	local name = keyCode.Name
	local shortNames = {
		LeftShift = "LSHIFT", RightShift = "RSHIFT",
		LeftControl = "LCTRL", RightControl = "RCTRL",
		LeftAlt = "LALT", RightAlt = "RALT",
		Space = "SPACE", Backspace = "BKSP",
		CapsLock = "CAPS", Tab = "TAB",
		Return = "ENTER",
	}
	return shortNames[name] or name
end
local function enableFullbright()
	Lighting.Brightness = 2
	Lighting.Ambient = Color3.fromRGB(178, 178, 178)
	Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
	Lighting.FogEnd = 100000
	Lighting.FogStart = 0
	Lighting.GlobalShadows = false
	for _, child in pairs(Lighting:GetChildren()) do
		if child:IsA("Atmosphere") or child:IsA("BloomEffect") or child:IsA("BlurEffect") or child:IsA("ColorCorrectionEffect") then
			child.Enabled = false
		end
	end
end
local function disableFullbright()
	Lighting.Brightness = originalLighting.Brightness
	Lighting.Ambient = originalLighting.Ambient
	Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
	Lighting.FogEnd = originalLighting.FogEnd
	Lighting.FogStart = originalLighting.FogStart
	Lighting.GlobalShadows = originalLighting.GlobalShadows
	for _, child in pairs(Lighting:GetChildren()) do
		if child:IsA("Atmosphere") or child:IsA("BloomEffect") or child:IsA("BlurEffect") or child:IsA("ColorCorrectionEffect") then
			child.Enabled = true
		end
	end
end
local function updateWorldModulation()
	if features.worldModulation then
		Lighting.Brightness = worldSettings.brightness * 2
		Lighting.ClockTime = worldSettings.clockTime
	end
	if features.fogControl then
		Lighting.FogEnd = math.clamp((1 - worldSettings.fogDensity) * 10000, 50, 100000)
		Lighting.FogStart = 0
		Lighting.FogColor = worldSettings.fogColor
	end
	if features.ambientColor then
		local c = Color3.fromRGB(math.floor(worldSettings.ambientR * 255), math.floor(worldSettings.ambientG * 255), math.floor(worldSettings.ambientB * 255))
		Lighting.Ambient = c
		Lighting.OutdoorAmbient = c
	end
end
local function resetWorldModulation()
	Lighting.Brightness = originalLighting.Brightness
	Lighting.ClockTime = originalLighting.ClockTime
	Lighting.FogEnd = originalLighting.FogEnd
	Lighting.FogStart = originalLighting.FogStart
	Lighting.FogColor = originalLighting.FogColor
	Lighting.Ambient = originalLighting.Ambient
	Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
end
local function updateWorldTransparency()
	if not features.worldTransparency then return end
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character or Instance.new("Folder")) then
			local isPlayerPart = false
			for _, p in pairs(Players:GetPlayers()) do
				if p.Character and obj:IsDescendantOf(p.Character) then isPlayerPart = true break end
			end
			if not isPlayerPart and obj.Name ~= "Baseplate" and obj.Name ~= "Terrain" then
				if originalTransparencies[obj] == nil then originalTransparencies[obj] = obj.Transparency end
				obj.Transparency = math.clamp(worldSettings.transparency, 0, 0.95)
			end
		end
	end
end
local function resetWorldTransparency()
	for obj, val in pairs(originalTransparencies) do
		if obj and obj.Parent then pcall(function() obj.Transparency = val end) end
	end
	originalTransparencies = {}
end
local notificationSound = Instance.new("Sound")
notificationSound.Name = "NotificationSound"
notificationSound.SoundId = CONFIG.NOTIFICATION_SOUND_ID
notificationSound.Volume = 0.4
notificationSound.PlayOnRemove = false
notificationSound.Parent = SoundService
local function playNotificationSound()
	if notificationSound then
		if notificationSound.IsPlaying then notificationSound:Stop() end
		notificationSound.TimePosition = 0
		pcall(function() notificationSound:Play() end)
	end
end
local function repositionNotifications()
	for i, nd in ipairs(notificationStack) do
		if nd.frame and nd.frame.Parent and refs.notifContainer then
			local targetY = 1 - ((CONFIG.NOTIF_BOTTOM_OFFSET + i * (CONFIG.NOTIF_HEIGHT + CONFIG.NOTIF_GAP)) / refs.notifContainer.AbsoluteSize.Y)
			TweenService:Create(nd.frame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, targetY, 0)}):Play()
		end
	end
end
local function removeNotification(notifData)
	for i, nd in ipairs(notificationStack) do
		if nd == notifData then table.remove(notificationStack, i) break end
	end
	if notifData.frame and notifData.frame.Parent then
		local tw = TweenService:Create(notifData.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, notifData.frame.Position.Y.Scale, 0)})
		tw:Play()
		tw.Completed:Connect(function() if notifData.frame and notifData.frame.Parent then notifData.frame:Destroy() end end)
	end
	task.delay(0.05, repositionNotifications)
end
local function showNotification(text, color)
	if not refs.notifContainer then return end
	playNotificationSound()
	if #notificationStack >= CONFIG.MAX_NOTIFICATIONS then removeNotification(notificationStack[#notificationStack]) end
	color = color or Color3.fromRGB(34, 197, 94)
	local notif = Instance.new("Frame")
	notif.Size = UDim2.new(1, 0, 0, CONFIG.NOTIF_HEIGHT)
	notif.Position = UDim2.new(1, 20, 1, -CONFIG.NOTIF_HEIGHT)
	notif.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
	notif.BorderSizePixel = 0
	notif.ZIndex = 10001
	notif.Parent = refs.notifContainer
	Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
	do
		local ns = Instance.new("UIStroke") ns.Thickness = 1 ns.Color = color ns.Transparency = 0.3 ns.Parent = notif
		local ab = Instance.new("Frame") ab.Size = UDim2.new(0,3,0.7,0) ab.Position = UDim2.new(0,0,0.15,0) ab.BackgroundColor3 = color ab.BorderSizePixel = 0 ab.ZIndex = 10002 ab.Parent = notif
		Instance.new("UICorner", ab).CornerRadius = UDim.new(0, 2)
		local ic = Instance.new("Frame") ic.Size = UDim2.new(0,20,0,20) ic.Position = UDim2.new(0,12,0.5,-10) ic.BackgroundColor3 = color ic.BorderSizePixel = 0 ic.ZIndex = 10003 ic.Parent = notif
		Instance.new("UICorner", ic).CornerRadius = UDim.new(1, 0)
		local lb = Instance.new("TextLabel") lb.Size = UDim2.new(1,-42,1,0) lb.Position = UDim2.new(0,38,0,0) lb.BackgroundTransparency = 1 lb.Font = Enum.Font.GothamSemibold lb.Text = text or "Notification" lb.TextColor3 = Color3.new(1,1,1) lb.TextSize = 11 lb.TextXAlignment = Enum.TextXAlignment.Left lb.TextTruncate = Enum.TextTruncate.AtEnd lb.ZIndex = 10003 lb.Parent = notif
	end
	local nd = {frame = notif, time = tick()}
	table.insert(notificationStack, 1, nd)
	repositionNotifications()
	task.delay(0.05, function()
		if notif and notif.Parent then
			TweenService:Create(notif, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, notif.Position.Y.Scale, 0)}):Play()
		end
	end)
	task.delay(CONFIG.NOTIF_LIFETIME, function() removeNotification(nd) end)
end
local function showToggleNotification(name, isOn)
	showNotification(name .. (isOn and "  >  ON" or "  >  OFF"), isOn and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(239, 68, 68))
end
local function openDiscordModal()
	if state.discordModalOpen then return end
	state.discordModalOpen = true
	refs.discordModalGui = Instance.new("ScreenGui")
	refs.discordModalGui.Name = "DiscordModal"
	refs.discordModalGui.ResetOnSpawn = false
	refs.discordModalGui.DisplayOrder = 9999
	refs.discordModalGui.IgnoreGuiInset = true
	refs.discordModalGui.Parent = playerGui
	do
		local overlay = Instance.new("TextButton") overlay.Size = UDim2.new(1,0,1,0) overlay.BackgroundColor3 = Color3.new(0,0,0) overlay.BackgroundTransparency = 1 overlay.BorderSizePixel = 0 overlay.Text = "" overlay.ZIndex = 1 overlay.Parent = refs.discordModalGui
		TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
		local modal = Instance.new("Frame") modal.Size = UDim2.new(0,340,0,170) modal.Position = UDim2.new(0.5,-170,0.5,-85) modal.BackgroundColor3 = Color3.fromRGB(20,20,32) modal.BorderSizePixel = 0 modal.ZIndex = 2 modal.Parent = refs.discordModalGui
		Instance.new("UICorner", modal).CornerRadius = UDim.new(0, 10)
		Instance.new("UIStroke", modal).Color = Color3.fromRGB(40, 40, 58)
		local title = Instance.new("TextLabel") title.Size = UDim2.new(1,-20,0,22) title.Position = UDim2.new(0,10,0,12) title.BackgroundTransparency = 1 title.Font = Enum.Font.GothamBold title.Text = "Discord Invite" title.TextColor3 = Color3.new(1,1,1) title.TextSize = 14 title.TextXAlignment = Enum.TextXAlignment.Left title.ZIndex = 3 title.Parent = modal
		local sub = Instance.new("TextLabel") sub.Size = UDim2.new(1,-20,0,14) sub.Position = UDim2.new(0,10,0,34) sub.BackgroundTransparency = 1 sub.Font = Enum.Font.Gotham sub.Text = "Copy the link below to join our Discord server" sub.TextColor3 = Color3.fromRGB(107,114,128) sub.TextSize = 11 sub.TextXAlignment = Enum.TextXAlignment.Left sub.ZIndex = 3 sub.Parent = modal
		local tbf = Instance.new("Frame") tbf.Size = UDim2.new(1,-20,0,32) tbf.Position = UDim2.new(0,10,0,58) tbf.BackgroundColor3 = Color3.fromRGB(12,12,16) tbf.BorderSizePixel = 0 tbf.ZIndex = 3 tbf.Parent = modal
		Instance.new("UICorner", tbf).CornerRadius = UDim.new(0, 6)
		Instance.new("UIStroke", tbf).Color = Color3.fromRGB(40, 40, 58)
		local tb = Instance.new("TextBox") tb.Size = UDim2.new(1,-16,1,0) tb.Position = UDim2.new(0,8,0,0) tb.BackgroundTransparency = 1 tb.Font = Enum.Font.Code tb.Text = "https://discord.gg/dMEdBSeUQ5" tb.TextColor3 = Color3.new(1,1,1) tb.TextSize = 12 tb.TextXAlignment = Enum.TextXAlignment.Left tb.ClearTextOnFocus = false tb.TextEditable = false tb.ZIndex = 4 tb.Parent = tbf
		local cpb = Instance.new("TextButton") cpb.Size = UDim2.new(0.55,-5,0,32) cpb.Position = UDim2.new(0,10,0,102) cpb.BackgroundColor3 = Color3.fromRGB(88,101,242) cpb.BorderSizePixel = 0 cpb.Font = Enum.Font.GothamBold cpb.Text = "Copy Link" cpb.TextColor3 = Color3.new(1,1,1) cpb.TextSize = 12 cpb.ZIndex = 3 cpb.Parent = modal
		Instance.new("UICorner", cpb).CornerRadius = UDim.new(0, 6)
		local clb = Instance.new("TextButton") clb.Size = UDim2.new(0.45,-15,0,32) clb.Position = UDim2.new(0.55,5,0,102) clb.BackgroundColor3 = Color3.fromRGB(26,26,32) clb.BorderSizePixel = 0 clb.Font = Enum.Font.GothamBold clb.Text = "Close" clb.TextColor3 = Color3.fromRGB(156,163,175) clb.TextSize = 12 clb.ZIndex = 3 clb.Parent = modal
		Instance.new("UICorner", clb).CornerRadius = UDim.new(0, 6)
		Instance.new("UIStroke", clb).Color = Color3.fromRGB(40, 40, 58)
		local function closeModal()
			if not state.discordModalOpen then return end
			state.discordModalOpen = false
			if refs.discordModalGui and refs.discordModalGui.Parent then
				TweenService:Create(overlay, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
				task.delay(0.15, function() if refs.discordModalGui and refs.discordModalGui.Parent then refs.discordModalGui:Destroy() end end)
			end
		end
		cpb.MouseButton1Click:Connect(function()
			local copied = false
			if setclipboard then pcall(function() setclipboard("https://discord.gg/dMEdBSeUQ5") copied = true end) end
			if not copied and toclipboard then pcall(function() toclipboard("https://discord.gg/dMEdBSeUQ5") copied = true end) end
			if copied then cpb.Text = "Copied!" cpb.BackgroundColor3 = Color3.fromRGB(34,197,94) showNotification("Copied to clipboard!") else cpb.Text = "Copy manually" showNotification("Copy the link manually", Color3.fromRGB(168,85,247)) end
			task.delay(2, function() if cpb and cpb.Parent then cpb.Text = "Copy Link" cpb.BackgroundColor3 = Color3.fromRGB(88,101,242) end end)
		end)
		clb.MouseButton1Click:Connect(closeModal)
		overlay.MouseButton1Click:Connect(closeModal)
	end
end
local function updateESP()
	if not features.esp then
		for _, data in pairs(espData) do
			if data.highlight and data.highlight.Parent then data.highlight:Destroy() end
			if data.nameGui and data.nameGui.Parent then data.nameGui:Destroy() end
			if data.healthGui and data.healthGui.Parent then data.healthGui:Destroy() end
		end
		espData = {}
		return
	end
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local character = p.Character
			local humanoid = character:FindFirstChild("Humanoid")
			local hrp = character:FindFirstChild("HumanoidRootPart")
			local head = character:FindFirstChild("Head")
			if not humanoid or not hrp or not head then
				if espData[p.Name] then
					if espData[p.Name].highlight then espData[p.Name].highlight:Destroy() end
					if espData[p.Name].nameGui then espData[p.Name].nameGui:Destroy() end
					if espData[p.Name].healthGui then espData[p.Name].healthGui:Destroy() end
					espData[p.Name] = nil
				end
				continue
			end
			local teamColor = p.Team and p.TeamColor.Color or Color3.new(1,1,1)
			local teamName = p.Team and p.Team.Name or "Neutral"
			local data = espData[p.Name]
			if not data then
				data = {}
				do
					local hl = Instance.new("Highlight") hl.Name = "ESP_HL_"..p.Name hl.Adornee = character hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop hl.FillTransparency = 1 hl.OutlineTransparency = 0 hl.OutlineColor = espSettings.boxColor hl.FillColor = espSettings.boxColor hl.Parent = character
					data.highlight = hl
					local nbb = Instance.new("BillboardGui") nbb.Name = "ESP_Name_"..p.Name nbb.Adornee = head nbb.Size = UDim2.new(0,120,0,30) nbb.StudsOffset = Vector3.new(0,2.5,0) nbb.AlwaysOnTop = true nbb.Parent = character
					local nl = Instance.new("TextLabel") nl.Name = "Name" nl.Size = UDim2.new(1,0,0.55,0) nl.BackgroundTransparency = 1 nl.Font = Enum.Font.GothamBold nl.TextColor3 = teamColor nl.TextStrokeTransparency = 0 nl.TextStrokeColor3 = Color3.new(0,0,0) nl.TextScaled = true nl.Text = p.DisplayName nl.ZIndex = 10 nl.Parent = nbb
					local tl = Instance.new("TextLabel") tl.Name = "Team" tl.Size = UDim2.new(1,0,0.35,0) tl.Position = UDim2.new(0,0,0.55,0) tl.BackgroundTransparency = 1 tl.Font = Enum.Font.Gotham tl.TextColor3 = teamColor tl.TextStrokeTransparency = 0 tl.TextStrokeColor3 = Color3.new(0,0,0) tl.TextScaled = true tl.Text = teamName tl.ZIndex = 10 tl.Parent = nbb
					data.nameGui = nbb
					local _, cs = character:GetBoundingBox()
					local hbb = Instance.new("BillboardGui") hbb.Name = "ESP_HP_"..p.Name hbb.Adornee = hrp hbb.Size = UDim2.new(0,3,cs.Y,0) hbb.StudsOffset = Vector3.new(-(cs.X/2)-0.8,0,0) hbb.AlwaysOnTop = true hbb.Parent = character
					local bg = Instance.new("Frame") bg.Name = "Bg" bg.Size = UDim2.new(1,0,1,0) bg.BackgroundColor3 = Color3.new(0,0,0) bg.BackgroundTransparency = 0.4 bg.BorderSizePixel = 0 bg.Parent = hbb
					local fl = Instance.new("Frame") fl.Name = "Fill" fl.BackgroundColor3 = Color3.fromRGB(0,255,0) fl.BorderSizePixel = 0 fl.AnchorPoint = Vector2.new(0,1) fl.Position = UDim2.new(0,0,1,0) fl.Size = UDim2.new(1,0,1,0) fl.Parent = bg
					data.healthGui = hbb
				end
				espData[p.Name] = data
			end
			if data.highlight then data.highlight.OutlineColor = espSettings.boxColor data.highlight.FillColor = espSettings.boxColor if data.highlight.Adornee ~= character then data.highlight.Adornee = character end end
			if data.nameGui then
				data.nameGui.Adornee = head
				local nl = data.nameGui:FindFirstChild("Name") if nl then nl.Text = p.DisplayName nl.TextColor3 = teamColor end
				local tl = data.nameGui:FindFirstChild("Team") if tl then tl.Text = teamName tl.TextColor3 = teamColor end
			end
			if data.healthGui then
				data.healthGui.Adornee = hrp
				local ok, _, cs = pcall(function() return character:GetBoundingBox() end)
				if ok and cs then data.healthGui.Size = UDim2.new(0,3,cs.Y,0) data.healthGui.StudsOffset = Vector3.new(-(cs.X/2)-0.8,0,0) end
				local bg = data.healthGui:FindFirstChild("Bg")
				if bg then local fl = bg:FindFirstChild("Fill") if fl then local hp = math.clamp(humanoid.Health/humanoid.MaxHealth,0,1) fl.Size = UDim2.new(1,0,hp,0) fl.BackgroundColor3 = Color3.fromRGB(255*(1-hp),255*hp,0) end end
			end
		else
			if espData[p.Name] then
				if espData[p.Name].highlight then espData[p.Name].highlight:Destroy() end
				if espData[p.Name].nameGui then espData[p.Name].nameGui:Destroy() end
				if espData[p.Name].healthGui then espData[p.Name].healthGui:Destroy() end
				espData[p.Name] = nil
			end
		end
	end
	for name, data in pairs(espData) do
		local found = false
		for _, p in pairs(Players:GetPlayers()) do if p.Name == name then found = true break end end
		if not found then
			if data.highlight then data.highlight:Destroy() end
			if data.nameGui then data.nameGui:Destroy() end
			if data.healthGui then data.healthGui:Destroy() end
			espData[name] = nil
		end
	end
end
local function getPearlescentColor(baseHue, baseSat, baseVal, offset)
	return Color3.fromHSV((baseHue + offset) % 1, math.clamp(baseSat * 0.7 + 0.15, 0, 1), math.clamp(baseVal * 0.85 + 0.15, 0, 1))
end
local function updateChams()
	if not features.chams then
		for _, h in pairs(chamsHighlights) do if h and h.Parent then h:Destroy() end end
		chamsHighlights = {}
		return
	end
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local character = p.Character
			if not character:FindFirstChild("Humanoid") then
				if chamsHighlights[p.Name] then chamsHighlights[p.Name]:Destroy() chamsHighlights[p.Name] = nil end
				continue
			end
			local highlight = chamsHighlights[p.Name]
			if not highlight or not highlight.Parent then
				highlight = Instance.new("Highlight") highlight.Name = "Chams_"..p.Name highlight.Adornee = character highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop highlight.Parent = character
				chamsHighlights[p.Name] = highlight
			end
			if chamsSettings.pearlescentEnabled then
				local phase = (p.UserId % 100) / 100 * math.pi * 2
				highlight.FillColor = getPearlescentColor(chamsSettings.chamHue, chamsSettings.chamSat, chamsSettings.chamVal, math.sin(state.pearlescentTime * chamsSettings.pearlescentSpeed + phase) * 0.15)
				highlight.OutlineColor = getPearlescentColor(chamsSettings.outlineHue, chamsSettings.outlineSat, chamsSettings.outlineVal, math.sin(state.pearlescentTime * chamsSettings.pearlescentSpeed * 1.3 + phase) * 0.1)
			else
				highlight.FillColor = chamsSettings.fillColor
				highlight.OutlineColor = chamsSettings.outlineColor
			end
			highlight.FillTransparency = chamsSettings.fillTransparency
			highlight.OutlineTransparency = chamsSettings.outlineTransparency
			if highlight.Adornee ~= character then highlight.Adornee = character end
		else
			if chamsHighlights[p.Name] then chamsHighlights[p.Name]:Destroy() chamsHighlights[p.Name] = nil end
		end
	end
	for name, h in pairs(chamsHighlights) do
		local found = false
		for _, p in pairs(Players:GetPlayers()) do if p.Name == name then found = true break end end
		if not found then if h and h.Parent then h:Destroy() end chamsHighlights[name] = nil end
	end
end
local function updateFOVChanger()
	if not features.fovChanger then
		if state.originalFieldOfView and camera then camera.FieldOfView = state.originalFieldOfView end
		return
	end
	if not state.originalFieldOfView then state.originalFieldOfView = camera.FieldOfView end
	camera.FieldOfView = math.clamp(state.fovValue, 20, 120)
end
local function cleanup()
	for i = #segments, 1, -1 do if segments[i] and segments[i].Parent then segments[i]:Destroy() end table.remove(segments, i) end
	state.lastSpeed = 16 state.graphSpeed = 16 state.autoEdgebugEnabled = false state.isGuiding = false state.isSliding = false
	state.edgeLanded = false state.isHangTime = false state.lastEdge = nil state.jumpBugApplied = false state.takeoffVelocity = 0
	state.lastOnGround = true state.wallhopHolding = false state.isWallhopFlicking = false state.lastWallhopTime = 0
	for key in pairs(state.keys) do state.keys[key] = false end
end
local function setup(c)
	state.char = c
	state.hum = c:WaitForChild("Humanoid")
	state.root = c:WaitForChild("HumanoidRootPart")
	if refs.edgebugSound then refs.edgebugSound.Parent = state.root end
	state.hum.Died:Connect(cleanup)
end
if player.Character then setup(player.Character) end
player.CharacterAdded:Connect(function(c) cleanup() setup(c) end)
do
	refs.edgebugSound = Instance.new("Sound")
	refs.edgebugSound.Name = "EdgebugSound"
	refs.edgebugSound.SoundId = CONFIG.EDGEBUG_SOUND_ID
	refs.edgebugSound.Volume = state.edgebugVolume
	refs.edgebugSound.PlayOnRemove = false
	refs.edgebugSound.RollOffMode = Enum.RollOffMode.Linear
	refs.edgebugSound.RollOffMaxDistance = 1000
	refs.edgebugSound.RollOffMinDistance = 0
	task.spawn(function()
		repeat task.wait() until state.root
		refs.edgebugSound.Parent = state.root
		pcall(function() ContentProvider:PreloadAsync({refs.edgebugSound}) end)
		state.soundLoaded = true
	end)
end
local function playEdgebugSound()
	if not refs.edgebugSound then return end
	if not refs.edgebugSound.Parent and state.root then refs.edgebugSound.Parent = state.root end
	if refs.edgebugSound.IsPlaying then refs.edgebugSound:Stop() end
	refs.edgebugSound.Volume = state.edgebugVolume
	refs.edgebugSound.TimePosition = 0
	pcall(function() refs.edgebugSound:Play() end)
end
task.spawn(function()
	repeat task.wait() until state.root
	for i = 1, CONFIG.KEYSTROKE_POOL_SIZE do
		local s = Instance.new("Sound") s.Name = "KeystrokeSound_"..i s.SoundId = CONFIG.KEYSTROKE_SOUND_ID s.Volume = state.keystrokeVolume s.PlayOnRemove = false s.Parent = state.root
		keystrokeSounds[i] = s
	end
	pcall(function() ContentProvider:PreloadAsync(keystrokeSounds) end)
end)
local function playKeystrokeSound()
	if not features.keystrokes or #keystrokeSounds == 0 then return end
	local s = keystrokeSounds[state.keystrokeSoundIndex]
	if s then
		if not s.Parent and state.root then s.Parent = state.root end
		s.Volume = state.keystrokeVolume s.TimePosition = 0
		pcall(function() s:Play() end)
	end
	state.keystrokeSoundIndex = (state.keystrokeSoundIndex % CONFIG.KEYSTROKE_POOL_SIZE) + 1
end
local function castWallhopRays(rootPart)
	local origin = rootPart.Position
	local rayParams = RaycastParams.new() rayParams.FilterType = Enum.RaycastFilterType.Exclude rayParams.FilterDescendantsInstances = {state.char}
	local closestResult, closestDist = nil, math.huge
	for i = 1, CONFIG.WALLHOP_NUM_RAYS do
		local angle = (i / CONFIG.WALLHOP_NUM_RAYS) * math.pi * 2
		local dir = Vector3.new(math.cos(angle), 0, math.sin(angle)) * CONFIG.WALLHOP_RAY_DISTANCE
		local result = Workspace:Raycast(origin, dir, rayParams)
		if result and result.Instance and math.abs(result.Normal:Dot(Vector3.new(0,1,0))) < 0.3 then
			local d = (result.Position - origin).Magnitude
			if d < closestDist then closestDist = d closestResult = result end
		end
	end
	return closestResult
end
local function rotateCameraYaw(angleDelta)
	if state.isGuiding then return end
	local cf = camera.CFrame
	local lv = cf.LookVector
	local c, s = math.cos(angleDelta), math.sin(angleDelta)
	camera.CFrame = CFrame.lookAt(cf.Position, cf.Position + Vector3.new(lv.X*c - lv.Z*s, lv.Y, lv.X*s + lv.Z*c))
end
local function performWallhop(rootPart, wallResult)
	if not state.hum or state.isWallhopFlicking then return end
	if tick() - state.lastWallhopTime < CONFIG.WALLHOP_COOLDOWN then return end
	state.lastWallhopTime = tick()
	state.isWallhopFlicking = true
	local wn = wallResult.Normal
	local flickDir = camera.CFrame.RightVector:Dot(-wn) >= 0 and 1 or -1
	local flickAngle = CONFIG.WALLHOP_FLICK_ANGLE * flickDir
	rotateCameraYaw(flickAngle)
	task.spawn(function()
		task.wait(CONFIG.WALLHOP_JUMP_DELAY)
		if not state.char or not state.char.Parent then state.isWallhopFlicking = false return end
		local h = state.char:FindFirstChild("Humanoid")
		local r = state.char:FindFirstChild("HumanoidRootPart")
		if h and r and h.Health > 0 then
			h:ChangeState(Enum.HumanoidStateType.Jumping)
			h.AutoRotate = false
			r.AssemblyLinearVelocity = Vector3.new(r.AssemblyLinearVelocity.X*0.5 + wn.X*25, math.max(r.AssemblyLinearVelocity.Y, 50), r.AssemblyLinearVelocity.Z*0.5 + wn.Z*25)
		end
		task.wait(CONFIG.WALLHOP_FLICK_DURATION)
		rotateCameraYaw(-flickAngle)
		pcall(function() if state.char and state.char.Parent then local h2 = state.char:FindFirstChild("Humanoid") if h2 then h2.AutoRotate = true end end end)
		state.isWallhopFlicking = false
	end)
end
refs.screenGui = Instance.new("ScreenGui")
refs.screenGui.ResetOnSpawn = false
refs.screenGui.Name = "ClarificationV2Gui"
refs.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
refs.screenGui.IgnoreGuiInset = true
refs.screenGui.Parent = playerGui
do
	refs.notifContainer = Instance.new("Frame")
	refs.notifContainer.Name = "NotificationContainer"
	refs.notifContainer.Size = UDim2.new(0, CONFIG.NOTIF_WIDTH + 20, 1, 0)
	refs.notifContainer.Position = UDim2.new(1, -CONFIG.NOTIF_WIDTH - 20, 0, 0)
	refs.notifContainer.BackgroundTransparency = 1
	refs.notifContainer.ZIndex = 10000
	refs.notifContainer.ClipsDescendants = false
	refs.notifContainer.Parent = refs.screenGui
end
pcall(function() ContentProvider:PreloadAsync({notificationSound}) end)
refs.velocityLabel = Instance.new("TextLabel")
refs.velocityLabel.Size = UDim2.new(0,200,0,50)
refs.velocityLabel.Position = UDim2.new(0.5,0,0.75,0)
refs.velocityLabel.AnchorPoint = Vector2.new(0.5,0)
refs.velocityLabel.BackgroundTransparency = 1
refs.velocityLabel.TextColor3 = THEME.primary
refs.velocityLabel.Font = Enum.Font.GothamBold
refs.velocityLabel.TextScaled = true
refs.velocityLabel.TextStrokeTransparency = 0.3
refs.velocityLabel.TextStrokeColor3 = Color3.new(0,0,0)
refs.velocityLabel.Text = "0"
refs.velocityLabel.ZIndex = 100
refs.velocityLabel.Visible = false
refs.velocityLabel.Parent = refs.screenGui
refs.graphContainer = Instance.new("Frame")
refs.graphContainer.Size = UDim2.new(0, CONFIG.GRAPH_WIDTH, 0, CONFIG.GRAPH_HEIGHT)
refs.graphContainer.Position = UDim2.new(0.5, -CONFIG.GRAPH_WIDTH/2, 0.70, 0)
refs.graphContainer.BackgroundTransparency = 1
refs.graphContainer.ClipsDescendants = true
refs.graphContainer.ZIndex = 100
refs.graphContainer.Visible = false
refs.graphContainer.Parent = refs.screenGui
local function updateGraph(hSpeed)
	if not features.velocityGraph then return end
	state.graphSpeed = state.graphSpeed * (1 - CONFIG.SMOOTH_FACTOR) + hSpeed * CONFIG.SMOOTH_FACTOR
	local targetY = CONFIG.GRAPH_HEIGHT - math.clamp(state.graphSpeed * CONFIG.HEIGHT_MULTIPLIER, 2, CONFIG.GRAPH_HEIGHT - 2)
	local prevY = CONFIG.GRAPH_HEIGHT - math.clamp(state.lastSpeed * CONFIG.HEIGHT_MULTIPLIER, 2, CONFIG.GRAPH_HEIGHT - 2)
	local sp = Vector2.new(CONFIG.GRAPH_WIDTH - CONFIG.SCROLL_SPEED, prevY)
	local diff = Vector2.new(CONFIG.GRAPH_WIDTH, targetY) - sp
	local dist = math.max(diff.Magnitude, CONFIG.SCROLL_SPEED * 0.9)
	do
		local line = Instance.new("Frame") line.Size = UDim2.new(0,dist+3.5,0,4) line.AnchorPoint = Vector2.new(0,0.5) line.Position = UDim2.new(0,sp.X-0.5,0,sp.Y) line.Rotation = math.deg(math.atan2(diff.Y,diff.X)) line.BackgroundColor3 = THEME.primary line.BorderSizePixel = 0 line.ZIndex = 110 line.Parent = refs.graphContainer
		table.insert(segments, line)
		local fill = Instance.new("Frame") fill.Size = UDim2.new(0,CONFIG.SCROLL_SPEED+4,0,CONFIG.GRAPH_HEIGHT-targetY+4) fill.Position = UDim2.new(0,CONFIG.GRAPH_WIDTH-CONFIG.SCROLL_SPEED-1.5,0,targetY-1.5) fill.BackgroundColor3 = THEME.graphFill fill.BackgroundTransparency = 0.65 fill.BorderSizePixel = 0 fill.ZIndex = 105
		local grad = Instance.new("UIGradient") grad.Rotation = 90 grad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.15),NumberSequenceKeypoint.new(1,0.75)}) grad.Parent = fill
		fill.Parent = refs.graphContainer
		table.insert(segments, fill)
	end
	for i = #segments, 1, -1 do
		local obj = segments[i]
		if obj and obj.Parent then
			local newX = obj.Position.X.Offset - CONFIG.SCROLL_SPEED
			obj.Position = UDim2.new(0, newX, 0, obj.Position.Y.Offset)
			if newX < -75 then obj:Destroy() table.remove(segments, i) end
		end
	end
	state.lastSpeed = state.graphSpeed
end
local function createHitmarker()
	if refs.hitmarkerContainer then refs.hitmarkerContainer:Destroy() end
	hitmarkerLines = {}
	refs.hitmarkerContainer = Instance.new("Frame") refs.hitmarkerContainer.Size = UDim2.new(0,40,0,40) refs.hitmarkerContainer.Position = UDim2.new(0.5,0,0.5,0) refs.hitmarkerContainer.AnchorPoint = Vector2.new(0.5,0.5) refs.hitmarkerContainer.BackgroundTransparency = 1 refs.hitmarkerContainer.ZIndex = 155 refs.hitmarkerContainer.Visible = false refs.hitmarkerContainer.Parent = refs.screenGui
	for _, o in ipairs({{rot=45},{rot=-45},{rot=135},{rot=-135}}) do
		local lf = Instance.new("Frame") lf.Size = UDim2.new(0,2,0,12) lf.Position = UDim2.new(0.5,0,0.5,0) lf.AnchorPoint = Vector2.new(0.5,0) lf.Rotation = o.rot lf.BackgroundColor3 = Color3.new(1,1,1) lf.BorderSizePixel = 0 lf.ZIndex = 156 lf.Parent = refs.hitmarkerContainer
		table.insert(hitmarkerLines, lf)
	end
end
local function triggerHitmarker()
	if not features.hitmarker or not refs.hitmarkerContainer then return end
	refs.hitmarkerContainer.Visible = true
	for _, lf in ipairs(hitmarkerLines) do lf.BackgroundTransparency = 0 end
	task.spawn(function()
		for step = 0, 8 do
			local t = step / 8
			for _, lf in ipairs(hitmarkerLines) do if lf and lf.Parent then lf.Size = UDim2.new(0,2,0,12+6*t) lf.BackgroundTransparency = t end end
			task.wait(0.02)
		end
		if refs.hitmarkerContainer then refs.hitmarkerContainer.Visible = false end
	end)
end
local function setupHitmarkerConnections()
	for _, conn in pairs(hitmarkerConnections) do if conn then pcall(function() conn:Disconnect() end) end end
	hitmarkerConnections = {}
	if not features.hitmarker then return end
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local humanoid = p.Character:FindFirstChild("Humanoid")
			if humanoid and not hitmarkerConnections[p.Name] then
				local lastHP = humanoid.Health
				hitmarkerConnections[p.Name] = humanoid.HealthChanged:Connect(function(hp) if hp < lastHP and features.hitmarker then triggerHitmarker() end lastHP = hp end)
			end
		end
	end
end
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() task.wait(1) if features.hitmarker then setupHitmarkerConnections() end end) end)
for _, p in pairs(Players:GetPlayers()) do if p ~= player then p.CharacterAdded:Connect(function() task.wait(1) if features.hitmarker then setupHitmarkerConnections() end end) end end
local function createKeystrokeDisplay()
	if refs.keystrokeDisplay then refs.keystrokeDisplay:Destroy() end
	keystrokeLabels = {}
	refs.keystrokeDisplay = Instance.new("Frame") refs.keystrokeDisplay.Size = UDim2.new(0,100,0,100) refs.keystrokeDisplay.Position = UDim2.new(0,16,0.5,-50) refs.keystrokeDisplay.BackgroundTransparency = 1 refs.keystrokeDisplay.ZIndex = 140 refs.keystrokeDisplay.Visible = features.miniKeyboard refs.keystrokeDisplay.Parent = refs.screenGui
	for _, k in ipairs({{key="W",x=1,y=0},{key="A",x=0,y=1},{key="S",x=1,y=1},{key="D",x=2,y=1},{key="SPACE",x=0,y=2,wide=true}}) do
		local w = k.wide and 96 or 30
		local h = k.wide and 20 or 30
		local btn = Instance.new("Frame") btn.Size = UDim2.new(0,w,0,h) btn.Position = UDim2.new(0,k.x*33,0,k.y*33) btn.BackgroundColor3 = THEME.backgroundLighter btn.BorderSizePixel = 0 btn.ZIndex = 141 btn.Parent = refs.keystrokeDisplay
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
		local bs = Instance.new("UIStroke") bs.Thickness = 1 bs.Color = THEME.border bs.Parent = btn
		local lb = Instance.new("TextLabel") lb.Size = UDim2.new(1,0,1,0) lb.BackgroundTransparency = 1 lb.Font = Enum.Font.GothamBold lb.Text = k.wide and "---" or k.key lb.TextColor3 = THEME.textMuted lb.TextSize = k.wide and 12 or 14 lb.ZIndex = 142 lb.Parent = btn
		keystrokeLabels[k.key] = {frame = btn, label = lb, stroke = bs}
		activeKeys[k.key] = false
	end
end
local function updateKeystrokeDisplay()
	if not refs.keystrokeDisplay then return end
	refs.keystrokeDisplay.Visible = features.miniKeyboard
	if not features.miniKeyboard then return end
	for kn, pressed in pairs({W=state.keys.W,A=state.keys.A,S=state.keys.S,D=state.keys.D,SPACE=state.keys.Jump}) do
		local entry = keystrokeLabels[kn]
		if entry then
			if pressed and not activeKeys[kn] then
				activeKeys[kn] = true
				TweenService:Create(entry.frame, TweenInfo.new(0.08), {BackgroundColor3 = THEME.primary}):Play()
				TweenService:Create(entry.label, TweenInfo.new(0.08), {TextColor3 = THEME.text}):Play()
				TweenService:Create(entry.stroke, TweenInfo.new(0.08), {Color = THEME.primary}):Play()
			elseif not pressed and activeKeys[kn] then
				activeKeys[kn] = false
				TweenService:Create(entry.frame, TweenInfo.new(0.15), {BackgroundColor3 = THEME.backgroundLighter}):Play()
				TweenService:Create(entry.label, TweenInfo.new(0.15), {TextColor3 = THEME.textMuted}):Play()
				TweenService:Create(entry.stroke, TweenInfo.new(0.15), {Color = THEME.border}):Play()
			end
		end
	end
end
local function createSnowContainer(parent)
	if refs.snowContainer and refs.snowContainer.Parent then refs.snowContainer:Destroy() end
	refs.snowContainer = Instance.new("Frame") refs.snowContainer.Size = UDim2.new(1,0,1,0) refs.snowContainer.BackgroundTransparency = 1 refs.snowContainer.ClipsDescendants = true refs.snowContainer.ZIndex = 203 refs.snowContainer.Name = "SnowContainer" refs.snowContainer.Parent = parent
end
local function updateSnow()
	if not features.snow then
		if refs.snowContainer and refs.snowContainer.Parent then refs.snowContainer:ClearAllChildren() end
		snowParticles = {}
		return
	end
	if not refs.snowContainer or not refs.snowContainer.Parent then return end
	if math.random() < 0.25 then
		local size = math.random(2, 4)
		local flake = Instance.new("Frame") flake.Size = UDim2.new(0,size,0,size) flake.Position = UDim2.new(math.random()*1.2-0.1,0,-0.02,0) flake.BackgroundColor3 = Color3.new(1,1,1) flake.BackgroundTransparency = math.random()*0.3+0.4 flake.BorderSizePixel = 0 flake.ZIndex = 204 flake.Parent = refs.snowContainer
		Instance.new("UICorner", flake).CornerRadius = UDim.new(1, 0)
		table.insert(snowParticles, {frame=flake, speed=math.random(40,100)/100, drift=(math.random()-0.5)*0.25, startX=flake.Position.X.Scale, time=0})
	end
	for i = #snowParticles, 1, -1 do
		local p = snowParticles[i]
		if p.frame and p.frame.Parent then
			p.time = p.time + 0.016
			local newY = p.frame.Position.Y.Scale + p.speed * 0.004
			p.frame.Position = UDim2.new(p.startX + math.sin(p.time*2)*p.drift, 0, newY, 0)
			if newY > 1.05 then p.frame:Destroy() table.remove(snowParticles, i) end
		else table.remove(snowParticles, i) end
	end
end
-- Flash
do
	local fsg = Instance.new("ScreenGui") fsg.Name = "FlashOverlay" fsg.ResetOnSpawn = false fsg.DisplayOrder = 999 fsg.IgnoreGuiInset = true fsg.Parent = playerGui
	refs.flashImage = Instance.new("ImageLabel") refs.flashImage.Size = UDim2.new(1,0,1,0) refs.flashImage.BackgroundTransparency = 1 refs.flashImage.ImageTransparency = 1 refs.flashImage.ScaleType = Enum.ScaleType.Stretch refs.flashImage.ZIndex = 100 refs.flashImage.Visible = false refs.flashImage.Parent = fsg
	refs.flashBoomSound = Instance.new("Sound") refs.flashBoomSound.SoundId = CONFIG.FLASH_SOUND_ID refs.flashBoomSound.Volume = 1 refs.flashBoomSound.Parent = SoundService
end
local function preloadImage(imageId)
	local t = Instance.new("ImageLabel") t.Image = imageId pcall(function() ContentProvider:PreloadAsync({t}) end) t:Destroy()
end
local function triggerFlash()
	if state.flashRunning then return end
	state.flashRunning = true
	while features.femboyFlash do
		if state.flashOnCooldown then task.wait(0.1) continue end
		state.flashOnCooldown = true
		if #resolvedImageIds == 0 then state.flashOnCooldown = false task.wait(1) continue end
		local img = resolvedImageIds[math.random(1, #resolvedImageIds)]
		preloadImage(img)
		refs.flashBoomSound:Stop() refs.flashBoomSound:Play()
		refs.flashImage.Image = img refs.flashImage.ImageTransparency = 0 refs.flashImage.Visible = true
		task.wait(CONFIG.FLASH_HOLD_TIME)
		local tw = TweenService:Create(refs.flashImage, TweenInfo.new(CONFIG.FLASH_FADE_OUT_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1})
		tw:Play() tw.Completed:Wait()
		refs.flashImage.Visible = false
		local st = tick()
		while tick() - st < state.flashCurrentCooldown and features.femboyFlash do task.wait(0.05) end
		state.flashOnCooldown = false
	end
	state.flashRunning = false
end
task.spawn(function()
	for _, id in ipairs(CONFIG.FLASH_CATALOG_IDS) do table.insert(resolvedImageIds, "rbxthumb://type=Asset&id="..id.."&w=768&h=432") end
	for _, imgId in ipairs(resolvedImageIds) do preloadImage(imgId) end
	state.flashImagesReady = true
end)
-- Menu frame
do
	local ok = pcall(function() local t = Instance.new("CanvasGroup") t:Destroy() end)
	if ok then
		refs.menuFrame = Instance.new("CanvasGroup")
		refs.menuFrame.GroupTransparency = 1
	else
		refs.menuFrame = Instance.new("Frame")
	end
	refs.menuFrame.Size = UDim2.new(0,540,0,440)
	refs.menuFrame.Position = UDim2.new(0.5,-270,0.5,-220)
	refs.menuFrame.BackgroundColor3 = THEME.background
	refs.menuFrame.BorderSizePixel = 0
	refs.menuFrame.Visible = false
	refs.menuFrame.ZIndex = 200
	refs.menuFrame.Parent = refs.screenGui
	Instance.new("UICorner", refs.menuFrame).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", refs.menuFrame).Color = THEME.border
	createSnowContainer(refs.menuFrame)
end
-- Header
do
	local header = Instance.new("Frame") header.Size = UDim2.new(1,0,0,48) header.BackgroundColor3 = THEME.backgroundLight header.BorderSizePixel = 0 header.ZIndex = 210 header.Parent = refs.menuFrame
	Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)
	local hf = Instance.new("Frame") hf.Size = UDim2.new(1,0,0,10) hf.Position = UDim2.new(0,0,1,-10) hf.BackgroundColor3 = THEME.backgroundLight hf.BorderSizePixel = 0 hf.ZIndex = 209 hf.Parent = header
	local ta = Instance.new("Frame") ta.Size = UDim2.new(1,0,0,3) ta.BackgroundColor3 = THEME.primary ta.BorderSizePixel = 0 ta.ZIndex = 211 ta.Parent = header
	trackTheme(ta, "BackgroundColor3", "primary")
	Instance.new("UICorner", ta).CornerRadius = UDim.new(0, 8)
	local ag = Instance.new("UIGradient") ag.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,THEME.primaryDark),ColorSequenceKeypoint.new(0.5,THEME.primaryLight),ColorSequenceKeypoint.new(1,THEME.primaryDark)}) ag.Parent = ta
	task.spawn(function() local o = 0 while ta and ta.Parent do o = (o+0.01)%1 ag.Offset = Vector2.new(math.sin(o*math.pi*2)*0.3,0) ag.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,THEME.primaryDark),ColorSequenceKeypoint.new(0.5,THEME.primaryLight),ColorSequenceKeypoint.new(1,THEME.primaryDark)}) task.wait(0.02) end end)
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			state.draggingMenu = true
			local mp = UserInputService:GetMouseLocation()
			state.dragOffset = Vector2.new(mp.X - refs.menuFrame.AbsolutePosition.X, mp.Y - refs.menuFrame.AbsolutePosition.Y)
		end
	end)
	
	-- NUKE SYMBOL LOGO IN TOP RIGHT
	local nukeLogo = Instance.new("ImageLabel")
	nukeLogo.Name = "NukeLogo"
	nukeLogo.Size = UDim2.new(0, 36, 0, 36)
	nukeLogo.Position = UDim2.new(1, -44, 0, 6)
	nukeLogo.BackgroundTransparency = 1
	nukeLogo.Image = "rbxassetid://17702655"
	nukeLogo.ZIndex = 215
	nukeLogo.Parent = header
	
	local tl = Instance.new("TextLabel") tl.Size = UDim2.new(0,250,0,20) tl.Position = UDim2.new(0,12,0,7) tl.BackgroundTransparency = 1 tl.Font = Enum.Font.GothamBlack tl.Text = "clarification v2" tl.TextColor3 = THEME.text tl.TextSize = 17 tl.TextXAlignment = Enum.TextXAlignment.Left tl.ZIndex = 212 tl.Parent = header
	local tg = Instance.new("UIGradient") tg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,THEME.text),ColorSequenceKeypoint.new(0.5,THEME.primaryLight),ColorSequenceKeypoint.new(1,THEME.text)}) tg.Parent = tl
	task.spawn(function() local o = 0 while tl and tl.Parent do o = (o+0.02)%2 tg.Offset = Vector2.new(o-0.5,0) tg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,THEME.text),ColorSequenceKeypoint.new(0.5,THEME.primaryLight),ColorSequenceKeypoint.new(1,THEME.text)}) task.wait(0.03) end end)
	local stl = Instance.new("TextButton") stl.Size = UDim2.new(0,200,0,12) stl.Position = UDim2.new(0,12,0,28) stl.BackgroundTransparency = 1 stl.Font = Enum.Font.Gotham stl.Text = "https://discord.gg/dMEdBSeUQ5" stl.TextColor3 = THEME.textMuted stl.TextSize = 9 stl.TextXAlignment = Enum.TextXAlignment.Left stl.ZIndex = 212 stl.Parent = header
	stl.MouseButton1Click:Connect(function() openDiscordModal() end)
	stl.MouseEnter:Connect(function() TweenService:Create(stl, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(114,137,218)}):Play() end)
	stl.MouseLeave:Connect(function() TweenService:Create(stl, TweenInfo.new(0.15), {TextColor3 = THEME.textMuted}):Play() end)
	local vb = Instance.new("Frame") vb.Size = UDim2.new(0,42,0,18) vb.Position = UDim2.new(1,-94,0,15) vb.BackgroundColor3 = THEME.primary vb.BackgroundTransparency = 0.8 vb.BorderSizePixel = 0 vb.ZIndex = 212 vb.Parent = header trackTheme(vb, "BackgroundColor3", "primary") Instance.new("UICorner", vb).CornerRadius = UDim.new(0, 4)
	local vs = Instance.new("UIStroke") vs.Thickness = 1 vs.Color = THEME.primary vs.Parent = vb trackTheme(vs, "Color", "primary")
	local vt = Instance.new("TextLabel") vt.Size = UDim2.new(1,0,1,0) vt.BackgroundTransparency = 1 vt.Font = Enum.Font.GothamBold vt.Text = "v3.2" vt.TextColor3 = THEME.primaryLight vt.TextSize = 10 vt.ZIndex = 213 vt.Parent = vb trackTheme(vt, "TextColor3", "primaryLight")
end
-- Sidebar
do
	local sidebar = Instance.new("Frame") sidebar.Size = UDim2.new(0,110,1,-68) sidebar.Position = UDim2.new(0,8,0,56) sidebar.BackgroundColor3 = THEME.backgroundLight sidebar.BackgroundTransparency = 0.3 sidebar.BorderSizePixel = 0 sidebar.ZIndex = 210 sidebar.Parent = refs.menuFrame
	Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 6)
	Instance.new("UIStroke", sidebar).Color = THEME.border
	local tabs = {"Movement", "Visuals", "Settings"}
	for i, tabName in ipairs(tabs) do
		local tb = Instance.new("TextButton") tb.Size = UDim2.new(1,-8,0,32) tb.Position = UDim2.new(0,4,0,4+(i-1)*36) tb.BackgroundColor3 = i==1 and THEME.primary or THEME.backgroundLighter tb.BackgroundTransparency = i==1 and 0.8 or 0.5 tb.Font = Enum.Font.GothamBold tb.Text = tabName tb.TextColor3 = i==1 and THEME.text or THEME.textMuted tb.TextSize = 11 tb.BorderSizePixel = 0 tb.ZIndex = 211 tb.Parent = sidebar
		Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 4)
		local ind = Instance.new("Frame") ind.Name = "Indicator" ind.Size = UDim2.new(0,3,0.6,0) ind.Position = UDim2.new(0,0,0.2,0) ind.BackgroundColor3 = THEME.primary ind.BackgroundTransparency = i==1 and 0 or 1 ind.BorderSizePixel = 0 ind.ZIndex = 212 ind.Parent = tb
		Instance.new("UICorner", ind).CornerRadius = UDim.new(0, 2)
		trackTheme(ind, "BackgroundColor3", "primary")
		tb.MouseEnter:Connect(function() if state.currentTab ~= tabName then TweenService:Create(tb, TweenInfo.new(0.15), {BackgroundTransparency = 0.6, TextColor3 = THEME.textDim}):Play() end end)
		tb.MouseLeave:Connect(function() if state.currentTab ~= tabName then TweenService:Create(tb, TweenInfo.new(0.15), {BackgroundTransparency = 0.5, TextColor3 = THEME.textMuted}):Play() end end)
		tabButtons[tabName] = tb
		tb.MouseButton1Click:Connect(function()
			if state.currentTab == tabName then return end
			for name, btn in pairs(tabButtons) do
				local active = name == tabName
				TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = active and THEME.primary or THEME.backgroundLighter, BackgroundTransparency = active and 0.8 or 0.5, TextColor3 = active and THEME.text or THEME.textMuted}):Play()
				local indicator = btn:FindFirstChild("Indicator")
				if indicator then TweenService:Create(indicator, TweenInfo.new(0.2), {BackgroundTransparency = active and 0 or 1}):Play() end
			end
			for name, content in pairs(tabContents) do content.Visible = name == tabName end
			state.currentTab = tabName
		end)
	end
end
local contentArea = Instance.new("Frame") contentArea.Size = UDim2.new(1,-130,1,-68) contentArea.Position = UDim2.new(0,122,0,56) contentArea.BackgroundTransparency = 1 contentArea.ClipsDescendants = true contentArea.ZIndex = 210 contentArea.Parent = refs.menuFrame
-- UI builders
local function createSectionHeader(parent, text, yPos)
	local lbl = Instance.new("TextLabel") lbl.Size = UDim2.new(1,0,0,18) lbl.Position = UDim2.new(0,0,0,yPos) lbl.BackgroundTransparency = 1 lbl.Font = Enum.Font.GothamBold lbl.Text = "-- "..text.." --" lbl.TextColor3 = THEME.textMuted lbl.TextSize = 9 lbl.ZIndex = 212 lbl.Parent = parent
end
local function createToggle(parent, name, key, yPos, description, bindKey)
	local container = Instance.new("Frame") container.Size = UDim2.new(1,0,0,38) container.Position = UDim2.new(0,0,0,yPos) container.BackgroundColor3 = THEME.backgroundLighter container.BackgroundTransparency = 0.5 container.BorderSizePixel = 0 container.ZIndex = 211 container.Parent = parent
	Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
	local cS = Instance.new("UIStroke") cS.Thickness = 1 cS.Color = THEME.border cS.Transparency = 0.5 cS.Parent = container
	container.MouseEnter:Connect(function() TweenService:Create(container, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play() TweenService:Create(cS, TweenInfo.new(0.15), {Color = THEME.primary, Transparency = 0.3}):Play() end)
	container.MouseLeave:Connect(function() TweenService:Create(container, TweenInfo.new(0.15), {BackgroundTransparency = 0.5}):Play() TweenService:Create(cS, TweenInfo.new(0.15), {Color = THEME.border, Transparency = 0.5}):Play() end)
	do
		local rightOffset = bindKey and -100 or -60
		local l = Instance.new("TextLabel") l.Size = UDim2.new(1,rightOffset,0,16) l.Position = UDim2.new(0,10,0,4) l.BackgroundTransparency = 1 l.Font = Enum.Font.GothamSemibold l.Text = name l.TextColor3 = THEME.text l.TextSize = 11 l.TextXAlignment = Enum.TextXAlignment.Left l.ZIndex = 212 l.Parent = container
		local d = Instance.new("TextLabel") d.Size = UDim2.new(1,rightOffset,0,12) d.Position = UDim2.new(0,10,0,21) d.BackgroundTransparency = 1 d.Font = Enum.Font.Gotham d.Text = description or "" d.TextColor3 = THEME.textMuted d.TextSize = 8 d.TextXAlignment = Enum.TextXAlignment.Left d.ZIndex = 212 d.Parent = container
	end
	-- Keybind button (only if bindKey is provided)
	if bindKey then
		do
			local kb = Instance.new("TextButton")
			kb.Size = UDim2.new(0, 38, 0, 20)
			kb.Position = UDim2.new(1, -84, 0.5, -10)
			kb.BackgroundColor3 = THEME.background
			kb.BorderSizePixel = 0
			kb.Font = Enum.Font.GothamBold
			kb.Text = getKeyName(keybinds[bindKey])
			kb.TextColor3 = THEME.textDim
			kb.TextSize = 8
			kb.ZIndex = 213
			kb.Parent = container
			Instance.new("UICorner", kb).CornerRadius = UDim.new(0, 4)
			local kbStroke = Instance.new("UIStroke") kbStroke.Thickness = 1 kbStroke.Color = THEME.border kbStroke.Parent = kb
			rebindButtons[bindKey] = kb
			kb.MouseButton1Click:Connect(function()
				if rebindingKey then
					-- Cancel previous rebind
					local prevBtn = rebindButtons[rebindingKey]
					if prevBtn and prevBtn.Parent then
						prevBtn.Text = getKeyName(keybinds[rebindingKey])
						prevBtn.TextColor3 = THEME.textDim
						TweenService:Create(prevBtn, TweenInfo.new(0.15), {BackgroundColor3 = THEME.background}):Play()
					end
				end
				rebindingKey = bindKey
				kb.Text = "..."
				kb.TextColor3 = THEME.primary
				TweenService:Create(kb, TweenInfo.new(0.15), {BackgroundColor3 = THEME.primaryDark}):Play()
				showNotification("Press any key to bind " .. name, Color3.fromRGB(168, 85, 247))
			end)
		end
	end
	local tBg = Instance.new("Frame") tBg.Size = UDim2.new(0,36,0,20) tBg.Position = UDim2.new(1,-44,0.5,-10) tBg.BackgroundColor3 = features[key] and THEME.primary or THEME.backgroundLighter tBg.BorderSizePixel = 0 tBg.ZIndex = 212 tBg.Parent = container
	Instance.new("UICorner", tBg).CornerRadius = UDim.new(0, 10)
	local tSt = Instance.new("UIStroke") tSt.Thickness = 1 tSt.Color = features[key] and THEME.primary or THEME.border tSt.Parent = tBg
	local tK = Instance.new("Frame") tK.Size = UDim2.new(0,16,0,16) tK.Position = features[key] and UDim2.new(1,-18,0,2) or UDim2.new(0,2,0,2) tK.BackgroundColor3 = THEME.text tK.BorderSizePixel = 0 tK.ZIndex = 213 tK.Parent = tBg
	Instance.new("UICorner", tK).CornerRadius = UDim.new(1, 0)
	local sD = Instance.new("Frame") sD.Size = UDim2.new(0,6,0,6) sD.Position = UDim2.new(0.5,-3,0.5,-3) sD.BackgroundColor3 = features[key] and THEME.success or THEME.danger sD.BorderSizePixel = 0 sD.ZIndex = 214 sD.Parent = tK
	Instance.new("UICorner", sD).CornerRadius = UDim.new(1, 0)
	local tBtn = Instance.new("TextButton") tBtn.Size = UDim2.new(0,36,0,20) tBtn.Position = UDim2.new(1,-44,0.5,-10) tBtn.BackgroundTransparency = 1 tBtn.Text = "" tBtn.ZIndex = 215 tBtn.Parent = container
	local function upd()
		local isOn = features[key]
		TweenService:Create(tBg, TweenInfo.new(0.2), {BackgroundColor3 = isOn and THEME.primary or THEME.backgroundLighter}):Play()
		TweenService:Create(tSt, TweenInfo.new(0.2), {Color = isOn and THEME.primary or THEME.border}):Play()
		TweenService:Create(tK, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = isOn and UDim2.new(1,-18,0,2) or UDim2.new(0,2,0,2)}):Play()
		TweenService:Create(sD, TweenInfo.new(0.2), {BackgroundColor3 = isOn and THEME.success or THEME.danger}):Play()
	end
	tBtn.MouseButton1Click:Connect(function()
		features[key] = not features[key]
		upd()
		showToggleNotification(name, features[key])
		if key == "velocityDisplay" then refs.velocityLabel.Visible = features[key]
		elseif key == "velocityGraph" then refs.graphContainer.Visible = features[key]
		elseif key == "esp" then if not features.esp then for _, dd in pairs(espData) do if dd.highlight then dd.highlight:Destroy() end if dd.nameGui then dd.nameGui:Destroy() end if dd.healthGui then dd.healthGui:Destroy() end end espData = {} end
		elseif key == "fullbright" then if features.fullbright then enableFullbright() else disableFullbright() end
		elseif key == "snow" then if features.snow then createSnowContainer(refs.menuFrame) else if refs.snowContainer and refs.snowContainer.Parent then refs.snowContainer:ClearAllChildren() end snowParticles = {} end
		elseif key == "miniKeyboard" then if refs.keystrokeDisplay then refs.keystrokeDisplay.Visible = features.miniKeyboard end
		elseif key == "hitmarker" then if features.hitmarker then setupHitmarkerConnections() else for _, conn in pairs(hitmarkerConnections) do if conn then pcall(function() conn:Disconnect() end) end end hitmarkerConnections = {} end
		elseif key == "chams" then if not features.chams then for _, h in pairs(chamsHighlights) do if h and h.Parent then h:Destroy() end end chamsHighlights = {} end
		elseif key == "fovChanger" then if not features.fovChanger and state.originalFieldOfView then camera.FieldOfView = state.originalFieldOfView end
		elseif key == "worldModulation" then if not features.worldModulation then resetWorldModulation() end
		elseif key == "fogControl" then if not features.fogControl then Lighting.FogEnd = originalLighting.FogEnd Lighting.FogStart = originalLighting.FogStart Lighting.FogColor = originalLighting.FogColor end
		elseif key == "ambientColor" then if not features.ambientColor then Lighting.Ambient = originalLighting.Ambient Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient end
		elseif key == "worldTransparency" then if not features.worldTransparency then resetWorldTransparency() end
		elseif key == "femboyFlash" then if features[key] then if state.flashImagesReady then task.spawn(triggerFlash) end else refs.flashImage.ImageTransparency = 1 refs.flashImage.Visible = false end
		end
	end)
end
local function createSlider(parent, name, yPos, getValue, setValue, minVal, maxVal, formatStr)
	local container = Instance.new("Frame") container.Size = UDim2.new(1,0,0,46) container.Position = UDim2.new(0,0,0,yPos) container.BackgroundColor3 = THEME.backgroundLighter container.BackgroundTransparency = 0.5 container.BorderSizePixel = 0 container.ZIndex = 211 container.Parent = parent
	Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
	Instance.new("UIStroke", container).Color = THEME.border
	local fmt = formatStr or "%.0f%%"
	local function fmtV(v) if fmt == "%.0f%%" then return string.format(fmt, v*100) else return string.format(fmt, minVal+v*(maxVal-minVal)) end end
	do local l = Instance.new("TextLabel") l.Size = UDim2.new(1,-50,0,16) l.Position = UDim2.new(0,10,0,4) l.BackgroundTransparency = 1 l.Font = Enum.Font.GothamSemibold l.Text = name l.TextColor3 = THEME.text l.TextSize = 10 l.TextXAlignment = Enum.TextXAlignment.Left l.ZIndex = 212 l.Parent = container end
	local vl = Instance.new("TextLabel") vl.Size = UDim2.new(0,50,0,16) vl.Position = UDim2.new(1,-58,0,4) vl.BackgroundTransparency = 1 vl.Font = Enum.Font.GothamBold vl.Text = fmtV(getValue()) vl.TextColor3 = THEME.primary vl.TextSize = 10 vl.TextXAlignment = Enum.TextXAlignment.Right vl.ZIndex = 212 vl.Parent = container trackTheme(vl, "TextColor3", "primary")
	local sb = Instance.new("Frame") sb.Size = UDim2.new(1,-20,0,6) sb.Position = UDim2.new(0,10,0,28) sb.BackgroundColor3 = THEME.background sb.BorderSizePixel = 0 sb.ZIndex = 212 sb.Parent = container Instance.new("UICorner", sb).CornerRadius = UDim.new(0, 3)
	local sf = Instance.new("Frame") sf.Size = UDim2.new(getValue(),0,1,0) sf.BackgroundColor3 = THEME.primary sf.BorderSizePixel = 0 sf.ZIndex = 213 sf.Parent = sb trackTheme(sf, "BackgroundColor3", "primary") Instance.new("UICorner", sf).CornerRadius = UDim.new(0, 3)
	local kn = Instance.new("Frame") kn.Size = UDim2.new(0,14,0,14) kn.Position = UDim2.new(getValue(),-7,0.5,-7) kn.BackgroundColor3 = THEME.text kn.BorderSizePixel = 0 kn.ZIndex = 214 kn.Parent = sb Instance.new("UICorner", kn).CornerRadius = UDim.new(1, 0)
	local ks = Instance.new("UIStroke") ks.Thickness = 1 ks.Color = THEME.primary ks.Parent = kn trackTheme(ks, "Color", "primary")
	local function updS(pct) pct = math.clamp(pct,0,1) setValue(pct) sf.Size = UDim2.new(pct,0,1,0) kn.Position = UDim2.new(pct,-7,0.5,-7) vl.Text = fmtV(pct) end
	sb.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then updS((input.Position.X-sb.AbsolutePosition.X)/sb.AbsoluteSize.X) state.activeDragSlider = {update = updS, bar = sb} end end)
end
local function createColorSlider(parent, yPos, labelText, getHue, setHue, setColorCb, getSat, setSat, getVal, setVal)
	local container = Instance.new("Frame") container.Size = UDim2.new(1,0,0,54) container.Position = UDim2.new(0,0,0,yPos) container.BackgroundColor3 = THEME.backgroundLighter container.BackgroundTransparency = 0.5 container.BorderSizePixel = 0 container.ZIndex = 211 container.Parent = parent
	Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
	Instance.new("UIStroke", container).Color = THEME.border
	do local l = Instance.new("TextLabel") l.Size = UDim2.new(1,-50,0,16) l.Position = UDim2.new(0,10,0,4) l.BackgroundTransparency = 1 l.Font = Enum.Font.GothamSemibold l.Text = labelText or "Color" l.TextColor3 = THEME.text l.TextSize = 10 l.TextXAlignment = Enum.TextXAlignment.Left l.ZIndex = 212 l.Parent = container end
	local function getCurColor() return Color3.fromHSV(getHue(), getSat and getSat() or 0.66, getVal and getVal() or 0.97) end
	local pv = Instance.new("Frame") pv.Size = UDim2.new(0,16,0,16) pv.Position = UDim2.new(1,-26,0,4) pv.BackgroundColor3 = getCurColor() pv.BorderSizePixel = 0 pv.ZIndex = 213 pv.Parent = container Instance.new("UICorner", pv).CornerRadius = UDim.new(0, 4) Instance.new("UIStroke", pv).Color = THEME.border
	local sb = Instance.new("Frame") sb.Size = UDim2.new(1,-20,0,10) sb.Position = UDim2.new(0,10,0,24) sb.BackgroundColor3 = Color3.new(1,1,1) sb.BorderSizePixel = 0 sb.ZIndex = 212 sb.Parent = container Instance.new("UICorner", sb).CornerRadius = UDim.new(0, 3)
	Instance.new("UIGradient", sb).Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromHSV(0,0.8,1)),ColorSequenceKeypoint.new(0.16,Color3.fromHSV(0.16,0.8,1)),ColorSequenceKeypoint.new(0.33,Color3.fromHSV(0.33,0.8,1)),ColorSequenceKeypoint.new(0.5,Color3.fromHSV(0.5,0.8,1)),ColorSequenceKeypoint.new(0.66,Color3.fromHSV(0.66,0.8,1)),ColorSequenceKeypoint.new(0.83,Color3.fromHSV(0.83,0.8,1)),ColorSequenceKeypoint.new(1,Color3.fromHSV(1,0.8,1))})
	local kn = Instance.new("Frame") kn.Size = UDim2.new(0,12,0,14) kn.Position = UDim2.new(getHue(),-6,0.5,-7) kn.BackgroundColor3 = THEME.text kn.BorderSizePixel = 0 kn.ZIndex = 214 kn.Parent = sb Instance.new("UICorner", kn).CornerRadius = UDim.new(0, 3) Instance.new("UIStroke", kn).Color = Color3.new(0,0,0)
	local svBar = Instance.new("Frame") svBar.Size = UDim2.new(1,-20,0,10) svBar.Position = UDim2.new(0,10,0,38) svBar.BackgroundColor3 = Color3.new(1,1,1) svBar.BorderSizePixel = 0 svBar.ZIndex = 212 svBar.Parent = container Instance.new("UICorner", svBar).CornerRadius = UDim.new(0, 3)
	local svGrad = Instance.new("UIGradient") svGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),ColorSequenceKeypoint.new(0.5,Color3.fromHSV(getHue(),0.8,1)),ColorSequenceKeypoint.new(1,Color3.new(1,1,1))}) svGrad.Parent = svBar
	local initSV = 0.5
	if getSat and getVal then local s,v = getSat(),getVal() if v < 0.5 then initSV = v elseif s < 0.5 then initSV = 0.5+(1-s)*0.5 else initSV = 0.5 end end
	local svKnob = Instance.new("Frame") svKnob.Size = UDim2.new(0,12,0,14) svKnob.Position = UDim2.new(initSV,-6,0.5,-7) svKnob.BackgroundColor3 = THEME.text svKnob.BorderSizePixel = 0 svKnob.ZIndex = 214 svKnob.Parent = svBar Instance.new("UICorner", svKnob).CornerRadius = UDim.new(0, 3) Instance.new("UIStroke", svKnob).Color = Color3.new(0,0,0)
	local function updatePreview() pv.BackgroundColor3 = getCurColor() svGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),ColorSequenceKeypoint.new(0.5,Color3.fromHSV(getHue(),0.8,1)),ColorSequenceKeypoint.new(1,Color3.new(1,1,1))}) end
	local function updHue(pct) pct = math.clamp(pct,0,0.999) setHue(pct) kn.Position = UDim2.new(pct,-6,0.5,-7) updatePreview() if setColorCb then setColorCb(pct) end end
	local function updSV(pct)
		pct = math.clamp(pct,0,1) svKnob.Position = UDim2.new(pct,-6,0.5,-7)
		local sat, val if pct <= 0.5 then sat = 0.8 val = pct*2 else sat = 1-(pct-0.5)*2 val = 1 end
		sat = math.clamp(sat,0,1) val = math.clamp(val,0,1)
		if setSat then setSat(sat) end if setVal then setVal(val) end
		updatePreview() if setColorCb then setColorCb(getHue()) end
	end
	sb.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then updHue((input.Position.X-sb.AbsolutePosition.X)/sb.AbsoluteSize.X) state.activeDragSlider = {update=updHue, bar=sb} end end)
	svBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then updSV((input.Position.X-svBar.AbsolutePosition.X)/svBar.AbsoluteSize.X) state.activeDragSlider = {update=updSV, bar=svBar} end end)
end
UserInputService.InputChanged:Connect(function(input)
	if state.activeDragSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
		local bar = state.activeDragSlider.bar
		if bar and bar.Parent then state.activeDragSlider.update((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X) end
	end
end)
-- Movement tab (with keybind buttons)
do
	local tab = Instance.new("ScrollingFrame") tab.Size = UDim2.new(1,0,1,0) tab.BackgroundTransparency = 1 tab.BorderSizePixel = 0 tab.ScrollBarThickness = 3 tab.ScrollBarImageColor3 = THEME.primary tab.CanvasSize = UDim2.new(0,0,0,310) tab.Visible = true tab.ZIndex = 211 tab.Parent = contentArea
	tabContents["Movement"] = tab
	trackTheme(tab, "ScrollBarImageColor3", "primary")
	createToggle(tab, "Pixel Surf", "pixelSurf", 0, "Hold key near walls to surf", "pixelSurf")
	createToggle(tab, "Bunny Hop", "bhop", 42, "Hold key + WASD to bhop", "bhop")
	createToggle(tab, "Jump Bug", "jumpBug", 84, "Press key while jumping for boost", "jumpBug")
	createToggle(tab, "Edge Bug", "edgebug", 126, "Hold key near edges to land smoothly", "edgebug")
	createSlider(tab, "Edgebug Volume", 168, function() return state.edgebugVolume end, function(v) state.edgebugVolume = v if refs.edgebugSound then refs.edgebugSound.Volume = v end end, 0, 1)
	createToggle(tab, "Auto Wallhop", "autoWallhop", 218, "Hold key near walls to wallhop", "autoWallhop")
end
-- Visuals tab
do
	local tab = Instance.new("ScrollingFrame") tab.Size = UDim2.new(1,0,1,0) tab.BackgroundTransparency = 1 tab.BorderSizePixel = 0 tab.ScrollBarThickness = 3 tab.ScrollBarImageColor3 = THEME.primary tab.CanvasSize = UDim2.new(0,0,0,1400) tab.Visible = false tab.ZIndex = 211 tab.Parent = contentArea
	tabContents["Visuals"] = tab
	trackTheme(tab, "ScrollBarImageColor3", "primary")
	local y = 0
	createSectionHeader(tab, "ESP & CHAMS", y) y+=20
	createToggle(tab, "ESP Boxes", "esp", y, "Outline boxes through walls") y+=42
	createColorSlider(tab, y, "ESP Color", function() return espSettings.boxHue end, function(v) espSettings.boxHue = v end, function(h) espSettings.boxColor = Color3.fromHSV(h, espSettings.boxSat, espSettings.boxVal) end, function() return espSettings.boxSat end, function(v) espSettings.boxSat = v end, function() return espSettings.boxVal end, function(v) espSettings.boxVal = v end) y+=58
	createToggle(tab, "Chams", "chams", y, "Highlight players through walls") y+=42
	createColorSlider(tab, y, "Chams Fill", function() return chamsSettings.chamHue end, function(v) chamsSettings.chamHue = v end, function(h) chamsSettings.fillColor = Color3.fromHSV(h, chamsSettings.chamSat, chamsSettings.chamVal) end, function() return chamsSettings.chamSat end, function(v) chamsSettings.chamSat = v end, function() return chamsSettings.chamVal end, function(v) chamsSettings.chamVal = v end) y+=58
	createColorSlider(tab, y, "Chams Outline", function() return chamsSettings.outlineHue end, function(v) chamsSettings.outlineHue = v end, function(h) chamsSettings.outlineColor = Color3.fromHSV(h, chamsSettings.outlineSat, chamsSettings.outlineVal) end, function() return chamsSettings.outlineSat end, function(v) chamsSettings.outlineSat = v end, function() return chamsSettings.outlineVal end, function(v) chamsSettings.outlineVal = v end) y+=58
	createSlider(tab, "Fill Transparency", y, function() return chamsSettings.fillTransparency end, function(v) chamsSettings.fillTransparency = v end, 0, 1) y+=50
	createSlider(tab, "Outline Transparency", y, function() return chamsSettings.outlineTransparency end, function(v) chamsSettings.outlineTransparency = v end, 0, 1) y+=50
	createSlider(tab, "Pearlescent Speed", y, function() return chamsSettings.pearlescentSpeed/3 end, function(v) chamsSettings.pearlescentSpeed = v*3 end, 0, 3, "%.1fx") y+=50
	createSectionHeader(tab, "HUD", y) y+=20
	createToggle(tab, "Velocity Display", "velocityDisplay", y, "Show speed on screen") y+=42
	createToggle(tab, "Velocity Graph", "velocityGraph", y, "Animated speed graph") y+=42
	createToggle(tab, "Hitmarker", "hitmarker", y, "X flash on damage dealt") y+=42
	createSectionHeader(tab, "KEYSTROKES", y) y+=20
	createToggle(tab, "Mini Keyboard", "miniKeyboard", y, "On-screen keyboard") y+=42
	createSectionHeader(tab, "LIGHTING", y) y+=20
	createToggle(tab, "Fullbright", "fullbright", y, "Remove darkness") y+=42
	createSectionHeader(tab, "WORLD", y) y+=20
	createToggle(tab, "World Modulation", "worldModulation", y, "Brightness & time control") y+=42
	createSlider(tab, "Brightness", y, function() return worldSettings.brightness end, function(v) worldSettings.brightness = v end, 0, 2, "%.1f") y+=50
	createSlider(tab, "Time of Day", y, function() return worldSettings.clockTime/24 end, function(v) worldSettings.clockTime = v*24 end, 0, 24, "%.1f hr") y+=50
	createToggle(tab, "Fog Control", "fogControl", y, "Fog density and color") y+=42
	createSlider(tab, "Fog Density", y, function() return worldSettings.fogDensity end, function(v) worldSettings.fogDensity = v end, 0, 1) y+=50
	createColorSlider(tab, y, "Fog Color", function() return worldSettings.fogHue end, function(v) worldSettings.fogHue = v end, function(h) worldSettings.fogColor = Color3.fromHSV(h, worldSettings.fogSat, worldSettings.fogVal) end, function() return worldSettings.fogSat end, function(v) worldSettings.fogSat = v end, function() return worldSettings.fogVal end, function(v) worldSettings.fogVal = v end) y+=58
	createToggle(tab, "Ambient Color", "ambientColor", y, "Change ambient lighting") y+=42
	createSlider(tab, "Ambient Red", y, function() return worldSettings.ambientR end, function(v) worldSettings.ambientR = v end, 0, 255, "%.0f") y+=50
	createSlider(tab, "Ambient Green", y, function() return worldSettings.ambientG end, function(v) worldSettings.ambientG = v end, 0, 255, "%.0f") y+=50
	createSlider(tab, "Ambient Blue", y, function() return worldSettings.ambientB end, function(v) worldSettings.ambientB = v end, 0, 255, "%.0f") y+=50
	createToggle(tab, "World Transparency", "worldTransparency", y, "Make world see-through") y+=42
	createSlider(tab, "Transparency", y, function() return worldSettings.transparency end, function(v) worldSettings.transparency = v end, 0, 0.95, "%.0f%%") y+=50
	createSectionHeader(tab, "CAMERA", y) y+=20
	createToggle(tab, "FOV Changer", "fovChanger", y, "Change field of view") y+=42
	createSlider(tab, "FOV Value", y, function() return (state.fovValue-20)/100 end, function(v) state.fovValue = 20+v*100 end, 20, 120, "%.0f") y+=50
	tab.CanvasSize = UDim2.new(0, 0, 0, y + 10)
end
-- Settings tab
do
	local tab = Instance.new("ScrollingFrame") tab.Size = UDim2.new(1,0,1,0) tab.BackgroundTransparency = 1 tab.BorderSizePixel = 0 tab.ScrollBarThickness = 3 tab.ScrollBarImageColor3 = THEME.primary tab.CanvasSize = UDim2.new(0,0,0,400) tab.Visible = false tab.ZIndex = 211 tab.Parent = contentArea
	tabContents["Settings"] = tab
	trackTheme(tab, "ScrollBarImageColor3", "primary")
	local y = 0
	createToggle(tab, "Snow Effect", "snow", y, "Falling snow in the menu") y+=42
	createToggle(tab, "Keystroke Sounds", "keystrokes", y, "Click sounds on key press") y+=42
	createSlider(tab, "Keystroke Volume", y, function() return state.keystrokeVolume end, function(v) state.keystrokeVolume = v for _, s in ipairs(keystrokeSounds) do if s then s.Volume = v end end end, 0, 1) y+=50
	createColorSlider(tab, y, "Menu Accent Color", function() return state.themeHue end, function(v) state.themeHue = v end, function() updateThemeColors() end, function() return state.themeSat end, function(v) state.themeSat = v end, function() return state.themeVal end, function(v) state.themeVal = v end) y+=58
	createSectionHeader(tab, "FEMBOY FLASH", y) y+=20
	createToggle(tab, "Femboy Flash", "femboyFlash", y, "Random fullscreen images on loop") y+=42
	createSlider(tab, "Flash Cooldown", y, function() return (state.flashCurrentCooldown-1)/19 end, function(v) state.flashCurrentCooldown = 1+v*19 end, 1, 20, "%.0fs") y+=50
	do
		local cc = Instance.new("Frame") cc.Size = UDim2.new(1,0,0,40) cc.Position = UDim2.new(0,0,0,y) cc.BackgroundColor3 = THEME.primary cc.BackgroundTransparency = 0.85 cc.BorderSizePixel = 0 cc.ZIndex = 212 cc.Parent = tab trackTheme(cc, "BackgroundColor3", "primary") Instance.new("UICorner", cc).CornerRadius = UDim.new(0, 6)
		local cs = Instance.new("UIStroke") cs.Thickness = 1 cs.Color = THEME.primary cs.Transparency = 0.5 cs.Parent = cc trackTheme(cs, "Color", "primary")
		local ct = Instance.new("TextLabel") ct.Size = UDim2.new(1,-12,1,0) ct.Position = UDim2.new(0,6,0,0) ct.BackgroundTransparency = 1 ct.Font = Enum.Font.Gotham ct.Text = "clarification v2 v3.2" ct.TextColor3 = THEME.text ct.TextSize = 10 ct.ZIndex = 213 ct.Parent = cc
	end
	y += 50
	tab.CanvasSize = UDim2.new(0, 0, 0, y + 10)
end
-- Footer
do
	local footer = Instance.new("Frame") footer.Size = UDim2.new(1,-8,0,20) footer.Position = UDim2.new(0,4,1,-24) footer.BackgroundColor3 = THEME.backgroundLight footer.BackgroundTransparency = 0.5 footer.BorderSizePixel = 0 footer.ZIndex = 210 footer.Parent = refs.menuFrame Instance.new("UICorner", footer).CornerRadius = UDim.new(0, 4)
	local ft = Instance.new("TextButton") ft.Size = UDim2.new(1,-14,1,0) ft.Position = UDim2.new(0,7,0,0) ft.BackgroundTransparency = 1 ft.Font = Enum.Font.Gotham ft.Text = "https://discord.gg/dMEdBSeUQ5" ft.TextColor3 = THEME.textMuted ft.TextSize = 8 ft.ZIndex = 211 ft.Parent = footer
	ft.MouseButton1Click:Connect(function() openDiscordModal() end)
	ft.MouseEnter:Connect(function() TweenService:Create(ft, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(114,137,218)}):Play() end)
	ft.MouseLeave:Connect(function() TweenService:Create(ft, TweenInfo.new(0.15), {TextColor3 = THEME.textMuted}):Play() end)
	local sd = Instance.new("Frame") sd.Size = UDim2.new(0,6,0,6) sd.Position = UDim2.new(1,-14,0.5,-3) sd.BackgroundColor3 = THEME.success sd.BorderSizePixel = 0 sd.ZIndex = 211 sd.Parent = footer Instance.new("UICorner", sd).CornerRadius = UDim.new(1, 0)
	task.spawn(function() while sd and sd.Parent do TweenService:Create(sd, TweenInfo.new(0.5), {BackgroundTransparency = 0.5}):Play() task.wait(0.5) TweenService:Create(sd, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play() task.wait(0.5) end end)
end
createHitmarker()
createKeystrokeDisplay()
task.spawn(function() while true do task.wait(5) if features.hitmarker then setupHitmarkerConnections() end end end)
refs.velocityLabel.Visible = features.velocityDisplay
refs.graphContainer.Visible = features.velocityGraph
task.spawn(function() while true do task.wait(2) if features.worldTransparency then updateWorldTransparency() end end end)
-- Input handling with keybind support
local canvasGroupSupported = pcall(function() local t = Instance.new("CanvasGroup") t:Destroy() end)
UserInputService.InputBegan:Connect(function(input, gp)
	local kc = input.KeyCode
	if input.UserInputType == Enum.UserInputType.Keyboard and features.keystrokes then playKeystrokeSound() end
	-- Handle rebinding: if waiting for a key, assign it
	if rebindingKey and input.UserInputType == Enum.UserInputType.Keyboard then
		local bindName = rebindingKey
		-- Don't allow F (menu key) or Escape as binds
		if kc ~= Enum.KeyCode.F and kc ~= Enum.KeyCode.Escape then
			keybinds[bindName] = kc
			showNotification("Bound to " .. getKeyName(kc), Color3.fromRGB(34, 197, 94))
		else
			showNotification("Cancelled rebind", Color3.fromRGB(239, 68, 68))
		end
		-- Reset button appearance
		local btn = rebindButtons[bindName]
		if btn and btn.Parent then
			btn.Text = getKeyName(keybinds[bindName])
			btn.TextColor3 = THEME.textDim
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = THEME.background}):Play()
		end
		rebindingKey = nil
		return
	end
	if kc == Enum.KeyCode.F then
		if gp then return end
		state.menuOpen = not state.menuOpen
		UserInputService.MouseIconEnabled = state.menuOpen
		if state.menuOpen then
			refs.menuFrame.Visible = true
			if canvasGroupSupported then TweenService:Create(refs.menuFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play() end
		else
			if canvasGroupSupported then
				local fo = TweenService:Create(refs.menuFrame, TweenInfo.new(0.15), {GroupTransparency = 1}) fo:Play()
				fo.Completed:Connect(function() if not state.menuOpen then refs.menuFrame.Visible = false end end)
			else refs.menuFrame.Visible = false end
		end
		return
	end
	if gp or state.menuOpen then return end
	-- Standard movement keys
	if kc == Enum.KeyCode.W then state.keys.W = true end
	if kc == Enum.KeyCode.A then state.keys.A = true end
	if kc == Enum.KeyCode.S then state.keys.S = true end
	if kc == Enum.KeyCode.D then state.keys.D = true end
	if kc == Enum.KeyCode.Space then state.keys.Jump = true end
	-- Keybind-driven features
	if kc == keybinds.pixelSurf then state.keys.Surf = true end
	if kc == keybinds.jumpBug then state.keys.JumpBug = true end
	if kc == keybinds.edgebug and features.edgebug then
		state.autoEdgebugEnabled = true
		if state.hum then state.hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false) end
	end
	if kc == keybinds.autoWallhop and features.autoWallhop then state.wallhopHolding = true end
end)
UserInputService.InputEnded:Connect(function(input)
	local kc = input.KeyCode
	if kc == Enum.KeyCode.W then state.keys.W = false end
	if kc == Enum.KeyCode.A then state.keys.A = false end
	if kc == Enum.KeyCode.S then state.keys.S = false end
	if kc == Enum.KeyCode.D then state.keys.D = false end
	if kc == Enum.KeyCode.Space then state.keys.Jump = false end
	if kc == keybinds.pixelSurf then state.keys.Surf = false end
	if kc == keybinds.jumpBug then state.keys.JumpBug = false end
	if kc == keybinds.edgebug then
		state.autoEdgebugEnabled = false state.isGuiding = false state.isSliding = false state.edgeLanded = false state.isHangTime = false
		if state.hum then state.hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end
	end
	if kc == keybinds.autoWallhop then state.wallhopHolding = false end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then state.draggingMenu = false state.activeDragSlider = nil end
end)
-- Movement helpers
local function touchingWall()
	if not state.root then return false end
	local params = RaycastParams.new() params.FilterDescendantsInstances = {state.char} params.FilterType = Enum.RaycastFilterType.Exclude
	for _, dir in ipairs({state.root.CFrame.LookVector, -state.root.CFrame.LookVector, state.root.CFrame.RightVector, -state.root.CFrame.RightVector}) do
		if Workspace:Raycast(state.root.Position, dir * CONFIG.WALL_DETECT_DIST, params) then return true end
	end
	return false
end
local function getCardinalDir()
	local look = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
	if look.Magnitude == 0 then return Vector3.new(0,0,1) end
	look = look.Unit
	if math.abs(look.X) > math.abs(look.Z) then return Vector3.new(look.X > 0 and 1 or -1, 0, 0) else return Vector3.new(0, 0, look.Z > 0 and 1 or -1) end
end
local function findNearestEdge()
	if not state.root then return nil end
	local rp = RaycastParams.new() rp.FilterDescendantsInstances = {state.char} rp.FilterType = Enum.RaycastFilterType.Exclude
	local origin = state.root.Position
	local bestEdge, cd = nil, math.huge
	for _, dir in ipairs({Vector3.new(1,0,0),Vector3.new(-1,0,0),Vector3.new(0,0,1),Vector3.new(0,0,-1),Vector3.new(1,0,1).Unit,Vector3.new(-1,0,1).Unit,Vector3.new(1,0,-1).Unit,Vector3.new(-1,0,-1).Unit}) do
		for distance = 2, CONFIG.EDGE_DETECTION_RANGE do
			local cp = origin + dir * distance
			local dr = Workspace:Raycast(cp, Vector3.new(0,-CONFIG.EDGE_DETECTION_RANGE,0), rp)
			local fr = Workspace:Raycast(cp + dir*1.5, Vector3.new(0,-CONFIG.EDGE_DETECTION_RANGE,0), rp)
			if dr and not fr then
				local d = (cp-origin).Magnitude
				if d < cd then cd = d bestEdge = {position = dr.Position - dir*CONFIG.EDGE_OFFSET, direction = dir, groundHeight = dr.Position.Y, distance = d} end
			elseif dr and fr and (dr.Position.Y - fr.Position.Y) > 0.8 then
				local d = (cp-origin).Magnitude
				if d < cd then cd = d bestEdge = {position = dr.Position - dir*CONFIG.EDGE_OFFSET, direction = dir, groundHeight = dr.Position.Y, distance = d} end
			end
		end
	end
	return bestEdge
end
local function guideCameraToEdge(edge)
	if not edge or not state.root or state.isWallhopFlicking then return end
	state.isGuiding = true
	local fd = ((edge.position + Vector3.new(0,3,0)) - state.root.Position).Unit
	local cl = camera.CFrame.LookVector
	local ad = math.deg(math.acos(math.clamp(cl:Dot(fd), -1, 1)))
	local ll = ad < CONFIG.ANGLE_TOLERANCE and cl or cl:Lerp(fd, math.min(CONFIG.CAMERA_TURN_SPEED*math.min(1, ad/30), CONFIG.MAX_TURN_RATE/ad))
	camera.CFrame = CFrame.lookAt(camera.CFrame.Position, camera.CFrame.Position + ll)
	local hd = Vector3.new(edge.position.X-state.root.Position.X, 0, edge.position.Z-state.root.Position.Z).Magnitude
	local sm, pn = 1, Vector3.zero
	if hd > CONFIG.CORRECTION_THRESHOLD then sm = CONFIG.SPEED_BOOST pn = edge.direction*CONFIG.POSITION_CORRECTION
	elseif hd < CONFIG.OVERSHOOT_THRESHOLD then sm = CONFIG.SPEED_REDUCE pn = edge.direction*-CONFIG.POSITION_CORRECTION end
	if pn.Magnitude > 0 then state.root.CFrame = state.root.CFrame + pn end
	local hd2 = Vector3.new(ll.X,0,ll.Z).Unit
	state.root.AssemblyLinearVelocity = Vector3.new(hd2.X*CONFIG.FORWARD_SPEED*sm, state.root.AssemblyLinearVelocity.Y, hd2.Z*CONFIG.FORWARD_SPEED*sm)
end
local function slideOffEdge(edge)
	if state.isSliding or not state.root then return end
	state.isSliding = true state.isGuiding = false
	state.root.AssemblyLinearVelocity = Vector3.new(edge.direction.X*CONFIG.SLIDE_SPEED, state.root.AssemblyLinearVelocity.Y*0.4, edge.direction.Z*CONFIG.SLIDE_SPEED)
	task.wait(0.3) state.isSliding = false state.edgeLanded = false
end
local function performHangTime(edge)
	if state.isHangTime or not state.root or not state.root.Parent then return end
	state.isHangTime = true state.isGuiding = false
	playEdgebugSound()
	local hv = Vector3.new(state.root.AssemblyLinearVelocity.X, 0, state.root.AssemblyLinearVelocity.Z)
	local hf = Instance.new("BodyVelocity") hf.Name = "HangTimeEffect" hf.MaxForce = Vector3.new(0,math.huge,0) hf.Velocity = Vector3.new(0,-CONFIG.HANG_TIME_GRAVITY,0) hf.Parent = state.root
	state.root.AssemblyLinearVelocity = Vector3.new(hv.X*0.5, -CONFIG.HANG_TIME_GRAVITY, hv.Z*0.5)
	task.wait(CONFIG.HANG_TIME_DURATION)
	if hf and hf.Parent then hf:Destroy() end
	state.isHangTime = false
	slideOffEdge(edge)
end
-- Main loops
RunService.RenderStepped:Connect(function(dt)
	state.pearlescentTime = state.pearlescentTime + dt
	if state.draggingMenu and state.menuOpen then
		local mp = UserInputService:GetMouseLocation()
		refs.menuFrame.Position = UDim2.new(0, mp.X - state.dragOffset.X, 0, mp.Y - state.dragOffset.Y)
	end
	updateESP()
	updateChams()
	updateSnow()
	updateKeystrokeDisplay()
	updateFOVChanger()
	if features.worldModulation or features.fogControl or features.ambientColor then updateWorldModulation() end
	if not state.hum or not state.root then return end
	local vel = state.root.AssemblyLinearVelocity
	local onGround = state.hum.FloorMaterial ~= Enum.Material.Air
	if features.pixelSurf and state.keys.Surf and touchingWall() then
		local dir = getCardinalDir()
		state.root.AssemblyLinearVelocity = Vector3.new(dir.X*CONFIG.PIXELSURF_SPEED, CONFIG.COUNTER_GRAVITY and 196*dt or vel.Y, dir.Z*CONFIG.PIXELSURF_SPEED)
		return
	end
	if features.bhop and state.keys.Jump and not state.menuOpen then
		if onGround then state.jumpBugApplied = false end
		local moveDir = Vector3.zero
		local cam = camera.CFrame
		if state.keys.W then moveDir += Vector3.new(cam.LookVector.X,0,cam.LookVector.Z) end
		if state.keys.S then moveDir -= Vector3.new(cam.LookVector.X,0,cam.LookVector.Z) end
		if state.keys.A then moveDir -= Vector3.new(cam.RightVector.X,0,cam.RightVector.Z) end
		if state.keys.D then moveDir += Vector3.new(cam.RightVector.X,0,cam.RightVector.Z) end
		if moveDir.Magnitude > 0 then
			moveDir = moveDir.Unit
			local jv = vel.Y
			if features.jumpBug and state.keys.JumpBug and not state.jumpBugApplied then jv = math.max(jv,16)+CONFIG.JUMPBUG_EXTRA_Y state.jumpBugApplied = true end
			state.root.AssemblyLinearVelocity = Vector3.new(moveDir.X*CONFIG.BHOP_SPEED, jv, moveDir.Z*CONFIG.BHOP_SPEED)
		end
	end
	local hVel = Vector3.new(vel.X,0,vel.Z).Magnitude
	if features.velocityDisplay then refs.velocityLabel.Text = string.format("%.1f", hVel) end
	refs.velocityLabel.Visible = features.velocityDisplay
	updateGraph(hVel)
	if not state.takeoffVelocity or (hVel > state.takeoffVelocity and not onGround) then state.takeoffVelocity = hVel end
	if onGround and state.lastOnGround then state.takeoffVelocity = hVel end
	state.lastOnGround = onGround
end)
RunService.Heartbeat:Connect(function()
	if not state.menuOpen and features.edgebug and state.autoEdgebugEnabled and state.root and state.hum and state.char and state.char.Parent then
		local velocity = state.root.AssemblyLinearVelocity
		if math.abs(velocity.Y) >= CONFIG.MIN_FALL_SPEED or state.hum:GetState() == Enum.HumanoidStateType.Freefall then
			local edge = findNearestEdge()
			if edge then
				state.lastEdge = edge
				local h = state.root.Position.Y - edge.groundHeight
				if h <= 3.5 and h >= 2.5 and not state.isSliding and not state.isHangTime then state.edgeLanded = true performHangTime(edge)
				elseif not state.isSliding and not state.isHangTime and h > 4 then guideCameraToEdge(edge) end
			end
		else
			if not state.isSliding and not state.isHangTime then state.isGuiding = false state.edgeLanded = false end
		end
	end
	if features.autoWallhop and state.wallhopHolding and not state.isWallhopFlicking and not state.menuOpen then
		if state.root and state.hum and state.hum.Health > 0 then
			local wallResult = castWallhopRays(state.root)
			if wallResult then performWallhop(state.root, wallResult) end
		end
	end
end)
task.delay(0.5, function()
	updateThemeColors()
	showNotification("Injected! Press F to open :3", Color3.fromRGB(34, 197, 94))
end)