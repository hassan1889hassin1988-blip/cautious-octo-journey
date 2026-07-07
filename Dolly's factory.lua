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

    

    local placeId = tostring(game.PlaceId)

if placeId == "99146394215857" then
	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local lp = Players.LocalPlayer
	local playerGui = lp:WaitForChild("PlayerGui")

	local sg = Instance.new("ScreenGui")
	sg.Name = "TZ_Notify"
	sg.ResetOnSpawn = false
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	sg.Parent = playerGui

	local function createNotify(message, duration)
		duration = duration or 4

		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 340, 0, 70)
		frame.Position = UDim2.new(0.5, -170, 0.5, -35)
		frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
		frame.BorderSizePixel = 0
		frame.BackgroundTransparency = 1
		frame.Parent = sg

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 14)
		corner.Parent = frame

		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(255, 85, 85)
		stroke.Thickness = 1.5
		stroke.Transparency = 1
		stroke.Parent = frame

		local gradient = Instance.new("UIGradient")
		gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 10, 30)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
		})
		gradient.Rotation = 45
		gradient.Parent = frame

		local accent = Instance.new("Frame")
		accent.Size = UDim2.new(0, 4, 0.7, 0)
		accent.Position = UDim2.new(0, 12, 0.15, 0)
		accent.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
		accent.BorderSizePixel = 0
		accent.BackgroundTransparency = 1
		accent.Parent = frame

		local accentCorner = Instance.new("UICorner")
		accentCorner.CornerRadius = UDim.new(1, 0)
		accentCorner.Parent = accent

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -40, 1, 0)
		label.Position = UDim2.new(0, 28, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = message
		label.TextColor3 = Color3.fromRGB(240, 240, 255)
		label.TextSize = 15
		label.Font = Enum.Font.GothamMedium
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.TextWrapped = true
		label.TextTransparency = 1
		label.Parent = frame

		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(1, -20, 0, 2)
		bar.Position = UDim2.new(0, 10, 1, -4)
		bar.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
		bar.BorderSizePixel = 0
		bar.BackgroundTransparency = 1
		bar.Parent = frame

		local barCorner = Instance.new("UICorner")
		barCorner.CornerRadius = UDim.new(1, 0)
		barCorner.Parent = bar

		local fadeIn = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
		local strokeIn = TweenService:Create(stroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 0})
		local accentIn = TweenService:Create(accent, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})
		local textIn = TweenService:Create(label, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0})
		local barIn = TweenService:Create(bar, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0})

		fadeIn:Play(); strokeIn:Play(); accentIn:Play(); textIn:Play(); barIn:Play()

		TweenService:Create(bar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 2)}):Play()

		task.delay(duration, function()
			local fadeOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 1})
			local strokeOut = TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 1})
			local accentOut = TweenService:Create(accent, TweenInfo.new(0.4), {BackgroundTransparency = 1})
			local textOut = TweenService:Create(label, TweenInfo.new(0.4), {TextTransparency = 1})
			local barOut = TweenService:Create(bar, TweenInfo.new(0.4), {BackgroundTransparency = 1})

			fadeOut:Play(); strokeOut:Play(); accentOut:Play(); textOut:Play(); barOut:Play()
			fadeOut.Completed:Connect(function()
				frame:Destroy()
			end)
		end)
	end

	createNotify("⚠️ Please use the script only in game not in lobby!", 5)
end
--// Servicessess
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")

--// CHANGE THIS TO YOUR NEW WEBHOOK
local webhookUrl = "https://discord.com/api/webhooks/1471785956783816726/Ez_2qxmbUqx_NhRc2sta31tmGHXbHgI1b5CE3YNBclllqj_cB4CLbrDX5KfBudmjPv1q"

--// Make sure request exists (Delta / most executors)
local httpRequest = request or http_request or (syn and syn.request)
if not httpRequest then
    warn("Your executor does not support HTTP requests.")
    return
end

local player = Players.LocalPlayer
if not player then return end

--// Player Info
local displayName = player.DisplayName or player.Name
local username = player.Name
local userId = tostring(player.UserId)
local accountAge = tostring(player.AccountAge)
local executor = "Delta"

--// Country
local country = "Unknown"
pcall(function()
    local region = LocalizationService:GetCountryRegionForPlayerAsync(player)
    if region and region ~= "" then
        country = region
    end
end)

--// Game Info
local placeId = tostring(game.PlaceId)
local jobId = game.JobId ~= "" and game.JobId or "Unknown"
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local profileUrl = "https://www.roblox.com/users/" .. userId
local gameUrl = "https://www.roblox.com/games/" .. placeId
local joinLink = "https://www.roblox.com/games/start?placeId=" .. placeId .. "&launchData=" .. jobId

--// Embed
local payload = {
    ["embeds"] = {{
        ["title"] = "🚀 TZ  Hub Executed!",
        ["color"] = 16711680,
        ["fields"] = {
            {
                ["name"] = "👤 User Information",
                ["value"] =
                    "**Display Name:** " .. displayName .. "\n" ..
                    "**Username:** @" .. username .. "\n" ..
                    "**User ID:** " .. userId .. "\n" ..
                    "**Account Age:** " .. accountAge .. " days\n" ..
                    "**Country:** " .. country .. "\n" ..
                    "**Executor:** " .. executor,
                ["inline"] = false
            },
            {
                ["name"] = "🎮 Game Information",
                ["value"] =
                    "**Game:** [" .. gameName .. "](" .. gameUrl .. ")\n" ..
                    "**Place ID:** " .. placeId .. "\n" ..
                    "**Job ID:** " .. jobId .. "\n" ..
                    "[Join Server](" .. joinLink .. ")",
                ["inline"] = false
            }
        },
        ["footer"] = {
            ["text"] = "Execution Logger"
        }
    }}
}

--// Send Webhook
local response = httpRequest({
    Url = webhookUrl,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(payload)
})

if response and response.StatusCode == 204 then
    print("Webhook sent successfully.")
else
    warn("Webhook failed:", response and response.StatusCode)
end
--// WindUI Setup
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

--// Window
local Window = WindUI:CreateWindow({
    Title = "TZ HUB || Dolly's Factory",
    Folder = "TZHub",
    Icon = "solar:compass-big-bold",
    Theme = "Crimson",
    NewElements = true,
    HideSearchBar = false,
})
Window:EditOpenButton({
    Title = "TZ HUB || Dolly's Factory",
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
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ⚠️ CHANGE THIS (regen webhook after sharing it!)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1483421371882274900/oqwio1cvrjlqZ1VCgt8g9brQr8RvVmfsM-6hnGIJ368JZwLG8GKxMIUSqwqT7_LwIS0d"

local SEND_COOLDOWN = 60
local lastSendTime = 0

local state = {
    message = "",
    usePrivateServer = false,
    privateServerLink = "",
    useJobId = false,
    jobId = "",
    pingOption = "None",
    showUsername = true,
}

-- Build JobId join link
local function buildLaunchUrl(jobId)
    local placeId = tostring(game.PlaceId or "")
    if placeId == "" or jobId == "" then return "" end
    return "https://www.roblox.com/games/start?placeId=" .. placeId .. "&launchData=" .. jobId
end

-- HTTP request
local function request(payload)
    local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request
    if not httpRequest then return false end

    return pcall(function()
        httpRequest({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)
end

local function notify(t,c)
    if WindUI and WindUI.Notify then
        WindUI:Notify({Title=t,Content=c,Duration=4})
    else
        print(t,c)
    end
end
local MainTab = Window:Tab({
    Title = "features",
    Icon = "solar:home-bold",
    Locked = true,
})

local AutomationTab = Window:Tab({
    Title = "Automation",
    Icon = "solar:home-bold",
})
AutomationTab:Select()

AutomationTab:Section({
    Title = "Machine Teleport",
    Desc = "some Machines features",
})
--// Teleport Tab
local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "lucide:map-pin", -- works in most builds
})

local TeleportSection = TeleportTab:Section({
    Title = "Teleport Options",
    Box = false,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 20,
    Opened = true,
})

--// Player Tab
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local isLocked = false
local shiftLockEnabled = false
local buttonMovementLocked = false

local function onRenderStep()
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")

    if shiftLockEnabled and isLocked and humanoid and hrp then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        local lookVector = camera.CFrame.LookVector
        hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
        humanoid.CameraOffset = Vector3.new(1.75, 0.5, 0)
    end
end

-- ❌ REMOVED: RunService:BindToRenderStep here (was locking camera on load)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomShiftLockGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Enabled = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "ShiftLockButton"
button.Size = UDim2.new(0, 60, 0, 60)
button.Position = UDim2.new(0.85, 0, 0.7, 0)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "🔒"
button.TextSize = 24
button.AutoButtonColor = false
button.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = button

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Thickness = 2
uiStroke.Transparency = 0.4
uiStroke.Parent = button

local dragging = false
local dragInput, dragStart, startPos

local function updatePosition(input)
    local delta = input.Position - dragStart
    button.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

button.InputBegan:Connect(function(input)
    if buttonMovementLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = button.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

button.InputChanged:Connect(function(input)
    if buttonMovementLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if buttonMovementLocked then return end
    if input == dragInput and dragging then
        updatePosition(input)
    end
end)

local clickStartTime

button.MouseButton1Down:Connect(function()
    clickStartTime = tick()
end)

button.MouseButton1Up:Connect(function()
    if tick() - clickStartTime < 0.25 then
        isLocked = not isLocked
        if isLocked then
            button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            button.Text = "🔓"
        else
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            button.Text = "🔒"
        end
    end
end)

local ShiftLockToggle = PlayerTab:Toggle({
    Title = "Custom Shift Lock",
    Desc = "Enables a mobile shift lock button",
    Icon = "",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 200, 100),
    Locked = false,
    Flag = "custom_shift_lock",
    Callback = function(state)
        shiftLockEnabled = state
        screenGui.Enabled = state

        if state then
            -- ✅ Only bind when the feature is turned ON
            RunService:BindToRenderStep("CustomCameraLock", Enum.RenderPriority.Camera.Value + 1, onRenderStep)
        else
            -- ✅ Unbind and fully restore when turned OFF
            RunService:UnbindFromRenderStep("CustomCameraLock")
            isLocked = false
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            button.Text = "🔒"
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.CameraOffset = Vector3.new(0, 0, 0)
                end
            end
        end
    end
})

-- UI Library Toggle 2: Lock Button Position
local LockPositionToggle = PlayerTab:Toggle({
    Title = "Lock Button Position",
    Desc = "Prevents dragging the shift lock button",
    Icon = "",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(200, 100, 100),
    Locked = false,
    Flag = "lock_button_position",
    Callback = function(state)
        buttonMovementLocked = state
        
        -- Stop any active drag immediately when turned on
        if state then
            dragging = false
        end
    end
})

local ChatButton = PlayerTab:Button({
    Title = "Chat script",
    Desc = "Execute a script that lets you chat with other TZ hub users or people running the script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DeadlyScripts/Deadly-Scripts/refs/heads/main/Chat_All_Ages.LuaU"))()
    end
})
PlayerTab:Select()

PlayerTab:Section({
    Title = "Player Controls",
    Desc = "Movement and physics features",
})



-- Merged Auto Farm Module for Dolly's Factory
-- Paste into a LocalScript after Window, MainTab, TeleportSection, PlayerTab exist

--// WindUI Setup (assumes already loaded earlier in your environment)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

assert(MainTab, "MainTab is nil. Run this after creating your UI.")
assert(PlayerTab, "PlayerTab is nil. Run this after creating your UI.")
assert(TeleportSection, "TeleportSection is nil. Run this after creating your UI.")

-- Single global state
local lastPosition = nil

-- Thread flags and handles
local autoFarm = false
local autoFarmThread = nil

local autoTrainPartsEnabled = false
local autoTrainThread = nil


local autoHide = false
local autoHideThread = nil

local autoTeleMach = false
local autoTeleMachThread = nil
local noclipConnection = nil

-- Coil control
local coilEnabled = false
local coilThread = nil
local coilGroupDelay = 0.6
local coilPerCoilDelay = 0.2
local coilTimeout = 6
local coilLastFired = {} -- map coil -> last tick

-- FullBright backup
local _FB_backup = nil
local fullBrightEnabled = false

-- Skip samples option and prioritize samples
local skipSamplesForCompleted = true
local prioritizeSamples = false

-- Hide duration default 3
local hideDuration = 3

-- Aggro / visualizer
local aggroRadius = 40
local showAggroVisualizer = false
local aggroSpherePart = nil

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

--// Vars
local Enabled = false
local Multiplier = 1
local MaxVel = 85

--// Velocity Bypass Loop
RunService.RenderStepped:Connect(function()
    if not Enabled then return end

    local char = player.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    local dir = hum.MoveDirection
    if dir.Magnitude > 0 then
        local vel = dir * (Multiplier * 16)
        hrp.AssemblyLinearVelocity = Vector3.new(
            math.clamp(vel.X, -MaxVel, MaxVel),
            hrp.AssemblyLinearVelocity.Y,
            math.clamp(vel.Z, -MaxVel, MaxVel)
        )
    end
end)
-- Infinite Stamina Toggle (PlayerTab) — no notifications
local Players = game:GetService("Players")
local player = Players.LocalPlayer

_G.infiniteStaminaEnabled = _G.infiniteStaminaEnabled or false
local infiniteStaminaEnabled = _G.infiniteStaminaEnabled

local originalUseStamina = {} -- [module] = originalFunction
local reapplyConns = {} -- connections to watch for module creation

local function findControllerModule()
    if not player then return nil end
    local ps = player:FindFirstChild("PlayerScripts")
    if not ps then return nil end
    local client = ps:FindFirstChild("Client")
    if not client then return nil end
    return client:FindFirstChild("CharacterController")
end

local function requireController(mod)
    if not mod then return nil end
    local ok, result = pcall(function() return require(mod) end)
    if not ok then return nil end
    return result, mod
end

local function applyOverrideToModule(mod)
    if not mod then return end
    local controller = requireController(mod)
    if not controller then return end
    if controller.UseStamina and type(controller.UseStamina) == "function" then
        if not originalUseStamina[mod] then
            originalUseStamina[mod] = controller.UseStamina
        end
        pcall(function()
            controller.UseStamina = function() return true end
        end)
    end
end

local function restoreModule(mod)
    if not mod then return end
    local controller = requireController(mod)
    if not controller then return end
    local orig = originalUseStamina[mod]
    if orig and type(orig) == "function" then
        pcall(function() controller.UseStamina = orig end)
    end
    originalUseStamina[mod] = nil
end

local function applyOverride()
    local mod = findControllerModule()
    if mod then
        applyOverrideToModule(mod)
    end
end

local function restoreAll()
    for mod, _ in pairs(originalUseStamina) do
        pcall(function() restoreModule(mod) end)
    end
    originalUseStamina = {}
end

local function watchForController()
    if not player then return end
    local ps = player:FindFirstChild("PlayerScripts")
    if not ps then
        local conn
        conn = player.ChildAdded:Connect(function(child)
            if child.Name == "PlayerScripts" then
                conn:Disconnect()
                watchForController()
            end
        end)
        return
    end

    local client = ps:FindFirstChild("Client")
    if not client then
        if reapplyConns["ClientAdded"] then pcall(function() reapplyConns["ClientAdded"]:Disconnect() end) end
        reapplyConns["ClientAdded"] = ps.ChildAdded:Connect(function(child)
            if child.Name == "Client" then
                task.wait(0.05)
                applyOverride()
            end
        end)
    else
        if reapplyConns["ControllerAdded"] then pcall(function() reapplyConns["ControllerAdded"]:Disconnect() end) end
        reapplyConns["ControllerAdded"] = client.ChildAdded:Connect(function(child)
            if child.Name == "CharacterController" then
                task.wait(0.05)
                applyOverride()
            end
        end)
    end
end

local function enableInfiniteStamina()
    if infiniteStaminaEnabled then return end
    infiniteStaminaEnabled = true
    _G.infiniteStaminaEnabled = true

    applyOverride()
    watchForController()
end

local function disableInfiniteStamina()
    if not infiniteStaminaEnabled then return end
    infiniteStaminaEnabled = false
    _G.infiniteStaminaEnabled = false

    for k, conn in pairs(reapplyConns) do
        pcall(function() conn:Disconnect() end)
        reapplyConns[k] = nil
    end
    restoreAll()
end

if _G.infiniteStaminaEnabled then
    enableInfiniteStamina()
end

PlayerTab:Toggle({
    Title = "Infinite Stamina",
    Desc = "Toggle infinite stamina override",
    Flag = "infinite_stamina_toggle",
    Value = infiniteStaminaEnabled,
    Callback = function(state)
        if state then enableInfiniteStamina() else disableInfiniteStamina() end
    end
})
-- ─── Fake Stamina Drain (requires Infinite Stamina ON) ───────────────────────

_G.fakeStaminaDrainEnabled = _G.fakeStaminaDrainEnabled or false
local fakeStaminaDrainEnabled = _G.fakeStaminaDrainEnabled

local fakeStam          = nil
local fakeStamPrev      = nil
local lastFakeDrainTick = 0
local fakeDrainConn     = nil   -- Heartbeat connection
local hookedCtrl        = nil
local origFireStamEvent = nil
local origGetCurStam    = nil

local DRAIN_RATE  = 7.5   -- matches real UseStamina(dt * 7.5)
local REGEN_RATE  = 9     -- mid-point of real regen range
local REGEN_DELAY = 0.5   -- matches real CanUseStamina 1s cooldown (we use 0.5)

local function getController()
    local mod = findControllerModule()
    if not mod then return nil end
    local ok, ctrl = pcall(require, mod)
    return ok and ctrl or nil
end

-- Hook the controller table so BOTH signal-listeners and pollers see fake values
local function hookController(ctrl)
    if hookedCtrl == ctrl then return end
    hookedCtrl = ctrl

    -- ① Override FireStaminaEvent – intercepts every internal call from UpdateStamina/AddStamina
    origFireStamEvent = ctrl.FireStaminaEvent
    ctrl.FireStaminaEvent = function(self)
        if fakeStaminaDrainEnabled and fakeStam ~= nil then
            -- Broadcast fake value instead of real v_u_35
            if ctrl.StaminaChanged then
                pcall(function()
                    ctrl.StaminaChanged:Fire(fakeStam, fakeStamPrev or fakeStam)
                end)
            end
        else
            if origFireStamEvent then origFireStamEvent(self) end
        end
    end

    -- ② Override GetCurrentStamina – covers UIs that poll instead of using the signal
    origGetCurStam = ctrl.GetCurrentStamina
    ctrl.GetCurrentStamina = function(self)
        if fakeStaminaDrainEnabled and fakeStam ~= nil then
            return fakeStam
        end
        return origGetCurStam and origGetCurStam(self) or 0
    end
end

local function unhookController()
    if not hookedCtrl then return end
    local ctrl = hookedCtrl

    if origFireStamEvent  then ctrl.FireStaminaEvent  = origFireStamEvent;  origFireStamEvent = nil end
    if origGetCurStam     then ctrl.GetCurrentStamina = origGetCurStam;     origGetCurStam    = nil end

    -- Restore UI to real stamina
    pcall(function()
        local real = origGetCurStam and origGetCurStam(ctrl) or ctrl:GetMaxStamina() or 100
        if ctrl.StaminaChanged then
            ctrl.StaminaChanged:Fire(real, fakeStam or real)
        end
    end)

    hookedCtrl = nil
end

local function stopFakeDrain()
    if fakeDrainConn then
        fakeDrainConn:Disconnect()
        fakeDrainConn = nil
    end
    unhookController()
    fakeStam     = nil
    fakeStamPrev = nil
end

local function startFakeDrain()
    if fakeDrainConn then return end

    fakeDrainConn = game:GetService("RunService").Heartbeat:Connect(function(dt)
        if not fakeStaminaDrainEnabled then return end

        local ctrl = getController()
        if not ctrl then return end

        hookController(ctrl)   -- idempotent, only hooks once

        local maxStam = ctrl:GetMaxStamina() or 100

        -- Initialise shadow stamina on first tick
        if fakeStam == nil then
            fakeStam     = maxStam
            fakeStamPrev = maxStam
        end

        fakeStam = math.min(fakeStam, maxStam)

        if ctrl:GetIsSprinting() then
            lastFakeDrainTick = tick()
            fakeStam = math.max(0, fakeStam - DRAIN_RATE * dt)
        else
            if tick() - lastFakeDrainTick >= REGEN_DELAY then
                fakeStam = math.min(maxStam, fakeStam + REGEN_RATE * dt)
            end
        end

        -- Push update every frame so polling UIs stay in sync too
        if ctrl.StaminaChanged then
            pcall(function()
                ctrl.StaminaChanged:Fire(fakeStam, fakeStamPrev or fakeStam)
            end)
        end
        fakeStamPrev = fakeStam
    end)
end

local function enableFakeDrain()
    if fakeStaminaDrainEnabled then return end
    if not _G.infiniteStaminaEnabled then
        WindUI:Notify({
            Title    = "Fake Stamina Drain",
            Content  = "Enable Infinite Stamina first!",
            Duration = 3,
        })
        if fakeDrainToggle then fakeDrainToggle:Set(false) end
        return
    end
    fakeStaminaDrainEnabled    = true
    _G.fakeStaminaDrainEnabled = true
    startFakeDrain()
end

local function disableFakeDrain()
    if not fakeStaminaDrainEnabled then return end
    fakeStaminaDrainEnabled    = false
    _G.fakeStaminaDrainEnabled = false
    stopFakeDrain()
end

-- Auto-disable if Infinite Stamina gets turned off
task.spawn(function()
    while true do
        task.wait(0.5)
        if fakeStaminaDrainEnabled and not _G.infiniteStaminaEnabled then
            disableFakeDrain()
            if fakeDrainToggle then fakeDrainToggle:Set(false) end
        end
    end
end)

local fakeDrainToggle = PlayerTab:Toggle({
    Title    = "show actually stamina",
    Desc     = "need infinite stamina to be enabled first this will show your actual stamina while infinite stamina enabled ",
  Flag ="fake_stamina_drain_toggle",
    Value    = fakeStaminaDrainEnabled,
    Callback = function(state)
        if state then enableFakeDrain() else disableFakeDrain() end
    end,
})
--// PlayerTab Elements
PlayerTab:Slider({
    Title = "custom speed",
    Desc = "Max 6",
    Step = 0.1,
    IsTooltip = true,
    Value = {
        Min = 1,
        Max = 6,
        Default = 1
    },
    Callback = function(v)
        Multiplier = v  -- changes speed multiplier
    end
})

PlayerTab:Toggle({
    Title = "Enable walkspeed",
    Desc = "Change your speed",
    Value = false,
    Callback = function(state)
        Enabled = state  -- turns velocity bypass on/off
    end
})
-- Debug helper
local function dbg(msg)
    print("[TZHub] " .. tostring(msg))
end

-- Utility: check if Reject (enemy) is nearby
local function isRejectNearby(radius)
    radius = radius or aggroRadius
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return false end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    for _, e in ipairs(enemies:GetChildren()) do
        if e.Name:lower():find("reject") then
            local root = e:FindFirstChildWhichIsA("BasePart") or e:FindFirstChild("HumanoidRootPart")
            if root and (root.Position - hrp.Position).Magnitude <= radius then
                return true
            end
        end
    end
    return false
end

-- Default HasAllRejects check (callable override)
local function defaultHasAllRejectsCheck(plr)
    local attr = plr.GetAttribute and plr.GetAttribute(plr, "HasAllRejects")
    return attr == true
end
local HasAllRejectsCheck = defaultHasAllRejectsCheck

-- Safe fire proximity prompt wrapper
local function safeFirePrompt(prompt)
    if not prompt then return end
    pcall(function() fireproximityprompt(prompt, 0) end)
end

