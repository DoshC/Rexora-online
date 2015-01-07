local boss = {
	["azerus"] = 1,
}
local function removeTeleport(tp)
	local teleport = getTileItemById(tp, 1387).uid
	local teleports = getTileItemById(tp, 9738).uid
	if(teleport > 0) then
	if(teleports > 0) then
     doRemoveItem(teleport)
	 doRemoveItem(teleports)
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   end
   return true
end


function onKill(cid, target)
	local position = getCreaturePosition(target)
	if(boss[string.lower(getCreatureName(target))]) then
		local player = isPlayer(cid)
			doCreateTeleport(1387, {x = 32778, y = 31173, z = 14}, position)
			doCreatureSay(cid, "Azerus ran into teleporter! It will disappear in 2 minutes. Enter it!",TALKTYPE_MONSTER_SAY,false,cid,position)
			doSendMagicEffect(position,CONST_ME_TELEPORT)
			addEvent(removeTeleport, 2 * 60 * 1000, position)
	end
	return true
end