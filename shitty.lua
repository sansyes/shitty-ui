local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local pickedplayernorpag = nil


local GUI = Library:create{
    Name = "shitty ui",
    Theme = Library.Themes.Legacy,
}

local tab = GUI:Tab{
    Name = "Mic Arab",
    Icon = 'rbxassetid://12493101081'
}
local tab22 = GUI:Tab{
    Name = "Normal",
}
tab:Toggle({
    Name = "Spam Cuffs [Takes Abit of time]",
    Callback = function(state)
    print(state)
        if state == true then
            task.spawn(function()
             while wait(0.05) do
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then
                        game:GetService("Players").LocalPlayer.Character.Handcuff.DataSender:FireServer(v.Character.UpperTorso)
                    end
                end
            end 
        end)
        end
    end
})
tab:Button{
    Name = "Give Cuffs",
    Callback = function()
        
-- script made by Sans#0009 Thanks For Using my Script Dont Remove This Credits Please --

for i,v in pairs(game.Players:GetPlayers()) do
				if v.Backpack:FindFirstChild("Admin Cuffs") == nil then	
						else
												if game.Players.LocalPlayer.Backpack:FindFirstChild("Admin Cuffs") == nil then
					v.Backpack:FindFirstChild("Admin Cuffs").Parent = game.Players.LocalPlayer.Backpack
							end
				end
						if v.Backpack:FindFirstChild("Handcuff") == nil then	
				else
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Handcuff") == nil then
					v.Backpack:FindFirstChild("Handcuff").Parent = game.Players.LocalPlayer.Backpack
							end
		end
end  


-- script made by Sans#0009 Thanks For Using my Script Dont Remove This Credits Please --
    end
}

tab22:Textbox{
    Name = "Players",

    Callback = function(text)
        if text == "me" then
            game.workspace.CurrentCamera.Parent = game.Players.LocalPlayer
        end
    end
}


tab22:Button{
    Name = "Chams",
    Callback = function()
        while wait() do
            for _,i in pairs(game.Players:GetPlayers()) do
                if i.Character:FindFirstChild("Highlight") == nil and i ~= game.Players.LocalPlayer then
                    local chams = Instance.new("Highlight")
                    chams.OutlineColor = Color3.fromRGB(0, 187, 255)
                    chams.FillTransparency = 1
                    chams.Parent = i.Character
                end
            end
            return
        end
    end
}
tab22:Button{
    Name = " Remove Chams",
    Callback = function()
        while wait() do
            for _,i in pairs(game.Players:GetPlayers()) do
                if i.Character:FindFirstChild("Highlight") == nil then
                    else
                        i.Character.Highlight:Destroy()
                    
                end
            end
            return
        end
    end
}
GUI:Notification{
	Title = "Alert",
	Text = "welcome niggers to shitty ui",
	Duration = 3,
	Callback = function() end
}


tab22:Button{
    Name = "ReJoin",
    Callback = function()
        GUI:Prompt{
            Followup = false,
            Title = "WARNING",
            Text = "you want to rejoin the same game?",
            Buttons = {
                ok = function()
                    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) task.wait()
                    return true
                end,
                no = function()
                    return false
                end
            }
        }
    end
}

local playerslist = {}
local MyDropdown = tab22:Dropdown{
	Name = "Players",
	StartingText = "Select...",
	Description = nil,
	Items = {},
	Callback = function(item)
        print(Items)
        for _,i in pairs(playerslist) do
            if table.find([playerslist,]) then pickedplayernorpag = i end
        end
        return
    end
}
tab22:Button{
    Name = "Pick Cham",
    Callback = function()
        if pickedplayernorpag == nil then
            GUI:Notification{
                Title = "Alert",
                Text = "Please pick a player to give cham",
                Duration = 4,
                Callback = function() end
            }
        else
            local chams = Instance.new("Highlight")
            chams.OutlineColor = Color3.fromRGB(0, 187, 255)
            chams.FillTransparency = 1
            chams.Parent = game.Players:FindFirstChild(MyDropdown.StartingText()).Character
        end
    end
}
while wait() do
    local num = 0
    for _,i in pairs(game.Players:GetPlayers()) do
        num += 1
        MyDropdown:AddItems({
            {i.Name, num}
        })
        table.insert(playerslist,i.Name)
        
    end
    return
end
