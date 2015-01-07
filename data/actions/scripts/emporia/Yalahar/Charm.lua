local pos = {x = 32778, y = 31061, z = 7}
local pos2 = {x = 32778, y = 31062, z = 7}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.itemid == 9737 and itemEx.actionid == 9737 and itemEx.itemid == 471) then
		local player = isPlayer(cid)
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 36) then
			doPlayerRemoveItem(cid,9737, 1)
          		doCreateItem(9738,1,toPosition) 
          		doSendMagicEffect(toPosition,47)
			local ret = doCreateMonster("Tormented Ghost", pos)
   	 		local ret2 = doCreateMonster("Tormented Ghost", pos2)
         	 	doSendMagicEffect(getThingPos(ret), CONST_ME_TELEPORT)
          		doSendMagicEffect(getThingPos(ret2), CONST_ME_TELEPORT)
		end
	end
	return true
	end
