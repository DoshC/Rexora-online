local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local message = {}

local config = {
	['blue cloth'] = {storageValue = 1, text = {'Brought the 50 pieces of blue cloth?', 'Good. Get me 50 pieces of green cloth now.'}, itemId = 5912, count = 50},
	['green cloth'] = {storageValue = 2, text = {'Brought the 50 pieces of green cloth?', 'Good. Get me 50 pieces of red cloth now.'}, itemId = 5910, count = 50},
	['red cloth'] = {storageValue = 3, text = {'Brought the 50 pieces of red cloth?', 'Good. Get me 50 pieces of brown cloth now.'}, itemId = 5911, count = 50},
	['brown cloth'] = {storageValue = 4, text = {'Brought the 50 pieces of brown cloth?', 'Good. Get me 50 pieces of yellow cloth now.'}, itemId = 5913, count = 50},
	['yellow cloth'] = {storageValue = 5, text = {'Brought the 50 pieces of yellow cloth?', 'Good. Get me 50 pieces of white cloth now.'}, itemId = 5914, count = 50},
	['white cloth'] = {storageValue = 6, text = {'Brought the 50 pieces of white cloth?', 'Good. Get me 10 spools of yarn now.'}, itemId = 5909, count = 50},
	['spools of yarn'] = {storageValue = 7, text = {'Brought the 10 spools of yarn?', 'Thanks. That\'s it, you\'re done. Good job, |PLAYERNAME|. I keep my promise. Here\'s my old assassin head piece.'}, itemId = 5886, count = 10}
}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)

	if msgcontains(msg, 'addon') then
		if getPlayerStorageValue(cid,OutfitQuest.AssassinFirstAddon) < 1 then
			npcHandler:say('Vescu gave you an assassin outfit? Haha. Noticed it lacks the head piece? You look a bit silly. Want my old head piece?', cid)
			TopicState[cid] = 1
		end
	elseif config[msg] and TopicState[cid] == 0 then
		if getPlayerStorageValue(cid,OutfitQuest.AssassinFirstAddon) == config[msg].storageValue then
			npcHandler:say(config[msg].text[1], cid)
			TopicState[cid] = 3
			message[cid] = msg
		end
	elseif msgcontains(msg, 'yes') then
		if TopicState[cid] == 1 then
			npcHandler:say('Thought so. Could use some help anyway. Listen, I need stuff. Someone gave me a strange assignment - sneak into Thais castle at night and shroud it with cloth without anyone noticing it. ...',cid)
			addEvent(selfSay, 3000,	'I wonder why anyone would want to shroud a castle, but as long as long as the guy pays, no problem, I\'ll do the sneaking part. Need a lot of cloth though. ...',cid)
			addEvent(selfSay, 6000,	'Gonna make it colourful. Bring me 50 pieces of {blue cloth}, 50 pieces of {green cloth}, 50 pieces of {red cloth}, 50 pieces of {brown cloth}, 50 pieces of {yellow cloth} and 50 pieces of {white cloth}. ...',cid)
			addEvent(selfSay, 9000,	'Besides, gonna need 10 {spools of yarn}. Understood?', cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 2 then
			if getPlayerStorageValue(cid,OutfitQuest.DefaultStart) ~= 1 then
				setPlayerStorageValue(cid,OutfitQuest.DefaultStart, 1)
			end
			setPlayerStorageValue(cid,OutfitQuest.AssassinFirstAddon, 1)
			npcHandler:say('Good. Start with the blue cloth. I\'ll wait.', cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 3 then
			local targetMessage = config[message[cid]]
			if not doPlayerRemoveItem(cid,targetMessage.itemId, targetMessage.count) then
				npcHandler:say('You don\'t have the required items.', cid)
				TopicState[cid] = 0
				return true
			end

			setPlayerStorageValue(cid,OutfitQuest.AssassinFirstAddon, getPlayerStorageValue(cid,OutfitQuest.AssassinFirstAddon) + 1)
			if getPlayerStorageValue(cid,OutfitQuest.AssassinFirstAddon) == 8 then
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 152, 1)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 156, 1)
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				end
			end
			npcHandler:say(targetMessage.text[2]:gsub('|PLAYERNAME|', getCreatureName(cid)), cid)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, 'no') and TopicState[cid] > 0 then
		npcHandler:say('Maybe another time.', cid)
		TopicState[cid] = 0
	end
	return true
end



npcHandler:setMessage(MESSAGE_GREET, 'What the... I mean, of course I sensed you.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())