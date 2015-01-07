function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	if getPlayerStorageValue(cid,DemonOak.Done) == 2 then
		doTeleportThing(cid,DEMON_OAK_REWARDROOM_POSITION)
		doSendMagicEffect(DEMON_OAK_REWARDROOM_POSITION, CONST_ME_TELEPORT)
		return true
	end
end