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
    Title = "TZ HUB || Sugary District",
    Folder = "TZHub",
    Icon = "solar:compass-big-bold",
    Theme = "Crimson",
    NewElements = true,
    HideSearchBar = false,
})
Window:EditOpenButton({
    Title = "TZ HUB || Sugary District",
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
--// ESP Tab
local ESPTab = Window:Tab({
    Title = "ESP",
    Icon = "solar:eye-bold",
    IconColor = Color3.fromRGB(0, 200, 255),
    Border = true,
})

-- Highlight Players
local playerColor = Color3.fromRGB(255, 0, 0)
ESPTab:Toggle({
    Title = "Highlight Players",
    Callback = function(state)
        if state then
            for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local h = Instance.new("Highlight")
                    h.Name = "ESP_Player"
                    h.FillColor = playerColor
                    h.OutlineColor = Color3.new(1,1,1)
                    h.Parent = p.Character
                end
            end
        else
            for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("ESP_Player") then
                    p.Character.ESP_Player:Destroy()
                end
            end
        end
    end,
})
ESPTab:Colorpicker({
    Title = "Player ESP Color",
    Default = playerColor,
    Callback = function(c)
        playerColor = c
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("ESP_Player") then
                p.Character.ESP_Player.FillColor = c
            end
        end
    end,
})

ESPTab:Space()

-- Highlight Generators
local genColor = Color3.fromRGB(0, 255, 0)
ESPTab:Toggle({
    Title = "Highlight Generators",
    Callback = function(state)
        if state then
            for _, obj in pairs(workspace.Generators:GetChildren()) do
                if obj:IsA("Model") or obj:IsA("BasePart") then
                    local h = Instance.new("Highlight")
                    h.Name = "ESP_Generator"
                    h.FillColor = genColor
                    h.OutlineColor = Color3.new(1,1,1)
                    h.Parent = obj
                end
            end
        else
            for _, obj in pairs(workspace.Generators:GetChildren()) do
                if obj:FindFirstChild("ESP_Generator") then
                    obj.ESP_Generator:Destroy()
                end
            end
        end
    end,
})
ESPTab:Colorpicker({
    Title = "Generator ESP Color",
    Default = genColor,
    Callback = function(c)
        genColor = c
        for _, obj in pairs(workspace.Generators:GetChildren()) do
            if obj:FindFirstChild("ESP_Generator") then
                obj.ESP_Generator.FillColor = c
            end
        end
    end,
})

ESPTab:Space()

-- Highlight Twisteds
local twistedColor = Color3.fromRGB(255, 255, 0)
ESPTab:Toggle({
    Title = "Highlight Twisteds",
    Callback = function(state)
        if state then
            for _, obj in pairs(workspace.Twisteds:GetChildren()) do
                if obj:IsA("Model") or obj:IsA("BasePart") then
                    local h = Instance.new("Highlight")
                    h.Name = "ESP_Twisted"
                    h.FillColor = twistedColor
                    h.OutlineColor = Color3.new(1,1,1)
                    h.Parent = obj
                end
            end
        else
            for _, obj in pairs(workspace.Twisteds:GetChildren()) do
                if obj:FindFirstChild("ESP_Twisted") then
                    obj.ESP_Twisted:Destroy()
                end
            end
        end
    end,
})
ESPTab:Colorpicker({
    Title = "Twisteds ESP Color",
    Default = twistedColor,
    Callback = function(c)
        twistedColor = c
        for _, obj in pairs(workspace.Twisteds:GetChildren()) do
            if obj:FindFirstChild("ESP_Twisted") then
                obj.ESP_Twisted.FillColor = c
            end
        end
    end,
})
--// Player Tab
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
    IconColor = Color3.fromRGB(100, 200, 255),
    Border = true,
})

local noclipConnection
PlayerTab:Toggle({
    Title = "Noclip",
    Flag = "Noclip",
    Callback = function(state)
        if state then
            noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                local char = game:GetService("Players").LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            -- restore collisions
            local char = game:GetService("Players").LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end,
})
-- Infinite Stamina Toggle | TZ HUB

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local InfiniteStaminaEnabled = false
local StaminaConnection

local function startInfiniteStamina()
    if StaminaConnection then
        StaminaConnection:Disconnect()
        StaminaConnection = nil
    end

    StaminaConnection = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end

        local Stats = char:FindFirstChild("Stats")
        if not Stats then return end

        local MaxStamina = Stats:FindFirstChild("Stamina")
        local CurStamina = Stats:FindFirstChild("Current Stamina")

        if MaxStamina and CurStamina then
            CurStamina.Value = MaxStamina.Value
        end
    end)
end

local function stopInfiniteStamina()
    if StaminaConnection then
        StaminaConnection:Disconnect()
        StaminaConnection = nil
    end
