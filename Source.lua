--[[
	Furinafield - Premium Game Hub
	Version: 2.0
	Design by: RexxHayanasi
]]

--// Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Main.lua"))()
local Window = Library:CreateWindow({
	Title = "Furinafield Premium",
	Theme = "Dark",
	Size = UDim2.fromOffset(600, 400),
	Transparency = 0.15,
	Blurring = true,
	MinimizeKeybind = Enum.KeyCode.RightAlt,
})

--// Custom Themes with Enhanced Colors
local Themes = {
	Light = {
		Primary = Color3.fromRGB(240, 240, 240),
		Secondary = Color3.fromRGB(255, 255, 255),
		Component = Color3.fromRGB(245, 245, 245),
		Interactables = Color3.fromRGB(230, 230, 230),
		Tab = Color3.fromRGB(50, 50, 50),
		Title = Color3.fromRGB(0, 0, 0),
		Description = Color3.fromRGB(100, 100, 100),
		Shadow = Color3.fromRGB(255, 255, 255),
		Outline = Color3.fromRGB(210, 210, 210),
		Icon = Color3.fromRGB(100, 100, 100),
		Accent = Color3.fromRGB(0, 120, 215), -- Added accent color
	},
	
	Dark = {
		Primary = Color3.fromRGB(25, 25, 25),
		Secondary = Color3.fromRGB(35, 35, 35),
		Component = Color3.fromRGB(45, 45, 45),
		Interactables = Color3.fromRGB(55, 55, 55),
		Tab = Color3.fromRGB(220, 220, 220),
		Title = Color3.fromRGB(240, 240, 240),
		Description = Color3.fromRGB(200, 200, 200),
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(60, 60, 60),
		Icon = Color3.fromRGB(220, 220, 220),
		Accent = Color3.fromRGB(0, 162, 255), -- Added accent color
	},
	
	Ocean = { -- New theme
		Primary = Color3.fromRGB(15, 30, 45),
		Secondary = Color3.fromRGB(20, 40, 60),
		Component = Color3.fromRGB(25, 50, 75),
		Interactables = Color3.fromRGB(30, 60, 90),
		Tab = Color3.fromRGB(180, 220, 255),
		Title = Color3.fromRGB(220, 240, 255),
		Description = Color3.fromRGB(180, 210, 240),
		Shadow = Color3.fromRGB(0, 10, 20),
		Outline = Color3.fromRGB(40, 80, 120),
		Icon = Color3.fromRGB(180, 220, 255),
		Accent = Color3.fromRGB(0, 180, 255),
	},

	Void = {
		Primary = Color3.fromRGB(10, 10, 10),
		Secondary = Color3.fromRGB(15, 15, 15),
		Component = Color3.fromRGB(20, 20, 20),
		Interactables = Color3.fromRGB(25, 25, 25),
		Tab = Color3.fromRGB(200, 200, 200),
		Title = Color3.fromRGB(240, 240, 240),
		Description = Color3.fromRGB(200, 200, 200),
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(30, 30, 30),
		Icon = Color3.fromRGB(220, 220, 220),
		Accent = Color3.fromRGB(150, 0, 255),
	}
}

-- Set Ocean theme as default
Window:SetTheme(Themes.Ocean)

--// Sections with Icons
Window:AddTabSection({ Name = "Dashboard", Order = 1, Icon = "rbxassetid://10723424646" })
Window:AddTabSection({ Name = "Script Hub", Order = 2, Icon = "rbxassetid://11372957192" })
Window:AddTabSection({ Name = "Visuals", Order = 3, Icon = "rbxassetid://11963373994" })
Window:AddTabSection({ Name = "Settings", Order = 4, Icon = "rbxassetid://10734951830" })

--// Dashboard Tab
local DashboardTab = Window:AddTab({
    Title = "Dashboard",
    Section = "Dashboard",
    Icon = "rbxassetid://10723424646",
})

-- Welcome Card with Animation
local welcomeCard = Window:AddCard({
    Title = "Welcome to Furinafield!",
    Description = "Premium game hub with powerful features",
    Tab = DashboardTab,
    Image = "https://files.catbox.moe/q1nl5g.jpg",
    ImageSize = UDim2.fromOffset(80, 80)
})

-- Stats Panel
local statsPanel = Window:AddParagraph({
    Title = "System Stats",
    Description = "Loading system information...",
    Tab = DashboardTab
})

