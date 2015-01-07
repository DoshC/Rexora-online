local cfg = {
	bless = { 1, 2, 3, 4, 5 },
	cost = 50000
}

function onSay(cid, words, param, channel)
    for i = 1, table.maxn(cfg.bless) do
        if(getPlayerBlessing(cid, cfg.bless[i])) then
            doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "You have already been blessed.")
            return true
        end
    end
	if (getPlayerMoney(cid) < cfg.cost) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "You need 50,000 gold coins.")
    elseif(doPlayerRemoveMoney(cid, cfg.cost) == TRUE) then
        for i = 1, table.maxn(cfg.bless) do
            doPlayerAddBlessing(cid, cfg.bless[i])
        end
        doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_BLUE)
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You have been blessed by the gods.")
    end
    return true
end