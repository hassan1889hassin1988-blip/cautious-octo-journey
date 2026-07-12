if not game:IsLoaded() then
    game.Loaded:Wait()
end
local function copyLink(title, url)
    setclipboard(url)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✅ Copied!",
        Text = title .. " link copied to clipboard.",
        Duration = 3,
    })
end

local function createsupport()
    local SupportTab = Window:Tab({
        Title = "Support",
        Icon = "support",
        IconThemed = false,
        Locked = false,
    })

    SupportTab:Select()

    local supportButtons = {
        {"💎 3 Robux",             "https://www.roblox.com/game-pass/1393917970/3-rbx"},
        {"💎 5 Robux",             "https://www.roblox.com/game-pass/1394051778/5-rbx"},
        {"💎 7 Robux",             "https://www.roblox.com/game-pass/1590110782/7-ROBUX"},
        {"💎 10 Robux",            "https://www.roblox.com/game-pass/1397546692/10-rbx"},
        {"💎 20 Robux",            "https://www.roblox.com/game-pass/1399668269/20-rbx"},
        {"💎 50 Robux",            "https://www.roblox.com/game-pass/1396221207/50-rbx"},
        {"💎 100 Robux",           "https://www.roblox.com/game-pass/1394439639/100-rbx"},
        {"💎 150 Robux",           "https://www.roblox.com/game-pass/1421451261/Thanks"},
        {"💎 200 Robux",           "https://www.roblox.com/game-pass/1423400055/Ty"},
        {"💎 300 Robux",           "https://www.roblox.com/game-pass/1504992105/300-rbx"},
        {"💎 500 Robux",           "https://www.roblox.com/game-pass/1395963387/500-rbx"},
        {"💎 1000 Robux",          "https://www.roblox.com/game-pass/1394041876/1000-rbx"},
        {"💎 1000 Robux (Thanks)", "https://www.roblox.com/game-pass/1460106222/Thanks-nnnnn"},
        {"💎 2500 Robux",          "https://www.roblox.com/game-pass/1437117512/2-500-robux"},
        {"💎 3000 Robux",          "https://www.roblox.com/game-pass/1587430862/3000-Robux"},
        {"💎 5000 Robux",          "https://www.roblox.com/game-pass/1395963387/5000-rbx"},
        {"💎 10000 Robux",         "https://www.roblox.com/game-pass/1399060598/10000-rbx"},
    }

    for _, entry in ipairs(supportButtons) do
        local title, url = entry[1], entry[2]
        local Button = SupportTab:Button({
            Title = title,
            Justify = "Center",
            IconAlign = "Left",
            Icon = "",
            Callback = function()
                copyLink(title, url)
            end,
        })
        Button:SetDesc("Copies the support link to your clipboard")
    end
end
local function createaddon()
    local AddonsTab = Window:Tab({
        Title = "Add-ons",
        Icon = "solar:plug-circle-bold",
        NewElements = true,
    })

    if not isfolder("TZHub") then makefolder("TZHub") end
    if not isfolder("TZHub/addons") then makefolder("TZHub/addons") end

    local function LoadAddons()
        local ok, files = pcall(listfiles, "TZHub/addons")
        if not ok or not files then return end

        getgenv().TZAddonsTab = AddonsTab  -- ← added this

        for _, path in ipairs(files) do
            if typeof(path) == "string" and path:sub(-4) == ".lua" then
                local success, err = pcall(function()
                    local src = readfile(path)
                    local fn, compileErr = loadstring(src)
                    if fn then
                        fn()  -- ← removed AddonsTab arg
                    else
                        warn("[TZ Add-ons] Compile error in " .. path .. ": " .. tostring(compileErr))
                    end
                end)
                if not success then
                    warn("[TZ Add-ons] Runtime error in " .. path .. ": " .. tostring(err))
                end
            end
        end
    end

    LoadAddons()
end

local function createowner()
  local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local function notify(player)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "OwnerNotif_" .. player.Name
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 999
	pcall(function() ScreenGui.Parent = CoreGui end)
	if not ScreenGui.Parent or ScreenGui.Parent ~= CoreGui then
		ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	end

	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0, 320, 0, 80)
	Frame.Position = UDim2.new(1, 20, 0, 24)
	Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	Frame.BorderSizePixel = 0
	Frame.Parent = ScreenGui

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 12)
	Corner.Parent = Frame

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(255, 215, 0)
	Stroke.Thickness = 1.5
	Stroke.Transparency = 0.3
	Stroke.Parent = Frame

	local Gradient = Instance.new("UIGradient")
	Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 20, 10)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 18))
	})
	Gradient.Rotation = 135
	Gradient.Parent = Frame

	local AccentBar = Instance.new("Frame")
	AccentBar.Size = UDim2.new(0, 4, 1, -20)
	AccentBar.Position = UDim2.new(0, 10, 0, 10)
	AccentBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
	AccentBar.BorderSizePixel = 0
	AccentBar.Parent = Frame
	Instance.new("UICorner", AccentBar).CornerRadius = UDim.new(1, 0)

	local Icon = Instance.new("TextLabel")
	Icon.Size = UDim2.new(0, 30, 0, 30)
	Icon.Position = UDim2.new(0, 22, 0, 12)
	Icon.BackgroundTransparency = 1
	Icon.Text = "👑"
	Icon.TextSize = 22
	Icon.Font = Enum.Font.GothamBold
	Icon.Parent = Frame

	local Avatar = Instance.new("ImageLabel")
	Avatar.Size = UDim2.new(0, 36, 0, 36)
	Avatar.Position = UDim2.new(0, 54, 0.5, -18)
	Avatar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	Avatar.BorderSizePixel = 0
	Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=48&height=48&format=png"
	Avatar.Parent = Frame
	local AvatarCorner = Instance.new("UICorner")
	AvatarCorner.CornerRadius = UDim.new(1, 0)
	AvatarCorner.Parent = Avatar

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(0, 200, 0, 22)
	Title.Position = UDim2.new(0, 100, 0, 12)
	Title.BackgroundTransparency = 1
	Title.Text = "⚡ Owner Detected"
	Title.TextColor3 = Color3.fromRGB(255, 215, 0)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 14
	Title.Parent = Frame

	local Sub = Instance.new("TextLabel")
	Sub.Size = UDim2.new(0, 200, 0, 18)
	Sub.Position = UDim2.new(0, 100, 0, 34)
	Sub.BackgroundTransparency = 1
	Sub.Text = player.Name .. " joined your server"
	Sub.TextColor3 = Color3.fromRGB(200, 200, 200)
	Sub.TextXAlignment = Enum.TextXAlignment.Left
	Sub.Font = Enum.Font.Gotham
	Sub.TextSize = 12
	Sub.Parent = Frame

	local Tag = Instance.new("TextLabel")
	Tag.Size = UDim2.new(0, 180, 0, 14)
	Tag.Position = UDim2.new(0, 100, 0, 54)
	Tag.BackgroundTransparency = 1
	Tag.Text = "🔒 Server Owner  •  TZ HUB"
	Tag.TextColor3 = Color3.fromRGB(255, 215, 0)
	Tag.TextXAlignment = Enum.TextXAlignment.Left
	Tag.Font = Enum.Font.GothamBold
	Tag.TextSize = 10
	Tag.TextTransparency = 0.3
	Tag.Parent = Frame

	TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -340, 0, 24)
	}):Play()

	task.delay(6, function()
		local out = TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 20, 0, 24)
		})
		out:Play()
		out.Completed:Wait()
		ScreenGui:Destroy()
	end)

end

local function checkPlayer(player)
	if player.Name == "Ali_hhjjj" then
		notify(player)
	end
end

for _, p in ipairs(Players:GetPlayers()) do
	checkPlayer(p)
end

Players.PlayerAdded:Connect(checkPlayer)
-- Helper: copy to clipboard (works in many Roblox environments)
local function copyLink(name, url)
    local ok, err = pcall(function()
        if setclipboard then
            setclipboard(url)
        elseif syn and syn.request then
            -- syn doesn't provide clipboard by default; keep fallback
            error("No clipboard function available")
        else
            -- Try Roblox SetCore (may be restricted)
            pcall(function()
                game:GetService("StarterGui"):SetCore("CopyToClipboard", url)
            end)
        end
    end)

    if ok then
        print(("Copied %s -> %s"):format(name, url))
    else
        warn("Failed to copy to clipboard:", err)
    end
end
end
local function createcustom()
  do
	local CustomTab = Window:Tab({
		Title = "Custom",
		Icon = "bird",
		Border = true,
	})

	-- Utilities
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local RunService = game:GetService("RunService")
	local Workspace = game:GetService("Workspace")

	local function resolveObjectByName(name)
		if not name or name == "" then
			return nil
		end
		-- try direct child of workspace
		local obj = Workspace:FindFirstChild(name, true)
		if obj then
			return obj
		end
		-- try game:FindFirstChild anywhere
		obj = game:FindFirstChild(name, true)
		if obj then
			return obj
		end
		return nil
	end

	local function resolveObjectByPath(path)
		if not path or path == "" then
			return nil
		end
		-- Try dot-separated traversal starting from Workspace
		local parts = {}
		for part in string.gmatch(path, "[^%.%/]+") do
			table.insert(parts, part)
		end
		local current = Workspace
		for i, p in ipairs(parts) do
			if current and current.FindFirstChild then
				current = current:FindFirstChild(p)
			else
				current = nil
			end
			if not current then
				break
			end
		end
		if current then
			return current
		end
		-- fallback: global search by name
		return resolveObjectByName(path)
	end

	local function getTarget(objectName, objectPath)
		local target = nil
		if objectPath and objectPath ~= "" then
			target = resolveObjectByPath(objectPath)
		end
		if not target and objectName and objectName ~= "" then
			target = resolveObjectByName(objectName)
		end
		return target
	end

	-- Highlight Section
	local HighlightSection = CustomTab:Section({
		Title = "Highlight",
	})

	local highlightObjectName = ""
	local highlightObjectPath = ""
	local currentHighlightInstance = nil
	local autoHighlightEnabled = false
	local autoHighlightConn = nil

	HighlightSection:Input({
		Title = "Object Name",
		Placeholder = "Name of the object (optional if path provided)",
		Callback = function(v)
			highlightObjectName = v
		end,
	})

	HighlightSection:Input({
		Title = "Object Path (optional)",
		Placeholder = "Workspace.Model.Part or Model/SubModel/Part",
		Callback = function(v)
			highlightObjectPath = v
		end,
	})

	local function createHighlightFor(target)
		if not target then
			return
		end
		-- remove old
		if currentHighlightInstance and currentHighlightInstance.Parent then
			currentHighlightInstance:Destroy()
			currentHighlightInstance = nil
		end
		local ok, highlight = pcall(function()
			local h = Instance.new("Highlight")
			h.Name = ".ftgs_CustomHighlight"
			h.Adornee = target
			h.FillTransparency = 0.6
			h.OutlineTransparency = 0
			h.Parent = Workspace
			return h
		end)
		if ok then
			currentHighlightInstance = highlight
		end
	end

	HighlightSection:Button({
		Title = "Highlight Object",
		Color = Color3.fromHex("#30ff6a"),
		Callback = function()
			local target = getTarget(highlightObjectName, highlightObjectPath)
			if target then
				createHighlightFor(target)
			else
				WindUI:Notify({
					Title = "Highlight",
					Content = "Target not found.",
				})
			end
		end,
	})

	HighlightSection:Toggle({
		Title = "Auto Highlight",
		Desc = "Continuously keep highlight on the target (updates if target appears).",
		Value = false,
		Callback = function(state)
			autoHighlightEnabled = state
			if autoHighlightConn then
				autoHighlightConn:Disconnect()
				autoHighlightConn = nil
			end
			if state then
				autoHighlightConn = RunService.Heartbeat:Connect(function()
					local target = getTarget(highlightObjectName, highlightObjectPath)
					if target then
						if not currentHighlightInstance or currentHighlightInstance.Adornee ~= target then
							createHighlightFor(target)
						end
					else
						if currentHighlightInstance then
							currentHighlightInstance:Destroy()
							currentHighlightInstance = nil
						end
					end
				end)
			else
				if currentHighlightInstance then
					currentHighlightInstance:Destroy()
					currentHighlightInstance = nil
				end
			end
		end,
	})

	-- Teleport Section
	local TeleportSection = CustomTab:Section({
		Title = "Teleport",
	})

	local teleportObjectName = ""
	local teleportObjectPath = ""
	local teleportLoopEnabled = false
	local teleportLoopConn = nil
	local teleportInterval = 1 -- seconds between loop teleports

	TeleportSection:Input({
		Title = "Object Name",
		Placeholder = "Name of the object (optional if path provided)",
		Callback = function(v)
			teleportObjectName = v
		end,
	})

	TeleportSection:Input({
		Title = "Object Path (optional)",
		Placeholder = "Workspace.Model.Part or Model/SubModel/Part",
		Callback = function(v)
			teleportObjectPath = v
		end,
	})

	local function teleportToTarget(target)
		if not target then
			WindUI:Notify({
				Title = "Teleport",
				Content = "Target not found.",
			})
			return
		end
		local character = LocalPlayer and LocalPlayer.Character
		if not character then
			WindUI:Notify({
				Title = "Teleport",
				Content = "Character not found.",
			})
			return
		end
		local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
		if not hrp then
			WindUI:Notify({
				Title = "Teleport",
				Content = "HumanoidRootPart not found.",
			})
			return
		end
		local ok, pivot = pcall(function()
			if target:IsA("Model") then
				if target.PrimaryPart then
					return target.PrimaryPart.CFrame
				else
					return target:GetModelCFrame()
				end
			elseif target:IsA("BasePart") then
				return target.CFrame
			else
				-- try to find a primary part inside
				local bp = target:FindFirstChildWhichIsA("BasePart", true)
				if bp then
					return bp.CFrame
				end
			end
			return nil
		end)
		if ok and pivot then
			-- offset a little above
			local dest = pivot + Vector3.new(0, 3, 0)
			pcall(function()
				hrp.CFrame = dest
			end)
		else
			WindUI:Notify({
				Title = "Teleport",
				Content = "Could not determine target position.",
			})
		end
	end

	TeleportSection:Button({
		Title = "Teleport To Object",
		Color = Color3.fromHex("#257AF7"),
		Callback = function()
			local target = getTarget(teleportObjectName, teleportObjectPath)
			teleportToTarget(target)
		end,
	})

	TeleportSection:Toggle({
		Title = "Loop Teleport",
		Desc = "Continuously teleport to the target every second.",
		Value = false,
		Callback = function(state)
			teleportLoopEnabled = state
			if teleportLoopConn then
				teleportLoopConn:Disconnect()
				teleportLoopConn = nil
			end
			if state then
				local lastTick = 0
				teleportLoopConn = RunService.Heartbeat:Connect(function(dt)
					lastTick = lastTick + dt
					if lastTick >= teleportInterval then
						lastTick = 0
						local target = getTarget(teleportObjectName, teleportObjectPath)
						if target then
							teleportToTarget(target)
						end
					end
				end)
			end
		end,
	})

	local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- Variables for Trigger State
