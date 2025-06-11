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
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Parent = frame

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Text = message
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 16
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Position = UDim2.new(0, 10, 0, 40)
    messageLabel.Size = UDim2.new(1, -20, 0, 30)
    messageLabel.TextWrapped = true
    messageLabel.Parent = frame

    frame.Position = UDim2.new(1, 10, 1, 100)
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 1, -90)})
    tweenIn:Play()

    task.delay(duration, function()
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 1, 100)})
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            notificationGui:Destroy()
        end)
    end)
end

showNotification("Furinafield", "Memuat antarmuka...", 2)

local ToggleImage = Instance.new("ImageButton")
ToggleImage.Name = "FurinafieldToggle"
ToggleImage.Image = "https://files.catbox.moe/q1nl5g.jpg"
ToggleImage.Size = UDim2.new(0, 45, 0, 45)
ToggleImage.Position = UDim2.new(0, 20, 0, 250)
ToggleImage.BackgroundTransparency = 1
ToggleImage.ZIndex = 50

local function getSafeParent()
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        return LocalPlayer:WaitForChild("PlayerGui")
    end
    return CoreGui
end

ToggleImage.Parent = getSafeParent()

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
})

local Themes = {
    Dark = {
        Primary = Color3.fromRGB(45, 45, 65),
        Secondary = Color3.fromRGB(35, 35, 55),
        Interactables = Color3.fromRGB(60, 60, 90),
        Tab = Color3.fromRGB(200, 200, 200),
        Title = Color3.fromRGB(240,240,240),
        Description = Color3.fromRGB(200,200,200),
        Shadow = Color3.fromRGB(0, 0, 0),
        Outline = Color3.fromRGB(40, 40, 40),
        Icon = Color3.fromRGB(220, 220, 220),
    },
}
Window:SetTheme(Themes.Dark)

Window:AddTabSection({ Name = "Main", Order = 1 })
Window:AddTabSection({ Name = "Script", Order = 2 })
Window:AddTabSection({ Name = "Visual", Order = 3 })
Window:AddTabSection({ Name = "Settings", Order = 4 })

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

----------------------------------------------------------------------
-- DASHBOARD TAB (TAMBAHAN)
----------------------------------------------------------------------
local function getAvatarUrl(userId)
    return string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", userId)
end

local DashboardTab = Window:AddTab({
    Title = "Dashboard",
    Section = "Main",
    Icon = "rbxassetid://10723424646", -- lucide-layout-dashboard
})

DashboardTab:AddParagraph({
    Title = "User Info",
    Description = "",
    Tab = DashboardTab
})

local playerName = LocalPlayer and LocalPlayer.Name or "Guest"
local playerId = LocalPlayer and LocalPlayer.UserId or 1

local playerAvatarImage = Instance.new("ImageLabel")
playerAvatarImage.Name = "UserAvatar"
playerAvatarImage.Image = getAvatarUrl(playerId)
playerAvatarImage.Size = UDim2.new(0, 64, 0, 64)
playerAvatarImage.Position = UDim2.new(0, 10, 0, 45)
playerAvatarImage.BackgroundTransparency = 1
playerAvatarImage.Parent = DashboardTab.Content

local playerNameLabel = Instance.new("TextLabel")
playerNameLabel.Text = playerName
playerNameLabel.Font = Enum.Font.GothamBold
playerNameLabel.TextSize = 18
playerNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
playerNameLabel.BackgroundTransparency = 1
playerNameLabel.Position = UDim2.new(0, 80, 0, 60)
playerNameLabel.Size = UDim2.new(0, 200, 0, 30)
playerNameLabel.Parent = DashboardTab.Content

DashboardTab:AddParagraph({
    Title = "Tentang Furinafield",
    Description = "Furinafield adalah UI library premium untuk Roblox yang menghadirkan tampilan modern, fitur lengkap, dan kemudahan integrasi ke script kamu.",
    Tab = DashboardTab
})

DashboardTab:AddParagraph({
    Title = "Creator",
    Description = "XyraaDeFontine",
    Tab = DashboardTab
})

local creatorAvatarImage = Instance.new("ImageLabel")
creatorAvatarImage.Name = "CreatorAvatar"
creatorAvatarImage.Image = getAvatarUrl(4488332506) -- UserId XyraaDeFontine
creatorAvatarImage.Size = UDim2.new(0, 64, 0, 64)
creatorAvatarImage.Position = UDim2.new(0, 10, 0, 230)
creatorAvatarImage.BackgroundTransparency = 1
creatorAvatarImage.Parent = DashboardTab.Content

local creatorNameLabel = Instance.new("TextLabel")
creatorNameLabel.Text = "XyraaDeFontine"
creatorNameLabel.Font = Enum.Font.GothamBold
creatorNameLabel.TextSize = 18
creatorNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
creatorNameLabel.BackgroundTransparency = 1
creatorNameLabel.Position = UDim2.new(0, 80, 0, 245)
creatorNameLabel.Size = UDim2.new(0, 200, 0, 30)
creatorNameLabel.Parent = DashboardTab.Content
----------------------------------------------------------------------
-- AKHIR DASHBOARD TAB
----------------------------------------------------------------------

local ScriptTab = Window:AddTab({
    Title = "Script",
    Section = "Script",
    Icon = "rbxassetid://11372957192"
})
Window:AddButton({
    Title = "Contoh Script",
    Description = "Menampilkan script contoh",
    Tab = ScriptTab,
    Callback = function()
        showNotification("Furinafield", "Contoh script ditampilkan!", 1)
    end
})

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

local Settings = Window:AddTab({
    Title = "Settings",
    Section = "Settings",
    Icon = "rbxassetid://11293977610",
})
Window:AddKeybind({
    Title = "Minimize Keybind",
    Description = "Toggle UI",
    Tab = Settings,
    Default = Enum.KeyCode.RightControl,
    Callback = function()
        UIVisible = not UIVisible
        for _, v in ipairs(getSafeParent():GetChildren()) do
            if v:IsA("ScreenGui") and v.Name:find("Furinafield") then
                v.Enabled = UIVisible
            end
        end
        showNotification("Furinafield", UIVisible and "UI Ditampilkan" or "UI Disembunyikan", 1)
    end
})
Window:AddToggle({
    Title = "Blur Background",
    Description = "Aktifkan blur pada background UI",
    Tab = Settings,
    Callback = function(Boolean)
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

showNotification("Furinafield", "Antarmuka siap digunakan!", 2)
