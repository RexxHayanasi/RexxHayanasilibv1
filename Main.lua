--[[
	User Interface Library
	Made by RexxHayanasi
]]

--// Connections
local GetService = game.GetService
local Connect = game.Loaded.Connect
local Wait = game.Loaded.Wait
local Clone = game.Clone 
local Destroy = game.Destroy 

if (not game:IsLoaded()) then
	local Loaded = game.Loaded
	Loaded.Wait(Loaded);
end

--// Important 
local Setup = {
	Keybind = Enum.KeyCode.LeftControl,
	Transparency = 0.2,
	ThemeMode = "Dark",
	Size = nil,
}

local Theme = { --// (Dark Theme)
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
}

--// Services & Functions
local Type, Blur = nil
local LocalPlayer = GetService(game, "Players").LocalPlayer;
local Services = {
	Insert = GetService(game, "InsertService");
	Tween = GetService(game, "TweenService");
	Run = GetService(game, "RunService");
	Input = GetService(game, "UserInputService");
}

local Player = {
	Mouse = LocalPlayer:GetMouse();
	GUI = LocalPlayer.PlayerGui;
}

local function warnMissingAsset(name)
	warn("[UI LIB]: Komponen asset '"..tostring(name).."' TIDAK ADA di Components. Silakan cek asset UI di model Screen/Components-mu!")
end

local Tween = function(Object, Speed, Properties, Info)
	if not Object then return end
	local Style, Direction = Enum.EasingStyle.Sine, Enum.EasingDirection.Out
	if Info then
		Style, Direction = Info["EasingStyle"] or Style, Info["EasingDirection"] or Direction
	end
	return Services.Tween:Create(Object, TweenInfo.new(Speed, Style, Direction), Properties):Play()
end

local SetProperty = function(Object, Properties)
	if not Object then return end
	for Index, Property in next, Properties do
		Object[Index] = (Property);
	end
	return Object
end

local Multiply = function(Value, Amount)
	local New = {
		Value.X.Scale * Amount;
		Value.X.Offset * Amount;
		Value.Y.Scale * Amount;
		Value.Y.Offset * Amount;
	}
	return UDim2.new(unpack(New))
end

local Color = function(Color, Factor, Mode)
	Mode = Mode or Setup.ThemeMode
	if Mode == "Light" then
		return Color3.fromRGB((Color.R * 255) - Factor, (Color.G * 255) - Factor, (Color.B * 255) - Factor)
	else
		return Color3.fromRGB((Color.R * 255) + Factor, (Color.G * 255) + Factor, (Color.B * 255) + Factor)
	end
end

