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
	elseif(msgcontains(msg, "trouble") and getPlayerStorageValue(cid,TheInquisition.TimGuard) < 1 and getPlayerStorageValue(cid,TheInquisition.Mission01) ~= -1) then
		npcHandler:say("Ah, well. Just this morning my new toothbrush fell into the toilet.", cid)
		TopicState[cid] =  1
	elseif(msgcontains(msg, "authorities")) then
		if(TopicState[cid] == 1) then
			npcHandler:say("What do you mean? Of course they will immediately send someone with extra long and thin arms to retrieve it! ", cid)
			TopicState[cid] =  2
		end
	elseif(msgcontains(msg, "avoided")) then
		if(TopicState[cid] == 2) then
			npcHandler:say("Your humour might let end you up beaten in some dark alley, you know? No, I don't think someone could have prevented that accident! ", cid)
			TopicState[cid] =  3
		end
	elseif(msgcontains(msg, "gods would allow")) then
		if(TopicState[cid] == 3) then
			npcHandler:say("It's not a drama!! I think there is just no god who's responsible for toothbrush safety, that's all ... ", cid)
			TopicState[cid] =  0
			if(getPlayerStorageValue(cid,TheInquisition.TimGuard) < 1) then
				setPlayerStorageValue(cid,TheInquisition.TimGuard, 1)
				setPlayerStorageValue(cid,TheInquisition.Mission01, getPlayerStorageValue(cid,TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYAREA)
			end
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())