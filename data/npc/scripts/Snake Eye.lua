local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

-- OTServ event handling functions start
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onPlayerEndTrade(cid)              npcHandler:onPlayerEndTrade(cid) end
function onPlayerCloseChannel(cid)          npcHandler:onPlayerCloseChannel(cid) end
function onThink()                          npcHandler:onThink() end
-- OTServ event handling functions end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if msgcontains(msg, 'package for rashid') then
		if getPlayerStorageValue(cid,TravellingTrader.Mission02) >= 1 and getPlayerStorageValue(cid,TravellingTrader.Mission02) < 3 then
			npcHandler:say('So you\'re the delivery boy? Go ahead, but I warn you, it\'s quite heavy. You can take it from the box over there.', cid)
			setPlayerStorageValue(cid,TravellingTrader.Mission02, getPlayerStorageValue(cid,TravellingTrader.Mission02) + 1)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, 'documents') then
		if getPlayerStorageValue(cid,thievesGuild.Mission04) == 1 then
			setPlayerStorageValue(cid,thievesGuild.Mission04, 2)
			npcHandler:say('Funny thing that everyone thinks we have forgers for fake documents here. But no, we don\'t. The best forger is old Ahmet in Ankrahmun.', cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())