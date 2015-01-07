  function onUse(cid, item, fromPosition, itemEx, toPosition)
local chance = 2 -- chance in % to get the Winner Ticket
        if math.random(1,100) <= chance then
                doSendMagicEffect(fromPosition, CONST_ME_SOUND_YELLOW)
                doCreatureSay(cid, "You have a winning lottery ticket!", TALKTYPE_ORANGE_1)
                doTransformItem(item.uid, item.itemid + 1)
        else
                doSendMagicEffect(fromPosition, CONST_ME_POFF)
                doCreatureSay(cid, "Pufff.", TALKTYPE_ORANGE_1)
                doTransformItem(item.uid, item.itemid - 1)
        end
        return TRUE
end