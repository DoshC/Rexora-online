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
	elseif(msgcontains(msg, "farmine")) then
		if(getPlayerStorageValue(cid,TheNewFrontier.Questline) == 15) then
			npcHandler:say("Bah, Farmine here, Farmine there. Is there nothing else than Farmine to talk about these days? Hrmpf, whatever. So what do you want?", cid)
			TopicState[cid] = 1
		end
	elseif(msgcontains(msg, "flatter")) then
		if(TopicState[cid] == 1) then
			if(getPlayerStorageValue(cid,TheNewFrontier.BribeHumgolf) < 1) then
				npcHandler:say("Yeah, of course they can't do without my worms. Mining and worms go hand in hand. Well, in the case of the worms it is only an imaginary hand of course. I'll send them some of my finest worms.", cid)
				setPlayerStorageValue(cid,TheNewFrontier.BribeHumgolf, 1)
				setPlayerStorageValue(cid,TheNewFrontier.Mission05, getPlayerStorageValue(cid,TheNewFrontier.Mission05) + 1) --Questlog, The New Frontier Quest "Mission 05: Getting Things Busy"
			end
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