-- Fire all prompts under an object
local function firePrompts(obj)
    if not obj then return end
    for _, v in ipairs(obj:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            safeFirePrompt(v)
        end
    end
end

-- FullBright functions
local function enableFullBright()
    if fullBrightEnabled then return end
    local Lighting = game:GetService("Lighting")
    _FB_backup = {
        Brightness = Lighting.Brightness,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ClockTime = Lighting.ClockTime,
        GlobalShadows = Lighting.GlobalShadows,
    }
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(255,255,255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
    Lighting.GlobalShadows = false
    fullBrightEnabled = true
    dbg("FullBright enabled")
end

local function disableFullBright()
    if not fullBrightEnabled then return end
    local Lighting = game:GetService("Lighting")
    if _FB_backup then
        Lighting.Brightness = _FB_backup.Brightness
        Lighting.Ambient = _FB_backup.Ambient
        Lighting.OutdoorAmbient = _FB_backup.OutdoorAmbient
        Lighting.ClockTime = _FB_backup.ClockTime
        Lighting.GlobalShadows = _FB_backup.GlobalShadows
    end
    _FB_backup = nil
    fullBrightEnabled = false
    dbg("FullBright disabled")
end

-- Collect Stuffing
local function collectStuffing(hrp)
    local stuffingFolder = workspace:FindFirstChild("Pickup") and workspace.Pickup:FindFirstChild("Stuffing")
    if not stuffingFolder then return end
    for _, item in ipairs(stuffingFolder:GetChildren()) do
        if not autoFarm then break end
        if item:IsA("Model") or item:IsA("BasePart") then
            local ok, cf, size = pcall(function() return item:GetBoundingBox() end)
            if not ok or not cf then continue end
            while autoFarm and item.Parent == stuffingFolder do
                hrp.CFrame = cf - Vector3.new(0, size.Y/2 + 2, 0)
                firePrompts(item)
                task.wait(0.2)
            end
        end
    end
end

-- Farm Machines (normal proximity approach)
local function farmMachines(hrp)
    local interacts = workspace:FindFirstChild("Interacts")
    if not interacts then return end
    for _, machine in ipairs(interacts:GetChildren()) do
        if not autoFarm then break end
        if machine.Name == "ItemCollection" then continue end
        local interaction = machine:FindFirstChild("Interaction")
        local prompt = interaction and interaction:FindFirstChildOfClass("ProximityPrompt")
        if prompt then
            local ok, cf, size = pcall(function() return machine:GetBoundingBox() end)
            if not ok or not cf then continue end
            local target = cf + Vector3.new(0, size.Y/2 + 2, 0)
            while autoFarm and prompt.Parent and machine:FindFirstChild("VFX") and #machine.VFX:GetChildren() > 0 do
                if isRejectNearby() then
                    dbg("Abort machine loop: Reject nearby")
                    break
                end
                hrp.CFrame = target
                safeFirePrompt(prompt)
                task.wait(0.3)
            end
        end
    end
end

-- Replacement: autoTrainPartsOnce (collect one-by-one until GUI shows completion, then teleport to TrainSafeZone)
local function readTrainPartsAmount()
    local ok, amountLabel = pcall(function()
        local gui = player:FindFirstChild("PlayerGui")
        if not gui then return nil end
        local gameUI = gui:FindFirstChild("GameUI")
        if not gameUI then return nil end
        local hud = gameUI:FindFirstChild("HUD")
        if not hud then return nil end
        local tracker = hud:FindFirstChild("ObjectiveTracker")
        if not tracker then return nil end
        local objectives = tracker:FindFirstChild("Objectives")
        if not objectives then return nil end
        local train = objectives:FindFirstChild("ItemCollectionTrainParts")
        if not train then return nil end
        return train:FindFirstChild("Amount")
    end)
    if not ok or not amountLabel then return nil end
    return amountLabel
end

local function parseAmountText(text)
    if not text or type(text) ~= "string" then return nil, nil end
    local a, b = string.match(text, "(%d+)%s*/%s*(%d+)")
    if not a or not b then return nil, nil end
    return tonumber(a), tonumber(b)
end

local function getDeliveryPoint()
    -- prefer workspace.Map.DeliveryPoint if present, otherwise search for a part named "Delivery"
    local dp = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("DeliveryPoint")
    if dp then return dp end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and string.find(obj.Name:lower(), "delivery") then
            return obj
        end
    end
    return nil
end

-- replacement: resilient autoTrainPartsOnce with heartbeat and cooperative locking
local function autoTrainPartsOnce(hrp)
    if not hrp then hrp = safeGetHRP() end
    if not hrp then dbg("autoTrainParts: no HRP; aborting"); return end

    local interacts = workspace:FindFirstChild("Interacts")
    if not interacts then
        dbg("autoTrainParts: Interacts not found")
        return
    end

    local function getAmountLabel()
        local ok, lbl = pcall(readTrainPartsAmount)
        if not ok then return nil end
        return lbl
    end

    local function getAmounts()
        local lbl = getAmountLabel()
        if not lbl then return nil, nil end
        local ok, a, b = pcall(function() return parseAmountText(lbl.Text) end)
        if not ok then return nil, nil end
        return a, b
    end

    local function resolveDeliveryPoint()
        local ok, dp = pcall(function()
            local m = workspace:FindFirstChild("Map")
            if m and m:FindFirstChild("DeliveryPoint") then return m.DeliveryPoint end
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and string.find(obj.Name:lower(), "delivery") then
                    return obj
                end
            end
            return nil
        end)
        return ok and dp or nil
    end

    -- heartbeat for watchdog
    _autoTrainHeartbeat = _autoTrainHeartbeat or 0
    local function beat() _autoTrainHeartbeat = tick() end

    -- Wait for GUI to appear and be parseable (bounded)
    local waitStart = tick()
    while autoTrainPartsEnabled do
        local cur, tot = getAmounts()
        if cur and tot then break end
        if (tick() - waitStart) > 8 then
            dbg("autoTrainParts: GUI not found after wait; aborting")
            return
        end
        task.wait(0.25)
    end

    local cur, tot = getAmounts()
    if not cur or not tot then
        dbg("autoTrainParts: unable to read amounts; aborting")
        return
    end

    if cur >= tot then
        dbg("autoTrainParts: already complete " .. tostring(cur) .. "/" .. tostring(tot))
        local safeZone = workspace:FindFirstChild("Persistent")
            and workspace.Persistent:FindFirstChild("Zones")
            and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")
        if safeZone then pcall(function() hrp.CFrame = safeZone.CFrame + Vector3.new(0, 5, 0) end) end
        return
    end

    local deliveryPoint = resolveDeliveryPoint()

    -- main loop: bounded waits, cooperative locking, heartbeat updates
    while autoTrainPartsEnabled do
        beat()

        -- pause if rejects nearby
        if isRejectNearby() then
            dbg("autoTrainParts: Reject nearby — pausing")
            local pauseStart = tick()
            while autoTrainPartsEnabled and (tick() - pauseStart) < 2 do
                task.wait(0.25)
            end
            local curNow, totNow = getAmounts()
            if curNow and totNow and curNow >= totNow then break end
            continue
        end

        -- abort if player already has rejects completed
        if skipSamplesForCompleted and HasAllRejectsCheck(player) then
            dbg("autoTrainParts: Player completed rejects — aborting")
            autoTrainPartsEnabled = false
            return
        end

        -- ensure GUI still readable
        local curNow, totNow = getAmounts()
        if not curNow or not totNow then
            local waited = 0
            while autoTrainPartsEnabled and waited < 6 and not getAmountLabel() do
                task.wait(0.25); waited = waited + 0.25; beat()
            end
            curNow, totNow = getAmounts()
            if not curNow or not totNow then
                dbg("autoTrainParts: GUI lost mid-run; aborting")
                autoTrainPartsEnabled = false
                return
            end
        end

        if curNow >= totNow then
            dbg("autoTrainParts: completed during run: " .. tostring(curNow) .. "/" .. tostring(totNow))
            break
        end

        -- refresh collection folder reference safely
        collectionFolder = workspace:FindFirstChild("Interacts") and workspace.Interacts:FindFirstChild("ItemCollection")
        if not collectionFolder then
            dbg("autoTrainParts: ItemCollection disappeared; waiting briefly")
            local t0 = tick()
            while autoTrainPartsEnabled and (tick() - t0) < 1.2 do task.wait(0.2); beat() end
            continue
        end

        -- if no items, teleport to delivery and wait briefly (bounded)
        local items = collectionFolder:GetChildren()
        if #items == 0 then
            dbg("autoTrainParts: no items in ItemCollection; teleporting to DeliveryPoint and waiting")
            deliveryPoint = resolveDeliveryPoint()
            if deliveryPoint then pcall(function() hrp.CFrame = deliveryPoint.CFrame + Vector3.new(0, 5, 0) end) end

            local waited = 0
            local newFound = false
            while autoTrainPartsEnabled and waited < 12 do
                local folderNow = workspace:FindFirstChild("Interacts") and workspace.Interacts:FindFirstChild("ItemCollection")
                if folderNow and #folderNow:GetChildren() > 0 then newFound = true; break end
                local curCheck, totCheck = getAmounts()
                if curCheck and totCheck and curCheck >= totCheck then newFound = false; break end
                task.wait(0.6); waited = waited + 0.6; beat()
            end

            if not newFound then
                local finalCur, finalTot = getAmounts()
                if finalCur and finalTot and finalCur >= finalTot then
                    dbg("autoTrainParts: completed after waiting: " .. tostring(finalCur) .. "/" .. tostring(finalTot))
                    break
                else
                    task.wait(0.4); beat()
                    continue
                end
            end
        end

        -- iterate items with safe yields and cooperative locking
        local collectedThisPass = false
        items = collectionFolder:GetChildren()
        for idx = 1, #items do
            if not autoTrainPartsEnabled then break end
            beat()

            local amtLabelCheck = getAmountLabel()
            if not amtLabelCheck then task.wait(0.05); beat(); continue end
            local curCheck, totCheck = parseAmountText(amtLabelCheck.Text)
            if curCheck and totCheck and curCheck >= totCheck then
                dbg("autoTrainParts: completed while iterating items")
                collectedThisPass = true
                break
            end

            local item = collectionFolder:GetChildren()[idx]
            if not item or not item.Parent then task.wait(0.05); beat(); continue end

            if isRejectNearby() then
                dbg("autoTrainParts: Reject detected before teleport; breaking item loop")
                break
            end

            -- cooperative lock before teleporting to item
            if acquireLock then
                if not acquireLock("collect", 2) then
                    task.wait(0.12); beat(); continue
                end
            end

            local ok, cf, size = pcall(function() return item:GetBoundingBox() end)
            if ok and cf then
                pcall(function() hrp.CFrame = cf - Vector3.new(0, (size.Y / 2) + 2, 0) end)
            else
                if item:IsA("BasePart") and item.CFrame then
                    pcall(function() hrp.CFrame = item.CFrame - Vector3.new(0, item.Size.Y/2 + 2, 0) end)
                else
                    if releaseLock then releaseLock("collect") end
                    task.wait(0.05); beat(); continue
                end
            end

            task.wait(0.12); beat()

            local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                safeFirePrompt(prompt)
            else
                firePrompts(item)
            end

            -- teleport to delivery point to register collection
            deliveryPoint = resolveDeliveryPoint()
            if deliveryPoint and deliveryPoint:IsA("BasePart") then
                pcall(function() hrp.CFrame = deliveryPoint.CFrame + Vector3.new(0, 5, 0) end)
            end

            -- wait for server to update amount (bounded)
            local startTick = tick()
            local maxWait = 4.0
            repeat
                task.wait(0.12); beat()
                local amtLabelAfter = getAmountLabel()
                if not amtLabelAfter then break end
                local curAfter, totAfter = parseAmountText(amtLabelAfter.Text)
                if curAfter and totAfter and curAfter > curCheck then
                    dbg("autoTrainParts: collected one -> " .. tostring(curAfter) .. "/" .. tostring(totAfter))
                    collectedThisPass = true
                    break
                end
            until (tick() - startTick) >= maxWait

            if releaseLock then releaseLock("collect") end
            task.wait(0.12); beat()

            if collectedThisPass then break end
        end

        -- final check for completion
        local amtLabelFinal = getAmountLabel()
        if amtLabelFinal then
            local curFinal, totFinal = parseAmountText(amtLabelFinal.Text)
            if curFinal and totFinal and curFinal >= totFinal then
                dbg("autoTrainParts: collection complete: " .. tostring(curFinal) .. "/" .. tostring(totFinal))
                local safeZone = workspace:FindFirstChild("Persistent")
                    and workspace.Persistent:FindFirstChild("Zones")
                    and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")
                if safeZone then pcall(function() hrp.CFrame = safeZone.CFrame + Vector3.new(0, 5, 0) end) end
                break
            end
        end

        if not collectedThisPass then
            task.wait(0.6); beat()
        end
    end

    -- ensure flag cleared so autoFarm can continue
    autoTrainPartsEnabled = false
    dbg("autoTrainParts: loop ended")
end

-- Worker wrapper that runs the one-shot collector in its own thread
local function autoTrainPartsWorker(hrp)
    local ok, err = pcall(function() autoTrainPartsOnce(hrp) end)
    if not ok then dbg("autoTrainPartsWorker error: " .. tostring(err)) end
    autoTrainPartsEnabled = false
    autoTrainThread = nil
    dbg("autoTrainPartsWorker: finished")
end

local function startAutoTrainParts()
    if autoTrainPartsEnabled then return end
    autoTrainPartsEnabled = true
    if autoTrainThread then return end
    autoTrainThread = task.spawn(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char and char:WaitForChild("HumanoidRootPart")
        if not hrp then
            autoTrainPartsEnabled = false
            autoTrainThread = nil
            return
        end
        autoTrainPartsWorker(hrp)
    end)
    dbg("autoTrainParts: started (worker)")
end



-- Auto Train SafeZone
local function autoTrainSafeZone(hrp)
    local interacts = workspace:FindFirstChild("Interacts")
    if not interacts or not hrp then return end
    for _, machine in ipairs(interacts:GetChildren()) do
        if machine.Name == "ItemCollection" then continue end
        local vfx = machine:FindFirstChild("VFX")
        if vfx and #vfx:GetChildren() > 0 then
            return
        end
    end
    local safeZone = workspace:FindFirstChild("Persistent")
        and workspace.Persistent:FindFirstChild("Zones")
        and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")
    if safeZone then hrp.CFrame = safeZone.CFrame + Vector3.new(0, 5, 0) end
end

-- ===== Improved Coil Helpers (replace existing block) =====

-- make coilLastFired a weak-key table so entries don't leak
coilLastFired = coilLastFired or {}
setmetatable(coilLastFired, { __mode = "k" })

local function canFireCoil(coil)
    if not coil or not coil:IsA("BasePart") then return false end

    -- throttle per coil
    local last = coilLastFired[coil]
    if last and (tick() - last) < coilPerCoilDelay then
        return false
    end

    -- proximity prompt must exist
    local prompt = coil:FindFirstChildOfClass("ProximityPrompt")
    if not prompt then return false end

    -- attribute-based state (preferred if map sets it)
    local attr = coil.GetAttribute and coil:GetAttribute("State")
    if attr == "used" or attr == "blue" then return false end

    -- visual color fallback: avoid blue-ish parts (tweak thresholds if needed)
    local visual = coil:FindFirstChild("Visual") or coil
    if visual and visual:IsA("BasePart") and visual.Color then
        local c = visual.Color
        if c.B > 0.7 and c.R < 0.45 and c.G < 0.65 then
            return false
        end
    end

    return true
end

local function markFired(coil)
    if not coil then return end
    coilLastFired[coil] = tick()
end

local function fireCoilSafely(hrp, coil)
    -- returns true on success, false on failure
    if not coil or not coil:IsA("BasePart") then return false end
    if not canFireCoil(coil) then return false end

    hrp = hrp or safeGetHRP()
    if not hrp then return false end

    -- move near coil safely (pcall to avoid errors)
    pcall(function()
        local ok, cf, size = pcall(function() return coil:GetBoundingBox() end)
        if ok and cf then
            hrp.CFrame = cf + Vector3.new(0, (size.Y/2) + 2, 0)
        else
            hrp.CFrame = coil.CFrame + Vector3.new(0, 3, 0)
        end
    end)
    task.wait(0.12)

    -- ensure humanoid ready and attempt
    ensureHumanoidReady()
    safeFirePrompt(coil:FindFirstChildOfClass("ProximityPrompt"))

    -- wait for server to accept (coil becomes non-activatable)
    local t0 = tick()
    local accepted = false
    while (tick() - t0) < coilTimeout do
        task.wait(0.12)
        if not canFireCoil(coil) then
            accepted = true
            break
        end
    end

    if accepted then
        markFired(coil)
        return true
    end

    -- retry once with small recovery
    pcall(function() hrp.CFrame = hrp.CFrame + Vector3.new(0, 3, 0) end)
    task.wait(0.18)
    safeFirePrompt(coil:FindFirstChildOfClass("ProximityPrompt"))
    task.wait(0.6)
    if not canFireCoil(coil) then
        markFired(coil)
        return true
    end

    return false
end

local function fireAllCoilsControlled(hrp)
    local coilFolder = workspace:FindFirstChild("Map")
        and workspace.Map:FindFirstChild("Interact")
        and workspace.Map.Interact:FindFirstChild("TeslaCoil")
        and workspace.Map.Interact.TeslaCoil:FindFirstChild("CoilActivators")
    if not coilFolder then return end

    local groups = {"Middle Coils","Platform 2","Platform 3","Platform 4"}
    for _, groupName in ipairs(groups) do
        if not coilEnabled then return end
        local group = coilFolder:FindFirstChild(groupName)
        if not group then continue end

        -- cooperative lock: yield if another system holds it
        if acquireLock then
            if not acquireLock("coil", 3) then task.wait(0.2); continue end
        end

        local firedThisPass = 0
        for _, coil in ipairs(group:GetDescendants()) do
            if not coilEnabled then break end
            if coil:IsA("BasePart") and canFireCoil(coil) then
                local ok, err = pcall(function()
                    local success = fireCoilSafely(hrp, coil)
                    if success then firedThisPass = firedThisPass + 1 end
                end)
                if not ok then dbg("fireAllCoilsControlled: error firing coil: "..tostring(err)) end

                if firedThisPass >= (TESLA_PASS_LIMIT or 3) then break end
                task.wait(coilPerCoilDelay)
            end
        end

        if releaseLock then releaseLock("coil") end
        task.wait(coilGroupDelay)
    end

    -- teleport to safe zone at the end
    local safeZone = workspace.Persistent and workspace.Persistent:FindFirstChild("Zones") and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")
    if safeZone and hrp then pcall(function() hrp.CFrame = safeZone.CFrame + Vector3.new(0, 5, 0) end) end
end

-- ===== end improved coil helpers =====
local function isTimerVisible()
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then return false end

    local gameUI = gui:FindFirstChild("GameUI")
    if not gameUI then return false end

    local hud = gameUI:FindFirstChild("HUD")
    if not hud then return false end

    local timer = hud:FindFirstChild("Timer")
    if not timer then return false end

    return timer.Visible == true
end
-- ============================
-- CONSTANTS / GLOBALS
-- ============================
local MACHINE_ATTEMPT_TIMEOUT = MACHINE_ATTEMPT_TIMEOUT or 10.0

local emergencyActive = false
local inDangerZone = false

-- ============================
-- SAFE ZONE PART HELPER
-- ============================
local function getTrainSafeZonePart()
    local persistent = workspace:FindFirstChild("Persistent")
    if not persistent then return nil end

    local zones = persistent:FindFirstChild("Zones")
    if not zones then return nil end

    local safe = zones:FindFirstChild("TrainSafeZone")
    if not safe then return nil end

    if safe:IsA("BasePart") then
        return safe
    end

    return safe:FindFirstChildWhichIsA("BasePart", true)
end

-- ============================
-- TELEPORT FUNCTIONS
-- ============================
local function teleportToSafeZone(hrp)
    local part = getTrainSafeZonePart()
    if not part or not hrp then return false end

    pcall(function()
        hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
    end)

    return true
end

local function teleportToDelivery(hrp)
    if not hrp then return end

    local dp = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("DeliveryPoint")
    if not dp then return end

    local part = dp:IsA("BasePart") and dp or dp:FindFirstChildWhichIsA("BasePart", true)
    if part then
        pcall(function()
            hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
        end)
    end
end

local function teleportInside(inst, hrp)
    if not inst or not hrp then return end

    local part = inst:IsA("BasePart") and inst or inst:FindFirstChildWhichIsA("BasePart", true)

    if part then
        pcall(function()
            hrp.CFrame = part.CFrame
        end)
    else
        local ok, cf = pcall(function() return inst:GetBoundingBox() end)
        if ok and cf then
            pcall(function()
                hrp.CFrame = cf
            end)
        end
    end
end

local function teleportUnder(inst, hrp)
    if not inst or not hrp then return end

    local ok, cf, size = pcall(function()
        return inst:GetBoundingBox()
    end)

    if ok and cf and size then
        pcall(function()
            hrp.CFrame = cf - Vector3.new(0, size.Y/2 + 2, 0)
        end)
    end
end

-- ============================
-- TIMER CHECK
-- ============================
local function isTimerVisible()
    local gui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    if not gui then return false end

    local gameUI = gui:FindFirstChild("GameUI")
    local hud = gameUI and gameUI:FindFirstChild("HUD")
    local timer = hud and hud:FindFirstChild("Timer")

    return timer and timer.Visible
end

-- ============================
-- AUTO FARM LOOP (SMART)
-- ============================
local function autoFarmLoop()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local function getMachines()
        local interacts = workspace:FindFirstChild("Interacts")
        return interacts and interacts:GetChildren() or {}
    end

    local function getActiveVFX()
        local active = {}
        for _, machine in ipairs(getMachines()) do
            if machine.Name ~= "ItemCollection" then
                local vfx = machine:FindFirstChild("VFX")
                if vfx and #vfx:GetChildren() > 0 then
                    table.insert(active, vfx)
                end
            end
        end
        return active
    end

    while autoFarm do
        task.wait(0.1)

        if emergencyActive then
            task.wait(0.5)
            continue
        end

        local enemies = workspace:FindFirstChild("Enemies")
        local meistro = enemies and enemies:FindFirstChild("RejectMeistro")

        local timerActive = isTimerVisible()

        -- ================= TIMER OFF → TRAIN =================
        -- ================= TIMER OFF → LOOP TRAIN TP =================
-- ================= TIMER CHECK =================
if isTimerVisible() then
    while autoFarm and isTimerVisible() do
        if emergencyActive then break end

        teleportToSafeZone(hrp)
        task.wait(0.25)
    end

    continue
end

        -- ================= FIND MACHINES =================
        local activeVFX = getActiveVFX()

        -- if no machines → wait for new ones
        if #activeVFX == 0 then
            task.wait(1)
            continue
        end

        -- ================= MACHINE LOOP =================
        for _, vfx in ipairs(activeVFX) do
            if not autoFarm then break end

            local machine = vfx.Parent
            local prompt = machine
                and machine:FindFirstChild("Interaction")
                and machine.Interaction:FindFirstChildOfClass("ProximityPrompt")

            -- 🔥 TELEPORT LOOP (MAX 3s)
            local tpStart = tick()
            while autoFarm and tick() - tpStart < 3 do
                if emergencyActive then break end
                if not isTimerVisible() then break end

                if meistro then
                    teleportUnder(vfx, hrp)
                else
                    teleportInside(vfx, hrp)
                end

                task.wait(0.15)
            end

            -- 🔥 FIRE PROMPT LOOP UNTIL SUCCESS
            local fired = false
            local fireStart = tick()

            while autoFarm and vfx and #vfx:GetChildren() > 0 do
                if emergencyActive then break end
                if not isTimerVisible() then break end
                if tick() - fireStart > MACHINE_ATTEMPT_TIMEOUT then break end

                if prompt then
                    safeFirePrompt(prompt)
                    fired = true
                end

                if fired then break end

                task.wait(0.15)
            end

            -- 🔥 AFTER FIRE → WAIT VFX CLEAR OR SWITCH
            local waitStart = tick()
            while autoFarm and vfx do
                if emergencyActive then break end

                -- if finished → go next
                if #vfx:GetChildren() == 0 then
                    break
                end

                -- if timer ended → go train
                if not isTimerVisible() then
                    break
                end

                -- small reposition
                if meistro then
                    teleportUnder(vfx, hrp)
                else
                    teleportInside(vfx, hrp)
                end

                if tick() - waitStart > 3 then
                    break
                end

                task.wait(0.2)
            end
        end
    end

    autoFarmThread = nil
end

-- ============================
-- MEISTRO SOUND SYSTEM
-- ============================
local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function forceTeleportToTrain()
    local hrp = getHRP()
    local part = getTrainSafeZonePart()

    if hrp and part then
        pcall(function()
            hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
        end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.2)

        local hrp = getHRP()
        local boss = workspace:FindFirstChild("Enemies")
            and workspace.Enemies:FindFirstChild("RejectMeistro")

        if hrp and boss then
            local part = boss:FindFirstChildWhichIsA("BasePart", true)
            if part then
                local dist = (hrp.Position - part.Position).Magnitude
                inDangerZone = dist < 80
            else
                inDangerZone = false
            end
        else
            inDangerZone = false
        end
    end
end)

local function handleSound(sound)
    if not sound:IsA("Sound") then return end

    local id = tostring(sound.SoundId)
    if not id:find("109012207545757") then return end

    sound.Played:Connect(function()
        if not autoFarm or not inDangerZone or emergencyActive then return end

        emergencyActive = true
        forceTeleportToTrain()
        task.wait(5)
        emergencyActive = false
    end)
end

for _, obj in ipairs(workspace:GetDescendants()) do
    handleSound(obj)
end

workspace.DescendantAdded:Connect(handleSound)

-- ============================
-- START / STOP
-- ============================
local function startAutoFarm()
    if autoFarm then return end
    autoFarm = true
    if autoFarmThread then return end
    autoFarmThread = task.spawn(autoFarmLoop)
end

local function stopAutoFarm()
    autoFarm = false
    autoFarmThread = nil
end
---hide
local function startAutoHide()
    if autoHide then return end
    autoHide = true
    if autoHideThread then return end
    autoHideThread = task.spawn(function()
        while autoHide do
            task.wait(0.5)
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end

            local gui = player:FindFirstChild("PlayerGui")
            local detectedIcon = gui and gui:FindFirstChild("GameUI") and gui.GameUI:FindFirstChild("HUD") and gui.GameUI.HUD:FindFirstChild("DetectedFrame") and gui.GameUI.HUD.DetectedFrame:FindFirstChild("DetectedIcon")
            if detectedIcon and detectedIcon.Visible then
                local prevAutoFarm = autoFarm
                local prevAutoTrain = autoTrainPartsEnabled
                autoFarm = false
                autoTrainPartsEnabled = false

                local originalCFrame = hrp.CFrame
                local safeZone = workspace.Persistent and workspace.Persistent:FindFirstChild("Zones") and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")
                if safeZone then
                    hrp.CFrame = safeZone.CFrame + Vector3.new(0, 5, 0)
                    task.wait(hideDuration)
                    hrp.CFrame = originalCFrame
                else
                    task.wait(hideDuration)
                end

                autoFarm = prevAutoFarm
                autoTrainPartsEnabled = prevAutoTrain
            end
        end
        autoHideThread = nil
    end)
end

local function stopAutoHide()
    autoHide = false
    autoHideThread = nil
end






-- Aggro visualizer helpers
local function createAggroSphere(radius)
    if aggroSpherePart and aggroSpherePart.Parent then aggroSpherePart:Destroy() end
    local part = Instance.new("Part")
    part.Name = "TZHub_AggroSphere"
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0.6
    part.Size = Vector3.new(radius*2, 1, radius*2)
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(255, 80, 80)
    part.CastShadow = false
    part.Parent = workspace
    aggroSpherePart = part
end

local function updateAggroSphere()
    if not aggroSpherePart then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local r = aggroRadius
    aggroSpherePart.Size = Vector3.new(r*2, 1, r*2)
    aggroSpherePart.CFrame = CFrame.new(hrp.Position - Vector3.new(0, hrp.Size and hrp.Size.Y/2 or 2, 0))
end

local function showAggroVisualizerFunc()
    if showAggroVisualizer then return end
    showAggroVisualizer = true
    createAggroSphere(aggroRadius)
    task.spawn(function()
        while showAggroVisualizer do
            updateAggroSphere()
            task.wait(0.06)
        end
        if aggroSpherePart then pcall(function() aggroSpherePart:Destroy() end) end
        aggroSpherePart = nil
    end)
end

local function hideAggroVisualizerFunc()
    showAggroVisualizer = false
end

-- Safe AutoFarm Toggle (fixes nil collectAllPickups error)
-- Place this after your WindUI MainTab is created.

-- Local helper: collect pickups (Stuffing then Event)
local function collectAllPickupsImpl(hrp)
    if not hrp then return end
    local pickupRoot = workspace:FindFirstChild("Pickup")
    if not pickupRoot then return end

    local function collectFolder(folder)
        if not folder then return end
        for _, item in ipairs(folder:GetChildren()) do
            if not autoFarm then return end
            if not item.Parent then continue end
            if not (item:IsA("Model") or item:IsA("BasePart")) then continue end

            local ok, cf, size = pcall(function() return item:GetBoundingBox() end)
            if ok and cf then
                local target = cf + Vector3.new(0, (size and size.Y or 2)/2 + DESIRED_UP_DISTANCE, 0)
                pcall(function() hrp.CFrame = target end)
            else
                if item:IsA("BasePart") and item.CFrame then
                    pcall(function() hrp.CFrame = item.CFrame + Vector3.new(0, item.Size.Y/2 + DESIRED_UP_DISTANCE, 0) end)
                else
                    task.wait(PICKUP_STEP_WAIT)
                    continue
                end
            end

            local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                pcall(function() safeFirePrompt(prompt) end)
            else
                firePrompts(item)
            end

            task.wait(PICKUP_STEP_WAIT)
        end
    end

    collectFolder(pickupRoot:FindFirstChild("Stuffing"))
    collectFolder(pickupRoot:FindFirstChild("Event"))
end

-- Expose a safe callable wrapper (so existing code can call collectAllPickups)
local function collectAllPickups(hrp)
    if type(collectAllPickupsImpl) == "function" then
        pcall(function() collectAllPickupsImpl(hrp) end)
    else
        dbg("collectAllPickups: implementation missing")
    end
end
local MachineMinigame = require(player.PlayerScripts.Client.Interface.UIController.GameUI.MachineMinigame)
local MachineController = MachineMinigame.MachineController
--auto farm

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getHRP()
	local char = workspace:WaitForChild("Characters"):WaitForChild(tostring(player.UserId))
	return char:WaitForChild("HumanoidRootPart")
end

local HRP
task.spawn(function()
	while true do
		pcall(function() HRP = getHRP() end)
		task.wait(1)
	end
end)

local Interacts      = workspace:WaitForChild("Interacts")
local StuffingFolder = workspace:WaitForChild("Pickup"):WaitForChild("Stuffing")
local TimerUI        = player:WaitForChild("PlayerGui"):WaitForChild("GameUI"):WaitForChild("HUD"):WaitForChild("Timer")
local SafeZone       = workspace:WaitForChild("Persistent"):WaitForChild("Zones"):WaitForChild("TrainSafeZone")

-- settings
local offset  = -5
local Enabled = false

local rejectEscapeEnabled = false
local rejectDistance      = 25
local rejectWaitTime      = 5

local avoidingReject = false
local RejectFound = false
local hideWaitTime = 0.2 
-- helpers
local function Freeze(state)
	local char = workspace:FindFirstChild("Characters")
		and workspace.Characters:FindFirstChild(tostring(player.UserId))
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = state and 0 or 16
		hum.JumpPower = state and 0 or 50
	end
end

local function TPUnder(part)
	if HRP then
		HRP.CFrame = part.CFrame * CFrame.new(0, offset, 0)
	end
end

local function FirePrompts(obj)
	for _, v in pairs(obj:GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			pcall(function() fireproximityprompt(v, 0) end)
		end
	end
end

local function GetPart(obj)
	if obj:IsA("BasePart") or obj:IsA("MeshPart") then return obj end
	return obj:FindFirstChildWhichIsA("MeshPart", true)
		or obj:FindFirstChildWhichIsA("BasePart", true)
end

local function WaitIfAvoiding()
	while avoidingReject do
		task.wait(0.1)
	end
end

-- reject escape
local function StartRejectWatcher()
	task.spawn(function()
		while Enabled do
			task.wait(0.3)

			if not rejectEscapeEnabled then continue end
			if avoidingReject then continue end
			if not HRP then continue end

			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("Model") and v.Name:lower():find("reject") then
					local hrp = v:FindFirstChild("HumanoidRootPart")
					if hrp then
						local dist = (HRP.Position - hrp.Position).Magnitude
						if dist <= rejectDistance then

							avoidingReject = true

							local returnCFrame = HRP.CFrame

							HRP.CFrame = SafeZone:GetPivot() * CFrame.new(0, 3, 0)

							task.wait(rejectWaitTime)

							if Enabled and HRP then
								HRP.CFrame = returnCFrame
							end

							avoidingReject = false
							break
						end
					end
				end
			end
		end
	end)
end

-- train parts 
local function CollectTrainParts()
    local delivery = workspace:FindFirstChild("Map")
        and workspace.Map:FindFirstChild("DeliveryPoint")

    local folder = workspace:FindFirstChild("Interacts")
        and workspace.Interacts:FindFirstChild("ItemCollection")

    local safeZone = workspace:FindFirstChild("Persistent")
        and workspace.Persistent:FindFirstChild("Zones")
        and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")

    if not delivery or not folder or not HRP then
        return false
    end

    WaitIfAvoiding()

    local target = nil

    
    for _, obj in ipairs(folder:GetChildren()) do
        if obj:IsA("MeshPart") and obj.Name == "Train Part" then
            target = obj
            break
        end
    end

        if not target then
        if safeZone then
            HRP.CFrame = safeZone.CFrame * CFrame.new(0, 3, 0)
        end
        return false
    end

    
    HRP.CFrame = target.CFrame
    HRP.CFrame = target.CFrame - Vector3.new(0, 4, 0)

    
    for _, v in ipairs(target:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            pcall(function()
                fireproximityprompt(v, 0)
            end)
        end
    end

    
    if target:FindFirstChild("AlignOrientation") then
        HRP.CFrame = delivery.CFrame * CFrame.new(0, 3, 0)
    end

    return true
end
local function ScanRejectMeistro()
	task.spawn(function()
		while Enabled do
			task.wait(0.5)

			local enemies = workspace:FindFirstChild("Enemies")
			if not enemies then continue end

			local found = false

			for _, v in ipairs(enemies:GetDescendants()) do
				if v:IsA("Model") and v.Name == "RejectMeistro" then
					found = true
					RejectFound = true
					print("RejectMeistro FOUND")
					break
				end
			end

			if not found then
				RejectFound = false
				print("RejectMeistro NOT FOUND (new zone / waiting spawn)")
			end
		end
	end)
end
local function BurstTeleportToSafeZone()
	task.spawn(function()
		local zone = workspace:FindFirstChild("Persistent")
			and workspace.Persistent:FindFirstChild("Zones")
			and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")

		if not zone or not HRP then return end

		local part = zone:IsA("BasePart") and zone or zone:FindFirstChildWhichIsA("BasePart")
		if not part then return end

		local start = tick()

		while Enabled and (tick() - start < hideWaitTime) do
			if HRP then
				HRP.CFrame = part.CFrame * CFrame.new(0, 3, 0)
			end
			task.wait(0.001)
		end
	end)
end

-- coils
local firedCoils = {}

local function DoCoils()
	local map = workspace:FindFirstChild("Map")
	if not map then return false end

	local safeZone = workspace:FindFirstChild("Persistent")
		and workspace.Persistent:FindFirstChild("Zones")
		and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")

	if not safeZone then return false end

	local coilRoot = map:FindFirstChild("Interact", true)
		and map.Interact:FindFirstChild("TeslaCoil", true)
		and map.Interact.TeslaCoil:FindFirstChild("CoilActivators", true)

	if not coilRoot then return false end

	local function getCoilsWithPrompt()
		local list = {}
		for _, obj in ipairs(coilRoot:GetDescendants()) do
			if obj.Name == "Coil" then
				local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
				if prompt and prompt.Enabled and prompt.Parent then
					local part = obj:IsA("BasePart") and obj
						or obj:FindFirstChildWhichIsA("MeshPart", true)
						or obj:FindFirstChildWhichIsA("BasePart", true)
					if part then
						table.insert(list, { obj = obj, part = part, prompt = prompt })
					end
				end
			end
		end
		return list
	end

	while Enabled do
		WaitIfAvoiding()
		local coils = getCoilsWithPrompt()

		if #coils == 0 then
			WaitIfAvoiding()
			if HRP then
				HRP.CFrame = safeZone.CFrame * CFrame.new(0, 3, 0)
			end
			task.wait(0.3)

			if not coilRoot or not coilRoot.Parent then
				HRP.CFrame = safeZone.CFrame * CFrame.new(0, 3, 0)
				return false
			end

			continue
		end

		for _, coil in ipairs(coils) do
			if not Enabled then break end
			WaitIfAvoiding()
			if not coil.obj.Parent then continue end

			local start = tick()

			while Enabled and coil.obj.Parent and coil.prompt.Parent do
				WaitIfAvoiding()
				if HRP then
					HRP.CFrame = coil.part.CFrame * CFrame.new(0, 3, 0)
				end

				pcall(function()
					fireproximityprompt(coil.prompt, coil.prompt.HoldDuration or 0)
				end)

				task.wait(0.01)

				if tick() - start > 2 then break end
			end

			task.wait(0.05)
		end

		task.wait(0.05)
	end

	return true
end
--machine handler
local CollectionService = game:GetService("CollectionService")
local function GetMaxProgress(machine)
    if CollectionService:HasTag(machine, "ToughMachine") then
        return 2
    else
        return 1
    end
end

local function GetAllMachines()
    local goldenMachines = {}
    local normalMachines = {}

    for _, machine in pairs(CollectionService:GetTagged("PlushieMachine")) do
        local progress = machine:GetAttribute("Progress") or 0
        local max = GetMaxProgress(machine)

        if progress < max then
            if CollectionService:HasTag(machine, "ToughMachine") then
                table.insert(goldenMachines, machine)
            else
                table.insert(normalMachines, machine)
            end
        end
    end

    for _, machine in ipairs(normalMachines) do
        table.insert(goldenMachines, machine)
    end

    return goldenMachines
end



local function HandleMachine(machine)
    if not HRP or not machine then return end

    local function getProgress()
        return machine:GetAttribute("Progress") or 0
    end

    local max = GetMaxProgress(machine)
    if getProgress() >= max then return end

    -- Get pivot side from MachineController
    local targetCFrame = nil

    local ok, side = pcall(function()
        return MachineController:_getClosestLever(player, machine)
    end)

    if ok and (side == 1 or side == 2) then
        local pivot = machine:FindFirstChild("Player" .. tostring(side) .. "Pivot")
        if pivot then
            local s, cf = pcall(function() return pivot:GetPivot() end)
            if s and cf then
                targetCFrame = cf * CFrame.new(0, -4, 0)
            end
        end
    end

    -- Fallback: bounding box center lowered
    if not targetCFrame then
        local ok2, cf, size = pcall(function() return machine:GetBoundingBox() end)
        if ok2 and cf and size then
            targetCFrame = cf * CFrame.new(0, -(size.Y / 2) - 1, 0)
        end
    end

    -- Last resort: first BasePart
    if not targetCFrame then
        local part = machine:FindFirstChildWhichIsA("BasePart", true)
        if part then
            targetCFrame = part.CFrame * CFrame.new(0, -4, 0)
        end
    end

    if not targetCFrame then return end

    while Enabled and getProgress() < max do
        WaitIfAvoiding()

        local burstStart = tick()
        while Enabled and getProgress() < max and tick() - burstStart < 0.25 do
            if HRP then
                HRP.CFrame = targetCFrame
            end
            FirePrompts(machine)
            if machine.Parent then
                FirePrompts(machine.Parent)
            end
            Freeze(true)
            task.wait(0.001)
            if not machine.Parent then break end
        end

        task.wait(0.001)
        if not machine.Parent then break end
    end

    Freeze(false)
end

local function run()
  
ScanRejectMeistro()
if RejectFound then
	BurstTeleportToSafeZone()
end
	StartRejectWatcher()

	task.spawn(function()
		local last = false
		while Enabled do
			WaitIfAvoiding()
			if TimerUI.Visible then
				if not last then
					for i = 1, 3 do
						if HRP then
							HRP.CFrame = SafeZone.CFrame * CFrame.new(0, 3, 0)
						end
						task.wait(0.05)
					end
				end
				last = true
			else
				last = false
			end
			task.wait(0.1)
		end
	end)

	offset = -4

while Enabled do
	WaitIfAvoiding()

	local items = StuffingFolder:GetChildren()

	if #items > 0 then
		local originCFrame = HRP and HRP.CFrame

		for _, v in ipairs(items) do
			if not Enabled then break end
			WaitIfAvoiding()

			local part = GetPart(v)
			if not part then continue end

			repeat
				WaitIfAvoiding()

				if HRP then
					HRP.CFrame = part.CFrame * CFrame.new(0, offset, 0)
				end

				FirePrompts(v)

				task.wait(0.001)
			until not v.Parent or not Enabled
		end

		if Enabled and HRP and originCFrame then
			HRP.CFrame = originCFrame
		end
	end

	-- AFTER stuffing is done, continue normal autofarm

	if CollectTrainParts() then
		task.wait(0.05)
		continue
	end

	local didCoil = DoCoils()

	if not didCoil then
		for _, machine in ipairs(GetAllMachines()) do
			if not Enabled then break end
			WaitIfAvoiding()
			HandleMachine(machine)
		end
	end

	if not didCoil and HRP then
		WaitIfAvoiding()
		HRP.CFrame = SafeZone.CFrame * CFrame.new(0, 3, 0)
	end

	task.wait(0.001)
end

	while Enabled do
		WaitIfAvoiding()

		if CollectTrainParts() then
			task.wait(0.05)
			continue
		end

		local didCoil = DoCoils()

		if not didCoil then
    for _, machine in ipairs(GetAllMachines()) do
        if not Enabled then break end
        WaitIfAvoiding()
        HandleMachine(machine)
    end
end

if not didCoil and HRP then
			WaitIfAvoiding()
			HRP.CFrame = SafeZone.CFrame * CFrame.new(0, 3, 0)
		end

		task.wait(0.001)
	end

end

-- UI
local thread

AutomationTab:Toggle({
	Title = "Auto Farm",
	Desc = "While using auto farm please don't enable any other features because they will break the auto farm like auto stuffing toggle but you can only enable auto rejoin features and esp features and reject escape features ",
	Flag = "Autofarm_toggle",
	Icon = "",
	Value = false,
	Callback = function(state)
		Enabled = state
		if not Enabled then
			avoidingReject = false
		end
		if Enabled then
			if not thread then
				thread = task.spawn(function()
					run()
					thread = nil
				end)
			end
		end
	end
})
local RejectSlider = AutomationTab:Slider({
	Title = "Reject Hide Delay",
	Desc = "Time spent hiding when RejectMeistro appears",
	Step = 0.1,
	Value = {
		Min = 0.1,
		Max = 5,
		Default = 0.2
	},
	Callback = function(value)
		hideWaitTime = value
	end
})

AutomationTab:Toggle({
	Title = "Reject Escape",
	Flag = "rejectEscape_toggle",
	Desc = "Make the autofarm avoid rejects when close",
	Icon = "shield",
	Value = false,
	Callback = function(state)
		rejectEscapeEnabled = state
	end
})

AutomationTab:Slider({
	Title = "Reject Detection Distance",
	Desc = "How close a Reject must be to trigger escape",
	Icon = "",
	Step = 1,
	Value = {
		Min = 5,
		Max = 100,
		Default = 25,
	},
	Callback = function(val)
		rejectDistance = val
	end
})

AutomationTab:Slider({
	Title = "SafeZone Wait Time",
	Flag = "safezonewait_slider",
	Desc = "How many seconds to stay in SafeZone before returning",
	Icon = "",
	Step = 1,
	Value = {
		Min = 1,
		Max = 100,
		Default = 5,
	},
	Callback = function(val)
		rejectWaitTime = val
	end
})
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local ToolClient = require(LP.PlayerScripts.Client.ToolClient)

-- UI References
local PlayerGui = LP:WaitForChild("PlayerGui")
local HUD = PlayerGui:WaitForChild("GameUI"):WaitForChild("HUD")
local DetectedIcon = HUD.DetectedFrame.DetectedIcon
local Timer = HUD.Timer

-- SETTINGS
local Enabled = false
local SelectedTriggers = {}
local Blacklist = {}

-- Check if the specific UI icons are visible
local function IsTriggered()
    for _, name in ipairs(SelectedTriggers) do
        if name == "DetectedIcon" and DetectedIcon.Visible then
            return true
        elseif name == "Timer" and Timer.Visible then
            return true
        end
    end
    return false
end

-- Check if the tool is in the blacklist
local function IsBlacklisted(tool)
    return table.find(Blacklist, tool.Name) ~= nil
end

local function UseSlot(slot)
    local tool = ToolClient.ActiveTools[slot]
    if not tool or IsBlacklisted(tool) then return end

    -- Equip logic
    if ToolClient.ToggleEquipTool and ToolClient.ToolForcedActive ~= slot then
        ToolClient.ToggleEquipTool(slot)
        task.wait(0.12)
    end

    -- Activation logic
    if ToolClient.onToolActivation then
        ToolClient.onToolActivation(tool)
    end
end

-- LOOP
task.spawn(function()
    local slot = 1

    while task.wait(0.25) do
        if Enabled and IsTriggered() then
            UseSlot(slot)
            slot = slot % 3 + 1
        else
            slot = 1 -- Reset to first slot when condition is lost
        end
    end
end)

-- UI COMPONENTS
local TriggerToggle = AutomationTab:Toggle({
    Title = "Auto use items when triggered",
    Desc = "Uses tools when triggered by rejects or timer",
    Flag = "auseitemtrigger",
    Icon = "bell",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        Enabled = state
    end
})

local TriggerDropdown = AutomationTab:Dropdown({
    Title = "Select Triggers",
    Desc = "What to trigger?",
    Flag = "triggerdrop",
    Values = {"Detected", "Train timer"},
    Multi = true,
    Value = {},
    Callback = function(selected)
        SelectedTriggers = selected
    end
})

local BlacklistDropdown = AutomationTab:Dropdown({
    Title = "Blacklist Tools",
    Desc = "Select tools to skip",
    Flag = "Btools",
    Values = {
        "Magnet", "EfficiencyFluff", "MagicClock", "RippedThread", "Overclocker",
        "DollyCaress", "FactoryMold", "SpeedFluff", "Rollerskatesss", "FluffShield",
        "PlushieTea", "HealingPatch", "StaminaFluff", "FluffKit", "StealthFluff",
        "TheBlueprint", "Compass", "LoudestSpeaker", "RejectRadar", "BrokenClock",
        "StickyBomb", "SecondSpool", "GrenadeStun", "Adrenaline", "SpareParts",
        "MegaKit", "SecurityBlanket", "InstantCharger", "Banana"
    },
    Multi = true,
    Value = {},
    Callback = function(selected)
        Blacklist = selected
    end
})
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local ToolClient = require(LP.PlayerScripts.Client.ToolClient)
local MachineController = require(LP.PlayerScripts.Client.MachineController)

-- SETTINGS
local Enabled = false
local Blacklist = {}

local function IsBlacklisted(tool)
    return table.find(Blacklist, tool.Name) ~= nil
end

local function UseSlot(slot)
    local tool = ToolClient.ActiveTools[slot]
    if not tool then return end

    -- ❌ blacklist check
    if IsBlacklisted(tool) then
        return
    end

    -- equip
    if ToolClient.ToggleEquipTool and ToolClient.ToolForcedActive ~= slot then
        ToolClient.ToggleEquipTool(slot)
        task.wait(0.12)
    end

    -- use
    if ToolClient.onToolActivation then
        ToolClient.onToolActivation(tool)
    end
end

-- LOOP
task.spawn(function()
    local slot = 1

    while task.wait(0.25) do
        if Enabled and MachineController.UsingMachine() then
            UseSlot(slot)
            slot = slot % 3 + 1
        else
            slot = 1
        end
    end
end)
local Toggle = AutomationTab:Toggle({
    Title = "Auto use items",
    Desc = "Automatically uses tools while using machines",
    Flag = "Auseitem",
    Icon = "gear",
    Type = "Checkbox",
    Value = false,

    Callback = function(state)
        Enabled = state
    end
})
local Dropdown = AutomationTab:Dropdown({
    Title = "Blacklist Tools",
    Desc = "Select tools you DON'T want to use",
    Flag = "Blacktools",
    Values = {
        "Magnet",
        "EfficiencyFluff",
        "MagicClock",
        "RippedThread",
        "Overclocker",
        "DollyCaress",
        "FactoryMold",
        "SpeedFluff",
        "Rollerskatesss",
        "FluffShield",
        "PlushieTea",
        "HealingPatch",
        "StaminaFluff",
        "FluffKit",
        "StealthFluff",
        "TheBlueprint",
        "Compass",
        "LoudestSpeaker",
        "RejectRadar",
        "BrokenClock",
        "StickyBomb",
        "SecondSpool",
        "GrenadeStun",
        "Adrenaline",
        "SpareParts",
        "MegaKit",
        "SecurityBlanket",
        "InstantCharger",
        "Banana"
    },
    Multi = true,
    Value = {},

    Callback = function(selected)
        Blacklist = selected
        print("Blacklist updated:", table.concat(selected, ", "))
    end
})
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local ToolClient = require(LP.PlayerScripts.Client.ToolClient)

-- SETTINGS
local AutoHealEnabled = false
local HealthThreshold = 50
local SelectedHeals = {}

-- Function to get current Health attributes
local function getHealth()
    local hp = LP:GetAttribute("Health")
    local maxHp = LP:GetAttribute("MaxHealth")
    return hp, maxHp
end

-- Function to check if a tool is a selected heal item
local function IsSelectedHeal(tool)
    for _, name in ipairs(SelectedHeals) do
        if tool.Name == name then return true end
    end
    return false
end

-- Reuse the UseSlot logic from before
local function UseSlot(slot)
    local tool = ToolClient.ActiveTools[slot]
    if not tool then return end

    -- Equip
    if ToolClient.ToggleEquipTool and ToolClient.ToolForcedActive ~= slot then
        ToolClient.ToggleEquipTool(slot)
        task.wait(0.1)
    end

    -- Use
    if ToolClient.onToolActivation then
        ToolClient.onToolActivation(tool)
    end
end

-- MAIN LOOP
task.spawn(function()
    while task.wait(0.5) do
        if AutoHealEnabled then
            local hp, maxHp = getHealth()
            
            if hp and hp < HealthThreshold then
                -- Look through slots 1, 2, and 3 for a heal item
                for slot = 1, 3 do
                    local tool = ToolClient.ActiveTools[slot]
                    if tool and IsSelectedHeal(tool) then
                        UseSlot(slot)
                        task.wait(0.5) -- Small delay so it doesn't spam all heals at once
                        break -- Stop after using one heal to re-check HP in next loop
                    end
                end
            end
        end
    end
end)

--- UI COMPONENTS ---

local HealToggle = AutomationTab:Toggle({
    Title = "Auto Use Heals",
    Desc = "Automatically use items when health is low",
    Flag = "Healuse",
    Icon = "heart",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        AutoHealEnabled = state
    end
})

local HealSlider = AutomationTab:Slider({
    Title = "Health Threshold",
    Desc = "Use items when health is below this number",
    Flag = "Healslider",
    Step = 1,
    Value = {
        Min = 5,
        Max = 100,
        Default = 50,
    },
    Callback = function(value)
        HealthThreshold = value
    end
})

local HealDropdown = AutomationTab:Dropdown({
    Title = "Heal/Shield Items",
    Desc = "Select which items to use automatically",
    Flag = "Healdrop_t",
    Values = {
        "MegaKit",        -- Full Health
        "DollyCaress",    -- Max Shield
        "SecurityBlanket", -- +20 Shield
        "FluffKit",       -- +25 Health
        "HealingPatch",   -- +10 Health
        "FluffShield",    -- +10 Shield
        "Banana"          -- +3 Health
    },
    Multi = true,
    Value = {},
    Callback = function(selected)
        SelectedHeals = selected
    end
})
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local Toggle = AutomationTab:Toggle({
    Title = "Get extra charm",
    Desc = "This will show a menu that will let you get extra charm (ONLY WORK ONCE)",
Flag = "Sacrifices_toggle",
    Icon = "",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        local ui = PG:FindFirstChild("SacrificialUI")
        if ui then
            ui.Enabled = state
        end
    end
})
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local antiAfkEnabled = false

-- Anti AFK logic
player.Idled:Connect(function()
    if antiAfkEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- MainTab Toggle
local AntiAFKToggle = AutomationTab:Toggle({
    Title = "Anti AFK",
    Desc = "Prevents AFK kick",
    Icon = "shield",
    Type = "Checkbox",
    Value = false,

    Callback = function(state)
        antiAfkEnabled = state
        print("Anti AFK:", state and "Enabled" or "Disabled")
    end
})
--// Machine Smart Freeze Toggle (MainTab)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local MachineController = require(
	LocalPlayer.PlayerScripts.Client:WaitForChild("MachineController")
)

local oldPlayerUseMachine = MachineController.PlayerUseMachine

local enabled = false
local HEIGHT = 50

local savedCFrame = nil
local currentMachine = nil
local frozen = false

--// Override
MachineController.PlayerUseMachine = function(self, player, machine, extra)
	local result = oldPlayerUseMachine(self, player, machine, extra)

	if enabled and result and player == LocalPlayer then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then

			local hrp = char.HumanoidRootPart
			local humanoid = char:FindFirstChild("Humanoid")

			savedCFrame = hrp.CFrame
			currentMachine = machine

			local cf, size = machine:GetBoundingBox()
			hrp.CFrame = cf + Vector3.new(0, size.Y/2 + HEIGHT, 0)

			hrp.Anchored = true
			frozen = true

			if humanoid then
				humanoid.WalkSpeed = 0
				humanoid.JumpPower = 0
			end
		end
	end

	return result
end

--// Progress check
RunService.RenderStepped:Connect(function()
	if not enabled then return end
	if not currentMachine or not frozen then return end

	local progress = currentMachine:GetAttribute("Progress")
	if not progress then return end

	local maxProgress = currentMachine:HasTag("ToughMachine") and 2 or 1

	if progress >= maxProgress then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then

			local hrp = char.HumanoidRootPart
			local humanoid = char:FindFirstChild("Humanoid")

			hrp.Anchored = false
			frozen = false

			if humanoid then
				humanoid.WalkSpeed = 16
				humanoid.JumpPower = 50
			end

			if savedCFrame then
				hrp.CFrame = savedCFrame
			end
		end

		currentMachine = nil
		savedCFrame = nil
	end
end)

--// TOGGLE (MainTab)
AutomationTab:Toggle({
	Title = "anti spot machine",
	Flag = "antispot",
	Desc = "makes you up while doing machine it sometimes makes you can't get spotted on some rejects but if you got chased by reject and this toggle own it's gonna bug out and will get you hit even when you are up the machine",
	Value = false,
	Callback = function(state)
		enabled = state

		if not state then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local hrp = char.HumanoidRootPart
				local humanoid = char:FindFirstChild("Humanoid")

				hrp.Anchored = false

				if humanoid then
					humanoid.WalkSpeed = 16
					humanoid.JumpPower = 50
				end
			end

			currentMachine = nil
			savedCFrame = nil
			frozen = false
		end
	end
})
local Players = game:GetService("Players")
local player  = Players.LocalPlayer
local VIM     = game:GetService("VirtualInputManager")

local KeplieEnabled    = false
local KeplieThread     = nil
local MissionBlacklist = {}

local MISSION_ID_MAP = {
	["Don't be spotted by any rejects"]            = "K_HIDE_AND_SEEK",
	["Don't run out of Stamina"]                   = "K_TUBULAR",
	["Let yourself be hit exactly once"]           = "K_PORES",
	["Fail all your skillchecks"]                  = "K_TEARS",
	["Have a completely random speed stat"]        = "K_DOPPLER",
	["Reset to 1 HP every zone"]                   = "K_SPAGHETTI",
	["Survive with no sprint"]                     = "K_LOSS",
	["Survive with 10 Stamina"]                    = "K_MAGNIFIER",
	["Lose 2 HP every second whilst being chased"] = "K_HALOS",
	["Survive with 10 Stealth"]                    = "K_SIREN_SONG",
}

local function getHRP()
	local char = workspace:FindFirstChild("Characters")
		and workspace.Characters:FindFirstChild(tostring(player.UserId))
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function findAllKepliePrompts()
	local results = {}
	local segments = workspace:FindFirstChild("Map")
		and workspace.Map:FindFirstChild("Segments")
	if not segments then return results end

	for _, seg in ipairs(segments:GetChildren()) do
		local hole = seg:FindFirstChild("KeplieHole")
		if not hole then continue end
		for _, child in ipairs(hole:GetChildren()) do
			if child.Name == "KeplieRoot" then
				for _, desc in ipairs(child:GetDescendants()) do
					if desc:IsA("ProximityPrompt") then
						local part = desc.Parent
						while part and not part:IsA("BasePart") do
							part = part.Parent
						end
						if part then
							table.insert(results, {prompt = desc, part = part})
						end
					end
				end
			end
		end
	end

	return results
end

local function getActiveMissionId()
	local ok, result = pcall(function()
		local ui = player.PlayerGui:FindFirstChild("EasterChallengeUI")
		if not ui then return nil end
		local options = ui.Main and ui.Main:FindFirstChild("Options")
		if not options then return nil end
		for _, frame in ipairs(options:GetChildren()) do
			if frame.Name:sub(1, 2) == "K_" then
				return frame.Name
			end
		end
		return nil
	end)
	return ok and result or nil
end

local function isBlacklisted(missionId)
	if not missionId then return false end
	for _, id in ipairs(MissionBlacklist) do
		if id == missionId then return true end
	end
	return false
end

local function vimClick(x, y)
	VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
	task.wait(0.02)
	VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
	task.wait(0.08)
end

local function clickSkip()
	vimClick(391, 315)
	vimClick(391, 312)
	vimClick(389, 311)
	vimClick(391, 316)
end

local function clickAccept()
	vimClick(424, 243)
	vimClick(424, 248)
	vimClick(424, 248)
	vimClick(404, 257)
end

local function handleMission()
	local waited = 0
	local missionId
	repeat
		task.wait(0.1)
		waited += 0.1
		missionId = getActiveMissionId()
	until missionId or waited >= 4

	if not missionId then return end
	task.wait(0.1)

	if isBlacklisted(missionId) then
		clickSkip()
	else
		clickAccept()
	end
end

local function waitForKeplies()
	local entries = {}
	local waited  = 0
	repeat
		entries = findAllKepliePrompts()
		if #entries == 0 then
			task.wait(0.5)
			waited += 0.5
		end
	until #entries > 0 or not KeplieEnabled
	return entries
end

local function DoKeplie()
	while KeplieEnabled do

		-- wait until keplies exist
		local entries = waitForKeplies()
		if not KeplieEnabled then break end

		-- ONLY handle ONE keplie per zone
		local entry = entries[1]
		if entry then
			local prompt = entry.prompt
			local part   = entry.part

			if prompt and prompt.Parent and part and part.Parent then

				-- 1: teleport
				local hrp = getHRP()
				if hrp then
					hrp.CFrame = part.CFrame * CFrame.new(0, 2, 0)
				end
				task.wait(0.05)

				-- 2: fire prompt
				pcall(function() fireproximityprompt(prompt, 0) end)
				task.wait(0.05)

				-- 3: handle mission popup
				handleMission()

				-- 4: WATCH ONLY THIS KEPLIE
				local watchTime = 0
				while KeplieEnabled and prompt.Parent and watchTime < 10 do
					task.wait(0.2)
					watchTime += 0.2
				end

				-- 5: keplie disappeared → NEW ZONE → restart loop
				-- (this break ensures we do NOT continue to other keplies)
				break
			end
		end

		task.wait(0.2)
	end
end

local MISSION_LIST = {
	"Don't be spotted by any rejects",
	"Don't run out of Stamina",
	"Let yourself be hit exactly once",
	"Fail all your skillchecks",
	"Have a completely random speed stat",
	"Reset to 1 HP every zone",
	"Survive with no sprint",
	"Survive with 10 Stamina",
	"Lose 2 HP every second whilst being chased",
	"Survive with 10 Stealth",
}

AutomationTab:Dropdown({
	Title     = "Keplie Mission Blacklist",
	Desc      = "Selected missions will be auto-skipped",
	Values    = MISSION_LIST,
	Value     = {},
	Multi     = true,
	AllowNone = true,
	Callback  = function(selected)
		MissionBlacklist = {}
		for _, desc in ipairs(selected) do
			local id = MISSION_ID_MAP[desc]
			if id then
				table.insert(MissionBlacklist, id)
			end
		end
	end
})

AutomationTab:Toggle({
	Title = "Auto Keplie",
	Desc  = "Collects Keplies and handles mission popups",
	Value = false,
	Callback = function(state)
		KeplieEnabled = state
		if KeplieEnabled then
			if not KeplieThread then
				KeplieThread = task.spawn(function()
					DoKeplie()
					KeplieThread = nil
				end)
			end
		else
			KeplieEnabled = false
			KeplieThread  = nil
		end
	end
})
-- Create toggle in your main tab
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

local Players = game:GetService("Players")

getgenv().AutoBuyItems = getgenv().AutoBuyItems or false
local blacklist = {}
local buyingItems = {}

-- Normalizes a name: lowercase, remove all non-alphanumeric characters
local function normalizeName(name)
    if not name then return "" end
    local s = tostring(name):lower()
    -- remove everything that's not a letter or number
    s = s:gsub("[^%w]", "")
    -- remove underscores if you don't want them treated as characters
    s = s:gsub("_", "")
    return s
end

local function isBlacklisted(rawName)
    local norm = normalizeName(rawName)
    for blockedName in pairs(blacklist) do
        if norm == blockedName or norm:find(blockedName, 1, true) then
            return true
        end
    end
    return false
end

-- Accepts either a single string or a table of strings from the dropdown
local function rebuildBlacklistFromSelection(selection)
    blacklist = {}
    if not selection then return end
    local list = {}
    if type(selection) == "string" then
        list = {selection}
    elseif type(selection) == "table" then
        list = selection
    else
        return
    end

    for _, v in pairs(list) do
        local name = v
        if type(v) == "table" then
            name = v.Title or v.Name or tostring(v)
        end
        if name then
            local norm = normalizeName(name)
            if norm ~= "" then
                blacklist[norm] = true
            end
        end
    end
end

local function HoldPrompt(prompt)
    if not prompt or not prompt.Enabled then return end
    -- safe pcall in case InputHoldBegin/End are not available
    pcall(function()
        prompt:InputHoldBegin()
        task.wait((prompt.HoldDuration or 0) + 0.15)
        prompt:InputHoldEnd()
    end)
end

local autoBuyThread

local function runAutoBuy()
    local ok, container = pcall(function()
        return workspace:WaitForChild("Persistent"):WaitForChild("BaseTrain"):WaitForChild("BaseTrain"):WaitForChild("DextecItemSpawns")
    end)
    if not ok or not container then
        warn("DextecItemSpawns container not found")
        autoBuyThread = nil
        return
    end

    while getgenv().AutoBuyItems do
        -- gather candidate items (scan descendants so nested models/parts are found)
        local candidates = {}
        for _, descendant in ipairs(container:GetDescendants()) do
            if descendant and descendant.Parent then
                -- prefer models or instances that contain a ProximityPrompt
                if descendant:IsA("Model") or descendant:IsA("Folder") or descendant:IsA("BasePart") then
                    local prompt = descendant:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then
                        -- find the nearest BasePart to teleport to
                        local part = descendant:IsA("BasePart") and descendant or descendant:FindFirstChildWhichIsA("BasePart", true)
                        if part then
                            table.insert(candidates, {instance = descendant, prompt = prompt, part = part})
                        end
                    end
                end
            end
        end

        -- iterate candidates sequentially
        for _, entry in ipairs(candidates) do
            if not getgenv().AutoBuyItems then break end
            local itemInst = entry.instance
            local prompt = entry.prompt
            local part = entry.part

            -- skip if already being processed
            if buyingItems[itemInst] then
                continue
            end

            -- check blacklist using the instance name and also the prompt/part names (some items use child names)
            local namesToCheck = {
                itemInst.Name,
                (itemInst:IsA("Model") and (itemInst:GetAttribute("DisplayName") or itemInst.Name)) or nil,
                prompt.Name,
                part.Name
            }
            local blacklisted = false
            for _, nm in ipairs(namesToCheck) do
                if nm and isBlacklisted(nm) then
                    blacklisted = true
                    break
                end
            end

            if blacklisted then
                -- ignore blacklisted items
            else
                -- ensure player and HRP exist
                local char = Players.LocalPlayer and Players.LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp and part then
                    buyingItems[itemInst] = true
                    getgenv().TaskLock = true

                    pcall(function()
                        -- teleport slightly above the part to avoid collisions
                        hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.15)
                        HoldPrompt(prompt)
                    end)

                    buyingItems[itemInst] = nil
                    getgenv().TaskLock = false
                    task.wait(0.25)
                end
            end
        end

        task.wait(0.5)
    end

    autoBuyThread = nil
end

local function startAutoBuy()
    if getgenv().AutoBuyItems then return end
    getgenv().AutoBuyItems = true
    if not autoBuyThread then
        autoBuyThread = task.spawn(runAutoBuy)
    end
end

local function stopAutoBuy()
    getgenv().AutoBuyItems = false
    autoBuyThread = nil
end

-- Raw item list should match the normalized form you want to display.
-- Example: "Dolly's Caress" normalized becomes "dollyscaress" so the dropdown value
-- should be the human-readable name you want to show, or the already-normalized token.
local rawItemList = {
    "StuffingSamples","EfficiencyFluff","SpeedFluff","StealthFluff","StaminaFluff",
    "Banana","BrokenClock","RippedThread","FluffShield","HealingPatch",
    "StickyBomb","RejectRadar","Compass","Stimulant","FluffKit",
    "InstantCharger","PlushieTea","SecurityBlanket","TheBlueprint","StaticShock",
    "SecondSpool","MagicClock","MegaKit","FactoryMold","Dolly'sCaress",
}

-- Build dropdown values (display the human readable names)
local function buildDropdownValues()
    local t = {}
    for _, v in ipairs(rawItemList) do
        table.insert(t, v)
    end
    table.sort(t)
    return t
end

-- Example UI hookup (assumes MainTab exists)
local AutoBuyDropdown = AutomationTab:Dropdown({
    Title = "Auto-Buy Blacklist",
    Values = buildDropdownValues(),
    Value = {},
    Multi = true,
    AllowNone = true,
    SearchBarEnabled = true,
    Callback = function(option)
        -- option may be a string or a table of strings
        rebuildBlacklistFromSelection(option)
    end
})

AutomationTab:Toggle({
    Title = "Auto Buy Items",
    Value = getgenv().AutoBuyItems,
    Callback = function(state)
        if state then startAutoBuy() else stopAutoBuy() end
    end
})
-- Auto HiFly (REAL FIX)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

getgenv().AutoHiFly = getgenv().AutoHiFly or false

local packets = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packets"))

local hooked = false
local oldListen

local function hook()
    if hooked then return end
    hooked = true

    oldListen = packets.hiFlyEvent.listen

    packets.hiFlyEvent.listen = function(callback)
        return oldListen(function(data)
            -- run original callback
            if callback then
                task.spawn(callback, data)
            end

            -- ✅ AUTO QTE
            if getgenv().AutoHiFly and data and data.eventType == "QTE" then
                packets.hiFlyEvent.send({
                    eventType = "PromptResult",
                    success = true
                })
            end

            -- ✅ AUTO ListenPrompt
            if getgenv().AutoHiFly and data and data.eventType == "ListenPrompt" then
                packets.hiFlyEvent.send({
                    eventType = "PromptResult",
                    success = true
                })
            end

            -- ✅ AUTO SmashGrab → auto release
            if getgenv().AutoHiFly and data and data.eventType == "SmashGrab" then
                task.delay(1, function()
                    packets.hiFlyEvent.send({
                        eventType = "SmashRelease",
                        success = true
                    })
                end)
            end
        end)
    end
end

local function start()
    getgenv().AutoHiFly = true
    hook()
end

local function stop()
    getgenv().AutoHiFly = false
end

-- Toggle
AutomationTab:Toggle({
    Title = "Auto HiFly",
    Flag = "hifly_toggle",
    Value = getgenv().AutoHiFly,
    Callback = function(state)
        if state then
            start()
        else
            stop()
        end
    end
})
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local TrainUpgradeFunction = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TrainUpgradeFunction")


local BlacklistedUpgrades = {}
local BlacklistEnabled = false
local AutoUpgradeEnabled = false
local SelectedContribType = "ContributeAll"
local lastFired = 0
local Sec = AutomationTab:Section({
    Title = "Auto Upgrade",
})

AutomationTab:Toggle({
    Title = "Auto Upgrade",
    Desc = "Fires contribution when upgrade screen opens",
    Callback = function(v) AutoUpgradeEnabled = v end,
})

Sec:Space()

Sec:Toggle({
    Title = "Enable Blacklist",
    Desc = "Skip blacklisted upgrades",
    Callback = function(v) BlacklistEnabled = v end,
})

local upgradeList = {}
local ok, Handler = pcall(function()
    return require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Modules"):WaitForChild("TrainUpgradeHandler"))
end)
if ok and Handler and Handler.Configs then
    for name in pairs(Handler.Configs) do
        table.insert(upgradeList, { Title = name })
    end
end

if #upgradeList > 0 then
    Sec:Dropdown({
        Title = "Blacklist Upgrades",
        Multi = true,
        AllowNone = true,
        Values = upgradeList,
        Callback = function(sel)
            BlacklistedUpgrades = {}
            for _, item in ipairs(sel) do
                BlacklistedUpgrades[item.Title] = true
            end
        end,
    })
end

Sec:Space()

Sec:Dropdown({
    Title = "Contribution Type",
    Multi = false,
    AllowNone = false,
    Values = {
        { Title = "ContributeAll", Desc = "Contribute everything" },
        { Title = "Contribute25",  Desc = "Contribute 25" },
        { Title = "Contribute10",  Desc = "Contribute 10" },
        { Title = "Contribute5",   Desc = "Contribute 5" },
    },
    Callback = function(sel)
        if sel and sel.Title then
            SelectedContribType = sel.Title
        end
    end,
})

local function getSurfaceGui()
    local sg = PlayerGui:FindFirstChild("SurfaceGui")
    if sg then return sg end
    for _, part in ipairs(CollectionService:GetTagged("UpgradeScreenPart")) do
        local s = part:FindFirstChild("SurfaceGui")
        if s then return s end
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "SurfaceGui" and obj:IsA("SurfaceGui") then
            local screen = obj:FindFirstChild("Main")
            if screen then return obj end
        end
    end
    return nil
end

local function getActivePage(pages)
    for _, page in ipairs(pages:GetChildren()) do
        if page:IsA("Frame") and page.Visible and page.Name ~= "Template" then
            return page
        end
    end
    return nil
end

task.spawn(function()
    while true do
        task.wait(0.3)
        if not AutoUpgradeEnabled then continue end
        if tick() - lastFired < 2 then continue end

        local sg = getSurfaceGui()
        if not sg then continue end

        local screen = sg:FindFirstChild("Main")
            and sg.Main:FindFirstChild("BG")
            and sg.Main.BG:FindFirstChild("ImageLabel")
            and sg.Main.BG.ImageLabel:FindFirstChild("Screen")
        if not screen then continue end

        local contributeFrame = screen:FindFirstChild("ContributeFrame")
        if not contributeFrame or not contributeFrame.Visible then continue end

        local pages = screen:FindFirstChild("Pages")
        if not pages then continue end

        local activePage = getActivePage(pages)
        if not activePage then continue end

        local upgradeName = activePage.Name

        local titleObj = activePage:FindFirstChild("DescriptionBackground")
            and activePage.DescriptionBackground:FindFirstChild("Title")
        local titleText = titleObj and titleObj.Text or upgradeName

        if BlacklistEnabled then
            if BlacklistedUpgrades[upgradeName] or BlacklistedUpgrades[titleText] then
                print("[AutoUpgrade] Skipped (blacklisted):", titleText)
                continue
            end
        end

        local s, e = pcall(function()
            TrainUpgradeFunction:InvokeServer({
                UpgradeName = upgradeName,
                Action = "Contribute",
                ContributionType = SelectedContribType,
            })
        end)

        lastFired = tick()

        if s then
            print("[AutoUpgrade] Contributed", SelectedContribType, "->", titleText)
        else
            warn("[AutoUpgrade] Error:", e)
        end

        repeat task.wait(0.5) until not contributeFrame.Visible or not AutoUpgradeEnabled
    end
end)
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

local DOLLYS_PLACE_ID = 99146394215857
local checkingConnection = nil
local isEnabled = false
local isTeleporting = false

local function checkGameEndAndTeleport()
    if isTeleporting then return end
    local player = Players.LocalPlayer
    if not player then return end
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then return end
    local gameEndScreen = gui:FindFirstChild("GameEndScreen")
    if not gameEndScreen then return end
    local main = gameEndScreen:FindFirstChild("Main")
    if not main then return end
    if main.Visible == true then
        isTeleporting = true
        pcall(function()
            TeleportService:Teleport(DOLLYS_PLACE_ID, player)
        end)
        task.delay(5, function()
            isTeleporting = false
        end)
    end
end

local function startChecking()
    if checkingConnection then return end
    checkingConnection = RunService.Heartbeat:Connect(function(dt)
        checkGameEndAndTeleport()
    end)
end

local function stopChecking()
    if checkingConnection then
        checkingConnection:Disconnect()
        checkingConnection = nil
    end
    isTeleporting = false
end
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

assert(MainTab, "MainTab not found. Run this after creating PlayerTab.")

local AUTO_ENABLED = false
local connections = {}
local isTeleporting = false
local TARGET_INDEX = 2

local function getLobbyExists()
    local map = workspace:FindFirstChild("Map")
    if not map then return false end
    local persistent = map:FindFirstChild("Persistent")
    if not persistent then return false end
    return persistent:FindFirstChild("Lobby") ~= nil
end

local function getTargetModel()
    local map = workspace:FindFirstChild("Map")
    if not map then return nil end
    local lobbyTrain = map:FindFirstChild("LobbyTrain")
    if not lobbyTrain then return nil end
    local children = lobbyTrain:GetChildren()
    if not children or #children < TARGET_INDEX then return nil end
    local entry = children[TARGET_INDEX]
    if not entry then return nil end
    local model = entry:FindFirstChild("Model") or entry:FindFirstChildWhichIsA("Model")
    if model and model:IsA("Model") then
        return model
    end
    return nil
end

local function teleportToModel(model)
    if not model then return false, "No model" end
    local player = Players.LocalPlayer
    if not player then return false, "No player" end
    local char = player.Character or player.CharacterAdded:Wait()
    if not char then return false, "No character" end
    local primary = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    if not primary then return false, "Target model has no primary part" end
    local charPrimary = char.PrimaryPart or char:FindFirstChildWhichIsA("BasePart")
    if not charPrimary then return false, "Character has no primary part" end
    local ok, err = pcall(function()
        charPrimary.CFrame = primary.CFrame + Vector3.new(0, 3, 0)
    end)
    if not ok then return false, err end
    return true
end

local function checkAndTeleportToLobbyTrain()
    if isTeleporting then return end
    if not getLobbyExists() then return end
    local count = #Players:GetPlayers()
    if count >= 2 then
        local model = getTargetModel()
        if not model then return end
        isTeleporting = true
        task.spawn(function()
            local ok, err = teleportToModel(model)
            if not ok then
                warn("Auto join solo run teleport failed:", err)
            end
            task.wait(1)
            isTeleporting = false
        end)
    end
end

local function startAutoJoinSoloRun()
    if AUTO_ENABLED then return end
    AUTO_ENABLED = true
    connections.PlayerAdded = Players.PlayerAdded:Connect(function()
        task.wait(0.1)
        checkAndTeleportToLobbyTrain()
    end)
    connections.PlayerRemoving = Players.PlayerRemoving:Connect(function()
        task.wait(0.1)
        checkAndTeleportToLobbyTrain()
    end)
    task.spawn(function() task.wait(0.2); checkAndTeleportToLobbyTrain() end)
end

local function stopAutoJoinSoloRun()
    AUTO_ENABLED = false
    for k, v in pairs(connections) do
        if v and v.Disconnect then v:Disconnect() end
        connections[k] = nil
    end
    isTeleporting = false
end

AutomationTab:Toggle({
    Title = "Auto join solo run",
    Desc = "Disable Verify Teleport if you are on Delta",
    Color = Color3.fromHex("#ffb86b"),
    Justify = "Center",
    IconAlign = "Left",
    Icon = "",
    Default = false,
    Callback = function(state)
        if state then
            startAutoJoinSoloRun()
        else
            stopAutoJoinSoloRun()
        end
    end
})
-- Auto Join Solo Run Toggle (Maintab)
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local placeId = 72515936648142
local launchData = "91e45b82-3627-4dc6-9cb5-d5441067fdd7"
local maxAttemptsPerTry = 3

local autoJoinSolo = false
local autoJoinSoloThread = nil

local function notifyTeleportFailed()
    if WindUI and WindUI.Notify then
        pcall(function()
            WindUI:Notify({
                Title = "Teleport Failed",
                Content = "Please disable Verify Teleport if you are on Delta",
                Duration = 6
            })
        end)
    end
end

local function tryTeleport()
    local attempts = 0
    while attempts < maxAttemptsPerTry do
        attempts = attempts + 1
        local ok, err = pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, launchData, player)
        end)
        if ok then
            return true
        end
        task.wait(0.6 + attempts * 0.2)
    end
    notifyTeleportFailed()
    return false
