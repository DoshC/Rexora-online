function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.itemid == 11100) then
	local player = isPlayer(cid)
		if(itemEx.actionid == 14066) then
			if(getPlayerStorageValue(cid,TheNewFrontier.Questline) == 5) and (getPlayerStorageValue(cid,TheNewFrontier.Beaver1) < 1) then
				doCreateMonster("thieving squirrel", toPosition)
				doSendMagicEffect(toPosition,CONST_ME_TELEPORT)
				setPlayerStorageValue(cid,TheNewFrontier.Beaver1, 1)
				setPlayerStorageValue(cid,TheNewFrontier.Mission02, getPlayerStorageValue(cid,TheNewFrontier.Mission02) + 1) --Questlog, The New Frontier Quest "Mission 02: From Kazordoon With Love"
				doCreateMonster("thieving squirrel", toPosition)
				doCreatureSay(cid,"You've marked the tree, but its former inhabitant has stolen your bait! Get it before it runs away!", TALKTYPE_MONSTER_SAY)
				doRemoveItem(item.uid)
			end
		elseif(itemEx.actionid == 14067) then
			if(getPlayerStorageValue(cid,TheNewFrontier.Questline) == 5) and (getPlayerStorageValue(cid,TheNewFrontier.Beaver2) < 1) then
				for i = 1, 5 do
					pos = toPosition
					doCreateMonster("wolf", pos)
					doSendMagicEffect(toPosition,CONST_ME_TELEPORT)
				end
				doCreateMonster("war wolf", toPosition)
				doSendMagicEffect(toPosition, CONST_ME_TELEPORT)
				setPlayerStorageValue(cid,TheNewFrontier.Beaver2, 1)
				setPlayerStorageValue(cid,TheNewFrontier.Mission02, getPlayerStorageValue(cid,TheNewFrontier.Mission02) + 1) --Questlog, The New Frontier Quest "Mission 02: From Kazordoon With Love"
				doCreatureSay(cid,"You have marked the tree but it seems someone marked it already! He is not happy with your actions and he brought friends!", TALKTYPE_MONSTER_SAY)
			end
		elseif(itemEx.actionid == 14068) then
			if(getPlayerStorageValue(cid,TheNewFrontier.Questline) == 5) and (getPlayerStorageValue(cid,TheNewFrontier.Beaver3) < 1) then
				for i = 1, 3 do
					pos = toPosition
					doCreateMonster("enraged squirrel", pos)
					doSendMagicEffect(toPosition,CONST_ME_TELEPORT)
				end
				setPlayerStorageValue(cid,TheNewFrontier.Beaver3, 1)
				setPlayerStorageValue(cid,TheNewFrontier.Mission02, getPlayerStorageValue(cid,TheNewFrontier.Mission02) + 1) --Questlog, The New Frontier Quest "Mission 02: From Kazordoon With Love"
				doCreatureSay(cid,"You have marked the tree, but you also angered the aquirrel family who lived on it!", TALKTYPE_MONSTER_SAY)
			end
		end
		if(getPlayerStorageValue(cid,TheNewFrontier.Beaver1) == 1) and (getPlayerStorageValue(cid,TheNewFrontier.Beaver2) == 1) and (getPlayerStorageValue(cid,TheNewFrontier.Beaver3) == 1)then
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 6)
		end
	end
	return true
end