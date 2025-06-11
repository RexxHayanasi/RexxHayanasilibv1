--// Auto Toggle UI Button (Image)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Fungsi untuk membuat notifikasi
local function showNotification(title, message, duration)
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "FurinaNotification"
    notificationGui.Parent = CoreGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, 10, 1, -90)
    frame.AnchorPoint = Vector2.new(1, 1)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Parent = notificationGui
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Text = message
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 14
    messageLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    messageLabel.Size = UDim2.new(1, -20, 1, -40)
    messageLabel.Position = UDim2.new(0, 10, 0, 35)
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = frame
    
    -- Animasi masuk
    frame.Position = UDim2.new(1, 10, 1, 100)
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 1, -90)})
    tweenIn:Play()
    
    -- Animasi keluar setelah durasi
    task.delay(duration, function()
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 1, 100)})
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            notificationGui:Destroy()
        end)
    end)
end

-- Tampilkan notifikasi saat memulai
showNotification("Furinafield", "Memuat antarmuka...", 2)

local ToggleImage = Instance.new("ImageButton")
ToggleImage.Name = "FurinafieldToggle"
ToggleImage.Image = "https://files.catbox.moe/q1nl5g.jpg"
ToggleImage.Size = UDim2.new(0, 50, 0, 50) -- Ukuran diperbesar
ToggleImage.Position = UDim2.new(0, 20, 0, 20) -- Posisi disesuaikan
ToggleImage.BackgroundTransparency = 1
ToggleImage.ZIndex = 1000
ToggleImage.AnchorPoint = Vector2.new(0, 0)
ToggleImage.Visible = true

-- Efek hover pada tombol
ToggleImage.MouseEnter:Connect(function()
    TweenService:Create(ToggleImage, TweenInfo.new(0.2), {Size = UDim2.new(0, 55, 0, 55)}):Play()
end)

ToggleImage.MouseLeave:Connect(function()
    TweenService:Create(ToggleImage, TweenInfo.new(0.2), {Size = UDim2.new(0, 50, 0, 50)}):Play()
end)

-- Parent image toggle ke PlayerGui jika ada (support mobile)
local function getSafeParent()
    if RunService:IsStudio() or RunService:IsClient() then
        if LocalPlayer:FindFirstChild("PlayerGui") then
            return LocalPlayer:WaitForChild("PlayerGui")
        end
    end
    return CoreGui
end

ToggleImage.Parent = getSafeParent()

-- Image toggle logic
local UIVisible = true
ToggleImage.MouseButton1Click:Connect(function()
    UIVisible = not UIVisible
    for _, v in ipairs(getSafeParent():GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("Furinafield") then
            v.Enabled = UIVisible
        end
    end
    showNotification("Furinafield", UIVisible and "UI Ditampilkan" or "UI Disembunyikan", 1)
end)

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/RexxLibsV1/main/main.lua"))()
local Window = Library:CreateWindow({
    Title = "Furinafield Premium",
    Theme = "Dark",
    Size = UDim2.fromOffset(600, 400), -- Ukuran diperbesar
    Transparency = 0.15, -- Lebih transparan
    Blurring = true,
    MinimizeKeybind = Enum.KeyCode.LeftAlt,
})

--// Themes
local Themes = {
    Light = {
        Primary = Color3.fromRGB(232, 232, 232),
        Secondary = Color3.fromRGB(255, 255, 255),
        Component = Color3.fromRGB(245, 245, 245),
        Interactables = Color3.fromRGB(235, 235, 235),
        Tab = Color3.fromRGB(50, 50, 50),
        Title = Color3.fromRGB(0, 0, 0),
        Description = Color3.fromRGB(100, 100, 100),
        Shadow = Color3.fromRGB(255, 255, 255),
        Outline = Color3.fromRGB(210, 210, 210),
        Icon = Color3.fromRGB(100, 100, 100),
    },
    Dark = {
        Primary = Color3.fromRGB(30, 30, 30),
        Secondary = Color3.fromRGB(35, 35, 35),
        Component = Color3.fromRGB(40, 40, 40),
        Interactables = Color3.fromRGB(45, 45, 45),
        Tab = Color3.fromRGB(200, 200, 200),
        Title = Color3.fromRGB(240,240,240),
        Description = Color3.fromRGB(200,200,200),
        Shadow = Color3.fromRGB(0, 0, 0),
        Outline = Color3.fromRGB(40, 40, 40),
        Icon = Color3.fromRGB(220, 220, 220),
    },
    Void = {
        Primary = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(20, 20, 20),
        Component = Color3.fromRGB(25, 25, 25),
        Interactables = Color3.fromRGB(30, 30, 30),
        Tab = Color3.fromRGB(200, 200, 200),
        Title = Color3.fromRGB(240,240,240),
        Description = Color3.fromRGB(200,200,200),
        Shadow = Color3.fromRGB(0, 0, 0),
        Outline = Color3.fromRGB(40, 40, 40),
        Icon = Color3.fromRGB(220, 220, 220),
    },
}
Window:SetTheme(Themes.Dark)

--// Tab Sections
Window:AddTabSection({ Name = "Main", Order = 1 })
Window:AddTabSection({ Name = "Script", Order = 2 })
Window:AddTabSection({ Name = "Visual", Order = 3 })
Window:AddTabSection({ Name = "Settings", Order = 4 })

--// MAIN Tab
local Main = Window:AddTab({
    Title = "Components",
    Section = "Main",
    Icon = "rbxassetid://11963373994"
})
Window:AddParagraph({
    Title = "Welcome",
    Description = "Furinafield Premium Hub",
    Tab = Main
})

--// SCRIPT Tab
local ScriptTab = Window:AddTab({
    Title = "Script",
    Section = "Script",
    Icon = "rbxassetid://11963373994"
})
Window:AddButton({
    Title = "Dead Rails",
    Description = "Load Dead Rails game script",
    Tab = ScriptTab,
    Callback = function()
        showNotification("Furinafield", "Memuat Dead Rails...", 1)
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/refs/heads/main/Script/Game/Dead-Rails.lua"))()
        end)
        if success then
            showNotification("Furinafield", "Dead Rails berhasil dimuat!", 2)
        else
            showNotification("Furinafield", "Gagal memuat Dead Rails", 2)
            warn("Error loading Dead Rails:", err)
        end
    end
})

