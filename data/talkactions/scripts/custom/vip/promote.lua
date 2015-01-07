----- Antigua RPG --- Diviinoo ----
function onSay(cid, words, param)
if getAccountPoints(cid) >= 12 then
		if getPlayerStorageValue(cid,11551) == -1 then
				setPlayerPromotionLevel(cid, 2)
				doSendMagicEffect(getCreaturePosition(cid),14)
				doSendAnimatedText(getCreaturePosition(cid), "PROMOTED!" ,49)
				setPlayerStorageValue(cid,11551,1)
				doRemovePoints(cid, 12)
	 else
        doPlayerSendCancel(cid, "Not enough Premium Points or already promoted!")
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    end
    return TRUE
end
end