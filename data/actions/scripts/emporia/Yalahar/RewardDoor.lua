function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.actionid == 14049) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 53) then
			if(item.itemid == 1255) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 1256)
			end
		end
	end
	return true
end