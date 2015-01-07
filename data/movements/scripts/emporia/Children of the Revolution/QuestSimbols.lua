function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end
	if item.uid == 14052 then
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.StrangeSymbols) < 1 and getPlayerStorageValue(cid,ChildrenoftheRevolution.Mission03) >= 2 then
			setPlayerStorageValue(cid,ChildrenoftheRevolution.StrangeSymbols, 1)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission04, 2) --Questlog, Children of the Revolution "Mission 4: Zze Way of Zztonezz"
			doCreatureSay(cid,"A part of the floor before you displays an arrangement of strange symbols.", TALKTYPE_MONSTER_SAY)
		end
	end
	return true
end
