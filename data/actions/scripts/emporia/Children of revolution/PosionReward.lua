function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.uid == 14051 then
		local player = isPlayer(cid)
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 9 then
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 10)
			doPlayerAddItem(cid,10760, 1)
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You've found a flask of poison.")
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.StrangeSymbols) == 2 then
			setPlayerStorageValue(cid,ChildrenoftheRevolution.StrangeSymbols, 3)
			doPlayerAddItem(cid,11106, 1)
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You've found a flask of extra greasy oil.")
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	end
	return true
end