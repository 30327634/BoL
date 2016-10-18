--[[

             _               _               _   
     /\     (_)             | |             | |  
    /  \     _   _ __ ___   | |__     ___   | |_ 
   / /\ \   | | | '_ ` _ \  | '_ \   / _ \  | __|
  / ____ \  | | | | | | | | | |_) | | (_) | | |_ 
 /_/    \_\ |_| |_| |_| |_| |_.__/   \___/   \__|
                                          
             
    By Nebelwolfi                                    
]]--

--[[ Set this to false if you do not want it to auto update. ]] --
local AUTO_UPDATE = true;

--[[ Skillshot list start ]]--
local tAimbotChamps = {
    ["Aatrox"] = {
        [_Q] = { speed = 450, delay = 0.25, range = 650, width = 150, collision = false, aoe = true, type = "circular"},
        [_E] = { speed = 1200, delay = 0.25, range = 1000, width = 150, collision = false, aoe = false, type = "linear"}
    },
        ["Ahri"] = {
        [_Q] = { speed = 1200, delay = 0.25, range = 880, width = 100, collision = false, aoe = false, type = "linear"},
        [_E] = { speed = 1100, delay = 0.25, range = 975, width = 60, collision = true, aoe = false, type = "linear"}
    },
        ["Amumu"] = {
        [_Q] = { speed = 2000, delay = 0.250, range = 1100, width = 80, collision = true, aoe = false, type = "linear"}
    },
        ["Anivia"] = {
        [_Q] = { speed = 850, delay = 0.250, range = 1200, width = 110, collision = false, aoe = false, type = "linear"},
        [_R] = { speed = math.huge, delay = 0.100, range = 615, width = 350, collision = false, aoe = true, type = "circular"}
    },
        ["Annie"] = {
        [_W] = { speed = math.huge, delay = 0.25, range = 625, width = 0, collision = false, aoe = true, type = "cone"},
        [_R] = { speed = math.huge, delay = 0.1, range = 600, width = 300, collision = false, aoe = true, type = "circular"}
    },
        ["Ashe"] = {
        [_W] = { speed = 2000, delay = 0.120, range = 1200, width = 85, collision = true, aoe = false, type = "cone"},
        [_R] = { speed = 1600, delay = 0.25, range = 25000, width = 120, collision = false, aoe = false, type = "linear"}
    },
        ["Blitzcrank"] = {
        [_Q] = { speed = 1800, delay = 0.250, range = 900, width = 70, collision = true, aoe = false, type = "linear"}
    },
        ["Brand"] = {
        [_Q] = { speed = 1600, delay = 0.25, range = 1100, width = 60, collision = false, aoe = false, type = "linear"},
        [_W] = { speed = math.huge, delay = 0.85, range = 1100, width = 210, collision = false, aoe = true, type = "linear"}
    },
        ["Braum"] = {
        [_Q] = { speed = 1600, delay = 225, range = 1000, width = 100, collision = false, aoe = false, type = "linear"},
        [_R] = { speed = 1250, delay = 500, range = 1250, width = 0, collision = false, aoe = false, type = "linear"}
    },    
        ["Caitlyn"] = {
        [_Q] = { speed = 2200, delay = 0.625, range = 1300, width = 0, collision = false, aoe = false, type = "linear"},
        [_E] = { speed = 2000, delay = 0.400, range = 1000, width = 80, collision = false, aoe = false, type = "linear"}
    },
        ["Cassiopeia"] = {
        [_Q] = { speed = math.huge, delay = 0.535, range = 850, width = 130, collision = false, aoe = false, type = "circular"},
        [_W] = { speed = math.huge, delay = 0.350, range = 850, width = 212, collision = false, aoe = false, type = "circular"},
        [_R] = { speed = math.huge, delay = 0.535, range = 850, width = 350, collision = false, aoe = false, type = "cone"}
    },
        ["Chogath"] = {
        [_Q] = { speed = math.huge, delay = 0.625, range = 950, width = 300, collision = false, aoe = true, type = "circular"},
        [_W] = { speed = math.huge, delay = 0.5, range = 650, width = 275, collision = false, aoe = false, type = "linear"},
    },
        ["Corki"] = {
        [_Q] = { speed = 700, delay = 0.4, range = 825, width = 250, collision = false, aoe = false, type = "circular"},
        [_R] = { speed = 2000, delay = 0.200, range = 1225, width = 60, collision = false, aoe = false, type = "linear"},
    },
        ["Darius"] = {
        [_E] = { speed = 1500, delay = 0.550, range = 530, width = 0, collision = false, aoe = true, type = "cone"}
    },
        ["Diana"] = {
        [_Q] = { speed = 2000, delay = 0.250, range = 830, width = 0, collision = false, aoe = false, type = "linear"}
    },
        ["DrMundo"] = {
        [_Q] = { speed = 2000, delay = 0.250, range = 1050, width = 75, collision = true, aoe = false, type = "linear"}
    },
        ["Draven"] = {
        [_E] = { speed = 1400, delay = 0.250, range = 1100, width = 130, collision = false, aoe = false, type = "linear"},
        [_R] = { speed = 2000, delay = 0.5, range = 25000, width = 160, collision = false, aoe = false, type = "linear"}
    },
        ["Elise"] = {
        [_E] = { speed = 1450, delay = 0.250, range = 975, width = 70, collision = true, aoe = false, type = "linear"}
    },
        ["Ekko"] = {
        [_Q] = { speed = 1050, delay = 0.250, range = 825, width = 70, collision = false, aoe = false, type = "linear"}
    },
        ["Ezreal"] = {
        [_Q] = { speed = 2000, delay = 0.25, range = 1200, width = 65, collision = true, aoe = false, type = "linear"},
        [_W] = { speed = 1200, delay = 0.25, range = 900, width = 90, collision = false, aoe = false, type = "linear"},
        [_R] = { speed = 2000, delay = 1, range = 20000, width = 160, collision = false, aoe = false, type = "linear"}
    },
        ["Fizz"] = {
        [_R] = { speed = 1350, delay = 0.250, range = 1150, width = 100, collision = false, aoe = false, type = "linear"}
    },
        ["Galio"] = {
        [_Q] = { speed = 1300, delay = 0.25, range = 900, width = 250, collision = false, aoe = true, type = "circular"},
        [_E] = { speed = 1200, delay = 0.25, range = 1000, width = 200, collision = false, aoe = false, type = "linear"}
    },
        ["Gragas"] = {
        [_Q] = { speed = 1000, delay = 0.250, range = 1000, width = 300, collision = false, aoe = true, type = "circular"},
        [_E] = { speed = math.huge, delay = 0.250, range = 600, width = 50, collision = true, aoe = true, type = "circular"},
        [_R] = { speed = 1000, delay = 0.250, range = 1050, width = 400, collision = false, aoe = true, type = "circular"}
    },
        ["Graves"] = {
        [_Q] = { speed = 1950, delay = 0.265, range = 750, width = 85, collision = false, aoe = false, type = "cone"},
        [_W] = { speed = 1650, delay = 0.300, range = 700, width = 250, collision = false, aoe = true, type = "circular"},
        [_R] = { speed = 2100, delay = 0.219, range = 1000, width = 100, collision = false, aoe = false, type = "linear"}
    },
        ["Heimerdinger"] = {
        [_W] = { speed = 900, delay = 0.500, range = 1325, width = 100, collision = true, aoe = false, type = "linear"},
        [_E] = { speed = 2500, delay = 0.250, range = 970, width = 180, collision = false, aoe = true, type = "circular"}
    },
        ["Irelia"] = {
        [_R] = { speed = 1700, delay = 0.250, range = 1200, width = 10, collision = false, aoe = false, type = "linear"}
    },
        ["JarvanIV"] = {
        [_Q] = { speed = 1400, delay = 0.2, range = 770, width = 0, collision = false, aoe = false, type = "linear"},
        [_E] = { speed = 200, delay = 0.2, range = 850, width = 0, collision = false, aoe = false, type = "linear"}
    },
        ["Jinx"] = {
        [_W] = { speed = 3000, delay = 0.600, range = 1400, width = 60, collision = true, aoe = false, type = "linear"},
        [_E] = { speed = 887, delay = 0.500, range = 830, width = 0, collision = false, aoe = true, type = "circular"},
        [_R] = { speed = 1700, delay = 0.600, range = 20000, width = 120, collision = false, aoe = true, type = "circular"}
    },
        ["Jhin"] = {
        [_W] = { speed = math.huge, delay = 0.675, range = 2250, width = 80, collision = true, aoe = false, type = "linear"},
        [_R] = { speed = 4000, delay = 0.250, range = 3500, width = 160, collision = true, aoe = false, type = "linear"}
    },
        ["Jayce"] = {
        [_Q] = { speed = 2350, delay = 0.15, range = 1750, width = 70, collision = true, aoe = false, type = "linear"}
    },
        ["Kalista"] = {
        [_Q] = { speed = 1750, delay = 0.25, range = 1450, width = 70, collision = true, aoe = false, type = "linear"}
    },
        ["Karma"] = {
        [_Q] = { speed = 1700, delay = 0.250, range = 950, width = 90, collision = true, aoe = false, type = "linear"}
    },
        ["Karthus"] = {
        [_Q] = { speed = 1700, delay = 0.25, range = 875, width = 140, collision = false, aoe = true, type = "circular"}
    },
        ["Kennen"] = {
        [_Q] = { speed = 1700, delay = 0.180, range = 1050, width = 70, collision = true, aoe = false, type = "linear"}
    },
        ["Khazix"] = {
        [_W] = { speed = 1700, delay = 0.25, range = 1025, width = 70, collision = true, aoe = false, type = "linear"}
    },
        ["KogMaw"] = {
        [_Q] = { speed = 1550, delay = 0.3667, range = 975, width = 60, collision = true, aoe = false, type = "linear"},
        [_E] = { speed = 1200, delay = 0.5, range = 1200, width = 120, collision = false, aoe = false, type = "linear"},
        [_R] = { speed = math.huge, delay = 1.1, range = 2200, width = 65, collision = false, aoe = true, type = "circular"}
    },
        ["Leblanc"] = {
        [_E] = { speed = 1600, delay = 0.250, range = 960, width = 70, collision = true, aoe = false, type = "linear"}
    },
        ["LeeSin"] = {
        [_Q] = { speed = 1800, delay = 0.250, range = 1100, width = 100, collision = true, aoe = false, type = "linear"}
    },
        ["Leona"] = {
        [_E] = { speed = 2000, delay = 0.250, range = 875, width = 80, collision = false, aoe = false, type = "linear"},
        [_R] = { speed = 2000, delay = 0.250, range = 1200, width = 300, collision = false, aoe = true, type = "circular"}
    },
        ["Lissandra"] = {
        [_Q] = { speed = 1800, delay = 0.250, range = 725, width = 20, collision = true, aoe = false, type = "linear"}
    },
        ["Lucian"] = {
        [_W] = { speed = 800, delay = 0.300, range = 1000, width = 80, collision = true, aoe = false, type = "linear"}
    },
        ["Lulu"] = {
        [_Q] = { speed = 1400, delay = 0.250, range = 925, width = 80, collision = false, aoe = false, type = "linear"}
    },
        ["Lux"] = {
        [_Q] = { speed = 1350, delay = 0.25, range = 1175, width = 65, collision = true, type = "linear" },
        [_E] = { speed = 1275, delay = 0.25, range = 1100, width = 250, collision = false, type = "circular" },
        [_R] = { speed = math.huge, delay = 0.675, range = 3340, width = 190, collision = false, type = "linear" }
    },
        ["Malphite"] = {
        [_R] = { speed = 550, delay = 0.0, range = 1000, width = 300, collision = false, aoe = true, type = "circular"}
    },
        ["Malzahar"] = {
        [_Q] = { speed = 1600, delay = 0.600, range = 900, width = 200, collision = false, aoe = false, type = "linear"},
        [_W] = { speed = math.huge, delay = 0.25, range = 800, width = 240, collision = false, aoe = true, type = "circular"}
    },
        ["Mordekaiser"] = {
        [_E] = { speed = math.huge, delay = 0.25, range = 700, width = 0, collision = false, aoe = true, type = "cone"},
    },
        ["Morgana"] = {
        [_Q] = { speed = 1200, delay = 0.250, range = 1300, width = 80, collision = true, aoe = false, type = "linear"}
    },
        ["Nami"] = {
        [_Q] = { speed = math.huge, delay = 0.8, range = 850, width = 0, collision = false, aoe = true, type = "circular"}
    },
        ["Nautilus"] = {
        [_Q] = { speed = 2000, delay = 0.250, range = 1080, width = 80, collision = true, aoe = false, type = "linear"}
    },
        ["Nidalee"] = {
        [_Q] = { speed = 1300, delay = 0.125, range = 1500, width = 60, collision = true, aoe = false, type = "linear"},
    },
        ["Nocturne"] = {
        [_Q] = { speed = 1400, delay = 0.250, range = 1125, width = 60, collision = false, aoe = false, type = "linear"}
    },
        ["Olaf"] = {
        [_Q] = { speed = 1600, delay = 0.25, range = 1000, width = 90, collision = false, aoe = false, type = "linear"}
    },
        ["Quinn"] = {
        [_Q] = { speed = 1550, delay = 0.25, range = 1050, width = 80, collision = true, aoe = false, type = "linear"}
    },
        ["Rengar"] = {
        [_E] = { speed = 1500, delay = 0.50, range = 1000, width = 80, collision = false, aoe = false, type = "linear"}
    },
        ["Riven"] = {
        [_R] = { speed = 2200, delay = 0.5, range = 1100, width = 200, collision = false, aoe = false, type = "cone", spellname = "rivenizunablade"}
    },
        ["Rumble"] = {
        [_E] = { speed = 1200, delay = 0.250, range = 850, width = 90, collision = true, aoe = false, type = "linear"}
    },
        ["Ryze"] = {
        [_Q] = { speed = 1700, delay = 0.25, range = 900, width = 50, collision = true, aoe = false, type = "linear"}
    },
        ["Sejuani"] = {
        [_R] = { speed = 1600, delay = 0.250, range = 1200, width = 110, collision = false, aoe = false, type = "linear"}
    },
        ["Shyvana"] = {
        [_E] = { speed = 1500, delay = 0.250, range = 925, width = 60, collision = false, aoe = false, type = "linear"}
    },
        ["Sivir"] = {
        [_Q] = { speed = 1330, delay = 0.250, range = 1075, width = 0, collision = false, aoe = false, type = "linear"}
    },
        ["Skarner"] = {
        [_E] = { speed = 1200, delay = 0.600, range = 350, width = 60, collision = false, aoe = false, type = "linear"}
    },
        ["Sona"] = {
        [_R] = { speed = 2400, delay = 0.5, range = 1050, width = 160, collision = false, aoe = false, type = "linear"}
    },
        ["Swain"] = {
        [_W] = { speed = math.huge, delay = 0.850, range = 900, width = 125, collision = false, aoe = true, type = "circular"}
    },
        ["Syndra"] = {
        [_Q] = { speed = math.huge, delay = 0.600, range = 790, width = 125, collision = false, aoe = true, type = "circular"},
        [_E] = { speed = 2500, delay = 0.250, range = 700, width = 45, collision = false, aoe = true, type = "cone"}
    },
        ["Thresh"] = {
        [_Q] = { speed = 1900, delay = 0.500, range = 1050, width = 70, collision = true, aoe = false, type = "linear"}
    },
        ["Twitch"] = {
        [_W] = {speed = 1750, delay = 0.250, range = 950, width = 275, collision = false, aoe = true, type = "circular"}
    },
        ["TwistedFate"] = {
        [_Q] = { speed = 1500, delay = 0.250, range = 1200, width = 80, collision = false, aoe = false, type = "cone"}
    },
        ["Urgot"] = {
        [_Q] = { speed = 1600, delay = 0.2, range = 1400, width = 80, collision = true, aoe = false, type = "linear"},
        [_E] = { speed = 1750, delay = 0.3, range = 920, width = 200, collision = false, aoe = true, type = "circular"}
    },
        ["Varus"] = {
        [_Q] = { speed = 1500, delay = 0.5, range = 1475, width = 100, collision = false, aoe = false, type = "linear"},
        [_E] = { speed = 1750, delay = 0.25, range = 925, width = 235, collision = false, aoe = true, type = "circular"},
        [_R] = { speed = 1200, delay = 0.5, range = 800, width = 100, collision = false, aoe = false, type = "linear"}
    },
        ["Veigar"] = {
        [_Q] = { speed = 1200, delay = 0.25, range = 875, width = 75, collision = true, aoe = false, type = "linear"},
        [_W] = { speed = 900, delay = 1.25, range = 900, width = 110, collision = false, aoe = true, type = "circular"}
    },
        ["Vi"] = {
        [_Q] = { speed = 1500, delay = 0.25, range = 715, width = 55, collision = false, aoe = false, type = "linear"},
    },
        ["Viktor"] = {
        [_W] = { speed = 750, delay = 0.6, range = 700, width = 125, collision = false, aoe = true, type = "circular"},
        [_E] = { speed = 1200, delay = 0.25, range = 1200, width = 0, collision = false, aoe = false, type = "linear"},
        [_R] = { speed = 1000, delay = 0.25, range = 700, width = 0, collision = false, aoe = true, type = "circular"},
    },
        ["Velkoz"] = {
        [_Q] = { speed = 1300, delay = 0.066, range = 1050, width = 50, collision = true, aoe = false, type = "linear"},
        [_W] = { speed = 1700, delay = 0.064, range = 1050, width = 80, collision = false, aoe = false, type = "linear"},
        [_E] = { speed = 1500, delay = 0.333, range = 850, width = 225, collision = false, aoe = true, type = "circular"},
        [_R] = { speed = math.huge, delay = 0.333, range = 1550, width = 50, collision = false, aoe = false, type = "linear"}
    },    
        ["Xerath"] = {
        [_Q] = { speed = math.huge, delay = 0.6, range = 750, width = 100, collision = false, aoe = false, type = "linear"},
        [_W] = { speed = math.huge, delay = 0.25, range = 1100, width = 100, collision = false, aoe = true, type = "circular"},
        [_E] = { speed = 1600, delay = 0.25, range = 1050, width = 70, collision = true, aoe = false, type = "linear"},
        [_R] = { speed = math.huge, delay = 0.75, range = 3200, width = 245, collision = false, aoe = true, type = "circular"}
    },
        ["Yasuo"] = {
        [_Q] =  { speed = math.huge, delay = 250, range = 475, width = 40, collision = false, aoe = false, type = "linear"},
    },
        ["Zac"] = {
        [_Q] = { speed = 2500, delay = 0.110, range = 500, width = 110, collision = false, aoe = false, type = "linear"},
    },
        ["Zed"] = {
        [_Q] = { speed = 1700, delay = 0.25, range = 925, width = 50, collision = false, aoe = false, type = "linear"},
    },
        ["Ziggs"] = {
        [_Q] = { speed = 1750, delay = 0.25, range = 1400, width = 155, collision = true, aoe = false, type = "linear"},
        [_W] = { speed = 1800, delay = 0.25, range = 970, width = 275, collision = false, aoe = true, type = "circular"},
        [_E] = { speed = 1750, delay = 0.12, range = 900, width = 350, collision = false, aoe = true, type = "circular"},
        [_R] = { speed = 1750, delay = 0.14, range = 5300, width = 525, collision = false, aoe = true, type = "circular"},
    },
        ["Zilean"] = {
        [_Q] = { speed = math.huge, delay = 0.5, range = 900, width = 150, collision = false, aoe = true, type = "circular"},
    },
        ["Zyra"] = {
        [_Q] = { speed = math.huge, delay = 0.7, range = 800, width = 85, collision = false, aoe = true, type = "circular"},
        [_E] = { speed = 1150, delay = 0.25, range = 1100, width = 70, collision = false, aoe = false, type = "linear"},
        [_R] = { speed = math.huge, delay = 1, range = 1100, width = 500, collision=false, aoe = true, type = "circular" }
    }
}
--[[ Skillshot list end ]]--

