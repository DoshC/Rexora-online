function onSay(cid, words, param, channel)
		if getPlayerLevel(cid) >= 8 then
		doPlayerSendTextMessage(cid, 18, "Report have been send.")
		db.executeQuery("INSERT INTO `server_reports` ( `id` , `world_id` , `player_id` , `posx` , `posy` , `posz` , `timestamp` , `report` ) VALUES (NULL , "..getConfigValue("worldId")..", "..getPlayerGUID(cid)..", ".. getThingPos(cid).x ..", ".. getThingPos(cid).y ..", ".. getThingPos(cid).z ..", "..os.time()..", '"..param.."');")
		end
	return true
end