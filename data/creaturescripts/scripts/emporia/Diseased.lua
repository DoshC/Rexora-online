local boss = {
	["diseased dan"] = InServiceofYalahar.DiseasedDan,
	["diseased bill"] = InServiceofYalahar.DiseasedBill,
	["diseased fred"] = InServiceofYalahar.DiseasedFred,
}

function onKill(cid, target)
	if(boss[string.lower(getCreatureName(target))]) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,boss[string.lower(getCreatureName(target))]) < 1) then
			setPlayerStorageValue(cid,boss[string.lower(getCreatureName(target))], 1)
			doCreatureSay(cid, "You slained " .. getCreatureName(target) .. ".", TALKTYPE_MONSTER_SAY)
		end
	end
	return true
end