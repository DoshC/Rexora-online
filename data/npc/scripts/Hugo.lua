local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local config = {
	['brown piece of cloth'] = {
		itemId = 5913,
		count = 20,
		value = 1,
		messages = {
			done = 'Ghouls sometimes carry it with them. My assistant Irmana can also fabricate cloth from secondhand clothing.',
			deliever = 'Ah! Have you brought 20 pieces of brown cloth?',
			notEnough = 'Uh, that is not even enough cloth for a poor dwarf\'s look.',
			success = 'Yes, yes, that\'s it! Very well, now I need 50 pieces of minotaur leather to continue.'
		}
	},
	['minotaur leather'] = {
		itemId = 5878,
		count = 50,
		value = 2,
		messages = {
			done = 'If you don\'t know how to obtain minotaur leather, ask my apprentice Kalvin. I\'m far too busy for these trivial matters.',
			deliever = 'Were you able to obtain 50 pieces of minotaur leather?',
			notEnough = 'Uh, that is not even enough leather for a poor dwarf\'s look.',
			success = 'Great! This leather will suffice. Now, please, the 10 bat wings.'
		}
	},
	['bat wings'] = {
		itemId = 5894,
		count = 10,
		value = 3,
		messages = {
			done = 'Well, what do you expect? Bat wings come from bats, of course.',
			deliever = 'Did you get me the 10 bat wings?',
			notEnough = 'No, no. I need more bat wings! I said, 10!',
			success = 'Hooray! These bat wings are ugly enough. Now the last thing: Please bring me 30 heaven blossoms to neutralise the ghoulish stench.'
		}
	},
	['heaven blossom'] = {
		itemId = 5921,
		count = 30,
		value = 4,
		messages = {
			done = 'A flower favoured by almost all elves.',
			deliever = 'Is this the lovely smell of 30 heaven blossoms?',
			notEnough = 'These few flowers are not enough to neutralise the ghoulish stench.',
			success = 'This is it! I will immediately start to work on this outfit. Come back in a day or something... then my new creation will be born!'
		},
		lastItem = true
	}
}

local message = {}