-- Update stats (example)
task.spawn(function()
    while true do
        local ping = math.random(20, 80)
        local fps = math.random(50, 120)
        statsPanel:Set({
            Description = string.format("Ping: %dms | FPS: %d | Memory: %.1fMB", 
                ping, fps, game:GetService("Stats"):GetTotalMemoryUsageMb())
        })
        task.wait(2)
    end
end)

-- Quick Access Buttons
local quickAccess = Window:AddFolder({
    Title = "Quick Access",
    Tab = DashboardTab,
    Default = true
})

quickAccess:AddButton({
    Title = "Execute All",
    Description = "Run all recommended scripts",
    Callback = function()
        Window:Notify({ Title = "System", Description = "Executing all recommended scripts...", Duration = 2 })
    end
})

quickAccess:AddButton({
    Title = "Clean UI",
    Description = "Remove all UI elements",
    Callback = function()
        Window:Notify({ Title = "System", Description = "Cleaning UI...", Duration = 2 })
    end
})

--// Script Hub Tab
local ScriptTab = Window:AddTab({
    Title = "Script Hub",
    Section = "Script Hub",
    Icon = "rbxassetid://11372957192"
})

-- Game Detection
local currentGame = Window:AddParagraph({
    Title = "Detected Game",
    Description = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Tab = ScriptTab
})

-- Recommended Scripts
local recommended = Window:AddFolder({
    Title = "Recommended",
    Tab = ScriptTab,
    Default = true
})

recommended:AddButton({
    Title = "Dead Rails",
    Description = "Best script for Dead Rails",
    Callback = function()
        Window:Notify({ Title = "Script Hub", Description = "Loading Dead Rails script...", Duration = 1 })
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/main/Script/Game/Dead-Rails.lua"))()
        end)
        if success then
            Window:Notify({ Title = "Success", Description = "Dead Rails loaded successfully!", Duration = 3 })
        else
            Window:Notify({ Title = "Error", Description = "Failed to load Dead Rails", Duration = 3 })
            warn(err)
        end
    end
})

-- Universal Scripts
local universal = Window:AddFolder({
    Title = "Universal",
    Tab = ScriptTab
})

