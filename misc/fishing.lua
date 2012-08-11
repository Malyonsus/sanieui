--[[-----------------------------------------------
	Doubleclick mod
	This mod creates a button that activates on
	double middle clicks.
-------------------------------------------------

local lib = SanieUI.lib

-- The frame to hook events to.
local fishingLogic = CreateFrame("Frame")


fishingLogic.activeMode = 0
fishingLogic.eventTable = {}

fishingLogic.modes = {
	"archaeology",
	"fishing",
}

fishingLogic.eventTable.UNIT_INVENTORY_CHANGED = function(unitID, ...)
	-- passes in the arguments: unitname (player)
	if( unitID ~= "player" ) then
		return;
	end
	
	-- We don't actually have to check for the pole.
	-- We just need to see if fishing is a useable spell.
	local isFishing = IsUsableSpell("Fishing")
	
	if(not isFishing) then
		mode = 0;
	else
		mode = 1;
	end
	
end

fishingLogic.eventHandler = function(self, event, ...)
	fishingLogic.eventTable[event](...)
end


-- Register events we care about.
fishingLogic:RegisterEvent("UNIT_INVENTORY_CHANGED")
fishingLogic:SetScript("OnEvent", fishingLogic.eventHandler)

--]]