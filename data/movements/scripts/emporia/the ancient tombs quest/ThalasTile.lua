local condition = (CONDITION_POISON)

function onStepIn(creature, item, position, fromPosition)
	local player = isPlayer(cid)
	if not player then
		return true
	end

	doSendMagicEffect(getPlayerPosition(cid),CONST_ME_GREEN_RINGS)
	doAddCondition(cid,condition)
	doTransformItem(item.uid,417)
	return true
end