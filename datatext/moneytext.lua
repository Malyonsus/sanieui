local lib = SanieUI.lib

local textFrame = CreateFrame("Frame", "MoneyTextFrame", UIParent)
local text = textFrame:CreateFontString("MoneyText", "OVERLAY")
text:SetFont("Fonts\\ARIALN.TTF", 10)
text:SetShadowOffset(1,-1)
text:SetShadowColor(0,0,0)


local update = function(self)
	text:SetText(lib.colorMoney(GetMoney()))
	self:SetAllPoints(text)
end

textFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
textFrame:RegisterEvent("PLAYER_MONEY")
textFrame:SetScript("OnEvent", update)

--text:SetPoint("TOPRIGHT", "Minimap", "TOPLEFT", -10, 0)
text:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -2, 2)
textFrame:SetAllPoints(text)
