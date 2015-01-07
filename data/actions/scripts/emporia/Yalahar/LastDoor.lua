function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 51 and item.itemid == 1257) then
		if(item.itemid == 1258) then 
			return false 
		end
		doTeleportThing(cid,toPosition, true)
		doTransformItem(item.uid,1258)
	else
		doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "This door seems to be sealed against unwanted intruders.")
	end
return true
end
