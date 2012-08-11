--[[
Initializes internal variables.
You probably do not want to modify this!
--]]

-- Get and store the resolution of the main window.
local res = select(GetCurrentResolution(), GetScreenResolutions())
-- res contains a string that is something like, oh, "800x600"
local x, y = string.split("x", res)
SanieUI["resolution"] = {
	["width"] = tonumber(x),
	["height"] = tonumber(y)
}

SanieUI["lib"] = {}

-- Create, colorize, and return a money string.
SanieUI.lib.colorMoney = function(coppers)
	local gold = floor(coppers / 10000)
	local remaining = coppers % 10000
	local silver = floor(remaining / 100)
	remaining = coppers % 100
	local cop = remaining
	local moneyString = ""
	if(gold > 0) then
		moneyString = moneyString .. "|cFFFFFF32"..gold.."|r."
	end
	if(silver > 0 or gold > 0) then
		moneyString = moneyString .. "|cFFE6E8FA"..silver.."|r."
	end
	moneyString = moneyString .. "|cFFB87333"..cop.."|r"
	--moneyString = "|cFFFFFF32"..gold.."|r.|cFFE6E8FA"..silver.."|r.|cFFB87333"..cop.."|r"

	return moneyString
end	

-- Add an event handler to a frame without messing with other hooks.
SanieUI.lib.SetOrHookScript = function(frame, event, func)
	if(frame:GetScript(event)) then
		frame:HookScript(event, func)
	else
		frame:SetScript(event, func)
	end
end

-- Return the class color as a three variable return in r,g,b order
-- Return black if nonsense.
SanieUI.lib.classColor = function(unit)
	local u = strupper(unit)
	local colors = RAID_CLASS_COLORS[u]

	if colors ~= nil then
		return colors["r"], colors["g"], colors["b"]
	else
		return 0,0,0
	end
end

SanieUI.lib.buffCount = function()
	local count = 0;
	for i = 1,40 do
		local n = UnitBuff("player", i);
		if n then count = count + 1 end
	end
	return count;
end

SanieUI.lib.colorToTextCode = function(r, g, b, a)

	a = a or 1

	red = math.ceil(r * 255)
	green = math.ceil(g * 255)
	blue = math.ceil(b * 255)
	alpha = math.ceil(a * 255)
	
	if red > 255 then red = 255 end
	if green > 255 then green = 255 end
	if blue > 255 then blue = 255 end
	if alpha > 255 then alpha = 255 end
	
	if red < 0 then red = 0 end
	if green < 0 then green = 0 end
	if blue < 0 then blue = 0 end
	if alpha < 0 then alpha = 0 end
	
	return string.format("|c%02x%02x%02x%02x", alpha, red, green, blue)
end

SanieUI.lib.questDifficultyColor = function(difficulty)
	local d = strlower(difficulty)
	local color = QuestDifficultyColors[d]
	
	if d ~= nil then
		return color.r, color.g, color.b
	else
		return 0,0,0
	end
end

SanieUI.lib.colors = {}
	
