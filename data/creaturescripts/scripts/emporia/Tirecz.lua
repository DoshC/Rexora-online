function onKill(cid, target)
	local name = getCreatureName(target):lower()
		if name == 'tirecz' and getPlayerStorageValue(cid,TheNewFrontier.Mission09, -1) then
			local spectators = getSpectators({x = 33063, y = 31034, z = 3}, 10, 10, false)
			for _, spectator in ipairs(spectators) do
				doTeleportThing(cid,{x = 33053, y = 31022, z = 7})
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
				doCreatureSay(cid,"You have won! As new champion take the ancient armor as reward before you leave.", TALKTYPE_MONSTER_SAY)
				if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 25 then
					setPlayerStorageValue(cid,TheNewFrontier.Mission09, 2) --Questlog, The New Frontier Quest "Mission 09: Mortal Combat"
					setPlayerStorageValue(cid,TheNewFrontier.Questline, 26)
				end
			end
		end
	return true
end