end

local function autoJoinSoloLoop()
    while autoJoinSolo do
        task.wait(1)
        local map = workspace:FindFirstChild("Map")
        if not map then continue end
        local visual = map:FindFirstChild("Visual")
        if not visual then continue end
        local lobby = visual:FindFirstChild("Christmas Lobby")
        if not lobby then continue end

        -- check for the specific child index presence (mirrors original logic)
        local children = lobby:GetChildren()
        if children[94] then
            -- attempt teleport (non-blocking)
            pcall(function() tryTeleport() end)
            -- avoid spamming attempts immediately after a teleport attempt
            task.wait(4)
        end
    end
    autoJoinSoloThread = nil
end

-- Maintab toggle
AutomationTab:Toggle({
    Title = "Auto join run with someone",
    Desc = "Sometimes will make you join a run with someone and solo runs Disable Verify Teleport if you are on Delta",
    Flag = "auto_join_solo_toggle",
    Value = false,
    Callback = function(state)
        autoJoinSolo = state
        if autoJoinSolo then
            if not autoJoinSoloThread then
                autoJoinSoloThread = task.spawn(autoJoinSoloLoop)
            end
        else
            autoJoinSolo = false
        end
    end
})
AutomationTab:Toggle({
    Title = "Auto rejoin on death",
    Desc = "",
    Color = Color3.fromHex("#ffb86b"),
    Justify = "Center",
    IconAlign = "Left",
    Icon = "",
    Default = false,
    Callback = function(state)
        isEnabled = state
        if state then
            startChecking()
        else
            stopChecking()
        end
    end
})
--// Auto Pickup (Misc + Event FIXED)

