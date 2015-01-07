local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local lastSound = 0
function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 5)
		if math.random(100) < 25 then
			npcHandler:say("Hello there, adventurer! Need a deal in weapons or armor? I'm your man!", TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)
	if msgcontains(msg, 'adorn')
			or msgcontains(msg, 'outfit')
			or msgcontains(msg, 'addon') then
		local addonProgress = getPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet)
		if addonProgress == 5 then
			setPlayerStorageValue(cid,OutfitQuest.Knight.MissionHelmet, 6)
			setPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet, 6)
			setPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmetTimer, os.time() + 7200)
			npcHandler:say('Oh, Gregor sent you? I see. It will be my pleasure to adorn your helmet. Please give me some time to finish it.', cid)
		elseif addonProgress == 6 then
			if getPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmetTimer) < os.time() then
				setPlayerStorageValue(cid,OutfitQuest.Knight.MissionHelmet, 0)
				setPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet, 7)
				setPlayerStorageValue(cid,OutfitQuest.Ref, math.min(getPlayerStorageValue(cid,OutfitQuest.Ref),0) - 1)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 131, 2)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 139, 2)
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				npcHandler:say('Just in time, "..getCreatureName(cid)..". Your helmet is finished, I hope you like it.', cid)
			else
				npcHandler:say('Please have some patience, "..getCreatureName(cid)..". Forging is hard work!', cid)
			end
		end
		elseif addonProgress == 7 then
			npcHandler:say('I think it\'s one of my masterpieces.', cid)
		else
			npcHandler:say('Sorry, but without the permission of Gregor I cannot help you with this matter.', cid)
		end

	elseif msgcontains(msg, "old backpack") then
		if getPlayerStorageValue(cid,SamsOldBackpack) < 1 then
			npcHandler:say("What? Are you telling me you found my old adventurer's backpack that I lost years ago??", cid)
			TopicState[cid] = 1
		end

	elseif msgcontains(msg, '2000 steel shields') then
		if getPlayerStorageValue(cid,WhatAFoolishQuest.Questline) ~= 29
				or getPlayerStorageValue(cid,WhatAFoolishQuest.Contract) == 2 then
			npcHandler:say('My offers are weapons, armors, helmets, legs, and shields. If you\'d like to see my offers, ask me for a {trade}.', cid)
			return true
		end

		npcHandler:say('What? You want to buy 2000 steel shields??', cid)
		TopicState[cid] = 2

	elseif msgcontains(msg, 'contract') then
		if getPlayerStorageValue(cid,WhatAFoolishQuest.Contract) == 0 then
			npcHandler:say('Have you signed the contract?', cid)
			TopicState[cid] = 4
		end

	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			if doPlayerRemoveItem(cid,3960, 1) then
				npcHandler:say("Thank you very much! This brings back good old memories! Please, as a reward, travel to Kazordoon and ask my old friend Kroox to provide you a special dwarven armor. ...",cid)
				addEvent(selfSay, 3000,	"I will mail him about you immediately. Just tell him, his old buddy Sam is sending you.", cid)
				setPlayerStorageValue(cid,SamsOldBackpack, 1)
			else
				npcHandler:say("You don't have it...", cid)
			end
			TopicState[cid] = 0
		elseif TopicState[cid] == 2 then
			npcHandler:say('I can\'t believe it. Finally I will be rich! I could move to Edron and enjoy my retirement! But ... wait a minute! I will not start working without a contract! Are you willing to sign one?', cid)
			TopicState[cid] = 3
		elseif TopicState[cid] == 3 then
			doPlayerAddItem(cid,7492, 1)
			setPlayerStorageValue(cid,WhatAFoolishQuest.Contract, 1)
			npcHandler:say('Fine! Here is the contract. Please sign it. Talk to me about it again when you\'re done.', cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 4 then
			if not doPlayerRemoveItem(cid,7491, 1) then
				npcHandler:say('You don\'t have a signed contract.', cid)
				TopicState[cid] = 0
				return true
			end

			setPlayerStorageValue(cid,WhatAFoolishQuest.Contract, 2)
			npcHandler:say('Excellent! I will start working right away! Now that I am going to be rich, I will take the opportunity to tell some people what I REALLY think about them!', cid)
			TopicState[cid] = 0
		end

	elseif msgcontains(msg, "no") then
		if TopicState[cid] == 1 then
			npcHandler:say("Then no.", cid)
		elseif isInArray({2, 3, 4}, TopicState[cid]) then
			npcHandler:say("This deal sounded too good to be true anyway.", cid)
		end
		TopicState[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I am the blacksmith. If you need weapons or armor - just ask me."})

npcHandler:setMessage(MESSAGE_GREET, "Welcome to my shop, adventurer |PLAYERNAME|! I {trade} with weapons and armor.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and come again, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye and come again.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new()) 