--// Auto Toggle UI Button (Image)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

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

local function getSafeParent()
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        return LocalPlayer:WaitForChild("PlayerGui")
    end
    return CoreGui
end

--// LIBRARY AUTO-GENERATE COMPONENTS
local function EnsureComponents(Screen)
    local Components = Screen:FindFirstChild("Components")
    if not Components then
        Components = Instance.new("Folder")
        Components.Name = "Components"
        Components.Parent = Screen
    end

    -- Template minimal agar UI tidak blank
    local function textLabel(name)
        local l = Instance.new("TextLabel")
        l.Name = name
        l.Size = UDim2.new(1, 0, 0, 24)
        l.BackgroundTransparency = 1
        l.Text = name
        l.TextColor3 = Color3.fromRGB(220, 220, 220)
        return l
    end
    local function textButton(name)
        local b = Instance.new("TextButton")
        b.Name = name
        b.Size = UDim2.new(1, 0, 0, 32)
        b.BackgroundTransparency = 0.1
        b.Text = name
        b.TextColor3 = Color3.fromRGB(210, 210, 255)
        return b
    end
    local function frame(name)
        local f = Instance.new("Frame")
        f.Name = name
        f.Size = UDim2.new(1, 0, 0, 32)
        f.BackgroundTransparency = 0.2
        return f
    end
    local function canvasGroup(name)
        local c = Instance.new("CanvasGroup")
        c.Name = name
        c.Size = UDim2.new(1, 0, 1, 0)
        c.BackgroundTransparency = 0.2
        return c
    end

    local templates = {
        MainExample = canvasGroup("MainExample"),
        TabButtonExample = textButton("TabButtonExample"),
        SectionExample = textLabel("SectionExample"),
        Button = textButton("Button"),
        Paragraph = frame("Paragraph"),
        Notification = canvasGroup("Notification"),
        DropdownExample = frame("DropdownExample"),
        DropdownButtonExample = textButton("DropdownButtonExample"),
        Toggle = frame("Toggle"),
        Input = frame("Input"),
        Keybind = frame("Keybind"),
        Slider = frame("Slider"),
    }

    for name, instance in pairs(templates) do
        if not Components:FindFirstChild(name) then
            instance.Parent = Components
        end
    end
end

--// Library: LOAD & PASTIKAN COMPONENTS ADA (auto generate jika tidak ada)
local function getLibrary()
    local MainLibUrl = "https://raw.githubusercontent.com/RexxHayanasi/RexxLibsV1/main/Main.lua"
    local raw = game:HttpGet(MainLibUrl)
    local Library = loadstring(raw)()

    -- Cari Screen (ScreenGui) di CoreGui atau PlayerGui
    local Screen = nil
    for _, gui in ipairs(game.CoreGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui:FindFirstChild("Components") then
            Screen = gui
            break
        end
    end
    if not Screen and LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
        for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui:FindFirstChild("Components") then
                Screen = gui
                break
            end
        end
    end

    -- Jika tidak ada, buat Screen baru & generate komponen
    if not Screen then
        Screen = Instance.new("ScreenGui")
        Screen.Name = "FurinafieldScreen"
        Screen.Parent = getSafeParent()
    end
    EnsureComponents(Screen)
    return Library
end

local Library = getLibrary()

local defaultSize = UDim2.new(0, 600, 0, 400)
local maximizedSize = UDim2.new(0.8, 0, 0.8, 0)
local Window = Library:CreateWindow({
    Title = "Furinafield Premium",
    Size = defaultSize,
    Theme = "Dark",
    Transparency = 0.1,
})

local Themes = {
    Dark = {
        Primary = Color3.fromRGB(40, 40, 60),
        Secondary = Color3.fromRGB(30, 30, 48),
        Interactables = Color3.fromRGB(60, 60, 90),
        Tab = Color3.fromRGB(220, 220, 220),
        Title = Color3.fromRGB(255,255,255),
        Description = Color3.fromRGB(200,200,200),
        Shadow = Color3.fromRGB(0, 0, 0),
        Outline = Color3.fromRGB(40, 40, 40),
        Icon = Color3.fromRGB(220, 220, 220),
    },
}
Window:SetTheme(Themes.Dark)

-- Section dan Tab
Window:AddTabSection({ Name = "Dashboard", Order = 1 })
Window:AddTabSection({ Name = "Script", Order = 2 })
Window:AddTabSection({ Name = "Visual", Order = 3 })
Window:AddTabSection({ Name = "Settings", Order = 4 })

local DashboardTab = Window:AddTab({
    Title = "Dashboard",
    Section = "Dashboard",
    Icon = "rbxassetid://10723424646",
})

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
        showNotification("Furinafield", "Memuat script Dead Rails...", 1)
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/main/Script/Game/Dead-Rails.lua"))()
        end)
        if success then
            showNotification("Furinafield", "Script Dead Rails berhasil dijalankan!", 2)
        else
            showNotification("Furinafield", "Gagal menjalankan script Dead Rails", 2)
            warn("Error loading script Dead Rails:", err)
        end
    end
})

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
        showNotification("Furinafield", "Memuat Hitbox...", 1)
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/main/Script/Visual/hitbox.lua"))()
        end)
        if success then
            showNotification("Furinafield", "Hitbox berhasil dimuat!", 2)
        else
            showNotification("Furinafield", "Gagal memuat Hitbox", 2)
            warn("Error loading Hitbox:", err)
        end
    end
})