local function greetCallback(cid)
	message[cid] = nil
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)
	if msgcontains(msg, "uniforms") then
		if getPlayerStorageValue(cid,postman.Mission06) == 1 then
			npcHandler:say("A new uniform for the post officers? I am sorry but my dog ate the last dress pattern we used. You need to supply us with a new dress pattern.", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "dress pattern") then
		if TopicState[cid] == 1 then
			npcHandler:say("It was ... wonderous beyond wildest imaginations! I have no clue where Kevin Postner got it from. Better ask him.", cid)
			setPlayerStorageValue(cid,postman.Mission06, 2)
		elseif getPlayerStorageValue(cid,postman.Mission06) == 11 then
			npcHandler:say("By the gods of fashion! Didn't it do that I fed the last dress pattern to my poor dog? Will this mocking of all which is taste and fashion never stop?? Ok, ok, you will get those ugly, stinking uniforms and now get lost, fashion terrorist.", cid)
			setPlayerStorageValue(cid,postman.Mission06, 12)
		end
		TopicState[cid] = 0
	elseif msgcontains(msg, 'outfit') then
		if not isPremium(cid) then
			npcHandler:say('Sorry, but my time is currently reserved for premium matters.', cid)
			return true
		end

		if getPlayerStorageValue(cid,OutfitQuest.BeggarOutfit) < 1 then
			npcHandler:say('I think I\'m having an innovative vision! I feel that people are getting tired of attempting to look wealthy and of displaying their treasures. ...',cid)
			addEvent(selfSay, 3000,	'A really new and innovative look would be - the \'poor man\'s look\'! I can already see it in front of me... yes... a little ragged... but not too shabby! ...',cid)
			addEvent(selfSay, 6000,	'I need material right now! Argh - the vision starts to fade... please hurry, can you bring me some stuff?', cid)
			TopicState[cid] = 2
		elseif getPlayerStorageValue(cid,OutfitQuest.BeggarOutfit) > 0 and getPlayerStorageValue(cid,OutfitQuest.BeggarOutfit) < 5 then
			npcHandler:say('I am so excited! This poor man\'s look will be an outfit like the world has never seen before.', cid)
		elseif getPlayerStorageValue(cid,OutfitQuest.BeggarOutfit) == 5 then
			if getPlayerStorageValue(cid,OutfitQuest.BeggarOutfitTimer) > os.time() then
				npcHandler:say('Sorry, but I am not done with the outfit yet. Venore wasn\'t built in a day.', cid)
			elseif getPlayerStorageValue(cid,OutfitQuest.BeggarOutfitTimer) > 0 and getPlayerStorageValue(cid,OutfitQuest.BeggarOutfitTimer) < os.time() then
				npcHandler:say('Eureka! Alas, the poor man\'s outfit is finished, but... to be honest... it turned out much less appealing than I expected. However, you can have it if you want, okay?', cid)
				TopicState[cid] = 5
			end
		elseif getPlayerStorageValue(cid,OutfitQuest.BeggarOutfit) == 6 then
			npcHandler:say('I guess my vision wasn\'t that grand after all. I hope there are still people who enjoy it.', cid)
		end
	elseif config[msg:lower()] then
		local targetMessage = config[msg:lower()]
		if getPlayerStorageValue(cid,OutfitQuest.BeggarOutfit) ~= targetMessage.value then
			npcHandler:say(targetMessage.messages.done, cid)
			return true
		end

		npcHandler:say(targetMessage.messages.deliever, cid)
		TopicState[cid] = 4
		message[cid] = targetMessage
	elseif msgcontains(msg, 'yes') then
		if TopicState[cid] == 2 then
			npcHandler:say('Good! Listen, I need the following material - first, 20 pieces of brown cloth, like the worn and ragged ghoul clothing. ...',cid)
			addEvent(selfSay, 3000,	'Secondly, 50 pieces of minotaur leather. Third, I need bat wings, maybe 10. And 30 heaven blossoms, the flowers elves cultivate. ...',cid)
			addEvent(selfSay, 6000,	'Have you noted down everything and will help me gather the material?', cid)
			TopicState[cid] = 3
		elseif TopicState[cid] == 3 then
			if getPlayerStorageValue(cid,OutfitQuest.DefaultStart) ~= 1 then
				setPlayerStorageValue(cid,OutfitQuest.DefaultStart, 1)
			end
			setPlayerStorageValue(cid,OutfitQuest.BeggarOutfit, 1)
			npcHandler:say('Terrific! What are you waiting for?! Start right away gathering 20 pieces of brown cloth and come back once you have them!', cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 4 then
			local targetMessage = message[cid]
			if not doPlayerRemoveItem(cid,targetMessage.itemId, targetMessage.count) then
				npcHandler:say(targetMessage.messages.notEnough, cid)
				return true
			end

			setPlayerStorageValue(cid,OutfitQuest.BeggarOutfit, getPlayerStorageValue(cid,OutfitQuest.BeggarOutfit) + 1)
			if targetMessage.lastItem then
				setPlayerStorageValue(cid,OutfitQuest.BeggarOutfitTimer, os.time() + 86400)
			end
			npcHandler:say(targetMessage.messages.success, cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 5 then
			if getPlayerSex(cid) == 1 then
			doPlayerAddOutfit(cid, 157)
			elseif getPlayerSex(cid) == 0 then
			doPlayerAddOutfit(cid, 153)
			setPlayerStorageValue(cid,OutfitQuest.BeggarOutfit, 6)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
			npcHandler:say('Here you go. Maybe you enjoy if after all.', cid)
			TopicState[cid] = 0
		end
		end
	elseif msgcontains(msg, 'no') then
		if TopicState[cid] == 2 then
			npcHandler:say('Argh! I guess this awesome idea has to remain unimplemented. What a pity.', cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 3 then
			npcHandler:say('Do you want me to repeat the task requirements?', cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 4 then
			npcHandler:say('Hurry! I am at my creative peak right now!', cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 5 then
			npcHandler:say('Well, if you should change your mind, just ask me for the beggar outfit.', cid)
			TopicState[cid] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())