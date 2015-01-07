function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end
	
	if item.uid == 9105 and isPlayer(cid) then
		if getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 51 then
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			doTeleportThing(cid,{x = 32783, y = 31174, z = 10})
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			doCreatureSay(cid,"The apparatus in the centre looks odd! You should inspect it.", TALKTYPE_MONSTER_SAY)

		else
			doTeleportThing(cid,fromPosition)
		end
	elseif item.uid == 9106 and isPlayer(cid) then
		if getGlobalStorageValue(982) < 1 then
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			doTeleportThing(cid,{x = 32784, y = 31178, z = 9})
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		else
			doTeleportThing(cid,fromPosition)
		end
	end
	return true
end