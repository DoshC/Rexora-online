function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.uid == 14072) then
		if(getPlayerStorageValue(cid, TravellingTrader.Mission02) == 3) then
			setPlayerStorageValue(cid, TravellingTrader.Mission02, 4)
			doPlayerAddItem(cid, 7503, 1)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You've found a heavy package.")
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	end
	return true
end