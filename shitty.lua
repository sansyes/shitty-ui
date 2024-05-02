local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local loadedorunloaded = false
local funcs = {}
local version = "1.0.1"
local playerselected = nil
local Window = Fluent:CreateWindow({
    Title = "shitty ui " ..version,
    SubTitle = "by sans on discord fr add me :)",
    TabWidth = 140,
    Size = UDim2.fromOffset(780, 520),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.F6 -- Used when theres no MinimizeKeybind
})
local Options = Fluent.Options

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Mic Arab", Icon = "sprout" }),
    mm2 = Window:AddTab({ Title = "MM2", Icon = "slice"}),
    Players = Window:AddTab({ Title = "Players", Icon = "users"}),
    Misc = Window:AddTab({ Title = "Misc", Icon = "star" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
Window:SelectTab(1)
local playerlist = {}

for _,i in pairs(game.Players:GetChildren()) do
    if i ~= game.Players.LocalPlayer and not table.find(playerlist,i.Name) then
        table.insert(playerlist,i.Name)
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    if not table.find(playerlist,plr.Name) then
        print(table.find(playerlist,plr.Name))
        table.insert(playerlist,plr.Name)
    end
end)

game.Players.PlayerRemoving:Connect(function(plr)
    if table.find(playerlist,plr.Name) then
        table.remove(playerlist,table.find(playerlist,plr.Name))
    end
end)


do
    local plrselec = Tabs.Players:AddDropdown("Dropdown", {
        Title = "Players Selection",
        Values = playerlist,
        Multi = false,
        Default = "None",
    })

    plrselec:OnChanged(function(Value)
        if playerselected ~= nil then 
            if game.Players:FindFirstChild(playerselected) then
                if game.Players:FindFirstChild(playerselected).Character:FindFirstChildOfClass("Highlight") then
                    game.Players:FindFirstChild(playerselected).Character:FindFirstChildOfClass("Highlight"):Destroy()
                end
            end
        end
        playerselected = Value
        if playerselected ~= nil then 
            if game.Players:FindFirstChild(playerselected) then
                if not game.Players:FindFirstChild(playerselected).Character:FindFirstChildOfClass("Highlight") then
                    local chams = Instance.new("Highlight")
                    chams.OutlineColor = Color3.fromRGB(0, 187, 255)
                    chams.FillTransparency = 1
                    chams.Parent = game.Players:FindFirstChild(playerselected).Character
                end
            end
        end
    end)
    local autofarmcoins = Tabs.mm2:AddToggle("autofarmcoinss", {Title = "autofarm - coins", Default = false })

    autofarmcoins:OnChanged(function()
        if Options.autofarmcoinss.Value == true then
            funcs.autofarmcoins(true)
        end
    end)


    Tabs.Players:AddButton({
        Title = "Teleport to player",
        Description = "to teleport to selected player",
        Callback = function()
            if playerselected == nil then
                Fluent:Notify({
                    Title = "teleport to selected player",
                    Content = "Select A player to teleport to selected Player.",
                    Duration = 3
                })
            else
                if game.Players:FindFirstChild(playerselected) then
                    game.Players.LocalPlayer.Character:MoveTo(game.Players:FindFirstChild(playerselected).Character.HumanoidRootPart.Position)
                end
            end
        end
    })

    if game.PlaceId == 10200194177 or 15568252850 then
        Tabs.Main:AddButton({
            Title = "Kill All",
            Description = "Kills all players",
            Callback = function()
            funcs.killall()
            end
        })
        Tabs.Main:AddButton({
            Title = "Cuff all",
            Description = "Cuffing all players in mic arab very epic [buggy a bit]",
            Callback = function()
                funcs.cuffall()
                Fluent:Notify({
                    Title = "cuff all",
                    Content = "this may take a min if it take a long time unequip cuffs and equip it again and run cuff all again.",
                    Duration = 3
                })
            end
        })

        Tabs.Main:AddButton({
            Title = "Cuff selected player",
            Description = "Cuffs Selected player in mic arab very epic select players in players tab [buggy a bit - i think]",
            Callback = function()
                if playerselected == nil then 
                    Fluent:Notify({
                        Title = "cuff selected player",
                        Content = "Select A player to use cuff selected Player.",
                        Duration = 3
                    })
                    else
                    if not game.Players:FindFirstChild(playerselected) then

                    end
                end
                funcs.cuffplr(game.Players:FindFirstChild(playerselected))
                Fluent:Notify({
                    Title = "cuff selected player",
                    Content = "this may take a min if it take a long time unequip cuffs and equip it again and run cuff all again.",
                    Duration = 3
                })
            end
        })

        Tabs.Main:AddButton({
            Title = "kill selected player",
            Description = "kill Selected player in mic arab very epic select players in players tab [buggy a bit - i think]",
            Callback = function()
                if playerselected == nil then 
                    Fluent:Notify({
                        Title = "kill selected player",
                        Content = "Select A player to use kill selected Player.",
                        Duration = 3
                    })
                    return
                    else
                    if not game.Players:FindFirstChild(playerselected) then
                        return
                    end
                    funcs.killplr(game.Players:FindFirstChild(playerselected))
                end
            end
        })
    else
        Tabs.Main:AddParagraph({
            Title = "Read this",
            Content = "Please Join The Game To View the Tools!"
        })
        Tabs.Main:AddButton({
            Title = "Auto Join",
            Description = "Teleports you to the game for the tools",
            Callback = function()
                game:GetService("TeleportService"):Teleport(10200194177, LocalPlayer) task.wait()
            end
        })
    end
    
    Tabs.Misc:AddButton({
        Title = "Rejoin",
        Description = "Rejoin the same game",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) task.wait()
         end
    })

    task.spawn(function()
        while wait(0.04) do
            for _,i in pairs(game.Players:GetPlayers()) do
                if playerselected ~= nil then
                    if i.Name ~= playerselected then
                        if i and i.Character and i.Character:FindFirstChild("Highlight") then
                                i.Character:FindFirstChildOfClass("Highlight"):Destroy()
                        end
                    end
                end
                if game.Players:FindFirstChild(playerselected) then
                    if not game.Players:FindFirstChild(playerselected).Character:FindFirstChildOfClass("Highlight") then
                        plrselec:SetValue(playerselected)
                        local chams = Instance.new("Highlight")
                        chams.OutlineColor = Color3.fromRGB(0, 187, 255)
                        chams.FillTransparency = 1
                        chams.Parent = game.Players:FindFirstChild(playerselected).Character
                    end
                end
            end
        end
    end)
