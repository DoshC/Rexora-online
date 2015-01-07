local teleports2 = {
	[2150] = {text = "Entering Ushuriel's ward.", newPos = Position(33158, 31728, 11), storage = 0} -- to ushuriel ward
}

local teleports = {
	[2151] = {boss = true, text = "Entering the Crystal Caves.", bossStorage = 200, newPos = Position(33069, 31782, 13), storage = 1}, -- from ushuriel ward
	[2152] = {text = "Escaping back to the Retreat.", newPos = Position(33165, 31709, 14)}, -- from crystal caves
	[2153] = {text = "Entering the Crystal Caves.", newPos = Position(33069, 31782, 13), storage = 1}, -- to crystal caves
	[2154] = {text = "Entering the Sunken Caves.", newPos = Position(33169, 31755, 13)}, -- to sunken caves
	[2155] = {text = "Entering the Mirror Maze of Madness.", newPos = Position(33065, 31772, 10)}, -- from sunken caves
	[2156] = {text = "Entering Zugurosh's ward.", newPos = Position(33124, 31692, 11)}, -- to zugurosh ward
	[2157] = {boss = true, text = "Entering the Blood Halls.", bossStorage = 201, newPos = Position(33372, 31613, 14), storage = 2}, -- from zugurosh ward
	[2158] = {text = "Escaping back to the Retreat.", newPos = Position(33165, 31709, 14)}, -- from blood halls
	[2159] = {text = "Entering the Blood Halls.", newPos = Position(33372, 31613, 14), storage = 2}, -- to blood halls
	[2160] = {text = "Entering the Foundry.", newPos = Position(33356, 31589, 11)}, -- to foundry
	[2161] = {text = "Entering Madareth's ward.", newPos = Position(33197, 31767, 11)}, -- to madareth ward
	[2162] = {boss = true, text = "Entering the Vats.", bossStorage = 202, newPos = Position(33153, 31782, 12), storage = 3}, -- from madareth ward
	[2163] = {text = "Escaping back to the Retreat.", newPos = Position(33165, 31709, 14)}, -- from vats
	[2164] = {text = "Entering the Vats.", newPos = Position(33153, 31782, 12), storage = 3}, -- to vats
	[2165] = {text = "Entering the Battlefield.", newPos = Position(33250, 31632, 13)}, -- to battlefield
	[2166] = {text = "Entering the Vats.", newPos = Position(33233, 31758, 12)}, -- from battlefield
	[2167] = {text = "Entering the Demon Forge.", newPos = Position(33232, 31733, 11)}, -- to brothers ward
	[2168] = {boss = true, text = "Entering the Arcanum.", bossStorage = 203, newPos = Position(33038, 31753, 15), storage = 4}, -- from demon forge
	[2169] = {text = "Escaping back to the Retreat.", newPos = Position(33165, 31709, 14)}, -- from arcanum
	[2170] = {text = "Entering the Arcanum.", newPos = Position(33038, 31753, 15), storage = 4}, -- to arcanum
	[2171] = {text = "Entering the Soul Wells.", newPos = Position(33093, 31575, 11)}, -- to soul wells
	[2172] = {text = "Entering the Arcanum.", newPos = Position(33186, 31759, 15)}, -- from soul wells
	[2173] = {text = "Entering the Annihilon's ward.", newPos = Position(33197, 31703, 11)}, -- to annihilon ward
	[2174] = {boss = true, text = "Entering the Hive.", bossStorage = 204, newPos = Position(33199, 31686, 12), storage = 5}, -- from annihilon ward
	[2175] = {text = "Escaping back to the Retreat.", newPos = Position(33165, 31709, 14)}, -- from hive
	[2176] = {text = "Entering the Hive.", newPos = Position(33199, 31686, 12), storage = 5}, -- to hive
	[2177] = {text = "Entering the Hellgorak's ward.", newPos = Position(33104, 31734, 11)}, -- to hellgorak ward
	[2178] = {boss = true, text = "Entering the Shadow Nexus. Abandon all Hope.", bossStorage = 205, newPos = Position(33110, 31682, 12), storage = 6}, -- from hellgorak ward
	[2179] = {text = "Escaping back to the Retreat.", newPos = Position(33165, 31709, 14)}, -- from shadow nexus
	[2180] = {text = "Entering the Blood Halls.", newPos = Position(33357, 31589, 12)} -- from foundry to blood halls
}
function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end
	if item.uid == 2150 then
		if getPlayerStorageValue(cid,TheInquisition.EnterTeleport) <= teleports2[item.uid].storage then
			setPlayerStorageValue(cid,TheInquisition.EnterTeleport, teleports2[item.uid].storage)
		end
		doTeleportThing(cid,teleports2[item.uid].newPos)
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		doCreatureSay(cid,teleports2[item.uid].text, TALKTYPE_MONSTER_SAY)
	return true	
	end

	local tp = teleports[item.uniqueid].boss
	if tp then
		if getGlobalStorageValue(teleports[item.uid].bossStorage) == 2 then
			if getPlayerStorageValue(cid,TheInquisition.EnterTeleport) <= teleports[item.uid].storage then
				setPlayerStorageValue(cid,TheInquisition.EnterTeleport, teleports[item.uid].storage)
			end
			doTeleportThing(cid,teleports[item.uid].newPos)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			doCreatureSay(cid,teleports[item.uid].text, TALKTYPE_MONSTER_SAY)
		else
			doTeleportThing(cid,Position(33165, 31709, 14))
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			doCreatureSay(cid,"Escaping back to the Retreat.", TALKTYPE_MONSTER_SAY)
		end
		return true
	end
	
	local tps = teleports[item.uid].storage 
	if tps then
		if getPlayerStorageValue(cid,TheInquisition.EnterTeleport) >= teleports[item.uid].storage then
			doTeleportThing(cid,teleports[item.uid].newPos)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			doCreatureSay(cid,teleports[item.uid].text, TALKTYPE_MONSTER_SAY)
		else
			doTeleportThing(cid,fromPosition)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			doCreatureSay(cid,'You don\'t have enough energy to enter this portal', TALKTYPE_MONSTER_SAY)
		end
		return true
	end

	if teleports[item.uid] then
		doTeleportThing(cid,teleports[item.uid].newPos)
		doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
		doCreatureSay(cid,teleports[item.uid].text, TALKTYPE_MONSTER_SAY)
		return true
	end
	return true
end