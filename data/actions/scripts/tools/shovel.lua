function onUse(cid, item, fromPosition, itemEx, toPosition)
local holes = {468, 481, 483, 7932}
aID = 1345 --Action Id the ground tile must have to turn into a hole.
ticks = 30 --How many seconds the hole will last before turning into a normal tile again
topos = {x=toPosition.x, y=toPosition.y, z=toPosition.z}
sandrand = math.random(1, 10)
    if itemEx.itemid == 0 then
        return 0
    end
if (itemEx.actionid == aID and sandrand == 5) then
    if itemEx.itemid == 9059 then
        doTransformItem(itemEx.uid,482)
        doSendMagicEffect(toPosition,2)
        doDecayItem(toPosition, itemEx.itemid, ticks)
        else
            doSendMagicEffect(toPosition,2)
        end
        return 1
    end

    if isInArray(holes, itemEx.itemid) == TRUE then
        doTransformItem(itemEx.uid, itemEx.itemid+1)
        doDecayItem(itemEx.uid)
    elseif itemEx.itemid == 9059 then
        rand = math.random(1, 100)
        if rand > 95 then
            doSummonCreature("Scarab", toPosition)
        elseif rand == 1 then
            doCreateItem(2159, 1, toPosition)
        else
            doSendMagicEffect(toPosition,2)
        end
    else
        return 0
    end
    return 1
end  