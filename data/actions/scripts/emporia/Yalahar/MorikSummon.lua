function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.uid == 14043) then
	local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 31 and getPlayerStorageValue(cid,InServiceofYalahar.MorikSummon) < 1) then
			doCreateMonster("Morik the Gladiator", fromPosition) 
			doSendMagicEffect(toPosition, CONST_ME_TELEPORT)
			setPlayerStorageValue(cid,InServiceofYalahar.MorikSummon, 1)
		end
	end
return true
end
