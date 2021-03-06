local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end

local lastSound = 0
function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 5)
		if math.random(100) < 25 then
			npcHandler:say("Quality armors for sale!", TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I run this armoury. If you want to protect your life, you better buy my wares."})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = isPlayer(cid)
	if isInArray({"addon", "armor"}, msg) then
		if getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon) == 5 then
			setPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon, 6)
			setPlayerStorageValue(cid,OutfitQuest.WarriorShoulderTimer, os.time() + (getPlayerSex(cid) == PLAYERSEX_FEMALE and 3600 or 7200))
			npcHandler:say('Ah, you must be the hero Trisha talked about. I\'ll prepare the shoulder spikes for you. Please give me some time to finish.', cid)
		elseif getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon) == 6 then
			if getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderTimer) > os.time() then
				npcHandler:say('I\'m not done yet. Please be as patient as you are courageous.', cid)
			elseif getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderTimer) > 0 and getPlayerStorageValue(cid,OutfitQuest.WarriorShoulderTimer) < os.time() then
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				setPlayerStorageValue(cid,OutfitQuest.WarriorShoulderAddon, 7)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 134, 1)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 142, 1)
				end
				npcHandler:say('Finished! Since you are a man, I thought you probably wanted two. Men always want that little extra status symbol. <giggles>', cid)
			else
				npcHandler:say('I\'m selling leather armor, chain armor, and brass armor. Ask me for a {trade} if you like to take a look.', cid)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Welcome to the finest {armor} shop in the land, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. Come back soon.")
npcHandler:addModule(FocusModule:new())