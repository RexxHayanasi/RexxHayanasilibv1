--// Auto Toggle UI Button (Image)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local ToggleImage = Instance.new("ImageButton")
ToggleImage.Name = "FurinafieldToggle"
ToggleImage.Image = "https://files.catbox.moe/q1nl5g.jpg"
ToggleImage.Size = UDim2.new(0, 40, 0, 40)
ToggleImage.Position = UDim2.new(0, 10, 0, 10)
ToggleImage.BackgroundTransparency = 1
ToggleImage.ZIndex = 1000
ToggleImage.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui

local UIVisible = true
ToggleImage.MouseButton1Click:Connect(function()
    UIVisible = not UIVisible
    Window:Toggle(UIVisible)
end)

--// Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/RexxLibsV1/main/main.lua"))()
local Window = Library:CreateWindow({
    Title = "Furinafield",
    Theme = "Dark",
    Size = UDim2.fromOffset(570, 370),
    Transparency = 0.2,
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
        Title = Color3.fromRGB(240, 240, 240),
        Description = Color3.fromRGB(200, 200, 200),
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
        Title = Color3.fromRGB(240, 240, 240),
        Description = Color3.fromRGB(200, 200, 200),
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
    Description = "Furinafield Hub",
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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/refs/heads/main/Script/Game/Dead-Rails.lua"))()
    end
})

--// VISUAL Tab
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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RexxHayanasi/Script-roblox/refs/heads/main/Script/Visual/hitbox.lua"))()
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
    end
})
Window:AddToggle({
    Title = "UI Blur",
    Description = "Toggle UI blur effect",
    Default = true,
    Tab = Settings,
    Callback = function(Boolean)
        Window:SetSetting("Blur", Boolean)
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
    end
})
