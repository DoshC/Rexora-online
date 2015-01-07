function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.actionid == 7801) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 20) then
			if(item.itemid == 5288) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 5289)
			elseif(item.itemid == 5123) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 5124)
			end
		end
	end
	return true
end