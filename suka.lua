local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
local Window = OrionLib:MakeWindow({
	Name = "🌑 MoonTree HUB 🌑 | Anime Punch Simulator", 
	HidePremium = false, 
	IntroEnabled = false, 
	IntroText = "MoonTree HUB", 
	SaveConfig = false, 
	ConfigFolder = "hubConfig"
});

local C_POTION = {
	ENERGY_POTION_2X = "Energy Potion",
	GEM_POTION_2X = "Gems Potion"
};

local C_MINER = {
	CAVE_1 = "Cave 1",
	CAVE_2 = "Cave 2",
	CAVE_3 = "Cave 3"
};

_G.farmEnergyFast = false;
_G.autoOpenPetOrbs = false;
_G.autoOpenPetOrbToOpen = nil;
_G.autoFarmRaidBosses = false;
_G.raidBossesToFarm = {};
_G.antiAfk = true;



_G.farmMarks = false;
_G.marksToFarm = {};

_G.farmCurses = false;
_G.cursesToFarm = {};

_G.farmRaces = false;
_G.racesToFarm = {};

_G.farmFruits = false;

_G.farmGrimories = false;
_G.GrimoriePrimaryToFarm = {};

_G.farmPassives = false;
_G.passiveToFarm = {};

_G.farmTitles = false;
_G.titlesToFarm = {};

_G.farmHakis = false;
_G.hakisToFarm = {};

_G.farmTalents = false;
_G.farmClasses = false;

_G.farmFamily = false;
_G.farmDivines = false;


_G.farmRaids = false;
_G.farmEvolvedRaids = false;

_G.farmInvasionShip = false;
_G.farmEvolvedInvasionShip = false;

_G.isEventActive = false;


_G.buyWorldSixPotions = false;
_G.summonSpecialBossSuzuye = false;
_G.farmEvolvedDefense = false;

_G.use2xEnergyPotion = false;
_G.use2xGemPotion = false;
_G.farmIceCubes = false;

_G.isSwitchingEquips = false;
_G.farmWorldEvents = false;
_G.isWorldEventActive = false;
_G.farmTimeTrialEasy = false;
_G.farmTimeTrialMedium = false;
_G.farmLevelingDungeon = false;

_G.autoMiningCave1 = false;
_G.autoMiningCave2 = false;
_G.autoMiningCave3 = false;

_G.equipDamageGearWhenDoingEvents = false;


function teleportToWorld(worldName, waitTimeAfterTeleport)
	local worldName = tostring(worldName);
	local waitTimeAfterTeleport = tonumber(waitTimeAfterTeleport) or 1;
	
	if(not worldName) then
		print("ERROR: invalid world provided for teleport");
		return false;
	end;
	
	local args = {
		[1] = "Teleport",
		[2] = "Spawn",
		[3] = worldName
	};
	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	task.wait(waitTimeAfterTeleport);
	
	return true;
end;

function farmEnergyFast()
	local args = {
			[1] = "Attack",
			[2] = "Click"
		};
		
	local args2 = {
			[1] = "Attack",
			[2] = "Click",
			[3] = {
				["Type"] = "TrialEasy"
			}
		};

	while(_G.farmEnergyFast) do
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args2));
		task.wait(0.05);
	end;
end;

function autoOpenPetOrbs()
	while(_G.autoOpenPetOrbs) do
		local args = {
			[1] = "Stars",
			[2] = "Roll",
			[3] = {
				["Map"] = "Bizarre Desert",
				["Type"] = "Multi"
			}
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		task.wait(0.20);
	end;
end;

function antiAfk()
	while(_G.antiAfk) do
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
		task.wait(60*15);
	end;
end;


function farmTitles()
	while(_G.farmTitles and not (tostring(workspace.Occuriaa.HumanoidRootPart.HUD.Frame.PlayerRank.Text) == "Monarch")) do
		print("banner at start: "..tostring(workspace.Occuriaa.HumanoidRootPart.HUD.Frame.PlayerRank.Text));
		local args = {
			[1] = "Titles",
			[2] = "Buy"
		};

		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args))
		task.wait(0.5);

		while(game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer:getAttribute("BannerSpinning")) do
			task.wait(0.50);
			--print("banner spinning");
		end;
		print("banner at end: "..tostring(workspace.Occuriaa.HumanoidRootPart.HUD.Frame.PlayerRank.Text));
	end;
end;

