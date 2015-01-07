function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.actionid == 14032) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 17) then
			if(item.itemid == 1257) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 1258)
			end
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The door seems to be sealed against unwanted intruders.")
		end
	end
	return true
end