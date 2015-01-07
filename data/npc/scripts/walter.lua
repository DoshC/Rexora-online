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
	local player = isPlayer(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif(msgcontains(msg, "trouble") and getPlayerStorageValue(cid,TheInquisition.WalterGuard) < 1 and getPlayerStorageValue(cid,TheInquisition.Mission01) ~= -1) then
		npcHandler:say("I think there is a pickpocket in town.", cid)
		TopicState[cid] = 1
	elseif(msgcontains(msg, "authorities")) then
		if(TopicState[cid] == 1) then
			npcHandler:say("Well, sooner or later we will get hold of that delinquent. That's for sure.", cid)
			TopicState[cid] = 2
		end
	elseif(msgcontains(msg, "avoided")) then
		if(TopicState[cid] == 2) then
			npcHandler:say("You can't tell by a person's appearance who is a pickpocket and who isn't. You simply can't close the city gates for everyone.", cid)
			TopicState[cid] = 3
		end
	elseif(msgcontains(msg, "gods allow")) then
		if(TopicState[cid] == 3) then
			npcHandler:say("If the gods had created the world a paradise, no one had to steal at all.", cid)
			TopicState[cid] = 0
			if(getPlayerStorageValue(cid,TheInquisition.WalterGuard) < 1) then
				setPlayerStorageValue(cid,TheInquisition.WalterGuard, 1)
				setPlayerStorageValue(cid,TheInquisition.Mission01, getPlayerStorageValue(cid,TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYAREA)
			end
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())