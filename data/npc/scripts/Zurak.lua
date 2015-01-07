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
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, "trip") then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) >= 24 then
			npcHandler:say("You want trip to Izzle of Zztrife?", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			npcHandler:say("It'zz your doom you travel to.", cid)
			local player = isPlayer(cid)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
			doTeleportThing(cid,{x = 33102, y = 31056, z = 7})
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "no") then
		if TopicState[cid] == 1 then
			npcHandler:say("Zzoftzzkinzz zzo full of fear.", cid)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, 'hurry') or msgcontains(msg, 'job')  then
		npcHandler:say('Me zzimple ferryman. I arrange {trip} to Izzle of Zztrife.', cid)
		TopicState[cid] = 0
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
