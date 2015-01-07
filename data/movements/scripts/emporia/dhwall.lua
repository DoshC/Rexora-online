function onStepIn(cid, item, pos)
    local stairs_pos = {
	{x = 33210, y = 31630, z = 13, stackpos = 255},
	{x = 33211, y = 31630, z = 13, stackpos = 255},
	{x = 33212, y = 31630, z = 13, stackpos = 255}
	}
    if item.uid == 930 and isPlayer(cid) == TRUE then
        doCreateItem(1050,3,stairs_pos)
    end
    return true
end

function onStepOut(cid, item, pos)
    local stairs_pos = {
	{x = 33210, y = 31630, z = 13, stackpos = 255},
	{x = 33211, y = 31630, z = 13, stackpos = 255},
	{x = 33212, y = 31630, z = 13, stackpos = 255}
	}
    local stairs = getThingfromPos(stairs_pos)
    if item.uid == 930 and isPlayer(cid) == TRUE then              
    doRemoveItem(stairs.uid)
    end
    return true
end
