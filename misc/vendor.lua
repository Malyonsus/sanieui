-- Some vendor stuff.
if(SanieUI.debug) then
	print("Loading vendor.lua")
end

local mFrame = CreateFrame("Frame")

local lib = SanieUI.lib
local isDebug = SanieUI.debug

local sellGreys = function()
	-- As of 4.0.1, 0 is the backpack, 1 - NUM_BAG_SLOTS are the bags
	-- -1 is the bank WHEN OPEN, NUM_BAG_SLOTS + 1 to NUM_BAG_SLOTS + NUM_BANKBAGSLOTS are
	-- the bank bag slots.
	if(isDebug) then print("Autosell called") end
	local totalGold = 0
	local sold = 0;
	for bagId=0,NUM_BAG_SLOTS do
		local slotsInBag = GetContainerNumSlots(bagId)
		for slotNum = 1, slotsInBag do
			local _, count, _, quality, _ = GetContainerItemInfo(bagId, slotNum)
			local itemId = GetContainerItemID(bagId, slotNum)
			if(itemId) then
				local name, link, rarity, ilevel, _, _, _, _, _, _, sellPrice = GetItemInfo(itemId)
				if(rarity == 0) then
					local cost = sellPrice * count
					if(cost > 0) then
						sold = sold + 1
						totalGold = totalGold + cost
						UseContainerItem(bagId, slotNum)
						PickupMerchantItem()
						if(count < 2) then
							print("Sold", link, "for", lib.colorMoney(cost))
						else
							print("Sold", link.."x"..count, "for", lib.colorMoney(cost))
						end
					end
				end
			end
		end
	end
	if(sold > 0) then
		print("----")
		print("Sold all greys for a total of", lib.colorMoney(totalGold))
	end
end

local autoRepair = function(frame, event, ...)
	if(isDebug) then print("Autorepair called") end
	if(CanMerchantRepair()) then
		local cost, doable = GetRepairAllCost()
		if(cost > 0 and doable) then
			RepairAllItems(1)
			print("Repaired all items at a cost of", lib.colorMoney(cost))
		elseif(cost > 0 and not doable) then
			print("Insufficient funds to repair at cost of", lib.colorMoney(cost))
		end
	end
end	

if(SanieUI.sellgreys) then
	mFrame:RegisterEvent("MERCHANT_SHOW")
	lib.SetOrHookScript(mFrame, "OnEvent", sellGreys)
end

if(SanieUI.autorepair) then
	mFrame:RegisterEvent("MERCHANT_SHOW")
	lib.SetOrHookScript(mFrame, "OnEvent", autoRepair)
end