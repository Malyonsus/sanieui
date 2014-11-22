local lib = SanieUI.lib
local textString
local textColor

--[[---------------------------
Fishing zone no-junk skill table. Data totally ripped off from El's Extreme Anglin' (elsanglin.com)
--]]---------------------------
local zoneSkill = {
	["Blackrock Mountain"] = 1,
	["Burning Steppes"] = 1,
	["Azuremyst Isle"] = 1,
	["Dun Morogh"] = 25,
	["Durotar"] = 25,
	["Elwynn Forest"] = 25,
	["Eversong Woods"] = 25,
	--["Gilneas"] Worgen phase has skill 25
	["The Lost Isles"] = 25,
	["Mulgore"] = 25,
	["Teldrassil"] = 25,
	["Tirisfal Glades"] = 25,
	["Azshara"] = 75,
	["Blackfathom Deeps"] = 75,
	["Bloodmyst Isle"] = 75,
	["Darkshore"] = 75,
	["Darnassus"] = 75,
	["The Deadmines"] = 75,
	["Ghostlands"] = 75,
	["Gilneas"] = 75,
	["Ironforge"] = 75,
	["Loch Modan"] = 75,
	["Northern Barrens"] = 75,
	["Orgrimmar"] = 75,
	["Redridge Mountains"] = 75,
	["Silverpine Forest"] = 75,
	["Stormwind City"] = 75,
	["Thunder Bluff"] = 75,
	["Undercity"] = 75,
	["The Wailing Caverns"] = 75,
	["Westfall"] = 75,
	["Arathi Highlands"] = 150,
	["Ashenvale"] = 150,
	["Duskwood"] = 150,
	["Hillsbrad Foothills"] = 150,
	["Northern Stranglethorn"] = 150,
	["Stonetalon Mountains"] = 150,
	["Wetlands"] = 150,
	["The Cape of Stranglethorn"] = 225,
	["Desolace"] = 225,
	["Dustwallow Marsh"] = 225,
	["Feralas"] = 225,
	["The Forbidding Sea"] = 225,
	["The Great Sea"] = 225,
	["The Hinterlands"] = 225,
	["Scarlet Monastery"] = 225,
	["Southern Barrens"] = 225,
	["Western Plaguelands"] = 225,
	["Badlands"] = 300,
	["Eastern Plaguelands"] = 300,
	["Felwood"] = 300,
	["Maraudon"] = 300,
	["Moonglade"] = 300,
	["Tanaris"] = 300,
	["The Temple of Atal'Hakkar"] = 300,
	["Thousand Needles"] = 300,
	["Hellfire Peninsula"] = 375,
	["Shadowmoon Valley"] = 375,
	["Un'Goro Crater"] = 375,
	["The Underbog"] = 400,
	["Serpentshrine Cavern"] = 400,
	["Zangarmarsh"] = 400,
	["Blasted Lands"] = 425,
	["Deadwind Pass"] = 425,
	["Dire Maul"] = 425,
	["Scholomance"] = 425,
	["Searing Gorge"] = 425,
	["Silithus"] = 425,
	["Stratholme"] = 425,
	["Swamp of Sorrows"] = 425,
	["Winterspring"] = 425,
	["Zul'aman"] = 425,
	["Isle of Quel'Danas"] = 450,
	["Terokkar Forest"] = 450,
	["Borean Tundra"] = 475,
	["Dragonblight"] = 475,
	["Grizzly Hills"] = 475,
	["Howling Fjord"] = 475,
	["Nagrand"] = 475,
	["Netherstorm"] = 475,
	["Zul'drak"] = 475,
	["Crystalsong Forest"] = 500,
	["Dalaran"] = 525,
	["Sholazar Basin"] = 525,
	["Wintergrasp"] = 525,
	["Deepholm"] = 550,
	["Hrothgar's Landing"] = 550,
	["Icecrown"] = 550,
	["Storm Peaks"] = 550,
	["Ulduar"] = 550,
	["The Frozen Sea"] = 575,
	["Mount Hyjal"] = 575,
	["Vash'jir"] = 575,
	["The Ruby Sanctum"] = 650,
	["Twilight Highlands"] = 650,
	["Uldum"] = 650,
	["Tol Barad"] = 675,
	-- MOP
	["Dread Wastes"] = 625,
	["The Jade Forest"] = 650,
	["Krasarang Wilds"] = 700,
	["Valley of the Four Winds"] = 700,
	["Townlong Steppes"] = 725,
	["Kun-Lai Summit"] = 750,
	["The Veiled Stair"] = 750,
	["Vale of Eternal Blossoms"] = 825,
}	

local subzoneSkill = {
	["Throne of Flame"] = 1,
	["Cannon's Inferno"] = 1,
	["Fire Plume Ridge"] = 1,
	["Sunveil Excursion"] = 25,
	["The Tainted Forest"] = 25,
	["The Forgotten Pools"] = 100,
	["Lushwater Oasis"] = 100,
	["The Stagnant Oasis"] = 100,
	["Lake Everstill"] = 150,
	["Forbidding Sea"] = 225, -- check this name
	["Jagged Reef"] = 300,
	["The Ruined Reaches"] = 300,
	["The Shattered Strand"] = 300,
	["Southridge Beach"] = 300,
	["Verdantis River"] = 300,
	["South Seas"] = 300,
	["Forge Camp: Hate"] = 375,
	["Bay of Storms"] = 425,
	["Jademir Lake"] = 425,
	["Marshlight Lake"] = 450,
	["Sporewind Lake"] = 450,
	["Serpent Lake"] = 450,
	["Lake Sunspring"] = 490,
	["Skysong Lake"] = 490,
	["Blackwind Lake"] = 500,
	["Lake Ere'Noru"] = 500,
	["Lake Jorune"] = 500,
	["Silmyr Lake"] = 500,
	-- MOP
	["Widow's Wall"] = 625,
	["Sha-Touched"] = 625,
}

