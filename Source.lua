--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--// Services
local UserInputService = game:GetService("UserInputService");

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Main.lua"))()
local Window = Library:CreateWindow({
	Title = "???",
	Theme = "Dark",
	
	Size = UDim2.fromOffset(570, 370),
	Transparency = 0.2,
	Blurring = true,
	MinimizeKeybind = Enum.KeyCode.LeftAlt,
})

local Themes = {
	Light = {
		--// Frames:
		Primary = Color3.fromRGB(232, 232, 232),
		Secondary = Color3.fromRGB(255, 255, 255),
		Component = Color3.fromRGB(245, 245, 245),
		Interactables = Color3.fromRGB(235, 235, 235),

		--// Text:
		Tab = Color3.fromRGB(50, 50, 50),
		Title = Color3.fromRGB(0, 0, 0),
		Description = Color3.fromRGB(100, 100, 100),

		--// Outlines:
		Shadow = Color3.fromRGB(255, 255, 255),
		Outline = Color3.fromRGB(210, 210, 210),

		--// Image:
		Icon = Color3.fromRGB(100, 100, 100),
	},
	
	Dark = {
		--// Frames:
		Primary = Color3.fromRGB(30, 30, 30),
		Secondary = Color3.fromRGB(35, 35, 35),
		Component = Color3.fromRGB(40, 40, 40),
		Interactables = Color3.fromRGB(45, 45, 45),

		--// Text:
		Tab = Color3.fromRGB(200, 200, 200),
		Title = Color3.fromRGB(240,240,240),
		Description = Color3.fromRGB(200,200,200),

		--// Outlines:
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(40, 40, 40),

		--// Image:
		Icon = Color3.fromRGB(220, 220, 220),
	},
	
	Void = {
		--// Frames:
		Primary = Color3.fromRGB(15, 15, 15),
		Secondary = Color3.fromRGB(20, 20, 20),
		Component = Color3.fromRGB(25, 25, 25),
		Interactables = Color3.fromRGB(30, 30, 30),

		--// Text:
		Tab = Color3.fromRGB(200, 200, 200),
		Title = Color3.fromRGB(240,240,240),
		Description = Color3.fromRGB(200,200,200),

		--// Outlines:
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(40, 40, 40),

		--// Image:
		Icon = Color3.fromRGB(220, 220, 220),
	},

}

--// Set the default theme
Window:SetTheme(Themes.Dark)

--// Sections
--// Tambahan Section dan Tabs lainnya
Window:AddTabSection({ Name = "Dashboard", Order = 3 })
Window:AddTabSection({ Name = "Script", Order = 4 })
Window:AddTabSection({ Name = "Visual", Order = 5 })

--// Dashboard Tab
local DashboardTab = Window:AddTab({
    Title = "Dashboard",
    Section = "Dashboard",
    Icon = "rbxassetid://10723424646",
})

Window:AddParagraph({
    Title = "Selamat datang!",
    Description = "Ini adalah tampilan utama Furinafield.",
    Tab = DashboardTab
})

--// Script Tab
local ScriptTab = Window:AddTab({
    Title = "Script",
    Section = "Script",
    Icon = "rbxassetid://11372957192"
})

Window:AddParagraph({
    Title = "Info",
    Description = "Tab untuk eksekusi script game.",
    Tab = ScriptTab
})

Window:AddButton({
    Title = "Dead Rails",
    Description = "Jalankan script Dead Rails",
    Tab = ScriptTab,
    Callback = function()
        Window:Notify({ Title = "Furinafield", Description = "Memuat script Dead Rails...", Duration = 1 })
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/main/Script/Game/Dead-Rails.lua"))()
        end)
        if success then
            Window:Notify({ Title = "Berhasil", Description = "Script Dead Rails dijalankan!", Duration = 2 })
        else
            Window:Notify({ Title = "Gagal", Description = "Gagal menjalankan script Dead Rails", Duration = 2 })
            warn(err)
        end
    end
})

--// Visual Tab
local VisualTab = Window:AddTab({
    Title = "Visual",
    Section = "Visual",
    Icon = "rbxassetid://11963373994"
})

Window:AddParagraph({
    Title = "Info",
    Description = "Tab visual untuk script Hitbox.",
    Tab = VisualTab
})

Window:AddButton({
    Title = "Hitbox (Auto Inject)",
    Description = "Jalankan script Hitbox Visual",
    Tab = VisualTab,
    Callback = function()
        Window:Notify({ Title = "Furinafield", Description = "Memuat Hitbox...", Duration = 1 })
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/main/Script/Visual/hitbox.lua"))()
        end)
        if success then
            Window:Notify({ Title = "Berhasil", Description = "Hitbox berhasil dimuat!", Duration = 2 })
        else
            Window:Notify({ Title = "Gagal", Description = "Gagal memuat Hitbox", Duration = 2 })
            warn(err)
        end
    end
})

--// UI Toggle Button (Kiri bawah)
local UIVisible = true
local ToggleImage = Instance.new("ImageButton")
ToggleImage.Name = "FurinafieldToggle"
ToggleImage.Image = "https://files.catbox.moe/q1nl5g.jpg"
ToggleImage.Size = UDim2.new(0, 45, 0, 45)
ToggleImage.Position = UDim2.new(0, 20, 0, 250)
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

--// Maximize/Minimize Button (Kanan atas)
local maximizeImg = "https://files.catbox.moe/q1nl5g.jpg"
local minimizeImg = "https://files.catbox.moe/q1nl5g.jpg"
local isMaximized = false
local defaultSize = UDim2.fromOffset(570, 370)
local maximizedSize = UDim2.fromOffset(770, 500)

local ToggleMaxBtn = Instance.new("ImageButton")
ToggleMaxBtn.Name = "ToggleMaximize"
ToggleMaxBtn.Image = maximizeImg
ToggleMaxBtn.Size = UDim2.new(0, 36, 0, 36)
ToggleMaxBtn.BackgroundTransparency = 1
ToggleMaxBtn.Position = UDim2.new(1, -50, 0, 8)
ToggleMaxBtn.AnchorPoint = Vector2.new(1, 0)
ToggleMaxBtn.ZIndex = 999
ToggleMaxBtn.Parent = gethui and gethui() or game.CoreGui

ToggleMaxBtn.MouseButton1Click:Connect(function()
    isMaximized = not isMaximized
    Window:SetSetting("Size", isMaximized and maximizedSize or defaultSize)
    ToggleMaxBtn.Image = isMaximized and minimizeImg or maximizeImg
    Window:Notify({
        Title = "Furinafield",
        Description = isMaximized and "UI Diperbesar" or "UI Diperkecil",
        Duration = 1
    })
end)

