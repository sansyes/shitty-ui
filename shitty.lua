local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))();
local HS = game:GetService("HttpService");
getgenv().afk_spam = false;
getgenv().afk_spam_speed = 0.5;
getgenv().spam_commandlogger = false;
getgenv().ESPValue = false;
local Players = game:GetService("Players");
local infojson = HS:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/sansyes/shitty-ui/main/info.json"));
local Window = Library.CreateLib("Sex Hack - Verson : " .. tostring(infojson.Verson), "Midnight");
local info = Window:NewTab("Info");
local things = info:NewSection("Script/Hack info");
things:NewLabel("Verson : " .. tostring(infojson.Verson));
things:NewLabel("[DEV] Message : \n" .. infojson.Message);
local Credits = info:NewSection("Credits");
Credits:NewLabel("Discord : " .. tostring(infojson.discordlink));
local AH = Window:NewTab("Arab Hangout");
local ViusalThings = AH:NewSection("Viusal fun");
ViusalThings:NewToggle("ESP", "ESP", function(state)
	if (state == true) then
		getgenv().ESPValue = true;
		for _, i in pairs(Players:GetPlayers()) do
			if (i ~= Players.LocalPlayer) then
				if not i.Character:FindFirstChild("ESP_sex") then
					local FlatIdent_1B51D = 0;
					while true do
						if (FlatIdent_1B51D == 1) then
							Players.PlayerAdded:Connect(function(plrr)
								if (getgenv().ESPValue == true) then
									plrr.CharacterAdded:Connect(function(char)
										if not char:FindFirstChild("ESP_sex") then
											createesp(plrr);
										end
									end);
								end
							end);
							break;
						end
						if (FlatIdent_1B51D == 0) then
							createesp(i);
							i.Character:WaitForChild("Humanoid").StateChanged:Connect(function(state)
								if (getgenv().ESPValue == true) then
									if ((state == Enum.HumanoidStateType.Dead) or (i.Character:WaitForChild("Humanoid").Health <= 0)) then
										createesp(i);
									end
								end
							end);
							FlatIdent_1B51D = 1;
						end
					end
				end
			end
		end
	else
		local FlatIdent_25DF3 = 0;
		while true do
			if (FlatIdent_25DF3 == 0) then
				getgenv().ESPValue = false;
				for _, i in pairs(Players:GetPlayers()) do
					if i.Character:FindFirstChild("ESP_sex") then
						i.Character:FindFirstChild("ESP_sex"):Destroy();
					end
				end
				break;
			end
		end
	end
end);
ViusalThings:NewSlider("Spam afk SPEED", "", 100, 1, function(s)
	getgenv().afk_spam_speed = s;
end);
ViusalThings:NewToggle("Spam afk", "Spam afk and unafk", function(state)
	if (state == true) then
		local FlatIdent_378D0 = 0;
		while true do
			if (FlatIdent_378D0 == 0) then
				getgenv().afk_spam = true;
				AFKSP();
				break;
			end
		end
	else
		getgenv().afk_spam = false;
	end
end);
local OPTHIG = AH:NewSection("Op Shit");
OPTHIG:NewButton("Get Cuffs", "Gives Handcuffs for free to you", function()
	local FlatIdent_74348 = 0;
	local func;
	while true do
		if (FlatIdent_74348 == 0) then
			func = getcuffs();
			if ((typeof(func) == "Instance") and not Players.LocalPlayer.Backpack:FindFirstChild("Handcuffs")) then
				func.Parent = Players.LocalPlayer.Backpack;
			else
				print("there is no one with cuffs to steal");
			end
			break;
		end
	end
end);
OPTHIG:NewButton("Cuff All [ Working ]", "Cuffs all players if there you have handcuffs", function()
	local FlatIdent_2953F = 0;
	while true do
		if (FlatIdent_2953F == 0) then
			if (not Players.LocalPlayer.Backpack:FindFirstChild("Handcuffs") or not Players.LocalPlayer.Character:FindFirstChild("Handcuffs")) then
				local FlatIdent_6B983 = 0;
				local func;
				while true do
					if (FlatIdent_6B983 == 0) then
						func = getcuffs();
						if ((typeof(func) == "Instance") and not Players.LocalPlayer.Backpack:FindFirstChild("Handcuffs")) then
							func.Parent = Players.LocalPlayer.Backpack;
						else
							print("there is no one with cuffs to steal");
						end
						break;
					end
				end
			end
			Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(Players.LocalPlayer.Backpack:FindFirstChild("Handcuffs"));
			FlatIdent_2953F = 1;
		end
		if (FlatIdent_2953F == 1) then
			wait();
			task.spawn(function()
				for _, i in pairs(Players:GetPlayers()) do
					if ((i ~= Players.LocalPlayer) and not i.Character:FindFirstChild("Handcuffs")) then
						cuff(i);
					end
				end
			end);
			break;
		end
	end
end);
OPTHIG:NewToggle("Spam Logger", "Spam Logger, spams the event logger", function(state)
	if (state == true) then
		getgenv().spam_commandlogger = true;
		SpamLoggerEvent();
	else
		getgenv().spam_commandlogger = false;
	end
end);
function getplayerinfo(plr)
	local plrinfo = {ingroup=plr:IsInGroup(5740208),userid=plr.UserId,rankname=function()
		if plr:GetRoleInGroup(5740208) then
			return plr:GetRoleInGroup(5740208);
		else
			return nil;
		end
	end()};
	return plrinfo;
