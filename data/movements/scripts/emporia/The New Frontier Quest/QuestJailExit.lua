function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end
	if getPlayerStorageValue(cid,TheNewFrontier.Mission08) >= 1 then
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		doTeleportThing(cid,{x = 33145, y = 31247, z = 6})
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
	else
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		doTeleportThing(cid,fromPosition)
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		doPlayerSendTextMessage(cid,MESSAGE_STATUS_SMALL, "You don't have access to this area.")
	end
	return true
end