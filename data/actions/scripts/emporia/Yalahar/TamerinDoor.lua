function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.uid == 14041) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 29) then
			if(item.itemid == 9279) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 9280)
			end
		end
	end
	return true
end