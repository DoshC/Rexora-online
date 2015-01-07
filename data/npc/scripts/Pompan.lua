local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

-- OTServ event handling functions start
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onPlayerEndTrade(cid)              npcHandler:onPlayerEndTrade(cid) end
function onPlayerCloseChannel(cid)          npcHandler:onPlayerCloseChannel(cid) end
function onThink()                          npcHandler:onThink() end
-- OTServ event handling functions end   


local items = {
		{name='backpack', id=1988, buy=20},
		{name='bag', id=1987, buy=5},
		{name='basket', id=1989, buy=6},
		{name='bucket', id=2005, buy=4},
		{name='candlestick', id=2047, buy=2},
		{name='closed trap', id=2578, buy=280, sell=75},
		{name='crowbar', id=2416, buy=260, sell=50},
		{name='expedition backpack', id=11241, buy=100},
		{name='expedition bag', id=11242, buy=50},
		{name='fishing rod', id=2580, buy=150, sell=40},
		{name='lamp', id=2044, buy=8},
		{name='pick', id=2553, buy=50, sell=15},
		{name='rope', id=2120, buy=50, sell=15},
		{name='scythe', id=2550, buy=50, sell=10},
		{name='shovel', id=2554, buy=50, sell=8},
		{name='torch', id=2050, buy=2},
		{name='watch', id=2036, buy=20, sell=6},
		{name='worm', id=3976, buy=1},
		{name='inkwell', id=2600, sell=8},
		{name='mirror', id=2560, sell=10},
		{name='sickle', id=2405, sell=3}
	}
	
	local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
		if getPlayerStorageValue(cid,TheNewFrontier.TomeofKnowledge) >= 1 then	
		table.insert(items,	{name='arrow', id=2544, buy=3})
		table.insert(items,	{name='bolt', id=2543, buy=4})
		table.insert(items,	{name='bow', id=2456, buy=400, sell=100})
		table.insert(items,	{name='crossbow', id=2455, buy=500, sell=120})
		table.insert(items,	{name='crystalline arrow', id=18304, buy=20})
		table.insert(items,	{name='dragon tapestry', id=11264, buy=80})
		table.insert(items,	{name='earth arrow', id=7850, buy=5})
		table.insert(items,	{name='flaming arrow', id=7840, buy=5})
		table.insert(items,	{name='flash arrow', id=7838, buy=5})
		table.insert(items,	{name='onyx arrow', id=7365, buy=7})
		table.insert(items,	{name='piercing bolt', id=7363, buy=5})
		table.insert(items,	{name='power bolt', id=2547, buy=7})
		table.insert(items,	{name='royal spear', id=7378, buy=15})
		table.insert(items,	{name='shiver arrow', id=7839, buy=5})
		table.insert(items,	{name='sniper arrow', id=7364, buy=5})
		table.insert(items,	{name='spear', id=2389, buy=9, sell=3})
		table.insert(items,	{name='tarsal arrow', id=15648, buy=6})
		table.insert(items,	{name='throwing star', id=2399, buy=42})
		table.insert(items,	{name='corrupted flag', id=11326, sell=700})
		table.insert(items,	{name='high guard flag', id=11332, sell=550})
		table.insert(items,	{name='legionnaire flags', id=11334, sell=500})
		table.insert(items,	{name='zaogun flag', id=11330, sell=600})
		-- 2 tomes
		end
	if getPlayerStorageValue(cid,TheNewFrontier.TomeofKnowledge) >= 2 then
		table.insert(items,	{name='minotaur backpack', id=11244, buy=200})
		end
		-- 5 tomes
	if getPlayerStorageValue(cid,TheNewFrontier.TomeofKnowledge) >= 5 then
		table.insert(items,	{name='dragon backpack', id=11243, buy=200})
		end
	if msgcontains(msg, 'trade') then
		openShopWindow(cid, items, onBuy, onSell)
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
	return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Hello.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'It was a pleasure to help you, |PLAYERNAME|.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())