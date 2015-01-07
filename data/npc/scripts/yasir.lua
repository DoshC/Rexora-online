local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)                                    npcHandler:onThink() end
 
local items =
{
	{id = 11213, sell = 10},
	{id = 11214, sell = 50},
	{id = 5883, sell = 120},
	{id = 7965, sell = 15},
	{id = 12401, sell = 30},
	{id = 12467, sell = 55},
	{id = 6492, sell = 2000},
	{id = 5894, sell = 50},
	{id = 5896, sell = 100},
	{id = 5930, sell = 2000},
	{id = 10562, sell = 190},
	{id = 12404, sell = 300},
	{id = 12405, sell = 320},
	{id = 10550, sell = 100},
	{id = 5912, sell = 200},
	{id = 10584, sell = 200},
	{id = 11321, sell = 150},
	{id = 5898, sell = 80},
	{id = 11194, sell = 210},
	{id = 11237, sell = 180},
	{id = 10563, sell = 120},
	{id = 12658, sell = 380},
	{id = 12659, sell = 210},
	{id = 12407, sell = 30},
	{id = 12616, sell = 340},
	{id = 11335, sell = 100},
	{id = 12409, sell = 20},
	{id = 12608, sell = 8000},
	{id = 13877, sell = 4000},
	{id = 12408, sell = 35},
	{id = 12617, sell = 120},
	{id = 5913, sell = 100},
	{id = 10606, sell = 30},
	{id = 10605, sell = 800},
	{id = 11217, sell = 50},
	{id = 11192, sell = 35},
	{id = 5480, sell = 2000},
	{id = 11218, sell = 28},
	{id = 5890, sell = 30},
	{id = 10551, sell = 15},
	{id = 12470, sell = 110},
	{id = 11219, sell = 45},
	{id = 15486, sell = 150},
	{id = 11326, sell = 700},
	{id = 6536, sell = 50000},
	{id = 11189, sell = 35},
	{id = 15482, sell = 210},
	{id = 10555, sell = 280},
	{id = 10556, sell = 150},
	{id = 12411, sell = 500},
	{id = 11327, sell = 320},
	{id = 10574, sell = 55},
	{id = 11220, sell = 48},
	{id = 15424, sell = 90},
	{id = 15455, sell = 430},
	{id = 15423, sell = 230},
	{id = 15452, sell = 360},
	{id = 15430, sell = 80},
	{id = 15425, sell = 180},
	{id = 15426, sell = 290},
	{id = 5527, sell = 300},
	{id = 5954, sell = 1000},
	{id = 13530, sell = 1000},
	{id = 10564, sell = 80},
	{id = 12412, sell = 120},
	{id = 12640, sell = 20},
	{id = 6546, sell = 50000},
	{id = 9948, sell = 5000},
	{id = 5919, sell = 8000},
	{id = 11361, sell = 175},
	{id = 12413, sell = 100},
	{id = 12614, sell = 550},
	{id = 12615, sell = 430},
	{id = 15622, sell = 130},
	{id = 11193, sell = 150},
	{id = 12421, sell = 90},
	{id = 12420, sell = 50},
	{id = 10552, sell = 45},
	{id = 5891, sell = 20000},
	{id = 11223, sell = 360},
	{id = 13870, sell = 150},
	{id = 12627, sell = 390},
	{id = 10553, sell = 375},
	{id = 5895, sell = 150},
	{id = 12422, sell = 30},
	{id = 5885, sell = 10000},
	{id = 10575, sell = 160},
	{id = 10565, sell = 30},
	{id = 10578, sell = 280},
	{id = 10566, sell = 90},
	{id = 12414, sell = 80},
	{id = 12419, sell = 120},
	{id = 11366, sell = 700},
	{id = 10607, sell = 90},
	{id = 12423, sell = 60},
	{id = 11197, sell = 380},
	{id = 12399, sell = 30},
	{id = 8971, sell = 500},
	{id = 9967, sell = 25},
	{id = 9966, sell = 20},
	{id = 9968, sell = 30},
	{id = 12495, sell = 20},
	{id = 5877, sell = 100},
	{id = 5920, sell = 100},
	{id = 5910, sell = 200},
	{id = 12402, sell = 350},
	{id = 11200, sell = 55},
	{id = 10576, sell = 85},
	{id = 5925, sell = 70},
	{id = 10600, sell = 115},
	{id = 2743, sell = 50},
	{id = 10554, sell = 500},
	{id = 11221, sell = 475},
	{id = 11332, sell = 550},
	{id = 11333, sell = 130},
	{id = 5922, sell = 90},
	{id = 5902, sell = 40},
	{id = 12425, sell = 80},
	{id = 11199, sell = 600},
	{id = 5880, sell = 500},
	{id = 12426, sell = 180},
	{id = 15422, sell = 330},
	{id = 15480, sell = 420},
	{id = 12427, sell = 100},
	{id = 11372, sell = 80},
	{id = 11334, sell = 500},
	{id = 10608, sell = 60},
	{id = 12636, sell = 300},
	{id = 5876, sell = 150},
	{id = 5881, sell = 120},
	{id = 12410, sell = 1000},
	{id = 10609, sell = 10},
	{id = 11222, sell = 130},
	{id = 5904, sell = 8000},
	{id = 11238, sell = 100},
	{id = 12445, sell = 280},
	{id = 12428, sell = 75},
	{id = 5878, sell = 80},
	{id = 12430, sell = 60},
	{id = 6537, sell = 50000},
	{id = 10579, sell = 420},
	{id = 11225, sell = 50},
	{id = 10585, sell = 150},
	{id = 10577, sell = 700},
	{id = 12431, sell = 250},
	{id = 11231, sell = 75},
	{id = 12432, sell = 25},
	{id = 12442, sell = 430},
	{id = 5804, sell = 2000},
	{id = 12435, sell = 30},
	{id = 11113, sell = 150},
	{id = 12433, sell = 85},
	{id = 12437, sell = 30},
	{id = 5893, sell = 250},
	{id = 11337, sell = 250},
	{id = 12439, sell = 20},
	{id = 11196, sell = 15},
	{id = 10580, sell = 420},
	{id = 6540, sell = 50000},
	{id = 10558, sell = 45},
	{id = 12438, sell = 50},
	{id = 10610, sell = 10},
	{id = 12440, sell = 25},
	{id = 12441, sell = 10},
	{id = 10557, sell = 50},
	{id = 10567, sell = 30},
	{id = 12400, sell = 60},
	{id = 12429, sell = 110},
	{id = 12447, sell = 500},
	{id = 12444, sell = 350},
	{id = 12446, sell = 410},
	{id = 12443, sell = 140},
	{id = 5948, sell = 200},
	{id = 5882, sell = 200},
	{id = 5911, sell = 300},
	{id = 12448, sell = 66},
	{id = 11208, sell = 30},
	{id = 11228, sell = 400},
	{id = 12449, sell = 120},
	{id = 11373, sell = 20},
	{id = 12629, sell = 680},
	{id = 10548, sell = 280},
	{id = 10568, sell = 25},
	{id = 12466, sell = 230},
	{id = 11229, sell = 450},
	{id = 10583, sell = 520},
	{id = 7732, sell = 150},
	{id = 11324, sell = 25},
	{id = 12434, sell = 45},
	{id = 11209, sell = 35},
	{id = 6524, sell = 3000},
	{id = 12436, sell = 80},
	{id = 11191, sell = 50},
	{id = 12468, sell = 95},
	{id = 12406, sell = 480},
	{id = 2062, sell = 150},
	{id = 12469, sell = 70},
	{id = 10611, sell = 400},
	{id = 5875, sell = 2000},
	{id = 5809, sell = 6000},
	{id = 15421, sell = 280},
	{id = 8859, sell = 10},
	{id = 5879, sell = 100},
	{id = 15485, sell = 450},
	{id = 11325, sell = 100},
	{id = 15481, sell = 340},
	{id = 10559, sell = 95},
	{id = 2800, sell = 15},
	{id = 2799, sell = 20},
	{id = 11195, sell = 120},
	{id = 11226, sell = 600},
	{id = 2174, sell = 200},
	{id = 11210, sell = 50},
	{id = 10603, sell = 20},
	{id = 15479, sell = 130},
	{id = 12628, sell = 240},
	{id = 11198, sell = 80},
	{id = 10601, sell = 120},
	{id = 12622, sell = 5000},
	{id = 11370, sell = 50},
	{id = 11371, sell = 60},
	{id = 11369, sell = 170},
	{id = 11190, sell = 95},
	{id = 6539, sell = 50000},
	{id = 6534, sell = 50000},
	{id = 6535, sell = 50000},
	{id = 11224, sell = 150},
	{id = 10560, sell = 100},
	{id = 2805, sell = 25},
	{id = 12471, sell = 50},
	{id = 5899, sell = 90},
	{id = 8614, sell = 100},
	{id = 11367, sell = 200},
	{id = 11233, sell = 480},
	{id = 5905, sell = 100},
	{id = 10602, sell = 275},
	{id = 11322, sell = 200},
	{id = 11235, sell = 30},
	{id = 15483, sell = 320},
	{id = 15484, sell = 190},
	{id = 11314, sell = 250},
	{id = 11234, sell = 380},
	{id = 5909, sell = 100},
	{id = 11328, sell = 110},
	{id = 11230, sell = 800},
	{id = 11212, sell = 20},
	{id = 10569, sell = 60},
	{id = 5897, sell = 70},
	{id = 5901, sell = 5},
	{id = 11236, sell = 15},
	{id = 10582, sell = 400},
	{id = 10561, sell = 265},
	{id = 5914, sell = 150},
	{id = 11330, sell = 600},
	{id = 11331, sell = 150}
}
 
