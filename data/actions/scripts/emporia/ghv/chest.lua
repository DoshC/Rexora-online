local t = {
[14015] = {8001,"executioner",7453},
[14016] = {8001,"havoc blade",7405},
[14017] = {8001,"skullcrusher",7423},
[14018] = {8001,"ironworker",8853},
[14019] = {8002,"dark lord's cape",8853},
[14020] = {8002,"amazon armor",2500},
}
function onUse(cid,item,fromPosition,itemEx,toPosition)
local v = t[item.uid]
      if getPlayerStorageValue(cid,v[1]) >= 1 then
      return doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty")
      elseif getPlayerFreeCap(cid) < (getItemWeightById(v[2])) then
      return doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You need " .. getItemWeightById(v[2]) .. " capacity in order to get the item")
    end
        setPlayerStorageValue(cid,v[1],1)
        doPlayerAddItem(cid,v[2])
        doPlayerSendTextMessage(cid,22,"Has Recibido tu Item")
    return true
end