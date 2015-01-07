function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	local targetItem = (itemEx.uid)
	-- In Service Of Yalahar Quest
	if(itemEx.uid == 3071) then
			if(getPlayerStorageValue(cid,InServiceofYalahar.SewerPipe01) < 1) then
				doSetMonsterOutfit(cid, 'skeleton', 3 * 1000)
				doSendMagicEffect(fromPosition,CONST_ME_ENERGYHIT)
				setPlayerStorageValue(cid,InServiceofYalahar.SewerPipe01, 1)
				setPlayerStorageValue(cid,InServiceofYalahar.Mission01, getPlayerStorageValue(cid,InServiceofYalahar.Mission01) + 1) -- StorageValue for Questlog 'Mission 01: Something Rotten'
				for x = -1, 1 do
					for y = -1, 1 do
						doSendMagicEffect({x = getCreaturePosition(cid).x + x, y = getCreaturePosition(cid).y + y, z = getCreaturePosition(cid).z}, CONST_ME_YELLOWENERGY)
					end
				end
			end
		elseif(itemEx.uid == 3072) then
			if(getPlayerStorageValue(cid,InServiceofYalahar.SewerPipe02) < 1) then
				setPlayerStorageValue(cid,InServiceofYalahar.SewerPipe02, 1)
				setPlayerStorageValue(cid,InServiceofYalahar.Mission01, getPlayerStorageValue(cid,InServiceofYalahar.Mission01) + 1) -- StorageValue for Questlog 'Mission 01: Something Rotten'
				for x = -1, 1 do
					for y = -1, 1 do
						if(math.random(2) == 2) then
							doCreateMonster("rat", {x = getCreaturePosition(cid).x + x, y = getCreaturePosition(cid).y + y, z = getCreaturePosition(cid).z})
							doSendMagicEffect({x = getCreaturePosition(cid).x + x, y = getCreaturePosition(cid).y + y, z = getCreaturePosition(cid).z}, CONST_ME_TELEPORT)
						end
					end
				end
			end
		elseif(itemEx.uid == 3073) then
			if(getPlayerStorageValue(cid,InServiceofYalahar.SewerPipe03) < 1) then
				doCreatureSay(cid,'You have used the crowbar on a grate.', TALKTYPE_MONSTER_SAY)
				setPlayerStorageValue(cid,InServiceofYalahar.SewerPipe03, 1)
				setPlayerStorageValue(cid,InServiceofYalahar.Mission01, getPlayerStorageValue(cid,InServiceofYalahar.Mission01) + 1) -- StorageValue for Questlog 'Mission 01: Something Rotten'
			end
		elseif(itemEx.uid == 3074) then
			if(getPlayerStorageValue(cid,InServiceofYalahar.SewerPipe04) < 1) then
				doSetMonsterOutfit(cid, 'bog raider', 5 * 1000)
				doCreatureSay(cid,'You have used the crowbar on a knot.', TALKTYPE_MONSTER_SAY)
				setPlayerStorageValue(cid,InServiceofYalahar.SewerPipe04, 1)
				setPlayerStorageValue(cid,InServiceofYalahar.Mission01, getPlayerStorageValue(cid,InServiceofYalahar.Mission01) + 1) -- StorageValue for Questlog 'Mission 01: Something Rotten'
			end
		end
	-- The Ape City - Mission 7: Destroying Casks With Crowbar
	if itemEx.itemid == 5539 and itemEx.actionid == 12127 and getPlayerStorageValue(cid,TheApeCity.Mission07) <= 3 then --hit cask with crowbar
			doSendMagicEffect(toPosition,CONST_ME_POFF)
			setPlayerStorageValue(cid,TheApeCity.Mission07, getPlayerStorageValue(cid,TheApeCity.Mission07) + 1) -- The Ape City Questlog - Mission 7: Destroying Casks With Crowbar
			if getPlayerStorageValue(cid,TheApeCity.Mission07) == 4 then
				setPlayerStorageValue(cid,TheApeCity.Questline, 17)
			end
			doCreatureSay(cid,'You destroyed a cask.', TALKTYPE_MONSTER_SAY)
			doTransformItem(2249)
			addEvent(revertCask, 30 * 1000, toPosition)
	end
	-- Postman Quest
	if(itemEx.actionid == 100 and itemEx.itemid == 2593) then
		if(getPlayerStorageValue(cid,250) == 3) then
			setPlayerStorageValue(cid,250, 4)
			doSendMagicEffect(toPosition, CONST_ME_MAGIC_BLUE)
		end
	end
	return true
end