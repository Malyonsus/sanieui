if(SanieUI.debug == true) then
	print("Loading castbar data")
end

local UnitCastingInfo = UnitCastingInfo

local frame = CreateFrame("Frame")

local is_casting = false

local SpellCastingEventsFunctions = {}

local eventHandler = function(self, event, ...)
	SpellCastingEventsFunctions[event](...)
end

SpellCastingEventsFunctions.UNIT_SPELLCAST_SUCCEEDED = function(...)
	local unit, spell, _, _, id = ...
	if(not is_casting) then
		-- A spell finished that wasn't started, it was an instant.
		print("Cast instant", spell, "by", (UnitName(unit)))
	else
		print("Finished casting", spell, "by", (UnitName(unit)))
	end
	is_casting = false
end

SpellCastingEventsFunctions.UNIT_SPELLCAST_START = function(...)
	local unit, spell, _, _, id = ...
	local _, _, dispName, icon, startTime, endTime, trade, _, _ = UnitCastingInfo(unit)
	is_casting = true
	print("Started casting ", spell, "by", UnitName(unit), "for", (endTime - startTime)/1000, "seconds")
end

SpellCastingEventsFunctions.UNIT_SPELLCAST_FAILED = function(...)
	local unit, spell, _, _, id = ...
	if(is_casting) then
		print("Failed casting ", spell, "by", (UnitName(unit)))
	end
	is_casting = false
end

SpellCastingEventsFunctions.UNIT_SPELLCAST_INTERRUPTED = function(...)
	local unit, spell, _, _, id = ...
	if(is_casting) then
		print("Interrupted casting ", spell, "by", (UnitName(unit)))
	end
	is_casting = false
end

-- So casting events are a little weird.
-- Only spells with cast times and are not channeled get a unit_spellcast_start.
-- All spells get a unit_spellcast_failed or unit_spellcast_succeeded
-- Channelled spells have TWO spellcasts. The casting component that triggers the channel
-- and the channel itself. Think of mind control. You cast, then you channel.
--frame:RegisterEvent("UNIT_SPELLCAST_START")
--frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
--frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
--frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
--frame:SetScript("OnEvent", eventHandler)