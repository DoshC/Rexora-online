function onStepOut(cid, item, position, fromPosition)
	if (isPlayerGhost(cid)) == false then
		if(item.itemid == 670) then
			doDecayItem(doCreateItem(6594, fromPosition))
		else
			doDecayItem(doCreateItem(item.itemid + 15, fromPosition))
		end
	end
	return true
end