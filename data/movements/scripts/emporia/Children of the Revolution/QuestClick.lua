local config = {
	positions = {
		{x = 33258, y = 31080, z = 8},
		{x = 33266, y = 31084, z = 8},
		{x = 33259, y = 31089, z = 8},
		{x = 33263, y = 31093, z = 8}
	},
	stairsPosition = {x = 33265, y = 31116, z = 8},
	areaCenter = {x = 33268, y = 31119, z = 7},
	zalamonPosition = {x = 33353, y = 31410, z = 8}
	
}

function doClearMissionArea()
local spectator = getSpectators(config.areaCenter, 26, 26)
	for i = 1, #spectator do
		if isPlayer(spectator[i]) then
		doTeleportThing(spectator[i],config.zalamonPosition)
		setPlayerStorageValue(spectator[i],5000, -1)
		doSendMagicEffect(getCreaturePosition(spectator[i]),CONST_ME_TELEPORT)
		if getPlayerStorageValue(spectator[i],ChildrenoftheRevolution.Questline) < 1 then
			setGlobalStorageValue(ChildrenoftheRevolution.Questline, 20)
	   end	
	end
end
return true
end

local function removeStairs()
	doTransformItem(getTileItemById(config.stairsPosition,3687).uid,3653)
end

local function summonWave(i)
	local summonPosition = Position(math.random(33252, 33288), math.random(31105, 31134), 7)
	doCreateMonster(i < 3 and 'eternal guardian' or 'lizard chosen', summonPosition)
	doSendMagicEffect(summonPosition,CONST_ME_TELEPORT)
end

function onStepIn(cid, item, position, fromPosition)
	if getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) < 1
			or getPlayerStorageValue(cid,ChildrenoftheRevolution.Mission05) < 1 then
		return true
	end

	local players = {}
	for i = 1, #config.positions do
		local creature = getTopCreature(config.positions[i])
		if creature then
			table.insert(players, creature)
		end
	end

	if #players == #config.positions then
		for i = 1, #players do
			doCreatureSay(cid,"A clicking sound tatters the silence.", TALKTYPE_MONSTER_SAY)
		end

		doTransformItem(getTileItemById(config.stairsPosition,3653).uid,3687)
		addEvent(removeStairs, 30 * 1000)

		setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission05, 1)
		for wave = 1, 4 do
			for i = 1, 20 do
				addEvent(summonWave, wave * 30 * 1000, wave)
			end
		end
		addEvent(doClearMissionArea, 5 * 30 * 1000)
	end
	return true
end
