local rewards = {
	[1300] = 8890,
	[1301] = 8918,
	[1302] = 8881,
	[1303] = 8888,
	[1304] = 8851,
	[1305] = 8924,
	[1306] = 8928,
	[1307] = 8930,
	[1308] = 8854
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = isPlayer(cid)
	if(getPlayerStorageValue(cid,TheInquisition.Reward) < 1) then
		setPlayerStorageValue(cid,TheInquisition.Reward, 1)
		setPlayerStorageValue(cid,TheInquisition.Questline, 25)
		setPlayerStorageValue(cid,TheInquisition.Mission07, 5) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
		doPlayerAddItem(cid,rewards[item.uid], 1)
		doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You've found " .. getItemNameById(rewards[item.uid]) .. ".")
	else
		doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "The chest is empty.")
	end
	return true
end
