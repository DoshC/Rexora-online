function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.actionid == 14042 then
		local player = isPlayer(cid)
		if getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 45 then
			if item.itemid == 9277 then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 9278)
			elseif item.itemid == 9279 then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 9280)
			else
				doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "This door seems to be sealed against unwanted intruders.")
			end
		end
	end
	return true
end