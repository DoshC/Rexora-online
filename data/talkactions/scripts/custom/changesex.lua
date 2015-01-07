local config = {
	cost = 5
}
function onSay(cid, words, param, channel)
	if(getPlayerSex(cid) >= 2) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You cannot change your gender.")
		return
	end

	if (getAccountPoints(cid) < config.cost) then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sorry, not enough premium time - changing gender costs " .. config.cost .. " premium points.")
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
	else
		doRemovePoints(cid,config.cost)
		doPlayerSetSex(cid, getPlayerSex(cid) == PLAYERSEX_FEMALE and PLAYERSEX_MALE or PLAYERSEX_FEMALE)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have changed your gender and lost " .. config.cost .. " premium points.")
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_RED)
		doWriteLogFile("data/logs/buyeditems.txt", "[".. os.date('%d %B %y - %H:%M') .."] ".. getCreatureName(cid) .." bought a changesex for "..config.cost.." points.")
	end
	return true
end