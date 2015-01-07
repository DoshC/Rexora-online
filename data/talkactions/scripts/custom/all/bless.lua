local cfg = {
	bless = { 1, 2, 3, 4, 5 },
	cost = 50000
}

function onSay(cid, words, param, channel)
    for i = 1, table.maxn(cfg.bless) do
        if(getPlayerBlessing(cid, cfg.bless[i])) then
            doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
            doCreatureSay(cid, "You have already been blessed.", TALKTYPE_ORANGE_1)
            return true
        end
    end
	if (getPlayerMoney(cid) < cfg.cost) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
		doSendAnimatedText(getCreaturePosition(cid), "$$$", TEXTCOLOR_WHITE)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You do not have enough money.")
    elseif(doPlayerRemoveMoney(cid, cfg.cost) == TRUE) then
        for i = 1, table.maxn(cfg.bless) do
            doPlayerAddBlessing(cid, cfg.bless[i])
        end
        doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYAREA)
        doSendAnimatedText(getCreaturePosition(cid), "BLESSED!", TEXTCOLOR_RED)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You have been blessed by the gods.")
    end
    return true
end