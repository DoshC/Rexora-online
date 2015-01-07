function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end
	if item.actionid == 14065 then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 1 then
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 2)
			setPlayerStorageValue(cid,TheNewFrontier.Mission01, 2) --Questlog, The New Frontier Quest "Mission 01: New Land"
			doCreatureSay(cid,"You have found the passage through the mountains and can report about your success.", TALKTYPE_MONSTER_SAY)
		end
	end
	return true
end