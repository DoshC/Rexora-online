function onSay(cid, words, param, channel)
local quests = {6076, 50013, 11000, 254200, 12900, 43345, 5050, 42381, 42361, 42371, 45865, 6000, 6001, 6002, 6003, 6004, 6005, 6006, 6007, 6008, 6009, 6010, 6011, 6012, 6013, 6014, 6015, 6016, 6017, 6018, 6019} -- Change/add numbers to the unique ids on your quest chests.
local completed = {}
	for i = 1, #quests do
		if getPlayerStorageValue(cid, quests[i]) > 0 then
			table.insert(completed, 1)
		end
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have completed ".. #completed .. " of " .. #quests .. " quests.")
	end
return true
end