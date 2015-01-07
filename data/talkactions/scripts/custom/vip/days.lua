function onSay(cid, words, param)
local points = getPlayerPoints(cid)
		if getPlayerStorageValue(cid, 11552) > 0 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have "..points.." days.")
	else
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You dont have any days")
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    end
    return TRUE
end  