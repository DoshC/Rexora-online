function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.uid == 14034) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 16) then
			if(item.itemid == 1255) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 1256)
			end
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The door seems to be sealed against unwanted intruders.")
		end
	end
	return true
end