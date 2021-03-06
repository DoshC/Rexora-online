local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local config = {
	['hardened bones'] = {
		storageValue = 1,
		message = {
			wrongValue = 'Well, I\'ll give you a little hint. They can sometimes be extracted from creatures that consist only of - you guessed it, bones. You need an obsidian knife though.',
			deliever = 'How are you faring with your mission? Have you collected all 100 hardened bones?',
			success = 'I\'m surprised. That\'s pretty good for a man. Now, bring us the 100 turtle shells.'
		},
		itemId = 5925,
		count = 100
	},
	['turtle shells'] = {
		storageValue = 2,
		message = {
			wrongValue = 'Turtles can be found on some idyllic islands which have recently been discovered.',
			deliever = 'Did you get us 100 turtle shells so we can make new shields?',
			success = 'Well done - for a man. These shells are enough to build many strong new shields. Thank you! Now - show me fighting spirit.'
		},
		itemId = 5899,
		count = 100
	},
	['fighting spirit'] = {
		storageValue = 3,
		message = {
			wrongValue = 'You should have enough fighting spirit if you are a true hero. Sorry, but you have to figure this one out by yourself. Unless someone grants you a wish.',
			deliever = 'So, can you show me your fighting spirit?',
			success = 'Correct - pretty smart for a man. But the hardest task is yet to come: the claw from a lord among the dragon lords.'
		},
		itemId = 5884
	},
	['dragon claw'] = {
		storageValue = 4,
		message = {
			wrongValue = 'You cannot get this special red claw from any common dragon in Tibia. It requires a special one, a lord among the lords.',
			deliever = 'Have you actually managed to obtain the dragon claw I asked for?',
			success = 'You did it! I have seldom seen a man as courageous as you. I really have to say that you deserve to wear a spike. Go ask Cornelia to adorn your armour.'
		},
		itemId = 5919
	}
}

local message = {}

local function greetCallback(cid)
	npcHandler:setMessage(MESSAGE_GREET, 'Salutations, |PLAYERNAME|. What can I do for you?')
	message[cid] = nil
	TopicState[cid] = 0
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	

	if TopicState[cid] == 0 then
		if isInArray({'outfit', 'addon'}, msg) then
			npcHandler:say('Are you talking about my spiky shoulder pad? You can\'t buy one of these. They have to be {earned}.', cid)
		elseif msgcontains(msg, 'earn') then
			if getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon) < 1 then
				npcHandler:say('I\'m not sure if you are enough of a hero to earn them. You could try, though. What do you think?', cid)
				TopicState[cid] = 1
			elseif getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon) >= 1 and getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon) < 5 then
				npcHandler:say('Before I can nominate you for an award, please complete your task.', cid)
			elseif getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon) == 5 then
				npcHandler:say('You did it! I have seldom seen a man as courageous as you. I really have to say that you deserve to wear a spike. Go ask Cornelia to adorn your armour.', cid)
			end
		elseif config[msg:lower()] then
			local targetMessage = config[msg:lower()]
			if getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon) ~= targetMessage.storageValue then
				npcHandler:say(targetMessage.message.wrongValue, cid)
				return true
			end

			npcHandler:say(targetMessage.message.deliever, cid)
			TopicState[cid] = 3
			message[cid] = targetMessage
		end
	elseif TopicState[cid] == 1 then
		if msgcontains(msg, 'yes') then
			npcHandler:say('Okay, who knows, maybe you have a chance. A really small one though. Listen up: ...',cid)
			addEvent(selfSay, 3000,	'First, you have to prove your guts by bringing me 100 hardened bones. ...',cid)
			addEvent(selfSay, 6000,	'Next, if you actually managed to collect that many, please complete a small task for our guild and bring us 100 turtle shells. ...',cid)
			addEvent(selfSay, 9000,	'It is said that excellent shields can be created from these. ...',cid)
			addEvent(selfSay, 12000,	'Alright, um, afterwards show me that you have fighting spirit. Any true hero needs plenty of that. ...',cid)
			addEvent(selfSay, 15000,	'The last task is the hardest. You will need to bring me a claw from a mighty dragon king. ...',cid)
			addEvent(selfSay, 18000,	'Did you understand everything I told you and are willing to handle this task?', cid)
			TopicState[cid] = 2
		elseif msgcontains(msg, 'no') then
			npcHandler:say('I thought so. Train hard and maybe some day you will be ready to face this mission.', cid)
			TopicState[cid] = 0
		end
	elseif TopicState[cid] == 2 then
		if msgcontains(msg, 'yes') then
			setPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon, 1)
			setPlayerStorageValue(cid,OutfitQuest.DefaultStart, 1) --this for default start of Outfit and Addon Quests
			npcHandler:say('Excellent! Don\'t forget: Your first task is to bring me 100 hardened bones. Good luck!', cid)
			TopicState[cid] = 0
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Would you like me to repeat the task requirements then?', cid)
			TopicState[cid] = 1
		end
	elseif TopicState[cid] == 3 then
		if msgcontains(msg, 'yes') then
			local targetMessage = message[cid]
			if not doPlayerRemoveItem(cid,targetMessage.itemId, targetMessage.count or 1) then
				npcHandler:say('Why do men always lie?', cid)
				return true
			end

			setPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon, getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon) + 1)
			npcHandler:say(targetMessage.message.success, cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Don\'t give up just yet.', cid)
		end
		TopicState[cid] = 0
	end
	return true
end

npcHandler:setMessage(MESSAGE_WALKAWAY, 'Be careful on your journeys.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Don\'t hurt yourself with that weapon, little one.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())