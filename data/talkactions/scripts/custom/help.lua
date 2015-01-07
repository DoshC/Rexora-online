local config = {
        cost = 500,
        compraid = 2554, --shovel
        compraid2 = 2120, -- rope
        compraid3 = 2553, -- pick
        compraid4 = 2420, -- machete
}
function onSay(cid, words, param, channel)
if doPlayerRemoveMoney(cid, config.cost) == TRUE then
	local container = doPlayerAddItem(cid, 2000, 1) --backpack
	doAddContainerItem(container, config.compraid, 1) 
	doAddContainerItem(container, config.compraid2, 1) 
	doAddContainerItem(container, config.compraid3, 1) 
	doAddContainerItem(container, config.compraid4, 1) 
    doSendMagicEffect(getPlayerPosition(cid),12)
    doPlayerSendTextMessage(cid,22,"Thanks for buying!.")
else
    doPlayerSendCancel(cid,"You don't have enough money.")
    doSendMagicEffect(getPlayerPosition(cid),2)
end
return TRUE
end