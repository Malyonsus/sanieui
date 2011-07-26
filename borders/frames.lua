local edgeWidth = 20
local r,g,b = SanieUI.lib.classColor(select(2,UnitClass("player")))

local height = GetScreenHeight()
local width = GetScreenWidth()

-- Left Edge
local leftEdge = CreateFrame("Frame", "leftEdge", UIParent)
leftEdge:SetFrameStrata("BACKGROUND")
leftEdge:SetWidth(1)
leftEdge:SetScale(1.0)
leftEdge:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", edgeWidth, -edgeWidth)
leftEdge:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", edgeWidth, edgeWidth)

leftEdge.texture = leftEdge:CreateTexture()
leftEdge.texture:SetAllPoints(leftEdge)
leftEdge.texture:SetTexture(r,g,b)

-- Right Edge
local rightEdge = CreateFrame("Frame", "rightEdge", UIParent)
rightEdge:SetFrameStrata("BACKGROUND")
rightEdge:SetWidth(1)
rightEdge:SetScale(1.0)
rightEdge:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -edgeWidth, -edgeWidth)
rightEdge:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -edgeWidth, edgeWidth)

rightEdge.texture = rightEdge:CreateTexture()
rightEdge.texture:SetAllPoints(rightEdge)
rightEdge.texture:SetTexture(r,g,b)

-- Bottom Edge
local bottomEdge = CreateFrame("Frame", "bottomEdge", UIParent)
bottomEdge:SetFrameStrata("BACKGROUND")
bottomEdge:SetHeight(1)
bottomEdge:SetScale(1.0)
bottomEdge:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", edgeWidth, edgeWidth)
bottomEdge:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -edgeWidth, -edgeWidth)

bottomEdge.texture = bottomEdge:CreateTexture()
bottomEdge.texture:SetAllPoints(bottomEdge)
bottomEdge.texture:SetTexture(r,g,b)

-- Top Left Gradient
local topLeftGradient = CreateFrame("Frame", "topLeftGradient", UIParent)
topLeftGradient:SetFrameStrata("BACKGROUND")
topLeftGradient:SetHeight(1)
topLeftGradient:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 0, -edgeWidth)
topLeftGradient:SetPoint("TOPRIGHT", "UIParent", "TOPLEFT", width/3, -edgeWidth)

topLeftGradient.texture = topLeftGradient:CreateTexture()
topLeftGradient.texture:SetAllPoints(topLeftGradient)
topLeftGradient.texture:SetTexture(r,g,b)
topLeftGradient.texture:SetGradientAlpha("HORIZONTAL", 1,1,1,1,1,1,1,0)

-- Top Right Gradient
local topRightGradient = CreateFrame("Frame", "topRightGradient", UIParent)
topRightGradient:SetFrameStrata("BACKGROUND")
topRightGradient:SetHeight(1)
topRightGradient:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", 0, -edgeWidth)
topRightGradient:SetPoint("TOPLEFT", "UIParent", "TOPRIGHT", -width/3, -edgeWidth)

topRightGradient.texture = topLeftGradient:CreateTexture()
topRightGradient.texture:SetAllPoints(topRightGradient)
topRightGradient.texture:SetTexture(r,g,b)
topRightGradient.texture:SetGradientAlpha("HORIZONTAL", 1,1,1,0,1,1,1,1) 

print("Loaded!")