end



InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
--load

Fluent:Notify({
    Title = "shitty ui",
    Content = "shitty ui has been loaded.",
    Duration = 4
})
loadedorunloaded = true

-----functions commands n shit

function checkfor(s)
    task.spawn(function()
        while wait() do
            if s then
                return true
            end
        end
    end)
end

function funcs.killplr(plr:Player)
    local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local partstand = Instance.new("Part",Workspace)
    partstand.Position = Vector3.new(-368,-500,-275)
    partstand.Size = Vector3.new(3,0,3)
    partstand.Anchored = true
    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(-368,-499,-275)))
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") and not game.Players.LocalPlayer.Character:FindFirstChild("Handcuff")  then
        Fluent:Notify({
            Title = "kill selected player",
            Content = "you do not have handcuff/handcuffs or the name of the headcuffs has been renamed.",
            Duration = 4
        })
        return
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff"))
    end
    if plr ~= game.Players.LocalPlayer then
        if not plr.Character:FindFirstChild("Handcuff") then
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Handcuff").DataSender:FireServer(plr.Character.Head)
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Handcuff").DataSender:FireServer()
        end
    end
    wait(0.014)
    game.Players.LocalPlayer.Character:PivotTo(oldcframe)
    partstand:Destroy()
end

function funcs.killall()
    local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local partstand = Instance.new("Part",Workspace)
    partstand.Position = Vector3.new(-368,-501,-275)
    partstand.Size = Vector3.new(3,0,3)
    partstand.Anchored = true
    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(-368,-499,-275)))
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") and not game.Players.LocalPlayer.Character:FindFirstChild("Handcuff")  then
        Fluent:Notify({
            Title = "kill all",
            Content = "you do not have handcuff/handcuffs or the name of the headcuffs has been renamed.",
            Duration = 4
        })
        return
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff"))
    end
    for i,v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            if not v.Character:FindFirstChild("Handcuff") then
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("Handcuff").DataSender:FireServer(v.Character.Head)
                wait(0.01)
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("Handcuff").DataSender:FireServer()
            end
        end
    end
    wait(0.003)
    game.Players.LocalPlayer.Character:PivotTo(oldcframe)
    partstand:Destroy()
