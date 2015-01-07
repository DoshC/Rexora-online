function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.actionid == 14029) then
		if(getPlayerStorageValue(cid,TheInquisition.Questline) == 18) then
			if(item.itemid == 5114) then
				doTeleportThing(cid, toPosition, true)
				doTransformItem(item.uid, 5115)
			end
		end
	end
	return true
end