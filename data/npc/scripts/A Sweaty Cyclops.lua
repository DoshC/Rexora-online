local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local voices = {
	'Hum hum, huhum',
	'Silly lil\' human'
}

local lastSound = 0
function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 10)
		if math.random(100) < 20 then
			npcHandler:say(voices[math.random(#voices)], TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)
	if msgcontains(msg, "melt") then
		npcHandler:say("Can melt gold ingot for lil' one. You want?", cid)
		TopicState[cid] = 10
	elseif msgcontains(msg, "yes") and TopicState[cid] == 10 then
		if doPlayerRemoveItem(cid,9971,1) then
			npcHandler:say("whoooosh There!", cid)
			doPlayerAddItem(cid,2160, 1)
		else
			npcHandler:say("There is no gold ingot with you.", cid)
		end
		TopicState[cid] = 0
	end

	if msgcontains(msg, "amulet") then
		if getPlayerStorageValue(cid,SweetyCyclops.AmuletStatus) < 1 then
			npcHandler:say("Me can do unbroken but Big Ben want gold 5000 and Big Ben need a lil' time to make it unbroken. Yes or no??", cid)
			TopicState[cid] = 9
		elseif getPlayerStorageValue(cid,SweetyCyclops.AmuletStatus) == 1 then
			if getPlayerStorageValue(cid,SweetyCyclops.AmuletTimer) + 24 * 60 * 60 < os.time() then
				npcHandler:say("Ahh, lil' one wants amulet. Here! Have it! Mighty, mighty amulet lil' one has. Don't know what but mighty, mighty it is!!!", cid)
				doPlayerAddItem(cid,8266, 1)
				setPlayerStorageValue(cid,SweetyCyclops.AmuletStatus, 2)
			else
				npcHandler:say("Me need more time!!!", cid)
			end
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			npcHandler:say("Wait. Me work no cheap is. Do favour for me first, yes?", cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 2 then
			npcHandler:say("Me need gift for woman. We dance, so me want to give her bast skirt. But she big is. So I need many to make big one. Bring three okay? Me wait.", cid)
			TopicState[cid] = 0
			setPlayerStorageValue(cid,FriendsandTraders.DefaultStart, 1)
			setPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops, 1)
		elseif TopicState[cid] == 3 then
			if doPlayerRemoveItem(cid,3983, 3) then
				npcHandler:say("Good good! Woman happy will be. Now me happy too and help you.", cid)
				TopicState[cid] = 0
				setPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops, 2)
			end
		-- Crown Armor
		elseif TopicState[cid] == 4 then
			if doPlayerRemoveItem(cid,2487, 1) then
				npcHandler:say("Cling clang!", cid)
				TopicState[cid] = 0
				doPlayerAddItem(cid,5887, 1)
			end
		-- Dragon Shield
		elseif TopicState[cid] == 5 then
			if doPlayerRemoveItem(cid,2516, 1) then
				npcHandler:say("Cling clang!", cid)
				TopicState[cid] = 0
				doPlayerAddItem(cid,5889, 1)
			end
		-- Devil Helmet
		elseif TopicState[cid] == 6 then
			if doPlayerRemoveItem(cid,2462, 1) then
				npcHandler:say("Cling clang!", cid)
				TopicState[cid] = 0
				doPlayerAddItem(cid,5888, 1)
			end
		-- Giant Sword
		elseif TopicState[cid] == 7 then
			if doPlayerRemoveItem(cid,2393, 1) then
				npcHandler:say("Cling clang!", cid)
				TopicState[cid] = 0
				doPlayerAddItem(cid,5892, 1)
			end
		-- Soul Orb
		elseif TopicState[cid] == 8 then
			if getPlayerItemCount(cid,5944) > 0 then
				local count = getPlayerItemCount(cid,5944)
				for i = 1, count do
					if math.random(100) <= 1 then
						doPlayerAddItem(cid,6529, 6)
						doPlayerRemoveItem(cid,5944, 1)
					else
						doPlayerAddItem(cid,6529, 3)
						doPlayerRemoveItem(cid,5944, 1)
					end
				end
				npcHandler:say("Cling clang!", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 9 then
			if getPlayerItemCount(cid,8262) > 0 and getPlayerItemCount(cid,8263) > 0 and getPlayerItemCount(cid,8264) > 0 and getPlayerItemCount(cid,8265) > 0 and getPlayerMoney(cid) >= 5000 then
				doPlayerRemoveItem(cid,8262, 1)
				doPlayerRemoveItem(cid,8263, 1)
				doPlayerRemoveItem(cid,8264, 1)
				doPlayerRemoveItem(cid,8265, 1)
				doPlayerRemoveMoney(cid,5000)
				setPlayerStorageValue(cid,SweetyCyclops.AmuletTimer, os.time())
				setPlayerStorageValue(cid,SweetyCyclops.AmuletStatus, 1)
				npcHandler:say("Well, well, I do that! Big Ben makes lil' amulet unbroken with big hammer in big hands! No worry! Come back after sun hits the horizon 24 times and ask me for amulet.", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 11 then
			if doPlayerRemoveItem(cid,5880, 1) then
				setPlayerStorageValue(cid,hiddenCityOfBeregar.GearWheel, getPlayerStorageValue(cid,hiddenCityOfBeregar.GearWheel) + 1)
				doPlayerAddItem(cid,9690, 1)
			else
				npcHandler:say("Lil' one does not have any iron ores.", cid)
			end
			TopicState[cid] = 0
		end

	-- Crown Armor
	elseif msgcontains(msg, "uth'kean") then
		if getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) < 1 then
			npcHandler:say("Very noble. Shiny. Me like. But breaks so fast. Me can make from shiny armour. Lil' one want to trade?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 1 then
			npcHandler:say("Lil' one bring three bast skirts?", cid)
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 2 then
			npcHandler:say("Very noble. Shiny. Me like. But breaks so fast. Me can make from shiny armour. Lil' one want to trade?", cid)
			TopicState[cid] = 4
		end
	-- Dragon Shield
	elseif msgcontains(msg, "uth'lokr") then
		if getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) < 1 then
			npcHandler:say("Firy steel it is. Need green ones' breath to melt. Or red even better. Me can make from shield. Lil' one want to trade?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 1 then
			npcHandler:say("Lil' one bring three bast skirts?", cid)
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 2 then
			npcHandler:say("Firy steel it is. Need green ones' breath to melt. Or red even better. Me can make from shield. Lil' one want to trade?", cid)
			TopicState[cid] = 5
		end
	-- Devil Helmet
	elseif msgcontains(msg, "za'ralator") then
		if getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) < 1 then
			npcHandler:say("Hellsteel is. Cursed and evil. Dangerous to work with. Me can make from evil helmet. Lil' one want to trade?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 1 then
			npcHandler:say("Lil' one bring three bast skirts?", cid)
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 2 then
			npcHandler:say("Hellsteel is. Cursed and evil. Dangerous to work with. Me can make from evil helmet. Lil' one want to trade?", cid)
			TopicState[cid] = 6
		end
	-- Giant Sword
	elseif msgcontains(msg, "uth'prta") then
		if getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) < 1 then
			npcHandler:say("Good iron is. Me friends use it much for fight. Me can make from weapon. Lil' one want to trade?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 1 then
			npcHandler:say("Lil' one bring three bast skirts?", cid)
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 2 then
			npcHandler:say("Good iron is. Me friends use it much for fight. Me can make from weapon. Lil' one want to trade?", cid)
			TopicState[cid] = 7
		end
	-- Soul Orb
	elseif msgcontains(msg, "soul orb") then
		if getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) < 1 then
			npcHandler:say("Uh. Me can make some nasty lil' bolt from soul orbs. Lil' one want to trade all?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 1 then
			npcHandler:say("Lil' one bring three bast skirts?", cid)
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,FriendsandTraders.TheSweatyCyclops) == 2 then
			npcHandler:say("Uh. Me can make some nasty lil' bolt from soul orbs. Lil' one want to trade all?", cid)
			TopicState[cid] = 8
		end
	elseif msgcontains(msg, "gear wheel") then
		if getPlayerStorageValue(cid,hiddenCityOfBeregar.GoingDown) > 0 and getPlayerStorageValue(cid,hiddenCityOfBeregar.GearWheel) > 3 then
			npcHandler:say("Uh. Me can make some gear wheel from iron ores. Lil' one want to trade?", cid)
			TopicState[cid] = 11
		end
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I am smith."})
keywordHandler:addKeyword({'smith'}, StdModule.say, {npcHandler = npcHandler, text = "Working steel is my profession."})
keywordHandler:addKeyword({'steel'}, StdModule.say, {npcHandler = npcHandler, text = "Manny kinds of. Like {Mesh Kaha Rogh'}, {Za'Kalortith}, {Uth'Byth}, {Uth'Morc}, {Uth'Amon}, {Uth'Maer}, {Uth'Doon}, and {Zatragil}."})
keywordHandler:addKeyword({'zatragil'}, StdModule.say, {npcHandler = npcHandler, text = "Most ancients use dream silver for different stuff. Now ancients most gone. Most not know about."})
keywordHandler:addKeyword({'uth\'doon'}, StdModule.say, {npcHandler = npcHandler, text = "It's high steel called. Only lil' lil' ones know how make."})
keywordHandler:addKeyword({'za\'kalortith'}, StdModule.say, {npcHandler = npcHandler, text = "It's evil. Demon iron is. No good cyclops goes where you can find and need evil flame to melt."})
keywordHandler:addKeyword({'mesh kaha rogh'}, StdModule.say, {npcHandler = npcHandler, text = "Steel that is singing when forged. No one knows where find today."})
keywordHandler:addKeyword({'uth\'byth'}, StdModule.say, {npcHandler = npcHandler, text = "Not good to make stuff off. Bad steel it is. But eating magic, so useful is."})
keywordHandler:addKeyword({'uth\'maer'}, StdModule.say, {npcHandler = npcHandler, text = "Brightsteel is. Much art made with it. Sorcerers too lazy and afraid to enchant much."})
keywordHandler:addKeyword({'uth\'amon'}, StdModule.say, {npcHandler = npcHandler, text = "Heartiron from heart of big old mountain, found very deep. Lil' lil ones fiercely defend. Not wanting to have it used for stuff but holy stuff."})
keywordHandler:addKeyword({'ab\'dendriel'}, StdModule.say, {npcHandler = npcHandler, text = "Me parents live here before town was. Me not care about lil' ones."})
keywordHandler:addKeyword({'lil\' lil\''}, StdModule.say, {npcHandler = npcHandler, text = "Lil' lil' ones are so fun. We often chat."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = "One day I'll go and look."})
keywordHandler:addKeyword({'teshial'}, StdModule.say, {npcHandler = npcHandler, text = "Is one of elven family or such thing. Me not understand lil' ones and their business."})
keywordHandler:addKeyword({'cenath'}, StdModule.say, {npcHandler = npcHandler, text = "Is one of elven family or such thing. Me not understand lil' ones and their business."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "I called Bencthyclthrtrprr by me people. Lil' ones me call Big Ben."})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, text = "You shut up. Me not want to hear."})
keywordHandler:addKeyword({'fire sword'}, StdModule.say, {npcHandler = npcHandler, text = "Do lil' one want to trade a fire sword?"})
keywordHandler:addKeyword({'dragon shield'}, StdModule.say, {npcHandler = npcHandler, text = "Do lil' one want to trade a dragon shield?"})
keywordHandler:addKeyword({'sword of valor'}, StdModule.say, {npcHandler = npcHandler, text = "Do lil' one want to trade a sword of valor?"})
keywordHandler:addKeyword({'warlord sword'}, StdModule.say, {npcHandler = npcHandler, text = "Do lil' one want to trade a warlord sword?"})
keywordHandler:addKeyword({'minotaurs'}, StdModule.say, {npcHandler = npcHandler, text = "They were friend with me parents. Long before elves here, they often made visit. No longer come here."})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, text = "Me not fight them, they not fight me."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = "Me wish I could make weapon like it."})
keywordHandler:addKeyword({'cyclops'}, StdModule.say, {npcHandler = npcHandler, text = "Me people not live here much. Most are far away."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hum Humm! Welcume lil' |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye lil' one.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye lil' one.")
npcHandler:addModule(FocusModule:new())