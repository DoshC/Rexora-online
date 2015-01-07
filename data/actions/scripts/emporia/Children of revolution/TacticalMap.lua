function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.uid == 14050 then
		local player = isPlayer(cid)
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 1 then
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 2)
			doPlayerAddItem(cid,11101, 1)
			doCreatureSay(cid,"A batch of documents has been stashed in the shelf. These might be of interest to Zalamon.", TALKTYPE_MONSTER_YELL)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_POFF)
		end
	end
	return true
end