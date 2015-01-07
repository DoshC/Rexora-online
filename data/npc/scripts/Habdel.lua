local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if msgcontains(msg, 'outfit') then
		if getPlayerSex(cid) == PLAYERSEX_FEMALE then
			npcHandler:say('My scimitar? Well, mylady, I do not want to sound rude, but I don\'t think a scimitar would fit to your beautiful outfit. If you are looking for an accessory, why don\'t you talk to Ishina?', cid)
			return true
		end
		if getPlayerStorageValue(cid,OutfitQuest.firstOrientalAddon) < 1 then
			npcHandler:say('My scimitar? Yes, that is a true masterpiece. Of course I could make one for you, but I have a small request. Would you fulfil a task for me?', cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, 'comb') then
		if getPlayerSex(cid) == PLAYERSEX_FEMALE then
			npcHandler:say('Comb? This is a weapon shop.', cid)
			return true
		end
		if getPlayerStorageValue(cid,OutfitQuest.firstOrientalAddon) == 1 then
			npcHandler:say('Have you brought a mermaid\'s comb for Ishina?', cid)
			TopicState[cid] = 3
		end
	elseif msgcontains(msg, 'yes') then
		if TopicState[cid] == 1 then
			npcHandler:say('Listen, um... I know that Ishina has been wanting a comb for a long time... not just any comb, but a mermaid\'s comb. She said it prevents split ends... or something. ...',cid)
			addEvent(selfSay, 3000,'Do you think you could get one for me so I can give it to her? I really would appreciate it.', cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 2 then
			setPlayerStorageValue(cid,OutfitQuest.DefaultStart, 1)
			setPlayerStorageValue(cid,OutfitQuest.firstOrientalAddon, 1)
			npcHandler:say('Brilliant! I will wait for you to return with a mermaid\'s comb then.', cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 3 then
			if not doPlayerRemoveItem(cid,5945, 1) then
				npcHandler:say('No... that\'s not it.', cid)
				TopicState[cid] = 0
				return true
			end
			setPlayerStorageValue(cid,OutfitQuest.firstOrientalAddon, 2)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
			npcHandler:say('Yeah! That\'s it! I can\'t wait to give it to her! Oh - but first, I\'ll fulfil my promise: Here is your scimitar! Thanks again!', cid)
			if getPlayerSex(cid) == 1 then
			doPlayerAddOutfit(cid, 150, 1)
			elseif getPlayerSex(cid) == 0 then
			doPlayerAddOutfit(cid, 146, 1)
			TopicState[cid] = 0
			end
		end
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] ~= 0 then
		npcHandler:say('Ah well. Doesn\'t matter.', cid)
		TopicState[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'weapons'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell the finest weapons in town. If you\'d like to see my offers, ask me for a {trade}.'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome |PLAYERNAME|! See the fine {weapons} I sell.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. Come back soon.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye. Come back soon.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())