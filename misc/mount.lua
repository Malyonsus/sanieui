--[[
Figuring out what kind of mount each mount is is kind of an
interesting problem. As of 4.0.3 beta, blizzard provides no
API call to tell whether a mount is land or flying, though
the range of checks simplified with the auto-scaling change
and complicated by the fact that the standard tooltip no
longer states "Can only be used in Northrend or Outland"
--]]

if(SanieUI.debug) then
	print("Loading mount functions")
end

local scalingStrings = {
	"celestial steed",
	"invincible",
	"headless horseman's mount",
	"tyrael's charger",
}

local flyingStrings = {
	"drake", -- Drakes and protodrakes
	"wind", -- wind riders
	"gryph", -- hippogryphs and gryphons
	"wyrm", -- frostwyrms
	"flying", -- flying carpet, flying machine
	"phoenix", -- I think this might just be the totally unique peep phoenix
	"al'ar", -- Ashes of Al'ar
	"vanquisher", -- pvp arena mounts
	"rocket", -- Some goblin things, love rocket (wink), etc
	"dragonhawk",
}

local swimmingStrings = {
	"seahorse", -- Abyssal Seahorse
}

local qirajiStrings = {
	-- We want to match everything with qiraji that is not preceeded by "black" or "ultramarine"
	-- This would be easy with zero-width negative lookbehind, but Lua doesn't do that "(?<!black)"
	"blue qiraji",
	"green qiraji",
	"red qiraji",
	"yellow qiraji",
}

local isMatch = function(name, mountTable)
	local lname = name:lower()
	for _, match in ipairs(mountTable) do
		if lname:find(match, 1, true) then
			return true
		end
	end
	return false
end

local loadMounts = function()
	-- Reset mount tables.
	SanieUI.mount.scaling = {}
	SanieUI.mount.flying = {}
	SanieUI.mount.swimming = {}
	SanieUI.mount.running = {}
	SanieUI.mount.qiraji = {}
	local numMounts = GetNumCompanions("MOUNT")
	for i=1,numMounts do
		local _, name = GetCompanionInfo("MOUNT", i)
		if(isMatch(name, scalingStrings)) then
			SanieUI.mount.scaling[#SanieUI.mount.scaling + 1] = i
		elseif(isMatch(name, flyingStrings)) then
			SanieUI.mount.flying[#SanieUI.mount.flying + 1] = i
		elseif(isMatch(name, swimmingStrings)) then
			SanieUI.mount.swimming[#SanieUI.mount.swimming + 1] = i
		elseif(isMatch(name, qirajiStrings)) then
			SanieUI.mount.qiraji[#SanieUI.mount.qiraji + 1] = i
		else
			SanieUI.mount.running[#SanieUI.mount.running + 1] = i
		end
	end
	--[[
	print("Size of scaling table is", #SanieUI.mount.scaling)
	print("Size of flying table is", #SanieUI.mount.flying)
	print("Size of swimming table is", #SanieUI.mount.swimming)
	print("Size of qiraji table is", #SanieUI.mount.qiraji)
	print("Size of running table is", #SanieUI.mount.running)
	--]]
end

-- Return the mount type we want for the zone we're currently in.
local getMountType = function()
	local canFly = IsFlyableArea()
	-- There's an issue here, in that wintergrasp when a battle is going is
	-- not flyable, but returns 1 nevertheless.
	local zone = GetZoneText()
	local subzone = GetSubZoneText()
	if(zone == "Wintergrasp" and not GetWintergraspWaitTime()) then
		-- Special wintergrasp case
		return "running"
	end
	
	if(zone == "Throne of the Four Winds") then
		return "running"
	end
	
	if(subzone == "Nespirah") then
		return "running"
	end
	
	if((zone == "Abyssal Depths" or zone == "Shimmering Expanse" or zone == "Kelp'thar Forest" or zone == "Damplight Chamber" or zone == "Ruins of Vashj'ir") and IsSwimming()) then
		-- Vashj'ir case
		return "swimming"
	end
	
	if(canFly) then
		return "flying"
	else
		return "running"
	end
end

SanieUI["mount"] = {
	["RandomMount"] = function(mountType)
		local mountReal = GetNumCompanions("MOUNT")
		local mountScanned = #SanieUI.mount.scaling + #SanieUI.mount.flying + #SanieUI.mount.swimming + #SanieUI.mount.qiraji + #SanieUI.mount.running
		if mountReal ~= mountScanned then
			loadMounts()
		end
		--set mount type if it is nil.
		mountType = mountType or getMountType()
		local mountTable = SanieUI.mount[mountType]
		local scaleTable = SanieUI.mount.scaling
		if not mountTable then
			print("Invalid mount type supplied:", mountType)
			return
		end
		numScale = #scaleTable
		numChosen = #mountTable
		
		
		if(mountType ~= "swimming") then
			numTotal = numScale + numChosen
		else
			numTotal = numChosen
		end
		
		if numTotal == 0 then
			print("No mounts found for type:", mountType)
			return
		end
		choice = math.random(numTotal)
		if(choice <= numChosen) then
			if IsOutdoors() then
				CallCompanion("MOUNT", mountTable[choice])
			end
		else
			if IsOutdoors() then
				CallCompanion("MOUNT", scaleTable[choice - numChosen])
			end
		end
	end,
	["LoadMounts"] = loadMounts,
	["ListMounts"] = function(tableName)
		tableName = tableName or getMountType()
		for i, name in ipairs(SanieUI.mount[tableName]) do
			print(i, name)
		end
	end,
}

loadMounts()