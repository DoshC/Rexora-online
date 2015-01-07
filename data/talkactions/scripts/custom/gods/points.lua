  function onSay(cid, words, param)
        local t = string.explode(param, ",")
        if t[1] ~= nil and t[2] ~= nil then
                local result = db.getResult("SELECT `account_id` FROM `players` WHERE `name` = '"..t[1].."';")
                db.executeQuery("UPDATE `accounts` SET `premium_points` = `premium_points` + "..t[2].." WHERE `id` = '" ..result:getDataString("account_id").. "';")
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, ""..t[1].." has received "..t[2].." premium points.")
                result:free()
        else
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command Requires Two Params.")
        end
        return TRUE
end