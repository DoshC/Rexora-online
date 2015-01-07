function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.uid == 9021) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,TheInquisition.Questline) == 23) then
			return doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You forgot to ask henricus for outfit.")
		end
		if(getPlayerStorageValue(cid,TheInquisition.Questline) >= 24) then
			if(item.itemid == 5105) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 5106)
			end
		else
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE,"The door seems to be sealed against unwanted intruders.")
		end
	end
	return true
end
