function onStepIn(cid, item, pos)

local oken = {x = 31151, y = 31652, z = 7}    if item.actionid == 30043 then
        doPlayerSetTown(cid,17) 
		doTeleportThing(cid,oken)
        doSendMagicEffect(getCreaturePosition(cid),12)
		doPlayerSendTextMessage(cid,22, "You are now a citizen of Oken")
        end
    return 1
end  