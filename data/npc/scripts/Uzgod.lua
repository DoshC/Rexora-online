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

local function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local player = isPlayer(cid)
	if(msgcontains(msg, "piece of draconian steel")) then
		npcHandler:say("You bringing me draconian steel and obsidian lance in exchange for obsidian knife?", cid)
		TopicState[cid] = 15
	elseif(msgcontains(msg, "yes") and TopicState[cid] == 15) then
		if getPlayerItemCount(cid,5889) >= 1 and getPlayerItemCount(cid,2425) >= 1 then
			npcHandler:say("Here you have it.", cid)
			doPlayerRemoveItem(cid,5889, 1)
			doPlayerRemoveItem(cid,2425, 1)
			doPlayerAddItem(cid,5908, 1)
			TopicState[cid] = 0
		else
			npcHandler:say("You dont have these items.", cid)
			TopicState[cid] = 0
		end
	end

	if(msgcontains(msg, "pickaxe")) then
		if getPlayerStorageValue(cid,ExplorerSociety.QuestLine) == 1 then
			npcHandler:say("True dwarven pickaxes having to be maded by true weaponsmith! You wanting to get pickaxe for explorer society?", cid)
			TopicState[cid] = 1
		end
	elseif(msgcontains(msg, "crimson sword")) then
		if getPlayerStorageValue(cid,TravellingTrader.Mission05) == 1 then
			npcHandler:say("Me don't sell crimson sword.", cid)
			TopicState[cid] = 5
		end
	elseif(msgcontains(msg, "forge")) then
		if(TopicState[cid] == 5) then
			npcHandler:say("You telling me to forge one?! Especially for you? You making fun of me?", cid)
			TopicState[cid] = 6
		end
	elseif(msgcontains(msg, "brooch")) then
		if getPlayerStorageValue(cid,ExplorerSociety.QuestLine) == 2 then
			npcHandler:say("True dwarven pickaxes having to be maded by true weaponsmith! You wanting to get pickaxe for explorer society?", cid)
			TopicState[cid] = 3
		end
	elseif(msgcontains(msg, "yes")) then
		if(TopicState[cid] == 1) then
			npcHandler:say("Me order book quite full is. But telling you what: You getting me something me lost and Uzgod seeing that your pickaxe comes first. Jawoll! You interested?", cid)
			TopicState[cid] = 2
		elseif(TopicState[cid] == 2) then
			npcHandler:say("Good good. You listening: Me was stolen valuable heirloom. Brooch from my family. Good thing is criminal was caught. Bad thing is, criminal now in dwarven prison of dwacatra is and must have taken brooch with him ...", cid)
			npcHandler:say("To get into dwacatra you having to get several keys. Each key opening way to other key until you get key to dwarven prison ...", cid)
			npcHandler:say("Last key should be in the generals quarter near armory. Only General might have key to enter there too. But me not knowing how to enter Generals private room at barracks. You looking on your own ...", cid)
			npcHandler:say("When got key, then you going down to dwarven prison and getting me that brooch. Tell me that you got brooch when having it.", cid)
			TopicState[cid] = 0
			setPlayerStorageValue(cid,ExplorerSociety.QuestLine, 2)
		elseif(TopicState[cid] == 3) then
			if doPlayerRemoveItem(cid,2318, 1) then
				npcHandler:say("Thanking you for brooch. Me guessing you now want your pickaxe?", cid)
				TopicState[cid] = 4
			end
		elseif(TopicState[cid] == 4) then
			npcHandler:say("Here you have it.", cid)
			doPlayerAddItem(cid,11421, 1)
			setPlayerStorageValue(cid,ExplorerSociety.QuestLine, 3)
			TopicState[cid] = 0
		elseif(TopicState[cid] == 9) then
			if getPlayerMoney(cid) >= 250 and getPlayerItemCount(cid,5880) >= 3 then
				doPlayerRemoveMoney(cid,250)
				doPlayerRemoveItem(cid,5880, 3)
				npcHandler:say("Ah, that's how me like me customers. Ok, me do this... <pling pling> ... another fine swing of the hammer here and there... <ploing>... here you have it!", cid)
				doPlayerAddItem(cid,7385, 1)
				setPlayerStorageValue(cid,TravellingTrader.Mission05, 2)
				TopicState[cid] = 0
			end
		end
	elseif(msgcontains(msg, "no")) then
		if(TopicState[cid] == 6) then
			npcHandler:say("Well. Thinking about it, me a smith, so why not. 1000 gold for your personal crimson sword. Ok?", cid)
			TopicState[cid] = 7
		elseif(TopicState[cid] == 7) then
			npcHandler:say("Too expensive?! You think me work is cheap? Well, if you want cheap, I can make cheap. Hrmpf. I make cheap sword for 300 gold. Ok?", cid)
			TopicState[cid] = 8
		elseif(TopicState[cid] == 8) then
			npcHandler:say("Cheap but good quality? Impossible. Unless... you bring material. Three iron ores, 250 gold. Okay?", cid)
			TopicState[cid] = 9
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())