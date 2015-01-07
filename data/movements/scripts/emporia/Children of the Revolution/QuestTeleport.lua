local config = {
	[14053] = {ChildrenoftheRevolution.Questline,{x = 33257, y = 31115, z = 8},{x = 33356, y = 31126, z = 7}},
	[14054] = {ChildrenoftheRevolution.Questline,{x = 33356, y = 31125, z = 7},{x = 33261, y = 31079, z = 8}}
}

function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	local targetTile = config[item.uid]
	if not player then 
		return true
	end

	if not targetTile then
		return true
	end
	
	if getPlayerStorageValue(cid,targetTile[1]) >= 19 then
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		doTeleportThing(cid,targetTile[2])
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
	else
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		doTeleportThing(cid,targetTile[3])
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		doCreatureSay(cid,"This portal should not be entered unprepared", TALKTYPE_MONSTER_SAY)
	end
	return true
end