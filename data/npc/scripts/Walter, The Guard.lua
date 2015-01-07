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



function creatureSayCallback(cid, type, msg)

	if (msgcontains(msg, "hello") or msgcontains(msg, "hi")) and (not npcHandler:isFocused(cid)) then
		npcHandler:say("LONG LIVE THE KING!", cid)
		npcHandler:addFocus(cid)
		TopicState[cid] = 0

	elseif(not npcHandler:isFocused(cid)) then
		return false

	elseif msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
		npcHandler:say("", cid, TRUE)
		npcHandler:releaseFocus(cid)

	elseif msgcontains(msg, "trouble") and TopicState[cid] == 0 then
		npcHandler:say("I think there is a pickpocket in town.",cid)
		TopicState[cid] = 2
		
	elseif msgcontains(msg, "authorities") and TopicState[cid] == 2 then
		npcHandler:say("Well, sooner or later we will get hold of that delinquent. That's for sure.",cid)
		setPlayerStorageValue(cid, 12160,1)
		TopicState[cid] = 3
		
		
	elseif msgcontains(msg, "avoided") and TopicState[cid] == 3 then
		npcHandler:say("You can't tell by a person's appearance who is a pickpocket and who isn't. You simply can't close the city gates for everyone.",cid)
		setPlayerStorageValue(cid, 12160,1)
		TopicState[cid] = 4
	
	elseif msgcontains(msg, "gods allow") and TopicState[cid] == 4 then
		npcHandler:say("If the gods had created the world a paradise, no one had to steal at all.",cid)
		setPlayerStorageValue(cid, 12161,2)
		setPlayerStorageValue(cid, 20000,0)
		TopicState[cid] = 5

	elseif msgcontains(msg, 'yes') then
		if (TopicState[cid] == 0) then
		npcHandler:say("So be it. Now you are a member of the inquisition. You might ask me for a mission to raise in my esteem.",cid)
	end
	end

	return true

end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)