function onUse(cid, item, fromPosition, itemEx, toPosition)

  if item.itemid == 1946 then
      return doTransformItem(item.uid, item.itemid - 1)
	elseif(item.actionid == 14063) and item.itemid == 1945 then
       doTeleportThing(getTopCreature({x = toPosition.x - 1, y = toPosition.y, z = toPosition.z}).uid, {x = 33065, y = 31489, z = 15})
	elseif (item.actionid == 14064) and item.itemid == 1945 then
		doTeleportThing(getTopCreature({x = toPosition.x + 1, y = toPosition.y, z = toPosition.z}).uid, { x = 33055, y = 31527, z = 10})
	end
		  doTransformItem(item.uid, item.itemid + 1)
	return true
end