function onStepIn(cid, item, pos)

local vikia = {x = 30664, y = 32255, z = 7}

    if item.actionid == 30044 then
        doPlayerSetTown(cid,20) 
		doTeleportThing(cid,ghenov)
        doSendMagicEffect(getCreaturePosition(cid),12)
		doPlayerSendTextMessage(cid,22, "You are now a citizen of vikia")
        end
    return 1
end  