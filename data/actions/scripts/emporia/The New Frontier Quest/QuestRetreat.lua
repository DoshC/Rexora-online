function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.uid == 14070 then
		local destination = {x = 33170, y = 31247, z = 11}
		doTeleportThing(cid,destination)
		doSendMagicEffect(destination,CONST_ME_POFF)
	end
	return true
end