local triggerWatchPath = ""
local triggerExpectedValue = ""
local triggerEnabled = false
local triggerLoopTeleport = false -- New Toggle Variable
local triggerMatchType = "equals"
local triggerLoopConn = nil
local triggerTeleportTargetName = ""
local triggerTeleportTargetPath = ""
local triggerFired = false

-- 1. SMARTER VALUE DETECTOR
local function getObjectValue(obj)
    if not obj then return nil end
    
    -- Check ValueBase (BoolValue, StringValue, etc)
    if obj:IsA("ValueBase") then
        return obj.Value
    end
    
    -- Check Attributes
    local attr = obj:GetAttribute("Value") or obj:GetAttribute("Text") or obj:GetAttribute("Enabled")
    if attr ~= nil then return attr end

    -- Check common properties safely
    local commonProperties = {"Text", "Health", "Value", "Enabled", "Transparency"}
    for _, prop in ipairs(commonProperties) do
        local success, val = pcall(function() return obj[prop] end)
        if success and val ~= nil then return val end
    end

    return nil
end

-- 2. ROBUST PATH RESOLVER
local function resolveObjectByPath(path)
    if not path or path == "" then return nil end
    path = path:gsub("/", ".")
    local parts = path:split(".")
    
    local current = game
    local startIdx = 1
    
    if parts[1]:lower() == "game" then
        startIdx = 2
    elseif parts[1]:lower() == "workspace" then
        current = workspace
        startIdx = 2
    end
    
    for i = startIdx, #parts do
        local name = parts[i]
        local found = current:FindFirstChild(name)
        
        if not found and i == startIdx then
            local success, service = pcall(function() return game:GetService(name) end)
            if success then found = service end
        end
        
        if not found then return nil end
        current = found
    end
    return current
end

-- 3. TELEPORT UTILITY
local function teleportToTarget(target)
    local character = localPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp and target then
        local targetPos
        if target:IsA("Model") then
            targetPos = target:GetPivot()
        elseif target:IsA("BasePart") then
            targetPos = target.CFrame
        end
        
        if targetPos then
            hrp.CFrame = targetPos
        end
    end
end

-- 4. UI SECTION
local TriggerSection = CustomTab:Section({
    Title = "Smarter Trigger",
})

TriggerSection:Paragraph({
    Title = "Trigger Explanation",
    Desc = "Monitors an object. If 'Loop Teleport' is ON, you stay at the target while the condition is true. If OFF, you teleport only once.",
})

TriggerSection:Input({
    Title = "Object to Watch",
    Placeholder = "Workspace.Folder.ValueObj",
    Callback = function(v)
        triggerWatchPath = v
        triggerFired = false 
    end,
})

TriggerSection:Input({
    Title = "Teleport Target",
    Placeholder = "Part Name or Full Path",
    Callback = function(v)
        triggerTeleportTargetPath = v
        triggerTeleportTargetName = v
    end,
})

TriggerSection:Input({
    Title = "Expected Value",
    Placeholder = "e.g. 100 or true",
    Callback = function(v)
        triggerExpectedValue = v
        triggerFired = false
    end,
})

TriggerSection:Dropdown({
    Title = "Match Type",
    Values = { "equals", "contains", "greater", "less" },
    Value = "equals",
    Callback = function(v) triggerMatchType = v end,
})

-- NEW TOGGLE: Loop Teleport
TriggerSection:Toggle({
    Title = "Loop Teleport",
    Desc = "Keep teleporting as long as the condition is true.",
    Value = false,
    Callback = function(state)
        triggerLoopTeleport = state
    end,
})

TriggerSection:Toggle({
    Title = "Enable Trigger",
    Value = false,
    Callback = function(state)
        triggerEnabled = state
        triggerFired = false 

        if triggerLoopConn then
            triggerLoopConn:Disconnect()
            triggerLoopConn = nil
        end

        if state then
            triggerLoopConn = task.spawn(function()
                while triggerEnabled do
                    task.wait(0.1) 
                    
                    local watched = resolveObjectByPath(triggerWatchPath)
                    if watched then
                        local currentValue = getObjectValue(watched)
                        
                        if currentValue ~= nil then
                            local strCur = tostring(currentValue):lower()
                            local strExp = tostring(triggerExpectedValue):lower()
                            local numCur = tonumber(currentValue)
                            local numExp = tonumber(triggerExpectedValue)
                            
                            local matched = false
                            if triggerMatchType == "equals" then
                                matched = strCur == strExp
                            elseif triggerMatchType == "contains" then
                                matched = string.find(strCur, strExp, 1, true) ~= nil
                            elseif triggerMatchType == "greater" and numCur and numExp then
                                matched = numCur > numExp
                            elseif triggerMatchType == "less" and numCur and numExp then
                                matched = numCur < numExp
                            end

                            if matched then
                                -- Logic for Loop vs Single fire
                                if triggerLoopTeleport or not triggerFired then
                                    local target = resolveObjectByPath(triggerTeleportTargetPath) or workspace:FindFirstChild(triggerTeleportTargetName, true)
                                    if target then
                                        teleportToTarget(target)
                                        triggerFired = true -- Marks that it has fired at least once
                                    end
                                end
                            else
                                -- Reset when condition is no longer met
                                triggerFired = false 
                            end
                        end
                    end
                end
            end)
        end
    end,
})
end
end
local function createsettings()
  local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "solar:folder-with-files-bold",
    IconColor = Color3.fromRGB(255, 180, 0),
    Border = true,
})

local ConfigManager = Window.ConfigManager
local ConfigName = "default"
local myConfig = ConfigManager:CreateConfig(ConfigName)

local ConfigNameInput = SettingsTab:Input({
    Title = "Config Name",
    Icon = "file-cog",
    Callback = function(value)
        ConfigName = value
        myConfig = ConfigManager:CreateConfig(ConfigName)
    end,
})

local function refreshDropdown(dd)
    dd:Refresh(ConfigManager:AllConfigs())
end

local AllConfigsDropdown = SettingsTab:Dropdown({
    Title = "All Configs",
    Values = ConfigManager:AllConfigs(),
    Value = ConfigName,
    Callback = function(value)
        ConfigName = value
        ConfigNameInput:Set(value)
        myConfig = ConfigManager:CreateConfig(ConfigName)
    end,
})

SettingsTab:Button({
    Title = "Save Config",
    Callback = function()
        if myConfig:Save() then
            WindUI:Notify({
                Title = "Settings",
                Content = "Saved '"..ConfigName.."'",
                Icon = "check"
            })
        end
        refreshDropdown(AllConfigsDropdown)
    end,
})

SettingsTab:Button({
    Title = "Load Config",
    Callback = function()
        if myConfig:Load() then
            WindUI:Notify({
                Title = "Settings",
                Content = "Loaded '"..ConfigName.."'",
                Icon = "refresh-cw"
            })
        else
            WindUI:Notify({
                Title = "Settings",
                Content = "Failed to load '"..ConfigName.."'",
                Icon = "alert-triangle"
            })
        end
    end,
})

SettingsTab:Button({
    Title = "Delete Config",
    Color = Color3.fromRGB(255, 80, 80),
    Callback = function()
        if myConfig:Delete() then
            WindUI:Notify({
                Title = "Settings",
                Content = "Deleted '"..ConfigName.."'",
                Icon = "trash"
            })
        end
        refreshDropdown(AllConfigsDropdown)
    end,
})
--// Live Theme Editor in Settings Tab
local currentTheme = {
    Name = "Live Theme",
    Accent = Color3.fromRGB(200, 50, 50),
    Background = Color3.fromRGB(20, 20, 20),
    Outline = Color3.fromRGB(255, 255, 255),
    Text = Color3.fromRGB(255, 255, 255),
    Placeholder = Color3.fromRGB(120, 120, 120),
    Button = Color3.fromRGB(50, 50, 50),
    Icon = Color3.fromRGB(160, 160, 160),
}

--// Section inside Settings Tab
local ThemeSection = SettingsTab:Section({
    Title = "Your Theme!",
    Box = false,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17, -- optional
    Opened = true,
})

-- Accent Colorpicker
ThemeSection:Colorpicker({
    Title = "Accent Color",
    Desc = "Pick accent color for highlights",
    Default = currentTheme.Accent,
    Callback = function(color)
        currentTheme.Accent = color
        WindUI:AddTheme(currentTheme)
        WindUI:SetTheme("Live Theme")
    end
})

-- Background Colorpicker
ThemeSection:Colorpicker({
    Title = "Background Color",
    Desc = "Pick background color",
    Default = currentTheme.Background,
    Callback = function(color)
        currentTheme.Background = color
        WindUI:AddTheme(currentTheme)
        WindUI:SetTheme("Live Theme")
    end
})

