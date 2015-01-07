local shop = {
["change name"] = {id = 2152, cost = 5, charges = 1},
["crystal coins"] = {id = 2160, cost = 5, charges = 50},
["solar axe"] = {id = 8925, cost = 12, charges = 1},
["solar sword"] = {id = 8931, cost = 12, charges = 1},
["dark mace"] = {id = 8927, cost = 10, charges = 1},
["soft boots"] = {id = 6132, cost = 5, charges = 1},
["slingshot"] = {id = 5907, cost = 15, charges = 1},
["star tear"] = {id = 7735, cost = 12, charges = 1},
["demonic essences"] = {id = 6500, cost = 3, charges = 100},
["blessing book"] = {id = 8977, cost = 30, charges = 1},
["stamina feather"] = {id = 2366, cost = 15, charges = 1},
["infinite amulet"] = {id = 2138, cost = 20, charges = 1},
["yalahari mask"] = {id = 9778, cost = 8, charges = 1},
["yalahari armor"] = {id = 9776, cost = 8, charges = 1},
["yalahari legs"] = {id = 9777, cost = 8, charges = 1},
["nightmare shield"] = {id = 6391, cost = 7, charges = 1},
["necromancer shield"] = {id = 6433, cost = 7, charges = 1},
["master archers armor"] = {id = 8888, cost = 8, charges = 1},
["robe of the underworld"] = {id = 8890, cost = 8, charges = 1},
["elite draken helmet"] = {id = 12606, cost = 12, charges = 1},
["snake gods wristguard"] = {id = 12608, cost = 12, charges = 1},
["shield of corruption"] = {id = 12605, cost = 12, charges = 1},
["royal draken mail"] = {id = 12603, cost = 12, charges = 1},
["royal scale robe"] = {id = 12604, cost = 12, charges = 1},
["draken boots"] = {id = 2852, cost = 12, charges = 1},
["kosheis ancient amulet"] = {id = 8266, cost = 5, charges = 1},
["helmet of the ancients"] = {id = 2342, cost = 15, charges = 1},
["earthborn titan armor"] = {id = 8882, cost = 8, charges = 1},
["fireborn giant armor"] = {id = 8881, cost = 8, charges = 1},
["windborn collosus armor"] = {id = 8883, cost = 8, charges = 1},
["royal tapestry"] = {id = 9958, cost = 1, charges = 1},
["blood herb"] = {id = 2798, cost = 3, charges = 10},
["demon legs"] = {id = 2495, cost = 10, charges = 1},
["rainbow shield"] = {id = 8905, cost = 10, charges = 1},
["addon doll"] = {id = 8982, cost = 15, charges = 1}
}

function onSay(cid, words, param, channel)
	if(param == "") then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
		return true
	end
	
local v = shop[param]
	if (not v) then
		doPlayerSendCancel(cid,"Item not found.")
		doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
		return true
    end
	
	local itemm = getItemWeightById(v.id, v.charges)
	if getPlayerFreeCap(cid) < itemm then
        doPlayerSendCancel(cid, "Sorry, you do not have enough cap. You need "..itemm.." oz to carry "..param..".")
		doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    end
    
	if (getAccountPoints(cid) < v.cost) then
        doPlayerSendCancel(cid, "Sorry, you need "..v.cost.." points to buy this item.")
		doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    else
        doPlayerAddItem(cid,v.id,v.charges)
        doRemovePoints(cid,v.cost)
        doSendMagicEffect(getThingPos(cid), CONST_ME_GIFT_WRAPS)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Thanks for buying!")
		doWriteLogFile("data/logs/buyeditems.txt", "[".. os.date('%d %B %y - %H:%M') .."] ".. getCreatureName(cid) .." bought "..param.." for "..v.cost.." points.")
	end
  return true                                              
end