function onUse(cid, item, frompos, item2, topos)
if getPlayerStorageValue(cid,20010) == -1 then
doPlayerAddItem(cid,8702)
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,"You have found the witches' grimoire.")
setPlayerStorageValue(cid,20010,1)
else
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,"The chest is empty.")
end
return 1
end