-- Text Colorpicker
ThemeSection:Colorpicker({
    Title = "Text Color",
    Desc = "Pick text color",
    Default = currentTheme.Text,
    Callback = function(color)
        currentTheme.Text = color
        WindUI:AddTheme(currentTheme)
        WindUI:SetTheme("Live Theme")
    end
})

-- Reset Theme Button
ThemeSection:Button({
    Title = "Reset Theme",
    Desc = "Revert back to the default theme",
    Icon = "solar:refresh-bold",
    Callback = function()
        WindUI:SetTheme("Crimson") -- change "Crimson" if your default is different
        WindUI:Notify({
            Title = "Theme Reset",
            Content = "Theme has been reset to default (Crimson).",
            Icon = "solar:palette-bold",
            Duration = 4,
        })
    end
})
end
local function createdonor()
  --// SERVICES
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

--// CONFIGURATION
local AllowedUsers = {
    ["Ali_hhjjj"] = true,
    ["ananana_201601"] = true,
    ["ayllaaa_718474"] = true
}

local DonorGamepasses = {
    1423400055, 1504992105, 1395983236, 1394041876,
    1460106222, 1437117512, 1399060598
}

--// CONSTANTS (SIGNALS)
local TAG_IAMHERE      = "rbxassetid://0_TZ_IAMHERE"
local TAG_FREEZE       = "rbxassetid://0_TZ_FRZ"
local TAG_BRING        = "rbxassetid://0_TZ_BRING"
local TAG_FLING        = "rbxassetid://0_TZ_FLING"
local TAG_HIGHLIGHT    = "rbxassetid://0_TZ_HIGHT"
local TAG_JUMPSCARE    = "rbxassetid://0_TZ_SCARE"
local TAG_CRASH        = "rbxassetid://0_TZ_CRASH"
local TAG_KICK         = "rbxassetid://0_TZ_KICK"
local TAG_NOISE        = "rbxassetid://0_TZ_NOISE"
local TAG_SIT   = "rbxassetid://0_TZ_SIT"      -- ← add this

--// JUMPSCARE DATA
local Scares = {
    Granny =   {Img = "rbxassetid://13979337521", Snd = "rbxassetid://9069608259"},
    Jeff =     {Img = "rbxassetid://5464680274",  Snd = "rbxassetid://5567522792"},
    Screamer = {Img = "rbxassetid://14948439436", Snd = "rbxassetid://338967351"},
    Troll =    {Img = "rbxassetid://7047491714",  Snd = "rbxassetid://1534913678"}
}

--// STATE VARIABLES
local DetectedPlayers = {}
local TZUsers = {}
local State = { CrashLoop = nil, SitLoop = nil }

--// HELPER FUNCTIONS
local function isAuthorized(player)
    return AllowedUsers[(player or LocalPlayer).Name] == true
end

local function isDonor()
    if isAuthorized() then return true end
    for _, id in pairs(DonorGamepasses) do
        local s, r = pcall(function() return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, id) end)
        if s and r then return true end
    end
    return false
end

local function getChar(p)
    local player = p or LocalPlayer
    local c = player.Character
    return c, c and c:FindFirstChild("Humanoid"), c and c:FindFirstChild("HumanoidRootPart")
end

--// T-POSE FIX: stop track immediately after play
local function sendCmd(tag, target, all, v1, v2)
    local tName = all and "ALL" or target
    if not tName or tName == "No Players" then return end
    local payload = tag .. "||" .. tName .. "||" .. tostring(v1 or "") .. "||" .. tostring(v2 or "")
    local _, hum = getChar()
    if hum then
        local anim = Instance.new("Animation")
        anim.AnimationId = payload
        local ok, track = pcall(function() return hum:LoadAnimation(anim) end)
        if ok and track then
            track:Play()
            track:Stop(0)
        end
    end
end

--// PLAYER LIST HELPERS
local function getAllPlayerNames()
    local names = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    if #names == 0 then table.insert(names, "No Players") end
    return names
end

--// ====================================================
--// UI CONSTRUCTION
--// ====================================================

local DonorTab = Window:Tab({ Title = "Donor control", Icon = "solar:gift-bold" })

--// DROPDOWN REFS (declared early so refresher can reach them)
local PhysDrop, ScareDrop, AdvDrop, NoiseDrop, SitDrop

local function refreshAllDropdowns()
local list = getAllPlayerNames()
if PhysDrop  then PhysDrop:Refresh(list)  end
if ScareDrop then ScareDrop:Refresh(list) end
if AdvDrop   then AdvDrop:Refresh(list)   end
if NoiseDrop then NoiseDrop:Refresh(list) end
if SitDrop   then SitDrop:Refresh(list)   end   -- ← add this
end

Players.PlayerAdded:Connect(function()
    task.wait(1)
    refreshAllDropdowns()
end)
Players.PlayerRemoving:Connect(function()
    task.wait(0.1)
    refreshAllDropdowns()
end)

getgenv().UpdateDropdown = refreshAllDropdowns

