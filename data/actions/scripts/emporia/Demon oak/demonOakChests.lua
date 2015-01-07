local chests = {
	[12901] = 2495, 
	[12902] = 8905, 
	[12903] = 8851,
	[12904] = 8918
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	if getPlayerStorageValue(cid,DemonOak.Done) == 2 then
		doPlayerAddItem(cid,chests[item.uid], 1)
		doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found " .. getItemNameById(chests[item.uid]) .. ".")
		doPlayerSetStorageValue(cid,DemonOak.Done, 3)
		else
		doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, 'It\'s empty.')
	end
	return true
end