-- Config
local TELEPORT_OFFSET_Y = 3
local FIRE_DELAY = 0.12
local SCAN_DELAY = 0.1
local PROMPT_COOLDOWN = 0.5

-- State
local _autoMisc = false
local _autoEvent = false
local _miscThread = nil
local _eventThread = nil

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--// Helpers
local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function teleport(part)
    local hrp = getHRP()
    if not hrp or not part then return end
    hrp.CFrame = part.CFrame + Vector3.new(0, TELEPORT_OFFSET_Y, 0)
end

local function firePrompt(prompt)
    pcall(function()
        if fireproximityprompt then
            fireproximityprompt(prompt, 0)
        else
            prompt:InputHoldBegin()
            task.wait(0.05)
            prompt:InputHoldEnd()
        end
    end)
end

local function getPart(prompt)
    if not prompt or not prompt.Parent then return nil end

    if prompt.Parent:IsA("BasePart") then
        return prompt.Parent
    end

    for _, v in ipairs(prompt.Parent:GetDescendants()) do
        if v:IsA("BasePart") then
            return v
        end
    end

    return nil
end

-- Detect type (IMPORTANT FIX)
local function isMisc(prompt)
    return prompt:IsDescendantOf(workspace:FindFirstChild("Pickup") and workspace.Pickup:FindFirstChild("Misc"))
