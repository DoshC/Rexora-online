function onUse(cid, item, frompos, item2, topos)
if(item.actionid == 1001) then
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It is locked.")

return true
end

doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It is locked.")

return true
end