local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'arrow'}, 2544, 3, 'arrow')
shopModule:addBuyableItem({'assassin star'}, 7368, 100, 'assassin star')
shopModule:addBuyableItem({'bolt'}, 2543, 4, 'bolt')
shopModule:addBuyableItem({'bow'}, 2456, 400, 'bow')
shopModule:addBuyableItem({'crossbow'}, 2455, 500, 'crossbow')
shopModule:addBuyableItem({'spear'}, 2389, 9, 'spear')

local function greetCallback(cid)
	if getCreatureCondition(cid,CONDITION_FIRE) then
		npcHandler:setMessage(MESSAGE_GREET, 'Hehe. That\'s a good show, |PLAYERNAME|, with all the pyro effects. You got my attention. For a minute or so.')
	else
		return false
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)

	if msgcontains(msg, 'addon') then
		if getPlayerStorageValue(cid,OutfitQuest.AssassinSecondAddon) < 1 then
			npcHandler:say('You managed to deceive Erayo? Impressive. Well, I guess, since you have come that far, I might as well give you a task too, eh?', cid)
			TopicState[cid] = 1
		else
			npcHandler:say('I don\'t know what you are talking about.', cid)
		end
	elseif msgcontains(msg, 'nose ring') then
		if getPlayerStorageValue(cid,OutfitQuest.AssassinSecondAddon) == 1 then
			if getPlayerItemCount(cid,5804) > 0 and getPlayerItemCount(cid,5930) > 0 then
				doPlayerRemoveItem(cid,5804, 1)
				doPlayerRemoveItem(cid,5930, 1)
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				setPlayerStorageValue(cid,OutfitQuest.AssassinSecondAddon, 2)
				npcHandler:say('I see you brought my stuff. Good. I\'ll keep my promise: Here\'s katana in return.', cid)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 152, 2)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 156, 2)
			else
				npcHandler:say('You don\'t have the required items.', cid)
			end
		end
	end
	elseif msgcontains(msg, 'yes') then
		if TopicState[cid] == 1 then
			npcHandler:say('Okay, listen up. I don\'t have a list of stupid objects, I just want two things. A {behemoth claw} and a {nose ring}. Got that?', cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 2 then
			if getPlayerStorageValue(cid,OutfitQuest.DefaultStart) ~= 1 then
				setPlayerStorageValue(cid,OutfitQuest.DefaultStart, 1)
			end
			setPlayerStorageValue(cid,OutfitQuest.AssassinSecondAddon, 1)
			npcHandler:say('Good. Come back when you have BOTH. Should be clear where to get a behemoth claw from. There\'s a horned fox who wears a nose ring. Good luck.', cid)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > 0 then
		npcHandler:say('Maybe another time.', cid)
		TopicState[cid] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())