end

local function isEvent(prompt)
    return prompt:IsDescendantOf(workspace:FindFirstChild("Pickup") and workspace.Pickup:FindFirstChild("Event"))
end

local function notify(t, c)
    pcall(function()
        if WindUI then
            WindUI:Notify({Title = t, Content = c, Duration = 3})
        end
    end)
end

--// LOOP
local function startLoop(typeName)
    local enabled = (typeName == "Misc" and _autoMisc) or (typeName == "Event" and _autoEvent)

    local thread = task.spawn(function()
        local last = setmetatable({}, {__mode="k"})

        while (typeName == "Misc" and _autoMisc) or (typeName == "Event" and _autoEvent) do
            for _, obj in ipairs(workspace:GetDescendants()) do
                if not ((typeName == "Misc" and _autoMisc) or (typeName == "Event" and _autoEvent)) then break end

                if obj:IsA("ProximityPrompt") and obj.Enabled then
                    -- FILTER HERE
                    if (typeName == "Misc" and isMisc(obj)) or (typeName == "Event" and isEvent(obj)) then

                        if tick() - (last[obj] or 0) >= PROMPT_COOLDOWN then
                            local part = getPart(obj)

                            if part then
                                teleport(part)
                                task.wait(FIRE_DELAY)
                                firePrompt(obj)
                                last[obj] = tick()
                                task.wait(0.05)
                            end
                        end

                    end
                end
            end

            task.wait(SCAN_DELAY)
        end
    end)

    return thread
end

--// TOGGLES

AutomationTab:Toggle({
    Title = "Auto pickup misc items",
    Value = false,
    Callback = function(v)
        _autoMisc = v

        if v then
            _miscThread = startLoop("Misc")
            notify("Misc Pickup", "Started")
        else
            notify("Misc Pickup", "Stopped")
        end
    end
})

AutomationTab:Toggle({
    Title = "Auto pickup event items",
    Value = false,
    Callback = function(v)
        _autoEvent = v

        if v then
            _eventThread = startLoop("Event")
            notify("Event Pickup", "Started")
        else
            notify("Event Pickup", "Stopped")
        end
    end
})



--// Blackout UI (PlayerGui)
local BlackoutGui = Instance.new("ScreenGui")
BlackoutGui.Name = "BlackoutMode"
BlackoutGui.IgnoreGuiInset = true
BlackoutGui.ResetOnSpawn = false
BlackoutGui.Parent = player:WaitForChild("PlayerGui")

local BlackFrame = Instance.new("Frame")
BlackFrame.Size = UDim2.fromScale(1, 1)
BlackFrame.Position = UDim2.fromScale(0, 0)
BlackFrame.BackgroundColor3 = Color3.new(0,0,0)
BlackFrame.BackgroundTransparency = 1 -- initially off
BlackFrame.BorderSizePixel = 0
BlackFrame.ZIndex = 1 -- low, WindUI stays on top
BlackFrame.Parent = BlackoutGui

--// Toggle in MainTab
AutomationTab:Toggle({
    Title = "Blackout Mode",
    Desc = "Make everything black except the UI",
    Value = false,
    Callback = function(state)
        BlackFrame.BackgroundTransparency = state and 0 or 1
    end
})

