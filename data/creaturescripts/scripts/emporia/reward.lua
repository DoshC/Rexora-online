local count = {}
local t = {
	39001, {
	[50] = {2160, 5, "Se ha transferido 50k a tu bank.", 1},
	[100] = {2160, 10, "Se ha transferido 100k a tu bank.", 2},
	[150] = {2160, 15, "Se ha transferido 150k a tu bank.", 3},
	[200] = {2160, 20, "Se ha transferido 200k a tu bank.", 4}
	}
}

function onAdvance(cid, skill, oldlevel, newlevel)
	if skill == SKILL__LEVEL then
		for level, v in pairs(t[2]) do
			if oldlevel < level and getPlayerLevel(cid) >= level and getPlayerStorageValue(cid, t[1]) < v[4] then
				doPlayerAddItem(cid, v[2], v[3],count[cid])
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, v[3])
				setPlayerStorageValue(cid, t[1], v[4])
			end
		end
	end
	doPlayerSave(cid, true) 
	return true
end