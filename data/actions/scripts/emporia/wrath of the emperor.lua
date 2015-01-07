function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.actionid == 103 and getPlayerStorageValue(cid, STORAGE_ZLAK) == 4) then
		if(getPlayerPosition(cid).x == POS_LEVER_TELEPORT[1].x and getPlayerPosition(cid).y == POS_LEVER_TELEPORT[1].y) then
			doTeleportThing(cid, POS_LEVER_TELEPORT[2])
			doSendMagicEffect(POS_LEVER_TELEPORT[2], CONST_ME_TELEPORT)
		elseif(getPlayerPosition(cid).x == POS_LEVER_TELEPORT[2].x and getPlayerPosition(cid).y == POS_LEVER_TELEPORT[2].y) then
			doTeleportThing(cid, POS_LEVER_TELEPORT[1])
			doSendMagicEffect(POS_LEVER_TELEPORT[1], CONST_ME_TELEPORT)
		end
	end
	
	if(item.acionid == 102) then -- a hole to teleport back from the zumtah prison
		if(getPlayerStorageValue(cid, STORAGE_EXIT) == 1) then
			doTeleportThing(cid, POS_PRISON_EXIT)
			doSendMagicEffect(POS_PRISON_EXIT, CONST_ME_TELEPORT)
			doSetCreatureOutfit(cid, {lookType = 352}, 1)
			setPlayerStorageValue(cid, STORAGE_EXIT, 0)
		end
	end

	if(REAGENTS[item.itemid]) then
		local ID = (REAGENTS[item.itemid].ITEMEX)[1] and itemEx.actionid or itemEx.itemid
		if(ID == (REAGENTS[item.itemid].ITEMEX)[2]) then
			if(getPlayerStorageValue(cid, REAGENTS[item.itemid].STORAGE) < 1) then
				doPlayerAddItem(cid, REAGENTS[item.itemid].ADDITEM, 1)
				setPlayerStorageValue(cid, REAGENTS[item.itemid].STORAGE, 1)
				doCreatureSay(cid, REAGENTS[item.itemid].TEXT, TALKTYPE_ORANGE_1)
			end
		end
	end
	
	if(item.itemid == 5908 and itemEx.itemid == 12295) then -- carving a bowl - ob knife
		doTransformItem(itemEx.uid, 12287)
		doCreatureSay(cid, "You carve a solid bowl of the chunk of wood.", TALKTYPE_ORANGE_1)
	elseif(item.itemid == 12285 and itemEx.itemid == 12297) then -- combine earth with clay
		doCreatureSay(cid, "You carefully mix the clay with the sacred earth.", TALKTYPE_ORANGE_1)
		doRemoveItem(item.uid)
		doRemoveItem(itemEx.uid)
		doPlayerAddItem(cid, 12300, 1)
	elseif(item.itemid == 12300 and itemEx.itemid == 12287) then -- combine bowl with sacred clay
		doCreatureSay(cid, "You carefully coat the inside of the wooden bowl with the sacred clay.", TALKTYPE_ORANGE_1)
		doRemoveItem(itemEx.uid)
		doTransformItem(item.uid, 12303)
	elseif(item.itemid == 12303 and itemEx.itemid == 11450) then -- combine sacred bowl with water
		doCreatureSay(cid, "Filling the corrupted water into the sacred bowl completly purifies the fluid.", TALKTYPE_ORANGE_1)
		doTransformItem(item.uid, 12289)
	elseif(item.itemid == 12289 and itemEx.itemid == 12301) then -- coal gathering
		doTransformItem(item.uid, 12290)
		doSendMagicEffect(getThingPos(itemEx.uid), CONST_ME_POFF)
	elseif(item.itemid == 12290 and itemEx.itemid == 12304) then -- coal usage - water clean, teleport done
		doCreatureSay(cid, "As you give the coal into the pool the corrupted fluid begins to dissolve, leaving purified, refreshing water.", TALKTYPE_ORANGE_1)
		doRemoveItem(item.uid)
		setPlayerStorageValue(cid, STORAGE_TELEPORT, 1)
	end
	
	if(item.actionid == 130) then -- combine scepter
		if(getPlayerItemCount(cid, 12324) >= 1 and getPlayerItemCount(cid, 12325) >= 1 and getPlayerItemCount(cid, 12326) >= 1 and getPlayerStorageValue(cid, STORAGE_SCEPTRE) < 1) then
			doPlayerRemoveItem(cid, 12324, 1)
			doPlayerRemoveItem(cid, 12325, 1)
			doPlayerRemoveItem(cid, 12326, 1)
			doPlayerAddItem(cid, 12327, 1)
			doSendMagicEffect(getThingPos(item.uid), CONST_ME_TELEPORT)
			setPlayerStorageValue(cid, STORAGE_SCEPTRE, 1)
		end
	end
	
	if(itemEx.itemid == 12383 and item.itemid == 12318) then -- summoning boss
		doTransformItem(itemEx.uid, itemEx.itemid + 1)
		addEvent(doTransformItem, 3 * 60 * 1000, itemEx.uid, itemEx.itemid - 1)
		doSummonCreature(BOSSES[itemEx.actionid], getClosestFreeTile(cid, getThingPos(itemEx.uid)))
		addEvent(doRemoveCreature, 3 * 60 * 1000, BOSSES[itemEx.actionid])
		setGlobalStorageValue(itemEx.actionid, 1)
		addEvent(setGlobalStorageValue, 3 * 60 * 1000, itemEx.actionid, 0)
	end
	
	if(isInArray({120, 121, 122, 123}, item.actionid)) then -- boss corpse
		if(getPlayerStorageValue(cid, item.actionid) < 1 and getPlayerStorageValue(cid, STORAGE_BOSS) ~= 4) then
			setPlayerStorageValue(cid, STORAGE_BOSS, math.max(0, getPlayerStorageValue(cid, STORAGE_BOSS)) + 1)
			setPlayerStorageValue(cid, item.actionid, 1)
			doSendMagicEffect(getThingPos(item.uid), CONST_ME_HOLYDAMAGE)
		end
		setPlayerStorageValue(cid, itemEx.actionid, 1)
	elseif(item.actionid == 110) then -- teleport to the last room
		for x = 33357, 31404 do
			for y = 33362, 31409 do
				pos = {x = x, y = y, z = getCreaturePosition(cid).z}
				if(isPlayer(getTopCreature(pos).uid)) then
					doTeleportThing(getTopCreature(pos).uid, POS_LAST_ROOM)
					doSendMagicEffect(POS_LAST_ROOM, CONST_ME_TELEPORT)
				end
			end
		end
		if(not(getCreatureByName("Snake God Essence"))) then
			doSummonCreature("Snake God Essence", {x = 33360, y = 31406, z = 10})
		end
	end
	
	if(item.itemid == 12385 and getPlayerStorageValue(cid, STORAGE_END) == 1) then
		setPlayerStorageValue(cid, STORAGE_END, 2)
		doSendMagicEffect(toPosition, CONST_ME_MAGIC_RED)
	end
	
	if(item.itemid == 12320 and itemEx.itemid == 12292 and not(getCreatureByName("the keeper"))) then -- the keeper summon
		doSummonCreature("the keeper", getClosestFreeTile(cid, toPosition))
	end
	
	if(item.itemid == 12316) then -- the keeper corpse
		if(getPlayerStorageValue(cid, STORAGE_THE_KEEPER) < 1) then
			doPlayerAddItem(cid, 12323, 1)
			setPlayerStorageValue(cid, STORAGE_THE_KEEPER, 1)
			doSendMagicEffect(toPosition, CONST_ME_MAGIC_GREEN)
		end
	end
	
	if(item.itemid == 12318 and itemEx.itemid == 12385) then
		if(getPlayerStorageValue(cid, STORAGE_END) < 3) then
			setPlayerStorageValue(cid, STORAGE_END, 3)
			doSendMagicEffect(toPosition, CONST_ME_MAGIC_RED)
		end
	end
	
	if(isInArray({113, 114, 115}, item.actionid)) then -- item reward
		if(getPlayerStorageValue(cid, STORAGE_PRIZE) < 1) then
			doPlayerAddItem(cid, PRIZE[item.actionid], 1)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have found " .. getItemArticleById(PRIZE[item.actionid]) .. " " .. getItemNameById(PRIZE[item.actionid]) .. ".")
			setPlayerStorageValue(cid, STORAGE_PRIZE, 1)
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It's empty.")
		end
	end
	
	if(item.actionid == 116) then -- outfit
		if(getPlayerStorageValue(cid, STORAGE_OUTFIT) < 1) then
			for i = 366, 367 do
				doPlayerAddOutfit(cid, i, 3)
			end
			setPlayerStorageValue(cid, STORAGE_OUTFIT, 1)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You've found some clothes in wardrobe")
		else
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The wardrobe is empty.")
		end
	end
	
	if(item.actionid == 117) then -- reward room door
		storageDoors(cid, item.uid, "vertical", STORAGE_END, 4)
	elseif(item.actionid == 131) then -- izsh doors
		storageDoors(cid, item.uid, "vertical", STORAGE_END, 3)
	elseif(item.actionid == 132) then -- zalamon doors
		storageDoors(cid, item.uid, "horizontal", STORAGE_PREQUEST, 1)
	elseif(item.actionid == 133) then -- izsh doors
		storageDoors(cid, item.uid, "vertical", STORAGE_CHARTAN, 2)
	end
	return true
end