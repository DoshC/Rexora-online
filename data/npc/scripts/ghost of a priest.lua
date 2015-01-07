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
	if(msgcontains(msg, "mission")) then
		if(getPlayerStorageValue(cid, STORAGE_ZALAMON) == 4) then
			if(getPlayerStorageValue(cid, STORAGE_GHOST) < 1) then
				npcHandler:say("Although we are willing to hand this item to you, there is something you have to understand: There is no such thing as 'the' sceptre. ...", cid)
				addEvent(npcHandler:say, 5000, "Those sceptres are created for special purposes each time anew. Therefore you will have to create one on your own. It will be your mission to find us three keepers and to get the three parts of the holy sceptre. ...", cid, true)
				addEvent(npcHandler:say, 5000, "Then go to the holy altar and create a new one.", cid, true)
				setPlayerStorageValue(cid, STORAGE_GHOST, 1)
			elseif(getPlayerStorageValue(cid, STORAGE_GHOST) > 0) then
				npcHandler:say("Even though we are spirits, we can't create anything out of thin air. You will have to donate some precious metal which we can drain for energy and substance. ...", cid)
				addEvent(npcHandler:say, 5000, "The equivalent of 5000 gold will do. Are you willing to make such a donation?", cid, true)
				talkState[talkUser] = getPlayerPosition(cid).z
			end
		end
	elseif(msgcontains(msg, "yes")) then
		if(talkState[talkUser]) then
			if(getPlayerMoney(cid) >= 5000) then
				doPlayerAddItem(cid, 12339 - talkState[talkUser], 1)
				doPlayerRemoveMoney(cid, 5000)
				npcHandler:say("So be it! Here is my part of the sceptre. Combine it with the other parts on the altar of the Great Snake in the depths of this temple. ", cid)
			else
				npcHandler:say("If you bring me 5000 gold we can talk this out, if no then no.", cid)
			end
			talkState[talkUser] = 0
		end
	elseif(msgcontains(msg, "no") and talkState[talkUser]) then
		npcHandler:say("No deal then.", cid)
		talkState[talkUser] = 0
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
