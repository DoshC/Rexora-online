local config =
{
        conditionsToRemove = {CONDITION_POISON, CONDITION_CURSED},
        timeBetweenUse = 10,
        usesLimit = 60,
        usesLimitTime = 1,
        damage = 200,
        timeStorage = 64500,
        usesStorage = 64501,
        usesLimitStorage = 64502
}      

function onUse(cid, item, fromPosition, itemEx, toPosition)

        if(getPlayerStorageValue(cid, config.timeStorage) < 0) then
                doPlayerSetStorageValue(cid, config.timeStorage, 0)
        end
        if(getPlayerStorageValue(cid, config.usesStorage) < 0) then
                doPlayerSetStorageValue(cid, config.usesStorage, 0)
        end
        if(os.clock() - getPlayerStorageValue(cid, config.timeStorage)) > config.timeBetweenUse then
                if(getTilePzInfo(getCreaturePosition(cid)) == true) then
                        doCreatureSay(cid, "It tightens around your wrist as you take it on.", TALKTYPE_MONSTER)
                else
                        doCreatureSay(cid, "Ouch! The serpent claw stabbed you.", TALKTYPE_MONSTER)
                        doCreatureAddHealth(cid, -config.damage)
                        doSendAnimatedText(getCreaturePosition(cid), config.damage, TEXTCOLOR_RED)
                end

                doPlayerSetStorageValue(cid, config.timeStorage, os.clock())

                if(os.clock() - (config.usesLimitTime * 3600) < getPlayerStorageValue(cid, config.usesLimitStorage)) then
                        doPlayerSetStorageValue(cid, config.usesStorage, getPlayerStorageValue(cid, config.usesStorage) + 1)
                else
                        doPlayerSetStorageValue(cid, config.usesStorage, 0)
                end

                if(getPlayerStorageValue(cid, config.usesStorage) >= config.usesLimit) then
                        doTransformItem(item.uid, item.itemid + 2)
                end
                for i = 1, table.maxn(config.conditionsToRemove) do
                        doRemoveCondition(cid, config.conditionsToRemove[i])
                end
        else
                return false
        end
        return true
end 