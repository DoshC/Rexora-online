local name = "Shard Of Corruption"
function onKill(cid, target)
	if getCreatureName(target) == "Shard Of Corruption" then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 12 then
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 13)
				setPlayerStorageValue(cid,TheNewFrontier.Mission04, 2) --Questlog, The New Frontier Quest "Mission 04: The Mine Is Mine"
			end
		end
	return true
end