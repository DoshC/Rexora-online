function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.actionid == 14043) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.MatrixReward) >= 1) then
			if(item.itemid == 9279) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 9280)
			end
		end
	end
	return true
end
