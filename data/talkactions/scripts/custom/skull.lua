local config = {
	cost = 10
}
function onSay(cid, words, param, channel)
    local nonremskulls =  -- These are the skulls it cant remove. If player has any of these, the rune wont work.
    {
        white = SKULL_WHITE
    }
    if isInArray(nonremskulls, getPlayerSkullType(cid)) then
        doPlayerSendCancel(cid,"You can't remove this type of skull.")
        doSendMagicEffect(getPlayerPosition(cid),2)
    	return
	end
    if (getAccountPoints(cid) < config.cost) then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sorry, not enough premium time - removing red skull costs " .. config.cost .. " premium points.")
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
	else
		doRemovePoints(cid,config.cost)
        db.executeQuery("UPDATE `killers` SET `unjustified` = 0 WHERE `id` IN (SELECT `kill_id` FROM `player_killers` WHERE `player_id` = " .. getPlayerGUID(cid) .. ")")
        doCreatureSetSkullType(cid,0)
        doPlayerSendTextMessage(cid,27,"Your frags & your skull have been removed, thanks for donating!")
        doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_RED)
        doSendAnimatedText(getPlayerPosition(cid), "Removed!", 180)
        doPlayerSetSkullEnd(cid, 0, getPlayerSkullType(cid))
        doWriteLogFile("data/logs/buyeditems.txt", "[".. os.date('%d %B %y - %H:%M') .."] ".. getCreatureName(cid) .." bought a redskull remover for "..config.cost.." points.")
    return TRUE
    end
end