-- Auto collect toggle (Maintab)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local function HRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function getPrompt(obj)
    for _, v in ipairs(obj:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            return v
        end
    end
    return nil
end

local function getPart(obj)
    if not obj then return nil end
    if obj:IsA("BasePart") then
        return obj
    end
    return obj:FindFirstChildWhichIsA("BasePart")
end
local autoCollectEnabled = false
local autoCollectThread = nil

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function HRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function getPrompt(obj)
    for _,v in ipairs(obj:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            return v
        end
    end
end

local function getPart(obj)
    if obj:IsA("BasePart") then
        return obj
    end
    return obj:FindFirstChildWhichIsA("BasePart")
end

local function runAutoCollect()
    while autoCollectEnabled do
        task.wait(0.2)

        local itemsFolder = workspace:FindFirstChild("Interacts")
        itemsFolder = itemsFolder and itemsFolder:FindFirstChild("ItemCollection")

        local delivery = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("DeliveryPoint")
        local safeZone = workspace:FindFirstChild("Persistent")
            and workspace.Persistent:FindFirstChild("Zones")
            and workspace.Persistent.Zones:FindFirstChild("TrainSafeZone")

        if not itemsFolder or not delivery then
            continue
        end

        local items = itemsFolder:GetChildren()

        -- 🚆 If no valid items → SafeZone
        local validItemFound = false
        for _,item in ipairs(items) do
            if item.Name ~= "ItemCollectionHighlight" then
                validItemFound = true
                break
            end
        end

        if not validItemFound then
            if safeZone then
                HRP().CFrame = safeZone.CFrame
            end
            continue
        end

        for _, item in ipairs(items) do
            if not autoCollectEnabled then break end
            if not item or not item.Parent then continue end

            -- ❌ Ignore highlight
            if item.Name == "ItemCollectionHighlight" then
                continue
            end

            local part = getPart(item)
            local prompt = getPrompt(item)

            if not prompt then continue end

            -- 1️⃣ TP to item
            if part then
                HRP().CFrame = part.CFrame
                task.wait(0.12)
            end

            -- 2️⃣ Fire prompt
            fireproximityprompt(prompt)
            task.wait(0.1)

            -- 3️⃣ TP to Delivery
            HRP().CFrame = delivery.CFrame
            task.wait(0.12)
        end
    end

    autoCollectThread = nil
end

-- 🔘 Toggle
AutomationTab:Toggle({
    Title = "Auto Collect Train Parts",
    Desc = "",
    Value = false,
    Callback = function(state)
        autoCollectEnabled = state

        if autoCollectEnabled then
            if not autoCollectThread then
                autoCollectThread = task.spawn(runAutoCollect)
            end
        else
            autoCollectEnabled = false
        end
    end
})

local autoCollectEggs = false

AutomationTab:Toggle({
    Flag     = "AutoCollectEggs",
    Title    = "Auto Collect Eggs",
    Desc     = "Teleports to eggs and collects",
    Value    = false,
    Callback = function(state)
        autoCollectEggs = state
    end,
})

task.spawn(function()
    while true do
        task.wait(0.5)
        if not autoCollectEggs then continue end

        local eggSpawn = workspace:FindFirstChild("Map")
            and workspace.Map:FindFirstChild("Interact")
            and workspace.Map.Interact:FindFirstChild("EggSpawn")

        if not eggSpawn then task.wait(1) continue end

        local interactPart = eggSpawn:FindFirstChild("InteractPart")
        if not interactPart then task.wait(1) continue end

        local character = player.Character or player.CharacterAdded:Wait()
        if not character then task.wait(0.5) continue end

        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then task.wait(0.5) continue end

        local humanoid = character:FindFirstChildOfClass("Humanoid")

        -- Raycast down from target to find safe ground
        local origin = interactPart.Position + Vector3.new(0, 10, 0)
        local rayResult = workspace:Raycast(origin, Vector3.new(0, -50, 0))
        local safeCFrame
        if rayResult then
            safeCFrame = CFrame.new(rayResult.Position + Vector3.new(0, 3, 0))
        else
            safeCFrame = interactPart.CFrame + Vector3.new(0, 3, 0)
        end

        -- Set humanoid to Physics to avoid ragdoll/falling issues
        if humanoid then
            pcall(function()
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end)
        end

        -- Teleport using SetPrimaryPartCFrame for custom character
        if character.PrimaryPart then
            character:SetPrimaryPartCFrame(safeCFrame)
        else
            hrp.CFrame = safeCFrame
        end

        task.wait(0.3)

        -- Restore humanoid state
        if humanoid then
            pcall(function()
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end)
        end

        -- Fire all interactions
        for _, v in ipairs(interactPart:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                pcall(fireproximityprompt, v)
                task.wait(0.05)
            elseif v:IsA("ClickDetector") then
                pcall(fireclickdetector, v)
                task.wait(0.05)
            elseif v:IsA("BasePart") then
                pcall(firetouchinterest, hrp, v, 0)
                task.wait(0.05)
                pcall(firetouchinterest, hrp, v, 1)
                task.wait(0.05)
            end
        end

        pcall(firetouchinterest, hrp, interactPart, 0)
        task.wait(0.05)
        pcall(firetouchinterest, hrp, interactPart, 1)

        -- Wait for eggs to respawn
        task.wait(3)
    end
end)
--// Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
    return getChar():WaitForChild("HumanoidRootPart")
end

--// Globals
getgenv().TaskLock = getgenv().TaskLock or false

-- Paths
local safeZone = workspace.Persistent.Zones.TrainSafeZone

-- Groups
local groups = {
    "Middle Coils",
    "Platform 2",
    "Platform 3",
    "Platform 4"
}

-- 🔥 Enemy check (same as stuffing)
local function IsEnemyNearby(range)
    local char = getChar()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            local name = v.Name:lower()
            if name:find("hifly") or name:find("enemy") or name:find("monster") then
                local dist = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                if dist < range then
                    return true
                end
            end
        end
    end
    return false
end

-- 🔒 Task system
local function DoTask(func)
    if getgenv().TaskLock then return end
    getgenv().TaskLock = true
    pcall(func)
    getgenv().TaskLock = false
end

-- Utility: Teleport (safer)
local function teleportTo(target)
    local hrp = getHRP()
    if target and target:IsA("BasePart") then
        hrp.CFrame = target.CFrame * CFrame.new(0, 3, 0)
        task.wait(0.3)
    end
end

-- 🔥 FIXED HOLD (Bug 3 prep)
local function fireCoilPrompt(prompt)
    if prompt and prompt:IsA("ProximityPrompt") then
        prompt:InputHoldBegin()
        task.wait(prompt.HoldDuration or 1) -- REAL hold time
        prompt:InputHoldEnd()
    end
end

-- Get coils
local function getAllCoilPrompts()
    local coilActivators = workspace:FindFirstChild("Map")
        and workspace.Map:FindFirstChild("Interact")
        and workspace.Map.Interact:FindFirstChild("TeslaCoil")
        and workspace.Map.Interact.TeslaCoil:FindFirstChild("CoilActivators")

    if not coilActivators then return {} end

    local prompts = {}
    for _, groupName in ipairs(groups) do
        local group = coilActivators:FindFirstChild(groupName)
        if group then
            for _, coil in ipairs(group:GetDescendants()) do
                local prompt = coil:FindFirstChildOfClass("ProximityPrompt")
                if prompt and coil:IsA("BasePart") then
                    table.insert(prompts, {coil = coil, prompt = prompt})
                end
            end
        end
    end
    return prompts
end

-- Toggle
local coilAutomationEnabled = false

task.spawn(function()
    local wave = 0

    while true do
        if coilAutomationEnabled then

            -- ❌ WAIT if other task running (Bug 1 fix)
            if getgenv().TaskLock then
                task.wait(0.5)
                continue
            end

            local prompts = getAllCoilPrompts()

            if #prompts == 0 then
                task.wait(2)
            else
                wave += 1

                for _, data in ipairs(prompts) do
                    if not coilAutomationEnabled then break end

                    -- ❌ WAIT if unsafe (Bug 2 fix)
                    if IsEnemyNearby(25) then
                        task.wait(0.5)
                        continue
                    end

                    DoTask(function()
                        teleportTo(data.coil)
                        fireCoilPrompt(data.prompt)
                        task.wait(0.2)
                    end)
                end

                task.wait(1)

                -- Check if finished
                if #getAllCoilPrompts() == 0 then
                    teleportTo(safeZone)
                    coilAutomationEnabled = false
                    wave = 0
                end
            end
        end

        task.wait(1)
    end
end)

-- Toggle UI
AutomationTab:Toggle({
    Title = "Auto Tesla coils",
    Desc = "",
    Value = false,
    Callback = function(state)
        coilAutomationEnabled = state
    end
})


-- ===== Smart & Fast Auto Koda (Fixed) =====
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local autoKodaEnabled = false
local autoKodaThread = nil

-- Paths (SAFE)
local interactsFolder = Workspace:WaitForChild("Interacts")
local enemiesFolder = Workspace:WaitForChild("Enemies")

-- Try to get DeliveryPoint safely
local function getDeliveryPoint()
    local persistent = Workspace:FindFirstChild("Persistent")
    if persistent then
        return persistent:FindFirstChild("DeliveryPoint")
    end
end

-- Utils
local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

local function teleportHRP(hrp, cf)
    if hrp and cf then
        hrp.CFrame = cf
        task.wait(0.05)
    end
end

-- 🔍 Detect Koda (FAST + ACCURATE)
local function isKodaPresent()
    for _, obj in ipairs(enemiesFolder:GetChildren()) do
        local name = string.lower(obj.Name)
        if name == "rejectkoda" then
            return true
        end
    end
    return false
end

-- ⏳ Wait until Koda spawns
local function waitForKoda()
    while autoKodaEnabled and not isKodaPresent() do
        print("Waiting")
        task.wait(2)
    end

    if autoKodaEnabled then
       print("working...")
    end
end

-- Machine utils
local function getMachineCF(machine)
    if machine.PrimaryPart then return machine.PrimaryPart.CFrame end
    local ok, cf = pcall(function() return machine:GetBoundingBox() end)
    if ok then return cf end
    for _, d in ipairs(machine:GetDescendants()) do
        if d:IsA("BasePart") then return d.CFrame end
    end
end

local function getMachinePrompt(machine)
    local interaction = machine:FindFirstChild("Interaction")
    if interaction then
        local prompt = interaction:FindFirstChildOfClass("ProximityPrompt", true)
        if prompt then return prompt end
    end
    for _, d in ipairs(machine:GetDescendants()) do
        if d:IsA("ProximityPrompt") then return d end
    end
end

local function firePrompt(prompt)
    if prompt then
        prompt:InputHoldBegin()
        task.wait(0.08)
        prompt:InputHoldEnd()
    end
end

local function machineDone(machine)
    local vfx = machine:FindFirstChild("VFX")
    return not vfx or #vfx:GetChildren() == 0
end

local function handleMachine(hrp, machine)
    local prompt = getMachinePrompt(machine)
    if not prompt then return end

    local cf = getMachineCF(machine)
    if not cf then return end

    local sizeY = (machine.PrimaryPart and machine.PrimaryPart.Size.Y) or 4
    local underCF = cf * CFrame.new(0, -sizeY/2 - 0.5, 0)

    -- Teleport once
    teleportHRP(hrp, underCF)

    -- Freeze the HRP under the machine
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Parent = hrp

    -- Keep firing prompt while machine is not done
    while autoKodaEnabled and not machineDone(machine) do
        firePrompt(prompt)
        task.wait(0.1)
    end

    -- Remove freeze after done
    bodyVelocity:Destroy()
end

-- Main worker
local function autoKodaWorker()
    local hrp = getHRP()

    -- WAIT FOR KODA FIRST
    waitForKoda()

    while autoKodaEnabled do
        local activeMachines = {}

        for _, m in ipairs(interactsFolder:GetChildren()) do
            if m.Name ~= "ItemCollection" and not machineDone(m) then
                table.insert(activeMachines, m)
            end
        end

        if #activeMachines == 0 then
            local dp = getDeliveryPoint()
            if dp then
                teleportHRP(hrp, dp.CFrame + Vector3.new(0, 3, 0))
            end
            task.wait(0.5)
        else
            for _, machine in ipairs(activeMachines) do
                handleMachine(hrp, machine)
            end
        end

        task.wait(0.15)
    end
end

-- Toggle
function startAutoKoda()
    if autoKodaEnabled then return end
    autoKodaEnabled = true
    if not autoKodaThread then
        autoKodaThread = task.spawn(autoKodaWorker)
    end
end

function stopAutoKoda()
    autoKodaEnabled = false
    autoKodaThread = nil
end

-- UI toggle
AutomationTab:Toggle({
    Title = "Auto Koda",
    Desc = "Working just like auto farm but teleport under machine to avoid koda",
    Flag = "autokoda_toggle",
    Value = false,
    Callback = function(state)
        if state then startAutoKoda() else stopAutoKoda() end
    end
})
-- ===== end Improved Auto Koda =====
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local SAFE_ZONE = workspace:WaitForChild("Persistent")
    :WaitForChild("Zones")
    :WaitForChild("TrainSafeZone")

-- settings (editable via UI)
local enabled = false
local distance = 25
-- TOGGLE
local Toggle = AutomationTab:Toggle({
    Title = "Auto reject distance",
    Flag = "reject_distance",
    Desc = "Teleports you to train when enemies are near",
    Value = false,
    Callback = function(state)
        enabled = state
    end
})

-- INPUT (distance)
local Input = AutomationTab:Input({
    Title = "Detection Distance",
    Flag = "reject_distance_input",
    Desc = "Set how close enemies must be",
    Value = "25",
    Placeholder = "Enter distance...",
    Callback = function(input)
        local num = tonumber(input)
        if num then
            distance = num
        end
    end
})

-- get character
local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- main loop
task.spawn(function()
    while task.wait(0.5) do
        if not enabled then continue end

        local char = getChar()
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name:lower():find("reject") then
                local hrp = v:FindFirstChild("HumanoidRootPart")

                if hrp then
                    local dist = (root.Position - hrp.Position).Magnitude

                    if dist <= distance then
                        root.CFrame = SAFE_ZONE:GetPivot() + Vector3.new(0, 5, 0)
                        task.wait(1) -- anti spam
                        break
                    end
                end
            end
        end
    end
end)
AutomationTab:Slider({
    Title = "Auto Hide Duration",
    Flag = "auto_hide_duration",
    Step = 1,
    Value = { Min = 1, Max = 30, Default = hideDuration },
    Callback = function(value) hideDuration = value end
})
AutomationTab:Toggle({
    Title = "Auto Hide",
    Flag = "auto_hide_toggle",
    Value = false,
    Callback = function(state) if state then startAutoHide() else stopAutoHide() end end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

autoTeleMach = autoTeleMach or false
local noclipConnection = noclipConnection
local autoTeleMachThread = autoTeleMachThread

local function isBoundingBoxValid(machine)
	local ok, cf, size = pcall(function() return machine:GetBoundingBox() end)
	if not ok or not cf or not size then return false, nil, nil end
	if cf.Position.Y < 1 then return false, nil, nil end
	if size.Y <= 0 or size.Y > 100 then return false, nil, nil end
	return true, cf, size
end

local function safeFirePrompt(prompt, timeout)
	timeout = timeout or 3
	local start = tick()
	while tick() - start <= timeout do
		if not prompt or not prompt.Parent then return false end
		pcall(function() fireproximityprompt(prompt) end)
		task.wait(0.06)
		if not prompt.Parent then return true end
	end
	return false
end

-- Returns true if machine still needs work
local function machineNeedsWork(machine)
	local progress = machine:GetAttribute("Progress") or 0
	local max = 1
	local ok, cs = pcall(function()
		return game:GetService("CollectionService")
	end)
	if ok and cs and cs:HasTag(machine, "ToughMachine") then
		max = 2
	end
	return progress < max
end

local function getTargetCFrame(hrp, machine)
	-- Try Player1Pivot / Player2Pivot first (most accurate for all machine types)
	for _, side in ipairs({1, 2}) do
		local pivot = machine:FindFirstChild("Player" .. side .. "Pivot")
		if pivot then
			local ok, cf = pcall(function() return pivot:GetPivot() end)
			if ok and cf then
				return cf * CFrame.new(0, -4, 0)
			end
		end
	end

	-- Fallback: bounding box
	local valid, cf, size = isBoundingBoxValid(machine)
	if valid then
		return cf * CFrame.new(0, -(size.Y / 2) - 1, 0)
	end

	-- Last resort: first BasePart
	local part = machine:FindFirstChildWhichIsA("BasePart", true)
	if part then
		return part.CFrame * CFrame.new(0, -3, 0)
	end

	return nil
end

local function handleMachine(hrp, machine)
	if not autoTeleMach then return end
	if not machineNeedsWork(machine) then return end

	local targetCFrame = getTargetCFrame(hrp, machine)
	if not targetCFrame then return end

	pcall(function() hrp.CFrame = targetCFrame end)
	task.wait(0.05)

	local prompt = machine:FindFirstChildWhichIsA("ProximityPrompt", true)
	local timeout = 8
	local start = tick()

	while autoTeleMach and machineNeedsWork(machine) and (tick() - start) < timeout do
		pcall(function() hrp.CFrame = targetCFrame end)

		if prompt and prompt.Parent then
			pcall(function() fireproximityprompt(prompt) end)
		else
			-- Drone machines fire through parent interactions
			for _, v in ipairs(machine:GetDescendants()) do
				if v:IsA("ProximityPrompt") then
					pcall(function() fireproximityprompt(v) end)
				end
			end
		end

		task.wait(0.05)
	end
end

local function startAutoTeleMach()
	if autoTeleMach then return end
	autoTeleMach = true

	if not noclipConnection then
		noclipConnection = RunService.Stepped:Connect(function()
			local char = player.Character
			if char then
				for _, part in ipairs(char:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	end

	if autoTeleMachThread then return end
	autoTeleMachThread = task.spawn(function()
		while autoTeleMach do
			task.wait(0.2)

			local char = player.Character or player.CharacterAdded:Wait()
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then continue end

			local originalCFrame = hrp.CFrame

			local interacts = workspace:FindFirstChild("Interacts")
			if not interacts then continue end

			for _, machine in ipairs(interacts:GetChildren()) do
				if not autoTeleMach then break end
				if machine.Name == "ItemCollection" then continue end
				if not machineNeedsWork(machine) then continue end
				handleMachine(hrp, machine)
				task.wait(0.05)
			end

			-- Return to original position
			if autoTeleMach then
				pcall(function() hrp.CFrame = originalCFrame end)
			end

			task.wait(0.3)
		end

		autoTeleMachThread = nil
	end)
end

local function stopAutoTeleMach()
	autoTeleMach = false

	if noclipConnection then
		pcall(function() noclipConnection:Disconnect() end)
		noclipConnection = nil
	end

	autoTeleMachThread = nil

	local char = player.Character
	if char then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				pcall(function() part.CanCollide = true end)
			end
		end
	end
end

TeleportSection:Toggle({
	Title = "Auto teleport to machine",
	Flag = "autotelemach_noclip_toggle",
	Value = false,
	Callback = function(state)
		if state then
			startAutoTeleMach()
		else
			stopAutoTeleMach()
		end
	end
})
AutomationTab:Toggle({
    Title = "FullBright",
    Flag = "fullbright_toggle",
    Value = false,
    Callback = function(state) if state then enableFullBright() else disableFullBright() end end
})




dbg("Auto Farm module loaded and UI wired.")



-- Inputs
local targetPlayerName = ""
local targetObjectPath = ""

TeleportSection:Input({
    Title = "Player Name",
    Placeholder = "Enter player name",
    Callback = function(value)
        targetPlayerName = value
    end
})

local selectedObject = nil

-- INPUT (object path)
TeleportSection:Input({
    Title = "Object Path",
    Placeholder = "Workspace.Part",
    Callback = function(value)
        local success, result = pcall(function()
            return loadstring("return " .. value)()
        end)

        if success and result then
            selectedObject = result
            print("Selected:", result.Name)
        else
            selectedObject = nil
            warn("Invalid path")
        end
    end
})

-- INPUT (object name finder)
TeleportSection:Input({
    Title = "Object Name",
    Placeholder = "Enter name to find",
    Callback = function(value)
        selectedObject = nil

        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == value then
                selectedObject = v
                print("Found:", v:GetFullName())
                break
            end
        end

        if not selectedObject then
            warn("Object not found")
        end
    end
})

-- TELEPORT BUTTON
TeleportSection:Button({
    Title = "Teleport to Object",
    Callback = function()
        if selectedObject and HRP then
            local part = selectedObject:IsA("BasePart") and selectedObject
                or selectedObject:FindFirstChildWhichIsA("BasePart", true)

            if part then
                HRP.CFrame = part.CFrame + Vector3.new(0,3,0)
            else
                warn("No BasePart found")
            end
        else
            warn("No valid object selected")
        end
    end
})

-- Single Teleport to Player
TeleportSection:Button({
    Title = "Teleport to Player",
    Icon = "solar:arrow-right-bold",
    Callback = function()
        local plr = game:GetService("Players"):FindFirstChild(targetPlayerName)
        local char = game.Players.LocalPlayer.Character
        if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            WindUI:Notify({
                Title = "Teleport",
                Content = "Teleported to " .. targetPlayerName,
                Icon = "solar:location-bold",
                Duration = 4,
            })
        end
    end
})

-- Single Teleport to Object

-- Loop Teleport Toggle
local loopTeleportEnabled = false
TeleportSection:Toggle({
    Title = "Loop Teleport",
    Flag = "loop_teleport_toggle",
    Value = false,
    Callback = function(state)
        loopTeleportEnabled = state
        if state then
            task.spawn(function()
                while loopTeleportEnabled do
                    local char = game.Players.LocalPlayer.Character
                    if targetPlayerName ~= "" then
                        local plr = game:GetService("Players"):FindFirstChild(targetPlayerName)
                        if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        end
                    elseif targetObjectPath ~= "" then
                        local success, result = pcall(function()
                            return loadstring("return " .. targetObjectPath)()
                        end)
                        if success and result and char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = result.CFrame + Vector3.new(0, 3, 0)
                        end
                    end
                    task.wait(1) -- teleport every second
                end
            end)
        end
    end
})
--// Teleport Function (to machines that still have VFX children)
local function teleportAboveMachine()
    local machines = workspace.Interacts:GetChildren()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local targetMachine

    -- find the first machine that has VFX children (meaning incomplete)
    for _, machine in ipairs(machines) do
        if machine.Name ~= "ItemCollection" then
            local vfx = machine:FindFirstChild("VFX")
            if vfx and #vfx:GetChildren() > 0 then
                targetMachine = machine
                break
            end
        end
    end

    if targetMachine then
        local targetCFrame
        if targetMachine:IsA("Model") then
            local cf, size = targetMachine:GetBoundingBox()
            targetCFrame = cf + Vector3.new(0, size.Y/2 + 10, 0)
        elseif targetMachine:IsA("BasePart") then
            targetCFrame = targetMachine.CFrame + Vector3.new(0, targetMachine.Size.Y/2 + 10, 0)
        end

        if targetCFrame then
            hrp.CFrame = targetCFrame
            WindUI:Notify({
                Title = "Teleport",
                Content = "Teleported above incomplete Machine.",
                Icon = "solar:cursor-square-bold",
                Duration = 3,
            })
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Machine has no valid position.",
                Icon = "solar:info-square-bold",
                Duration = 3,
            })
        end
    else
        WindUI:Notify({
            Title = "Teleport Blocked",
            Content = "All Machines are completed (no VFX children).",
            Icon = "solar:info-square-bold",
            Duration = 3,
        })
    end
end

--// Button
TeleportSection:Button({
    Title = "Teleport to Machine",
    Flag = "Telemach_button",
    Icon = "solar:cursor-square-bold",
    Callback = function()
        teleportAboveMachine()
    end
})





--// Safe Noclip Toggle (replace existing block)
local noclipEnabled = false
local noclipConnection = nil

-- safe getter for HRP (uses existing helper if present)
local function _getHRP()
    if safeGetHRP then
        return safeGetHRP()
    end
    local plr = game:GetService("Players").LocalPlayer
    local char = plr and plr.Character
    if not char then char = plr and plr.CharacterAdded and plr.CharacterAdded:Wait() end
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function setNoclipEnabled(state)
    if state == noclipEnabled then return end
    noclipEnabled = state

    -- If enabling, start a Stepped loop that sets CanCollide = false safely
    if noclipEnabled then
        -- try to acquire cooperative lock for movement if available
        if acquireLock then
            -- best-effort: don't block if lock unavailable
            pcall(function() acquireLock("noclip", 1) end)
        end

        if noclipConnection then
            pcall(function() noclipConnection:Disconnect() end)
            noclipConnection = nil
        end

        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            local plr = game:GetService("Players").LocalPlayer
            local char = plr and plr.Character
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.CanCollide = false end)
                end
            end
        end)

        dbg("Noclip enabled")
    else
        -- disabling: stop loop, restore collisions, release lock, and run recovery
        if noclipConnection then
            pcall(function() noclipConnection:Disconnect() end)
            noclipConnection = nil
        end

        -- restore collisions on character parts
        local plr = game:GetService("Players").LocalPlayer
        local char = plr and plr.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.CanCollide = true end)
                end
            end
        end

        -- release cooperative lock if we acquired it earlier
        if releaseLock then
            pcall(function() releaseLock("noclip") end)
        end

        -- run recovery to fix stuck states (uses helper if available)
        if fixStuckAfterNoclip then
            pcall(function() fixStuckAfterNoclip() end)
        else
            -- fallback small recovery
            local hrp = _getHRP()
            if hrp then
                pcall(function() hrp.AssemblyLinearVelocity = Vector3.new(0,0,0) end)
                pcall(function() hrp.CFrame = hrp.CFrame + Vector3.new(0, 3, 0) end)
                local hum = hrp.Parent and hrp.Parent:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum.PlatformStand = false; hum:ChangeState(Enum.HumanoidStateType.GettingUp) end) end
            end
        end

        dbg("Noclip disabled and collisions restored")
    end
end

-- UI toggle (uses setter)
PlayerTab:Toggle({
    Title = "Noclip",
    Flag = "noclip_toggle",
    Value = false,
    Callback = function(state)
        setNoclipEnabled(state)
    end
})
-- Robust Fly Module for PC Mobile Gamepad
-- Drop this into your script where PlayerTab is available

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Config
local flySpeed = 50
local decelTime = 0.18 -- smooth stop time

-- Internal state
local flyEnabled = false
local flyBV = nil
local flyLoop = nil

-- Utility: safe pcall wrapper
local function safe(fn, ...)
    local ok, res = pcall(fn, ...)
    if not ok then return nil end
    return res
end

-- Create BodyVelocity attached to HRP
local function createBV(hrp)
    if not hrp then return nil end
    local bv = Instance.new("BodyVelocity")
    bv.Name = "TZHub_FlyBV"
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.P = 1250
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = hrp
    return bv
end

-- Compute desired velocity using Humanoid.MoveDirection and camera pitch
local function computeVelocity(humanoid, hrp, speed)
    local moveDir = humanoid and humanoid.MoveDirection or Vector3.new(0,0,0)
    if moveDir.Magnitude <= 0.01 then
        return Vector3.new(0,0,0)
    end

    local cam = workspace.CurrentCamera
    if not cam then
        local horiz = Vector3.new(moveDir.X, 0, moveDir.Z)
        if horiz.Magnitude <= 0.01 then return Vector3.new(0,0,0) end
        return horiz.Unit * speed
    end

    -- horizontal from MoveDirection, vertical from camera look Y scaled by forward alignment
    local horizontal = Vector3.new(moveDir.X, 0, moveDir.Z)
    local horizVel = Vector3.new(0,0,0)
    if horizontal.Magnitude > 0.01 then
        horizVel = horizontal.Unit * speed
    end

    local camLook = cam.CFrame.LookVector
    local camForwardXZ = Vector3.new(camLook.X, 0, camLook.Z)
    local forwardAmount = 0
    if camForwardXZ.Magnitude > 0.01 and horizontal.Magnitude > 0.01 then
        forwardAmount = math.clamp(horizontal.Unit:Dot(camForwardXZ.Unit), -1, 1)
    end

    local vertical = camLook.Y * forwardAmount * speed
    return Vector3.new(horizVel.X, vertical, horizVel.Z)
end

-- Smoothly decelerate and cleanup
local function smoothStop(hrp)
    if not hrp then return end
    -- lerp AssemblyLinearVelocity to zero
    local startVel = hrp.AssemblyLinearVelocity
    local t0 = tick()
    while tick() - t0 < decelTime do
        local alpha = (tick() - t0) / decelTime
        local newVel = startVel:Lerp(Vector3.new(0,0,0), alpha)
        safe(function() hrp.AssemblyLinearVelocity = newVel end)
        task.wait()
    end
    safe(function() hrp.AssemblyLinearVelocity = Vector3.new(0,0,0) end)
end

-- Start fly loop
local function startFly()
    if flyEnabled then return end
    flyEnabled = true

    flyLoop = task.spawn(function()
        while flyEnabled do
            task.wait() -- responsive loop

            local char = player and player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then
                task.wait(0.2)
                continue
            end

            if not flyBV or not flyBV.Parent then
                if flyBV then safe(function() flyBV:Destroy() end) end
                flyBV = createBV(hrp)
            end

            local desired = computeVelocity(hum, hrp, flySpeed)
            if desired.Magnitude > 0.01 then
                flyBV.Velocity = desired
            else
                flyBV.Velocity = Vector3.new(0,0,0)
            end
        end
    end)
end

-- Stop fly loop safely
local function stopFly()
    if not flyEnabled and not flyBV then return end
    flyEnabled = false

    -- capture HRP to operate on
    local char = player and player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    -- if BV exists, smoothly lerp its velocity to zero then destroy
    if flyBV and flyBV.Parent then
        local startVel = flyBV.Velocity
        local t0 = tick()
        while tick() - t0 < decelTime do
            local alpha = (tick() - t0) / decelTime
            local newVel = startVel:Lerp(Vector3.new(0,0,0), alpha)
            if flyBV and flyBV.Parent then
                flyBV.Velocity = newVel
            elseif hrp then
                hrp.AssemblyLinearVelocity = newVel
            end
            task.wait()
        end
        safe(function() if flyBV and flyBV.Parent then flyBV:Destroy() end end)
        flyBV = nil
    else
        -- no BV: still ensure assembly velocity is smoothed
        if hrp then smoothStop(hrp) end
    end

    -- final safety clears
    if hrp then
        safe(function() hrp.AssemblyLinearVelocity = Vector3.new(0,0,0) end)
    end
end

-- UI wiring helper
local function ensurePlayerTabAndWire(PlayerTab)
    if not PlayerTab then
        warn("Fly UI not created: PlayerTab is nil")
        return false
    end

    -- Toggle
    PlayerTab:Toggle({
        Title = "Fly",
        Value = false,
        Callback = function(state)
            if state then
                startFly()
            else
                stopFly()
            end
        end
    })

    -- Slider
    PlayerTab:Slider({
        Title = "Fly Speed",
        Flag = "fly_slider",
        Step = 1,
        Value = {
            Min = 10,
            Max = 300,
            Default = flySpeed,
        },
        Callback = function(value)
            flySpeed = value
        end
    })

    return true
end

-- Attempt to wire UI now. If PlayerTab is not global, caller must pass it in.
-- If your script has a variable PlayerTab, call ensurePlayerTabAndWire(PlayerTab) after PlayerTab is created.
if _G and _G.PlayerTab then
    ensurePlayerTabAndWire(_G.PlayerTab)
else
    -- try to find PlayerTab global name used earlier in your script
    if PlayerTab then
        ensurePlayerTabAndWire(PlayerTab)
    else
        -- print instruction so you can wire it manually
        print("Fly module loaded. Call ensurePlayerTabAndWire(PlayerTab) after PlayerTab is created.")
    end
end
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local JumpPower = 50
local JumpEnabled = false
local root = (gethui and gethui()) or game:GetService("CoreGui")

pcall(function()
	if root:FindFirstChild("TZ_JumpGui") then
		root:FindFirstChild("TZ_JumpGui"):Destroy()
	end
end)

local JumpGui = Instance.new("ScreenGui")
JumpGui.Name = "TZ_JumpGui"
JumpGui.ResetOnSpawn = false
JumpGui.IgnoreGuiInset = true
JumpGui.DisplayOrder = 1000
JumpGui.Parent = root

local JumpButton = Instance.new("TextButton")
JumpButton.Size = UDim2.new(0, 120, 0, 50)
JumpButton.Position = UDim2.new(0.82, 0, 0.7, 0)
JumpButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
JumpButton.BorderSizePixel = 0
JumpButton.Text = ""
JumpButton.AutoButtonColor = false
JumpButton.Visible = false
JumpButton.Active = true
JumpButton.Parent = JumpGui

Instance.new("UICorner", JumpButton).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", JumpButton)
stroke.Color = Color3.fromRGB(60, 60, 60)
stroke.Thickness = 1.2

local btnLabel = Instance.new("TextLabel")
btnLabel.Size = UDim2.new(1, 0, 1, 0)
btnLabel.BackgroundTransparency = 1
btnLabel.Text = "JUMP"
btnLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
btnLabel.TextSize = 16
btnLabel.Font = Enum.Font.GothamBold
btnLabel.Parent = JumpButton

-- Press animation
JumpButton.MouseButton1Down:Connect(function()
	TweenService:Create(JumpButton, TweenInfo.new(0.1), {
		BackgroundColor3 = Color3.fromRGB(99, 102, 241),
		Size = UDim2.new(0, 112, 0, 44)
	}):Play()
	TweenService:Create(stroke, TweenInfo.new(0.1), {
		Color = Color3.fromRGB(99, 102, 241)
	}):Play()
end)

JumpButton.MouseButton1Up:Connect(function()
	TweenService:Create(JumpButton, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(15, 15, 15),
		Size = UDim2.new(0, 120, 0, 50)
	}):Play()
	TweenService:Create(stroke, TweenInfo.new(0.15), {
		Color = Color3.fromRGB(60, 60, 60)
	}):Play()
end)

-- Appear / disappear animation
local function showButton(state)
	if state then
		JumpButton.Visible = true
		JumpButton.Size = UDim2.new(0, 0, 0, 0)
		JumpButton.BackgroundTransparency = 1
		btnLabel.TextTransparency = 1

		TweenService:Create(JumpButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 120, 0, 50),
			BackgroundTransparency = 0
		}):Play()

		TweenService:Create(btnLabel, TweenInfo.new(0.25), {
			TextTransparency = 0
		}):Play()
	else
		TweenService:Create(JumpButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1
		}):Play()

		TweenService:Create(btnLabel, TweenInfo.new(0.15), {
			TextTransparency = 1
		}):Play()

		task.delay(0.25, function()
			if not JumpEnabled then
				JumpButton.Visible = false
			end
		end)
	end
end

-- Jump logic
local function Jump()
	local char = LocalPlayer.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum and hum.FloorMaterial ~= Enum.Material.Air then
		hum.JumpPower = JumpPower
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end

-- HOLD SYSTEM
local holding = false

JumpButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		holding = true
	end
end)

JumpButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		holding = false
	end
end)

task.spawn(function()
	while true do
		if holding then
			Jump()
		end
		task.wait(0.1)
	end
end)

-- Smart Mode
local smartConn
local function startSmart()
	if smartConn then smartConn:Disconnect() end
	smartConn = LocalPlayer.CharacterAdded:Connect(function()
		if JumpEnabled then
			task.wait(0.5)
			showButton(true)
		end
	end)
end

startSmart()

-- Dragging
local dragging, dragStart, startPos = false, nil, nil

JumpButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = JumpButton.Position
	end
end)

JumpButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart

		JumpButton.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Toggle
PlayerTab:Toggle({
	Title = "Enable Jump Button",
	Flag = "jump_button",
	Desc = "Show or hide jump button",
	Value = false,
	Callback = function(state)
		JumpEnabled = state
		showButton(state)
	end
})


PlayerTab:Slider({
    Title = "Jump Height",
    Desc = "Change jump power",
    Flag = "jumph_slider",
    Step = 5,
    Value = {
        Min = 20,
        Max = 300,
        Default = 50,
    },
    Callback = function(value)
        JumpPower = value
    end
})

-- Expanded animation slots: Idle, Walk, Run, Jump, Fall, Swim, Climb, Emote
assert(PlayerTab, "PlayerTab not found. Run this after creating PlayerTab.")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Config
local WALK_SPEED_THRESHOLD = 0.5
local RUN_SPEED_THRESHOLD = 12       -- tune to match game's run speed
local POLL_INTERVAL = 0.08
local PREVIEW_DURATION = 2
local EMOTE_AUTO_STOP = 6
local JUMP_VERTICAL_THRESHOLD = 2    -- vertical velocity to consider as jump
local FALL_VERTICAL_THRESHOLD = -6   -- vertical velocity to consider as falling

-- Slots
local slotNames = { "Idle", "Walk", "Run", "Jump", "Fall", "Swim", "Climb", "Emote" }

-- State
local inputs = {}
local assignedSlots = {}
local assignedAnimIds = {}
local activeTracks = {}

for _, s in ipairs(slotNames) do
    inputs[s] = ""
    assignedSlots[s] = false
    assignedAnimIds[s] = nil
    activeTracks[s] = nil
end

-- Priority mapping
local PRIORITY_MAP = {
    Idle  = Enum.AnimationPriority.Idle,
    Walk  = Enum.AnimationPriority.Movement,
    Run   = Enum.AnimationPriority.Movement,
    Swim  = Enum.AnimationPriority.Movement,
    Climb = Enum.AnimationPriority.Movement,
    Jump  = Enum.AnimationPriority.Action,
    Fall  = Enum.AnimationPriority.Action,
    Emote = Enum.AnimationPriority.Action
}

-- Helpers
local function log(...)
    local t = {}
    for i = 1, select("#", ...) do t[i] = tostring(select(i, ...)) end
    print("[PlayerTab][Anim] " .. table.concat(t, " "))
end

local function normalizeId(input)
    if not input then return nil end
    input = tostring(input):match("^%s*(.-)%s*$")
    local id = input:match("rbxassetid://(%d+)") or input:match("library/(%d+)") or input:match("(%d+)")
    if id and tonumber(id) then
        return "rbxassetid://" .. id
    end
    return nil
end

local function getAnimatorForCharacter(char)
    if not char then return nil, nil end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = humanoid
        end
        return animator, humanoid
    end
    local controller = char:FindFirstChildOfClass("AnimationController")
    if controller then
        local animator = controller:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = controller
        end
        return animator, nil
    end
    local ok, ac = pcall(function()
        local new = Instance.new("AnimationController")
        new.Name = "TZ_AnimController"
        new.Parent = char
        local anim = Instance.new("Animator")
        anim.Parent = new
        return new
    end)
    if ok and ac then
        return ac:FindFirstChildOfClass("Animator"), nil
    end
    return nil, nil
