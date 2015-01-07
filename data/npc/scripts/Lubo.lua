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
			npcHandler:say('Stop by and rest a while, tired adventurer! Have a look at my wares!', TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)
	local addonProgress = getPlayerStorageValue(cid,OutfitQuest.Citizen.AddonBackpack)
	if msgcontains(msg, 'addon') or msgcontains(msg, 'outfit')
			or (addonProgress == 1 and msgcontains(msg, 'leather'))
			or ((addonProgress == 1 or addonProgress == 2) and msgcontains(msg, 'backpack')) then
		if addonProgress < 1 then
			npcHandler:say('Sorry, the backpack I wear is not for sale. It\'s handmade from rare minotaur leather.', cid)
			TopicState[cid] = 1
		elseif addonProgress == 1 then
			npcHandler:say('Ah, right, almost forgot about the backpack! Have you brought me 100 pieces of minotaur leather as requested?', cid)
			TopicState[cid] = 3
		elseif addonProgress == 2 then
			if getPlayerStorageValue(cid,OutfitQuest.Citizen.AddonBackpackTimer) < os.time() then
				npcHandler:say('Just in time! Your backpack is finished. Here you go, I hope you like it.', cid)
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				setPlayerStorageValue(cid,OutfitQuest.Ref, math.min(0, getPlayerStorageValue(cid,OutfitQuest.Ref) - 1))
				setPlayerStorageValue(cid,OutfitQuest.Citizen.MissionBackpack, 0)
				setPlayerStorageValue(cid,OutfitQuest.Citizen.AddonBackpack, 3)
			else
				npcHandler:say('Uh... I didn\'t expect you to return that early. Sorry, but I\'m not finished yet with your backpack. I\'m doing the best I can, promised.', cid)
			end
		elseif addonProgress == 3 then
			npcHandler:say('Sorry, but I can only make one backpack per person, else I\'d have to close my shop and open a leather manufactory.', cid)
		end
		return true
	end

	if TopicState[cid] == 1 then
		if msgcontains(msg, 'backpack') or msgcontains(msg, 'minotaur') or msgcontains(msg, 'leather') then
			npcHandler:say('Well, if you really like this backpack, I could make one for you, but minotaur leather is hard to come by these days. Are you willing to put some work into this?', cid)
			TopicState[cid] = 2
		end

	elseif TopicState[cid] == 2 then
		if msgcontains(msg, 'yes') then
			setPlayerStorageValue(cid,OutfitQuest.Ref, math.max(getPlayerStorageValue(cid,OutfitQuest.Ref),0) + 1)
			setPlayerStorageValue(cid,OutfitQuest.Citizen.AddonBackpack, 1)
			setPlayerStorageValue(cid,OutfitQuest.Citizen.MissionBackpack, 1)
			npcHandler:say('Alright then, if you bring me 100 pieces of fine minotaur leather I will see what I can do for you. You probably have to kill really many minotaurs though... so good luck!', cid)
			npcHandler:releaseFocus(cid)
		else
			npcHandler:say('Sorry, but I don\'t run a welfare office, you know... no pain, no gain.', cid)
		end
		TopicState[cid] = 0

	elseif TopicState[cid] == 3 then
		if msgcontains(msg, 'yes') then
			if getPlayerItemCount(cid,5878) < 100 then
				npcHandler:say('Sorry, but that\'s not enough leather yet to make one of these backpacks. Would you rather like to buy a normal backpack for 10 gold?', cid)
			else
				npcHandler:say('Great! Alright, I need a while to finish this backpack for you. Come ask me later, okay?', cid)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 128, 1)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 136, 1)
				end
				doPlayerRemoveItem(cid,5878, 100)

				setPlayerStorageValue(cid,OutfitQuest.Citizen.MissionBackpack, 2)
				setPlayerStorageValue(cid,OutfitQuest.Citizen.AddonBackpack, 2)
				setPlayerStorageValue(cid,OutfitQuest.Citizen.AddonBackpackTimer, os.time() + 2 * 60 * 60)
			end
		else
			npcHandler:say('I know, it\'s quite some work... don\'t lose heart, just keep killing minotaurs and you\'ll eventually get lucky. Would you rather like to buy a normal backpack for 10 gold?', cid)
		end
		TopicState[cid] = 0
	end
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am selling equipment for adventurers. If you need anything, let me know.'})
keywordHandler:addKeyword({'dog'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Ruffy my dog, please don\'t do him any harm.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell torches, fishing rods, worms, ropes, water hoses, backpacks, apples, and maps.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'I am Lubo, the owner of this shop.'})
keywordHandler:addKeyword({'maps'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh! I\'m sorry, I sold the last one just five minutes ago.'})
keywordHandler:addKeyword({'hat'}, StdModule.say, {npcHandler = npcHandler, text = 'My hat? Hanna made this one for me.'})
keywordHandler:addKeyword({'finger'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh, you sure mean this old story about the mage Dago, who lost two fingers when he conjured a dragon.'})
keywordHandler:addKeyword({'pet'}, StdModule.say, {npcHandler = npcHandler, text = 'There are some strange stories about a magicians pet names. Ask Hoggle about it.'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome to my adventurer shop, |PLAYERNAME|! What do you need? Ask me for a {trade} to look at my wares.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())