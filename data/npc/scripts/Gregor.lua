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
			npcHandler:say("Gather around me, young knights! I'm going to teach you some spells!", TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)
	local addonProgress = getPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet)
	if msgcontains(msg, 'task') then
		if not isPremium(cid) then
			npcHandler:say('Sorry, but our tasks are only for premium warriors.', cid)
			return true
		end

		if addonProgress < 1 then
			npcHandler:say('You mean you would like to prove that you deserve to wear such a helmet?', cid)
			TopicState[cid] = 1
		elseif addonProgress == 1 then
			npcHandler:say('Your current task is to bring me 100 perfect behemoth fangs, '..getCreatureName(cid)..'', cid)
		elseif addonProgress == 2 then
			npcHandler:say('Your current task is to retrieve the helmet of Ramsay the Reckless from Banuta, '..getCreatureName(cid)..'', cid)
		elseif addonProgress == 3 then
			npcHandler:say('Your current task is to obtain a flask of warrior\'s sweat, '..getCreatureName(cid)..'', cid)
		elseif addonProgress == 4 then
			npcHandler:say('Your current task is to bring me royal steel, '..getCreatureName(cid)..'', cid)
		elseif addonProgress == 5 then
			npcHandler:say('Please talk to Sam and tell him I sent you. I\'m sure he will be glad to refine your helmet, '..getCreatureName(cid)..'', cid)
		else
			npcHandler:say('You\'ve already completed the task and can consider yourself a mighty warrior, '..getCreatureName(cid)..'', cid)
		end

	elseif msgcontains(msg, 'behemoth fang') then
		if addonProgress == 1 then
			npcHandler:say('Have you really managed to fulfil the task and brought me 100 perfect behemoth fangs?', cid)
			TopicState[cid] = 3
		else
			npcHandler:say('You\'re not serious asking that, are you? They come from behemoths, of course. Unless there are behemoth rabbits. Duh.', cid)
		end

	elseif msgcontains(msg, 'ramsay') then
		if addonProgress == 2 then
			npcHandler:say('Did you recover the helmet of Ramsay the Reckless?', cid)
			TopicState[cid] = 4
		else
			npcHandler:say('These pesky apes steal everything they can get their dirty hands on.', cid)
		end

	elseif msgcontains(msg, 'sweat') then
		if addonProgress == 3 then
			npcHandler:say('Were you able to get hold of a flask with pure warrior\'s sweat?', cid)
			TopicState[cid] = 5
		else
			npcHandler:say('Warrior\'s sweat can be magically extracted from headgear worn by a true warrior, but only in small amounts. Djinns are said to be good at magical extractions.', cid)
		end

	elseif msgcontains(msg, 'royal steel') then
		if addonProgress == 4 then
			npcHandler:say('Ah, have you brought the royal steel?', cid)
			TopicState[cid] = 6
		else
			npcHandler:say('Royal steel can only be refined by very skilled smiths.', cid)
		end

	elseif TopicState[cid] == 1 then
		if msgcontains(msg, 'yes') then
			npcHandler:say('Well then, listen closely. First, you will have to prove that you are a fierce and restless warrior by bringing me 100 perfect behemoth fangs. ...',cid)
			addEvent(selfSay, 3000,	'Secondly, please retrieve a helmet for us which has been lost a long time ago. The famous Ramsay the Reckless wore it when exploring an ape settlement. ...',cid)
			addEvent(selfSay, 6000,	'Third, we need a new flask of warrior\'s sweat. We\'ve run out of it recently, but we need a small amount for the show battles in our arena. ...',cid)
			addEvent(selfSay, 9000,	'Lastly, I will have our smith refine your helmet if you bring me royal steel, an especially noble metal. ...',cid)
			addEvent(selfSay, 12000,	'Did you understand everything I told you and are willing to handle this task?', cid)
			TopicState[cid] = 2
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Bah. Then you will have to wait for the day these helmets are sold in shops, but that will not happen before hell freezes over.', cid)
			TopicState[cid] = 0
		end

	elseif TopicState[cid] == 2 then
		if msgcontains(msg, 'yes') then
			setPlayerStorageValue(cid,OutfitQuest.Ref, math.max(getPlayerStorageValue(cid,OutfitQuest.Ref),0) + 1)
			setPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet, 1)
			setPlayerStorageValue(cid,OutfitQuest.Knight.MissionHelmet, 1)
			npcHandler:say('Alright then. Come back to me once you have collected 100 perfect behemoth fangs.', cid)
			TopicState[cid] = 0
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Would you like me to repeat the task requirements then?', cid)
			TopicState[cid] = 1
		end

	elseif TopicState[cid] == 3 then
		if msgcontains(msg, 'yes') then
			if not doPlayerRemoveItem(cid,5893, 100) then
				npcHandler:say('Lying is not exactly honourable, '..getCreatureName(cid)..' Shame on you.', cid)
				return true
			end

			setPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet, 2)
			setPlayerStorageValue(cid,OutfitQuest.Knight.MissionHelmet, 2)
			setPlayerStorageValue(cid,OutfitQuest.Knight.RamsaysHelmetDoor, 1)
			npcHandler:say('I\'m deeply impressed, brave Knight '..getCreatureName(cid)..' I expected nothing less from you. Now, please retrieve Ramsay\'s helmet.', cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('There is no need to rush anyway.', cid)
		end
		TopicState[cid] = 0

	elseif TopicState[cid] == 4 then
		if msgcontains(msg, 'yes') then
			if not doPlayerRemoveItem(cid,5924, 1) then
				npcHandler:say('Lying is not exactly honourable, '..getCreatureName(cid)..' Shame on you.', cid)
				return true
			end

			setPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet, 3)
			setPlayerStorageValue(cid,OutfitQuest.Knight.MissionHelmet, 3)
			npcHandler:say('Good work, brave Knight '..getCreatureName(cid)..'! Even though it is damaged, it has a lot of sentimental value. Now, please bring me warrior\'s sweat.', cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('There is no need to rush anyway.', cid)
		end
		TopicState[cid] = 0

	elseif TopicState[cid] == 5 then
		if msgcontains(msg, 'yes') then
			if not doPlayerRemoveItem(cid,5885, 1) then
				npcHandler:say('Lying is not exactly honourable, '..getCreatureName(cid)..' Shame on you.', cid)
				return true
			end

			setPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet, 4)
			setPlayerStorageValue(cid,OutfitQuest.Knight.MissionHelmet, 4)
			npcHandler:say('Now that is a pleasant surprise, brave Knight '..getCreatureName(cid)..'! There is only one task left now: Obtain royal steel to have your helmet refined.', cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('There is no need to rush anyway.', cid)
		end
		TopicState[cid] = 0

	elseif TopicState[cid] == 6 then
		if msgcontains(msg, 'yes') then
			if not doPlayerRemoveItem(cid,5887, 1) then
				npcHandler:say('Lying is not exactly honourable, '..getCreatureName(cid)..' Shame on you.', cid)
				return true
			end

			setPlayerStorageValue(cid,OutfitQuest.Knight.AddonHelmet, 5)
			setPlayerStorageValue(cid,OutfitQuest.Knight.MissionHelmet, 5)
			npcHandler:say('You truly deserve to wear an adorned helmet, brave Knight '..getCreatureName(cid)..' Please talk to Sam and tell him I sent you. I\'m sure he will be glad to refine your helmet.', cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('There is no need to rush anyway.', cid)
		end
		TopicState[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I am the first knight. I trained some of the greatest heroes of Tibia."})
keywordHandler:addKeyword({'heroes'}, StdModule.say, {npcHandler = npcHandler, text = "Of course, you heard of them. Knights are the best fighters in Tibia."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = "Hail to our King!"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "You are joking, eh? Of course, you know me. I am Gregor, the first knight."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, text = "A great name, isn't it?"})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = "Beautiful Tibia. And with our help everyone is save."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "It is time to join the Knights!"})
keywordHandler:addKeyword({'knights'}, StdModule.say, {npcHandler = npcHandler, text = "Knights are the warriors of Tibia. Without us, no one would be safe. Every brave and strong man or woman can join us."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, text = "Some day someone will make something happen to him..."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = "A bow might be a fine weapon for someone not strong enough to wield a REAL weapon."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, text = "I and my students often share a cask of beer or wine at Frodo's hut."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, text = "Always concerned with his profit. What a loss! He was adventuring with baxter in the old days."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, text = "He was an adventurer once."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, text = "Before she became a priest she won the Miss Tibia contest three times in a row."})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, text = "Peaceful farmers."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "A fine game to hunt. But be careful, he cheats!"})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, text = "Bah, go away with these sorcerer tricks. Only cowards use tricks."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, text = "What an idiot."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, text = "I will never understand this peaceful monks and priests."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, text = "He has the muscles, but lacks the guts."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, text = "Hail to our King!"})
keywordHandler:addKeyword({'outfit'}, StdModule.say, {npcHandler = npcHandler, text = "Only the bravest warriors may wear adorned helmets. They are traditionally awarded after having completed a difficult task for our guild."})
keywordHandler:addKeyword({'helmet'}, StdModule.say, {npcHandler = npcHandler, text = "Only the bravest warriors may wear adorned helmets. They are traditionally awarded after having completed a difficult task for our guild."})

npcHandler:setMessage(MESSAGE_GREET, "Greetings, |PLAYERNAME|. What do you want?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Be careful on your journeys.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Be careful on your journeys.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())