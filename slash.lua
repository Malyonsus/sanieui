--[[
Register slash commands. Do this last because these functions
all call other functions that need to be defined first.
--]]
SLASH_RELOAD_UI1 = "/rl"
-- For convenience
SlashCmdList["RELOAD_UI"] = function(msg)
	ReloadUI()
end

SLASH_SANIEUI1 = "/sanie"
SLASH_SANIEUI2 = "/sanieui"
SlashCmdList["SANIEUI"] = function(msg)
	--print("Ran the sanie slash command")
	a,b,c = string.split(" ", msg)
	if a == "mount" then
		if IsMounted() then
			Dismount()
		else
			SanieUI.mount.RandomMount(b)
		end
	end
end