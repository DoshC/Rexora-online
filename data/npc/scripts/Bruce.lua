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
	elseif(msgcontains(msg, "report")) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 9 or getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 11) then
			npcHandler:say("Well, .. <gives a short and precise report>. ", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, getPlayerStorageValue(cid,InServiceofYalahar.Questline) + 1)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission02, getPlayerStorageValue(cid,InServiceofYalahar.Mission02) + 1) -- StorageValue for Questlog "Mission 02: Watching the Watchmen"
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "pass")) then
		npcHandler:say("You can {pass} either to the {Alchemist Quarter} or {Cemetery Quarter}. Which one will it be?", cid)
		TopicState[cid] = 1	
	elseif(msgcontains(msg, "alchemist")) then
		if(TopicState[cid] == 1) then
			doTeleportThing(cid,{x=32738, y=31113, z=7})
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "cemetery")) then
		if(TopicState[cid] == 1) then
			doTeleportThing(cid,{x=32743, y=31113, z=7})
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())