function onUse(cid, item, fromPosition, itemEx, toPosition)
	if itemEx.actionid == 14052 then
		local player = isPlayer(cid)
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 10 then
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 11)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission03, 2) --Questlog, Children of the Revolution "Mission 3: Zee Killing Fieldzz"
			doRemoveItem(item.uid)
			doCreatureSay(cid,"The rice has been poisoned. This will weaken the Emperor's army significantly. Return and tell Zalamon about your success.", TALKTYPE_MONSTER_YELL)
		end
	end
	return true
end