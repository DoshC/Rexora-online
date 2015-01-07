--By Benji69--

function onUse(cid, item, position, fromPosition, topos)

local posup= {x=32636, y =31881, z=2}
local playerpos= {x=32636, y =31881, z=7, stackpos=253}
local getpos= getThingfromPos(playerpos)

     if isPlayer(cid) == TRUE and  item.actionid == 9653 then
		if getpos.itemid > 0 then
				doTeleportThing(cid, posup)
				doSendMagicEffect(posup,10)
				doCreatureSay(cid, "Welcome To Kazordoon.",19)
		else
            doCreatureSay(cid, "You are not standing in the right place.",19)
        end
     end
end