function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.uid == 14042) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 31) then
			if(item.itemid == 6259) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 6260)
			end
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The door seems to be sealed against unwanted intruders.")
		end
	end
	return true
end