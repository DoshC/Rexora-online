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
	local isplayer = isPlayer(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, "trouble") and TopicState[cid] ~= 3 and getPlayerStorageValue(cid,TheInquisition.MilesGuard) < 1 and getPlayerStorageValue(cid,TheInquisition.Mission01) ~= -1 then
		npcHandler:say("I'm fine. There's no trouble at all.", cid)
		TopicState[cid] = 1
	elseif msgcontains(msg, "foresight of the authorities") and TopicState[cid] == 1 then
		npcHandler:say("Well, of course. We live in safety and peace.", cid)
		TopicState[cid] = 2
	elseif msgcontains(msg, "also for the gods") and TopicState[cid] == 2 then
		npcHandler:say("I think the gods are looking after us and their hands shield us from evil.", cid)
		TopicState[cid] = 3
	elseif msgcontains(msg, "trouble will arise in the near future") and TopicState[cid] == 3 then
		npcHandler:say("I think the gods and the government do their best to keep away harm from the citizens.", cid)
		TopicState[cid] = 0
		local player = isPlayer(cid)
		if getPlayerStorageValue(cid,TheInquisition.MilesGuard) < 1 then
			setPlayerStorageValue(cid,TheInquisition.MilesGuard, 1)
			setPlayerStorageValue(cid,TheInquisition.Mission01, getPlayerStorageValue(cid,TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYAREA)
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
