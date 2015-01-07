function onStepIn(cid, item, pos)

local ghenov = {x = 30996, y = 32187, z = 6}

    if item.actionid == 30043 then
        doPlayerSetTown(cid,19) 
		doTeleportThing(cid,ghenov)
        doSendMagicEffect(getCreaturePosition(cid),12)
		doPlayerSendTextMessage(cid,22, "You are now a citizen of ghenov")
        end
    return 1
end  