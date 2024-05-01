local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local funcs = {}
local playerselected = nil
local Window = Fluent:CreateWindow({
    Title = "shitty ui " .. Fluent.Version,
    SubTitle = "by sans on discord fr add me :)",
    TabWidth = 140,
    Size = UDim2.fromOffset(780, 520),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.F6 -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Mic Arab", Icon = "sprout" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "star" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
Window:SelectTab(1)
local playerlist = {}

for _,i in pairs(game.Players:GetChildren()) do
    if i ~= game.Players.LocalPlayer then
        table.insert(playerlist,i.Name)
    end
end
print(game.HttpService:JSONEncode(playerlist))
do
    local plrselec = Tabs.Main:AddDropdown("Dropdown", {
        Title = "Players Selection",
        Values = playerlist,
        Multi = false,
        Default = 0,
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
        Description = "Cuffs Selected player in mic arab very epic [buggy a bit - i think]",
        Callback = function()
            if playerselected == nil then 
                return
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
        Title = "UnCuff self",
        Description = "Uncuff yourself in mic arab very epic",
        Callback = function()
            funcs.uncuffself()
            end
    })
    
    Tabs.Misc:AddButton({
        Title = "Rejoin",
        Description = "Rejoin the same game",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) task.wait()
         end
    })
end



InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
--load

Fluent:Notify({
    Title = "shitty ui",
    Content = "shitty ui has been loaded.",
    Duration = 4
})

-----functions commands n shit

function funcs.uncuffself()
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") and not game.Players.LocalPlayer.Character:FindFirstChild("Handcuff")  then
        Fluent:Notify({
            Title = "UnCuff self",
            Content = "you do not have handcuff/handcuffs or the name of the headcuffs has been renamed.",
            Duration = 4
        })
        return
    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff"))
    end
    task.wait(0.05)
    for _,i in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if i:IsA("MeshPart"or"Part") then
             game:GetService("Players").LocalPlayer.Character.Handcuff.DataSender:FireServer(game.Players.LocalPlayer.Character.Head)
             game:GetService("Players").LocalPlayer.Character.Handcuff.DataSender:FireServer()
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
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Handcuff").DataSender:FireServer(v.Character.Head)
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
    task.wait(0.05)
    game:GetService("Players").LocalPlayer.Character.Handcuff.DataSender:FireServer(plr.Character.Head)
end
