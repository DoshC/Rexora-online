function onStepIn(cid, item, position, fromPosition)
	local level = 120
	local player = isPlayer(cid)
	if not player then
		return true
	end

	if getPlayerStorageValue(cid,DemonOak.Done) >= 1 then
		doTeleportThing(cid,DEMON_OAK_KICK_POSITION)
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
		return true
	end

	if getPlayerLevel(cid) < level then
		doCreatureSay(cid,"LEAVE LITTLE FISH, YOU ARE NOT WORTH IT!", TALKTYPE_ORANGE_1, false, cid, DEMON_OAK_POSITION)
		doTeleportThing(cid,DEMON_OAK_KICK_POSITION)
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
		return true
	end

	if getPlayerStorageValue(cid, DemonOak.Squares) == 5 and not isInArea({x = 32706, y = 32345, z = 7, stackpos = 255}, {x = 32725, y = 32357, z = 7, stackpos = 255}) then
		doTeleportThing(cid,DEMON_OAK_ENTER_POSITION)
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
		setPlayerStorageValue(cid,DemonOak.Progress, 1)
		doCreatureSay(cid,"I AWAITED YOU! COME HERE AND GET YOUR REWARD!", TALKTYPE_ORANGE_1, false, cid, DEMON_OAK_POSITION)
	else
		doTeleportThing(cid,DEMON_OAK_KICK_POSITION)
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
end
	return true
end