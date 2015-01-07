local stairsPosition = {x = 33265, y = 31116, z = 7}

local function revertStairs()
	doTransformItem(getTileItemById(config.stairsPosition,9197).uid, 3219)
end

function onStepIn(creature, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end

	-- check if going upstairs
	if not getTileItemById(position,3687) then
		return true
	end

	local stairs = getTileItemById(stairsPosition,3219)
	if stairs then
		doTransformItem(stairs,9197)
		addEvent(revertStairs, 5 * 30 * 1000)
	end

	doCreatureSay(cid,'The area around the gate is suspiciously quiet, you have a bad feeling about this.', TALKTYPE_MONSTER_SAY)
	if getPlayerStorageValue(cid,ChildrenoftheRevolution.Mission05) >= 1 then
		--Questlog, Children of the Revolution 'Mission 5: Phantom Army'
		setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission05, 2)
	end
	return true
end