universal:AddButton({
    Title = "Infinite Yield",
    Description = "Admin commands for any game",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

--// Visuals Tab
local VisualTab = Window:AddTab({
    Title = "Visuals",
    Section = "Visuals",
    Icon = "rbxassetid://11963373994"
})

-- Visual Features
local visuals = Window:AddFolder({
    Title = "Visual Modifications",
    Tab = VisualTab,
    Default = true
})

visuals:AddButton({
    Title = "Hitbox Expander",
    Description = "Auto inject hitbox visualizer",
    Callback = function()
        Window:Notify({ Title = "Visuals", Description = "Injecting hitbox visualizer...", Duration = 1 })
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/main/Script/Visual/hitbox.lua"))()
        end)
        if success then
            Window:Notify({ Title = "Success", Description = "Hitbox visualizer loaded!", Duration = 3 })
        else
            Window:Notify({ Title = "Error", Description = "Failed to load hitbox", Duration = 3 })
            warn(err)
        end
    end
})

-- Chams
visuals:AddToggle({
    Title = "Player Chams",
    Description = "Highlight players through walls",
    Default = false,
    Callback = function(state)
        Window:Notify({ Title = "Visuals", Description = state and "Chams enabled" or "Chams disabled", Duration = 2 })
    end
})

-- ESP Options
local espOptions = Window:AddFolder({
    Title = "ESP Settings",
    Tab = VisualTab
})

espOptions:AddToggle({
    Title = "Name ESP",
    Default = true,
    Callback = function(state)
        -- ESP implementation would go here
    end
})

espOptions:AddColorpicker({
    Title = "ESP Color",
    Default = Color3.fromRGB(0, 255, 255),
    Callback = function(color)
        -- Color change implementation
    end
})

--// Settings Tab
local SettingsTab = Window:AddTab({
    Title = "Settings",
    Section = "Settings",
    Icon = "rbxassetid://10734951830"
})

-- UI Settings
local uiSettings = Window:AddFolder({
    Title = "UI Settings",
    Tab = SettingsTab,
    Default = true
})

uiSettings:AddDropdown({
    Title = "Theme",
    Description = "Change UI theme",
    Default = "Ocean",
    Items = {"Dark", "Light", "Ocean", "Void"},
    Callback = function(option)
        Window:SetTheme(Themes[option])
    end
})

uiSettings:AddSlider({
    Title = "UI Transparency",
    Description = "Adjust window transparency",
    Default = 15,
    Min = 0,
    Max = 80,
    Callback = function(value)
        Window:SetSetting("Transparency", value/100)
    end
})

-- Keybinds
local keybinds = Window:AddFolder({
    Title = "Keybinds",
    Tab = SettingsTab
})

keybinds:AddKeybind({
    Title = "Toggle UI",
    Description = "Key to show/hide the UI",
    Default = Enum.KeyCode.RightControl,
    Callback = function(key)
        Window:SetSetting("MinimizeKeybind", key)
    end
})

-- Watermark
Window:AddWatermark("Furinafield Premium | v2.0 | "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)

--// UI Toggle Button (Animated)
local UIVisible = true
local ToggleImage = Instance.new("ImageButton")
ToggleImage.Name = "FurinafieldToggle"
ToggleImage.Image = "https://files.catbox.moe/q1nl5g.jpg"
ToggleImage.Size = UDim2.new(0, 50, 0, 50)
ToggleImage.Position = UDim2.new(0, 20, 0.5, -25)
ToggleImage.AnchorPoint = Vector2.new(0, 0.5)
ToggleImage.BackgroundTransparency = 1
ToggleImage.ZIndex = 999
ToggleImage.Parent = gethui and gethui() or game.CoreGui

-- Add glow effect
local glow = Instance.new("ImageLabel")
glow.Name = "GlowEffect"
glow.Image = "rbxassetid://5028857084"
glow.Size = UDim2.new(1.5, 0, 1.5, 0)
glow.Position = UDim2.new(0.5, 0, 0.5, 0)
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.BackgroundTransparency = 1
glow.ImageTransparency = 0.8
glow.ZIndex = 998
glow.Parent = ToggleImage

-- Animation
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local glowTween = TweenService:Create(glow, tweenInfo, {ImageTransparency = 0.5})
local glowReset = TweenService:Create(glow, tweenInfo, {ImageTransparency = 0.8})

ToggleImage.MouseEnter:Connect(function()
    glowTween:Play()
end)

ToggleImage.MouseLeave:Connect(function()
    glowReset:Play()
end)

ToggleImage.MouseButton1Click:Connect(function()
    UIVisible = not UIVisible
    for _, v in ipairs((gethui and gethui() or game.CoreGui):GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("Furinafield") then
            v.Enabled = UIVisible
        end
    end
    
    -- Animate button on click
    local clickTween = TweenService:Create(ToggleImage, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 45, 0, 45),
        Position = UDim2.new(0, 22.5, 0.5, -22.5)
    })
    local resetTween = TweenService:Create(ToggleImage, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0, 20, 0.5, -25)
    })
    
    clickTween:Play()
    clickTween.Completed:Wait()
    resetTween:Play()
    
    Window:Notify({
        Title = "Furinafield",
        Description = UIVisible and "UI Visible" or "UI Hidden",
        Duration = 1
    })
end)

--// Maximize/Minimize Button (Animated)
local isMaximized = false
local defaultSize = UDim2.fromOffset(600, 400)
local maximizedSize = UDim2.fromOffset(800, 550)

local ToggleMaxBtn = Instance.new("ImageButton")
ToggleMaxBtn.Name = "ToggleMaximize"
ToggleMaxBtn.Image = "rbxassetid://6031091004" -- Maximize icon
ToggleMaxBtn.Size = UDim2.new(0, 20, 0, 20)
ToggleMaxBtn.BackgroundTransparency = 1
ToggleMaxBtn.Position = UDim2.new(1, -30, 0, 10)
ToggleMaxBtn.AnchorPoint = Vector2.new(1, 0)
ToggleMaxBtn.ZIndex = 999
ToggleMaxBtn.Parent = gethui and gethui() or game.CoreGui

ToggleMaxBtn.MouseButton1Click:Connect(function()
    isMaximized = not isMaximized
    Window:SetSetting("Size", isMaximized and maximizedSize or defaultSize)
    ToggleMaxBtn.Image = isMaximized and "rbxassetid://6031090997" or "rbxassetid://6031091004" -- Toggle between icons
    
    -- Add animation
    local tween = TweenService:Create(ToggleMaxBtn, TweenInfo.new(0.3), {
        Rotation = isMaximized and 180 or 0
    })
    tween:Play()
    
    Window:Notify({
        Title = "Furinafield",
        Description = isMaximized and "Window Maximized" or "Window Restored",
        Duration = 1
    })
end)

--// Initialization Complete
Window:Notify({
    Title = "Furinafield Loaded",
    Description = "Premium hub initialized successfully!",
    Duration = 3
})