local draenorZones = {
	"Frostwall",
	"Town Hall",
	"Frostfire Ridge",
	"Ashran",
	"Gorgrond",
	"Nagrand",
	"Shadowmoon Valley",
	"Spires of Arak",
	"Talador",
	"Tanaan Jungle",
	"Warspear"
}

local catchesPerGain = {
	[1] = 1,
	[115] = 2,
	[150] = 3,
	[170] = 4,
	[190] = 5,
	[215] = 6,
	[235] = 7,
	[260] = 8,
	[280] = 9,
	[295] = 12,
	[300] = 9,
	[325] = 10,
	[365] = 11,
	[450] = 9,
	[500] = 10,
}
-- Trivia: 1-525 will take average 3470 catches. I recommend you never calculate how much of your life
-- you spent fishing in WoW if you have 525 fishing skill.

local catchChance = function(mySkill,reqSkill)
	local ratio = mySkill/reqSkill
	return ratio * ratio
end

local inDraenor = function( )
	local zone = GetRealZoneText()
	for _, v in ipairs( draenorZones ) do
		if zone == v then
			return true
		end
	end
	
	return false
	
end

local draenorCatchRates = {
	[0  ] = {100,  0,  0},
	[100] = {100,  0,  0},
	[300] = { 81, 19,  0},
	[525] = { 81, 19,  0},
	[650] = { 33, 66,  0},
	[700] = {  0, 50, 50},
	[950] = {  0,  0,100},
}

--[[---------------------------
Datatext Constants
--]]----------------------------
-- Set name
local name = "FishingText"
-- Set update frequency in seconds. Set to nil for event-only updating.
local updateFrequency = nil
-- Font
local font = SanieUI.font
-- Font size
local textSize = 12

--[[----------------------------
Datatext functions
--]]----------------------------
-- This function returns the text value and r, g, b, a. If any of r,g,b,a are nil, will use solid white.
-- You can also always use the |cAARRGGBBText|r format inline, too
local textValues = function(frame, event, ...)

	local fishingIndex = (select(4, GetProfessions()))

	local skillName, skillRank, skillMaxRank, skillModifier

	local text
	
	if( fishingIndex ) then
		skillName, _, skillRank, skillMaxRank, _, _, _, skillModifier = GetProfessionInfo(fishingIndex)

		local zone, subzone = GetRealZoneText(), GetSubZoneText()
		
		skill = subzoneSkill[subzone] or zoneSkill[zone] or -1
	
		if skill == -1 then
		--print("No skill level found for "..(zone or "nil").." - "..(subzone or "nil"))
			skill = 1 -- sanity catch.
		end

		local effectiveSkill = skillRank + skillModifier
		
		if( inDraenor() ) then
			-- Draenor fishing works differently
			local rates = {97,0,0,0}
			if( draenorCatchRates[effectiveSkill] ) then
				rates = draenorCatchRates[effectiveSkill]
			else
				-- Interpolate
				local lowSkill = 0
				local highSkill = 1000
				for k,v in pairs( draenorCatchRates ) do
					if( k > effectiveSkill and k - effectiveSkill < highSkill - effectiveSkill ) then
						highSkill = k
					elseif( k < effectiveSkill and effectiveSkill - k < effectiveSkill - lowSkill ) then
						lowSkill = k
					end
				end
				
				local lowRates = draenorCatchRates[lowSkill]
				local highRates = draenorCatchRates[highSkill]
				
				-- We're x% of the way to highSkill
				local ratio = (effectiveSkill - lowSkill) / (highSkill - lowSkill)
				local smallRate = lowRates[1] + (highRates[1] - lowRates[1]) * ratio
				local mediumRate = lowRates[2] + (highRates[2] - lowRates[2]) * ratio
				local largeRate = lowRates[3] + (highRates[3] - lowRates[3]) * ratio
				print( effectiveSkill, lowSkill, highSkill, smallRate, mediumRate, largeRate )
				
				text = format("Fishing: %d+%d S: %.2f%%  M: %.2f%%  E: %.2f%%", skillRank, skillModifier, smallRate, mediumRate, largeRate )
				
			end
			
			--if zone == "Frostwall" then
				-- Restrict fish size based on garrison level
			
			
		else 
			local catchPercent = 100 * catchChance(skillRank + skillModifier, skill)
	
			if catchPercent > 100 then catchPercent = 100 end
	
			text = format("Fishing: %d+%d(%d), %.2f%%", skillRank, skillModifier, skill, catchPercent)
		end
	else
		text = "Fishing: No Fishing Skill"
	end
	
	return text
end

--[[----------------------------
Datatext events
--]]----------------------------
local events = {
	"PLAYER_ENTERING_WORLD", -- You almost certainly want to keep this
	"ZONE_CHANGED",
	"ZONE_CHANGED_INDOORS",
	"ZONE_CHANGED_NEW_AREA",
	"CHAT_MSG_SKILL",
	"UNIT_INVENTORY_CHANGED",
}

--[[----------------------------
Datatext anchors
--]]----------------------------
local anchors = {
	[1] = { anchor = "TOPLEFT",
			relative = "UIParent",
			relativeAnchor = "TOPLEFT",
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
