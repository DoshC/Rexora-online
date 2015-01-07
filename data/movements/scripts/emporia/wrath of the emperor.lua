function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	if(item.actionid == 104) then
		doPlayerTeleportIfStorage(cid, STORAGE_DRAGON, 2, {x = 33027, y = 31084, z = 13}, lastPosition)	
	elseif(item.actionid == 105) then
		doPlayerTeleportIfStorage(cid, STORAGE_ZIZZLE, 1, {x = 33160, y = 31113, z = 15}, lastPosition)
	elseif(item.actionid == 125) then
		doPlayerTeleportIfStorage(cid, STORAGE_END, 1, {x = 33160, y = 31113, z = 15}, lastPosition)
	elseif(item.actionid == 112) then
		addEvent(doPlayerTeleportIfStorage, 1000, cid, STORAGE_BOSS, 4, {x = 33060, y = 31153, z = 15})
	elseif(item.actionid == 135) then
		doPlayerTeleportIfStorage(cid, STORAGE_END, 2, {x = 33093, y = 31122, z = 12}, lastPosition)
	elseif(item.actionid == 136) then
		if(getPlayerItemCount(cid, 12629) >= 1) then
			doPlayerRemoveItem(cid, 12629, 1)
			doPlayerTeleportIfStorage(cid, STORAGE_END, 2, {x = 33084, y = 31214, z = 8}, lastPosition)
		else
			doTeleportThing(cid, fromPosition)
		end
	end
	return true
end