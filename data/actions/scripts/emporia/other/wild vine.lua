local position = {x = 33021, y = 31536, z = 4}
		
     function onUse(cid, item, fromPosition, itemEx, toPosition)
	doTeleportThing(cid, position)
   doSendMagicEffect(getPlayerPosition(cid),CONST_ME_POFF)
  return true
end