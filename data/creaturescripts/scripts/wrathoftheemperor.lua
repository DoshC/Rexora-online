function onKill(cid, target)
	if(isMonster(target)) then
		if(ZLAK_MISSIONS[string.lower(getCreatureName(target))]) then
			if(getPlayerStorageValue(cid, STORAGE_ZLAK) == ZLAK_MISSIONS[string.lower(getCreatureName(target))].STORAGE_ZLAK) then
				local STORAGE = string.explode(string.lower(getCreatureName(target)), " ")
				if(getPlayerStorageValue(cid, ZLAK_MISSIONS[string.lower(getCreatureName(target))].STORAGE) < ZLAK_MISSIONS[string.lower(getCreatureName(target))].MAX_STORAGE_VALUE) then
					setPlayerStorageValue(cid, ZLAK_MISSIONS[string.lower(getCreatureName(target))].STORAGE, math.max(0, getPlayerStorageValue(cid, ZLAK_MISSIONS[string.lower(getCreatureName(target))].STORAGE)) + 1)
				end
			end
		elseif(ZALAMON_FORMS[string.lower(getCreatureName(target))]) then
			doSummonCreature(ZALAMON_FORMS[string.lower(getCreatureName(target))].NEW_FORM, getCreaturePosition(target))
			doCreatureSay(target, ZALAMON_FORMS[string.lower(getCreatureName(target))].TEXT, TALKTYPE_ORANGE_1)
		elseif(SOUL_PARTS[string.lower(getCreatureName(target))]) then
			doItemSetAttribute(doCreateItem(12317, 1, getCreaturePosition(target)), "aid", SOUL_PARTS[string.lower(getCreatureName(target))])
		end
	end
	return true
end