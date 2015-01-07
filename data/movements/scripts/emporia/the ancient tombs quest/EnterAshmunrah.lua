function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	local player = isPlayer(cid)
	if not player then
		return true
	end

	local destination = {x = 33198, y = 32885, z = 11}
	if getGlobalStorageValue(TheAncientTombs.AshmunrahSwitchesGlobalStorage) >= 5 then
		doTeleportThing(cid,destination)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
		else
		doTeleportThing(cid,fromPosition, true)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
	end
	return true
end