end
function getcuffs()
	for _, i in pairs(Players:GetPlayers()) do
		if (i ~= Players.LocalPlayer) then
			if (i.Backpack:FindFirstChild("Handcuffs") and i.Backpack:FindFirstChild("Handcuffs"):IsA("Tool")) then
				return i.Backpack:FindFirstChild("Handcuffs");
			end
		end
	end
end
function createesp(plr)
	local FlatIdent_47A9C = 0;
	local plrinfo;
	local BillBoardUI;
	local Frameone;
	local UIStroke;
	local UserIdText;
	local RankNameText;
	while true do
		if (FlatIdent_47A9C == 5) then
			UserIdText.TextColor3 = Color3.fromRGB(255, 255, 255);
			UserIdText.Text = "UserId : " .. plrinfo.userid;
			RankNameText = Instance.new("TextLabel");
			RankNameText.Parent = BillBoardUI;
			FlatIdent_47A9C = 6;
		end
		if (FlatIdent_47A9C == 3) then
			UIStroke.Parent = Frameone;
			UIStroke.Color = Color3.new(0.717647, 0.003922, 1);
			UIStroke.Thickness = 2;
			UserIdText = Instance.new("TextLabel");
			FlatIdent_47A9C = 4;
		end
		if (6 == FlatIdent_47A9C) then
			RankNameText.Position = UDim2.fromScale(0.8, 0.15);
			RankNameText.Size = UDim2.fromScale(0.8, 0.2);
			RankNameText.BackgroundTransparency = 1;
			RankNameText.TextColor3 = Color3.fromRGB(255, 255, 255);
			FlatIdent_47A9C = 7;
		end
		if (FlatIdent_47A9C == 2) then
			Frameone.Parent = BillBoardUI;
			Frameone.Size = UDim2.fromScale(1, 1);
			Frameone.BackgroundTransparency = 1;
			UIStroke = Instance.new("UIStroke");
			FlatIdent_47A9C = 3;
		end
		if (FlatIdent_47A9C == 1) then
			BillBoardUI.ResetOnSpawn = true;
			BillBoardUI.AlwaysOnTop = true;
			BillBoardUI.Size = UDim2.fromScale(4, 5.5);
			Frameone = Instance.new("Frame");
			FlatIdent_47A9C = 2;
		end
		if (FlatIdent_47A9C == 7) then
			RankNameText.Text = "Rank : " .. plrinfo.rankname;
			return BillBoardUI;
		end
		if (FlatIdent_47A9C == 0) then
			plrinfo = getplayerinfo(plr);
			BillBoardUI = Instance.new("BillboardGui");
			BillBoardUI.Parent = plr.Character;
			BillBoardUI.Name = "ESP_sex";
			FlatIdent_47A9C = 1;
		end
		if (4 == FlatIdent_47A9C) then
			UserIdText.Parent = BillBoardUI;
			UserIdText.Position = UDim2.fromScale(0.8, 0);
			UserIdText.Size = UDim2.fromScale(0.8, 0.2);
			UserIdText.BackgroundTransparency = 1;
			FlatIdent_47A9C = 5;
		end
	end
end
function cuff(plr)
	local FlatIdent_A36C = 0;
	local args;
	while true do
		if (FlatIdent_A36C == 0) then
			args = {[1]="mmKoplat_",[2]=plr.Character.HumanoidRootPart};
			Players.LocalPlayer.Character:FindFirstChild("Handcuffs"):WaitForChild("EventRemoteCuff"):FireServer(unpack(args));
			break;
		end
	end
end
function uncuff()
	local FlatIdent_7F35E = 0;
	local args;
	while true do
		if (FlatIdent_7F35E == 0) then
			args = {[1]="mmKoplat_UN"};
			Players.LocalPlayer.Character:FindFirstChild("Handcuffs"):WaitForChild("EventRemoteCuff"):FireServer(unpack(args));
			break;
		end
	end
end
function AFKSP()
	if (getgenv().afk_spam == true) then
		task.spawn(function()
			while true do
				local FlatIdent_A9A3 = 0;
				while true do
					if (1 == FlatIdent_A9A3) then
						task.wait(getgenv().afk_spam_speed / 99);
						game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AFK"):FireServer(false);
						FlatIdent_A9A3 = 2;
					end
					if (FlatIdent_A9A3 == 2) then
						task.wait(getgenv().afk_spam_speed / 99);
						break;
					end
					if (FlatIdent_A9A3 == 0) then
						if (getgenv().afk_spam == false) then
							game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AFK"):FireServer(false);
							return;
						end
						game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AFK"):FireServer(true);
						FlatIdent_A9A3 = 1;
					end
				end
			end
		end);
	end
end
function SpamLoggerEvent()
	task.spawn(function()
		while task.wait() do
			if (getgenv().spam_commandlogger == true) then
				local FlatIdent_703C8 = 0;
				local args;
				while true do
					if (FlatIdent_703C8 == 0) then
						args = {[1]={[1]="https://discord.gg/PqDYpbYUPm",[2]="join i fucking hate copy paste code",[3]="kill yourself EwZone"}};
						game:GetService("ReplicatedStorage"):WaitForChild("LoggerEvent"):FireServer(unpack(args));
						FlatIdent_703C8 = 1;
					end
					if (FlatIdent_703C8 == 1) then
						print("SpamReporting");
						break;
					end
				end
			else
				return;
			end
		end
	end);
end
