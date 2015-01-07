function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end

		if getPlayerStorageValue(cid,TheInquisition.Questline) >= 20 then
			local destination = {x =33168, y = 31683, z = 15}
			doTeleportThing(cid,destination)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		else
			doTeleportThing(cid,fromPosition)
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
			doPlayerSendCancel(cid,"You don't have access to this area.")
		end
	return true
end

