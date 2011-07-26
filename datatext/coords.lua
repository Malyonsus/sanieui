local lib = SanieUI.lib
local textString
local textColor

local facingColorCrossfade = function(val)
	-- transitions from full green at 1 to white at 0 to red at -1
	if val >= 0 then
		return 1-val, 1, 1-val
	else
		return 1, 1+val, 1+val
	end
end

--[[---------------------------
Datatext Constants
--]]----------------------------
-- Set name
local name = "Coords"
-- Set update frequency in seconds. Set to nil for event-only updating.
local updateFrequency = 0.1
-- Font
local font = SanieUI.font
-- Font size
local textSize = 10

--[[----------------------------
Datatext functions
--]]----------------------------
-- This function returns the text value and r, g, b, a. If any of r,g,b,a are nil, will use solid white.
-- You can also always use the |cAARRGGBBText|r format inline, too
local textValues = function(frame, event, ...)
	local heading = GetPlayerFacing()
	-- Player facing starts at 0 facing north and increases counter-clockwise by radians.
	-- This is the unitcircle minus .5pi radians.
	local x, y = GetPlayerMapPosition("player")
	
	heading = heading + (0.5 * math.pi)
	-- now heading is an angle on the unit circle, and I can rely on
	-- normal unit circle calculations for facing.
	local southness, eastness = -math.sin(heading), math.cos(heading)
	-- 1 is due south, 1 is due east, -1 is due north, -1 is due west.
	-- the sine negation is important because positive y is south, but heading was calculated as though positive y is north.
	local xColorCode = lib.colorToTextCode(facingColorCrossfade(eastness))
	local yColorCode = lib.colorToTextCode(facingColorCrossfade(southness))
	
	local textString = format("%s%.2f|r, %s%.2f|r", xColorCode, x * 100, yColorCode, y * 100)
	
	return textString
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
	[1] = { anchor = "TOPRIGHT",
			relative = "SanieZoneTextFrame",
			relativeAnchor = "BOTTOMRIGHT",
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