function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	if(item.uid == 14044) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.MatrixReward) < 1) then
			setPlayerStorageValue(cid,InServiceofYalahar.MatrixReward, 1)
			doPlayerAddItem(cid,9744, 1)
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You've found a matrix.")
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	elseif(item.uid == 14045) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.MatrixReward) < 1) then
			setPlayerStorageValue(cid,InServiceofYalahar.MatrixReward, 1)
			doPlayerAddItem(cid,9743, 1)
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You've found a matrix.")
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	end
	return true
end