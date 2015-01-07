function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	if getPlayerStorageValue(cid,UnnaturalSelection.Mission01) == 1 then
		setPlayerStorageValue(cid,UnnaturalSelection.Mission01, 2) -- Questlog, Unnatural Selection Quest "Mission 1: Skulled"
		doPlayerAddItem(cid,11076, 1)
		doCreatureSay(cid,"You dig out a skull from the pile of bones. That must be the skull Lazaran talked about.", TALKTYPE_MONSTER_YELL)
	end
	return true
end
