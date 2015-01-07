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
	elseif(msgcontains(msg, "trouble") and getPlayerStorageValue(cid,TheInquisition.KulagGuard) < 1 and getPlayerStorageValue(cid,TheInquisition.Mission01) ~= -1) then
		npcHandler:say("You adventurers become more and more of a pest.", cid)
		TopicState[cid] = 1
	elseif(msgcontains(msg, "authorities")) then
		if(TopicState[cid] == 1) then
			npcHandler:say("They should throw you all into jail instead of giving you all those quests and rewards an honest watchman can only dream about.", cid)
			TopicState[cid] = 0
			if(getPlayerStorageValue(cid,TheInquisition.KulagGuard) < 1) then
				setPlayerStorageValue(cid,TheInquisition.KulagGuard, 1)
				setPlayerStorageValue(cid,TheInquisition.Mission01, getPlayerStorageValue(cid,TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYAREA)
			end
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())