  --- Config ---
local levelReq = 15 -- Level needed to use the command.
local minChars = 6 -- How many characters may you write as minumum?
local basePrice = 2000 -- Base price, will be multiplied by the players level.
local group_id = 2 -- Group to not use the script.

--- Exhaust Settings ---
local useExhaust = FALSE -- FALSE = Broadcast as fast as they want.
local storageValue = 1235 -- Storage for Exhaust to work.
local exhaustTime = 1 -- Minutes.
--- End config ---

function onSay(cid, words, param)
local letterPrice = basePrice
local broadcastPrice = letterPrice
    if getPlayerLevel(cid) < levelReq then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Sorry, you need to be atleast level " .. levelReq .. " to use this command.")
    return TRUE
    end
    if (useExhaust == TRUE) and getPlayerStorageValue(cid, storageValue) == 1 then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry, you need to wait before broadcasting another message.")
    return TRUE
    end
    if string.len(param) < minChars then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry, you need to enter atleast " .. minChars .. " characters. Each character will cost you " .. letterPrice .. " gold coins.")
    return TRUE
    end
    if getPlayerGroupId(cid) > group_id then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry, staff members do not need to broadcast messages with this command.")
    return TRUE
    end
    if doPlayerTakeItem(cid, 8981, 1) == FALSE then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sorry, you need to have a BROADCASTER. You can buy one in the donator shop.")
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    else        
	  doPlayerRemoveMoney(cid, broadcastPrice)
	  doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Broadcast successfully sent. Your message contained " .. string.len(param) .. " characters and cost you " .. broadcastPrice .. " gold coins.")
        broadcastMessage(getPlayerName(cid) .. " [" .. getPlayerLevel(cid) .. "]: " .. param, MESSAGE_STATUS_WARNING)
        setPlayerStorageValue(cid, storageValue, 1)
        addEvent(endExhaust, exhaustTime * 60000, cid)
    end
end

function endExhaust(cid)
    if (useExhaust == TRUE) then
        setPlayerStorageValue(cid, storageValue, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "You may now broadcast another message.")
    end
end 