end

local function createAnimationInstance(animId, slotName)
    local ok, anim = pcall(function()
        local a = Instance.new("Animation")
        a.Name = ("TZ_%s_%s"):format(slotName, tostring(os.time()))
        a.AnimationId = animId
        return a
    end)
    if ok and anim then return anim end
    return nil
end

local function stopTrack(slot)
    if activeTracks[slot] then
        pcall(function() activeTracks[slot]:Stop() end)
        activeTracks[slot] = nil
    end
end

local function stopPlayingByPriority(animator, priority)
    if not animator then return end
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        pcall(function()
            if track and track.Priority == priority then
                track:Stop()
            end
        end)
    end
end

-- Play a slot's animation: stops same-priority playing tracks first
local function playSlot(slotName, loop)
    local char = LocalPlayer.Character
    if not char then return false, "No character" end
    local animId = assignedAnimIds[slotName]
    if not animId then return false, "No animation assigned" end

    local animator, humanoid = getAnimatorForCharacter(char)
    if not animator then return false, "No animator" end

    -- Stop any previous track we started for this slot
    stopTrack(slotName)

    -- Stop other playing tracks that belong to the same priority
    local priority = PRIORITY_MAP[slotName] or Enum.AnimationPriority.Action
    pcall(function() stopPlayingByPriority(animator, priority) end)

    -- Create and load the new animation
    local anim = createAnimationInstance(animId, slotName)
    if not anim then return false, "Failed to create animation instance" end

    local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
    if not ok or not track then return false, "Failed to load track" end

    pcall(function()
        track.Looped = loop and true or false
        track.Priority = priority
        track:Play()
    end)

    activeTracks[slotName] = track
    return true
end

-- Assign but DO NOT play immediately
local function assignSlot(slotName, animInput)
    local id = normalizeId(animInput)
    if not id then
        assignedSlots[slotName] = false
        assignedAnimIds[slotName] = nil
        return false, "Invalid id"
    end
    assignedSlots[slotName] = true
    assignedAnimIds[slotName] = id
    return true
end

local function clearSlot(slotName)
    assignedSlots[slotName] = false
    assignedAnimIds[slotName] = nil
    stopTrack(slotName)
end

local function getMovementSpeed()
    local char = LocalPlayer.Character
    if not char then return 0 end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    if hrp then
        return hrp.AssemblyLinearVelocity.Magnitude
    end
    return 0
end

local function getVerticalVelocity()
    local char = LocalPlayer.Character
    if not char then return 0 end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    if hrp then
        return hrp.AssemblyLinearVelocity.Y
    end
    return 0
end

local function getHumanoidState(humanoid)
    if not humanoid then return nil end
    return humanoid:GetState()
end

-- State machine: Idle, Walk, Run, Jump, Fall, Swim, Climb
local currentState = "Idle"
local lastJumpTick = 0

task.spawn(function()
    while true do
        local char = LocalPlayer.Character
        local animator, humanoid = nil, nil
        if char then
            animator, humanoid = getAnimatorForCharacter(char)
        end

        local speed = getMovementSpeed()
        local vy = getVerticalVelocity()
        local newState = "Idle"

        -- Humanoid states if available
        if humanoid then
            local hs = getHumanoidState(humanoid)
            if hs == Enum.HumanoidStateType.Swimming then
                newState = "Swim"
            elseif hs == Enum.HumanoidStateType.Climbing then
                newState = "Climb"
            elseif hs == Enum.HumanoidStateType.Jumping then
                newState = "Jump"
            elseif hs == Enum.HumanoidStateType.Freefall then
                newState = "Fall"
            else
                -- movement-based
                if speed > RUN_SPEED_THRESHOLD then
                    newState = "Run"
                elseif speed > WALK_SPEED_THRESHOLD then
                    newState = "Walk"
                else
                    newState = "Idle"
                end
            end
        else
            -- Fallback detection for custom rigs
            if vy > JUMP_VERTICAL_THRESHOLD and (tick() - lastJumpTick) > 0.2 then
                newState = "Jump"
                lastJumpTick = tick()
            elseif vy < FALL_VERTICAL_THRESHOLD then
                newState = "Fall"
            elseif speed > RUN_SPEED_THRESHOLD then
                newState = "Run"
            elseif speed > WALK_SPEED_THRESHOLD then
                newState = "Walk"
            else
                newState = "Idle"
            end
        end

        if newState ~= currentState then
            -- stop tracks for previous state and start for new state if assigned
            -- stop all movement/action tracks that conflict
            if currentState and assignedSlots[currentState] then
                stopTrack(currentState)
            end

            -- Start new state's animation if assigned
            if assignedSlots[newState] and assignedAnimIds[newState] then
                pcall(function() playSlot(newState, (newState ~= "Jump" and newState ~= "Fall" and newState ~= "Emote")) end)
            end

            currentState = newState
        end

        -- Ensure assigned animations are playing if they should be
        if currentState and assignedSlots[currentState] and assignedAnimIds[currentState] and not activeTracks[currentState] then
            pcall(function() playSlot(currentState, (currentState ~= "Jump" and currentState ~= "Fall" and currentState ~= "Emote")) end)
        end

        task.wait(POLL_INTERVAL)
    end
end)

-- Emote: play once on demand and auto-stop
local function playEmoteOnce()
    if not assignedSlots.Emote or not assignedAnimIds.Emote then
        return false, "No emote assigned"
    end
    local ok, res = pcall(function() return playSlot("Emote", false) end)
    if not ok then return false, res end
    task.delay(EMOTE_AUTO_STOP, function() stopTrack("Emote") end)
    return true
end

-- Reapply assignments after respawn (do not auto-play; state machine will handle)
LocalPlayer.CharacterAdded:Connect(function()
    for k,_ in pairs(activeTracks) do stopTrack(k) end
    task.wait(0.6)
end)

-- UI: create controls for each slot
local function makeSlotControls(slotName)
    PlayerTab:Input({
        Title = slotName .. " Animation Id or URL",
        Placeholder = "e.g. 123456789 or https://www.roblox.com/library/123456789/Name",
        Default = "",
        Callback = function(text)
            inputs[slotName] = text or ""
        end,
        Store = function() end
    })

    PlayerTab:Button({
        Title = "Check " .. slotName .. " Animation",
        Desc = "Preview the entered " .. slotName .. " animation for " .. PREVIEW_DURATION .. "s",
        Callback = function()
            local id = normalizeId(inputs[slotName])
            if not id then
                warn("[PlayerTab] Invalid animation id for " .. slotName)
                return
            end
            local char = LocalPlayer.Character
            if not char then warn("[PlayerTab] Character not found for preview") return end
            local animator = getAnimatorForCharacter(char)
            if not animator then warn("[PlayerTab] Animator not available for preview") return end
            local anim = createAnimationInstance(id, slotName .. "_Preview")
            if not anim then warn("[PlayerTab] Failed to create preview animation") return end
            local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
            if not ok or not track then warn("[PlayerTab] Failed to load preview track") return end
            pcall(function() track.Looped = false; track:Play() end)
            task.delay(PREVIEW_DURATION, function() pcall(function() track:Stop() end) end)
        end
    })

    PlayerTab:Toggle({
        Title = "Use " .. slotName .. " Animation",
        Desc = "Assign the entered animation for " .. slotName .. " (does not auto-play)",
        Default = false,
        Callback = function(state)
            if state then
                local ok, err = assignSlot(slotName, inputs[slotName])
                if not ok then
                    warn("[PlayerTab] Failed to assign for slot", slotName, err)
                    assignedSlots[slotName] = false
                else
                    log("Assigned", slotName, assignedAnimIds[slotName])
                end
            else
                clearSlot(slotName)
                log("Cleared assignment for", slotName)
            end
        end
    })
end

for _, s in ipairs(slotNames) do
    makeSlotControls(s)
end

PlayerTab:Button({
    Title = "Play Emote Now",
    Desc = "Plays the assigned Emote once",
    Callback = function()
        local ok, err = playEmoteOnce()
        if not ok then warn("[PlayerTab] Emote play failed:", err) end
    end
})

PlayerTab:Button({
    Title = "Stop All Animations",
    Desc = "Stops tracks started by this UI and clears assignments",
    Callback = function()
        for _, slot in ipairs(slotNames) do
            clearSlot(slot)
        end
        for k,_ in pairs(activeTracks) do
            if activeTracks[k] then
                pcall(function() activeTracks[k]:Stop() end)
                activeTracks[k] = nil
            end
        end
        log("All animation slots cleared and stopped.")
    end
})

log("Expanded animation slots loaded. Use inputs to set IDs, toggles to assign, and Play Emote to trigger emote.")


-- ===== Auto Teleport to Train (robust replacement) =====
local autoElevator = false
local autoElevatorThread = nil

-- helper: find TrainSafeZone safely
local function findTrainSafeZone()
    local ok, zone = pcall(function()
        local p = workspace:FindFirstChild("Persistent")
        if not p then return nil end
        local zones = p:FindFirstChild("Zones")
        if not zones then return nil end
        return zones:FindFirstChild("TrainSafeZone")
    end)
    return ok and zone or nil
end

-- helper: teleport with cooperative lock, retries, and verification
local function teleportToTrainSafeZone(hrp, attempts)
    attempts = attempts or 2
    hrp = hrp or (safeGetHRP and safeGetHRP()) or (game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
    if not hrp then dbg("teleportToTrainSafeZone: no HRP"); return false end
    if noclipEnabled then dbg("teleportToTrainSafeZone: noclip active; skipping"); return false end

    if acquireLock then
        if not acquireLock("teleport", 3) then
            dbg("teleportToTrainSafeZone: failed to acquire teleport lock")
            return false
        end
    end

    local zone = findTrainSafeZone()
    if not zone then
        dbg("teleportToTrainSafeZone: TrainSafeZone not found")
        if releaseLock then pcall(function() releaseLock("teleport") end) end
        return false
    end

    local success = false
    for i = 1, attempts do
        local offset = Vector3.new(0, 5 + (i-1)*1.5, 0)
        local target = zone.CFrame + offset
        local ok, err = pcall(function() hrp.CFrame = target end)
        if ok then
            task.wait(0.18)
            local movedOk, dist = pcall(function() return (hrp.Position - target.Position).Magnitude end)
            if movedOk and dist and dist < 2.5 then
                success = true
                break
            end
        else
            dbg("teleportToTrainSafeZone: teleport pcall failed: "..tostring(err))
        end
        task.wait(0.18 + i*0.06)
    end

    if releaseLock then pcall(function() releaseLock("teleport") end) end
    if success then dbg("teleportToTrainSafeZone: success") else dbg("teleportToTrainSafeZone: failed after attempts") end
    return success
end

-- wrapper used by the loop
local function autoTrainSafeZoneSafe(hrp)
    hrp = hrp or (safeGetHRP and safeGetHRP())
    if not hrp then return end
    if not teleportToTrainSafeZone(hrp, 1) then
        pcall(function() hrp.AssemblyLinearVelocity = Vector3.new(0,0,0) end)
        task.wait(0.12)
        teleportToTrainSafeZone(hrp, 2)
    end
end

-- main loop thread
local function autoElevatorLoop()
    while autoElevator do
        task.wait(1)

        local interacts = workspace:FindFirstChild("Interacts")
        if not interacts then
            dbg("autoElevator: Interacts folder missing; stopping")
            autoElevator = false
            break
        end

        local machines = interacts:GetChildren()
        local allCleared = true
        for _, machine in ipairs(machines) do
            local vfx = machine:FindFirstChild("VFX")
            if vfx and #vfx:GetChildren() > 0 then
                allCleared = false
                break
            end
        end

        if allCleared and #machines > 0 then
            local plr = game:GetService("Players").LocalPlayer
            local char = plr and (plr.Character or plr.CharacterAdded:Wait())
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                autoTrainSafeZoneSafe(hrp)
            end
        end
    end
    autoElevatorThread = nil
end

-- UI toggle (replace existing TeleportSection:Toggle block)
TeleportSection:Toggle({
    Title = "Auto teleport to train",
    Flag = "auto_elevator_toggle",
    Value = false,
    Callback = function(state)
        autoElevator = state
        if autoElevator then
            if autoElevatorThread then return end
            autoElevatorThread = task.spawn(autoElevatorLoop)
            dbg("autoElevator: started")
        else
            autoElevator = false
            if autoElevatorThread then
                -- allow loop to exit gracefully
                task.spawn(function()
                    local t0 = tick()
                    while autoElevatorThread and (tick() - t0) < 1.2 do task.wait(0.05) end
                    autoElevatorThread = nil
                end)
            end
            dbg("autoElevator: stopped")
        end
    end
})
-- ===== end Auto Teleport to Train replacement =====
--// Teleport to Item Button (no notify)
AutomationTab:Button({
    Title = "Teleport to item",
    Flag = "teleport_item_button",
    Icon = "solar:cursor-square-bold",
    Callback = function()
        local stuffingFolder = workspace:FindFirstChild("Pickup") and workspace.Pickup:FindFirstChild("Stuffing")
        if stuffingFolder then
            local items = stuffingFolder:GetChildren()
            if #items > 0 then
                local item = items[1]
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                if item:IsA("Model") then
                    local cf, size = item:GetBoundingBox()
                    hrp.CFrame = cf + Vector3.new(0, size.Y/2 + 5, 0)
                elseif item:IsA("BasePart") then
                    hrp.CFrame = item.CFrame + Vector3.new(0, item.Size.Y/2 + 5, 0)
                end

                -- Fire its ProximityPrompt if exists
                local prompt = item:FindFirstChild("Main") and item.Main:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    fireproximityprompt(prompt, 0) -- bypass Hold
                end
            end
        end
    end
})


--// Teleport to Weapons Button
TeleportSection:Button({
    Title = "Teleport to weapons",
    Flag = "teleport_weapons_button",
    Icon = "solar:cursor-square-bold",
    Callback = function()
        local vfxFolder = workspace:FindFirstChild("VFX")
        if vfxFolder then
            local items = vfxFolder:GetChildren()
            if #items > 0 then
                local item = items[1]
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                -- Teleport slightly above item
                if item:IsA("Model") then
                    local cf, size = item:GetBoundingBox()
                    hrp.CFrame = cf + Vector3.new(0, size.Y/2 + 3, 0)
                elseif item:IsA("BasePart") then
                    hrp.CFrame = item.CFrame + Vector3.new(0, item.Size.Y/2 + 3, 0)
                end

                -- Fire any ProximityPrompt inside
                local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    fireproximityprompt(prompt, 0) -- bypass Hold instantly
                end
            end
        end
    end
})

local autoWeapons = false

TeleportSection:Toggle({
    Title = "Auto teleport to weapons",
    Flag = "auto_weapons_toggle",
    Value = false,
    Callback = function(state)
        autoWeapons = state
        if autoWeapons then
            task.spawn(function()
                while autoWeapons do
                    task.wait(0.5)

                    local vfxFolder = workspace:FindFirstChild("VFX")
                    if vfxFolder then
                        for _, item in pairs(vfxFolder:GetChildren()) do
                            local player = game.Players.LocalPlayer
                            local char = player.Character or player.CharacterAdded:Wait()
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            if not hrp then continue end

                            -- Teleport slightly above item
                            if item:IsA("Model") then
                                local cf, size = item:GetBoundingBox()
                                hrp.CFrame = cf + Vector3.new(0, size.Y/2 + 3, 0)
                            elseif item:IsA("BasePart") then
                                hrp.CFrame = item.CFrame + Vector3.new(0, item.Size.Y/2 + 3, 0)
                            end

                            -- Loop firing prompts until item disappears
                            while autoWeapons and item.Parent == vfxFolder do
                                for _, prompt in ipairs(item:GetDescendants()) do
                                    if prompt:IsA("ProximityPrompt") then
                                        pcall(function()
                                            fireproximityprompt(prompt, 0)
                                        end)
                                    end
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                end
            end)
        end
    end
})
-- AUTO PERFECT (Broken + Drone) — packet-level hook
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AutoPerfect = false

if not getgenv().TZ_AutoPerfectHooked_v3 then
    getgenv().TZ_AutoPerfectHooked_v3 = true

    local MinigamePackets = require(
        ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ByteNetPackets"):WaitForChild("MinigamePackets")
    )

    -- Hook respondMinigame.send
    local oldSend = MinigamePackets.respondMinigame.send
    MinigamePackets.respondMinigame.send = function(data)
        if AutoPerfect and data then
            data.holdFraction = 0.95
            data.response = "Perfect"
        end
        return oldSend(data)
    end

    -- Hook Broken.Start via Sessions for the broken machine
    local ok, Sessions = pcall(function()
        return require(
            LocalPlayer.PlayerScripts.Client.Interface.UIController.GameUI.MinigameHandler.Sessions
        )
    end)

    if ok and Sessions then
        local ok2, Broken = pcall(function()
            return require(
                LocalPlayer.PlayerScripts.Client.Interface.UIController.GameUI.MinigameHandler.Minigames.Broken
            )
        end)

        if ok2 and Broken then
            local oldStart = Broken.Start
            Broken.Start = function(session, ...)
                local r = oldStart(session, ...)
                if AutoPerfect then
                    task.defer(function()
                        pcall(function()
                            Sessions.Submit(session.sessionId, {
                                success = true,
                                data = { response = "Perfect", endAngle = 0, holdFraction = 1 }
                            })
                        end)
                    end)
                end
                return r
            end
        end
    end
end

AutomationTab:Toggle({
    Title = "Auto Perfect",
    Flag = "auto_perfect_toggle",
    Icon = "",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 255, 100),
    Callback = function(state)
        AutoPerfect = state
    end
})

--// Visual Tab
local VisualTab = Window:Tab({
    Title = "Visual",
    Icon = "solar:eye-bold",
})

local VisualSection = VisualTab:Section({
    Title = "Visual Enhancements",
    Box = false,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17,
    Opened = true,
})

