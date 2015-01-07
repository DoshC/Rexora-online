function onStepIn(cid, item, position, fromPosition)
for i = 50001, 50088 do
local pos = getThingPos(i)
if not isPlayer(getTopCreature(pos).uid) then
doTeleportThing(cid, pos)
doCreatureSay(cid, 'Has sido asignado a un room.', TALKTYPE_MONSTER)
doSendMagicEffect(position, CONST_ME_TELEPORT)
doSendMagicEffect(pos, CONST_ME_TELEPORT)
return
end
end
doTeleportThing(cid, fromPosition, true)
doCreatureSay(cid, 'No ahi rooms disponibles por el momento.', TALKTYPE_MONSTER)
doSendMagicEffect(fromPosition, CONST_ME_TELEPORT)
end