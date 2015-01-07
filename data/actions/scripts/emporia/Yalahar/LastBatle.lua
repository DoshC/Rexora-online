local center = {x = 32783, y = 31166, z = 10}

local waves = {
	{x = 32779, y = 31166, z = 10},
	{x = 32787, y = 31166, z = 10},
	{x = 32782, y = 31162, z = 10},
	{x = 32784, y = 31162, z = 10},
	{x = 32782, y = 31170, z = 10},
	{x = 32784, y = 31170, z = 10},
}

function doClearAreaAzerus()
	if getPlayerStorageValue(cid,982) == 1 then
		local othermonsters = getSpectators(center, 10, 10, false)
		for _, othermonster in ipairs(othermonsters) do
			if isMonster(othermonster) then
				sendMagicEffect(getCreaturePosition(othermonster),CONST_ME_POFF)
				doRemoveCreature(othermonster)
			end
		end
		setPlayerStorageValue(cid,982, 0)
	end
	return true
end

function doChangeAzerus()
	local azeruses = getSpectators(center, 10, 10, false)
	for _, azerus in ipairs(azeruses) do
		if getCreatureName(monster) == "Azerus" then 
			doCreatureSay(cid,"No! I am losing my energy!", TALKTYPE_ORANGE_1)
			local azeruspos = getCreaturePosition(cid)
			doRemoveCreature(azerus)
			doSummonCreature("Azerus3", {x = 32783, y = 31167, z = 10}) 
			return true
		end
	end
	return false
end		

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.uid == 14047 then
		if getPlayerStorageValue(cid,982) ~= 1 then -- Fight
			local amountOfPlayers = 1
			local spectators = getSpectators(center, 10, 10, false)
			if #spectators < amountOfPlayers then
				for _, spectator in ipairs(spectators) do
					doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You need atleast "..amountOfPlayers.." players inside the quest room.")
				end
				return true
			end
			setPlayerStorageValue(cid,982, 1)
			addEvent(doSummonCreature, 18 * 1000, "Azerus2", {x = 32783, y = 31167, z = 10})
			for i = 1, 4 do
				if i == 1 then
					azeruswavemonster = "rift worm"
				elseif i == 2 then
					azeruswavemonster = "rift scythe"
				elseif i == 3 then
					azeruswavemonster = "rift brood"
				elseif i == 4 then
					azeruswavemonster = "war golem"
				end
				for k = 1, table.maxn(waves) do			
					addEvent(doSummonCreature, i * 20 * 1000, azeruswavemonster, waves[k])
					addEvent(doSendMagicEffect, i * 20 * 1000, waves[k], CONST_ME_TELEPORT)
				end
			end
			for x = 32779, 32787, 8 do
				for y = 31161, 31171, 10 do      
					doSendMagicEffect({x=x, y=y, z=10}, CONST_ME_HOLYAREA)
				end
			end
			addEvent(doChangeAzerus, 4 * 20 * 1000)
			addEvent(doClearAreaAzerus, 5 * 60 * 1000)
		else
			doCreatureSay(cid,'You have to wait some time before this globe charges.', TALKTYPE_MONSTER_SAY)
		end
	end
	return true
end