AddLoadCallback(function()
    if not tAimbotChamps[myHero.charName] then tAimbotChamps = nil;collectgarbage();return;end; -- not supported :(
    local tAimbotSpells, tAimbotChamps, tAimbotStrings = table.copy(tAimbotChamps[myHero.charName]), nil, {"W", "E", "R", [0] = "Q"};
    collectgarbage();
    local enemyHeroes, enemyHeroesCount = GetEnemyHeroes(), #GetEnemyHeroes(); -- lazy approach..
    local iAimbotVersion = 3;
    local function aimbotMsg(msg) 
        print("<font color=\"#ff0000\">[</font><font color=\"#ff7f00\">A</font><font color=\"#ffbf00\">i</font><font color=\"#ffff00\">m</font><font color=\"#00ff00\">b</font><font color=\"#00ffff\">o</font><font color=\"#0080ff\">t</font><font color=\"#0000ff\">]</font><font color=\"#8b00ff\">:</font> <font color=\"#FFFFFF\">"..msg..".</font>");
    end;
    (function(_)
        if AUTO_UPDATE then
            local sAimbotServerData = GetWebResult("raw.githubusercontent.com", "/nebelwolfi/BoL/master/Aimbot.version".."?no-cache="..math.random(1,99999999));
            if sAimbotServerData then
                local iAimbotServerVersion = type(tonumber(sAimbotServerData)) == "number" and tonumber(sAimbotServerData) or nil;
                if iAimbotServerVersion then
                    if tonumber(iAimbotVersion) < iAimbotServerVersion then
                        aimbotMsg("New version available v"..iAimbotServerVersion);
                        aimbotMsg("Updating, please don't press F9");
                        DelayAction(function() DownloadFile("https:/raw.githubusercontent.com".."/nebelwolfi/BoL/master/Aimbot.lua".."?no-cache="..math.random(1,99999999), SCRIPT_PATH.."Aimbot.lua", function() 
                                aimbotMsg("Successfully updated. ("..iAimbotVersion.." => "..iAimbotServerVersion.."), press F9 twice to load the updated version");
                            end)
                        end, .5);
                        return;
                    end;
                end;
            else
                aimbotMsg("Error downloading version info");
            end;
        else
            aimbotMsg("AUTO_UPDATE is disabled.");
        end;
        if not _G.UPLloaded then
            if FileExist(LIB_PATH .. "/UPL.lua") then
                require("UPL");
                _G.UPL = UPL();
                _();
            else 
                aimbotMsg("Downloading UPL, please don't press F9")
                DelayAction(function() 
                    DownloadFile("https://raw.githubusercontent.com/bol/Common/UPL.lua".."?rand="..math.random(1,99999999), LIB_PATH.."UPL.lua", function() 
                        DelayAction(function()
                            require("UPL");
                            _G.UPL = UPL();
                            _();
                        end, .5);
                    end);
                end, .5);
            end;
        end;
    end)(function() 
        local mAimbotMenu = scriptConfig("[Aimbot] "..myHero.charName, "Aimbot3");
        mAimbotMenu:addParam("empty1", " ", SCRIPT_PARAM_INFO, " ");
        UPL:AddToMenu(mAimbotMenu);
        for k = 0, 3 do
            local v = tAimbotSpells[k];
            if v then
                UPL:AddSpell(k, v);
                mAimbotMenu:addParam(tAimbotStrings[k], "Aimassist: " .. tAimbotStrings[k], SCRIPT_PARAM_ONOFF, false);
            end;
        end;
        mAimbotMenu:addParam("empty2", " ", SCRIPT_PARAM_INFO, " ");
        mAimbotMenu:addParam("ofmiceandmen", "Allow casting to mouse", SCRIPT_PARAM_ONOFF, false);
        mAimbotMenu:addParam("info1", "^ If below hitchance threshold ^", SCRIPT_PARAM_INFO, " ");
        mAimbotMenu:addParam("empty3", " ", SCRIPT_PARAM_INFO, " ");
        mAimbotMenu:addParam("onoff", "Activate Aimbot", SCRIPT_PARAM_ONOFF, true);
        mAimbotMenu:addParam("toggle", "Deactivate Aimbot", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "));
        AddCastSpellCallback(function(i, _, __)
            if mAimbotMenu.onoff and not mAimbotMenu.toggle then
                if mAimbotMenu[tAimbotStrings[i]] then
                    local _ = (function(I)
                                    local c = 0;
                                    for i = 0, enemyHeroesCount do 
                                        local _ = enemyHeroes[i];
                                        if _ and _.valid and not _.dead and _.visible then
                                            local dx, dy = (_.x - myHero.x), (_.z - myHero.z);
                                            local r = tAimbotSpells[I].range + tAimbotSpells[I].width *.5;
                                            if dx*dx + dy*dy < r * r then
                                                c = c + 1;
                                            end;
                                            local CastPosition, Chance = UPL:Predict(I, myHero, _);
                                            if CastPosition and Chance > 0 then 
                                                return CastPosition;
                                            end;
                                        end;
                                    end;
                                    return not (mAimbotMenu.ofmiceandmen or c == 0);
                                end)(i);
                    if _ and _ ~= true then 
                        __.x,__.y,__.z=_.x,_.y,_.z; 
                    else 
                        return not _ or BlockSpell();
                    end;
                end;
            end;
        end);
    end);
end)
