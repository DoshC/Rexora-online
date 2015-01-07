local shop = {}

function onSell(cid, item, subType, amount)
	for _, it in ipairs(items) do
		shop[it.id] = {price = it.sell, name = it.name}
	end
	if getPlayerItemCount(cid, item) >= amount and doPlayerRemoveItem(cid, item, amount) then
		doPlayerAddMoney(cid, amount * shop[item].price)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sold x" .. amount .. " " .. shop[item].name .. " for " .. shop[item].price * amount .. " gold.")
	else
		doPlayerSendCancel(cid, "You do not have that item.")
	end
end
 
function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
	for _, it in ipairs(items) do
		if it.buy then
			shop[it.id] = {price = it.buy, name = it.name}
		end
	end
	if inBackpacks then
		if not getItemInfo(item).stackable then
			local backpacks = math.ceil(amount / 20)
			if not ignoreCap then
				local totalCap = getItemInfo(1988).weight * backpacks
				totalCap = totalCap + (getItemInfo(item).weight * amount)
				if totalCap > getPlayerFreeCap(cid) then
					doPlayerSendCancel(cid, "You do not have enough cap.")
					return true
				end
			end
			local a = amount
			if doPlayerRemoveMoney(cid, (shop[item].price * amount) + (backpacks * 20)) then
				for i = 1, backpacks do
					local cont = doPlayerAddItem(cid, 1988, 1)
					local a2 = 20
					if a < 20 then
						a2 = a
					end
					for k = 1, a2 do
						doAddContainerItem(cont, item, 1)
						a = a - 1
					end
				end
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Bought x" .. amount .. " " .. shop[item].name .. " for " .. shop[item].price * amount + (backpacks * 20) .. " gold.")
			else
				doPlayerSendCancel(cid, "You do not have enough money.")
				return true
			end
		else
			if doPlayerRemoveMoney(cid, (shop[item].price * amount) + 20) then
				local cont = doPlayerAddItem(cid, 1988, 1)
				doAddContainerItem(cont, item, amount)
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Bought x" .. amount .. " " .. shop[item].name .. " for " .. (shop[item].price * amount) + 20 .. " gold.")
			else
				doPlayerSendCancel(cid, "You do not have enough money.")
				return true
			end
		end				
	else	
		if not ignoreCap then
			local total = getItemInfo(item).weight * amount
			if total > getPlayerFreeCap(cid) then
				doPlayerSendCancel(cid, "You do not have enough cap.")
				return true
			end
		end
		if doPlayerRemoveMoney(cid, shop[item].price * amount) then
			for i = 1, amount do
				doPlayerAddItem(cid, item, 1)
			end
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Bought x" .. amount .. " " .. shop[item].name .. " for " .. shop[item].price * amount .. " gold.")
		else
			doPlayerSendCancel(cid, "You do not have enough money.")
			return true
		end
	end
end		