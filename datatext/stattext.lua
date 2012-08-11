local lib = SanieUI.lib
local textString
local textColor

--[[---------------------------
Datatext Constants
--]]----------------------------
-- Set name
local name = "StatText"
-- Set update frequency in seconds. Set to nil for event-only updating.
local updateFrequency = nil
-- Font
local font = SanieUI.font
-- Font size
local textSize = 12

local classFunctions = {}
local rapidUpdate = nil

--[[----------------------------
Datatext functions
--]]----------------------------


-- This function returns the text value and r, g, b, a. If any of r,g,b,a are nil, will use solid white.
-- You can also always use the |cAARRGGBBText|r format inline, too
local textValues = function(frame, event, ...)
	local _, class = UnitClass("player")
	
	if classFunctions[class] then
		return classFunctions[class]()
	else
		return classFunctions.DEFAULT()
	end
end

classFunctions.DEFAULT = function()
	return "No StatText Function for your class!"
end

classFunctions.PALADIN = function()
	local block = GetBlockChance()
	local dodge = GetDodgeChance()
	local parry = GetParryChance()
	local miss = 5
	local ctc = block + dodge + parry + miss
	local avg = 0.36666*block + dodge + parry + miss
	
	local text = format("CTC: %.2f%% | AVG: %.2f%%", ctc, avg)
	return text
end

classFunctions.HUNTER = function()
	local base, neg, pos = UnitRangedAttackPower("player")
	return "RAP: "..(base + neg + pos)
end

classFunctions.WARLOCK = function()
	local spellpower = GetSpellBonusDamage(6)
	return "SP: "..spellpower
end

classFunctions.ROGUE = function()
	local base, neg, pos = UnitAttackPower("player")
	return "AP: "..(base + neg + pos)
end
	
	
--[[----------------------------
Datatext events
--]]----------------------------
local events = {
	"PLAYER_ENTERING_WORLD", -- You almost certainly want to keep this
	"UNIT_AURA",
	"ACTIVE_TALENT_GROUP_CHANGED",
	"PLAYER_LEVEL_UP",
	"UNIT_INVENTORY_CHANGED",
}

--[[----------------------------
Datatext anchors
--]]----------------------------
local anchors = {
	[1] = { anchor = "TOP",
			relative = "UIParent",
			relativeAnchor = "TOP",
			x = 0,
			y = -3,
    	  },
}



--[[
If I've done my job right, nothing below here needs to be edited.
--]]

local textFrame = CreateFrame("Frame", name.."Frame", UIParent)
textFrame.timeElapsed = 0
local text = textFrame:CreateFontString(name, "OVERLAY")
text:SetShadowOffset(1,-1)
text:SetShadowColor(0,0,0)
text:SetFont(font, textSize)

local changeUpdateRate = function(rate)
	if rate then
		textFrame:SetScript("OnUpdate", heartbeat)
	else
		textFrame:SetScript("OnUpdate", nil)
	end
end

local update = function(self, event, ...)
--[[
	if rapidUpdate and event == "OnUpdate" then
		print("update rate reset")
		rapidUpdate = nil
		changeUpdateRate(updateFrequency)
	end

	if event ~= "OnUpdate" then
		print("update rate modified")
		changeUpdateRate(0.1)
		rapidUpdate = 1
	end
--]]
	local textString, r, g, b, a = textValues(self, event, ...)
	
	text:SetText(textString)
	
	if r and g and b and a then 
		text:SetTextColor(r, g, b, a)
	else
		text:SetTextColor(1,1,1,1)
	end
	
	self:SetAllPoints(text)
end

local heartbeat = function(self, elapsed)
	self.timeElapsed = self.timeElapsed + elapsed
	
	if self.timeElapsed >= updateFrequency then
		update(self, "OnUpdate")
		self.timeElapsed = 0
	end
end


-- Register the events we're listening for reasons to update.
for i, v in ipairs(events) do
	textFrame:RegisterEvent(v)
end

textFrame:SetScript("OnEvent", update)

if updateFrequency then
	textFrame:SetScript("OnUpdate", heartbeat)
end

for i, anchor in ipairs(anchors) do
	text:SetPoint(anchor.anchor, anchor.relative, anchor.relativeAnchor, anchor.x, anchor.y)
end

textFrame:SetAllPoints(text)