function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.uniqueid == 14036) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 17) then
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