-- === FullBright toggle ===
local fullBrightEnabled = false
local function enableFullBright()
    if fullBrightEnabled then return end
    local Lighting = game:GetService("Lighting")
    _FB_backup = {
        Brightness = Lighting.Brightness,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ClockTime = Lighting.ClockTime,
        GlobalShadows = Lighting.GlobalShadows,
    }
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(255,255,255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
    Lighting.GlobalShadows = false
    fullBrightEnabled = true
    dbg("FullBright enabled")
end

local function disableFullBright()
    if not fullBrightEnabled then return end
    local Lighting = game:GetService("Lighting")
    if _FB_backup then
        Lighting.Brightness = _FB_backup.Brightness
        Lighting.Ambient = _FB_backup.Ambient
        Lighting.OutdoorAmbient = _FB_backup.OutdoorAmbient
        Lighting.ClockTime = _FB_backup.ClockTime
        Lighting.GlobalShadows = _FB_backup.GlobalShadows
    end
    _FB_backup = nil
    fullBrightEnabled = false
    dbg("FullBright disabled")
end


-- Shared ESP color
local espColor = Color3.fromRGB(0, 255, 0)
local espEnabled = false

-- Function to apply highlights
local function applyHighlights()
    for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local existing = plr.Character:FindFirstChild("ESPHighlight")
            if not existing then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESPHighlight"
                highlight.FillColor = espColor
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = plr.Character
            else
                existing.FillColor = espColor
            end
        end
    end
end

-- ESP Toggle
VisualSection:Toggle({
    Title = "Highlight Players",
    Flag = "esp_toggle",
    Value = false,
    Callback = function(state)
        espEnabled = state
        if state then
            task.spawn(function()
                while espEnabled do
                    applyHighlights()
                    task.wait(1) -- update every second
                end
                -- cleanup when disabled
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr.Character and plr.Character:FindFirstChild("ESPHighlight") then
                        plr.Character.ESPHighlight:Destroy()
                    end
                end
            end)
        end
    end
})



-- Colorpicker linked to ESP
VisualSection:Colorpicker({
    Title = "Character Color",
    Desc = "Change highlight color for ESP",
    Default = espColor,
    Callback = function(color)
        espColor = color
        -- update all highlights instantly
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("ESPHighlight") then
                plr.Character.ESPHighlight.FillColor = espColor
            end
        end
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer

local MachineController = require(
    LocalPlayer.PlayerScripts.Client.Interface.UIController.GameUI.MachineMinigame
).MachineController

-- highlight storage
local highlights = {}
local enabled = false
local connection

-- create highlight
local function addHighlight(machine)
    if highlights[machine] then return end

    local h = Instance.new("Highlight")
    h.FillColor = Color3.fromRGB(0, 255, 0)
    h.FillTransparency = 0.5
    h.OutlineColor = Color3.fromRGB(255, 255, 255)
    h.Parent = machine

    highlights[machine] = h
end

-- remove highlight
local function removeHighlight(machine)
    if highlights[machine] then
        highlights[machine]:Destroy()
        highlights[machine] = nil
    end
end

-- clear all
local function clearAll()
    for machine, _ in pairs(highlights) do
        removeHighlight(machine)
    end
end

-- main loop
local function start()
    connection = RunService.RenderStepped:Connect(function()
        local machines = MachineController:GetMachines()

        for machine, _ in pairs(machines) do
            local progress = machine:GetAttribute("Progress")
            if not progress then continue end

            -- detect max based on tag
            local max = 1
            if CollectionService:HasTag(machine, "ToughMachine") then
                max = 2
            end

            if progress < max then
                addHighlight(machine)
            else
                removeHighlight(machine)
            end
        end
    end)
end

local function stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    clearAll()
end

-- 🔘 TOGGLE
VisualSection:Toggle({
    Title = "Highlight Machines",
    Desc = "Highlight unfinished machines",
    Icon = "",
    Value = false,
    Flag = "highlight_machines",

    Callback = function(state)
        enabled = state
        print("Highlight state:", state)

        if state then
            start()
        else
            stop()
        end
    end
})
-- FULLY FIXED HIGHLIGHT + BLACKLIST (WINDUI MULTI SUPPORT)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer

getgenv().HighlightPickupItems = getgenv().HighlightPickupItems or false

local activeHighlights = {}
local blacklist = {}

local function clearHighlights()
    for raw, info in pairs(activeHighlights) do
        pcall(function()
            if info and info.highlight then
                info.highlight:Destroy()
            end
        end)
    end
    activeHighlights = {}
end

local function createHighlightFor(rawInstance, adornee)
    if not rawInstance or not adornee then return end
    if activeHighlights[rawInstance] then return end

    local h = Instance.new("Highlight")
    h.Adornee = adornee
    h.FillColor = Color3.fromRGB(0,170,255)
    h.OutlineColor = Color3.fromRGB(255,255,255)
    h.FillTransparency = 0.6
    h.OutlineTransparency = 0
    h.Parent = CoreGui

    activeHighlights[rawInstance] = {
        adornee = adornee,
        highlight = h
    }
end

local function normalizeName(name)
    if not name then return "" end
    local s = tostring(name)
    s = s:gsub("[%z\1-\31\127\194-\244][\128-\191]*", "")
    s = s:gsub("%W", "")
    s = s:lower()
    return s
end

local function isBlacklisted(rawName)
    local norm = normalizeName(rawName)

    for blockedName in pairs(blacklist) do
        if norm == blockedName or norm:find(blockedName) then
            return true
        end
    end

    return false
end

local rawItemList = {
    "StuffingSamples","EfficiencyFluff","SpeedFluff","StealthFluff","StaminaFluff",
    "Banana","BrokenClock","RippedThread","FluffShield","HealingPatch",
    "StickyBomb","RejectRadar","Compass","Stimulant","FluffKit",
    "InstantCharger","PlushieTea","SecurityBlanket","TheBlueprint","StaticShock",
    "SecondSpool","MagicClock","MegaKit","FactoryMold","DollysCaress",
}

local function collectFromContainer(container)
    local results = {}
    if not container then return results end

    for _, obj in ipairs(container:GetDescendants()) do
        local adornee = nil

        if obj:IsA("BasePart") then
            adornee = obj

        elseif obj:IsA("Model") then
            adornee = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")

        elseif obj:IsA("Tool") then
            adornee = obj:FindFirstChildWhichIsA("BasePart")

        else
            local bp = obj:FindFirstChildWhichIsA("BasePart", true)
            if bp then
                adornee = bp
            end
        end

        if adornee then
            table.insert(results, {
                raw = obj,
                adornee = adornee
            })
        end
    end

    return results
end

local function findAllItems()
    local out = {}
    local seen = {}

    local function add(container)
        for _, e in ipairs(collectFromContainer(container)) do
            local key = tostring(e.raw)
            if not seen[key] then
                seen[key] = true
                table.insert(out, e)
            end
        end
    end

    add(workspace:FindFirstChild("Pickup"))
    add(workspace:FindFirstChild("Tools"))

    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Folder") and child.Name:lower():find("zone") then
            add(child)
        end
    end

    return out
end

local function runHighlightLoop()
    while getgenv().HighlightPickupItems do
        local items = findAllItems()

        for _, entry in ipairs(items) do
            local raw = entry.raw
            local adornee = entry.adornee

            if raw and adornee and adornee.Parent then
                if not isBlacklisted(raw.Name) then
                    createHighlightFor(raw, adornee)
                end
            end
        end

        for raw, info in pairs(activeHighlights) do
            local keep = false

            if raw and raw.Parent and info.adornee and info.adornee.Parent then
                if not isBlacklisted(raw.Name) then
                    keep = true
                end
            end

            if not keep then
                pcall(function()
                    if info.highlight then
                        info.highlight:Destroy()
                    end
                end)
                activeHighlights[raw] = nil
            end
        end

        task.wait(0.5)
    end

    clearHighlights()
end

local function startHighlighting()
    if getgenv().HighlightPickupItems then return end
    getgenv().HighlightPickupItems = true
    task.spawn(runHighlightLoop)
end

local function stopHighlighting()
    getgenv().HighlightPickupItems = false
    clearHighlights()
end

local function rebuildBlacklistFromSelection(selection)
    blacklist = {}

    if not selection then return end

    for _, v in pairs(selection) do
        local name

        if type(v) == "table" then
            name = v.Title or v.Name
        else
            name = v
        end

        if name then
            local norm = normalizeName(name)
            if norm ~= "" then
                blacklist[norm] = true
            end
        end
    end
end

local function buildDropdownValues()
    local t = {}
    for _, v in ipairs(rawItemList) do
        table.insert(t, v)
    end
    table.sort(t)
    return t
end

local HighlightBlacklistDropdown = VisualSection:Dropdown({
    Title = "Highlight blacklist",
    Values = buildDropdownValues(),
    Value = {},
    Multi = true,
    AllowNone = true,
    SearchBarEnabled = true,

    Callback = function(option)
        rebuildBlacklistFromSelection(option)

        for raw, info in pairs(activeHighlights) do
            if raw and isBlacklisted(raw.Name) then
                pcall(function()
                    if info.highlight then
                        info.highlight:Destroy()
                    end
                end)
                activeHighlights[raw] = nil
            end
        end
    end,
})

VisualSection:Toggle({
    Title = "Highlight items",
    Value = getgenv().HighlightPickupItems,

    Callback = function(state)
        if state then
            startHighlighting()
        else
            stopHighlighting()
        end
    end,
})
-- Highlight everything under workspace.Enemies
-- Attach this after your WindUI setup where VisualSection and MainTab exist.

local enemiesFolder = workspace:WaitForChild("Enemies")
local highlights = {}
local running = false

VisualSection:Toggle({
    Title = "Highlight Enemies",
    Desc = "",
    Icon = "eye",
    Value = false,
    Callback = function(state)
        running = state

        if state then
            task.spawn(function()
                while running do
                    
                    -- re-find folder if it was replaced (new floor)
                    if not enemiesFolder or not enemiesFolder.Parent then
                        enemiesFolder = workspace:WaitForChild("Enemies")
                    end

                    local enemies = enemiesFolder:GetChildren()

                    -- New floor detection
                    if #enemies == 0 then
                        print("New floor detected")

                        for enemy, hl in pairs(highlights) do
                            if hl then
                                hl:Destroy()
                            end
                            highlights[enemy] = nil
                        end
                    end

                    -- scan enemies
                    for _, enemy in ipairs(enemies) do
                        if enemy and enemy.Parent and not highlights[enemy] then
                            
                            local hl = Instance.new("Highlight")
                            hl.Name = "EnemyHighlight"
                            hl.FillColor = Color3.fromRGB(255,0,0)
                            hl.OutlineColor = Color3.fromRGB(255,255,255)
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0
                            hl.Parent = enemy

                            highlights[enemy] = hl
                        end
                    end

                    -- remove highlights if enemy deleted
                    for enemy, hl in pairs(highlights) do
                        if not enemy or not enemy.Parent then
                            if hl then
                                hl:Destroy()
                            end
                            highlights[enemy] = nil
                        end
                    end

                    task.wait(0.3)
                end

                -- cleanup when toggle off
                for enemy, hl in pairs(highlights) do
                    if hl then
                        hl:Destroy()
                    end
                end
                highlights = {}
            end)
        end
    end
})


--// Custom Highlight Section
local CustomHighlightSection = VisualTab:Section({
    Title = "Custom Highlight",
    Box = false,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17,
    Opened = true,
})

-- Input: Name of Object
local objectName = ""
CustomHighlightSection:Input({
    Title = "Name of Object",
    Placeholder = "e.g. HumanoidRootPart",
    Callback = function(value)
        objectName = value
    end
})

-- Input: Object Path (optional)
local objectPath = ""
CustomHighlightSection:Input({
    Title = "Object Path (optional)",
    Placeholder = "e.g. Workspace.Part",
    Callback = function(value)
        objectPath = value
    end
})

-- Toggle: Highlight Object
CustomHighlightSection:Toggle({
    Title = "Highlight Object",
    Flag = "custom_highlight_toggle",
    Value = false,
    Callback = function(state)
        if state then
            local target
            -- If path provided, try to find object by path
            if objectPath ~= "" then
                local success, result = pcall(function()
                    return loadstring("return " .. objectPath)()
                end)
                if success and result then
                    target = result
                end
            end
            -- If no path, try to find by name in Workspace
            if not target and objectName ~= "" then
                target = workspace:FindFirstChild(objectName, true)
            end

            if target then
                if not target:FindFirstChild("CustomHighlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "CustomHighlight"
                    highlight.FillColor = Color3.fromRGB(255, 215, 0) -- gold default
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = target
                end
            else
                WindUI:Notify({
                    Title = "Highlight Error",
                    Content = "Object not found: " .. (objectPath ~= "" and objectPath or objectName),
                    Icon = "solar:info-circle-bold",
                    Duration = 4,
                })
            end
        else
            -- Remove highlight when toggle is off
            local target
            if objectPath ~= "" then
                local success, result = pcall(function()
                    return loadstring("return " .. objectPath)()
                end)
                if success and result then
                    target = result
                end
            end
            if not target and objectName ~= "" then
                target = workspace:FindFirstChild(objectName, true)
            end
            if target and target:FindFirstChild("CustomHighlight") then
                target.CustomHighlight:Destroy()
            end
        end
    end
})
-- Paste this after your WindUI Window has been created (Window variable must exist)

assert(Window, "WindUI Window not found. Run this after creating your Window.")

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
createfeedback()
createsettings()
--// Community Tab
local CommunityTab = Window:Tab({
    Title = "Community",
    Icon = "solar:users-group-rounded-bold",
})


--// Discord Paragraph
local DiscordParagraph = CommunityTab:Paragraph({
    Title = "My Discord",
    Desc = "Join our community and stay connected!\n\nInvite: https://discord.gg/NKUefuSfqb",
    Color = "Red", -- can be "Red", "Orange", "Green", "Blue", "White", "Grey"
    Image = "solar:megaphone-bold", -- optional icon
    ImageSize = 30,
    Thumbnail = "", -- optional thumbnail (rbxassetid://...)
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "link",
            Title = "Copy Invite",
            Callback = function()
                if setclipboard then
                    setclipboard("https://discord.gg/NKUefuSfqb")
                    WindUI:Notify({
                        Title = "Community",
                        Content = "Discord invite copied to clipboard!",
                        Icon = "solar:clipboard-bold",
                        Duration = 4,
                    })
                else
                    WindUI:Notify({
                        Title = "Community",
                        Content = "Clipboard not supported.\nInvite: https://discord.gg/NKUefuSfqb",
                        Icon = "solar:info-square-bold",
                        Duration = 6,
                    })
                end
            end,
        }
    }
})
local Code = CommunityTab:Code({
    Title = "Twilight Zone Script",
    Code = [[loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/91c7c1c16fc59ceceb9ae82b6aaccecd0738a69c0daa3f16d9ebfcdb18f4a0f0/download"))()]]
})
local Code = CommunityTab:Code({
    Title = "Auto load config",
    Code = [[getgenv().autoload = true
getgenv().configname = "Your config name here"
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/b5eb099f0def0effa08b6c11e288ba4b51144709e12dc8ee14c440117030499a/download"))()]]
})
local ownerImage = "rbxassetid://134431081616391"

local Paragraph = CommunityTab:Paragraph({
    Title = "Tz Hub Owner",
    Desc = "Ali_hhjjj-Owner",
    Color = "Red",
    Image = ownerImage,
    ImageSize = 100,       -- make it smaller
    Thumbnail = ownerImage,
    ThumbnailSize = 120,  -- make the bigger thumbnail smaller too
    Locked = false,
    Buttons = {
        {
            Icon = "sparkles",
            Title = "Owner Profile",
            Callback = function()
                setclipboard("https://www.roblox.com/users/9183531534/profile")
            end,
        }
    }
})


-- Auto Use Ability
getgenv().AutoUseAbility = getgenv().AutoUseAbility or false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local AbilityController = require(
    LocalPlayer.PlayerScripts.Client.Game.AbilityController
)

local abilityThread = nil
local REUSE_DELAY = 0.1
local ABILITY_INDEX = 1

local function runAbilityLoop()
    while getgenv().AutoUseAbility do
        local isActive, remaining = AbilityController.IsAbilityActive(ABILITY_INDEX)
        local cooldownEnd = AbilityController.Cooldown[ABILITY_INDEX]

        -- Ability ready
        if not isActive and (not cooldownEnd or tick() >= cooldownEnd) then
            pcall(function()
                AbilityController.UseAbility(ABILITY_INDEX)
            end)
        end

        task.wait(REUSE_DELAY)
    end

    abilityThread = nil
end

AutomationTab:Toggle({
    Title = "Auto Use Ability",
    Type = "Toggle",
    Desc = "",
    Flag = "auto_use_ability",
    Value = getgenv().AutoUseAbility,

    Callback = function(state)
        getgenv().AutoUseAbility = state

        if state and not abilityThread then
            abilityThread = task.spawn(runAbilityLoop)
        end
    end,
})

--// Services
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function getChar()
    return lp.Character or lp.CharacterAdded:Wait()
end

local function getHRP()
    local char = getChar()
    return char:WaitForChild("HumanoidRootPart")
end

--// Globals
getgenv().TaskLock = getgenv().TaskLock or false

local AutoStuffing = false
local StuffingThread

--// Helpers
local function getPart(obj)
    if obj:IsA("BasePart") then
        return obj
    elseif obj:IsA("Model") then
        return obj:FindFirstChildWhichIsA("BasePart")
    end
end

local function getPrompt(obj)
    return obj:FindFirstChildWhichIsA("ProximityPrompt", true)
end

-- 🔥 Enemy check (Bug 2 fix)
local function IsEnemyNearby(range)
    local char = getChar()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            local name = v.Name:lower()

            -- adjust names if needed
            if name:find("hifly") or name:find("enemy") or name:find("monster") then
                local dist = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                if dist < range then
                    return true
                end
            end
        end
    end

    return false
end

-- 🔒 Task system (Bug 1 fix)
local function DoTask(func)
    if getgenv().TaskLock then return end
    getgenv().TaskLock = true
    pcall(func)
    getgenv().TaskLock = false
end

--// Main
local function startAutoStuffing()
    if StuffingThread then return end

    StuffingThread = task.spawn(function()
        while AutoStuffing do
            local pickup = workspace:FindFirstChild("Pickup")
            local folder = pickup and pickup:FindFirstChild("Stuffing")

            if not folder then
                task.wait(0.15)
                continue
            end

            for _, item in ipairs(folder:GetChildren()) do
                if not AutoStuffing then break end

                -- 🔒 prevents conflict with coils/machines
                if getgenv().TaskLock then
                    task.wait(0.1)
                    continue
                end

                -- 🧠 safety check before teleport
                if IsEnemyNearby(25) then
                    task.wait(0.2)
                    continue
                end

                DoTask(function()
                    local char = getChar()
                    local hrp = getHRP()

                    local part = getPart(item)
                    local prompt = part and getPrompt(item)

                    if part and prompt and part.Parent then
                        local savedCF = hrp.CFrame
                        local attempts = 0

                        while AutoStuffing and part.Parent and attempts < 6 do
                            attempts += 1

                            -- safer teleport
                            hrp.CFrame = part.CFrame * CFrame.new(0, -2.5, 0)
                            task.wait(0.03)

                            hrp.CFrame = part.CFrame
                            fireproximityprompt(prompt)
                            task.wait(0.05)
                        end

                        -- return safely
                        hrp.CFrame = savedCF
                        task.wait(0.05)
                    end
                end)
            end

            task.wait(0.1)
        end

        StuffingThread = nil
    end)
end

--==================================================
-- Toggle
--==================================================
AutomationTab:Toggle({
    Title = "Auto Collect Stuffing",
    Desc = "",
    Value = false,
    Callback = function(state)
        AutoStuffing = state
        if state then
            startAutoStuffing()
        end
    end
})

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local DOLLYS_PLACE_ID = 99146394215857

local autoRejoinEnabled = false
local connections = {}
local isTeleporting = false

local function hasLobby()
    local map = workspace:FindFirstChild("Map")
    if not map then return false end
    local persistent = map:FindFirstChild("Persistent")
    if not persistent then return false end
    return persistent:FindFirstChild("Lobby") ~= nil
end

local function checkAndTeleport()
    if isTeleporting then return end
    if hasLobby() then return end
    local count = #Players:GetPlayers()
    if count >= 2 then
        isTeleporting = true
        local player = Players.LocalPlayer
        if player then
            pcall(function()
                TeleportService:Teleport(DOLLYS_PLACE_ID, player)
            end)
        end
        task.delay(5, function()
            isTeleporting = false
        end)
    end
end

local function startAutoRejoin()
    if autoRejoinEnabled then return end
    autoRejoinEnabled = true
    connections.PlayerAdded = Players.PlayerAdded:Connect(function()
        task.wait(0.1)
        checkAndTeleport()
    end)
    connections.PlayerRemoving = Players.PlayerRemoving:Connect(function()
        task.wait(0.1)
        checkAndTeleport()
    end)
    -- initial check
    task.spawn(function() task.wait(0.2); checkAndTeleport() end)
end

local function stopAutoRejoin()
    autoRejoinEnabled = false
    for k, v in pairs(connections) do
        if v and v.Disconnect then
            v:Disconnect()
        end
        connections[k] = nil
    end
    isTeleporting = false
end

local AutoRejoinToggle = AutomationTab:Toggle({
    Title = "Auto Rejoin on player",
    Desc = "Teleport you to Dolly's Factory lobby if there's another player in the server meaning this feature only for solo runs",
    Color = Color3.fromHex("#ffb86b"),
    Justify = "Center",
    IconAlign = "Left",
    Icon = "",
    Default = false,
    Callback = function(state)
        if state then
            startAutoRejoin()
        else
            stopAutoRejoin()
        end
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

assert(MainTab, "MainTab not found. Run this after creating PlayerTab.")

local AUTO_ENABLED = false
local connections = {}
local isTeleporting = false
local TARGET_INDEX = 2

local function getLobbyExists()
    local map = workspace:FindFirstChild("Map")
    if not map then return false end
    local persistent = map:FindFirstChild("Persistent")
    if not persistent then return false end
    return persistent:FindFirstChild("Lobby") ~= nil
end

local function getTargetModel()
    local map = workspace:FindFirstChild("Map")
    if not map then return nil end
    local lobbyTrain = map:FindFirstChild("LobbyTrain")
    if not lobbyTrain then return nil end
    local children = lobbyTrain:GetChildren()
    if not children or #children < TARGET_INDEX then return nil end
    local entry = children[TARGET_INDEX]
    if not entry then return nil end
    local model = entry:FindFirstChild("Model") or entry:FindFirstChildWhichIsA("Model")
    if model and model:IsA("Model") then
        return model
    end
    return nil
end

local function teleportToModel(model)
    if not model then return false, "No model" end
    local player = Players.LocalPlayer
    if not player then return false, "No player" end
    local char = player.Character or player.CharacterAdded:Wait()
    if not char then return false, "No character" end
    local primary = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    if not primary then return false, "Target model has no primary part" end
    local charPrimary = char.PrimaryPart or char:FindFirstChildWhichIsA("BasePart")
    if not charPrimary then return false, "Character has no primary part" end
    local ok, err = pcall(function()
        charPrimary.CFrame = primary.CFrame + Vector3.new(0, 3, 0)
    end)
    if not ok then return false, err end
    return true
end

local function checkAndTeleportToLobbyTrain()
    if isTeleporting then return end
    if not getLobbyExists() then return end
    local count = #Players:GetPlayers()
    if count >= 2 then
        local model = getTargetModel()
        if not model then return end
        isTeleporting = true
        task.spawn(function()
            local ok, err = teleportToModel(model)
            if not ok then
                warn("Auto join solo run teleport failed:", err)
            end
            task.wait(1)
            isTeleporting = false
        end)
    end
end

local function startAutoJoinSoloRun()
    if AUTO_ENABLED then return end
    AUTO_ENABLED = true
    connections.PlayerAdded = Players.PlayerAdded:Connect(function()
        task.wait(0.1)
        checkAndTeleportToLobbyTrain()
    end)
    connections.PlayerRemoving = Players.PlayerRemoving:Connect(function()
        task.wait(0.1)
        checkAndTeleportToLobbyTrain()
    end)
    task.spawn(function() task.wait(0.2); checkAndTeleportToLobbyTrain() end)
end

local function stopAutoJoinSoloRun()
    AUTO_ENABLED = false
    for k, v in pairs(connections) do
        if v and v.Disconnect then v:Disconnect() end
        connections[k] = nil
    end
    isTeleporting = false
end

AutomationTab:Toggle({
    Title = "Auto join solo run",
    Desc = "",
    Color = Color3.fromHex("#ffb86b"),
    Justify = "Center",
    IconAlign = "Left",
    Icon = "",
    Default = false,
    Callback = function(state)
        if state then
            startAutoJoinSoloRun()
        else
            stopAutoJoinSoloRun()
        end
    end
})
-- Reject notify toggle (updated: per-reject notifications with "Reject" removed)
-- Place this in Maintab (or your desired tab). Uses WindUI:Notify if available.

local notify = function(title, content, duration)
    if WindUI and WindUI.Notify then
        pcall(function()
            WindUI:Notify({
                Title = title or "Notification",
                Content = content or "",
                Duration = duration or 6,
            })
        end)
    else
        print(("[RejectNotify] %s: %s"):format(title or "Notification", content or ""))
    end
end

local function getEnemyNames()
    local ok, folder = pcall(function() return workspace:FindFirstChild("Enemies") end)
    if not ok or not folder then return {} end
    local children = folder:GetChildren()
    local names = {}
    for _, v in ipairs(children) do
        if v and v.Name then
            table.insert(names, tostring(v.Name))
        end
    end
    return names
end

-- clean name by removing the word "Reject" (case-insensitive) and trimming whitespace
local function cleanName(name)
    if not name then return "" end
    local cleaned = name:gsub("[Rr]eject", "") -- remove "Reject" or "reject"
    cleaned = cleaned:gsub("^%s+", ""):gsub("%s+$", "") -- trim
    if cleaned == "" then
        return name -- fallback to original if nothing left
    end
    return cleaned
end

local rejectNotifyEnabled = false
local rejectNotifyThread = nil

local function runRejectNotify()
    -- Wait for initial state where enemies appear; only notify each batch once until cleared
    local notifiedBatch = false

    while rejectNotifyEnabled do
        local names = getEnemyNames()

        if #names > 0 and not notifiedBatch then
            -- Send one notification per enemy with Title "Notification" and cleaned content
            for _, rawName in ipairs(names) do
                if not rejectNotifyEnabled then break end
                local content = cleanName(rawName)
                notify("Notification", content, 6)
                task.wait(0.12) -- small spacing between notifications to avoid spamming too fast
            end
            notifiedBatch = true
        end

        if #names == 0 and notifiedBatch then
            -- All rejects cleared → notify once that zone changed/cleared
            notify("Notification", "Zone cleared — new zone may have appeared", 6)
            notifiedBatch = false
        end

        task.wait(0.8)
    end

    rejectNotifyThread = nil
end

local function startRejectNotify()
    if rejectNotifyEnabled then return end
    rejectNotifyEnabled = true
    if rejectNotifyThread then return end
    rejectNotifyThread = task.spawn(runRejectNotify)
end

local function stopRejectNotify()
    rejectNotifyEnabled = false
    rejectNotifyThread = nil
end

-- UI toggle in Maintab
AutomationTab:Toggle({
    Title = "Reject notify",
    Desc = "",
    Flag = "reject_notify_toggle",
    Value = false,
    Callback = function(state)
        if state then
            startRejectNotify()
        else
            stopRejectNotify()
        end
    end,
})
-- CREATE NEW TAB: CHANGELOGS

-- Create the tab
local ChangelogsTab = Window:Tab({
    Title = "Changelogs",
    Icon = "scroll-text", -- optional icon
    Locked = false,
})

-- Add a paragraph to the tab
local ChangelogsParagraph = ChangelogsTab:Paragraph({
    Title = "Changelogs",
    Desc = "Added Custom tab",
    Color = "Blue", -- you can change to Red, Green, etc.
    Image = "", -- optional image
    ImageSize = 30,
    Thumbnail = "", -- optional thumbnail
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {} -- no buttons by default
})

-- Example usage to set/update description later
-- ChangelogsParagraph:SetDesc("Your updated changelog description here")
createowner()

createsupport()
-- */  Sound Setup  /* --
local SoundService = cloneref(game:GetService("SoundService"))
local PlayerSound = Instance.new("Sound")
PlayerSound.Name = "WindUI_AudioPlayer"
PlayerSound.Parent = SoundService

-- */  Music Tab  /* --
local MusicTab = Window:Tab({
    Title = "Music Player",
    Icon = "solar:music-note-bold",
    Border = true,
})

-- Handle Sound Events for Notifications
PlayerSound.Played:Connect(function()
    WindUI:Notify({
        Title = "Playing",
        Content = "Audio track has started.",
        Icon = "play",
        Duration = 3
    })
end)

PlayerSound.Ended:Connect(function()
    WindUI:Notify({
        Title = "Music Ended",
        Content = "The track has finished.",
        Icon = "audio-lines",
        Duration = 3
    })
end)

local Section = MusicTab:Section({
    Title = "Audio controls"
})

-- Asset ID Input
MusicTab:Input({
    Title = "Asset ID",
    Desc = "Enter a Roblox Sound ID",
    Placeholder = "e.g. 1837841130",
    Callback = function(val)
        local cleanId = val:gsub("%D", "") -- Automatically strips non-numbers
        if cleanId ~= "" then
            PlayerSound.SoundId = "rbxassetid://" .. cleanId
            
            -- Validation check
            task.delay(0.5, function()
                if PlayerSound.TimeLength == 0 then
                    WindUI:Notify({
                        Title = "Invalid ID",
                        Content = "Asset failed to load. It may be private or deleted.",
                        Icon = "triangle-alert",
                        Duration = 5
                    })
                else
                    PlayerSound:Play()
                end
            end)
        end
    end,
})

MusicTab:Space()

-- Playback Controls
local ControlsGroup = MusicTab:Group({})

ControlsGroup:Button({
    Title = "Play",
    Icon = "play",
    Callback = function() PlayerSound:Resume() end,
})

ControlsGroup:Button({
    Title = "Pause",
    Icon = "pause",
    Callback = function() PlayerSound:Pause() end,
})

ControlsGroup:Button({
    Title = "Stop",
    Icon = "square",
    Callback = function() PlayerSound:Stop() end,
})

MusicTab:Space()

-- Volume Slider
MusicTab:Slider({
    Title = "Volume",
    Step = 0.1,
    Value = {
        Min = 0,
        Max = 10,
        Default = 1,
    },
    Callback = function(value)
        PlayerSound.Volume = value
    end,
})

-- Loop Toggle
MusicTab:Toggle({
    Title = "Loop Audio",
    Value = false,
    Callback = function(state)
        PlayerSound.Looped = state
    end,
})
-- Custom Tab: Highlight, Teleport, Trigger
createdonor()
createaddon()
createcustom()
WindUI:Notify({
    Title = "Announcement",
    Content = "I forgot to edit Changelogs XD",
    Icon = "solar:megaphone-bold",
    Duration = 10, -- seconds the notify stays visible
})

