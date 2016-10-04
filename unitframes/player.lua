--[[
Create the player unit frame.
--]]

if(SanieUI.debug == true) then
	print("Loading player frame data")
end

local uf = SanieUI.unitframes
local _, class = UnitClass("player")

local height = uf.player.height
local width = uf.player.width
local scale = uf.player.scale
local texture = uf.bartexture
local xpos = uf.player.xpos
local ypos = uf.player.ypos
local backdropmargin = uf.backdropmargin
local spgap = uf.player.spgap

local hpweight = uf.player.hpweight
local ppweight = uf.player.ppweight
local spweight = uf.player.spweight

local numBars = 2
if(class == "WARLOCK" or class == "PALADIN") then
	numBars = 3
end

local hpheight = (height - (numBars + 1) * backdropmargin) * (hpweight / (hpweight + ppweight + spweight))
local ppheight = (height - (numBars + 1) * backdropmargin) * (ppweight / (hpweight + ppweight + spweight))
local spheight = (height - (numBars + 1) * backdropmargin) * (spweight / (hpweight + ppweight + spweight))

local function backdrop(frame)
	frame:SetFrameLevel(0)
	frame.texture = frame:CreateTexture()
	frame.texture:SetAllPoints(frame)
	frame.texture:SetTexture(0, 0, 0, 0.5)
end

local function createHealthBar(frame)
	local hpBar = CreateFrame("StatusBar", nil, frame)
	hpBar:SetStatusBarTexture(texture)
	hpBar:SetHeight(hpheight)
	hpBar:SetWidth(width - 2 * backdropmargin)
	hpBar:SetPoint("TOPLEFT",frame,"TOPLEFT", backdropmargin, -backdropmargin)
	hpBar:SetFrameLevel(1)
	local backgroundTexture = hpBar:CreateTexture(nil, "BACKGROUND")
	backgroundTexture:SetTexture(texture)
	backgroundTexture:SetAllPoints(hpBar)
	frame.Health = hpBar
	frame.Health.bg = backgroundTexture
end

local function createPowerBar(frame)
	local pBar = CreateFrame("StatusBar", nil, frame)
	pBar:SetStatusBarTexture(texture)
	pBar:SetHeight(ppheight)
	pBar:SetWidth(width - 2 * backdropmargin)
	pBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", backdropmargin, backdropmargin)
	pBar:SetFrameLevel(1)
	local bgTex = pBar:CreateTexture(nil, "BACKGROUND")
	bgTex:SetTexture(texture)
	bgTex:SetAllPoints(pBar)
	frame.Power = pBar
	frame.Power.bg = bgTex
end

local function createSpecialPowerBar(frame)
	local sBar = CreateFrame("StatusBar", nil, frame)
	--sBar:SetStatusBarTexture(texture)
	sBar:SetHeight(spheight)
	sBar:SetWidth(width - 2 * backdropmargin)
	sBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", backdropmargin, backdropmargin + ppheight + backdropmargin)
	sBar:SetFrameLevel(1)
	--local bgTex = sBar:CreateTexture(nil, "BACKGROUND")
	--bgTex:SetTexture(texture)
	--bgTex:SetAllPoints(sBar)
	frame.AltPowerBar = sBar
	--frame.HolyPower.bg = bgTex

	-- local singlesegmentwidth = (width - ((2 * backdropmargin) + ((MAX_HOLY_POWER - 1) * spgap))) / MAX_HOLY_POWER
	--
	-- for i = 1, MAX_HOLY_POWER do
	-- 	sBar[i] = sBar:CreateTexture(nil, "OVERLAY")
	-- 	sBar[i]:SetSize(singlesegmentwidth, spheight)
	-- 	sBar[i]:SetTexture(texture)
	-- 	sBar[i]:SetVertexColor(1, 0, 0)
	--
	-- 	if i == 1 then
	-- 		sBar[i]:SetPoint("TOPLEFT", sBar, "TOPLEFT", 0, 0)
	-- 	else
	-- 		sBar[i]:SetPoint("TOPLEFT", sBar[i - 1], "TOPRIGHT", spgap, 0)
	-- 	end
	-- end

end


