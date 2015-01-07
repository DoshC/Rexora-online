local config = {
	arenaPosition = Position(33154, 31415, 7),
	exitPosition = Position(33146, 31414, 6),
	successPosition = Position(33145, 31419, 7)
}

local function completeTest(cid)
	local player = isPlayer(cid)
	if not player then
		return true
	end

	if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 19 then
		doTeleportThing(cid,config.successPosition)
		doCreatureSay(cid,'You have passed the test. Report to Curos.', TALKTYPE_MONSTER_SAY)
	end
end

function onStepIn(cid, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end

	if item.actionid == 14066 then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 18 then
			addEvent(completeTest, 2 * 60 * 1000, cid)
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 19)
			doTeleportThing(cid,config.arenaPosition)
			doSendMagicEffect(config.arenaPosition,CONST_ME_TELEPORT)
		else
			doTeleportThing(cid,fromPosition)
			doSendMagicEffect(fromPosition,CONST_ME_TELEPORT)
			doPlayerSendTextMessage(cid,MESSAGE_STATUS_SMALL, 'You don\'t have access to this area.')
		end
	elseif item.actionid == 14067 then
		setPlayerStorageValue(cid,TheNewFrontier.Questline, 17)
		doTeleportThing(cid,config.exitPosition)
		doSendMagicEffect(config.exitPosition,CONST_ME_TELEPORT)
		doCreatureSay(cid,'You left the arena. Ask Curos again for the mission!', TALKTYPE_MONSTER_SAY)
	end
	return true
end
