--By Benji69--

function onUse(cid, item, position, fromPosition)

local posdown= {x=32636, y =31881, z=7}
local playerpos= {x=32636, y =31881, z=2, stackpos=253}
local getpos= getThingfromPos(playerpos)

     if isPlayer(cid) == TRUE and  item.actionid == 9652 then
		if getpos.itemid > 0 then
	    		doTeleportThing(cid, posdown)
	    		doSendMagicEffect(posdown,10)
		else
            doCreatureSay(cid, "You are not standing in the right place.",19)
         end
     end
end