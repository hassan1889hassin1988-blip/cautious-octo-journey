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

--// Window
local Window = WindUI:CreateWindow({
    Title = "TZ HUB || Twilight zone",
    Folder = "TZHub",
    Icon = "solar:compass-big-bold",
    Theme = "Crimson",
    NewElements = true,
    HideSearchBar = false,
})
Window:EditOpenButton({
    Title = "TZ HUB || Twilight zone",
    Icon = "solar:compass-big-bold",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("DC143C"),
        Color3.fromHex("8B0000")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

--// Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

--// Notification utility
local function notify(msg)
    StarterGui:SetCore("SendNotification", {
        Title = "TZ Loader",
        Text = msg,
        Duration = 8
    })
end

--// Lobby check
if Workspace:FindFirstChild("LobbySpawn") then
    notify("Please use the script only in game, not in lobby!")
end

--// Utility functions
local function findRepresentativePart(model)
    if not model then return nil end
    if model:IsA("BasePart") then return model end
    local names = {"Front","front","Head","head","HumanoidRootPart","PrimaryPart"}
    for _,n in ipairs(names) do
        local f = model:FindFirstChild(n)
        if f and f:IsA("BasePart") then
            return f
        end
    end
    if model.PrimaryPart and model.PrimaryPart:IsA("BasePart") then
        return model.PrimaryPart
    end
    return model:FindFirstChildWhichIsA("BasePart", true)
end

local function isFuseLike(name)
    if not name then return false end
    local s = tostring(name):lower()
    return s:find("fuse") or s:find("fusebox") or s:find("fuse_box")
end

--// Godmode (Toggle)
local godmodeFlag = false

task.spawn(function()
    while true do
        if godmodeFlag then
            pcall(function()
                if Workspace:FindFirstChild("Floor") and Workspace.Floor:FindFirstChild("Spirits") then
                    for _, folder in ipairs(Workspace.Floor.Spirits:GetChildren()) do
                        for _, v in ipairs(folder:GetChildren()) do
                            if v.Name == "HitPlayer" then
                                v:Destroy()
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)

--// Machine gathering
local function findMachinesFolders()
    local folders = {}
    if Workspace:FindFirstChild("Machines") then
        table.insert(folders, Workspace.Machines)
    end
    if Workspace:FindFirstChild("Floor") then
        for _, obj in ipairs(Workspace.Floor:GetDescendants()) do
            if (obj:IsA("Folder") or obj:IsA("Model")) and tostring(obj.Name):lower() == "machines" then
                table.insert(folders, obj)
            end
        end
    end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if (obj:IsA("Folder") or obj:IsA("Model")) and tostring(obj.Name):lower() == "machines" then
            table.insert(folders, obj)
        end
    end
    local seen = {}
    local unique = {}
    for _, f in ipairs(folders) do
        if f and not seen[f] then
            seen[f] = true
            table.insert(unique, f)
        end
    end
    return unique
end

local function gatherMachineParts()
    local parts = {}
    local folders = findMachinesFolders()
    for _, machinesFolder in ipairs(folders) do
        for _, machine in ipairs(machinesFolder:GetChildren()) do
            if machine:IsA("Model") and not isFuseLike(machine.Name) then
                local rep = findRepresentativePart(machine) or machine
                if rep then table.insert(parts, rep) end
            end
        end
    end
    if #parts == 0 then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and not isFuseLike(obj.Name) then
                if tostring(obj.Name):lower():find("machine") then
                    local rep = findRepresentativePart(obj) or obj
                    table.insert(parts, rep)
                end
            end
        end
    end
    if #parts == 0 and Workspace:FindFirstChild("Floor") then
        for _, obj in ipairs(Workspace.Floor:GetDescendants()) do
            if obj:IsA("Model") and not isFuseLike(obj.Name) then
                local rep = findRepresentativePart(obj)
                if rep and (tostring(obj.Name):lower():find("machine") or rep.Name:lower():find("machine")) then
                    table.insert(parts, rep)
                end
            end
        end
    end
    return parts
end

local function findNearestMachinePart()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local parts = gatherMachineParts()
    if #parts == 0 then return nil end
    table.sort(parts, function(a,b)
        return (a.Position - hrp.Position).Magnitude < (b.Position - hrp.Position).Magnitude
    end)
    return parts[1]
end

--// Teleports
local function teleportToPart(part, yOffset)
    yOffset = yOffset or 5
    if not part then return false end
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 2)
    if not hrp then return false end
    pcall(function()
        hrp.CFrame = part.CFrame + Vector3.new(0, yOffset, 0)
    end)
    return true
end

local function teleportToRandomMachine()
    local parts = gatherMachineParts()
    if #parts == 0 then return false end
    return teleportToPart(parts[math.random(1,#parts)])
end

local function teleportToNearestMachine()
    local p = findNearestMachinePart()
    if not p then return false end
    return teleportToPart(p)
end

local function teleportToElevator()
    local elevator = Workspace:FindFirstChild("Elevator")
    if not elevator then return false end
    local spawn = elevator:FindFirstChild("ElevatorSpawn") or elevator:FindFirstChild("Elevator1") or elevator:FindFirstChild("Elevator2") or findRepresentativePart(elevator)
    if not spawn then return false end
    return teleportToPart(spawn, 2)
end

--// ESP
local espMachinesOn, espSpiritsOn = false, false
local espMap = {}

local function createHighlightForModel(model, color)
    if not model or not model.Parent or espMap[model] then return end
    local hl = Instance.new("Highlight")
    hl.Name = "TZ_HL"
    hl.Adornee = model
    hl.FillColor, hl.OutlineColor = color, color
    hl.FillTransparency = 0.55
    hl.Parent = workspace
    espMap[model] = hl
end

local function clearAllHighlights()
    for model, hl in pairs(espMap) do
        pcall(function()
            if hl then hl:Destroy() end
        end)
    end
    espMap = {}
end

local function cleanupDeadHighlights()
    for model, hl in pairs(espMap) do
        if not model or not model.Parent then
            pcall(function()
                if hl then hl:Destroy() end
            end)
            espMap[model] = nil
        end
    end
end

task.spawn(function()
    while true do
        cleanupDeadHighlights()
        if espMachinesOn then
            local parts = gatherMachineParts()
            for _, rep in ipairs(parts) do
                local model = rep and rep:IsA("BasePart") and rep.Parent or rep
                if model and model:IsA("Model") and not espMap[model] then
                    createHighlightForModel(model, Color3.fromRGB(0, 200, 0))
                end
            end
        end
        if espSpiritsOn then
            local foundSpiritFolders = {}
            if Workspace:FindFirstChild("Floor") then
                for _, obj in ipairs(Workspace.Floor:GetDescendants()) do
                    if (obj:IsA("Folder") or obj:IsA("Model")) and tostring(obj.Name):lower() == "spirits" then
                        table.insert(foundSpiritFolders, obj)
                    end
                end
            end
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if (obj:IsA("Folder") or obj:IsA("Model")) and tostring(obj.Name):lower() == "spirits" then
                    table.insert(foundSpiritFolders, obj)
                end
            end
            local seen = {}
            for _, folder in ipairs(foundSpiritFolders) do
                if folder and not seen[folder] then
                    seen[folder] = true
                    for _, spirit in ipairs(folder:GetChildren()) do
                        if spirit:IsA("Model") then
                            local part = spirit:FindFirstChild("HumanoidRootPart") or spirit:FindFirstChildWhichIsA("BasePart", true)
                            if part then
                                createHighlightForModel(spirit, Color3.fromRGB(200, 0, 200))
                            end
                        end
                    end
                end
            end
        end
        if not espMachinesOn and not espSpiritsOn then
            clearAllHighlights()
        end
        task.wait(1)
    end
end)

--// Auto Skillcheck (Toggle)
local autoSkillFlag = false

ReplicatedStorage.DescendantAdded:Connect(function(desc)
    if (desc:IsA("RemoteFunction") or desc:IsA("RemoteEvent")) and tostring(desc.Name):lower():find("skill") then
        if autoSkillFlag and desc:IsA("RemoteFunction") then
            desc.OnClientInvoke = function(...) return 2 end
        end
    end
end)

--// Infinite Stamina
local staminaFlag = false
local AddStamina
pcall(function()
    AddStamina = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("AddStamina")
end)
task.spawn(function()
    while true do
        if staminaFlag and AddStamina then
            pcall(function()
                firesignal(AddStamina.OnClientEvent, 45)
            end)
        end
        task.wait(0.2)
    end
end)

--// Auto Elevator
local autoElevatorFlag = false
task.spawn(function()
    while true do
        if autoElevatorFlag then
            local elevator = Workspace:FindFirstChild("Elevator")
            if elevator then
                local tele = elevator:FindFirstChild("TeleportExit") or elevator:FindFirstChild("Teleport")
                local msg = tele and tele:FindFirstChild("Message")
                if msg and msg.Enabled then
                    teleportToElevator()
                    repeat
                        task.wait(1)
                    until not msg.Enabled
                end
            end
        end
        task.wait(1)
    end
end)

--// Auto Teleport
local autoTeleportFlag = false
task.spawn(function()
    while true do
        if autoTeleportFlag then
            local parts = gatherMachineParts()
            if #parts > 0 then
                teleportToPart(parts[math.random(1, #parts)])
            end
        end
        task.wait(3)
    end
end)

--// WindUI Tabs
local TabSettings = Window:Tab({ Title = "Settings", Icon = "settings", Border = true })
local TabMain = Window:Tab({ Title = "Main", Icon = "home", Border = true })
local TabESP = Window:Tab({ Title = "ESP", Icon = "eye", Border = true })
local TabAutoCollect = Window:Tab({ Title = "Auto Collect", Icon = "package", Border = true })
local TabCredits = Window:Tab({ Title = "Credits", Icon = "heart", Border = true })
local TabSupport = Window:Tab({ Title = "Support", Icon = "gift", Border = true })
local TabFeedback = Window:Tab({ Title = "Feedback", Icon = "message-square", Border = true })
local TabPlayer = Window:Tab({ Title = "Player", Icon = "user", Border = true })

--// Settings Tab
TabSettings:Dropdown({
    Title = "Theme",
    Values = {
        "Default",
        "AmberGlow",
        "Amethyst",
        "Bloom",
        "DarkBlue",
        "Green",
        "Light",
        "Ocean",
        "Serenity"
    },
    Value = "Default",
    Callback = function(SelectedTheme)
        pcall(function()
            if Window.SetTheme then
                Window:SetTheme(SelectedTheme)
            elseif WindUI.SetTheme then
                WindUI:SetTheme(SelectedTheme)
            end
        end)
    end
})

TabSettings:Space()

TabSettings:Button({
    Title = "Save Config",
    Callback = function()
        local ok = pcall(function()
            local cfg = Window.ConfigManager:Config("TZ_Config")
            cfg:Save()
        end)
        WindUI:Notify({
            Title = "Settings",
            Content = ok and "Configuration saved!" or "Failed to save config",
            Duration = 4
        })
    end
})

TabSettings:Space()

TabSettings:Button({
    Title = "Load Config",
    Callback = function()
        local ok = pcall(function()
            local cfg = Window.ConfigManager:Config("TZ_Config")
            cfg:Load()
        end)
        WindUI:Notify({
            Title = "Settings",
            Content = ok and "Configuration loaded!" or "Failed to load config",
            Duration = 4
        })
    end
})

--// Main Tab
TabMain:Button({ Title = "Teleport: Nearest Machine", Callback = teleportToNearestMachine })
TabMain:Space()
TabMain:Button({ Title = "Teleport: Random Machine", Callback = teleportToRandomMachine })
TabMain:Space()
TabMain:Button({ Title = "Teleport: Elevator", Callback = teleportToElevator })
TabMain:Space()

TabMain:Toggle({
    Title = "Auto Teleport Machines",
    Type = "Toggle",
    Value = false,
    Callback = function(v) autoTeleportFlag = v end
})
TabMain:Space()

TabMain:Toggle({
    Title = "Auto Elevator",
    Type = "Toggle",
    Value = false,
    Callback = function(v) autoElevatorFlag = v end
})
TabMain:Space()

TabMain:Toggle({
    Title = "Infinite Stamina",
    Type = "Toggle",
    Value = false,
    Callback = function(v) staminaFlag = v end
})
TabMain:Space()

TabMain:Toggle({
    Title = "Godmode",
    Type = "Toggle",
    Value = false,
    Callback = function(v) godmodeFlag = v end
})
TabMain:Space()

TabMain:Toggle({
    Title = "Auto Skillcheck",
    Type = "Toggle",
    Value = false,
    Callback = function(v)
        autoSkillFlag = v
        for _, desc in ipairs(ReplicatedStorage:GetDescendants()) do
            if (desc:IsA("RemoteFunction") or desc:IsA("RemoteEvent")) and tostring(desc.Name):lower():find("skill") then
                if desc:IsA("RemoteFunction") then
                    desc.OnClientInvoke = v and function(...) return 2 end or nil
                end
            end
        end
    end
})
TabMain:Space()

local antiLagFlag = false
TabMain:Toggle({
    Title = "Anti Lag",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        antiLagFlag = state
        if state then
            task.spawn(function()
                while antiLagFlag do
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("Decal") or obj:IsA("Texture") then
                            pcall(function() obj:Destroy() end)
                        elseif obj:IsA("ParticleEmitter") then
                            pcall(function() obj.Enabled = false end)
                        elseif obj:IsA("Sound") then
                            pcall(function() obj:Stop() end)
                        end
                    end
                    task.wait(2)
                end
            end)
        end
    end
})
TabMain:Space()

local fullbrightEnabled = false
local oldLighting = {}
TabMain:Toggle({
    Title = "FullBright",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        fullbrightEnabled = state
        if state then
            oldLighting = {
                Brightness = Lighting.Brightness,
                ClockTime = Lighting.ClockTime,
                FogEnd = Lighting.FogEnd,
                GlobalShadows = Lighting.GlobalShadows,
                Ambient = Lighting.Ambient,
                OutdoorAmbient = Lighting.OutdoorAmbient
            }
            Lighting.Brightness = 3
            Lighting.ClockTime = 12
            Lighting.FogEnd = 1e9
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(255,255,255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
        else
            for prop, value in pairs(oldLighting) do
                pcall(function()
                    Lighting[prop] = value
                end)
            end
        end
    end
})
TabMain:Space()

local noFogEnabled = false
local originalFogEnd, originalFogStart
TabMain:Toggle({
    Title = "No Fog",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        noFogEnabled = state
        if state then
            originalFogEnd = Lighting.FogEnd
            originalFogStart = Lighting.FogStart
            task.spawn(function()
                while noFogEnabled do
                    Lighting.FogStart = 0
                    Lighting.FogEnd = 1e9
                    task.wait(1)
                end
            end)
        else
            if originalFogEnd then
                Lighting.FogEnd = originalFogEnd
            end
            if originalFogStart then
                Lighting.FogStart = originalFogStart
            end
        end
    end
})
TabMain:Space()

local autoSnowmapEnabled = false
TabMain:Toggle({
    Title = "Auto Snowmap",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        autoSnowmapEnabled = state
        if not state then return end
        task.spawn(function()
            local player = Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            local DropItem = player:WaitForChild("PlayerGui")
                :WaitForChild("main")
                :WaitForChild("Bottom")
                :WaitForChild("DropItem")
            while autoSnowmapEnabled do
                if not workspace:FindFirstChild("Floor")
                or not workspace.Floor:FindFirstChild("Map")
                or not workspace.Floor.Map:FindFirstChild("IceFloor") then
                    task.wait(1)
                    continue
                end
                local machines = workspace.Floor:FindFirstChild("Machines")
                if not machines then task.wait(1) continue end
                local didSomething = false
                if DropItem.Visible then
                    for _, machine in ipairs(machines:GetChildren()) do
                        if machine:FindFirstChild("Snowman") then
                            local middle = machine.Snowman:FindFirstChild("MiddleSnowball")
                            local prompt = middle and middle:FindFirstChildWhichIsA("ProximityPrompt")
                            if prompt then
                                hrp.CFrame = middle:GetPivot() + Vector3.new(0, 2, 0)
                                task.wait(0.2)
                                fireproximityprompt(prompt)
                                task.wait(0.4)
                                didSomething = true
                                break
                            end
                        end
                    end
                else
                    for _, machine in ipairs(machines:GetChildren()) do
                        if not machine.Name:lower():find("fuse") and machine:FindFirstChild("Pickup") then
                            for _, obj in ipairs(machine.Pickup:GetDescendants()) do
                                if obj:IsA("ProximityPrompt") then
                                    hrp.CFrame = obj.Parent:GetPivot() + Vector3.new(0, 2, 0)
                                    task.wait(0.2)
                                    fireproximityprompt(obj)
                                    task.wait(0.4)
                                    didSomething = true
                                    break
                                end
                            end
                        end
                        if didSomething then break end
                    end
                end
                if not didSomething then
                    local elevator = workspace:FindFirstChild("Elevator")
                    local part = elevator and elevator:FindFirstChildWhichIsA("BasePart")
                    if part then
                        hrp.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                    end
                    autoSnowmapEnabled = false
                    break
                end
                task.wait(0.3)
            end
        end)
    end
})
TabMain:Space()

--// Auto Farm
local AutoFarm = false
local TP_DELAY = 0.2

local function teleport(part, offsetY)
    offsetY = offsetY or 3
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp and part and part:IsA("BasePart") then
        hrp.CFrame = part.CFrame + Vector3.new(0, offsetY, 0)
    end
end

local function firePrompts(obj)
    for _, v in ipairs(obj:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            pcall(function() fireproximityprompt(v) end)
        end
    end
end

local function getFloor()
    return Workspace:FindFirstChild("Floor")
end

local function collectFolder(folderName)
    local floor = getFloor()
    if not floor then return end
    local folder = floor.Items:FindFirstChild(folderName)
    if not folder then return end
    for _, item in ipairs(folder:GetChildren()) do
        if not AutoFarm then return end
        local part = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart")
        if part then
            teleport(part)
            task.wait(TP_DELAY)
            firePrompts(item)
            task.wait(TP_DELAY)
        end
    end
end

local function isRepairing()
    return LocalPlayer.PlayerGui.main.Bottom:FindFirstChild("StopRepairing") ~= nil
end

local function getIncompleteMachines()
    local floor = getFloor()
    if not floor then return {} end
    local machines = {}
    for _, machine in ipairs(floor.Machines:GetChildren()) do
        if machine.Name ~= "FuseBox" then
            local completed = machine:FindFirstChild("Completed")
            if completed and completed.Value == false then
                table.insert(machines, machine)
            end
        end
    end
    return machines
end

local function workMachine(machine)
    local part = machine:FindFirstChildWhichIsA("BasePart", true)
    if part then
        teleport(part)
        task.wait(TP_DELAY)
        firePrompts(machine)
        repeat task.wait(0.2) until isRepairing()
        repeat task.wait(0.3) until not isRepairing() or (machine:FindFirstChild("Completed") and machine.Completed.Value == true)
    end
end

local function teleportElevatorIfArrow()
    local arrow = workspace.Elevator.TeleportExit.Message:FindFirstChild("Arrow")
    if arrow then
        local elevatorPart = workspace.Elevator.ElevatorModel:GetChildren()[3]:GetChildren()[5].Union
        if elevatorPart then
            teleport(elevatorPart, 5)
            repeat task.wait(0.5) until workspace:FindFirstChild("Floor")
            task.wait(1)
        end
    end
end

local function watchFloorChanges()
    local gameInfo = workspace:FindFirstChild("GameInformation")
    if not gameInfo then return end
    local floorVal = gameInfo:FindFirstChild("Floor")
    if not floorVal then return end
    floorVal:GetPropertyChangedSignal("Value"):Connect(function()
        if AutoFarm then
            task.spawn(function()
                collectFolder("Capsules")
                collectFolder("Currencies")
                local incompleteMachines = getIncompleteMachines()
                while #incompleteMachines > 0 and AutoFarm do
                    workMachine(incompleteMachines[1])
                    incompleteMachines = getIncompleteMachines()
                end
            end)
        end
    end)
end

local function watchEyeIcon()
    local topGui = LocalPlayer.PlayerGui.main.Top
    topGui.ChildAdded:Connect(function(child)
        if child.Name == "EyeIcon" and AutoFarm then
            local incompleteMachines = getIncompleteMachines()
            for _, machine in ipairs(incompleteMachines) do
                firePrompts(machine)
            end
        end
    end)
end

TabMain:Toggle({
    Title = "Auto Farm",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        AutoFarm = state
        if AutoFarm then
            watchFloorChanges()
            watchEyeIcon()
            task.spawn(function()
                while AutoFarm do
                    collectFolder("Capsules")
                    collectFolder("Currencies")
                    local incompleteMachines = getIncompleteMachines()
                    while #incompleteMachines > 0 and AutoFarm do
                        local machine = incompleteMachines[math.random(1, #incompleteMachines)]
                        workMachine(machine)
                        incompleteMachines = getIncompleteMachines()
                        task.wait(0.2)
                    end
                    teleportElevatorIfArrow()
                    task.wait(0.2)
                end
            end)
        end
    end
})

--// ESP Tab
TabESP:Toggle({
    Title = "ESP Machines",
    Type = "Toggle",
    Value = false,
    Callback = function(v)
        espMachinesOn = v
        if not v then clearAllHighlights() end
    end
})
TabESP:Space()

TabESP:Toggle({
    Title = "ESP Spirits",
    Type = "Toggle",
    Value = false,
    Callback = function(v)
        espSpiritsOn = v
        if not v then clearAllHighlights() end
    end
})
TabESP:Space()

--// Player ESP
local espPlayersOn = false
local espNameOn = true
local espDistanceOn = true
local playerESPMap = {}

local function createOrUpdatePlayerESP(player)
    if not player.Character then return end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local data = playerESPMap[player]
    if not data then
        local highlight = Instance.new("Highlight")
        highlight.Name = "TZ_PlayerHighlight"
        highlight.Adornee = player.Character
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
        highlight.FillTransparency = 0.7
        highlight.Parent = workspace
        local billboard, textLabel
        if espNameOn or espDistanceOn then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "TZ_PlayerESPText"
            billboard.Adornee = hrp
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            textLabel.TextScaled = true
            textLabel.Text = player.Name
            textLabel.Parent = billboard
            billboard.Parent = workspace
        end
        playerESPMap[player] = {
            highlight = highlight,
            billboard = billboard,
            textLabel = textLabel
        }
    end
    local data2 = playerESPMap[player]
    if data2 and data2.textLabel then
        local dist = math.floor((hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
        if espNameOn and espDistanceOn then
            data2.textLabel.Text = player.Name .. " | " .. dist .. "m"
        elseif espNameOn then
            data2.textLabel.Text = player.Name
        elseif espDistanceOn then
            data2.textLabel.Text = dist .. "m"
        else
            data2.textLabel.Text = ""
        end
    end
end

local function removePlayerESP(player)
    local data = playerESPMap[player]
    if data then
        if data.highlight then pcall(function() data.highlight:Destroy() end) end
        if data.billboard then pcall(function() data.billboard:Destroy() end) end
        playerESPMap[player] = nil
    end
end

task.spawn(function()
    while true do
        if espPlayersOn then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    createOrUpdatePlayerESP(player)
                end
            end
        else
            for player, _ in pairs(playerESPMap) do
                removePlayerESP(player)
            end
        end
        task.wait(0.5)
    end
end)

Players.PlayerRemoving:Connect(removePlayerESP)

TabESP:Toggle({
    Title = "ESP Players",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        espPlayersOn = state
    end
})
TabESP:Space()

TabESP:Toggle({
    Title = "ESP Name",
    Type = "Toggle",
    Value = true,
    Callback = function(state)
        espNameOn = state
    end
})
TabESP:Space()

TabESP:Toggle({
    Title = "ESP Distance",
    Type = "Toggle",
    Value = true,
    Callback = function(state)
        espDistanceOn = state
    end
})
TabESP:Space()

--// Item ESP
local ItemsESPEnabled = false
local ItemHighlights = {}

local function clearItemESP()
    for _, h in pairs(ItemHighlights) do
        if h and h.Parent then
            h:Destroy()
        end
    end
    table.clear(ItemHighlights)
end

local function createItemESP(obj)
    if ItemHighlights[obj] then return end
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(0, 180, 0)
    highlight.FillTransparency = 0.5
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = obj
    highlight.Parent = obj
    ItemHighlights[obj] = highlight
end

task.spawn(function()
    while task.wait(0.5) do
        if not ItemsESPEnabled then
            clearItemESP()
            continue
        end
        local itemsFolder = workspace:FindFirstChild("Floor")
            and workspace.Floor:FindFirstChild("Items")
            and workspace.Floor.Items:FindFirstChild("Items")
        if not itemsFolder then continue end
        for _, item in ipairs(itemsFolder:GetChildren()) do
            local spawnFolder = item:FindFirstChild("Spawn")
            if spawnFolder then
                for _, realItem in ipairs(spawnFolder:GetChildren()) do
                    if realItem:IsA("BasePart") or realItem:IsA("Model") then
                        createItemESP(realItem)
                    end
                end
            end
        end
    end
end)

TabESP:Toggle({
    Title = "Item ESP",
    Type = "Toggle",
    Value = false,
    Callback = function(v)
        ItemsESPEnabled = v
        if not v then
            clearItemESP()
        end
    end
})

--// Auto Collect Tab
TabAutoCollect:Button({
    Title = "Collect Currency",
    Callback = function()
        local items = workspace.Floor.Items.Currencies:GetChildren()
        for i = 1, #items do
            local item = items[i]
            local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = item:GetPivot()
                    task.wait(0.3)
                    fireproximityprompt(prompt)
                end
                break
            end
        end
    end
})
TabAutoCollect:Space()

TabAutoCollect:Button({
    Title = "Collect Capsule",
    Callback = function()
        local items = workspace.Floor.Items.Capsules:GetChildren()
        for i = 1, #items do
            local item = items[i]
            local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = item:GetPivot()
                    task.wait(0.3)
                    fireproximityprompt(prompt)
                end
                break
            end
        end
    end
})
TabAutoCollect:Space()

local autoCurrency = false
TabAutoCollect:Toggle({
    Title = "Auto Collect Currency",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        autoCurrency = state
        if state then
            task.spawn(function()
                while autoCurrency do
                    local items = workspace.Floor.Items.Currencies:GetChildren()
                    for i = 1, #items do
                        if not autoCurrency then break end
                        local item = items[i]
                        local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if prompt and hrp then
                            hrp.CFrame = item:GetPivot()
                            task.wait(0.25)
                            fireproximityprompt(prompt)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
TabAutoCollect:Space()

local autoCapsule = false
TabAutoCollect:Toggle({
    Title = "Auto Collect Capsule",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        autoCapsule = state
        if state then
            task.spawn(function()
                while autoCapsule do
                    local items = workspace.Floor.Items.Capsules:GetChildren()
                    for i = 1, #items do
                        if not autoCapsule then break end
                        local item = items[i]
                        local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if prompt and hrp then
                            hrp.CFrame = item:GetPivot()
                            task.wait(0.25)
                            fireproximityprompt(prompt)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})
TabAutoCollect:Space()

local autoSnowflakes = false
TabAutoCollect:Toggle({
    Title = "Auto Collect Snowflakes",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        autoSnowflakes = state
        if state then
            task.spawn(function()
                local player = Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                local originalCFrame = hrp.CFrame
                while autoSnowflakes do
                    local folder = workspace:FindFirstChild("Floor")
                        and workspace.Floor:FindFirstChild("Items")
                        and workspace.Floor.Items:FindFirstChild("Currencies")
                    if not folder then break end
                    local children = folder:GetChildren()
                    local foundAny = false
                    for index, item in ipairs(children) do
                        if not autoSnowflakes then break end
                        if index == 2 then continue end
                        if not item.Name:lower():find("snow") then continue end
                        local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt then
                            foundAny = true
                            hrp.CFrame = item:GetPivot() + Vector3.new(0, 2, 0)
                            task.wait(0.25)
                            pcall(function()
                                fireproximityprompt(prompt)
                            end)
                            task.wait(0.3)
                        end
                    end
                    if not foundAny then
                        hrp.CFrame = originalCFrame
                        autoSnowflakes = false
                        break
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

--// Credits Tab
TabCredits:Paragraph({ Title = "Created by Ali_hhjjj" })
TabCredits:Paragraph({ Title = "Tester: GoodJOBS3" })
TabCredits:Paragraph({ Title = "Thanks to Olivia (creator of Riddance Hub) and shelly (Riddance manager) for Rayfield idea" })

--// Support Tab
local function copyLink(name, link)
    setclipboard(link)
    WindUI:Notify({
        Title = "Copied!",
        Content = name .. " link copied to clipboard",
        Duration = 3
    })
end

TabSupport:Button({
    Title = "linkvertice",
    Callback = function()
        setclipboard("https://link-hub.net/1402067/y38uvYI5ny4q")
        notify("Link copied to clipboard!")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 3 Robux",
    Callback = function()
        copyLink("3 Robux", "https://www.roblox.com/game-pass/1393917970/3-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 5 Robux",
    Callback = function()
        copyLink("5 Robux", "https://www.roblox.com/game-pass/1394051778/5-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 7 Robux",
    Callback = function()
        copyLink("7 Robux", "https://www.roblox.com/game-pass/1590110782/7-ROBUX")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 10 Robux",
    Callback = function()
        copyLink("10 Robux", "https://www.roblox.com/game-pass/1397546692/10-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 20 Robux",
    Callback = function()
        copyLink("20 Robux", "https://www.roblox.com/game-pass/1399668269/20-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 50 Robux",
    Callback = function()
        copyLink("50 Robux", "https://www.roblox.com/game-pass/1396221207/50-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 100 Robux",
    Callback = function()
        copyLink("100 Robux", "https://www.roblox.com/game-pass/1394439639/100-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 150 Robux",
    Callback = function()
        copyLink("150 Robux", "https://www.roblox.com/game-pass/1421451261/Thanks")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 200 Robux",
    Callback = function()
        copyLink("200 Robux", "https://www.roblox.com/game-pass/1423400055/Ty")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 300 Robux",
    Callback = function()
        copyLink("300 Robux", "https://www.roblox.com/game-pass/1504992105/300-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 500 Robux",
    Callback = function()
        copyLink("500 Robux", "https://www.roblox.com/game-pass/1395983236/500-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 1000 Robux",
    Callback = function()
        copyLink("1000 Robux", "https://www.roblox.com/game-pass/1394041876/1000-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 1000 Robux (Thanks)",
    Callback = function()
        copyLink("1000 Robux Thanks", "https://www.roblox.com/game-pass/1460106222/Thanks-nnnnn")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 2500 Robux",
    Callback = function()
        copyLink("2500 Robux", "https://www.roblox.com/game-pass/1437117512/2-500-robux")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 3000 Robux",
    Callback = function()
        copyLink("3000 Robux", "https://www.roblox.com/game-pass/1587430862/3000-Robux")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 5000 Robux",
    Callback = function()
        copyLink("5000 Robux", "https://www.roblox.com/game-pass/1395963387/5000-rbx")
    end
})
TabSupport:Space()

TabSupport:Button({
    Title = "💎 10000 Robux",
    Callback = function()
        copyLink("10000 Robux", "https://www.roblox.com/game-pass/1399060598/10000-rbx")
    end
})

createfeedback()

--// Player Tab
local noclipEnabled, flyEnabled, flySpeed = false, false, 50
local noclipConnection, flyConnection

TabPlayer:Toggle({
    Title = "Noclip",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        noclipEnabled = state
        if noclipEnabled then
            noclipConnection = RunService.Stepped:Connect(function()
                if noclipEnabled and LocalPlayer.Character then
                    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        elseif noclipConnection then
            noclipConnection:Disconnect()
        end
    end
})
TabPlayer:Space()

TabPlayer:Toggle({
    Title = "Fly",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        flyEnabled = state
        if flyEnabled then
            flyConnection = RunService.RenderStepped:Connect(function()
                if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local cam = workspace.CurrentCamera
                    local moveDir = LocalPlayer.Character.Humanoid.MoveDirection
                    hrp.Velocity = (moveDir.Magnitude > 0) and (cam.CFrame.LookVector * moveDir.Magnitude * flySpeed) or Vector3.new(0,0,0)
                end
            end)
        elseif flyConnection then
            flyConnection:Disconnect()
            if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end
        end
    end
})
TabPlayer:Space()

TabPlayer:Slider({
    Title = "Fly Speed",
    Step = 5,
    Value = {
        Min = 20,
        Max = 200,
        Default = 50,
    },
    Callback = function(v) flySpeed = v end
})
TabPlayer:Space()

TabPlayer:Slider({
    Title = "Walk Speed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 200,
        Default = 16,
    },
    Callback = function(v)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
    end
})

--// Owner notification
local OWNER_NAME = "Ali_hhjjj"
local function notifyOwner()
    StarterGui:SetCore("SendNotification", {
        Title = "TZ Owner",
        Text = "The owner joined your server",
        Duration = 8
    })
end
for _, plr in pairs(Players:GetPlayers()) do
    if plr.Name == OWNER_NAME then
        notifyOwner()
    end
end
Players.PlayerAdded:Connect(function(plr)
    if plr.Name == OWNER_NAME then
        notifyOwner()
    end
end)



WindUI:Notify({
    Title = "TZ announcement",
    Content = "Gonna delete some useless tabs soon",
    Duration = 6.5,
    Icon = "megaphone",
})

    