function farmHakis()
	while(_G.farmHakis and not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Haki.Main.Frames.Spin.Haki.Title.Text) == "Cyan Haki")) do
		print("Haki at start: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Haki.Main.Frames.Spin.Haki.Title.Text));
		local args = {
			[1] = "Haki",
			[2] = "Buy"
		};

		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args))
		task.wait(0.5);

		while(game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer:getAttribute("BannerSpinning")) do
			task.wait(0.50);
			--print("banner spinning");
		end;
		print("Haki at end: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Haki.Main.Frames.Spin.Haki.Title.Text));
	end;
	print("done farming haki");
	task.wait(1);
end;

function isNpcDead(mapName, npcId)
	local enemies = game:GetService("Workspace"):WaitForChild("Server"):WaitForChild(mapName):WaitForChild("Enemies");
	for i,enemy in pairs(enemies:getChildren()) do
		if(enemy) then
			local enemyId = enemy:getAttribute("ID");
			if(enemyId == nil) then 
				print("ERROR: NPC doesn't have an ID");
			end;
			if(npcId == tostring(enemyId)) then
				--print("npc is not dead");
				return false;
			else
				--print("not same npc");
			end;
		end;
	end;
	return true;
end;


function getEnemiesList(mapName, maxAttempts, waitTimeBetweenRefreshAttempts)
	local maxAttempts = tonumber(maxAttempts) or 1;	
	local waitTimeBetweenRefreshAttempts = tonumber(waitTimeBetweenRefreshAttempts) or 1;	
	local enemies = {};
	local enemyListFetchAttempts = 0;
	
	local executionStatus, result = pcall(function() 
		while((#enemies == 0) and (enemyListFetchAttempts < maxAttempts)) do
			enemyListFetchAttempts = enemyListFetchAttempts + 1;
			enemies = game:GetService("Workspace"):WaitForChild("Server", 1):WaitForChild(mapName, 1):WaitForChild("Enemies", 1):getChildren();
			task.wait(waitTimeBetweenRefreshAttempts);
		end;
		return #enemies;
	end);
	return enemies;	
end;


function killNpcs(mapName, waitTimeBetweenRefreshAttempts)
	local KILL_DURATION_MAX_SECONDS = 5;
	
	local waitTimeBetweenRefreshAttempts = tonumber(waitTimeBetweenRefreshAttempts) or 1;
	local enemies = {};
	local isTakingTooLongToKill = false;
	

	enemies = getEnemiesList(mapName, 10, waitTimeBetweenRefreshAttempts);
	--print("Fightable enemies found: "..tostring(#enemies));

	for i,enemy in pairs(enemies) do
		if(enemy and not isTakingTooLongToKill) then
			local enemyId = enemy:getAttribute("ID");
			--print("enemy ID: "..tostring(enemyId));
			if(enemyId) then
				--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.CFrame;
				--print("teleporting to NPC position: "..tostring(CFrame.new(math.floor(enemy.CFrame.Position.X+0.5), math.floor(enemy.CFrame.Position.Y+0.5), math.floor(enemy.CFrame.Position.Z+0.5))));
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.floor(enemy.CFrame.Position.X+0.5), math.floor(enemy.CFrame.Position.Y+2+0.5), math.floor(enemy.CFrame.Position.Z+0.5));
				task.wait(1);
				local killStartTime = os.time();
				--print("starting to kill npc");
				while((not isNpcDead(mapName, enemyId)) and (not isTakingTooLongToKill)) do
					task.wait(1);
					isTakingTooLongToKill = ((os.time() - killStartTime) > KILL_DURATION_MAX_SECONDS);
				end;
			end;
		end;
	end;
	
	-- consider number of enemies to ensure there were enemies to kill there else it could be empty map scenario; can happen at max raid room?
	print("status-isTakingTooLongToKill: "..tostring(isTakingTooLongToKill));
	print("status-#enemies: "..tostring(#enemies));
	return (not isTakingTooLongToKill and (#enemies > 0));
end;


function doEvolvedRaid()
	local raidNpcs = getEnemiesList("RaidEvolved", 1, 1);
	if(#raidNpcs > 0) then
		print("ERROR: evolved raid is already active cannot start a new one yet");
		return false;
	end;

	-- teleport to evolved raid
	local args = {
		[1] = "Enemies",
		[2] = "Bridge",
		[3] = {
			["Module"] = "RaidEvolved",
			["FunctionName"] = "Start",
			["Args"] = "Friend"
		}
	};
	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	-- wait for cooldown
	task.wait(18);
	
	-- kill NPCs until it's too long to kill or that no NPCs are found
	local npcKillStatus = nil;
	repeat 
		npcKillStatus = killNpcs("RaidEvolved", 1);
	until(not npcKillStatus);
	
	-- teleport out of evolved raid to leave
	local args = {
		[1] = "Teleport",
		[2] = "Spawn",
		[3] = "Lobby"
	};
	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	
	task.wait(2);
	
	return true;
end;

function farmEvolvedRaid(raidFarmCount)
	local raidStatus = nil;
	for i=1,raidFarmCount do
		raidStatus = doEvolvedRaid();
		
		if(not raidStatus) then
			print("ERROR: raid ended due to error...stopping raids...");
			break;
		end;
	end;
end;


function doEvolvedInvasionShip()
	local invasionNpcs = getEnemiesList("ShipEvolved", 1, 1);
	if(#invasionNpcs > 0) then
		print("ERROR: ShipEvolved is already active cannot start a new one yet");
		return false;
	end;

	-- teleport to ShipEvolved
	local args = {
		[1] = "Enemies",
		[2] = "Bridge",
		[3] = {
			["Module"] = "ShipEvolved",
			["FunctionName"] = "Start",
			["Args"] = "Friend"
		}
	};
	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	
	-- wait for cooldown
	task.wait(18);
	
	-- kill NPCs until it's too long to kill or that no NPCs are found
	local npcKillStatus = nil;
	repeat 
		npcKillStatus = killNpcs("ShipEvolved", 1);
	until(not npcKillStatus);
	
	-- teleport out of ShipEvolved to leave
	local args = {
		[1] = "Teleport",
		[2] = "Spawn",
		[3] = "Clown Island"
	};
	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	
	task.wait(3);
	
	return true;
end;

function farmEvolvedInvasionShip(repeatCount)
	local status = nil;
	for i=1,repeatCount do
		status = doEvolvedInvasionShip();
		
		if(not status) then
			print("ERROR: evolved invasion ended due to error...stopping evolved invasions...");
			break;
		end;
	end;
end;

function farmRaces()
	while(_G.farmRaces and (not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.RaceMachine.Main.Frame.Race.Title.Text) == "King Wings"))) do
		print("Race at start: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.RaceMachine.Main.Frame.Race.Title.Text));
		local args = {
			[1] = "RaceMachine",
			[2] = "Buy"
		};

		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args))
		task.wait(2);
		print("Race at end: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.RaceMachine.Main.Frame.Race.Title.Text));
	end;
	task.wait(1);
	print("Race farmed");
end;

function farmGrimories()
	while(_G.farmGrimories and (not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Grimories.Main.Frames.Spin.Grimorie.Title.Text) == "Chess Grimorie"))) do
		print("Grimorie at start: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Grimories.Main.Frames.Spin.Grimorie.Title.Text));
		local args = {
			[1] = "Grimories",
			[2] = "Buy",
			[3] = "Primary"
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		
		task.wait(2);
		print("Grimorie at end: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Grimories.Main.Frames.Spin.Grimorie.Title.Text));
	end;
	task.wait(1);
	print("Grimorie farmed");
end;

function farmPassives()
	while(_G.farmPassives and (not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Passives.Main.Frame.Passive.Title.Text) == "Star" or tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Passives.Main.Frame.Passive.Title.Text) == "Light Speed"))) do
		print("Passive at start: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Passives.Main.Frame.Passive.Title.Text));
		local args = {
			[1] = "Passives",
			[2] = "Buy"
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		
		task.wait(0.8);
		print("Passive at end: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Passives.Main.Frame.Passive.Title.Text));
	end;
	task.wait(1);
	print("Passives farmed");
end;

function farmMarks()
	while(_G.farmMarks and (not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Marks.Main.Frame.Mark.Title.Text) == "Love Mark"))) do
		print("Mark at start: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Marks.Main.Frame.Mark.Title.Text));
		--TODO: Add correct MARK buy text
		local args = {
			[1] = "Marks",
			[2] = "Buy"
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		
		task.wait(1);
		print("Mark at end: "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Marks.Main.Frame.Mark.Title.Text));
	end;
	task.wait(1);
	print("Marks farmed");
end;

function farmCurses()
	while(_G.farmCurses and (not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.CurseMachine.Main.Frame.Curse.Title.Text) == "Rika"))) do
		print("Curse at start: ["..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.CurseMachine.Main.Frame.Curse.Title.Text).."]");
		--TODO: Add correct CURSES buy text
		local args = {
			[1] = "CurseMachine",
			[2] = "Buy"
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		
		task.wait(1);
		print("Curse at end: ["..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.CurseMachine.Main.Frame.Curse.Title.Text).."]");
	end;
	task.wait(1);
	print("Curses farmed");
end;

function farmFruits()
	local args = {
			[1] = "FruitsEvolved",
			[2] = "Buy"
		};
	while(_G.farmFruits) do
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		task.wait(1);
	end;
end;

function buyWorldSixPotions()
	while(_G.buyWorldSixPotions) do
		local args = {
			[1] = "PotionsMachine",
			[2] = "Buy3"
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		task.wait(1);
	end;
	print("Done buying potions");
	task.wait(1);
end;

function summonEvolvedBoss()
	while(_G.summonSpecialBossSuzuye) do
		local args = {
			[1] = "Enemies",
			[2] = "Bridge",
			[3] = {
				["Module"] = "SummonBoss",
				["FunctionName"] = "Spawn"
			}
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		task.wait(2);
	end;
end;

function farmEvolvedDefense()
	while(_G.farmEvolvedDefense) do
		local defenseNpcs = getEnemiesList("DefenseEvolved", 25, 1);
		while(#defenseNpcs > 0) do
			print("ERROR: DefenseEvolved is already active cannot start a new one yet");
			task.wait(23);
			defenseNpcs = getEnemiesList("DefenseEvolved", 5, 1);
		end;
		
		if(_G.farmEvolvedDefense) then
			-- teleport to evolved defense
			local args = {
				[1] = "Enemies",
				[2] = "Bridge",
				[3] = {
					["Module"] = "DefenseEvolved",
					["FunctionName"] = "Start",
					["Args"] = "Friend"
				}
			};
			game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));

			-- wait for cooldown
			task.wait(8);
			
			--move to gate
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8864.745, 3851.147+3, -346.164);
			task.wait(8);
		end;
	end;
end;

function isRaidBossAlive()
	local raidBossDirectory = workspace:WaitForChild("Server"):WaitForChild("Enemies"):WaitForChild("RaidBoss");
	if(not raidBossDirectory) then
		--print("ERROR: failed to find raid boss object");
		return false;
	end;
	-- TODO: Handle case where boss object exists but boss is dead. Can happen if boss just died but object has been garbage collected.
	-- Not important as of yet as only side affect, known so far, it cause you to keep teleporting to boss position.
	return ((#raidBossDirectory:getChildren()) > 0);
end;

function getRaidBossNpc()
	if(isRaidBossAlive()) then
		return workspace:WaitForChild("Server"):WaitForChild("Enemies"):WaitForChild("RaidBoss"):getChildren()[1];
	end;
	
	return nil;
end;

function gotoKillRaidBossNpc()
	local raidBoss = getRaidBossNpc();
	if(not raidBoss) then
		print("WARN: failed to find raid boss to kill");
		return false;
	end;
	
	local raidBossSpawnWorld = raidBoss:getAttribute("World");
	
	--teleport to raid boss world and then to raid boss location (slightly higher to avoid collision bug)
	teleportToWorld(raidBossSpawnWorld, 2);
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.floor(raidBoss.CFrame.Position.X+1), math.floor(raidBoss.CFrame.Position.Y+3), math.floor(raidBoss.CFrame.Position.Z+1));
	task.wait(1);
	return true;
end;

function farmRaidBosses()
	while(_G.autoFarmRaidBosses) do
		if(isRaidBossAlive()) then
			gotoKillRaidBossNpc();
		else
			task.wait(3);
		end;
	end;
end;

function usePotion(potionName, waitTimeAfterPotionUse)
	local potionName = tostring(potionName);
	local waitTimeAfterPotionUse = tonumber(waitTimeAfterPotionUse) or 1;
	local args = {
		[1] = "Potions",
		[2] = "Use",
		[3] = potionName
	};
	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	task.wait(waitTimeAfterPotionUse);
end;

function use2xEnergyPotion()
	while(_G.use2xEnergyPotion) do
		usePotion(C_POTION.ENERGY_POTION_2X, 0.5);
	end;
end;

function use2xGemPotion()
	while(_G.use2xGemPotion) do
		usePotion(C_POTION.GEM_POTION_2X, 0.5);
	end;
end;

function isWorldNpcDead(npc)
	if(npc) then
		local isNpcDead = npc:getAttribute("Died");
		return isNpcDead;
	else
		print("ERROR: npc not found when checking if world NPC is dead");
	end;
	return false;
end;

function getWorldNpcs(worldName, npcList)
	local fightableNpcs = {};
	local world = game:GetService("Workspace"):WaitForChild("Server", 1):WaitForChild("Enemies", 1):WaitForChild("World", 1):WaitForChild(worldName, 1);
	
	for i,npc in pairs(world:getChildren()) do
		for j,targetNpcName in pairs(npcList) do
			if(npc and (npc.Name == targetNpcName)) then
				table.insert(fightableNpcs, npc);
			end;
		end;
	end;
	
	return fightableNpcs;
end;

function killWorldNpcs(fightableNpcs)

	if(fightableNpcs and (#fightableNpcs < 1)) then
		return false;
	end;
	--print("Fightable NPCs found: "..tostring(#fightableNpcs));
	
	for i,npc in pairs(fightableNpcs) do
		local isWorldNpcDead = npc:getAttribute("Died");
		if(not isWorldNpcDead) then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.floor(npc.CFrame.Position.X+0.5), math.floor(npc.CFrame.Position.Y+2+0.5), math.floor(npc.CFrame.Position.Z+0.5));
			task.wait(1);
		else
			--print("NPC is already dead");
		end;
	end;
	return true;
end;

function farmIceCubesFromWorld10()
	if(_G.farmIceCubes) then
		local fightableNpcs = getWorldNpcs("Criminal Village", {"Meliedes", "Ben", "Kyng"});
		
		if(#fightableNpcs < 1) then
			print("Fightable NPCs not found in world");
			return false;
		end;

		while(_G.farmIceCubes) do
			killWorldNpcs(fightableNpcs);
			task.wait(0.1);
		end;
	end;
end;


function equipAccessory(accessoryName)
	local args = {
		[1] = "Accessories",
		[2] = "Select",
		[3] = accessoryName
	};

	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
end;

function equipFruit(fruitName)
	local args = {
		[1] = "Fruits",
		[2] = "Select",
		[3] = fruitName
	};

	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
end;

function switchBuffFromVault(name, slot)
	local slot = tonumber(slot) or 1;

	local args = {
		[1] = "Vault",
		[2] = "Change",
		[3] = {
			["Type"] = name,
			["Slot"] = slot
		}
	};

	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	task.wait(0.1);
end;

function equipAllDamageBuffs()
	local waitTimeBetweenSwitches = 1;

	switchBuffFromVault("Haki", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Titles", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Marks", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Curses", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Races", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Primary Grimorie", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Secondary Grimorie", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Passives", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Classes", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Family", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Divines", 1);
	task.wait(waitTimeBetweenSwitches);
	equipAccessory("Shark Hat");
	task.wait(waitTimeBetweenSwitches);
	equipFruit("Bari Fruit");
	task.wait(waitTimeBetweenSwitches);
end;

function equipAllEnergyBuffs()
	local waitTimeBetweenSwitches = 1;

	switchBuffFromVault("Haki", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Titles", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Marks", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Curses", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Races", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Primary Grimorie", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Secondary Grimorie", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Passives", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Classes", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Family", 1);
	task.wait(waitTimeBetweenSwitches);
	switchBuffFromVault("Divines", 1);
	task.wait(waitTimeBetweenSwitches);
	equipAccessory("Urehare Hat");
	task.wait(waitTimeBetweenSwitches);
	equipFruit("Phoenix Fruit");
	task.wait(waitTimeBetweenSwitches);
end;


function tokenizeString(searchString, delimiter)
  local delimiter = delimiter or ".";
  local tokens = {};
  
  for token in string.gmatch(searchString, "[^"..tostring(delimiter).."]+") do
    table.insert(tokens, token);
  end;
  
  return tokens;
end;

function getEnemiesObjectForAMap(mapPath)
	local enemiesObject = game:GetService("Workspace"):WaitForChild("Server");

	for _,token in pairs(tokenizeString(mapPath, ".")) do
		enemiesObject = enemiesObject:WaitForChild(token, 1);
	end;
	enemiesObject = enemiesObject:WaitForChild("Enemies");
	return enemiesObject;
end;

function isNpcDeadWithTokenizedMapPath(mapName, npcId)
	local enemies = getEnemiesObjectForAMap(mapName);
	
	for i,enemy in pairs(enemies:getChildren()) do
		if(enemy) then
			local enemyId = enemy:getAttribute("ID");
			if(enemyId == nil) then 
				print("ERROR: NPC doesn't have an ID");
			end;
			if(npcId == tostring(enemyId)) then
				--print("npc is not dead");
				return false;
			else
				--print("not same npc");
			end;
		end;
	end;
	return true;
end;


function getEnemiesListWithTokenizedMapPath(mapName, maxAttempts, waitTimeBetweenRefreshAttempts)
	local maxAttempts = tonumber(maxAttempts) or 1;	
	local waitTimeBetweenRefreshAttempts = tonumber(waitTimeBetweenRefreshAttempts) or 1;	
	local enemies = {};
	local enemyListFetchAttempts = 0;
	
	local executionStatus, result = pcall(function() 
		while((#enemies == 0) and (enemyListFetchAttempts < maxAttempts)) do
			enemyListFetchAttempts = enemyListFetchAttempts + 1;
			enemies = getEnemiesObjectForAMap(mapName);
			enemies = enemies:getChildren();
			task.wait(waitTimeBetweenRefreshAttempts);
		end;
		return #enemies;
	end);
	return enemies;	
end;


function killNpcsWithTokenizedMapPath(mapName, waitTimeBetweenRefreshAttempts)
	local KILL_DURATION_MAX_SECONDS = 4;
	
	local waitTimeBetweenRefreshAttempts = tonumber(waitTimeBetweenRefreshAttempts) or 1;
	local enemies = {};
	local isTakingTooLongToKill = false;
	

	enemies = getEnemiesListWithTokenizedMapPath(mapName, 10, waitTimeBetweenRefreshAttempts);
	print("Fightable enemies found: "..tostring(#enemies));

	for i,enemy in pairs(enemies) do
		if(enemy and not isTakingTooLongToKill) then
			local enemyId = enemy:getAttribute("ID");
			--print("enemy ID: "..tostring(enemyId));
			if(enemyId) then
				--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.CFrame;
				--print("teleporting to NPC position: "..tostring(CFrame.new(math.floor(enemy.CFrame.Position.X+0.5), math.floor(enemy.CFrame.Position.Y+0.5), math.floor(enemy.CFrame.Position.Z+0.5))));
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.floor(enemy.CFrame.Position.X+0.5), math.floor(enemy.CFrame.Position.Y+2+0.5), math.floor(enemy.CFrame.Position.Z+0.5));
				task.wait(1);
				local killStartTime = os.time();
				--print("starting to kill npc");
				while((not isNpcDeadWithTokenizedMapPath(mapName, enemyId)) and (not isTakingTooLongToKill)) do
					task.wait(1);
					isTakingTooLongToKill = ((os.time() - killStartTime) > KILL_DURATION_MAX_SECONDS);
				end;
			end;
		end;
	end;
	
	-- consider number of enemies to ensure there were enemies to kill there else it could be empty map scenario; can happen at max raid room?
	--print("status-isTakingTooLongToKill: "..tostring(isTakingTooLongToKill));
	--print("status-#enemies: "..tostring(#enemies));
	return (not isTakingTooLongToKill and (#enemies > 0));
end;

function notificationContainsTokens(searchTokens)
	local notification = game:GetService("Players").LocalPlayer.PlayerGui.UI.Notification;
	if((not notification) or ((#notification:getChildren()) < 1)) then
		return false;
	end;
	
	local searchTokensFound = false;
	for i,template in pairs(notification:getChildren()) do
		if(template.Name == "Template" and template.Description and template.Description.Text) then
			local notificationText = template.Description.Text:lower();
			print("Notification text: "..tostring(notificationText));
			
			searchTokensFound = false;
			for j,token in pairs(searchTokens) do
				if(string.find(notificationText, token)) then
					searchTokensFound = true;
				else
					searchTokensFound = false;
					break;
				end;
			end;
			
			if(searchTokensFound) then
				return true;
			end;
		end;
	end;

	return false;
end;


function farmTimeTrialEasy()
	--_G.isWorldEventActive = false;
	
	local isTimeTrialEasyStarting = false;
	
	while(_G.farmTimeTrialEasy and (not _G.isWorldEventActive)) do
		--print("checking to see if easy trial event started");
		isTimeTrialEasyStarting = notificationContainsTokens({"trial", "easy", "opened"});
		task.wait(1);
		if(isTimeTrialEasyStarting) then
			_G.isWorldEventActive = true;

			-- put on damage buffs
			if(_G.equipDamageGearWhenDoingEvents) then
				equipAllDamageBuffs();
			end;
			
			-- teleport to dungeon world
			--teleportToWorld("Online World", 3);
			task.wait(3);
			
			-- join time trial
			local args = {
				[1] = "Enemies",
				[2] = "Bridge",
				[3] = {
					["Module"] = "TrialEasy",
					["FunctionName"] = "Join",
					["Args"] = ""
				}
			};
			game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));

			-- wait for it to start
			task.wait(60);
			
			-- kill NPCs
			local npcKillStatus = nil;
			repeat 
				npcKillStatus = killNpcsWithTokenizedMapPath("Trial.Easy", 1);
			until(not npcKillStatus);
			task.wait(2);
			
			-- leave time trial
			teleportToWorld("Criminal Village", 3);
			
			-- equip energy buff
			if(_G.equipDamageGearWhenDoingEvents) then
				equipAllEnergyBuffs();
			end;
			 
			_G.isWorldEventActive = false;
		end;
	end;
end;

function farmTimeTrialMedium()
	--_G.isWorldEventActive = false;
	
	local isTimeTrialMediumStarting = false;
	
	while(_G.farmTimeTrialMedium and (not _G.isWorldEventActive)) do
		--print("checking to see if medium trial event started");
		isTimeTrialMediumStarting = notificationContainsTokens({"trial", "medium", "opened"});
		task.wait(1);
		if(isTimeTrialMediumStarting) then
			_G.isWorldEventActive = true;

			-- put on damage buffs
			if(_G.equipDamageGearWhenDoingEvents) then
				equipAllDamageBuffs();
			end;
			
			-- teleport to dungeon world
			--teleportToWorld("Online World", 3);
			task.wait(3);
			
			-- join time trial
			local args = {
				[1] = "Enemies",
				[2] = "Bridge",
				[3] = {
					["Module"] = "TrialMedium",
					["FunctionName"] = "Join",
					["Args"] = ""
				}
			};
			game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));

			-- wait for it to start
			task.wait(60);
			
			-- kill NPCs
			local npcKillStatus = nil;
			repeat 
				npcKillStatus = killNpcsWithTokenizedMapPath("Trial.Medium", 1);
			until(not npcKillStatus);
			task.wait(2);
			
			-- leave time trial
			teleportToWorld("Criminal Village", 3);
			
			-- equip energy buff
			 if(_G.equipDamageGearWhenDoingEvents) then
				equipAllEnergyBuffs();
			end;
			 
			_G.isWorldEventActive = false;
		end;
	end;
end;

function farmTalents()
	while(_G.farmTalents and (not (string.match(tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Talent.Main.Frame.Current.Text), ">(%u+)<") == "SS" or string.match(tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Talent.Main.Frame.Current.Text), ">(%u+)<") == "SSS"))) do
		print("Talent at start: ["..string.match(tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Talent.Main.Frame.Current.Text), ">(%u+)<").."]");
		local args = {
			[1] = "Talent",
			[2] = "Spin"
		};

		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		task.wait(0.5);
		print("Talent at end: ["..string.match(tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Talent.Main.Frame.Current.Text), ">(%u+)<").."]");
	end;
	task.wait(1);
	print("Talents farmed");
end;

function farmClasses()
	while(_G.farmClasses and (not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Class.Main.Frames.Spin.Class.Class.Text) == "Great Wizard" or tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Class.Main.Frames.Spin.Class.Class.Text) == "Assassin"))) do
		print("Class at start: ["..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Class.Main.Frames.Spin.Class.Class.Text).."]");
		local args = {
			[1] = "Class",
			[2] = "Buy"
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		
		task.wait(1);
		print("Class at end: ["..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Class.Main.Frames.Spin.Class.Class.Text).."]");
	end;
	task.wait(1);
	print("Classes farmed");
end;

function farmFamily()
	while(_G.farmFamily and (not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Family.Main.Frames.Spin.Family.Title.Text) == "One Punch" or tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Family.Main.Frames.Spin.Family.Title.Text) == "Strongest"))) do
		print("Family at start: ["..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Family.Main.Frames.Spin.Family.Title.Text).."]");
		local args = {
			[1] = "Family",
			[2] = "Buy"
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		
		task.wait(0.8);
		print("Family at end: ["..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Family.Main.Frames.Spin.Family.Title.Text).."]");
	end;
	task.wait(1);
	print("Family farmed");
end;

function farmDivines()
	while(_G.farmDivines and (not (tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Divines.Main.Frames.Spin.Divine.Title.Text) == "Hades" or tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Class.Main.Frames.Spin.Class.Class.Text) == "Buda"))) do
		print("Divines at start: ["..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Divines.Main.Frames.Spin.Divine.Title.Text).."]");
		local args = {
			[1] = "Divines",
			[2] = "Buy"
		};
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		
		task.wait(0.8);
		print("Divines at end: ["..tostring(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Divines.Main.Frames.Spin.Divine.Title.Text).."]");
	end;
	task.wait(1);
	print("Divines farmed");
end;

function autoMining(cave)
	local args = {
		[1] = "Miners",
		[2] = "Start",
		[3] = cave
	};
	while(_G.autoMiningCave3) do
		game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
		task.wait(60);
	end;
	task.wait(1);
end;

function doLevelingDungeon()
	--local npcs = getEnemiesList("LevelingDungeon", 1, 1);
	local npcs = getEnemiesListWithTokenizedMapPath("LevelingDungeon", 1, 1);
	
	if(#npcs > 0) then
		print("ERROR: LevelingDungeon is already active cannot start a new one yet");
		return false;
	end;

	-- teleport to LevelingDungeon
	local args = {
		[1] = "Enemies",
		[2] = "Bridge",
		[3] = {
			["Module"] = "LevelingDungeon",
			["FunctionName"] = "Start",
			["Args"] = "Friend"
		}
	};
	
	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	
	-- wait for cooldown
	task.wait(18);
	
	-- kill NPCs until it's too long to kill or that no NPCs are found
	local npcKillStatus = nil;
	repeat 
		--npcKillStatus = killNpcs("LevelingDungeon", 1);
		npcKillStatus = killNpcsWithTokenizedMapPath("LevelingDungeon", 1);
	until(not npcKillStatus);
	
	-- teleport out of LevelingDungeon to leave
	local args = {
		[1] = "Teleport",
		[2] = "Spawn",
		[3] = "Leveling City"
	};
	game:GetService("ReplicatedStorage"):WaitForChild("Bridge"):FireServer(unpack(args));
	
	task.wait(3);
	
	return true;
end;

function farmLevelingDungeon(dungeonFarmCount)
	local dungeonStatus = nil;
	for i=1,dungeonFarmCount do
		dungeonStatus = doLevelingDungeon();
		
		if(not dungeonStatus) then
			print("ERROR: leveling dungeon ended due to error...stopping raids...");
			break;
		end;
	end;
end;


local FarmTab = Window:MakeTab({
	Name = "Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
});

local FarmTabMainSection = FarmTab:AddSection({
	Name = "Main"
});

FarmTabMainSection:AddToggle({
	Name = "Auto Farm Energy",
	Default = false,
	Callback = function(value)
		_G.farmEnergyFast = value;
		farmEnergyFast();
	end
});

FarmTabMainSection:AddToggle({
	Name = "Auto Open Stars",
	Default = false,
	Callback = function(value)
		_G.autoOpenPetOrbs = value;
		autoOpenPetOrbs();
	end
});

FarmTabMainSection:AddDropdown({
	Name = "Select Auto Orb World",
	Default = nil,
	Options = {"Ghoul City"},
	Callback = function(value)
		_G.autoOpenPetOrbToOpen = value;
	end    
});

local FarmTabRaidsSection = FarmTab:AddSection({
	Name = "Raids"
});

FarmTabRaidsSection:AddToggle({
	Name = "Farm Evolved Raids",
	Default = false,
	Callback = function(Value)
		_G.farmEvolvedRaids = Value;
		while(_G.farmEvolvedRaids and not _G.isEventActive) do
			_G.isEventActive = true;
			farmEvolvedRaid(1);
			_G.isEventActive = false;
		end;
	end
});

local FarmTabInvasionsSection = FarmTab:AddSection({
	Name = "Invasions"
});

FarmTabInvasionsSection:AddToggle({
	Name = "Farm Evolved Invasion ship",
	Default = false,
	Callback = function(Value)
		_G.farmEvolvedInvasionShip = Value;
		while(_G.farmEvolvedInvasionShip and not _G.isEventActive) do
			_G.isEventActive = true;
			farmEvolvedInvasionShip(1);
			_G.isEventActive = false;
		end;
	end
});

local FarmTabDefenseSection = FarmTab:AddSection({
	Name = "Defense"
});

FarmTabDefenseSection:AddToggle({
	Name = "Farm Evolved Defense",
	Default = false,
	Callback = function(Value)
		_G.farmEvolvedDefense = Value;
		while(_G.farmEvolvedDefense and not _G.isEventActive) do
			_G.isEventActive = true;
			farmEvolvedDefense();
			_G.isEventActive = false;
		end;
	end
});

local FarmTabDungeonSection = FarmTab:AddSection({
	Name = "Dungeon"
});

FarmTabDungeonSection:AddToggle({
	Name = "Farm Leveling Dungeon",
	Default = false,
	Callback = function(Value)
		_G.farmLevelingDungeon = Value;
		while(_G.farmLevelingDungeon and not _G.isEventActive) do
			_G.isEventActive = true;
			farmLevelingDungeon(1);
			_G.isEventActive = false;
		end;
	end
});

local SpinsTab = Window:MakeTab({
	Name = "Spins",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
});

SpinsTab:AddToggle({
	Name = "Farm Best Mark",
	Default = false,
	Callback = function(value)
		_G.farmMarks = value;
		farmMarks();
	end
});

SpinsTab:AddToggle({
	Name = "Farm Best Curse",
	Default = false,
	Callback = function(Value)
		_G.farmCurses = Value;
		farmCurses();
	end
});

SpinsTab:AddToggle({
	Name = "Farm Best Race",
	Default = false,
	Callback = function(Value)
		_G.farmRaces = Value;
		farmRaces();
	end
});

SpinsTab:AddToggle({
	Name = "Buy Fruits",
	Default = false,
	Callback = function(Value)
		_G.farmFruits = Value;
		farmFruits();
	end
});


SpinsTab:AddToggle({
	Name = "Farm Best Grimorie",
	Default = false,
	Callback = function(Value)
		_G.farmGrimories = Value;
		while(_G.farmGrimories) do
			farmGrimories();
		end;
	end
});

SpinsTab:AddToggle({
	Name = "Farm Best Passives",
	Default = false,
	Callback = function(Value)
		_G.farmPassives = Value;
		while(_G.farmPassives) do
			farmPassives();
		end;
	end
});

SpinsTab:AddToggle({
	Name = "Farm Best Title",
	Default = false,
	Callback = function(Value)
		_G.farmTitles = Value;
		farmTitles();
	end
});

SpinsTab:AddToggle({
	Name = "Farm Best Haki",
	Default = false,
	Callback = function(Value)
		_G.farmHakis = Value;
		farmHakis();
	end
});

SpinsTab:AddToggle({
	Name = "Farm SS or SSS talents",
	Default = false,
	Callback = function(Value)
		_G.farmTalents = Value;
		farmTalents();
	end
});

SpinsTab:AddToggle({
	Name = "Farm Best Class",
	Default = false,
	Callback = function(Value)
		_G.farmClasses = Value;
		farmClasses();
	end
});

SpinsTab:AddToggle({
	Name = "Farm Best Divine",
	Default = false,
	Callback = function(Value)
		_G.farmDivines = Value;
		farmDivines();
	end
});

SpinsTab:AddToggle({
	Name = "Farm Best Family",
	Default = false,
	Callback = function(Value)
		_G.farmFamily = Value;
		farmFamily();
	end
});

local BossesTab = Window:MakeTab({
	Name = "Bosses",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
});

local BossesTabRaidBossSection = BossesTab:AddSection({
	Name = "Raid Bosses"
});

BossesTabRaidBossSection:AddToggle({
	Name = "Auto Raid Bosses",
	Default = false,
	Callback = function(value)
		_G.autoFarmRaidBosses = value;
		farmRaidBosses();
	end
});


local EventsTab = Window:MakeTab({
	Name = "Events",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
});

local EventsTabFightOptionsSection = EventsTab:AddSection({
	Name = "Fight Options"
});

EventsTabFightOptionsSection:AddToggle({
	Name = "Equip damage gear",
	Default = false,
	Callback = function(value)
		_G.equipDamageGearWhenDoingEvents = value;
	end
});

local EventsTabTimeTrialSection = EventsTab:AddSection({
	Name = "Time Trials"
});

EventsTabTimeTrialSection:AddToggle({
	Name = "Auto Time Trial Easy",
	Default = false,
	Callback = function(value)
		_G.farmTimeTrialEasy = value;
		farmTimeTrialEasy();
	end
});

EventsTabTimeTrialSection:AddToggle({
	Name = "Auto Time Trial Medium",
	Default = false,
	Callback = function(value)
		_G.farmTimeTrialMedium = value;
		farmTimeTrialMedium();
	end
});

local EventsTabMiningSection = EventsTab:AddSection({
	Name = "Mining"
});

EventsTabMiningSection:AddToggle({
	Name = "Auto Cave 1",
	Default = false,
	Callback = function(value)
		_G.autoMiningCave1 = value;
		autoMining(C_MINER.CAVE_1);
	end
});

EventsTabMiningSection:AddToggle({
	Name = "Auto Cave 2",
	Default = false,
	Callback = function(value)
		_G.autoMiningCave2 = value;
		autoMining(C_MINER.CAVE_2);
	end
});

EventsTabMiningSection:AddToggle({
	Name = "Auto Cave 3",
	Default = false,
	Callback = function(value)
		_G.autoMiningCave3 = value;
		autoMining(C_MINER.CAVE_3);
	end
});


local EquipsTab = Window:MakeTab({
	Name = "Equips",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
});

local EquipsTabQuickSwitchSection = EquipsTab:AddSection({
	Name = "Quick Switch"
});

EquipsTabQuickSwitchSection:AddButton({
	Name = "Equip Damage Buffs",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			equipAllDamageBuffs();
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabQuickSwitchSection:AddButton({
	Name = "Equip Energy Buffs",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			equipAllEnergyBuffs();
			_G.isSwitchingEquips = false;
		end;
  	end
});

local EquipsTabBuffsSection = EquipsTab:AddSection({
	Name = "Buffs"
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Mark Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Marks", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Curse Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Curses", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Race Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Races", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Primary Grimorie Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Primary Grimorie", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Secondary Grimorie Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Secondary Grimorie", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Passive Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Passives", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Haki Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Haki", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Title Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Titles", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Class Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Classes", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Family Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Family", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});

EquipsTabBuffsSection:AddButton({
	Name = "Switch Divines Buff",
	Callback = function()
		if(not _G.isSwitchingEquips) then
			_G.isSwitchingEquips = true;
			switchBuffFromVault("Divines", 1);
			_G.isSwitchingEquips = false;
		end;
  	end
});


local ResourcesTab = Window:MakeTab({
	Name = "Resources",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
});

local ResourcesTabIceCubes = ResourcesTab:AddSection({
	Name = "Resource: Ice Cubes"
});

ResourcesTabIceCubes:AddToggle({
	Name = "Farm Ice Cubes (world 10)",
	Default = false,
	Callback = function(Value)
		_G.farmIceCubes = Value;
		farmIceCubesFromWorld10();
	end
});


local MiscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
});

MiscTab:AddToggle({
	Name = "Buy 100x potion pack (world 6)",
	Default = false,
	Callback = function(Value)
		_G.buyWorldSixPotions = Value;
		buyWorldSixPotions();
	end
});

MiscTab:AddToggle({
	Name = "Auto summon boss Suzuye",
	Default = false,
	Callback = function(Value)
		_G.summonSpecialBossSuzuye = Value;
		summonEvolvedBoss();
	end
});

local antiAfkToggle = MiscTab:AddToggle({
	Name = "Anti AFK",
	Default = false,
	Callback = function(Value)
		_G.antiAfk = Value;
		antiAfk();
	end
});

local MiscTabPotionSection = MiscTab:AddSection({
	Name = "Potions"
});

MiscTabPotionSection:AddToggle({
	Name = "Use Energy Potion 2x",
	Default = false,
	Callback = function(value)
		_G.use2xEnergyPotion = value;
		use2xEnergyPotion();
	end
});

MiscTabPotionSection:AddToggle({
	Name = "Use Gem Potion 2x",
	Default = false,
	Callback = function(value)
		_G.use2xGemPotion = value;
		use2xGemPotion();
	end
});

OrionLib:Init();
task.wait(5);
antiAfkToggle:Set(true);