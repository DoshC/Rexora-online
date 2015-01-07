function onUse(cid, item, frompos, item2, topos)

local wallpos1    = {x=32233, y=32276, z=9, stackpos=1}
local wall1    = getThingfromPos(wallpos1)
local toPos = {x=32225, y=32275, z=10} 
local wallID    = 1387


    if item.itemid == 1946 then
        doRemoveItem(wall1.uid, 1)
    elseif item.itemid == 1945 then
        doCreateTeleport(wallID, toPos, wallpos1)

    end

end  