-- Tombol maximize/minimize UI (pojok kanan atas)
local maximizeImg = "https://files.catbox.moe/q1nl5g.jpg"
local minimizeImg = "https://files.catbox.moe/q1nl5g.jpg"
local isMaximized = false

local ToggleMaxBtn = Instance.new("ImageButton")
ToggleMaxBtn.Name = "ToggleMaximize"
ToggleMaxBtn.Image = maximizeImg
ToggleMaxBtn.Size = UDim2.new(0, 36, 0, 36)
ToggleMaxBtn.BackgroundTransparency = 1
ToggleMaxBtn.Position = UDim2.new(1, -50, 0, 8)
ToggleMaxBtn.AnchorPoint = Vector2.new(1, 0)
ToggleMaxBtn.ZIndex = 999
ToggleMaxBtn.Parent = getSafeParent()

ToggleMaxBtn.MouseButton1Click:Connect(function()
    isMaximized = not isMaximized
    if isMaximized then
        Window:SetSetting("Size", maximizedSize)
        ToggleMaxBtn.Image = minimizeImg
        showNotification("Furinafield", "UI Diperbesar", 1)
    else
        Window:SetSetting("Size", defaultSize)
        ToggleMaxBtn.Image = maximizeImg
        showNotification("Furinafield", "UI Diperkecil", 1)
    end
end)

-- Tombol toggle show/hide UI (kiri bawah)
local UIVisible = true
local ToggleImage = Instance.new("ImageButton")
ToggleImage.Name = "FurinafieldToggle"
ToggleImage.Image = "https://files.catbox.moe/q1nl5g.jpg"
ToggleImage.Size = UDim2.new(0, 45, 0, 45)
ToggleImage.Position = UDim2.new(0, 20, 0, 250)
ToggleImage.BackgroundTransparency = 1
ToggleImage.ZIndex = 999
ToggleImage.Parent = getSafeParent()

ToggleImage.MouseButton1Click:Connect(function()
    UIVisible = not UIVisible
    for _, v in ipairs(getSafeParent():GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("Furinafield") then
            v.Enabled = UIVisible
        end
    end
    showNotification("Furinafield", UIVisible and "UI Ditampilkan" or "UI Disembunyikan", 1)
end)

local SettingsTab = Window:AddTab({
    Title = "Settings",
    Section = "Settings",
    Icon = "rbxassetid://11293977610",
})
Window:AddParagraph({
    Title = "Pengaturan",
    Description = "Atur fitur UI di sini.",
    Tab = SettingsTab
})
Window:AddKeybind({
    Title = "Minimize Keybind",
    Description = "Toggle UI",
    Tab = SettingsTab,
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
    Tab = SettingsTab,
    Callback = function(Boolean)
        showNotification("Furinafield", "Blur "..(Boolean and "diaktifkan" or "dinonaktifkan"), 1)
    end
})
Window:AddSlider({
    Title = "UI Transparency",
    Description = "Adjust UI transparency",
    Tab = SettingsTab,
    AllowDecimals = true,
    MaxValue = 1,
    Callback = function(Amount)
        Window:SetSetting("Transparency", Amount)
        showNotification("Furinafield", "Transparansi diatur ke: "..string.format("%.0f%%", Amount*100), 1)
    end
})

showNotification("Furinafield", "Antarmuka siap digunakan!", 2)
