function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end
	
	if item.uid == 14048 then
		if getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 51 then
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 52)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 3) -- StorageValue for Questlog "Mission 10: The Final Battle"
			doCreatureSay(cid,"It seems by defeating Azerus you have stopped this army from entering your world! Better leave this ghastly place forever.", TALKTYPE_MONSTER_SAY)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_MAGIC_BLUE)
		end
	end
	return true
end