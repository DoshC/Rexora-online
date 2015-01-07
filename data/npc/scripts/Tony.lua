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
	elseif msgcontains(msg, "report") then
		if getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 7 or getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 13 then
			npcHandler:say("Uhm, report, eh? <slowly gives a clumsy description of recent problems>. ", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, math.max(1, getPlayerStorageValue(cid,InServiceofYalahar.Questline) +1))
			setPlayerStorageValue(cid,InServiceofYalahar.Mission02, math.max(1, getPlayerStorageValue(cid,InServiceofYalahar.Mission02) +1)) -- StorageValue for Questlog "Mission 02: Watching the Watchmen"
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "pass") then
		npcHandler:say("You can {pass} either to the {Arena Quarter} or {Foreigner Quarter}. Which one will it be?", cid)
		TopicState[cid] = 1
	elseif(msgcontains(msg, "arena")) then
		if TopicState[cid] == 1 then
			doTeleportThing(cid,{x=32695, y=31254, z=7}, false)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "foreigner")) then
		if TopicState[cid] == 1 then
			doTeleportThing(cid,{x=32695, y=31259, z=7}, false)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())