local Drag = function(Canvas)
	if Canvas then
		local Dragging, DragInput, Start, StartPosition
		local function Update(input)
			local delta = input.Position - Start
			Canvas.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y)
		end

		Connect(Canvas.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or (Input.UserInputType == Enum.UserInputType.Touch and not Type) then
				Dragging = true
				Start = Input.Position
				StartPosition = Canvas.Position

				Connect(Input.Changed, function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		Connect(Canvas.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or (Input.UserInputType == Enum.UserInputType.Touch and not Type) then
				DragInput = Input
			end
		end)

		Connect(Services.Input.InputChanged, function(Input)
			if Input == DragInput and Dragging and not Type then
				Update(Input)
			end
		end)
	end
end

Resizing = { 
	TopLeft = { X = Vector2.new(-1, 0),   Y = Vector2.new(0, -1)};
	TopRight = { X = Vector2.new(1, 0),    Y = Vector2.new(0, -1)};
	BottomLeft = { X = Vector2.new(-1, 0),   Y = Vector2.new(0, 1)};
	BottomRight = { X = Vector2.new(1, 0),    Y = Vector2.new(0, 1)};
}

Resizeable = function(Tab, Minimum, Maximum)
	task.spawn(function()
		local MousePos, Size, UIPos
		if Tab and Tab:FindFirstChild("Resize") then
			local Positions = Tab:FindFirstChild("Resize")
			for _, Types in next, Positions:GetChildren() do
				Connect(Types.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Type = Types
						MousePos = Vector2.new(Player.Mouse.X, Player.Mouse.Y)
						Size = Tab.AbsoluteSize
						UIPos = Tab.Position
					end
				end)
				Connect(Types.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Type = nil
					end
				end)
			end
		end
		local Resize = function(Delta)
			if Type and MousePos and Size and UIPos and Tab:FindFirstChild("Resize")[Type.Name] == Type then
				local Mode = Resizing[Type.Name]
				local NewSize = Vector2.new(Size.X + Delta.X * Mode.X.X, Size.Y + Delta.Y * Mode.Y.Y)
				NewSize = Vector2.new(math.clamp(NewSize.X, Minimum.X, Maximum.X), math.clamp(NewSize.Y, Minimum.Y, Maximum.Y))
				local AnchorOffset = Vector2.new(Tab.AnchorPoint.X * Size.X, Tab.AnchorPoint.Y * Size.Y)
				local NewAnchorOffset = Vector2.new(Tab.AnchorPoint.X * NewSize.X, Tab.AnchorPoint.Y * NewSize.Y)
				local DeltaAnchorOffset = NewAnchorOffset - AnchorOffset
				Tab.Size = UDim2.new(0, NewSize.X, 0, NewSize.Y)
				local NewPosition = UDim2.new(
					UIPos.X.Scale, 
					UIPos.X.Offset + DeltaAnchorOffset.X * Mode.X.X,
					UIPos.Y.Scale,
					UIPos.Y.Offset + DeltaAnchorOffset.Y * Mode.Y.Y
				)
				Tab.Position = NewPosition
			end
		end
		Connect(Player.Mouse.Move, function()
			if Type then
				Resize(Vector2.new(Player.Mouse.X, Player.Mouse.Y) - MousePos)
			end
		end)
	end)
end

--// Setup [UI]
if (identifyexecutor) then
	Screen = Services.Insert:LoadLocalAsset("rbxassetid://18490507748");
	Blur = loadstring(game:HttpGet("https://raw.githubusercontent.com/lxte/lates-lib/main/Assets/Blur.lua"))();
else
	Screen = (script.Parent);
	Blur = require(script.Blur)
end

Screen.Main.Visible = false

xpcall(function()
	Screen.Parent = game.CoreGui
end, function() 
	Screen.Parent = Player.GUI
end)

--// Tables for Data
local Animations = {}
local Blurs = {}
local Components = (Screen:FindFirstChild("Components"));
local Library = {};
local StoredInfo = {
	["Sections"] = {};
	["Tabs"] = {}
};

--// Animations [Window]
function Animations:Open(Window, Transparency, UseCurrentSize)
	if not Window then return end
	local Original = (UseCurrentSize and Window.Size) or Setup.Size
	local Multiplied = Multiply(Original, 1.1)
	local Shadow = Window:FindFirstChildOfClass("UIStroke")
	SetProperty(Shadow, { Transparency = 1 })
	SetProperty(Window, {
		Size = Multiplied,
		GroupTransparency = 1,
		Visible = true,
	})
	Tween(Shadow, .25, { Transparency = 0.5 })
	Tween(Window, .25, {
		Size = Original,
		GroupTransparency = Transparency or 0,
	})
end

function Animations:Close(Window)
	if not Window then return end
	local Original = Window.Size
	local Multiplied = Multiply(Original, 1.1)
	local Shadow = Window:FindFirstChildOfClass("UIStroke")
	SetProperty(Window, { Size = Original, })
	Tween(Shadow, .25, { Transparency = 1 })
	Tween(Window, .25, {
		Size = Multiplied,
		GroupTransparency = 1,
	})
	task.wait(.25)
	Window.Size = Original
	Window.Visible = false
end

function Animations:Component(Component, Custom)
	if not Component then return end
	Connect(Component.InputBegan, function() 
		if Custom then
			Tween(Component, .25, { Transparency = .85 });
		else
			Tween(Component, .25, { BackgroundColor3 = Color(Theme.Component, 5, Setup.ThemeMode) });
		end
	end)
	Connect(Component.InputEnded, function() 
		if Custom then
			Tween(Component, .25, { Transparency = 1 });
		else
			Tween(Component, .25, { BackgroundColor3 = Theme.Component });
		end
	end)
end

--// Library [Window]
function Library:CreateWindow(Settings)
	local Window = Clone(Screen:FindFirstChild("Main"))
	if not Window then warnMissingAsset("Main"); return {} end
	local Sidebar = Window:FindFirstChild("Sidebar")
	local Holder = Window:FindFirstChild("Main")
	local BG = Window:FindFirstChild("BackgroundShadow")
	local Tab = Sidebar and Sidebar:FindFirstChild("Tab") or nil

	local Options = {}
	local Examples = {}
	local Opened = true
	local Maximized = false
	local BlurEnabled = false

	for _, Example in next, Window:GetDescendants() do
		if Example.Name:find("Example") and not Examples[Example.Name] then
			Examples[Example.Name] = Example
		end
	end

	-- UI Blur, Drag, Resize
	Drag(Window);
	Resizeable(Window, Vector2.new(411, 271), Vector2.new(9e9, 9e9));
	Setup.Transparency = Settings.Transparency or 0
	Setup.Size = Settings.Size
	Setup.ThemeMode = Settings.Theme or "Dark"
	if Settings.Blurring then
		Blurs[Settings.Title] = Blur.new(Window, 5)
		BlurEnabled = true
	end
	if Settings.MinimizeKeybind then
		Setup.Keybind = Settings.MinimizeKeybind
	end

	local Close = function()
		if Opened then
			if BlurEnabled then
				Blurs[Settings.Title].root.Parent = nil
			end
			Opened = false
			Animations:Close(Window)
			Window.Visible = false
		else
			Animations:Open(Window, Setup.Transparency)
			Opened = true
			if BlurEnabled then
				Blurs[Settings.Title].root.Parent = workspace.CurrentCamera
			end
		end
	end

	if Sidebar and Sidebar:FindFirstChild("Top") and Sidebar.Top:FindFirstChild("Buttons") then
		for _, Button in next, Sidebar.Top.Buttons:GetChildren() do
			if Button:IsA("TextButton") then
				local Name = Button.Name
				Animations:Component(Button, true)
				Connect(Button.MouseButton1Click, function() 
					if Name == "Close" then
						Close()
					elseif Name == "Maximize" then
						if Maximized then
							Maximized = false
							Tween(Window, .15, { Size = Setup.Size });
						else
							Maximized = true
							Tween(Window, .15, { Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0.5, 0.5 )});
						end
					elseif Name == "Minimize" then
						Opened = false
						Window.Visible = false
						if Blurs[Settings.Title] then Blurs[Settings.Title].root.Parent = nil end
					end
				end)
			end
		end
	end

	Services.Input.InputBegan:Connect(function(Input, Focused) 
		if (Input == Setup.Keybind or Input.KeyCode == Setup.Keybind) and not Focused then
			Close()
		end
	end)

	function Options:SetTab(Name)
		if not Tab then return end
		for _, Button in next, Tab:GetChildren() do
			if Button:IsA("TextButton") then
				local Opened, SameName = Button.Value, (Button.Name == Name)
				local Padding = Button:FindFirstChildOfClass("UIPadding")
				if SameName and not Opened.Value then
					Tween(Padding, .25, { PaddingLeft = UDim.new(0, 25) });
					Tween(Button, .25, { BackgroundTransparency = 0.9, Size = UDim2.new(1, -15, 0, 30) });
					SetProperty(Opened, { Value = true });
				elseif not SameName and Opened.Value then
					Tween(Padding, .25, { PaddingLeft = UDim.new(0, 20) });
					Tween(Button, .25, { BackgroundTransparency = 1, Size = UDim2.new(1, -44, 0, 30) });
					SetProperty(Opened, { Value = false });
				end
			end
		end

		for _, Main in next, Holder:GetChildren() do
			if Main:IsA("CanvasGroup") then
				local Opened, SameName = Main.Value, (Main.Name == Name)
				local Scroll = Main:FindFirstChild("ScrollingFrame")
				if SameName and not Opened.Value then
					Opened.Value = true
					Main.Visible = true
					Tween(Main, .3, { GroupTransparency = 0 });
					if Scroll and Scroll:FindFirstChild("UIPadding") then
						Tween(Scroll["UIPadding"], .3, { PaddingTop = UDim.new(0, 5) });
					end
				elseif not SameName and Opened.Value then
					Opened.Value = false
					Tween(Main, .15, { GroupTransparency = 1 });
					if Scroll and Scroll:FindFirstChild("UIPadding") then
						Tween(Scroll["UIPadding"], .15, { PaddingTop = UDim.new(0, 15) });
					end
					task.delay(.2, function() Main.Visible = false end)
				end
			end
		end
	end

	function Options:AddTabSection(Settings)
		local Example = Examples["SectionExample"]
		if not Example then warnMissingAsset("SectionExample"); return end
		local Section = Clone(Example)
		StoredInfo["Sections"][Settings.Name] = (Settings.Order)
		SetProperty(Section, { 
			Parent = Example.Parent,
			Text = Settings.Name,
			Name = Settings.Name,
			LayoutOrder = Settings.Order,
			Visible = true
		})
	end

	function Options:AddTab(Settings)
		if StoredInfo["Tabs"][Settings.Title] then 
			error("[UI LIB]: A tab with the same name has already been created") 
		end 

		local Example, MainExample = Examples["TabButtonExample"], Examples["MainExample"]
		if not Example then warnMissingAsset("TabButtonExample"); return end
		if not MainExample then warnMissingAsset("MainExample"); return end

		local Section = StoredInfo["Sections"][Settings.Section];
		local Main = Clone(MainExample)
		local Tab = Clone(Example)

		if not Settings.Icon then
			if Tab:FindFirstChild("ICO") then Destroy(Tab["ICO"]) end
		else
			if Tab:FindFirstChild("ICO") then SetProperty(Tab["ICO"], { Image = Settings.Icon }) end
		end

		StoredInfo["Tabs"][Settings.Title] = { Tab }
		SetProperty(Tab["TextLabel"], { Text = Settings.Title })

		SetProperty(Main, { 
			Parent = MainExample.Parent,
			Name = Settings.Title;
		})

		SetProperty(Tab, { 
			Parent = Example.Parent,
			LayoutOrder = Section or #StoredInfo["Sections"] + 1,
			Name = Settings.Title;
			Visible = true,
		})

		Tab.MouseButton1Click:Connect(function()
			Options:SetTab(Tab.Name)
		end)

		-- DASHBOARD FITUR KHUSUS
		if Settings.Title == "Dashboard" then
			local ScrollingFrame = Main:FindFirstChild("ScrollingFrame")
			if ScrollingFrame then
				local playerName = LocalPlayer and LocalPlayer.Name or "Guest"
				local playerId = LocalPlayer and LocalPlayer.UserId or 1
				local function getAvatarUrl(userId)
					return string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", userId)
				end

				local avatar = Instance.new("ImageLabel")
				avatar.Name = "UserAvatar"
				avatar.Size = UDim2.new(0, 64, 0, 64)
				avatar.Position = UDim2.new(0, 10, 0, 10)
				avatar.BackgroundTransparency = 1
				avatar.Image = getAvatarUrl(playerId)
				avatar.Parent = ScrollingFrame

				local userLabel = Instance.new("TextLabel")
				userLabel.Name = "UserNameLabel"
				userLabel.Text = playerName
				userLabel.Font = Enum.Font.GothamBold
				userLabel.TextSize = 18
				userLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				userLabel.BackgroundTransparency = 1
				userLabel.Position = UDim2.new(0, 90, 0, 25)
				userLabel.Size = UDim2.new(0, 200, 0, 30)
				userLabel.Parent = ScrollingFrame

				local descLabel = Instance.new("TextLabel")
				descLabel.Text = "Furinafield adalah UI library premium untuk Roblox yang menghadirkan tampilan modern, fitur lengkap, dan kemudahan integrasi ke script kamu."
				descLabel.Font = Enum.Font.Gotham
				descLabel.TextSize = 16
				descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				descLabel.BackgroundTransparency = 1
				descLabel.Position = UDim2.new(0, 10, 0, 90)
				descLabel.Size = UDim2.new(1, -20, 0, 50)
				descLabel.TextWrapped = true
				descLabel.Parent = ScrollingFrame

				local creatorTitle = Instance.new("TextLabel")
				creatorTitle.Text = "Creator"
				creatorTitle.Font = Enum.Font.GothamBold
				creatorTitle.TextSize = 16
				creatorTitle.TextColor3 = Color3.fromRGB(240,240,240)
				creatorTitle.BackgroundTransparency = 1
				creatorTitle.Position = UDim2.new(0, 10, 0, 155)
				creatorTitle.Size = UDim2.new(0, 100, 0, 20)
				creatorTitle.Parent = ScrollingFrame

				local creatorAvatar = Instance.new("ImageLabel")
				creatorAvatar.Name = "CreatorAvatar"
				creatorAvatar.Size = UDim2.new(0, 64, 0, 64)
				creatorAvatar.Position = UDim2.new(0, 10, 0, 180)
				creatorAvatar.BackgroundTransparency = 1
				creatorAvatar.Image = getAvatarUrl(4488332506)
				creatorAvatar.Parent = ScrollingFrame

				local creatorName = Instance.new("TextLabel")
				creatorName.Text = "XyraaDeFontine"
				creatorName.Font = Enum.Font.GothamBold
				creatorName.TextSize = 18
				creatorName.TextColor3 = Color3.fromRGB(255,255,255)
				creatorName.BackgroundTransparency = 1
				creatorName.Position = UDim2.new(0, 90, 0, 200)
				creatorName.Size = UDim2.new(0, 200, 0, 30)
				creatorName.Parent = ScrollingFrame
			end
		end

		return Main.ScrollingFrame
	end

	-- NOTIFICATIONS
	function Options:Notify(Settings)
		local Notif = Components and Components:FindFirstChild("Notification")
		if not Notif then warnMissingAsset("Notification"); return end
		local Notification = Clone(Notif)
		local Title, Description = Options:GetLabels(Notification)
		local Timer = Notification:FindFirstChild("Timer")
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Notification, { Parent = Screen:FindFirstChild("Frame"), })
		task.spawn(function() 
			local Duration = Settings.Duration or 2
			Animations:Open(Notification, Setup.Transparency, true); Tween(Timer, Duration, { Size = UDim2.new(0, 0, 0, 4) });
			task.wait(Duration);
			Animations:Close(Notification);
			task.wait(1);
			Notification:Destroy();
		end)
	end

	-- Component Functions
	function Options:GetLabels(Component)
		local Labels = Component and Component:FindFirstChild("Labels")
		if not Labels then return {}, {} end
		return Labels.Title, Labels.Description
	end

	function Options:AddSection(Settings)
		local SectionTemplate = Components and Components:FindFirstChild("Section")
		if not SectionTemplate then warnMissingAsset("Section"); return end
		local Section = Clone(SectionTemplate)
		SetProperty(Section, {
			Text = Settings.Name,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddButton(Settings)
		local BtnTemplate = Components and Components:FindFirstChild("Button")
		if not BtnTemplate then warnMissingAsset("Button"); return end
		local Button = Clone(BtnTemplate)
		local Title, Description = Options:GetLabels(Button)
		Connect(Button.MouseButton1Click, Settings.Callback)
		Animations:Component(Button)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Button, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddInput(Settings)
		local InputTemplate = Components and Components:FindFirstChild("Input")
		if not InputTemplate then warnMissingAsset("Input"); return end
		local Input = Clone(InputTemplate)
		local Title, Description = Options:GetLabels(Input)
		local TextBox = Input["Main"] and Input["Main"]:FindFirstChild("Input")
		if Input.MouseButton1Click and TextBox then
			Connect(Input.MouseButton1Click, function() TextBox:CaptureFocus() end)
			Connect(TextBox.FocusLost, function() Settings.Callback(TextBox.Text) end)
		end
		Animations:Component(Input)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Input, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddToggle(Settings)
		local ToggleTemplate = Components and Components:FindFirstChild("Toggle")
		if not ToggleTemplate then warnMissingAsset("Toggle"); return end
		local Toggle = Clone(ToggleTemplate)
		local Title, Description = Options:GetLabels(Toggle)
		local On = Toggle:FindFirstChild("Value")
		local Main = Toggle:FindFirstChild("Main")
		local Circle = Main and Main:FindFirstChild("Circle")
		local Set = function(Value)
			if not Main or not Circle then return end
			if Value then
				Tween(Main,   .2, { BackgroundColor3 = Color3.fromRGB(153, 155, 255) })
				Tween(Circle, .2, { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -16, 0.5, 0) })
			else
				Tween(Main,   .2, { BackgroundColor3 = Theme.Interactables })
				Tween(Circle, .2, { BackgroundColor3 = Theme.Primary, Position = UDim2.new(0, 3, 0.5, 0) })
			end
			On.Value = Value
		end
		Connect(Toggle.MouseButton1Click, function()
			local Value = not On.Value
			Set(Value)
			Settings.Callback(Value)
		end)
		Animations:Component(Toggle)
		Set(Settings.Default)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Toggle, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddKeybind(Settings)
		local KeybindTemplate = Components and Components:FindFirstChild("Keybind")
		if not KeybindTemplate then warnMissingAsset("Keybind"); return end
		local Dropdown = Clone(KeybindTemplate)
		local Title, Description = Options:GetLabels(Dropdown)
		local Bind = Dropdown["Main"] and Dropdown["Main"]:FindFirstChild("Options")
		local Mouse = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3 }
		local Types = { ["Mouse"] = "Enum.UserInputType.MouseButton", ["Key"] = "Enum.KeyCode." }
		Connect(Dropdown.MouseButton1Click, function()
			SetProperty(Bind, { Text = "..." })
			local Finished = false
			local Detect
			Detect = Connect(game.UserInputService.InputBegan, function(Key, Focused) 
				local InputType = Key.UserInputType
				if not Finished and not Focused then
					Finished = true
					if table.find(Mouse, InputType) then
						Settings.Callback(Key);
						SetProperty(Bind, {Text = tostring(InputType):gsub(Types.Mouse, "MB")})
					elseif InputType == Enum.UserInputType.Keyboard then
						Settings.Callback(Key);
						SetProperty(Bind, {Text = tostring(Key.KeyCode):gsub(Types.Key, "")})
					end
				end 
			end)
		end)
		Animations:Component(Dropdown)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Dropdown, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddDropdown(Settings)
		local DropdownTemplate = Components and Components:FindFirstChild("Dropdown")
		if not DropdownTemplate then warnMissingAsset("Dropdown"); return end
		local Dropdown = Clone(DropdownTemplate)
		local Title, Description = Options:GetLabels(Dropdown)
		local Text = Dropdown["Main"] and Dropdown["Main"]:FindFirstChild("Options")
		Connect(Dropdown.MouseButton1Click, function()
			local Example = Examples["DropdownExample"]
			if not Example then warnMissingAsset("DropdownExample"); return end
			Example = Clone(Example)
			local Buttons = Example:FindFirstChild("Top") and Example.Top:FindFirstChild("Buttons")
			Tween(BG, .25, { BackgroundTransparency = 0.6 })
			SetProperty(Example, { Parent = Window })
			Animations:Open(Example, 0, true)
			if Buttons then
				for _, Button in next, Buttons:GetChildren() do
					if Button:IsA("TextButton") then
						Animations:Component(Button, true)
						Connect(Button.MouseButton1Click, function()
							Tween(BG, .25, { BackgroundTransparency = 1 })
							Animations:Close(Example)
							task.wait(2)
							Destroy(Example)
						end)
					end
				end
			end
			for Index, Option in next, Settings.Options do
				local BtnExample = Examples["DropdownButtonExample"]
				if not BtnExample then warnMissingAsset("DropdownButtonExample"); return end
				local Button = Clone(BtnExample)
				local Title, Description = Options:GetLabels(Button)
				local Selected = Button:FindFirstChild("Value")
				Animations:Component(Button)
				SetProperty(Title, { Text = Index })
				SetProperty(Button, { Parent = Example.ScrollingFrame, Visible = true })
				if Description then Destroy(Description) end
				Connect(Button.MouseButton1Click, function() 
					local NewValue = not Selected.Value 
					if NewValue then
						Tween(Button, .25, { BackgroundColor3 = Theme.Interactables })
						Settings.Callback(Option)
						Text.Text = Index
						for _, Others in next, Example:GetChildren() do
							if Others:IsA("TextButton") and Others ~= Button then
								Others.BackgroundColor3 = Theme.Component
							end
						end
					else
						Tween(Button, .25, { BackgroundColor3 = Theme.Component })
					end
					Selected.Value = NewValue
					Tween(BG, .25, { BackgroundTransparency = 1 })
					Animations:Close(Example)
					task.wait(2)
					Destroy(Example)
				end)
			end
		end)
		Animations:Component(Dropdown)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Dropdown, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddSlider(Settings)
		local SliderTemplate = Components and Components:FindFirstChild("Slider")
		if not SliderTemplate then warnMissingAsset("Slider"); return end
		local Slider = Clone(SliderTemplate)
		local Title, Description = Options:GetLabels(Slider)
		local Main = Slider:FindFirstChild("Slider")
		local Amount = Main and Main:FindFirstChild("Main") and Main.Main:FindFirstChild("Input")
		local Slide = Main and Main:FindFirstChild("Slide")
		local Fill = Slide and Slide:FindFirstChild("Highlight")
		local Circle = Fill and Fill:FindFirstChild("Circle")
		local Fire = Slide and Slide:FindFirstChild("Fire")
		local Active, Value = false, 0
		local SetNumber = function(Number)
			if Settings.AllowDecimals then
				local Power = 10 ^ (Settings.DecimalAmount or 2)
				Number = math.floor(Number * Power + 0.5) / Power
			else
				Number = math.round(Number)
			end
			return Number
		end
		local Update = function(Number)
			if not Slide then return end
			local Scale = (Player.Mouse.X - Slide.AbsolutePosition.X) / Slide.AbsoluteSize.X			
			Scale = (Scale > 1 and 1) or (Scale < 0 and 0) or Scale
			if Number then
				Number = (Number > Settings.MaxValue and Settings.MaxValue) or (Number < 0 and 0) or Number
			end
			Value = SetNumber(Number or (Scale * Settings.MaxValue))
			if Amount then Amount.Text = Value end
			if Fill then Fill.Size = UDim2.fromScale((Number and Number / Settings.MaxValue) or Scale, 1) end
			Settings.Callback(Value)
		end
		local Activate = function()
			Active = true
			repeat task.wait() Update() until not Active
		end
		if Amount then Connect(Amount.FocusLost, function() Update(tonumber(Amount.Text) or 0) end) end
		if Fire then Connect(Fire.MouseButton1Down, Activate) end
		Connect(Services.Input.InputEnded, function(Input) 
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Active = false
			end
		end)
		if Fill then Fill.Size = UDim2.fromScale(Value, 1) end
		Animations:Component(Slider)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Slider, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddParagraph(Settings)
		local ParagraphTemplate = Components and Components:FindFirstChild("Paragraph")
		if not ParagraphTemplate then warnMissingAsset("Paragraph"); return end
		local Paragraph = Clone(ParagraphTemplate)
		local Title, Description = Options:GetLabels(Paragraph)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Paragraph, {
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	-- SetTheme, SetSetting, Toggle (tidak diubah)
	-- ... (bagian ini bisa tetap seperti versi kamu, atau pakai versi sebelumnya)

	SetProperty(Window, { Size = Settings.Size, Visible = true, Parent = Screen })
	Animations:Open(Window, Settings.Transparency or 0)

	function Options:Toggle(value)
		if value == nil then value = not Opened end
		if value then
			Animations:Open(Window, Setup.Transparency)
			Opened = true
			if BlurEnabled and Blurs[Settings.Title] then
				Blurs[Settings.Title].root.Parent = workspace.CurrentCamera
			end
		else
			Opened = false
			Animations:Close(Window)
			if BlurEnabled and Blurs[Settings.Title] then
				Blurs[Settings.Title].root.Parent = nil
			end
		end
	end

	return Options
end

return Library