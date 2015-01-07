function onUse(cid, item, frompos, item2, topos)
        local playerskull = getCreatureSkullType(cid)
        local skulls = {
                                        SKULL_NONE,
                                        SKULL_YELLOW,
                                        SKULL_GREEN,
                                        SKULL_WHITE
                                        }
 
        if isInArray(skulls, playerskull) then
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You don't have red or black skull.")
                return 0
        else
                doCreatureSetSkullType(cid, skulls[1])
                doRemoveItem(item.uid, 1)
                db.executeQuery("UPDATE `killers` SET `unjustified` = 0 WHERE `id` IN (SELECT `kill_id` FROM `player_killers` WHERE `player_id` = " .. getPlayerGUID(cid) .. ")")
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your skull has been removed.")
        end
        return true
end