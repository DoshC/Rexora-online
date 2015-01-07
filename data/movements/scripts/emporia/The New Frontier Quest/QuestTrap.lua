function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end
	if(item.actionid == 14068) then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 22 then
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 23)
			setPlayerStorageValue(cid,TheNewFrontier.Mission07, 2) --Questlog, The New Frontier Quest "Mission 07: Messengers Of Peace"
		end
		local destination = {x = 33170, y = 31253, z = 11}
		doTeleportThing(cid,destination)
		doSendMagicEffect(destination,CONST_ME_POFF)
		doCreatureSay(cid,"So far for the negotiating peace. Now you have other problems to handle.", TALKTYPE_MONSTER_SAY)
	end
	return true
end