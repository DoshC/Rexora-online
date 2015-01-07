local config = {
	[50000] = {position = Position(32259, 31891, 10), revert = true},
	[50001] = {position = Position(32259, 31890, 10), revert = true},
	[50002] = {position = Position(32266, 31860, 11)},

	time = 100
}

local function revertWall(wallPosition, leverPosition)
	local leverItem = getTileItemById(leverPosition,1946)
	if leverItem then
		doTransformItem(item.uid,1945)
	end

	doCreateItem(1498,1, wallPosition)
end

local function removeWall(position)
	local tile = getThingFromPos(position)
	if not tile then
		return
	end

	local thing = getTileItemById(tile,1498)
	if thing then
		doRemoveItem(getThingFromPos(thing.uid).uid)
		doSendMagicEffect(position,CONST_ME_MAGIC_RED)
	end
end

function onUse(cid, item, frompos, item2, topos)
	if item.itemid ~= 1945 then
		doPlayerSendCancel(cid,"The lever has already been used.")
		return true
	end

	local wall = config[item.uid]
	removeWall(wall.position)
	if wall.revert then
		addEvent(revertWall, config.time * 1000, wall.position, toPosition)
	end
	doTransformItem(item.uid,1946)
	return true
end
