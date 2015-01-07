function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	local player = isPlayer(cid)
	if not player then
		return true
	end

	local destination = {x = 33367, y = 32805, z = 14}
	if getGlobalStorageValue(TheAncientTombs.ThalasSwitchesGlobalStorage) >= 7 then
		doTeleportThing(cid,destination)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
		else
		doTeleportThing(cid,fromPosition, true)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
	end
	return true
end