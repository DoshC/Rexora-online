local config = {
	[14080] = TheAncientTombs.ThalasSwitchesGlobalStorage,
	[14081] = TheAncientTombs.DiprathSwitchesGlobalStorage,
	[14082] = TheAncientTombs.AshmunrahSwitchesGlobalStorage
}

local function resetScript(position, storage)
	local item = getTileItemById(position, 1946)
	if item then
		doTransformItem(item.uid,1945)
	end

	setGlobalStorageValue(storage, getGlobalStorageValue(storage) - 1)
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local storage = config[item.actionid]
	if not storage then
		return true
	end

	if item.itemid ~= 1945 then
		return false
	end

	setGlobalStorageValue(storage, getGlobalStorageValue(storage) + 1)
	doTransformItem(item.uid,1946)
	addEvent(resetScript, 4 * 60 * 1000, toPosition, storage)
	return true
end