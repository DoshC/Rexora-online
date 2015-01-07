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
			npcHandler:say("Oh my, where to begin with .. <tells about the troubles he and his men have recently encountered>. ", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, getPlayerStorageValue(cid,InServiceofYalahar.Questline) + 1)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission02, getPlayerStorageValue(cid,InServiceofYalahar.Mission02) + 1) -- StorageValue for Questlog "Mission 02: Watching the Watchmen"
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "pass")) then
		npcHandler:say("You can {pass} either to the {Magician Quarter} or {Sunken Quarter}. Which one will it be?", cid)
		TopicState[cid] = 1
	elseif(msgcontains(msg, "magician")) then
		if(TopicState[cid] == 1) then
			doTeleportThing(cid,{x=32885, y=31157, z=7})
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "sunken")) then
		if(TopicState[cid] == 1) then
			doTeleportThing(cid,{x=32884, y=31162, z=7})
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())