if(SanieUI.debug == true) then
	print("Loading target frame data")
end

local uf = SanieUI.unitframes

local height = uf.target.height
local width = uf.target.width
local scale = uf.target.scale
local texture = uf.bartexture
local xpos = uf.target.xpos
local ypos = uf.target.ypos
local backdropmargin = uf.backdropmargin

local hpweight = uf.target.hpweight
local ppweight = uf.target.ppweight

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
	name:SetPoint("BOTTOMLEFT", f.Health, "TOPLEFT", 0, 4)
	name:SetJustifyH("LEFT")
	f:Tag(name, tag)
	
	local leftTag = "[smartlevel] [race] [smartclass]"
	local leftName = uf.GetFontString(f, SanieUI.font, 10, nil)
	leftName:SetPoint("BOTTOMRIGHT", f.Health, "TOPRIGHT", 0, 4)
	leftName:SetJustifyH("RIGHT")
	f:Tag(leftName, leftTag)
end

local function setHpStrings(f)
	local leftHpTag = "[perhp]%"
	local rightHpTag = "[curhp]/[maxhp]"
	
	local leftHp = uf.GetFontString(f.Health, SanieUI.font, 10, nil)
	leftHp:SetPoint("LEFT", f.Health, "LEFT", 0, 0)
	leftHp:SetJustifyH("LEFT")
	f:Tag(leftHp, leftHpTag)
	
	local rightHp = uf.GetFontString(f.Health, SanieUI.font, 10, nil)
	rightHp:SetPoint("RIGHT", f.Health, "RIGHT", 0, 0)
	rightHp:SetJustifyH("RIGHT")
	f:Tag(rightHp, rightHpTag)
end

local function setPowerString(f)
	local ppTag = "[curpp]/[maxpp]"
	local pp = uf.GetFontString(f.Power, SanieUI.font, 10, nil)
	pp:SetPoint("LEFT", f.Power, "LEFT", 0, 0)
	pp:SetJustifyH("LEFT")
	f:Tag(pp, ppTag)
end

-- When you register a style with oUF, you pass it a function that basically
-- 'sets' the style.
local function CreateTargetStyle(self)
	self.width = width
	self.height = height
	self.scale = scale
	self.mystyle = "target"
	uf.SetFrameDimensionsAndPosition(self, "BOTTOM", UIParent, "BOTTOM", xpos, ypos)
	backdrop(self)
	createHealthBar(self)
	createPowerBar(self)
	setNameString(self)
	setHpStrings(self)
	--setPowerString(self)
	self.Health.frequentUpdates = true
	self.Health.colorTapping = true
	self.Health.colorDisconnected = true
    self.Health.colorClass = true
    self.Health.colorReaction = true
	self.Health.bg.multiplier = 0.3
	self.Power.colorPower = true
	self.Power.bg.multiplier = 0.3
	self.Power.frequentUpdates = true
end

oUF:RegisterStyle("Target", CreateTargetStyle)
oUF:SetActiveStyle("Target")
oUF:Spawn("target", "oUF_Sanie_TargetFrame")