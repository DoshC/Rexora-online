local config = {
        cost = 10000,
        compraid = 2173
}
function onSay(cid, words, param)
if doPlayerRemoveMoney(cid, config.cost) == TRUE then
    doPlayerAddItem(cid, config.compraid, 1)
	doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYAREA)
    doSendAnimatedText(getCreaturePosition(cid), "AOL!", TEXTCOLOR_DARKYELLOW)
    doPlayerSendTextMessage(cid,22,"Thanks for buying!.")
else
    doPlayerSendCancel(cid,"You need 10,000 gold coins.")
	doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
end
return TRUE
end