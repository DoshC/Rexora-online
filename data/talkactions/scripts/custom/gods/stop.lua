local condition1 = createConditionObject(CONDITION_INFIGHT)
    local condition2 = createConditionObject(CONDITION_EXHAUST)
    local condition3 = createConditionObject(CONDITION_MUTED)
    setConditionParam(condition1, CONDITION_PARAM_TICKS, -1)
    setConditionParam(condition2, CONDITION_PARAM_TICKS, -1)
    setConditionParam(condition3, CONDITION_PARAM_TICKS, -1)

function onSay(cid, words, param)
    if(param == "") then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Name required.")
        return TRUE
    end

    local player = getPlayerByNameWildcard(param)
        local pos = getCreaturePosition(player)
 
        local nha = {x = pos.x, y = pos.y - 3, z = pos.z, stackpos = 255}
        local sha = {x = pos.x, y = pos.y + 3, z = pos.z, stackpos = 255}
        local wha = {x = pos.x - 3, y = pos.y, z = pos.z, stackpos = 255}
        local eha = {x = pos.x + 3, y = pos.y, z = pos.z, stackpos = 255}
        local nwa = {x = pos.x - 2, y = pos.y - 2, z = pos.z, stackpos = 255}
        local nea = {x = pos.x + 2, y = pos.y - 2, z = pos.z, stackpos = 255}
        local sea = {x = pos.x + 2, y = pos.y + 2, z = pos.z, stackpos = 255}
        local swa = {x = pos.x - 2, y = pos.y + 2, z = pos.z, stackpos = 255}
if getPlayerGroupId(cid) >= getPlayerGroupId(player) then
if getPlayerStorageValue(player, 12346) < 0 then
    if((doCreatureSetNoMove(player, 1))== LUA_ERROR) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Error.")
    end
        setPlayerStorageValue(player, 12346, 1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player can now not move.")
        doSendAnimatedText(getCreaturePosition(player), "Frozen", 64)
            doSendDistanceShoot(nha, pos, 28)
            doSendDistanceShoot(sha, pos, 28)
            doSendDistanceShoot(wha, pos, 28)
            doSendDistanceShoot(eha, pos, 28)
            doSendDistanceShoot(nwa, pos, 28)
            doSendDistanceShoot(nea, pos, 28)
            doSendDistanceShoot(sea, pos, 28)
            doSendDistanceShoot(swa, pos, 28)
                doSendMagicEffect(pos, 52)
        doAddCondition(player, condition1)
        doAddCondition(player, condition2)
        doAddCondition(player, condition3)
elseif getPlayerStorageValue(player, 12346) >= 0 then
    if((doCreatureSetNoMove(player, 0))== LUA_ERROR) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Error.")
    end
        setPlayerStorageValue(player, 12346, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player can now move again.")
        doSendAnimatedText(getCreaturePosition(player), "Can Move", 168)
            doSendDistanceShoot(pos, nha, 37)
            doSendDistanceShoot(pos, sha, 37)
            doSendDistanceShoot(pos, wha, 37)
            doSendDistanceShoot(pos, eha, 37)
            doSendDistanceShoot(pos, nwa, 37)
            doSendDistanceShoot(pos, nea, 37)
            doSendDistanceShoot(pos, sea, 37)
            doSendDistanceShoot(pos, swa, 37)
                doSendMagicEffect(pos, 49)
        doRemoveCondition(cid, CONDITION_INFIGHT)
        doRemoveCondition(cid, CONDITION_EXHAUST)
        doRemoveCondition(cid, CONDITION_MUTED)
end
end
    return TRUE
end