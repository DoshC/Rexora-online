function onUse(cid, item, fromPosition, itemEx, toPosition)
	if itemEx.actionid == 14055 then
		local player = isPlayer(cid)
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 13 then
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 14)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission04, 4) --Questlog, Children of the Revolution "Mission 4: Zze Way of Zztonezz"
			doRemoveItem(item.uid)
			doCreatureSay(cid,"Due to being extra greasy, the leavers can now be moved.", TALKTYPE_MONSTER_SAY)
		end
	end
	return true
end