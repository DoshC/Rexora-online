function onStepIn(cid, item, pos)

local ghala = {x = 31236, y = 32414, z = 7}

    if item.actionid == 30042 then
        doPlayerSetTown(cid,18) 
		doTeleportThing(cid,ghala)
        doSendMagicEffect(getCreaturePosition(cid),12)
		doPlayerSendTextMessage(cid,22, "You are now a citizen of ghala")
        end
    return 1
end  