local function setNameString(f)
	local tag = "[name]"
	local name = uf.GetFontString(f, SanieUI.font, 10, nil)
	name:SetPoint("BOTTOMRIGHT", f.Health, "TOPRIGHT", 0, 4)
	name:SetJustifyH("RIGHT")
	f:Tag(name, tag)

	local leftTag = "[smartlevel] [race] [smartclass]"
	local leftName = uf.GetFontString(f, SanieUI.font, 10, nil)
	leftName:SetPoint("BOTTOMLEFT", f.Health, "TOPLEFT", 0, 4)
	leftName:SetJustifyH("LEFT")
	f:Tag(leftName, leftTag)
end

local function setHpStrings(f)
	local leftHpTag = "[curhp]/[maxhp]"
	local rightHpTag = "[perhp]%"

	local leftHp = uf.GetFontString(f.Health, SanieUI.font, 10, nil)
	leftHp:SetPoint("LEFT", f.Health, "LEFT", 0, 0)
	leftHp:SetJustifyH("LEFT")
	leftHp.frequentUpdates = 0.1
	f:Tag(leftHp, leftHpTag)

	local rightHp = uf.GetFontString(f.Health, SanieUI.font, 10, nil)
	rightHp:SetPoint("RIGHT", f.Health, "RIGHT", 0, 0)
	rightHp:SetJustifyH("RIGHT")
	rightHp.frequentUpdates = 0.1
	f:Tag(rightHp, rightHpTag)
end

local function setPowerString(f)
	local ppTag = "[curpp]/[maxpp]"
	local pp = uf.GetFontString(f.Power, SanieUI.font, 10, nil)
	pp:SetPoint("RIGHT", f.Power, "RIGHT", 0, 0)
	pp:SetJustifyH("RIGHT")
	pp.frequentUpdates = 0.1
	f:Tag(pp, ppTag)
end

local function createPvpIcon(f)
	f.PvP = f.Health:CreateTexture(nil, "OVERLAY")
	if(UnitIsPVP("player")) then
		--f.PvP:SetTexCoord(0.08, 0.58, 0.045, 0.545)
		f.PvP:SetTexCoord(0, 1, 0, 1)
	end
	f.PvP:SetHeight(18)
	f.PvP:SetWidth(18)
	f.PvP:SetPoint("BOTTOMLEFT", -7, 7)
end

local function createRestIcon(f)
	f.Resting = f.Health:CreateTexture(nil, "OVERLAY")
	if(IsResting()) then
		f.Resting:SetTexCoord(0, 1, 0, 1)
	end
	f.Resting:SetHeight(18)
	f.Resting:SetWidth(18)
	f.Resting:SetPoint("TOPLEFT", 7, 7)
end

local function createCombatIcon(f)
	f.Combat = f.Health:CreateTexture(nil, "OVERLAY")
	if(UnitAffectingCombat("player"))then
		f.Combat:SetTexCoord(0, 1, 0, 1)
	end
	f.Combat:SetHeight(18)
	f.Combat:SetWidth(18)
	f.Combat:SetPoint("TOPRIGHT", 7, -7)
end

-- When you register a style with oUF, you pass it a function that basically
-- 'sets' the style.
local function CreatePlayerStyle(self, isSingle)
	self.width = width
	self.height = height
	self.scale = scale
	self.mystyle = "player"
	uf.SetFrameDimensionsAndPosition(self, "BOTTOM", UIParent, "BOTTOM", xpos, ypos)
	backdrop(self)
	createHealthBar(self)
	if(class == "PALADIN") then
--		createSpecialPowerBar(self)
	end
	createPowerBar(self)
	createPvpIcon(self)
	createRestIcon(self)
	createCombatIcon(self)
	setNameString(self)
	setHpStrings(self)
	setPowerString(self)
	self.Health.frequentUpdates = true
	self.Health.colorClass = true
	self.Health.bg.multiplier = 0.3
	self.Power.frequentUpdates = true
	self.Power.colorPower = true
	self.Power.bg.multiplier = 0.3
end

oUF:RegisterStyle("Player", CreatePlayerStyle)
oUF:SetActiveStyle("Player")
oUF:Spawn("player", "oUF_Sanie_PlayerFrame")
