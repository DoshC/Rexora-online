local config = {
	demonOakIds = {8288, 8289, 8290, 8291},
	sounds = {
		'MY ROOTS ARE SHARP AS A SCYTHE! FEEL IT?!?',
		'CURSE YOU!',
		'RISE, MINIONS, RISE FROM THE DEAD!!!!',
		'AHHHH! YOUR BLOOD MAKES ME STRONG!',
		'GET THE BONES, HELLHOUND! GET THEM!!',
		'GET THERE WHERE I CAN REACH YOU!!!',
		'ETERNAL PAIN AWAITS YOU! NICE REWARD, HUH?!?!',
		'YOU ARE GOING TO PAY FOR EACH HIT WITH DECADES OF TORTURE!!',
		'ARGG! TORTURE IT!! KILL IT SLOWLY MY MINION!!'
	},
	bonebeastChance = 90,
	bonebeastCount = 4,
	waves = 10,
	questArea = {
		fromPosition = {x = 32706, y = 32345, z = 7},
		toPosition = {x = 32725, y = 32357, z = 7}
	},
	summonPositions = {
		{x = 32714, y = 32348, z = 7},
		{x = 32712, y = 32349, z = 7},
		{x = 32711, y = 32351, z = 7},
		{x = 32713, y = 32354, z = 7},
		{x = 32716, y = 32354, z = 7},
		{x = 32719, y = 32354, z = 7},
		{x = 32721, y = 32351, z = 7},
		{x = 32719, y = 32348, z = 7}
	},
	summons = {
		[8288] = {
			[5] = {'Braindeath', 'Braindeath', 'Braindeath', 'Bonebeast'},
			[10] = {'Betrayed Wraith', 'Betrayed Wraith'}
		},
		[8289] = {
			[5] = {'Lich', 'Lich', 'Lich'},
			[10] = {'Dark Torturer', 'Blightwalker'}
		},
		[8290] = {
			[5] = {'Banshee', 'Banshee', 'Banshee'},
			[10] = {'Grim Reaper'}
		},
		[8291] = {
			[5] = {'Giant Spider', 'Giant Spider', 'Lich'},
			[10] = {'Undead Dragon', 'Hand of Cursed Fate'}
		}
	}
}

local function getRandomSummonPosition()
	return config.summonPositions[math.random(#config.summonPositions)]
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if not isInArray(config.demonOakIds, itemEx.itemid) then
		return true
	end

	local player = isPlayer(cid)

	local totalProgress = 0
	for i = 1, #config.demonOakIds do
		totalProgress = totalProgress + math.max(getPlayerStorageValue(cid,config.demonOakIds[i])or 0)
	end

	local isDefeated = totalProgress == (#config.demonOakIds * (config.waves + 1))
	if (config.killAllBeforeCut or isDefeated)
			and isMonster(config.questArea.fromPosition, config.questArea.toPosition, true, true) then
		doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, 'You need to kill all monsters first.')
		return true
	end

	if isDefeated then
		doTeleportThing(cid,DEMON_OAK_KICK_POSITION)
		doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE, 'Tell Oldrak about your great victory against the demon oak.')
		setPlayerStorageValue(cid,DemonOak.Done, 1)
		setPlayerStorageValue(cid,DemonOak.Progress, 3)
		return true
	end

	local progress = math.max(getPlayerStorageValue(cid,itemEx.itemid), 1)
	if progress >= config.waves + 1 then
		doSendMagicEffect(toPosition,CONST_ME_POFF)
		return true
	end

	local isLastCut = totalProgress == (#config.demonOakIds * (config.waves + 1) - 1)
	local summons = config.summons[itemEx.itemid]
	if summons and summons[progress] then
		-- Summon a single demon on the last hit
		if isLastCut then
			doCreateMonster('Demon', getRandomSummonPosition(), false, true)

		-- Summon normal monsters otherwise
		else
			for i = 1, #summons[progress] do
				doCreateMonster(summons[progress][i], getRandomSummonPosition(), false, true)
			end
		end

	-- if it is not the 5th or 10th there is only a chance to summon bonebeasts
	elseif math.random(100) >= config.bonebeastChance then
		for i = 1, config.bonebeastCount do
			doCreateMonster('Bonebeast', getRandomSummonPosition(), false, true)
		end
	end

	doCreatureSay(cid,isLastCut and "HOW IS THAT POSSIBLE?!? MY MASTER WILL CRUSH YOU!! AHRRGGG!" or config.sounds[math.random(#config.sounds)], TALKTYPE_MONSTER_YELL, false, cid, DEMON_OAK_POSITION)
	doSendMagicEffect(toPosition,CONST_ME_DRAWBLOOD)
	setPlayerStorageValue(cid,itemEx.itemid, progress + 1)
	doCreatureSay(cid,'-krrrrak-', TALKTYPE_MONSTER_YELL, false, cid, toPosition)
	doTargetCombatHealth(0, cid, COMBAT_EARTHDAMAGE, -170, -210, CONST_ME_BIGPLANTS)
	return true
end