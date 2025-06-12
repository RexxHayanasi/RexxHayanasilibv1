--[[
	Furinafield Premium - Game Hub
	Version: 2.1
	Creator: XyraaDeFontine
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

--// Themes
local Themes = {
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
		Accent = Color3.fromRGB(0, 162, 255),
	},
	
	Ocean = {
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
	}
}

Window:SetTheme(Themes.Ocean)

--// Sections
Window:AddTabSection({ Name = "Dashboard", Order = 1, Icon = "rbxassetid://10723424646" })
Window:AddTabSection({ Name = "Script Hub", Order = 2, Icon = "rbxassetid://11372957192" })
Window:AddTabSection({ Name = "Visuals", Order = 3, Icon = "rbxassetid://11963373994" })
Window:AddTabSection({ Name = "Settings", Order = 4, Icon = "rbxassetid://10734951830" })

--// Dashboard Tab (Enhanced)
local DashboardTab = Window:AddTab({
    Title = "Dashboard",
    Section = "Dashboard",
    Icon = "rbxassetid://10723424646",
})

-- Welcome Card with Creator Info
Window:AddCard({
    Title = "🌟 Furinafield Premium",
    Description = "Game Hub canggih oleh XyraaDeFontine",
    Image = "https://files.catbox.moe/q1nl5g.jpg",
    ImageSize = UDim2.fromOffset(80, 80),
    Tab = DashboardTab
})

-- About Section
Window:AddParagraph({
    Title = "📌 Tentang Furinafield",
    Description = "Furinafield adalah hub premium yang menyediakan:\n"..
                 "• Koleksi script game terbaik\n"..
                 "• Visual enhancer (ESP, Hitbox, Chams)\n"..
                 "• Antarmuka customizable\n\n"..
                 "Versi: 2.1 | Creator: XyraaDeFontine",
    Tab = DashboardTab
})

-- Stats Panel (Existing Functionality)
local statsPanel = Window:AddParagraph({
    Title = "📊 System Stats",
    Description = "Memuat statistik sistem...",
    Tab = DashboardTab
})

-- Update stats (Original Function)
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

-- Quick Access (Original Functionality)
local quickAccess = Window:AddFolder({
    Title = "⚡ Quick Access",
    Tab = DashboardTab,
    Default = true
})

quickAccess:AddButton({
    Title = "Execute All",
    Description = "Jalankan semua script rekomendasi",
    Callback = function()
        Window:Notify({ Title = "System", Description = "Menjalankan script...", Duration = 2 })
    end
})

quickAccess:AddButton({
    Title = "Clean UI",
    Description = "Bersihkan semua UI",
    Callback = function()
        Window:Notify({ Title = "System", Description = "Membersihkan antarmuka...", Duration = 2 })
    end
})

--// Script Hub Tab (Original Functionality)
local ScriptTab = Window:AddTab({
    Title = "Script Hub",
    Section = "Script Hub",
    Icon = "rbxassetid://11372957192"
})

Window:AddButton({
    Title = "Dead Rails",
    Description = "Jalankan script Dead Rails",
    Tab = ScriptTab,
    Callback = function()
        Window:Notify({ Title = "Script Hub", Description = "Memuat Dead Rails...", Duration = 1 })
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/main/Script/Game/Dead-Rails.lua"))()
        end)
        if success then
            Window:Notify({ Title = "Berhasil!", Description = "Dead Rails berjalan!", Duration = 3 })
        else
            Window:Notify({ Title = "Gagal", Description = "Error: "..err, Duration = 3 })
        end
    end
})

Window:AddButton({
    Title = "Infinite Yield",
    Description = "Admin commands universal",
    Tab = ScriptTab,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

--// Visuals Tab (Original Functionality)
local VisualTab = Window:AddTab({
    Title = "Visuals",
    Section = "Visuals",
    Icon = "rbxassetid://11963373994"
})

Window:AddButton({
    Title = "Hitbox Expander",
    Description = "Auto inject hitbox visual",
    Tab = VisualTab,
    Callback = function()
        Window:Notify({ Title = "Visuals", Description = "Memuat Hitbox...", Duration = 1 })
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/main/Script/Visual/hitbox.lua"))()
        end)
        if success then
            Window:Notify({ Title = "Berhasil!", Description = "Hitbox aktif!", Duration = 3 })
        else
            Window:Notify({ Title = "Gagal", Description = "Error: "..err, Duration = 3 })
        end
    end
})

Window:AddToggle({
    Title = "Player ESP",
    Description = "Tampilkan ESP pemain",
    Tab = VisualTab,
    Default = false,
    Callback = function(state)
        Window:Notify({ Title = "Visuals", Description = state and "ESP Aktif" or "ESP Nonaktif", Duration = 2 })
    end
})

--// Settings Tab (Original Functionality)
local SettingsTab = Window:AddTab({
    Title = "Settings",
    Section = "Settings",
    Icon = "rbxassetid://10734951830"
})

Window:AddDropdown({
    Title = "Theme",
    Description = "Ubah tema UI",
    Tab = SettingsTab,
    Default = "Ocean",
    Items = {"Dark", "Ocean"},
    Callback = function(option)
        Window:SetTheme(Themes[option])
    end
})

Window:AddSlider({
    Title = "Transparansi UI",
    Description = "Atur transparansi jendela",
    Tab = SettingsTab,
    Default = 15,
    Min = 0,
    Max = 80,
    Callback = function(value)
        Window:SetSetting("Transparency", value/100)
    end
})

--// UI Toggle Button (Original Functionality)
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

ToggleImage.MouseButton1Click:Connect(function()
    UIVisible = not UIVisible
    for _, v in ipairs((gethui and gethui() or game.CoreGui):GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("Furinafield") then
            v.Enabled = UIVisible
        end
    end
    Window:Notify({
        Title = "Furinafield",
        Description = UIVisible and "UI Ditampilkan" or "UI Disembunyikan",
        Duration = 1
    })
end)

--// Initial Notification
Window:Notify({
    Title = "Furinafield Premium",
    Description = "Berhasil dimuat! Dibuat oleh XyraaDeFontine",
    Duration = 3
})
