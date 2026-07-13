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
local Window = WindUI:CreateWindow({
    Title = "TZ HUB || Animal hospital",
    Folder = "TZHub",
    Icon = "solar:compass-big-bold",
    Theme = "Crimson",
    Transparent = true,
    NewElements = true,
    HideSearchBar = false,
    Background = "rbxassetid://102499664048994",
    BackgroundImageTransparency = 0.42,
})
Window:EditOpenButton({
    Title = "TZ HUB || Animal hospital",
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
-- Toggle to block sanity loss completely
local Toggle = PlayerTab:Toggle({
    Title = "anti Sanity",
    Flag = "Immortal_sanity",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

        if state then
            print("Sanity loss blocked and set to NaN")
            -- Backup original
            if not getgenv().PlayerLostSanityBackup then
                getgenv().PlayerLostSanityBackup = Lib.Network.FireServer
            end
            -- Override FireServer for PlayerLostSanity
            Lib.Network.FireServer = function(self, event, ...)
                if event == "PlayerLostSanity" then
                    print("Blocked sanity loss event.")
                    player:SetAttribute("Sanity", 0/0) -- force NaN
                    return
                end
                return getgenv().PlayerLostSanityBackup(self, event, ...)
            end
            -- Lock sanity as NaN
            player:SetAttribute("Sanity", 0/0)
            player:GetAttributeChangedSignal("Sanity"):Connect(function()
                player:SetAttribute("Sanity", 0/0)
            end)
        else
            print("Sanity loss allowed again")
            if getgenv().PlayerLostSanityBackup then
                Lib.Network.FireServer = getgenv().PlayerLostSanityBackup
            end
            player:SetAttribute("Sanity", 100)
        end
    end
})

-- Create Universal tab
local UniversalTab = Window:Tab({
    Title = "Universal",
    Icon = "globe"
})

-- Section with credit
UniversalTab:Section({
    Title = "Float script by @muapx_0",
    Desc = "Shared in the Discord bookclub"
})

UniversalTab:Button({
    Title = "Run Float Script",
    Desc = "Loads float script",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://gist.githubusercontent.com/shigaraki-svg/6a037ac5d9a6386ccfc9871c18b757af/raw/05715144621af9d2249c8b6a883f12872eeebcbc/Float"))()
        end)

        if success then
            print("[Universal] Float script executed!")
        else
            warn("[Universal] Error:", err)
        end
    end
})
-- Section with credit
UniversalTab:Section({
    Title = "Change speed script by @thebrickzcc",
    Desc = "Shared in the Discord TZ HUB"
})

UniversalTab:Button({
    Title = "Run change speed Script",
    Desc = "Loads change speed script",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/m7JCkB8W/raw"))()
        end)

        if success then
            print("[Universal] change speed script executed!")
        else
            warn("[Universal] Error:", err)
        end
    end
})
SectionLin = UniversalTab:Section({
    Title = "Linear Script server hopper",
    Desc = "This script will teleport you to a server that reached shift 100+ or more so you can reach highest shifts and be in the leaderboard!",
    Opened = true,
})
SectionLin:Button({
  Title = "Exeute script!",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/christmas-cookie/extensions/refs/heads/main/AnimalHospitalServerHopper.lua"))()
    end
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
getgenv().WalkSpeedValue = 16 -- Default Roblox WalkSpeed


-- Background loop to enforce WalkSpeed persistently (handles respawns/game resets)
task.spawn(function()
	while true do
		local Player = game:GetService("Players").LocalPlayer
		local Character = Player and Player.Character
		local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
		
		if Humanoid and Humanoid.WalkSpeed ~= getgenv().WalkSpeedValue then
			Humanoid.WalkSpeed = getgenv().WalkSpeedValue
		end
		task.wait(0.1)
	end
end)

PlayerTab:Slider({
	Title = "WalkSpeed",
	IsTooltip = true,
	IsTextbox = false,
	Value = { Min = 16, Max = 100, Default = 16 },
	Step = 1,
	Callback = function(value)
		getgenv().WalkSpeedValue = value
		
		local Player = game:GetService("Players").LocalPlayer
		local Character = Player and Player.Character
		local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
		if Humanoid then
			Humanoid.WalkSpeed = value
		end
	end,
})
getgenv().Flags = getgenv().Flags or {}

local TargetWindow = Window or _G.Window
if not TargetWindow then
    warn("WindUI Window not found.")
    return
end

-- ══════════════════════════════════
--   AUTOMATION TAB (No Sections)
-- ══════════════════════════════════

local AutomationTab = TargetWindow:Tab({
    Title = "Automation",
    Icon  = "solar:cpu-bold",
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Safely require the game library and preserve original functions for toggling off
local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local originalStart = Lib.StartCircleMinigame
local originalEnd = Lib.EndCircleMinigame

local function autoCircleMinigame(callback)
    Lib.CS:AddTag(LocalPlayer, "InMinigame")

    task.wait(0.25)
    Lib.HeartMinigameComplete(true)

    Lib.CS:RemoveTag(LocalPlayer, "InMinigame")

    if callback then
        callback(false)
    end
end

AutomationTab:Toggle({
    Title    = "Auto Circle Minigame",
    Flag     = "auto_circle_minigame",
    Value    = false,
    Callback = function(value)
        getgenv().Flags["auto_circle_minigame"] = value
        if value then
            -- Inject autocomplete hooks
            Lib.Inject("StartCircleMinigame", autoCircleMinigame)
            Lib.Inject("EndCircleMinigame", function()
                Lib.CS:RemoveTag(LocalPlayer, "InMinigame")
            end)
        else
            -- Restore original game functions when toggled off
            if originalStart then Lib.Inject("StartCircleMinigame", originalStart) end
            if originalEnd then Lib.Inject("EndCircleMinigame", originalEnd) end
        end
    end,
})

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local NPCs = workspace:WaitForChild("NPCs")

local MinigameLib = require(game:GetService("ReplicatedStorage"):WaitForChild("Lib"))

MinigameLib.Inject("StartCircleMinigame", function(callback)
    MinigameLib.CS:AddTag(LocalPlayer, "InMinigame")
    task.wait(0.25)
    MinigameLib.HeartMinigameComplete(true)
    MinigameLib.CS:RemoveTag(LocalPlayer, "InMinigame")
    if callback then callback(false) end
end)

MinigameLib.Inject("EndCircleMinigame", function()
    MinigameLib.CS:RemoveTag(LocalPlayer, "InMinigame")
end)

getgenv().AnchorTarget = nil
getgenv().SkinwalkerActive = false
getgenv().FirePatientActive = false
getgenv().TreatmentInProgress = false
getgenv().Room6Active = false
getgenv().HospitalFarmEnabled = false 
getgenv().ESPPatientsEnabled = false
getgenv().ESPSkinwalkersEnabled = false

local function findPrompt(root)
    if not root then return nil end
    for _, d in ipairs(root:GetDescendants()) do
        if d:IsA("ProximityPrompt") then return d end
    end
    return nil
end

local function findPromptByPreference(root, preferredNames)
    if not root then return nil end
    local all = {}
    for _, d in ipairs(root:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
            table.insert(all, d)
        end
    end
    for _, name in ipairs(preferredNames) do
        for _, p in ipairs(all) do
            if p.Name == name then return p end
        end
    end
    return all[1]
end

local function rawTeleport(obj)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not obj then return end
    local pos
    if obj:IsA("BasePart") then
        pos = obj.Position
    elseif obj:IsA("Model") then
        pos = obj:GetPivot().Position
    end
    if pos then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
    end
end

local function teleportTo(obj)
    getgenv().AnchorTarget = obj
    rawTeleport(obj)
end

local function clearAnchor()
    getgenv().AnchorTarget = nil
end

task.spawn(function()
    while true do
        if getgenv().AnchorTarget then
            rawTeleport(getgenv().AnchorTarget)
        end
        task.wait(0.1)
    end
end)

local function fire(obj, timeout)
    teleportTo(obj)
    task.wait(0.2)
    local p = findPrompt(obj)
    timeout = timeout or 5
    local t = 0
    while p and (not p.Enabled) and t < timeout do
        if getgenv().SkinwalkerActive then return false end
        task.wait(0.2)
        t += 0.2
    end
    if p and p.Parent then
        fireproximityprompt(p)
        return true
    end
    warn("Could not fire prompt on: " .. obj:GetFullName())
    return false
end

local function fireNamed(root, promptName, timeout)
    teleportTo(root)
    task.wait(0.2)
    local p = root:FindFirstChild(promptName)
    timeout = timeout or 5
    local t = 0
    while p and (not p.Enabled) and t < timeout do
        if getgenv().SkinwalkerActive then return false end
        task.wait(0.2)
        t += 0.2
    end
    if p and p.Parent then
        fireproximityprompt(p)
        return true
    end
    warn("Could not fire named prompt '" .. promptName .. "' on: " .. root:GetFullName())
    return false
end

local function findItemByName(itemName)
    for _, d in ipairs(workspace:GetDescendants()) do
        if d.Name == "Items" and (d:IsA("Folder") or d:IsA("Model")) then
            local item = d:FindFirstChild(itemName)
            if item then
                return item
            end
        end
    end
    return nil
end

local function waitForChild(parent, name, timeout)
    timeout = timeout or 10
    local t = 0
    local obj = parent:FindFirstChild(name)
    while not obj and t < timeout do
        if getgenv().SkinwalkerActive then return nil end
        task.wait(0.2)
        t += 0.2
        obj = parent:FindFirstChild(name)
    end
    return obj
end

local function getNPCNearPart(part, range)
    range = range or 10
    if not part then return nil end
    local refPos = part:IsA("Model") and part:GetPivot().Position or part.Position
    for _, npc in ipairs(NPCs:GetChildren()) do
        local root = npc:FindFirstChild("HumanoidRootPart")
        if root and (root.Position - refPos).Magnitude <= range then
            return npc
        end
    end
    return nil
end

local function findNearestPromptInRange(position, range)
    range = range or 15
    local nearest, nearestDist = nil, math.huge
    for _, d in ipairs(workspace:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
            local part = d.Parent
            local pos
            if part and part:IsA("BasePart") then
                pos = part.Position
            elseif part and part:IsA("Attachment") then
                pos = part.WorldPosition
            end
            if pos then
                local dist = (pos - position).Magnitude
                if dist < range and dist < nearestDist then
                    nearest = d
                    nearestDist = dist
                end
            end
        end
    end
    return nearest
end

local function getLabelText(obj)
    if not obj then return nil end
    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
        return obj.Text
    end
    local textChild = obj:FindFirstChild("text") or obj:FindFirstChild("Text") or obj:FindFirstChild("Label")
    if textChild and (textChild:IsA("TextLabel") or textChild:IsA("TextButton")) then
        return textChild.Text
    end
    for _, d in ipairs(obj:GetDescendants()) do
        if d:IsA("TextLabel") or d:IsA("TextButton") then
            return d.Text
        end
    end
    return nil
end

local function findModelWithForm()
    for _, d in ipairs(workspace:GetDescendants()) do
        if (d:IsA("Model") or d:IsA("Folder")) and d:FindFirstChild("Form") then
            return d
        end
    end
    return nil
end

local medicalRooms = {"Room1", "Room2", "Room3", "Room4", "Room5"}

local notified = {}

local function notify(name)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "⚠️ Skinwalker Detected",
            Text = name,
            Duration = 5,
        })
    end)
end

local cachedShutterPrompt = nil

local function handleSkinwalker(npc)
    print("SKINWALKER DETECTED:", npc.Name, "- stopping everything")
    getgenv().SkinwalkerActive = true
    notify(npc.Name)

    local shutterModel = workspace.Misc:FindFirstChild("ShutterButton")

    if shutterModel then
        teleportTo(shutterModel)
        task.wait(0.2)

        local prompt = cachedShutterPrompt
        if not (prompt and prompt.Parent) then
            prompt = shutterModel:FindFirstChild("PP") or findPrompt(shutterModel)
        end

        if not (prompt and prompt.Parent) then
            local pos = shutterModel:IsA("Model") and shutterModel:GetPivot().Position or shutterModel.Position
            local nearest = findNearestPromptInRange(pos, 15)
            if nearest and nearest:IsDescendantOf(shutterModel) then
                prompt = nearest
                print("Found ShutterButton prompt via distance search:", nearest:GetFullName())
            end
        end

        if prompt and prompt.Parent then
            cachedShutterPrompt = prompt
            fireproximityprompt(prompt)

            while npc.Parent and npc:GetAttribute("Skinwalker") == true do
                task.wait(0.3)
            end

            teleportTo(button)
            task.wait(0.2)
            if prompt.Parent then
                fireproximityprompt(prompt)
            end
        else
            warn("ShutterButton prompt not found, even with distance fallback")
        end
    else
        warn("Misc.ShutterButton not found")
    end

    clearAnchor()
    getgenv().SkinwalkerActive = false
    print("Skinwalker handled, resuming normal operation")
end

task.spawn(function()
    while task.wait(0.2) do
        if getgenv().HospitalFarmEnabled then
            for _, npc in ipairs(NPCs:GetChildren()) do
                if npc:IsA("Model") and npc:GetAttribute("Skinwalker") == true then
                    if not notified[npc] then
                        notified[npc] = true
                        handleSkinwalker(npc)
                    end
                else
                    notified[npc] = nil
                end
            end
        end
    end
end)

local function handleCandles(room)
    local candlesFolder = room:FindFirstChild("Candles")
    if not candlesFolder then return end

    local anyBad = false
    for _, candle in ipairs(candlesFolder:GetChildren()) do
        local p = findPrompt(candle)
        if p and p.Enabled then
            anyBad = true
        end
    end
    if not anyBad then return end

    print("Bad candles detected in " .. room.Parent.Name .. ", handling...")
    for _, candle in ipairs(candlesFolder:GetChildren()) do
        if getgenv().SkinwalkerActive then return end
        local p = findPrompt(candle)
        if p and p.Enabled then
            teleportTo(candle)
            local attempts = 0
            while p.Parent and p.Enabled and attempts < 10 do
                if getgenv().SkinwalkerActive then return end
                fireproximityprompt(p)
                task.wait(0.4)
                attempts += 1
            end
        end
    end
    clearAnchor()
    print("Candles handled in " .. room.Parent.Name)
end

local processedCheckIns = {}

local function findReadyPatientNPC()
    for _, npc in ipairs(NPCs:GetChildren()) do
        if not processedCheckIns[npc] then
            local p = findPrompt(npc)
            if p and p.Enabled then
                return npc
            end
        end
    end
    return nil
end

task.spawn(function()
    while true do
        if getgenv().HospitalFarmEnabled and not getgenv().SkinwalkerActive and not getgenv().FirePatientActive
            and not getgenv().TreatmentInProgress and not getgenv().Room6Active then
            local ok, err = pcall(function()
                local checkInModel = findModelWithForm()
                if checkInModel then
                    print("Form detected at " .. checkInModel:GetFullName() .. ", starting check-in")

                    fire(checkInModel.Form)
                    task.wait(0.3)
                    if getgenv().SkinwalkerActive then return end

                    local cameraObj = checkInModel:FindFirstChild("Camera")
                    if cameraObj then fire(cameraObj) end
                    task.wait(0.3)
                    if getgenv().SkinwalkerActive then return end

                    local computerObj = checkInModel:FindFirstChild("Computer")
                    if computerObj then fire(computerObj) end
                    task.wait(0.3)
                    if getgenv().SkinwalkerActive then return end

                    local printerObj = checkInModel:FindFirstChild("Printer")
                    if printerObj then fire(printerObj) end
                    task.wait(0.3)
                    if getgenv().SkinwalkerActive then return end

                    local badge = waitForChild(checkInModel, "PrintedBadge", 10)
                    if badge then
                        fire(badge)
                    else
                        warn("PrintedBadge never appeared")
                    end
                    task.wait(0.5)
                    if getgenv().SkinwalkerActive then return end

                    local npc = findReadyPatientNPC()
                    if npc then
                        processedCheckIns[npc] = true
                        local npcPrompt = findPrompt(npc)
                        if npcPrompt then
                            teleportTo(npc:FindFirstChild("HumanoidRootPart") or npc)
                            task.wait(0.2)
                            local t = 0
                            while npcPrompt.Parent and (not npcPrompt.Enabled) and t < 8 do
                                if getgenv().SkinwalkerActive then return end
                                task.wait(0.2)
                                t += 0.2
                            end
                            if npcPrompt.Parent then fireproximityprompt(npcPrompt) end
                        end
                        print("Checked in:", npc.Name)
                    else
                        warn("Could not find waiting NPC to hand badge to")
                    end
                end
            end)
            if not ok then
                warn("Check-in loop error: " .. tostring(err))
            end
            clearAnchor()
        end
        task.wait(0.3)
    end
end)

local function fetchAndEquipItem(itemName)
    local itemObj = findItemByName(itemName)
    if not itemObj then
        warn("Item not found anywhere: " .. itemName)
        return false
    end

    print("Fetching: " .. itemName)
    fire(itemObj)
    task.wait(1)
    if getgenv().SkinwalkerActive then return false end

    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    local tool = backpack and backpack:FindFirstChild(itemName)
    if tool and humanoid then
        humanoid:EquipTool(tool)
        print("Equipped: " .. itemName)
    end
    return true
end

local function deliverToBed(room)
    fire(room.Bed.InBed)
    task.wait(0.5)
end

local function handleReportAndItems(room, deliverFn)
    local reportUI = room.TV.Screen.UI
    local reportInv = reportUI.Report.inv
    local treatmentObj = reportUI.Report:FindFirstChild("treatment")

    local neededCount = nil
    local waitedTreatment = 0
    while waitedTreatment < 15 do
        if getgenv().SkinwalkerActive then return end
        local txt = getLabelText(treatmentObj)
        if txt then
            local _, totalCapture = txt:match("(%d+)%s*/%s*(%d+)")
            if totalCapture then neededCount = tonumber(totalCapture) break end
        end
        task.wait(0.3)
        waitedTreatment += 0.3
    end

    local waitedReport = 0
    while waitedReport < 30 do
        if getgenv().SkinwalkerActive then return end
        local currentFrames = 0
        for _, f in ipairs(reportInv:GetChildren()) do
            if f:IsA("Frame") then currentFrames += 1 end
        end
        if neededCount and currentFrames >= neededCount then break
        elseif not neededCount and currentFrames > 0 then break end
        task.wait(0.5)
        waitedReport += 0.5
    end

    local neededItems = {}
    for _, frame in ipairs(reportInv:GetChildren()) do
        if frame:IsA("Frame") and #neededItems < 3 then
            table.insert(neededItems, frame.Name)
        end
    end

    if #neededItems == 0 then
        warn("No items found in report for " .. room.Parent.Name)
        return
    end

    print("Needed items: " .. table.concat(neededItems, ", "))

    for _, itemName in ipairs(neededItems) do
        if getgenv().SkinwalkerActive then return end
        local got = fetchAndEquipRoom8Item(itemName) or fetchAndEquipItem(itemName)
        if got then
            deliverFn()
            task.wait(0.5)
        end
    end
end

local function getButtonModels(colorsFolder)
    local buttons = {}
    for _, child in ipairs(colorsFolder:GetChildren()) do
        local btn = child:FindFirstChild("Button")
        if btn then table.insert(buttons, btn) end
    end
    return buttons
end

local function recordColorSequence(buttons)
    local baseline = {}
    for _, btn in ipairs(buttons) do baseline[btn] = btn.Color end

    local sequence = {}
    local activeBtn = nil
    local lastFlashTime = tick()

    while true do
        local now = tick()
        if #sequence > 0 and now - lastFlashTime > 3 then break end
        if #sequence == 0 and now - lastFlashTime > 10 then break end

        for _, btn in ipairs(buttons) do
            if btn.Color ~= baseline[btn] then
                if activeBtn ~= btn then
                    activeBtn = btn
                    table.insert(sequence, btn)
                    lastFlashTime = now
                end
            elseif activeBtn == btn then
                activeBtn = nil
            end
        end
        task.wait(0.1)
    end
    return sequence
end

local function replaySequence(sequence)
    for _, btn in ipairs(sequence) do
        teleportTo(btn)
        task.wait(0.2)
        local cd = btn:FindFirstChildOfClass("ClickDetector")
        if cd then
            fireclickdetector(cd)
        else
            warn("No ClickDetector on: " .. btn:GetFullName())
        end
        task.wait(0.3)
    end
end

local function handleRoom6Patient()
    local room = workspace.Rooms.Emergency.Room6.Minigame
    print("Room6 patient detected, watching color sequence")
    getgenv().Room6Active = true

    local buttons = getButtonModels(room.Colors)
    teleportTo(room.Colors)
    local sequence = recordColorSequence(buttons)

    if #sequence == 0 then
        warn("No color sequence detected in Room6")
        clearAnchor()
        getgenv().Room6Active = false
        return
    end

    print("Recorded " .. #sequence .. " flashes, replaying...")
    replaySequence(sequence)

    local monitorPrompt
    local waited = 0
    repeat
        monitorPrompt = room.Monitor:FindFirstChild("PP2")
        if not monitorPrompt or not monitorPrompt.Enabled then
            task.wait(0.3)
            waited += 0.3
        end
    until (monitorPrompt and monitorPrompt.Enabled) or waited >= 15

    if monitorPrompt and monitorPrompt.Enabled then
        fireNamed(room.Monitor, "PP2")
    else
        warn("Room6 Monitor.PP2 never became ready")
    end
    task.wait(1)

    local xray = waitForChild(room, "PrintedXRay", 10)
    if xray then fire(xray) end
    task.wait(0.5)

    handleReportAndItems(room, function()
        fire(room.xrayMonitor)
    end)

    clearAnchor()
    getgenv().Room6Active = false
    print("Room6 treatment complete")
end

task.spawn(function()
    while true do
        if getgenv().HospitalFarmEnabled and not getgenv().Room6Active and not getgenv().SkinwalkerActive
            and not getgenv().FirePatientActive and not getgenv().TreatmentInProgress then
            local room6 = workspace.Rooms.Emergency.Room6.Minigame
            local xrayPrompt = room6.xrayMonitor:FindFirstChild("PP")
            if xrayPrompt and xrayPrompt.Enabled then
                local ok, err = pcall(handleRoom6Patient)
                if not ok then
                    warn("Room6 error: " .. tostring(err))
                    getgenv().Room6Active = false
                end
            end
        end
        task.wait(0.5)
    end
end)

local notifiedFire = {}

local function handleFirePatient(npc)
    print("FIRE PATIENT DETECTED:", npc.Name, "- running Room7 sequence")
    getgenv().FirePatientActive = true

    local room = workspace.Rooms.Emergency.Room7.Minigame

    local firePrompt = npc:FindFirstChild("FirePP")
    if firePrompt then
        teleportTo(npc:FindFirstChild("HumanoidRootPart") or npc)
        task.wait(0.2)
        if firePrompt.Parent then fireproximityprompt(firePrompt) end
    else
        warn("FirePP not found on " .. npc.Name)
    end
    task.wait(0.5)

    fireNamed(room.Bed.InBed, "PP2")
    task.wait(0.5)

    fire(room.StandIV)
    task.wait(0.5)

    fire(room.Machine)
    task.wait(0.5)

    fire(room.HeartMonitor)
    task.wait(1.5)

    fireNamed(room.Monitor, "PP2")
    task.wait(1)

    local xray = waitForChild(room, "PrintedXRay", 10)
    if xray then
        fire(xray)
    else
        warn("PrintedXRay never appeared in Room7")
        clearAnchor()
        getgenv().FirePatientActive = false
        return
    end
    task.wait(0.5)

    handleReportAndItems(room, function()
        fireNamed(room.Bed.InBed, "PP")
    end)

    clearAnchor()
    getgenv().FirePatientActive = false
    print("Room7 treatment complete for", npc.Name)
end

local function findRoom8Item(itemName)
    local medicineFolder = workspace.Rooms.Emergency.Room8.Minigame.Medicine.Model
    return medicineFolder:FindFirstChild(itemName)
end

local function fetchAndEquipRoom8Item(itemName)
    local itemObj = findRoom8Item(itemName)
    if not itemObj then
        warn("Room8 item not found: " .. itemName)
        return false
    end

    print("Fetching (Room8): " .. itemName)
    fire(itemObj)
    task.wait(1)

    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    local tool = backpack and backpack:FindFirstChild(itemName)
    if tool and humanoid then
        humanoid:EquipTool(tool)
        print("Equipped: " .. itemName)
    end
    return true
end

local function treatPatientInRoom8(npc)
    local room = workspace.Rooms.Emergency.Room8.Minigame

    print("Diagnosing patient in Room8: " .. npc.Name)

    teleportTo(npc:FindFirstChild("HumanoidRootPart") or npc)
    task.wait(0.3)
    fire(npc, 8)
    task.wait(1)

    fire(room.Monitor) 
    task.wait(1)

    local processPrompt = room.Monitor:FindFirstChild("PP2")
    local waited = 0
    while processPrompt and not processPrompt.Enabled and waited < 10 do
        task.wait(0.3)
        waited += 0.3
    end
    if processPrompt and processPrompt.Enabled then
        fireNamed(room.Monitor, "PP2")
    else
        warn("Room8 Monitor.PP2 never became ready")
        return
    end
    task.wait(1)

    fireNamed(room.Bed.InBed, "PP2")
    task.wait(1)

    handleReportAndItems(room, function()
        fireNamed(room.Bed.InBed, "PP")
    end)

    print("Room8 treatment complete for " .. npc.Name)
end

task.spawn(function()
    while task.wait(0.2) do
        if getgenv().HospitalFarmEnabled and not getgenv().SkinwalkerActive then
            for _, npc in ipairs(NPCs:GetChildren()) do
                local firePrompt = npc:FindFirstChild("FirePP")
                if firePrompt and firePrompt:IsA("ProximityPrompt") and firePrompt.Enabled then
                    if not notifiedFire[npc] then
                        notifiedFire[npc] = true
                        handleFirePatient(npc)
                    end
                else
                    notifiedFire[npc] = nil
                end
            end
        end
    end
end)

local function treatPatientInRoom(roomName, npc)
    local room = workspace.Rooms.Medical[roomName].Minigame
    local checkInModel = findModelWithForm()

    handleCandles(room)
    if getgenv().SkinwalkerActive then return end

    print("Diagnosing patient in " .. roomName .. ": " .. npc.Name)

    fire(npc, 8)
    task.wait(1)
    if getgenv().SkinwalkerActive then return end

    local analyzerLabel = room.Analyzer.Screen.UI.Label
    local previousText = analyzerLabel.Text

    fire(room.Analyzer)

    local waitedAnalyzer = 0
    while waitedAnalyzer < 30 do
        if getgenv().SkinwalkerActive then return end
        if analyzerLabel.Text == "Analyzed" and analyzerLabel.Text ~= previousText then
            break
        end
        task.wait(0.3)
        waitedAnalyzer += 0.3
    end

    if analyzerLabel.Text ~= "Analyzed" then
        warn("Analyzer never finished for " .. roomName)
        return
    end

    teleportTo(room.Monitor.Screen)
    local monitorPrompt
    local waited = 0
    repeat
        if getgenv().SkinwalkerActive then return end
        monitorPrompt = findPromptByPreference(room.Monitor, {"PP2", "PP"})
        if not monitorPrompt or not monitorPrompt.Enabled then
            task.wait(0.3)
            waited += 0.3
        end
    until (monitorPrompt and monitorPrompt.Enabled) or waited >= 10

    if not monitorPrompt or not monitorPrompt.Enabled then
        warn("Monitor prompt never became ready for " .. roomName)
        return
    end

    local reportUI = room.TV.Screen.UI
    local reportInv = reportUI.Report.inv
    local treatmentObj = reportUI.Report:FindFirstChild("treatment")

    fireproximityprompt(monitorPrompt)

    local neededCount = nil
    local waitedTreatment = 0
    while waitedTreatment < 15 do
        if getgenv().SkinwalkerActive then return end
        local txt = getLabelText(treatmentObj)
        if txt then
            local _, totalCapture = txt:match("(%d+)%s*/%s*(%d+)")
            if totalCapture then
                neededCount = tonumber(totalCapture)
                break
            end
        end
        task.wait(0.3)
        waitedTreatment += 0.3
    end

    local waitedReport = 0
    local lastRefire = 0
    while waitedReport < 60 do
        if getgenv().SkinwalkerActive then return end
        local currentFrames = 0
        for _, f in ipairs(reportInv:GetChildren()) do
            if f:IsA("Frame") then currentFrames += 1 end
        end
        if neededCount and currentFrames >= neededCount then
            break
        elseif not neededCount and currentFrames > 0 then
            break
        end
        task.wait(0.5)
        waitedReport += 0.5
        lastRefire += 0.5
        if lastRefire >= 5 and monitorPrompt.Parent and monitorPrompt.Enabled then
            fireproximityprompt(monitorPrompt)
            lastRefire = 0
        end
    end

    local neededItems = {}
    for _, frame in ipairs(reportInv:GetChildren()) do
        if frame:IsA("Frame") and #neededItems < 3 then
            table.insert(neededItems, frame.Name)
        end
    end

    if #neededItems == 0 then
        warn("No items found for " .. roomName .. " — aborting this patient")
        return
    end

    print("Needed items: " .. table.concat(neededItems, ", "))

    for _, itemName in ipairs(neededItems) do
        if getgenv().SkinwalkerActive then return end
        local got = fetchAndEquipItem(itemName)
        if got then
            deliverToBed(room)
        end
    end

    print("Treatment delivered to " .. roomName)

    if checkInModel then
        local printerObj = checkInModel:FindFirstChild("Printer")
        if printerObj then
            teleportTo(printerObj)
        end
    end
    print("Returned to Printer, patient " .. npc.Name .. " complete")
end

local roomWaitStart = {}

local function findWaitingPatientInRoom(roomName)
    local room = workspace.Rooms.Medical[roomName].Minigame
    local npc = getNPCNearPart(room.Bed.InBed, 10)
    if not npc then
        roomWaitStart[roomName] = nil
        return nil
    end
    local p = findPrompt(npc)
    if p and p.Enabled then
        if not roomWaitStart[roomName] then
            roomWaitStart[roomName] = tick()
        end
        return npc
    end
    roomWaitStart[roomName] = nil
    return nil
end

local function getRoomsByPriority()
    local candidates = {}
    for _, roomName in ipairs(medicalRooms) do
        local npc = findWaitingPatientInRoom(roomName)
        if npc then
            table.insert(candidates, {
                roomName = roomName,
                waitStart = roomWaitStart[roomName] or tick()
            })
        end
    end
    table.sort(candidates, function(a, b) return a.waitStart < b.waitStart end)
    return candidates
end

task.spawn(function()
    while true do
        if getgenv().HospitalFarmEnabled and not getgenv().SkinwalkerActive
            and not getgenv().FirePatientActive and not getgenv().Room6Active then
            for _, roomName in ipairs(medicalRooms) do
                if getgenv().SkinwalkerActive then break end
                handleCandles(workspace.Rooms.Medical[roomName].Minigame)
            end

            local priorityList = getRoomsByPriority()
            for _, entry in ipairs(priorityList) do
                if not getgenv().HospitalFarmEnabled or getgenv().SkinwalkerActive or getgenv().FirePatientActive then break end

                local stillThere = findWaitingPatientInRoom(entry.roomName)
                if stillThere then
                    getgenv().TreatmentInProgress = true
                    local ok, err = pcall(treatPatientInRoom, entry.roomName, stillThere)
                    if not ok then
                        warn("Error treating " .. entry.roomName .. ": " .. tostring(err))
                    end
                    clearAnchor()
                    getgenv().TreatmentInProgress = false
                end
            end
        end
        task.wait(0.1)
    end
end)

local patientHighlights = {}

local function addPatientHighlight(npc)
    if patientHighlights[npc] then return end
    local h = Instance.new("Highlight")
    h.FillColor = Color3.fromRGB(16, 197, 80)
    h.OutlineColor = Color3.fromRGB(16, 197, 80)
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.Parent = npc
    patientHighlights[npc] = h
end

local function removePatientHighlight(npc)
    local h = patientHighlights[npc]
    if h then
        h:Destroy()
        patientHighlights[npc] = nil
    end
end

task.spawn(function()
    while true do
        if getgenv().ESPPatientsEnabled then
            for _, npc in ipairs(NPCs:GetChildren()) do
                local isPatient = npc:GetAttribute("IsPatient") == true
                    and npc:GetAttribute("Skinwalker") ~= true
                if isPatient then
                    addPatientHighlight(npc)
                else
                    removePatientHighlight(npc)
                end
            end
        else
            for npc in pairs(patientHighlights) do
                removePatientHighlight(npc)
            end
        end
        task.wait(0.5)
    end
end)

local skinwalkerHighlights = {}

local function addSkinwalkerHighlight(npc)
    if skinwalkerHighlights[npc] then return end
    local h = Instance.new("Highlight")
    h.FillColor = Color3.fromRGB(239, 79, 29)
    h.OutlineColor = Color3.fromRGB(239, 79, 29)
    h.FillTransparency = 0.3
    h.OutlineTransparency = 0
    h.Parent = npc
    skinwalkerHighlights[npc] = h
end

local function removeSkinwalkerHighlight(npc)
    local h = skinwalkerHighlights[npc]
    if h then
        h:Destroy()
        skinwalkerHighlights[npc] = nil
    end
end

task.spawn(function()
    while true do
        if getgenv().ESPSkinwalkersEnabled then
            for _, npc in ipairs(NPCs:GetChildren()) do
                if npc:GetAttribute("Skinwalker") == true then
                    addSkinwalkerHighlight(npc)
                else
                    removeSkinwalkerHighlight(npc)
                end
            end
        else
            for npc in pairs(skinwalkerHighlights) do
                removeSkinwalkerHighlight(npc)
            end
        end
        task.wait(0.3)
    end
end)

AutomationTab:Toggle({
    Flag = "HospitalAutoFarm",
    Title = "Auto Farm Hospital",
    Desc = "doesn't handle burning animals or animals that lose their mind yet.",
    Value = false,
    Callback = function(state)
        getgenv().HospitalFarmEnabled = state
    end,
})
local InstantFireToggle = AutomationTab:Toggle({
    Title = "Instant Fire Prompt",
    Desc = "Makes hold prompts instant",
    Icon = "",
    Value = false, -- default OFF
    Callback = function(state)
        getgenv().InstantFireEnabled = state

        -- Apply to all existing prompts
        for _, prompt in ipairs(game:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                if state then
                    prompt.HoldDuration = 0
                else
                    prompt.HoldDuration = 1 -- reset default (adjust if needed)
                end
            end
        end
    end
})
-- Auto-apply to new prompts
game.DescendantAdded:Connect(function(desc)
    if desc:IsA("ProximityPrompt") then
        if getgenv().InstantFireEnabled then
            desc.HoldDuration = 0
        end
    end
end)
local ESPTab = Window:Tab({
    Title = "ESP",
    Icon = "eye", -- optional
})
ESPTab:Toggle({
    Flag = "ESPPatients",
    Title = "ESP: Patients",
    Desc = "Highlights patients ready for treatment in green.",
    Value = false,
    Callback = function(state)
        getgenv().ESPPatientsEnabled = state
    end,
})

ESPTab:Toggle({
    Flag = "ESPSkinwalkers",
    Title = "ESP: Skinwalkers",
    Desc = "Highlights active Skinwalkers in red.",
    Value = false,
    Callback = function(state)
        getgenv().ESPSkinwalkersEnabled = state
    end,
})

print("Hospital auto farm + ESP loaded.")
-- ══════════════════════════════════
--   PLAYER TAB (No Sections Addition)
-- ══════════════════════════════════

-- Attempts to use your existing PlayerTab, or creates it if not already defined
local PlayerTab = PlayerTab or TargetWindow:Tab({
    Title = "Player",
    Icon  = "solar:user-bold",
})


createfeedback()
createsettings()
createcustom()
createdonor()
createsupport()
WindUI:Notify({
    Title = "announcement",
    Content = "HAIIIII!!!:D",
    Icon = "megaphone", -- lucide icon or "rbxassetid://". optional
    Duration = 3, -- time in seconds. optional
})
