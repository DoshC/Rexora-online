local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local message = {}

local config = {
	['ape fur'] = {
		itemId = 5883,
		count = 100,
		storageValue = 1,
		text = {
			'Have you really managed to fulfil the task and brought me 100 pieces of ape fur?',
			'Only ape fur is good enough to touch the feet of our Caliph.',
			'Ahhh, this softness! I\'m impressed, |PLAYERNAME|. You\'re on the best way to earn that turban. Now, please retrieve 100 fish fins.'
		}
	},
	['fish fins'] = {
		itemId = 5895,
		count = 100,
		storageValue = 2,
		text = {
			'Were you able to discover the undersea race and retrieved 100 fish fins?',
			'I really wonder what the explorer society is up to. Actually I have no idea how they managed to dive unterwater.',
			'I never thought you\'d make it, |PLAYERNAME|. Now we only need two enchanted chicken wings to start our waterwalking test!'
		}
	},
	['enchanted chicken wings'] = {
		itemId = 5891,
		count = 2,
		storageValue = 3,
		text = {
			'Were you able to get hold of two enchanted chicken wings?',
			'Enchanted chicken wings are actually used to make boots of haste, so they could be magically extracted again. Djinns are said to be good at that.',
			'Great, thank you very much. Just bring me 100 pieces of blue cloth now and I will happily show you how to make a turban.'
		}
	},
	['blue cloth'] = {
		itemId = 5912,
		count = 100,
		storageValue = 4,
		text = {
			'Ah, have you brought the 100 pieces of blue cloth?',
			'It\'s a great material for turbans.',
			'Ah! Congratulations - I hope this veil will turn out as beautiful as you are. Here, I\'ll do it for you.'
		}
	}
}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if msgcontains(msg, 'outfit') then
		npcHandler:say(getPlayerSex(cid) == PLAYERSEX_FEMALE and 'Hehe, would you like to wear a pretty veil like I do? Well... I could help you, but you would have to complete a task first.' or 'My veil? No, I will definitely not lift it for you! If you are looking for an addon, go talk to Razan.', cid)
	elseif msgcontains(msg, 'task') then
		if getPlayerSex(cid) == PLAYERSEX_MALE then
			npcHandler:say('Uh... I don\'t think that I have work for you right now. If you need a job, go talk to Razan.', cid)
			return true
		end
		if getPlayerStorageValue(cid,OutfitQuest.secondOrientalAddon) < 1 then
			npcHandler:say('You mean, you would like to prove that you deserve to wear such a veil?', cid)
			TopicState[cid] = 1
		end
	elseif config[msg] and TopicState[cid] == 0 then
		if getPlayerStorageValue(cid,OutfitQuest.secondOrientalAddon) == config[msg].storageValue then
			npcHandler:say(config[msg].text[1], cid)
			TopicState[cid] = 3
			message[cid] = msg
		else
			npcHandler:say(config[msg].text[2], cid)
		end
	elseif msgcontains(msg, 'scarab cheese') then
		if getPlayerStorageValue(cid,TravellingTrader.Mission03) == 1 then
			npcHandler:say('Let me cover my nose before I get this for you... Would you REALLY like to buy scarab cheese for 100 gold?', cid)
		elseif getPlayerStorageValue(cid,TravellingTrader.Mission03) == 2 then
			npcHandler:say('Oh the last cheese molded? Would you like to buy another one for 100 gold?', cid)
		end
		TopicState[cid] = 4
	elseif msgcontains(msg, 'yes') then
		if TopicState[cid] == 1 then
			npcHandler:say('Alright, then listen to the following requirements. We are currently in dire need of ape fur since the Caliph has requested a new bathroom carpet. ...',cid)
			addEvent(selfSay, 3000,	'Thus, please bring me 100 pieces of ape fur. Secondly, it came to our ears that the explorer society has discovered a new undersea race of fishmen. ...',cid)
			addEvent(selfSay, 6000,	'Their fins are said to allow humans to walk on water! Please bring us 100 of these fish fin. ...',cid)
			addEvent(selfSay, 9000,	'Third, if the plan of walking on water should fail, we need enchanted chicken wings to prevent the testers from drowning. Please bring me two. ...',cid)
			addEvent(selfSay, 12000,	'Last but not least, just drop by with 100 pieces of blue cloth and I will happily show you how to make a turban. ...',cid)
			addEvent(selfSay, 15000,	'Did you understand everything I told you and are willing to handle this task?', cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 2 then
			if getPlayerStorageValue(cid,OutfitQuest.DefaultStart) ~= 1 then
				setPlayerStorageValue(cid,OutfitQuest.DefaultStart, 1)
			end
			setPlayerStorageValue(cid,OutfitQuest.secondOrientalAddon, 1)
			npcHandler:say('Excellent! Come back to me once you have collected 100 pieces of ape fur.', cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 3 then
			local targetMessage = config[message[cid]]
			if not doPlayerRemoveItem(cid,targetMessage.itemId, targetMessage.count) then
				npcHandler:say('That is a shameless lie.', cid)
				TopicState[cid] = 0
				return true
			end
			setPlayerStorageValue(cid,OutfitQuest.secondOrientalAddon, getPlayerStorageValue(cid,OutfitQuest.secondOrientalAddon) + 1)
			if getPlayerStorageValue(cid,OutfitQuest.secondOrientalAddon) == 5 then
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 150, 2)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 146, 2)
				TopicState[cid] = 0
				end
			end
			npcHandler:say(targetMessage.text[3]:gsub('|PLAYERNAME|', getCreatureName(cid)), cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 4 then
			if getPlayerMoney(cid) >= 100 then
				setPlayerStorageValue(cid,TravellingTrader.Mission03, 2)
				doPlayerAddItem(cid,8112, 1)
				doPlayerRemoveItem(cid,100)
				npcHandler:say('Here it is.', cid)
			else
				npcHandler:say('You don\'t have enough money.', cid)
			end
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] ~= 0 then
		npcHandler:say('What a pity.', cid)
		TopicState[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'drink'}, StdModule.say, {npcHandler = npcHandler, text = 'I can offer you lemonade, camel milk, and water. If you\'d like to see my offers, ask me for a {trade}.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = 'Are you looking for food? I have bread, cheese, ham, and meat. If you\'d like to see my offers, ask me for a {trade}.'})

npcHandler:setMessage(MESSAGE_GREET, 'Daraman\'s blessings, |PLAYERNAME|. Welcome to the Enlightened Oasis. Sit down, have a {drink} or some {food}!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Daraman\'s blessings. Come back soon.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())