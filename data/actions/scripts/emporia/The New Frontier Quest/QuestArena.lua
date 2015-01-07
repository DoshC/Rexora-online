local config = {
	bosses = {
		{'Baron Brute', 'The Axeorcist'},
		{'Menace', 'Fatality'},
		{'Incineron', 'Coldheart'},
		{'Dreadwing', 'Doomhowl'},
		{'Haunter', 'The Dreadorian'},
		{'Rocko', 'Tremorak'},
		{'Tirecz'}
	},

	teleportPositions = {
		Position(33059, 31032, 3),
		Position(33057, 31034, 3)
	},

	positions = {
		-- other bosses
		Position(33065, 31035, 3),
		Position(33068, 31034, 3),

		-- first 2 bosses
		Position(33065, 31033, 3),
		Position(33066, 31037, 3)
	}
}

local function summonBoss(name, position)
	doCreateMonster(name, position)
	doSendMagicEffect(position,CONST_ME_TELEPORT)
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player1 = getTopCreature({x = 33080, y = 31014, z = 2}).uid
	if not(player1 and isPlayer(player1)) then
		return true
	end

	local player2 =getTopCreature({x = 33081, y = 31014, z = 2}).uid
	if not(player2 and isPlayer(player2)) then
		return true
	end

	if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 25 then
		doPlayerSendTextMessage(cid,MESSAGE_STATUS_SMALL, 'You already finished this battle.')
		return true
	end

	if getPlayerStorageValue(cid,TheNewFrontier.Mission09) == 1 then
		doPlayerSendTextMessage(cid,MESSAGE_STATUS_SMALL, 'The arena is already in use.')
		return true
	end

	setPlayerStorageValue(cid,TheNewFrontier.Mission09, 1)
	addEvent(clearArena, 30 * 60 * 1000, {x = 33053, y = 31024, z = 3}, {x = 33074, y = 31044, z = 3})
	doTeleportThing(player1, config.teleportPositions[1])
	doSendMagicEffect(getPlayerPosition(player1),CONST_ME_TELEPORT)
	doTeleportThing(player2, config.teleportPositions[2])
	doSendMagicEffect(getPlayerPosition(player2),CONST_ME_TELEPORT)

	for i = 1, #config.bosses do
		for j = 1, #config.bosses[i] do
			addEvent(summonBoss, (i - 1) * 90 * 1000, config.bosses[i][j], config.positions[j + (i == 1 and 2 or 0)])
		end
	end
	return true
end