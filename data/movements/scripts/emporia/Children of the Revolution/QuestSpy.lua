local config = {
	[8009] = {ChildrenoftheRevolution.SpyBuilding01, "An impressive ammount of fish is stored here."},
	[8010] = {ChildrenoftheRevolution.SpyBuilding02, "A seemingly endless array of weapon stretches before you into the darkness."},
	[8011] = {ChildrenoftheRevolution.SpyBuilding03, "These barracks seem to be home for quite a lot of soldiers."}
}

function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	local targetTile = config[item.actionid]
	if not player then 
		return true
	end

	if not targetTile then
		return true
	end
	
	if getPlayerStorageValue(cid,targetTile[1]) < 1 then
		setPlayerStorageValue(cid,targetTile[1], 1)
		doCreatureSay(cid,string.format("%s", targetTile[2]), TALKTYPE_MONSTER_SAY)
		setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission02, getPlayerStorageValue(cid,ChildrenoftheRevolution.Mission02) + 1) --Questlog, Children of the Revolution "Mission 2: Imperial Zzecret Weaponzz"
	end
	return true
end
