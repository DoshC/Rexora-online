function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	if(item.uid == 14039) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 24) then
			if(item.itemid == 5288) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 5289)
				setPlayerStorageValue(cid,InServiceofYalahar.MrWestDoor, 1)
			end
		end
	elseif(item.uid == 14040) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 24) then
			if(item.itemid == 6261) then
				doTeleportThing(cid,toPosition, true)
				doTransformItem(item.uid, 6262)
				setPlayerStorageValue(cid,InServiceofYalahar.MrWestDoor, 2)
			end
		end
	end
	return true
end