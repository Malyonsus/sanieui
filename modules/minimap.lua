lib = SanieUI.lib

local margin = 20
local r, g, b = lib.classColor(select(2, UnitClass("player")))

MinimapBorder:Hide()
MinimapBorderTop:Hide()
Minimap:SetMaskTexture([=[Interface\ChatFrame\ChatFrameBackground]=])

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -0.5 * margin, -1.5 * margin)

local MinimapWrapper = CreateFrame("Frame", "MinimapWrapper", UIParent)
MinimapWrapper:SetFrameStrata("BACKGROUND")
MinimapWrapper.texture = MinimapWrapper:CreateTexture()
MinimapWrapper.texture:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", -1, 1)
MinimapWrapper.texture:SetPoint("BOTTOMRIGHT", "Minimap", "BOTTOMRIGHT", 1, -1)
MinimapWrapper.texture:SetColorTexture(r,g,b)

MinimapNorthTag:Hide()
MinimapZoneText:Hide()
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
-- MiniMapVoiceChatFrame:Hide()
MiniMapTracking:Hide()
GameTimeFrame:Hide()
MiniMapMailFrame:Hide()
MiniMapMailIcon:Hide()
MiniMapMailBorder:Hide()
--MiniMapBattlefieldFrame:Hide() No longer exists?
MiniMapWorldMapButton:Hide()
MinimapZoneTextButton:Hide()

Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- Anonymous frame for hiding the clock
local f = CreateFrame("Frame", nil, UIParent)
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, e, n)
	if n == "Blizzard_TimeManager" then
		TimeManagerClockButton:Hide()
		TimeManagerClockButton:SetScript("OnShow", function(self)
			TimeManagerClockButton:Hide()
		end)
	end
end)

-- Set right click tracking
Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == "RightButton" then
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self)
	end
end)
