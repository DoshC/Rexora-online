function skinMonster(cid,item,skin)
local random = math.random(1,15)
if(random < 4) then
doPlayerAddItem(cid,skin,1)
doSendMagicEffect(getThingPos(item.uid), CONST_ME_MAGIC_GREEN)
else
doSendMagicEffect(getThingPos(item.uid), CONST_ME_BLOCKHIT)
end
doTransformItem(item.uid,item.itemid+1)
end
minotaurs = {2830, 3090, 2871, 2866, 2876}
lizards = {4259, 4262, 4256}
lizardsh = {11269, 11273, 11277, 11281, 11285}
greendragons = {3104, 2844}
reddragons = {2881}
behemoth = {2931}
bonebeast = {3031}
cube = {7441, 7444, 7445}
cube2 = {7442}
marble = {11343}
function onUse(cid, item, fromPosition, itemEx, toPosition)
local random = math.random(1,10)
	if isInArray(minotaurs, itemEx.itemid) == TRUE then
	skinMonster(cid, itemEx, 5878)
	else
		if isInArray(lizards, itemEx.itemid) == TRUE then
		skinMonster(cid, itemEx, 5876)
		else
			if isInArray(lizardsh, itemEx.itemid) == TRUE then
			skinMonster(cid, itemEx, 5876)
			else
				if isInArray(greendragons, itemEx.itemid) == TRUE then
				skinMonster(cid, itemEx, 5877)
				else
					if isInArray(reddragons, itemEx.itemid) == TRUE then
					skinMonster(cid, itemEx, 5948)
					else
						if isInArray(behemoth, itemEx.itemid) == TRUE then
						skinMonster(cid, itemEx, 5893)
						else
							if isInArray(bonebeast, itemEx.itemid) == TRUE then
							skinMonster(cid, itemEx, 5925)
							else
								if isInArray(cube, itemEx.itemid) == TRUE and random < 4 then
								doSendMagicEffect(getThingPos(itemEx.uid), CONST_ME_HITAREA)
								doTransformItem(itemEx.uid, itemEx.itemid + 1)
								else
									if isInArray(cube2, itemEx.itemid) == TRUE and random < 4 then
									doSendMagicEffect(getThingPos(itemEx.uid), CONST_ME_HITAREA)
									doTransformItem(itemEx.uid, itemEx.itemid + 2)
									else
										if (isInArray(cube, itemEx.itemid) == TRUE or isInArray(cube2, itemEx.itemid) == TRUE) and random > 4 then
										doSendMagicEffect(getThingPos(itemEx.uid), CONST_ME_HITAREA)
										doRemoveItem(itemEx.uid)
										doCreatureSay(cid, "The attempt of sculpting failed miserably.", TALKTYPE_MONSTER)
										else
											if isInArray(marble, itemEx.itemid) == TRUE then
												doSendMagicEffect(getThingPos(itemEx.uid), CONST_ME_ICEAREA)
												doRemoveItem(itemEx.uid,1)
												local check = math.random(1,10)
												if(check < 6) then
													goblet = doPlayerAddItem(cid, 11344, 1)
													doItemSetAttribute(goblet, "description", "This shoddy work was made by " .. getCreatureName(cid) .. ".")
												else
													if(check < 8) then
													goblet = doPlayerAddItem(cid, 11345, 1)
													doItemSetAttribute(goblet, "description", "This little figurine made by " .. getCreatureName(cid) .. " has some room for improvement.")
													else
														goblet = doPlayerAddItem(cid, 11346, 1)
														doItemSetAttribute(goblet, "description", "This little figurine of Tibiasula was masterfully sculpted by " .. getCreatureName(cid) .. ".")
													end
												end
											else
											doPlayerSendDefaultCancel(cid, RETURNVALUE_CANNOTUSETHISOBJECT)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
		return true
end