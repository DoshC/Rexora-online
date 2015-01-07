  function onSay(cid, words, param)

local config = {
        bankSystemEnabled = getBooleanFromString(getConfigInfo('bankSystem')),
        playerIsFighting = hasCondition(cid, CONDITION_INFIGHT)
}

if config.bankSystemEnabled == TRUE then
        if config.playerIsFighting == TRUE then

if(param == "") then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Command requires param.")
        return TRUE
end

local t = string.explode(param, ",")

if playerExists(param) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You have transferred " .. getPlayerBalance(cid) .. " gold to " .. param .. ".")
        doPlayerTransferAllMoneyTo(cid, param)
else
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Player " .. param .. " does not exist.")
        end
        return TRUE
else
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Bank can not be used in fight.")
        return TRUE
end
else
        return FALSE
        end
end