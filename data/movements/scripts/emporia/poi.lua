function onStepIn(cid, item, pos)

local pos = {x=32826, y=32248, z=10}

    if item.actionid == 20000 then
		doTeleportThing(cid,pos)
		setPlayerStorageValue(cid, 20000,1)
        doSendMagicEffect(getCreaturePosition(cid),14)		
        end
    return 1
end  