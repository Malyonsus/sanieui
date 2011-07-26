local lib = SanieUI.lib
local textString
local textColor

--[[---------------------------
Datatext Constants
--]]----------------------------
-- Set name
local name = "FPS"
-- Set update frequency in seconds. Set to nil for event-only updating.
local updateFrequency = 0.5
-- Font
local font = SanieUI.font
-- Font size
local textSize = 12

--[[----------------------------
Datatext functions
--]]----------------------------
-- This function returns the text value and r, g, b, a. If any of r,g,b,a are nil, will use solid white.
local textValues = function(frame, event, ...)
	return format("%.1f", GetFramerate())
end

--[[----------------------------
Datatext events
--]]----------------------------
local events = {
	"PLAYER_ENTERING_WORLD", -- You almost certainly want to keep this
}

--[[----------------------------
Datatext anchors
--]]----------------------------
local anchors = {
	[1] = { anchor = "BOTTOMLEFT",
			relative = "UIParent",
			relativeAnchor = "BOTTOMLEFT",
			x = 3,
			y = 3,
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
	text:SetPoint(anchor.anchor, anchor.relative, anchor.relativeAnchor, x, y)
end

textFrame:SetAllPoints(text)