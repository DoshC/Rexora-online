local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	local player = isPlayer(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif(msgcontains(msg, 'addon')) then
		selfSay('I can forge the finest {weapons} for knights and warriors. They may wear them proudly and visible to everyone.', cid)
		TopicState[cid] = 1
	elseif msgcontains(msg, "firebird") then
		if getPlayerStorageValue(cid,OutfitQuest.PirateSabreAddon) == 4 then
			selfSay("Ahh. So Duncan sent you, eh? You must have done something really impressive. Okay, take this fine sabre from me, mate.", cid)
			setPlayerStorageValue(cid,OutfitQuest.PirateSabreAddon, 5)
			if getPlayerSex(cid) == 1 then
			doPlayerAddOutfit(cid, 155, 1)
			elseif getPlayerSex(cid) == 0 then
			doPlayerAddOutfit(cid, 151, 1)
			end
		end
	elseif(msgcontains(msg, 'weapons') and TopicState[cid] == 1) then
		selfSay('Would you rather be interested in a {knight\'s sword} or in a {warrior\'s sword}?', cid)
		TopicState[cid] = 2
	elseif (msgcontains(msg, 'warrior\'s sword') or msgcontains(msg, 'warriors sword')) then
		if TopicState[cid] == 2 and getPlayerStorageValue(cid,OutfitQuest.WarriorSwordAddon) < 1 then 
			selfSay('Great! Simply bring me 100 iron ore and one royal steel and I will happily {forge} it for you.', cid)
			TopicState[cid] = 3
		elseif TopicState[cid] == 4  and getPlayerStorageValue(cid,OutfitQuest.WarriorSwordAddon) < 1 then
			if doPlayerRemoveItem(cid,5887,1) and doPlayerRemoveItem(cid,5880,100) then
				selfSay('Alright! As a matter of fact, I have one in store. Here you go!', cid)             
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				setPlayerStorageValue(cid,OutfitQuest.WarriorSwordAddon,1) 
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 142, 2)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 134, 2)
				TopicState[cid] = 0
			else
				selfSay('You do not have all the required items.', cid)
				TopicState[cid] = 0
				end
			end
		elseif TopicState[cid] > 1 then 
			selfSay('You already have this outfit!', cid)
			TopicState[cid] = 0
		end
	elseif (msgcontains(msg, 'knights sword') or msgcontains(msg, 'knight\'s sword')) then
		if TopicState[cid] == 2 and getPlayerStorageValue(cid,OutfitQuest.KnightSwordAddon) < 1 then
			selfSay('Great! Simply bring me 100 Iron Ore and one Crude Iron and I will happily {forge} it for you.', cid)
			TopicState[cid] = 4
		elseif TopicState[cid] == 4 and getPlayerStorageValue(cid,OutfitQuest.KnightSwordAddon) < 1 then
			if doPlayerRemoveItem(cid,5892,1) and doPlayerRemoveItem(cid,5880,100) then
				selfSay('Alright! As a matter of fact, I have one in store. Here you go!', cid)             
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				setPlayerStorageValue(cid,OutfitQuest.KnightSwordAddon,1)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 139, 1)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 131, 1)
				TopicState[cid] = 0
			else
				selfSay('You do not have all the required items.', cid)
				TopicState[cid] = 0
				end
			end
		elseif TopicState[cid] > 1 then 
			selfSay('You already have this outfit!', cid)
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, 'forge') or msgcontains(msg, 'forge weapon')) then
		selfSay('What would you like me to forge for you? A {knight\'s sword} or a {warrior\'s sword}?', cid)
		TopicState[cid] = 4
	end
	
	if (msgcontains(msg, "bye") or msgcontains(msg, "farewell")) then
		npcHandler:say("Finally.", cid)
		TopicState[cid] = 0
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
	end
	
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
