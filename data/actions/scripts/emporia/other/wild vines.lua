local position = {x = 33022, y = 31536, z = 6}
		
     function onUse(cid, item, fromPosition, itemEx, toPosition)
	doTeleportThing(cid, position)
   doSendMagicEffect(getPlayerPosition(cid),CONST_ME_POFF)
  return true
end