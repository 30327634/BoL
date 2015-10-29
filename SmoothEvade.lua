local version = 1;
local patch = GetGameVersion():lower():find("5.19") and "5.19" or "5.18"
local debugMode = true;
local enemyHeroes = {{charName = "Lux"}, {charName = "Graves"}, {charName = "Morgana"}, {charName = "Diana"}, {charName = "Ezreal"}};
local print2 = print;
local EvasionTable = {};
local VIP = VIP_USER;
local SmoothEvadeConfig = nil;
local ChampionList = {};
local CurrentConfigurateChampions = {};
local str = {[-3] = "P", [-2] = "Q3", [-1] = "Q2", [_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"};
local testPos = Vector(6939, -188, 1827);

_G.Evade = false;

local 
function print(msg)
	if (not debugMode and tostring(msg) ~= "SmoothEvade - Loaded!") then 
		return;
	end
	print2("<font color=\"#ff0000\">[</font><font color=\"#ff4000\">S</font><font color=\"#ff7f00\">m</font><font color=\"#ffbf00\">o</font><font color=\"#ffff00\">o</font><font color=\"#aaff00\">t</font><font color=\"#55ff00\">h</font><font color=\"#00ff00\">E</font><font color=\"#00ff80\">v</font><font color=\"#00ffff\">a</font><font color=\"#0080ff\">d</font><font color=\"#0000ff\">e</font><font color=\"#4600ff\">]</font><font color=\"#8b00ff\">:</font> <font color=\"#FFFFFF\">"..tostring(msg).."</font>");
end

local 
function OnSkillshot(skillshot)
end

local 
function OnCreateSkillshotObject(object)
end

local 
function OnProcessSkillshotSpell(spell)
end

local 
function OnEvade()
	_G.Evade = true;
end

local 
function OnAfterEvade()
	_G.Evade = false;
end

local 
function GetDistanceSqr(p1, p2)
	p2 = p2 or myHero;
	local dx = p1.x - p2.x;
	local dz = (p1.z or p1.y) - (p2.z or p2.y);
	return dx*dx + dz*dz;
end

local 
function GetDistance(p1, p2)
	p2 = p2 or myHero;
	return math.sqrt(GetDistanceSqr(p1, p2));
end

local 
function GetAnchorPoint()
end

local
function MakeMove(t)
	local x,y,z = VectorPointProjectionOnLineSegment(t.startPos,t.endPos,Vector(myHero))
	if z and GetDistance(x) < t.width then
		local x = Vector(x.x,0,x.y)
		t.evadePos = x - ((t.endPos-x):normalized()*t.width):perpendicular()
		MoveTable = t;
	end
end

local
function Tick()
	for i, skill in pairs(EvasionTable) do
		if skill.type == "linear" then
			local timer = skill.startTime+skill.delay;
			local time = os.clock();
			local ttime = skill.range/skill.speed;
			if time <= timer then
			elseif skill.speed ~= math.huge and time > timer and time <= timer+ttime then
				skill.currentPos = skill.endPos-(skill.endPos-skill.startPos):normalized()*skill.range*((timer+ttime-time)/ttime);
			elseif timer+ttime < time then
				table.remove(EvasionTable, i);
			end
			local CurrentPos = skill.endPos-(skill.endPos-skill.startPos):normalized()*skill.range*((timer-SmoothEvadeConfig.Skillshots[skill.menu].Delay+ttime-time)/ttime);
			if GetDistance(CurrentPos) < skill.width*2+myHero.boundingRadius and GetDistance(CurrentPos) < skill.range+skill.width then
				MakeMove({startPos = skill.startPos, endPos = skill.endPos, evadePos = nil, width = skill.width+SmoothEvadeConfig.Skillshots[skill.menu].Width+myHero.boundingRadius, id = i})
			end
		elseif skill.type == "circular" then
			local timer = skill.startTime+skill.delay;
			local time = os.clock();
			local ttime = skill.range/skill.speed;
			if time <= timer then
			elseif skill.speed ~= math.huge and time > timer and time <= timer+ttime then
				skill.currentPos = skill.endPos-(skill.endPos-skill.startPos):normalized()*skill.range*((timer+ttime-time)/ttime);
			elseif timer+ttime < time then
				table.remove(EvasionTable, i);
			end
		elseif skill.type == "cone" then
			local timer = skill.startTime+skill.delay;
			local time = os.clock();
			if time <= timer then
			elseif timer < time then
				table.remove(EvasionTable, i);
			end
		end
	end
	if MoveTable then
		myHero:MoveTo(MoveTable.evadePos.x, MoveTable.evadePos.z)
	end
	if MoveTable and (GetDistance(MoveTable.startPos) > MoveTable.width or not EvasionTable[MoveTable.id]) then
		MoveTable = nil;
	end
end

local
function DrawLine3D(x,y,z,a,b,c,w,col)
	local p = WorldToScreen(D3DXVECTOR3(x, y, z))
	local px, py = p.x, p.y
	local c = WorldToScreen(D3DXVECTOR3(a, b, c))
	local cx, cy = c.x, c.y
	if OnScreen(px, py) or OnScreen(px, py) then
		DrawLine(cx, cy, px, py, w or 1, col or 4294967295)
	end
end

local
function DrawRectangleOutline(startPos, endPos, width)
	local c1 = startPos+Vector(Vector(endPos)-startPos):perpendicular():normalized()*width
	local c2 = startPos+Vector(Vector(endPos)-startPos):perpendicular2():normalized()*width
	local c3 = endPos+Vector(Vector(startPos)-endPos):perpendicular():normalized()*width
	local c4 = endPos+Vector(Vector(startPos)-endPos):perpendicular2():normalized()*width
	DrawLine3D(c1.x,c1.y,c1.z,c2.x,c2.y,c2.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	DrawLine3D(c2.x,c2.y,c2.z,c3.x,c3.y,c3.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	DrawLine3D(c3.x,c3.y,c3.z,c4.x,c4.y,c4.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	DrawLine3D(c1.x,c1.y,c1.z,c4.x,c4.y,c4.z,math.ceil(width/100),ARGB(255, 255, 255, 255))
	local c1 = startPos+Vector(Vector(endPos)-startPos):perpendicular():normalized()*width*1.25
	local c2 = startPos+Vector(Vector(endPos)-startPos):perpendicular2():normalized()*width*1.25
	DrawLine3D(c1.x,c1.y,c1.z,c2.x,c2.y,c2.z,math.ceil(width/25),ARGB(255, 0, 255, 0))
end

local
function DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
	radius = radius or 300
	quality = chordlength
	quality = 2 * math.pi / quality
	radius = radius*.92
	local points = {}
	for theta = 0, 2 * math.pi + quality, quality do
		local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
		points[#points + 1] = D3DXVECTOR2(c.x, c.y)
	end
	DrawLines2(points, width or 1, color or 4294967295)
end

local
function DrawCircle3D(x, y, z, radius, width, color, chordlength)
	local vPos1 = Vector(x, y, z)
	local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
	local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
	local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
	if OnScreen(sPos.x, sPos.y) then
		DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
	end
end

local
function DrawArrow3D(start, endPos, width, color)
	DrawLine3D(start.x,start.y,start.z,endPos.x,endPos.y,endPos.z,width,color)
	local start2 = endPos-((start-endPos):normalized()*75):perpendicular()+(start-endPos):normalized()*75
	DrawLine3D(start2.x,start2.y,start2.z,endPos.x,endPos.y,endPos.z,width,color)
	local start3 = endPos-((start-endPos):normalized()*75):perpendicular2()+(start-endPos):normalized()*75
	DrawLine3D(start3.x,start3.y,start3.z,endPos.x,endPos.y,endPos.z,width,color)
end

local 
function Draw()
	for i, skill in pairs(EvasionTable) do
		if skill.type == "linear" then
			DrawRectangleOutline(skill.currentPos, skill.endPos, skill.width/2);
		elseif skill.type == "circular" then
			local pos = skill.endPos;
			DrawCircle3D(pos.x, pos.y, pos.z, skill.width, 2, ARGB(255,255,255,255), 8)
		elseif skill.type == "cone" then
		end
	end
	if MoveTable then
		DrawArrow3D(MoveTable.startPos, MoveTable.evadePos, 2, ARGB(255,0,255,0))
	end
end

local 
function ProcessSpell(u,s)
end

local 
function CreateObject(o)
end

function OnSendPacket(p)
	if (_G.Evade) then
		if (p.header == 1 and SmoothEvadeConfig.VIP.BlockMovement) then
			if (SmoothMove) then
				SmoothMove = false;
			else
				p:Block();
			end
		end
		if (p.header == 0x26 and SmoothEvadeConfig.VIP.BlockSpells) then
			if (SmoothCast) then
				SmoothCast = false;
			else
				p:Block();
			end
		end
	end
end

local 
function Update()
	CScriptUpdate(version, true, "raw.githubusercontent.com", "/nebelwolfi/BoL/master/SmoothEvade.version", "/nebelwolfi/BoL/master/SmoothEvade.lua?rand="..math.random(1,10000), SCRIPT_PATH.."SmoothEvade.lua", function() end, function() print("Latest Version!") end, function() print("Updating!") end, function() end)
end

function scriptConfig:clear(clearParams, clearSubMenus)
	assert(type(clearParams) == "boolean" and type(clearSubMenus) == "boolean", "ImprovedScriptConfig: wrong argument types (<boolean>, <boolean> expected)")

	if (clearParams) then
		local i = #self._param;
		while i > 0 do
			local param = self._param[i];
			table.remove(self._param, i);
			i = i - 1;
		end
	end

	if (clearSubMenus) then
		for i, subMenu in pairs(self._subInstances) do
			subMenu:clear(clearParams, clearSubMenus);
		end
		self._subInstances = {};
		self._subMenuIndex = 0;
		self._param = {};
	end
end

local
function DoSkillshotMenu(shot)
	SmoothEvadeConfig.Skillshots[shot]:addParam("Enabled", "Evade Enabled", SCRIPT_PARAM_ONOFF, true)
	SmoothEvadeConfig.Skillshots[shot]:addParam("Delay", "Evade X seconds before hit", SCRIPT_PARAM_SLICE, 0.25, 0.125, 0.75, 2)
	SmoothEvadeConfig.Skillshots[shot]:addParam("Width", "Extra width", SCRIPT_PARAM_SLICE, 0, 0, 250, 1)
end

local
function DoSkillshotsMenu(bool)
	if not SmoothEvadeConfig.Skillshots then
		SmoothEvadeConfig:addSubMenu("Skillshots", "Skillshots");
	end
	SmoothEvadeConfig.Skillshots:clear(true, true);
	if (not bool) then
	else
		local champName = CurrentConfigurateChampions[SmoothEvadeConfig.Config.Champions];
		if spellData[champName] then
			for c, d in pairs(spellData[champName]) do
				if d and d.type then
					SmoothEvadeConfig.Skillshots:addSubMenu(champName.." -------- ["..(d.name or str[c]).."]", champName..str[c])
					DoSkillshotMenu(champName..str[c])
				end
			end
		end
	end
end

local 
function AssignCallbacks()
	AddTickCallback(Tick);
	AddDrawCallback(Draw);
	AddProcessSpellCallback(ProcessSpell);
	AddCreateObjCallback(CreateObject);
	print("Callbacks - Loaded!");
end

local function pairsByKeys (t, f)
	local a = {};
	for n in pairs(t) do 
		table.insert(a, n);
	end
	table.sort(a, f)
	local i = 0;
	local iter = function ()
		i = i + 1;
		if (a[i] == nil) then 
			return nil;
		else 
			return a[i], t[a[i]];
		end
	end
	return iter;
end

local 
function LoadSpellData()
	if (FileExist(LIB_PATH .. "SpellData.lua")) then
		spellData = loadfile(LIB_PATH .. "SpellData.lua")();
		for champ, skillshots in pairsByKeys(spellData) do
			local insert = false;
			for k, skillshot in pairs(skillshots) do
				if (skillshot and skillshot.type) then
					insert = true;
				end
			end
			if insert then
				table.insert(ChampionList, champ);
			end
		end
		print("SpellData - Loaded!");
		CScriptUpdate(0, true, "raw.githubusercontent.com", "/nebelwolfi/BoL/master/Scriptology.version", "/nebelwolfi/BoL/master/Common/SpellData.lua?rand="..math.random(1,10000), LIB_PATH.."SpellData.lua", function() end, function() end, function() end, function() end)
	else
		print("Please download the SpellData.lua file from the thread!");
	end
end

local 
function ChangeConfigurateSkills(index)
	SmoothEvadeConfig.Config:removeParam("Skills");
	local skills = {"","","",""};
	local data = spellData[CurrentConfigurateChampions[index]];
	if (data) then
		for _, spell in pairs(data) do
			if (spell and spell.type) then
				skills[_+1] = (spell.name or str[_]);
			end
		end
	end
	SmoothEvadeConfig.Config:addParam("Skills", "Skill to shoot", SCRIPT_PARAM_LIST, 1, skills);
	DelayAction(function() DoSkillshotsMenu(true); end, 0.5);
end

local
function ChangeConfigurateToLetter(letter)
	SmoothEvadeConfig.Config:removeParam("Champions");
	CurrentConfigurateChampions = {};
	for c, s in pairs(ChampionList) do
		if (string.sub(s, 1, 1):lower():find(string.char(letter+96))) then
			table.insert(CurrentConfigurateChampions, s);
		end
	end
	SmoothEvadeConfig.Config:addParam("Champions", "Champion:", SCRIPT_PARAM_LIST, 1, CurrentConfigurateChampions);
	SmoothEvadeConfig.Config.Champions = 1;
	SmoothEvadeConfig.Config:setCallback("Champions", ChangeConfigurateSkills)
	ChangeConfigurateSkills(1);
end

local
function FireSkillshot(fire)
	SmoothEvadeConfig.Config.Shoot = false;
	if fire then
		local data = spellData[CurrentConfigurateChampions[SmoothEvadeConfig.Config.Champions]][SmoothEvadeConfig.Config.Skills-1];
		if data and data.type then
			local skillshot = {};
			skillshot.menu = CurrentConfigurateChampions[SmoothEvadeConfig.Config.Champions]..str[SmoothEvadeConfig.Config.Skills-1]
			skillshot.startPos = testPos;
			skillshot.currentPos = testPos;
			skillshot.width = data.width;
			skillshot.speed = data.speed;
			skillshot.range = data.range;
			skillshot.delay = data.delay;
			skillshot.endPos = testPos + (Vector(myHero)-testPos):normalized()*skillshot.range;
			skillshot.type = data.type;
			skillshot.startTime = os.clock();
			table.insert(EvasionTable, skillshot);
		end
	end
end

local 
function Configurate(bool)
	if (bool) then
		SmoothEvadeConfig:addSubMenu("Configuration", "Config");
		SmoothEvadeConfig.Config:addParam("Shoot", "Shoot towards me", SCRIPT_PARAM_ONOFF, false);
		SmoothEvadeConfig.Config:setCallback("Shoot", FireSkillshot)
		SmoothEvadeConfig.Config:addParam("spacer", "", SCRIPT_PARAM_INFO, "");
		SmoothEvadeConfig.Config:addParam("Choose", "Choose Enemy Champion", SCRIPT_PARAM_INFO, "");
		local letters = {};
		for i=97,122 do
			table.insert(letters, string.char(i):upper());
		end
		SmoothEvadeConfig.Config:addParam("Champion", "Starting Letter:", SCRIPT_PARAM_LIST, 1, letters);
		SmoothEvadeConfig.Config.Champion = 1;
		SmoothEvadeConfig.Config:setCallback("Champion", ChangeConfigurateToLetter);
		ChangeConfigurateToLetter(1);
		ChangeConfigurateSkills(1);
		SmoothEvadeConfig.Config.Shoot = false;
	else
		DoSkillshotsMenu();
		SmoothEvadeConfig:removeSubMenu("Config");
	end
	print("Configuration Mode: "..({[true] = "Enabled", [false] = "Disabled"})[bool]);
end

local 
function SetupMenu()
	SmoothEvadeConfig = scriptConfig("SmoothEvade", "SmoothEvade"..myHero.charName);
	SmoothEvadeConfig:addSubMenu("Key Settings", "Keys");
	SmoothEvadeConfig.Keys:addParam("Evade", "Evade", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("G"));
	DoSkillshotsMenu();
	if (VIP) then
		SmoothEvadeConfig:addSubMenu("VIP", "VIP");
		SmoothEvadeConfig.VIP:addParam("BlockMovement", "Block Movement while Evading", SCRIPT_PARAM_ONOFF, true);
		SmoothEvadeConfig.VIP:addParam("BlockSpells", "Block Spells while Evading", SCRIPT_PARAM_ONOFF, true);
	end
	SmoothEvadeConfig:addSubMenu("Spells", "Spells");
	SmoothEvadeConfig:addSubMenu("Miscellaneous", "Misc");
	SmoothEvadeConfig.Misc:addParam("Collision", "Consider Collision", SCRIPT_PARAM_ONOFF, true);
	SmoothEvadeConfig.Misc:addParam("Anchor", "Select Evading Anchor", SCRIPT_PARAM_LIST, 1, {"Mouse", "Enemy", "StartPos"});
	SmoothEvadeConfig.Misc:addParam("space", "", SCRIPT_PARAM_INFO, "");
	SmoothEvadeConfig.Misc:addParam("Configuration", "Enable Configuration Mode", SCRIPT_PARAM_ONOFF, false);
	SmoothEvadeConfig.Misc.Configuration = false;
	SmoothEvadeConfig.Misc:setCallback("Configuration", Configurate);
	SmoothEvadeConfig:addParam("version", "Current Version:", SCRIPT_PARAM_INFO, patch.."."..tostring(version))
	print("Menu - Loaded!");
end

local 
function AfterLoad()
	SetupMenu();
	print("SmoothEvade - Loaded!");
end

local 
function Load()
	Update();
	AssignCallbacks();
	LoadSpellData();
	AfterLoad();
end

function OnLoad()
	Load();
end

class "CScriptUpdate" -- {

  function CScriptUpdate:__init(LocalVersion,UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
    if not ScriptologyAutoUpdate then return end
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
    return self
  end

  function CScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
  end

  function CScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
      self.LuaSocket = require("socket")
    else
      self.Socket:close()
      self.Socket = nil
      self.Size = nil
      self.RecvStarted = false
    end
    self.LuaSocket = require("socket")
    self.Socket = self.LuaSocket.tcp()
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.Socket:connect('sx-bol.eu', 80)
    self.Url = url
    self.Started = false
    self.LastPrint = ""
    self.File = ""
  end

  function CScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
      local r,b='',x:byte()
      for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
      return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
      if (#x < 6) then return '' end
      local c=0
      for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
      return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
  end

  function CScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
      self.Started = true
      self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
      self.RecvStarted = true
      self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
      if not self.Size then
      self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
      end
      if self.File:find('<scr'..'ipt>') then
      local _,ScriptFind = self.File:find('<scr'..'ipt>')
      local ScriptEnd = self.File:find('</scr'..'ipt>')
      if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
      local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
      self.DownloadStatus = 'Downloading VersionInfo ('..round(100/self.Size*DownloadedSize,2)..'%)'
      end
    end
    if self.File:find('</scr'..'ipt>') then
      self.DownloadStatus = 'Downloading VersionInfo (100%)'
      local a,b = self.File:find('\r\n\r\n')
      self.File = self.File:sub(a,-1)
      self.NewFile = ''
      for line,content in ipairs(self.File:split('\n')) do
      if content:len() > 5 then
        self.NewFile = self.NewFile .. content
      end
      end
      local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
      local ContentEnd, _ = self.File:find('</sc'..'ript>')
      if not ContentStart or not ContentEnd then
      if self.CallbackError and type(self.CallbackError) == 'function' then
        self.CallbackError()
      end
      else
      self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
      self.OnlineVersion = tonumber(self.OnlineVersion)
      if self.OnlineVersion and self.LocalVersion and self.OnlineVersion > self.LocalVersion then
        if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
        self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
        end
        self:CreateSocket(self.ScriptPath)
        self.DownloadStatus = 'Connect to Server for ScriptDownload'
        AddTickCallback(function() self:DownloadUpdate() end)
      else
        if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
        self.CallbackNoUpdate(self.LocalVersion)
        end
      end
      end
      self.GotScriptVersion = true
    end
  end

  function CScriptUpdate:DownloadUpdate()
    if self.GotCScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
      self.Started = true
      self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
      self.RecvStarted = true
      self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
      if not self.Size then
      self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
      end
      if self.File:find('<scr'..'ipt>') then
      local _,ScriptFind = self.File:find('<scr'..'ipt>')
      local ScriptEnd = self.File:find('</scr'..'ipt>')
      if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
      local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
      self.DownloadStatus = 'Downloading Script ('..round(100/self.Size*DownloadedSize,2)..'%)'
      end
    end
    if self.File:find('</scr'..'ipt>') then
      self.DownloadStatus = 'Downloading Script (100%)'
      local a,b = self.File:find('\r\n\r\n')
      self.File = self.File:sub(a,-1)
      self.NewFile = ''
      for line,content in ipairs(self.File:split('\n')) do
      if content:len() > 5 then
        self.NewFile = self.NewFile .. content
      end
      end
      local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
      local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
      if not ContentStart or not ContentEnd then
      if self.CallbackError and type(self.CallbackError) == 'function' then
        self.CallbackError()
      end
      else
      local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
      local newf = newf:gsub('\r','')
      if newf:len() ~= self.Size then
        if self.CallbackError and type(self.CallbackError) == 'function' then
        self.CallbackError()
        end
        return
      end
      local newf = Base64Decode(newf)
      if type(load(newf)) ~= 'function' then
        if self.CallbackError and type(self.CallbackError) == 'function' then
        self.CallbackError()
        end
      else
        local f = io.open(self.SavePath,"w+b")
        f:write(newf)
        f:close()
        if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
        self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
        end
      end
      end
      self.GotCScriptUpdate = true
    end
  end

-- }
