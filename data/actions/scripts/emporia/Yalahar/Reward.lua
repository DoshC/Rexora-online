function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	if(getPlayerStorageValue(cid,102504) < 1) then
		doPlayerAddExp(cid, 250000, true, true)
		setPlayerStorageValue(cid,102504, 1)
	end
	if(item.actionid == 58268) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 53) then
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 54)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 5) -- StorageValue for Questlog "Mission 10: The Final Battle"
			doPlayerAddItem(cid,9776, 1)
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You've found a yalahari armor.")
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	elseif(item.actionid == 58267) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 53) then
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 54)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 5) -- StorageValue for Questlog "Mission 10: The Final Battle"
			doPlayerAddItem(cid,9778, 1)
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You've found a yalahari mask.")
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	elseif(item.actionid == 58269) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 53) then
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 54)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 5) -- StorageValue for Questlog "Mission 10: The Final Battle"
			doPlayerAddItem(cid,9777, 1)
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You've found a yalahari leg piece.")
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	end
	return true
end