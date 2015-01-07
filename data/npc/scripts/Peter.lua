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
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 7 or getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 13) then
			npcHandler:say("A report? What do they think is happening here? <gives an angry and bitter report>. ", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, getPlayerStorageValue(cid,InServiceofYalahar.Questline) + 1)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission02, getPlayerStorageValue(cid,InServiceofYalahar.Mission02) + 1) -- StorageValue for Questlog "Mission 02: Watching the Watchmen"
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "pass")) then
		npcHandler:say("You can {pass} either to the {Factory Quarter} or {Trade Quarter}. Which one will it be?", cid)
		TopicState[cid] = 1
	elseif(msgcontains(msg, "factory")) then
		if(TopicState[cid] == 1) then
			doTeleportThing(cid,{x=32859, y=31302, z=7})
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "trade")) then
		if(TopicState[cid] == 1) then
			doTeleportThing(cid,{x=32854, y=31302, z=7})
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())