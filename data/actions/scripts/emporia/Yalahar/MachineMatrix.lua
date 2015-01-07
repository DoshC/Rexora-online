function onUse(cid, item, fromPosition, itemEx, toPosition)
	if((itemEx.itemid == 7915 or itemEx.itemid == 7916) and itemEx.actionid == 9744) then
		local player = isPlayer(cid)
		if item.itemid == 9744 and getPlayerStorageValue(cid,InServiceofYalahar.MatrixState) < 1 then
			setPlayerStorageValue(cid,InServiceofYalahar.MatrixState, 1)
			doRemoveItem(item.uid, 1)
			doSendMagicEffect(toPosition, CONST_ME_MAGIC_BLUE)
			doCreatureSay(cid,"The machine was activated.", TALKTYPE_MONSTER_SAY)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 46)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission08, 3) -- StorageValue for Questlog "Mission 08: Dangerous Machinations"
		elseif item.itemid == 9743 and getPlayerStorageValue(cid,InServiceofYalahar.MatrixState) < 1 then
			setPlayerStorageValue(cid,InServiceofYalahar.MatrixState, 2)
			doRemoveItem(item.uid, 1)
			doSendMagicEffect(toPosition, CONST_ME_MAGIC_BLUE)
			doCreatureSay(cid,"The machine was activated.", TALKTYPE_MONSTER_SAY)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 46)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission08, 3) -- StorageValue for Questlog "Mission 08: Dangerous Machinations"
		end
	end
	return true
end