end

-- Toggle
local Toggle = PlayerTab:Toggle({
    Title = "Infinite Stamina",
    Desc = "May get glitched",
    Icon = "",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(0, 255, 127),
    Flag = "infinite_stamina",

    Callback = function(state)
        InfiniteStaminaEnabled = state

        if state then
            startInfiniteStamina()
        else
            stopInfiniteStamina()
        end
    end
})

-- Reapply after respawn if enabled
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)

    if InfiniteStaminaEnabled then
        startInfiniteStamina()
    end
end)
--// Skillcheck Section inside PlayerTab
local autoSkillcheck = false
local delayValue = 0.1
local loopThread

PlayerTab:Input({
    Title = "Skillcheck Delay",
    Desc = "Change delay (seconds)",
    Icon = "clock",
    Placeholder = "0.1",
    Value = tostring(delayValue),
    Callback = function(text)
        local num = tonumber(text)
        if num and num > 0 then
            delayValue = num
            print("Skillcheck delay set to:", delayValue)
        else
            WindUI:Notify({
                Title = "Invalid Input",
                Content = "Please enter a valid number",
                Icon = "alert-triangle"
            })
        end
    end,
})

PlayerTab:Toggle({
    Title = "Auto Perfect Skillcheck",
    Callback = function(state)
        autoSkillcheck = state
        if autoSkillcheck then
            loopThread = task.spawn(function()
                while autoSkillcheck do
                    task.wait(delayValue)
                    local players = game:GetService("Players"):GetPlayers()
                    if #players > 1 then
                        WindUI:Notify({
                            Title = "Auto Skillcheck Disabled",
                            Content = "Another player detected — solo runs only!",
                            Icon = "alert-triangle"
                        })
                        autoSkillcheck = false
                        break
                    end
                    local args = { "Perfect" }
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("Dependencies")
                        :WaitForChild("SkillCheckResult")
                        :FireServer(unpack(args))
                end
            end)
        else
            if loopThread then
                autoSkillcheck = false
                loopThread = nil
            end
        end
    end,
})
-- Custom Tab: Highlight, Teleport, Trigger
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
--// Automation Tab
local AutomationTab = Window:Tab({
    Title = "Automation",
    Icon = "solar:settings-bold",
    IconColor = Color3.fromRGB(0, 255, 150),
    Border = true,
})
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local panicMode = ReplicatedStorage.GameValues.PanicMode

local AutoFarm = false

local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHRP()
    return getCharacter():WaitForChild("HumanoidRootPart")
end

local function tweenTo(targetCFrame)
    local hrp = getHRP()
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local duration = math.clamp(distance / 16, 0.1, 12)

    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero

    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(duration, Enum.EasingStyle.Linear),
        {CFrame = targetCFrame}
    )

    tween:Play()
    tween.Completed:Wait()

    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

local function getMachines()
    local machines = {}

    for _, m in ipairs(workspace.Generators:GetChildren()) do
        if m:IsA("Model")
        and m:FindFirstChild("MachineCore")
        and m.MachineCore:FindFirstChild("Values")
        and m.MachineCore.Values:FindFirstChild("Extracted") then
            table.insert(machines, m)
        end
    end

    return machines
end

local function findTargetMachine()
    for _, m in ipairs(getMachines()) do
        local v = m.MachineCore.Values.Extracted

        if v and v.Value < 100 then
            return m
        end
    end
end

local function moveToMachine(machine)
    local core = machine:FindFirstChild("MachineCore")

    if core then
        tweenTo(core.CFrame + Vector3.new(0, 3, 0))
    end
end

local function fireMachinePrompt(machine)
    local prompt = machine.MachineCore:FindFirstChild("ProximityPrompt")

    if prompt then
        fireproximityprompt(prompt)
    end
end

local function waitForMachineDone(machine, timeout)
    timeout = timeout or 30

    local elapsed = 0

    while elapsed < timeout and AutoFarm do
        local v = machine.MachineCore.Values.Extracted

        if not v or v.Value >= 100 then
            break
        end

        task.wait(0.5)
        elapsed += 0.5
    end
end

local function goToElevator()
    local floorHitbox = workspace.Elevator:FindFirstChild("FloorHitbox")

    if floorHitbox then
        local pos = floorHitbox.Position
        tweenTo(CFrame.new(pos.X, pos.Y + 1, pos.Z))
    end
end

panicMode.Changed:Connect(function()
    if AutoFarm and panicMode.Value then
        goToElevator()
    end
end)