if isDonor() then
    --// PHYSICAL SECTION
    DonorTab:Section({ Title = "Physical Controls" })
    local PhysTarget, PhysAll = nil, false

    --// SCAN BUTTON
    DonorTab:Button({ Title = "Scan TZ Users", Callback = function()
        local found = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and TZUsers[p.Name] then
                table.insert(found, p.Name)
            end
        end
        if #found > 0 then
            Window:Notify({ Title = "TZ Users Found (" .. #found .. ")", Desc = table.concat(found, ", "), Duration = 6 })
        else
            Window:Notify({ Title = "Scan Complete", Desc = "No TZ users detected yet — wait a few seconds and retry", Duration = 4 })
        end
    end })

    PhysDrop = DonorTab:Dropdown({
        Title = "Target",
        Values = getAllPlayerNames(),
        Callback = function(v)
            PhysTarget = v
            if v == "No Players" then return end
            if TZUsers[v] then
                Window:Notify({ Title = "✅ " .. v, Desc = "TZ Hub detected on this player", Duration = 3 })
            else
                Window:Notify({ Title = "❌ " .. v, Desc = "No TZ Hub detected", Duration = 3 })
            end
        end
    })
    DonorTab:Toggle({ Title = "Target Everyone", Callback = function(v) PhysAll = v end })
    DonorTab:Toggle({ Title = "Freeze", Callback = function(v) sendCmd(TAG_FREEZE, PhysTarget, PhysAll, v) end })
    DonorTab:Button({ Title = "Fling", Callback = function() sendCmd(TAG_FLING, PhysTarget, PhysAll) end })
    DonorTab:Button({ Title = "Bring", Callback = function() sendCmd(TAG_BRING, PhysTarget, PhysAll) end })

    --// JUMPSCARE SECTION
    DonorTab:Section({ Title = "Jumpscare Menu" })
    local ScareTarget, ScareAll = nil, false
    ScareDrop = DonorTab:Dropdown({
        Title = "Victim",
        Values = getAllPlayerNames(),
        Callback = function(v)
            ScareTarget = v
            if v == "No Players" then return end
            if TZUsers[v] then
                Window:Notify({ Title = "✅ " .. v, Desc = "TZ Hub detected on this player", Duration = 3 })
            else
                Window:Notify({ Title = "❌ " .. v, Desc = "No TZ Hub detected", Duration = 3 })
            end
        end
    })
    DonorTab:Toggle({ Title = "Target Everyone", Callback = function(v) ScareAll = v end })
    for name, _ in pairs(Scares) do
        DonorTab:Button({ Title = name, Callback = function()
            local d = Scares[name]
            sendCmd(TAG_JUMPSCARE, ScareTarget, ScareAll, d.Img, d.Snd)
        end })
    end

    --// ADVANCED SECTION
    DonorTab:Section({ Title = "Advanced Control" })
    local AdvTarget, AdvAll = nil, false
    AdvDrop = DonorTab:Dropdown({
        Title = "Target",
        Values = getAllPlayerNames(),
        Callback = function(v)
            AdvTarget = v
            if v == "No Players" then return end
            if TZUsers[v] then
                Window:Notify({ Title = "✅ " .. v, Desc = "TZ Hub detected on this player", Duration = 3 })
            else
                Window:Notify({ Title = "❌ " .. v, Desc = "No TZ Hub detected", Duration = 3 })
            end
        end
    })
    DonorTab:Toggle({ Title = "Target Everyone", Callback = function(v) AdvAll = v end })
    DonorTab:Toggle({ Title = "Highlight", Callback = function(v) sendCmd(TAG_HIGHLIGHT, AdvTarget, AdvAll, v) end })
    DonorTab:Toggle({ Title = "Screen Crash", Callback = function(v) sendCmd(TAG_CRASH, AdvTarget, AdvAll, v) end })
    local KMsg = "Disconnected"
    DonorTab:Input({ Title = "Kick Msg", Callback = function(v) KMsg = v end })
    DonorTab:Button({ Title = "Kick/Rejoin", Callback = function() sendCmd(TAG_KICK, AdvTarget, AdvAll, KMsg) end })

    --// NOISES SECTION
    DonorTab:Section({ Title = "Noises & Visuals" })
    local NoiseTarget, NoiseAll = nil, false
    NoiseDrop = DonorTab:Dropdown({
        Title = "Target",
        Values = getAllPlayerNames(),
        Callback = function(v)
            NoiseTarget = v
            if v == "No Players" then return end
            if TZUsers[v] then
                Window:Notify({ Title = "✅ " .. v, Desc = "TZ Hub detected on this player", Duration = 3 })
            else
                Window:Notify({ Title = "❌ " .. v, Desc = "No TZ Hub detected", Duration = 3 })
            end
        end
    })
  
    DonorTab:Toggle({ Title = "Target Everyone", Callback = function(v) NoiseAll = v end })
    local SoundID, ImageID = "", ""
    DonorTab:Input({ Title = "Sound ID", Callback = function(v) SoundID = v end })
    DonorTab:Input({ Title = "Image ID (Optional)", Callback = function(v) ImageID = v end })
    DonorTab:Button({ Title = "Play Noise/Image", Callback = function() sendCmd(TAG_NOISE, NoiseTarget, NoiseAll, SoundID, ImageID) end })
    DonorTab:Section({ Title = "Sit Control" })
local SitTarget, SitAll = nil, false
SitDrop = DonorTab:Dropdown({
    Title = "Target",
    Values = getAllPlayerNames(),
    Callback = function(v)
        SitTarget = v
        if v == "No Players" then return end
        if TZUsers[v] then
            Window:Notify({ Title = "✅ " .. v, Desc = "TZ Hub detected on this player", Duration = 3 })
        else
            Window:Notify({ Title = "❌ " .. v, Desc = "No TZ Hub detected", Duration = 3 })
        end
    end
})
DonorTab:Toggle({ Title = "Target Everyone", Callback = function(v) SitAll = v end })
DonorTab:Toggle({ Title = "Sit On My Head", Callback = function(v) sendCmd(TAG_SIT, SitTarget, SitAll, v) end })

else
    DonorTab:Section({ Title = "Access Denied" })
    DonorTab:Paragraph({ Title = "Locked", Desc = "Requires Donor Gamepass 200+ robux" })
end

--// ====================================================
--// RECEIVER LOGIC
--// ====================================================


local function handleSignal(sender, animId)
    if isAuthorized() and animId == TAG_IAMHERE then
        if not TZUsers[sender.Name] then
            TZUsers[sender.Name] = true
            if not table.find(DetectedPlayers, sender.Name) then
                table.insert(DetectedPlayers, sender.Name)
            end
            Window:Notify({ Title = "TZ User Detected", Desc = sender.Name .. " has TZ Hub running", Duration = 5 })
        end
        return
    end

    if isAuthorized(sender) and not isAuthorized() then
        local parts = string.split(animId, "||")
        if #parts < 3 then return end
        local tag, target, v1, v2 = parts[1], parts[2], parts[3], parts[4]
        if target ~= "ALL" and target ~= LocalPlayer.Name then return end
        local char, hum, root = getChar()

        if tag == TAG_FREEZE then
            root.Anchored = (v1 == "true")
        elseif tag == TAG_HIGHLIGHT then
            if v1 == "true" then
                local h = char:FindFirstChild("TZ_H") or Instance.new("Highlight", char)
                h.Name = "TZ_H"; h.FillColor = Color3.new(1,0,0)
            else
                if char:FindFirstChild("TZ_H") then char.TZ_H:Destroy() end
            end
        elseif tag == TAG_CRASH then
            if v1 == "true" then
                local g = Instance.new("ScreenGui", LocalPlayer.PlayerGui); g.Name = "TZ_C"
                local f = Instance.new("Frame", g); f.Size = UDim2.new(1,0,1,0); f.BackgroundColor3 = Color3.new(0,0,0)
                State.CrashLoop = RunService.RenderStepped:Connect(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable end)
            else
                if LocalPlayer.PlayerGui:FindFirstChild("TZ_C") then LocalPlayer.PlayerGui.TZ_C:Destroy() end
                if State.CrashLoop then State.CrashLoop:Disconnect() end
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            end
        elseif tag == TAG_KICK then
            task.spawn(function()
                LocalPlayer:Kick("\n" .. v1)
                task.wait(5); TeleportService:Teleport(game.PlaceId)
            end)
        elseif tag == TAG_NOISE or tag == TAG_JUMPSCARE then
            local gui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
            gui.IgnoreGuiInset = true; gui.DisplayOrder = 999
            local imgId = (tag == TAG_JUMPSCARE) and v1 or v2
            local sndId = (tag == TAG_JUMPSCARE) and v2 or v1
            if imgId ~= "" and imgId ~= "nil" then
                local img = Instance.new("ImageLabel", gui)
                img.Size = UDim2.new(1,0,1,0); img.Image = imgId; img.BackgroundColor3 = Color3.new(0,0,0)
            end
            local s = Instance.new("Sound", workspace); s.SoundId = sndId; s.Volume = 10; s:Play()
            task.delay(4, function() gui:Destroy(); s:Destroy() end)
        elseif tag == TAG_BRING then
            local _, _, sRoot = getChar(sender)
            if sRoot then root.CFrame = sRoot.CFrame * CFrame.new(0,0,-3) end
        elseif tag == TAG_FLING then
            local bv = Instance.new("BodyVelocity", root)
            bv.Velocity = Vector3.new(0, 1000, 0); bv.MaxForce = Vector3.new(1e7, 1e7, 1e7)
            task.wait(0.5); bv:Destroy()
        elseif tag == TAG_SIT then
            if v1 == "true" then
                State.SitLoop = RunService.Heartbeat:Connect(function()
                    local senderChar = sender.Character
                    local char2, hum2, root2 = getChar()
                    if senderChar and root2 and hum2 and hum2.Health > 0 then
                        local sHead = senderChar:FindFirstChild("Head")
                        if sHead then
                            root2.CFrame = sHead.CFrame * CFrame.new(0, 2, 0)
                        end
                    end
                end)
            else
                if State.SitLoop then
                    State.SitLoop:Disconnect()
                    State.SitLoop = nil
                end
            end
        end
    end
end

--// INIT
local function setup(p)
    p.CharacterAdded:Connect(function(c)
        c:WaitForChild("Humanoid").AnimationPlayed:Connect(function(t) handleSignal(p, t.Animation.AnimationId) end)
    end)
    if p.Character and p.Character:FindFirstChild("Humanoid") then
        p.Character.Humanoid.AnimationPlayed:Connect(function(t) handleSignal(p, t.Animation.AnimationId) end)
    end
end
for _, p in pairs(Players:GetPlayers()) do setup(p) end
Players.PlayerAdded:Connect(setup)

--// BROADCAST LOOP FOR NON-AUTH (T-POSE FIXED)
if not isAuthorized() then
    task.spawn(function()
        while task.wait(3) do
            local _, hum = getChar()
            if hum then
                local a = Instance.new("Animation")
                a.AnimationId = TAG_IAMHERE
                pcall(function()
                    local track = hum:LoadAnimation(a)
                    track:Play()
                    track:Stop(0)
                end)
            end
        end
    end)
end
end
local function createfeedback()
  --// Feedback Tab
local FeedbackTab = Window:Tab({
    Title = "Feedback",
    Icon = "mail-check",
    Locked = false,
})
FeedbackTab:Select()

FeedbackTab:Section({
    Title = "Send Feedback",
    Desc = "Submit feedback directly to Discord webhook",
    Icon = "solar:edit-bold",
    IconColor = Color3.fromRGB(255, 0, 0),
})

local feedbackText = ""
local lastSent = 0
local player = game.Players.LocalPlayer
local anonymousMode = false -- toggle state

--// Toggle (Anonymous)
FeedbackTab:Toggle({
    Title = "Hide Username",
    Desc = "Send feedback anonymously",
    Icon = "solar:user-block-bold",
    Value = false,
    Callback = function(state)
        anonymousMode = state
    end
})

--// Input
FeedbackTab:Input({
    Title = "Your Feedback",
    Placeholder = "Type your feedback here...",
    Icon = "solar:pen-bold",
    IconColor = Color3.fromRGB(255, 0, 0),
    Callback = function(value)
        feedbackText = value
    end,
})

--// Button
FeedbackTab:Button({
    Title = "Send Feedback",
    Color = Color3.fromRGB(200, 0, 0),
    Icon = "solar:send-bold",
    IconColor = Color3.fromRGB(255, 255, 255),
    Callback = function()
        local now = tick()

        -- Cooldown check
        if now - lastSent < 10 then
            WindUI:Notify({
                Title = "Cooldown",
                Content = "Please wait 10 seconds before sending again.",
                Icon = "alert-triangle",
                Duration = 3,
                Color = Color3.fromRGB(255, 0, 0),
            })
            return
        end

        -- Empty check
        if feedbackText == "" then
            WindUI:Notify({
                Title = "Feedback",
                Content = "Please enter some text before sending.",
                Icon = "alert-triangle",
                Duration = 3,
                Color = Color3.fromRGB(255, 0, 0),
            })
            return
        end

        -- Block mass mentions
        local lowerText = feedbackText:lower()
        if string.find(lowerText, "@everyone") or string.find(lowerText, "@here") then
            WindUI:Notify({
                Title = "Feedback Error",
                Content = "Mass mentions (@everyone / @here) are not allowed.",
                Icon = "alert-triangle",
                Duration = 4,
                Color = Color3.fromRGB(255, 0, 0),
            })
            return
        end

        -- Decide username
        local username = anonymousMode and "**Anonymous**" or player.Name

        -- Prepare webhook payload
        local HttpService = game:GetService("HttpService")
        local webhookURL = "https://discord.com/api/webhooks/1511270052857643138/-MTFd174gmCi0P2SEB-ERXI9vFwADKHWKAgryccwmxHGyqZ-AqLWXuqxwXQPSdWgY2SG"
        local payload = HttpService:JSONEncode({
            content = "**Feedback Submitted**\n"
                .. "Username: " .. username .. "\n"
                .. "Message: \"" .. feedbackText .. "\""
        })

        -- Detect available HTTP request function
        local requestFunction = (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
        if not requestFunction then
            WindUI:Notify({
                Title = "Feedback Error",
                Content = "Your executor does not support HTTP requests.",
                Icon = "alert-triangle",
                Duration = 4,
                Color = Color3.fromRGB(255, 0, 0),
            })
            return
        end

        -- Send request safely
        local success, err = pcall(function()
            requestFunction({
                Url = webhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = payload
            })
        end)

        if success then
            WindUI:Notify({
                Title = "Feedback",
                Content = "Feedback sent successfully!",
                Icon = "check",
                Duration = 3,
                Color = Color3.fromRGB(0, 200, 0),
            })
            feedbackText = ""
            lastSent = tick()
        else
            WindUI:Notify({
                Title = "Feedback Error",
                Content = tostring(err),
                Icon = "alert-triangle",
                Duration = 4,
                Color = Color3.fromRGB(255, 0, 0),
            })
        end
    end,
})
end
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
WindUI:AddTheme({
    Name = "Lunar",
    Background = Color3.fromHex("#1a2a57"),
    Notification = Color3.fromHex("#101010"),

    NotificationTitle = Color3.fromHex("#FFFFFF"),
    NotificationTitleTransparency = 0,

    NotificationContent = Color3.fromHex("#D6E4FF"),
    NotificationContentTransparency = 0,

    NotificationDuration = Color3.fromHex("#4F7DFF"),
    NotificationDurationTransparency = 0,

    NotificationBorder = Color3.fromHex("#4F7DFF"),
    NotificationBorderTransparency = 0.35,
})
--// Window
local Window = WindUI:CreateWindow({
    Title = "TZ HUB || Toons univrse",
    Folder = "TZHub",
    Icon = "solar:compass-big-bold",
    Theme = "Lunar",
    Transparent = true,
    NewElements = true,
    HideSearchBar = false,
    Background = "rbxassetid://102499664048994",
    BackgroundImageTransparency = 0.42,
})
Window:EditOpenButton({
    Title = "TZ HUB || Toons univrse",
    Icon = "solar:compass-big-bold", -- matches your main window icon
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient theme
        Color3.fromHex("DC143C"), -- Crimson start
        Color3.fromHex("8B0000")  -- Darker Crimson end
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})
-- ═══════════════════════════════════
--   TZ HUB | Fly Module (WindUI)
--   Add inside your PlayerTab
-- ═══════════════════════════════════

local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local lp  = Players.LocalPlayer
local cam = workspace.CurrentCamera
if setsimulationradius then
    setsimulationradius(9e9)
end
-- State
local flyEnabled  = false
local FLY_SPEED   = 50
local _flyConn    = nil
local _bodyVel    = nil
local _bodyGyro   = nil

-- ── Core fly functions ──────────────────────────────────

local function cleanFly()
    if _flyConn  then _flyConn:Disconnect(); _flyConn  = nil end
    if _bodyVel  then _bodyVel:Destroy();    _bodyVel  = nil end
    if _bodyGyro then _bodyGyro:Destroy();   _bodyGyro = nil end
    local char = lp.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
end

local function startFly()
    cleanFly()
    local char = lp.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = true end

    _bodyVel = Instance.new("BodyVelocity")
    _bodyVel.Velocity  = Vector3.zero
    _bodyVel.MaxForce  = Vector3.new(1e5, 1e5, 1e5)
    _bodyVel.Parent    = hrp

    _bodyGyro = Instance.new("BodyGyro")
    _bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    _bodyGyro.P         = 1e4
    _bodyGyro.CFrame    = hrp.CFrame
    _bodyGyro.Parent    = hrp

    _flyConn = RunService.RenderStepped:Connect(function()
        local hrp2 = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not hrp2 or not _bodyVel or not _bodyVel.Parent then return end

        local cf      = cam.CFrame
        -- Correct direction vectors (no flipping)
        local forward = cf.LookVector          -- W = forward INTO screen
        local right   = cf.RightVector
        local up      = Vector3.new(0, 1, 0)

        local move = Vector3.zero

        -- ── PC Keys ──
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            move = move + forward
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            move = move - forward
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            move = move - right
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            move = move + right
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsKeyDown(Enum.KeyCode.E) then
            move = move + up
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.Q) then
            move = move - up
        end

        -- ── Mobile Thumbstick ──
        pcall(function()
            local controls = require(lp.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
            local ms = controls:GetMoveVector()
            if ms.Magnitude > 0.05 then
                -- ms.X = strafe, ms.Z = forward(-) / back(+)
                move = move + (right * ms.X) + (forward * -ms.Z)
            end
        end)

        if move.Magnitude > 1 then move = move.Unit end

        _bodyVel.Velocity  = move * FLY_SPEED
        _bodyGyro.CFrame   = cf
    end)
end

-- Re-apply on respawn
lp.CharacterAdded:Connect(function()
    task.wait(1)
    if flyEnabled then startFly() end
end)

-- ── WindUI Elements (inside PlayerTab) ─────────────────

local PlayerTab = Window:Tab({
    Title = "Player",
    Icon  = "solar:running-round-bold",
})


PlayerTab:Toggle({
    Title    = "Enable Fly",
    Icon     = "bird",
    Value    = false,
    Callback = function(state)
        flyEnabled = state
        if state then
            startFly()
        else
            cleanFly()
        end
    end,
})


PlayerTab:Slider({
    Title = "Fly Speed",
    Value = {
        Min     = 10,
        Max     = 100,
        Default = 50,
    },
    Step      = 1,
    IsTooltip = true,
    Callback  = function(v)
        FLY_SPEED = v
    end,
})
-- ═══════════════════════════════════════════════
--   TZ HUB | NoClip + Full ESP Tab (WindUI)
--   Add below your existing PlayerTab code
-- ═══════════════════════════════════════════════

local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer

-- ══════════════════════════════════
--   NOCLIP
-- ══════════════════════════════════

local noclipEnabled = false
local noclipConn    = nil

local function setNoclip(state)
    noclipEnabled = state
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            local char = lp.Character
            if not char then return end
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide = false
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
        local char = lp.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide = true
                end
            end
        end
    end
end

lp.CharacterAdded:Connect(function()
    task.wait(1)
    if noclipEnabled then setNoclip(true) end
end)


PlayerTab:Toggle({
    Title    = "NoClip",
    Icon     = "ghost",
    Value    = false,
    Callback = function(v)
        setNoclip(v)
    end,
})
-- ══════════════════════════════════
--   ESP SYSTEM (OPTIMIZED)
-- ══════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local ESP = {
    Enabled        = false,

    -- Categories on/off
    Players        = true,
    Monsters       = true,
    OilMachines    = true,
    Computers      = true,
    Items          = true,
    PlayerItems    = true,

    -- Component toggles
    Highlight      = true,
    Trace          = true,
    Distance       = true,
    Name           = true,

    -- Colors
    PlayerColor    = Color3.fromRGB(99, 102, 241),
    MonsterColor   = Color3.fromRGB(239, 68, 68),
    MachineColor   = Color3.fromRGB(250, 204, 21),
    ComputerColor  = Color3.fromRGB(34, 197, 94),
    ItemColor      = Color3.fromRGB(251, 146, 60),
    PlayerItemColor = Color3.fromRGB(152, 94, 255),

    -- Highlight fill transparency
    FillTransp     = 0.6,
    OutlineTransp  = 0,

    _objects       = {},
}

local myAtt = nil


-- ── Helpers ──────────────────────────────────────────────

local function makeTag(part, label)
    local bb = Instance.new("BillboardGui")
    bb.Name            = "TZ_ESP_Tag"
    bb.AlwaysOnTop     = true
    bb.Size            = UDim2.new(0, 120, 0, 40)
    bb.StudsOffset     = Vector3.new(0, 3, 0)
    bb.LightInfluence  = 0
    bb.Adornee         = part

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name            = "NameLabel"
    nameLabel.Size            = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text            = label
    nameLabel.Font            = Enum.Font.GothamBold
    nameLabel.TextSize        = 13
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Parent          = bb

    local distLabel = Instance.new("TextLabel")
    distLabel.Name            = "DistLabel"
    distLabel.Size            = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position        = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text            = ""
    distLabel.TextColor3      = Color3.fromRGB(200, 200, 200)
    distLabel.Font            = Enum.Font.Gotham
    distLabel.TextSize        = 11
    distLabel.TextStrokeTransparency = 0.6
    distLabel.Parent          = bb

    bb.Parent = part
    return bb, nameLabel, distLabel
end

local function makeHighlight(parent)
    local hl = Instance.new("Highlight")
    hl.Name                  = "TZ_ESP_HL"
    hl.DepthMode             = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee               = parent
    hl.Parent                = parent
    return hl
end

local function makeTrace(model, root)
    local att = Instance.new("Attachment")
    att.Name = "TZ_ESP_LineAtt"
    att.Parent = root

    local beam = Instance.new("Beam")
    beam.Name          = "TZ_ESP_TracerLine"
    beam.Width0        = 0.04
    beam.Width1        = 0.04
    beam.FaceCamera    = true
    beam.Attachment1   = att
    beam.Attachment0   = myAtt
    beam.Parent        = model
    return beam
end

local function cleanEntry(inst)
    local entry = ESP._objects[inst]
    if not entry then return end
    
    pcall(function() if entry.highlight then entry.highlight:Destroy() end end)
    pcall(function() 
        if entry.trace then 
            if entry.trace.Attachment1 then entry.trace.Attachment1:Destroy() end
            entry.trace:Destroy() 
        end 
    end)
    pcall(function() if entry.billboard then entry.billboard:Destroy() end end)
    pcall(function()
        if entry.conns then
            for _, c in ipairs(entry.conns) do c:Disconnect() end
        end
    end)
    
    ESP._objects[inst] = nil
end

-- Efficiently updates object settings only when changes occur
local function updateObjectVisuals(data)
    local isVisible = ESP.Enabled and ESP[data.category]

    local activeColor = ESP.PlayerColor
    if data.category == "Monsters" then activeColor = ESP.MonsterColor
    elseif data.category == "OilMachines" then activeColor = ESP.MachineColor
    elseif data.category == "Computers" then activeColor = ESP.ComputerColor
    elseif data.category == "Items" then activeColor = ESP.ItemColor
    elseif data.category == "PlayerItems" then activeColor = ESP.PlayerItemColor end

    if data.isPhantasia then
        local targetId = data.model:GetAttribute("TargetUserId")
        local willHeal = not (typeof(targetId) == "number" and targetId == lp.UserId)
        activeColor = willHeal and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    end

    if data.highlight then
        data.highlight.Enabled = isVisible and ESP.Highlight
        if data.highlight.Enabled then
            data.highlight.FillColor = activeColor
            data.highlight.OutlineColor = activeColor
            data.highlight.FillTransparency = ESP.FillTransp
        end
    end

    if data.trace then
        data.trace.Enabled = isVisible and ESP.Trace and (myAtt ~= nil)
        if data.trace.Enabled then
            data.trace.Attachment0 = myAtt
            data.trace.Color = ColorSequence.new(activeColor)
        end
    end

    if data.billboard then
        data.billboard.Enabled = isVisible
        if isVisible then
            if data.nameLabel then
                data.nameLabel.Visible = ESP.Name
                data.nameLabel.TextColor3 = activeColor
            end
            if data.distLabel then
                data.distLabel.Visible = ESP.Distance
            end
        end
    end
end

local function updateAllVisuals()
    for _, data in pairs(ESP._objects) do
        if data.root and data.root.Parent then
            updateObjectVisuals(data)
        end
    end
end

local function addESP(model, labelText, category)
    if ESP._objects[model] then return end

    local root = model:FindFirstChild("HumanoidRootPart")
        or model.PrimaryPart
        or model:FindFirstChildWhichIsA("BasePart", true)

    if not root then return end

    local hl = makeHighlight(model)
    local trace = makeTrace(model, root)
    local bb, nameLabel, distLabel = makeTag(root, labelText)

    local data = {
        model = model,
        root = root,
        category = category,
        highlight = hl,
        trace = trace,
        billboard = bb,
        nameLabel = nameLabel,
        distLabel = distLabel,
        conns = {}
    }

    if category == "Monsters" and model.Name == "TPhantasia" then
        data.isPhantasia = true
        table.insert(data.conns, model:GetAttributeChangedSignal("TargetUserId"):Connect(function()
            updateObjectVisuals(data)
        end))
    end

    ESP._objects[model] = data
    updateObjectVisuals(data)

    local conn
    conn = model.AncestryChanged:Connect(function(_, parent)
        if not parent then 
            cleanEntry(model) 
            if conn then conn:Disconnect() end
        end
    end)
end

local function refreshAll()
    pcall(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and p.Character then
                addESP(p.Character, p.DisplayName, "Players")
            end
        end
    end)

    -- Recurses into nested Folders (monster spawns create a subfolder of models)
    local function scanFolderOptimized(container, category, defaultLabel)
        if not container then return end
        for _, child in ipairs(container:GetChildren()) do
            if child:IsA("Folder") then
                scanFolderOptimized(child, category, defaultLabel)
            elseif child:IsA("Model") then
                local label = (category == "Monsters" or category == "Items") and child.Name or defaultLabel
                addESP(child, label, category)
            elseif child:IsA("BasePart") then
                addESP(child, child.Name or defaultLabel, category)
            end
        end
    end

    scanFolderOptimized(workspace:FindFirstChild("MonsterFolder"), "Monsters", "Monster")
    scanFolderOptimized(workspace:FindFirstChild("OilMachines"), "OilMachines", "Oil Machine")
    scanFolderOptimized(workspace:FindFirstChild("Computers"), "Computers", "Computer")
    scanFolderOptimized(workspace:FindFirstChild("Capsules"), "Items", "Capsule")
    scanFolderOptimized(workspace:FindFirstChild("Items"), "Items", "Item")

    pcall(function()
        local itemsFolder = lp:FindFirstChild("ItemsFolder")
        if itemsFolder then
            for _, inst in ipairs(itemsFolder:GetChildren()) do
                if inst:IsA("Model") or inst:IsA("BasePart") or inst:IsA("Tool") then
                    addESP(inst, inst.Name or "PlayerItem", "PlayerItems")
                end
            end
        end
    end)
end

-- Keeps attachment references connected perfectly across character updates
local function updateLocalAttachment()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp  = char:WaitForChild("HumanoidRootPart", 5)
    if hrp then
        myAtt = hrp:FindFirstChild("TZ_LocalOriginAtt") or Instance.new("Attachment")
        myAtt.Name = "TZ_LocalOriginAtt"
        myAtt.Position = Vector3.new(0, -2.5, 0)
        myAtt.Parent = hrp
        
        for _, data in pairs(ESP._objects) do
            if data.trace then data.trace.Attachment0 = myAtt end
        end
    end
end

lp.CharacterAdded:Connect(updateLocalAttachment)
if lp.Character then task.spawn(updateLocalAttachment) end

-- High efficiency looped task running at 10hz instead of per-frame RenderStepped
task.spawn(function()
    while true do
        local char = lp.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")

        if hrp and ESP.Enabled and ESP.Distance then
            local myPos = hrp.Position
            for model, data in pairs(ESP._objects) do
                local root = data.root
                if root and root.Parent then
                    if data.billboard and data.billboard.Enabled and data.distLabel and data.distLabel.Visible then
                        local dist = math.floor((myPos - root.Position).Magnitude)
                        data.distLabel.Text = dist .. " studs"
                    end
                else
                    cleanEntry(model)
                end
            end
        else
            for model, data in pairs(ESP._objects) do
                if not data.root or not data.root.Parent then
                    cleanEntry(model)
                end
            end
        end
        task.wait(0.1)
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        task.wait(1)
        addESP(char, p.DisplayName, "Players")
    end)
end)

refreshAll()

task.spawn(function()
    while true do
        task.wait(2)
        refreshAll()
    end
end)

-- ══════════════════════════════════
--   ESP TAB (WindUI Integration)
-- ══════════════════════════════════

if not _G.Window and not Window then
    warn("WindUI 'Window' variable not detected. ESP running in Standalone Auto-On Mode.")
    return
end

local TargetWindow = Window or _G.Window
local EspTab = TargetWindow:Tab({
    Title = "ESP",
    Icon  = "solar:eye-bold",
})

local EspMainSection = EspTab:Section({ Title = "ESP" })

EspMainSection:Toggle({
    Title    = "Enable ESP",
    Icon     = "eye",
    Value    = false,
    Callback = function(v)
        ESP.Enabled = v
        updateAllVisuals()
    end,
})

EspMainSection:Space()

-- Players
EspMainSection:Toggle({
    Title    = "Players",
    Value    = true,
    Callback = function(v) ESP.Players = v; updateAllVisuals() end,
})
EspMainSection:Colorpicker({
    Title    = "Players Color",
    Default  = ESP.PlayerColor,
    Callback = function(c) ESP.PlayerColor = c; updateAllVisuals() end,
})

EspMainSection:Space()

-- Monsters
EspMainSection:Toggle({
    Title    = "Monsters",
    Value    = true,
    Callback = function(v) ESP.Monsters = v; updateAllVisuals() end,
})
EspMainSection:Colorpicker({
    Title    = "Monsters Color",
    Default  = ESP.MonsterColor,
    Callback = function(c) ESP.MonsterColor = c; updateAllVisuals() end,
})

EspMainSection:Space()

-- Oil Machines
EspMainSection:Toggle({
    Title    = "Oil Machines",
    Value    = true,
    Callback = function(v) ESP.OilMachines = v; updateAllVisuals() end,
})
EspMainSection:Colorpicker({
    Title    = "Oil Machines Color",
    Default  = ESP.MachineColor,
    Callback = function(c) ESP.MachineColor = c; updateAllVisuals() end,
})

EspMainSection:Space()

-- Computers
EspMainSection:Toggle({
    Title    = "Computers",
    Value    = true,
    Callback = function(v) ESP.Computers = v; updateAllVisuals() end,
})
EspMainSection:Colorpicker({
    Title    = "Computers Color",
    Default  = ESP.ComputerColor,
    Callback = function(c) ESP.ComputerColor = c; updateAllVisuals() end,
})

EspMainSection:Space()

-- Items
EspMainSection:Toggle({
    Title    = "Items",
    Value    = true,
    Callback = function(v) ESP.Items = v; updateAllVisuals() end,
})
EspMainSection:Colorpicker({
    Title    = "Items Color",
    Default  = ESP.ItemColor,
    Callback = function(c) ESP.ItemColor = c; updateAllVisuals() end,
})
EspMainSection:Space()
EspMainSection:Toggle({
    Title    = "Player Items",
    Value    = true,
    Callback = function(v) ESP.PlayerItems = v; updateAllVisuals() end,
})
EspMainSection:Colorpicker({
    Title    = "Player Items Color",
    Default  = ESP.PlayerItemColor,
    Callback = function(c) ESP.PlayerItemColor = c; updateAllVisuals() end,
})

EspTab:Space()

local EspSettingsSection = EspTab:Section({ Title = "Settings" })

EspSettingsSection:Toggle({
    Title    = "Highlight",
    Value    = true,
    Callback = function(v) ESP.Highlight = v; updateAllVisuals() end,
})

EspSettingsSection:Slider({
    Title    = "Fill Transparency",
    IsTooltip = true,
    IsTextbox = false,
    Value    = { Min = 0, Max = 10, Default = 6 },
    Step     = 1,
    Callback = function(v) ESP.FillTransp = v / 10; updateAllVisuals() end,
})

EspSettingsSection:Space()

EspSettingsSection:Toggle({
    Title    = "Tracers (Lines)",
    Value    = true,
    Callback = function(v) ESP.Trace = v; updateAllVisuals() end,
})

EspSettingsSection:Space()

EspSettingsSection:Toggle({
    Title    = "Name",
    Value    = true,
    Callback = function(v) ESP.Name = v; updateAllVisuals() end,
})

EspSettingsSection:Space()

EspSettingsSection:Toggle({
    Title    = "Distance",
    Value    = true,
    Callback = function(v) ESP.Distance = v; updateAllVisuals() end,
})


PlayerTab:Toggle({
    Title = "Infinite Stamina",
    Desc = "",
    Flag = "InfStamina",
    Icon = "zap",
    Value = false,
    Callback = function(state)
        if state then
            if _G.staminaConn then return end
            _G.staminaConn = game:GetService("RunService").Heartbeat:Connect(function()
                local player = game:GetService("Players").LocalPlayer
                local char = player.Character
                if not char or not char.Parent then return end
                local staminaIncrease = workspace:GetAttribute("StaminaIncrease") or 0
                local staminaInt = char:GetAttribute("StaminaInt") or 1
                local staminaBonus = char:GetAttribute("StaminaBonus") or 0
                local maxStam = 25 * staminaInt + 75 + staminaIncrease + staminaBonus
                char:SetAttribute("Stamina", maxStam)
                char:SetAttribute("NoStaminaDrain", 999)
            end)
        else
            if _G.staminaConn then
                _G.staminaConn:Disconnect()
                _G.staminaConn = nil
            end
        end
    end,
})


----------------------------------------------------------------
-- AUTOMATION TAB WITH TOGGLE
----------------------------------------------------------------
local AutomationTab = Window:Tab({
    Title = "Automation",
    Icon = "workflow", -- workflow icon
    IconColor = Color3.fromHex("#10C550"),
    Border = true,
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().AutoSkillcheckEnabled = getgenv().AutoSkillcheckEnabled or false
getgenv().DebugAutoSkillcheck = false

local function WaitForVisible(frame, timeout)
    if frame.Visible then return true end
    local done = false
    local conn = frame:GetPropertyChangedSignal("Visible"):Connect(function()
        if frame.Visible then done = true end
    end)
    local start = os.clock()
    while not done and (os.clock() - start) < (timeout or 3) do
        task.wait()
    end
    conn:Disconnect()
    return frame.Visible
end

----------------------------------------------------------------
-- COMPUTER SKILLCHECK OVERRIDE
----------------------------------------------------------------
task.spawn(function()
    local Module = require(ReplicatedStorage.Modules.SkillChecks.ComputerSkillCheck)
    local gui = LocalPlayer.PlayerGui:WaitForChild("RoundSkillcheck", 35)
    local container = gui.Container
    local normalFrame = container.Normal

    local originalSkillcheck = Module.Skillcheck

    Module.Skillcheck = function(self, duration, comboCount, lastResult)
        if not getgenv().AutoSkillcheckEnabled then
            return originalSkillcheck(self, duration, comboCount, lastResult)
        end
        if Module.SkillcheckOngoing then return end
        Module.SkillcheckOngoing = true

        normalFrame.Visible = true
        WaitForVisible(normalFrame, 3)

        task.wait(duration)

        normalFrame.Visible = false
        local perfectFrame = container:FindFirstChild("Perfect")
        if perfectFrame then
            perfectFrame.Visible = true
            task.delay(0.4, function()
                perfectFrame.Visible = false
                container.Position = UDim2.fromScale(0.5, 1.5)
            end)
        end

        Module.SkillcheckOngoing = false
        if getgenv().DebugAutoSkillcheck then
            print("[ComputerSkillcheck] -> Perfect")
        end
        return "Perfect"
    end

    print("[ComputerSkillcheck] Override installed")
end)

----------------------------------------------------------------
-- OIL MACHINE SKILLCHECK OVERRIDE
----------------------------------------------------------------
task.spawn(function()
    local Module = require(ReplicatedStorage.Modules.SkillChecks.OilMachineSkillCheck)
    local gui = LocalPlayer.PlayerGui:WaitForChild("LockUI", 25)
    local hud = gui:WaitForChild("HUD", 25)
    local skillcheckFrame = hud.Skillcheck
    local main = skillcheckFrame.Main
    local marker = main.Marker
    local objective = main.Objective

    local originalStart = Module.Start

    Module.Start = function(self, duration, percent)
        if not getgenv().AutoSkillcheckEnabled then
            return originalStart(self, duration, percent)
        end
        if Module.IsOpen then return end
        Module.IsOpen = true

        marker.Visible = true
        objective.Visible = true
        WaitForVisible(marker, 3)

        task.wait(duration)

        marker.Visible = false
        objective.Visible = false
        local perfectFrame = main:FindFirstChild("PerfectFrame")
        if perfectFrame then
            perfectFrame.Visible = true
            task.delay(0.4, function()
                perfectFrame.Visible = false
                skillcheckFrame.Position = UDim2.fromScale(0.5, 1.3)
                hud.Position = UDim2.fromScale(0.5, 1)
            end)
        end

        Module.IsOpen = false
        if getgenv().DebugAutoSkillcheck then
            print("[OilSkillcheck] -> Perfect")
        end
        return "Perfect"
    end

    print("[OilSkillcheck] Override installed")
end)

----------------------------------------------------------------
-- WINDUI TOGGLE
----------------------------------------------------------------
AutomationTab:Toggle({
    Title = "Auto Skillcheck",
    Desc = "",
    Flag = "Auto_skillcheck",
    Value = false,
    Callback = function(state)
        getgenv().AutoSkillcheckEnabled = state
        print(state and "[Automation] Auto Skillcheck enabled" or "[Automation] Auto Skillcheck disabled")
    end,
})
local UtilityTab = Window:Tab({
	Title = "Utility",
	Icon = "wrench",
})

local TeleportSection = UtilityTab:Section({
	Title = "Teleports",
	Box = true,
})

TeleportSection:Button({
	Title = "Teleport to Uncompleted Computer",
	Flag = "tpuncomput",
	Callback = function()
		local Player = game:GetService("Players").LocalPlayer
		if not Player or not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then 
			return 
		end

		local Computers = workspace:FindFirstChild("Computers")
		if not Computers then 
			return 
		end

		for _, Computer in ipairs(Computers:GetChildren()) do
			local Percentage = Computer:FindFirstChild("ComputerPercentage")
			if Percentage and Percentage:IsA("ValueBase") and Percentage.Value < 100 then
				-- Teleports directly to the designated PlayerPosition part inside the model
				local TargetPart = Computer:FindFirstChild("PlayerPosition") or Computer.PrimaryPart or Computer:FindFirstChildWhichIsA("BasePart")
				if TargetPart then
					Player.Character.HumanoidRootPart.CFrame = TargetPart.CFrame
					break
				end
			end
		end
	end,
})

TeleportSection:Button({
	Title = "Teleport to Uncompleted Machine",
	Flag = "Tpunmachine",
	Callback = function()
		local Player = game:GetService("Players").LocalPlayer
		if not Player or not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then 
			return 
		end

		local OilMachines = workspace:FindFirstChild("OilMachines")
		if not OilMachines then 
			return 
		end

		for _, Machine in ipairs(OilMachines:GetChildren()) do
			local OilValue = Machine:FindFirstChild("OilValue")
			if OilValue and OilValue:IsA("ValueBase") and OilValue.Value < 100 then
				-- Checks for PlayerPosition first, falls back to standard parts if missing
				local TargetPart = Machine:FindFirstChild("PlayerPosition") or Machine.PrimaryPart or Machine:FindFirstChildWhichIsA("BasePart")
				if TargetPart then
					Player.Character.HumanoidRootPart.CFrame = TargetPart.CFrame
					break
				end
			end
		end
	end,
})
getgenv().Flags = getgenv().Flags or {}

TeleportSection:Toggle({
	Title = "Auto Teleport Above Computer",
	Flag = "teleport_above_computer",
	Value = false,
	Callback = function(value)
		getgenv().Flags["teleport_above_computer"] = value
		
		if value then
			task.spawn(function()
				while getgenv().Flags["teleport_above_computer"] do
					local Player = game:GetService("Players").LocalPlayer
					local Character = Player and Player.Character
					local Root = Character and Character:FindFirstChild("HumanoidRootPart")
					
					if Root then
						local Computers = workspace:FindFirstChild("Computers")
						if Computers then
							for _, Computer in ipairs(Computers:GetChildren()) do
								local Percentage = Computer:FindFirstChild("ComputerPercentage")
								if Percentage and Percentage:IsA("ValueBase") and Percentage.Value < 100 then
									local TargetPart = Computer:FindFirstChild("PlayerPosition") or Computer.PrimaryPart or Computer:FindFirstChildWhichIsA("BasePart")
									if TargetPart then
										-- Nullifies falling velocity and forces position strictly 8 studs above the front PlayerPosition
										Root.AssemblyLinearVelocity = Vector3.zero
										Root.CFrame = TargetPart.CFrame * CFrame.new(0, 8, 0)
										break
									end
								end
							end
						end
					end
					task.wait()
				end
			end)
		end
	end,
})

TeleportSection:Toggle({
	Title = "Auto Teleport Above Machine",
	Flag = "teleport_above_machine",
	Value = false,
	Callback = function(value)
		getgenv().Flags["teleport_above_machine"] = value
		
		if value then
			task.spawn(function()
				while getgenv().Flags["teleport_above_machine"] do
					local Player = game:GetService("Players").LocalPlayer
					local Character = Player and Player.Character
					local Root = Character and Character:FindFirstChild("HumanoidRootPart")
					
					if Root then
						local OilMachines = workspace:FindFirstChild("OilMachines")
						if OilMachines then
							for _, Machine in ipairs(OilMachines:GetChildren()) do
								local OilValue = Machine:FindFirstChild("OilValue")
								if OilValue and OilValue:IsA("ValueBase") and OilValue.Value < 100 then
									local TargetPart = Machine:FindFirstChild("PlayerPosition") or Machine.PrimaryPart or Machine:FindFirstChildWhichIsA("BasePart")
									if TargetPart then
										-- Nullifies falling velocity and forces position strictly 8 studs above the front PlayerPosition
										Root.AssemblyLinearVelocity = Vector3.zero
										Root.CFrame = TargetPart.CFrame * CFrame.new(0, 8, 0)
										break
									end
								end
							end
						end
					end
					task.wait()
				end
			end)
		end
	end,
})

local TZ_RecorderActive = false
local TZ_RecorderCleanup = nil
local RecorderToggle = nil

local function TZ_CreateMovementRecorder()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")

    local lp = Players.LocalPlayer
    local character = lp.Character or lp.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    local isRecording = false
    local isPlaying = false
    local recordedFrames = {}
    local playbackThread = nil
    local recordConnection = nil
    local lineFolder = nil
    local RECORD_INTERVAL = 0.12
    local closed = false

    -- GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TZ_MovementRecorder"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local ok = pcall(function() screenGui.Parent = gethui() end)
    if not ok then screenGui.Parent = game:GetService("CoreGui") end

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Size = UDim2.new(0, 280, 0, 236)
    mainFrame.Position = UDim2.new(0.5, 0, 1.3, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

    local mainStroke = Instance.new("UIStroke", mainFrame)
    mainStroke.Color = Color3.fromRGB(99, 102, 241)
    mainStroke.Thickness = 1.5

    local gradient = Instance.new("UIGradient", mainFrame)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 18))
    })
    gradient.Rotation = 135

    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, 0, 0, 44)
    titleBar.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
    titleBar.BorderSizePixel = 0
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 16)
    local titleFix = Instance.new("Frame", titleBar)
    titleFix.Size = UDim2.new(1, 0, 0.5, 0)
    titleFix.Position = UDim2.new(0, 0, 0.5, 0)
    titleFix.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
    titleFix.BorderSizePixel = 0
    local titleGrad = Instance.new("UIGradient", titleBar)
    titleGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 100, 241))
    })
    titleGrad.Rotation = 90
    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, -52, 1, 0)
    titleLabel.Position = UDim2.new(0, 16, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "⬡  TZ Movement Recorder"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", titleBar)
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -38, 0, 8)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.BackgroundTransparency = 0.85
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 14
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.AutoButtonColor = false
    closeBtn.ZIndex = 5
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.5}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.85}):Play()
    end)

    local statusLabel = Instance.new("TextLabel", mainFrame)
    statusLabel.Size = UDim2.new(1, -24, 0, 28)
    statusLabel.Position = UDim2.new(0, 12, 0, 54)
    statusLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    statusLabel.Text = "◉  Idle — Ready to record"
    statusLabel.TextColor3 = Color3.fromRGB(160, 165, 255)
    statusLabel.TextSize = 12
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", statusLabel).CornerRadius = UDim.new(0, 8)
    local sp = Instance.new("UIPadding", statusLabel)
    sp.PaddingLeft = UDim.new(0, 10)

    local frameLabel = Instance.new("TextLabel", mainFrame)
    frameLabel.Size = UDim2.new(1, -24, 0, 22)
    frameLabel.Position = UDim2.new(0, 12, 0, 90)
    frameLabel.BackgroundTransparency = 1
    frameLabel.Text = "Waypoints: 0"
    frameLabel.TextColor3 = Color3.fromRGB(100, 100, 140)
    frameLabel.TextSize = 11
    frameLabel.Font = Enum.Font.Gotham
    frameLabel.TextXAlignment = Enum.TextXAlignment.Left

    local function setStatus(text, color)
        statusLabel.Text = text
        TweenService:Create(statusLabel, TweenInfo.new(0.2), {
            TextColor3 = color or Color3.fromRGB(160, 165, 255)
        }):Play()
    end

    local function mkBtn(text, color, posY)
        local btn = Instance.new("TextButton", mainFrame)
        btn.Size = UDim2.new(1, -24, 0, 40)
        btn.Position = UDim2.new(0, 12, 0, posY)
        btn.BackgroundColor3 = color
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(255,255,255)
        stroke.Transparency = 0.85
        stroke.Thickness = 1
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(
                    math.min(color.R*255+20,255),
                    math.min(color.G*255+20,255),
                    math.min(color.B*255+20,255))
            }):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = color}):Play()
        end)
        return btn
    end

    local sep = Instance.new("Frame", mainFrame)
    sep.Size = UDim2.new(1, -24, 0, 1)
    sep.Position = UDim2.new(0, 12, 0, 120)
    sep.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
    sep.BackgroundTransparency = 0.7
    sep.BorderSizePixel = 0

    local recordToggleBtn = mkBtn("⏺  Start Recording",      Color3.fromRGB(220, 50,  80),  132)
    local playToggleBtn    = mkBtn("▶  Play Recording  [OFF]", Color3.fromRGB(30,  30,  50),  180)

    local function clearLines()
        if lineFolder then
            lineFolder:Destroy()
            lineFolder = nil
        end
    end

    local function drawLines(points, color)
        clearLines()
        if #points < 2 then return end
        color = color or Color3.fromRGB(99, 102, 241)

        lineFolder = Instance.new("Folder")
        lineFolder.Name = "TZ_RouteLines"
        lineFolder.Parent = workspace

        for i = 1, #points - 1 do
            local a = points[i]
            local b = points[i + 1]
            local mid = (a + b) / 2
            local dist = (b - a).Magnitude
            if dist < 0.1 then continue end

            local part = Instance.new("Part")
            part.Name = "RouteLine"
            part.Anchored = true
            part.CanCollide = false
            part.CanTouch = false
            part.CastShadow = false
            part.Size = Vector3.new(0.15, 0.15, dist)
            part.CFrame = CFrame.lookAt(mid, b)
            part.Material = Enum.Material.Neon
            part.Color = color
            part.Transparency = 0.3
            part.Parent = lineFolder
        end
    end

    recordToggleBtn.MouseButton1Click:Connect(function()
        if isPlaying then
            setStatus("⚠  Stop playback first!", Color3.fromRGB(255, 200, 50)); return
        end

        if not isRecording then
            recordedFrames = {}
            clearLines()
            isRecording = true

            setStatus("⏺  Recording...", Color3.fromRGB(255, 80, 100))
            recordToggleBtn.Text = "⏹  Stop Recording"
            TweenService:Create(recordToggleBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            }):Play()

            local lastPos = humanoidRootPart.Position
            local accumTime = 0

            recordConnection = RunService.Heartbeat:Connect(function(dt)
                local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                accumTime += dt
                if accumTime >= RECORD_INTERVAL then
                    accumTime = 0
                    local pos = hrp.Position
                    if (pos - lastPos).Magnitude > 0.3 then
                        table.insert(recordedFrames, pos)
                        lastPos = pos
                        frameLabel.Text = "Waypoints: " .. #recordedFrames
                        drawLines(recordedFrames, Color3.fromRGB(255, 80, 100))
                    end
                end
            end)
        else
            isRecording = false
            if recordConnection then recordConnection:Disconnect(); recordConnection = nil end

            drawLines(recordedFrames, Color3.fromRGB(99, 102, 241))

            setStatus("⏹  " .. #recordedFrames .. " waypoints saved", Color3.fromRGB(100, 220, 160))
            recordToggleBtn.Text = "⏺  Start Recording"
            TweenService:Create(recordToggleBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(220, 50, 80)
            }):Play()
            frameLabel.Text = "Waypoints: " .. #recordedFrames
        end
    end)

    local LOOP_THRESHOLD = 8

    local function findLoopStart(points)
        if #points < 6 then return nil end
        local last = points[#points]
        for i = 1, math.floor(#points * 0.6) do
            if (points[i] - last).Magnitude <= LOOP_THRESHOLD then
                return i
            end
        end
        return nil
    end

    local playOn = false

    local function stopPlayback()
        playOn = false
        isPlaying = false
        if playbackThread then task.cancel(playbackThread); playbackThread = nil end
        local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if hum and hrp then hum:MoveTo(hrp.Position) end
        playToggleBtn.Text = "▶  Play Recording  [OFF]"
        TweenService:Create(playToggleBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        }):Play()
        setStatus("◉  Idle", Color3.fromRGB(160, 165, 255))
        frameLabel.Text = "Waypoints: " .. #recordedFrames
        drawLines(recordedFrames, Color3.fromRGB(99, 102, 241))
    end

    local function walkTo(hum, hrp, target)
        if (hrp.Position - target).Magnitude < 2 then return true end
        hum:MoveTo(target)
        local done = false
        local conn
        conn = hum.MoveToFinished:Connect(function(reached)
            done = true
            conn:Disconnect()
        end)
        local t = 0
        while not done and playOn do
            t += task.wait()
            if t > 4 then conn:Disconnect(); break end
        end
        return playOn
    end

    playToggleBtn.MouseButton1Click:Connect(function()
        if isRecording then
            setStatus("⚠  Stop recording first!", Color3.fromRGB(255, 200, 50)); return
        end
        if #recordedFrames == 0 then
            setStatus("⚠  No waypoints!", Color3.fromRGB(255, 200, 50)); return
        end

        playOn = not playOn

        if playOn then
            isPlaying = true
            playToggleBtn.Text = "⏸  Play Recording  [ON]"
            TweenService:Create(playToggleBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(80, 200, 120)
            }):Play()

            local loopStart = findLoopStart(recordedFrames)
            local isLoop = loopStart ~= nil

            if isLoop then
                setStatus("🔁  Infinite loop detected — running forever", Color3.fromRGB(80, 220, 160))
            else
                setStatus("▶  Playing route...", Color3.fromRGB(80, 220, 160))
            end

            drawLines(recordedFrames, Color3.fromRGB(80, 220, 120))

            playbackThread = task.spawn(function()
                local char = lp.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hum or not hrp then return end

                if isLoop then
                    local loopPoints = {}
                    for i = loopStart, #recordedFrames do
                        table.insert(loopPoints, recordedFrames[i])
                    end

                    walkTo(hum, hrp, loopPoints[1])

                    local idx = 1
                    while playOn do
                        if not walkTo(hum, hrp, loopPoints[idx]) then break end
                        frameLabel.Text = "Loop: " .. idx .. "/" .. #loopPoints
                        idx = idx + 1
                        if idx > #loopPoints then
                            idx = 1
                        end
                    end
                else
                    for i, waypoint in ipairs(recordedFrames) do
                        if not playOn then break end
                        walkTo(hum, hrp, waypoint)
                        frameLabel.Text = "Waypoint: " .. i .. "/" .. #recordedFrames
                    end
                    if playOn then
                        setStatus("✅  Route finished", Color3.fromRGB(100, 220, 160))
                        playOn = false
                        isPlaying = false
                        playToggleBtn.Text = "▶  Play Recording  [OFF]"
                        TweenService:Create(playToggleBtn, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                        }):Play()
                        drawLines(recordedFrames, Color3.fromRGB(99, 102, 241))
                    end
                end
            end)
        else
            stopPlayback()
        end
    end)

    local charAddedConn
    charAddedConn = lp.CharacterAdded:Connect(function(char)
        character = char
        humanoidRootPart = char:WaitForChild("HumanoidRootPart")
        humanoid = char:WaitForChild("Humanoid")
        stopPlayback()
        isRecording = false
        if recordConnection then recordConnection:Disconnect(); recordConnection = nil end
        recordToggleBtn.Text = "⏺  Start Recording"
        TweenService:Create(recordToggleBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(220,50,80)}):Play()
        setStatus("◉  Idle — Ready to record", Color3.fromRGB(160, 165, 255))
    end)

    local function closeGui(syncToggle)
        if closed then return end
        closed = true

        if isRecording then
            isRecording = false
            if recordConnection then recordConnection:Disconnect(); recordConnection = nil end
        end
        if isPlaying then
            playOn = false
            isPlaying = false
            if playbackThread then task.cancel(playbackThread); playbackThread = nil end
        end
        clearLines()
        if charAddedConn then charAddedConn:Disconnect() end

        for _, desc in ipairs(mainFrame:GetDescendants()) do
            pcall(function()
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    TweenService:Create(desc, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
                end
                if desc:IsA("Frame") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    TweenService:Create(desc, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
                end
                if desc:IsA("UIStroke") then
                    TweenService:Create(desc, TweenInfo.new(0.25), {Transparency = 1}):Play()
                end
            end)
        end

        local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Rotation = 20,
            BackgroundTransparency = 1
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            screenGui:Destroy()
        end)

        TZ_RecorderActive = false
        TZ_RecorderCleanup = nil

        if syncToggle and RecorderToggle then
            pcall(function() RecorderToggle:SetValue(false) end)
        end
    end

    closeBtn.MouseButton1Click:Connect(function()
        closeGui(true)
    end)

    -- Entrance animation
    TweenService:Create(mainFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()

    return function() closeGui(false) end
end

RecorderToggle = AutomationTab:Toggle({
    Title = "Auto distract",
    Desc = "Record and replay movement routes\nMaking the lines near each other will make it loop forever.",
    Icon = "route",
    Value = false,
    Type = "Toggle",
    Flag = "tz_movement_recorder",
    Callback = function(state)
        if state then
            if not TZ_RecorderActive then
                TZ_RecorderActive = true
                TZ_RecorderCleanup = TZ_CreateMovementRecorder()
            end
        else
            if TZ_RecorderCleanup then
                TZ_RecorderCleanup()
                TZ_RecorderCleanup = nil
            end
            TZ_RecorderActive = false
        end
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

getgenv().TZAutoSprintEnabled = false
getgenv().TZAutoSprintShowCircle = false
getgenv().TZAutoSprintRadius = 15
getgenv().TZAutoSprintReleaseTime = 3

local Character = LocalPlayer.Character
local HRP = Character and Character:FindFirstChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- Trigger circle (flat disc on the ground)
local Circle = Instance.new("Part")
Circle.Name = "TZAutoSprintCircle"
Circle.Shape = Enum.PartType.Cylinder
Circle.Anchored = true
Circle.CanCollide = false
Circle.CanQuery = false
Circle.CanTouch = false
Circle.Material = Enum.Material.Neon
Circle.Color = Color3.fromRGB(99, 102, 241)
Circle.Transparency = 1
Circle.Size = Vector3.new(0.15, getgenv().TZAutoSprintRadius * 2, getgenv().TZAutoSprintRadius * 2)
Circle.Parent = workspace

local function updateCircleSize()
    Circle.Size = Vector3.new(0.15, getgenv().TZAutoSprintRadius * 2, getgenv().TZAutoSprintRadius * 2)
end

local function closestMonsterDist()
    local folder = workspace:FindFirstChild("MonsterFolder")
    if not folder or not HRP then return math.huge end
    local closest = math.huge
    local function scan(container)
        for _, m in ipairs(container:GetChildren()) do
            if m:IsA("Folder") then
                scan(m)
            elseif m:IsA("Model") then
                local part = m.PrimaryPart or m:FindFirstChild("HumanoidRootPart") or m:FindFirstChildWhichIsA("BasePart")
                if part then
                    local d = (part.Position - HRP.Position).Magnitude
                    if d < closest then closest = d end
                end
            elseif m:IsA("BasePart") then
                local d = (m.Position - HRP.Position).Magnitude
                if d < closest then closest = d end
            end
        end
    end
    scan(folder)
    return closest
end

local triggered = false
local triggerEndTime = 0
local lastForceSprint = nil

if getgenv().TZAutoSprintConn then
    getgenv().TZAutoSprintConn:Disconnect()
end

getgenv().TZAutoSprintConn = RunService.Heartbeat:Connect(function()
    if HRP then
        local hip = (Character and Character:FindFirstChildOfClass("Humanoid") and Character.Humanoid.HipHeight) or 2
        Circle.CFrame = CFrame.new(HRP.Position - Vector3.new(0, hip + 0.5, 0)) * CFrame.Angles(0, 0, math.rad(90))
    end
    Circle.Transparency = getgenv().TZAutoSprintShowCircle and 0.75 or 1

    if not getgenv().TZAutoSprintEnabled or not Character then
        if lastForceSprint ~= false and Character then
            Character:SetAttribute("ForceSprint", false)
            lastForceSprint = false
        end
        triggered = false
        return
    end

    local dist = closestMonsterDist()
    local now = tick()

    if dist <= getgenv().TZAutoSprintRadius then
        triggered = true
        triggerEndTime = now + getgenv().TZAutoSprintReleaseTime
    elseif triggered and now >= triggerEndTime then
        triggered = false
    end

    if triggered ~= lastForceSprint then
        Character:SetAttribute("ForceSprint", triggered)
        lastForceSprint = triggered
    end
end)

AutomationTab:Toggle({
    Title = "Auto Sprint",
    Default = false,
    Callback = function(state)
        getgenv().TZAutoSprintEnabled = state
        if not state and Character then
            Character:SetAttribute("ForceSprint", false)
        end
    end
})

AutomationTab:Toggle({
    Title = "Show Trigger Circle",
    Default = false,
    Callback = function(state)
        getgenv().TZAutoSprintShowCircle = state
    end
})

AutomationTab:Input({
    Title = "Circle Radius",
    Value = "15",
    Placeholder = "15",
    Callback = function(text)
        local num = tonumber(text)
        if num and num > 0 then
            getgenv().TZAutoSprintRadius = num
            updateCircleSize()
        end
    end
})

AutomationTab:Input({
    Title = "Sprint Release Time (sec)",
    Value = "3",
    Placeholder = "3",
    Callback = function(text)
        local num = tonumber(text)
        if num and num >= 0 then
            getgenv().TZAutoSprintReleaseTime = num
        end
    end
})
getgenv().Flags = getgenv().Flags or {}

local PickupSection = AutomationTab:Section({
	Title = "Pickup",
	Opened = true,
	Box = true,
})

PickupSection:Toggle({
	Title = "Auto Pickup Capsules",
	Flag = "auto_pickup_capsules",
	Value = false,
	Callback = function(value)
		getgenv().Flags["auto_pickup_capsules"] = value
		
		if value then
			task.spawn(function()
				while getgenv().Flags["auto_pickup_capsules"] do
					local Player = game:GetService("Players").LocalPlayer
					local Character = Player and Player.Character
					local Root = Character and Character:FindFirstChild("HumanoidRootPart")
					local Capsules = workspace:FindFirstChild("Capsules")
					
					if Root and Capsules then
						for _, Capsule in ipairs(Capsules:GetChildren()) do
							if not getgenv().Flags["auto_pickup_capsules"] then break end
							
							local Prompt = Capsule:FindFirstChildWhichIsA("ProximityPrompt", true)
							local TargetPart = Capsule.PrimaryPart or Capsule:FindFirstChildWhichIsA("BasePart")
							
							if Prompt and TargetPart and Prompt.Enabled then
								local originalCFrame = Root.CFrame
								local interacting = true
								
								-- Fast loop: Teleports 3.5 studs under the item every 0.01 seconds
								task.spawn(function()
									while interacting and getgenv().Flags["auto_pickup_capsules"] and TargetPart and TargetPart.Parent do
										Root.AssemblyLinearVelocity = Vector3.zero
										Root.CFrame = TargetPart.CFrame * CFrame.new(0, -3.5, 0)
										task.wait(0.01)
									end
								end)
								
								task.wait(0.05) -- Short delay to ensure position snaps before firing
								
								if fireproximityprompt then
									fireproximityprompt(Prompt)
								end
								
								-- Waits and holds underground until collection is fully finished
								repeat
									task.wait()
									local condition = not getgenv().Flags["auto_pickup_capsules"] or not Capsule.Parent or not Prompt.Enabled
								until condition
								
								interacting = false -- Stop the 0.01s teleport loop
								task.wait(0.05)
								
								-- Only returns to the original position once the capsule is fully collected
								Root.AssemblyLinearVelocity = Vector3.zero
								Root.CFrame = originalCFrame
								task.wait(0.2)
							end
						end
					end
					task.wait(0.1)
				end
			end)
		end
	end,
})

PickupSection:Toggle({
	Title = "Auto Pickup Items",
	Flag = "auto_pickup_items",
	Value = false,
	Callback = function(value)
		getgenv().Flags["auto_pickup_items"] = value
		
		if value then
			task.spawn(function()
				while getgenv().Flags["auto_pickup_items"] do
					local Player = game:GetService("Players").LocalPlayer
					local Character = Player and Player.Character
					local Root = Character and Character:FindFirstChild("HumanoidRootPart")
					local ItemsFolder = Player and Player:FindFirstChild("ItemsFolder")
					local ItemsWorld = workspace:FindFirstChild("Items")
					
					if Root and ItemsFolder and ItemsWorld then
						if #ItemsFolder:GetChildren() >= 3 then
							task.wait(1)
							continue
						end
						
						for _, Item in ipairs(ItemsWorld:GetChildren()) do
							if not getgenv().Flags["auto_pickup_items"] then break end
							if #ItemsFolder:GetChildren() >= 3 then break end
							
							local Prompt = Item:FindFirstChildWhichIsA("ProximityPrompt", true)
							local TargetPart = Item.PrimaryPart or Item:FindFirstChildWhichIsA("BasePart")
							
							if Prompt and TargetPart and Prompt.Enabled then
								local originalCFrame = Root.CFrame
								local interacting = true
								
								-- Fast loop: Teleports 3.5 studs under the item every 0.01 seconds
								task.spawn(function()
									while interacting and getgenv().Flags["auto_pickup_items"] and TargetPart and TargetPart.Parent do
										Root.AssemblyLinearVelocity = Vector3.zero
										Root.CFrame = TargetPart.CFrame * CFrame.new(0, -3.5, 0)
										task.wait(0.01)
									end
								end)
								
								task.wait(0.05) -- Short delay to ensure position snaps before firing
								
								if fireproximityprompt then
									fireproximityprompt(Prompt)
								end
								
								-- Waits and holds underground until collection is fully finished
								repeat
									task.wait()
									local condition = not getgenv().Flags["auto_pickup_items"] or not Item.Parent or not Prompt.Enabled or #ItemsFolder:GetChildren() >= 3
								until condition
								
								interacting = false -- Stop the 0.01s teleport loop
								task.wait(0.05)
								
								-- Only returns to the original position once the item is fully collected
								Root.AssemblyLinearVelocity = Vector3.zero
								Root.CFrame = originalCFrame
								task.wait(0.2)
							end
						end
					end
					task.wait(0.1)
				end
			end)
		end
	end,
})

-- Toons univrse

createsettings()
createdonor()
createcustom()
createfeedback()
createsupport()
WindUI:Notify({
    Title = "announcement",
    Content = "Hi I need suggestions so please join discord",
    Icon = "megaphone", -- lucide icon or "rbxassetid://". optional
    Duration = 6, -- time in seconds. optional
})
