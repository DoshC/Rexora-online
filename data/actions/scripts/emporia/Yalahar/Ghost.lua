function onUse(cid, item, fromPosition, itemEx, toPosition)
local player = isPlayer(cid)
		if itemEx.itemid == 9738 then  
			local ret = doCreateMonster("Tormented Ghost", fromPosition)
    		local ret2 = doCreateMonster("Tormented Ghost", fromPosition)    
          	doSendMagicEffect(getThingPos(ret), CONST_ME_TELEPORT)
          	doSendMagicEffect(getThingPos(ret2), CONST_ME_TELEPORT)
          	doSendMagicEffect(toPosition,12)
          	doRemoveItem(item.uid)
			doCreatureSay(cid,"The ghost charm is charging.", TALKTYPE_MONSTER_SAY)
          	doTransformItem(getTileItemById( {x=32776,y=31062,z =7},9738 ).uid, 9739) 
    	elseif itemEx.itemid == 9739 then 
			local ret = doCreateMonster("Tormented Ghost", fromPosition)
    		local ret2 = doCreateMonster("Tormented Ghost", fromPosition)  
          	doSendMagicEffect(getThingPos(ret), CONST_ME_TELEPORT)
          	doSendMagicEffect(getThingPos(ret2), CONST_ME_TELEPORT)
          	doSendMagicEffect(toPosition,12)
          	doRemoveItem(item.uid)
			doCreatureSay(cid,"The ghost charm is charging.", TALKTYPE_MONSTER_SAY)
          	doTransformItem(getTileItemById( {x=32776,y=31062,z =7},9739 ).uid, 9740)
    	elseif itemEx.itemid == 9740 then 
			local ret = doCreateMonster("Tormented Ghost", fromPosition)
    		local ret2 = doCreateMonster("Tormented Ghost", fromPosition)  
          	doSendMagicEffect(getThingPos(ret), CONST_ME_TELEPORT)
          	doSendMagicEffect(getThingPos(ret2), CONST_ME_TELEPORT)
          	doSendMagicEffect(toPosition,12)
          	doRemoveItem(item.uid)
			doCreatureSay(cid,"The ghost charm is charging.", TALKTYPE_MONSTER_SAY)
          	doTransformItem(getTileItemById( {x=32776,y=31062,z =7},9740).uid, 9773)
    	elseif itemEx.itemid == 9773 then
			local ret = doCreateMonster("Tormented Ghost", fromPosition)
    		local ret2 = doCreateMonster("Tormented Ghost", fromPosition)  
          	doSendMagicEffect(getThingPos(ret), CONST_ME_TELEPORT)
          	doSendMagicEffect(getThingPos(ret2), CONST_ME_TELEPORT)
          	doSendMagicEffect(toPosition,12)
          	doRemoveItem(item.uid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 37)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission06, 3) -- StorageValue for Questlog "Mission 06: Frightening Fuel"
			doPlayerRemoveItem(cid,9737, 1)
			doCreatureSay(cid,"The ghost charm is charged.", TALKTYPE_MONSTER_SAY)
          	doTransformItem(getTileItemById( {x=32776,y=31062,z =7},9773).uid, 9742) 
          end  
          return true
end  