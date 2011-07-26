local lib = SanieUI.lib

local zoneName = CreateFrame("Frame", "SanieZoneTextFrame", UIParent)
local text = zoneName:CreateFontString("SanieZoneText", "OVERLAY")
text:SetFont("Fonts\\ARIALN.TTF", 25)
text:SetShadowOffset(1,-1)
text:SetShadowColor(0,0,0)

local zoneColor = function(pvpType)
	if pvpType == "sanctuary" then
		return 0.4, 0.8, 0.95
	elseif pvpType == "friendly" then
		return 0.1, 1.0, 0.1
	elseif pvpType == "contested" then
		return 1.0, 0.7, 0.0
	elseif pvpType == "hostile" then
		return 1.0, 0.1, 0.1
	elseif pvpType == "arena" then
		return 1.0, 0.1, 0.1
	else
		return 1.0, 0.9, 0.75
	end
end

local update = function(self)
	local subzone = GetSubZoneText()
	local zone = GetRealZoneText()
	if not subzone or subzone == "" then
		text:SetText(zone)
	else
		text:SetText(subzone)
	end
	text:SetTextColor(zoneColor(GetZonePVPInfo()))
	self:SetAllPoints(text)
end

zoneName:RegisterEvent("PLAYER_ENTERING_WORLD")
zoneName:RegisterEvent("ZONE_CHANGED")
zoneName:RegisterEvent("ZONE_CHANGED_INDOORS")
zoneName:RegisterEvent("ZONE_CHANGED_NEW_AREA")
zoneName:SetScript("OnEvent", update)

text:SetPoint("TOPRIGHT", "Minimap", "TOPLEFT", -10, 0)
text:SetPoint("BOTTOMRIGHT", "Minimap", "TOPRIGHT", -10, -20)
zoneName:SetAllPoints(text)
