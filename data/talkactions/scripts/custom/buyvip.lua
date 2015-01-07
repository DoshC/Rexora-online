-- Vip System by 5mok3 --
function onSay(cid, words, param, channel)
    if getAccountPoints(cid) >= 10 then        
        --[[if getPlayerPromotionLevel(cid) < 2 then
			setPlayerPromotionLevel(cid, 2)
	    end]]
				doSendMagicEffect(getCreaturePosition(cid),14)
				doSendAnimatedText(getCreaturePosition(cid), "VIP +7!" ,49)
				doAddVipDays(cid, 7)
				doRemovePoints(cid, 10)
				doWriteLogFile("data/logs/buyeditems.txt", "[".. os.date('%d %B %y - %H:%M') .."] ".. getCreatureName(cid) .." bought VIP for 18 points.")
		    
		    --[[local thing = getThingfromPos(pos)
                doRemoveCreature(thing.uid)]]
	 else
        doPlayerSendCancel(cid, "Not enough Premium Points or already have more than 365 VIP days!")
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    end
    return TRUE
end