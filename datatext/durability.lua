local lib = SanieUI.lib
local textString
local textColor


local slots = {
	"HeadSlot",
	"NeckSlot",
	"ShoulderSlot",
	"BackSlot",
	"ChestSlot",
	"ShirtSlot",
	"TabardSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	"Finger0Slot",
	"Finger1Slot",
	"Trinket0Slot",
	"Trinket1Slot",
	"MainHandSlot",
	"SecondaryHandSlot",
	"RangedSlot",
}
--[[---------------------------
Datatext Constants
--]]----------------------------
-- Set name
local name = "SanieDurability"
-- Set update frequency in seconds. Set to nil for event-only updating.
local updateFrequency = nil
-- Font
local font = SanieUI.font
-- Font size
local textSize = 12

--[[----------------------------
Datatext functions
--]]----------------------------
-- This function returns the text value and r, g, b, a. If any of r,g,b,a are nil, will use solid white.
-- You can also always use the |cAARRGGBBText|r format inline, too
local textValues = function(frame, event, ...)
	local allDur, allTotal = 0, 0
	for _,v in ipairs(slots) do
		local slotNum = GetInventorySlotInfo(v)
		local dur, tot = GetInventoryItemDurability(slotNum)
		if dur then allDur = allDur + dur end
		if tot then allTotal = allTotal + tot end
	end
	
	local ratio = allDur * 100 / allTotal
	return format("%.0f%%", ratio)
end

--[[----------------------------
Datatext events
--]]----------------------------
local events = {
	"PLAYER_ENTERING_WORLD", -- You almost certainly want to keep this
	"UPDATE_INVENTORY_DURABILITY",
	"UNIT_INVENTORY_CHANGED",
}

--[[----------------------------
Datatext anchors
--]]----------------------------
local anchors = {
	[1] = { anchor = "TOPRIGHT",
			relative = "BagspaceFrame",
			relativeAnchor = "TOPLEFT",
			x = -10,
			y = 0,
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


local update = function(self, event, ...)

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