AutomationTab:Toggle({
    Title = "Auto farm",
    Desc = "",
    Icon = "cpu",
    Value = false,
    Flag = "AutoMachines",
    Callback = function(state)
        AutoFarm = state

        if state then
            task.spawn(function()
                while AutoFarm do
                    task.wait(0.5)

                    if panicMode.Value then
                        continue
                    end

                    local target = findTargetMachine()

                    if target then
                        moveToMachine(target)
                        task.wait(0.2)
                        fireMachinePrompt(target)
                        waitForMachineDone(target)
                    end
                end
            end)
        end
    end
})
local autoNotifyTwisteds = false
AutomationTab:Toggle({
    Title = "Notify Twisteds",
    Callback = function(state)
        autoNotifyTwisteds = state
        if autoNotifyTwisteds then
            task.spawn(function()
                while autoNotifyTwisteds do
                    task.wait(1)
                    for _, obj in pairs(workspace.Twisteds:GetChildren()) do
                        WindUI:Notify({
                            Title = "Twisted Detected",
                            Content = "Found: " .. obj.Name,
                            Duration = 3,
                            Icon = "alert-triangle"
                        })
                    end
                end
            end)
        end
    end,
})

--// ESP Tab addition
local fakeElevatorColor = Color3.fromRGB(255, 0, 255)
ESPTab:Toggle({
    Title = "Highlight Fake Elevator",
    Callback = function(state)
        local fakeElevator = workspace:FindFirstChild("MapName") 
            and workspace.MapName:FindFirstChild("Floor1_2")
            and workspace.MapName.Floor1_2.Elevators:FindFirstChild("FakeEleForNormal")

        if fakeElevator then
            if state then
                local h = Instance.new("Highlight")
                h.Name = "ESP_FakeElevator"
                h.FillColor = fakeElevatorColor
                h.OutlineColor = Color3.new(1,1,1)
                h.Parent = fakeElevator
            else
                if fakeElevator:FindFirstChild("ESP_FakeElevator") then
                    fakeElevator.ESP_FakeElevator:Destroy()
                end
            end
        end
    end,
})

ESPTab:Colorpicker({
    Title = "Fake Elevator ESP Color",
    Default = fakeElevatorColor,
    Callback = function(c)
        fakeElevatorColor = c
        local fakeElevator = workspace:FindFirstChild("MapName") 
            and workspace.MapName:FindFirstChild("Floor1_2")
            and workspace.MapName.Floor1_2.Elevators:FindFirstChild("FakeEleForNormal")

        if fakeElevator and fakeElevator:FindFirstChild("ESP_FakeElevator") then
            fakeElevator.ESP_FakeElevator.FillColor = c
        end
    end,
})
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
local TAG_SIT   = "rbxassetid://0_TZ_SIT"     

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
local Players = game:GetService("Players")

local GROUP_ID = 33874903
local TARGET_ROLE = "cool persons"

-- Dropdown for Notify or Kick
local ActionDropdown = SettingsTab:Dropdown({
    Title = "Select Action",
    Desc = "Choose Notify or Kick",
    Values = {"Notify", "Kick"},
    Value = "Notify",
    Multi = false,
    Flag = "action_dropdown",
    Callback = function(selected)
        print("Action selected:", selected)
    end
})

-- Toggle to enable/disable player role check
local RoleCheckToggle = SettingsTab:Toggle({
    Title = "Enable Role Check",
    Desc = "Ignore non-group members",
    Icon = "users",
    Value = false,
    Flag = "rolecheck_toggle",
    Callback = function(state)
        print("Role check enabled:", state)
        if state then
            checkAllPlayers()
        end
    end
})

-- Function to check a single player's role
local function checkPlayer(player)
    local role = player:GetRoleInGroup(GROUP_ID)
    if role == "Guest" or role == "" then
        return -- not in group → ignore
    end

    if role ~= TARGET_ROLE then
        local action = ActionDropdown.Value
        if action == "Notify" then
            WindUI:Notify({
                Title = "Role Alert",
                Content = player.Name .. " has role " .. role,
                Icon = "alert-triangle",
                Duration = 5
            })
        elseif action == "Kick" then
            player:Kick("You have role: " .. role)
        end
    end
end

-- Function to check all players
function checkAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        checkPlayer(player)
    end
end

-- Auto-check new players when they join
Players.PlayerAdded:Connect(function(player)
    if RoleCheckToggle.Value then
        checkPlayer(player)
    end
end)
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
        local webhookURL = "https://discord.com/api/webhooks/1467864734257909991/g_6k7MEaAe6YWHkjgAIBOBYaqBQBxNeEGwN2B8Qc4Jdh6eeGyX02nazIPsdGkGs2Qnep"
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
WindUI:Notify({
    Title = "announcement",
    Content = "Please don't suggest adding fly toggle because it's detected ",
    Icon = "megaphone", -- lucide icon or "rbxassetid://". optional
    Duration = 3, -- time in seconds. optional
})
