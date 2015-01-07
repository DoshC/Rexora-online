local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end

local voices = {
	'Alms! Alms for the poor!',
	'Sir, Ma\'am, have a gold coin to spare?',
	'I need help! Please help me!'
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

function BeggarFirst(cid, message, keywords, parameters, node)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)
	if isPremium(cid) then
		if getPlayerStorageValue(cid,OutfitQuest.BeggarFirstAddon) == -1 then
			if getPlayerItemCount(cid,5883) >= 100 and getPlayerMoney(cid) >= 20000 then
				if doPlayerRemoveItem(cid,5883, 100) and doPlayerRemoveMoney(cid,20000) then
					npcHandler:say("Ah, right! The beggar beard or beggar dress! Here you go.", cid)
					doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
					setPlayerStorageValue(cid,OutfitQuest.BeggarFirstAddon, 1)
					if getPlayerSex(cid) == 1 then
					doPlayerAddOutfit(cid, 157, 1)
					elseif getPlayerSex(cid) == 0 then
					doPlayerAddOutfit(cid, 153, 1)
					end
				end
			else
				npcHandler:say("You do not have all the required items.", cid)
			end
		else
			npcHandler:say("It seems you already have this addon, don't you try to mock me son!", cid)
		end
	end
end

function BeggarSecond(cid, message, keywords, parameters, node)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)
	if isPremium(cid) then
		if getPlayerStorageValue(cid,OutfitQuest.BeggarSecondAddon) == -1 then
			if getPlayerItemCount(cid,6107) >= 1 then
				if doPlayerRemoveItem(cid,6107, 1) then
					npcHandler:say("Ah, right! The beggar staff! Here you go.", cid)
					doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
					setPlayerStorageValue(cid,OutfitQuest.BeggarSecondAddon, 1)
					if getPlayerSex(cid) == 1 then
					doPlayerAddOutfit(cid, 157, 2)
					elseif getPlayerSex(cid) == 0 then
					doPlayerAddOutfit(cid, 153, 2)
					end
				end
			else
				npcHandler:say("You do not have all the required items.", cid)
			end
		else
			npcHandler:say("It seems you already have this addon, don't you try to mock me son!", cid)
		end
	end
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)

	if msgcontains(msg, 'cookie') then
		if getPlayerStorageValue(cid,WhatAFoolishQuest.Questline) == 31
				and getPlayerStorageValue(cid,WhatAFoolishQuest.CookieDelivery.SimonTheBeggar) ~= 1 then
			npcHandler:say('Have you brought a cookie for the poor?', cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, 'help') then
		npcHandler:say('I need gold. Can you spare 100 gold pieces for me?', cid)
		TopicState[cid] = 2
	elseif msgcontains(msg, 'yes') then
		if TopicState[cid] == 1 then
			if not doPlayerRemoveItem(cid,8111, 1) then
				npcHandler:say('You have no cookie that I\'d like.', cid)
				TopicState[cid] = 0
				return true
			end

			setPlayerStorageValue(cid,WhatAFoolishQuest.CookieDelivery.SimonTheBeggar, 1)
			if player:getCookiesDelivered() == 10 then
				player:addAchievement('Allow Cookies?')
			end

			Npc():getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			npcHandler:say('Well, it\'s the least you can do for those who live in dire poverty. A single cookie is a bit less than I\'d expected, but better than ... WHA ... WHAT?? MY BEARD! MY PRECIOUS BEARD! IT WILL TAKE AGES TO CLEAR IT OF THIS CONFETTI!', cid)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		elseif TopicState[cid] == 2 then
			if not doPlayerRemoveMoney(cid,100) then
				npcHandler:say('You haven\'t got enough money for me.', cid)
				TopicState[cid] = 0
				return true
			end

			npcHandler:say('Thank you very much. Can you spare 500 more gold pieces for me? I will give you a nice hint.', cid)
			TopicState[cid] = 3
		elseif TopicState[cid] == 3 then
			if not doPlayerRemoveMoney(cid,500) then
				npcHandler:say('Sorry, that\'s not enough.', cid)
				TopicState[cid] = 0
				return true
			end

			npcHandler:say('That\'s great! I have stolen something from Dermot. You can buy it for 200 gold. Do you want to buy it?', cid)
			TopicState[cid] = 4
		elseif TopicState[cid] == 4 then
			if not doPlayerRemoveMoney(cid,200) then
				npcHandler:say('Pah! I said 200 gold. You don\'t have that much.', cid)
				TopicState[cid] = 0
				return true
			end

			local key = player:addItem(2087, 1)
			if key then
				key:setActionId(3940)
			end
			npcHandler:say('Now you own the hot key.', cid)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] ~= 0 then
		if TopicState[cid] == 1 then
			npcHandler:say('I see.', cid)
		elseif TopicState[cid] == 2 then
			npcHandler:say('Hmm, maybe next time.', cid)
		elseif TopicState[cid] == 3 then
			npcHandler:say('It was your decision.', cid)
		elseif TopicState[cid] == 4 then
			npcHandler:say('Ok. No problem. I\'ll find another buyer.', cid)
		end
		TopicState[cid] = 0
	end
	return true
end

node1 = keywordHandler:addKeyword({'addon'}, StdModule.say, {npcHandler = npcHandler, text = 'For the small fee of 20000 gold pieces I will help you mix this potion. Just bring me 100 pieces of ape fur, which are necessary to create this potion. ...Do we have a deal?'})
node1:addChildKeyword({'yes'}, BeggarFirst, {})
node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Alright then. Come back when you got all neccessary items.', reset = true})

node2 = keywordHandler:addKeyword({'dress'}, StdModule.say, {npcHandler = npcHandler, text = 'For the small fee of 20000 gold pieces I will help you mix this potion. Just bring me 100 pieces of ape fur, which are necessary to create this potion. ...Do we have a deal?'})
node2:addChildKeyword({'yes'}, BeggarFirst, {})
node2:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Alright then. Come back when you got all neccessary items.', reset = true})

node3 = keywordHandler:addKeyword({'staff'}, StdModule.say, {npcHandler = npcHandler, text = 'To get beggar staff you need to give me simon the beggar\'s staff. Do you have it with you?'})
node3:addChildKeyword({'yes'}, BeggarSecond, {})
node3:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Alright then. Come back when you got all neccessary items.', reset = true})

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I am a poor man. Please help me.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Have a nice day.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Have a nice day.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())