--// VISUAL Tab (di bawah Script)
local VisualTab = Window:AddTab({
    Title = "Visual",
    Section = "Visual",
    Icon = "rbxassetid://11963373994"
})
Window:AddButton({
    Title = "Hitbox",
    Description = "Load Hitbox script",
    Tab = VisualTab,
    Callback = function()
        showNotification("Furinafield", "Memuat Hitbox...", 1)
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/refs/heads/main/Script/Visual/hitbox.lua"))()
        end)
        if success then
            showNotification("Furinafield", "Hitbox berhasil dimuat!", 2)
        else
            showNotification("Furinafield", "Gagal memuat Hitbox", 2)
            warn("Error loading Hitbox:", err)
        end
    end
})

--// SETTINGS Tab
local Settings = Window:AddTab({
    Title = "Settings",
    Section = "Settings",
    Icon = "rbxassetid://11293977610",
})
Window:AddKeybind({
    Title = "Minimize Keybind",
    Description = "Set the keybind for Minimizing",
    Tab = Settings,
    Callback = function(Key)
        Window:SetSetting("Keybind", Key)
        showNotification("Furinafield", "Keybind diperbarui: "..tostring(Key), 1)
    end
})
Window:AddDropdown({
    Title = "Set Theme",
    Description = "Set the theme of the library!",
    Tab = Settings,
    Options = {
        ["Light Mode"] = "Light",
        ["Dark Mode"] = "Dark",
        ["Extra Dark"] = "Void",
    },
    Callback = function(Theme)
        Window:SetTheme(Themes[Theme])
        showNotification("Furinafield", "Tema diubah ke: "..Theme, 1)
    end
})
Window:AddToggle({
    Title = "UI Blur",
    Description = "Toggle UI blur effect",
    Default = true,
    Tab = Settings,
    Callback = function(Boolean)
        Window:SetSetting("Blur", Boolean)
        showNotification("Furinafield", "Blur "..(Boolean and "diaktifkan" or "dinonaktifkan"), 1)
    end
})
Window:AddSlider({
    Title = "UI Transparency",
    Description = "Adjust UI transparency",
    Tab = Settings,
    AllowDecimals = true,
    MaxValue = 1,
    Callback = function(Amount)
        Window:SetSetting("Transparency", Amount)
        showNotification("Furinafield", "Transparansi diatur ke: "..string.format("%.0f%%", Amount*100), 1)
    end
})

-- Notifikasi saat UI selesai dimuat
showNotification("Furinafield", "Antarmuka siap digunakan!", 2)
