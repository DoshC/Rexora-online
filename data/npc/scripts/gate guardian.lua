local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end
function creatureSayCallback(cid, type, msg)
	if(not(npcHandler:isFocused(cid))) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if(msgcontains(msg, "mission") or msgcontains(msg, "pass")) then
		if(getPlayerStorageValue(cid, STORAGE_ZALAMON) == 7) then
			if(getPlayerStorageValue(cid, STORAGE_GATE) < 1) then
				npcHandler:say("You want entranzzze to zzze zzzity?", cid)
				talkState[talkUser] = 1
			else
				if(getPlayerPosition(cid).x > 511) then
					NEWPOS = {x = 33114, y = 31197, z = 7}
				else
					NEWPOS = {x = 33123, y = 31197, z = 7}
				end
				doTeleportThing(cid, NEWPOS)
				doSendMagicEffect(NEWPOS, CONST_ME_TELEPORT)
			end
		end
	elseif(msgcontains(msg, "yes")) then
		if(talkState[talkUser] == 1) then
			npcHandler:say("Mh, zzzezzze paperzzz zzzeem legit, I have orderzzz to let you pazzz. Zzzo be it.", cid)
			setPlayerStorageValue(cid, STORAGE_GATE, 1)
			talkState[talkUser] = 0
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
