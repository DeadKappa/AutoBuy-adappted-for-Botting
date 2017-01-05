--[[
	Auto Buy Items
	Build Path modified and adjusted for league season 7
]]

-- BUG: Upong buying the last item, tries to buy 'other' items and produces error as no other index in array

if GetMyHero().charName == "Soraka" then

	--[[ Config ]]
	PrintChat("Support Items Loaded: Soraka, for Season 7 :D")
	shopList = {1004, 3096, 1006 , 1031, 2053, 3069, 1027, 1028, 3010, 1026, 3027, 3105, 3190, 1028 , 3211,  3065, 1058, 1026, 3089}
	--item ids can be found at many websites, ie: http://www.lolking.net/items/1004

	nextbuyIndex = 1
	wardBought = 0
	firstBought = false
	lastBuy = 0
	boughtalready = 1
	
	buyDelay = 500 --default 100

	--[[ Code ]]

	function OnTick()
		if firstBought == false and GetTickCount() - startingTime > 2000 then
			BuyItem(3301) -- Ancient Coin
			BuyItem(2003)
			BuyItem(2003)
			BuyItem(2003) -- Health Potion
			BuyItem(3340) -- warding totem (trinket)
			firstBought = true
		end

		-- Run buy code only if in fountain
		if InFountain() and firstBought == true then
			-- Item purchases
			if GetTickCount() - startingTime > 5000 then	
				if GetTickCount() > lastBuy + buyDelay then
					if GetInventorySlotItem(shopList[nextbuyIndex]) ~= nil then
						--Last Buy successful
						nextbuyIndex = nextbuyIndex + 1
					else
						--Last Buy unsuccessful (buy again)
						BuyItem(shopList[nextbuyIndex])
						lastBuy = GetTickCount()
					end
				end
			end
			-- Continuous Pot purchases
			if GetInventorySlotItem(2003) == nil and boughtalready == 1 then
				BuyItem(2003) -- Health Potion
				BuyItem(2003)
				boughtalready = 0
			end
		else
		boughtalready = 1
		end
	end


	function OnLoad()
		if GetInventorySlotIsEmpty(ITEM_1) == false then
			firstBought = true
		end

		startingTime = GetTickCount()
	end
end