end

function funcs.autofarmcoins(boolean)
    if boolean == true then
        local results = checkfor(Workspace:FindFirstChild()("Normal"))
        if results == true  then 
            for _,i in pairs(Workspace:WaitForChild("Normal").CoinContainer:GetChildren()) do
                game.Players.LocalPlayer.Character:MoveTo(i.Position)
                wait(0.4)
            end
        else
            Fluent:Notify({
                Title = "shitty ui - mm2",
                Content = "Please wait for the map to load.",
                Duration = 3
            })
            Options.autofarmcoinss:SetValue(false)
            return
        end
    elseif boolean == false then
    end
end

function funcs.checkplayerclicked()
    if game.Players.LocalPlayer:GetMouse().Target.Parent then
        if game.Players.LocalPlayer:GetMouse().Target.Parent:IsA("Model") then
            if game.Players.LocalPlayer:GetMouse().Target.Parent:FindFirstChildOfClass("Humanoid") then
                if game.Players:GetPlayerFromCharacter(game.Players.LocalPlayer:GetMouse().Target.Parent) then
                    playerselected = game.Players:GetPlayerFromCharacter(game.Players.LocalPlayer:GetMouse().Target.Parent).Name
                    Fluent:Notify({
                        Title = "Mouse selection",
                        Content = "Selected Player : "..playerselected,
                        Duration = 3
                    })
                end
            end
        else
            if game.Players.LocalPlayer:GetMouse().Target.Parent.Parent:IsA("Model") then
                
                if game.Players.LocalPlayer:GetMouse().Target.Parent.Parent:FindFirstChildOfClass("Humanoid") then
                    if game.Players:GetPlayerFromCharacter(game.Players.LocalPlayer:GetMouse().Target.Parent.Parent) then
                        playerselected = game.Players:GetPlayerFromCharacter(game.Players.LocalPlayer:GetMouse().Target.Parent.Parent).Name
                    end
                end
            end
        end
    end
end

function funcs.cuffall()
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") and not game.Players.LocalPlayer.Character:FindFirstChild("Handcuff")  then
        Fluent:Notify({
            Title = "Cuff all",
            Content = "you do not have handcuff/handcuffs or the name of the headcuffs has been renamed.",
            Duration = 4
        })
        return
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff"))
    end
    task.wait(0.05)
    for i,v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            if not v.Character:FindFirstChild("Handcuff") then
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("Handcuff").DataSender:FireServer(v.Character.Head)
            end
        end
    end
end

function funcs.cuffplr(plr:Player)
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") and not game.Players.LocalPlayer.Character:FindFirstChild("Handcuff")  then
        Fluent:Notify({
            Title = "Cuff selected player",
            Content = "you do not have handcuff/handcuffs or the name of the headcuffs has been renamed.",
            Duration = 4
        })
        return
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff"))
    end
    game:GetService("Players").LocalPlayer.Character.Handcuff.DataSender:FireServer(plr.Character.Head)
end

game.Players.LocalPlayer:GetMouse().Button1Down:Connect(funcs.checkplayerclicked)
