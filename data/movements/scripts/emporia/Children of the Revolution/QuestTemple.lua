function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end
	if item.uid == 3163 then
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 4 then
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 5)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission01, 2) --Questlog, Children of the Revolution "Mission 1: Corruption"
			doCreatureSay(cid,"The temple has been corrupted and is lost. Zalamon should be informed about this as soon as possible.", TALKTYPE_MONSTER_YELL)
		end
	end
	return true
end
