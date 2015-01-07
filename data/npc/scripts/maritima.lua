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
	elseif(msgcontains(msg, "quara")) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 41 and getPlayerStorageValue(cid,InServiceofYalahar.QuaraInky) < 1  and getPlayerStorageValue(cid,InServiceofYalahar.QuaraSplasher) < 1 and getPlayerStorageValue(cid,InServiceofYalahar.QuaraSharptooth) < 1) then
			npcHandler:say("The quara in this area are a strange race that seeks for inner perfection rather than physical one. ...",cid)
			addEvent(selfSay,3000,"However, recently the quara got mad because their area is flooded with toxic sewage from the city. If you could inform someone about it, they might stop the sewage and the quara could return to their own business.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 42)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission07, 3) -- StorageValue for Questlog "Mission 07: A Fishy Mission"
			setPlayerStorageValue(cid,InServiceofYalahar.QuaraState, 1)
			TopicState[cid] = 0
		end
	end
	return true
end
 

npcHandler:setMessage(MESSAGE_GREET, "Oh, hello |PLAYERNAME|. A visitor, how nice!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")  
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())