for _, it in ipairs(items) do
	it.name = getItemNameById(it.id):lower()
end
 
local shop = {}

function onSell(cid, item, subType, amount)
	for _, it in ipairs(items) do
		shop[it.id] = {price = it.sell, name = it.name}
	end
	if getPlayerItemCount(cid, item) >= amount and doPlayerRemoveItem(cid, item, amount) then
		doPlayerAddMoney(cid, amount * shop[item].price)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sold x" .. amount .. " " .. shop[item].name .. " for " .. shop[item].price * amount .. " gold.")
	else
		doPlayerSendCancel(cid, "You do not have that item.")
	end
end
 
function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
	for _, it in ipairs(items) do
		if it.buy then
			shop[it.id] = {price = it.buy, name = it.name}
		end
	end
	if inBackpacks then
		if not getItemInfo(item).stackable then
			local backpacks = math.ceil(amount / 20)
			if not ignoreCap then
				local totalCap = getItemInfo(1988).weight * backpacks
				totalCap = totalCap + (getItemInfo(item).weight * amount)
				if totalCap > getPlayerFreeCap(cid) then
					doPlayerSendCancel(cid, "You do not have enough cap.")
					return true
				end
			end
			local a = amount
			if doPlayerRemoveMoney(cid, (shop[item].price * amount) + (backpacks * 20)) then
				for i = 1, backpacks do
					local cont = doPlayerAddItem(cid, 1988, 1)
					local a2 = 20
					if a < 20 then
						a2 = a
					end
					for k = 1, a2 do
						doAddContainerItem(cont, item, 1)
						a = a - 1
					end
				end
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Bought x" .. amount .. " " .. shop[item].name .. " for " .. shop[item].price * amount + (backpacks * 20) .. " gold.")
			else
				doPlayerSendCancel(cid, "You do not have enough money.")
				return true
			end
		else
			if doPlayerRemoveMoney(cid, (shop[item].price * amount) + 20) then
				local cont = doPlayerAddItem(cid, 1988, 1)
				doAddContainerItem(cont, item, amount)
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Bought x" .. amount .. " " .. shop[item].name .. " for " .. (shop[item].price * amount) + 20 .. " gold.")
			else
				doPlayerSendCancel(cid, "You do not have enough money.")
				return true
			end
		end				
	else	
		if not ignoreCap then
			local total = getItemInfo(item).weight * amount
			if total > getPlayerFreeCap(cid) then
				doPlayerSendCancel(cid, "You do not have enough cap.")
				return true
			end
		end
		if doPlayerRemoveMoney(cid, shop[item].price * amount) then
			for i = 1, amount do
				doPlayerAddItem(cid, item, 1)
			end
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Bought x" .. amount .. " " .. shop[item].name .. " for " .. shop[item].price * amount .. " gold.")
		else
			doPlayerSendCancel(cid, "You do not have enough money.")
			return true
		end
	end
end
 
function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
	return false
	end
	local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
 
	if isInArray({"trade", "ariki"}, msg:lower()) then
		npcHandler:say("Si! Haneka ariki!", cid)
		if doPlayerAddAchievement then --Do you have an achievements system?
			doPlayerAddAchievement(cid, "Si, Ariki!", true)
		end
		openShopWindow(cid, items, onBuy, onSell)
	elseif msg:lower() == "name" then
		return npcHandler:say("Me Yasir.", cid)
	elseif msg:lower() == "job" then
		return npcHandler:say("Tje hari ku ne finjala. {Ariki}?", cid)
	elseif msg:lower() == "passage" then
		return npcHandler:say("Soso yana. <shakes his head>", cid)
	end
	return true
end
 
npcHandler:setMessage(MESSAGE_FAREWELL, "Si, jema ze harun. <waves>")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())