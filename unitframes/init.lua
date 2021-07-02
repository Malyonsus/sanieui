-- Initialize the unit frames stuff.
if(SanieUI.debug == true) then
	print("Loading init")
end

SanieUI["unitframes"] = {
	["GetFontString"] = function(frame, name, size, outline)
		local fontString = frame:CreateFontString(nil, "OVERLAY")
		fontString:SetFont(name, size, outline)
		fontString:SetShadowColor(0,0,0,1)
		fontString:SetShadowOffset(1, -1)
		return fontString
	end,
	["SetFrameDimensionsAndPosition"] = function(frame, point, relativeFrame, relativePoint, offx, offy)
		--frame:SetAttribute("initial-height", frame.height)
		--frame:SetAttribute("initial-width", frame.width)
		frame:SetSize(frame.width, frame.height)
		--frame:SetAttribute("initial-scale", frame.scale)
		frame:SetScale(frame.scale)
		frame:SetPoint(point, relativeFrame, relativePoint, offx, offy)
		frame.menu = SanieUI.unitframes.Menu
		frame:RegisterForClicks("AnyUp")
		-- * means 'any' 'type2' means right click, so *type2 means right click with any modifiers.
		frame:SetAttribute("*type2", "menu")
		frame:SetScript("OnEnter", UnitFrame_OnEnter)
		frame:SetScript("OnLeave", UnitFrame_OnLeave)
	end,
	["Menu"] = function(frame)
		local unit = frame.unit:sub(1, -2)
		local cunit = frame.unit:gsub("(.)", string.upper, 1)
		if(unit == "party" or unit == "partypet") then
			ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..frame.id.."DropDown"], "cursor", 0, 0)
		elseif(_G[cunit.."FrameDropDown"]) then
			ToggleDropDownMenu(1, nil, _G[cunit.."FrameDropDown"], "cursor", 0, 0)
		end
	end,
	["bartexture"] = "Interface\\AddOns\\SanieUI\\textures\\Gloss.tga",
	["backdropmargin"] = 2,
	-- Unit frame data
	-- x and y positions are anchored to the bottom center of UI parent
	-- and reference the bottom center of the unit frame.
	["player"] = {
		["height"] = 29.75,
		["width"] = 238,
		["hpweight"] = 7,
		["ppweight"] = 2,
		["spweight"] = 3, -- weight of holypower/soulshards/eclipse
		["spgap"] = 3, -- pixel gap of individual bars
		["scale"] = 1,
		["xpos"] = -335, -- Relative to the bottom center of the screen
		["ypos"] = 100, -- Relative to the bottom center of the screen
	},
	["pet"] = {
		["height"] = 29.75,
		["width"] = 178.5,
		["hpweight"] = 7,
		["ppweight"] = 2,
		["scale"] = 1,
		["xpos"] = -335,
		["ypos"] = 23,
	},
	["target"] = {
		["height"] = 29.75,
		["width"] = 238,
		["hpweight"] = 7,
		["ppweight"] = 2,
		["scale"] = 1,
		["xpos"] = 335,
		["ypos"] = 100,
	},
	["targettarget"] = {
		["height"] = 29.75,
		["width"] = 178.5,
		["hpweight"] = 7,
		["ppweight"] = 2,
		["scale"] = 1,
		["xpos"] = 242,
		["ypos"] = 23,
	}
}