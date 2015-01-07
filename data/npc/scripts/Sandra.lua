local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local voices = {
	'Great spirit potions as well as health and mana potions in different sizes!',
	'If you need alchemical fluids like slime and blood, get them here.'
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

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if isInArray({"vial", "ticket", "bonus", "deposit"}, msg) then
		if getPlayerStorageValue(cid,OutfitQuest.MageSummonerFluidBeltAddon) < 1 then
			npcHandler:say("We have a special offer right now for depositing vials. Are you interested in hearing it?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,OutfitQuest.MageSummonerFluidBeltAddon) >= 1 then
			npcHandler:say("Would you like to get a lottery ticket instead of the deposit for your vials?", cid)
			TopicState[cid] = 3
		end
	elseif msgcontains(msg, "prize") then
		npcHandler:say("Are you here to claim a prize?", cid)
		TopicState[cid] = 4
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			npcHandler:say("The Edron academy has introduced a bonus system. Each time you deposit 100 vials without claiming the money for it, you will receive a lottery ticket. ...",cid)
			addEvent(selfSay, 3000,	"Some of these lottery tickets will grant you a special potion belt accessory, if you bring the ticket to me. ...",cid)
			addEvent(selfSay, 6000,	"If you join the bonus system now, I will ask you each time you are bringing back 100 or more vials to me whether you claim your deposit or rather want a lottery ticket. ...",cid)
			addEvent(selfSay, 9000,	"Of course, you can leave or join the bonus system at any time by just asking me for the 'bonus'. ...",cid)
			addEvent(selfSay, 12000,	"Would you like to join the bonus system now?", cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 2 then
			npcHandler:say("Great! I've signed you up for our bonus system. From now on, you will have the chance to win the potion belt addon!", cid)
			setPlayerStorageValue(cid,OutfitQuest.MageSummonerFluidBeltAddon, 1)
			setPlayerStorageValue(cid,OutfitQuest.DefaultStart, 1) --this for default start of Outfit and Addon Quests
			TopicState[cid] = 0
		elseif TopicState[cid] == 3 then
			if doPlayerRemoveItem(cid,7634, 100) or doPlayerRemoveItem(cid,7635, 100) or doPlayerRemoveItem(cid,7636, 100) then
				npcHandler:say("Ok here take this lottery ticket!", cid)
				doPlayerAddItem(cid,5957, 1)
				TopicState[cid] = 0
			else
				npcHandler:say("You don't have 100 vials.", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 4 then
			if getPlayerStorageValue(cid,OutfitQuest.MageSummonerFluidBeltAddon) == 1 and doPlayerRemoveItem(cid,5958, 1) then
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 133, 1)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 138, 1)	
				setPlayerStorageValue(cid,OutfitQuest.MageSummonerFluidBeltAddon, 2)
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				npcHandler:say("Congratulations! Here, from now on you can wear our lovely potion belt as accessory.", cid)
			else
				npcHandler:say("You don't have any prize to claim!", cid)
			end
			end
			TopicState[cid] = 0
		end
		return true
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, welcome to the fluid and potion shop of Edron.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|, please come back soon.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, |PLAYERNAME|, please come back soon.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares. By the way, if you'd like to join our bonus system for depositing flasks and vial, you have to tell me about that {deposit}.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())