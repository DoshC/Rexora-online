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
	--The New Frontier
	elseif msgcontains(msg, "farmine") then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 15 then
			npcHandler:say("Oh yes, that project the whole dwarven community is so excited about. I guess I already know why you are here, but speak up.", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "impress") or msgcontains(msg, "plea") then
		if TopicState[cid] == 1 then
			if getPlayerStorageValue(cid,TheNewFrontier.BribeLeeland) < 1 then
				npcHandler:say("Your pathetic whimpering amuses me. For this I grant you my assistance. But listen, one day I'll ask you to return this favour. From now on, you owe me one.", cid)
				setPlayerStorageValue(cid,TheNewFrontier.BribeLeeland, 1)
				setPlayerStorageValue(cid,TheNewFrontier.Mission05, getPlayerStorageValue(cid,TheNewFrontier.Mission05) + 1) --Questlog, The New Frontier Quest "Mission 05: Getting Things Busy"
			end
		end
	end
	return true
end
npcHandler:setMessage(MESSAGE_GREET, "Greetings, |PLAYERNAME|.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
