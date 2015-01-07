function onUse(cid, item, fromPosition, itemEx, toPosition)
	for i = 10001, 10008 do
		if getPlayerStorageValue(cid, i) > 0 then
			return doTransformItem(item.uid, 5133) and doTeleportThing(cid, toPosition, true)
		end
	end
	return doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE,"The doors are sealed against unwanted intruders.")
end