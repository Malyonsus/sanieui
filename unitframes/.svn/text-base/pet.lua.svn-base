--[[
Create the pet unit frame.
--]]

if(SanieUI.debug == true) then
	print("Loading petframe data")
end

local uf = SanieUI.unitframes

local height = uf.pet.height
local width = uf.pet.width
local scale = uf.pet.scale
local texture = uf.bartexture
local xpos = uf.pet.xpos
local ypos = uf.pet.ypos
local backdropmargin = uf.backdropmargin

local hpweight = uf.pet.hpweight
local ppweight = uf.pet.ppweight

local hpheight = (height - 3 * backdropmargin) * (hpweight / (hpweight + ppweight))
local ppheight = (height - 3 * backdropmargin) * (ppweight / (hpweight + ppweight))

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
	backgroundTexture = hpBar:CreateTexture(nil, "BACKGROUND")
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
	bgTex = pBar:CreateTexture(nil, "BACKGROUND")
	bgTex:SetTexture(texture)
	bgTex:SetAllPoints(pBar)
	frame.Power = pBar
	frame.Power.bg = bgTex
end

local function setNameString(f)
	local tag = "[name]"
	local name = uf.GetFontString(f, SanieUI.font, 10, nil)
	name:SetPoint("BOTTOMRIGHT", f.Health, "TOPRIGHT", 0, 4)
	name:SetJustifyH("RIGHT")
	name.frequentUpdates = 0.5
	f:Tag(name, tag)
	
	local leftTag = "[level] [smartclass]"
	local leftName = uf.GetFontString(f, SanieUI.font, 10, nil)
	leftName:SetPoint("BOTTOMLEFT", f.Health, "TOPLEFT", 0, 4)
	leftName:SetJustifyH("LEFT")
	leftName.frequentUpdates = 0.5
	f:Tag(leftName, leftTag)
end

local function setHpStrings(f)
	--local leftHpTag = "[curhp]/[maxhp]"
	local rightHpTag = "[curhp]/[maxhp]"
	
	--local leftHp = uf.GetFontString(f.Health, SanieUI.font, 10, nil)
	--leftHp:SetPoint("LEFT", f.Health, "LEFT", 0, 0)
	--leftHp:SetJustifyH("LEFT")
	--leftHp.frequentUpdates = 0.1
	--f:Tag(leftHp, leftHpTag)
	
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

-- When you register a style with oUF, you pass it a function that basically
-- 'sets' the style.
local function CreateTargetStyle(self)
	self.width = width
	self.height = height
	self.scale = scale
	self.mystyle = "pet"
	uf.SetFrameDimensionsAndPosition(self, "BOTTOM", UIParent, "BOTTOM", xpos, ypos)
	backdrop(self)
	createHealthBar(self)
	createPowerBar(self)
	setNameString(self)
	setHpStrings(self)
	--setPowerString(self)
	self.Health.frequentUpdates = true
    self.Health.colorDisconnected = true
    self.Health.colorHappiness = true
    self.Health.colorClass = true
    self.Health.colorReaction = true
    self.Health.colorHealth = true
	self.Health.bg.multiplier = 0.3
	self.Power.frequentUpdates = true
	self.Power.colorPower = true
	self.Power.bg.multiplier = 0.3
end

oUF:RegisterStyle("PlayerPet", CreateTargetStyle)
oUF:SetActiveStyle("PlayerPet")
oUF:Spawn("pet", "oUF_Sanie_PlayerPetFrame")