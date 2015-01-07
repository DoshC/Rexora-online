local config = {
        cost = 10000,
        compraid = 2173
}
function onSay(cid, words, param)
if doPlayerRemoveMoney(cid, config.cost) == TRUE then
    doPlayerAddItem(cid, config.compraid, 1)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You bought an AOL!")
	doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_BLUE)
else
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "You need 10,000 gold coins.")
	doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
end
return TRUE
end